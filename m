Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72488C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB8087D46;
	Wed, 26 Jun 2024 15:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TampfxTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AC9880AD; Wed, 26 Jun 2024 15:56:31 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4008657F
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 15:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d55e2e0327so795241b6e.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719410188; x=1720014988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AJXaUoJj//3nfgZzcaRbS79FdWccj/S6qY6gM7mQTGA=;
 b=TampfxTvrR5SsiVWJD0wK4Bi2v5LJcj467urQ2+zemq1ia5AgTzc/OUkrXMviC60HU
 U710Yh94hTHFEyA7DNpo/buA+zE0od+oZhCsVsSGdKTlJ/5DbgDZs7oxsKNtB4Abrvux
 5C2iIRqZo8kgm7dL2gsVkhbvl0MmRT5uSW65M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719410188; x=1720014988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJXaUoJj//3nfgZzcaRbS79FdWccj/S6qY6gM7mQTGA=;
 b=Gz/iBGHD71tx0zKJJ9pJAtTpH+VKEdksLVAxphiTYvu8OSka2aAlFQUuUl94j+ubL+
 f3JVGBTqA7mPYFkDGlAQENxNunFSzuZlKaZRyme8AeHht/WmOdxU95U3SeFFXBlnpBo1
 9ctl1kKAHxaB9ns/9hGwsx48+EY3JuRFT6SH4+G/XhtgOUVUyNzjewVpVdi3b5z3HKch
 HcYN65e1BTqp/ts4HDXCKxh7wIcvWTfB+F5qiB2kXVzxp7hp+baNT1x9NUjCUc/RUfAC
 YxjZM9JuZhoI1zWpTpH+3TH3yxwQ3XMlo2lkVnLeZ3vHkwq4svmVMSv65ZdZLh8HhWU9
 0YsA==
X-Gm-Message-State: AOJu0Yy2LYwC4OjPurPco4P4K4czrygZ3w8NgYj0dbrdZzauk1pkZqTh
 chjNuliVdUrgLEfPeOYkmDv8xBkm3s+ZOenJk27TJNNdCvyMNboRqGKw4sHq/ww=
X-Google-Smtp-Source: AGHT+IF9LM3ldzc+Rxe8mqiw5qupHQ5ZwW8lCqF527nXF0u1/C3kdjpdDhHABNJz6suz63p2/w/SsQ==
X-Received: by 2002:a05:6808:f13:b0:3d5:64e0:d1ff with SMTP id
 5614622812f47-3d564e0d52cmr524022b6e.59.1719410187948; 
 Wed, 26 Jun 2024 06:56:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5344fa290sm2309292b6e.14.2024.06.26.06.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 06:56:26 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:56:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
Message-ID: <20240626135624.GT38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
 <20240625141432.GP38804@bill-the-cat>
 <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oQ+HaoIlxfcQO9ji"
Content-Disposition: inline
In-Reply-To: <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--oQ+HaoIlxfcQO9ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 09:00:42AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 01:38:00PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
> > > >
> > > > > When a test returns -EAGAIN this should not be considered a failu=
re.
> > > > > Fix what seems to be a problem case, where the pytests see a fail=
ure
> > > > > when a test has merely been skipped.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  test/test-main.c | 16 +++++++++++-----
> > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/test/test-main.c b/test/test-main.c
> > > > > index 3fa6f6e32ec..cda1a186390 100644
> > > > > --- a/test/test-main.c
> > > > > +++ b/test/test-main.c
> > > > > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state=
 *uts, struct unit_test *test,
> > > > >  static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > >                                struct unit_test *test)
> > > > >  {
> > > > > -     int runs;
> > > > > +     int runs, ret;
> > > > >
> > > > >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFI=
G_SANDBOX))
> > > > >               return skip_test(uts);
> > > > > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit=
_test_state *uts,
> > > > >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> > > > >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> > > > >                       uts->of_live =3D true;
> > > > > -                     ut_assertok(ut_run_test(uts, test, test->na=
me));
> > > > > -                     runs++;
> > > > > +                     ret =3D ut_run_test(uts, test, test->name);
> > > > > +                     if (ret !=3D -EAGAIN) {
> > > > > +                             ut_assertok(ret);
> > > > > +                             runs++;
> > > > > +                     }
> > > > >               }
> > > > >       }
> > > > >
> > > > > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit=
_test_state *uts,
> > > > >           (!runs || ut_test_run_on_flattree(test)) &&
> > > > >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> > > > >               uts->of_live =3D false;
> > > > > -             ut_assertok(ut_run_test(uts, test, test->name));
> > > > > -             runs++;
> > > > > +             ret =3D ut_run_test(uts, test, test->name);
> > > > > +             if (ret !=3D -EAGAIN) {
> > > > > +                     ut_assertok(ret);
> > > > > +                     runs++;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       return 0;
> > > >
> > > > How did you trigger this case exactly?
> > >
> > > I noticed this in CI, where some skipped tests were shown as failed in
> > > the log, even though they were not counted as failures in the final
> > > results.
> >
> > That's really really strange, do you have an example log or something
> > around still?
>=20
> This happens on snow, which is (maybe) the only real board that
> defines CONFIG_UNIT_TEST

I think it is too, but that's also perhaps a reminder that I should be
enabling it as part of my build before testing scripts. I'll go do that
now and see if this problem shows up a tiny bit more widely.

> test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
> Test: bdinfo_test_eth: bdinfo.c
> Skipping: Console recording disabled
> test/test-main.c:486, ut_run_test_live_flat(): 0 =3D=3D ut_run_test(uts,
> test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
> Test bdinfo_test_eth failed 1 times
> Skipped: 1, Failures: 1
> snow # F+u-boot-test-reset snow snow
>=20
> For this particular mechanism (-EAGAIN returned by test_pre_run()) , I
> think a better fix would be to squash the error in ut_run_test(), as
> is done when -EAGAIN is returned in the body of the test. I'll update
> that. I cannot see any other way this could happen, but we can always
> deal with it later if it does.

Thanks for explaining, please also include the example in the commit
message in v2.

--=20
Tom

--oQ+HaoIlxfcQO9ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ8HgUACgkQFHw5/5Y0
tyxo/QwAjjy8fUG77FITiPsO8UX/g98JSsOptgir9CLRXbFVaNkYxMK2HSx/YRHR
4f/utH/l9k2jrGBRx5IU1qnsza8pUZAC8vcSkal9yhKXf5ese/3/EBIEsoo1DTsZ
sW6hFB/TvRdabMCQLuokQqn0BQzKouDmcLhbGmvnTRGLeAJkMzM0YwmaIWSu+yB+
aZSH5WsF06EOtSS9wQfLG1QcXRY5FZnSrQVcPEuld3tAApFhzzG0QB8wxi5ZhILZ
uUVFquaOBAAUxGuX2TQFw8GC466i6g3Tu/9yzmNSazH2Nn1fjUcMGsLerLo7GJMQ
r+5otQO4mwkkevNvcLxU51wYLWfX9EHZjqobOPUNNkZV0Rxi7pR+H138eOq+XeAg
3ImhA+mGESg5bSgp66VMJ7yH0Lgca1Gu39SFdFXyvPF/WgAhFd9R4Or2zGm3zvrd
3nJxkDObGSxwyTWmbSWjd5NaZiI3y6Gn8rbUL9JKH1oTKxWL36r4CNWAtij1GEul
U4Ar+Zd7
=BesL
-----END PGP SIGNATURE-----

--oQ+HaoIlxfcQO9ji--
