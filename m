Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8113606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tX/0S1QR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/A6Wil9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 363E980E36;
	Mon, 23 Nov 2026 17:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PU3iFWvkEObC; Mon, 23 Nov 2026 17:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB85780DF8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455366;
	b=OdPNNRaUWPKE6p3LiACATXJZW/x6ngiopJdx/kSE9UrJWfowjwIcvuas5Y7lRhtP/Kaj
	 LtEFaXSpJ+7REOl4AbgMok6pDbgEmEWRZFWFuj6H2mUeVnJoPROcuktlfkvyjNuYv9PzY
	 QGi3pCjDYYwFFcUXZZ6oI8i6dKjxsBChdGj1bH7msqRa2i9/0+71wU9whWaLhkB9i62wa
	 UrhIMz3nckzEpWCwm0x0oKbYXvdRhH/g8HYkrTGKcwdBX99Ev8Ua6JDXt2/rjNHzcKIZt
	 Rk8aXddAAdqiccMCH4ElH9wI0sjQDp/FViAMqSvFPIgPuQDqmVlU3qo2JmceF/+cBcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KNSmTusk6MtgDxFsQZ76la9YnileylMKg7jiXqVJZdo=;
	b=jizAX+dzj+dIUjgXDV92bCY42Lolwqh4zj1tHtFAfRSZDgaqt7yxuNYq7wIyNvObSIpf
	 SG1VKClcAFTTaLkpk4RSmUwT4UVCqLHWCCUpHJaq1gG9FNiNOuvvLINaQJmyUI6otl9sB
	 mUNvroDX31FxjRT6NA/l6hLm8WKXNGzUc6VOkaz/XnYxjeE+oO+sqW/7onF6eNraypHfw
	 WrhlKHSuvgUcJX9R9WE+GdHKvWnOsLrXizvM+9GQyMSs6aLgYjLcb86AR2pphUfJCtm1r
	 RWMpCexxQTRqkIsyZ6kggB84d6nmBM/WSDc7ySUzJu5uuIkxsYlEt4G8U5F5i6gpw0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455366;
	bh=KNSmTusk6MtgDxFsQZ76la9YnileylMKg7jiXqVJZdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tX/0S1QR0E8oLZVmJL1kYzNjKC2PxF58zJ/wvvrrTtqL7rEGwYwi0LQMEl3sl+Kfm
	 /FmLxWoTb+BRMDkJyG9Ktz2CqyegQOxtUd0RcxsRvTkAzjfam966YY2WdGaHMbdqqm
	 cVcKB8kcBgFWIYgSULTVg857R5Aq17PWhvhcgVWmgStjQGd90oIa3q/6uScYFLT7rT
	 hB6V1SIhSWLIr9M9xYf6JBeS7KJRjKluaIubUxjXz4IY82/4WHWUzij6RBFehKyRPa
	 WZvbP9AV5QfaPwCXJqP2skEu7tjMLgNsB1ua75i5jBrioxRpa72S4WK/RILqkHnX6B
	 pEFG1S3jQQ5pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB85780DF8;
	Mon, 23 Nov 2026 17:36:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 593963A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5657960678
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vho-arkp1-tn for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C713A60603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=d/A6Wil9
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C713A60603
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:36:00 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c511c0e2826so413481866b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795455359; x=1796060159;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KNSmTusk6MtgDxFsQZ76la9YnileylMKg7jiXqVJZdo=;
 b=d/A6Wil9lnJZLhAO2U4PSPNv6IVcaI/UfFJ81DqMuznHo0liTuqnO8M86jv0tr/mq0
 t8mXYig9rvbX/rgOhK39A+cNjZnpwALsYIOmDlfTJqBFR0yIcLnTI7FAq6FGQPWPxI9a
 EF2gfqNOzP5y96aqTk1GcSYy+I5yvXUdUU7iX9pIqiaHx7KaualsVxeeGZRzwy4eaPkm
 1oMr5M77HIe24y4Y3DhWjs/xDXE8D8COFskQ4HZ1xBOXmeIRs7m8irG4C6JvGpXlFpUc
 xVoXxiypoazY2iJNp1+FcjQ1oJRZ8eNvSoln8F0N4HxA5eAy1XDqIK3r0arLfNRNsj1A
 vXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455359; x=1796060159;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KNSmTusk6MtgDxFsQZ76la9YnileylMKg7jiXqVJZdo=;
 b=UId8V+A/KbjVHx5gYGNJDoeaT758xgFbU2Z8muPjkUIBicvXOcyai5OKSakqhi/VaZ
 ig+F3mEV7Zz280dvc7GhLO+KW0ynwCJCj1kWagPCpo7BzkiYB6NxGrZvCgTj3D8gKSoP
 70wn5Z7TM6XH03MFhlmxTvv0Mzy0/OTmXgPP803fwGeGTvtcmmLmNUzyIWSjB3334IW6
 NwW61xK0V8qE+rLA45SS71xo99ZGFyTSx5VLYLT4GDJo4SdN33nD2hF89PV13qgn1QqF
 G9HCNw37Bs0GfIw/aGm05kQGIeYhEu2E2udHUttf9udCcQZY+YyR7yT/mb7sW90oKK8q
 Jkew==
X-Gm-Message-State: APuU4Z+z3zZn48ch5P08vCXbf7uZPxKfrVYnvS9KgceiLNfsnQ9F1IGh
 vKpD6bftPFYHKXo3JFRp5yaPxhppkT/XZUenE+akrsB6173O3YegqZrLOWcKAHROXdPapQRDM13
 B6zm84g5qpEpUT+37fn30ajMgtXMk2qQ=
X-Gm-Gg: AZFdTZfdgbYH9Oq+eeM+ywmbp7QwXHwVxupjMO1sdi0aRvcGkdoh37CjjT24qQ1j5qg
 IhkTZ9h95u4p0TZ738F2WapMzU0peexPnJ9CoJcujBz4fOpH0RogvlSU4lgWpa9YnuQkchtpzSV
 Nvfb+Z4trO3iRyceXCmL/TyfTU0T2yTA2fN4lsdTTYArKawpS+KTf6PiQL5NeByt+rcCnEg9ai3
 n/VTqKBNx0ZQbeaLRWQiF+hjO5VeTjdpvS9LEr9B9/EZapu3+tPbQquQiIEUiWwVFXwP5gtD7ph
 o666fPocOBZy/KIteEmEZ+y3YrThrhekNfzMuBdv/UXoiOLko1GJaNQDLN6az4xI/7c7hIKbZUK
 hiJul2u6xGDkH76+a2b6UK027n8T7G5SI0AHH
X-Received: by 2002:a17:906:4194:20b0:c4d:31ad:f641 with SMTP id
 a640c23a62f3a-c513a47d3e3mr755566966b.3.1795455358761; Mon, 23 Nov 2026
 09:35:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
 <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
 <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
 <a7390f3e-f6f1-4617-b7a4-df253673abe3@cherry.de>
 <CAC928HZjdBO1W7_X_+VKHh0fxoBoQahW9nRBfdf4PYMNAmompA@mail.gmail.com>
 <95ab24b7-5cfd-4ac6-8a63-f6fe820e1dff@cherry.de>
In-Reply-To: <95ab24b7-5cfd-4ac6-8a63-f6fe820e1dff@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 18:35:47 +0100
X-Gm-Features: Aa3M54panRwlWb1puEMlRYBi6hlxR0L7_z-A_b3yzGUuWoaRmmrlXVBC8sdxgcU
Message-ID: <CAC928HZD3q-Yr8XnPHuc2XDsxtw27dtwjGC3KiQ0KziaBmyznA@mail.gmail.com>
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
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno lun 23 nov 2026 alle ore 10:56 Quentin Schulz ha scritto:
> Hi Massimo,
>
> On 11/20/26 8:53 PM, Massimo Pegorer wrote:
> > Hi Quentin,
> >
> > Il giorno gio 19 nov 2026 alle ore 16:14 Quentin Schulz ha scritto:
> >> Hi Massimo,
> >>
> >> On 11/19/26 2:23 PM, Massimo Pegorer wrote:
> >>> Hi Quentin,
> >>>
> >>> Il giorno mar 17 nov 2026 alle ore 17:40 Quentin Schulz
> >>> <quentin.schulz@cherry.de> ha scritto:
> >>>>
> >>>> Hi Massimo,
> >>>>
> >>>> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> >>>>> The PX30 and RV1126 sdram drivers support more sdram types but only
> >>>>> one type at a time, really. The type to support is selected through
> >>>>> RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
> >>>>> more than one of these options is selected, instead of relying on a
> >>>>> debatable and embedded priority order to choose the one to support
> >>>>> among the selected.
> >>>>>
> >>>>
> >>>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>>>
> >>>> If we add ROCKCHIP_RK3399 to the depends of
> >>>> RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think
> >>>> we should add a similar check in the rk3399 driver to refuse to build if
> >>>> there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3
> >>>> enabled. What do you think?
> >>>
> >>> Unfortunately I did not come to a clean solution for the RK3399 sdram driver
> >>> "singularity". At least, not enough clear for my taste. So I left untouched,
> >>> open to discussion.
> >>>
> >>> Let's suppose we also have ROCKCHIP_RK3399 in the dependencies of
> >>> RAM_ROCKCHIP_LPDDR3 and RAM_ROCKCHIP_DDR3, something like:
> >>>
> >>> config RAM_ROCKCHIP_DDR3
> >>>           depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126
> >>>
> >>> config RAM_ROCKCHIP_LPDDR3
> >>>           depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399
> >>>
> >>> Some compile-time checks in the source code can easily be added to raise an
> >>> error if LPDDR4 is selected but it is not the only one, or if none is selected.
> >>>
> >>> The point that annoys me is that, in RK3399's case, the two options
> >>> RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR3 are the same thing, in the end.
> >>> If it would be possible to have their values coordinated, I would be happy,
> >>> but I do not think it is. Using the Kconfig 'select' statement will force
> >>> one to be true when the other is selected. But unfortunately, this does not
> >>> work when unselecting options. So, if one is selected but the other is not,
> >>> what should we do in this case: raise an error, or silently ignore it since
> >>> it does not affect the build?
> >>>
> >>
> >> I think it's fine if we have DDR3/LPDDR3 selected but will use
> >> LPDDR3/DDR3 based on Device Tree. We can make them really mean something
> >> by gating LPDDR3-/DDR3-specific code, but I'm not sure it's that worth
> >> it right now. Something worth investigating if we need to shed some
> >> bytes in TPL/SPL.
> >>
> >>> An alternative could be to use an RK3399-specific config option, something
> >>> like RAM_ROCKCHIP_DDR3_LPDDR3 but... ...it's quite disgusting.
> >>>
> >>
> >> Nope, don't want to go this route :)
> >>
> >> Another option is to make the RK3399 driver capable of handling
> >> LPDDR3/DDR3 AND LPDDR4 at the same time (no autodetection of the
> >> populated DRAM type, still read the type from Device Tree), then it
> >
> > This (driver capable of handling all types at the same time) seems to me
> > the most reasonable due to the fact that, indeed, the SDRAM type and
> > parameters are read from the Device Tree.
> >
> >> becomes less of a headache. You can have LPDDR3/DDR3, and/or LPDDR4, and
> >> it gets easier in the Kconfig symbols.
> >>
> >> I quickly came up with (didn't test aside building):
> >>
> >> """
> >> diff --git a/drivers/ram/rockchip/sdram_rk3399.c
> >> b/drivers/ram/rockchip/sdram_rk3399.c
> >> index 6fa8f268770d..22d196f1bec7 100644
> >> --- a/drivers/ram/rockchip/sdram_rk3399.c
> >> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> >> @@ -1632,7 +1632,7 @@ static void set_ddr_stride(struct
> >> rk3399_pmusgrf_regs *pmusgrf, u32 stride)
> >>          rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
> >>    }
> >>
> >> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> >> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
> >> defined(CONFIG_RAM_ROCKCHIP_DDR3)
> >>    static int data_training_first(struct dram_info *dram, u32 channel, u8
> >> rank,
> >>                                 struct rk3399_sdram_params *params)
> >>    {
> >> @@ -1723,7 +1723,9 @@ void modify_param(const struct chan_info *chan,
> >>          clrsetbits_le32(&denali_pi_params[76], 0x1 << 24, 0x1 << 24);
> >>          clrsetbits_le32(&denali_pi_params[77], 0x1, 0x1);
> >>    }
> >> -#else
> >> +#endif
> >> +
> >> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> >>
> >>    struct rk3399_sdram_params dfs_cfgs_lpddr4[] = {
> >>    #include "sdram-rk3399-lpddr4-400.inc"
> >> @@ -2964,9 +2966,11 @@ static int sdram_init(struct dram_info *dram,
> >>          }
> >>
> >>    #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> >> -       /* LPDDR4 needs to be trained at 400MHz */
> >> -       lpddr4_set_rate(dram, params, 0);
> >> -       params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
> >> +       if (dramtype == LPDDR4) {
> >> +               /* LPDDR4 needs to be trained at 400MHz */
> >> +               lpddr4_set_rate(dram, params, 0);
> >> +               params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
> >> +       }
> >>    #endif
> >>
> >>          params->base.num_channels = 0;
> >> @@ -3067,19 +3071,23 @@ static int conv_of_plat(struct udevice *dev)
> >>    }
> >>    #endif
> >>
> >> -static const struct sdram_rk3399_ops rk3399_ops = {
> >> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> >> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
> >> defined(CONFIG_RAM_ROCKCHIP_DDR3)
> >> +static const struct sdram_rk3399_ops rk3399_lpddr3_ddr3_ops = {
> >>          .data_training_first = data_training_first,
> >>          .set_rate_index = switch_to_phy_index1,
> >>          .modify_param = modify_param,
> >>          .get_phy_index_params = get_phy_index_params,
> >> -#else
> >> +};
> >> +#endif
> >> +
> >> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> >> +static const struct sdram_rk3399_ops rk3399_lpddr4_ops = {
> >>          .data_training_first = lpddr4_mr_detect,
> >>          .set_rate_index = lpddr4_set_rate,
> >>          .modify_param = lpddr4_modify_param,
> >>          .get_phy_index_params = lpddr4_get_phy_index_params,
> >> -#endif
> >>    };
> >> +#endif
> >>
> >>    static int rk3399_dmc_init(struct udevice *dev)
> >>    {
> >> @@ -3098,7 +3106,21 @@ static int rk3399_dmc_init(struct udevice *dev)
> >>                  return ret;
> >>    #endif
> >>
> >> -       priv->ops = &rk3399_ops;
> >> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
> >> +       if (params->base.dramtype == LPDDR4)
> >> +               priv->ops = &rk3399_lpddr4_ops;
> >> +#endif
> >> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
> >> defined(CONFIG_RAM_ROCKCHIP_DDR3)
> >> +       if (params->base.dramtype == LPDDR3 || params->base.dramtype == DDR3)
> >> +               priv->ops = &rk3399_lpddr3_ddr3_ops;
> >> +#endif
> >> +
> >> +       if (priv->ops == NULL) {
> >> +               printf("no ops found for requested dramtype (%d)\n",
> >> +                      params->base.dramtype);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >>          priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
> >>          priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> >>          priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
> >> """
> >>
> >> Of course, we need to update the existing defconfigs to reflect that
> >> change as !LPDDR4 used to mean LPDDR3/DDR3 but not anymore. An
> >> intermediary step could be to have DDR3/LPDDR3 default y if !LPDDR4 so
> >> we avoid changing the defconfigs with the driver patch, and then remove
> >> the default y in a follow-up commit by making the rk3399 defconfigs
> >> enable the appropriate one (easy to find based on the Device Tree they
> >> include).
> >>
> >> Finally, with the above diff, you can technically build the RK3399
> >> driver without any of LPDDR3/DDR3/DDR4 enabled, which can be remediated
> >> by an ifdef check at the top like you've done for PX30/RV1126, just that
> >> we *want* to check that their sum is NOT 0, anything else would be fine.
> >>
> >> What do you think?
> >
> > I look at the RK3399 driver code and at its repository history to provide a
> > well-founded answer and... honestly, it seems to me a mess. The driver was
> > born to support all SDRAM types at the same time. Then the LPDDR4 config
> > option was added by commit b6cf08949d4 because "Supporting LPDDR4 code support
> > in RK3399 would increases the size of SPL/TPL", and the related ifdeffery
> > followed. But a lot of LPDDR4 code was already there, and has been left in the
>
> RK3399 started with only SPL supported. Then TPL support got added but
> only for some boards, c.f. RK3399 Puma switched to TPL in commit
> 2169e29c5a1b ("rockchip: puma-rk3399: migrate to TPL"), "only" four
> years ago. SO I think the size argument was reasonable for SPL as it
> probably was already quite big, even for RK3399.
>
> > common area, instead of being reorganized properly. Seems everybody added on
> > top, instead of looking to redesign the driver.
> >
>
> That's usually what people do. Doing bigger reworks are not very fun,
> and take longer to be reviewed (and sometimes are outright rejected).

Really? That seems to mean I am quite an "unusual people". I find big reworks
much more funnier than adding a few lines on top of chaos: I need to spend a
lot of reasoning and testing to make the simplest thing work well on top of
chaos. And I will have to spend all of that once again, if I will need to add
a few more lines just a few months later.

>
> > What happens if the driver is built for LPDDR4 only and the value of dramtype
> > read from Device Tree is DDR3 or LPDDR3? Or vice versa? The simplest thing I
> > would expect is for the driver to print an error and stop. It doesn't. Instead,
> > it goes on, without happy ending I suppose.
> >
>
> Yeah, it likely will try to init the DRAM with completely misconfigured
> DRAM controller.
>
> > Another example: looking here and there I came across the gstride_type variable
> > in the calculate_stride() function: is it there something magic I cannot
> > understand? I see a local variable initialized and then used for comparisons,
> > which are all necessarily false.
> >
>
> Yup, and downstream also has the same issue, c.f.
> https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ram/rockchip/sdram_rk3399.c
>
> > In the end, I wouldn't touch it. But if you prefer, I can integrate in this
> > series the changes you suggested above, adding the defaults y if !LPDDR4 and
> > the check for NOT 0.
> >
>
> There's probably a lot of cleanup we can do. I'm suspecting the removal
> of gstride_type won't do anything to the size of the TPL/SPL as I would
> hope the compiler identifies those always-true and always-false
> if-blocks and removes the if check, or the block entirely. It would help
> with readability though.
>
> Up to you, I can also simply send a series with this done myself and you
> can rebase your changes on top. What do you prefer?

I prefer to merge your suggestions in my series, not to fragment topic in
more pieces and to limit patches management effort. A v4 will follow. I will
add a signed off tag with your name too: correct? Thanks.

Regards,
Massimo

>
> Cheers,
> Quentin
