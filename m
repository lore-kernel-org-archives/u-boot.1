Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B83FD1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82191842B7;
	Thu,  8 Jan 2026 18:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dgye3K8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0F7841F2; Thu,  8 Jan 2026 18:50:58 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB8383B4E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-383153e06d1so5063301fa.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767894655; x=1768499455; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kwq+LVoJO/7YVqzeImBPo8vLUJXBvro5x0CXaYbyVcg=;
 b=Dgye3K8gJX/NkTlKm+b2Ks2//MBwypVx/ByGMJSmVhD57NsPwmU/C2krFHwAWjpXv1
 s6eeTokpQlLkQ+Uaesla9fyGUA8jZC4GyjQfwWaKxnXE22x7OMomQUcHnyRcQjRIs1rk
 2Xs3HG3kVtu4POn8Yjhkb4ah+DyjBd460BguRrKdCB9N+3TlDueXOAt6G6aOKi9gIkRw
 V8oU7oxZcDnASufCOtAcf5d/GTSn6U2i4plIAyy2Ikqi/W4owN4ycWuhzlImIY5zsr7x
 1G4gYAYGNxSoXwMQa4AxEdZTrwv5UtUgflSI34lnCR/fC6V91+C+33ZpauG16+W7xLGu
 NB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894655; x=1768499455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kwq+LVoJO/7YVqzeImBPo8vLUJXBvro5x0CXaYbyVcg=;
 b=MvKZtIM5a9M3qRW4jRJ8AubcsPLwXjJ4I85qgl8bd6WAczbiRSsN2VTMEDsHYyGN5v
 /ANVpP9Mfbb303bgrh7LPsn8leTYWs7c78MFyaakqzDtkfkuzj7t00oYJ+2/gji909Vj
 BB3PlEqlp+c25GLyJ05cMiLl0qOsxmBraQVX454n/IWOSUYzLOUEmpy5YLHtv3dQPbB4
 lhtvSxqU0N6d8erw8Xeuul9QDJWr4kV1KHKnTXHUNaqEllvWYIk1LQ0/t4DxIVbH63mR
 5fIYX1owLdwT0KNV4Kk1QJinHs+Z4y+YmiAGq2S/k58vO86e2SyPFjmm9tR0h1vRFxaH
 6yGQ==
X-Gm-Message-State: AOJu0YzJSd+kuME7OGLqYmgMQJ+711SIegA/5el3jqqS3FBze4Qn7EaG
 H1TLR6He1ue+WXX4UVBR6/8WYQChJGExXUJFSiGDRIVb4oqxB6I1U1fT
X-Gm-Gg: AY/fxX5zGufQ0BYsqIWJensBz3aHOyXeCICE8Waf4J4yenQx383+KhHCUBVazO4L7Yj
 5w+4YgNtBN9ehdSKIgLaML27mGMxDCxZwxjxpTvCf18a4SaQDQ+n7kxVca04oGTlIof0LJ61GKn
 jFC6Hqm1X6x07447Qd9+x9AFJM9XQ8upidQFePuljwDpGYqBGX3IMn6B+EncHw+baZMbBo7yLlo
 CEXfNy4q2HFgPXu0s0Oi+xhnlOQ5gb0PK+3oPuqP3pXX3vLjVGIcIW/8gIShcSEM0dtgItEFxMh
 cQ5qR3I0xElAtrY/sJeEWLm6qo2XRrx/lJC866nE1eP6nKNAlposmmbmFUptukhYW256pR5R+vZ
 SBHj/d62mjkIOdR1mY7H97zz4qRWhU4QGHWbGfSUtZQQSnP4J+3gRv5CGK5DFiBXWkm/YPzrN8d
 kPyXzyL22SKIi+CjJMMRk2HorPvDMMWyAVbiJyq0ZWwXN3SUjZLEoQKKTjW6OIi5uMWw==
X-Google-Smtp-Source: AGHT+IH/bT7QQ7GsOFIXI4oJWu+3WDlAycd8X/xV4TilSTXM5/qxwItyN51hMKPyXmteTuo32I+C6Q==
X-Received: by 2002:a05:651c:a07:b0:381:19bf:fb42 with SMTP id
 38308e7fff4ca-382ff69648fmr19871831fa.19.1767894654771; 
 Thu, 08 Jan 2026 09:50:54 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-382eb8f478dsm17988701fa.37.2026.01.08.09.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:50:53 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 08 Jan 2026 21:49:59 +0400
Subject: [PATCH v4 2/3] ufs: rockchip: Add device reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rk3576-ufs-v4-2-e8e67649f3f8@gmail.com>
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
In-Reply-To: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3110; i=alchark@gmail.com;
 h=from:subject:message-id; bh=lvUFjC3b2eun3xn2zINASRE91cR6E7wpZEXwtvTkyts=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGv4uvupQm+j1x9t03a2X5lthe+MRwKP2hlVDqv907X
 2zRX28o0zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBU7zNm+B9nrp98s3FVmv8zlsbgW+/fHOPiXXk+yOSIeP/nE5N61JwZGQ709nO
 +33tT/EBIxL/MSpmnyyfybijerZCgcbZT9eN3Hh4A
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Thu, 08 Jan 2026 18:51:53 +0100
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

