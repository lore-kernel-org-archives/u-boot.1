Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE9EC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 13:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCBD88216;
	Wed, 26 Jun 2024 15:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JdXFb0cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55BA8826B; Wed, 26 Jun 2024 15:59:43 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4FC88149
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 15:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-700a6853664so2667217a34.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719410380; x=1720015180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dDMri1KOejxur6QjNc1lClg8YRlDFFyMBeUJOeAUbWQ=;
 b=JdXFb0cyt+xUqyE7HEj8X7crMJfuhitho8TG3JeMBgXhu1NY6T8tndDUNLCOR41PK5
 J5oZ5r9UVI5g/cY52aJ2t0Zf0hqfU5cBPze+hFSQKMu4sNFLy+FYtXXynEXPVFd7AQDy
 PqYY0iABh8vKOj0Sqp/WtZElxanFvF7d+VBk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719410380; x=1720015180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDMri1KOejxur6QjNc1lClg8YRlDFFyMBeUJOeAUbWQ=;
 b=qQzoKOHChnV21W+W2CQJoKZwGwOw2p6T+uBDkuaYkG7faAS0DBhKWZrMU6VswJv2uL
 4lnLZVNZOE/6MOG66KaKX+bhTHQaR+TMZ10rdyIYj7aPifOZlsKyZ5Qd/LKF0BsWG+MA
 nijqi/I/5NRG8jDTrXrDebvsb4Go5OLC3lMnYsi/niQzVbTQu5ruJYjBdoFZOqGndocA
 nGFdj9/C76tZyUtUuQTABWs1Fe0a+FqLFAo54xUuvLBVEPUnqmPM6vMu9BSDMPAnBmRB
 OldaTdQSzJHYs1kuzn4+iHCq5QaHtGnd2Ut3xN26VFJpldhptkMMo7KfezU+K7Ze1oKp
 N6pg==
X-Gm-Message-State: AOJu0YxALXQPQh3eKxVruW+6pkv24PoND+IXoIcQ7uQSpodN2ZG9B76H
 +d0BMiqksVJOEtxamCriuEsWsWJZb1wVW6/O7Nz4XFvdgB0kfge4HtJreUnIeVU=
X-Google-Smtp-Source: AGHT+IEnIBRZKr2LZV4v443hF5pkr6ULWlBHtG4/py6MbZ2rUrx7RwtSUwypwrBMTLzxANATfDlEvQ==
X-Received: by 2002:a9d:3e58:0:b0:700:ccfd:9350 with SMTP id
 46e09a7af769-700ccfd9811mr4373582a34.14.1719410380260; 
 Wed, 26 Jun 2024 06:59:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-700d1303c1csm178844a34.79.2024.06.26.06.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 06:59:39 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:59:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
Message-ID: <20240626135937.GU38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
 <20240625141432.GP38804@bill-the-cat>
 <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
 <20240626135624.GT38804@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QnjNtXg4qHhlXolJ"
Content-Disposition: inline
In-Reply-To: <20240626135624.GT38804@bill-the-cat>
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


--QnjNtXg4qHhlXolJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 07:56:24AM -0600, Tom Rini wrote:
> On Wed, Jun 26, 2024 at 09:00:42AM +0100, Simon Glass wrote:
> > Hi Tom,
> >=20
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
> >=20
> > This happens on snow, which is (maybe) the only real board that
> > defines CONFIG_UNIT_TEST
>=20
> I think it is too, but that's also perhaps a reminder that I should be
> enabling it as part of my build before testing scripts. I'll go do that
> now and see if this problem shows up a tiny bit more widely.

OK, not right now then, there's missing dependencies within the test.
I'll selectively enable once v2 is in tho.

--=20
Tom

--QnjNtXg4qHhlXolJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ8HskACgkQFHw5/5Y0
tywSawv+Kts097nxffwGh1fcmMVykJ5f9MwPlTRalaokxbnq1EV7JPkPd5zTyqOH
K6V4GW/Q0bje+HhjTuULsKMwYuf9vrVLc5auzZcg3JJMHzbF4Ewb0It0NHJUS8Yw
aUq+2AaEseTgKgHT5TPRKmLlBX+iW3yffy2huO3bSXqeo+bqcK/dNvHIcYEND0vK
qcWaBQ6EgAo+g6rpsBoTtvV/F0JE1NpmJ9vR858JsAoog3I1gBmjl8OEkhwcX85E
qGYdp7YVu0YOPIEtXIiGZOeYnzpUnVoA+aU4lcFmNLVvu/Ku04YWq+juJ7sPHgOm
4hCxKcz8aKhqlofI0t84HUZ09CqVnARAiBgp+FK0UtiQOIiGHSBWmc5S/GgFf9Be
4Z3uNUEhlXjNfDIFLXZZTJwoaIdh+kpQaW0r3IHIQIFyBoa8ghoOPNkTmkfRtJ2K
q0Bv+47Zff3qb5NzIo9BzvaDNqcL2gQDLlpK+46/8peXuEXFjymAChLIZEBGVfd3
qYUhBUor
=twLw
-----END PGP SIGNATURE-----

--QnjNtXg4qHhlXolJ--
