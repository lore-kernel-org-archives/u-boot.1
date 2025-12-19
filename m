Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B77D78783
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 14:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E718042F;
	Fri, 19 Dec 2025 15:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DuB/VSx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713B68042F; Fri, 19 Dec 2025 15:13:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C3A80077
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 15:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D296160165;
 Fri, 19 Dec 2025 14:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADB5C4CEF1;
 Fri, 19 Dec 2025 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766153592;
 bh=glSuJJdqqSOCxkVW0OBusnU+jPJAXlLk2+Fb/aDgCjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DuB/VSx9c7AvkNQEPh61KQOgyOL+Aa5UwQ5HaUaDFq0bM40X4OIMEIPuUuFVWAOZ9
 XvQdM1ufiQkVw19fH6IkSIKYTjC+DtHrPYnZsLXrBGYPzeT8oIPuwXuW7foHt8SXiB
 4MHewChq/sYrlxw+KvZ9/Uz5wwvgfHG91lrul/OIe058wWjpkjFmAPk8WO+QplUXkf
 Rff8ID6pmiu7jQOAsEk0qlWoYlLbT9konIxSACThgnWq44ts6P1lCk5GneR+FApys+
 /4iXdXRXjwziClt/74bV40mmGqNstXKEH8fLCAYlXQo8mfSvf2xCEDOa4voDUvEzfX
 aOtz00c3SzTxA==
Date: Fri, 19 Dec 2025 19:43:02 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 3/6] phy: qcom: Add QMP USB PHY driver
Message-ID: <aUVdbkuosQBKZ5ls@sumit-xelite>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-4-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061557.1999367-4-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Dec 18, 2025 at 11:45:54AM +0530, Varadarajan Narayanan wrote:
> Port Qualcomm QMP USB PHY driver from Linux.

Which kernel driver commit is used as based for this porting?

> This PHY is available in
> many Qcom SoCs. Enabled and tested the driver on IPQ9574.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/phy/qcom/Kconfig                      |    8 +
>  drivers/phy/qcom/Makefile                     |    1 +
>  drivers/phy/qcom/phy-qcom-qmp-common.h        |   62 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h   |   17 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h    |   34 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h    |   36 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h    |   17 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h    |   17 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h        |   32 +
>  .../phy/qcom/phy-qcom-qmp-qserdes-com-v7.h    |   87 +
>  .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h   |   78 +
>  drivers/phy/qcom/phy-qcom-qmp-usb.c           | 2114 +++++++++++++++++
>  drivers/phy/qcom/phy-qcom-qmp.h               |   15 +
>  13 files changed, 2518 insertions(+)
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb.c
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 0dd69f7ffd0..ea4d52248ab 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -24,6 +24,14 @@ config PHY_QCOM_QMP_UFS
>  	help
>  	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
>  
> +config PHY_QCOM_QMP_USB
> +	tristate "Qualcomm QMP USB PHY Driver"

U-Boot doesn't have any tristate support, so use bool here instead. The
other Kconfigs need fix too but that can come as a separate patch.

> +	select GENERIC_PHY
> +	default PHY_QCOM_QMP
> +	help
> +	  Enable this to support the QMP USB PHY transceiver that is used
> +	  with USB3 controllers on Qualcomm chips.
> +
>  config PHY_QCOM_QUSB2
>  	tristate "Qualcomm USB QUSB2 PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 1c4e7d8d391..ef83a122234 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>  obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
>  obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
> +obj-$(CONFIG_PHY_QCOM_QMP_USB) += phy-qcom-qmp-usb.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
>  obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-common.h b/drivers/phy/qcom/phy-qcom-qmp-common.h
> new file mode 100644
> index 00000000000..71356fb7dd0
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-common.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_COMMON_H_
> +#define QCOM_PHY_QMP_COMMON_H_
> +
> +struct qmp_phy_init_tbl {
> +	unsigned int offset;
> +	unsigned int val;
> +	char *name;
> +	/*
> +	 * mask of lanes for which this register is written
> +	 * for cases when second lane needs different values
> +	 */
> +	u8 lane_mask;
> +};
> +
> +#define QMP_PHY_INIT_CFG(o, v)		\
> +	{				\
> +		.offset = o,		\
> +		.val = v,		\
> +		.name = #o,		\
> +		.lane_mask = 0xff,	\
> +	}
> +
> +#define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
> +	{				\
> +		.offset = o,		\
> +		.val = v,		\
> +		.name = #o,		\
> +		.lane_mask = l,		\
> +	}
> +
> +static inline void qmp_configure_lane(struct udevice *dev, void __iomem *base,
> +				      const struct qmp_phy_init_tbl tbl[],
> +				      int num, u8 lane_mask)
> +{
> +	int i;
> +	const struct qmp_phy_init_tbl *t = tbl;
> +
> +	if (!t)
> +		return;
> +
> +	for (i = 0; i < num; i++, t++) {
> +		if (!(t->lane_mask & lane_mask))
> +			continue;
> +
> +		dev_dbg(dev, "Writing Reg: %s Offset: 0x%04x Val: 0x%02x\n",
> +			t->name, t->offset, t->val);
> +		writel(t->val, base + t->offset);
> +	}
> +}
> +
> +static inline void qmp_configure(struct udevice *dev, void __iomem *base,
> +				 const struct qmp_phy_init_tbl tbl[], int num)
> +{
> +	qmp_configure_lane(dev, base, tbl, num, 0xff);
> +}
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
> new file mode 100644
> index 00000000000..e256a089f22
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_MISC_V4_H_
> +#define QCOM_PHY_QMP_PCS_MISC_V4_H_
> +
> +/* Only for QMP V4 PHY - PCS_MISC registers */
> +#define QPHY_V4_PCS_MISC_TYPEC_CTRL			0x00
> +#define QPHY_V4_PCS_MISC_TYPEC_PWRDN_CTRL		0x04
> +#define QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1		0x08
> +#define QPHY_V4_PCS_MISC_CLAMP_ENABLE			0x0c
> +#define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
> +#define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
> new file mode 100644
> index 00000000000..d7fd4ac0fc5
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_USB_V4_H_
> +#define QCOM_PHY_QMP_PCS_USB_V4_H_
> +
> +/* Only for QMP V4 PHY - USB3 PCS registers */
> +#define QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1		0x000
> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_STATUS		0x004
> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x008
> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL2		0x00c
> +#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x010
> +#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x014
> +#define QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x018
> +#define QPHY_V4_PCS_USB3_LFPS_TX_ECSTART		0x01c
> +#define QPHY_V4_PCS_USB3_LFPS_PER_TIMER_VAL		0x020
> +#define QPHY_V4_PCS_USB3_LFPS_TX_END_CNT_U3_START	0x024
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_LOCK_TIME		0x028
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME		0x02c
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_CTLE_TIME		0x030
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2	0x034
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x038
> +#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x03c
> +#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x040
> +#define QPHY_V4_PCS_USB3_ARCVR_DTCT_EN_PERIOD		0x044
> +#define QPHY_V4_PCS_USB3_ARCVR_DTCT_CM_DLY		0x048
> +#define QPHY_V4_PCS_USB3_TXONESZEROS_RUN_LENGTH		0x04c
> +#define QPHY_V4_PCS_USB3_ALFPS_DEGLITCH_VAL		0x050
> +#define QPHY_V4_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x054
> +#define QPHY_V4_PCS_USB3_TEST_CONTROL			0x058
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
> new file mode 100644
> index 00000000000..73de626223e
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_USB_V5_H_
> +#define QCOM_PHY_QMP_PCS_USB_V5_H_
> +
> +/* Only for QMP V5 PHY - USB3 have different offsets than V4 */
> +#define QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1		0x000
> +#define QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_STATUS		0x004
> +#define QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x008
> +#define QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL2		0x00c
> +#define QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x010
> +#define QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x014
> +#define QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x018
> +#define QPHY_V5_PCS_USB3_LFPS_TX_ECSTART		0x01c
> +#define QPHY_V5_PCS_USB3_LFPS_PER_TIMER_VAL		0x020
> +#define QPHY_V5_PCS_USB3_LFPS_TX_END_CNT_U3_START	0x024
> +#define QPHY_V5_PCS_USB3_LFPS_CONFIG1			0x028
> +#define QPHY_V5_PCS_USB3_RXEQTRAINING_LOCK_TIME		0x02c
> +#define QPHY_V5_PCS_USB3_RXEQTRAINING_WAIT_TIME		0x030
> +#define QPHY_V5_PCS_USB3_RXEQTRAINING_CTLE_TIME		0x034
> +#define QPHY_V5_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2	0x038
> +#define QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x03c
> +#define QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x040
> +#define QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x044
> +#define QPHY_V5_PCS_USB3_ARCVR_DTCT_EN_PERIOD		0x048
> +#define QPHY_V5_PCS_USB3_ARCVR_DTCT_CM_DLY		0x04c
> +#define QPHY_V5_PCS_USB3_TXONESZEROS_RUN_LENGTH		0x050
> +#define QPHY_V5_PCS_USB3_ALFPS_DEGLITCH_VAL		0x054
> +#define QPHY_V5_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x058
> +#define QPHY_V5_PCS_USB3_TEST_CONTROL			0x05c
> +#define QPHY_V5_PCS_USB3_RXTERMINATION_DLY_SEL		0x060
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
> new file mode 100644
> index 00000000000..df670143feb
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_USB_V6_H_
> +#define QCOM_PHY_QMP_PCS_USB_V6_H_
> +
> +#define QPHY_V6_PCS_USB3_POWER_STATE_CONFIG1		0x00
> +#define QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x08
> +#define QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x14
> +#define QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
> +#define QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
> +#define QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
> +#define QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
> new file mode 100644
> index 00000000000..24368d45ae7
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_USB_V7_H_
> +#define QCOM_PHY_QMP_PCS_USB_V7_H_
> +
> +#define QPHY_V7_PCS_USB3_POWER_STATE_CONFIG1		0x00
> +#define QPHY_V7_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x08
> +#define QPHY_V7_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x14
> +#define QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
> +#define QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
> +#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
> +#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
> new file mode 100644
> index 00000000000..c7759892ed2
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_V7_H_
> +#define QCOM_PHY_QMP_PCS_V7_H_
> +
> +/* Only for QMP V7 PHY - USB/PCIe PCS registers */
> +#define QPHY_V7_PCS_SW_RESET			0x000
> +#define QPHY_V7_PCS_PCS_STATUS1			0x014
> +#define QPHY_V7_PCS_POWER_DOWN_CONTROL		0x040
> +#define QPHY_V7_PCS_START_CONTROL		0x044
> +#define QPHY_V7_PCS_POWER_STATE_CONFIG1		0x090
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG1		0x0c4
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG2		0x0c8
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG3		0x0cc
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG6		0x0d8
> +#define QPHY_V7_PCS_REFGEN_REQ_CONFIG1		0x0dc
> +#define QPHY_V7_PCS_RX_SIGDET_LVL		0x188
> +#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
> +#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
> +#define QPHY_V7_PCS_RATE_SLEW_CNTRL1		0x198
> +#define QPHY_V7_PCS_CDR_RESET_TIME		0x1b0
> +#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG1	0x1c0
> +#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG2	0x1c4
> +#define QPHY_V7_PCS_PCS_TX_RX_CONFIG		0x1d0
> +#define QPHY_V7_PCS_EQ_CONFIG1			0x1dc
> +#define QPHY_V7_PCS_EQ_CONFIG2			0x1e0
> +#define QPHY_V7_PCS_EQ_CONFIG5			0x1ec
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
> new file mode 100644
> index 00000000000..7430f492147
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_COM_V7_H_
> +#define QCOM_PHY_QMP_QSERDES_COM_V7_H_
> +
> +/* Only for QMP V7 PHY - QSERDES COM registers */
> +
> +#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1			0x00
> +#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1			0x04
> +#define QSERDES_V7_COM_CP_CTRL_MODE1				0x10
> +#define QSERDES_V7_COM_PLL_RCTRL_MODE1				0x14
> +#define QSERDES_V7_COM_PLL_CCTRL_MODE1				0x18
> +#define QSERDES_V7_COM_CORECLK_DIV_MODE1			0x1c
> +#define QSERDES_V7_COM_LOCK_CMP1_MODE1				0x20
> +#define QSERDES_V7_COM_LOCK_CMP2_MODE1				0x24
> +#define QSERDES_V7_COM_DEC_START_MODE1				0x28
> +#define QSERDES_V7_COM_DEC_START_MSB_MODE1			0x2c
> +#define QSERDES_V7_COM_DIV_FRAC_START1_MODE1			0x30
> +#define QSERDES_V7_COM_DIV_FRAC_START2_MODE1			0x34
> +#define QSERDES_V7_COM_DIV_FRAC_START3_MODE1			0x38
> +#define QSERDES_V7_COM_HSCLK_SEL_1				0x3c
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE1			0x40
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE1			0x44
> +#define QSERDES_V7_COM_VCO_TUNE1_MODE1				0x48
> +#define QSERDES_V7_COM_VCO_TUNE2_MODE1				0x4c
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x54
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x58
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x5c
> +#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0			0x60
> +#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0			0x64
> +#define QSERDES_V7_COM_CP_CTRL_MODE0				0x70
> +#define QSERDES_V7_COM_PLL_RCTRL_MODE0				0x74
> +#define QSERDES_V7_COM_PLL_CCTRL_MODE0				0x78
> +#define QSERDES_V7_COM_PLL_CORE_CLK_DIV_MODE0			0x7c
> +#define QSERDES_V7_COM_LOCK_CMP1_MODE0				0x80
> +#define QSERDES_V7_COM_LOCK_CMP2_MODE0				0x84
> +#define QSERDES_V7_COM_DEC_START_MODE0				0x88
> +#define QSERDES_V7_COM_DEC_START_MSB_MODE0			0x8c
> +#define QSERDES_V7_COM_DIV_FRAC_START1_MODE0			0x90
> +#define QSERDES_V7_COM_DIV_FRAC_START2_MODE0			0x94
> +#define QSERDES_V7_COM_DIV_FRAC_START3_MODE0			0x98
> +#define QSERDES_V7_COM_HSCLK_HS_SWITCH_SEL_1			0x9c
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE0			0xa0
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE0			0xa4
> +#define QSERDES_V7_COM_VCO_TUNE1_MODE0				0xa8
> +#define QSERDES_V7_COM_VCO_TUNE2_MODE0				0xac
> +#define QSERDES_V7_COM_BG_TIMER					0xbc
> +#define QSERDES_V7_COM_SSC_EN_CENTER				0xc0
> +#define QSERDES_V7_COM_SSC_ADJ_PER1				0xc4
> +#define QSERDES_V7_COM_SSC_PER1					0xcc
> +#define QSERDES_V7_COM_SSC_PER2					0xd0
> +#define QSERDES_V7_COM_PLL_POST_DIV_MUX				0xd8
> +#define QSERDES_V7_COM_PLL_BIAS_EN_CLK_BUFLR_EN			0xdc
> +#define QSERDES_V7_COM_CLK_ENABLE1				0xe0
> +#define QSERDES_V7_COM_SYS_CLK_CTRL				0xe4
> +#define QSERDES_V7_COM_SYSCLK_BUF_ENABLE			0xe8
> +#define QSERDES_V7_COM_PLL_IVCO					0xf4
> +#define QSERDES_V7_COM_PLL_IVCO_MODE1				0xf8
> +#define QSERDES_V7_COM_SYSCLK_EN_SEL				0x110
> +#define QSERDES_V7_COM_RESETSM_CNTRL				0x118
> +#define QSERDES_V7_COM_LOCK_CMP_EN				0x120
> +#define QSERDES_V7_COM_LOCK_CMP_CFG				0x124
> +#define QSERDES_V7_COM_VCO_TUNE_CTRL				0x13c
> +#define QSERDES_V7_COM_VCO_TUNE_MAP				0x140
> +#define QSERDES_V7_COM_VCO_TUNE_INITVAL2			0x148
> +#define QSERDES_V7_COM_VCO_TUNE_MAXVAL2				0x158
> +#define QSERDES_V7_COM_CLK_SELECT				0x164
> +#define QSERDES_V7_COM_CORE_CLK_EN				0x170
> +#define QSERDES_V7_COM_CMN_CONFIG_1				0x174
> +#define QSERDES_V7_COM_SVS_MODE_CLK_SEL				0x17c
> +#define QSERDES_V7_COM_CMN_MISC_1				0x184
> +#define QSERDES_V7_COM_CMN_MODE					0x188
> +#define QSERDES_V7_COM_PLL_VCO_DC_LEVEL_CTRL			0x198
> +#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1			0x1a4
> +#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2			0x1a8
> +#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3			0x1ac
> +#define QSERDES_V7_COM_ADDITIONAL_MISC				0x1b4
> +#define QSERDES_V7_COM_ADDITIONAL_MISC_2			0x1b8
> +#define QSERDES_V7_COM_ADDITIONAL_MISC_3			0x1bc
> +#define QSERDES_V7_COM_CMN_STATUS				0x1d0
> +#define QSERDES_V7_COM_C_READY_STATUS				0x1f8
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
> new file mode 100644
> index 00000000000..91f865b1134
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V7_H_
> +#define QCOM_PHY_QMP_QSERDES_TXRX_V7_H_
> +
> +#define QSERDES_V7_TX_CLKBUF_ENABLE				0x08
> +#define QSERDES_V7_TX_RESET_TSYNC_EN				0x1c
> +#define QSERDES_V7_TX_PRE_STALL_LDO_BOOST_EN			0x20
> +#define QSERDES_V7_TX_TX_BAND					0x24
> +#define QSERDES_V7_TX_INTERFACE_SELECT				0x2c
> +#define QSERDES_V7_TX_RES_CODE_LANE_TX				0x34
> +#define QSERDES_V7_TX_RES_CODE_LANE_RX				0x38
> +#define QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX			0x3c
> +#define QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX			0x40
> +#define QSERDES_V7_TX_PARRATE_REC_DETECT_IDLE_EN		0x60
> +#define QSERDES_V7_TX_BIST_PATTERN7				0x7c
> +#define QSERDES_V7_TX_LANE_MODE_1				0x84
> +#define QSERDES_V7_TX_LANE_MODE_2				0x88
> +#define QSERDES_V7_TX_LANE_MODE_3				0x8c
> +#define QSERDES_V7_TX_LANE_MODE_4				0x90
> +#define QSERDES_V7_TX_LANE_MODE_5				0x94
> +#define QSERDES_V7_TX_RCV_DETECT_LVL_2				0xa4
> +#define QSERDES_V7_TX_TRAN_DRVR_EMP_EN				0xc0
> +#define QSERDES_V7_TX_TX_INTERFACE_MODE				0xc4
> +#define QSERDES_V7_TX_VMODE_CTRL1				0xc8
> +#define QSERDES_V7_TX_PI_QEC_CTRL				0xe4
> +
> +#define QSERDES_V7_RX_UCDR_FO_GAIN				0x08
> +#define QSERDES_V7_RX_UCDR_SO_GAIN				0x14
> +#define QSERDES_V7_RX_UCDR_FASTLOCK_FO_GAIN			0x30
> +#define QSERDES_V7_RX_UCDR_SO_SATURATION_AND_ENABLE		0x34
> +#define QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_LOW			0x3c
> +#define QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_HIGH			0x40
> +#define QSERDES_V7_RX_UCDR_PI_CONTROLS				0x44
> +#define QSERDES_V7_RX_UCDR_SB2_THRESH1				0x4c
> +#define QSERDES_V7_RX_UCDR_SB2_THRESH2				0x50
> +#define QSERDES_V7_RX_UCDR_SB2_GAIN1				0x54
> +#define QSERDES_V7_RX_UCDR_SB2_GAIN2				0x58
> +#define QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE			0x60
> +#define QSERDES_V7_RX_TX_ADAPT_POST_THRESH			0xcc
> +#define QSERDES_V7_RX_VGA_CAL_CNTRL1				0xd4
> +#define QSERDES_V7_RX_VGA_CAL_CNTRL2				0xd8
> +#define QSERDES_V7_RX_GM_CAL					0xdc
> +#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL2			0xec
> +#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL3			0xf0
> +#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL4			0xf4
> +#define QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW			0xf8
> +#define QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH			0xfc
> +#define QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x110
> +#define QSERDES_V7_RX_SIDGET_ENABLES				0x118
> +#define QSERDES_V7_RX_SIGDET_CNTRL				0x11c
> +#define QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL			0x124
> +#define QSERDES_V7_RX_RX_MODE_00_LOW				0x15c
> +#define QSERDES_V7_RX_RX_MODE_00_HIGH				0x160
> +#define QSERDES_V7_RX_RX_MODE_00_HIGH2				0x164
> +#define QSERDES_V7_RX_RX_MODE_00_HIGH3				0x168
> +#define QSERDES_V7_RX_RX_MODE_00_HIGH4				0x16c
> +#define QSERDES_V7_RX_RX_MODE_01_LOW				0x170
> +#define QSERDES_V7_RX_RX_MODE_01_HIGH				0x174
> +#define QSERDES_V7_RX_RX_MODE_01_HIGH2				0x178
> +#define QSERDES_V7_RX_RX_MODE_01_HIGH3				0x17c
> +#define QSERDES_V7_RX_RX_MODE_01_HIGH4				0x180
> +#define QSERDES_V7_RX_RX_MODE_10_LOW				0x184
> +#define QSERDES_V7_RX_RX_MODE_10_HIGH				0x188
> +#define QSERDES_V7_RX_RX_MODE_10_HIGH2				0x18c
> +#define QSERDES_V7_RX_RX_MODE_10_HIGH3				0x190
> +#define QSERDES_V7_RX_RX_MODE_10_HIGH4				0x194
> +#define QSERDES_V7_RX_DFE_EN_TIMER				0x1a0
> +#define QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET			0x1a4
> +#define QSERDES_V7_RX_DCC_CTRL1					0x1a8
> +#define QSERDES_V7_RX_VTH_CODE					0x1b0
> +#define QSERDES_V7_RX_SIGDET_CAL_CTRL1				0x1e4
> +#define QSERDES_V7_RX_SIGDET_CAL_TRIM				0x1f8
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb.c b/drivers/phy/qcom/phy-qcom-qmp-usb.c
> new file mode 100644
> index 00000000000..0d6a9da174b
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-usb.c
> @@ -0,0 +1,2114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <clk.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <generic-phy.h>
> +#include <malloc.h>
> +#include <reset.h>
> +
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +
> +#include "phy-qcom-qmp-common.h"
> +
> +#include "phy-qcom-qmp.h"
> +#include "phy-qcom-qmp-pcs-misc-v3.h"
> +#include "phy-qcom-qmp-pcs-misc-v4.h"
> +#include "phy-qcom-qmp-pcs-usb-v4.h"
> +#include "phy-qcom-qmp-pcs-usb-v5.h"
> +#include "phy-qcom-qmp-pcs-usb-v6.h"
> +#include "phy-qcom-qmp-pcs-usb-v7.h"
> +
> +#include "phy-qcom-qmp-pcs-v4.h"
> +#include "phy-qcom-qmp-pcs-v5.h"
> +#include "phy-qcom-qmp-pcs-v6.h"
> +#include "phy-qcom-qmp-pcs-v7.h"
> +#include "phy-qcom-qmp-qserdes-com-v4.h"
> +#include "phy-qcom-qmp-qserdes-com-v5.h"
> +#include "phy-qcom-qmp-qserdes-com-v6.h"
> +#include "phy-qcom-qmp-qserdes-com-v7.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v4.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v5.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v6.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v7.h"
> +
> +#define SW_RESET				BIT(0)
> +/* QPHY_POWER_DOWN_CONTROL */
> +#define SW_PWRDN				BIT(0)
> +/* QPHY_START_CONTROL bits */
> +#define SERDES_START				BIT(0)
> +#define PCS_START				BIT(1)
> +/* QPHY_PCS_READY_STATUS bit */
> +#define PCS_READY				BIT(0)
> +
> +#define PHY_INIT_COMPLETE_TIMEOUT		10000
> +
> +/* set of registers with offsets different per-PHY */
> +enum qphy_reg_layout {
> +	/* PCS registers */
> +	QPHY_SW_RESET,
> +	QPHY_START_CTRL,
> +	QPHY_PCS_STATUS,
> +	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
> +	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
> +	QPHY_PCS_POWER_DOWN_CONTROL,
> +	QPHY_PCS_MISC_CLAMP_ENABLE,
> +	/* Keep last to ensure regs_layout arrays are properly initialized */
> +	QPHY_LAYOUT_SIZE
> +};
> +
> +static const unsigned int qmp_v2_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V2_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V2_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V2_PCS_USB_PCS_STATUS,
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V2_PCS_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V2_PCS_LFPS_RXTERM_IRQ_CLEAR,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_POWER_DOWN_CONTROL,
> +};
> +
> +static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V3_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V3_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V3_PCS_PCS_STATUS,
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V3_PCS_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V3_PCS_LFPS_RXTERM_IRQ_CLEAR,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V3_PCS_POWER_DOWN_CONTROL,
> +	[QPHY_PCS_MISC_CLAMP_ENABLE]	= QPHY_V3_PCS_MISC_CLAMP_ENABLE,
> +};
> +
> +static const unsigned int qmp_v4_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V4_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V4_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V4_PCS_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_POWER_DOWN_CONTROL,
> +
> +	/* In PCS_USB */
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> +	[QPHY_PCS_MISC_CLAMP_ENABLE]	= QPHY_V4_PCS_MISC_CLAMP_ENABLE,
> +};
> +
> +static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V5_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V5_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V5_PCS_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_PCS_POWER_DOWN_CONTROL,
> +
> +	/* In PCS_USB */
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> +};
> +
> +static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V6_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V6_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V6_PCS_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
> +
> +	/* In PCS_USB */
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> +};
> +
> +static const unsigned int qmp_v7_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V7_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V7_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V7_PCS_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V7_PCS_POWER_DOWN_CONTROL,
> +
> +	/* In PCS_USB */
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V7_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V7_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
> +	/* PLL and Loop filter settings */
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x29),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +	/* SSC settings */
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x7d),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x05),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> +	QMP_PHY_INIT_CFG(QSERDES_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x6c),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_ENABLES, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq8074_usb3_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
> +	/* PLL and Loop filter settings */
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +	/* SSC settings */
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq8074_usb3_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_ENABLES, 0x0),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq8074_usb3_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
> +};
> +
> +static const struct qmp_phy_init_tbl msm8996_usb3_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x04),
> +	/* PLL and Loop filter settings */
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +	/* SSC settings */
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl msm8996_usb3_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> +	QMP_PHY_INIT_CFG(QSERDES_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl msm8996_usb3_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xbb),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> +};
> +
> +static const struct qmp_phy_init_tbl msm8996_usb3_pcs_tbl[] = {
> +	/* FLL settings */
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNTRL2, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNTRL1, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNT_VAL_L, 0x09),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNT_VAL_H_TOL, 0x42),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_MAN_CODE, 0x85),
> +
> +	/* Lock Det settings */
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_POWER_STATE_CONFIG2, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl qdu1000_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl qdu1000_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
> +};
> +
> +static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START2_MODE0, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xc9),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORECLK_DIV_MODE0, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_CFG, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE1, 0x85),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE2, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x50),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
> +};
> +
> +static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_pcs_tbl[] = {
> +	/* FLL settings */
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> +
> +	/* Lock Det settings */
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
> +
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0xba),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V1, 0x9f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V2, 0xb5),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V3, 0x4c),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V4, 0x64),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_LS, 0x6a),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V1, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V1, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V2, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V2, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V3, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V3, 0x1d),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V4, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V4, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_LS, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_LS, 0x0d),
> +
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RATE_SLEW_CNTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> +
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_IPTRIM, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x95),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x05),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0xb8),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x37),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xef),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb3),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_2, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX, 0x02),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0xb8),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xbf),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xa9),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx55_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx55_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xbf),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x048),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0b),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdb),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x9e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x2e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0x25),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xb7),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xb7),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0x9e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x25),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_TX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_RX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0xf5),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_5, 0x5f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_PI_QEC_CTRL, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN2, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_GM_CAL, 0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_LOW, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xbf),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xdf),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xed),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_LOW, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH2, 0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH3, 0x1d),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH4, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DCC_CTRL1, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VTH_CODE, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_CTRL1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_TRIM, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl qcs8300_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0xf2),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +};
> +
> +static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE2_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE1, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
> +};
> +
> +static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl qcs8300_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xec),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG1, 0xd0),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +};
> +
> +static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORECLK_DIV_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE1, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE1, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE1, 0x75),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_HSCLK_SEL_1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE1_MODE1, 0x25),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE2_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE0, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE0, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE0, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE0, 0x75),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE1_MODE0, 0x25),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER1, 0x62),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP_CFG, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORE_CLK_EN, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CMN_CONFIG_1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_COM_ADDITIONAL_MISC, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_TX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_RX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_1, 0xf5),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_5, 0x5f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_TX_PI_QEC_CTRL, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_GAIN2, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_GM_CAL, 0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_LOW, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH, 0xbf),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH3, 0xdf),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH4, 0xed),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_LOW, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH2, 0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH3, 0x1d),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH4, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DCC_CTRL1, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VTH_CODE, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_CTRL1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_TRIM, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG5, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> +};
> +
> +struct qmp_usb_offsets {
> +	u16 serdes;
> +	u16 pcs;
> +	u16 pcs_misc;
> +	u16 pcs_usb;
> +	u16 tx;
> +	u16 rx;
> +};
> +
> +/* struct qmp_phy_cfg - per-PHY initialization config */
> +struct qmp_phy_cfg {
> +	const struct qmp_usb_offsets *offsets;
> +
> +	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> +	const struct qmp_phy_init_tbl *serdes_tbl;
> +	int serdes_tbl_num;
> +	const struct qmp_phy_init_tbl *tx_tbl;
> +	int tx_tbl_num;
> +	const struct qmp_phy_init_tbl *rx_tbl;
> +	int rx_tbl_num;
> +	const struct qmp_phy_init_tbl *pcs_tbl;
> +	int pcs_tbl_num;
> +	const struct qmp_phy_init_tbl *pcs_usb_tbl;
> +	int pcs_usb_tbl_num;
> +
> +	/* regulators to be requested */
> +	const char * const *vreg_list;
> +	int num_vregs;
> +
> +	/* array of registers with different offsets */
> +	const unsigned int *regs;
> +
> +	/* true, if PHY needs delay after POWER_DOWN */
> +	bool has_pwrdn_delay;
> +
> +	/* Offset from PCS to PCS_USB region */
> +	unsigned int pcs_usb_offset;
> +};
> +
> +struct qmp_usb {
> +	struct udevice *dev;
> +
> +	const struct qmp_phy_cfg *cfg;
> +
> +	void __iomem *serdes;
> +	void __iomem *pcs;
> +	void __iomem *pcs_misc;
> +	void __iomem *pcs_usb;
> +	void __iomem *tx;
> +	void __iomem *rx;
> +
> +	struct clk *pipe_clk;
> +	struct clk_bulk clks;
> +	int num_clks;
> +	int num_resets;
> +	struct reset_ctl_bulk *resets;
> +	struct regulator_bulk_data *vregs;
> +
> +	enum phy_mode mode;
> +
> +	struct phy *phy;
> +
> +	struct clk_fixed_rate pipe_clk_fixed;
> +};
> +
> +static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg |= val;
> +	writel(reg, base + offset);
> +
> +	/* ensure that above write is through */
> +	readl(base + offset);
> +}
> +
> +static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg &= ~val;
> +	writel(reg, base + offset);
> +
> +	/* ensure that above write is through */
> +	readl(base + offset);
> +}
> +
> +/* list of clocks required by phy */
> +static const char * const qmp_usb_phy_clk_l[] = {
> +	"aux", "cfg_ahb", "ref", "com_aux",
> +};
> +
> +/* list of resets */
> +static const char * const usb3phy_legacy_reset_l[] = {
> +	"phy", "common",
> +};
> +
> +static const char * const usb3phy_reset_l[] = {
> +	"phy_phy", "phy",
> +};
> +
> +/* list of regulators */
> +static const char * const qmp_phy_vreg_l[] = {
> +	"vdda-phy", "vdda-pll",
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
> +	.serdes		= 0,
> +	.pcs		= 0x800,
> +	.pcs_misc	= 0x600,
> +	.tx		= 0x200,
> +	.rx		= 0x400,
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
> +	.serdes		= 0,
> +	.pcs		= 0x800,
> +	.pcs_usb	= 0x800,
> +	.tx		= 0x200,
> +	.rx		= 0x400,
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_v3_msm8996 = {
> +	.serdes		= 0,
> +	.pcs		= 0x600,
> +	.tx		= 0x200,
> +	.rx		= 0x400,
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_v4 = {
> +	.serdes		= 0,
> +	.pcs		= 0x0800,
> +	.pcs_usb	= 0x0e00,
> +	.tx		= 0x0200,
> +	.rx		= 0x0400,
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
> +	.serdes		= 0,
> +	.pcs		= 0x0200,
> +	.pcs_usb	= 0x1200,
> +	.tx		= 0x0e00,
> +	.rx		= 0x1000,
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_v6 = {
> +	.serdes		= 0,
> +	.pcs		= 0x0200,
> +	.pcs_usb	= 0x1200,
> +	.tx		= 0x0e00,
> +	.rx		= 0x1000,
> +};
> +
> +static const struct qmp_usb_offsets qmp_usb_offsets_v7 = {
> +	.serdes		= 0,
> +	.pcs		= 0x0200,
> +	.pcs_usb	= 0x1200,
> +	.tx		= 0x0e00,
> +	.rx		= 0x1000,
> +};
> +
> +static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v3,
> +
> +	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
> +	.tx_tbl			= msm8996_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
> +	.rx_tbl			= ipq8074_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(ipq8074_usb3_rx_tbl),
> +	.pcs_tbl		= ipq8074_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v3_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v3,
> +
> +	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
> +	.tx_tbl			= msm8996_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
> +	.rx_tbl			= ipq8074_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(ipq8074_usb3_rx_tbl),
> +	.pcs_tbl		= ipq8074_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v3_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {
> +	.offsets		= &qmp_usb_offsets_ipq9574,
> +
> +	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
> +	.tx_tbl			= ipq9574_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(ipq9574_usb3_tx_tbl),
> +	.rx_tbl			= ipq9574_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(ipq9574_usb3_rx_tbl),
> +	.pcs_tbl		= ipq9574_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(ipq9574_usb3_pcs_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v3_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v3_msm8996,
> +
> +	.serdes_tbl		= msm8996_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(msm8996_usb3_serdes_tbl),
> +	.tx_tbl			= msm8996_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
> +	.rx_tbl			= msm8996_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(msm8996_usb3_rx_tbl),
> +	.pcs_tbl		= msm8996_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(msm8996_usb3_pcs_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v2_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg qdu1000_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sm8350_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sm8350_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= qdu1000_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(qdu1000_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= qdu1000_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(qdu1000_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v4_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x1000,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sa8775p_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sc8280xp_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sc8280xp_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sa8775p_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sa8775p_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg qcs8300_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= qcs8300_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(qcs8300_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= qcs8300_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(qcs8300_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sa8775p_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sa8775p_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sc8280xp_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sc8280xp_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sc8280xp_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sc8280xp_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,
> +};
> +
> +static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v3,
> +
> +	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= qmp_v3_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= qmp_v3_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= qmp_v3_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_pcs_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v3_usb3phy_regs_layout,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v4,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sm8150_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sm8150_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sm8150_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sm8150_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v4_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x600,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v4,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sm8250_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sm8250_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sm8250_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sm8250_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v4_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x600,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v4,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sdx55_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdx55_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sdx55_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdx55_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sm8250_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sm8250_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v4_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x600,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sdx65_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdx65_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sdx65_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdx65_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sm8350_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sm8350_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x1000,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v6,
> +
> +	.serdes_tbl		= sdx75_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sdx75_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sdx75_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sdx75_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sdx75_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v6_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x1000,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sm8350_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sm8350_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sm8350_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sm8350_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x1000,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static const struct qmp_phy_cfg x1e80100_usb3_uniphy_cfg = {
> +	.offsets		= &qmp_usb_offsets_v7,
> +
> +	.serdes_tbl		= x1e80100_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= x1e80100_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= x1e80100_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= x1e80100_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= x1e80100_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v7_usb3phy_regs_layout,
> +};
> +
> +static int qmp_usb_serdes_init(struct qmp_usb *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *serdes = qmp->serdes;
> +	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
> +	int serdes_tbl_num = cfg->serdes_tbl_num;
> +
> +	qmp_configure(qmp->dev, serdes, serdes_tbl, serdes_tbl_num);
> +
> +	return 0;
> +}
> +
> +static int qmp_usb_init(struct phy *phy)
> +{
> +	struct qmp_usb *qmp = dev_get_priv(phy->dev);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs = qmp->pcs;
> +	int ret;
> +
> +	ret = reset_assert_bulk(qmp->resets);
> +	if (ret) {
> +		dev_err(qmp->dev, "reset assert failed\n");
> +		goto err_disable_regulators;
> +	}
> +
> +	udelay(200);
> +
> +	ret = reset_deassert_bulk(qmp->resets);
> +	if (ret) {
> +		dev_err(qmp->dev, "reset deassert failed\n");
> +		goto err_disable_regulators;
> +	}
> +
> +	udelay(200);
> +
> +	ret = clk_enable_bulk(&qmp->clks);
> +	if (ret)
> +		goto err_assert_reset;
> +
> +	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
> +
> +	return 0;
> +
> +err_assert_reset:
> +	reset_deassert_bulk(qmp->resets);
> +err_disable_regulators:
> +
> +	return ret;
> +}
> +
> +static int qmp_usb_exit(struct phy *phy)
> +{
> +	struct qmp_usb *qmp = dev_get_priv(phy->dev);
> +
> +	reset_assert_bulk(qmp->resets);
> +
> +	clk_disable_bulk(&qmp->clks);
> +
> +	return 0;
> +}
> +
> +static int qmp_usb_power_on(struct phy *phy)
> +{
> +	struct qmp_usb *qmp = dev_get_priv(phy->dev);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *tx = qmp->tx;
> +	void __iomem *rx = qmp->rx;
> +	void __iomem *pcs = qmp->pcs;
> +	void __iomem *pcs_usb = qmp->pcs_usb;
> +	void __iomem *status;
> +	unsigned int val;
> +	int ret;
> +
> +	qmp_usb_serdes_init(qmp);
> +
> +	ret = clk_prepare_enable(qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Tx, Rx, and PCS configurations */
> +	qmp_configure_lane(qmp->dev, tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
> +	qmp_configure_lane(qmp->dev, rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
> +
> +	qmp_configure(qmp->dev, pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> +
> +	if (pcs_usb)
> +		qmp_configure(qmp->dev, pcs_usb, cfg->pcs_usb_tbl, cfg->pcs_usb_tbl_num);
> +
> +	if (cfg->has_pwrdn_delay)
> +		udelay(20);
> +
> +	/* Pull PHY out of reset state */
> +	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +
> +	/* start SerDes and Phy-Coding-Sublayer */
> +	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
> +
> +	status = pcs + cfg->regs[QPHY_PCS_STATUS];
> +	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
> +				 PHY_INIT_COMPLETE_TIMEOUT);
> +	if (ret) {
> +		dev_err(qmp->dev, "phy initialization timed-out\n");
> +		goto err_disable_pipe_clk;
> +	}
> +
> +	return 0;
> +
> +err_disable_pipe_clk:
> +	clk_disable_unprepare(qmp->pipe_clk);
> +
> +	return ret;
> +}
> +
> +static int qmp_usb_power_off(struct phy *phy)
> +{
> +	struct qmp_usb *qmp = dev_get_priv(phy->dev);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +
> +	clk_disable_unprepare(qmp->pipe_clk);
> +
> +	/* PHY reset */
> +	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +
> +	/* stop SerDes and Phy-Coding-Sublayer */
> +	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL],
> +		     SERDES_START | PCS_START);
> +
> +	/* Put PHY into POWER DOWN state: active low */
> +	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +		     SW_PWRDN);
> +
> +	return 0;
> +}
> +
> +static int qmp_usb_enable(struct phy *phy)
> +{
> +	int ret;
> +
> +	ret = qmp_usb_init(phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = qmp_usb_power_on(phy);
> +	if (ret)
> +		qmp_usb_exit(phy);
> +
> +	return ret;
> +}
> +
> +static int qmp_usb_disable(struct phy *phy)
> +{
> +	int ret;
> +
> +	ret = qmp_usb_power_off(phy);
> +	if (ret)
> +		return ret;
> +	return qmp_usb_exit(phy);
> +}
> +
> +static int qmp_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct qmp_usb *qmp = dev_get_priv(phy->dev);
> +
> +	qmp->mode = mode;
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops qmp_usb_phy_ops = {
> +	.init		= qmp_usb_enable,
> +	.exit		= qmp_usb_disable,
> +	.set_mode	= qmp_usb_set_mode,
> +};
> +
> +static void qmp_usb_enable_autonomous_mode(struct qmp_usb *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
> +	void __iomem *pcs_misc = qmp->pcs_misc;
> +	u32 intr_mask;
> +
> +	if (qmp->mode == PHY_MODE_USB_HOST_SS ||
> +	    qmp->mode == PHY_MODE_USB_DEVICE_SS)
> +		intr_mask = ARCVR_DTCT_EN | ALFPS_DTCT_EN;
> +	else
> +		intr_mask = ARCVR_DTCT_EN | ARCVR_DTCT_EVENT_SEL;
> +
> +	/* Clear any pending interrupts status */
> +	qphy_setbits(pcs_usb, cfg->regs[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR], IRQ_CLEAR);
> +	/* Writing 1 followed by 0 clears the interrupt */
> +	qphy_clrbits(pcs_usb, cfg->regs[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR], IRQ_CLEAR);
> +
> +	qphy_clrbits(pcs_usb, cfg->regs[QPHY_PCS_AUTONOMOUS_MODE_CTRL],
> +		     ARCVR_DTCT_EN | ALFPS_DTCT_EN | ARCVR_DTCT_EVENT_SEL);
> +
> +	/* Enable required PHY autonomous mode interrupts */
> +	qphy_setbits(pcs_usb, cfg->regs[QPHY_PCS_AUTONOMOUS_MODE_CTRL], intr_mask);
> +
> +	/* Enable i/o clamp_n for autonomous mode */
> +	if (pcs_misc && cfg->regs[QPHY_PCS_MISC_CLAMP_ENABLE])
> +		qphy_clrbits(pcs_misc, cfg->regs[QPHY_PCS_MISC_CLAMP_ENABLE], CLAMP_EN);
> +}
> +
> +static void qmp_usb_disable_autonomous_mode(struct qmp_usb *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
> +	void __iomem *pcs_misc = qmp->pcs_misc;
> +
> +	/* Disable i/o clamp_n on resume for normal mode */
> +	if (pcs_misc && cfg->regs[QPHY_PCS_MISC_CLAMP_ENABLE])
> +		qphy_setbits(pcs_misc, cfg->regs[QPHY_PCS_MISC_CLAMP_ENABLE], CLAMP_EN);
> +
> +	qphy_clrbits(pcs_usb, cfg->regs[QPHY_PCS_AUTONOMOUS_MODE_CTRL],
> +		     ARCVR_DTCT_EN | ARCVR_DTCT_EVENT_SEL | ALFPS_DTCT_EN);
> +
> +	qphy_setbits(pcs_usb, cfg->regs[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR], IRQ_CLEAR);
> +	/* Writing 1 followed by 0 clears the interrupt */
> +	qphy_clrbits(pcs_usb, cfg->regs[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR], IRQ_CLEAR);
> +}
> +
> +static int qmp_usb_reset_init(struct qmp_usb *qmp,
> +			      const char *const *reset_list,
> +			      int num_resets)
> +{
> +	struct udevice *dev = qmp->dev;
> +	int ret;
> +
> +	qmp->num_resets = num_resets;
> +
> +	qmp->resets = devm_reset_bulk_get_optional(dev);
> +	if (IS_ERR_OR_NULL(qmp->resets)) {
> +		ret = PTR_ERR(qmp->resets);
> +		dev_err(dev, "failed to get resets %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qmp_usb_clk_init(struct qmp_usb *qmp)
> +{
> +	struct udevice *dev = qmp->dev;
> +	int ret;
> +
> +	ret = clk_get_bulk(dev, &qmp->clks);
> +
> +	if (!ret)
> +		qmp->num_clks = qmp->clks.count;
> +
> +	return ret;
> +}
> +
> +static int qmp_usb_parse_dt(struct qmp_usb *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	const struct qmp_usb_offsets *offs = cfg->offsets;
> +	struct udevice *dev = qmp->dev;
> +	void __iomem *base;
> +	int ret;
> +
> +	if (!offs)
> +		return -EINVAL;
> +
> +	base = (void __iomem *)dev_read_addr(dev);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	qmp->serdes = base + offs->serdes;
> +	qmp->pcs = base + offs->pcs;
> +	if (offs->pcs_usb)
> +		qmp->pcs_usb = base + offs->pcs_usb;
> +	if (offs->pcs_misc)
> +		qmp->pcs_misc = base + offs->pcs_misc;
> +	qmp->tx = base + offs->tx;
> +	qmp->rx = base + offs->rx;
> +
> +	ret = qmp_usb_clk_init(qmp);
> +	if (ret)
> +		return ret;
> +
> +	qmp->pipe_clk = devm_clk_get(dev, "pipe");
> +	if (IS_ERR(qmp->pipe_clk)) {
> +		dev_err(dev, "failed to get pipe clock (%ld)\n",
> +			PTR_ERR(qmp->pipe_clk));
> +		return ret;
> +	}
> +
> +	ret = qmp_usb_reset_init(qmp, usb3phy_reset_l,
> +				 ARRAY_SIZE(usb3phy_reset_l));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int qmp_usb_probe(struct udevice *dev)
> +{
> +	struct qmp_usb *qmp = dev_get_priv(dev);
> +	int ret;
> +
> +	qmp->dev = dev;
> +	dev_set_drvdata(dev, qmp);
> +
> +	qmp->cfg = (struct qmp_phy_cfg *)dev_get_driver_data(dev);
> +	if (!qmp->cfg)
> +		return -EINVAL;
> +
> +	ret = qmp_usb_parse_dt(qmp);
> +
> +	if (ret)
> +		goto err_node_put;
> +
> +err_node_put:
> +	return ret;
> +}
> +
> +static const struct udevice_id qmp_usb_phy_ids[] = {
> +	{
> +		.compatible = "qcom,ipq5424-qmp-usb3-phy",
> +		.data = (ulong)&ipq9574_usb3phy_cfg,
> +	}, {
> +		.compatible = "qcom,ipq6018-qmp-usb3-phy",
> +		.data = (ulong)&ipq6018_usb3phy_cfg,
> +	}, {
> +		.compatible = "qcom,ipq8074-qmp-usb3-phy",
> +		.data = (ulong)&ipq8074_usb3phy_cfg,

> +	}, {
> +		.compatible = "qcom,ipq9574-qmp-usb3-phy",
> +		.data = (ulong)&ipq9574_usb3phy_cfg,

This series only you say that you have tested on ipq9574 boards, so why
you have imported untested support for all other SoCs? Do you confirm if
all the clocks and other dependencies are present for other SoCs for
this driver to work?

-Sumit

> +	}, {
> +		.compatible = "qcom,msm8996-qmp-usb3-phy",
> +		.data = (ulong)&msm8996_usb3phy_cfg,
> +	}, {
> +		.compatible = "qcom,qcs8300-qmp-usb3-uni-phy",
> +		.data = (ulong)&qcs8300_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,qdu1000-qmp-usb3-uni-phy",
> +		.data = (ulong)&qdu1000_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sa8775p-qmp-usb3-uni-phy",
> +		.data = (ulong)&sa8775p_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sc8180x-qmp-usb3-uni-phy",
> +		.data = (ulong)&sm8150_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
> +		.data = (ulong)&sc8280xp_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
> +		.data = (ulong)&qmp_v3_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
> +		.data = (ulong)&sdx55_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
> +		.data = (ulong)&sdx65_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sdx75-qmp-usb3-uni-phy",
> +		.data = (ulong)&sdx75_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8150-qmp-usb3-uni-phy",
> +		.data = (ulong)&sm8150_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
> +		.data = (ulong)&sm8250_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8350-qmp-usb3-uni-phy",
> +		.data = (ulong)&sm8350_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,x1e80100-qmp-usb3-uni-phy",
> +		.data = (ulong)&x1e80100_usb3_uniphy_cfg,
> +	},
> +	{ },
> +};
> +
> +U_BOOT_DRIVER(qmp_usb_phy) = {
> +	.name		= "qcom-qmp-usb-phy",
> +	.id		= UCLASS_PHY,
> +	.of_match	= qmp_usb_phy_ids,
> +	.ops		= &qmp_usb_phy_ops,
> +	.probe		= qmp_usb_probe,
> +	.priv_auto	= sizeof(struct qmp_usb),
> +};
> diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
> index 99f4d447caf..f9c9a4714fc 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp.h
> +++ b/drivers/phy/qcom/phy-qcom-qmp.h
> @@ -112,4 +112,19 @@
>  #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
>  #define QSERDES_V6_DP_PHY_STATUS			0x0e4
>  
> +/* QPHY_PCS_STATUS bit */
> +#define PHYSTATUS				BIT(6)
> +#define PHYSTATUS_4_20				BIT(7)
> +
> +/* QPHY_PCS_AUTONOMOUS_MODE_CTRL register bits */
> +#define ARCVR_DTCT_EN				BIT(0)
> +#define ALFPS_DTCT_EN				BIT(1)
> +#define ARCVR_DTCT_EVENT_SEL			BIT(4)
> +
> +/* QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR register bits */
> +#define IRQ_CLEAR				BIT(0)
> +
> +/* QPHY_PCS_MISC_CLAMP_ENABLE register bits */
> +#define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
> +
>  #endif
> -- 
> 2.34.1
> 
