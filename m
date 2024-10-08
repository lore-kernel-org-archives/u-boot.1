Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1488CEF15E
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 12:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6930588BBC;
	Tue,  8 Oct 2024 14:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GJ8Kab3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D67088E0A; Tue,  8 Oct 2024 14:12:53 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FC488B63
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 14:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5398e33155fso6862795e87.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728389570; x=1728994370;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbY81kKoZgbGJEpc3AAVmtFBWx2+Nr5O8Z1IABiI+d0=;
 b=GJ8Kab3vc9hCUWVgJPAnVcSJVYRXC4c1OAj8A/0xb1KvyQveb8M1XJ5BB+SjsO0tSA
 vXh5UCPjNW5yWAz1MhS3Lh7+aeo7/o5iPzAW1/QqJcCvEegjzXkhNW2KJl+JhIuSF2UC
 0I97ygYwQ903SY9DmttuDl4XvQKfPmviMXZXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728389570; x=1728994370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbY81kKoZgbGJEpc3AAVmtFBWx2+Nr5O8Z1IABiI+d0=;
 b=Y6N1Yaz8feRSqEuA1Kqhlmbo0pvd8eshSrq/4O81df8+yJnjbmliBdc18SY6ZXSDa4
 yz10DSKdd8AQpFF3025fx3wfyYZu0+ES7IiO0salNvMpU3lZIJ8V2g666NaQXdw/m5cF
 K6FLMEy0f0ctGuynNwwV5P7xbdt4jJXpaei66cqSvFiAenyisZ3mxLmDlcgAoLDdRotA
 6lRqo5+MKECy4ikpUTFa7DOPUFNLgWRoGTs50AGcwx40NNIPZiZ9y3VO3Kkn/O0xux6Q
 cnar7wGf36eynX16YRFLkvZmsWBrPLK/sH3CyglQgJ3zWq/a2ersPX/EZp9DlHS9CuCD
 79yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPftEK+ZR9y4402DmiNxJIgWZSHxZUN8ELT8K4n43tzSUmh6CFTgwTtxhuYrQ4DEYJi8hU914=@lists.denx.de
X-Gm-Message-State: AOJu0YwLSQh3bu1U0hLk6sBbatL4cKUHeQQhXHPwciExXoTaVkPFqy55
 +ryjzrotvLK0u02HncuGORSpbEbfwQgLihqMewUp/4CM3cfZV3aiiMvN20AKfNzTYlNDPmfaKiz
 UaCxTGGy7YH4A86N+T3NOQgoi1MGhmgd7ugEVXg==
X-Google-Smtp-Source: AGHT+IHBajPgnJ1+byyUsF3uBl/UfYZ4eMRORGYZuYAUyR7JOIZV0DjhbmHjdu/xeeP9ddniOaWXukrXxSL3YfSsZT8=
X-Received: by 2002:a05:6512:3a91:b0:539:94c4:d9cb with SMTP id
 2adb3069b0e04-539ab88c4d6mr7406568e87.31.1728389570265; Tue, 08 Oct 2024
 05:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
 <010201926bef0b2e-c1230e3e-a51a-4953-9c41-c2b116ac28ed-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201926bef0b2e-c1230e3e-a51a-4953-9c41-c2b116ac28ed-000000@eu-west-1.amazonses.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 8 Oct 2024 14:12:38 +0200
Message-ID: <CAOf5uwnNSn-XGP9e54_Q4Kr1dpTkuYqFUyjgdgiPA57TOxjAvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de, Nicolas Ferre <nicolas.ferre@microchip.com>
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

Hi

On Tue, Oct 8, 2024 at 1:41=E2=80=AFPM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 9/30/24 11:07, Alexander Dahl wrote:
> > Hello,
> >
> > Am Tue, May 28, 2024 at 12:32:44PM +0200 schrieb Alexander Dahl:
> >> Hei hei,
> >>
> >> Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
> >>> From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
> >>> like we have to wait tREA after rising RE# before sampling the data.
> >>> Thus pulse time must be at least tREA.
> >>>
> >>> Without this fix we got PMECC errors when reading, after switching to
> >>> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.
> >>>
> >>> The approach to set timings used before worked on sam9g20 and sama5d2
> >>> with the same flash (S34ML02G1), probably because those have a slower
> >>> mck clock rate and thus the resolution of the timings setup is not as
> >>> tight as with sam9x60.
> >>>
> >>> The approach to fix the issue was carried over from at91bootstrap, an=
d
> >>> has been successfully tested in at91bootstrap, U-Boot and Linux.
> >>>
> >>> Link: https://github.com/linux4sam/at91bootstrap/issues/174
> >>> Cc: Li Bin <bin.li@microchip.com>
> >>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> >>> ---
> >>>
> >>> Notes:
> >>>     v3:
> >>>     - initial patch version (not present in v1 and v2)
> >>
> >> This patch was send as part of a series, which you wanted to have some
> >> more time to test.  Besides that, has anyone looked into this
> >> particular fix?  Maybe it can be applied separately?
> >
> > I'd kindly ask what the status of this patch series is from U-Boot
> > NAND subsystem maintainers POV?  Could you test it?  Should I rebase
> > and resend?
> >
> > Two of these three patches are specific to at91 family, what's the
> > opinion of at91 maintainers on this?
>
> Hello Alexander,
>
> From at91 perspective I have no objections.
> As these are very NAND specific, I defer the patches to the NAND maintain=
ers.
>
> Eugen
>
> >
> > Link to the series discussion for reference:
> >
> > https://lore.kernel.org/u-boot/20240415074547.779264-1-ada@thorsis.com/=
T/#u
> >
> > Greets
> > Alex
> >

I will review this series

Michael

> >>
> >> Greets
> >> Alex
> >>
> >>>
> >>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
> >>>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/m=
td/nand/raw/atmel/nand-controller.c
> >>> index bbafc88e44c..00ffeadd113 100644
> >>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struc=
t atmel_nand *nand,
> >>>                                       const struct nand_data_interfac=
e *conf,
> >>>                                       struct atmel_smc_cs_conf *smcco=
nf)
> >>>  {
> >>> -   u32 ncycles, totalcycles, timeps, mckperiodps;
> >>> +   u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
> >>>     struct atmel_nand_controller *nc;
> >>>     int ret;
> >>>
> >>> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(str=
uct atmel_nand *nand,
> >>>                      ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
> >>>
> >>>     /*
> >>> -    * Read pulse timing directly matches tRP:
> >>> +    * Read pulse timing would directly match tRP,
> >>> +    * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
> >>> +    * do not work properly in timing mode 3.
> >>> +    * The workaround is to extend the SMC NRD pulse to meet tREA
> >>> +    * timing.
> >>>      *
> >>> -    * NRD_PULSE =3D tRP
> >>> +    * NRD_PULSE =3D max(tRP, tREA)
> >>>      */
> >>> -   ncycles =3D DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
> >>> +   pulse =3D max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_m=
ax);
> >>> +   ncycles =3D DIV_ROUND_UP(pulse, mckperiodps);
> >>>     totalcycles +=3D ncycles;
> >>>     ret =3D atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
> >>>                                       ncycles);
> >>> --
> >>> 2.39.2
> >>>
> >>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
