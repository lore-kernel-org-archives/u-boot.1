Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CA2C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDE088035;
	Wed, 27 Mar 2024 12:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AbVa9C/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808918805B; Wed, 27 Mar 2024 12:50:16 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528AC8801A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dee5daedf6so7123015ad.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711540213; x=1712145013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UseadsVRICUFSxCD784O3ICbKT7mbMFNmodX5PmTqOs=;
 b=AbVa9C/5HUxflDgoxiTxO1G+a2Wg8CloN318r8xYFQNNyV+sg+cK3rgHUeJaWQypzy
 qf6iK8Nf4qUQkp8dESe9JBTjM4/Z6mu/erbOgoHpaaFCFOGCsopAA5GlcA3Dwt/lj2dU
 +b9bDNRDK4YrrtZIc96a/bCTtOmiFPm2pkpti8WD3bisSn0klTEQOkiqmoEGIGF8jzMp
 aP5BV2rytlOgbE8JCNxF7NTWyZ3dVia/pPCYqJM72522xeaxmfN+O6wcUBJRAl9mDPgM
 LVHrrriX+fTE6Jd694MoRtNPNIvbERyvFteCkxTVEIod6mJ2z5PvrVmFtFWDIao7KFGt
 +vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711540213; x=1712145013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UseadsVRICUFSxCD784O3ICbKT7mbMFNmodX5PmTqOs=;
 b=QgWkAXZVsSY7pgGFOCLcMprVIS8Fdih1zC6rb1Rvm29lJL04tkr3ZFe/+GDpmeIjjC
 5u13T5gUKXB8TRgnVLcPA3nsBixGx0EWNPFS21d2VvV6V32AkmDCu89KfuvZNbydhlCD
 21LZ3BjykhxQcUNNgu3Xa/1Khzk4VOehWdjDRxBYnExdhDFkjIMcDiyovvnNRWxGU524
 jOFcQZtT3n0K43/DxWpp0UQ18LImyKnSS+S0IMmueTMNujrQ2gZXux9mAE/gQCGQwkYo
 NQIT1VAS9ykDfa1/rCGavAMKFS8cJwdIVb/u1SJgcBA+vsWeirMdlY3Utxm6Ls/ogaKg
 2tUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn94uQtfl7XT/Cr+lZu7oLhayrkqTan2KrGh8OR2ilqISDjiX0DMXtLM8pWqr1ITLfje6P9IFADzAjgY/fzk6D1zewPQ==
X-Gm-Message-State: AOJu0YzR9Xu+HoCyAA9LS8Euu/fzqXu0R4GArDnqeV1AIJdFEQBllF6g
 2507p3vctUExdO+H7nUWwCmRRJPTdHfVKJu1e8wYAZ8nu2a804Ae
X-Google-Smtp-Source: AGHT+IH+dQqrAc5K/M6SmtaOAz48HGMCaH8Y7Qzk3mK3sGk8hmnDlU8HrDc0t49Acw+Bavuj9t8y3Q==
X-Received: by 2002:a17:902:e547:b0:1e0:b25b:c423 with SMTP id
 n7-20020a170902e54700b001e0b25bc423mr11331314plf.5.1711540212664; 
 Wed, 27 Mar 2024 04:50:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bfc9:1394:a603:c344])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a17090276c100b001e0d093d962sm4895316plt.248.2024.03.27.04.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 04:50:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de, cgmeiner@igalia.com
Subject: [PATCH] mx6cuboxi: Fix board revision detection
Date: Wed, 27 Mar 2024 08:49:59 -0300
Message-Id: <20240327114959.2084525-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently, an i.MX6 Cuboxi board is incorrectly detected
as the HummingBoard model:

U-Boot 2024.04-rc5 (Mar 26 2024 - 15:59:22 +0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
Reset cause: POR
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
gpio@20a4000: set_dir_flags: error: gpio GPIO3_8 not reserved
gpio@20a4000: get_value: error: gpio GPIO3_8 not reserved
gpio@20a8000: set_dir_flags: error: gpio GPIO4_4 not reserved
gpio@20a8000: get_value: error: gpio GPIO4_4 not reserved
gpio@20b0000: set_dir_flags: error: gpio GPIO6_9 not reserved
gpio@20b0000: get_value: error: gpio GPIO6_9 not reserved
Board: MX6 HummingBoard
DRAM:  2 GiB
...

This error happens because request_detect_gpios() uses the GPIO DM
API, but board_type() still uses the legacy non-DM GPIO API.

Fix it by using the GPIO DM API in board_type() to read the
board revision pins in SPL.

Reported-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/solidrun/mx6cuboxi/mx6cuboxi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 8edabf4404c2..7fe515f928a0 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -336,20 +336,17 @@ static enum board_type board_type(void)
 	 * HB             1     1    x
 	 */
 
-	gpio_direction_input(IMX_GPIO_NR(2, 8));
-	val3 = gpio_get_value(IMX_GPIO_NR(2, 8));
+	val3 = !!dm_gpio_get_value(&board_detect_desc[0]);
 
 	if (val3 == 0)
 		return HUMMINGBOARD2;
 
-	gpio_direction_input(IMX_GPIO_NR(3, 4));
-	val2 = gpio_get_value(IMX_GPIO_NR(3, 4));
+	val2 = !!dm_gpio_get_value(&board_detect_desc[1]);
 
 	if (val2 == 0)
 		return HUMMINGBOARD;
 
-	gpio_direction_input(IMX_GPIO_NR(4, 9));
-	val1 = gpio_get_value(IMX_GPIO_NR(4, 9));
+	val1 = !!dm_gpio_get_value(&board_detect_desc[2]);
 
 	if (val1 == 0) {
 		return CUBOXI;
@@ -363,8 +360,8 @@ static bool is_rev_15_som(void)
 	int val1, val2;
 	SETUP_IOMUX_PADS(som_rev_detect);
 
-	val1 = gpio_get_value(IMX_GPIO_NR(6, 0));
-	val2 = gpio_get_value(IMX_GPIO_NR(6, 4));
+	val1 = !!dm_gpio_get_value(&board_detect_desc[3]);
+	val2 = !!dm_gpio_get_value(&board_detect_desc[4]);
 
 	if (val1 == 1 && val2 == 0)
 		return true;
-- 
2.34.1

