Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4870E6B278
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B0F89177;
	Fri,  1 Nov 2024 14:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UXWVqwu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B36B89177; Fri,  1 Nov 2024 14:52:29 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE051892A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so11747566d6.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730469146; x=1731073946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kvp5eoiuGMY3RDCkH7FumA/Lj9ajw6molDzkbMsdhnA=;
 b=UXWVqwu5NWQVDtR1GQ4tvBStWKaO43E74ynA54Z05Fhxy7T3CKtC3ecIsiY/Cg65yy
 JkInTOzXw55BlgPjqNqOGUz1My3dNMr95zTbxraZiNiXfw1NQ5uk3oN3jsCzw2+/R0b9
 dRmLztTgDJC+7ZYUuWzRNs2myOZzTMhKS1v/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730469146; x=1731073946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kvp5eoiuGMY3RDCkH7FumA/Lj9ajw6molDzkbMsdhnA=;
 b=KYzwYa52yyMnbI4IyNH9zh21NM715F5WY6ucv4XZ4IdVwZbh4x/JwLlCjcngUKuI1d
 /x43SfEIoQbuIzrGDmVE9gYFAj/cJAz3Zg865Qb0wyYkH+ZGMke7gBP75Q2MAOKOu2um
 qM6u18Cqj0OSagnBisLSBtMV759WWnr/SMnzThGExYo9eRA4zVEcGNy9g+EPFNQ3WOqL
 tXngZDu4FApKhxT+pXLDbveBG3iVXme/JAWYvl/l77dYb5JiliQHWHlpngkr20hRilnH
 4Q0uDiYjzkqB625PgcIPdWP1+ny9WGjzcnlxG9bY9kpv/8gcscqF47V0pdPJdAtwt6Qv
 a+dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHqboa0iBR8XeaYLnEB6whRad+ESvhFInsbLDMzyZnTLNC8JwzU3K5TaloS6UUtFCRBKXdWR8=@lists.denx.de
X-Gm-Message-State: AOJu0YyzmZLbqdRGKOO8JQKHVo63DAE5ozfr+DGBOM+8RSc3XneOyPD7
 NA6Hw8HAujDOAvIznNBF30pXE0hX7QGVJWQLFbPjDF18cytOyjJiZzsRuujFqeE=
X-Google-Smtp-Source: AGHT+IGxStWgjHnlRNHRzfSqX2l3X2sZz+NkyHi7mKlTLLPIUv710+Iku2y7NzTQ/+ivlW5o26SHxQ==
X-Received: by 2002:a05:6214:458f:b0:6cb:7104:f115 with SMTP id
 6a1803df08f44-6d35c088599mr44998906d6.11.1730469145710; 
 Fri, 01 Nov 2024 06:52:25 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415a6d3sm19179386d6.101.2024.11.01.06.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:52:24 -0700 (PDT)
Date: Fri, 1 Nov 2024 07:52:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com,
 neal.frager@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
Message-ID: <20241101135220.GJ3600562@bill-the-cat>
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
 <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
 <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DoL4BN5PX10/X1+w"
Content-Disposition: inline
In-Reply-To: <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
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


--DoL4BN5PX10/X1+w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 02:09:38PM +0100, Michal Simek wrote:
> Hi Simon,
>=20
> On 11/1/24 09:27, Michal Simek wrote:
> >=20
> >=20
> > On 10/31/24 19:03, Simon Glass wrote:
> > > Hi Michal,
> > >=20
> > > On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrot=
e:
> > > >=20
> > > > There is necessary to do some steps to compose boot images. These s=
teps
> > > > were in scripts in layers for a while. That's why introduce descrip=
tion via
> > > > binman to simplify wiring and remove all scripting around.
> > > > This should make sure that everybody is up2date with the latest ver=
sions.
> > > >=20
> > > > The first step is to create fit image with DTBs with descriptions in
> > > > configuration node which is written as regular expression to match =
all SOM
> > > > versions.
> > > > Description is there for k24 and k26 in spite of low level psu_init
> > > > configuration is different. The reason is that it goes to u-boot.it=
b image
> > > > which is the same for k24 and k26.
> > > > u-boot.itb is another image which is generated. It is normally gene=
rated
> > > > via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supp=
osed to
> > > > be deprecated.
> > > > FIT image by purpose is using 64bit addresses to have default optio=
n to
> > > > move images to high DDR (above 4GB). TF-A and TEE are optional comp=
onents
> > > > but in the most cases TF-A is present all the time and TEE(OP-TEE) =
is used
> > > > by some configurations too.
> > > >=20
> > > > 3rd generated image is boot.bin with updated user field which conta=
ins
> > > > version number. This image can be used with updated Image Selector
> > > > which supports A/B update mechanisms with rollback protection.
> > > >=20
> > > > 4th image is image.bin which binary file which contains boot.bin and
> > > > u-boot.itb together and can be programmed via origin Image Selector.
> > > > This image can be also used for creating one capsule which contains=
 both
> > > > boot images (in SPL boot flow).
> > > >=20
> > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > ---
> > > >=20
> > > > Currently I have this for testing purpose only to find missing bits=
 and
> > > > pieces in binman for cases I want to support.
> > > >=20
> > > > This patch depends on
> > > > https://lore.kernel.org/r/ fbed0251437b61a2f7a85596d7403b5b9c8237c1=
=2E1728306322.git.michal.simek@amd.com
> > > >=20
> > > > ---
> > > > =A0 arch/arm/dts/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 1 +
> > > > =A0 arch/arm/dts/zynqmp-som-binman.dts=A0=A0 | 224 ++++++++++++++++=
+++++++++++
> > > > =A0 arch/arm/mach-zynqmp/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 17 ++
> > > > =A0 configs/xilinx_zynqmp_kria_defconfig |=A0=A0 2 +
> > > > =A0 4 files changed, 244 insertions(+)
> > > > =A0 create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
> > >=20
> > > I'm pleased to see this. My only suggestion is to use '/bits/ 64'
> > > instead of the macros, for 64-bit values.
> >=20
> > When I was playing with it some time ago it didn't work but it works now
> > that's why no issue with it.
>=20
> One more thing on this one. I pretty much dislike that images are generat=
ed
> to u-boot root folder. Isn't there a way that they will be written to
> separate folder (deploy for example)?

Or perhaps $(obj) ?

--=20
Tom

--DoL4BN5PX10/X1+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmck3RAACgkQFHw5/5Y0
tyzDzQv/fjYOg8IjIoHra9zPqoHJ1OCpgMHFsA4jh414ZsmSGdp4JGvQi5Oq4vWT
/xs1IxB4CXMNaV+A/U32aWmgxJvwa5I4cJ/wkUfvXXDYPtHF6CtBhYJlgQZUWoG7
ANOOxlvyityOuenRmVxEaXoSaxxIoWQerYgWhfmaja1oymZzcFzt0FeM7oPDglE3
lHDd33xS/t4+9VoK3sTKCFFikWtBQ/oTEcRV2qk5/uK1/gbo41NJ6erOi0zy+Hb9
JACMNXKOWKGjKrTSiUIW8ZIuGF8qByfOHzF91/mHNDewtBl4FVAGx3TVj/Zn0bpJ
KakGUPfONLYzZF6Otz8xrBaA75ldH163LcHclxXrTxXuC6aBKRuVQUJnyWuwjjZL
kqasabdg+bdeqCxbgzdAshUCGibgZYt7R+EGPjnh/sYaCzFfk9JrgL7Fgb53qmBk
UjoewByPv8FPpyZsOsT1yOFnnnpDcaSKeAGUwQ/rUTc8KvhcCdH0Fs4ECuRi6/ro
BOviM+V9
=1Ct4
-----END PGP SIGNATURE-----

--DoL4BN5PX10/X1+w--
