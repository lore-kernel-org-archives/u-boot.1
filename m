Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5DDC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C34188A4C;
	Thu, 22 Aug 2024 16:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CvX6EnfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188DA88A56; Thu, 22 Aug 2024 16:29:07 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDD188395
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 16:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7093d565310so743092a34.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724336943; x=1724941743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xKwRvIKk2VhjIFX/Fe/Bczskr9ShkAeV635exQcmRgA=;
 b=CvX6EnfMraD6u1BbfpGxQspef+7VREJl2Zl+OHlQ69jHYKrOLhqQpP7TNFSKP/98ZL
 vHw5PTUsS4Tk7BaRBPmR1360Pkgf6+3OUHpaU+Q+Gmy1c3kL6luQodAz0PfHAnPdL1IR
 mwoT3QfVeBZ3vw2pP830TLI9SzBQbnAESnbHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724336943; x=1724941743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKwRvIKk2VhjIFX/Fe/Bczskr9ShkAeV635exQcmRgA=;
 b=V9lzOqHPibb76p8nKblJfocvX/yGMph+5t4tLqlyEN6iGZnQNksRZYzG2Ee92iSsII
 64L4/MwLFL/shskpEYa/udQ8BfAmwuwHYYegkt823i0cw5IRhPxoBum2nks343iwTRwS
 Ap2bg/Sv9rwQJQX+qKkPm8keSQnHINhGgDLFOGfAmvHtn5hY0PHddWx6bGVX/544gcI5
 V26EccKCE9d0w5HvI/9MNcDJcoeLgS1yy49dEBYwTXbeXlMkXBVXb8jtiIrigX/0sKaU
 67rw9ujK6ESJs9FkgphNXeWgMAXO649cQN5PKkUZL76nguEIjEkOE6FuxIgJOWLl0SdR
 P0jw==
X-Gm-Message-State: AOJu0Yz99GCF3A4qsK0XDpCPg40lS8LQmyY69/37Dhpu+vva0FQLHfGH
 8wKjtjXE4zjW9mI3/BeyaIlwT8CbJTEvPyptEybUeqhlWFvJF8zavPUvbEtbLVw=
X-Google-Smtp-Source: AGHT+IH+6Y04gtEsBIbr1yV0m+OXNFUCIKxNMjgJ5ntdzRpryuMsQBamrU5q/Lm6h61IIemBePwzUw==
X-Received: by 2002:a05:6808:2382:b0:3d5:4256:26d4 with SMTP id
 5614622812f47-3de194e0f77mr6438324b6e.7.1724336943391; 
 Thu, 22 Aug 2024 07:29:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de22571a5dsm291520b6e.32.2024.08.22.07.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 07:29:02 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:29:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
Message-ID: <20240822142900.GT1626301@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
 <20240625141432.GP38804@bill-the-cat>
 <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
 <CAFLszTgP71y2Z6Or5CLA+gzk=EfiwnfXFvdkeBqGKidLFGd6bQ@mail.gmail.com>
 <20240822141146.GR1626301@bill-the-cat>
 <CAFLszTiyPCH57NZMrbKg76Cg3NRhO5bHriRLWwgs5i5qPMhFVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qp0GlOjMxKawJmI6"
Content-Disposition: inline
In-Reply-To: <CAFLszTiyPCH57NZMrbKg76Cg3NRhO5bHriRLWwgs5i5qPMhFVQ@mail.gmail.com>
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


--Qp0GlOjMxKawJmI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 08:22:59AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 22 Aug 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 09:00:33PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 26 Jun 2024 at 02:00, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jun 25, 2024 at 01:38:00PM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > When a test returns -EAGAIN this should not be considered a=
 failure.
> > > > > > > > Fix what seems to be a problem case, where the pytests see =
a failure
> > > > > > > > when a test has merely been skipped.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  test/test-main.c | 16 +++++++++++-----
> > > > > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/test/test-main.c b/test/test-main.c
> > > > > > > > index 3fa6f6e32ec..cda1a186390 100644
> > > > > > > > --- a/test/test-main.c
> > > > > > > > +++ b/test/test-main.c
> > > > > > > > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test=
_state *uts, struct unit_test *test,
> > > > > > > >  static int ut_run_test_live_flat(struct unit_test_state *u=
ts,
> > > > > > > >                                struct unit_test *test)
> > > > > > > >  {
> > > > > > > > -     int runs;
> > > > > > > > +     int runs, ret;
> > > > > > > >
> > > > > > > >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED=
(CONFIG_SANDBOX))
> > > > > > > >               return skip_test(uts);
> > > > > > > > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struc=
t unit_test_state *uts,
> > > > > > > >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> > > > > > > >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> > > > > > > >                       uts->of_live =3D true;
> > > > > > > > -                     ut_assertok(ut_run_test(uts, test, te=
st->name));
> > > > > > > > -                     runs++;
> > > > > > > > +                     ret =3D ut_run_test(uts, test, test->=
name);
> > > > > > > > +                     if (ret !=3D -EAGAIN) {
> > > > > > > > +                             ut_assertok(ret);
> > > > > > > > +                             runs++;
> > > > > > > > +                     }
> > > > > > > >               }
> > > > > > > >       }
> > > > > > > >
> > > > > > > > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struc=
t unit_test_state *uts,
> > > > > > > >           (!runs || ut_test_run_on_flattree(test)) &&
> > > > > > > >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> > > > > > > >               uts->of_live =3D false;
> > > > > > > > -             ut_assertok(ut_run_test(uts, test, test->name=
));
> > > > > > > > -             runs++;
> > > > > > > > +             ret =3D ut_run_test(uts, test, test->name);
> > > > > > > > +             if (ret !=3D -EAGAIN) {
> > > > > > > > +                     ut_assertok(ret);
> > > > > > > > +                     runs++;
> > > > > > > > +             }
> > > > > > > >       }
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > >
> > > > > > > How did you trigger this case exactly?
> > > > > >
> > > > > > I noticed this in CI, where some skipped tests were shown as fa=
iled in
> > > > > > the log, even though they were not counted as failures in the f=
inal
> > > > > > results.
> > > > >
> > > > > That's really really strange, do you have an example log or somet=
hing
> > > > > around still?
> > > >
> > > > This happens on snow, which is (maybe) the only real board that
> > > > defines CONFIG_UNIT_TEST
> > > >
> > > > test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
> > > > Test: bdinfo_test_eth: bdinfo.c
> > > > Skipping: Console recording disabled
> > > > test/test-main.c:486, ut_run_test_live_flat(): 0 =3D=3D ut_run_test=
(uts,
> > > > test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
> > > > Test bdinfo_test_eth failed 1 times
> > > > Skipped: 1, Failures: 1
> > > > snow # F+u-boot-test-reset snow snow
> > > >
> > > > For this particular mechanism (-EAGAIN returned by test_pre_run()) =
, I
> > > > think a better fix would be to squash the error in ut_run_test(), as
> > > > is done when -EAGAIN is returned in the body of the test. I'll upda=
te
> > > > that. I cannot see any other way this could happen, but we can alwa=
ys
> > > > deal with it later if it does.
> > >
> > > No, that doesn't work, since the failure counting happens in the
> > > caller. This patch seems to be the right fix, so I'll send it again
> > > with a better commit message.
> >
> > And I'll try and test it on Pi as with the series I posted and so
> > UNIT_TEST compiles on there, I got what looks like the same failure.
>=20
> OK ta.
>=20
> It would be good to get the Labgrid series into -next as it fixes
> quite a few problems on snow for me. It will provide a better base for
> solving other problems.

I want to pick some of it for sure. But it also broke my lab support
(before an office power cycle left it in an odd state and I need to go
and confirm what's needed / not needed again to bring the boards up).

--=20
Tom

--Qp0GlOjMxKawJmI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHSygACgkQFHw5/5Y0
tyxk2Av9HE9uh9EW7JIh9ZR571nK2xGUUZ466YehdFSPV/P/cTSkcnKO82EgrTaM
SzVw4xD5lG4kIoXXmS+0k5Q4w3FQ12+LNb08NVLIyaOTqfQXy3N3KK8OJ0eByxZo
01KpoPuZd78wZ/yNi2SyvCAsvjo9s5CmQfTC4cLaCUxTJ0FX1wpFdnTt5yCChnHj
mPjRT7DPBH7GNY5l497hMq7zlVdWJXtXQiXP9nnLpReSoMt94vcKvO4uAroHouPS
84m2JJHZTvkJpqzI1zWB3LFWuD9oOCWvZBcUG1lbeHT0mtNYI1O9Uoc5Ki4sKGLf
4FK4Xu5hv1GShBGjpZqNJXErsGouqurW4Bq8wBmkqu0s9EKXTL0jqkj8CvGcm3gh
XHHMppjtanmQdlXmJG3u5rwkyx3cB78lFl/SLiZFnhdiOEMZrO5PBOCnB0zCUckF
APrmJeqZAcfOz4CUG1+nOCI9hxkU76NXOFPfVl49rQ2H3ee2Z3++6wY6324BwQH6
oXeYvYEg
=LQji
-----END PGP SIGNATURE-----

--Qp0GlOjMxKawJmI6--
