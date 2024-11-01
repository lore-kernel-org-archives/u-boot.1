Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFD7E6F06E
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 16:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4C488E42;
	Fri,  1 Nov 2024 17:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W82AEwa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C92F88E3C; Fri,  1 Nov 2024 17:47:29 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3C588E94
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 17:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so12089156d6.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730479646; x=1731084446; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yp55J/kfMESPHnOheLA/G4fWWXegGUu2xLSYvAR69Vg=;
 b=W82AEwa1X1efGlE/8gSncRDcLuA9OzrOP6Jx34z071zbP3OazCR+Cpsx2faqV+KJ94
 7d6DQsi/7lDdw79xusUmr/px9xvY3qtKrUuC/eyMjMoQ+IMF5TqEujFs/Y0sQD75KRqe
 BMFwiXMD+p4TtptlYhtQfK5uwGyFZF1J8P6nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730479646; x=1731084446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp55J/kfMESPHnOheLA/G4fWWXegGUu2xLSYvAR69Vg=;
 b=A38qpRdlERVdGj73osZVjcxc4vUs2JdCxlW6AqVx3UhLlxBZvqIZ1P7K1Vqx6yGPdX
 kPqDTnWx6k6OudAEWqsKp6Wo4KGFbZmn076PAZmuhkVHpaK0n7r+byVvHDmCUK6+rZYx
 YKXzt03wKHTH9tnNuUK5GyhOT0U9IONz+xZ0TmJwaK1Nl4ObYS/5IdU2PXTdMATD168p
 LcA8BH9YbY9z3EZegG5Yh2gEj5tr1teSrJyigHnxZq0VkutPEoPY0ZIfLH0EdzuFy5ut
 RPU5WisLtz+k+3svD0yoZMbo+MMvkxHICKlKSHcXExgxt2ht+9gNHNT3FUmZQZrbKBaQ
 LubA==
X-Gm-Message-State: AOJu0YwjBGwxgl63gP5mZqYLAHCeQswTGbeWFk3zYADmoCE8G5W6YS60
 y8tzUcqFz62rbtwxv//LLECUzo8wCvROrZIX/FpDxC4GLBeeJ38wS8ZJYzYriNByq/dyXeqQH+5
 ed1Y=
X-Google-Smtp-Source: AGHT+IE94XO7z7p8398aqhdGgmgWY+ZM/Qv3b8Bi3HtKxVkaDLCziz7UyIaUdgE04/7dTrrFFTHj1Q==
X-Received: by 2002:a05:6214:4189:b0:6cb:e9eb:1b24 with SMTP id
 6a1803df08f44-6d1856fb72dmr302362256d6.24.1730479645682; 
 Fri, 01 Nov 2024 09:47:25 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a709fbsm184113385a.75.2024.11.01.09.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:47:25 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:47:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
Message-ID: <20241101164721.GQ3600562@bill-the-cat>
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
 <20241028193310.GS4959@bill-the-cat>
 <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
 <20241029163642.GA4959@bill-the-cat>
 <CAFLszTiXXXNFUeGoe+0ivyWgh-9MDYdCETFoWDcskYwHd-c9bA@mail.gmail.com>
 <20241031181049.GV2558755@bill-the-cat>
 <CAFLszTit0yePZLL-_iNjKOBFhCgKN2Wd=fXxB6OeV4j7Cnb9LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FXWulwoMr1HJWdjr"
Content-Disposition: inline
In-Reply-To: <CAFLszTit0yePZLL-_iNjKOBFhCgKN2Wd=fXxB6OeV4j7Cnb9LA@mail.gmail.com>
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


--FXWulwoMr1HJWdjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 04:32:56PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 31 Oct 2024 at 19:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 07:00:41PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 29 Oct 2024 at 17:36, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 04:45:40PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 28 Oct 2024 at 20:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:
> > > > > >
> > > > > > > There is no particular need for bloblist to have its own test=
 suite.
> > > > > > > Move it into the common suite instead.
> > > > > > >
> > > > > > > Add the missing help for 'common' and update the docs.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > This feels both like churn and weird. I would think "common" te=
sts are
> > > > > > for things that are kinda legacy and too catch-all to have thei=
r own
> > > > > > subgroup.
> > > > >
> > > > > It's just chosen so that the test for common/ is in test/common -=
 i.e.
> > > > > it makes it easier for people to find it.
> > > >
> > > > Then I really don't understand renaming bloblist from something
> > > > descriptive to common which is not.
> > >
> > > Old: test/bloblist.c
> > > New: test/common/bloblist.c
> > >
> > > It is only the directory that is changing.
> >
> > Then some of the commit messages need to be reworked? It looks like it
> > stops being "ut bloblist" and part of "ut common" and that's my concern.
>=20
> Oh I see...
>=20
> I basically decided that there is no point in having a special suite
> for bloblist, and some other things. A better way to handle this would
> be to allow running tests which match a name, e.g. 'ut common
> bloblist', because we are adding way too many suites IMO.

OK. It's not a big deal, yeah. I think the common use cases are "run
everything" and "run this one test that failed while I debug it".

--=20
Tom

--FXWulwoMr1HJWdjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmclBhIACgkQFHw5/5Y0
tyx7VQv/ZenC5EHfFMW+o7laQmxtMQQhmvstpDJJqAS1qrOoR1GhHFi7yNJQFTWS
VAI8u/+tvRFtqkKaeBo4WbwFPml8yVYqJhVjZo3dkaYAUdD1hooCQ3C8ytXNNa0W
Vv1RiagETID1RW7FK9fEQqLMAVlFkQA9jaKhCqFT3u+r9H20nWdPuQgBEVffdc3s
bKbqTpZQ0ocISgZMdPBfSF1zUKvtWSOa6xc6BdxiqwBraJpsklVZuyY8boz9oGVp
LGCyna+TvTtE1r/l0UK52eJ/G1Od6FDnkUU7eehV220O+gPsoe2y/D+RtMRtUfNb
rmAkxmd0NBM6bSfG9Q1Kkt7q9fsJl1yO6BM1BVCFGUef4ZBaF1ZSsdIz/ONGbTLT
b/RdqXlXLRmyf7gZ7NOskZBH3EK0z1P2Conm+BStdVzqI6UZX9QgJoVwvXXgjZSZ
WQfaDPPj4tsxJqeLx2EqNcxOXOUecVYNeQ01wSs9NShWfegHFCgXipI6HFhK8PIe
2Igt7xtE
=sYmA
-----END PGP SIGNATURE-----

--FXWulwoMr1HJWdjr--
