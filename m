Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B20C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CDB8881AC;
	Tue, 16 Apr 2024 02:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q8Ba/gbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6160488191; Tue, 16 Apr 2024 02:36:26 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A4E88190
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78ebc7e1586so494379885a.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713227783; x=1713832583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=USKN2pGFkDP20YIROQZ5FYJcSA8Ij3EdEzwpfwvE09c=;
 b=Q8Ba/gbN/eACq/5X1dhpzQXaUPusNBLwfXCO1VZyUC23S8zTzXQsUsjX7rN42k00Ot
 25naMFXq0ESLxK6H3SmLwKd5JPN5KHXLKeWSdpTWC4NtGUy+auvtKyfh9rQq57oOJIIs
 OyQ5g4jWEGOertwUc7nohGcgGFyr59YpI2bi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227783; x=1713832583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USKN2pGFkDP20YIROQZ5FYJcSA8Ij3EdEzwpfwvE09c=;
 b=l6RJtJS1D4fO0XeU0eoWUGln5/6UOdKfjCBYbgvkYk5crNm/P7t41nuz99NYfIwoxh
 1t1TA0wIsrTIiWOzrGTtLs3c8MjVc5Me0tWTZ0Ntfvw3Z7swRNhtDK2I9Wv4mdX9IMRg
 uUomfzSOTwC7ffJNM1N0P7TKlwF7DZpABSxRFlx668U1TYGJ1wv7vKmJ/vXAnBNcg77/
 KtpM86lLM9wz3ITOsz9R0YUtwk4C41dO+KOGXNbixr4blp7fgoov7UEYidk6yZV+KV/f
 02yQNcgV8VVkRaeGNwe7gtMXg4tJ3FMpwGkNzoXSOAgXqbA4zUuBG63lpiW4Ob8pboq4
 +/hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrjcy8c1Bk7iEK1eRRU3JBVL9AAFSF57dWuDqVTpY40g2768EIMl3kAG3Q8N8RfoQgwHchUGFBVPdzinB7NFtOLZyL4A==
X-Gm-Message-State: AOJu0YwNQxfC1IvfE13IvcRmNO1x8EMvJXPR2wqg1xAAbNyBu3c6IwB8
 zD3FndUhnVejF5UKlgH4XdrRnoN0fGWaDaz3BFxd8B+q4oB9F174ZbO0Kft5QPU=
X-Google-Smtp-Source: AGHT+IEXVCQHH5O/XM2/o3Qiz9JWDRqRIPL+O4VbkQ5D2YowAIWqBEI6kTwLZlpmiW+45wnGZZkq3w==
X-Received: by 2002:a05:620a:22f5:b0:78b:cc54:68e with SMTP id
 p21-20020a05620a22f500b0078bcc54068emr808665qki.35.1713227783075; 
 Mon, 15 Apr 2024 17:36:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05620a15a900b0078d6b42ca02sm7031732qkk.120.2024.04.15.17.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:36:22 -0700 (PDT)
Date: Tue, 16 Apr 2024 02:36:19 +0200
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
Message-ID: <20240416003619.GK1054907@bill-the-cat>
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
 <3df9f51d-d37b-41da-94a1-f05936ebd0d6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ECXV8zH+JBWxwlU"
Content-Disposition: inline
In-Reply-To: <3df9f51d-d37b-41da-94a1-f05936ebd0d6@amd.com>
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


--+ECXV8zH+JBWxwlU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 02:49:13PM +0200, Michal Simek wrote:
>=20
>=20
> On 4/15/24 14:22, Heinrich Schuchardt wrote:
> > On 15.04.24 13:35, Michal Simek wrote:
> > > Some of Kconfigs are using utf-8 encoding because of used chars. Conv=
ert
> > > all of them to ascii enconging.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > > There are other files which are using utf-8 enconding and pretty much=
 I
> > > think we should convert all of them because there is no reason to use=
 utf-8
> > > encoding.
> >=20
> > Hello Michal,
> >=20
> > The commit message does not explain why we should refrain from using UT=
F-8.
>=20
> that's a good point. I was thinking about the reason for it and pretty mu=
ch
> wanted to get feedback from Tom about it.
>=20
> In doc/develop/sending_patches.rst is said that patches should be sent as
> plain text but encoding is not specified. Traditionally this was ASCII an=
d I
> pretty much don't see the reason to use UTF encoding (even my name has
> special czech char which I am not using, the same is for Marek Vasut).

My point of view is that I think ASCII should be used in general, with
the exception being names (I won't force people to ASCII-ize their
names, modern systems handle UTF-8 just fine). I actually don't know if
we should also exclude rST doc files from this rule as well as UTF-8
should render fine and for example "=B0C" reads nicely in web/PDF/etc.

--=20
Tom

--+ECXV8zH+JBWxwlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYdyAMACgkQFHw5/5Y0
tyyT9Qv/WWSFXon8Ekzt1GB6SglQYnav34i1m1hEIeTWX7lWqdzV7QalT6Ifz0OZ
b6s/gfz+zCnpUkECkHLdVUDFH8tdvuUTuO8HUDML9iCtUVAVcE/u4mpR7eydDSHr
Udbe5Zf+lHmYRscapOrSa0BYxXnnd0Wdt4KnF2tkz0IItRXnJ4tPZcinuS3gRIOV
THQ3+u0vfDxPsvqhdp+4t7PhtXu5w01LfIWycsI2GfTGwOH3HgCxO2ZfxyMV8dQe
RYSNWE2gCipNSivpS0cmu/xDDz4iWNPoR4tdkH/aSG7uco1Ir0EpXOo7KuslEBtF
VDjo9wqfAplbxrroCfFoeEzKVLaQ7G0suiXczLo7FOR70Rt0rN1Ap2tsdCgAgBxP
eCgjoidvAGPRCvOrRHR4FpimqWutTRwvlNtAYEMy1FaFIbaUyBwbBL2A32Yu6PYx
tRF3vnOogkICIP1pl3j86aLSeVeP9K6atSZHrReBIfgUdvL4YFlHsDHlWatVYfAT
W4Im0zJe
=9JGK
-----END PGP SIGNATURE-----

--+ECXV8zH+JBWxwlU--
