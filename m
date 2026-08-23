Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BBDC5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 168AD80D7C;
	Sun, 23 Aug 2026 20:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryS1dvp7foXN; Sun, 23 Aug 2026 20:39:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517592;
	bh=m/Zik1Y4tvLAlshzUGOMt60x8wDhWeaokgiUChpjWgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCquTZgEJJ16fVl80OZb+vXCTEacJyfW/fLnYwiOqkyCjFgPL+Pmgr1npO+014SCs
	 LHAz6SOI5NzElOsU6in7/e9nippMiHKw4wY873Q5yJeTkC1PcKDI9VVtnzM2bgbQ4h
	 7Wj+CHTi3wxJXB1MFZ5WxQ5sOoWNxIe4rSTCYKAjXocDf34zOaSIg2iJb79eDHzB7/
	 zxbnkFa+YX2YoYUzpEQX3WuI4dCIk0oTxoPs0cAb+91prCipwwA9WRkLeUEw64X0Oe
	 Keh8oA3xZozwTLhbCwVgbyxJ0+0f3aVL5MKLf9SH7EjvPXYbAzU5o3316qkIEHvSaH
	 XYKpvHgFgz/Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31FC880DC5;
	Sun, 23 Aug 2026 20:39:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3745435
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4C2E403AE
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xphh_7ExyP4y for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=m0/LtGF8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECAAA403B5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6713F40626;
 Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D49D1F000E9;
 Sun, 23 Aug 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517584;
 bh=m/Zik1Y4tvLAlshzUGOMt60x8wDhWeaokgiUChpjWgI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=m0/LtGF8aW/CcMCRVBH5lAMBgV067G9YQ/bPNH2tsDaqQnRrIqP0F1R77mYIniMqX
 X7k+5ohaXmnBShrXarh987W/Um7b9q5jG7QPROCwrfLOYdzAAUiHjxnGxGd26t9qrH
 2kV9f7Jz19r4KLupxSeqIvg3FVBk2E6nS2vmIXEZ0p0oh9tZQ+EqTTgx3tfvqWnECy
 2WbatS7rpDFd12lueJ4NXXAOvh61mi44HNg/RaXaSjAKCpirEhsXIi5mvY5bt1sKPg
 mlOwOZFQcqwzBUV7a6p5QJT+lwFX9gwBJGpnCXGNNPxda+l2volZ8MX7/xjIPxEKhC
 85jY1l3WRtrbg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:28 +0200
Subject: [PATCH v5 09/13] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-9-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
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

