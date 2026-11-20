Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AF606A6D9
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E7raTFEz;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uVjby00H
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76A1E81401;
	Fri, 20 Nov 2026 19:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0E6o40nHdg33; Fri, 20 Nov 2026 19:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ED2881403
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795204428;
	b=hAILgEgGPLfIHD0aqj1DY/z2Ih52vz74tzpV0k44ki8XHbm24/K4CVxO4bFOyUednNzt
	 S5aR0Q+sV8lzZNsIrPtaKi/qLa1AsM2fk2HTzI++9QPioQ5FUkaj8rsP1YheRY6doEtYh
	 tiyB2a9S5Sx0WsJUCUHBN3hXO++Xn59yGPQ+VSW9aRW+TOoT/ktnjmqMIZb1zGx2NlkS1
	 32amYJ+LXXQdGIqfrth5w5GWnI+QJ5oYAgRg19hiubX/gciXrUM7+zQQMGWtOV4xuo0kl
	 1SQmX4ddeLHIIwDtelGfjpQjV+295+r+0Ax8zgcY/0kbiziuubBg6qQSVS934DXIfZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795204428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w0OdkHnyKYRgtXKwU8WgssCXtL9RBBCZgGOenlieZdY=;
	b=Ys1IzEYP0U3sU88VxT4TiQrMAQebM7zi0z9bf5dReWo6vI2/u1RNazzfK3N7MmXGL82e
	 e8wT6QhTsfQRsRpwVwEd+NvEXsYXYWVOhWNvh9ZuhRCObV7MqZWsx7zrrzQzJnkt+5zEj
	 ELvPdmFHXzx3gBEG6aejingHcbbyqAtaCmNu1sTAFslIB5WVThn/0Nxmiw4A1PPrQdIyh
	 VYwk6IslgDrFQ8XVZK6CN0pxM0CpgQ/8sESZqfE1A8HqY26MrUbi4qpQRnQnRZq75Mslt
	 UGnnM86irphEVtqOr26JmPN6TcqSzljk8UoRJ5pakdbcA2PWLzBB3QJ7CQnkQeUjCGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795204428;
	bh=w0OdkHnyKYRgtXKwU8WgssCXtL9RBBCZgGOenlieZdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E7raTFEznW9CZTBkbGfXNtkT/lDyhPTsJtUhs8wMGta1iJZiL64D4AFGDh2nOqzaO
	 acuwR3yl8NLb0Rnb5KTR98NIYT2EvRRHagCu1HdQUFwsw3EWjrI/d3HlNjHA1yxkGq
	 c3pKWxWDanYic4Z9Q/se0OdEINuIvYMqpNCAgGRBhhaWOWpXufuGA/+m+wvTdzoAzq
	 Gdlj+7Zo02iZkmkq2vGDwycZN7U2K6JaBRSnUSZ2aubRHQ6c56cF/f5WSRRcVXwpXH
	 H1uVceP0A//T6oQj5NcYjWqigBOBCagyq3UUrT/ZJ9Ep0+8liVU08C19F3+0YQVVs/
	 WDeUfSIAGejOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ED2881403;
	Fri, 20 Nov 2026 19:53:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40277971
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 260E960698
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYFyZqkU70Nb for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:53:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF39A60686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=uVjby00H
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF39A60686
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:53:45 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c50ac25cdd4so177230866b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795204423; x=1795809223;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w0OdkHnyKYRgtXKwU8WgssCXtL9RBBCZgGOenlieZdY=;
 b=uVjby00H6koaScYAFmIPU9yaUT0JY3iQfes7Si/KBPu59UzxaADNyqwsyCHoPfKZfp
 RhOfhj9qghDXakRdWWzkVzgLeRGRc+l80zdba3wVxzQK2jj4j/5OZ270BOCi7du2CfHa
 OOOhgesP+YlfJRGv2QDCS3hmAOyLZIvLPUt7TEok/RoO1oBAQhhg5V+F6oWRNfOoXhLr
 me1WmKwvZ9WwAVIah7YDqO82N2ojhsapVSLPNpXULLk7E+dwAr0sEy9ALZ6R0K5dQ2bR
 2mlpzg2ZGSrHxDKio48JYRTnK3jBg2ddtExY2dJ7wg+oEp22OMcO5Bn1R3BF3n/qps7d
 eJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795204423; x=1795809223;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w0OdkHnyKYRgtXKwU8WgssCXtL9RBBCZgGOenlieZdY=;
 b=Rro8Ym5GffHiM7BxcANTq2YonMrIcDnAZWaB4o1fiMwFUhwakRANI8JbZzVZE3ak0O
 l2Q5R9ILvsYgy/2lSfcaSdM6VF7LiiFIyTLrw4lwzZqOpv8/Bk/I8WU6q/p5iRoOfem7
 NY5N0mWjoUvJJJX6mWIV62JYTzkh55f0VGNgMPsfUeOHiYqIvB73dvvMFUT1hivPBcaq
 Kwdpd55znq03FFJHxkw3TCaIzB2y/CamhcPeheJ6wqWviOFvTRgCoecgUEkCUZZ+8EGc
 z7DldA92bFTX6keAnMGX78tkTIMFEKb+syTuicASmBbRnkndO030fqCLm00S+HEdWIyP
 L8VQ==
X-Gm-Message-State: APuU4Z/ptCb/dMvdGE6gPReKty104B9ULdk6VLT1mWTwL0irqsT/XZ3w
 J/QrBfP2euIoG4HPTBtEwMQ0zgkVpBTIv3uqSGHPBxLkAccV3bsL4ELDElSMnwHa+DvlR0P8TZ+
 AcM9uPyqocQOTAh3RVmOM7rLtkQGD2FsU0T6K
X-Gm-Gg: AZFdTZdmEIMVBOrLly0qQ4Ic+8YAWDJ2G5vwxMd39EBvvtYaNMhu1aFxsQEUmJarJ8+
 fCaa+oHBsXKt7TPDyGNr8yPCQJf3BIH0AmCqMUBIO9DAMsO8N6L7mI8cL7Lf8cymBpuwsFR7Q4G
 fvONqudjTZv0WEEL2ll0hJ9AjVcCYgImrZDga2IxVLrbybRX7u4StXMwWqbedLDiHPM+Ib+ALZK
 fRGw8V3FNeivu4OzVeHSBJV/n5NnVZjWE3ZWHpdcDn7YqxPriBs6VyD9gNbwc60oopfSIuQH1k4
 Br+EXKHdDBYrU0J2Bxc2QpYN4fn+99hapadie33fza0YdCCOnLFu0sVNeAetcxs3Rt/n1FnH4jc
 hQzr92ptiLoOpXG2f1md17lGbzT25QAQQx3ejwQ==
X-Received: by 2002:a17:907:c643:10b0:c2e:4292:d27e with SMTP id
 a640c23a62f3a-c513a816d3amr307355666b.22.1795204423317; Fri, 20 Nov 2026
 11:53:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
 <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
 <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
 <a7390f3e-f6f1-4617-b7a4-df253673abe3@cherry.de>
In-Reply-To: <a7390f3e-f6f1-4617-b7a4-df253673abe3@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 20 Nov 2026 20:53:31 +0100
X-Gm-Features: Aa3M54pYDdB_N00-S2n0pAaklmZMA77ZhCODoJdtpMNIMlCwvx0YdCj8ElB4UeM
Message-ID: <CAC928HZjdBO1W7_X_+VKHh0fxoBoQahW9nRBfdf4PYMNAmompA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno gio 19 nov 2026 alle ore 16:14 Quentin Schulz ha scritto:
> Hi Massimo,
>
> On 11/19/26 2:23 PM, Massimo Pegorer wrote:
> > Hi Quentin,
> >
> > Il giorno mar 17 nov 2026 alle ore 17:40 Quentin Schulz
> > <quentin.schulz@cherry.de> ha scritto:
> >>
> >> Hi Massimo,
> >>
> >> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> >>> The PX30 and RV1126 sdram drivers support more sdram types but only
> >>> one type at a time, really. The type to support is selected through
> >>> RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
> >>> more than one of these options is selected, instead of relying on a
> >>> debatable and embedded priority order to choose the one to support
> >>> among the selected.
> >>>
> >>
> >> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> If we add ROCKCHIP_RK3399 to the depends of
> >> RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think
> >> we should add a similar check in the rk3399 driver to refuse to build if
> >> there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3
> >> enabled. What do you think?
> >
> > Unfortunately I did not come to a clean solution for the RK3399 sdram driver
> > "singularity". At least, not enough clear for my taste. So I left untouched,
> > open to discussion.
> >
> > Let's suppose we also have ROCKCHIP_RK3399 in the dependencies of
> > RAM_ROCKCHIP_LPDDR3 and RAM_ROCKCHIP_DDR3, something like:
> >
> > config RAM_ROCKCHIP_DDR3
> >          depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126
> >
> > config RAM_ROCKCHIP_LPDDR3
> >          depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399
> >
> > Some compile-time checks in the source code can easily be added to raise an
> > error if LPDDR4 is selected but it is not the only one, or if none is selected.
> >
> > The point that annoys me is that, in RK3399's case, the two options
> > RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR3 are the same thing, in the end.
> > If it would be possible to have their values coordinated, I would be happy,
> > but I do not think it is. Using the Kconfig 'select' statement will force
> > one to be true when the other is selected. But unfortunately, this does not
> > work when unselecting options. So, if one is selected but the other is not,
> > what should we do in this case: raise an error, or silently ignore it since
> > it does not affect the build?
> >
>
> I think it's fine if we have DDR3/LPDDR3 selected but will use
> LPDDR3/DDR3 based on Device Tree. We can make them really mean something
> by gating LPDDR3-/DDR3-specific code, but I'm not sure it's that worth
> it right now. Something worth investigating if we need to shed some
> bytes in TPL/SPL.
>
> > An alternative could be to use an RK3399-specific config option, something
> > like RAM_ROCKCHIP_DDR3_LPDDR3 but... ...it's quite disgusting.
> >
>
> Nope, don't want to go this route :)
>
> Another option is to make the RK3399 driver capable of handling
> LPDDR3/DDR3 AND LPDDR4 at the same time (no autodetection of the
> populated DRAM type, still read the type from Device Tree), then it

This (driver capable of handling all types at the same time) seems to me
the most reasonable due to the fact that, indeed, the SDRAM type and
parameters are read from the Device Tree.

> becomes less of a headache. You can have LPDDR3/DDR3, and/or LPDDR4, and
> it gets easier in the Kconfig symbols.
>
> I quickly came up with (didn't test aside building):
>
> """
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c
> b/drivers/ram/rockchip/sdram_rk3399.c
> index 6fa8f268770d..22d196f1bec7 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -1632,7 +1632,7 @@ static void set_ddr_stride(struct
> rk3399_pmusgrf_regs *pmusgrf, u32 stride)
>         rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
>   }
>
> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>   static int data_training_first(struct dram_info *dram, u32 channel, u8
> rank,
>                                struct rk3399_sdram_params *params)
>   {
> @@ -1723,7 +1723,9 @@ void modify_param(const struct chan_info *chan,
>         clrsetbits_le32(&denali_pi_params[76], 0x1 << 24, 0x1 << 24);
>         clrsetbits_le32(&denali_pi_params[77], 0x1, 0x1);
>   }
> -#else
> +#endif
> +
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>
>   struct rk3399_sdram_params dfs_cfgs_lpddr4[] = {
>   #include "sdram-rk3399-lpddr4-400.inc"
> @@ -2964,9 +2966,11 @@ static int sdram_init(struct dram_info *dram,
>         }
>
>   #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> -       /* LPDDR4 needs to be trained at 400MHz */
> -       lpddr4_set_rate(dram, params, 0);
> -       params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
> +       if (dramtype == LPDDR4) {
> +               /* LPDDR4 needs to be trained at 400MHz */
> +               lpddr4_set_rate(dram, params, 0);
> +               params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
> +       }
>   #endif
>
>         params->base.num_channels = 0;
> @@ -3067,19 +3071,23 @@ static int conv_of_plat(struct udevice *dev)
>   }
>   #endif
>
> -static const struct sdram_rk3399_ops rk3399_ops = {
> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
> defined(CONFIG_RAM_ROCKCHIP_DDR3)
> +static const struct sdram_rk3399_ops rk3399_lpddr3_ddr3_ops = {
>         .data_training_first = data_training_first,
>         .set_rate_index = switch_to_phy_index1,
>         .modify_param = modify_param,
>         .get_phy_index_params = get_phy_index_params,
> -#else
> +};
> +#endif
> +
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> +static const struct sdram_rk3399_ops rk3399_lpddr4_ops = {
>         .data_training_first = lpddr4_mr_detect,
>         .set_rate_index = lpddr4_set_rate,
>         .modify_param = lpddr4_modify_param,
>         .get_phy_index_params = lpddr4_get_phy_index_params,
> -#endif
>   };
> +#endif
>
>   static int rk3399_dmc_init(struct udevice *dev)
>   {
> @@ -3098,7 +3106,21 @@ static int rk3399_dmc_init(struct udevice *dev)
>                 return ret;
>   #endif
>
> -       priv->ops = &rk3399_ops;
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> +       if (params->base.dramtype == LPDDR4)
> +               priv->ops = &rk3399_lpddr4_ops;
> +#endif
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
> defined(CONFIG_RAM_ROCKCHIP_DDR3)
> +       if (params->base.dramtype == LPDDR3 || params->base.dramtype == DDR3)
> +               priv->ops = &rk3399_lpddr3_ddr3_ops;
> +#endif
> +
> +       if (priv->ops == NULL) {
> +               printf("no ops found for requested dramtype (%d)\n",
> +                      params->base.dramtype);
> +               return -EINVAL;
> +       }
> +
>         priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
>         priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>         priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
> """
>
> Of course, we need to update the existing defconfigs to reflect that
> change as !LPDDR4 used to mean LPDDR3/DDR3 but not anymore. An
> intermediary step could be to have DDR3/LPDDR3 default y if !LPDDR4 so
> we avoid changing the defconfigs with the driver patch, and then remove
> the default y in a follow-up commit by making the rk3399 defconfigs
> enable the appropriate one (easy to find based on the Device Tree they
> include).
>
> Finally, with the above diff, you can technically build the RK3399
> driver without any of LPDDR3/DDR3/DDR4 enabled, which can be remediated
> by an ifdef check at the top like you've done for PX30/RV1126, just that
> we *want* to check that their sum is NOT 0, anything else would be fine.
>
> What do you think?

I look at the RK3399 driver code and at its repository history to provide a
well-founded answer and... honestly, it seems to me a mess. The driver was
born to support all SDRAM types at the same time. Then the LPDDR4 config
option was added by commit b6cf08949d4 because "Supporting LPDDR4 code support
in RK3399 would increases the size of SPL/TPL", and the related ifdeffery
followed. But a lot of LPDDR4 code was already there, and has been left in the
common area, instead of being reorganized properly. Seems everybody added on
top, instead of looking to redesign the driver.

What happens if the driver is built for LPDDR4 only and the value of dramtype
read from Device Tree is DDR3 or LPDDR3? Or vice versa? The simplest thing I
would expect is for the driver to print an error and stop. It doesn't. Instead,
it goes on, without happy ending I suppose.

Another example: looking here and there I came across the gstride_type variable
in the calculate_stride() function: is it there something magic I cannot
understand? I see a local variable initialized and then used for comparisons,
which are all necessarily false.

In the end, I wouldn't touch it. But if you prefer, I can integrate in this
series the changes you suggested above, adding the defaults y if !LPDDR4 and
the check for NOT 0.

Regards,
Massimo

>
> Cheers,
> Quentin
