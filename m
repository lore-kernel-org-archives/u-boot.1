Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB99FC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F19CA80756;
	Sat, 15 Feb 2025 19:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1ok0ypL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F7480C77; Sat, 15 Feb 2025 19:28:12 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A2880077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso3695243a91.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739644089; x=1740248889; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4ern8SXXkNUD85wnFHGx93v4/yvrMjm/Pk+YbGeWlKk=;
 b=F1ok0ypLpS8hga0qHfajreT03ejqLTz/6po55CeZG3JD59H3tr3x8Qx73+Aqpx4a3u
 7osPhKD+ey04URSlkH90zMOzBusf7WYHhb1lP3oIGDV9lOiW6dXIo70iEETk+LDbVE9Q
 dCnXh+JLu6WTSlJv57EAFNIYKL3mCTnd+T6+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739644089; x=1740248889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ern8SXXkNUD85wnFHGx93v4/yvrMjm/Pk+YbGeWlKk=;
 b=UCdb5cdUTNaUV2tDaP0pAFhqrxpzoNzqo1uLI2+TCXzsfbVklrbcOPiGq4QZIvnYpN
 yAEs2+DFYrODpsSMAxsn9h9CP37P2BjLbLCWm/ZaTcaJpacf9OUNxjpR23F2cqN/ZElN
 +9D6Vme0OOfbDY6qle/w/pjag9e1lQOioD2F7ICIpfFjEp2Zp7G7QQeeWlpZGOAyE6Oi
 k/drf32M7lO/1pAZ0QhHhmsdjmw1rmwtfzJ3yOfNZtxMnBMFDqQlMDH6ZYFSEDFSyl1C
 Y8SBHstPCUIDgr6DDULkVGCyL0c+WSizcZAxHj02eRaZeaFqHEgd9LfM+4iTurDJpJhz
 i5Bw==
X-Gm-Message-State: AOJu0YxHlCTq/YyUNFzWyu6WsLlmKF8EO9yqwZK4BGM/WrmwagD+UAew
 MQjpOc5vHFNCKPlJn6OxLzW3VpZENdiQeJrz17UGBgNUxNZFysj8DFmQ+KnqEec=
X-Gm-Gg: ASbGncvVxyQ221vRYLqu/r/+qFYlmlVRijaFjOhyzQ3SVJXqdxCCIBLv9csIDrDsVzJ
 Lu5Lb9LFNY/0QcZXyQT9KvpjbMBreUxVrV9oImnrkvyp6PJZx5Z8rvHtBMiB6wrSDgoXHjENcjJ
 YQkl0DTYqqmi06yo+25/P/B4o9L1kem52fe6fCRtcCxWAtupm3W+2gur+GCUsA2NJxElyfDI6fc
 NhNcX7UCvKdjRcoErZJc+t7+5NDyy/C2Lt5zYOguIDu26Nld4jNjt4I69nRTSkdwb7yDWyxpt4+
 6gv5oMGmtx1ufw==
X-Google-Smtp-Source: AGHT+IE6OsRg2rGCtw1ccPUIGWPEGryBrb3SPBWc6UgSVyRC+xf7J2vDxB05/pleEYlS5RvInUbXlA==
X-Received: by 2002:a05:6a00:3d55:b0:732:56cb:2f83 with SMTP id
 d2e1a72fcca58-732618c2987mr5557873b3a.15.1739644088715; 
 Sat, 15 Feb 2025 10:28:08 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324256aa53sm5362406b3a.50.2025.02.15.10.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 10:28:07 -0800 (PST)
Date: Sat, 15 Feb 2025 12:28:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 35/35] bloblist: Allow using a different bloblist
 address
Message-ID: <20250215182804.GV1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
 <20250210143312.GB1233568@bill-the-cat>
 <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
 <20250211140755.GA1233568@bill-the-cat>
 <CAFLszTj+LnHXX5E1Yh8hqzu_uc2c1HeyzqCxOdAUu1XQBO0W0g@mail.gmail.com>
 <20250215145923.GR1233568@bill-the-cat>
 <CAFLszThHkXtvRCUYvBRBkfx_Tabb6wQ8mExFmLPNWrWXE3fsAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nyJ2WGHF0fxhdvLS"
Content-Disposition: inline
In-Reply-To: <CAFLszThHkXtvRCUYvBRBkfx_Tabb6wQ8mExFmLPNWrWXE3fsAg@mail.gmail.com>
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


--nyJ2WGHF0fxhdvLS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:23:05AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 04:58:24AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 11 Feb 2025 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 11, 2025 at 06:09:03AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > Where the bloblist is located in internal memory and TF-A's B=
L31 blob
> > > > > > > removes access to this memory, the best option seems to be to=
 relocate
> > > > > > > the bloblist just before running TF-A.
> > > > > > >
> > > > > > > We can do the relocation in board-specific code, but need an =
option to
> > > > > > > pick up the correct address within U-Boot proper.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Move the actual relocation code to a previous board-specifi=
c patch
> > > > > > >
> > > > > > >  common/Kconfig    | 20 ++++++++++++++++++++
> > > > > > >  common/bloblist.c | 15 ++++++++++++++-
> > > > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > I'm going to NAK this whole concept. The whole nightmare thread=
 about
> > > > > > these platforms comes from using a fixed address. We need to pa=
ss in a
> > > > > > bloblist or see that one is not passed to us, via register. And=
 then use
> > > > > > that mechanism to pass the bloblist to the next phase. When we =
don't
> > > > > > have a bloblist passed to us, we allocate one, and not at a fix=
ed
> > > > > > location.
> > > > >
> > > > > Well I understand that Linaro may be doing some work to head in t=
hat
> > > > > direction.
> > > >
> > > > Are they? I don't know. I know Raymond was doing some clean up base=
d on
> > > > the idea of treating bloblist and standard passage as two separate
> > > > things. Which I think is a terrible idea, despite suggesting it. Bu=
t I
> > > > think it's also the only way to make progress now that you've decid=
ed
> > > > you can't work with them anymore.
> > >
> > > Can't work with who? Linaro? If you don't allow me to create patches
> > > for bloblist within your tree, what am I to do?
> > >
> > > >
> > > > > The 'piror-stage' stuff is what has made this all too hard and
> > > > > confusing. We should think of things from a U-Boot perspective and
> > > > > make that work. The new case can be handled by standard passage, =
along
> > > > > the lines that Raymond suggested, i.e. just checking for it first.
> > > > >
> > > > > For x86 we don't need this path as there is no bloblist in TPL, i=
=2Ee.
> > > > > it can be placed in DRAM from the start.
> > > >
> > > > A fixed address is a bad API for the U-Boot case and is what makes =
this
> > > > all so confusing. And no, we can't put it in DRAM on x86 either, th=
at's
> > > > what had coral broke until I put it back in CAR.
> > > >
> > > > Please explain why a fixed address is a better API than passing a k=
nown
> > > > valid location via register, for the U-Boot case. I don't like it
> > > > because it means that we cannot always safely check if it exists.
> > > >
> > > > --
> > > > Tom
> > >
> > > Yes I would rather pass the location via register using standard
> > > passage, at least on ARM, where we have a suitable protocol. For now
> > > this is the only way for me to provide a series where VBE actually
> > > works in the lab.
> >
> > I don't understand why you don't just add what U-Boot is missing then
> > for passage via register.
>=20
> It's too difficult for me, with all the prior-stage and OF_BLOBLIST argum=
ents.

I'm not sure what to tell you then. I don't want BLOBLIST (which is not
standard passage anymore, to appease you) using fixed addresses because
that's a bad design and I'm sorry I missed that part originally. I swear
I thought it was just temporary or only a starting point.

--=20
Tom

--nyJ2WGHF0fxhdvLS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmew3LQACgkQFHw5/5Y0
tyzmiAwAi2xvKjC9PH7n57OqnsCCkFD6ZgG+JDGnOo/6k11wccSNzQvEtzV/Gn9S
nqitY60CvOrUsBVUt7Lv+zV5pPomR8Q2YqLuiS1ZhIYzim43eplaRsgLi+ALVGZi
ecdP4ZxpGVNGnKXBTR3fhT52R9ZQZQhPLZ6Xxfn0SWDT/AoJsdXN7efSoXuNv+kU
y40PdEqxx1xRX1Qv152QLX8ydVQAua98V3NP0CwraRFapZ1I+ycgUT6WzjN1K/x/
kkMy1/rygIpk1z3Zjo+6s1G504h6KRpUYM4BdRhY2kIa6NgRdMTWs6FvKl1uWN+r
/bPE6n9QR/DVXU3Le4x0FgbMsCzmh/C5ugtrh9vyLvSmYDGHd8yDPp8JF2g3uBGE
EwwUuFvv+Fa70TDWctQd6Nm474rr0I0P9Arir77Dm7LDDyOadzXr7HqixtPOsaUZ
dF7yFA3Es0mJzNc0vEurcMBj148tRinOhuiA3Z1Sp/zsXSeW6OqV3TweZm3NL8ne
yRAxgT1C
=zqQR
-----END PGP SIGNATURE-----

--nyJ2WGHF0fxhdvLS--
