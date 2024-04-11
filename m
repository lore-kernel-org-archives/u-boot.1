Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F006C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E53881D7;
	Fri, 12 Apr 2024 00:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MD5tNntQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EE0881EA; Fri, 12 Apr 2024 00:07:49 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3683881A8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ea1f98f3b9so183119a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712873266; x=1713478066; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qae2j2Mi4TIWqgRHJAElYvrxAJ2Bi/VlrlnrQ5nKx2M=;
 b=MD5tNntQnQimGjuCwBrVrNue5sx05kduw+Ru+5DQIKI061z+LRfhX7NEHZ+hv7gNLS
 IZcEYkyhkT/ogITYST7hIFyFw0dzVCK4HqWAna/ZQuLN5vb84/CNeHEgVfKwCvjnZLph
 86iHDMvNfPYoh+ckVAwaKGIaAPHweSsoLAPxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712873266; x=1713478066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qae2j2Mi4TIWqgRHJAElYvrxAJ2Bi/VlrlnrQ5nKx2M=;
 b=GWfvbwIQavNRSxWoB7v/KhCCNxDh8xV1r/MtdhUe06D5MB6mEXgJkYbp758YmjgvjH
 0vIjH4sug8Fgw4BHnQ9ZuGjlBb2/b2ZLNHrnbtthoaCH3LB9cWX4kr6K3zJot/g6IrUn
 qY+rsUh7xGVSRDftA/Bm1Vju9C0ZXT5uRIY7+3TcUrfHfZBral24nljBWmO4bBMupHxz
 I79UFB1OtJT4L/fUdyPIlw2WeAtSBUgbAWZajYb1U12B0uYe3oxyPymo7bzHwAE6ptOF
 DQEcnoJGAn0R4MJaX2KO9gXl1wHumCrbgOrWbkhBp9p9BXVf9MZafIdMJsvAguLr75aa
 mJcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNroOPEnMzlaWaZKx/7DjnkT1WDsYX/nj2OIyat4DHPmZPm/45b58Cpm/oYdCQmR3FZGedSdGE64/En/xUzS50/IvH6A==
X-Gm-Message-State: AOJu0YyHn7HNL79NAalO1s+XO80fxcBXdxnum680WiZoCQH3ic1gd5gc
 vaTa5ubBz6gSRG7fjGa8KhRirNmDMjSz5oH4yYVnRC7GEjtKa3c9U2wyDJfcpwU=
X-Google-Smtp-Source: AGHT+IEWvAsc70Bdw0bG4v4xPqO+e87Y2fjkBmL+HZZKzraOIwZ7OIqofa4vZ6XpN+Gn2L6iL5UVoQ==
X-Received: by 2002:a05:6830:1698:b0:6ea:13ae:73a2 with SMTP id
 k24-20020a056830169800b006ea13ae73a2mr1007122otr.11.1712873265674; 
 Thu, 11 Apr 2024 15:07:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 f10-20020a05620a15aa00b0078d76c1178esm1552907qkk.119.2024.04.11.15.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:07:45 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:07:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, sjg@chromium.org,
 marex@denx.de, nm@ti.com, afd@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de, dannenberg@ti.com, srk@ti.com
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240411220741.GJ2493117@bill-the-cat>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s8Q0kpBCjRAm5LVQ"
Content-Disposition: inline
In-Reply-To: <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
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


--s8Q0kpBCjRAm5LVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrote:
>=20
>=20
> On 22/01/24 10:11, Siddharth Vadapalli wrote:
> >=20
> >=20
> > On 20/01/24 22:11, Tom Rini wrote:
> > > On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wrote:
> > > > Hello Tom,
> > > >=20
> > > > On 12/01/24 18:56, Tom Rini wrote:
> >=20
> > ...
> >=20
> > > > > The list of conditionals in common/spl/spl.c::board_init_r() shou=
ld be
> > > > > updated and probably use SPL_NET as the option to check for.
> > > >=20
> > > > Thank you for reviewing the patch and pointing this out. I wasn't a=
ware of it. I
> > > > assume that you are referring to the following change:
> > > >=20
> > > >          if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HA=
NDOFF) ||
> > > > -           IS_ENABLED(CONFIG_SPL_ATF))
> > > > +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET=
))
> > > >                  dram_init_banksize();
> > > >=20
> > > > I shall replace the current patch with the above change in the v2 s=
eries. Since
> > > > this is in the common section, is there a generic reason I could pr=
ovide in the
> > > > commit message rather than the existing commit message which seems =
to be board
> > > > specific? Also, I hope that the above change will not cause regress=
ions for
> > > > other non-TI devices. Please let me know.
> > >=20
> > > Yes, that's the area, and just note that networking also requires the
> > > DDR to be initialized.
> > >=20
> >=20
> > Thank you for confirming and providing your suggestion for the contents=
 of the
> > commit message.
> >=20
> Following Tom's Suggestion of adding CONFIG_SPL_NET in common/spl/spl.c
> "dram_init_banksize()", the issue of fetching a file at SPL stage seemed
> to be fixed. However the commit "ba20b2443c29", which sets gd->ram_top
> for the very first time in "spl_enable_cache()" results in
> "arch_lmb_reserve()" function reserving memory region from Stack pointer
> at "0x81FFB820" to gd->ram_top pointing to "0x100000000". Previously
> when gd->ram_top was zero "arch_lmb_reserve()" was noop. Now using TFTP
> to fetch U-Boot image at SPL stage results in "tftp_init_load_addr()"
> function call that invokes "arch_lmb_reserve()" function, which reserves
> entire memory starting from Stack Pointer to gd->ram_top leaving no
> space to load U-Boot image via TFTP since TFTP loads files at pre
> configured memory address at "0x82000000".
>=20
> As a workaround for this issue, one solution we can propose is to
> disable the checks "lmb_get_free_size()" at SPL and U-Boot stage. For
> that we can define a new config option for LMB reserve checks as
> "SPL_LMB". This config will be enable by default for the backword
> compatibility and disable for our use case at SPL and U-Boot stage.

The problem here is that we need LMB for booting an OS, which is
something we'll want in SPL in non-cortex-R cases too, which means this
platform, so that's a no-go. I think you need to dig harder and see if
you can correct the logic somewhere so that we don't over reserve?

--=20
Tom

--s8Q0kpBCjRAm5LVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYYXyoACgkQFHw5/5Y0
tyyi0AwAh7DYPdt9c96jr7/X9xGvI7BI+8wtVm7UTDoFwcAxP9b2dZK+iEkjZygM
0RpjByJZRjcIZ5ddt6e86xqG4ak6hjhTDc5G4L+AinoZSqfrCJqWUrcfK/2Li2t5
kp5rF3nmWUJovSQs6zBn81rbpHMZIhELluO9X61Ug/bllheU4OCK2+JM1uwCMGWw
uE42JzJB/OW0hKzhxmpfOecoY70CxIC1Yxq7PPIind+ueXj/nVW8eabjzFU3jchu
rIhZ0MFIHTYMLHhxPfMgARG7xRnI1+GPY/vD2u/R4OCt7Rj3P+Zog7UVB3bxIUB0
+Udjyjwh82fKqdyRwDjS3n4hqKAuM1SBqdABHSkr/htoerz46L6ZEQhPyNwCmkxr
s9tffzwhKOq90F/bp1z9iEIUqFjQqeW+YBmBBnSONCyR7GXP9+qTV4z8T/Xed64H
LjVjDzxY5o9zpcijcTnonBkQ+BeMNB8nP9GFf1KAIwnqu7DCoj5ggXDxOQ/yvEfI
Ykk01KIz
=j78w
-----END PGP SIGNATURE-----

--s8Q0kpBCjRAm5LVQ--
