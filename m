Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7761CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542C7839DD;
	Wed,  8 Oct 2025 16:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AE9PUgRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B5283DB3; Wed,  8 Oct 2025 16:11:17 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A36839B7
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-394587df7c4so3624715fac.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759932673; x=1760537473; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/U/pUIXlqn14N+0/J8ZO453z8p58kLB6v9XBbo4ikNk=;
 b=AE9PUgRRQmR4AIm1EXZcjFQS+pgPAEw1ZE6IWl5AcYcTtEzOGtkLO07NZDtFkLqqni
 ge0gkMMfE7+xm6VA6V2mFmcFTnGylzjUuvoTC8X+RK6DXlQomOUMNjEwn04SHT5xLU0b
 5Iy+kAH9sOYRPpXubhriY1mXsOg8fTJnvP7NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932673; x=1760537473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U/pUIXlqn14N+0/J8ZO453z8p58kLB6v9XBbo4ikNk=;
 b=MVEVK8d5gb1bz9b5nVkXDnZ1pzIyAA60gZVRdfUXc6Q1rdYc2YipzXfWLpX9YbocNS
 Few/qqiO1+Hd7bbuzhOfHCQMA1a4H680ExdWZT/d/XhiQRwLMDieVjeEJAXe2S8un8Td
 X7uccWrz7SoKZWE6Tf71XFg9obYG5ZWIUFdgSoIK4POmZarqbBaDi5p7yL634ksYsAOW
 nWcBYV8dieFe1QFv3aeKZ39OCRbmj/1YsroRAkI8lnoGq4j6VNl4Hor1PrwwHkRlhiR4
 X+0JX/l41RqFbpYMJSe0t00+gRU6QZL/8nmj+wNBIrDaUWzISUBptxJzVKY5UeyZ/Nzf
 1zMw==
X-Gm-Message-State: AOJu0YxUBArDPlckHDoVRr8NPqV4djFJnypcPH0Kj4D/cIp0Qm+8VlSE
 gYCrgqO+a20QKSfxIT/f9ykw59n9Qml53f4JTZnui8kDaBk5p1yKk3D4W5ukAIDznWo=
X-Gm-Gg: ASbGnctOK2Gm8QjAxk8anxL1F/vWdQCJ/CaVEcqH/bPEZCDdCeHLIO2WuTNiB263F0G
 jyx2CVbNV+I31NnNqTnF2lDoI3BZ5uGZWJl6KKtbZi2VMfSz7ore6xP2tRrM20qfBFhkmVu6YlY
 5UuFH1caxq/bV7EuxJAjm9GVjk1D4okW1VJYr7Sj01nFbPjLEgKgWtdKCnSck9uaKvCiLs6xndm
 l200D06H1WfVd+TUFhuKZXlNB4brK2OztRUA8CEhKv0LT5O4YDL870D15sxWyS2UczlzND0g1jB
 tmi6E2bv1dEOF6K0ZN+hK+gp40C5JpR/+UScyAG0eIR7ZKfDs1U92FQguCbCl/zFqL4eTQ2sGx4
 QdGjoMlp1L7soI/FoOw/xK5LhKWtuy4YD9p6gsylHAX8zljA1cn6p6d1hnNU9Opg5niognGTMO6
 wFpVJ03C6Ybg==
X-Google-Smtp-Source: AGHT+IHCgembd4+RC8og4VQjbHw8ccY5xCXDb21A8YR12RHNajn8PnEQzDoE2ZNT3IhqsDITFmS0Rw==
X-Received: by 2002:a05:6870:d695:b0:396:3593:d1b2 with SMTP id
 586e51a60fabf-3c0f62f50c2mr1935493fac.15.1759932673212; 
 Wed, 08 Oct 2025 07:11:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab930c8e7esm6113214fac.24.2025.10.08.07.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:11:12 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:11:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
Message-ID: <20251008141110.GT298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
 <20251006234500.GG298503@bill-the-cat>
 <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
 <20251007135009.GI298503@bill-the-cat>
 <CAFLszTjimWcKE8n991-ik-7fyhsesHsm5hrQwx7-FKSqgd48QQ@mail.gmail.com>
 <20251007153904.GK298503@bill-the-cat>
 <CAFLszThRcVQZN=rcrPga6a4JuJnL8Q6Ra9qHmXhWKCsokt2Qcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/62bna/KDXkPr75z"
Content-Disposition: inline
In-Reply-To: <CAFLszThRcVQZN=rcrPga6a4JuJnL8Q6Ra9qHmXhWKCsokt2Qcw@mail.gmail.com>
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


--/62bna/KDXkPr75z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 06:50:41AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Oct 2025 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 09:14:29AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 7 Oct 2025 at 07:50, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 05:13:55AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 6 Oct 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > It is helpful in tests to be able to show the bootflow th=
at is being
> > > > > > > > > examined. Move show_bootflow() into boot/ and rename it.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Add a log_err() for an invalid state
> > > > > > > > >
> > > > > > > > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++=
++++++
> > > > > > > > >  cmd/bootflow.c     | 68 ++------------------------------=
--------------
> > > > > > > > >  include/bootflow.h |  9 ++++++
> > > > > > > > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > > > > > > > [snip]
> > > > > > > > > +     case BOOTFLOWST_COUNT:
> > > > > > > > > +             log_err("Unexpected boot value of bootflow =
error %d",
> > > > > > > > > +                      bflow->state);
> > > > > > > >
> > > > > > > > A small thing, checkpatch.pl catches that this isn't aligne=
d with the '('
> > > > > > > > here as it should be.
> > > > > > >
> > > > > > > OK. I'm unsure whether I really want this line anyway, since =
it
> > > > > > > increases code size.
> > > > > > >
> > > > > > > >
> > > > > > > > A larger thing, and please correct me if I'm wrong, but on =
reading the
> > > > > > > > whole set of changes, this move + rename just means we're p=
utting more
> > > > > > > > info in the test output, and nothing else?
> > > > > > >
> > > > > > > It will also appear if you have CONFIG BOOTSTD_FULL and use '=
bootflow
> > > > > > > list' or 'bootflow scan -l'.
> > > > > >
> > > > > > But that should be the case before this patch as well, yes?
> > > > >
> > > > > Yes, that's right. This is just moving the code into a place wher=
e it
> > > > > can be used from tests.
> > > >
> > > > But it's not being used from tests, with this series.
> > >
> > > Please see this one: 'boot: Add a new test for global bootmeths'
> >
> > Yes, it calls the function, but doesn't seem to do anything with that,
> > especially considering what the test does before these patches.
>=20
> Well, it prints out the information so you can see it when running the
> test. Other tests show what is going on so it seemed sensible to do
> the same here.

The flipside is that since all of the test is working testing the values
of the struct it's easy to debug any failure as we'll be told field X
expected value X but found Y.

> I'm happy to remove this patch if you like.

Yes, please drop this patch, thanks.

--=20
Tom

--/62bna/KDXkPr75z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZw/gAKCRAr4qD1Cr/k
CvUXAQC0zly7vS8VIcRc+ZSNu27g4MMYgK5r0fXFvYadQMdXzwD/WfDsseYxK7P9
J/kGPI9YawJudv3a3fL2FwtRA+Buww4=
=n7SV
-----END PGP SIGNATURE-----

--/62bna/KDXkPr75z--
