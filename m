Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44CFC61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70A504065D;
	Tue, 25 Aug 2026 19:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 51_W9Da7_rxT; Tue, 25 Aug 2026 19:04:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684669;
	bh=AmXGctW3Kca8bIrrPZc7tme0Ov9phSsn0+OpX0tQK90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUAVseGhNW8CxccoE7OaPkBlqzx0c4aD/ZF+UhaUIdBrnEKKuZt8ElN0ma5KZFzFx
	 ovDmRhBkgnSsbrEatftlBj2dpt3oIiwnPrBpBRQog0yJhyxGjOp8NT6jEyeR7hhdPA
	 MNUfAC3nh2sMKVAf8l1mRK2AGgzRUbM+peev5AAs+bgo5Wz2ni1O474yxo3hzlySm/
	 Hz4jF+sr+k4iHkLxJKVJggd1y50c/yELNwaDCUOY4k2JjR1JTWvttGeOwHhiCtME7c
	 iUePAoZXNtAMJfqI/4andIXMWqu2CnwCPfT0muVAt2PV+4mqsuifwZmdZxwi+3qd6c
	 ZJ76s12BQ1+LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A67F40612;
	Tue, 25 Aug 2026 19:04:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71F26334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61C3C60766
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFNlkR6COIiP for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KH3+70P3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DC0660759
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F03DF407C8;
 Tue, 25 Aug 2026 19:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70551F000E9;
 Tue, 25 Aug 2026 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684661;
 bh=AmXGctW3Kca8bIrrPZc7tme0Ov9phSsn0+OpX0tQK90=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KH3+70P38mN4F7hTfM40wPi6GFen2YLIpvhOCAScJfGGRh5ZfKbrIS0O0GA1qHfL7
 s7yCJUBHJcbfNZy/HcGguWXSZZjO+MKEvpCPG9M3JfJT14MTu8qsnSNipFdVwGeNsK
 Q7869wbEFAswokzduM5Xh+p6XEtZrcw/PV8avB2XtLDTcne3hRCTR4DbCM3JxGal1K
 VdHtYKtrw55UZKCPclvCpHu6cGAHk2tCA7aCUUpAq0A5bC+5Ft0Aa3JwsOk/cNYSPw
 K/eYN9d0hoYhuEf3zqOev5PlUIeZntoB7g1/Af91jXSNvNfnoKcym8grupgnw9Brmq
 41d8CXDQNgHVw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:09 +0200
Subject: [PATCH v6 09/13] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-9-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
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

