Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423260A6F47
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HO9EPHJ8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQpcMRj/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86123811A6;
	Wed, 11 Nov 2026 17:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LTX654n5Q2a2; Wed, 11 Nov 2026 17:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5796811A9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794419769;
	b=qEi8Im0k+Kwqzs36u6x8iJGRZlXUB6p66B5+L2xdcBQivAau9L6pSMzJ2yf2+mwHotXX
	 Gr0ybwNGjYiExrDVIlt04hUSbuADQGadSzeXBvJuUVVU7fZNBWZk9j72y9ETooQTQNJSg
	 C/g7z+9UJu8KB7QINDIhVTPvlnCLKODJ6LLwPn3MCOi4jao0bUT58BkdHVLzpnLTwHEpN
	 O24plHPzRbL5XS+2B5KhTfvDi5KmiKrx9G8PxdfOVkJ73+Rb0gY/w8bfjLaHQwkJjBrb5
	 WAjditAnY5Gz4J2vhE1E3EzCsyv11GAKSNaP2KBO4GG0Keo/sAZjKUVFvd75XIRj5og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794419769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cEQqTCwspfbOX/lovVsRxTBmy4aRnLECnxNx8LQY5Pc=;
	b=kjUyOThIlCA6IbuF6uDQLSYTftkTRlAxhJhEHoVCRikRgqX7iMA5DHQ/Bs2Y8K81pydS
	 lREAnEYA0GoxNiEob39o0xdXdkJlyYmowS1A5+qpQZGs+x/R01QM8S5fD+hECdMnD1gCH
	 PZbI+EjJEx3Fu5PNGRyNHMb6pxLwbqfLonLmK1w0Y1cyHXEy5sRJrId3RoiHCx5xDAFGR
	 hzt+77iFJHaZfUc5POWG5cryByZwMdPaduaEOR31SWapiLg+OiqAy7l268NfOIJtmOukJ
	 E5vi/DmfrYqMSBvs3J/esMmBlRvNagFYJ0XPOW9XsLVXmhSo6PYGLT0Y4L7CTRIKr6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794419769;
	bh=cEQqTCwspfbOX/lovVsRxTBmy4aRnLECnxNx8LQY5Pc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HO9EPHJ8q3ecGJAxxVKmn73eFg9wO3t0GlCRbNUBCamDWh5ZofsG5E9qvXJgY3U76
	 NnhH2qMyk74d93drjLempdH9xUb9nY+8vReDVo3Qe35niSBDMVRVxNOw6mZ7FKSLtr
	 VgrMCPQ/ritwAHq/5t5EbVwLuE+y2Rax2Qd4BKsKrPy5S3SbopvsdZu68GLqz8YZpe
	 pv3Cj+fPMveNKc+EWAM3X10swwwNQW9/MSiS76vWMYu3vHNjYXNNf2JP1KfBhBWkt6
	 Qf6HVBz5FqDlSB1OBOmRTiuQPNwI/hE1qR0U58Oydx+ElCDV6VRV68E8lYRysrpZKe
	 XvnHrBh6TR/8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5796811A9;
	Wed, 11 Nov 2026 17:56:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF399F22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B533140381
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmulHM1mPyxG for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 17:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FB1140360
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NQpcMRj/
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FB1140360
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:56:05 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c505b2e1cb9so269152166b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794419764; x=1795024564;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cEQqTCwspfbOX/lovVsRxTBmy4aRnLECnxNx8LQY5Pc=;
 b=NQpcMRj/MNOHWoCBmwIvlxe2lbxHPcTIwZ+nSX1qTyx9svSV0FC6SOZncyuuwBH6nl
 IHPK84SwO58jz8AVc3kLRcxZfwqyIFq4rJkvdj0OBLmrXmrzIzxsx9S8zEPs8dMNdEdi
 mCHCMctIxdUTg9AfjLZVrPCtBbJ1UCFwK1pZBt0gdkcE4tpds/wCZMQB+2ydRx8uhhA+
 XswxBZJEYweSTrClRdddx8Ec7MjCje+mXT95+f/S345m2q04itBhv0sC7hFUZ15rCgTv
 asMF3tOk+ukr9nwRoYk/UEm1V3QpUSlzyygMvZJalP704+2B0VNvQVCBkiqhZrwou/c7
 GYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794419764; x=1795024564;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cEQqTCwspfbOX/lovVsRxTBmy4aRnLECnxNx8LQY5Pc=;
 b=2C3GXI0MVNGdL2ioBV2kFlvPyF8OVbIzds/CTfcXAfASDHNhwvC/pbDm8ovFc7YtOv
 qY6vJoX2q9hlW/vXYkN0AUBOKTfBMstikJhVo02kx/jMC17o9YtjvXsL0yEz6rpaN3LC
 B//Q7hmyVT2FhVTIUK24ceaYxn0vZNi4dST/vQafgL0iljF4I6eP0hBYRxUoikzU43ba
 Cwo56w37ZJoOA3MFugLRSkrLYVY4415M/TkShVP7WfbuJtfmjHGat4rGVd/Lxv3M2cYv
 2rYPtAFRVB7rb8Deu2dBSV7l83J6xVhynTARQyCD+w8S1/m33I2tRWCkc5J0Nwz1yHOO
 K2vg==
X-Gm-Message-State: APuU4Z+mvMREenSW+XM5rHO8t15d240UZ9vPos8XEcxaHVWJFQQLM6/o
 p7Fi7o0jsNWwWMfMxr1/i1xv4M/gLq1R5kS7pMF38I1mIe4NEWkZsYPn1HtgohWOGXPi/1dVdh7
 iXQmaZBZopml/tIcDtlGhh2YSUJiDU4j+agc/
X-Gm-Gg: AYBFou0qZyNlYNWnSvcG8k3d5DQrF5i7ekbZe51uoD7/y7iCGuMkwCpmK2BuRYGLLEw
 qQPaHtgq8R7Zn445kPcI93GZUn+Muc0OXUB4Pd0Uf1GEOliQwa6+0tXSBmQT6N4Ew+0CM/CxEnC
 y7hIlIxVVxD50viH+TWomhrbwCKmN2vfPVxfTaL5I74YHOCAOy0CfpiIN9eWPxyra3C9lffNSg+
 8zKLVrz5bMTVj1dYVo0DJTrW8WTZ1BWPz/bwdGCoNP5d09QQOWEjxB58p8nXX20gAncZQklWQZi
 72vtqasiKwmmjgANytOHOKK+HpnNhWsvSsi2v13Kt5r4aXuroAs+bpqfhCNMo4VQA5HLfDcqdKZ
 6qjsM2MH+ilhu63yXDNgaYrcHO9qF1J2wH3oN2Q==
X-Received: by 2002:a17:907:60cd:b0:c4c:eb17:3da with SMTP id
 a640c23a62f3a-c5066ad897cmr227842366b.22.1794419763617; Wed, 11 Nov 2026
 09:56:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
 <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
In-Reply-To: <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 11 Nov 2026 18:55:50 +0100
X-Gm-Features: AclHuK8nK6M_WbZpSlk7PCJbYYVeRpPs6BtjpSPdYb1YgZOwdEMpLoXpiDqQ0wY
Message-ID: <CAC928Hanm2_mSEo3vuLnDQnHZ9uXTbV9pMmHfhXne7H3ONor=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ram: rockchip: px30: allow multiple SDRAM types
 selection
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Joseph Chen <chenjh@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mer 11 nov 2026 alle ore 16:41 Quentin Schulz ha scritto:
>
> Hi Massimo, Joseph,
>
> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> > Allow the inclusion of more than one SDRAM parameters set in the PX30
> > sdram driver. The driver applies included sets in alphabetical order
> > (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
> > SDRAM initialization function to complete with success. This order is
> > debatable and not based on any specific reason.
> >
> > Due to limited PX30 TPL maximum size, including support for more than
> > one SDRAM type can require disabling some configuration options such
> > as CONFIG_RAM_ROCKCHIP_DEBUG.
> >
>
> @Joseph, can you help us out here?
>
> We are trying to do the same thing that px30_ddr_333MHz_v*.bin from
> Rockchip's rkbin is doing: do DDR initialization without knowing which
> kind of DDR is soldered on the PX30-based device. Is there something
> special we need to do or know? For now, we are trying to initialize with
> DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, then
> LPDDR3 if all fails. The first DDR init that doesn't fail is deemed
> successful. I do not know if this is correct, can you please provide
> some guidance?
>
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
> >   1 file changed, 17 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> > index c7ff924b2c5..7f51b9c4f8f 100644
> > --- a/drivers/ram/rockchip/sdram_px30.c
> > +++ b/drivers/ram/rockchip/sdram_px30.c
> > @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
> >
> >   struct dram_info dram_info;
> >
> > -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
> > -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
> > -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
> > -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
> > -#error "This driver only supports one DRAM configuration at a time"
> > -#endif
> > -
> >   struct px30_sdram_params sdram_configs[] = {
> >   #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
> >   #include    "sdram-px30-ddr3-detect-333.inc"
> > -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> > +#endif
> > +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> >   #include    "sdram-px30-ddr4-detect-333.inc"
> > -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> > +#endif
> > +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >   #include    "sdram-px30-lpddr2-detect-333.inc"
> > -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> > +#endif
> > +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >   #include    "sdram-px30-lpddr3-detect-333.inc"
> > -#else
> > -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
> >   #endif
> >   };
> >
> > +static_assert(ARRAY_SIZE(sdram_configs) > 0,
> > +           "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
> > +
> >   struct ddr_phy_skew skew = {
> >   #include    "sdram-px30-ddr_skew.inc"
> >   };
> > @@ -691,19 +688,11 @@ out:
> >       return ret;
> >   }
> >
> > -struct px30_sdram_params
> > -             *get_default_sdram_config(void)
> > -{
> > -     sdram_configs[0].skew = &skew;
> > -
> > -     return &sdram_configs[0];
> > -}
> > -
> >   /* return: 0 = success, other = fail */
> >   int sdram_init(void)
> >   {
> >       struct px30_sdram_params *sdram_params;
> > -     int ret = 0;
> > +     int ret = 1;
>
> @Massimo: question: why the need to change ret to 1?
>
> Because the driver enforces sdram_configs array to be non-empty, we're
> guaranteed to do at least one loop and thus ret is guaranteed to be set
> properly.

You are right, the static assert guarantees ret to be set at least once.

For variables - and logic in general - which are in the local scope, I'm used
to rely as little as possible on conditions and assumptions out of that local
scope. But I respect different opinions and approaches, so if you prefer I can
drop the initialization at all, or restore the zero init.

By the way, in the original code, which is the need to init ret to zero? In that
case, there is a local scope evidence and guarantee that it will be set before
using.

Regards,
Massimo

>
> Cheers,
> Quentin
