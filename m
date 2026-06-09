Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC437CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 15:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0649984704;
	Tue,  9 Jun 2026 17:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mX/MGKEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2559184869; Tue,  9 Jun 2026 17:04:38 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEBF8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 17:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69de16f5f79so2299979eaf.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781017474; x=1781622274; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6kiqkfZA9zP4xqWInpcyRt+aNwGRRWTOeMl+QV6KMDQ=;
 b=mX/MGKElb8KLZpbyhQFmehxI70iAZqHaRCw7TWsV+8cmwEtiIRkrBaX3HR4P56eT+J
 BI+d7eK++dJHdzUoLqX1PnTmNnHU2QYhOE6oWPbZi0F04VDPtF4hDOjCSdfX7H+MHuex
 9b5+lslXzeLlot5yMZ54eeV/a0BgDDAxnJoeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017474; x=1781622274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kiqkfZA9zP4xqWInpcyRt+aNwGRRWTOeMl+QV6KMDQ=;
 b=aUx3NGAg3DY12fQ9rPujVNW4oGrQBNR3sXKHbmEz5zLMtU53b3fCStgBLR+pfCjUMm
 chvRV549+Ni1EIVqAAaw4pea6q+DvoccxYidAtAuwTQjx40hmXUZd9r4A90+Ag6CJE96
 /XO32I/uhG5C2XrS+FeWQe5hte6G2bgV6+MsxHpsqQcZJEaFJuicuJDdJdbq0dD8KG4S
 0nhSTSeQmZDBdFHXSdJpj8+lqrNV7dt1g8o54KRihC3yQBvsQ/KK8bwGPQSggzfEKJTA
 H8D0S4TXzevycYrBSfnzlcni3GgoYLV8XXKdkawywVU24aKTVjlKxjlWTlRBiPPwlFiU
 qYng==
X-Forwarded-Encrypted: i=1;
 AFNElJ95KkW0+5joeRonBPIS/IRyTdjaiwghNqC7/CE2uH+MPHpWZVQk9DbRjuASUyFOosKQxKDqZY0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyc3MiW49guWTO8V+YQfokEKeAdceMUyGAiePK16zUDBcNdM4xI
 X4kTotpVVtq38CvvcY5u+w6GYLl1XdZffEg28z0c7VNHApqduMqiRmHSN8xoZ3iP/Ps=
X-Gm-Gg: Acq92OEQa3YAhDPciDsC9TsmrT1AvaBUqcP+K8/3aFFoVipRHpvt/VdKtcRIYbGzzD5
 8OSng4JLtMNk2Nsh7xJuVRx060Ag06K+U/whYeUeHnOTu9kuDidZLa+g9rERqHc58ZO3laXtHia
 iL5nsNJ9/10CYZc0IXAz0tjpVSjzvSAKsMhrVhVSWHribuvTedllh5iScYl1/RbIP49N9lxG93Y
 DuG4yv92qTQJcdc5rFnYsL2D9upCHFs0sSVE1uNF+uL/+OLaTBJg9jDVlGYP7RmrWqxmI14yEhb
 IpkLek6X/44PxmrL2fcKEXZgDrRF0cPzW9XdQsqTY0eiKOhVLXbxPZwXOiSuLEqwm5UQx+u9YEA
 Gi/5W0GzbueTHBM/ZT78dnk/d9Zj6mwU5OHm17X7DWFTFCqH9ayuJrrbA+BeVLuXUqIu/NCXK4e
 3Jc1vyTtXSQfGb/FHUxWUt2ehyKIBlIZMQG1zOw7119ZiVn4dVIOLJ3V9gnlkcyiVUHrJoUjMUI
 INvZPNaxhMK/CuXOXEIFPdZuQ05rFcrVgsERfK9b7JTPjCch6Bk+EkvRePBiocHXyvu/Erv
X-Received: by 2002:a05:6820:2012:b0:69e:3dde:869d with SMTP id
 006d021491bc7-69e68b954e9mr11392117eaf.23.1781017473765; 
 Tue, 09 Jun 2026 08:04:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e462413fesm11891559eaf.6.2026.06.09.08.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:04:33 -0700 (PDT)
Date: Tue, 9 Jun 2026 09:04:29 -0600
From: Tom Rini <trini@konsulko.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
Message-ID: <20260609150429.GT382693@bill-the-cat>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
 <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
 <20260604230951.GX627328@bill-the-cat>
 <465fc13b-28a8-4ac5-90c1-e10c0a342a7d@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mbKUuyeS2oNgMabY"
Content-Disposition: inline
In-Reply-To: <465fc13b-28a8-4ac5-90c1-e10c0a342a7d@kernel.org>
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


--mbKUuyeS2oNgMabY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 04:23:36PM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 05/06/2026 =E0 01:09, Tom Rini a =E9crit=A0:
> > On Fri, Jun 05, 2026 at 12:31:10AM +0200, Marek Vasut wrote:
> > > On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
> > > > Currently, the bi_dram[] information is stored in the board info
> > > > structure (bd). Because bd is only valid after reserve_board(),
> > > > dram_init_banksize() must be called late in the initialization proc=
ess.
> > > > This limitation is problematic, as it forces us to rely on a variet=
y of
> > > > bespoke functions to determine board RAM, bank memory sizes, and ot=
her
> > > > early setup requirements.
> > > >=20
> > > > By moving bi_dram[] into the global data (gd), we can run it earlie=
r.
> > > > This is particularly convenient since boards define their own
> > > > dram_init_banksize() routines, which do not always rely on parsing
> > > > Device Tree (DT) memory nodes.
> > > >=20
> > > > Additionally, U-Boot defaults to relocating to the top of the first=
 memory
> > > > bank. While boards currently use custom functions to override this
> > > > behavior, having the DRAM bank information available earlier in gd =
makes
> > > > relocating to a different bank trivial and standardizes the process.
> > > Regarding the BD, this is likely really old, but it seems BD might be=
 passed
> > > from U-Boot to Linux somehow ? See [1] and U-Boot
> > > include/asm-generic/u-boot.h :
> > >=20
> > >   8  * NOTE: This header file defines an interface to U-Boot. Includi=
ng
> > >   9  * this (unmodified) header file in another file is considered no=
rmal
> > > 10  * use of U-Boot, and does *not* fall under the heading of "derived
> > > 11  * work".
> > >=20
> > > Are we certain we are not breaking ABI here ?
> > >=20
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/powerpc/boot/ppcboot.h
> >=20
> > I've added in Christophe as the maintainer of one of the active and in
> > some ways oldest (since MPC8xx is very old) PowerPC platforms we still
> > actively support. A tested-by on this series that also includes
> > verifying Linux still comes up would be much appreciated.
>=20
> Traveling at the moment. I will try to give it a go in a couple weeks.
>=20
> >=20
> > My suspicion is that anything DT-based shouldn't change here, and in
> > turn if you're doing modern U-Boot you're probably doing
> > not-extremely-ancient kernel and so DT based booting.
> >=20
>=20
> Linux receives a pointer to the device tree from U-boot, nothing else as =
far
> as I know.

Thanks. I strongly suspect everything in question applies to ancient
U-Boot and/or Kernel.

--=20
Tom

--mbKUuyeS2oNgMabY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaigrdwAKCRAr4qD1Cr/k
CnAgAQDT6KR8KzrvG6DKW9674IBC/9jKfB/NB/Kodkhub7k7nQEAyUh5nQWruE5C
YWHBOKMeMVGhgEh85cyhsvjINOk0/Aw=
=FYjo
-----END PGP SIGNATURE-----

--mbKUuyeS2oNgMabY--
