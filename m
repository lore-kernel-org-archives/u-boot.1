Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B713C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B49682998;
	Fri, 11 Jul 2025 22:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D+FfH1Kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBEC482C84; Fri, 11 Jul 2025 22:15:02 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD43828A2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71173646662so26999127b3.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752264898; x=1752869698; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1edGSMAlMIe1ef7XoRfwHQphOC6mOVGekUH7EpPL2FM=;
 b=D+FfH1KcZ30K9TazaVyIgSL0fvqMEPSp0b47jKE8VN502DQqtsV5lxGGhvFpoj0pel
 vrnjo0hvAOckaORvbb2z/a45NC4tIO8wRw+yIv6gnHcrUy4GuxyT3hn/n9gPH1PyxxKd
 WcSwhD/r/1jiDpaBDldIZC5iZcirYF3lQM4xiTr0K4d3W2DeMfIu7UoWJInPIvAL+FyT
 fLDaWUjvfpSgkB0A1SpPzwmagU0zuqOzYJNXHyubGtKkPhNyUEECrhvYsEc32ldubVCR
 9+IBRgDjdA2uehGnqmd5zB0KJdGYjcMUUET9ME0kIndFz3F+/LUFP8YsX9UzgSf+ELqj
 8usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264898; x=1752869698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1edGSMAlMIe1ef7XoRfwHQphOC6mOVGekUH7EpPL2FM=;
 b=aZERmYEaHxJhqbU6YZo53TTSzNdsIfM22wKqBah+lU0lBnQmWO/UlW6aIqTby+1kEM
 lcwQ50nKIfSLhqNwAZw5GaUIbkIPCpBioayYkLYOoMpc21dvm5aEtaGuT1pI7WygThGr
 0dE4C+mQYdilCGG03mGiU7j1cyHYoM1c7vICtx+TSEsfISb/xBBjqYc/kVPKCxLKLEew
 qZzhg6W0J0AWvOXS3wkpGhn5N97u6ctHOswHC75HWWVqy79fK2QkmLhJBvjjOamzevef
 cowCbPWoCiS7Pi5jW2hAkY/VaR0vr3eLid0l3u4q6o5LbsY1ZQSEmWKKzAUcqKhPgNzL
 JCyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ZG2kPk+OTr8WsQuFM57Pvj1RS6Racn+1NozpgQUy1WCWcnTRXqzZX6LMUzJ8ABz6Da8Uugk=@lists.denx.de
X-Gm-Message-State: AOJu0YxgmfZBpM2YYldqxm0mFWAvO7IV0UT9C9lMBLLFaw976wIfsd1Z
 QtElCVVJ/gvDxgAdizx/UVZNTUzrgZLXsy/5XQ24RkTePeeGiqARNjhuWKNcppLqHCFmiQ/ISIs
 Lopab5QoxXjgI8dHWk0xz1Vz/Yf87IS8/veHKTdBUMg==
X-Gm-Gg: ASbGncuFi9VWeXSo7ieGegOmHaTVE4PihExHR+XJIZSqV+E8tVolq7WHaCenbblh9ed
 xhViHRyVhtZOyMTDlF8CgA4P4+Gq9LghMiTpNeIdO5UFP+KsXsh2/CFgohZaAnp+lEyeojiM4tV
 cyRsXoYOlsHVaCs3cURnpUE1fPKubxT0Y29cM9eH7oA+6nRNyaghhfyQp7JlUMDaRgvxp8VPTp8
 cqaDv4lszeKYKXM+Q==
X-Google-Smtp-Source: AGHT+IHV2zzjwofzvkxhW0FW3gc+JE6seGzrk2pSt1EcRAHVteVqziewL2w1ZrBfKNUAVLQxe63sviT82UWXYhX5LEU=
X-Received: by 2002:a05:690c:6e04:b0:713:f7dd:5d7c with SMTP id
 00721157ae682-717d5dab9b3mr80711417b3.19.1752264897946; Fri, 11 Jul 2025
 13:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250709042342.13544-1-semen.protsenko@linaro.org>
 <874ivjjgtv.fsf@kernel.org>
In-Reply-To: <874ivjjgtv.fsf@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 11 Jul 2025 15:14:45 -0500
X-Gm-Features: Ac12FXw_NUB2JzgJi-rmDC8gZRMIIH8wyo912jv0Kirud_Cpip88pfibDVW7CGc
Message-ID: <CAPLW+4=C0rLu5GAFNYHFrraca0azW_t4QR0zN+6tmBD6B4oazg@mail.gmail.com>
Subject: Re: [PATCH] dfu: Fix dfu_config_interfaces() for single interface DFU
 syntax
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
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

On Fri, Jul 11, 2025 at 3:02=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Sam,
>
> Thank you for the patch.
>
> On Tue, Jul 08, 2025 at 23:23, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
>
> > As stated in DFU documentation [1], the device interface part might be
> > missing in dfu_alt_info:
> >
> >     dfu_alt_info
> >         The DFU setting for the USB download gadget with a semicolon
> >         separated string of information on each alternate:
> >             dfu_alt_info=3D"<alt1>;<alt2>;....;<altN>"
> >         When several devices are used, the format is:
> >             - <interface> <dev>'=3D'alternate list (';' separated)
> >
> > So in first case dfu_alt_info might look like something like this:
> >
> >     dfu_alt_info=3D"mmc 0=3Drawemmc raw 0 0x747c000 mmcpart 1;"
> >
> > And in second case (when the interface is missing):
> >
> >     dfu_alt_info=3D"rawemmc raw 0 0x747c000 mmcpart 1;"
> >
> > When the interface is not specified the 'dfu' command crashes when
> > called using 'dfu 0' or 'dfu list' syntax:
> >
> >     =3D> dfu list
> >     "Synchronous Abort" handler, esr 0x96000006, far 0x0
> >
> > That's happening due to incorrect string handling in
> > dfu_config_interfaces(). In case when the interface is not specified in
> > dfu_alt_info it triggers this corner case:
> >
> >     d =3D strsep(&s, "=3D");  // now d contains s, and s is NULL
> >     if (!d)
> >         break;
> >     a =3D strsep(&s, "&");  // s is already NULL, so a is NULL too
> >     if (!a)               // corner case
> >         a =3D s;            // a is NULL now
> >
> > which causes NULL pointer dereference later in this call, due to 'a'
> > being NULL:
> >
> >     part =3D skip_spaces(part);
> >
> > That's because as per strsep() behavior, when delimiter ("&") is not
> > found, the token (a) becomes the entire string (s), and string (s)
> > becomes NULL. To fix that issue assign "a =3D d" instead of "a =3D s",
> > because at that point variable d actually contains previous s, which
> > should be used in this case.
> >
> > [1] doc/usage/dfu.rst
> >
> > Fixes: commit febabe3ed4f4 ("dfu: allow to manage DFU on several device=
s")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> Good catch! I can indeed reproduce this on sandbox after enabling
> CMD_DFU:
>
> $ ./u-boot -T
>
> [...]
>
> =3D> setenv dfu_alt_info "rawemmc raw 0 0x747c000 mmcpart 1;"
> =3D> dfu list
> [1]    116917 segmentation fault (core dumped)  ./u-boot -T
>
> And I confirm it's fixed with this patch.
>
> Thanks for all the details, it makes the review and the testing
> so much easier!
>

Sometimes it takes longer to write a commit message than to come up
with the patch itself, hehe. I also tried to come up with some test
for that use case, but when you run the Py test suite on the sandbox
-- it just skips the DFU test. I figured some env hooks have to be
provided to make it work, but it took too much time for me already, so
I kinda ended up skipping that part.

> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> > ---
> >  drivers/dfu/dfu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> > index 756569217bbb..eefdf44ec877 100644
> > --- a/drivers/dfu/dfu.c
> > +++ b/drivers/dfu/dfu.c
> > @@ -147,7 +147,7 @@ int dfu_config_interfaces(char *env)
> >                       break;
> >               a =3D strsep(&s, "&");
> >               if (!a)
> > -                     a =3D s;
> > +                     a =3D d;
> >               do {
> >                       part =3D strsep(&a, ";");
> >                       part =3D skip_spaces(part);
> > --
> > 2.39.5
