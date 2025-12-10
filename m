Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28316D3B9AB
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 22:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC1783CDF;
	Wed, 10 Dec 2025 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jjo4c7V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC5A83CB5; Wed, 10 Dec 2025 21:11:35 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25DA8042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-595819064cdso359517e87.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765397493; x=1766002293; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S0ZIJXMMvUGwb+b1lGo/m/eYqHKYsO+vadiQtPCJDfQ=;
 b=Jjo4c7V+UmvvtM8jv8xzhKR2QX/+70l09ZB/Tsd147cM8y/aTv+g2W/jc7U+oRehK7
 Dt/qTgJmrNn15+ixVyTwYAXDtIQuINc1FDyEh6roABWk4osC9otib34fWOL3j7wOe5ww
 1iloWb60E/2DfcHhQtJJxC38gYVJZve5B63u+Sev4q1Xlu545IMXN9tdRRku31QXa7fS
 oyf5vwfDjZwivRAggrcYC4nLYRXNw5ZnT87aIhy1baHRDeJust/EcGg3i+h3Zg5y4JHb
 5If2QjH82vqCSRsUrchPicddCdZtgXDOi2CUEpXrEmHLmMOPhvf8z1Es+VEMqLY+vcZ/
 Bd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765397493; x=1766002293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S0ZIJXMMvUGwb+b1lGo/m/eYqHKYsO+vadiQtPCJDfQ=;
 b=tS648b3lYHsZh0Ammwm/xJa8ytAizh3tzFKsdv9fSMid9KE4nePmKN6vCZfgHLdpLi
 TL/l9hV6adb5lBPyvTRTRzCUePUmKLy+wFgmtc3lzFXtpe/v8G1qbvJrTFMjMKVrO0kf
 XO/njyZk+wmpuY/fhlX7mgBYesnfQ5I6BUFj8Ooat3bIt9f0dJXVq6ffPxnO/xEyrmwM
 OoJnihcohTd0WUMEBUr2ZnuED40uMMKM+CZTjA9TNdhUndiEbcKccAD7ZdInp2a/Gc9t
 6P5V3v7JcgaB+RkALuRQn4G72RE6imIaryGZE0XajePnQF5kALbhcukDd/wV/YQwjLH1
 ik/A==
X-Gm-Message-State: AOJu0Yz4yhRtlplf8aYwWN9VmRCt6q40GQ3/JQq45yWiQ8Ytcc0Bxx4f
 X+AB2Lcz+N99YQ0bBpDGS79fGU88EMMBw+fEPxCmZ5kAHaCTtypeYtRo
X-Gm-Gg: AY/fxX6BL7TDZOopMbtVZACwW5s8Y3xfXqL9ETz5bYjddz5TwkMhf5ZzagXwaSEaTGH
 IutOREP+yvuyM+K76lrXVOCgmyHoiK8XR9S7JDTwMh6y8mmhgGjWIkr2j+1qxAjJm0ioSaDQPFm
 qZ/2FrpI+U3tL4OG3IAaYVp324PdglxMwoWTGJsL+93/FUYAHXUe6PL4+6tdUqpP9F93Wg07Cyw
 1VDptnK1GMHt9/3w48A/dv5upHXk07vaAFW7RkCcr5rXMegOmyPZIHjomPtRIZuvH5fvUlFQBu3
 spNQfzQzIJ4KQw0p0qkFfWZ8F7kcF3vLY2djkFCPWGkB5zH+e+ru/KPP0ZczbwX1xdFmOP3dgzN
 NNppyhO+OgtsM/TSLgMaHlv5vgOoiMtql/1GFU7hj7W5Leu9MxH+FjLzOCuIKvMJmRkkEDdTL0f
 24WtwzcLo0sqB/Q7n0xrFhxx41
X-Google-Smtp-Source: AGHT+IH+dzGf8vJ2hPvLPP/Bbex/QlQBhYMXM8tvIz/e8W86srHD96/dzuwWm1bqotsfQf1fHlHhQw==
X-Received: by 2002:a05:6512:31ce:b0:598:ec8d:a53a with SMTP id
 2adb3069b0e04-598f2bedf5bmr199673e87.6.1765397492859; 
 Wed, 10 Dec 2025 12:11:32 -0800 (PST)
Received: from alchark-surface.localdomain ([31.173.84.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f2f45bbbsm134986e87.45.2025.12.10.12.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:11:32 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 10 Dec 2025 23:10:49 +0300
Subject: [PATCH 3/4] ufs: rockchip: Add device reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-rk3576-ufs-v1-3-a3f9e76eb66e@gmail.com>
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
In-Reply-To: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anurag Dutta <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Randolph <randolph@andestech.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=alchark@gmail.com;
 h=from:subject:message-id; bh=W1Zu7acIlLkSUqGsSXXlV6oV4upXJRbljIlcg6R2q1s=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRaXn625sXcalu5u/X7JG+EcM294rvtTpPhirkhqafmV
 +y7kb2Cv6OUhUGMi0FWTJFl7rcltlON+Gbt8vD4CjOHlQlkCAMXpwBM5G0wI8OVG4oXlcVfi3mm
 6+6c2P83cn2LdFvUvE+6d5j/qurPvOvEyLD1UEhM9ZqCi2vdfr0p7WK8+sd05q0tu122hMa08dz
 t5+ECAA==
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 10 Dec 2025 23:28:32 +0100
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

Wire up the GPIO line which Rockchip RK3576 UFS controller uses to reset
the connected UFS device.

This seems necessary at least for some UFS modules and fixes the following
error while enumerating UFS storage:

ufshcd-rockchip ufshc@2a2d0000: ufshcd_link_startup: Device not present
ufshcd-rockchip ufshc@2a2d0000: link startup failed -6
ufshcd-rockchip ufshc@2a2d0000: ufshcd_pltfrm_init() failed -6

Fixes: 76465ce21ee4 ("ufs: rockchip: Add initial support")
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/ufs/Kconfig        |  1 +
 drivers/ufs/ufs-rockchip.c | 25 +++++++++++++++++++++++++
 drivers/ufs/ufs-rockchip.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 6c75bb2a0790..30b0c87798e1 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
 config UFS_ROCKCHIP
 	bool "Rockchip specific hooks to UFS controller platform driver"
 	depends on UFS
+	select DM_GPIO
 	help
 	  This selects the Rockchip specific additions to UFSHCD platform driver.
 
diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 0384244387da..48444705fb29 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
  */
 
+#include <asm/gpio.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
@@ -153,11 +154,34 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
 		return err;
 	}
 
+	err = gpio_request_by_name(dev, "reset-gpios", 0, &host->device_reset,
+				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	if (err) {
+		dev_err(dev, "Warning: cannot get reset GPIO\n");
+		return err;
+	}
+
 	host->hba = hba;
 
 	return 0;
 }
 
+static int ufs_rockchip_device_reset(struct ufs_hba *hba)
+{
+	struct ufs_rockchip_host *host = dev_get_priv(hba->dev);
+
+	if (!dm_gpio_is_valid(&host->device_reset))
+		return 0;
+
+	dm_gpio_set_value(&host->device_reset, true);
+	udelay(20);
+
+	dm_gpio_set_value(&host->device_reset, false);
+	udelay(20);
+
+	return 0;
+}
+
 static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
 {
 	int ret = 0;
@@ -175,6 +199,7 @@ static struct ufs_hba_ops ufs_hba_rk3576_vops = {
 	.init = ufs_rockchip_rk3576_init,
 	.phy_initialization = ufs_rockchip_rk3576_phy_init,
 	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
+	.device_reset = ufs_rockchip_device_reset,
 };
 
 static const struct udevice_id ufs_rockchip_of_match[] = {
diff --git a/drivers/ufs/ufs-rockchip.h b/drivers/ufs/ufs-rockchip.h
index 3dcb80f57020..50c2539da78a 100644
--- a/drivers/ufs/ufs-rockchip.h
+++ b/drivers/ufs/ufs-rockchip.h
@@ -72,6 +72,7 @@ struct ufs_rockchip_host {
 	void __iomem *ufs_sys_ctrl;
 	void __iomem *mphy_base;
 	struct reset_ctl_bulk rsts;
+	struct gpio_desc device_reset;
 	struct clk ref_out_clk;
 	uint64_t caps;
 	uint32_t phy_config_mode;

-- 
2.49.1

