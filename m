Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3DAFD877B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D628432E;
	Tue, 17 Mar 2026 15:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BkFO85kA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D3084333; Tue, 17 Mar 2026 15:06:28 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB268421C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-464ba2bb3aeso583920b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773756384; x=1774361184; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QpyqL9sYsZf1CiprK9irO6c+LLvF/4kM7R2MtezwGtk=;
 b=BkFO85kAXaFHqKsIvgP0a2oTpDaqvqjKvB08ipLN0MO86+pMUjnZi3N/LAMx0jWGnF
 6VzWDnpLM2AEbp1ed4As0UW16g8FzRQgxxiTrU8Vk1pcWyx95AKmZDqlpZLYjsxSeSyD
 CrTsyjFSCWxakY3rkjHxUovESHg4K/ih5XK10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756384; x=1774361184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpyqL9sYsZf1CiprK9irO6c+LLvF/4kM7R2MtezwGtk=;
 b=tITrvKyt3mIQ3lknuJR1nO55u2ZdSZ7PTdF6A1dCnHjAXARny7ctwK1FjlOZPjP0r/
 1cx6BJ6eYHHpGP7Ch4nRf58GcPnyB0K/98AaL/2FRWYbUYVDbjoWNehM7s/7P1WRhlpg
 V+iXQJCLZNAKq/Rxdv/kL/syAi1IBXwhjCnyuKHq+q5QhN9PDbnNl8FP0W23p8sOEFJx
 SNyWS97eTT6g41yDlxtqn7rbqUgsja2xdDUM1rkkVBIu8vkGPG91Uf3JIP/Icpm4W0ph
 V+turuPTJJ8ntTmX0zve+TNGBzd+aMKvWGdpOTKe/I2bMUCppTgfhoTLefyzkjqRbY8j
 f0bw==
X-Gm-Message-State: AOJu0YyXpMlKnQ5oTIJovFVNyZE6OnYjJ4wR/f54CYt2r8uhB4kZPlqd
 xpKQ2fgGNATQBEfQ1Mi1sURo0OALoDV8oyt6Y+xFU9vEF8y/SjtBbyIuDp0NIGi+In8=
X-Gm-Gg: ATEYQzyzLh3+3XCPjnfNPdbPs0tsJ9H43WmaV8mKS6qOsGNFds7AjvAsMNaOdlXA6zE
 rMFPPrgtiBicwrVmU99Qb5IRwc8DPgc8m07vnSPB0q3VLK0feCD1OtIxT3REJLS7mV6BScmLraX
 q1ob1piW0dBSHvFdjy37Hbb27H82ty13aBdxrSpx1119ip8Z05azgQF2gggcXfhjaUAMeB1LIW+
 hpOoXEMRLxtYCqGOUS7YVafnN8zMPYa6FsBs8UPutCt6enB9Ka1Jh/dH0HXC65YY5kPZ/akX0Yf
 xneZLx59hE1yaY3JuDnXCDSeSk2Oizy/GjM80GsreGvUlAwmR789I06mkmUtDmKwngvRJmqViOp
 Hf71Gkk4To8GAp1tjrIwQFI2X2aMlA+b4ipDJw4QeTtE6lXGpxu540G7MwLfp6zvelZkoOfs/F8
 8VFNe9dfwoniwECWxteI8dXVM/o24V1rqQDRtRlU7XoO9A0F8NmIN5chf7xdhj67apKAtyHJBdw
 P2Ivj0OPYKPGv0D2MRSibeYfPNfVufHpbxEQgiSiGCSKm06
X-Received: by 2002:a05:6808:2389:b0:45a:6adf:4d44 with SMTP id
 5614622812f47-467a7f63c8dmr2053885b6e.12.1773756384509; 
 Tue, 17 Mar 2026 07:06:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6e82cdsm19933805fac.18.2026.03.17.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:06:23 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:06:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
Message-ID: <20260317140621.GX502704@bill-the-cat>
References: <20260317131839.2418655-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x74Y0chJkqlwL3fz"
Content-Disposition: inline
In-Reply-To: <20260317131839.2418655-1-sjg@chromium.org>
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


--x74Y0chJkqlwL3fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> Various updates:
> - c4 lack signing so does not currently build
> - samus hardware is non-functional
> - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> ---
> A sample run is here:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
>=20
> At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> broken on -next

Assuming "play" means beagleplay, it's working fine here. No link
because I'm still working on merging physical labs to be visible to CI
in a single job.

--=20
Tom

--x74Y0chJkqlwL3fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablf3QAKCRAr4qD1Cr/k
Cud5AQDUkv6g4arB3UyRl9+DGQcLclOPP0H96DuDWjfn377xsQD/fvH4gg7U6VbC
X5fytC5tR+6OZTvhQbdq5pS3TNSMMwY=
=oUyV
-----END PGP SIGNATURE-----

--x74Y0chJkqlwL3fz--
