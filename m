Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA7C52D71
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 16:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C78886E7;
	Tue,  6 Aug 2024 18:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="dQ3Q3ocn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123A7886BB; Tue,  6 Aug 2024 18:42:57 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5A4888FB
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 18:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso1088654e87.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1722962569; x=1723567369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56iHT+qiicUeUud8shCzJRcV6BJ3qYLO7GIT/j7yxMA=;
 b=dQ3Q3ocn95vG6tOTwE1yCmHZBy5OoNowu98Pg5Z6YPs21aTMJhA8g4KzInrmYCGHxl
 yYQr3l9wgHBbIgg+BykgjhSo8aP9qqMa2WIaYV7F2ulD46I5hzBZNPFQfK2e1P+cC4y1
 aE2aOQvDq75GC5w9aV1bWkIrj6Ntv3y4p2YzpQa8ayFIrHGuAeGMZZH9Hxg+bG99Skc3
 idOLj9V0UwczQzI8DdXyKMz8ulZo3jdECnzXdt+1m5oTyTLBsrHT2ulZtRQClJmttCOq
 rZ0mf/GPumk7qbByJm6tfcGifq4r+4MH5dD7Tr/NwH5H/WGkl87qcEZgRQH7QN6Agpqg
 UUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722962569; x=1723567369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56iHT+qiicUeUud8shCzJRcV6BJ3qYLO7GIT/j7yxMA=;
 b=etkyg4XAC+rGV/BKMiRcudHGyj7eBHRgNBFaQZytMOTZ1VJi5OgIgrvMO/dIUKBJdH
 8IZJhKib3LHEWqnIdVDAJ5lZmBQgFO91giWDksaXQyLhpzMSZL0DW8j1hfAEIVHl0Eq7
 qcdfH8MrU4bteqLmKHDOV5xPtF9vdkiITeTDwA9vLaMFwtKsCSNA19A6cnWAlP4GsR6O
 IP22/xNNwaUiGNJUvbreHqwUC592UHpeA6k6KXpn3o4V7ZIv8NswcoP5TG4qKnkQMgwt
 aG8S1+4INYPiVfK2WWK61DMB1DeLy9wjYnSuPHyWMPAe6SkCqQDaACcKzwBicvjobmDA
 akhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi+3UpW1IjFWJCi62rUctodVOU14VT44aNcV9ZWmi3y80caNhM1boNHIxiYg3vdyLp8WRrrSzgrf8QB6R/EGZfO5Xt0Q==
X-Gm-Message-State: AOJu0Yzgph6ERiyybQnP7Dd5tOIF3kaxBL+lnTf9mSFXKF7+AfdCu+Zz
 9Gb2efG+XF88nKnu1G3oT1q8QteF033NmYcVobCXmDlahfzjV5a+Z/R8aj1NZRY=
X-Google-Smtp-Source: AGHT+IFd5BJvQSh2zEbC0KhyZRw3nlJaqNcNs1luMisuR6dHknlA3s++QUsowhy5Mlp63Em2j9mP4Q==
X-Received: by 2002:a05:6512:234a:b0:530:ba42:8439 with SMTP id
 2adb3069b0e04-530bb388532mr9914829e87.34.1722962569152; 
 Tue, 06 Aug 2024 09:42:49 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bb5117ffa0sm3174744a12.41.2024.08.06.09.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 09:42:48 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de,
 upstream@sigma-star.at, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: upstream+uboot@sigma-star.at, francis.laniel@amarulasolutions.com,
 glaroque@baylibre.com, sjg@chromium.org, christian.taedcke@weidmueller.com,
 trini@konsulko.com
Subject: Re: [PATCH 2/3] test_fs: Rename mount dir to scratch
Date: Tue, 06 Aug 2024 18:42:47 +0200
Message-ID: <2716805.Hd9D3QOfv1@somecomputer>
In-Reply-To: <87plqloedx.fsf@baylibre.com>
References: <20240802093322.15240-1-richard@nod.at>
 <20240802093322.15240-2-richard@nod.at> <87plqloedx.fsf@baylibre.com>
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

Mattijs,

Am Dienstag, 6. August 2024, 17:32:58 CEST schrieb Mattijs Korpershoek:
> Hi Richard,
>=20
> Thank you for the patch.
>=20
> On ven., ao=C3=BBt 02, 2024 at 11:33, Richard Weinberger <richard@nod.at>=
 wrote:
>=20
> > Since no mounting happens anymore, rename the "mnt"
> > directory to "scratch" and the related variables.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  test/py/tests/test_fs/conftest.py | 66 +++++++++++++++----------------
> >  1 file changed, 33 insertions(+), 33 deletions(-)
> >
> > diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/=
conftest.py
> > index 59342a6e3d..af2adaf164 100644
> > --- a/test/py/tests/test_fs/conftest.py
> > +++ b/test/py/tests/test_fs/conftest.py
> > @@ -178,13 +178,13 @@ def fs_obj_basic(request, u_boot_config):
> >      fs_ubtype =3D fstype_to_ubname(fs_type)
> >      check_ubconfig(u_boot_config, fs_ubtype)
> > =20
> > -    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
> > +    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
> > =20
> > -    small_file =3D mount_dir + '/' + SMALL_FILE
> > -    big_file =3D mount_dir + '/' + BIG_FILE
> > +    small_file =3D scratch_dir + '/' + SMALL_FILE
> > +    big_file =3D scratch_dir + '/' + BIG_FILE
> > =20
> >      try:
> > -        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
> > +        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
> >      except CalledProcessError as err:
> >          pytest.skip('Preparing mount folder failed for filesystem: ' +=
 fs_type + '. {}'.format(err))
>=20
> Should we update the error message here as well?

Sure, thanks for pointing out!
I'll send a v2.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


