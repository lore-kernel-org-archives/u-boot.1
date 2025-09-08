Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D2CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776B182AE9;
	Mon,  8 Sep 2025 18:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GVv+uqJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B7A82DA1; Mon,  8 Sep 2025 18:20:28 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E605809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-319c2a87a5aso1663078fac.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757348424; x=1757953224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QqBU6LER36J9+aQHdSDo6X1T7NqodhqkL5C9kpMMALc=;
 b=GVv+uqJTagCwnaOJY2pgZm7Jxp9xzaZ81wtqSCNzoyulpy1aUu8fzqJIn0jSPlq93Q
 JOvdv3L36bRUTuph/DkyIV5WGLFV9CgLGaKJMk+eQiWCiwhewifxhzX4rAXa3ErZUrKx
 O/7xpi5Zn/raZ0aIOhCR57ajhBLE0mXktDn0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757348424; x=1757953224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqBU6LER36J9+aQHdSDo6X1T7NqodhqkL5C9kpMMALc=;
 b=OycHFpOZQGmeuzxBbVFOaJR5R0BkTO05JB4iNi93xUdTkSR+LBktb0Suabk0qF+R50
 W7vQ60OC1MRu4tdZwZ3khCxXNZ8y1Tcf/+M43mceS5taxJzExG04u8M03AywwnacCAT2
 CPkPu3WoiQw+91tGbF8t/DBFS28vNYeBhomfdaFJhupMzyL6ixUng7hfIULJSmyyazC7
 /HE6f7V6byUdeRsJfJuJIGYXB7G1Xu/eX2FIkL0SNpVtf15yLcraGum/WXVeq66LiZOl
 kTkJRnYLREQvHOnpnewSlGnqgrtHX9sTdRXBxLIJXxUewWBVW2b0Wi7a4Zu8qySkOrn2
 cGng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR8W+k3FdUp+g/MTtKbkkI5AL2ZELcgWk2+Qvfkc6qxtPc6Py+1aLMpzE2O6pAYbx3Dvadztw=@lists.denx.de
X-Gm-Message-State: AOJu0YzXyMdDWEYb9ftdOpl/bIAmDqTRdlbfyPjW4e0S9ZDPRNTgIYxD
 vqHgFERrWNZ/8Fj/0n5m8AkZdDWXCK0naDQuSoTBej+TP9ea2yhPA2eOGETtqMTJ+xiMCw5mXMV
 J0FHFTfc=
X-Gm-Gg: ASbGnct74xRbUMXeCPeF/IqpHATjSvAqv5kPtUs5rolAul8rPWS1Lg/Fk81yNAFiaYd
 rmFxUecJyIWMibyvpjWTwLXupQqnXPOyrl7VKH2NAI+rZ6Bybtd9VBXNifWZOgjdDz2KbzM8Mb1
 Tbm89HktZW/OeiisajRww31+22VNOXmHhhGqHhXZ+nit3N7NDgv04AXhn0SWf4SDWB58mIjDf7v
 5wTz17xOavDt3dUFakL/sowZEp4/gYF48NVlWoCUnWlt0q/gvyCpZtZuHzOTGVyw0ToVWfa1twP
 mC0RrRmLgCNtcOZSSH8cWNZPQepde+/zyGQiNAZU4zINPvuBLl4otoK3R1ErAsTSaIPJVw1FvRZ
 I9oZRzegfHou83VKAsHp39Z/ajcxJcVm+l4FUUYGWwBLwkU8alg9Jj40k
X-Google-Smtp-Source: AGHT+IFpOcHHpd2NcuN2x1TvYvsjzyjzJd6d5+i6xZPJ8oJuAKNs0JrvAa5CLbGGua4mzQJjtKVtow==
X-Received: by 2002:a05:6870:d608:b0:321:29a5:4e11 with SMTP id
 586e51a60fabf-3226552e753mr4246051fac.47.1757348423709; 
 Mon, 08 Sep 2025 09:20:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-747c84ff12bsm2967146a34.9.2025.09.08.09.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 09:20:22 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:20:20 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Anurag Dutta <a-dutta@ti.com>, n-francis@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO
 at SPL
Message-ID: <20250908162020.GR124814@bill-the-cat>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-3-a-dutta@ti.com>
 <20250902154656.GE124814@bill-the-cat>
 <5fec7216-9e0a-4d97-af23-60953cc1ef75@ti.com>
 <20250902161257.GF124814@bill-the-cat>
 <380dd6dd-8751-4843-936e-e9da577f376f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nieze2uAQ5Yg4SNC"
Content-Disposition: inline
In-Reply-To: <380dd6dd-8751-4843-936e-e9da577f376f@ti.com>
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


--Nieze2uAQ5Yg4SNC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 09:58:34AM +0530, Kumar, Udit wrote:
> Hi Tom,
>=20
> On 9/2/2025 9:42 PM, Tom Rini wrote:
> > On Tue, Sep 02, 2025 at 09:36:25PM +0530, Kumar, Udit wrote:
> > > Hi Tom
> > >=20
> > > On 9/2/2025 9:16 PM, Tom Rini wrote:
> > > > On Tue, Sep 02, 2025 at 03:49:59PM +0530, Anurag Dutta wrote:
> > > >=20
> > > > > Commit 0e198ff1a911 ("configs: Resync with savedefconfig") removed
> > > > > the necessary configs required to boot HyperFlash successfully, d=
ue to
> > > > > missing Kconfig dependencies. Now that the Kconfig dependencies h=
ave
> > > > > been added, re-enable the HBMC and MUX_MMIO configs in the SPL st=
age.
> > > > >=20
> > > > > Fixes: 0e198ff1a911 ("configs: Resync with savedefconfig")
> > > > > Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> > > > Please note that this means it never worked to start with.
> > > > "savedefconfig" does the equivalent of "make foo_defconfig" and then
> > >=20
> > > It was working before but due to some boot issues , due to DT sync
> > >=20
> > > we disabled HBMC with commit id 5b2671594b80af116e259313d48bcd580d71f=
462 .
> > >=20
> > >=20
> > > Instead of saying Fixes: 0e198ff1a91,
> > >=20
> > > This patch is fixing sha id=A05b2671594b80af116e259313d48bcd580d71f46=
2 by kind
> > > of revert.
> > >=20
> > > my bad to give R/B , overlooked on sha id of fixes tag.
> > Again, no, that's not quite how it works. When we do a defconfig resync
> > like this we're just making the defconfigs reflect the present reality.
>=20
> would need your suggestion here, what should be fixes tag,
>=20
> My comments were not related to defconfig sync

Ah, yes, sorry, I mis-matched the hashes here.

>=20
> > If you checkout 5b2671594b80af116e259313d48bcd580d71f462^ and then look
> > at the resulting defconfig, that option will be off. Doing a git blame
> > on drivers/mtd/Kconfig the right fixes tag is for:
>=20
>=20
> If you look at sha id d7ef2ef7c87528c359e110d7170e01a98aaecf14 (configs:
> j721e_evm_defconfig: Add HBMC related configs)
>=20
> is adding support for=A0HBMC. So it was functional before.

Yes, I see that now, that's good.

> Later due to DT sync and=A0HBMC was broken=A0so we disabled=A0HBMC with s=
ha id
> 5b2671594b80af116e259313d48bcd580d71f462.
>=20
>=20
> After that there was attempt to enable HBMC via below sha ids
>=20
> 8f71d37838ba0b0bfa047f5133877092ee9d1110 (mtd: Kconfig: Change HBMC drive=
r's
> dependency to MULTIPLEXER and MUX_MMIO)
>=20
> fd7fcd4098d5c1ba9e20dbd72aa5f9a74f0cbe42 (configs: j721e_evm_*_defconfig:
> Add configs for Hyperflash boot)
>=20
> c9df79ee64d0885277d5061a9426744920c4d6a5 (arm: dts: k3-j721e-r5-common: A=
dd
> HBMC overrides for R5 SPL)
>=20
> a42b8b0b3fe0ffe69ffb932bf3e709a62ff34a23 (mtd: HBMC-AM654: Changed syscon
> API to mux APIs)
>=20
> f0558f3a89fe0fa900b162ae2758772e37f72739 (mux: Makefile: Add config for m=
ux
> drivers)

I guess my main frustration now is just that it's unclear where along
the way what was submitted was or wasn't fully tested. We have both
Kconfig dependency changes and dts additions (but not binding changes).

At the end of the day however, we don't yet have a linux kernel style
"backport changes to eveywhere a fixes tag exists in old but supported
releases" work flow, so we can just drop the fixes tag if it's too
tricky to see where things did / didn't work. Alternatively, with the
list of commits above and a board to test on, checkout the tree at the
commit prior to that, test, then test the commit and see what the
functional change is.

--=20
Tom

--Nieze2uAQ5Yg4SNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaL8CRAAKCRAr4qD1Cr/k
Cng4AQCnP8cM9aRLcXopbfAxt8MtWib3WIyFvfVqF4vFUCq6lgEAhsP66vYA9qYF
hPObmidDp0EmfpvK90Xz0eDamS8CngQ=
=aPWv
-----END PGP SIGNATURE-----

--Nieze2uAQ5Yg4SNC--
