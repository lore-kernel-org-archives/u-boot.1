Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D92CD0E6C5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA4388901;
	Mon, 21 Oct 2024 19:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6Dsw+Uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC5588C63; Mon, 21 Oct 2024 19:33:01 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49517881C1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b1511697a5so311414485a.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729531978; x=1730136778; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/nvczVQ0n0coHWm4MgqY5X145zv3L45tpomknCzTGMg=;
 b=W6Dsw+Uh+PY3ZvnqvTeTCTzqJkRLM8W/LS/zY/CvmP6f1JooaF9vLFIu/J3zGIjOoL
 rI/thRqxkN3hncbyE/W1TYXK6TT9Xl5k25AdYwSbxgUkSObR6BuPQSXDb1Wo0sr6HEoy
 TzURmQpc28l2mIQC5wyTbSkqEVcRFQxJumdCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531978; x=1730136778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nvczVQ0n0coHWm4MgqY5X145zv3L45tpomknCzTGMg=;
 b=R+dze8X5zkqF79U0NVih7F8wZFQ6YdyPimxtXztn9TtGQQ0U/sBdu8WNejrpmwzi6i
 rxwwWyTM3UJvUb2eS30xsh8D3eVChNgbOKxEBsEUrU09EP/FpPIxm0HfxIP67pxNRU1+
 EF+Vf047SeIBrTotQjKv7dx7JgQf0iUCoVxdJME+7bFSyXsFYw60X43gFNg6Q/Q+EYvi
 XyVdX4LFvOCyI8It2R4yDn6iDT7ApK+yPnoyuB0oyP1pu/7g0XV0PhNc/CljXnzJCxxl
 OVeTYb5hmE6RID1fsOSsAcXZcH7V9TnZqq9uMsZJBT4LztWZiUEAE7rt70JnwElEEq10
 KUZg==
X-Gm-Message-State: AOJu0Yxb/iSwygRS2Rt+bekBuVQvq4/XSXRnhSfn9pfYsYnXww6lnNtO
 QZEnzJCvPNEKlM5Ypdz84mxOJWDX0C2zXbZ+7h4qgUVY78NvPuMRdpr+fAuIFQw=
X-Google-Smtp-Source: AGHT+IHs3Pp2UkwR6TN11XRCN9UbNRxReNXD9JIkTugMhqhNkoqbzRUHwj6EWOmi7MJp72Om+FfOLg==
X-Received: by 2002:a05:620a:2681:b0:7b1:14ee:2967 with SMTP id
 af79cd13be357-7b157be0cf3mr1593607585a.46.1729531978023; 
 Mon, 21 Oct 2024 10:32:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a77f35sm191543485a.120.2024.10.21.10.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 10:32:57 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:32:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH v7 6/7] test: efi: boot: Set up an image suitable for EFI
 testing
Message-ID: <20241021173253.GO4959@bill-the-cat>
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WQFNM0icDN7I4Zvu"
Content-Disposition: inline
In-Reply-To: <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
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


--WQFNM0icDN7I4Zvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> >
> > > Create a new disk for use with tests, which contains the new 'testapp'
> > > EFI app specifically intended for testing the EFI loader.
> > >
> > > Attach it to the USB device, since most testing is currently done with
> > > mmc.
> > >
> > > Initially this image will be used to test the EFI bootmeth.
> > >
> > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > >
> > > For now this uses sudo and a compressed fallback file, like all the
> > > other bootstd tests. Once this series is in, the patch which moves
> > > this to use user-space tools will be cleaned up and re-submitted.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > ---
> > > Here is the patch to avoid sudo and CI fallback:
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > 20240802093322.15240-1-richard@nod.at/
> > >
> > > (no changes since v1)
> > >
> > >  arch/sandbox/dts/test.dts           |   2 +-
> > >  test/boot/bootdev.c                 |  18 +++++++++-
> > >  test/boot/bootflow.c                |   2 +-
> > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> >
> > This I think best illustrates the problem with "BOOTSBOX.EFI". This
> > image will work for CI up until I can figure out how to get access to
> > free arm64 servers to run some tests on and then it will fail.
>=20
> I don't believe so. Why do you think that?

Because it includes the BOOTSBOX.EFI x86 binary file, and executes it?
Or did I miss where we update the contents to include that file as we
just built it (and so why have it included?) ?

> BTW it would be good to get CI running on arm. I believe Linaro might
> have some servers. I keep thinking of getting an Ampere device but so
> far have resisted as it is UEFI with closed firmware...

The problem is more, for GitLab, getting anyone to maintain and provide
a runner and then for Azure, waiting for Microsoft to include some in
the free tier. I think for the former, at one point I was thinking about
using one of Oracle's always-free tier ones and for a small enough
subset of things (like a host tools and a sandbox run) it might be fine.

--=20
Tom

--WQFNM0icDN7I4Zvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWkEUACgkQFHw5/5Y0
tyxJ/wwAuNOxoEH1n+LPQfnjQ1mXzGQrHdpr1AXjRWJG3IAuMa88fvVucu3f+Yst
b3cu7AedGQ33HjdNB4vgzwXF2N3BEimZa1Fsep/6hg40/wG3d+WqMek05B3quLsX
AahvcWkQihr0EU8O0FRBE9cjB2xbOaSEn1VNhIGbgptkvFjO0c7OiXw7q7w64GHe
G/lfFnod1p1jx75tswim/uuH7C69kAr7qYvHsetxc5Ibsns9zYDtg3bobIapzseL
QOztTeSIifDhyklH3ixaSalb+MS8BwOoJlf1miy0tgkvfBZAggU6mltVhmMauiWm
TDV3Bm7K5t6TeucpBYnbFZwNWvhaZvZTYSGCtKupHIgAaaXTWOjeOhD2QeeVliFq
Pgo954OKDzsQ1a8NY3c7IJuZtYeJW6zwpdiNbLmDBX8bwFjKSNDYU9M7hdZHgy39
YV0zLOjs36drGoQ3+370zmwoozbzY3oqQUGOSC2CYILXaMNwSxGxz1EMVuOlzdEd
1p8CXz9t
=Id6S
-----END PGP SIGNATURE-----

--WQFNM0icDN7I4Zvu--
