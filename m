Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95982C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E77383D6C;
	Mon,  5 Jan 2026 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ateKjxXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCB6839B7; Mon,  5 Jan 2026 16:06:27 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7A08003E
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so23945e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767625584; x=1768230384; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qQjTI2efA7j7r2ZytD+wApcal9naNlkAcTqyXbmg0Bg=;
 b=ateKjxXxOoaIDfXoCXZJnuRXsq6fPFHozpNZVG4jkkHjuuur7K9NaYh9SZPpflKR/q
 8s/N3DDgn6U224eRXzkV7Gd46wtJAa71oln3tokisge674DkOpWg+aa6dIp/4NQCrkRc
 oznY5l0orGNzctMCj/eNx/m3/gI5fdTofz2hLPGKFPiM9Y8enWCepAssNhu/N77VupH7
 lqdv7peg1705/V7yUp/hAt59VvDl/NwUgmaB6QvGsAL7K0CVmqhAhyCr5VTyrNAgkjWU
 J3oKp+GpKroYR4rozmouktJn4y+fGxuNpQM7vWMoNZt9SW5eiGV9nFf48hj7tJlYsEUR
 qEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767625584; x=1768230384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qQjTI2efA7j7r2ZytD+wApcal9naNlkAcTqyXbmg0Bg=;
 b=Ecd8RsNGsLN4K3sEASGQvUEEYIXph45/dsZV/1HPhbMHZ+As+7s6KJ3USeekBVwUYz
 wIk13LZFi0otUdkQy0qpelPiTl7h3zzYQY+U21Lq/PYFmmSllS3I/IXadwCw376fVth8
 a3YNnhQFWr723bdNDBmUXgU1z6V8TwniCqREjo9kqgQcmvYNFyVlu4FYK+MTAM4llRif
 oGzjY8YdXSIjI7mc9DX6a3Polty4/WTduZl+G5livIEibxVty3X+ZxrKJ+QjdaIzcHUu
 fzvx4cJGJO+n4dxCkmSgXF2XlUSF68qd4IJQg+jHxmuQYE9buFbm9+f72GvJF6hvRxBK
 m8bQ==
X-Gm-Message-State: AOJu0Yzj337Na6kOImvbTKb1z3uyikj4aLG+cSQUD9BhUP5HSS51Mii1
 Kj69CXST7jq81eUAdq1kfsBVcTwyK6XFJAHr3ccuBd4Ubo52JlObRrle
X-Gm-Gg: AY/fxX6ghXyX21j2+bwVADWf3B3ulO0vWyIwAkMRcWBprgtuwY3s9AGQ/DpqU4vPoQX
 OPkQTXig9uHyE0BMPsJk9KWNCjFMaPgOltaRqanq77gCuK/tBvKlbu5py90omwHzR9jO9yEQwwN
 qKufrf4bmSFYekYazq8RBy+ghcjsude1UNSwdV4emRqqWYcGVUtRZZVN/ux8lxI3wJgpS8tWKuw
 xYDHXM9kC3QHHWWq/jAW03yW/WRIC1UGqqIfoF32/A//kWxUin9po/0M2enHX+tZhRzKiZUj5Xp
 TkGbcSP99NGspK3A3rYKfP6HJfXYq1WaMw4Vw810p5IO7m3/xNMEHuha9Cmj2Z6QYd5xIfj6nOF
 w9GrvV0nLtbK67tmjUhV55DxwNGIHYg+cVjIwlNiYDrLmua43p3ix2ItpmWIWDVa7gx5QXdFrpN
 AqpuL/TIgg4k4TVbO+tTEcnNfcY42Z2ItKIXYKD4xIBww49gCBP22oT6/TeBRj/uAm2w==
X-Google-Smtp-Source: AGHT+IEXCNwWm5l5ydaJF3xPhTcJByAfXd+frWe1r+z9gdD9JUj/iQeCjhpfSPCoxv4uu5h2uh/ShA==
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr714368295e9.15.1767625584182; 
 Mon, 05 Jan 2026 07:06:24 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6c08f9b7sm57955335e9.11.2026.01.05.07.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:06:23 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 05 Jan 2026 19:05:37 +0400
Subject: [PATCH v2 2/3] ufs: rockchip: Add device reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-rk3576-ufs-v2-2-caba979a0d6b@gmail.com>
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
In-Reply-To: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=alchark@gmail.com;
 h=from:subject:message-id; bh=hhNXIM/PVd33vCwLgLF4fWmwtEfnsnvSnSWBXhQ7CrU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRGXw55u9Zx3e3/b8UmRN0JMvGaGKgb7WX5UVXqbNaHV
 IPUhrdnOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZjqWVsYGX7rXNzo/tnkU5m1xIf40+pm2cJLOxeulX8Wu3vXioxyfmNGhq6rB/l
 Ng/q4tTdbfKjOTTr47278/fgpE6d8ZnklM+/cVGYA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Mon, 05 Jan 2026 16:18:24 +0100
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
2.51.2

