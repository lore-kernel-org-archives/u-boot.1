Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E0DC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 15:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0226580C84;
	Wed, 23 Sep 2026 15:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZljujfutNpZC; Wed, 23 Sep 2026 15:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 333A980C86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790178655;
	b=MaOSqjzzx6zZls5bYHpxTtcClaKSsfKDc8m28R4gOrDbh5/NUxH+jkRWqXidQVfD+sTk
	 JP3gjf7R1kGXvwDGx8H+/DUSgWEZdiJeBHHD1eSTpttIrDNCaeIA5+3/L/SjfW7Yhz5KC
	 CipNdyZaPlQC5AoAN5qE7PPYRUnqBzRlIvqa6+EP6RqXXpb6KYI5qmTQMKBp/LHR/tM49
	 JiJAmOsAe4aaPq7yODCqIsJotcTdT3M+3L5YGm92giOBW0FGTPneO3GY0kG7kZn5/3bmg
	 6n8386MrV5/CyMvpUdktJRQXM5X6GxbQottXcEANEdAbH8dd5jjA3gYM6Rsu5y1tJQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790178655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Po/BbMt/6hn5+A3LzmuQb+WUtNUj3BClkcma6xvVjaE=;
	b=KhLbzzUKawBI82LT/cKJfEjaDiPvHeo4S7g+wwuswWb4oOgAEZe0iq0pCeJ2OtUKtwnb
	 rq49R/TZVkIuK+UhiA+wGWTntYDJqsJ1c4BStcXNNRSe7DhkjkcWhLkE3ZnfaSC9vdLYd
	 z3dzoDdbZe6GKrvD0OSQXGjH/jxCtKql+iMdjX/YA93vqCHj7+X7C/SHtydZU3bI6ev6V
	 7PPSsjVBVIo4QMHlC+V4lYVocQ5VtmF0sWZJM3Y/zKtTd3bANuvG+pJ4yylaQSzWfZYgy
	 m8/XMM9F6jD4u0t8tj8rUCmPMnBs3iWVBlBM26boxPBaoXGFm6scf+UNOOOKZohVhIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790178655;
	bh=Po/BbMt/6hn5+A3LzmuQb+WUtNUj3BClkcma6xvVjaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzlnyfpQtxMmUOmiO1McF3FgXgPhp8+vvwHgnGnfKkZzMGFuMcs+YSL0gUcgPz15o
	 xCY2T2RzdmC3j9zdtuyV4mx7Q56kl1GyNcOs4UDr3h2yoOIP2vrqlW63whyzFQ3b8E
	 9dxvODUFCX60I6m/djPS4aCxTphqtrCGvw/aZqJpYrUKQXl2xFqKckMpicR+LA4bmT
	 fldb7/+l4RxkaBIppTJvjSNGTAHxzqmqpza+XGTkZYrE0B01BGhNRmgbpsioNVLBnq
	 XZ2FLcdtZgn4fJ3CkdtSDkDnP+NgUY0oYkB9ZNSayvhUxXp7PqoSMuW7zPepy8U05v
	 hXCxt0ecpw/IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 333A980C86;
	Wed, 23 Sep 2026 15:50:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 351033A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AFC74069D
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y73Qcu_VShrY for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E75AC40677
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178650;
 b=C5XIHxWYrVa1ohEZ3M4uklVwfLVkgxMMmkP2GmB8yxCpNedyUWwdOmgFJKNCTPoorENo
 BcrEg/5+5k8FhBJIlafDyQeZdf0xuG+V5n3QRkUyXfmKqloXpZf+hKoYh6QTO1ct6Gw0/
 jCRam2s1i4fe5rrxm7Cp70mOH7mHmkKwiabxis0mxfg9fS1O+oF6irfAOUI9zc3YkbAkh
 usfGnvN4OhVcz/HYUeQRdyR+dT03hceDzoPD2xfhl7GJkPI+oYLCWUVxpYpQyxiEt8ZSW
 yyKwGKntkFV9Gre+vkL+jMQSFvnkMv5cuIB+UU6eTUGF03hxfX2j+xskBYUUDz/t0nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178650;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=Po/BbMt/6hn5+A3LzmuQb+WUtNUj3BClkcma6xvVjaE=;
 b=L0QXkxu3s3FTrUHpPM4i16ezWIUD93+d5uc5DOPTH/dDDyB16aWwuaYgRmcwBVVfKZyF
 iheKBKYCRS/HOitUYQo2/Yg1vAr2gwGeReOsPGhUZJdprCwKAwKM82yacfEk1Uttd6q8T
 RLCp+LzYJfVIHLY8hkEE9pS06jvCUnejvCJ3Mg7kcN3ot/22KICOt0Yu60sd8fokqR3ID
 lYdVN/brv1EpuOyeyF+/S1En7Cc/Y7lgbG8g74pZ+13lBMb0qGsEV5hYNRaBFreP5rWUd
 yccjUZ8TvhQZEHjizl+35BYoUAxmceV6S4kp+697RgAagAbGW3iPy97W9cmCAnE2NDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FB3+Z4fe; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FB3+Z4fe
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E75AC40677
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:50:49 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8d47b5987so933416e87.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790178647; x=1790783447;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Po/BbMt/6hn5+A3LzmuQb+WUtNUj3BClkcma6xvVjaE=;
 b=FB3+Z4fe2ocakj8AV9+El5waX2k1OeMVJ3HsRgd4Tie93usLfO+dTjS8aYAgAi77fp
 UGhRqPGuYoejzObx5d+77opa89xG8ItoU8wpt632iv79oYQwK+IYtYaCMhiFdd7hrGsw
 5zXn2gvw31iEuhSysaOc/51x/opdfOqY/v9KLfkuTgW4SFaDLF6flNFhX8ZJ2ibmrZKM
 cxaqGwq2IB71MzMBdmeESfIrq0eICYhPBEl/maZpFvY/tjbIfiEYfZN1rWEt2ezDyVcG
 jMOwqLg6SHcLV43Gnf5Ouzjitb/cGz9Wg72NTuiZFzXVgNf5BHmhmFMZ8VKGViAos4FF
 UUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178647; x=1790783447;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Po/BbMt/6hn5+A3LzmuQb+WUtNUj3BClkcma6xvVjaE=;
 b=p9pcU7FrbedhnDBJdQv+6vQMRAxNYSz2yyiFRXjWtsq3zzzjtchFRIS1xbYtLwl/3Y
 tSdjgLBfmZm5aaVRo2dTIytiLK0PEb6JdOWyBx1lqQddB8vtv2SCmRyAK8seFq2VRhgv
 dBDo4PHubXFoGrr8wVesB417eOV/k4lF2hs6ngYeMr+FI6EjLgiKqFhnDUjh7kKlKkUc
 8HKykdVLNmkhm4Q7ny84Wd6QoKBbeYxIEAHINeZIvO9mW0VCy8FFZ3LvROVrk0eqmyDw
 ttKGJFmF9dvIQQYid2MVzjeYLdNA9cu0FBZ56t04BIptbfwfptSj0uKn7lsXYdVJ0XMq
 bvlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlkuNKGke1L591xhzF6QkCpgtGMBiTNqnZueWlCtZFAoZTHOWcjUExKxE05Cbqh7UNXh6Wk3g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n+yTetX0wjr4UlqBgqzhQA8jX3/j/CkW4MdFMydHtt4I4HukA2
 +02W9eNyLLRTuG/RQxcgBjENk2v486LfXHtdMHux+Ukq/+481TQUXuA/IcaixRkkEiE=
X-Gm-Gg: AYBFou2k1/e4X7YJm2HAL06rR2HhUFMPMIU2ChHkdQX4bqFL+mmV+alf3tWMv2HSEqB
 gq8G2AWZdXmtK7rxLJ6vYSm8/yo1e5bDTRkeVg8EweHdVK7VJkk5IzVPXOZ+GlCyY6VaaEAikbl
 Ax25BgEKHdWB/XCVKFjjo7s0v/3+bEjCBWQBYb40OSqCM4PHMpmc/aOpah0gQzOy2GCzaf1j1JL
 lVULU+/z72F4DCaJFqudPHl8Olv1klS496LrElfQpR/xPIeK9NfFZ+4HSfEmuAZ9NFurQZLJKZd
 lJ7J6E49lP7NKJqdEwwv8TxaED31/KDCvXzCiTVua0JC6aO9xgAMRFQuZFAScbJvLSNwCpTJDdj
 e/g+8QvSFG/+G+FxuTylMKzvwUaiKbtv82HBA0EQd3m8F79GBM4ubwCnLObnCILqg5gEv1i3rle
 1h3NwN2yGotdIc4EMYHXdXJtimBqiyhv/DOXzfab0m/JqcdUyyyHeIDIPdAkJOuYgpfCPcgpiDN
 QyiPhA/VccM2QaZauwVJPDNSo4jyz3y0H28kshj44tNlSiYl9bpLgBwxUY=
X-Received: by 2002:a05:6512:308d:b0:5b8:d9bf:24e9 with SMTP id
 2adb3069b0e04-5b8d9bf2688mr935106e87.10.1790178646615; 
 Wed, 23 Sep 2026 08:50:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d858f32fsm719038e87.66.2026.09.23.08.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 08:50:45 -0700 (PDT)
Message-ID: <eded0ea7-a3ee-4735-b520-c0e2beccdd63@baylibre.com>
Date: Wed, 23 Sep 2026 10:50:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: phy-mtk-mipi-dsi: add new driver
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
 <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-3-83707ed5242a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-3-83707ed5242a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/15/26 10:00 AM, Julien Stephan wrote:
> Add a new driver for the MIPI DSI PHY. The driver supports MT8183
> compatible SoCs. The driver is base on the corresponding kernel driver

s/base/based/

> commit 2ec9c210c1f9 ("phy: mediatek: Add support for MT8196 MIPI DSI PHY")
> 
> Few notes about the port from kernel:

s/Few/A few/

> - tested on Genio-350 which does not have nvmem-cells, so keep rt_code[]
>   zeroed and fallback to 0x210 has kernel does when no cell available.

s/has/as the/

>   Can be implemented later.
> - PLL is not registered as a clock provider:
>     - configure() = determine_rate+set_rate
>     - power_on() = clk_prepare_enable
>   configure() takes a struct phy_configure_opts_mipi_dphy and uses its
>   hs_clk_rate member, which carries the per-lane data rate the kernel
>   would have set on the "hs" clock.
> 

...

> +static int mtk_mipi_tx_pll_enable(struct mtk_mipi_tx *mipi_tx)
> +{
> +	void __iomem *base = mipi_tx->regs;
> +	unsigned int txdiv, txdiv0;
> +	u64 pcw;
> +
> +	dev_dbg(mipi_tx->dev, "enable: %llu bps\n", mipi_tx->data_rate);
> +
> +	if (mipi_tx->data_rate >= 2000000000) {
> +		txdiv = 1;
> +		txdiv0 = 0;
> +	} else if (mipi_tx->data_rate >= 1000000000) {
> +		txdiv = 2;
> +		txdiv0 = 1;
> +	} else if (mipi_tx->data_rate >= 500000000) {
> +		txdiv = 4;
> +		txdiv0 = 2;
> +	} else if (mipi_tx->data_rate > 250000000) {
> +		txdiv = 8;
> +		txdiv0 = 3;
> +	} else if (mipi_tx->data_rate >= 125000000) {
> +		txdiv = 16;
> +		txdiv0 = 4;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	mtk_phy_clear_bits(base + MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
> +
> +	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> +	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +	udelay(1);
> +	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> +	pcw = div_u64(mipi_tx->data_rate * txdiv << 24, MIPITX_PLL_REF_RATE);

(mipi_tx->data_rate * txdiv) << 24

For those of us that can't remember order of operations.

> +	writel(pcw, base + MIPITX_PLL_CON0);
> +	mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, txdiv0);
> +	mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +
> +	return 0;
> +}
> +

...

> +static void mtk_mipi_tx_power_on_signal(struct mtk_mipi_tx *mipi_tx)
> +{
> +	void __iomem *base = mipi_tx->regs;
> +
> +	/* BG_LPF_EN / BG_CORE_EN */
> +	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
> +	udelay(30);
> +	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN, base + MIPITX_LANE_CON);
> +
> +	/* Switch OFF each Lane */
> +	mtk_phy_clear_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_phy_clear_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_phy_clear_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_phy_clear_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_phy_clear_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
> +
> +	mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_HSTX_LDO_REF_SEL,
> +			     (mipi_tx->mipitx_drive - 3000) / 200);

Is this 3000 supposed to be MIPITX_DRIVE_MIN_UA?

> +
> +	mtk_mipi_tx_config_calibration_data(mipi_tx);
> +
> +	mtk_phy_set_bits(base + MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
> +}
> +

...

> +	/*
> +	 * The kernel reads the per-lane impedance trim codes from the
> +	 * "calibration-data" nvmem cell. No MediaTek board describes that cell

Technically, mipi_tx0: dsi-phy@11e50000 does in mt8183.dtsi

Not saying we need to implement it right now though. Just the comment isn't
100% accurate.

> +	 * in its device tree yet, so rt_code[] is left zeroed here and the
> +	 * SoC layer substitutes the same mid-scale default the kernel uses
> +	 * when the cell is absent.
> +	 */
> +
> +	return 0;
> +}
> +
