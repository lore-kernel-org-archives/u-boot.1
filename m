Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66635D10F57
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F6D8006D;
	Wed, 26 Nov 2025 15:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="af7e5asg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C928382A; Wed, 26 Nov 2025 15:46:22 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABB580050
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so59737505e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764168379; x=1764773179; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+5awAnasepR0a6L3l6tCKd+4RNdKxv5bYOnjmI5c/Wc=;
 b=af7e5asgvNJWoGVz/cwwyMYPdI7Tsi5b+tN00I8rqEBeMJrIpJVXb2gCanN7ubUBMk
 wYGzpGM0tlBxict17lknkv5nTIaU24Hx2frHocIm33bFtJyNzXV/cuhdaahns0nv5A0c
 Y3Z86MvDt+/QMGTlxfZWQYESKgFC5t3bTYk3YawLKK3e/nxdWmQjPxz+ls7/d1ME7V9+
 xbDOh+bhPXuAuHUvmibJHb/rDOGoGrHjWKqhozRbarbtisP8Y268LGygFYHExGyoANuU
 zOhH94/hJJf6G6/QsX4dKZer9Rz/zp/4ffIQw2Ah+6jq8IBzfGG7T9nr7h5xnKNTMxRb
 9rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764168379; x=1764773179;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5awAnasepR0a6L3l6tCKd+4RNdKxv5bYOnjmI5c/Wc=;
 b=ML+lNRI1ySV0T1KHS3wCnyfdGdTu4NTmD2ARYE7ciuH4iCOVreYTTTLSame1Yp7Hd1
 WePGujZtYzBl8y9iggYmmIQKogGhVCnarIxeZww0r6H3WGn2nPa4CIn7SULjkpjdhSNY
 ZNnVtgfRb+MuIlRy2R0PRqcwyOsc5tsxh7IcD4gLkbzsUY3CYFOFwSGtueec1td6nmgm
 FPrJpI2TAWmxEzH5O/+tNpHgb5WnmUJfr+atkel4Kg+XlMFp9EIGUxh2f90jWPWghOVp
 BiOCXDaSgNjzepEphPo2RQ6DdWsXLw3vAauh1rOiLpEGReuBg5vxn2HUhpYdsSaYOrKU
 1uHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSq6dME2B7S8koV3MyOJKpmWFf9+H2fnpZTQ1iqPo6zjjbLsq/gU7ICpO8GLrEMaU9iMjphq0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2rwyCz26WiayobGFOB7FC7Ozu/6PUd+xJn1wbDNQZUDM1CHn5
 efC+Utx3517spVqQ06Vr5jMbz6l7JIZKz0HGSH35m6GuGUri0R/H9RACRnycjRHuaKo=
X-Gm-Gg: ASbGnctidI3WExImOqMaPhDBUNcGPNikmO4MNvYj9ngTHrF+ZJEPYeJOTw8oQ+X8WJl
 SMPQ2c9kwqm8feqF8JwznrUpGMMlHXceJB5mpbnoFot/2oq9lX9dlnDtyjJEZ4C2jzg6ziJGpX1
 6qMjtNXLp22xY/1INdmlWdB8OvSygNLyiRnV1apA9vyAV5EEfsrTTzO4L3KZtAHUYw7e8TG79uv
 88jDQeuQvbQ2w7aqH5Q5EXwGjNEqE25+ymhzRdihC70BbvbzxK6EsnD07OSHfjUnCAA1YT1zSv4
 XU6kPm3Uh+nNm40vDBTWZuxy5/zlLvNp4DOLavJ5udsH6Wa2wD1rTjVF9yAkLirIw3efrp7ULpY
 CAMQcvLzccLg7UtDRiNMgR7+bo0xdvMdcEIqlk1Aq9xzJySA0CCvm+i/r0d+oTPeSsf76mkCntw
 JEWt7tEshWltrTJA/XFYL/tWIEQcP9uncaaYwVbMg5xtWgbBDF0StghRziEUgz+tw=
X-Google-Smtp-Source: AGHT+IEhugM7tNG6Dxl+9aHuLBQ3WTJvHW8dObb9499RJv1Z8Z+I0fHd5QHiPiZ1+H8Tc9ECU8xfMA==
X-Received: by 2002:a05:600c:4fce:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47904b2bff2mr64170585e9.35.1764168378819; 
 Wed, 26 Nov 2025 06:46:18 -0800 (PST)
Received: from [192.168.1.36] (p549d4195.dip0.t-ipconnect.de. [84.157.65.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add608bsm48528165e9.5.2025.11.26.06.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 06:46:18 -0800 (PST)
Message-ID: <838611bc-35e8-433c-afc0-c8ea203ad78e@linaro.org>
Date: Wed, 26 Nov 2025 15:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

In general this looks great! I'm very excited to have SuperSpeed up and
running in U-Boot at long last :D

I'll try and give this a spin soon on my boards.

On 24/11/2025 16:54, Balaji Selvanathan wrote:
> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
> SC7280 and QCM6490 platforms. This driver currently implements
> USB3 super-speed functionality of the combo PHY.
> 
> The QMP Combo PHY is a dual-mode PHY
> that can operate in either USB3 mode or DisplayPort mode. This
> initial implementation focuses on USB3 mode to enable Super-Speed
> USB support.
> 
> This is a port of the upstream Linux files to U-Boot:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

For future reference, the best format for this is something like:

Taken from Linux commit 3d25d46a255a ("pmdomain: qcom: rpmhpd: Add
rpmhpd support for SM8750")

You can get this with "git top --pretty="%h (\"%s\")" COMMIT_SHA", you
can stick an alias for this in your .gitconfig.

Few more comments below.

> 
> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v2:
> - Added pipe clock disable in qmp_combo_power_off sequence
> - Added all required clocks except pipe clock in qmp_combo_phy_clk_l
> - All clocks except pipe clock are enabled and disabled seperate from pipe clock
> - Added support for regulator power supplies
> - Added a minimal xlate to only return the USB3 phy
> ---
>  drivers/phy/qcom/Kconfig                   |   8 +
>  drivers/phy/qcom/Makefile                  |   1 +
>  drivers/phy/qcom/phy-qcom-qmp-combo.c      | 642 +++++++++++++++++++++
>  drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 ++
>  drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
>  drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
>  7 files changed, 782 insertions(+)
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h

[snip]

> diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> new file mode 100644
> index 00000000000..f5596aa5e50
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> @@ -0,0 +1,642 @@

[snip]

> +/* list of clocks required by phy */
> +static const char * const qmp_combo_phy_clk_l[] = {
> +	"aux", "com_aux",
> +};
> +
> +/* list of regulators */
> +static const char * const qmp_phy_vreg_l[] = {
> +	"vdda-phy",
> +	"vdda-pll",

On U-Boot it's necessary to use the full DT property name:
"vdda-phy-supply".

> +};


[..]

> +static int qmp_combo_power_off(struct phy *phy)
> +{
> +	struct qmp_combo *qmp = dev_get_priv(phy->dev);
> +	void __iomem *com = qmp->com;
> +
> +	clk_disable(qmp->pipe_clk);
> +
> +	/* PHY reset */
> +	qphy_setbits(qmp->pcs, QPHY_V4_PCS_SW_RESET, SW_RESET);
> +
> +	/* Stop SerDes and Phy-Coding-Sublayer */
> +	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_START_CONTROL,
> +		     SERDES_START | PCS_START);
> +
> +	/* Put PHY into POWER DOWN state: active low */
> +	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +
> +	/* Power down common block */
> +	qphy_clrbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);

Should we also turn off the regulators here?

> +
> +	return qmp_combo_com_exit(qmp);
> +}

[...]

> +static int qmp_combo_vreg_init(struct qmp_combo *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	struct udevice *dev = qmp->dev;
> +	int num = cfg->num_vregs;
> +	int i, ret;
> +
> +	if (!num)
> +		return 0;
> +
> +	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
> +	if (!qmp->vregs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; i++) {
> +		ret = device_get_supply_regulator(dev, cfg->vreg_list[i],
> +						  &qmp->vregs[i]);
> +		if (ret) {
> +			dev_dbg(dev, "regulator %s not found (optional)\n",
> +				cfg->vreg_list[i]);

Are these really optional?

> +			qmp->num_vregs = 0;
> +			return 0;
> +		}
> +	}
> +
> +	qmp->num_vregs = num;
> +	dev_dbg(dev, "found %d regulators\n", num);

Please drop this debug print.

Kind regards,

> +	return 0;
> +}
> +
> +static int qmp_combo_parse_dt(struct qmp_combo *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	const struct qmp_combo_offsets *offs = cfg->offsets;
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
> +	qmp->com = base + offs->com;
> +	qmp->serdes = base + offs->usb3_serdes;
> +	qmp->tx = base + offs->txa;
> +	qmp->rx = base + offs->rxa;
> +	qmp->tx2 = base + offs->txb;
> +	qmp->rx2 = base + offs->rxb;
> +	qmp->pcs = base + offs->usb3_pcs;
> +	qmp->pcs_usb = base + offs->usb3_pcs_usb;
> +	qmp->pcs_misc = base + offs->usb3_pcs_misc;
> +
> +	ret = qmp_combo_clk_init(qmp);
> +	if (ret)
> +		return ret;
> +
> +	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
> +	if (IS_ERR(qmp->pipe_clk)) {
> +		dev_err(dev, "failed to get pipe clock (%ld)\n",
> +			PTR_ERR(qmp->pipe_clk));
> +		return ret;
> +	}
> +
> +	ret = qmp_combo_reset_init(qmp);
> +	if (ret)
> +		return ret;
> +
> +	ret = qmp_combo_vreg_init(qmp);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int qmp_combo_probe(struct udevice *dev)
> +{
> +	struct qmp_combo *qmp = dev_get_priv(dev);
> +	int ret;
> +
> +	qmp->dev = dev;
> +	qmp->cfg = (const struct qmp_phy_cfg *)dev_get_driver_data(dev);
> +	if (!qmp->cfg) {
> +		printf("Failed to get PHY configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = qmp_combo_parse_dt(qmp);
> +
> +	return ret;
> +}
> +
> +static const struct qmp_phy_cfg sc7280_usb3dpphy_cfg = {
> +	.offsets		= &qmp_combo_offsets_v3,
> +	.serdes_tbl		= sm8150_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
> +	.tx_tbl			= sm8250_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_tx_tbl),
> +	.rx_tbl			= sm8250_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_rx_tbl),
> +	.pcs_tbl		= sm8250_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_pcs_tbl),
> +	.pcs_usb_tbl		= sm8250_usb3_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static int qmp_combo_xlate(struct phy *phy, struct ofnode_phandle_args *args)
> +{
> +	if (args->args_count != 1) {
> +		debug("Invalid args_count: %d\n", args->args_count);
> +		return -EINVAL;
> +	}
> +
> +	/* We only support the USB3 phy at slot 0 */
> +	if (args->args[0] == QMP_USB43DP_DP_PHY)
> +		return -EINVAL;
> +
> +	phy->id = QMP_USB43DP_USB3_PHY;
> +
> +	return 0;
> +}
> +
> +static struct phy_ops qmp_combo_ops = {
> +	.init = qmp_combo_power_on,
> +	.exit = qmp_combo_power_off,
> +	.of_xlate = qmp_combo_xlate,
> +};
> +
> +static const struct udevice_id qmp_combo_ids[] = {
> +	{
> +		.compatible = "qcom,sc7280-qmp-usb3-dp-phy",
> +		.data = (ulong)&sc7280_usb3dpphy_cfg,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qmp_combo) = {
> +	.name = "qcom-qmp-usb3-dp-phy",
> +	.id = UCLASS_PHY,
> +	.of_match = qmp_combo_ids,
> +	.ops = &qmp_combo_ops,
> +	.probe = qmp_combo_probe,
> +	.priv_auto = sizeof(struct qmp_combo),
> +};
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
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
> new file mode 100644
> index 00000000000..396179ef38b
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_DP_COM_V3_H_
> +#define QCOM_PHY_QMP_DP_COM_V3_H_
> +
> +/* Only for QMP V3 & V4 PHY - DP COM registers */
> +#define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
> +#define QPHY_V3_DP_COM_SW_RESET				0x04
> +#define QPHY_V3_DP_COM_POWER_DOWN_CTRL			0x08
> +#define QPHY_V3_DP_COM_SWI_CTRL				0x0c
> +#define QPHY_V3_DP_COM_TYPEC_CTRL			0x10
> +#define QPHY_V3_DP_COM_TYPEC_PWRDN_CTRL			0x14
> +#define QPHY_V3_DP_COM_RESET_OVRD_CTRL			0x1c
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
> diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
> index 99f4d447caf..06dac21ddc4 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp.h
> +++ b/drivers/phy/qcom/phy-qcom-qmp.h
> @@ -12,12 +12,17 @@
>  #include "phy-qcom-qmp-qserdes-com-v3.h"
>  #include "phy-qcom-qmp-qserdes-txrx-v3.h"
>  
> +#include "phy-qcom-qmp-qserdes-com-v4.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v4.h"
> +
>  #include "phy-qcom-qmp-qserdes-pll.h"
>  
>  #include "phy-qcom-qmp-pcs-v2.h"
>  
>  #include "phy-qcom-qmp-pcs-v3.h"
>  
> +#include "phy-qcom-qmp-pcs-v4.h"
> +
>  /* Only for QMP V3 & V4 PHY - DP COM registers */
>  #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
>  #define QPHY_V3_DP_COM_SW_RESET				0x04
> @@ -112,4 +117,16 @@
>  #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
>  #define QSERDES_V6_DP_PHY_STATUS			0x0e4
>  
> +/* QPHY_SW_RESET bit */
> +#define SW_RESET                                BIT(0)
> +/* QPHY_POWER_DOWN_CONTROL */
> +#define SW_PWRDN                                BIT(0)
> +
> +/* QPHY_START_CONTROL bits */
> +#define SERDES_START                            BIT(0)
> +#define PCS_START                               BIT(1)
> +
> +/* QPHY_PCS_STATUS bit */
> +#define PHYSTATUS                               BIT(6)
> +
>  #endif

-- 
// Casey (she/her)

