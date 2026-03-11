Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D3A1125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CA28410B;
	Wed, 11 Mar 2026 15:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="vEBc8jBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE9C8404A; Wed, 11 Mar 2026 14:31:35 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371E384013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso45960265e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235893; x=1773840693; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j0a2HaBtS5zPNXlM4C0Ek2DfT3uCPfHufVttGRVtx0w=;
 b=vEBc8jBENGhVqIafLQBW5Ds1h+bNZbEVoVN45naEKs0VI4JOxeG3vS6HI9R3zCYcmV
 mFanpecXAilCYRlIAdkSkQLXqmd+EyJXM5o7IwhKTcUhSeAfpnguuPaaVpTDIRtZpmVx
 M5CSNoL4q9odySZF8BIlqB+dDePX6IxG9vYthPLU6m97dUG1x77Etui9wBHO2bITMDpZ
 nm0GnkfEwGgZBt2oYiMTrBb7MMZpRJFUefw4ZWcoDV246IJesScGHbSZBhJVcVHLpA3r
 qjbIewgrAseoURlWp57Jc+70rNEZP2e70+a1ce7Zk/sh5pQ8jYGpchc4nxL77lm4DVak
 0+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235893; x=1773840693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j0a2HaBtS5zPNXlM4C0Ek2DfT3uCPfHufVttGRVtx0w=;
 b=dyh2hyrYkygtZ/Ja3KgKpL6SeTaJk5aS21w4u2TUa0ZwI/7Y3oaX5whKhU47x/eQks
 mYqJc2HagFLmDR6S1BflTaFcgrvQzTxbRhg5XGrLcCeyC/HcxOYSJkPTvTnT6yGNc11C
 f6Es7akaImSscNZ8rnP37c8UGy47YOZj3PJw47nUv2rwk5HZdsl2p0RfC0JUGDskHCz7
 M1OA/xbJL/YSY5tNmkE5G5DHY5PRM3NSRfdcAjuHezf19k5Kc2beEfS8zErzr4MuFYH/
 jSygM+l6CBDS347PwV9tuEPB0Seyo85KevuEkRqcS7laDUk2ZiRoLbMvzTowuU603EQu
 AolA==
X-Gm-Message-State: AOJu0YyvZsioENIk2ZsgNW1vxsuhFcwGJrtE7gCprXgjtErpsQn9Ylo3
 cLKSLYydpESGFN5D/JD4vzkvmoGbNaryEnEIRaLe+MRw7waXWRKFAIwlrXQxrZcVfgA=
X-Gm-Gg: ATEYQzzat+XwEe/YEFT/FLdtjuEzrKQGVAkZnhTIhDLAvmGUWq5IodUiogDN/3qBkD9
 h5E64V8isPWBOeWZFjEZbzO+TvMqf8fg4P0JBbskOtpFqo5yhgePY9zizZCBWjNBK+tAmVael3p
 nAevu9+cBDWPIInqeW3v6EYJmV+pdNIXfjEdcA+u1Iel/Xbvu6aWkRVla8pSvtQ9SwuqUB9nPpI
 gEzxQjKI+xHAzQwxKeYcgTl5ISXG/oJA/wK8Rzu9C0R5MG+0jMi019VC3nELGq8q2D8iHQkRqwF
 ggxYwrQbccBHoQ+VYINHHAf/krdLC77qUcVO1laI/BWpI/v0DFYOpH6kVFl0XWtXbw8WCe05Uz6
 dalM4zRsCVmTXLccpnpYf9lmZadRmHRaeteLoK2PrA2ozNYZxGFP5yKejQhwOgY2x7vgzwfnxzI
 oyOt8ku9sRZTswQo/C9AW/IIhoVXFWnTcjQEdHjLzXkM/Px0w8M6M69r0V/CrpuXUdzzj3RCIcd
 2Lapw==
X-Received: by 2002:a05:600c:3511:b0:485:3473:d48b with SMTP id
 5b1f17b1804b1-4854b139161mr47151155e9.35.1773235892421; 
 Wed, 11 Mar 2026 06:31:32 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:32 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 17:30:59 +0400
Subject: [PATCH v6 4/6] rockchip: spl: Add support for booting from UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-rk3576-ufs-v6-4-c7c353739242@flipper.net>
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
In-Reply-To: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3879; i=alchark@flipper.net;
 h=from:subject:message-id; bh=aj8iY9x9hrNJG5jnIxLWmkZFGJQDQYYo2uicrEkbSJY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFsgVPluYvZdvwNr+TdOLlrDIrV1x7HvpYa9Z1nu9
 PvXn2qc2TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBU31rG8D/bq1flqryz2pyH4qlvF5SxiVxxZW8QnNBzVWW2AX+QzBxGhsf/rJ5
 uizqxd8cGcft8diGBrbtZf/9+x5yo9fD5iS0/0rgA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Add the required architecture-specific lookups to enable U-boot SPL to
load images from UFS storage devices on Rockchip RK3576, which has a
boot ROM capable of loading the SPL image from UFS.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/dts/rk3576-u-boot.dtsi              | 33 +++++++++++++++++++++++++++-
 arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
 arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index 018c9cc8d696..8db9495c6d46 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -12,7 +12,7 @@
 	};
 
 	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci, &ufshc;
 	};
 
 	dmc {
@@ -81,6 +81,17 @@
 	bootph-some-ram;
 };
 
+#ifdef CONFIG_SPL_UFS_SUPPORT
+&gpio4 {
+	/* This is specifically for GPIO4_D0, which is the only 1.2V capable
+	 * pin on RK3576 available for use as the UFS device reset, thus
+	 * &gpio4 is required for booting from UFS on RK3576.
+	 */
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+#endif
+
 &ioc_grf {
 	bootph-all;
 };
@@ -89,6 +100,11 @@
 	bootph-some-ram;
 };
 
+&pcfg_pull_down {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &pcfg_pull_none {
 	bootph-all;
 };
@@ -172,6 +188,21 @@
 	bootph-pre-ram;
 };
 
+&ufshc {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&ufs_refclk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&ufs_rstgpio {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &xin24m {
 	bootph-all;
 };
diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index b15938c021d6..f9ecb6858f04 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -51,6 +51,7 @@ enum {
 	BROM_BOOTSOURCE_SPINOR = 3,
 	BROM_BOOTSOURCE_SPINAND = 4,
 	BROM_BOOTSOURCE_SD = 5,
+	BROM_BOOTSOURCE_UFS = 7,
 	BROM_BOOTSOURCE_I2C = 8,
 	BROM_BOOTSOURCE_SPI = 9,
 	BROM_BOOTSOURCE_USB = 10,
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index c17ba418ced5..1def4e879719 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -49,6 +49,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
 	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
+	[BROM_BOOTSOURCE_UFS] = "/soc/ufshc@2a2d0000",
 };
 
 static struct mm_region rk3576_mem_map[] = {
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 6572dde29f65..d2dd5e10935f 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
 
+	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
+		return BOOT_DEVICE_UFS;
+
 	return -1;
 }
 
@@ -231,6 +234,17 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 		return -ENODEV;
 	}
 
+	if (boot_device == BOOT_DEVICE_UFS) {
+		ret = uclass_find_device(UCLASS_UFS, 0, &dev);
+		if (ret) {
+			debug("%s: could not find device for UFS: %d\n",
+			      __func__, ret);
+			return ret;
+		}
+
+		return ofnode_get_path(dev_ofnode(dev), buf, buflen);
+	}
+
 #if CONFIG_IS_ENABLED(BLK)
 	dev_num = (boot_device == BOOT_DEVICE_MMC1) ? 0 : 1;
 

-- 
2.52.0

