Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17275C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFE294082C;
	Wed, 19 Aug 2026 08:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KP7ZQvleaMR1; Wed, 19 Aug 2026 08:54:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129668;
	bh=m/Zik1Y4tvLAlshzUGOMt60x8wDhWeaokgiUChpjWgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRa9egEKf+uukGhennDgJPGFvijYwW/aEUmwWgkOmHaEAiloCDuDgRBcOlmlcqci4
	 Hz0SzjCm+i8BgNPc/u4cpfYw/N8TiMzdQ+Jer3MVEFGdqO2w72hziiE8k3WRuyRLFE
	 OD8P3fhD6LTC+z6XsJ0Dg3vrczpZ7DYmj7jC1sEimg6hGs8j6vbkBOx0DOxynYsp0v
	 C6nppgG+A6hKr6+WheDB/aXmsu+WHefJtyH5M/YyUemwFjPjwm5IW1+C/yKEbzV60s
	 4THA3+DlA6xqRrmQ2Q7LF9BeB6pDZDMIeJ1DaFdYDqSl2qDZ+QDicl715Voc68DPTT
	 c9NvxQCRq5ReQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B77B40815;
	Wed, 19 Aug 2026 08:54:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD0662FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F0DB60618
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYYkCcOUByD9 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lVzihu9m
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2D3960602
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57B8641A97;
 Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBE81F000E9;
 Wed, 19 Aug 2026 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129663;
 bh=m/Zik1Y4tvLAlshzUGOMt60x8wDhWeaokgiUChpjWgI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lVzihu9mrWZ0lD2F5khdlydSJnncX74VD+6Ehp6EohBcvA9gMQUVPOwkZUxXIvjDJ
 GbNkPLp2Rr/Jrm//vanO9DST9N3jedXgkYRH7MZ6vOBe/2RF/WqI/aQOaKDa7o20SV
 xrYjeK9UMXKUZEB8qdurh7ANyRouxl7d1oG+I6vykQEQ/VrChZ0jcee5IVDbIW0mTE
 YiEHjlpwK88ZmEzGSFSIHgeRurud9XQAe8hKX9RmtIHXW4gJeas2Ness0jt39Al7jT
 yv38VqahIoEKhufTnrg1qeGdOZg4h6a45YZCL83bfK12o3TBFrAeWCe0uPXT6Ked+C
 1+RlIrsKlIODA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:13 +0200
Subject: [PATCH v4 08/12] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-8-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Replace the fastboot-only command with standard bootflow scanning and
enable the EFI loader so the removable SD card can provide the default
ARM EFI executable. Filesystem probing is handled by the standard boot
framework and does not require the FAT command.
Skip global boot methods so EFI variables cannot redirect the scan to
the internal eMMC.

Disable mkeficapsule because generating capsule tools is unrelated to
running EFI payloads and adds a host GnuTLS build dependency.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 configs/stemmy_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 631ccababf1c..b1a14ab38210 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -14,10 +14,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="ste-ux500-samsung-stemmy"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
-# CONFIG_EFI_LOADER is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fastbootcmd"
+CONFIG_BOOTCOMMAND="bootflow scan -lbG"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -43,3 +43,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x685d
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MCDE_SIMPLE=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.55.0

