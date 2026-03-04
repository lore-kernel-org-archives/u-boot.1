Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F06EF8FF4
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 15:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B7C83BB1;
	Wed,  4 Mar 2026 16:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SfK7ethu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D44C83D8A; Wed,  4 Mar 2026 16:28:12 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B2083642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 16:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-463b3697846so6043149b6e.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772638088; x=1773242888;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UnTLBGYKRl+gp4pSGB20iDcoLB8pTrBBEXIHnQ8RlJk=;
 b=SfK7ethuKBtXbIcrOSPaNYPwwzGHKVfbtHor+LY3GHpRIE/clVaXjKq21bNkU7zHlN
 1HlRmNiX5/M6kaSybz+Wuqi4+FgwC8ivvKM/Q51Hz/VjJjhn6/O2B7BPBz+IEi7Hy0jC
 0/Rh1uUM2NZLKHHcI2CRmHeuOqv10qhHqKbN3FWyj8mlElaoKRH9+sw6rXHM1e+c9srg
 o1DU8WB/wWtQ9E6n8C5y1mX6d8gWYO7FELDgsugR9piZ47Hudz2vTGv4CErmIE0sUEJi
 sUpxjNVMC721uylcRj/yGhAB7G9xqyJs6k1vwRmbsok87rpITkczApA9sGrJm2+gVTjE
 h3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772638088; x=1773242888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UnTLBGYKRl+gp4pSGB20iDcoLB8pTrBBEXIHnQ8RlJk=;
 b=kIz3dN3ALgWnZks0nwz1fShedHPiOMpwNUjS8cAO3HKNgHAp8qDKbADtJB9qp7yhW1
 LEkecvXIAYlmxZCgCmLFiCdu0sUWcV12uLsgdFWYuZiJXQy23IPyF9EscJeYODnQHJHX
 fOZazGZLM0kkp2uPUEzAQLyhb+V8NF8USEQ1oCukP38tMrdIXbG3luzRpjo/pgkPyz7F
 98jAwRKTWe7+beN3SZ1qEYpDLLpQsKtOfjHpeY1r4QoiD8i5WhEdiNyZm9KwNvux/Mek
 wAmSzIqENKEYYXE6GaidAEm1M9OcSBKEO7Hz+hdvDnv1KeGEkVG7hAUAduJfIKQhtzfu
 mOLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu9/M5P+uY14WMmwXZpHzkAf13oYz3W830mQwKX7FKbES8A8/zcpnPvOqwDb7PuAHXd2Bb1uI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywno8UCCrGuDY9eGvElaELH6G7oHkVrcBn9JG6r1kcBQDRVbE94
 XeU9KL9VigxpbwAjtlSDYy66HBmecldlR2PT30RAZng044gDVf6BUE9EXWDv8vloAo0=
X-Gm-Gg: ATEYQzyd5cWir0wTh79LUWFm6WvFxPsAjBfk3kjAT+qh1t/8wTG2FLnd25WoNV8Gdo/
 7Q6d/u7DHbThbLD5EoMmtXubN9KfLANKMmNnak3BerYWlwWhNHjmZ+ucCmAliCAnl3H0bDkxHW8
 vX1n65ZjrI56uS1XfZ8buYxnNwttQWTqOFihFqj959z1+M13ocRIu3ZZQOOQUYXTWkB0tnLGDNo
 TtoGEzE43VW9ICcm7F3KZA5wrAIbvnQ+y9HaWj/9SP6Wbj0le7TX3pDRTf3S8eEi3S+2nuU6WJv
 zftz9p8DDd+05bR3V/nOldHTt8uZXdVezo/Dg2h6NhYfdmky9MGS/WcS5+QMIhbNpVFfupePFhX
 9reYVM7JrHl/cnUurLNH1ubcZSlBjQcPPrUBBOTm7IpEERPqfdcc5xAg67welouUAif72k6GXnw
 +cC1TgSkY5zShDY3jTDik6T5027poZ9yFS9mKksM77grtT0KIbLYa6cvn+I1+Jca/7kmlY1odJl
 Q==
X-Received: by 2002:a05:6808:e8e:b0:45e:fff5:89b4 with SMTP id
 5614622812f47-4650c68c4c0mr3344520b6e.10.1772638088612; 
 Wed, 04 Mar 2026 07:28:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0?
 ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf2572bsm16777461fac.2.2026.03.04.07.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 07:28:08 -0800 (PST)
Message-ID: <60ce40c2-8f47-4e7e-afb5-fb502e8894eb@baylibre.com>
Date: Wed, 4 Mar 2026 09:28:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt7622: fix infracfg and pericfg clock
 operations
To: Daniel Golle <daniel@makrotopia.org>, Lukasz Majewski <lukma@denx.de>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <a54fd4a7284da506020cb614919096067b195277.1772596281.git.daniel@makrotopia.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a54fd4a7284da506020cb614919096067b195277.1772596281.git.daniel@makrotopia.org>
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

On 3/3/26 9:53 PM, Daniel Golle wrote:
> The MT7622 infracfg and pericfg drivers both use
> mtk_common_clk_infrasys_init() for probe, which populates struct
> mtk_clk_priv and stores gate definitions in the clk_tree. However,
> both drivers were incorrectly wired to mtk_clk_gate_ops which expects
> struct mtk_cg_priv with separately populated gates/num_gates/gates_offs
> fields from mtk_common_clk_gate_init().
> 
> Since those fields were never set, any attempt to enable an infracfg or
> pericfg gate clock (e.g. CLK_INFRA_TRNG) would fail with -EINVAL.
> 
> Switch both to mtk_clk_infrasys_ops and struct mtk_clk_priv to match
> the init function.
> 
> Fixes: 72ab603b201 ("clk: mediatek: add driver for MT7622")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

I think this clock framework was initially designed to only have one
infracfg clock registered, but in this case, it should be safe to have
more than one because it isn't using CLK_PARENT_INFRASYS. So this seems
like the best solution for now.

Reviewed-by: David Lechner <dlechner@baylibre.com>


FWIW, I've been slowing working on some major cleanups to MediaTek clocks
to avoid that kind of restriction.

I would also be interested to see the output of the `clk dump` command
on this board to see if there are any other problems we have missed.


>  drivers/clk/mediatek/clk-mt7622.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index 782eb14e9c5..c1cc57f2e8c 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -821,8 +821,8 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
>  	.id = UCLASS_CLK,
>  	.of_match = mt7622_infracfg_compat,
>  	.probe = mt7622_infracfg_probe,
> -	.priv_auto	= sizeof(struct mtk_cg_priv),
> -	.ops = &mtk_clk_gate_ops,
> +	.priv_auto	= sizeof(struct mtk_clk_priv),

While we are here, I wouldn't mind getting rid of these random tab
indents before the `=`.

> +	.ops = &mtk_clk_infrasys_ops,
>  	.flags = DM_FLAG_PRE_RELOC,
>  };
>  
> @@ -831,8 +831,8 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
>  	.id = UCLASS_CLK,
>  	.of_match = mt7622_pericfg_compat,
>  	.probe = mt7622_pericfg_probe,
> -	.priv_auto	= sizeof(struct mtk_cg_priv),
> -	.ops = &mtk_clk_gate_ops,
> +	.priv_auto	= sizeof(struct mtk_clk_priv),
> +	.ops = &mtk_clk_infrasys_ops,
>  	.flags = DM_FLAG_PRE_RELOC,
>  };
>  


