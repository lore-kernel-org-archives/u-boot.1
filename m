Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4A5C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26BAB87D18;
	Sat, 20 Jan 2024 17:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ghzLeuQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E326F87D28; Sat, 20 Jan 2024 17:41:47 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C76879BD
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5f75aee31d2so16021807b3.2
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705768904; x=1706373704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wyVnn2spERN20gHZjLxuKaMgyzAnazvAj+HaaRDDCkM=;
 b=ghzLeuQfCPWlOwtNRB9tp3rLt5qY1uqbo7A1LtYqjkXqF4EpLQoUwL4/h7Feqx7hS2
 UDe8ZUEicQKDhl3iu4NFSEhY2Y7ndZQICFXySnsV9k32GlrFP2FvJvOObQu5e+LelQa4
 knxQhm78bUVb1mDJaB3Rnwrgvj0VIdspb83Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705768904; x=1706373704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyVnn2spERN20gHZjLxuKaMgyzAnazvAj+HaaRDDCkM=;
 b=ObkThfScqKyPl3N3DcJH5e1Gemk3fN0G66U4dG2M9jBaqg0dVfFhUXuHpiEThXghR9
 qgYatsAUYI76I/P1QjC1isRiA0aVyBmyAhU+dxq8n/lQ50s9gHGGkAU+c8o5b3UuiHQR
 0HD7eAt0jnUFUaBQ72X83TPREqa8oXwSMhAwyyCT8gFykiIrdvbYYkXnweS0R8giVo/5
 tr5puycUfbW9Wmee57QFoJZBcql52R7/5h3odMOoyj8N+tujzDPh1UcH58gveiwBruNU
 cjAzGozX87Rk2jG5Z3vgU4wB/svHem60S29+L2p2vmboUUHb6aaZ0MVvONtRUuLnzZPj
 DQxA==
X-Gm-Message-State: AOJu0YzFpy9pnTbC9TQjJ9ZLyoAtyDuYb5T7FKiR+H9gjrnqir/DC/uc
 tI2uSoC2zXx7Kk/qXKeOzfZL7axgXd0SxebcMZEGLg8zkd3I55GHEQqwiZXUZ/8=
X-Google-Smtp-Source: AGHT+IGMIyuNv8kztmY21Qv+zBcxGhz3mNSiHzSNZncjb6Uz7STzb8++yygzTemNqqp49dYFCbG5vQ==
X-Received: by 2002:a0d:ccc2:0:b0:5eb:1557:4881 with SMTP id
 o185-20020a0dccc2000000b005eb15574881mr1111581ywd.62.1705768904020; 
 Sat, 20 Jan 2024 08:41:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 x2-20020a817c02000000b005ffaa3ed258sm693167ywc.128.2024.01.20.08.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:41:43 -0800 (PST)
Date: Sat, 20 Jan 2024 11:41:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, sjg@chromium.org, afd@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de, dannenberg@ti.com, srk@ti.com
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240120164141.GA3652023@bill-the-cat>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Erq2PUKvufr0HbPX"
Content-Disposition: inline
In-Reply-To: <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
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


--Erq2PUKvufr0HbPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wrote:
> Hello Tom,
>=20
> On 12/01/24 18:56, Tom Rini wrote:
> > On Fri, Jan 12, 2024 at 12:17:50PM +0530, Siddharth Vadapalli wrote:
> >=20
> >> From: Kishon Vijay Abraham I <kishon@ti.com>
> >>
> >> Call dram_init_banksize() from spl_board_init() otherwise TFTP download
> >> fails with error "TFTP error: trying to overwrite reserved memory..."
> >> due to lmb_get_free_size() not able to find unreserved region due
> >> to lack of DRAM size info. Required to support Ethernet boot on AM62x.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> ---
> >>  board/ti/am62x/evm.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> >> index ad93908840..35f291d83a 100644
> >> --- a/board/ti/am62x/evm.c
> >> +++ b/board/ti/am62x/evm.c
> >> @@ -85,6 +85,9 @@ void spl_board_init(void)
> >>  	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BM=
P))
> >>  		splash_display();
> >> =20
> >> +	if (IS_ENABLED(CONFIG_SPL_ETH))
> >> +		/* Init DRAM size for R5/A53 SPL */
> >> +		dram_init_banksize();
> >=20
> > The list of conditionals in common/spl/spl.c::board_init_r() should be
> > updated and probably use SPL_NET as the option to check for.
>=20
> Thank you for reviewing the patch and pointing this out. I wasn't aware o=
f it. I
> assume that you are referring to the following change:
>=20
>         if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) =
||
> -           IS_ENABLED(CONFIG_SPL_ATF))
> +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
>                 dram_init_banksize();
>=20
> I shall replace the current patch with the above change in the v2 series.=
 Since
> this is in the common section, is there a generic reason I could provide =
in the
> commit message rather than the existing commit message which seems to be =
board
> specific? Also, I hope that the above change will not cause regressions f=
or
> other non-TI devices. Please let me know.

Yes, that's the area, and just note that networking also requires the
DDR to be initialized.

--=20
Tom

--Erq2PUKvufr0HbPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWr98UACgkQFHw5/5Y0
tyyHfQv/WtG+mwQ9Z2y06b2FfSLSreHHPeD31OdUuwbEOmv5u546z+yNRcwzcXfd
rJx48X+pWoi3GobS26aTz+K4F54ySyBHhc6R7ff0zOjHC7fNqYc77Y2AHejMMQjv
kOjpL9jXYBbmAQXaLcNP6T+NzMgJTJtK90xyyuSuls/8lsbgsGJATUKcpLrg0jGB
FNUON+sxCbuEcxXApFXXSLXxDSU9CpFoNoEUQ58rAIaEQfh1T/9LOu4Kcf1sLGlp
ssX3CA1vvWxcHu05X9Zp4so/SlZ0o0XfLOuqd9Aw6bHzNt+lElh/owLV2KqfLq0Q
pjpSBFQxYDk3dAYHMEzUEi4YD1S33V1NMPREBVf9CMAQLzD79/MmY6lwv6xdEo5C
FzW8f5pLEfD0kbkt3WzphVArHoR+j4lc6n27cvNWkTXcsZkcCUfT6i1YipCZotig
0slBvLj+c3E/0dO9hzVcK1obVw4gTcsj3T0qy6gLSSJZl7ZBkksBlUPRZpzZG8L7
KASvaR0m
=K3R3
-----END PGP SIGNATURE-----

--Erq2PUKvufr0HbPX--
