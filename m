Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436F0C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 088C940800;
	Tue, 18 Aug 2026 09:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vmt38aNOE9JH; Tue, 18 Aug 2026 09:00:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AF6D407A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043650;
	bh=m/Zik1Y4tvLAlshzUGOMt60x8wDhWeaokgiUChpjWgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xEDJXZz39ODc9B25xL0O+UVveJTOCbnfubRwvn2wcMbReS/sbwhhm0NHsf+xtjVw5
	 nMFSAOY3kiUkjrAQkCeOyYPZDFhndMtASrfPdoUQdJFYZaJFTBHZUZq1GMjnNYaJjq
	 5aXQGcldX1qZxiXF7lPQDRMwC8SJ9A6pkvv4R+aTtjPcMf/IXMKXmH2m6Z/aCdFoKm
	 m15bYV7zEMEUBk7NMLff69EUSqo72eha/HA301sgQszB7eNHlnYaPzW5+Oofzzaz10
	 nrGKggEZXQWpNpfBS47suW6sNZY2u1cetdxuS6CWKbpGqejy/O+0lgSHjDdisPLEQW
	 Rjwx/yjmZMUbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AF6D407A9;
	Tue, 18 Aug 2026 09:00:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B89A523F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92A7B8102F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PuCHImmo3Av5 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F31E810B3
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F31E810B3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cIrzO1Ss
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F31E810B3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E564601FB;
 Tue, 18 Aug 2026 09:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073031F00A3D;
 Tue, 18 Aug 2026 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043644;
 bh=m/Zik1Y4tvLAlshzUGOMt60x8wDhWeaokgiUChpjWgI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cIrzO1SsxqmfReN+XcXISSUSANNlQIvsMtzp22o41oTWnRbCiBX+05PwXNoaHrN3A
 IzpLIgOzzPYxV2/zIOL43Sc2pBSDvC5Ak2srJfQ4+/A4Vnwq7y0Jrbo8VtCdcdSIj0
 tPCoxS0jOdsu6/65m4zzCHPm9dbikEPYVHBCTknrqdVms/pNYryT8wGS87Xcnf3+A9
 El1LahenIRqi1pyW/VQR3zW8vI/jthYXBdXwPzal5GMCeTj8Q2WsPXT7cGMa0B6U+c
 OYs6Exy6zC5eP9mWXh+5d5OyZfxCd/b7LAQbefUsxIRAKHp5UaqtHj5eGosv3kTfR3
 JjkfXr4uF5ROw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 11:00:32 +0200
Subject: [PATCH v3 08/11] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ux500-external-sdcard-v3-8-a5d94930f3bb@kernel.org>
References: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
In-Reply-To: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
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

