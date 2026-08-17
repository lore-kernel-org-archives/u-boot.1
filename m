Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19253C5DF74
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF9CB60874;
	Mon, 17 Aug 2026 13:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WCY0FXlZQS4W; Mon, 17 Aug 2026 13:34:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C333A60877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973678;
	bh=CS39o5Q4ieQPqWn7qoHPFvTc4oOXYIl+02TWt/wxcvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z39VoienVJqW2UqK9a+yyK5By0SYWmkW1wt0iJoNCScn/w5/BAfxDKECAil75Hb7m
	 mhtu3J/TA3Dn5m6C6ieLQ73nZZztL0Q0ooV+o/Jb9kh2k0/oPPbdHRn8aFwjG3CSqX
	 Jp91XywT1YRgc/BCiRMcAgqwO4tvQaceT5EZf1XxCe6SsswyYAt2VDj/Fiy/IBaaHl
	 A+C8CT9YiInVJcxTeoorfRSnr1lqXwG7QIiCMTugyMWdTfopW8Ee1N8MpDAZWFkajB
	 JosvA7xpwF4TAXMlSzQWQtkwoOD+HL1NTFJWDqBZGlr26uKUK1mx98Xd9WbaPrRyMy
	 YftJwScIYiH6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C333A60877;
	Mon, 17 Aug 2026 13:34:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0388423F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E931F80EC9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AAm0YtRqjdln for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:32:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1025880EC5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1025880EC5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dEJ/Onz3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1025880EC5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB22B404D2;
 Mon, 17 Aug 2026 09:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5BD1F000E9;
 Mon, 17 Aug 2026 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959123;
 bh=CS39o5Q4ieQPqWn7qoHPFvTc4oOXYIl+02TWt/wxcvE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dEJ/Onz3FdNrf+3OnNFQYCJ9gyG4r3LXW4iSrAAm5eEoKgx7KftSUdC1DPtBLIxbF
 vLdSzmbwGUMhBFM83oDj0NMHJjYAaeWNmL0RNCNh5ok+z1MKEXfqPhiZQoiiv2Bm0e
 KZcrTIzJL5HnlpHlWAzvB3X/Q1SKX2130lLyNl0QDkZ9zy+xfrxl+6KY9HKFtQQTZ0
 BUrLV4WZa/hay2U67qqt8Pn+ziIkTST+didu4w/V+YECxLZ2fGP6Me8QFplBA5oEdR
 vtYmwzjeXnoRMwRggzQqf6tYuDtYIjo6bMgcB5BUZBbWF8FWsywKO+QYjbdkqHYQSK
 TarzV1YLbDWrQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:55 +0200
Subject: [PATCH v2 6/8] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-6-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Replace the fastboot-only command with standard bootflow scanning and
enable the EFI loader so the removable SD card can provide the default
ARM EFI executable. Filesystem probing is handled by the standard boot
framework and does not require the FAT command.

Disable mkeficapsule because generating capsule tools is unrelated to
running EFI payloads and adds a host GnuTLS build dependency.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 configs/stemmy_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 631ccababf1c..57e794c5c88b 100644
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
+CONFIG_BOOTCOMMAND="bootflow scan -lb"
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

