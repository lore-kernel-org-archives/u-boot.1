Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD842C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 22:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EA88862A;
	Fri, 24 May 2024 00:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CW7DazGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D4488630; Fri, 24 May 2024 00:12:32 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B239388582
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 00:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-43fb094da40so1373921cf.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716502348; x=1717107148; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O26+C3WJhvFblqd4U1ynR7IzUkT29zqzEwPvMu1sj/g=;
 b=CW7DazGz7QiRKUbCm+h2ZTT7nJaJXLT0g3rNiy0ft57PSm9NQThsQjCNrgr1bT5UPj
 274afcCQTEQJIKvhCS/9CEeMhIIJsp8Cc3xOErjyx3FlDdss1PWwpgGOrMCPYoag0z52
 OYB05+9YpsYBjdoYXFkw1pfYTRybPRAxT5g5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716502348; x=1717107148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O26+C3WJhvFblqd4U1ynR7IzUkT29zqzEwPvMu1sj/g=;
 b=h6a9WXmX51UfsBOeR+oaAmaEmJbAzGk+SxMopt1xAvdvWAv9XKf1+fKN8rwJqhD6Jw
 NEOKZTL+JdxQcWZAOedQfu/gaFaXHXfv/jjt3rFhXNJyH1XTZVp9Ymh0mX7cnTb/mzLN
 gYKO87k1aVO0bFgwrXq4q0jWdOOuZstJcqUlwV0neU7B54Fh8S6rfU8VrBwBCNxBZ4GN
 i+lyqWXI09a4FF+EmZ1QPXuwRC9ACgEqhaJvLw80cBaou+l42Sxknn2l1C8cH5RdDqfJ
 oTdUou8MtB6mFKWrJR6QkL0tkU5Qh3mt/cwhVWqxJABg1tEF1Jw/4LHvAAqsfVqm17AP
 jJwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzUegQkG71L/5JPFFpB5m1aiPm2v/S4PB0nY4wG//YmouXQcD+hDqtgU5uPZF5zn7PxItzvbyPRO/8sFz6PGEOkUN3xw==
X-Gm-Message-State: AOJu0YyVHafbXDiyjuFfLA4tW1UPGqp+5dKpzBQT09sEuxliFrSYRXhO
 Jh8K2qWu8ajNjd0nYiMrKpGFRxzSSbrO9C4bpPSbVwP0ruuB2XjtNlAdeVKIqeU=
X-Google-Smtp-Source: AGHT+IHyHKseYy+FOvTCwXGJIULJgx3FZFZoV89Qpgk+yrR3xUKpdl9xshoc0hu1eMugRQeJzF6q5w==
X-Received: by 2002:a05:6214:5293:b0:6a9:d5c:73fd with SMTP id
 6a1803df08f44-6ab8f3282famr56797776d6.2.1716502348384; 
 Thu, 23 May 2024 15:12:28 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac071048a3sm921176d6.69.2024.05.23.15.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 15:12:27 -0700 (PDT)
Date: Thu, 23 May 2024 16:12:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/7] dts: beagleplay: binman: Include firmware
 capsules binman nodes
Message-ID: <20240523221223.GV2568172@bill-the-cat>
References: <20240419212819.170033-1-j-humphreys@ti.com>
 <20240419212819.170033-5-j-humphreys@ti.com>
 <20240510173200.GV2568172@bill-the-cat>
 <86o78yd1ud.fsf@udb0321960.dhcp.ti.com>
 <20240522141048.GG2568172@bill-the-cat>
 <86jzjlcgjw.fsf@udb0321960.dhcp.ti.com>
 <20240523151740.GQ2568172@bill-the-cat>
 <86ed9sck19.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PQWBHp2JKlnbIfJG"
Content-Disposition: inline
In-Reply-To: <86ed9sck19.fsf@udb0321960.dhcp.ti.com>
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


--PQWBHp2JKlnbIfJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 04:09:38PM -0500, Jon Humphreys wrote:
> Tom Rini <trini@konsulko.com> writes:
>=20
> > On Wed, May 22, 2024 at 11:12:35PM -0500, Jon Humphreys wrote:
> >> Tom Rini <trini@konsulko.com> writes:
> >>=20
> >> > On Tue, May 21, 2024 at 09:20:26PM -0500, Jon Humphreys wrote:
> >> >> Tom Rini <trini@konsulko.com> writes:
> >> >>=20
> >> >> > On Fri, Apr 19, 2024 at 04:28:16PM -0500, Jonathan Humphreys wrot=
e:
> >> >> >
> >> >> >> Fill in the BeaglePlay's capsule GUID properties of the base bin=
man capsule
> >> >> >> nodes.
> >> >> >>=20
> >> >> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >> >> ---
> >> >> >>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 27 +++++++++++++=
+++++++
> >> >> >>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 15 +++++++++++
> >> >> >>  2 files changed, 42 insertions(+)
> >> >> >
> >> >> > This series introduces failure to build in CI, and it's a little =
tricky
> >> >> > to replicate locally, depending on your environment. You first ne=
ed to
> >> >> > NOT have BINMAN_INDIRS set and instead be using fake binaries. Se=
cond,
> >> >> > it seems python version dependent perhaps? I don't see this on my=
 host,
> >> >> > but by:
> >> >> > - Using the CI container
> >> >> > - Setting up a virtualenv inside of it
> >> >> > - pip install -r tools/buildman/requirements.txt
> >> >> > I get:
> >> >> > $ ./tools/buildman/buildman --keep-outputs --reproducible-builds =
-dvel --force-build -PEWM --output /tmp/am62x_beagleplay_r5 --board am62x_b=
eagleplay_r5
> >> >> > Building current source for 1 boards (1 thread, 12 jobs per threa=
d)
> >> >> >        arm:  +   am62x_beagleplay_r5
> >> >> > +(am62x_beagleplay_r5) Image 'tiboot3-am62x-gp-evm.bin' is missin=
g optional external blobs but is still functional: ti-fs-gp.bin
> >> >> > +(am62x_beagleplay_r5)
> >> >> > +(am62x_beagleplay_r5) /binman/tiboot3-am62x-gp-evm.bin/ti-fs-gp.=
bin (ti-sysfw/ti-fs-firmware-am62x-gp.bin):
> >> >> > +(am62x_beagleplay_r5)    Missing blob
> >> >> > +(am62x_beagleplay_r5) binman: object of type 'NoneType' has no l=
en()
> >> >> > +(am62x_beagleplay_r5) make[1]: *** [Makefile:1126: .binman_stamp=
] Error 1
> >> >> > +(am62x_beagleplay_r5) make: *** [Makefile:177: sub-make] Error 2
> >> >> >     0    0    1 /1              am62x_beagleplay_r5
> >> >>=20
> >> >> Tom, this is failing in the CI container because the container is m=
issing
> >> >> the mkeficapsule tool.
> >> >>=20
> >> >> To solve this, we just need to add it to the CI container.
> >> >>=20
> >> >> My understanding of binman's handling of missing bintools is that i=
t should
> >> >> gracefully continue with fake data, so that buildman can successful=
ly test
> >> >> out builds for boards even when you don't have all the required bin=
tools.
> >> >> If I have that correct, I can also create a patch to properly handl=
e this
> >> >> when using mkeficapsule. But I want to verify this is the desired b=
ehavior,
> >> >> since mkeficapsule isn't a unique or vendor specific tool, so shoul=
dn't we
> >> >> require it as part of the U-Boot build environment and err out if i=
t is
> >> >> missing?
> >> >
> >> > Perhaps it's a binman issue since we build mkeficapsule or at least
> >> > should be? Neha?
> >> >
> >>=20
> >> Never mind - I figured it out.
> >>=20
> >> The mkeficapsule tools is built by u-boot if TOOLS_MKEFICAPSULE config=
 is
> >> set. I didn't explicitly set it because it is implied by
> >> EFI_CAPSULE_ON_DISK config. But this is only set for the A core u-boot=
, as
> >> that is what would apply the capsules. SPL running on the R cores does=
 not
> >> need this. But that then means that the R core u-boot builds don't have
> >> TOOLS_MKEFICAPSULE set and if that is all that is being built (as in t=
he
> >> case of buildman), the mkeficapsule tool isn't built and so is missing.
> >>=20
> >> So I need to explicitly set TOOLS_MKEFICAPSULE in the R core defconfig=
s.
> >> I'll repost the patches.
> >
> > Interesting. My next thought here is that whatever symbol is allowing
> > for "make a capsule" should be select'ing TOOLS_MKEFICAPSULE and so the
> > current logic is a bit flawed. I'm just not sure off-hand where it
> > should be instead, do you have some ideas now? Thanks.
>=20
> There is no config that indicates that capsules will be generated for the
> resulting binary. The only thing I can think of is to scan the board's DTB
> for the presence of a capsule binman node, and then set the
> TOOLS_MKEFICAPSULE config. But this seems very complicated to do at
> build time.

Yeah, that's the wrong direction I think. We should perhaps just make
TOOLS_MKEFICAPSULE default y if EFI_LOADER instead.

--=20
Tom

--PQWBHp2JKlnbIfJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPv0QACgkQFHw5/5Y0
tyxuBAwAjsuld86fU3zHIgbuB0xRNmcjCLpMffW7GC0mG6gf55qH5JtWfmB+3lst
8DBihu9HkSZPKNpDxyGm9KsKr4FkjXcckZ+f/O3FpnWH90G5GpormA5wjQmPyXs9
XQwFYXVQWdGjkDMFI3aPwRwHNnnKcG053Cl+O/DrQIpcoKjFQbkIdwMNmcvwYKbg
cSP/CRvUiKpbY2MPxkqM8tG/Zi/OcGzD79SLU7OO13ARljTq/X9qxapybZjk8sm5
6Bm0PNHnytwsbnOk1FBRC8BHefn/Ex9bjIH8zy5nFzi5wA6psFQ1a88ZuWLmERJ4
9X8k3Tm29pHa+mjI+lmeDM5wRtPb0sxHrqaWfwWk4WRTiZPXk3eo0R98zgY26NsZ
SUndfNSOGoMmiesTt0eHYcCfcZHx65S6QzAq7SgQ6Q9CshTb3kxJruPE82U3g1jR
CDjMoKoTq5XEeUFZDJ1vcQJ7P7mUJRxFktgJmZSWe1VZPLxtwhznWZewkQRtD+7p
r562WFsu
=aJsl
-----END PGP SIGNATURE-----

--PQWBHp2JKlnbIfJG--
