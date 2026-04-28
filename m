Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76081FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7AC846DC;
	Wed, 29 Apr 2026 00:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KcIsjDWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313768465A; Tue, 28 Apr 2026 21:30:27 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4470B8464E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 21:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4be94eeacso12127672a34.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777404622; x=1778009422;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=onRYY76VstwkCVcdHmgsVkUTTDr+Km21NhP5JD3LXxw=;
 b=KcIsjDWOpIjOjCDpS0fuSns3bxcvtw5UUoJxQDI06vxGKwlgLzT9iWCjM88fjQdiFB
 9DedHSoj9UUeCydfKyGpgEUciyJM2JQxQ6qxbRX9OZO+72kZn56pQfWrs9lljyYivxT2
 idHMjCxq5l+D5mvUQuMAuj0JqvwvmsmwH9wTkVia9B4dkmov2Mf8zfrExJ8CTXczP4sR
 xi7q6ldq4DagCifUyXlOqNBDbwBzRPnndYk/+1LnCruU98ssRvMbnuMHxNymqZaQJTQW
 FbvvrQGqYOM7yrKccLOxCiQTtC2ywb5UPurtz329nJQUrEYwYhwJpkSwtMM3NhaxN7NC
 BpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777404622; x=1778009422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=onRYY76VstwkCVcdHmgsVkUTTDr+Km21NhP5JD3LXxw=;
 b=Fz9MX6Uy9Np+JRwqfDhi+IxhzKPWLn2tfbRprgJRkroTI33lC6k/vpne1FeoZkwPLY
 Ako85+oZ/abyhENEfzAfPuT0ZFn3yQWQ8Z26bX9vfifm8g+GL+tUfukxksaNtFyQODrE
 RQ/OUtPgmgt23+/FaqB4mzlP9sX02SStGu+sL0Fywf9AQFueTuSZnPLeogbjlowfcO4S
 tz3Pt3JCwZgn1aRkpZvHCc27cNAaZVYpMgFXBKtDMshNz6flJ1hVAeqmdHYegfIBxCdW
 +g9SNbkXrCDQe6z2wu7Xd+IGg3j9WQwD2SQhUfJqQaE52My2Agbb+dIQ0IL3a4oDdvls
 OUVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IGLGtyvPMGencrBNuHQFRbEehl7Mg71eM4AcXH+sHzfFMod3gabz8Qt86jyyTh6z6gOFKzBc=@lists.denx.de
X-Gm-Message-State: AOJu0YzIPPZLU3Ab7T2xm8I9t1GJl8dHiunqqMNdmhFSfa3ELv33PXJ/
 zgb4URr5sVugAcduS/4kXHpjlS0SAcLenFDwSXgtaoNQOmrfxG2pojMqZyTD2IgucPA=
X-Gm-Gg: AeBDiesblN1vj6HdSSNe4EwvonNY1ibIdJdAPtiVIG6G9jK9IsFJl/Wge3XZIVYfDEy
 SMQn3BNwbgAqAqB+1wB1n7QN324VxcgiZbX9EFl+o0wUFm0g471EcxBRSLoaRO7J8NpJGFMhc2y
 lk3Ba/PPVsPqkrXRdqnT+Y7PAkNih+tfsoFtvJbsCTHLdRsOJUhzfJFhXJbzmsK1OIl3zBfP4Dp
 9KRhmEBWw5XBRxuJD1HYdPfk7FSDTWAZ36gWShyXuLnKyWEUYvNrXICFeJ7DhFfdrq9noH16id0
 m9RaMySgGf76VLdjIwjiYytvvD8fTQycx6hwb4WUGdQwZrYCHquv33YmjpxcRrAxe9r69MbsYw0
 55jhE0tWHbeYWyH4Dvyb6jXmnkCLuehaSRd0pbK2ii7s6dyXXaDuCirb7BfkoJF/FYK3VJmKSSb
 ITTSwLnL628a4t18FFaO62ppUenAEmMpB7jkbCmwtAcvXkNh/1b/mzlmN8tYGaLqq2BmJ6UmRJ4
 KXF9cXQKT47
X-Received: by 2002:a05:6830:6aad:b0:7cf:da97:57d6 with SMTP id
 46e09a7af769-7dea64f0c55mr610266a34.6.1777404621594; 
 Tue, 28 Apr 2026 12:30:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de986a5601sm2328150a34.19.2026.04.28.12.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 12:30:21 -0700 (PDT)
Message-ID: <38365eb6-00e3-4cfd-88f3-edb4f36fc420@baylibre.com>
Date: Tue, 28 Apr 2026 14:30:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] net: phy: Add airoha AN8801 ethernet phy driver
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
 <20260428-add-ethernet-support-for-genio-520-720-v2-6-9cf2f0884bd8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-6-9cf2f0884bd8@baylibre.com>
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
> Add Airoha AN8801 Ethernet PHY driver (air_an8801.c).
> Implement CL22/CL45 MDIO access, LED control, and RGMII delay
> configuration. Provide probe, initialization, LED setup, and status
> handling. Expose DTS properties for clock delays. Register driver with
> PHY framework and trigger on startup.
> 

...

> +struct air_led_cfg {
> +	u16 en;		/* LED Enable */
> +	u16 gpio;	/* GPIO */
> +	u16 pol;	/* LED Polarity */
> +	u16 on_cfg;	/* LED On */
> +	u16 blk_cfg;	/* LED Blink */
> +};
> +

nit: make the variable names longer so that we don't need
comments to explain them

> +static int an8801r_rgmii_delay_config(struct phy_device *phydev)
> +{
> +	struct an8801r_priv *priv = phydev_cfg(phydev);
> +	int ret;
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		return an8801r_rgmii_txdelay(phydev, AIR_RGMII_DELAY_STEP_4);
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		return an8801r_rgmii_rxdelay(phydev, AIR_RGMII_DELAY_NOSTEP, true);
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		ret = an8801r_rgmii_txdelay(phydev, AIR_RGMII_DELAY_STEP_4);
> +		if (ret)
> +			return ret;
> +		return an8801r_rgmii_rxdelay(phydev, AIR_RGMII_DELAY_NOSTEP, true);
> +	case PHY_INTERFACE_MODE_RGMII:
> +	default:
> +		if (priv->rxdelay_force) {
> +			ret = an8801r_rgmii_rxdelay(phydev, priv->rxdelay_step,
> +						    priv->rxdelay_align);
> +			if (ret)
> +				return ret;
> +		}
> +		if (priv->txdelay_force)
> +			return an8801r_rgmii_txdelay(phydev, priv->txdelay_step);
> +		break;

nit: Could just return 0; here.

> +	}
> +	return 0;
> +}
> +

...

> +static int an8801r_phy_probe(struct phy_device *phydev)
> +{
> +	struct an8801r_priv *priv;
> +	u32 phy_id;
> +	int ret;
> +
> +	ret = get_phy_id(phydev->bus, phydev->addr, MDIO_DEVAD_NONE, &phy_id);
> +	if (ret)
> +		return ret;
> +
> +	if (phy_id != AN8801R_PHY_ID) {
> +		dev_err(phydev->dev,
> +			"AN8801R can't be detected (id=0x%08x).\n", phy_id);
> +		return -ENODEV;
> +	}
> +
> +	priv = calloc(1, sizeof(struct an8801r_priv));

Why calloc() for 1 item?

I think usual would be:

	priv = malloc(sizeof(*priv));

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	*priv = an8801r_priv_defaults;
> +
> +	phydev->priv = priv;
> +
> +	return 0;
> +}
> +

