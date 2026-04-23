Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764C9FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4303684552;
	Sat, 25 Apr 2026 20:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="xRSRYHbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874F5843FB; Sat, 25 Apr 2026 19:47:11 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF9B8435B
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d1872504cbso7608548a34.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777139227; x=1777744027;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RRVfAAn2++xzTHEepAqp1w58FLGaSSNsVGGyMUWBjO0=;
 b=xRSRYHbFHTpFZlzl+7Dbn9x4kN74abE71FJ4ZI9B3x9HVVtWddQS+HRphAx909ubnO
 iJ3sqHQnCCdlvijvfxh/DKp/hgu51DVTXIFA8e/LcTQCMJpaHAx5X7i8mmAWTzOJKhrO
 1zBpNm25wc8uzrjhuLDZlLfzN3q5v9cLgP2V+vt730NiCeWfG5OHSxlJfgHr4Yu7HRYX
 +tujIrPoTg765bH/n90djhiRI5SKRGk0QSNd3e/l7isOYLMpFjMZPdeAZzDeRqd09/gw
 OxvoCg7rtR4mxUkEiP2Zj0K1meSMHa/3sTu7+zdr3w+//aa9zMmPirLcHJy7eULBTZp4
 DGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139227; x=1777744027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRVfAAn2++xzTHEepAqp1w58FLGaSSNsVGGyMUWBjO0=;
 b=jeJaJmrtAt/tuuxw/7zmKF3SRjAmpKlEb24IY/E5pIdBwLbI+c/Qtz0QrQXI4N9pi8
 i1zmEn8Qcr00J2cXNd41ISiMQ7iQxXjDduAJ3Nt/KGl5tCkhFG+gOn6mRiSLFCzzSVD2
 2mO872NrRB6zcYcTfZsBdvxowyx4wJA9cyJmLb6BLhl59qX/SdeYT3yBGlcz6HPVhiY0
 d+J7RZder//zQ/BLEG5ze8JeaJQa0w1cM98EzvKoLv2molqLSQfPsbBgXZEQ3gBOPqZ3
 NDCvpTuX5D1Bq0HUtIyjK9yDvZWz8Ab1EXXMkW4DaEncaGi7ntqfxWr025POgowqLlTL
 OPAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q0BV9vPGHnQPax+CK4xUmVKLfwwZHNuUwEfe7RPN+vRkWeAIz8ElNf5dNrkIPUfD/BFoNzs4=@lists.denx.de
X-Gm-Message-State: AOJu0YyRyquE7MOTuqgMWbGTo/xy+tXqARkTkzAEpC2fLep7m9i6imgD
 JltG2ekZKoDuPWGQzRiEnLRhgt4y8DqtnmbzBWJtQ8lyaLzJ+4f/AjCn1U4jo8b2QWpWS41172v
 JcXyX
X-Gm-Gg: AeBDieuHNcjYkSrXtJfvDUM5SU2Wu6b4C6NQo5X2eNQPC6TJ1T8vFBuTW5v1ws3+KNw
 0S+43NUW+alm+EgPnK3nUfwIK0u2hURlEBjFi1/zXv9DQ8ttPhQvVb8C4BvRgxXlTJQtAWfj7kK
 XXDj34IwocLdCLQZ0S38Q4k47DfC+LNPBzcjihKh7VF0dIax7jktizSzurelcCZuSKDfEC7SuM4
 ayaYAQXKfR7L8Pk+F/PBGUxNEppDDxGhRFMHv8U8+TksOgQ/mKch593bR+6ixadpeCu6kRbYs2B
 tuQuGLCrYeDTXgWXyhdxOAz1KvM0L2UNOTQoDf8DcCtJnLQhwXDFMbB/ryf6fzKPrqUynVyl49S
 SDk6iuaRnu4xDEyH4KHKO8Q6ZE+I/corJzF4pUdca+9wrqRz+SxgZ2IKXBGOCBVDH9r3O2TTtlk
 4NCs/3iuFp9sIPOFEHPPW5V7cl1/eR/4YCnZMaictBlZ0jzgQjFpmRGW9jGcKr7Hs9nG1JXTc9R
 gbH42uu1okj
X-Received: by 2002:a05:6820:2e90:b0:694:98e5:2800 with SMTP id
 006d021491bc7-69498e53d21mr4212112eaf.23.1776958067624; 
 Thu, 23 Apr 2026 08:27:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3cc7:689f:be44:d58a?
 ([2600:8803:e7e4:500:3cc7:689f:be44:d58a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42ff2b6b2cdsm1076139fac.1.2026.04.23.08.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 08:27:47 -0700 (PDT)
Message-ID: <dc4bf83d-97d4-4076-8b73-29fcb9c0dc08@baylibre.com>
Date: Thu, 23 Apr 2026 10:27:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] net: dwc_eth_qos: Add mediatek support
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>
References: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
 <20260423-add-ethernet-support-for-genio-520-720-v1-7-47ca918e0017@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260423-add-ethernet-support-for-genio-520-720-v1-7-47ca918e0017@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

On 4/23/26 8:25 AM, Julien Stephan wrote:
> Synopsys DWC Ethernet QOS device support for MediaTek SoCs.
> in particular this initial commit adds support for Genio 520/720 and
> Genio 510/700 EVKs
> 

...

> +#define RX_DELAY_MAX_PS			9800
> +#define TX_DELAY_MAX_PS			9800

Do we need two macros for the same value? Or can be DELAY_MAX_PS?

> +
> +#define OUT_OP				true
> +

...

> +static int mtk_set_interface(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
> +	int rmii_clk_from_mac = mtk_pdata->rmii_clk_from_mac ? EQOS_MTK_RMII_CLK_SRC_INTERNAL : 0;
> +	int rmii_rxc = mtk_pdata->rmii_rxc ? EQOS_MTK_RMII_CLK_SRC_RXC : 0;
> +	u32 intf_val = 0;
> +
> +	/* select phy interface in top control domain */
> +	switch (pdata->phy_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		intf_val |= FIELD_PREP(EQOS_MTK_ETH_INTF_SEL, EQOS_MTK_PHY_INTF_MII);
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		intf_val |= (rmii_rxc | rmii_clk_from_mac);
> +		intf_val |= FIELD_PREP(EQOS_MTK_ETH_INTF_SEL, EQOS_MTK_PHY_INTF_RMII);
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		intf_val |= FIELD_PREP(EQOS_MTK_ETH_INTF_SEL, EQOS_MTK_PHY_INTF_RGMII);
> +		break;
> +	default:
> +		pr_err("%s: dev=%p phy interface not supported\n", __func__, dev);
> +		return -EINVAL;
> +	}
> +
> +	/* only support external PHY */
> +	intf_val |= EQOS_MTK_EXT_PHY_MODE;
> +	if (OUT_OP)

OUT_OP is defined as true. Can we drop the macro and the condition?

> +		intf_val |= EQOS_MTK_TXC_OUT_OP;
> +
> +	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL0, intf_val);
> +
> +	return 0;
> +}
> +
> +static int mtk_config_dt(struct udevice *dev)
> +{	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
> +	struct ofnode_phandle_args args;
> +	u32 tx_delay_ps, rx_delay_ps;
> +	int ret;
> +
> +	if (!dev_read_u32(dev, "mediatek,tx-delay-ps", &tx_delay_ps)) {
> +		if (tx_delay_ps > TX_DELAY_MAX_PS) {
> +			pr_err("%s: dev=%p Invalid TX clock delay: %dps\n",
> +			       __func__, dev, tx_delay_ps);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!dev_read_u32(dev, "mediatek,rx-delay-ps", &rx_delay_ps)) {
> +		if (rx_delay_ps > RX_DELAY_MAX_PS) {
> +			pr_err("%s: dev=%p Invalid RX clock delay: %dps\n",
> +			       __func__, dev, rx_delay_ps);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* 290ps per stage */

Should we make a macro for that?

> +	mtk_pdata->tx_delay_ps_per_stage = tx_delay_ps / 290;
> +	mtk_pdata->rx_delay_ps_per_stage = rx_delay_ps / 290;

Doing demtional analysis, ps / (ps/stage) = stage.

So {tx,rx}_delay_ps_per_stage should just be stage units, not
ps_per_stage.

> +
> +	mtk_pdata->tx_inv = dev_read_bool(dev, "mediatek,txc-inverse");
> +	mtk_pdata->rx_inv = dev_read_bool(dev, "mediatek,rxc-inverse");
> +	mtk_pdata->rmii_clk_from_mac = dev_read_bool(dev, "mediatek,rmii-clk-from-mac");
> +	mtk_pdata->rmii_rxc = dev_read_bool(dev, "mediatek,rmii-rxc");
> +
> +	ret = dev_read_phandle_with_args(dev, "mediatek,pericfg", NULL, 0, 0, &args);
> +	if (ret) {
> +		pr_err("Failed to get mediatek,pericfg property: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mtk_pdata->peri_regmap = syscon_node_to_regmap(args.node);
> +	if (IS_ERR(mtk_pdata->peri_regmap)) {
> +		pr_err("%s: dev=%p Invalid perif_cfg reg\n", __func__, dev);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
