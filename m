Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE55C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A2B8788F;
	Tue, 26 Dec 2023 10:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f5HKcg66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69CF8788E; Tue, 26 Dec 2023 10:47:04 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE268787E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f5c0be04cso41073726d6.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584019; x=1704188819; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TERB0+WoxysLt36hLLd0SavbPJHRFclpyEHjHledRFQ=;
 b=f5HKcg66Rp9sNLwG3jU+0J8+fPrM95IJ7HQR6JZCB/wsXofnrATWOiWqZi7nBmNYFx
 ofpN7N9VoUOteJ5/BQLIB+wwH+NYPQiz85mVWLGdtTrRJrOo5rRB1YQ0FvPSyIEvO2AR
 z4Ee4viUoJ2mAD8HzIv2IhU/8KKw8JT/AV6iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584019; x=1704188819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TERB0+WoxysLt36hLLd0SavbPJHRFclpyEHjHledRFQ=;
 b=TXrmv5p5k18m87o5aAmkyeV4bI6Q/ZUPAcxtq4BZNYjnMkjuoujpHogxHOSFk1qmpV
 pg6x2UTE+axjrdhFGSgoSEyUMTlDPxxTCbhhyF9sED49O78jpQuZsihr4P1nL2OGo35j
 YjsVlO5HOTdq1hg+Zzxfo/rnMZwhoRSz3czDmnbf9Ykbaaov1lT7dx0n2vgczKZl2kc7
 X32RwR4VmkK3taWmMywoZyPX1QdGxeTRnp2aTrySNnw3OhUm44SDI3n3C4jQwIgBUn2K
 r2fl8XODmmfDLMAR2G84ThvPDTJcbkdWNhUVqUYVQfi4wZt1YnynNw4SvOuhGmsCzaf7
 Whlg==
X-Gm-Message-State: AOJu0YxrUHAxvfQLem3Nr2Qm0tG+qCZMlgKXjC4uZOip0ezbNk6B9hFb
 LhdmefKblQwSvO8QvmRJrZHno00M2SBEhFrHAWqKu3Dclp+k
X-Google-Smtp-Source: AGHT+IHAOz/9W4nJQEuz1Q9D/JJgd1YRo7FoFGUEShBTxVzaTG44taI31+fkP1fiHVhUbGIeIAUpuHNYbJJ//7CiDMc=
X-Received: by 2002:a05:6214:20cf:b0:67f:2fe1:44eb with SMTP id
 15-20020a05621420cf00b0067f2fe144ebmr12571345qve.0.1703584019361; Tue, 26 Dec
 2023 01:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <20231222210244.91830-16-francis.laniel@amarulasolutions.com>
 <5739012.DvuYhMxLoT@pwmachine> <20231222212312.GE2652760@bill-the-cat>
In-Reply-To: <20231222212312.GE2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:48 +0000
Message-ID: <CAFLszTi_S4Q+=i-1=-UjBN7RWUOSC+FF1B3p8z7rU8spMh2YXQ@mail.gmail.com>
Subject: Re: [PATCH v13 15/24] cli: add modern hush as parser for
 run_command*()
To: Tom Rini <trini@konsulko.com>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, 
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>, 
 Hector Palacios <hector.palacios@digi.com>
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

Hi,

On Fri, Dec 22, 2023 at 9:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Dec 22, 2023 at 10:10:42PM +0100, Francis Laniel wrote:
> > Hi!
> >
> >
> > Le vendredi 22 d=C3=A9cembre 2023, 22:02:35 CET Francis Laniel a =C3=A9=
crit :
> > > Enables using, in code, modern hush as parser for run_command functio=
n
> > > family. It also enables the command run to be used by CLI user of mod=
ern
> > > hush.
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> [snip]
> > > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > > index a9b555c779..104f49deef 100644
> > > --- a/test/boot/bootflow.c
> > > +++ b/test/boot/bootflow.c
> > > @@ -710,7 +710,21 @@ static int bootflow_scan_menu_boot(struct
> > > unit_test_state *uts) ut_assert_skip_to_line("(2 bootflows, 2 valid)"=
);
> > >
> > >     ut_assert_nextline("Selected: Armbian");
> > > -   ut_assert_skip_to_line("Boot failed (err=3D-14)");
> > > +
> > > +   if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> > > +           /*
> > > +            * With old hush, despite booti failing to boot, i.e. ret=
urning
> > > +            * CMD_RET_FAILURE, run_command() returns 0 which leads
> > bootflow_boot(),
> > > as +                 * we are using bootmeth_script here, to return -=
EFAULT.
> > > +            */
> > > +           ut_assert_skip_to_line("Boot failed (err=3D-14)");
> > > +   } else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
> > > +           /*
> > > +            * While with modern one, run_command() propagates
> > CMD_RET_FAILURE
> > > returned +           * by booti, so we get 1 here.
> > > +            */
> > > +           ut_assert_skip_to_line("Boot failed (err=3D1)");
> > > +   }
> >
> > I would like to give a bit of context here.
> > With the following patch:
> > diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> > index c169c835e3..cc5adda0a3 100644
> > --- a/test/py/tests/test_ut.py
> > +++ b/test/py/tests/test_ut.py
> > @@ -173,7 +173,7 @@ else
> >         fi
> >  fi
> >  booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
> > -
> > +echo $?
> >  # Recompile with:
> >  # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
> >  ''' % (mmc_dev)
> > We can easily see that booti is failing while running the test:
> > $ ./test/py/test.py -o log_cli=3Dtrue -s --build -v -k
> > 'test_ut[ut_bootstd_bootflow_scan_menu_boot'
> > ...
> > Aborting!
> > Failed to load '/boot/dtb/rockchip/overlay/-fixup.scr'
> > 1
> >
> > The problem with old hush, is that the 1 returned here, which correspon=
ds to
> > CMD_RET_FAILURE, is not propagated as the return value of run_command()=
.
> > So, this lead the -EFAULT branch here to be taken:
> > int bootflow_boot(struct bootflow *bflow)
> > {
> >       /* ... */
> >
> >       ret =3D bootmeth_boot(bflow->method, bflow);
> >       if (ret)
> >               return log_msg_ret("boot", ret);
> >
> >       /*
> >        * internal error, should not get here since we should have boote=
d
> >        * something or returned an error
> >        */
> >
> >       return log_msg_ret("end", -EFAULT);
> > }
> >
> > With modern hush, CMD_RET_FAILURE is propagated as the return value of
> > run_command().
> > As a consequence, we return with log_mst_ret("boot", 1), which leaded t=
o this
> > test to fail.
> > The above modification consists in adapting the expected output to the =
current
> > shell flavor.
> > I think this is the good thing to do, as I find modern hush behavior be=
tter
> > than the old one, i.e. it propagates CMD_RET_FAILURE as return of
> > run_command().
>
> Oh very nice, thanks for digging in to this and explaining!

Yes, thank you from me too!


- Simon
