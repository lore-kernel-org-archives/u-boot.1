Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A591FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB70846D5;
	Wed, 29 Apr 2026 00:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qGXveXwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4480E8469A; Tue, 28 Apr 2026 21:00:18 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2391084698
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 21:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4303eb92930so1879314fac.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777402805; x=1778007605;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajfFDTo/ard7eUnJJqDy1rOYVdBe5jB5N8PtsNEfxbs=;
 b=qGXveXwXfi5GTxo4yMLJ7JMOb5V31k2jnNN1U/6yCVGhBhI3aaC2rITrQwSLKco1u8
 l7yo7eTlRFN/Tagau752DjbBootyiMX7LxnOGm5ElF7OKpPcSY8+iqr2ToWa7nI7QMJH
 CNgZPqkOrN2cRaKK654DjNKAWWeys9h+WF/O79mk98+KfFX0J60ZjfAMret9vbVvMHdh
 LxvraMdri5dlqLafiIfxvzXG/j+OBeJI0i1CTXOK1Byz9ebZ9NhhpErnJFvl1zce93pe
 vumouBTl8ejXGTaB/kE95eQIPmOlZlTzkKeUFEbMeRdLlJYV4mT1YoFzz8ZWQLOtTsaZ
 lvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777402805; x=1778007605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ajfFDTo/ard7eUnJJqDy1rOYVdBe5jB5N8PtsNEfxbs=;
 b=MkqOO0kbrmDK4RnkMLnYSWm3HKxBTCXCLNhL0j3QPOgEu4Z5yhWGlAeXDiGx8z+ZCF
 IVmRCYsK2nMrRoyM/qqcAJSB+NmD1iVvIPtQRHsADP6R6apO35Lk3e5H+wAqVDqIvxqC
 OGFha/FCv58mdrXIvuOAk1fgNwulPNRVkFINwce5pNQpaNl71Jo0Z+MoubGXKAz1iJxV
 1u4/o2JxDlzusRpn4kLZ6ssSyNtUsWAk+66GptH8IKBF6/+NEBj/n7001sK5iDdsCuPK
 KROFs4enn1qyBqxOtCLQXpFr6HDXFtwbpgndh3J5cWQCLoYU177CbAZROG/s5guEyL+Q
 xueA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Lbz3zqNqKvEay5cD6dja0NUUKg13yxHKIA4HDlGDCnNbIsWxGMndAz2jc/RBtTOAOkXFa7SA=@lists.denx.de
X-Gm-Message-State: AOJu0YwMBCFkEmMOxI6lphd50afaqgWiilsce+tna2NFdDW5+pLmCYJY
 4eyb+hHCRUwdAprB8cF1o8c7VuaDUFckDsEnnrhzj/FVfvy6j56W/GU3Ji9w7Wn3Lt0=
X-Gm-Gg: AeBDieu5/Y+oPlgICBckVSRY3ah5l2srgMkvkDio1zBrcsbthmDUUHlZSFWqgZivbnO
 BOhQCLDKyLb63v3K0ydtU/2xR6lDfTDpWZ/oNNEfc0hjQPThnMSM4VnXaP5mtrM7271FP7v7fxl
 oqTJfWcEinFV37ZqnvBKpmspuQ3bJ49QVY4SGziQGEQCrFkmHKQTNdJ7RSbM2++jtJDflrXloqV
 xsMr5k/w1viT359lxHRg28ImBL5H0Zx10QyQnUmGfEox/dIjDc+Ya4wZ2v/XOOPCc064jn4k9mq
 8c/5g9yOif58h0Qj2f3ghMbTcMgmwJXAoWokWTvLYjNQhEqJ4+DyYnkB3yoQp5sMjpg9QIGdQ1M
 12BLVdPpe+et8HmZLGnYAlffNTE9889Zv3AdN5SuMQeX/6G0Pc5+Spcg60PFKZuNNomXmntOj3P
 v0lUBr3D1LdfIU1kw1FRbkDQKKNaF/mfAw4abici3sJc3u0cxtv6b5uB1ieMRpcQqHY4tSrjeG6
 7XQwzL5mm8HtSuSpXoZJQg=
X-Received: by 2002:a05:6870:c03:b0:422:e938:6b49 with SMTP id
 586e51a60fabf-433f3b8d5f8mr2509926fac.38.1777402805444; 
 Tue, 28 Apr 2026 12:00:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:efba:bc47:a81b:dd0f?
 ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340d841467sm93954fac.16.2026.04.28.12.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 12:00:05 -0700 (PDT)
Message-ID: <ade67190-4a3b-4a86-92e5-5f4a4376db2c@baylibre.com>
Date: Tue, 28 Apr 2026 14:00:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] net: dwc_eth_qos: Add mediatek support
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
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
 <20260428-add-ethernet-support-for-genio-520-720-v2-7-9cf2f0884bd8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-7-9cf2f0884bd8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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

On 4/28/26 8:17 AM, Julien Stephan wrote:
> Synopsys DWC Ethernet QOS device support for MediaTek SoCs.
> in particular this initial commit adds support for Genio 520/720 and
> Genio 510/700 EVKs
> 
> Signed-off-by: fanyi zhang <fanyi.zhang@mediatek.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

...

> +static int mtk_config_dt(struct udevice *dev)
> +{	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
> +	struct ofnode_phandle_args args;
> +	u32 tx_delay_ps, rx_delay_ps;
> +	int ret;
> +
> +	if (!dev_read_u32(dev, "mediatek,tx-delay-ps", &tx_delay_ps)) {
> +		if (tx_delay_ps > DELAY_MAX_PS) {
> +			pr_err("%s: dev=%p Invalid TX clock delay: %dps\n",
> +			       __func__, dev, tx_delay_ps);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!dev_read_u32(dev, "mediatek,rx-delay-ps", &rx_delay_ps)) {
> +		if (rx_delay_ps > DELAY_MAX_PS) {
> +			pr_err("%s: dev=%p Invalid RX clock delay: %dps\n",
> +			       __func__, dev, rx_delay_ps);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	mtk_pdata->tx_delay_stage = tx_delay_ps / DELAY_PS_PER_STAGE;
> +	mtk_pdata->rx_delay_stage = rx_delay_ps / DELAY_PS_PER_STAGE;

Possible uninitialized use of tx_delay_ps and rx_delay_ps.

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

This error message is a bit misleading. The actual problem is that
syscon_node_to_regmap() failed.

> +		return -EINVAL;

Why not return PTR_ERR(mtk_pdata->peri_regmap)?

> +	}
> +
> +	return 0;
> +}
> +
> +static int eqos_probe_resources_mtk(struct udevice *dev)
> +{
> +	struct eqos_priv *eqos = dev_get_priv(dev);
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eqos_mtk_priv *mtk_pdata;
> +	int ret;
> +
> +	debug("%s(dev=%p):\n", __func__, dev);
> +
> +	ret = eqos_get_base_addr_dt(dev);
> +	if (ret) {
> +		dev_err(dev, "eqos_get_base_addr_dt failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mtk_pdata = calloc(1, sizeof(struct eqos_mtk_priv));
> +	if (!mtk_pdata)
> +		return -ENOMEM;
> +
> +	pdata->priv_pdata = mtk_pdata;
> +
> +	ret = mtk_config_dt(dev);
> +	if (ret) {
> +		dev_err(dev, "mtk config dt failed: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = mtk_clk_init(dev);
> +	if (ret)
> +		goto err;
> +
> +	pdata->phy_interface = eqos->config->interface(dev);
> +	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
> +		dev_err(dev, "Invalid PHY interface\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = mtk_set_interface(dev);
> +	if (ret)
> +		goto err;
> +
> +	ret = mtk_set_delay(dev);
> +	if (ret)
> +		goto err;
> +
> +	debug("%s: OK\n", __func__);

FWIW, log_msg_ret() is good for debugging return values.

> +	return 0;
> +err:
> +	free(mtk_pdata);
> +	return ret;
> +}
> +
