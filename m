Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68A2D75E4F
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 13:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FAA089831;
	Fri, 22 Nov 2024 14:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eAckQsCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9CD8981D; Fri, 22 Nov 2024 14:57:46 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA3B89831
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 14:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so340646766b.2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732283863; x=1732888663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TXX4LZnXLjrBhr6y2V/I69lFF73ZyYKa+i9+L/BTpyI=;
 b=eAckQsCx9JyAQBX1hnGbtK3sImY034IoWstnlDS3sNAY+U0ycerTEzQlii1lxLF7hz
 jI3pg2IfSuZoYTSc1Sr3pO+M+t44ufMGTt8Y8vU3k5w9L69KBDpqKhtpXasz74RRaFI/
 xlyf1YGnjjAe1YMhpt/1N9MZHcSWFeZz3v3No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732283863; x=1732888663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TXX4LZnXLjrBhr6y2V/I69lFF73ZyYKa+i9+L/BTpyI=;
 b=Gq5dGtm/vVXBvLzag+Fsm2lJeJgx6/v8pFl+3ZQQUh8IQUq+ijkUPn/EA8pbX6l+bz
 YMKug4zslD/7q8juMV/lEU9kblGyKSEM3EBspM5HpZ5LHzzUKIr5SF+W/K5Cz5EzgkvZ
 4hZzV+6+CMuJwsA+4LuCmFxk9ylYEFr+KQLT0gXelLo468aD1N0evD7ESJJ1+p6TAB8z
 idXjwbFtmAYjg5I+B2PWtnLbtN7cacPZMGBLBTQFPjF7dCx6Mx+K5FQo14KENJZRppko
 6cIsIU0/GZ3VVInrZDeDeG9Fa1y+8UQQgisrKoUQ5z0cmiht3VGNISGOp5ftZkzQUfi0
 eaqA==
X-Gm-Message-State: AOJu0Ywrc7yfEGG3uvmnrPszDzQgmfY+BXqKhwVtsvxPWNF4SCRqbgWr
 4h0n2ej8F1jiSWc9GUqWaH0X9vFHUCHmzHmQOUTNnd/gtERmZOzXyMfWw7kEL99MuQuaGfTuXuo
 cIFFl+AXNcFczupNiprrVTYncK/OapOZZLM2L
X-Gm-Gg: ASbGncsOk/8QI6ZMnZZ/K7t8B4XCjcbGzaeVmgnatuBlqSTo/lttCzqsYPEXjx7IEr6
 hr6GzARimwxKWtyw/JcTdCaZT8WFAuOUW
X-Google-Smtp-Source: AGHT+IGG/fqHQNojWP5OsOmSMoQf8EouXu7HkWaXc8MLpMf8M0fHDOmN7K+XQxqyfo+QJZ1yuY3Um82TF9GgpJ+2JNY=
X-Received: by 2002:a17:907:2cf0:b0:a99:da6c:f607 with SMTP id
 a640c23a62f3a-aa509d2138bmr242748666b.44.1732283863429; Fri, 22 Nov 2024
 05:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20241122015858.557561-1-marex@denx.de>
 <20241122015858.557561-3-marex@denx.de>
In-Reply-To: <20241122015858.557561-3-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Nov 2024 06:57:31 -0700
Message-ID: <CAFLszTigYfBSSmQwKs87CrVwtZRqPRJ+7yc-RdDk3uh5Sgwcfw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: imx8mn: Remove unreferenced
 clock-controller clocks in SPL DTs
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Thu, 21 Nov 2024 at 18:59, Marek Vasut <marex@denx.de> wrote:
>
> Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent"),
> drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_clk)
> fails with error -22 EINVAL in SPL. This is because clk_get_by_name() in the
> end calls fdtdec_parse_phandle_with_args(), which iterates over all phandles
> in clock-controller@30380000 { clocks = <&osc_32k>, <&osc_24m>, ... } node
> 'clocks' property in an attempt to find the "osc_24m" clock, but fails to
> resolve the &osc_32k phandle and returns with -EINVAL.
>
> Remove the clocks property phandles which cannot be resolved because their
> matching nodes are removed from SPL DTs, so fdtdec_parse_phandle_with_args()
> can resolve all the remaining valid nodes and successfully look up the osc_24m
> clock.
>
> Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Bryan Brattlof <bb@ti.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Malysa <greg.malysa@timesys.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jonathan Humphreys <j-humphreys@ti.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: For v2025.04
> ---
>  arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
> index 6d80d856365..38e1934aee8 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -51,6 +51,10 @@
>         /delete-property/ assigned-clocks;
>         /delete-property/ assigned-clock-parents;
>         /delete-property/ assigned-clock-rates;
> +#ifdef CONFIG_SPL_BUILD
> +       clocks = <&osc_24m>;
> +       clock-names = "osc_24m";
> +#endif
>  };
>
>  #ifdef CONFIG_FSL_CAAM
> --
> 2.45.2
>

We should not be checking U-Boot CONFIG things in .dts sources, since
there is no way it could go upstream.

get_phandle_argc() shows how this is done in dtoc. It seems we will
need similar logic in fdtgrep to handle this. You'll be pleased to
hear it is written in C :-)

BTW the bootph tags should be able to go upstream and be dropped from
the .dtsi - the only thing in the dtsi these days in the Binman
definition, which is barely started upstream.

Regards,
Simon
