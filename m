Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A66109C05B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37815840BE;
	Wed, 25 Mar 2026 20:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZaCLJEoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343D2840D8; Wed, 25 Mar 2026 20:00:43 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF83840AE
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d7653db148so87315a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465240; x=1775070040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ilvPWnSrxufpLeul0B7aYmiBjI3z2GzrjuHSZ0PAhM=;
 b=ZaCLJEoXnR2tS27mC0O2a3XFWZ46tmcoyZNaTnMa4fvePCBkwdZmZwT8fJBCqoCdh5
 m+fXVB0DYZ3GRCaNJpqdk4wrkPjjKW/Bat6F/UJqFeU08ptfVTGMPOWmt7GD4+8TbbFd
 lvI2WbeBfM5nJ9wnFWABt0vx0841KNKPG+S74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465240; x=1775070040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ilvPWnSrxufpLeul0B7aYmiBjI3z2GzrjuHSZ0PAhM=;
 b=jHbSZwBINq1UutKy8s3uPneWsBYJBThMSmdM9AW/BwDR79So1/Ujjihp+ZJGAMH96Q
 I7E7mR/sag9wYrBHRY7scHPDa8YVxkdhGWS2zP0H0nB/0VAue5v1oCmKxw8j3bnDHSTU
 U2nIErdSiraPDNKIQ53ba/sOCXKYjAnBAksRpvVcn2sB8lUWrHnWQT2YeOYbxkaDAIuD
 7RlgVUJU8YE/+3RF7/2oFJvJ+WZ1oieYJRwZ3PMWrieXg5JYn1XJet0vpnpl+Afb9EOS
 kyHwWECmaLZlV4KSZ0rYoQyLrD43vf2Y9+XkyZSGa1Uysp8HjRxxkF2p7ko08Z+RDp8n
 OtTA==
X-Gm-Message-State: AOJu0YwUPqUoWI7JkMAHwVoG2KbpEfMzW5FRBqM3+p9dt0mL8vHxticO
 CfzatAnblYxTN+wl/CMLkqWLESuiX3mgByA08WN0SKQsu+wJ0y/Zcc4sIE5wj1IBWrhy2UnsaEW
 809xPGHk=
X-Gm-Gg: ATEYQzxGJ8FANrKyMvc2Ji/lgwYrEd1srgqT6Rbf4Uqhlqp7SGOE508Q8/gPVTUa1e6
 ypICIt4OvyY18/r/wudTFdFzGE3ZWSeJZcou6WraOD8y9jS+PLiVMz79aZv6V3rkLqZ3J0CJ7M9
 qdpLFl5zVEgrVf5buzcpl2rYdRvPumaNszExzJiarRH2DfsT/GMeyUoqtR7k9WiDmrhnCEq7elI
 p4SCdMTnQlYCc9rZs46K9kZg/S5znsG01BCQvnnw2ZlUtb0pEvMNGuiujR+WClfqbIHsRubkror
 Y4YF6igWgNmZ6ZS1phGUt86EdsNCohI/5ioK4aAFxxboIIurTLLpGlyasGOgzYYV4jF6DqNc26F
 iqA4RjWNYM8P2BiPDe1lUin67ksOXRkkeNu42qluZnOSMq9AXfp0pG7t6wJHUQcRjOmGLr1Rc9T
 GdEAXZlIfATpSFoXYdyL+ss4UUEsS8aGBBjFNl2eBlGayCwhJNouK1R7bzgx6uxkoms7rdmXGrc
 L4FVCuHzFd6JMNoMmZP4nFM4aEUaiJWra7Cib6serCRSRRg0tVxeo7cRnwVCg==
X-Received: by 2002:a05:6830:378e:b0:7c7:6bb4:1197 with SMTP id
 46e09a7af769-7d9d68556fbmr2251008a34.24.1774465239591; 
 Wed, 25 Mar 2026 12:00:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e7264e10sm458012a34.23.2026.03.25.12.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
	Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH] imx93_frdm: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:38 -0600
Message-ID: <20260325190038.3428714-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
---
 board/nxp/imx93_frdm/imx93_frdm.c | 5 -----
 board/nxp/imx93_frdm/spl.c        | 2 --
 configs/imx93_frdm_defconfig      | 1 -
 3 files changed, 8 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93_frdm.c
index fb78a9bd0361..e187de74a724 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.c
+++ b/board/nxp/imx93_frdm/imx93_frdm.c
@@ -90,11 +90,6 @@ static int clear_pd_alert(void)
 	return 0;
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/nxp/imx93_frdm/spl.c b/board/nxp/imx93_frdm/spl.c
index 006c752d0715..068091ba0e96 100644
--- a/board/nxp/imx93_frdm/spl.c
+++ b/board/nxp/imx93_frdm/spl.c
@@ -156,8 +156,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	spl_early_init();
 
 	preloader_console_init();
diff --git a/configs/imx93_frdm_defconfig b/configs/imx93_frdm_defconfig
index c35ebc3b4926..adcf2125c732 100644
--- a/configs/imx93_frdm_defconfig
+++ b/configs/imx93_frdm_defconfig
@@ -35,7 +35,6 @@ CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-frdm.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_BOARD_INIT=y
-- 
2.43.0

