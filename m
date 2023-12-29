Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED13C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 18:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A354187B31;
	Fri, 29 Dec 2023 19:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VDMy3z6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC99987B31; Fri, 29 Dec 2023 19:55:10 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B238887B34
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 19:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5ae89c7bso25319215e9.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703876106; x=1704480906;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRfefyBHlApr0E3xvs0/GgMOamf4k0jCS1eMwI201eI=;
 b=VDMy3z6vIxtsxto4RebW+3oRmO96F8Ydf4i4NI8bAmS6WFn9bd4Dps0SdDWX2eXWCb
 IoaE9Bp89C3JwOZfoC6qi/dNsKIlfFFxyHLunoh8kmd+9yOXvInwg1YInuYFqs4s7CTK
 fyJg4D4SiQ/cuyqw91fUXLaLQXN/RLotYI2vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703876106; x=1704480906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRfefyBHlApr0E3xvs0/GgMOamf4k0jCS1eMwI201eI=;
 b=vmgml8eocAO2qFtw32WaqoCbm3mkSlGUTZZYjn5vc8MwMHH1Rm+LW/L5w9kSJjSAlB
 sJRPiIAE3M+qwmdoadHz01JLBo+/BlcFZCn5jySIZgEsWRCbMj9JRgcu8mXdWIoXTSQm
 L4DstzjMurAA8j9S8hDINqnIEfcWkpZCUyisJyRGOt0BmtQe/ffxat8DVtTDQoUpPXYI
 z0GKZMT/Ufrq3UyG1urLpnarxMfFXhXSRTiYf0ajVEc8R3GaD7ixViiKT1xrmHSjqPFH
 gas80J9O6+JWw0F36x846UqcITy9DnlK7lzNzW3NliwPownCSvJrC6Yd4ef+S3pEBUg+
 lyaQ==
X-Gm-Message-State: AOJu0YxcABbFjEtXzcYMcPWHzYz2fdPYOrFWlBMGz8wY5mVJAQVzNW16
 8Kl4yQfHcYNUnNcX1wwm2UT96daH/mdspQ==
X-Google-Smtp-Source: AGHT+IFq5Crg5b4ldJSiVWX29GKkyC8h9LrGCu2hUOrDSENxxUEv9uMGaTgqEZCzIsp4zpxAXnhqhw==
X-Received: by 2002:a05:600c:ca:b0:40d:376b:c640 with SMTP id
 u10-20020a05600c00ca00b0040d376bc640mr8602134wmm.102.1703876105502; 
 Fri, 29 Dec 2023 10:55:05 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 jh3-20020a05600ca08300b0040d81d16711sm187565wmb.16.2023.12.29.10.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 10:55:05 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Marek Vasut <marex@denx.de>, Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH v13 15/24] cli: add modern hush as parser for
 run_command*()
Date: Fri, 29 Dec 2023 19:55:04 +0100
Message-ID: <2712762.mvXUDI8C0e@pwmachine>
In-Reply-To: <CAFLszTi_S4Q+=i-1=-UjBN7RWUOSC+FF1B3p8z7rU8spMh2YXQ@mail.gmail.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <20231222212312.GE2652760@bill-the-cat>
 <CAFLszTi_S4Q+=i-1=-UjBN7RWUOSC+FF1B3p8z7rU8spMh2YXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Hi!

Le mardi 26 d=C3=A9cembre 2023, 10:46:48 CET Simon Glass a =C3=A9crit :
> Hi,
>=20
> On Fri, Dec 22, 2023 at 9:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> > On Fri, Dec 22, 2023 at 10:10:42PM +0100, Francis Laniel wrote:
> > > Hi!
> > >=20
> > > Le vendredi 22 d=C3=A9cembre 2023, 22:02:35 CET Francis Laniel a =C3=
=A9crit :
> > > > Enables using, in code, modern hush as parser for run_command funct=
ion
> > > > family. It also enables the command run to be used by CLI user of
> > > > modern
> > > > hush.
> > > >=20
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> >=20
> > [snip]
> >=20
> > > > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > > > index a9b555c779..104f49deef 100644
> > > > --- a/test/boot/bootflow.c
> > > > +++ b/test/boot/bootflow.c
> > > > @@ -710,7 +710,21 @@ static int bootflow_scan_menu_boot(struct
> > > > unit_test_state *uts) ut_assert_skip_to_line("(2 bootflows, 2
> > > > valid)");
> > > >=20
> > > >     ut_assert_nextline("Selected: Armbian");
> > > >=20
> > > > -   ut_assert_skip_to_line("Boot failed (err=3D-14)");
> > > > +
> > > > +   if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> > > > +           /*
> > > > +            * With old hush, despite booti failing to boot, i.e.
> > > > returning
> > > > +            * CMD_RET_FAILURE, run_command() returns 0 which leads
> > >=20
> > > bootflow_boot(),
> > >=20
> > > > as +                 * we are using bootmeth_script here, to return
> > > > -EFAULT. +            */
> > > > +           ut_assert_skip_to_line("Boot failed (err=3D-14)");
> > > > +   } else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
> > > > +           /*
> > > > +            * While with modern one, run_command() propagates
> > >=20
> > > CMD_RET_FAILURE
> > >=20
> > > > returned +           * by booti, so we get 1 here.
> > > > +            */
> > > > +           ut_assert_skip_to_line("Boot failed (err=3D1)");
> > > > +   }
> > >=20
> > > I would like to give a bit of context here.
> > > With the following patch:
> > > diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> > > index c169c835e3..cc5adda0a3 100644
> > > --- a/test/py/tests/test_ut.py
> > > +++ b/test/py/tests/test_ut.py
> > > @@ -173,7 +173,7 @@ else
> > >=20
> > >         fi
> > > =20
> > >  fi
> > >  booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
> > >=20
> > > -
> > > +echo $?
> > >=20
> > >  # Recompile with:
> > >  # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
> > >  ''' % (mmc_dev)
> > >=20
> > > We can easily see that booti is failing while running the test:
> > > $ ./test/py/test.py -o log_cli=3Dtrue -s --build -v -k
> > > 'test_ut[ut_bootstd_bootflow_scan_menu_boot'
> > > ...
> > > Aborting!
> > > Failed to load '/boot/dtb/rockchip/overlay/-fixup.scr'
> > > 1
> > >=20
> > > The problem with old hush, is that the 1 returned here, which
> > > corresponds to CMD_RET_FAILURE, is not propagated as the return value
> > > of run_command(). So, this lead the -EFAULT branch here to be taken:
> > > int bootflow_boot(struct bootflow *bflow)
> > > {
> > >=20
> > >       /* ... */
> > >      =20
> > >       ret =3D bootmeth_boot(bflow->method, bflow);
> > >       if (ret)
> > >      =20
> > >               return log_msg_ret("boot", ret);
> > >      =20
> > >       /*
> > >      =20
> > >        * internal error, should not get here since we should have boo=
ted
> > >        * something or returned an error
> > >        */
> > >      =20
> > >       return log_msg_ret("end", -EFAULT);
> > >=20
> > > }
> > >=20
> > > With modern hush, CMD_RET_FAILURE is propagated as the return value of
> > > run_command().
> > > As a consequence, we return with log_mst_ret("boot", 1), which leaded=
 to
> > > this test to fail.
> > > The above modification consists in adapting the expected output to the
> > > current shell flavor.
> > > I think this is the good thing to do, as I find modern hush behavior
> > > better
> > > than the old one, i.e. it propagates CMD_RET_FAILURE as return of
> > > run_command().
> >=20
> > Oh very nice, thanks for digging in to this and explaining!
>=20
> Yes, thank you from me too!

You are welcome!
=20
>=20
> - Simon

Best regards and have a nice end of the year!


