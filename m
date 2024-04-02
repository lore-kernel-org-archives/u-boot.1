Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD70CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A601E87F78;
	Tue,  2 Apr 2024 10:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ePMd710H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957EF87FDA; Tue,  2 Apr 2024 10:39:45 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1510287E30
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57CC33FB74
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712047182;
 bh=9Z03z6B8AV8AipCUmForOSn+78cxd1/cqCYfpouUuFI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ePMd710H6osraSf8mJ7+rPZh0skuUrbM0BGpseR0ftyvTUtoBSByPq9E4BsLYkxHc
 nLTT4IqYcYLS7XfUSMHgoC7qmKGUhjec8RMFJlzTp/t4pUEfy3KfNWozHHd0eOfyee
 l3RxhHakgRzvTgLNvwSgn0sRu+8ixghhlncwXY1mHJuW5mCeWf3b/lg5H0Waz+MFKg
 6tz+rUxafDeFvWi3IW/E5yichyChtz1FlpImGw2Qn4YViLwlZw7CWUzopgQ2azPwl8
 x/6imHfDZtbVDu7MKi/hecaLIs5eufLbtV2vVWN32d3l0XVBWUaCruCpy0xpxPLiYN
 GGQ9usTZojS4A==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d6c145dfd4so35430041fa.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047181; x=1712651981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Z03z6B8AV8AipCUmForOSn+78cxd1/cqCYfpouUuFI=;
 b=kN4m+LmVP5nag14BQDTPK5hjVscNA3GyaS5/Igy52+dCGNo+IamBs/KI2GUA0Tdv+y
 WCQV6wstlqqOwbc1hbRn+A6TDowTqdTQKCTeFkTKMXtSGeCeVPAHe2nYCCnO6uPPxHlB
 tbWh2fW2Io5bqGdgletB8k0meodKIRP/3YwYXRkViHCw6zwhIl4z+N8VoK00vd4twbvM
 utsf2IbwZJvIxvbV9ZAtxKd5tgSHRDxFWPQqGl/MUQN6QNdOQyk0ak0d6SJluaS71Nhs
 aWwgsD+15++BrodvDqn/5M/FaogVAalUTGEBYk1pM9EfGaQCswRUp6wUiPkECxxN8gv2
 Az2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ3AP8dtisvo41BAE70petsFXmf0a8UKLt0XP/pdwZ7nmsSq6lqOS4GIB1qvLTERztyfFKmt0fovRi0Sj7gA1MTMwBsw==
X-Gm-Message-State: AOJu0YzUa4lQBbNA00LUBXSLrpCwOPvSrfVot9Nb18yMbjZL30GbuGbE
 1oCU6iLKp6CGjvHqXW77pr2YUyQ4NetoFWthFKtv54O5aQ/7HBMlAsyfhH5hdOSn3gvQJiRfihn
 8C7YYixtwxTyqhY1oWtuXnZ2/XjEP4BSN4FQfz0XAJ2fqmw1VnuKOIG5ov0PNH60WQTE=
X-Received: by 2002:a05:651c:1a10:b0:2d8:19fe:4879 with SMTP id
 by16-20020a05651c1a1000b002d819fe4879mr3417495ljb.38.1712047181343; 
 Tue, 02 Apr 2024 01:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlwMd93JMN+l45EyPr71G6l1j9ktCCzVPUJZVM4YCdJAGU/QXag4a6hfEMZF+AGinGY5FgVg==
X-Received: by 2002:a05:651c:1a10:b0:2d8:19fe:4879 with SMTP id
 by16-20020a05651c1a1000b002d819fe4879mr3417478ljb.38.1712047180890; 
 Tue, 02 Apr 2024 01:39:40 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j29-20020a05600c1c1d00b0041493a93cc5sm17354117wms.2.2024.04.02.01.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:39:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Elmar Psilog <epsi@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: dw_eth_qos: Add missing \n in error messages.
Date: Tue,  2 Apr 2024 10:39:34 +0200
Message-ID: <20240402083934.42733-1-heinrich.schuchardt@canonical.com>
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

Missing line-feeds in error messages lead to output like:

    phy_startup() failed: -110FAILED: -110=>

Output like the following is much easier to read:

    phy_startup() failed: -110
    FAILED: -110
    =>

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/net/dwc_eth_qos.c | 108 +++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 9b3bce1dc87..1b4d0eda887 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -159,7 +159,7 @@ static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = eqos_mdio_wait_idle(eqos);
 	if (ret) {
-		pr_err("MDIO not idle at entry");
+		pr_err("MDIO not idle at entry\n");
 		return ret;
 	}
 
@@ -179,7 +179,7 @@ static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = eqos_mdio_wait_idle(eqos);
 	if (ret) {
-		pr_err("MDIO read didn't complete");
+		pr_err("MDIO read didn't complete\n");
 		return ret;
 	}
 
@@ -203,7 +203,7 @@ static int eqos_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = eqos_mdio_wait_idle(eqos);
 	if (ret) {
-		pr_err("MDIO not idle at entry");
+		pr_err("MDIO not idle at entry\n");
 		return ret;
 	}
 
@@ -225,7 +225,7 @@ static int eqos_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = eqos_mdio_wait_idle(eqos);
 	if (ret) {
-		pr_err("MDIO read didn't complete");
+		pr_err("MDIO read didn't complete\n");
 		return ret;
 	}
 
@@ -242,37 +242,37 @@ static int eqos_start_clks_tegra186(struct udevice *dev)
 
 	ret = clk_enable(&eqos->clk_slave_bus);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_slave_bus) failed: %d", ret);
+		pr_err("clk_enable(clk_slave_bus) failed: %d\n", ret);
 		goto err;
 	}
 
 	ret = clk_enable(&eqos->clk_master_bus);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_master_bus) failed: %d", ret);
+		pr_err("clk_enable(clk_master_bus) failed: %d\n", ret);
 		goto err_disable_clk_slave_bus;
 	}
 
 	ret = clk_enable(&eqos->clk_rx);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_rx) failed: %d", ret);
+		pr_err("clk_enable(clk_rx) failed: %d\n", ret);
 		goto err_disable_clk_master_bus;
 	}
 
 	ret = clk_enable(&eqos->clk_ptp_ref);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_ptp_ref) failed: %d", ret);
+		pr_err("clk_enable(clk_ptp_ref) failed: %d\n", ret);
 		goto err_disable_clk_rx;
 	}
 
 	ret = clk_set_rate(&eqos->clk_ptp_ref, 125 * 1000 * 1000);
 	if (ret < 0) {
-		pr_err("clk_set_rate(clk_ptp_ref) failed: %d", ret);
+		pr_err("clk_set_rate(clk_ptp_ref) failed: %d\n", ret);
 		goto err_disable_clk_ptp_ref;
 	}
 
 	ret = clk_enable(&eqos->clk_tx);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_tx) failed: %d", ret);
+		pr_err("clk_enable(clk_tx) failed: %d\n", ret);
 		goto err_disable_clk_ptp_ref;
 	}
 #endif
@@ -305,26 +305,26 @@ static int eqos_start_clks_stm32(struct udevice *dev)
 
 	ret = clk_enable(&eqos->clk_master_bus);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_master_bus) failed: %d", ret);
+		pr_err("clk_enable(clk_master_bus) failed: %d\n", ret);
 		goto err;
 	}
 
 	ret = clk_enable(&eqos->clk_rx);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_rx) failed: %d", ret);
+		pr_err("clk_enable(clk_rx) failed: %d\n", ret);
 		goto err_disable_clk_master_bus;
 	}
 
 	ret = clk_enable(&eqos->clk_tx);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_tx) failed: %d", ret);
+		pr_err("clk_enable(clk_tx) failed: %d\n", ret);
 		goto err_disable_clk_rx;
 	}
 
 	if (clk_valid(&eqos->clk_ck) && !eqos->clk_ck_enabled) {
 		ret = clk_enable(&eqos->clk_ck);
 		if (ret < 0) {
-			pr_err("clk_enable(clk_ck) failed: %d", ret);
+			pr_err("clk_enable(clk_ck) failed: %d\n", ret);
 			goto err_disable_clk_tx;
 		}
 		eqos->clk_ck_enabled = true;
@@ -390,7 +390,7 @@ static int eqos_start_resets_tegra186(struct udevice *dev)
 
 	ret = dm_gpio_set_value(&eqos->phy_reset_gpio, 1);
 	if (ret < 0) {
-		pr_err("dm_gpio_set_value(phy_reset, assert) failed: %d", ret);
+		pr_err("dm_gpio_set_value(phy_reset, assert) failed: %d\n", ret);
 		return ret;
 	}
 
@@ -398,13 +398,13 @@ static int eqos_start_resets_tegra186(struct udevice *dev)
 
 	ret = dm_gpio_set_value(&eqos->phy_reset_gpio, 0);
 	if (ret < 0) {
-		pr_err("dm_gpio_set_value(phy_reset, deassert) failed: %d", ret);
+		pr_err("dm_gpio_set_value(phy_reset, deassert) failed: %d\n", ret);
 		return ret;
 	}
 
 	ret = reset_assert(&eqos->reset_ctl);
 	if (ret < 0) {
-		pr_err("reset_assert() failed: %d", ret);
+		pr_err("reset_assert() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -412,7 +412,7 @@ static int eqos_start_resets_tegra186(struct udevice *dev)
 
 	ret = reset_deassert(&eqos->reset_ctl);
 	if (ret < 0) {
-		pr_err("reset_deassert() failed: %d", ret);
+		pr_err("reset_deassert() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -448,14 +448,14 @@ static int eqos_calibrate_pads_tegra186(struct udevice *dev)
 	ret = wait_for_bit_le32(&eqos->tegra186_regs->auto_cal_status,
 				EQOS_AUTO_CAL_STATUS_ACTIVE, true, 10, false);
 	if (ret) {
-		pr_err("calibrate didn't start");
+		pr_err("calibrate didn't start\n");
 		goto failed;
 	}
 
 	ret = wait_for_bit_le32(&eqos->tegra186_regs->auto_cal_status,
 				EQOS_AUTO_CAL_STATUS_ACTIVE, false, 10, false);
 	if (ret) {
-		pr_err("calibrate didn't finish");
+		pr_err("calibrate didn't finish\n");
 		goto failed;
 	}
 
@@ -586,13 +586,13 @@ static int eqos_set_tx_clk_speed_tegra186(struct udevice *dev)
 		rate = 2.5 * 1000 * 1000;
 		break;
 	default:
-		pr_err("invalid speed %d", eqos->phy->speed);
+		pr_err("invalid speed %d\n", eqos->phy->speed);
 		return -EINVAL;
 	}
 
 	ret = clk_set_rate(&eqos->clk_tx, rate);
 	if (ret < 0) {
-		pr_err("clk_set_rate(tx_clk, %lu) failed: %d", rate, ret);
+		pr_err("clk_set_rate(tx_clk, %lu) failed: %d\n", rate, ret);
 		return ret;
 	}
 #endif
@@ -613,7 +613,7 @@ static int eqos_adjust_link(struct udevice *dev)
 	else
 		ret = eqos_set_half_duplex(dev);
 	if (ret < 0) {
-		pr_err("eqos_set_*_duplex() failed: %d", ret);
+		pr_err("eqos_set_*_duplex() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -631,32 +631,32 @@ static int eqos_adjust_link(struct udevice *dev)
 		ret = eqos_set_mii_speed_10(dev);
 		break;
 	default:
-		pr_err("invalid speed %d", eqos->phy->speed);
+		pr_err("invalid speed %d\n", eqos->phy->speed);
 		return -EINVAL;
 	}
 	if (ret < 0) {
-		pr_err("eqos_set_*mii_speed*() failed: %d", ret);
+		pr_err("eqos_set_*mii_speed*() failed: %d\n", ret);
 		return ret;
 	}
 
 	if (en_calibration) {
 		ret = eqos->config->ops->eqos_calibrate_pads(dev);
 		if (ret < 0) {
-			pr_err("eqos_calibrate_pads() failed: %d",
+			pr_err("eqos_calibrate_pads() failed: %d\n",
 			       ret);
 			return ret;
 		}
 	} else {
 		ret = eqos->config->ops->eqos_disable_calibration(dev);
 		if (ret < 0) {
-			pr_err("eqos_disable_calibration() failed: %d",
+			pr_err("eqos_disable_calibration() failed: %d\n",
 			       ret);
 			return ret;
 		}
 	}
 	ret = eqos->config->ops->eqos_set_tx_clk_speed(dev);
 	if (ret < 0) {
-		pr_err("eqos_set_tx_clk_speed() failed: %d", ret);
+		pr_err("eqos_set_tx_clk_speed() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -755,7 +755,7 @@ static int eqos_start(struct udevice *dev)
 
 	ret = eqos->config->ops->eqos_start_resets(dev);
 	if (ret < 0) {
-		pr_err("eqos_start_resets() failed: %d", ret);
+		pr_err("eqos_start_resets() failed: %d\n", ret);
 		goto err;
 	}
 
@@ -773,13 +773,13 @@ static int eqos_start(struct udevice *dev)
 				EQOS_DMA_MODE_SWR, false,
 				eqos->config->swr_wait, false);
 	if (ret) {
-		pr_err("EQOS_DMA_MODE_SWR stuck");
+		pr_err("EQOS_DMA_MODE_SWR stuck\n");
 		goto err_stop_resets;
 	}
 
 	ret = eqos->config->ops->eqos_calibrate_pads(dev);
 	if (ret < 0) {
-		pr_err("eqos_calibrate_pads() failed: %d", ret);
+		pr_err("eqos_calibrate_pads() failed: %d\n", ret);
 		goto err_stop_resets;
 	}
 
@@ -812,7 +812,7 @@ static int eqos_start(struct udevice *dev)
 		}
 
 		if (!eqos->phy) {
-			pr_err("phy_connect() failed");
+			pr_err("phy_connect() failed\n");
 			ret = -ENODEV;
 			goto err_stop_resets;
 		}
@@ -820,7 +820,7 @@ static int eqos_start(struct udevice *dev)
 		if (eqos->max_speed) {
 			ret = phy_set_supported(eqos->phy, eqos->max_speed);
 			if (ret) {
-				pr_err("phy_set_supported() failed: %d", ret);
+				pr_err("phy_set_supported() failed: %d\n", ret);
 				goto err_shutdown_phy;
 			}
 		}
@@ -828,26 +828,26 @@ static int eqos_start(struct udevice *dev)
 		eqos->phy->node = eqos->phy_of_node;
 		ret = phy_config(eqos->phy);
 		if (ret < 0) {
-			pr_err("phy_config() failed: %d", ret);
+			pr_err("phy_config() failed: %d\n", ret);
 			goto err_shutdown_phy;
 		}
 	}
 
 	ret = phy_startup(eqos->phy);
 	if (ret < 0) {
-		pr_err("phy_startup() failed: %d", ret);
+		pr_err("phy_startup() failed: %d\n", ret);
 		goto err_shutdown_phy;
 	}
 
 	if (!eqos->phy->link) {
-		pr_err("No link");
+		pr_err("No link\n");
 		ret = -EAGAIN;
 		goto err_shutdown_phy;
 	}
 
 	ret = eqos_adjust_link(dev);
 	if (ret < 0) {
-		pr_err("eqos_adjust_link() failed: %d", ret);
+		pr_err("eqos_adjust_link() failed: %d\n", ret);
 		goto err_shutdown_phy;
 	}
 
@@ -1090,7 +1090,7 @@ err_shutdown_phy:
 err_stop_resets:
 	eqos->config->ops->eqos_stop_resets(dev);
 err:
-	pr_err("FAILED: %d", ret);
+	pr_err("FAILED: %d\n", ret);
 	return ret;
 }
 
@@ -1361,7 +1361,7 @@ static int eqos_probe_resources_tegra186(struct udevice *dev)
 
 	ret = reset_get_by_name(dev, "eqos", &eqos->reset_ctl);
 	if (ret) {
-		pr_err("reset_get_by_name(rst) failed: %d", ret);
+		pr_err("reset_get_by_name(rst) failed: %d\n", ret);
 		return ret;
 	}
 
@@ -1369,37 +1369,37 @@ static int eqos_probe_resources_tegra186(struct udevice *dev)
 				   &eqos->phy_reset_gpio,
 				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
 	if (ret) {
-		pr_err("gpio_request_by_name(phy reset) failed: %d", ret);
+		pr_err("gpio_request_by_name(phy reset) failed: %d\n", ret);
 		goto err_free_reset_eqos;
 	}
 
 	ret = clk_get_by_name(dev, "slave_bus", &eqos->clk_slave_bus);
 	if (ret) {
-		pr_err("clk_get_by_name(slave_bus) failed: %d", ret);
+		pr_err("clk_get_by_name(slave_bus) failed: %d\n", ret);
 		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "master_bus", &eqos->clk_master_bus);
 	if (ret) {
-		pr_err("clk_get_by_name(master_bus) failed: %d", ret);
+		pr_err("clk_get_by_name(master_bus) failed: %d\n", ret);
 		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "rx", &eqos->clk_rx);
 	if (ret) {
-		pr_err("clk_get_by_name(rx) failed: %d", ret);
+		pr_err("clk_get_by_name(rx) failed: %d\n", ret);
 		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "ptp_ref", &eqos->clk_ptp_ref);
 	if (ret) {
-		pr_err("clk_get_by_name(ptp_ref) failed: %d", ret);
+		pr_err("clk_get_by_name(ptp_ref) failed: %d\n", ret);
 		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "tx", &eqos->clk_tx);
 	if (ret) {
-		pr_err("clk_get_by_name(tx) failed: %d", ret);
+		pr_err("clk_get_by_name(tx) failed: %d\n", ret);
 		goto err_free_gpio_phy_reset;
 	}
 
@@ -1436,19 +1436,19 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 
 	ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
 	if (ret) {
-		pr_err("clk_get_by_name(master_bus) failed: %d", ret);
+		pr_err("clk_get_by_name(master_bus) failed: %d\n", ret);
 		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "mac-clk-rx", &eqos->clk_rx);
 	if (ret) {
-		pr_err("clk_get_by_name(rx) failed: %d", ret);
+		pr_err("clk_get_by_name(rx) failed: %d\n", ret);
 		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "mac-clk-tx", &eqos->clk_tx);
 	if (ret) {
-		pr_err("clk_get_by_name(tx) failed: %d", ret);
+		pr_err("clk_get_by_name(tx) failed: %d\n", ret);
 		goto err_probe;
 	}
 
@@ -1502,7 +1502,7 @@ static int eqos_probe(struct udevice *dev)
 
 	eqos->regs = dev_read_addr(dev);
 	if (eqos->regs == FDT_ADDR_T_NONE) {
-		pr_err("dev_read_addr() failed");
+		pr_err("dev_read_addr() failed\n");
 		return -ENODEV;
 	}
 	eqos->mac_regs = (void *)(eqos->regs + EQOS_MAC_REGS_BASE);
@@ -1514,19 +1514,19 @@ static int eqos_probe(struct udevice *dev)
 
 	ret = eqos_probe_resources_core(dev);
 	if (ret < 0) {
-		pr_err("eqos_probe_resources_core() failed: %d", ret);
+		pr_err("eqos_probe_resources_core() failed: %d\n", ret);
 		return ret;
 	}
 
 	ret = eqos->config->ops->eqos_probe_resources(dev);
 	if (ret < 0) {
-		pr_err("eqos_probe_resources() failed: %d", ret);
+		pr_err("eqos_probe_resources() failed: %d\n", ret);
 		goto err_remove_resources_core;
 	}
 
 	ret = eqos->config->ops->eqos_start_clks(dev);
 	if (ret < 0) {
-		pr_err("eqos_start_clks() failed: %d", ret);
+		pr_err("eqos_start_clks() failed: %d\n", ret);
 		goto err_remove_resources_tegra;
 	}
 
@@ -1536,7 +1536,7 @@ static int eqos_probe(struct udevice *dev)
 	if (!eqos->mii) {
 		eqos->mii = mdio_alloc();
 		if (!eqos->mii) {
-			pr_err("mdio_alloc() failed");
+			pr_err("mdio_alloc() failed\n");
 			ret = -ENOMEM;
 			goto err_stop_clks;
 		}
@@ -1547,7 +1547,7 @@ static int eqos_probe(struct udevice *dev)
 
 		ret = mdio_register(eqos->mii);
 		if (ret < 0) {
-			pr_err("mdio_register() failed: %d", ret);
+			pr_err("mdio_register() failed: %d\n", ret);
 			goto err_free_mdio;
 		}
 	}
-- 
2.43.0

