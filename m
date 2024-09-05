Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9048ACD5BAE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 12:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEA588C97;
	Thu,  5 Sep 2024 14:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bigAIRbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071E988C9F; Thu,  5 Sep 2024 14:10:25 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86E688C88
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 14:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5bf01bdaff0so782082a12.3
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725538222; x=1726143022; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fe/XupOI/aueAnNpDPW6cnN9NwjnF2cOSz3s2meQy00=;
 b=bigAIRbFN/0PfEzskXEh6x2/7kS8uGjpxCb2/sQC31GY1bMQo71AKyR34URtoZgZrZ
 p9EBP4PHqOtFUyWkmo8BajhnTX7S0FNVy+5EsQ+qhne8QdSaYHEaJlchQ/I1gDJ2HtBP
 KrAd+Fs6LWpnAw0Xf1cCfhEfeXr/I2k9U+63sjeAVD3/XRmKX/06MzghkJPKrUAqF/nm
 QIqC0HBTSdcZJKOaGgXC/AbipiKDPxNkdVECevaKt49Pg8YbvO8u+WuJw/TmxUwfnl1a
 Cf0TjI8HHUiDGpefgFfEGIQN2F/28tI/7kDFGimhhpeIYM7mjFCgO3JaA7MTSQNW3VmM
 1YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725538222; x=1726143022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fe/XupOI/aueAnNpDPW6cnN9NwjnF2cOSz3s2meQy00=;
 b=VCamkDNtmD5JBW9FxhniOC4lZss9T9O39BLwy6UQ5LfIvpHKGbtCXh8oKmllsuxRGe
 0TNoGo70u5Yf4XyeYBYG4gE9eZdzIn9a+gmq1mEkaZDTgw/j6qW3Y2RCzX3/o2j+5nmV
 5ekRKWVETcUxgb8qv0fkUUXF3dsqDtA1IefMJlnEEFUdaNrooFlGQv+aZDXKofC0AjGF
 YJM2Tnm1hiob1vU0ROqLF/oOWYeU+3RyadAoGBLemgsznm2oLspRz+sxsrodhomcrQra
 b/q+//4L0R3cNP/eH6hUzuSWejS24kW/wp2I5HMf3VIVS4LvkPVmAMEud2/iKUoke+lH
 758A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKEaNxJRDYVEVNqyv46HeZy6Cf+R2VNXZg3kNZCmpHF11E3HxQYvCNM+6go03FqQ6UqimOG6U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu5YnPam7cS2vcUVGOBaJ888yh5zdIqSX4iuehO7fNEVoYby8z
 ocm2JtWpGDt9ociTncIlHl2I7S1W2DuPbDlIP+MB+WXTf/oFBEHG8udaVwMD0GI=
X-Google-Smtp-Source: AGHT+IECoRB9oz0o1DpF1R4C5n7I5S+ZxpB2D1qsbl8seoPbji8VHzQIeBSv3YQBDbg3p2CxNUFzZA==
X-Received: by 2002:a05:6402:2813:b0:5c3:cd5b:3a0f with SMTP id
 4fb4d7f45d1cf-5c3cd5b3c01mr1890661a12.15.1725538222031; 
 Thu, 05 Sep 2024 05:10:22 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc529241sm1169127a12.11.2024.09.05.05.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 05:10:21 -0700 (PDT)
Message-ID: <18791918-0b81-450c-a441-7c464e87430b@linaro.org>
Date: Thu, 5 Sep 2024 14:10:20 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] net: phy: add Qualcomm QCA807x driver
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240522100638.224484-1-robert.marko@sartura.hr>
 <20240522100638.224484-2-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240522100638.224484-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi all,

Not sure what the status of this series is, seems like it slipped by my
inbox. Both patches are assigned to me on patchwork but they only affect
the phy subsystem...

At least for this one:

Acked-by: Caleb Connolly <caleb.connolly@linaro.org>



On 22/05/2024 12:06, Robert Marko wrote:
> This adds driver for the Qualcomm QCA8072 and QCA8075 PHY-s.
> 
> They are 2 or 5 port IEEE 802.3 clause 22 compliant
> 10BASE-Te, 100BASE-TX and 1000BASE-T PHY-s.
> 
> They feature 2 SerDes, one for PSGMII or QSGMII connection with MAC,
> while second one is SGMII for connection to MAC or fiber.
> 
> Both models have a combo port that supports 1000BASE-X and 100BASE-FX
> fiber (Currently not supported in U-Boot)
> 
> Each PHY inside of QCA807x series has 2 digitally controlled output only
> pins that natively drive LED-s.
> 
> These PHY-s are commonly used in Qualcomm IPQ40xx, IPQ60xx and IPQ807x
> boards.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/phy/Kconfig   |   6 ++
>  drivers/net/phy/Makefile  |   1 +
>  drivers/net/phy/qca807x.c | 211 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 218 insertions(+)
>  create mode 100644 drivers/net/phy/qca807x.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3d96938eab..cc79043b97 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -243,6 +243,12 @@ config PHY_NXP_TJA11XX
>  	help
>  	  Currently supports the NXP TJA1100 and TJA1101 PHY.
>  
> +config PHY_QCA807X
> +	bool "Qualcomm QCA807x PHYs support"
> +	help
> +	  Currently supports the Qualcomm QCA8072, QCA8075 and the PSGMII
> +	  control PHY.
> +
>  config PHY_REALTEK
>  	bool "Realtek Ethernet PHYs support"
>  
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 2487f366e1..b2d31fe4f2 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PHY_MOTORCOMM) += motorcomm.o
>  obj-$(CONFIG_PHY_NATSEMI) += natsemi.o
>  obj-$(CONFIG_PHY_NXP_C45_TJA11XX) += nxp-c45-tja11xx.o
>  obj-$(CONFIG_PHY_NXP_TJA11XX) += nxp-tja11xx.o
> +obj-$(CONFIG_PHY_QCA807X) += qca807x.o
>  obj-$(CONFIG_PHY_REALTEK) += realtek.o
>  obj-$(CONFIG_PHY_SMSC) += smsc.o
>  obj-$(CONFIG_PHY_TERANETICS) += teranetics.o
> diff --git a/drivers/net/phy/qca807x.c b/drivers/net/phy/qca807x.c
> new file mode 100644
> index 0000000000..a851ff34a0
> --- /dev/null
> +++ b/drivers/net/phy/qca807x.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Sartura Ltd.
> + *
> + * Author: Robert Marko <robert.marko@sartura.hr>
> + *
> + * Qualcomm QCA8072 and QCA8075 PHY driver
> + */
> +
> +#include <dm/device_compat.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <phy.h>
> +
> +#define PHY_ID_QCA8072			0x004dd0b2
> +#define PHY_ID_QCA8075			0x004dd0b1
> +#define PHY_ID_QCA807X_PSGMII		0x06820805
> +#define PHY_ID_QCA807X_MASK		GENMASK(31, 0)
> +
> +#define QCA807X_CHIP_CONFIGURATION 				0x1f
> +#define QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH	0x801a
> +#define QCA807X_CONTROL_DAC_MASK				GENMASK(2, 0)
> +/* List of tweaks enabled by this bit:
> + * - With both FULL amplitude and FULL bias current: bias current
> + *   is set to half.
> + * - With only DSP amplitude: bias current is set to half and
> + *   is set to 1/4 with cable < 10m.
> + * - With DSP bias current (included both DSP amplitude and
> + *   DSP bias current): bias current is half the detected current
> + *   with cable < 10m.
> + */
> +#define QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK			BIT(2)
> +#define QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT			BIT(1)
> +#define QCA807X_CONTROL_DAC_DSP_AMPLITUDE			BIT(0)
> +
> +#define QCA807X_MMD7_LED_100N_1 	0x8074
> +#define QCA807X_MMD7_LED_100N_2 	0x8075
> +#define QCA807X_MMD7_LED_1000N_1 	0x8076
> +#define QCA807X_MMD7_LED_1000N_2 	0x8077
> +#define QCA807X_LED_TXACT_BLK_EN_2 	BIT(10)
> +#define QCA807X_LED_RXACT_BLK_EN_2 	BIT(9)
> +#define QCA807X_LED_GT_ON_EN_2 		BIT(6)
> +#define QCA807X_LED_HT_ON_EN_2 		BIT(5)
> +#define QCA807X_LED_BT_ON_EN_2 		BIT(4)
> +
> +/* PSGMII PHY specific */
> +#define PSGMII_QSGMII_DRIVE_CONTROL_1 		0xb
> +#define PSGMII_QSGMII_TX_DRIVER_MASK		GENMASK(7, 4)
> +#define PQSGMII_TX_DRIVER_140MV				0x0
> +#define PQSGMII_TX_DRIVER_160MV				0x1
> +#define PQSGMII_TX_DRIVER_180MV				0x2
> +#define PQSGMII_TX_DRIVER_200MV				0x3
> +#define PQSGMII_TX_DRIVER_220MV				0x4
> +#define PQSGMII_TX_DRIVER_240MV				0x5
> +#define PQSGMII_TX_DRIVER_260MV				0x6
> +#define PQSGMII_TX_DRIVER_280MV				0x7
> +#define PQSGMII_TX_DRIVER_300MV				0x8
> +#define PQSGMII_TX_DRIVER_320MV				0x9
> +#define PQSGMII_TX_DRIVER_400MV				0xa
> +#define PQSGMII_TX_DRIVER_500MV				0xb
> +#define PQSGMII_TX_DRIVER_600MV				0xc
> +#define PSGMII_MODE_CTRL 			0x6d
> +#define PSGMII_MODE_CTRL_AZ_WORKAROUND_MASK 	GENMASK(3, 0)
> +#define PSGMII_MMD3_SERDES_CONTROL		0x805a
> +
> +static int qca807x_config(struct phy_device *phydev)
> +{
> +	int control_dac, ret = 0;
> +	bool dac_full_amplitude;
> +	bool dac_full_bias_current;
> +	bool dac_disable_bias_current_tweak;
> +	ofnode node;
> +
> +	node = phy_get_ofnode(phydev);
> +	if (!ofnode_valid(node))
> +		return -EINVAL;
> +
> +	dac_full_amplitude = ofnode_read_bool(node, "qcom,dac-full-amplitude");
> +	dac_full_bias_current = ofnode_read_bool(node, "qcom,dac-full-bias-current");
> +	dac_disable_bias_current_tweak = ofnode_read_bool(node, "qcom,dac-disable-bias-current-tweak");
> +
> +	/* Check for Combo port */
> +	if(phy_read(phydev, MDIO_DEVAD_NONE, QCA807X_CHIP_CONFIGURATION)) {
> +		int psgmii_serdes;
> +
> +		/* Prevent PSGMII going into hibernation via PSGMII self test */
> +		psgmii_serdes = phy_read_mmd(phydev, MDIO_MMD_PCS, PSGMII_MMD3_SERDES_CONTROL);
> +		psgmii_serdes &= ~BIT(1);
> +		ret = phy_write_mmd(phydev, MDIO_MMD_PCS, PSGMII_MMD3_SERDES_CONTROL, psgmii_serdes);
> +	}
> +
> +	control_dac = phy_read_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH);
> +	control_dac &= ~QCA807X_CONTROL_DAC_MASK;
> +	if (!dac_full_amplitude)
> +		control_dac |= QCA807X_CONTROL_DAC_DSP_AMPLITUDE;
> +	if (!dac_full_amplitude)
> +		control_dac |= QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT;
> +	if (!dac_disable_bias_current_tweak)
> +		control_dac |= QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH, control_dac);
> +
> +	phydev->supported = phydev->drv->features;
> +	phydev->advertising = phydev->drv->features;
> +
> +	genphy_config_aneg(phydev);
> +	genphy_restart_aneg(phydev);
> +
> +	return ret;
> +}
> +
> +static int qca807x_psgmii_config(struct phy_device *phydev)
> +{
> +	int psgmii_az, tx_amp, ret = 0;
> +	u32 tx_drive_strength;
> +	ofnode node;
> +
> +	node = phy_get_ofnode(phydev);
> +	if (!ofnode_valid(node))
> +		return -EINVAL;
> +
> +	/* Default to 600mw if not defined */
> +	if (ofnode_read_u32(node, "qcom,tx-drive-strength-milliwatt",
> +	                    &tx_drive_strength))
> +		tx_drive_strength = 600;
> +
> +	switch (tx_drive_strength) {
> +	case 140:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_140MV;
> +		break;
> +	case 160:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_160MV;
> +		break;
> +	case 180:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_180MV;
> +		break;
> +	case 200:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_200MV;
> +		break;
> +	case 220:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_220MV;
> +		break;
> +	case 240:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_240MV;
> +		break;
> +	case 260:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_260MV;
> +		break;
> +	case 280:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_280MV;
> +		break;
> +	case 300:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_300MV;
> +		break;
> +	case 320:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_320MV;
> +		break;
> +	case 400:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_400MV;
> +		break;
> +	case 500:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_500MV;
> +		break;
> +	case 600:
> +		tx_drive_strength = PQSGMII_TX_DRIVER_600MV;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Workaround to enable AZ transmitting ability */
> +	psgmii_az = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PSGMII_MODE_CTRL);
> +	psgmii_az &= ~PSGMII_MODE_CTRL_AZ_WORKAROUND_MASK;
> +	psgmii_az |= FIELD_PREP(PSGMII_MODE_CTRL_AZ_WORKAROUND_MASK, 0xc);
> +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, PSGMII_MODE_CTRL, psgmii_az);
> +	psgmii_az = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PSGMII_MODE_CTRL);
> +
> +
> +	tx_amp = phy_read(phydev, MDIO_DEVAD_NONE, PSGMII_QSGMII_DRIVE_CONTROL_1);
> +	tx_amp &= ~PSGMII_QSGMII_TX_DRIVER_MASK;
> +	tx_amp |= FIELD_PREP(PSGMII_QSGMII_TX_DRIVER_MASK, tx_drive_strength);
> +	ret = phy_write(phydev, MDIO_DEVAD_NONE, PSGMII_QSGMII_DRIVE_CONTROL_1, tx_amp);
> +
> +	return ret;
> +}
> +
> +U_BOOT_PHY_DRIVER(QCA8072_driver) =  {
> +	.name = "Qualcomm QCA8072",
> +	.uid = PHY_ID_QCA8072,
> +	.mask = PHY_ID_QCA807X_MASK,
> +	.features = PHY_GBIT_FEATURES,
> +	.config = qca807x_config,
> +	.startup = genphy_startup,
> +	.shutdown = genphy_shutdown,
> +};
> +
> +U_BOOT_PHY_DRIVER(QCA8075_driver) =  {
> +	.name = "Qualcomm QCA8075",
> +	.uid = PHY_ID_QCA8075,
> +	.mask = PHY_ID_QCA807X_MASK,
> +	.features = PHY_GBIT_FEATURES,
> +	.config = qca807x_config,
> +	.startup = genphy_startup,
> +	.shutdown = genphy_shutdown,
> +};
> +
> +U_BOOT_PHY_DRIVER(QCA807X_PSGMII_driver) =  {
> +	.name = "Qualcomm QCA807x PSGMII",
> +	.uid = PHY_ID_QCA807X_PSGMII,
> +	.mask = PHY_ID_QCA807X_MASK,
> +	.config = qca807x_psgmii_config,
> +};

-- 
// Caleb (they/them)
