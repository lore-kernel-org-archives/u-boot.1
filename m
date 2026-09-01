Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFA2C624C6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4229380D07;
	Tue,  1 Sep 2026 09:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DW-U-JpJeZ7N; Tue,  1 Sep 2026 09:13:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254009;
	bh=AmXGctW3Kca8bIrrPZc7tme0Ov9phSsn0+OpX0tQK90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=srjT8SY4HYjg/gHleJRI7ZHrlovFAxlVTfql/mVJ23pPKEi4JvsuTj6V/VGWHjb2D
	 mKC/i/vY/o2sQJUAo5lTjYw1kyTCgfjgYuE/WYwxrt3JTJii4Ms/ej3fPVos3nKJOL
	 xZ7Fs6qE5x30ZjWSgIhKwpiGYqF9XmVkCGsTi8qjQZaPnWLueEcuVn0JrMccWxcVQs
	 rYSAgukdIRlIyD3uyv4WKvyNjnwg3twXnz7I1CHHWS2/+WkKH76+tSkAocpij4Jzz0
	 Md+9AUQljQJyHWkO2LzB7i0sU43AUi1ChV3MazC7/RqJa7YnL3sqUgV2700dQuGUNz
	 BLhh4als92w4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D17780BFF;
	Tue,  1 Sep 2026 09:13:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C11942FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF04840714
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kAT7ZH2u27hg for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fARXrE7k
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5379840742
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B4D5601DB;
 Tue,  1 Sep 2026 09:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3547C1F000E9;
 Tue,  1 Sep 2026 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788254003;
 bh=AmXGctW3Kca8bIrrPZc7tme0Ov9phSsn0+OpX0tQK90=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fARXrE7kcHu8o/fROQOqZD4e0jVMkaJbsKRCRgL4S/PP8s9OiLkflybGzCmv86Zqm
 d5Jhe9gq9+JK7kl3nZItDhCrB0knWEGROjaaxkMQcCYeWNN1h5XgGZnxSwHPq2Ce5q
 whPfUaYXKGMTeeinquqtN7nCh8T0i8GTIsmlxMgdly+bOE0sLlqp23f6GjZHNMvjr/
 fSnjsbIQKEeDn7BRILSq5wXilywrMF1e2FO3DnBsLb+Kvy4OwICNF7q5Z97poAlZeH
 mGGzoKmNI3RmVeaG8HsERSrF5hTGXlOuBtR3grPP7VbIEDUa1JY00IXqU0gQ+P0nbL
 YCjnglyyVrD6A==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:07 +0200
Subject: [PATCH v7 09/13] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-9-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
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

