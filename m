Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AA606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a6PDp5C8;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=itRPGX3+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ABED40DD1;
	Thu, 19 Nov 2026 21:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mj35w45kOPEo; Thu, 19 Nov 2026 21:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55FD940DC1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795122416;
	b=V9hAMXlnWLPCAHqhxMn6W3R4QTi/AmULqSRoRzwDJaGaG3e12Xw1vT82bB7X7FIHU+yB
	 79NXHYrbQ3dl+5MeWcEueEwwWX3Yl4ePh1U1hc4ZrC3t2yWO4wK995qrN2VPvE7S2k/3L
	 MIla4WivnA2c+68e+S/GHBAQykWWzFwJyy4VBwUTVEfUKj60eZ1wg+0rShIOkyCK3Qgc9
	 kSQugrvwMYZKoikOhwv7b3TlOYUuksD5xHmhEBSdA/6ZbLS8y91XD2vMHIsmQo9DvLRka
	 3hW6t4BgOT9wsr8LwPWBJqRAMMJwWjtSupW1L3ZCL7xTrONg0iwk7Ndkm8ja9Qp9Qgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795122416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TCI8kmmV5Cx4MFc2vMHtYwuWXKuVdn6zVMvgcB5vB/g=;
	b=rUgHDdpIksQzJPAEV4a3qCVffMAI8pQmdWOnrDLsn9yNuYmkrOoJrH/OEA6RdtrnVftz
	 EQ9mFSl0x2mWI+yrZcIAWdco1qsvokIiCE7q8tPo8GYKAa8nrxD5Ffc36wSP/5chZ4bch
	 ZaD62o8tqlWc7dUgtPWmIWBGuxkzHdgW0ZM7RQzLp0Td2Bs31PrkANmzMboEXM0ALfQFR
	 FTwZHMfqQFIYTdLeEJuRx+8/8UbkEDnp6g4Iz3BIFfkDY53D7dFiwLB0kE9dWax1ptNWP
	 nOfs4hmDtrwcyn75Q+HK632hjJDsbCyHgis8Hu4LV/CjdOW8XbsUtAUreRbFHke0gZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795122416;
	bh=TCI8kmmV5Cx4MFc2vMHtYwuWXKuVdn6zVMvgcB5vB/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6PDp5C8mLakd3gB9mffGy692xDJGFBVIJ6E3xHXReF3NEOEamhxkIC+BdgSDFrih
	 H7/AVLzrdreNpVOweycwDxBxUPmi4sObKVX/5cL/80XU6YRARxywkkcVEGmBE8tums
	 stTA1Bajh835PK+HnyJmzVYa2sNstemO6MJ1G0tbkjCKrx9GSc1Xlib5hU452bsnhT
	 INmZEEbBzXkg+cy/IPo7DEBeCfpQfnMGCZ4UAF+SJbH0hxnWFUTPIjiVXXhrY+9tGv
	 YzlyR+X/uiU/uI6bbVYijT6Dw7ywImxrCmniLZ7kB70cAn/Xay+rPKewBN3cWqfn4B
	 W2OumSFjSxcQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55FD940DC1;
	Thu, 19 Nov 2026 21:06:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3B31C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C9A181541
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQvNjLHVcb6E for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:06:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 43F60813AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=itRPGX3+
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43F60813AE
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:06:52 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-862b9c2e78aso135448a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795122411; x=1795727211;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TCI8kmmV5Cx4MFc2vMHtYwuWXKuVdn6zVMvgcB5vB/g=;
 b=itRPGX3+LkPcs2BDYI+gGjMK9CionNpTfqU6q3l2JYqh/FZTyQmxb8m5j8jQBSPovR
 ia0WJzP/OWVO8QCGhf+XvYp3cfsf7cbh4154JnLofPg3mb2ADrUj3QPmLE39eCkkkyMx
 WoNoop9i1gJRAkmizdEovOENSrRHjshFb1SUVPI1Z8uO9zmESLahOAQRgvmt0jQjSVCQ
 PatwTmTV3WzA/ZqUDxlsXZDGzUq0LSX1Fn4SNDMGzXaOfugB3votWXO/GLlchNUfRgzo
 kwjBzILKUS/v1hNd/aaGYH4TSOOzvC5me9vShIKyRb+iRcrP522nE8rnZ1k8hg+UIQnu
 zvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795122411; x=1795727211;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TCI8kmmV5Cx4MFc2vMHtYwuWXKuVdn6zVMvgcB5vB/g=;
 b=VzyYHMhvO1HG74PTjj9r8lIq0I//HQoM7XLtvjoPE/lS3vXFpQBZMTEEdKYShL8eYG
 S1NykRejSYki0w/ncBK7okyV6bMoGXsjMH3VqXMwdC/et0zIPXL9mBPEETO1UPTzzKsW
 6wwpS6D90CPeRIF45WoBal+BAGHwIVdSUSxkG2DuNbCtU2anRFlJCu3HKfGTfd3MDJRe
 OawAYfwi+woRswD3Hqz7bm3F0Bef9PK4LhP5DYAahOyxU97E06P3TiA8vuw6MF9Zr0gb
 3ZrsGeVnvqnFqimhMNns3cnzudG4kWhybTr++1DYh26YCUpVuYGuh2sUFBfTm8wTfwgh
 RQqg==
X-Forwarded-Encrypted: i=1;
 AL+hErGLa3zGSVV68H7tLq/m28xk5Z/rEGReP0pHFfpNlx9eUrhCPfAnJAMp0EZHhe62DXmcZBRUong=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9V0hyTpuMqqRqdkUjI4uJ57EgcTw1YN8m0qIWwm2DDyBtp+UtE
 EJhAIPJkVOOEEiaeBFzxmwnVtwMM6vGeA/fFaTFOom5nufpGPJnxaahHle9PZFJw4kk=
X-Gm-Gg: AYBFou1qEprLrs30AuTnWxRL4cA+xTjcFugqDWJ/+LsgZa1uWyu+imbzluEFUSzswWQ
 0obGYZUx7nO1joSDJTAJDHXTJSev8tm7lu2NTd7a5/2u63jPBvETK0b93N45GvTZEBYncMlehwR
 deUkZ3l39JDB8Gt7s1wzjOOrafyZnOfFuNAkRtX9SS3ZLF96B+jUefkMsaFdUtiBK+PPzPfoyon
 +vtKX9JMxFN4F47UwzeM+pobQe4evMa0Eu/jA2Ou8kkavQKtD7vXRN9V/K8fGbIgguopbWT4vgm
 8wIyFnU3qHz5qZ757IMlnLtLTIle9XOW6ZxinTSQ9K2bCZ0j7elii3r7k1EgucsRRPeuLt+zrVQ
 bthXEu2P+2AEQ4uTUI2qvGfWQJAe8nx8xTZ4lbftsfKudLNUAZKaUq29F9ELEwQwkTtgGpzPLdy
 7EkkiU38SODbCNtVOCvhtFK25tdjyM50zWmUr9hNpGEpFe134z/EqsNvwUBzQrbkfZcXRYyuzDA
 IUTe6+h6Ed3L+OUKq7MTX1zk/j42oGO+AkgLeo3wVCRCPE/fqu8uj8rh5Pk4PbA4RMNpiqwR11+
 wWsP1TA3fh+rYc4wupLHS8406y8MWXQyCslV0WVtmDjy7K5m4tEFkTE68kPQoMEEWw8r7Orm5du
 FbBE=
X-Received: by 2002:a05:6830:3e03:b0:862:ba3a:f061 with SMTP id
 46e09a7af769-863157c920fmr1503091a34.7.1795122411405; 
 Thu, 19 Nov 2026 13:06:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6da9sm544837a34.15.2026.11.19.13.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:06:50 -0800 (PST)
Message-ID: <fbbb8087-d6f1-4dc6-9909-616a4028406d@baylibre.com>
Date: Thu, 19 Nov 2026 15:06:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] clk: mediatek: mt8189: index I2C gates by
 wrapper-local ID
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
 <20261118-ccaione-upstream-mtk-g720-i2c-v1-4-916dd6cc8d1a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-4-916dd6cc8d1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 2:29 PM, Carlo Caione wrote:
> Each wrapper numbers its gates from zero. GATE_IMP() sets .id but
> leaves the array index implicit. With all four wrappers in one array,
> a request for I2C5 (south ID 2) reads entry 2 and enables I2C3 instead.
> 
> Use one entry per local ID, using that ID as the index and gate bit.
> 
> Fixes: 4cce6acace72 ("clk: mediatek: add clock driver for MT8189")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8189.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
> index e29915d4c0..46a29397b6 100644
> --- a/drivers/clk/mediatek/clk-mt8189.c
> +++ b/drivers/clk/mediatek/clk-mt8189.c
> @@ -1534,20 +1534,16 @@ static const struct mtk_gate_regs imp_cg_regs = {
>  	.sta_ofs = 0xE00,
>  };
>  
> -#define GATE_IMP(_id, _parent, _shift) \
> -	GATE_FLAGS(_id, _parent, &imp_cg_regs, _shift, \
> -		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
> +/* All I2C wrappers use their local clock ID as the gate bit. */
> +#define GATE_IMP_I2C(_id) \
> +	[_id] = GATE_FLAGS(_id, CLK_TOP_I2C_SEL, &imp_cg_regs, _id, \
> +			   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
>  
>  static const struct mtk_gate imp_clks[] = {
> -	GATE_IMP(CLK_IMPE_I2C0, CLK_TOP_I2C_SEL, 0),
> -	GATE_IMP(CLK_IMPE_I2C1, CLK_TOP_I2C_SEL, 1),
> -	GATE_IMP(CLK_IMPWS_I2C2, CLK_TOP_I2C_SEL, 0),
> -	GATE_IMP(CLK_IMPS_I2C3, CLK_TOP_I2C_SEL, 0),
> -	GATE_IMP(CLK_IMPS_I2C4, CLK_TOP_I2C_SEL, 1),
> -	GATE_IMP(CLK_IMPS_I2C5, CLK_TOP_I2C_SEL, 2),
> -	GATE_IMP(CLK_IMPS_I2C6, CLK_TOP_I2C_SEL, 3),
> -	GATE_IMP(CLK_IMPEN_I2C7, CLK_TOP_I2C_SEL, 0),
> -	GATE_IMP(CLK_IMPEN_I2C8, CLK_TOP_I2C_SEL, 1),
> +	GATE_IMP_I2C(0),
> +	GATE_IMP_I2C(1),
> +	GATE_IMP_I2C(2),
> +	GATE_IMP_I2C(3),
>  };
>  
>  static const struct mtk_gate_regs mm0_cg_regs = {
> 

The proper fix would be to use the in-flight devicetree bindings for these
clocks, which means 4 compatibles and 4 clock trees.

The u-boot driver and devicetree predates proposed upstream bindings, so we
got it wrong.

It looks like the binding has landed upstream and the devicetree is likely
to follow.

bindings: https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?id=294637d60bc0dff970b51f32cf0a5d46bede0652
devicetree: https://lore.kernel.org/all/20260924-add-mediatek-genio-520-720-evk-v3-3-2ec5c80677d4@collabora.com/


