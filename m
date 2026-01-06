Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA07C47BF2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB8BF83FAA;
	Tue,  6 Jan 2026 15:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BB1AE5US";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9B983F66; Tue,  6 Jan 2026 14:58:33 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E71883F66
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477770019e4so8463125e9.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767707910; x=1768312710; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZIh/OCRGlFXDkD+NM6eDua0X5PNXgATLGwfQWKRnIUU=;
 b=BB1AE5UShQAJll/NGK5adkCMjudFWqpI6yuIkSvFwFoZbU5dt+w9UOR9gyThHJtfqQ
 +IurvqntJYX+IYV4dGlpY/D4r6aqpr/hBEyadaKCPxio/mTcELNUPYNgxp9sKW/v5v5I
 mwPP8HQUQvDqYLg1nNt6KUEfREtuP/BjfBY/jF8GuBjFHZvhtT0N5lFeO3iJFqyEupxR
 FipZUzL5ZPeLJpLuEYco1UAnjl4dFWGHaNYQ5Rn+vIQRAvC9qLLMwS1RfQB7bu7ejMxm
 YsHGhvZRWpcFgpTJnDcac3wrug7aYDx1Vsm+kJNiDWFgWmUqb7P7cUXXFTbvQvKgiS03
 50EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767707910; x=1768312710;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZIh/OCRGlFXDkD+NM6eDua0X5PNXgATLGwfQWKRnIUU=;
 b=Nu4SZdpN9VRaUABRyHiDljfJ125TGHNEBPdml6qdBV+f10Zv6xOopwXQ3PWtzkMdzP
 s5va3FjY0mSrm/dORBBqQdUywvUGrmbNEXnctDKsffc1GYrgy8GetAdVs1TTIzMGa7wr
 ymin41bBAmDPIEBsce3ebhdu0CiL45N0FjLjTo8OvHbO1qNK3ip78doaRueqFC3Yan8r
 g+3s0dTzeNiKRJHMxcyLDC30ZiV7+lOs+q8V6VXDvh3+7/2VaSonQPhelcTmzwpBTDcI
 mTBfwHH6NoAnF6NHi6U55+RyHezJPFBXd+lr0IxIw4fOOFQ781dOCJ85hfpKF/X/e4Ht
 N1xg==
X-Gm-Message-State: AOJu0YzgOAGWz6YXWRkkK3I/AcyS/RMWMnW+DtEMnjo6ASN4b5wr8vJ/
 S7ZtrnrxtICZdTNskR84tKj5o16mja2I8E8h2/3QgQ2whGY7WBgsuyNt
X-Gm-Gg: AY/fxX4Eug9og+7Iv1dAdNcYDfJzsDL6OUpkh1IX3mD/sSEhSFM6hsSNnZ26ehnThjY
 6FlZY1UyT44QFtG+z/m7CInV3NfHSV/trfoBLkkl60ptJeagSNNlXkd0mhm0Nbs59glAVOFyirh
 IR6O2GTQSTqZi3zDJinCgriKHgaEEEVAW93Ywvch+SHkZojXhzwJe3+qrvV39AmcMH2APhUahjy
 fFLlkGi+xyOj6xoTPusgPkwAWK5UO/fSD5JylwkHKVwemcRwSrk0UblxrLujKyBHJ5Za3UFoI0E
 pFVF/zCOOuWyFFAKwE52hYt0Zj8EgmOXAp1TC+/K51BlV27O8EuVmO6mUd4NZ2E+VgVqriUNIYN
 OMpXrFEI9Xb0eju2h6O6aApphAyTKuYiwAbIs85J+VejREHMnm8p29m8pg2Cuy5Lzrt01R1s8B8
 ckqyA27SQSqwOIp75d8nrOnI6nFm0qk9kZsn/brrjS86seof4F0AtKQLi4IwEBflbxLw==
X-Google-Smtp-Source: AGHT+IHJ3dsP5xf0c/4KNagkRpiDo0wy5XNieDDI5dkZAJQ3uY8IYou1OvbqN8rEGZFI35jSJQp/Dw==
X-Received: by 2002:a05:600c:4e86:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-47d7f066195mr34328825e9.3.1767707910192; 
 Tue, 06 Jan 2026 05:58:30 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm4605281f8f.22.2026.01.06.05.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:58:29 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 06 Jan 2026 17:57:11 +0400
Subject: [PATCH v3 4/5] ufs: rockchip: Add device reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-rk3576-ufs-v3-4-bfe259fd6d17@gmail.com>
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
In-Reply-To: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, Christian Marangi <ansuelsmth@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=alchark@gmail.com;
 h=from:subject:message-id; bh=Oe9bcQVQizUTIhVCAv5uxl5c4GqLFSPHJrP2h3BX/m8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGitywUipn0pp0a8KMo//P6y982c0v7bOgpPH6ahn37
 FdfHTSqOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZjqr1sZ/tl4lCk4F18w4YqO2zPVuWE9z7MNci1KAvJXajiOtnZd3MXIsPui9/1
 Tlxh/tpnm1k7v8GNgM7ZikN6tbfLwuOuFpEhrPgA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 06 Jan 2026 15:00:00 +0100
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/ufs/Kconfig        |  1 +
 drivers/ufs/ufs-rockchip.c | 25 +++++++++++++++++++++++++
 drivers/ufs/ufs-rockchip.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 2543b5d47c04..e9b22acb262f 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -77,6 +77,7 @@ config UFS_ROCKCHIP
 	bool "Rockchip specific hooks to UFS controller platform driver"
 	depends on UFS
 	select BOUNCE_BUFFER
+	select DM_GPIO
 	help
 	  This selects the Rockchip specific additions to UFSHCD platform driver.
 
diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 699460fc4d15..20ad78d5f558 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
  */
 
+#include <asm/gpio.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
@@ -153,12 +154,35 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
 		return err;
 	}
 
+	err = gpio_request_by_name(dev, "reset-gpios", 0, &host->device_reset,
+				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	if (err) {
+		dev_err(dev, "Warning: cannot get reset GPIO\n");
+		return err;
+	}
+
 	hba->quirks |= UFSHCD_QUIRK_DMA_SDRAM_ONLY;
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
@@ -176,6 +200,7 @@ static struct ufs_hba_ops ufs_hba_rk3576_vops = {
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
2.51.2

