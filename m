Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E14C54ED1
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 23:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A8283164;
	Fri, 23 May 2025 01:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q7ivimtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8838319A; Fri, 23 May 2025 01:39:59 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCC78310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 01:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-403407e998eso6156697b6e.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747957196; x=1748561996; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BEio1iGFWtZzJdbCnWxFENIhJA26cSCt/x5ius4jEqY=;
 b=Q7ivimtqtB5nNs0+T9HDW7uM3eTjtMAHRUTFKWQV0ew0niPAqW/CwZp42fyXuBkqpc
 ZWdcIR/6eQZGfNnfwF5/48Y7X7uOXFjHC0BLqtBqWm8/6FIkgOJVzeWJJ3IYWDA+JEle
 hhEqd1DvZw2v7f9aNBu8NF9/iS78IHtDI4Ub4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747957196; x=1748561996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEio1iGFWtZzJdbCnWxFENIhJA26cSCt/x5ius4jEqY=;
 b=XrfcBa2eW54xrOeuq7WT+Bb/oJ3CoSw7nn5O8iOY+CGTXCTztbf69Rbe8B32N3GbOu
 v+d7cGADwg93pvq93whxjAZfWPfPokzwFpE5SUkijqMLcKIxQ6qZROQctPqo3Q81N1We
 HxyQpegf83g33MzK0LX25Kbkwxdd6LFNTCDh2iiqbT+5ZdY5m1pw0ihvCYzcqeqPsInW
 9/xB6x75NgDvXYPmqMy+lao5yzvtxiGOKApjOOvp2j/QgMZSvGQ94wNeMQS/9/7Ra+Ys
 2vqdfQ540JZssl6wFHO6l9lalXaDNDTBk3Tacj+BuPk4DE4wASiivqXh4pDmT4hSZ7mP
 UOQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrjoiUk1llOqquvr79Op/xoPI9+6JCRxKS+NC12J5tywR08qGRuouqVvhvYzqdO5B1eSdao0E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7b/4LDZRTRuSrZkJnStPNQh4bYVeATfVjNHzv2VbbZ1SbKWSt
 MMA9B8B7RLmDsuZZJRxn5xiIpRLFn6a+zKXDp33WBk099fmGIemFGJlbReKfBOPDb9c=
X-Gm-Gg: ASbGncuINJLPtdnKx3bN4hOmOMcH10EctU807bzVoSdJJeZlGumzFg4XFr6DJFN6242
 BMJAaHPi8KgeyMWiQoXWwNr8aVGOTCSPnlnB+V4rqmRLJBMSLo1/r8Jx98FUPnyvJ0S613QAL6K
 TnKy6wOR5hx7+SUcuoc2nIjy7md9UlmI3MD2aOFpXrTfUOi3+E7bUjG6NgM7Y408UaozTjSdIN9
 P9Ic9PNfBRKWAvJ7hzxX/53X22dorhUUzE8bcahckodfry3V8Iu5qx26H7thrJaOegBkpo+wbvL
 GgfSDrh8aSIv81SBlBSBf9h6RQajiXyK2wgWyqzuCOTxqCoZDIR1hBhmmNB9aia19HUCAUlJ5VC
 BKOtn6BqGXFQL
X-Google-Smtp-Source: AGHT+IHKZO7NpXXqhZ0eT7BZvzkdcw080vjjJ4wodKIyhKPzQKxAUwN3t69FcbGRNoF0MPLAthprJA==
X-Received: by 2002:a05:6808:2f1b:b0:404:dd05:1bd9 with SMTP id
 5614622812f47-4063d7a6dd3mr882934b6e.0.1747957195855; 
 Thu, 22 May 2025 16:39:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4062a39c88dsm961900b6e.25.2025.05.22.16.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 16:39:54 -0700 (PDT)
Date: Thu, 22 May 2025 17:39:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] Qualcomm: teach the build system to emit signed ELF
 images
Message-ID: <20250522233952.GO100073@bill-the-cat>
References: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
 <20250522205100.GN100073@bill-the-cat>
 <00bc73ad-e17b-429b-9531-115f90508425@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="umG1Y65R+AyV0RZu"
Content-Disposition: inline
In-Reply-To: <00bc73ad-e17b-429b-9531-115f90508425@linaro.org>
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


--umG1Y65R+AyV0RZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:07:06AM +0200, Casey Connolly wrote:
>=20
>=20
> On 5/22/25 21:51, Tom Rini wrote:
> > On Thu, May 22, 2025 at 10:39:38PM +0200, Casey Connolly wrote:
> >=20
> > > With several new Qualcomm platforms appearing on the mailing list, all
> > > of which build U-Boot as an ELF, sign it, and then flash it to some
> > > partition on the board, we're getting a lot of defconfigs which just
> > > contain a debug UART and a TEXT_BASE address. This leads to needless
> > > rebuilds in CI of effectively the same image, and needless duplication
> > > of build instructions.
> > >=20
> > > To address this, let's introduce a new tool "mkmbn.py", this is based
> > > on the existing qtestsign[1] tool but is (currently) hardcoded to
> > > only handle the Dragonwing and IPQ boards which use MBN header v6.
> > > Additionally, the tool contains a lookup table that maps from a boards
> > > DT compatible property to the load address it needs. Since it's highly
> > > unusual for different boards using the same SoC to have different load
> > > addresses, generic platform matching is also done (e.g. "qcom,qcm6490=
").
> > >=20
> > > With this tool in place, we introduce a "u-boot.mbn" target in the
> > > Makefile, this can be invoked to build a Qualcomm signed ELF image for
> > > supported targets.
> > >=20
> > > Finally, the defconfigs are cleaned up by moving the debug UART
> > > definitions to config fragments (since it doesn't make sense to have
> > > them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
> > > the qcs9100_defconfig is removed entirely since the same binary can
> > > be created with just make arguments. This platform entirely lacked
> > > documentation to begin with, which should be addressed by future
> > > patches.
> > >=20
> > > The Qualcomm documentation is also cleaned up, a new "signing" page
> > > is added to briefly cover the what and why of MBN signing, and board
> > > specific pages are updated to explain the new build process.
> > >=20
> > > These patches have been tested on the RB3 Gen 2, but additionally
> > > testing for other platforms would be super useful.
> > >=20
> > > [1]: https://github.com/msm8916-mainline/qtestsign
> >=20
> > How much did you look in to having binman be what invokes a tool to
> > do the signing? Thanks.
>=20
> To be honest, I know very little about binman. I've done some reading now
> and on the surface it seems like it wants to solve the problem we have he=
re,
> but I'm not sure it would make things here much cleaner.
>=20
> As I understand it, I would remove the additions to mach-snapdragon/Makef=
ile
> and instead have binman wrap mkmbn?
>=20
> I can do this if it's preferred, but the abstraction feels a bit redundant
> in this case imo. Especially if it requires adding some "binman DTB" to t=
ell
> binman which tool to use, we already know which tool to use because it's
> encoded in the make target ("u-boot.mbn").

So, binman is the canonical tooling these days for doing this stuff,
yes. Can you see what it would look like to integrate this that way
instead for a comparison point? Thanks.

--=20
Tom

--umG1Y65R+AyV0RZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvtcQACgkQFHw5/5Y0
tywL6Qv8DJwTWSrfOebAgqz/SzIXzzJb4qe/rvcln0M3dDD2GBTcfpjn6mQV2NeC
jZxAkEM0K9Xd0KAtZbuMU/jxWkvWFMsQAIcYg589peLMVCCf4XaXcf4nkSrJ+qSB
IVVPKlHfnwfYoQNMXy36wrze3puIFVLXhb38ZgZbk/tBM/kUbsDojkA6B5bsIfyd
9E6SL3AG9Ryxg+A4mxJmTTw1yIwrYVW7CDFlyQKF3qWPW1y4jas5+mCuc0GMwr//
AH2qJt5g4zitOtS1Ub9MOs9dTwP3glbaljBYMl8gQiKn9od0Jfu8lYB+PExjcyhd
+8G/JqGA3ylVBn9U4B1n3/Kk3XzQuPS0xTB0dyjK9i6yYnC5HnM90gnywH6QKCu2
BlazOp+Nd0VKS3bFgGtNEzrnMoxhfV7eY7sbCm/HbgSPBdoFLJtyCI/XLLsR/nZh
/NbXfUJXrjd/BbXZo/SLbiK9mRBHrSIe+KuF1nwNDx2SyCS2LSiQdLv9p887USoR
64b4HXk5
=iLtV
-----END PGP SIGNATURE-----

--umG1Y65R+AyV0RZu--
