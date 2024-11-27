Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDA2D6ACF9
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13A28961A;
	Wed, 27 Nov 2024 18:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhYTnnIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF3A88DB1; Wed, 27 Nov 2024 14:04:59 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCD288B55
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcin.slusarz@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ffbea0acc2so40366431fa.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732712696; x=1733317496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yRtxs+fi0JrHoBBdkYy/oq63q4qC4J5XqmNc6nsYuus=;
 b=QhYTnnImWovT8MUZJ32drEWBBxdVgUa5VOaIdKHARAy1O2vYUfjFdjzESOU/IyrD7u
 WN2lRVZydaSVj1xUuh107FUj+GMF9Q8QpIck/VNjeuLFUMGbgX4M4KKAMSrzwAZ1clWV
 bePMhNeJdFjD+j5eZ0DWb9LAonJjb4WIr8PVdM0DWHxVbr/wddS5WYVPzD4nVjb/Yhg0
 NbvRZVcPYwMDtQQgSIaEulQj1auzJvMcaZjvdgWlhy6meNBIE+CACgstrGAOChL4fnPO
 1wSuDCWOuHpvBhEvBiJze5IX0vNZxJ0EsNiHoU9wWzDGYGyNOm5AHi8SYYA3CvSe626a
 hixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712696; x=1733317496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yRtxs+fi0JrHoBBdkYy/oq63q4qC4J5XqmNc6nsYuus=;
 b=YIwa3/2Ld7CpJWBxGLTvSm87u7rdpn8SirvUveBW8gcJUKUbOgIwSe2UFOB1Lp8Ca+
 JkvU8YIi59px5wlJlohwDkKswoo+Bpt2sdYXF3lCs0x0R8+3tNR/FQ60Cnp0uUjGJc3u
 swnJrfIItR9Ybf0QVeG/PBaIfxzVJys+SP+p2BFHvxSjg1U+S+EvEDfb+RSXthLK4X7W
 3YW4VsduQRbRVO3vplbyBHDxJIl3vJAf8OA65ZMQm+mANzMzovqT8nNSACqGq03QX2yk
 GOSnr4pV6ZoIIFs3qW7aAIabo4gvsCeJKFUJuuuv+jaybRtWeELlxAlcuH07VNe/BmOI
 CT1g==
X-Gm-Message-State: AOJu0Yycmgg4oWQiyd3Z6vFKfvZbuzZSdGPdZck0vmHlKrByedUopSwo
 4iLVtm+Ew/0BPsiN7nar6pz9U3UMFSXNITRlIh9EVbBr5Z7tqosUTPZDrg==
X-Gm-Gg: ASbGncvs5LJs1ijD/8pIyfgm55BX0k4NkA+RkLgOIk2ECW8cNGnuTpgvQzeGYnlaPSs
 cGnRMzu4NQq+YH4Gs/l91zWAW6KL6CvecEANCh/S5Z3TcXV3kLpbatXNRRHl2V3SyIon7j+ntkZ
 26fEeJKqytF+Dyip2JJeXZ2JA2FLRQuCpSjcu6C8Bf89bBYmd1iv+dhGAHAyrhk7jji5JoSCMs/
 eTfwMhGtfbJ2ru1G1y3OortC2Pk4KcFJUS41vU/xc7uxs+rWsnMHInryf6CCOixz4+zQ3y0Q9dC
 fZJNtZRFy14aGw==
X-Google-Smtp-Source: AGHT+IFmJ7QXHsa9w3QWByKS+UnYQMWBTEYQk9AVqtYHvb2aANPTK6H0oB0pgEYJO8QY3DKjtl5SDQ==
X-Received: by 2002:a2e:a5c1:0:b0:2fb:8774:4412 with SMTP id
 38308e7fff4ca-2ffd60dc656mr13978561fa.24.1732712695442; 
 Wed, 27 Nov 2024 05:04:55 -0800 (PST)
Received: from renau-vm3.mshome.net (1779df417e104.rev.snt.net.pl.
 [213.192.104.90]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa538ea2fsm20371341fa.97.2024.11.27.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:04:53 -0800 (PST)
From: "=?UTF-8?q?Marcin=20=C5=9Alusarz?=" <marcin.slusarz@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] power: axp: sunxi: configure charge current
Date: Wed, 27 Nov 2024 13:04:19 +0000
Message-Id: <20241127130419.50489-1-mslusarz@renau.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Nov 2024 18:27:29 +0100
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

Allows decreasing initial charge current, e.g. when power
supply is too weak to support both charging and other operations.

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andre Przywara <andre.przywara@arm.com>
---
 board/sunxi/board.c    |  4 ++++
 drivers/power/Kconfig  |  7 +++++++
 drivers/power/axp221.c | 33 +++++++++++++++++++++++++++++++++
 include/axp221.h       |  3 +++
 include/axp_pmic.h     |  1 +
 5 files changed, 48 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 824c322a0d..07fccf972a 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -623,6 +623,10 @@ void sunxi_board_init(void)
 #if defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER
 	power_failed |= axp_set_sw(IS_ENABLED(CONFIG_AXP_SW_ON));
 #endif
+
+#ifdef CONFIG_AXP221_POWER
+	power_failed |= axp221_set_charge_current(CONFIG_AXP221_CHARGE_CURRENT);
+#endif
 #endif	/* CONFIG_AXPxxx_POWER */
 	printf("DRAM:");
 	gd->ram_size = sunxi_dram_init();
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4b81aeb749..06b509a383 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -142,6 +142,13 @@ config SY8106A_POWER
 
 endchoice
 
+config AXP221_CHARGE_CURRENT
+	int "axp221 constant charge current in mA"
+	depends on AXP221_POWER
+	default 1200
+	---help---
+	Any value between 300 and 2100 in 150 increments, or 0 to disable charging.
+
 config AXP_DCDC1_VOLT
 	int "axp pmic dcdc1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
diff --git a/drivers/power/axp221.c b/drivers/power/axp221.c
index c22ca03f46..bf48585da0 100644
--- a/drivers/power/axp221.c
+++ b/drivers/power/axp221.c
@@ -205,6 +205,39 @@ int axp_set_eldo(int eldo_num, unsigned int mvolt)
 				AXP221_OUTPUT_CTRL2_ELDO1_EN << (eldo_num - 1));
 }
 
+static u8 axp221_mamp_to_cfg(int mamp, int min, int max, int div)
+{
+	if (mamp < min)
+		mamp = min;
+	else if (mamp > max)
+		mamp = max;
+
+	return (mamp - min) / div;
+}
+
+int axp221_set_charge_current(unsigned int mamp)
+{
+	int ret;
+	u8 cfg, chrg_ctrl;
+
+	cfg = axp221_mamp_to_cfg(mamp, 300, 2100, 150);
+	if (cfg > 0x0f)
+		return -EINVAL;
+
+	ret = pmic_bus_read(AXP221_CHRG_CTRL1, &chrg_ctrl);
+	if (ret)
+		return ret;
+
+	chrg_ctrl = (chrg_ctrl & 0xf0) | cfg;
+
+	if (mamp == 0)
+		chrg_ctrl &= 0x7f;
+	else
+		chrg_ctrl |= 0x80;
+
+	return pmic_bus_write(AXP221_CHRG_CTRL1, chrg_ctrl);
+}
+
 int axp_init(void)
 {
 	u8 axp_chip_id;
diff --git a/include/axp221.h b/include/axp221.h
index 32b988f3a9..8eb1792435 100644
--- a/include/axp221.h
+++ b/include/axp221.h
@@ -44,6 +44,9 @@
 #define AXP221_ALDO3_CTRL	0x2a
 #define AXP221_SHUTDOWN		0x32
 #define AXP221_SHUTDOWN_POWEROFF	(1 << 7)
+#define AXP221_CHRG_CTRL1	0x33
+#define AXP221_CHRG_CTRL2	0x34
+#define AXP221_CHRG_CTRL3	0x35
 #define AXP221_PAGE		0xff
 
 /* Page 1 addresses */
diff --git a/include/axp_pmic.h b/include/axp_pmic.h
index ae62ef0d76..3bcd8f9ca9 100644
--- a/include/axp_pmic.h
+++ b/include/axp_pmic.h
@@ -52,6 +52,7 @@ int axp_set_aldo4(unsigned int mvolt);
 int axp_set_dldo(int dldo_num, unsigned int mvolt);
 int axp_set_eldo(int eldo_num, unsigned int mvolt);
 int axp_set_fldo(int fldo_num, unsigned int mvolt);
+int axp221_set_charge_current(unsigned int mamp);
 int axp_set_sw(bool on);
 int axp_init(void);
 int axp_get_sid(unsigned int *sid);
-- 
2.25.1

