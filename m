Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAAAD2C559
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6581A88EBA;
	Tue, 22 Oct 2024 16:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RC9limjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA2488F31; Tue, 22 Oct 2024 16:02:35 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA17588E89
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbceb48613so36185606d6.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729605751; x=1730210551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RepZhq2FV4DzUSPp1Qp8o8CEtF02LkrJzGMKN/blpxs=;
 b=RC9limjgceFh9Bin5wha5tSxgkoIP2mfHpGOmb2CkmhtydFj4+RPApYcAG797vlBsY
 4Afsj2J1VNZpejdFkunUGNYka7+Rrbh4htO5d88iz0XbSfdV8b8fxi0kcsR6klI3GhLC
 TBYxxd2AvVuA+Y1hO9tEbf1NCiH3gPsyOaV7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605751; x=1730210551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RepZhq2FV4DzUSPp1Qp8o8CEtF02LkrJzGMKN/blpxs=;
 b=f6xj/18FVmK+TDoWKOukVSNCtgoDfuGcZsdwVPP9HU6aZNsfKsQMiEjM3X7mVvrUy8
 UY4GuDnwlXOLIo45n4/E5ASyEUK1UlalSBatzcgLpUr6XbbEowFcE0blGSK++IrhjBac
 UT+OCH7PreswK4odfI+SEeZky5YmNNmRtJRFQue/J9/C76djbp6VyrNJhGqtkxRp5/R1
 EqQAyHNtEgse3sd63MSSc945s73i7oLphINVTovOjvmxpQDNLelEdk1osEzBfgpaOgiF
 qWNE+BNKz1/oMeq3zBf2b8N8610Fk7BQTQ7ndahalKSs1MHABcMHe9Ih58NBldqNEL+p
 ZfDg==
X-Gm-Message-State: AOJu0YyXilvg844sZPYZWAswp1TxbqrwonxyOoDS0LjbFY9WvgbCi+e3
 8B5FVgUPEhlY3JFKPP/mSoyhi8a/p8SZZe4+hgOuIk4yHSR2Kq/ahmBLBK5G7q8=
X-Google-Smtp-Source: AGHT+IFnr1F2TFrW+ZpsT6X2R7u/IhaM43tgoIC0JQ2p6tW9Q9A92XLSnB6hDbnnOuhMpqmG6KkNCA==
X-Received: by 2002:a05:6214:3bc1:b0:6cc:6ab:aae3 with SMTP id
 6a1803df08f44-6ce2059e77emr45813416d6.46.1729605751437; 
 Tue, 22 Oct 2024 07:02:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0090c360sm29090336d6.57.2024.10.22.07.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:02:30 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:02:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] CI: Add a test for building without CMDLINE
Message-ID: <20241022140223.GZ4959@bill-the-cat>
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
 <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
 <20241021164958.GK4959@bill-the-cat>
 <CAFLszThz2DGSQ+gBiJi0jaSmsghVau0UTUyuZppjSyuy9pRkuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E049TJdqrBVDw4sg"
Content-Disposition: inline
In-Reply-To: <CAFLszThz2DGSQ+gBiJi0jaSmsghVau0UTUyuZppjSyuy9pRkuA@mail.gmail.com>
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


--E049TJdqrBVDw4sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:16:16PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 21 Oct 2024 at 18:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 06:32:18PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
> > > >
> > > > > Something this breaks, so add a test to keep it working. Since sa=
ndbox
> > > > > enables a lot of options, it is a good board to use.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  .azure-pipelines.yml |  8 ++++++++
> > > > >  .gitlab-ci.yml       | 11 +++++++++++
> > > > >  2 files changed, 19 insertions(+)
> > > >
> > > > I don't like this because "sandbox" is one of the longest run-time
> > > > build options due to all of the tests it runs. And given how we bre=
ak
> > > > down the jobs this will make a further bottleneck. Can we just disa=
ble
> > > > CMDLINE in one of the existing sandbox defconfigs instead please?
> > > > Perhaps sandbox_spl since that only does SPL related pytests?
> > >
> > > Actually we do boot into U-Boot proper as some tests need to check
> > > that SPL did the right thing.
> > >
> > > Note that this patch doesn't run any tests at all. It just tries to
> > > build sandbox without CMDLINE
> >
> > Is there no existing thing we can put this in? And have we had another
> > problem with CMDLINE=3Dn ? It's not cheap (wall clock) to add another
> > stage, especially in Azure, I'd really rather figure some way to bundle
> > this in with what we already do. Heck, following on with
> > qemu_arm64_lwip_defconfig I'd rather just add
> > sandbox_no_cmdline_defconfig and use #include so that it's just a few
> > lines of defconfig anyhow, but merged in with existing builds.
>=20
> No, I have not seen any problems with CMDLINE as it is, but there are
> some BOOTSTD cases which I would like to check, since disabling the
> command-line and using programmatic boot is something I'd like to
> eventually test. So this is just a starting point. In the end perhaps
> we have a new sandbox variant, or can take over the SPL one...but I'm
> not sure yet.
>=20
> If Azure is a problem, we could perhaps just do it in gitlab, where we
> have more runners. A build variant isn't the sort of problem that
> would be different between gitlab and Azure.
>=20
> The run is at [1] and it only took 1m19s - I suppose you saw that it
> is in the 'world build' section and no tests are run.
>=20
> Regards,
> Simon
>=20
> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/924269

No, I don't want Azure and GitLab to diverge since Azure is where
everywhere who isn't a custodian with git access can run CI and I keep
encouraging more people to use it. And also note that the actual build
took 8 seconds which is another reason it would be good to just drop it
in to an existing job.

--=20
Tom

--E049TJdqrBVDw4sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXsG8ACgkQFHw5/5Y0
tyx/GgwAo9n1DbQQsKLavdMGiX7VVXbXNOu+rGRHwvdIldWCw35LXQf6nH22nmCF
G+lVPxfZQqZrhw3I7LSgWShmVk2fsz6+ImQhoJ1uIBE8tvuB/teYQZBw4E9vWkLt
7970ExOXrRUA1YIGePithPVcTZnCJNeiN7+WRSeW7RNt5rojgb96+xDXSguTO3Wr
xHmJTRomiDcUchR3iRIKtlzqAEvYDtvjZR0uW5t2frk/WNWrDX9C8TFw2EGX/K0p
wlAYFmGIiImUIRE5nb3bNDpOiL6s60Bh+M3lavYclrczbdhebhQULS5pO/Yb9bwQ
BdBhILUqjopzne9MATY9iavkhffGCTv6jJNTRetGNup2DYyjAbobTKJ3B27yIvJz
XTQ+HYhlionI2TWBmulw9XChVUkS3IO1nuwgGjfKjPbAAovXTjI3Fi7GWmgGGas4
7f6yo2bU0UP9lTAMjOBI/2kyDcr4XHlQ3qYaQH6f0PLFeAa7aYJRttn7RGHpZcPR
NxDUYeiN
=Ejfl
-----END PGP SIGNATURE-----

--E049TJdqrBVDw4sg--
