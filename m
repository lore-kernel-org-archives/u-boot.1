Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13D4D6D22A
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 14:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D0F83DEE;
	Thu, 18 Dec 2025 15:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DN1O77Mm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC1283E0E; Thu, 18 Dec 2025 15:58:23 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F1983DE4
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45392215f74so317063b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766069885; x=1766674685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wvEqpKH2rcu1c9eErxjkzOza72SgXAzjkxaZkVdv/Ms=;
 b=DN1O77MmPbaqRyEY53K79lYZrIxNENKbsAkbjUWlSACrwPYm1xH16pvM2vnOPsCNHf
 Rz2M3KzYkHvnvVs8RdRm/WWpx6Nj4g9zDK7vyByCploUQqBr3e6j/Y61JpmBhnsxMaPd
 KJfAE4+wwtO5LUjMCdAoPJdAsyVMz7aJ61kUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766069885; x=1766674685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvEqpKH2rcu1c9eErxjkzOza72SgXAzjkxaZkVdv/Ms=;
 b=ThvTzkCu3+6psW9X14paT9qUXw9TpSb+QwXUQCZRP5v7vG+b5r6YaestQ6UUEKoZFl
 zXgeqjezaS+AGoA3NJheglql3Jdg+5NyGjZQgPCu1KvBdoRgQnN/Bwa+Bdus1x1cfpII
 oJk9gvb2ujdNiIRmZ7BxC6ElXFfSkuuP6kqMqfXtZZNouUvVE9yhrX8fAeBOfnMKODIY
 vM9Pa3gipPx6/W76zJ1jd/3NFl3mN4czncweNP2Gpem+tAmVP5Qo3tXblqOn3TCi6G8x
 dGtv8caIynxhojGvk5h5vd/OD1gXdcZJh/vmKm6vjoRUPI+qZNK2tftVvQpBaZmuRhwl
 qJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXAgmSiR5QnkHaxQfOad8oqoQTaniExliZpeOBgU3ThjVxR8LssI+i0picGYB1a4Zh+U1V7Zo=@lists.denx.de
X-Gm-Message-State: AOJu0YxEWA6OvXlawtemXi0s/OY3PkrDr9uQ/FEhUjGixH8NfXvv4CVL
 rdzN53Z/vUOEWW05qlysM4ZGbKDnUjtZXsEunb6fc/f8F7lkBGRj7cwGJyxt9NDgTNw=
X-Gm-Gg: AY/fxX6y8j7A7KGuegrwcHWt7vkiKYIqdVQUwXZKWAme2Gll3LPHxoOU4yRCOaKGsdz
 ZNLEuP72HMrx4nwfktB52d+61cDfRFHMbPpgLTvPmlbsIlcCy74motcea6biUR10SCwQGmiiiuv
 WHmyk9jo1dHxo6JyIPygX40W7qcHsbe6jxof8xTkJSHccIry8iI9a7yA1HeTnQiE2UDUv9YlpwR
 mZ8VfgtUnL0BVElKFWipR1v0453kE+oDQE3ZVLVr46D0tTX8kwcrHwgBxdt2QM9jHjCpUBUfzcT
 gRzPMipVpv04ejkvfwUerrBHCKrJCXyK2KsJIyWhoerGJHDr9vpLYUpl0XCeLgxTGYZ/yZijjvU
 JdZsL67PeKwvkmyEilMsnsqIsumgvg9aWSvtK6bpAEAD/+/Z14iPG6cwRMXOY/T/wmy+OTbi+Y+
 Z5VT3NsM22rT4MqAmuLmz4pg6RJAY0UmlE8vRo2iZz3y171pwqhQ==
X-Google-Smtp-Source: AGHT+IF+O3kFpjtePED8olcO9PbYT8ERyQp0huNpVa1aXyGUlMXvY19tg6MDnrdx7MmeF+RGBg32AA==
X-Received: by 2002:a05:6808:f90:b0:44e:c106:8192 with SMTP id
 5614622812f47-455ac7de007mr9901593b6e.11.1766069884577; 
 Thu, 18 Dec 2025 06:58:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457a42f7eb3sm1354730b6e.4.2025.12.18.06.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 06:58:03 -0800 (PST)
Date: Thu, 18 Dec 2025 08:58:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Judith Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
Message-ID: <20251218145801.GJ303283@bill-the-cat>
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
 <DEZHV1ELFZ43.E3FN619R0UNY@ti.com>
 <20251216140104.GU303283@bill-the-cat>
 <DF08W9D84X84.1DQ1VM5S8TT9D@ti.com>
 <20251218141653.GI303283@bill-the-cat>
 <210ecc7f-4de4-40e8-8c15-5a6231df48a4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3UfaZ+8GnZF8v8ec"
Content-Disposition: inline
In-Reply-To: <210ecc7f-4de4-40e8-8c15-5a6231df48a4@ti.com>
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


--3UfaZ+8GnZF8v8ec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 08:41:57AM -0600, Andrew Davis wrote:
> On 12/18/25 8:16 AM, Tom Rini wrote:
> > On Wed, Dec 17, 2025 at 11:03:43AM +0530, Anshul Dalal wrote:
> > > On Tue Dec 16, 2025 at 7:31 PM IST, Tom Rini wrote:
> > > > On Tue, Dec 16, 2025 at 01:52:37PM +0530, Anshul Dalal wrote:
> > > > > Hi all,
> > > > >=20
> > > > > Any updates on this patch? If possible could we pull this fix into
> > > > > master as well for the 2026.01 release?
> > > >=20
> > > > I thought the feedback was that this was a generic problem and so t=
he
> > > > Kconfig logic should be universal, or there was an incorrectly /
> > > > sub-optimally handled case in the tiny printf code, that needs fixi=
ng.
> > >=20
> > > We have a few ways to go about fixing this:
> > >=20
> > > 1. Fix the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> > >     with an extra Kconfig"):
> > >=20
> > >     Pointer formatting used to fall back to %x handling before the
> > >     commit. Though going by the commit description, it looks like the
> > >     change was intended. So, I'm unsure if we should re-introduce the
> > >     confusing handling back where %p is handled but not %pa or %pap.
> > >=20
> > > 2. Add SPL_USE_TINY_PRINTF_POINTER_SUPPORT per defconfig:
> > >=20
> > >     This was what v2 of the series were attempting to do but as Andrew
> > >     pointed out, there might be other platforms with similar issues a=
nd
> > >     it would be better to fix it for K3 overall.
> > >=20
> > > 3. Change usage of %p in k3_sysfw_dfu_download to %x:
> > >=20
> > >     This is a suitable fix imo but we might still have to fix similar
> > >     usages of %p in other places. We'd also have to be more careful w=
hen
> > >     bringing proper U-Boot code to SPL since %p would not work the sa=
me
> > >     way.
> > >=20
>=20
> For what it's worth my preference would be this one. We should just work
> to avoid using %p in general outside of debug statements.

I'm also fine with that.

> > > 4. Unconditionally select SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3:
> > >=20
> > >     This allows us to remedy the problems with above 3 solutions with
> > >     very little overhead to the SPL size (<100 bytes).
> > >=20
>=20
> How about unconditionally select this for all platforms? If it is only
> saving 100 bytes it shouldn't be an issue for most, then platforms that
> have verified they do not need it (or need to save every last byte) can
> then disable it. Seems odd to make a change like "1e24e84db41a" and not
> have the default be the existing behavior.

There's just lots of platforms that can't afford much growth.

> > > If this problem is faced by non K3 platforms as well, perhaps it might
> > > be better to take the hit and make SPL_USE_TINY_PRINTF_POINTER_SUPPORT
> > > default y.
> >=20
> > Ah, so now I understand the problem, with point 3. So yes, I think the
> > right fix is to add "select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if
> > SPL_USE_TINY_PRINTF && DFU && CPU_V7R" under the ARCH_K3 symbol.
> >=20
>=20
> Just the length and specificity of that conditional string is making
> me think that is not the right solution. What happens when we find
> the same issue for SPL DFU on ARM64, or in some other code not
> related to DFU, etc..

Part of the answer is that since we should be printing "?" now instead
of the wrong value, it should be easier to spot the wrong code. Perhaps
we also need something in doc/develop/spl.rst to talk about it (we
default to a tiny subset printf, some things don't work without
additional options, avoid %p unless you must and then enable
SPL_USE...)?

--=20
Tom

--3UfaZ+8GnZF8v8ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUQWdgAKCRAr4qD1Cr/k
ChMNAQCbWuewCLKAtNk+sOS5ReDheqaCw5Usg//9euBNB4lMRQD9GgKvm0k3opkb
8PIEItLhssELw1LctJf6Fvls8Btn7AM=
=IgB9
-----END PGP SIGNATURE-----

--3UfaZ+8GnZF8v8ec--
