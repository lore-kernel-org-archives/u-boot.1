Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE9A10854B6
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 01:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EA9842DF;
	Sun, 15 Mar 2026 02:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mrPP2EAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3113843C0; Sun, 15 Mar 2026 02:27:06 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A14484286
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 02:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-94ac3958788so2288666241.0
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 18:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773538022; cv=none;
 d=google.com; s=arc-20240605;
 b=TrDcvKPYiVwTkx0PjTR8BGVSRQACR5SeJkTv6p8bnBjiEaWpKXKVKay0qDsK13VXYz
 3tQp07uo5kjB4Kzm4UkqE5TRV+il2F4a7syPrIcAX1O8Kd+7yINND/zjF6u2EeGyXh1K
 AJ11alEAEfyHuTyNHAcsTEtcDjqVLX3Dzhsn0GVBHl5ydqZWDLKziIgT9vyAaZJjri6o
 Wka/z8ywhxpOxW7Sqni2SX/VUaxu1lNAH/ZS18BjwOEVYt6CpFx+moHhLYOn7U2zqFPF
 nEHpJedhc+Jh66/73mKZ/SUZfq0iBK8LJsrhnHL/iZp3rvXV9zDfd6naBFC/I6vk4/gM
 XW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JTYiS90wPWaE2LCDc69WnVgTI4AaBSmhwpfC9KES1yw=;
 fh=3g0gXWyY7a2Z4m1TNufcqs9taSnUMgJtaEjao5N7jRo=;
 b=RzoJB1AGPpoLa0tVo+VzJdPGaSVeNhQg/A9svgEFNSzDOO8J/edYc5A+f3Wi2GHo20
 cui/5F6QkWQQIz4hKuVyknF4cEuLmXFUF0YT/v0JW1r15GilNyTXXDrh3i2RYYSEGEpS
 etbyfxeEm5mJjRopZlJxDTWHcls0yhMdn64xWA6mqOt6XyoGI+KTeAISbnzOIz/RT1zg
 qznZob4M0oxaFvusatHpBV0K7lFMp4w9R7JmlVrdkgkJSfqfSLfJyNoXnanW/aAmF6Px
 +IAAeBNuHYFCXz4WjQXE9MA7hpf+a7OlsYTf6BZhJEKExQan0hFQh28LhbN5npn6sZJl
 9FNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773538022; x=1774142822; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTYiS90wPWaE2LCDc69WnVgTI4AaBSmhwpfC9KES1yw=;
 b=mrPP2EAs57Eq10C0eLnJR3swz+U38hWQJo8glHyjtQqxzndf6+KcqenqHEBdq8aQS7
 NKOX/7gLME6llOLH/U3tFH81VYzFtV3Dcja7vPoqBrTbB4McwW8i8dDfG8IbvCmnE35M
 Jlakff9g8qF7gvN7OjNfQh8fLcj5UU/VxDOJAYo3gfqmnY28f4B2rjPD0tqHE4ZkKpRd
 29LOJzVCefhrZF00uA8seH/ArszGs9DSGv4hcbies1d8UqmAXTwzjzF7unMHibYnqmkl
 vJUOw7hvi05WxD0b6DSG9YdT6bFnWcIWaySACXy0fc0TYcL37FUiGE3B1ovZHwjUnG94
 C/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773538022; x=1774142822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JTYiS90wPWaE2LCDc69WnVgTI4AaBSmhwpfC9KES1yw=;
 b=omtdWgWNJrlvinJYR1gzDnPjg/LfXKlYPriBdCK8FpQ/6y9UnvKm659O1nrC/sul4g
 etDbyeNElDDFAYF55bOuCs9IdaAWOy8SjMnuHLbKeHR3cDgw2qDCybH5xkEtiU3OdqY6
 Ejob2N1hQawEERQ9HJD0piUCP3GF18iSqWJll1aHV0qnYgdJHX7jO32/NNZTsUGIYOwf
 7z4kCBUb9tKu8WHZOq8JvaImWSfDP89ej7YGE3YxsjY+PIuoXfuw4DWbl+X/cOyemiJU
 1Csz+JCDNUY5CEK6LXk3N6GmCeI/UmmnnhXoOQMP5iIkYJJ0Ihqv5+WIS5P8N4rvNmPc
 f88w==
X-Gm-Message-State: AOJu0YyU/Ews/f4xr3qb2ZEJtmapQH+J9W9WYH5i9ipoxnDlddkPZVYF
 MFoH9NSgbTIMtH54EFHMFOtfgST/itz4Buq3U9FbUYjHJT0Ei9aA999UZOqTeJFj2dDOEIFoYd8
 u1OaTFNnHKIgrDyuTPRyfLuYTYq8c47s=
X-Gm-Gg: ATEYQzxk0izxQs3EalPLsKJnuMjuqbR9/0t3L0eE2d6ugI99aQemQAzFUIFU9Em6Sbr
 GrwfE2Wcg/bDYiL0ArOZ5BbkVRcD/qpOQRrqF2PhEdLS0bzRQr/jH7r3vfJGkIMPrUDIJWEIQuK
 t0QN9nC+HVMLLTlVH7q931wXR922z38ELw2rdXmAsUYkwZqxmKT+VTs6aVd6NlLO71txd8YfH+8
 LYBER/EVzkKBYspiuS0v9mtCmOmQB0MnQ0fiM7SEte3sbJAPz1KgaU5s6QtbmgrvyOb7034xA5M
 pTG03vzwYMe/gpGPnEHXWj05OLfp2a1gkUgQGHVRoZ0LDaitqwDG7a3LteL9uEM22hM=
X-Received: by 2002:a05:6102:41ac:b0:5ff:bbc1:50a7 with SMTP id
 ada2fe7eead31-6020d4d1cc2mr3387350137.15.1773538021764; Sat, 14 Mar 2026
 18:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260312204909.2865983-1-james.hilliard1@gmail.com>
 <20260315005340.1a3c062c@ryzen.lan>
In-Reply-To: <20260315005340.1a3c062c@ryzen.lan>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 14 Mar 2026 19:26:51 -0600
X-Gm-Features: AaiRm53gA71PqeDb5LukShTVJLLz1BnIesK1fQRXvTc18gT5vUpy9uP2kyvu-Pg
Message-ID: <CADvTj4o=Fy5HupNPiG=tiPy-jwR-g4aj82yWoiEz8U3_OzKtZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sunxi: h616: add GPIO-selected DRAM profiles
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Samuel Holland <samuel@sholland.org>, Icenowy Zheng <uwu@icenowy.me>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Mar 14, 2026 at 5:55=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Thu, 12 Mar 2026 14:49:06 -0600
> James Hilliard <james.hilliard1@gmail.com> wrote:
>
> Hi James,
>
> many thanks for doing this, although ....
> This patch is pretty massive and intrusive, as it not only provides
> support for your use case, but changes quite a lot in the H616 DRAM
> code, which is of course used by many more boards.
> The DRAM controller initialisation code, being part of the size
> constrained SPL, has been carefully tuned to compile to as small a
> binary as possible, without sacrificing code quality. We lean on
> toolchain garbage collection (removal of unused code) and constant
> propagation to have readable and portable code, but still very size
> optimised assembly. Your change might void some of these optimisations.
> I am not against those changes, but some things would need to happen to
> make it upstream:
>
> 1. Please split this patch up. This changes all at once, making
> it very hard to review, and to pinpoint any issues to the real
> root cause, when this commit is found in bisecting. I would expect
> between 5 and 10 patches out of this series, maybe even more. Some
> hints below, if you are unsure about the split, come back and ask.

I sent a v3 with just some of the initial refactoring prep changes that
should have no functional changes to make it easier to review:
https://lore.kernel.org/u-boot/20260315005422.471159-1-james.hilliard1@gmai=
l.com/

> 2. Try to keep the changes to boards using the hardcoded parameters as
> small as possible. In fact *every* Allwinner board uses this scheme so
> far, and this works quite nicely, so that's not a niche use case, and I
> don't want to jeopardise that for just one board (yours), which is not
> even upstream (hint!).

Yeah, I'm thinking it's probably easier to do a few rounds of refactoring
with just the hardcoded parameters in order to make the code suitable
for adding these features without having to touch the hardcoded param
paths too much.

> 3. Avoid #ifdef code sections: they are confusing to read, especially
> longer sections, and defy compile time testing, especially in your
> situation. If for instance any of the external functions you call in
> your #ifdef'ed code change, we wouldn't notice. If you rely on
> functions not available normally (DT in SPL), move the whole
> new code into a separate file, and put the condition in the Makefile.
> Also "if (IS_ENABLED(CONFIG_FOO))" can be used if you need to
> differentiate based on config options.

Yeah, the current code relies quite heavily on the #ifdef style, in
my v2 I had done more extensive refactoring to try and make it
easier to work with the multiple dram backends cleanly:
https://lore.kernel.org/u-boot/20260314060256.381642-2-james.hilliard1@gmai=
l.com/

My minimal refactoring only v3 also tries to address this issue with
too many #ifdef's but without introducing the new features at all yet.

> 4. This is hard to test, and even compile testing by CI wouldn't happen
> at the moment, since there is no user. Is there any chance you would
> upstream your board, starting with a DT submission to the kernel repo?
> That would make a much better case for merging intrusive code that
> just increases the code size for many boards.

Maybe, although there's quite a bit of unrelated stuff broken that's
still in the process of being upstreamed. I think there's some other
publicly available boards that use the runtime dram selection with
BSP based firmware, although not sure if any of those are upstream
yet at all.

> > Add an H616 profile-source choice so SPL can either use the existing
> > fixed Kconfig profile or load a DRAM profile selected by GPIO straps
> > from the U-Boot device tree.
>
> Those are only the last at least two changes of the whole series: DT
> profile parsing, and GPIO strap selection (so at least two patches).
>
> > The GPIO-selected path decodes up to four
> > allwinner,dram-coding-gpios bits and loads the matching profile from
> > /dram-profiles.
>
> This describes just the last step of the whole change set.

I removed all these in my v3 to make it easier to review.

> > Refactor the H616 DRAM code so the PHY init tables and timing backend a=
re
> > selected at runtime from para->type, and switch the H616 timing helpers
> > to use para->clk instead of CONFIG_DRAM_CLK.
>
> Those changes seems to be step 2 and step 1.
>
> > This allows a single SPL
> > build to support multiple H616 DRAM types selected at boot while keepin=
g
> > fixed-profile mode as the default.
>
> But even the latter comes at a cost, as it blows up code size, right? A
> quick test reveals it's not by much, but we maybe can reduce this
> overhead.

I think I had fixed the size blow up in my v2 by restoring the conditional
backend compilation(my v3 also retains the conditional backend
compilation):
https://lore.kernel.org/u-boot/20260314060256.381642-2-james.hilliard1@gmai=
l.com/

> I refrain from reviewing this mammoth of a patch, but some quick hints
> after a quick glance:
> - Avoid prefixing generic functions with h616_, h616_ns_to_t() and
>   h616_fdt_read_u32() don't seem H616 specific at all.

I removed most of these prefixes in my v3.

> - If you move h616.c into a header and make mctl_set_timing_params() a
>   static inline function, the generated code might be better, and we
>   probably talk the compiler into optimising away the whole choice when
>   SUNXI_DRAM_H616_FIXED_PROFILE is used, maybe with the help of some #ifd=
ef's.

I got rid of h616.c and moved these into dram_sun50i_h616.h in my v3.

> - h616_get_strap_gpio() seems to be overly complicated? Isn't it just
>   bank * 32 + pin?

Hmm, probably, I'll take a look at that after the initial refactoring.

>
> Cheers,
> Andre
>
> > Hide the fixed H616 Kconfig timing and parameter prompts when GPIO-base=
d
> > selection is enabled, since those settings are not used in that mode.
> > The selector name stays H616-specific because this only models the BSP
> > GPIO strap flow, not the GPADC-based variants.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  .../include/asm/arch-sunxi/dram_sun50i_h616.h |   7 +-
> >  arch/arm/mach-sunxi/Kconfig                   |  47 ++-
> >  arch/arm/mach-sunxi/dram_sun50i_h616.c        | 367 ++++++++++++++++--
> >  arch/arm/mach-sunxi/dram_timings/Makefile     |   5 +-
> >  arch/arm/mach-sunxi/dram_timings/h616.c       |  27 ++
> >  .../mach-sunxi/dram_timings/h616_ddr3_1333.c  |  32 +-
> >  .../arm/mach-sunxi/dram_timings/h616_lpddr3.c |  32 +-
> >  .../dram_timings/h616_lpddr4_2133.c           |  32 +-
> >  8 files changed, 463 insertions(+), 86 deletions(-)
> >  create mode 100644 arch/arm/mach-sunxi/dram_timings/h616.c
> >
> > diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/=
arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> > index a8fdda124a0..ea64f997fbf 100644
> > --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> > +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> > @@ -168,13 +168,16 @@ struct dram_config {
> >       u8 bus_full_width;
> >  };
> >
> > -static inline int ns_to_t(int nanoseconds)
> > +static inline int h616_ns_to_t(const struct dram_para *para, int nanos=
econds)
> >  {
> > -     const unsigned int ctrl_freq =3D CONFIG_DRAM_CLK / 2;
> > +     const unsigned int ctrl_freq =3D para->clk / 2;
> >
> >       return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
> >  }
> >
> > +void h616_ddr3_set_timing_params(const struct dram_para *para);
> > +void h616_lpddr3_set_timing_params(const struct dram_para *para);
> > +void h616_lpddr4_set_timing_params(const struct dram_para *para);
> >  void mctl_set_timing_params(const struct dram_para *para);
> >
> >  #endif /* _SUNXI_DRAM_SUN50I_H616_H */
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index e979ee4a2cc..f8cb0a96182 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -62,7 +62,41 @@ config DRAM_SUN55I_A523
> >       help
> >         Select this DRAM controller driver for A523/T527 SoCs.
> >
> > -if DRAM_SUN50I_H616 || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
> > +if DRAM_SUN50I_H616
> > +choice
> > +     prompt "H616 DRAM profile source"
> > +     default SUNXI_DRAM_H616_FIXED_PROFILE
> > +     help
> > +       Select whether SPL uses the fixed H616 Kconfig DRAM settings or
> > +       loads an H616 DRAM profile from the device tree at boot.
> > +
> > +config SUNXI_DRAM_H616_FIXED_PROFILE
> > +     bool "Fixed build-time DRAM profile"
> > +     help
> > +       Use a single H616 DRAM profile selected at build time.
> > +       This keeps the existing Kconfig-based timing selection flow.
> > +
> > +config SUNXI_DRAM_H616_GPIO_SELECT
> > +     bool "GPIO-selected DRAM profile"
> > +     select GPIO
> > +     select OF_CONTROL
> > +     select SPL_OF_CONTROL
> > +     select SPL_GPIO
> > +     help
> > +       Enable runtime H616 DRAM profile selection using GPIO strap bit=
s
> > +       described in the U-Boot device tree.
> > +
> > +       SPL reads the allwinner,dram-coding-gpios property from the
> > +       /dram-profiles node, decodes up to four strap bits into a profi=
le
> > +       ID, and loads the matching profile from /dram-profiles instead =
of
> > +       using a fixed build-time H616 DRAM profile.
> > +
> > +       Each profile must provide the H616 DRAM parameters used by the
> > +       driver. Supported dram-type values are DDR3, LPDDR3, and LPDDR4=
.
> > +endchoice
> > +endif
> > +
> > +if (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || DRAM_SUN50I_=
A133 || DRAM_SUN55I_A523
> >  config DRAM_SUNXI_DX_ODT
> >       hex "DRAM DX ODT parameter"
> >       help
> > @@ -608,6 +642,7 @@ config SUNXI_DRAM_DDR4
> >
> >  choice
> >       prompt "DRAM Type and Timing"
> > +     depends on !DRAM_SUN50I_H616 || SUNXI_DRAM_H616_FIXED_PROFILE
> >       default SUNXI_DRAM_A523_LPDDR4 if MACH_SUN55I_A523
> >       default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
> >       default SUNXI_DRAM_DDR2_V3S if MACH_SUN8I_V3S
> > @@ -647,7 +682,8 @@ config SUNXI_DRAM_H6_DDR3_1333
> >  config SUNXI_DRAM_H616_LPDDR3
> >       bool "LPDDR3 DRAM chips on the H616 DRAM controller"
> >       select SUNXI_DRAM_LPDDR3
> > -     depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
> > +     depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) ||=
 \
> > +                DRAM_SUN50I_A133
> >       help
> >         This option is the LPDDR3 timing used by the stock boot0 by
> >         Allwinner.
> > @@ -655,7 +691,8 @@ config SUNXI_DRAM_H616_LPDDR3
> >  config SUNXI_DRAM_H616_LPDDR4
> >       bool "LPDDR4 DRAM chips on the H616 DRAM controller"
> >       select SUNXI_DRAM_LPDDR4
> > -     depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
> > +     depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) ||=
 \
> > +                DRAM_SUN50I_A133
> >       help
> >         This option is the LPDDR4 timing used by the stock boot0 by
> >         Allwinner.
> > @@ -663,7 +700,8 @@ config SUNXI_DRAM_H616_LPDDR4
> >  config SUNXI_DRAM_H616_DDR3_1333
> >       bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
> >       select SUNXI_DRAM_DDR3
> > -     depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
> > +     depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) ||=
 \
> > +                DRAM_SUN50I_A133
> >       help
> >         This option is the DDR3 timing used by the boot0 on H616 TV box=
es
> >         which use a DDR3-1333 timing.
> > @@ -719,6 +757,7 @@ config DRAM_TYPE
> >
> >  config DRAM_CLK
> >       int "sunxi dram clock speed"
> > +     depends on !DRAM_SUN50I_H616 || SUNXI_DRAM_H616_FIXED_PROFILE
> >       default 792 if MACH_SUN9I
> >       default 648 if MACH_SUN8I_R40
> >       default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
> > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sun=
xi/dram_sun50i_h616.c
> > index 3345c9b8e82..f72c1e0f38c 100644
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > @@ -15,6 +15,17 @@
> >  #include <init.h>
> >  #include <log.h>
> >  #include <asm/io.h>
> > +
> > +#define H616_GPIO_SELECT_ENABLED     IS_ENABLED(CONFIG_SUNXI_DRAM_H616=
_GPIO_SELECT)
> > +
> > +#if H616_GPIO_SELECT_ENABLED
> > +#include <asm-generic/gpio.h>
> > +#include <asm/global_data.h>
> > +#include <errno.h>
> > +#include <sunxi_gpio.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/string.h>
> > +#endif
> >  #include <asm/arch/clock.h>
> >  #include <asm/arch/dram.h>
> >  #include <asm/arch/dram_dw_helpers.h>
> > @@ -23,6 +34,12 @@
> >  #include <linux/bitops.h>
> >  #include <linux/delay.h>
> >
> > +#define H616_DRAM_STRAP_GPIO_COUNT   4
> > +
> > +#if H616_GPIO_SELECT_ENABLED
> > +DECLARE_GLOBAL_DATA_PTR;
> > +#endif
> > +
> >  enum {
> >       MBUS_QOS_LOWEST =3D 0,
> >       MBUS_QOS_LOW,
> > @@ -227,45 +244,67 @@ static void mctl_set_addrmap(const struct dram_co=
nfig *config)
> >       mctl_ctl->addrmap[8] =3D 0x3F3F;
> >  }
> >
> > +#define H616_PHY_INIT_LEN    27
> > +
> >  #ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
> > -static const u8 phy_init[] =3D {
> > -#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
> > +static const u8 phy_init_ddr3[H616_PHY_INIT_LEN] =3D {
> >       0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
> >       0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
> >       0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
> >       0x06, 0x09, 0x0f
> > -#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
> > +};
> > +
> > +static const u8 phy_init_lpddr3[H616_PHY_INIT_LEN] =3D {
> >       0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
> >       0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> >       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
> >       0x08, 0x01, 0x1a
> > -#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
> > +};
> > +
> > +static const u8 phy_init_lpddr4[H616_PHY_INIT_LEN] =3D {
> >       0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
> >       0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> >       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
> >       0x18, 0x04, 0x1a
> > -#endif
> >  };
> > -#else /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
> > -static const u8 phy_init[] =3D {
> > -#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
> > +#else
> > +static const u8 phy_init_ddr3[H616_PHY_INIT_LEN] =3D {
> >       0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
> >       0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
> >       0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
> >       0x09, 0x05, 0x18
> > -#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
> > +};
> > +
> > +static const u8 phy_init_lpddr3[H616_PHY_INIT_LEN] =3D {
> >       0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
> >       0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> >       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
> >       0x17, 0x19, 0x1a
> > -#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
> > +};
> > +
> > +static const u8 phy_init_lpddr4[H616_PHY_INIT_LEN] =3D {
> >       0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
> >       0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> >       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
> >       0x18, 0x03, 0x1a
> > -#endif
> >  };
> > -#endif /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
> > +#endif
> > +
> > +static const u8 *h616_get_phy_init(const struct dram_para *para)
> > +{
> > +     switch (para->type) {
> > +     case SUNXI_DRAM_TYPE_DDR3:
> > +             return phy_init_ddr3;
> > +     case SUNXI_DRAM_TYPE_LPDDR3:
> > +             return phy_init_lpddr3;
> > +     case SUNXI_DRAM_TYPE_LPDDR4:
> > +             return phy_init_lpddr4;
> > +     case SUNXI_DRAM_TYPE_DDR4:
> > +     default:
> > +             panic("Unsupported H616 DRAM type: %u\n", para->type);
> > +     }
> > +}
> > +
> >  #define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
> >  static void mctl_phy_configure_odt(const struct dram_para *para)
> >  {
> > @@ -908,6 +947,7 @@ static bool mctl_phy_init(const struct dram_para *p=
ara,
> >                       (struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
> >       struct sunxi_mctl_ctl_reg * const mctl_ctl =3D
> >                       (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE=
;
> > +     const u8 *phy_init =3D h616_get_phy_init(para);
> >       u32 val, val2, *ptr, mr0, mr2;
> >       int i;
> >
> > @@ -964,7 +1004,7 @@ static bool mctl_phy_init(const struct dram_para *=
para,
> >       writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
> >
> >       ptr =3D (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
> > -     for (i =3D 0; i < ARRAY_SIZE(phy_init); i++)
> > +     for (i =3D 0; i < H616_PHY_INIT_LEN; i++)
> >               writel(phy_init[i], &ptr[i]);
> >
> >       if (para->tpr10 & TPR10_CA_BIT_DELAY)
> > @@ -1319,33 +1359,302 @@ bool mctl_core_init(const struct dram_para *pa=
ra,
> >       return mctl_ctrl_init(para, config);
> >  }
> >
> > -static const struct dram_para para =3D {
> > -     .clk =3D CONFIG_DRAM_CLK,
> > +#if H616_GPIO_SELECT_ENABLED
> > +static int h616_fdt_read_u32(const void *blob, int node, const char *p=
rop_name,
> > +                          u32 *val)
> > +{
> > +     const fdt32_t *prop;
> > +     int len;
> > +
> > +     prop =3D fdt_getprop(blob, node, prop_name, &len);
> > +     if (!prop || len !=3D sizeof(*prop))
> > +             return -EINVAL;
> > +
> > +     *val =3D fdt32_to_cpu(*prop);
> > +
> > +     return 0;
> > +}
> > +
> > +static int h616_fdt_read_dram_type(const void *blob, int node, u32 *va=
l)
> > +{
> > +     const char *prop;
> > +     int len;
> > +
> > +     prop =3D fdt_getprop(blob, node, "allwinner,dram-type", &len);
> > +     if (!prop)
> > +             return -EINVAL;
> > +
> > +     if (len =3D=3D sizeof(fdt32_t)) {
> > +             *val =3D fdt32_to_cpu(*(const fdt32_t *)prop);
> > +             return 0;
> > +     }
> > +
> > +     if (len <=3D 0 || prop[len - 1] !=3D '\0')
> > +             return -EINVAL;
> > +
> > +     if (!strcmp(prop, "ddr3")) {
> > +             *val =3D SUNXI_DRAM_TYPE_DDR3;
> > +             return 0;
> > +     }
> > +     if (!strcmp(prop, "ddr4")) {
> > +             *val =3D SUNXI_DRAM_TYPE_DDR4;
> > +             return 0;
> > +     }
> > +     if (!strcmp(prop, "lpddr3")) {
> > +             *val =3D SUNXI_DRAM_TYPE_LPDDR3;
> > +             return 0;
> > +     }
> > +     if (!strcmp(prop, "lpddr4")) {
> > +             *val =3D SUNXI_DRAM_TYPE_LPDDR4;
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int h616_get_strap_gpio(u32 bank, u32 pin)
> > +{
> > +     if (pin >=3D SUNXI_GPIOS_PER_BANK)
> > +             return -EINVAL;
> > +
> > +     switch (bank) {
> > +     case SUNXI_GPIO_A:
> > +             return SUNXI_GPA(pin);
> > +     case SUNXI_GPIO_B:
> > +             return SUNXI_GPB(pin);
> > +     case SUNXI_GPIO_C:
> > +             return SUNXI_GPC(pin);
> > +     case SUNXI_GPIO_D:
> > +             return SUNXI_GPD(pin);
> > +     case SUNXI_GPIO_E:
> > +             return SUNXI_GPE(pin);
> > +     case SUNXI_GPIO_F:
> > +             return SUNXI_GPF(pin);
> > +     case SUNXI_GPIO_G:
> > +             return SUNXI_GPG(pin);
> > +     case SUNXI_GPIO_H:
> > +             return SUNXI_GPH(pin);
> > +     case SUNXI_GPIO_I:
> > +             return SUNXI_GPI(pin);
> > +     case SUNXI_GPIO_L:
> > +             return SUNXI_GPL(pin);
> > +     case SUNXI_GPIO_M:
> > +             return SUNXI_GPM(pin);
> > +     case SUNXI_GPIO_N:
> > +             return SUNXI_GPN(pin);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int h616_fdt_get_gpio_spec(const void *blob, int node,
> > +                               const char *prop_name, int index,
> > +                               u32 *bank, u32 *pin)
> > +{
> > +     const fdt32_t *prop;
> > +     int entries, gpio_node, i, len, pos;
> > +     u32 cells, phandle;
> > +
> > +     prop =3D fdt_getprop(blob, node, prop_name, &len);
> > +     if (!prop)
> > +             return -ENOENT;
> > +     if (len % sizeof(*prop))
> > +             return -EINVAL;
> > +
> > +     entries =3D len / sizeof(*prop);
> > +     for (i =3D 0, pos =3D 0; pos < entries; i++) {
> > +             phandle =3D fdt32_to_cpu(prop[pos++]);
> > +             if (!phandle)
> > +                     break;
> > +
> > +             gpio_node =3D fdt_node_offset_by_phandle(blob, phandle);
> > +             if (gpio_node < 0)
> > +                     return gpio_node;
> > +             if (h616_fdt_read_u32(blob, gpio_node, "#gpio-cells", &ce=
lls))
> > +                     return -EINVAL;
> > +             if (cells < 2 || pos + cells > entries)
> > +                     return -EINVAL;
> > +
> > +             if (i =3D=3D index) {
> > +                     *bank =3D fdt32_to_cpu(prop[pos]);
> > +                     *pin =3D fdt32_to_cpu(prop[pos + 1]);
> > +                     return 0;
> > +             }
> > +
> > +             pos +=3D cells;
> > +     }
> > +
> > +     return -ENOENT;
> > +}
> > +
> > +static int h616_parse_dram_para(const void *blob, int node,
> > +                             struct dram_para *para)
> > +{
> > +     u32 val;
> > +
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,dram-clk", &para->cl=
k))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_dram_type(blob, node, &val))
> > +             return -EINVAL;
> > +
> > +     switch (val) {
> > +     case SUNXI_DRAM_TYPE_DDR3:
> > +     case SUNXI_DRAM_TYPE_LPDDR3:
> > +     case SUNXI_DRAM_TYPE_LPDDR4:
> > +             para->type =3D val;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,dx-odt", &para->dx_o=
dt))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,dx-dri", &para->dx_d=
ri))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,ca-dri", &para->ca_d=
ri))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,odt-en", &para->odt_=
en))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,tpr0", &para->tpr0))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,tpr2", &para->tpr2))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,tpr6", &para->tpr6))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,tpr10", &para->tpr10=
))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,tpr11", &para->tpr11=
))
> > +             return -EINVAL;
> > +     if (h616_fdt_read_u32(blob, node, "allwinner,tpr12", &para->tpr12=
))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static int h616_load_dram_profile(u32 profile_id, struct dram_para *pa=
ra)
> > +{
> > +     const void *blob =3D gd->fdt_blob;
> > +     int node, profiles;
> > +     u32 reg;
> > +
> > +     profiles =3D fdt_path_offset(blob, "/dram-profiles");
> > +     if (profiles < 0)
> > +             return profiles;
> > +
> > +     for (node =3D fdt_first_subnode(blob, profiles);
> > +          node >=3D 0;
> > +          node =3D fdt_next_subnode(blob, node)) {
> > +             if (h616_fdt_read_u32(blob, node, "reg", &reg))
> > +                     continue;
> > +             if (reg !=3D profile_id)
> > +                     continue;
> > +
> > +             return h616_parse_dram_para(blob, node, para);
> > +     }
> > +
> > +     return -ENOENT;
> > +}
> > +
> > +static int h616_get_dram_profile_id(u32 *profile_id)
> > +{
> > +     const void *blob =3D gd->fdt_blob;
> > +     int gpio, i, profiles, ret, value;
> > +     u32 bank, pin;
> > +
> > +     profiles =3D fdt_path_offset(blob, "/dram-profiles");
> > +     if (profiles < 0)
> > +             return profiles;
> > +
> > +     *profile_id =3D 0;
> > +     for (i =3D 0; i < H616_DRAM_STRAP_GPIO_COUNT; i++) {
> > +             ret =3D h616_fdt_get_gpio_spec(blob, profiles,
> > +                                          "allwinner,dram-coding-gpios=
",
> > +                                          i, &bank, &pin);
> > +             if (ret =3D=3D -ENOENT)
> > +                     return i ? 0 : -ENOENT;
> > +             if (ret)
> > +                     return ret;
> > +
> > +             gpio =3D h616_get_strap_gpio(bank, pin);
> > +             if (gpio < 0)
> > +                     return gpio;
> > +
> > +             ret =3D gpio_request(gpio, "h616_dram_sel");
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D gpio_direction_input(gpio);
> > +             if (ret) {
> > +                     gpio_free(gpio);
> > +                     return ret;
> > +             }
> > +
> > +             value =3D gpio_get_value(gpio);
> > +             gpio_free(gpio);
> > +             if (value < 0)
> > +                     return value;
> > +
> > +             *profile_id |=3D !!value << i;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void h616_get_dram_para(struct dram_para *para)
> > +{
> > +     u32 profile_id;
> > +     int ret;
> > +
> > +     ret =3D h616_get_dram_profile_id(&profile_id);
> > +     if (ret)
> > +             panic("H616 GPIO DRAM profile selection could not determi=
ne a profile\n");
> > +
> > +     ret =3D h616_load_dram_profile(profile_id, para);
> > +     if (ret)
> > +             panic("H616 GPIO DRAM profile selection failed to load pr=
ofile %u\n",
> > +                   profile_id);
> > +}
> > +#else
> > +static enum sunxi_dram_type h616_get_fixed_dram_type(void)
> > +{
> >  #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
> > -     .type =3D SUNXI_DRAM_TYPE_DDR3,
> > +     return SUNXI_DRAM_TYPE_DDR3;
> >  #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
> > -     .type =3D SUNXI_DRAM_TYPE_LPDDR3,
> > +     return SUNXI_DRAM_TYPE_LPDDR3;
> >  #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
> > -     .type =3D SUNXI_DRAM_TYPE_LPDDR4,
> > +     return SUNXI_DRAM_TYPE_LPDDR4;
> > +#endif
> > +     panic("No fixed H616 DRAM type selected\n");
> > +}
> > +
> > +static void h616_get_dram_para(struct dram_para *para)
> > +{
> > +     *para =3D (struct dram_para) {
> > +             .clk =3D CONFIG_DRAM_CLK,
> > +             .type =3D h616_get_fixed_dram_type(),
> > +             .dx_odt =3D CONFIG_DRAM_SUNXI_DX_ODT,
> > +             .dx_dri =3D CONFIG_DRAM_SUNXI_DX_DRI,
> > +             .ca_dri =3D CONFIG_DRAM_SUNXI_CA_DRI,
> > +             .odt_en =3D CONFIG_DRAM_SUNXI_ODT_EN,
> > +             .tpr0 =3D CONFIG_DRAM_SUNXI_TPR0,
> > +             .tpr2 =3D CONFIG_DRAM_SUNXI_TPR2,
> > +             .tpr6 =3D CONFIG_DRAM_SUNXI_TPR6,
> > +             .tpr10 =3D CONFIG_DRAM_SUNXI_TPR10,
> > +             .tpr11 =3D CONFIG_DRAM_SUNXI_TPR11,
> > +             .tpr12 =3D CONFIG_DRAM_SUNXI_TPR12,
> > +     };
> > +}
> >  #endif
> > -     .dx_odt =3D CONFIG_DRAM_SUNXI_DX_ODT,
> > -     .dx_dri =3D CONFIG_DRAM_SUNXI_DX_DRI,
> > -     .ca_dri =3D CONFIG_DRAM_SUNXI_CA_DRI,
> > -     .odt_en =3D CONFIG_DRAM_SUNXI_ODT_EN,
> > -     .tpr0 =3D CONFIG_DRAM_SUNXI_TPR0,
> > -     .tpr2 =3D CONFIG_DRAM_SUNXI_TPR2,
> > -     .tpr6 =3D CONFIG_DRAM_SUNXI_TPR6,
> > -     .tpr10 =3D CONFIG_DRAM_SUNXI_TPR10,
> > -     .tpr11 =3D CONFIG_DRAM_SUNXI_TPR11,
> > -     .tpr12 =3D CONFIG_DRAM_SUNXI_TPR12,
> > -};
> >
> >  unsigned long sunxi_dram_init(void)
> >  {
> >       void *const prcm =3D (void *)SUNXI_PRCM_BASE;
> > +     struct dram_para para;
> >       struct dram_config config;
> >       unsigned long size;
> >
> > +     h616_get_dram_para(&para);
> > +
> >       setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, BIT(8));
> >       clrbits_le32(prcm + CCU_PRCM_OHMS240, 0x3f);
> >
> > diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-=
sunxi/dram_timings/Makefile
> > index 5de9fd5aab4..34d46f2864a 100644
> > --- a/arch/arm/mach-sunxi/dram_timings/Makefile
> > +++ b/arch/arm/mach-sunxi/dram_timings/Makefile
> > @@ -3,9 +3,8 @@ obj-$(CONFIG_SUNXI_DRAM_LPDDR3_STOCK) +=3D lpddr3_stock=
.o
> >  obj-$(CONFIG_SUNXI_DRAM_DDR2_V3S)    +=3D ddr2_v3s.o
> >  obj-$(CONFIG_SUNXI_DRAM_H6_LPDDR3)   +=3D h6_lpddr3.o
> >  obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)        +=3D h6_ddr3_1333.o
> > -obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)      +=3D h616_ddr3_1333.o
> > -obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3) +=3D h616_lpddr3.o
> > -obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4) +=3D h616_lpddr4_2133.o
> > +obj-$(CONFIG_DRAM_SUN50I_H616)               +=3D h616.o h616_ddr3_133=
3.o
> > +obj-$(CONFIG_DRAM_SUN50I_H616)               +=3D h616_lpddr3.o h616_l=
pddr4_2133.o
> >  obj-$(CONFIG_SUNXI_DRAM_A133_DDR4)   +=3D a133_ddr4.o
> >  obj-$(CONFIG_SUNXI_DRAM_A133_LPDDR4) +=3D a133_lpddr4.o
> >  obj-$(CONFIG_SUNXI_DRAM_A523_DDR3)   +=3D a523_ddr3.o
> > diff --git a/arch/arm/mach-sunxi/dram_timings/h616.c b/arch/arm/mach-su=
nxi/dram_timings/h616.c
> > new file mode 100644
> > index 00000000000..d05d528cc57
> > --- /dev/null
> > +++ b/arch/arm/mach-sunxi/dram_timings/h616.c
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * sun50i H616 DRAM timing dispatcher
> > + *
> > + * Build all H616 timing backends and select the appropriate one at ru=
ntime.
> > + */
> > +
> > +#include <asm/arch/dram.h>
> > +#include <vsprintf.h>
> > +
> > +void mctl_set_timing_params(const struct dram_para *para)
> > +{
> > +     switch (para->type) {
> > +     case SUNXI_DRAM_TYPE_DDR3:
> > +             h616_ddr3_set_timing_params(para);
> > +             break;
> > +     case SUNXI_DRAM_TYPE_LPDDR3:
> > +             h616_lpddr3_set_timing_params(para);
> > +             break;
> > +     case SUNXI_DRAM_TYPE_LPDDR4:
> > +             h616_lpddr4_set_timing_params(para);
> > +             break;
> > +     case SUNXI_DRAM_TYPE_DDR4:
> > +     default:
> > +             panic("Unsupported H616 DRAM type: %u\n", para->type);
> > +     }
> > +}
> > diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/a=
rm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> > index 3faf8d5bd97..4fde0a81a0a 100644
> > --- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> > +++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> > @@ -14,33 +14,33 @@
> >  #include <asm/arch/dram.h>
> >  #include <asm/arch/cpu.h>
> >
> > -void mctl_set_timing_params(const struct dram_para *para)
> > +void h616_ddr3_set_timing_params(const struct dram_para *para)
> >  {
> >       struct sunxi_mctl_ctl_reg * const mctl_ctl =3D
> >                       (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE=
;
> >
> >       u8 tccd         =3D 2;                    /* JEDEC: 4nCK */
> > -     u8 tfaw         =3D ns_to_t(50);          /* JEDEC: 30 ns w/ 1K p=
ages */
> > -     u8 trrd         =3D max(ns_to_t(6), 4);   /* JEDEC: max(6 ns, 4nC=
K) */
> > -     u8 trcd         =3D ns_to_t(15);          /* JEDEC: 13.5 ns */
> > -     u8 trc          =3D ns_to_t(53);          /* JEDEC: 49.5 ns */
> > -     u8 txp          =3D max(ns_to_t(6), 3);   /* JEDEC: max(6 ns, 3nC=
K) */
> > -     u8 trtp         =3D max(ns_to_t(8), 2);   /* JEDEC: max(7.5 ns, 4=
nCK) */
> > -     u8 trp          =3D ns_to_t(15);          /* JEDEC: >=3D 13.75 ns=
 */
> > -     u8 tras         =3D ns_to_t(38);          /* JEDEC >=3D 36 ns, <=
=3D 9*trefi */
> > -     u16 trefi       =3D ns_to_t(7800) / 32;   /* JEDEC: 7.8us@Tcase <=
=3D 85C */
> > -     u16 trfc        =3D ns_to_t(350);         /* JEDEC: 160 ns for 2G=
b */
> > +     u8 tfaw         =3D h616_ns_to_t(para, 50);    /* JEDEC: 30 ns w/=
 1K pages */
> > +     u8 trrd         =3D max(h616_ns_to_t(para, 6), 4); /* JEDEC: max(=
6 ns, 4nCK) */
> > +     u8 trcd         =3D h616_ns_to_t(para, 15);    /* JEDEC: 13.5 ns =
*/
> > +     u8 trc          =3D h616_ns_to_t(para, 53);    /* JEDEC: 49.5 ns =
*/
> > +     u8 txp          =3D max(h616_ns_to_t(para, 6), 3); /* JEDEC: max(=
6 ns, 3nCK) */
> > +     u8 trtp         =3D max(h616_ns_to_t(para, 8), 2); /* JEDEC: max(=
7.5 ns, 4nCK) */
> > +     u8 trp          =3D h616_ns_to_t(para, 15);    /* JEDEC: >=3D 13.=
75 ns */
> > +     u8 tras         =3D h616_ns_to_t(para, 38);    /* JEDEC >=3D 36 n=
s, <=3D 9*trefi */
> > +     u16 trefi       =3D h616_ns_to_t(para, 7800) / 32; /* JEDEC: 7.8u=
s@Tcase <=3D 85C */
> > +     u16 trfc        =3D h616_ns_to_t(para, 350);   /* JEDEC: 160 ns f=
or 2Gb */
> >       u16 txsr        =3D 4;                    /* ? */
> >
> >       u8 tmrw         =3D 0;                    /* ? */
> >       u8 tmrd         =3D 4;                    /* JEDEC: 4nCK */
> > -     u8 tmod         =3D max(ns_to_t(15), 12); /* JEDEC: max(15 ns, 12=
nCK) */
> > -     u8 tcke         =3D max(ns_to_t(6), 3);   /* JEDEC: max(5.625 ns,=
 3nCK) */
> > -     u8 tcksrx       =3D max(ns_to_t(10), 4);  /* JEDEC: max(10 ns, 5n=
CK) */
> > -     u8 tcksre       =3D max(ns_to_t(10), 4);  /* JEDEC: max(10 ns, 5n=
CK) */
> > +     u8 tmod         =3D max(h616_ns_to_t(para, 15), 12); /* JEDEC: ma=
x(15 ns, 12nCK) */
> > +     u8 tcke         =3D max(h616_ns_to_t(para, 6), 3);   /* JEDEC: ma=
x(5.625 ns, 3nCK) */
> > +     u8 tcksrx       =3D max(h616_ns_to_t(para, 10), 4);  /* JEDEC: ma=
x(10 ns, 5nCK) */
> > +     u8 tcksre       =3D max(h616_ns_to_t(para, 10), 4);  /* JEDEC: ma=
x(10 ns, 5nCK) */
> >       u8 tckesr       =3D tcke + 1;             /* JEDEC: tCKE(min) + 1=
nCK */
> >       u8 trasmax      =3D (para->clk / 2) / 15; /* JEDEC: tREFI * 9 */
> > -     u8 txs          =3D ns_to_t(360) / 32;    /* JEDEC: max(5nCK,tRFC=
+10ns) */
> > +     u8 txs          =3D h616_ns_to_t(para, 360) / 32; /* JEDEC: max(5=
nCK,tRFC+10ns) */
> >       u8 txsdll       =3D 16;                   /* JEDEC: 512 nCK */
> >       u8 txsabort     =3D 4;                    /* ? */
> >       u8 txsfast      =3D 4;                    /* ? */
> > diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/=
mach-sunxi/dram_timings/h616_lpddr3.c
> > index ce2ffa7a020..d5106765b05 100644
> > --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> > +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> > @@ -14,33 +14,33 @@
> >  #include <asm/arch/dram.h>
> >  #include <asm/arch/cpu.h>
> >
> > -void mctl_set_timing_params(const struct dram_para *para)
> > +void h616_lpddr3_set_timing_params(const struct dram_para *para)
> >  {
> >       struct sunxi_mctl_ctl_reg * const mctl_ctl =3D
> >                       (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE=
;
> >
> >       u8 tccd         =3D 2;
> > -     u8 tfaw         =3D ns_to_t(50);
> > -     u8 trrd         =3D max(ns_to_t(6), 4);
> > -     u8 trcd         =3D ns_to_t(24);
> > -     u8 trc          =3D ns_to_t(70);
> > -     u8 txp          =3D max(ns_to_t(8), 3);
> > -     u8 trtp         =3D max(ns_to_t(8), 2);
> > -     u8 trp          =3D ns_to_t(27);
> > -     u8 tras         =3D ns_to_t(41);
> > -     u16 trefi       =3D ns_to_t(7800) / 64;
> > -     u16 trfc        =3D ns_to_t(210);
> > +     u8 tfaw         =3D h616_ns_to_t(para, 50);
> > +     u8 trrd         =3D max(h616_ns_to_t(para, 6), 4);
> > +     u8 trcd         =3D h616_ns_to_t(para, 24);
> > +     u8 trc          =3D h616_ns_to_t(para, 70);
> > +     u8 txp          =3D max(h616_ns_to_t(para, 8), 3);
> > +     u8 trtp         =3D max(h616_ns_to_t(para, 8), 2);
> > +     u8 trp          =3D h616_ns_to_t(para, 27);
> > +     u8 tras         =3D h616_ns_to_t(para, 41);
> > +     u16 trefi       =3D h616_ns_to_t(para, 7800) / 64;
> > +     u16 trfc        =3D h616_ns_to_t(para, 210);
> >       u16 txsr        =3D 88;
> >
> >       u8 tmrw         =3D 5;
> >       u8 tmrd         =3D 5;
> > -     u8 tmod         =3D max(ns_to_t(15), 12);
> > -     u8 tcke         =3D max(ns_to_t(6), 3);
> > -     u8 tcksrx       =3D max(ns_to_t(12), 4);
> > -     u8 tcksre       =3D max(ns_to_t(12), 4);
> > +     u8 tmod         =3D max(h616_ns_to_t(para, 15), 12);
> > +     u8 tcke         =3D max(h616_ns_to_t(para, 6), 3);
> > +     u8 tcksrx       =3D max(h616_ns_to_t(para, 12), 4);
> > +     u8 tcksre       =3D max(h616_ns_to_t(para, 12), 4);
> >       u8 tckesr       =3D tcke + 2;
> >       u8 trasmax      =3D (para->clk / 2) / 16;
> > -     u8 txs          =3D ns_to_t(360) / 32;
> > +     u8 txs          =3D h616_ns_to_t(para, 360) / 32;
> >       u8 txsdll       =3D 16;
> >       u8 txsabort     =3D 4;
> >       u8 txsfast      =3D 4;
> > diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch=
/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > index 6f5c4acbd62..e1ea41f7a3e 100644
> > --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > @@ -12,30 +12,30 @@
> >  #include <asm/arch/dram.h>
> >  #include <asm/arch/cpu.h>
> >
> > -void mctl_set_timing_params(const struct dram_para *para)
> > +void h616_lpddr4_set_timing_params(const struct dram_para *para)
> >  {
> >       struct sunxi_mctl_ctl_reg * const mctl_ctl =3D
> >                       (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE=
;
> >
> >       u8 tccd         =3D 4;
> > -     u8 tfaw         =3D ns_to_t(40);
> > -     u8 trrd         =3D max(ns_to_t(10), 2);
> > -     u8 trcd         =3D max(ns_to_t(18), 2);
> > -     u8 trc          =3D ns_to_t(65);
> > -     u8 txp          =3D max(ns_to_t(8), 2);
> > +     u8 tfaw         =3D h616_ns_to_t(para, 40);
> > +     u8 trrd         =3D max(h616_ns_to_t(para, 10), 2);
> > +     u8 trcd         =3D max(h616_ns_to_t(para, 18), 2);
> > +     u8 trc          =3D h616_ns_to_t(para, 65);
> > +     u8 txp          =3D max(h616_ns_to_t(para, 8), 2);
> >       u8 trtp         =3D 4;
> > -     u8 trp          =3D ns_to_t(21);
> > -     u8 tras         =3D ns_to_t(42);
> > -     u16 trefi       =3D ns_to_t(3904) / 32;
> > -     u16 trfc        =3D ns_to_t(280);
> > -     u16 txsr        =3D ns_to_t(190);
> > +     u8 trp          =3D h616_ns_to_t(para, 21);
> > +     u8 tras         =3D h616_ns_to_t(para, 42);
> > +     u16 trefi       =3D h616_ns_to_t(para, 3904) / 32;
> > +     u16 trfc        =3D h616_ns_to_t(para, 280);
> > +     u16 txsr        =3D h616_ns_to_t(para, 190);
> >
> > -     u8 tmrw         =3D max(ns_to_t(14), 5);
> > +     u8 tmrw         =3D max(h616_ns_to_t(para, 14), 5);
> >       u8 tmrd         =3D tmrw;
> >       u8 tmod         =3D 12;
> > -     u8 tcke         =3D max(ns_to_t(15), 2);
> > -     u8 tcksrx       =3D max(ns_to_t(2), 2);
> > -     u8 tcksre       =3D max(ns_to_t(5), 2);
> > +     u8 tcke         =3D max(h616_ns_to_t(para, 15), 2);
> > +     u8 tcksrx       =3D max(h616_ns_to_t(para, 2), 2);
> > +     u8 tcksre       =3D max(h616_ns_to_t(para, 5), 2);
> >       u8 tckesr       =3D tcke;
> >       u8 trasmax      =3D (trefi * 9) / 32;
> >       u8 txs          =3D 4;
> > @@ -49,7 +49,7 @@ void mctl_set_timing_params(const struct dram_para *p=
ara)
> >
> >       u8 twtp         =3D 24;
> >       u8 twr2rd       =3D max(trrd, (u8)4) + 14;
> > -     u8 trd2wr       =3D (ns_to_t(4) + 17) - ns_to_t(1);
> > +     u8 trd2wr       =3D (h616_ns_to_t(para, 4) + 17) - h616_ns_to_t(p=
ara, 1);
> >
> >       /* set DRAM timing */
> >       writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
>
