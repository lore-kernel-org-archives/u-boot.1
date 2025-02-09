Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91770C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276AE807D7;
	Sun,  9 Feb 2025 15:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eaG9WZY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B1880819; Sun,  9 Feb 2025 15:27:52 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DFA80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa286ea7e8so3070811a91.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111268; x=1739716068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tk5SZT/SKs44JMYT1DBK366uKSshDsRXNy56OdZ2iFo=;
 b=eaG9WZY6elNi7yomeAnlG+oBKYjivZZ8IQhLGsnKee3jijz07uFIp45vQeHSyyXh2r
 PBsM7StuDbFHjYe1FXg9BDYBM5UztGnj7HA52jb/vLKhP5p3zq0ObgJLFu0qVRgv76LN
 36Mld0lBw6udbgNb5/3jHpDx2grYYbddhi4XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111268; x=1739716068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tk5SZT/SKs44JMYT1DBK366uKSshDsRXNy56OdZ2iFo=;
 b=wwlj8UeTVJ9t+6UExo+oFxECxXmgJYKL4xQgLxvWnxdof/5CC95c7tEwEwXDvq+33R
 AR8SPEE5tPTIlMrvH6Vj9q2AXlksam3cS1B8opkH0g65gO7PTAgxJXOZNRU45kX0+zSF
 fdQbFrTAN0LbZc0PRnB/5ZrOb6eFyFJX4g7PtoOMgHPfr2styPpKE7aaJFdIaJxMxu48
 XHPvSjkyXQxcBSo92x7Grq4J9iGMlyuMb8XEjnOnfAMRU4USwo2iKn1WYRhDWzaEVP9m
 cucyv9mZrai56S7FN5TOG5OyAJNq2b6FMkjOVwNG2+tToeS6/nRxqKokHAHoIGEzdl0x
 G/KA==
X-Gm-Message-State: AOJu0YwRYMHHpu5afIzk5IPncnDkadVIi5TUqzAFzIsJS0H1QC916RxD
 opWD7DIhmZEXaAjsGdESvH7yJWRVXAs4Txeh5s1Nbabfu+0DQb8+gyfL/eMjJjvWllh96tGpP5B
 QaEq7Qiv4ioOcaaQn2sLMk9kHJKIf4hF05ij/
X-Gm-Gg: ASbGnctpvCtyMfSR5C0PdHOpLIJ2Y6IUpXeX9LxMVhiSN9oo0jO/yIB50U8YxxJHuh8
 RAJqCeaRHK9DoUMcy4cf2H+87HxihLwPOeYG3SNUhezsCksic50hW8Gm7PnXTQHmDsgBGS82F3Q
 ==
X-Google-Smtp-Source: AGHT+IHoBmwY5/lbsInwHlte0s7aCTuAXYK/OZ5I85qedRQ3HvcRLpLGht29CLMZk1smMYmwMrvv8Mf+v+UN6pzUoQI=
X-Received: by 2002:a17:90b:23c7:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2fa23f4262bmr13745164a91.5.1739111268503; Sun, 09 Feb 2025
 06:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-20-sjg@chromium.org>
 <c0ac5251-f590-46fc-bb73-c7b81e510f81@kwiboo.se>
In-Reply-To: <c0ac5251-f590-46fc-bb73-c7b81e510f81@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:27:26 -0700
X-Gm-Features: AWEUYZkli_KC7y92BMf68NJOfgrwNvRH0swF_Qf_Jk4KbYbVlZcFeYFPJ_3TmdA
Message-ID: <CAFLszTiXaCAMhJTjaycDrgZaPt0b4rqUQdqrS2s2WNgfq=c_hA@mail.gmail.com>
Subject: Re: [PATCH 19/29] rockchip: Add TPL alternatives
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Sat, 8 Feb 2025 at 18:47, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-05 02:55, Simon Glass wrote:
> > The TPL image must be built for each board we need to support. It is the
> > only part of the image which is board-specific.
>
> Is this building for multiple targets required for A, B or recovery?,
> the main topic for this series? If not it should be added later in the
> series or possible in a follow-up series.

It's really a main topic for this series. See the 'alternatives' part
where you swap in the correct TPL for the board you want to run on.
VBE is designed to minimise the amount of separate binaries which are
built.

>
> >
> > This helps to save space and reduce the size of TPL, so that it can fit
> > within the internal 192K IRAM.
>
> This should probably mention something about RK3399 here, Rockchip SoCs
> have different amount of usable SRAM.

OK

>
> Regards,
> Jonas
>
> >
> > As with other phases, the TPL devicetree is run through fdtgrep to
> > remove unwanted nodes and properties and reduce its size.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi | 42 +++++++++++++++++++++----------
> >  1 file changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index 0611533a310..f6348c532a4 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -254,23 +254,23 @@
> >               pad-byte = <0xff>;
> >               skip-at-start = <0x8000>;
> >
> > -             mkimage {
> > -                     filename = "idbloader.img";
> > -                     args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> > -                     multiple-data-files;
> > +#ifdef CONFIG_VPL
> > +             alternates-fdt {
> > +                     fdt-list-dir = "dts/upstream/src/arm64/rockchip";
> > +                     filename-pattern = "alt-NAME.bin";
> > +                     fdt-phase = "tpl";
> >
> > -#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> > -                     rockchip-tpl {
> > -                     };
> > -#elif defined(CONFIG_TPL)
> > -                     u-boot-tpl {
> > -                     };
> > -#endif
> > -                     u-boot-spl {
> > +                     mkimage {
> > +                             filename = "idbloader.img";
> > +                             args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> > +                             multiple-data-files;
> > +
> > +                             u-boot-tpl {
> > +                                     symbols-base = <0>;
> > +                             };
> >                       };
> >               };
> >
> > -#ifdef CONFIG_VPL
> >               vpl {
> >                       type = "fit";
> >                       offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
> > @@ -361,6 +361,22 @@
> >  # endif /* VBE method */
> >  #else /* !VPL */
> >
> > +             mkimage {
> > +                     filename = "idbloader.img";
> > +                     args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> > +                     multiple-data-files;
> > +
> > +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> > +                     rockchip-tpl {
> > +                     };
> > +#elif defined(CONFIG_TPL)
> > +                     u-boot-tpl {
> > +                     };
> > +#endif
> > +                     u-boot-spl {
> > +                     };
> > +             };
> > +
> >  #ifdef HAS_FIT
> >               fit {
> >                       offset = <CONFIG_SPL_PAD_TO>;
>

Regards,
Simon
