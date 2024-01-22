Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579BBC47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D048792D;
	Mon, 22 Jan 2024 19:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SAEvo7sC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA25878BA; Mon, 22 Jan 2024 19:47:24 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7485F87B6C
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5ffcb478512so11402727b3.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705949240; x=1706554040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6tBNdw7L8HxqfMTtyygC5thjy4a6HVfVUNTBygcjBf8=;
 b=SAEvo7sCxeX3Fdo5l4T9vn1JguXQ68pa8KOhsY+Wonh7gACGmwVueQl5M2iWwdtRL2
 CYoYqAfyOVRqWRUXetJ5b25mHnXHk3gKDE7uRCNLB7tfqhQD+pus2O9xh1/2uANG1sve
 jHSsn22nPdYalwk+fK/Gn4JE51HK7vyt/CCb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705949240; x=1706554040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tBNdw7L8HxqfMTtyygC5thjy4a6HVfVUNTBygcjBf8=;
 b=ch18Ci42pCuV2fI0PwxaQmgIdIGSNmSR5PiulF2jv61Y2BdymiyqZZz/02Nms2SNQb
 18qKiHUbHnzr7SdVLrcsQkLH1FIOM9d3U/WLvINMGj4NojOzbfaaKmZQVZbCd0kbtLp+
 2BIpIwZ8zqQpMtKeD77U7dpp7qdZSByHuNxOYG3Ut5sb+dO+ZiqRjewAdnbKirv5jHNr
 8KNHoT+GT38W2uxRG/8vJycroATPCOJTuYYdUw8aXfIqyN/PimY0Flkk9qFUQsGYPwi8
 Hp01xNVdiAu19/S0uYUoM7Roc+onpm+4gL8zdrCB/wxeKgPxGZXn8jQo3vrHcfJL0wY7
 5kIg==
X-Gm-Message-State: AOJu0Yxo2MgWjzYC2hRgqm/mPyc3bNLEnz792XMWeXg033s22CkYwKLt
 TxOun5VEWCGPZtgI7X0vHmZFWfNLV93fdJV/dd78AaPyOfuSdfMjzM2JJlSuXCs=
X-Google-Smtp-Source: AGHT+IHgAsCuEHvp7qX2p32IPTHbUVMBAlMzS7MS2+SHk93dz2C/i6y6As7lGDbxFvAtNCRGD5yFBg==
X-Received: by 2002:a0d:cd04:0:b0:5ff:933d:e8fd with SMTP id
 p4-20020a0dcd04000000b005ff933de8fdmr3575665ywd.28.1705949240211; 
 Mon, 22 Jan 2024 10:47:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 q8-20020a815c08000000b005f75cf6281fsm9695451ywb.5.2024.01.22.10.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 10:47:19 -0800 (PST)
Date: Mon, 22 Jan 2024 13:47:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20240122184717.GQ3652023@bill-the-cat>
References: <20240104014919.413568-1-sjg@chromium.org>
 <20240116-snowbound-symptom-aa07c4dcf736@wendy>
 <20240122-pranker-shininess-8953eb6182b4@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mx2EFe1yDwCKJXE8"
Content-Disposition: inline
In-Reply-To: <20240122-pranker-shininess-8953eb6182b4@spud>
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


--mx2EFe1yDwCKJXE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:36:31PM +0000, Conor Dooley wrote:
> Hey,
>=20
> On Tue, Jan 16, 2024 at 01:48:06PM +0000, Conor Dooley wrote:
> > Yo,
> >=20
> > On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:
> > > Standard passage provides for a bloblist to be passed from one firmwa=
re
> > > phase to the next. That can be used to pass the devicetree along as w=
ell.
> > > Add an option to support this.
> > >=20
> > > Tests for this will be added as part of the Universal Payload work.
> > >=20
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >=20
> > Since this was merged into master, U-Boot is no longer booting on my
> > icicle kit (At least that's what my bisection tells me). This is a
> > RISC-V board and U-Boot for it is built from
> > microchip_mpfs_icicle_defconfig.
> >=20
> > There's zero output on the console from U-Boot at all, the last thing
> > that I see is OpenSBI before things grind to a halt.
>=20
> Just wondering if there's anything I can do to help this one along?
> Got a red CI complaining at me every morning about it :|

Well, can you please look in to what part of this is causing the
failure? I don't really see what would have changed on
microchip_mpfs_icicle_defconfig from this as BLOBLIST isn't set before
nor after this change.

--=20
Tom

--mx2EFe1yDwCKJXE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuuDIACgkQFHw5/5Y0
tyzK5Av+JsuHHIviB/oN0+RMcpwnOzGBi86ed4mq49Wg1A1ATRT1aFDKczrP9hc7
qoe2bX00dr6GqStz/uX5TuYUfolYpin6EwksOYUHu1SBW9MDDmPo+xF8fQKuXPua
BaKSKqyVIwI3G0rJMElPDpnU+3Ie5NyREzoiQGkDBkX0rWOoLhvaGR9w9fiburrc
wxVFYam2HHXL62z6/qAapJ/HMN9ccyJuylB1dJX7L8ADuTWFSQdFx469gaLvT+lA
TygvKtEgysb/QVO9UNWBXw+A+RcdI3pl1Ubjks1IPQS+GC5kshjzrceXrDBy4kzk
1f+s6diZWDXEWAEeVq2R682brYoH4a4H8hI598Kere+GTnlO5jUfYhSiEh75LZNB
D3kGkO1nimVcsMvCqO9TgsxRA5aqKbaylQFChIFlZ4K7hzAl/VMKCiG36eI3SqHh
W7nvlKiELHJ5SX5gf1aQ8+SDYw0iSOWa0MM3/T/zPE8nm2MbNWcUTekyRSOZBJeM
epSq0mFu
=sOdJ
-----END PGP SIGNATURE-----

--mx2EFe1yDwCKJXE8--
