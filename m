Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D39606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jrp82pPv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VjPdTPQr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6ADA40798;
	Mon, 16 Nov 2026 18:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2fzbMUln7SF; Mon, 16 Nov 2026 18:44:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76297406B9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854643;
	b=W24qF2Ns/5rqJis3iuchlzIq7zGQljkdyYJUZ5/EFpYrjkAOrNLaA4zkpl+frdeesbwJ
	 N1rt1b9AGn6OR6rfGLaqdN8QHkm1sZTc2y12ScZOsQL9s43I4p6jTetdl9DU5vdpMwZt4
	 8pzfqVa1O954p+vS83AsGPr9+elXdJVVnUyWrruHiNdxnHeKPsycA5d86z7FYpp32lcx9
	 7PsBINTlziDbItdgSbJ7Drg5leNabvr0m+qAa5UoTNdmV2MkkN6A/heDTJN1lOsQ9xLII
	 LB5+2DRoqgurP0kQxJd23WgKPY5CGDGIXM32C3p+6t6WRXFdmAsYaQoZNtEg42IK8lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TJIJP4QK0ZyVyjYOU3WngalLBorcLpw5wW0vz4JX+uM=;
	b=eOL+/ijPfGqWi23fBF89LifLAT6nkdpQZoDRyLWi+WVyJIkpQihVK+2TTugWTCU85VF1
	 0DQGDOHKk624Qj6bnpMHNksuGPUGTVXHUpwy7ciuO3cLRFP5qK0ebf/bcogfa8b3UYtmp
	 A/LYQbhyxparWngDvd1n4NaJeKzVli8IeOUYRbds0KtlEBnVJBbAkJyzi3f91O3vm0bVn
	 9Sufm/kJiVMSVamOnNow4HgK7Y+LBkNZDOs9N45SUl8ZssAB8Rd/fY9eSfRr8kcYqLU4G
	 0L3dyp2nqh3TgNPjyeaMgfz/lzv6BW7zzqPZSuM5v2agmkbM3OgxY0yFzx9eahfVW3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854643;
	bh=TJIJP4QK0ZyVyjYOU3WngalLBorcLpw5wW0vz4JX+uM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jrp82pPvkXt7LPti41dPEffVCKnutOeKN7l71wjAnUoiV8zIZbLQvOvqw0VPYeA1P
	 dQtaZyobi+Vci6RqMrCGvJkV+NhHLTswjt8QgChx+wpl9zrktd17nUE7wED7Xp7eNy
	 YrzPLBkEZSbsR77+4qvhmJcvCggf0fyRTI4rocm9n5bcgsoctwlR+xlu7gb+K5JzaY
	 t6QLdgZTNKQTNHzBK3aaD8i1UCQA9N/S7oMhz2OWqtG5rJOGI16H/6aS/8aIJZMfFC
	 Zv4LbWd4HnL86X1nP0Hy0yU6g7rFi52MX3A3Y6NAuMuVWHb4TtRXREqOIomh5RznCd
	 /Md/Qr+Y0gaBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76297406B9;
	Mon, 16 Nov 2026 18:44:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF42E13C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0FDD60601
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLIBZK7X9JHM for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E375605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VjPdTPQr
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E375605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:44:00 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so669912566b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794854639; x=1795459439;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TJIJP4QK0ZyVyjYOU3WngalLBorcLpw5wW0vz4JX+uM=;
 b=VjPdTPQrkMgKaWg6ybMxMjKIWDQKxL225+0yA3TZD5f3eHA7AhPoLkphqODop2Spr4
 1R8TKuWGSO+QcnCsiIL+EUHA2DHSViRsipxiVhZM/3EiDaYijJIRbm07z6ShIWs9fzey
 t3jO+JbgrcbvaDBY0Bd0eD9V8gdEReM5Fp0Q7CB+TtmHLbXKTws3KAqNYimZNWahJ2HC
 lzbQhfWm7rhB07C/wj2jZNNWtpzav/GBIPR4emW1e9hcREV5IFWNfmDIEn52Xs0fDunc
 POfn5cy7Vz4CNzZShMtMQIK28s2HtC2WjYpyzwIgMxn2zJ42bRvzIC7FGj/G9rc0gRSB
 giSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854639; x=1795459439;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TJIJP4QK0ZyVyjYOU3WngalLBorcLpw5wW0vz4JX+uM=;
 b=KsIE/FlyMfH5m9ZJ8jvng7e5bJjxPb/9fXTDBriaWKc+8iDeck/KWq5wMrSo+42JFH
 wi52mZ8R/LQT6nVDfLp+67lPfQh+vKRU5oXQSzm4Eh4fWyF3Da88h+xzhWXMfNkIHFJS
 FS3/pe516/LAIo5cyFIBZl5KoEjhJR1nwBnfCNRf6YgIZnjRPeX5An9HKd1HVqwvi2P4
 ghoMF4/+QNAYweY8ElQQz3iGXU6sQ6BuxSiYzzi/TJUrLUspJJ2yqYq/UlvC/xZgtNtM
 sI/vwhs7KZGVteyskNnZXINGePlGYJSsjkoaEO9wi7X1TQ/Z8z0L62QnZQEH3p2tpezj
 mgOA==
X-Gm-Message-State: APuU4Z9Kx7u78EuutsNa3ATtREHN2Ejvbm8IdEOQ61IMe3Dg+cz9Wjao
 T8BkcqPtl6rjh4fl9b2rsDmKJ3zZ7b0I8JWoiurrxUqcxXu20wJ5mnbtqRcgB/TEJySjPQ64Kvw
 0Pyk1Pat+wj71tyso/390OGL3npQQ6wg=
X-Gm-Gg: AYBFou2n/rQ4vhmnY3IaAKgI+XSdd14/99D8Hz3pBdQYJX4sfxUm92hWOt9M8NAYykg
 VQO3voMfS0kyXNfkieArCtcHYS2WQjNaqvX7Vwv1LNjPmVuQQtFHIqcictApGsPRuLFWcOjTp6Y
 xdG5xDqZpd0rgGElt4+aYLX/Jb5cYd1F09gzTBg39tc8c5ImKToTfNapNfoSDkGhceSVRH+RZ0q
 QRSTSjNjX5RdtXt7YyCSbEwyYF3Wrt8mFqL/L8xgxFmwPa2DruBJX10mB9V7gh8lZScno//C2DX
 TNP1zEalGhWl5Gr2h3Llw3AYeMtJZ+Ka67ppjXeRjj0ktrnOMTBPHIdrUl+ok4rOcdm4gTT34BV
 wp/rvdAC5TuhNMsEE5cPKEpgTtA7BpKR2tmnT4w==
X-Received: by 2002:a17:907:9349:b0:c50:4720:4aec with SMTP id
 a640c23a62f3a-c5096398b9cmr886953666b.12.1794854638890; Mon, 16 Nov 2026
 10:43:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
 <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
 <CAC928Hanm2_mSEo3vuLnDQnHZ9uXTbV9pMmHfhXne7H3ONor=A@mail.gmail.com>
 <cfb5d923-8148-4087-a090-a20077a4a627@0leil.net>
 <CAC928HZvN5daTputdUxkZOkGPz-d4icga9sj+CzxtE0W6w4bsA@mail.gmail.com>
 <57d42d3e-6b0c-40af-a16d-0643e4e63a72@0leil.net>
In-Reply-To: <57d42d3e-6b0c-40af-a16d-0643e4e63a72@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 16 Nov 2026 19:43:46 +0100
X-Gm-Features: AclHuK_9kc974EXQkJJrdDdpnua6KuZAaZfhne4Ddk7mNLosGnAA-5sKeDMd5rI
Message-ID: <CAC928HZZhHyCyVi=DV6XGQGrtywwhfP4CMYeE1k-AESjH-jozQ@mail.gmail.com>
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

Il giorno lun 16 nov 2026 alle ore 11:32 Quentin Schulz ha scritto:
> Hi Massimo.
>
> On 11/15/26 11:32 AM, Massimo Pegorer wrote:
> > Hi Quentin,
> >
> > Il giorno mer 11 nov 2026 alle ore 19:08 Quentin Schulz ha scritto:
> >> On 11/11/26 6:55 PM, Massimo Pegorer wrote:
> >>> Hi Quentin,
> >>>
> >>> Il giorno mer 11 nov 2026 alle ore 16:41 Quentin Schulz ha scritto:
> >>>>
> >>>> Hi Massimo, Joseph,
> >>>>
> >>>> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> >>>>> Allow the inclusion of more than one SDRAM parameters set in the PX30
> >>>>> sdram driver. The driver applies included sets in alphabetical order
> >>>>> (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
> >>>>> SDRAM initialization function to complete with success. This order is
> >>>>> debatable and not based on any specific reason.
> >>>>>
> >>>>> Due to limited PX30 TPL maximum size, including support for more than
> >>>>> one SDRAM type can require disabling some configuration options such
> >>>>> as CONFIG_RAM_ROCKCHIP_DEBUG.
> >>>>>
> >>>>
> >>>> @Joseph, can you help us out here?
> >>>>
> >>>> We are trying to do the same thing that px30_ddr_333MHz_v*.bin from
> >>>> Rockchip's rkbin is doing: do DDR initialization without knowing which
> >>>> kind of DDR is soldered on the PX30-based device. Is there something
> >>>> special we need to do or know? For now, we are trying to initialize with
> >>>> DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, then
> >>>> LPDDR3 if all fails. The first DDR init that doesn't fail is deemed
> >>>> successful. I do not know if this is correct, can you please provide
> >>>> some guidance?
> >>>>
> >>>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >>>>> ---
> >>>>>     drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
> >>>>>     1 file changed, 17 insertions(+), 23 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> >>>>> index c7ff924b2c5..7f51b9c4f8f 100644
> >>>>> --- a/drivers/ram/rockchip/sdram_px30.c
> >>>>> +++ b/drivers/ram/rockchip/sdram_px30.c
> >>>>> @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
> >>>>>
> >>>>>     struct dram_info dram_info;
> >>>>>
> >>>>> -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
> >>>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
> >>>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
> >>>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
> >>>>> -#error "This driver only supports one DRAM configuration at a time"
> >>>>> -#endif
> >>>>> -
> >>>>>     struct px30_sdram_params sdram_configs[] = {
> >>>>>     #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
> >>>>>     #include    "sdram-px30-ddr3-detect-333.inc"
> >>>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> >>>>> +#endif
> >>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> >>>>>     #include    "sdram-px30-ddr4-detect-333.inc"
> >>>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >>>>> +#endif
> >>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >>>>>     #include    "sdram-px30-lpddr2-detect-333.inc"
> >>>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >>>>> +#endif
> >>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >>>>>     #include    "sdram-px30-lpddr3-detect-333.inc"
> >>>>> -#else
> >>>>> -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
> >>>>>     #endif
> >>>>>     };
> >>>>>
> >>>>> +static_assert(ARRAY_SIZE(sdram_configs) > 0,
> >>>>> +           "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
> >>>>> +
> >>>>>     struct ddr_phy_skew skew = {
> >>>>>     #include    "sdram-px30-ddr_skew.inc"
> >>>>>     };
> >>>>> @@ -691,19 +688,11 @@ out:
> >>>>>         return ret;
> >>>>>     }
> >>>>>
> >>>>> -struct px30_sdram_params
> >>>>> -             *get_default_sdram_config(void)
> >>>>> -{
> >>>>> -     sdram_configs[0].skew = &skew;
> >>>>> -
> >>>>> -     return &sdram_configs[0];
> >>>>> -}
> >>>>> -
> >>>>>     /* return: 0 = success, other = fail */
> >>>>>     int sdram_init(void)
> >>>>>     {
> >>>>>         struct px30_sdram_params *sdram_params;
> >>>>> -     int ret = 0;
> >>>>> +     int ret = 1;
> >>>>
> >>>> @Massimo: question: why the need to change ret to 1?
> >>>>
> >>>> Because the driver enforces sdram_configs array to be non-empty, we're
> >>>> guaranteed to do at least one loop and thus ret is guaranteed to be set
> >>>> properly.
> >>>
> >>> You are right, the static assert guarantees ret to be set at least once.
> >>>
> >>> For variables - and logic in general - which are in the local scope, I'm used
> >>> to rely as little as possible on conditions and assumptions out of that local
> >>> scope. But I respect different opinions and approaches, so if you prefer I can
> >>> drop the initialization at all, or restore the zero init.
> >>>
> >>
> >> Up to you, but if you keep a change to ret, have it at least -1 so it
> >> obviously shows when reading that an error is expected to be returned by
> >> default.
> >
> > Right. BTW, the line just above sdram_init() definition says:
> > /* return: 0 = success, other = fail */
> > ...so 1 should be considered a valid error return value too... ;)
> >
>
> Yeah but having this documented in the C file instead of the header is
> the wrong place, but fair enough :)
>
> >>
> >> You can also check if not setting ret doesn't actually save you some
> >> bytes in the final binary.
> >>
> >> suggestion: Maybe:
> >>
> >>          for (int i = 0; i < ARRAY_SIZE(sdram_configs); i++) {
> >>                  sdram_configs[i].skew = &skew;
> >>                  sdram_params = &sdram_configs[i];
> >>                  if(sdram_init_detect(&dram_info, sdram_params))
> >>                          continue;
> >>
> >>                  sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
> >>                  return 0;
> >>          }
> >>
> >>          return -1;
> >> }
> >
> > I will try some alternatives to find the best in size, thanks for the
> > suggestion.
> >
> > BTW, do you mean that I can also drop the printascii("out\n")? Really?! More
>
> Yes.
>
> > than six years ago Miquel Rynal provided a patch that Kever accepted [1][2]
>
> Probably was forgotten :)
>
> > but it has never landed into main (master at that time) branch really.
> > That "out" on console really annoys me!
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20200317153217.1493-1-miquel.raynal@bootlin.com/
> > [2] https://lore.kernel.org/u-boot/32e592dd-4a7e-ddaa-a4e0-e61686006a3f@rock-chips.com/
> >
> >>
> >> can make the binary even smaller without the need for the ret variable
> >> at all and removes a bunch of if conditions/jumps and is also valid
> >> without the static_assert on the sdram_configs array.
> >>
> >> thought: I'm also not sure why we have a global dram_info? If it's not
> >> needed, then we can have it as a function-local variable in sdram_init
> >> and initialized in one go:
> >>
> >> struct dram_info dram_info = {
> >>          .phy = (void *)DDR_PHY_BASE_ADDR,
> >>          .pctl = [...]
> >> };
> >>
> >> if it needs to be global, we can still initialize it in one go and avoid
> >> the multiple assignments in sdram_init.
> >
> > I have a few other optimizations, as mentioned. I will send a dedicated series
> > for them, after this one.
> >
>
> So... I would really like to have someone with knowledge about DRAM init
> in general (and/or someone at Rockchip) tell us how to correctly init
> the DRAM if we don't know its type before merging the "support multiple
> DRAM type at once and try all types to find one that works" part of the
> series. At the same time, I don't think we should make all improvements
> to DRAM init/drivers in U-Boot depend on that part being merged, so I
> think we can maybe split this into two series. One for preparing for
> support for multiple DRAM types, and one (a single patch I'm guessing)
> for enabling multiple DRAM types on PX30 so that it can take more time
> and not block the rest? What do you think?

Agree, no problem. I would have done before if this is the preferred approach.
Just sent v3 with the preliminary improvements only.

Regards,
Massimo

>
> Cheers,
> Quentin
