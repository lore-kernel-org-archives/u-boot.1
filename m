Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33613E74AC1
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CAD893E8;
	Tue,  3 Dec 2024 17:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Czm7H1jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5ADB8943D; Tue,  3 Dec 2024 17:01:38 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6717B893D6
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46694ca7de5so63862101cf.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733241695; x=1733846495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9BVNYyGcwbSJhB62ZzUmhE+cI1KDHs7UWLGdX++I/bU=;
 b=Czm7H1jdcXWJtHfjYm2dsbbvdieC8BhYPCMgXpbyL0ceiAPI+moy+ReBV1HvCwIJHt
 Vr9yQfgO007en1ANGdaqjb/C0xC4UyvcEeeKPkQT2P+miH0/brVsE+QpzncfQKI93dFV
 j4mEpbsQ9t6DIEdyQs01ABCqfzvSiSlbQw88w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241695; x=1733846495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BVNYyGcwbSJhB62ZzUmhE+cI1KDHs7UWLGdX++I/bU=;
 b=chYnMZOLjis8iILPW+yT0VYIQ32wgF9hXIOY5PqRXJfihUnX1Kh7TNRtyBgNwL5zNy
 CrWv/gVqEK8jcfcEgcUsQrNWBdphsvloMHPlcBWXjESxNizmdXLVV1J5MNfAWxbk3YKF
 O0rgMI/DLGFHBglqo1IP6ybU727sEx1DwtQJpe7Q5zF+6XPm45iTSntnd6aLpq6VX23v
 i6HVTPl99npRpLH0le4lIkluRMZDaVL8Lx85hqK9LGHBETBZNO0H0vcEdcBZN1iFWMRz
 MWCGJImrrEbje8rFN7dtgtNaK6P8f8UWdH3sijcNClsvQie6v5OjJ1u0BEyxqVeM2UiI
 eX2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvmr3aWZf9xC6WFxxWd9nzHijFqJXljPE6lZmgiMBgrA5oGsLYPRVE4UeO5FRasoHpki2yb/U=@lists.denx.de
X-Gm-Message-State: AOJu0YysE75fam4NH6eyay091HolKw0Tn59obT7VH6lhAzyS9NCk7kc7
 08jUOFmJ6GODcD/udV1hb0L3GM/hiHLctAGBrgooGsg1LlkiPB2273yTBLf+1RM=
X-Gm-Gg: ASbGncv2pGcQVYR0HHOwcFjUiXDI3pV86bxhc5rKbgrtD24rZTMFiJmAs4yLje4J7KY
 i2SkSSEXts97LUxWSLG0sRiXY3XoAEToBx6MOSQKDZgz9291QbuJpX3BkFN5k51UV7cG1AadFHn
 WPWTLdlnZyp2mj6PDg2tTqQ3u3WzazJ+QUDR+ebRA7vNSTr4CmAJUDq5tpZ8whFyT83LbFrWXpx
 GJZ759MCVmuCzzoGqIEAGl1Ei3vEcCT0tQaQ0oDozalhS4OYQ==
X-Google-Smtp-Source: AGHT+IGhCoBcADn5wWzSBLCwLw2mhZXpSgs53484+hvio4p9R52Pz2V97Xbtb8Q493Efszp474ysgQ==
X-Received: by 2002:ac8:5949:0:b0:466:9049:14cd with SMTP id
 d75a77b69052e-4670c3da314mr46581061cf.46.1733241695187; 
 Tue, 03 Dec 2024 08:01:35 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e2b5sm62498171cf.66.2024.12.03.08.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 08:01:34 -0800 (PST)
Date: Tue, 3 Dec 2024 10:01:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
Message-ID: <20241203160131.GW2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
 <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0acL++ZXh6FgYMKc"
Content-Disposition: inline
In-Reply-To: <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
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


--0acL++ZXh6FgYMKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 08:53:27AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 3 Dec 2024 at 07:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 06:46:27AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 2 Dec 2024 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 02, 2024 at 05:22:35PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > >
> > > > > > > > This stops coral, bob and kevin from booting.
> > > > > > > >
> > > > > > > > The correct way to do this was always to use a Kconfig opti=
on, so let's
> > > > > > > > first revert this broken idea.
> > > > > > > >
> > > > > > > > OF_BOARD and BLOBLIST should be general and hardware agnost=
ic,
> > > > > > > do you have more information on why they don't work for a few=
 boards?
> > > > > > > Maybe the way to handle these logic within certain boards sho=
uld be
> > > > > > > changed other than to revert this?
> > > > > >
> > > > > > Yes, I'd like to understand the whole problem better since we h=
ad a
> > > > > > forever-and-ever thread, compromised to what's in tree now and =
now you
> > > > > > want to revert the compromise and bring is back to what was arg=
ued
> > > > > > against for forever-and-ever, at least from a very quick read.
> > > > >
> > > > > I'm sorry but I believe I have explained the problem in that fore=
ver
> > > > > and-ever thread, so I don't really want to re-run it. It may be t=
hat I
> > > > > was right all along?
> > > >
> > > > Or maybe your use case is still badly explained, and your changes w=
ill
> > > > instead break other platforms.
> > > >
> > > > > Raymond, I cannot pass the DT in the bloblist from TPL to SPL on =
x86.
> > > > > There is not enough cache-as-RAM, for a start. Plus the DT is in =
the
> > > > > memory-mapped SPI flash, so it makes no sense...
> > > >
> > > > DT using x86 is a pretty odd case. I don't recall if you mentioned =
that
> > > > before, and it's likely everyone else assumed you were talking about
> > > > something more standard. Of course, you're listing one x86 platform=
 and
> > > > two ARM platforms as needing this change. Non-chromebook Rockchip i=
sn't
> > > > generally broken (or several other people would be complaining).
> > > >
> > > > So something that may or may not be explained in the longer older
> > > > threads is how the firmware in these platforms are doing anything w=
ith
> > > > the device tree?
> > > >
> > > > But, the biggest problem I see with this portion of the series is t=
hat
> > > > patch #4 is 'Revert "fdt: Allow the devicetree to come from a blobl=
ist"'
> > > > and patch #5 is "fdt: Allow the devicetree to come from a bloblist".
> > > > What you need to do instead is squash all 3 of these in to one comm=
it
> > > > and then write a new message that explains what exactly you are
> > > > changing, and why, instead of making someone else do that in order =
to
> > > > review  your changes here.
> > >
> > > As I said, I do not wish to go through all of that again. It is still
> > > a bad memory every though it was a year ago. I would like to build on
> > > what I have here, to resolve any future breakages.
> >
> > Sure, then you need to post something that's reviewable, like I
> > suggested.
>=20
> It is quite reviewable. It is just a revert. I am not expecting you or
> Linaro to agree with it, but I am confident it is correct.

It's _not_ at all reviewable. Again, you're reverting two commits, and
then introducing a new commit with the same title as the previous
revert. I'm not even sure there's a difference in the commit messages.

--=20
Tom

--0acL++ZXh6FgYMKc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPK1cACgkQFHw5/5Y0
tyynugv/R+PIivRht5g0UCZS69qDAGKDbd6U47W+2nvLYs1l/tNxF7L1BMAJRiK5
25jW51icFn8DmGJK/rEoeruNPuDOMrTu+tQPIRY58mEJRm60XZpI0ZDvIT3YMXtx
MMfi7RhUoAEgL25QLg3ELiCdi90NkSI18NKXmoepPpnJYjnjZ1fTQlKDKum2S2h4
TxFc7Wb0JOSJqqgnQqifBJQg6ie9FHSCvIHchsUxyVahNyhVDj8N2O2zlEFmSJtk
98QttILE3s0VkYSwu665pnU5VEJjT2wKId+jHgGfbsXTGFFhZpdBLCTlrpbgLRcs
azeZ5k+l2vOlR7cXSKcneM/sY1cOq5NBquPkNc37TQcoY0uYdDsypiFYU+UgaCB+
ccv9C4nduZeB7+hzRA+YnjjrFiah36cZf8ytafKNl83maMtblU9GLrWUS2XF/u7Y
TZNci6CQDUn2mRsAp1XMZT2ub3xQgsKrwxLfvEIrGLXb5DsTz2XqRQz3PU+Rl/ux
NbKeMfYP
=iWHd
-----END PGP SIGNATURE-----

--0acL++ZXh6FgYMKc--
