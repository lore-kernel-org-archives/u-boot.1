Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5592C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336AA886E7;
	Thu, 22 Aug 2024 16:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BD4PM4O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B217887D4; Thu, 22 Aug 2024 16:11:52 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317B188651
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 16:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70930972e19so362794a34.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724335909; x=1724940709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U0hbi3aURbyqzfXw+tMi6PZMSzYCIUpn6dDJBfKTxUc=;
 b=BD4PM4O5AQFzhc1sVBWp+xBB7YPE1NjQkETlyB8It9FPDo2bgastGLaUHiZ58XqOpv
 BqNL9mBZqvlZzjfUprGx3inZpFxULd/BVWa1Hhr4u6q6ihn8F2ysPLcD2EgwYI2O3365
 Av4aG4CMyf2I8eX2XQN8RRoEWtJdk1ZieONm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335909; x=1724940709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0hbi3aURbyqzfXw+tMi6PZMSzYCIUpn6dDJBfKTxUc=;
 b=W92hnndc/CvbdWt8kmLBBW3RJCNbR/bDEEmy39IsZONdyyw15BShtFVptN3ocYBsy4
 2IGKEvWkl3/KNTgLZUXiCrBbmLXaTwALCrlKefu/kxmoXOgYELLP84Wk0S5ctpm9At2F
 oon9gpEFNh8HHmFAVgu4PG0wZ/PTHewdPS/hbE7dUkgSMSQaO9sEQ9wYEqvE647knkLL
 1LW13ESXHrb1GgkG3skwL7QhW5uvBxZyapt+awMauQtH3rCRQ1p8c3gz1ecZhvksEEsJ
 NdWnPB8e3ocbfxKx69wRhk9mZdJksFYF/1z5KF6DdesFUX24omO7sTcNWZAVf7kbr/Ax
 7kjQ==
X-Gm-Message-State: AOJu0YzPDc30VkYHosDjg4d3UgwAfnFzz9hNxGN36j4pB/Lajuby1efp
 sCYaqpvr0LoARYfDQjGIZXY7i0lYK//KPCOkdZecMskgoe+PFwldRuknby1NG7Q=
X-Google-Smtp-Source: AGHT+IETG29YPRHcFC/+Gwq3kCvs6dqvAz+KRsu/ttrZ1n/NaV4ys/RdDpU4QR6GGuKW5UmQwH5TLw==
X-Received: by 2002:a05:6808:201c:b0:3d5:1eba:10b5 with SMTP id
 5614622812f47-3de194f49a6mr7636032b6e.12.1724335908416; 
 Thu, 22 Aug 2024 07:11:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de22461a02sm297413b6e.0.2024.08.22.07.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 07:11:48 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:11:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
Message-ID: <20240822141146.GR1626301@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
 <20240625141432.GP38804@bill-the-cat>
 <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
 <CAFLszTgP71y2Z6Or5CLA+gzk=EfiwnfXFvdkeBqGKidLFGd6bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ORGD8sNHEp/SkYjg"
Content-Disposition: inline
In-Reply-To: <CAFLszTgP71y2Z6Or5CLA+gzk=EfiwnfXFvdkeBqGKidLFGd6bQ@mail.gmail.com>
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


--ORGD8sNHEp/SkYjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 09:00:33PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 26 Jun 2024 at 02:00, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 01:38:00PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
> > > > >
> > > > > > When a test returns -EAGAIN this should not be considered a fai=
lure.
> > > > > > Fix what seems to be a problem case, where the pytests see a fa=
ilure
> > > > > > when a test has merely been skipped.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  test/test-main.c | 16 +++++++++++-----
> > > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/test/test-main.c b/test/test-main.c
> > > > > > index 3fa6f6e32ec..cda1a186390 100644
> > > > > > --- a/test/test-main.c
> > > > > > +++ b/test/test-main.c
> > > > > > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_sta=
te *uts, struct unit_test *test,
> > > > > >  static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > > >                                struct unit_test *test)
> > > > > >  {
> > > > > > -     int runs;
> > > > > > +     int runs, ret;
> > > > > >
> > > > > >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CON=
FIG_SANDBOX))
> > > > > >               return skip_test(uts);
> > > > > > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct un=
it_test_state *uts,
> > > > > >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> > > > > >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> > > > > >                       uts->of_live =3D true;
> > > > > > -                     ut_assertok(ut_run_test(uts, test, test->=
name));
> > > > > > -                     runs++;
> > > > > > +                     ret =3D ut_run_test(uts, test, test->name=
);
> > > > > > +                     if (ret !=3D -EAGAIN) {
> > > > > > +                             ut_assertok(ret);
> > > > > > +                             runs++;
> > > > > > +                     }
> > > > > >               }
> > > > > >       }
> > > > > >
> > > > > > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct un=
it_test_state *uts,
> > > > > >           (!runs || ut_test_run_on_flattree(test)) &&
> > > > > >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> > > > > >               uts->of_live =3D false;
> > > > > > -             ut_assertok(ut_run_test(uts, test, test->name));
> > > > > > -             runs++;
> > > > > > +             ret =3D ut_run_test(uts, test, test->name);
> > > > > > +             if (ret !=3D -EAGAIN) {
> > > > > > +                     ut_assertok(ret);
> > > > > > +                     runs++;
> > > > > > +             }
> > > > > >       }
> > > > > >
> > > > > >       return 0;
> > > > >
> > > > > How did you trigger this case exactly?
> > > >
> > > > I noticed this in CI, where some skipped tests were shown as failed=
 in
> > > > the log, even though they were not counted as failures in the final
> > > > results.
> > >
> > > That's really really strange, do you have an example log or something
> > > around still?
> >
> > This happens on snow, which is (maybe) the only real board that
> > defines CONFIG_UNIT_TEST
> >
> > test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
> > Test: bdinfo_test_eth: bdinfo.c
> > Skipping: Console recording disabled
> > test/test-main.c:486, ut_run_test_live_flat(): 0 =3D=3D ut_run_test(uts,
> > test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
> > Test bdinfo_test_eth failed 1 times
> > Skipped: 1, Failures: 1
> > snow # F+u-boot-test-reset snow snow
> >
> > For this particular mechanism (-EAGAIN returned by test_pre_run()) , I
> > think a better fix would be to squash the error in ut_run_test(), as
> > is done when -EAGAIN is returned in the body of the test. I'll update
> > that. I cannot see any other way this could happen, but we can always
> > deal with it later if it does.
>=20
> No, that doesn't work, since the failure counting happens in the
> caller. This patch seems to be the right fix, so I'll send it again
> with a better commit message.

And I'll try and test it on Pi as with the series I posted and so
UNIT_TEST compiles on there, I got what looks like the same failure.

--=20
Tom

--ORGD8sNHEp/SkYjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHRyIACgkQFHw5/5Y0
tyyQ1Av6Ah44jp+OaHuISqu7iFFKGWJIiGhlxvIIkXlX22d4SHeTHslBNPYgRRlN
24WFi9Po4aUbzjkvpP4gp601B2zti0bsTzm6xzwazdiCCufB22gEuCV3T7fFRyz+
ZYfI6GVznaIyf+ohP5FspgXQuOAXfTwiAPR4XV7Mz3p9ZIwC6GWP47YtzYOgs0dF
HKbhh/WlNTGFg/QVtVpFNM5OJRjZDRe9vsNmsYlBMPRB3/mqtSYhrholZ7VE/nsg
1I5F99BBicnWTxV1pXv9UE7ImZaDi6nTHMf0W29Ol5vxnS9pk0gXTLNNF12j1iG7
CNtUAcRFdEvA3+ZHJwjkWdJ0m9KTkOiEaecQenwz+o1pNQTb9wXAxvPyreUaiNpK
67TEekDVFXFHiHfXzG9W+GBdzIgPho/4GPdHZKIaiAmLTFnjY66Qd1yvloaACXSq
JVV0rjAgNhexgQctHuGNPfVQgm/WsMwA4T1U9/muLGL1IckN/mLmC4ZwlnYICNZc
IQ4Yyifv
=V5kJ
-----END PGP SIGNATURE-----

--ORGD8sNHEp/SkYjg--
