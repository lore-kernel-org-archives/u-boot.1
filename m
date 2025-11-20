Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4A9CF8875
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F578409E;
	Thu, 20 Nov 2025 17:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m892c6e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8D6840AA; Thu, 20 Nov 2025 17:27:28 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9877A84088
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e3dac349easo674713fac.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763656044; x=1764260844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2v5KLwJsZ6MNbjV8Ikc0oZwSEfOu3+2TUNdhgcsASRk=;
 b=m892c6e6OVG9XF36ykIjRMfi5/n3umeYOrJKQxA11rXbiePQPwvnIZfNNf1c5jzp3P
 anedboReBVxyF7lhqwnJJHRCAm25ztAK5tj/CA0NAwub4AomTcCeoDbneGxwRxCFdV/v
 mwfAshX9Q+QSzmkUL9UvzEHjbMC+Hntroil3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763656044; x=1764260844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2v5KLwJsZ6MNbjV8Ikc0oZwSEfOu3+2TUNdhgcsASRk=;
 b=ISxEA/jrWMBhvfmTCHyTm/cXR4imJ4NK6G6uOYRPhVEx2CMdFxr9cgz+5SeEE9jidL
 Cn1AgFMIBgtUEe7G2aopztV9nBnukAgXQrtgiggCgDfRoCKh+BrBQhDfEIwCoPnmITn5
 n2wc76XIqPmRVuQDUqG5inr8SExjZAzauFdSZhWA3XPFnIGvAhqyVUOj+Zo3Vi93V/E6
 DahHnR9eTzSnCTEFM2rCNpAdd3dZrnUaUr5RRvBfNLHofqxdo7luicbx2SNGKGjtXICz
 XXypZXjHSX+mAaoLhpdLTgj7sI/zmYKb71UUjegQ1grR6OkwzIZmZxiK0z0Q0gr9n9vO
 w7kA==
X-Gm-Message-State: AOJu0Yz0vSViSI/ftaKGsEjUojufOjKJwzXKxd41L6/jWmlnp1w8mXM1
 ilrpF7MJFMdPUleB8t4PBNrW+44C2tk5ifUBo/TLngvpwYsXdkMq3nFsk6l2/+ch9VY=
X-Gm-Gg: ASbGncsia/Km5e2MXYAk/R4Z82b+cG1OyMBtw4Vfx6PeGs2QcEDSyEjPPKgYBrLmT2E
 oM09BtniUmaceuXSj6PDIb8p7ePYdtlHtPafMNyPvMJoZDgv89DaPeGPFusSXz78DkR5oE8lYoP
 CUJRnrYl+0JLX06v5GblTmxyQXJ8hF2iI1ezjdF/D1rcsUHFOE1zOMoGacjzFIf5jby0BqyHem0
 gEApqO4yCweVs2Dl42Ege98oEMF6IgvFQJAmNxLUPqRcBnxwYBCcGoXhxZg3m1Syq3CFJsnRfej
 NYtjuHEgDJ7TuPwvlaBX75NCTYpgivoHk+4RR/ND6VGBoWKpv4AUtbawtbUwMSpHbSAcguGtQvW
 LuazI27dATEQsY2tHpgEJyYYuvP/nmIs6ocZj94/sRCcx6qqPHcWJDogxfHgXokI+SN5WAZ1F0D
 XyNJvDGc+wpXVtXA6czyQeAoL4/CFbQloCayYAkUwlIX47nyCqRw==
X-Google-Smtp-Source: AGHT+IFRpC+8ambebSDKNV9WNTn/BumXgcNN+H9uTBlBhKvJoLLWGF7+0trKkVok/NFuhcMqjqNlwA==
X-Received: by 2002:a05:6870:2253:b0:3e8:3382:aaed with SMTP id
 586e51a60fabf-3ec9a34ac29mr1715088fac.12.1763656044180; 
 Thu, 20 Nov 2025 08:27:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dce7853sm1324407fac.20.2025.11.20.08.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:27:23 -0800 (PST)
Date: Thu, 20 Nov 2025 10:27:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 3/4] Gitlab: sage: Add Pine64+ platform
Message-ID: <20251120162721.GN2125796@bill-the-cat>
References: <20251118210015.624758-1-trini@konsulko.com>
 <20251118210015.624758-3-trini@konsulko.com>
 <2b123aec-d0bf-4cf8-9f4d-32ca2865d6ab@linaro.org>
 <20251120160619.GJ2125796@bill-the-cat>
 <b4ee3be5-fb26-4581-8f4b-be8938c683f9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RdPx7G0Q3VKDFJWp"
Content-Disposition: inline
In-Reply-To: <b4ee3be5-fb26-4581-8f4b-be8938c683f9@linaro.org>
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


--RdPx7G0Q3VKDFJWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 05:22:30PM +0100, Jerome Forissier wrote:
>=20
>=20
> On 11/20/25 17:06, Tom Rini wrote:
> > On Thu, Nov 20, 2025 at 04:51:46PM +0100, Jerome Forissier wrote:
> >> Hi Tom,
> >>
> >> On 11/18/25 22:00, Tom Rini wrote:
> >>> This adds the Pine64+ platform to the sage lab, for both legacy and l=
wIP
> >>> networking stacks. In order to build this platform we need to copy
> >>> certain files that were built in the container to /tmp and then set
> >>> BINMAN_INDIRS to /tmp in order to find them when building.
> >>>
> >>> For now, we disable the test_net_pxe_boot_config test on lwIP as it
> >>> leads to a crash that needs to be investigated.
> >>>
> >>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>> ---
> >>> Cc: Andre Przywara <andre.przywara@arm.com>
> >>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> >>>
> >>> Andre, Jerome, how would you like to handle looking in to this issue?
> >>> https://source.denx.de/u-boot/u-boot/-/jobs/1303375#L2235 shows the
> >>> crash and I don't have enough sunxi targets to know if this is more
> >>> broadly breakable or not. But it doesn't happen on lwIP + Pi for
> >>> example, nor lwIP + Hummingboard (mx6cuboxi defconfig). I can't at th=
is
> >>> point give remote access to the lab directly, but I can help come up
> >>> with a gitlab job that'll acquire the board, build and try and boot
> >>> whatever you have.
> >>
> >> Well the crash dump doesn't tell much on its own, except that we have
> >> an invalid read at address 0x17. But we do have the ELR so it would be
> >> helpful to have the u-boot.elf file. Could it be made available as a j=
ob
> >> artifact, especially in case of failure (or always)?
> >=20
> > We do not have a literal 'u-boot.elf' in this case, but we do have the
> > full u-boot file gdb can read for example, would that help?
>=20
> Let me check...
>=20
> $ make pine64_plus_defconfig
> [...]
> $ make -j$(nproc) CROSS_COMPILE=3D"ccache aarch64-linux-gnu-"
> [...]
> $ file u-boot
> u-boot: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statica=
lly linked, with debug_info, not stripped
>=20
> So yes, it would definitely help locate the instruction causing the crash.
> What would be even better is if we could enable a stack dump on exception,
> but is that available in U-Boot?

We have something I believe, yes. However, this particular platform is
fairly constrained, I can't enable as much additional testing as I
usually do as SPL chokes on memory and I haven't dug at the memory map
enough to see if SPL can have more space.

> > Given that
> > we expire artifacts after a week, this is probably OK, or maybe a
> > commented out section for "To debug things, add ..." if I don't see how
> > to only save it on failures (there are options to do specific actions on
> > failures, but, need to look in to it).
>=20
> Yeah. Whatever allows to have an image file when we need to troubleshoot a
> crash would be great.

Will do. I'll point you off-list to an updated failure job to see if
it's got everything you'd like.

--=20
Tom

--RdPx7G0Q3VKDFJWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR9BaQAKCRAr4qD1Cr/k
CnuKAQDmleZbI7uIE0Hg5VIg/a/ptI4kgO5+32Z0p4rNZ6CkbgD7BykQFZbozaxX
pIhfJZlijUsRKmJxK03OR0osW+XmtAo=
=bRcv
-----END PGP SIGNATURE-----

--RdPx7G0Q3VKDFJWp--
