Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9788D65C5A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 15:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0138683B49;
	Wed, 17 Dec 2025 16:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rm4zAM4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E69D83B55; Wed, 17 Dec 2025 16:04:23 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7305783B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 16:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45358572a11so3490083b6e.3
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765983859; x=1766588659; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tugogqfgWGPc+rdAYvC1Lrspm4halsNiW2qkEuZ58kU=;
 b=Rm4zAM4r0VErDCk05aaGbG8oHcsIVa3sMrKTN7D7sqNjbFzGBA1OBwUzUXLURVBDsn
 bbU/BvULEyXYUExn0wu3czKWAwp2Efy2GUDYj6vGsHDO+/xKMRIZKwD9xG3F6GHEBoNC
 1VXMAzbVh/BzUFeF0vHsWUrT36CDvverXVvtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765983859; x=1766588659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tugogqfgWGPc+rdAYvC1Lrspm4halsNiW2qkEuZ58kU=;
 b=BczqkaDRNy7a9yixGNHqYRUN5DzNuNUsoXXAav/UTA4pyCSTnGIsLJIsEx9iaSIiBf
 sPUm9c6ayNGeor/eYl0bd1pzMHVh8gPz57AEQhVJ8dOetqLQbdXZNVds4NnZNGg/2PER
 bipOoPlOO/edDKa3pPeoeA10ZM8rJ4fC0bDg8t5GNFbyE6SIaJpKwxaYnW3UGwOEbDrx
 jPSwVwL5soKiRIjlKWN14FbpXUMJjcrxOxzUZ3fRbbe4D2tTz28t1h3mLBlWKZpzYwZc
 NPbuUggX0zo1BZax/wgKXIHS8bY/vk5/TjY6gQltbIcKTfTTFaBmQ3EGYQ0rXS5ji3kn
 cvdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt1kfJdkB2nxQU2fZqI7EWSEIhBBhzxaIFnbewvvkUpuk7g8PlxJviUxlYRj94apvWhx8JJwE=@lists.denx.de
X-Gm-Message-State: AOJu0YxAkDP3pOS6l/zT/TqPHn0ZC65k5ltOcpUAO24Wc3FHx2K1kUJg
 wEH4FJiex7iBsgQKHMAb/la4GJ+Zgz6JJsJWvnNlGZ5T+pSc3LG1CyVk/my447rASi8=
X-Gm-Gg: AY/fxX6ybSlDRXegAoA3ODgCPZvrbChPfktXf77blV5Icfd8XcW5NT3KaUS1siNd3CT
 jzArE22LXvTv03gvTRyEbb6u9Lk9vzWOgrJTzi7GBQ/LA3ad07iix/g37xKfslo3IDbVIQEbFSq
 LTL+K+bISUeoV9Vw/AIwX0L0lx16sTB91BkagxMdiDRPRyMJV79xEhS+9yqNrwAJOuGfgKqGcQ/
 m3Ad7sbUEa0dnz0Q/UoruabvkuI2iGxpNsD4vi/AOTPxNKNLXMeHF1G+zk/68Z//7r73+gTD5Ky
 SHNsAm6ggOO3Xtw9HmJiMx997XJm+PE0w72DBwq1oEJTrWRNjleqo3z779X1ftH6+8vzZdZ8Hzc
 KXKeCTzVMXSPAG6d/dFKPuEcgm8tPi/kKwYT+gzV+HtvCej5LbzBjER33gF9q7qTYAgc2C2nWyF
 KYfLUrFX46Uh8zWRNnfEhyt5t6k2oXVh8OOrkqoFN+i70lXTc4H/debQYOoOVE
X-Google-Smtp-Source: AGHT+IHtYkBi9cu9ujpjDMcw0GE4mrreUFRhYZp1O7Yjoc1InCDULNzOOZn+/D9soU3Ot4+W+VRb7w==
X-Received: by 2002:a05:6808:bd3:b0:437:eb1d:cdde with SMTP id
 5614622812f47-455ac92e233mr8223015b6e.33.1765983858656; 
 Wed, 17 Dec 2025 07:04:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598930fa1sm9786065b6e.0.2025.12.17.07.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 07:04:18 -0800 (PST)
Date: Wed, 17 Dec 2025 09:04:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
Message-ID: <20251217150415.GC303283@bill-the-cat>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
 <20251217141727.GB303283@bill-the-cat>
 <11ade490-ba73-4553-812b-27e85b4d29d9@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zSuTekBY+KB1ZDFO"
Content-Disposition: inline
In-Reply-To: <11ade490-ba73-4553-812b-27e85b4d29d9@cherry.de>
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


--zSuTekBY+KB1ZDFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 03:51:03PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/17/25 3:17 PM, Tom Rini wrote:
> > On Wed, Dec 17, 2025 at 03:01:10PM +0100, Quentin Schulz wrote:
> >=20
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
> > > intent was to allow print_eth() to be called when NET_LWIP is defined
> > > (NET means "legacy networking stack" as opposed to NET_LWIP which is =
the
> > >   newest (and incompatible) stack). There probably was some mix-up
> > > between CMD_NET and NET options.
> > >=20
> > > The dependency on CMD_NET seems unnecessary as it seems perfectly fine
> > > to run bdinfo without CMD_NET (build and run tested). So let's instead
> > > make the dependency on NET || NET_LWIP.
> > >=20
> > > Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=
=3Dy")
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > >   cmd/bdinfo.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> > > index 20c8c97f0cd..09fe8067642 100644
> > > --- a/cmd/bdinfo.c
> > > +++ b/cmd/bdinfo.c
> > > @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
> > >   	bdinfo_print_num_l("relocaddr", gd->relocaddr);
> > >   	bdinfo_print_num_l("reloc off", gd->reloc_off);
> > >   	printf("%-12s=3D %u-bit\n", "Build", (uint)sizeof(void *) * 8);
> > > -	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
> > > +	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
> > >   		print_eth();
> > >   	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
> > >   	if (IS_ENABLED(CONFIG_VIDEO))
> > > @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
> > >   		case 'a':
> > >   			return bdinfo_print_all(bd);
> > >   		case 'e':
> > > -			if (!IS_ENABLED(CONFIG_CMD_NET) &&
> > > -			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
> > > +			if (!IS_ENABLED(CONFIG_NET) &&
> > > +			    !IS_ENABLED(CONFIG_NET_LWIP))
> > >   				return CMD_RET_USAGE;
> > >   			print_eth();
> > >   			return CMD_RET_SUCCESS;
> >=20
> > It must also be the case that we never both build cmd/bdinfo.c and also
> > have no network stack, otherwise we'd get a warning around print_eth
> > being defined but unused. Can you guard that function too? It needs
>=20
> This doesn't happen though for some reason.
>=20
> make ringneck-px30_defconfig
> make menuconfig # CMD_NET=3Dn, NO_NET=3Dy
> make
>=20
> No warning or error (CMD_BDI=3Dy and I've checked by adding #error whatev=
er in
> the file). eth-uclass.c which defines eth_get_dev_index() is not compiled=
 in
> (no eth-uclass.o in build/drivers/).

Hunh, ok...

> > eth_get_dev_index to exist which does require a network stack. Also,
> > maybe we should be checking on the "no networking enabled" symbol? Or
>=20
> Yes we probably should but we do NET || NET_LWIP everywhere, so I believe
> it's better to stay consistent for now.

Makes sense.

> > no, because that would then conflict with the other series you're
> > working on that you mentioned?
> >=20
>=20
> In the upcoming series, I plan on having NET mean "there's a networking
> stack available" and I'll replace all current NET || NET_LWIP with simply
> NET (the "new" meaning for NET; the current NET will be renamed to
> NET_LEGACY). It'll be based on this series, and I don't want to be making
> this patch dependent on the huge changes in the upcoming series. I'm not
> confident that upcoming series is necessarily worth merging or that it'll=
 go
> through and be merged. I'm at 198 files changed and the list of people
> get_maintainer returns is 160 people... I still have my doubt on the
> NET->NET_LEGACY rename and reusing NET for NET_LEGACY || NET_LWIP.
>=20
> I'm on PTO in ~24h for ~3 weeks and I'm torn on whether to send the series
> (if it's ready) by then, feels a bit weird to drop a big changeset like t=
hat
> and disappear for a while :)

Yes, lets see it when you're back from vacation, thanks and enjoy your
PTO!

--=20
Tom

--zSuTekBY+KB1ZDFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaULGbAAKCRAr4qD1Cr/k
ChqWAQDpZGgusWZBk5l1p3HSWB4wHPPxQlHqVz8TvLbfU7ogQQD+JydhzCuwJ/zV
3ZPEAV8mSdT0gsOu2WX6m+S4iiQA+As=
=NOCg
-----END PGP SIGNATURE-----

--zSuTekBY+KB1ZDFO--
