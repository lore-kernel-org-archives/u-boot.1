Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F6606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mdlvqi/4;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2lMixcZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B07660698;
	Sun, 15 Nov 2026 10:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krJ2rgYB3Ira; Sun, 15 Nov 2026 10:32:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 293F76061C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794738750;
	b=pOg0CcO7/3z6IT7HgIg1nZuVrsi2I3i8qGkmXNWbo99HwI3ZIvSHSGscR0L5+zVk6hQC
	 gaEKaUfZPcjXAMoxrrTKIK7PKZYtDbjfpfbZqwY2b1+a6Y5EZDtWv4NZtT+y/paCVonO2
	 Krg1/xhbtq3nD9m7K3NtHvmIG+UCU+ad7XhJlXMjuZJDih6a6TfVLgZsUUvjyB78Cml4K
	 bGg/cvyAce/ze8M7l4wMdGs4laNYQBaJ6js/4h3uTEljdQywo81kjYOqubAwzvrtEOyXq
	 ohPYD+P6VzF5almOZFupGKcqXO6Wvnj3p2TupAirlgvAWAtEBDVjrzFRjkJQ/iQ8IBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794738750;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HI9T+pbtCzZhkzubMSmbuiA9GiDX3KDnrGwDspM6d34=;
	b=ANg8g2AE1nsPGzvbl+DmL8YR+VXCTZtlbGcaOQIM+L22WlGFPAIGzIU5E7TyvfMvtMk3
	 HrvX8FdFPtY0YeedTIsTNWd2amv5U8jaL/SoSWVhsDHpPwE6nRQp1+1fHpdsFJ/PYalgU
	 5asLpoLDcVXab0mQRHX/vhmwnL6Vwt9Au8Wd6XzGgadJModdcR9RyqeFrOjX0HrBqsmRX
	 HSGIbs+H9wDlc8ElEdMaZGZV9fJ4mxRAthFDeoXCR+sSAgN1707vkCGVhjONJTukC7wHq
	 DDc82bZCXkf1avWvNzY8+LOPsFRKXO/6W9ykEdSq+Nu++5zB7aWxL/Og1Ml+hmZjZNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794738750;
	bh=HI9T+pbtCzZhkzubMSmbuiA9GiDX3KDnrGwDspM6d34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mdlvqi/4TMKz6sAZk21xqwyJYEQ/aqfkChZ87Xy0tIcOOnOcJeojAU/RYsv2tBq/t
	 lCYPfxulTwrN271W0GkeDbVDAr3wzwQpFr0dQW+pn9lJitqmcHophbT2REMT/BYfm+
	 rWj9+Qvfq+Yf2grcU461NpIzwktIWbiN+ScS/wtXsJHhyr8YZ/GLCyBgPI+w8ZXUZK
	 3JXCBrpXoR0wazy+XGwPyVk2yjPfti+NDLgq8o5IATuwewiNztKJMf+dlo6Zp8XWob
	 fdIcQvmC/1WWxIDA7PUHdFM5KUX+ozBxmEwX8j3f1anKJUwZuy+s59YonOmYClD8wm
	 QZzRQzXMX6aEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 293F76061C;
	Sun, 15 Nov 2026 10:32:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B58A2FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2B1840079
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0ZDJHc8rCuZ for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7089C40061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=U2lMixcZ
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7089C40061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:32:26 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50604721c8so434405966b.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794738745; x=1795343545;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HI9T+pbtCzZhkzubMSmbuiA9GiDX3KDnrGwDspM6d34=;
 b=U2lMixcZS+hyeV4IF4z3dlRzTkScqNOS8d+ciYC5C0qf2Les3Un1x9u6jp57G/Y+E1
 IwCajstgfPqpwmrdPVPtbMAosga1QjASnbe0Bva2ucf8anCmhrMutN8aaZhIgcLTlHVx
 oH+tCqDZNpjl2nAEGP08htxZCjlhZNuuWZSBglKvjYNzR+H/mNgb8c/ARHlD4dH1EZBX
 rZwpzsyoHystiPgGnrEMRZgxHkafDBB8dbMW9eq1V3U9EDkZjupssFO6OYb0eU8JcA5U
 J0jCgqg/eaWshKF+KxojS3oGyoLjA/DQaojG4FAiG5JGOPui4WfyExvp+ChBzEFRV9FD
 RioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794738745; x=1795343545;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HI9T+pbtCzZhkzubMSmbuiA9GiDX3KDnrGwDspM6d34=;
 b=XUTJliA1EqMPAsAPrJvMb83/XnIQjuks5+RcwQfGNELUTyMHf6j+BfKrq0QuwNbBJ3
 pmnkrhPDqqGHDg72fDNSLaJeUNStBu123ie3yKi8LrsK3f5zwX7wRtCnl59ngWefazqY
 8GJG6qRjkqc8xThYFu74IB2e47uRD8TNpC6DRr1/zsGmWNy9M1bwLUGIHlaxchlbyNQO
 t2owQyE9huTN+zdoyGnqA1K0bKL/bNiWDcYXiFy3cwg9W7mc1lroj9EwwFlGQKbv9Z6Y
 FPTcsf6X57J6SUNtjyN/ohZLJmLhxLQrIBeMBWFnwt5vyBx2qsdq0pMqwmLCcD57JZ4R
 7OBg==
X-Gm-Message-State: APuU4Z+hcvnKbcqWOyQOQxoPDWXQpYntG2gX55lSyGrlneawyVCRSMp3
 ZhAIWHF9EPHHonW2xKnRsUQSiuU1wOCUdrhFj8J8cwJg2LQU591/s2/hyE+k7Lakon0Y48v0AcL
 iAEOxHvk9AXhMPcDlu5Qy8zSxdDmiqJy1DA==
X-Gm-Gg: AYBFou0oFKTv+44rMxuTcEtaPtLhpkxVrBrcmwOt06sERdHxxEe+ZTUy7RPEFtxpDJc
 a64GvHNe1psyiX8UP+BiuDgiUuhtEeyEsj3sCiBue/vxzoHaLubK5q0NXfrX6LNOavlE4R7rGzN
 K1ZqY8X9IlIq5evwE1GUsfodT1fEBJOJAQPzXpzv8RJCMj14Ma320RsAlOVOjL6BPyQZpSpMPrd
 TT4vVTq4X7nOhRLqJczJL2NPIVVrYnLji2i+mz8GTLtKe5cx49/gmR2vfgRkqUoWXO7kwLt/9in
 9NmEi4PsXIT45+HeGjTVhSBYftalR+wTqEENmgBBJITgu+LbPb0+bzFt7BbPXARWlYNfYNJr1Tl
 27wvcvb23uT+JQdg1oJNJRGP8Rw0qr/AQXXm+Jw==
X-Received: by 2002:a17:907:3e8b:b0:c29:f5d8:9c78 with SMTP id
 a640c23a62f3a-c50964101demr588347266b.39.1794738744726; Sun, 15 Nov 2026
 02:32:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
 <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
 <CAC928Hanm2_mSEo3vuLnDQnHZ9uXTbV9pMmHfhXne7H3ONor=A@mail.gmail.com>
 <cfb5d923-8148-4087-a090-a20077a4a627@0leil.net>
In-Reply-To: <cfb5d923-8148-4087-a090-a20077a4a627@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 15 Nov 2026 11:32:13 +0100
X-Gm-Features: AclHuK9bzyarC-h_b99K3ipcMJIzsWV_kRkA4bAphgdwcz3n7NZo0Wp7azfIKZk
Message-ID: <CAC928HZvN5daTputdUxkZOkGPz-d4icga9sj+CzxtE0W6w4bsA@mail.gmail.com>
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

Il giorno mer 11 nov 2026 alle ore 19:08 Quentin Schulz ha scritto:
> On 11/11/26 6:55 PM, Massimo Pegorer wrote:
> > Hi Quentin,
> >
> > Il giorno mer 11 nov 2026 alle ore 16:41 Quentin Schulz ha scritto:
> >>
> >> Hi Massimo, Joseph,
> >>
> >> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> >>> Allow the inclusion of more than one SDRAM parameters set in the PX30
> >>> sdram driver. The driver applies included sets in alphabetical order
> >>> (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
> >>> SDRAM initialization function to complete with success. This order is
> >>> debatable and not based on any specific reason.
> >>>
> >>> Due to limited PX30 TPL maximum size, including support for more than
> >>> one SDRAM type can require disabling some configuration options such
> >>> as CONFIG_RAM_ROCKCHIP_DEBUG.
> >>>
> >>
> >> @Joseph, can you help us out here?
> >>
> >> We are trying to do the same thing that px30_ddr_333MHz_v*.bin from
> >> Rockchip's rkbin is doing: do DDR initialization without knowing which
> >> kind of DDR is soldered on the PX30-based device. Is there something
> >> special we need to do or know? For now, we are trying to initialize with
> >> DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, then
> >> LPDDR3 if all fails. The first DDR init that doesn't fail is deemed
> >> successful. I do not know if this is correct, can you please provide
> >> some guidance?
> >>
> >>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >>> ---
> >>>    drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
> >>>    1 file changed, 17 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> >>> index c7ff924b2c5..7f51b9c4f8f 100644
> >>> --- a/drivers/ram/rockchip/sdram_px30.c
> >>> +++ b/drivers/ram/rockchip/sdram_px30.c
> >>> @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
> >>>
> >>>    struct dram_info dram_info;
> >>>
> >>> -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
> >>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
> >>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
> >>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
> >>> -#error "This driver only supports one DRAM configuration at a time"
> >>> -#endif
> >>> -
> >>>    struct px30_sdram_params sdram_configs[] = {
> >>>    #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
> >>>    #include    "sdram-px30-ddr3-detect-333.inc"
> >>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> >>> +#endif
> >>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> >>>    #include    "sdram-px30-ddr4-detect-333.inc"
> >>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >>> +#endif
> >>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >>>    #include    "sdram-px30-lpddr2-detect-333.inc"
> >>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >>> +#endif
> >>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >>>    #include    "sdram-px30-lpddr3-detect-333.inc"
> >>> -#else
> >>> -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
> >>>    #endif
> >>>    };
> >>>
> >>> +static_assert(ARRAY_SIZE(sdram_configs) > 0,
> >>> +           "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
> >>> +
> >>>    struct ddr_phy_skew skew = {
> >>>    #include    "sdram-px30-ddr_skew.inc"
> >>>    };
> >>> @@ -691,19 +688,11 @@ out:
> >>>        return ret;
> >>>    }
> >>>
> >>> -struct px30_sdram_params
> >>> -             *get_default_sdram_config(void)
> >>> -{
> >>> -     sdram_configs[0].skew = &skew;
> >>> -
> >>> -     return &sdram_configs[0];
> >>> -}
> >>> -
> >>>    /* return: 0 = success, other = fail */
> >>>    int sdram_init(void)
> >>>    {
> >>>        struct px30_sdram_params *sdram_params;
> >>> -     int ret = 0;
> >>> +     int ret = 1;
> >>
> >> @Massimo: question: why the need to change ret to 1?
> >>
> >> Because the driver enforces sdram_configs array to be non-empty, we're
> >> guaranteed to do at least one loop and thus ret is guaranteed to be set
> >> properly.
> >
> > You are right, the static assert guarantees ret to be set at least once.
> >
> > For variables - and logic in general - which are in the local scope, I'm used
> > to rely as little as possible on conditions and assumptions out of that local
> > scope. But I respect different opinions and approaches, so if you prefer I can
> > drop the initialization at all, or restore the zero init.
> >
>
> Up to you, but if you keep a change to ret, have it at least -1 so it
> obviously shows when reading that an error is expected to be returned by
> default.

Right. BTW, the line just above sdram_init() definition says:
/* return: 0 = success, other = fail */
...so 1 should be considered a valid error return value too... ;)

>
> You can also check if not setting ret doesn't actually save you some
> bytes in the final binary.
>
> suggestion: Maybe:
>
>         for (int i = 0; i < ARRAY_SIZE(sdram_configs); i++) {
>                 sdram_configs[i].skew = &skew;
>                 sdram_params = &sdram_configs[i];
>                 if(sdram_init_detect(&dram_info, sdram_params))
>                         continue;
>
>                 sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
>                 return 0;
>         }
>
>         return -1;
> }

I will try some alternatives to find the best in size, thanks for the
suggestion.

BTW, do you mean that I can also drop the printascii("out\n")? Really?! More
than six years ago Miquel Rynal provided a patch that Kever accepted [1][2]
but it has never landed into main (master at that time) branch really.
That "out" on console really annoys me!

[1] https://patchwork.ozlabs.org/project/uboot/patch/20200317153217.1493-1-miquel.raynal@bootlin.com/
[2] https://lore.kernel.org/u-boot/32e592dd-4a7e-ddaa-a4e0-e61686006a3f@rock-chips.com/

>
> can make the binary even smaller without the need for the ret variable
> at all and removes a bunch of if conditions/jumps and is also valid
> without the static_assert on the sdram_configs array.
>
> thought: I'm also not sure why we have a global dram_info? If it's not
> needed, then we can have it as a function-local variable in sdram_init
> and initialized in one go:
>
> struct dram_info dram_info = {
>         .phy = (void *)DDR_PHY_BASE_ADDR,
>         .pctl = [...]
> };
>
> if it needs to be global, we can still initialize it in one go and avoid
> the multiple assignments in sdram_init.

I have a few other optimizations, as mentioned. I will send a dedicated series
for them, after this one.

>
> > By the way, in the original code, which is the need to init ret to zero? In that
> > case, there is a local scope evidence and guarantee that it will be set before
> > using.
> >
>
> Yeah, let's agree we've got a lot of unused and non-optimal code in
> U-Boot for Rockchip boards :) We can always improve :)

Yes! Thanks. Regards,
Massimo

>
> Cheers,
> Quentin
