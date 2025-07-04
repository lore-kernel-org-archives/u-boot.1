Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FEAC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 15:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 361E7806D8;
	Fri,  4 Jul 2025 17:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jijRwxmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E47F8206E; Fri,  4 Jul 2025 17:08:57 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D02803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 17:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2efa219b5bbso330948fac.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751641734; x=1752246534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n0SdIBBdpkXzG/fjhQIIY0ODay5l6TCTCw53ww4CCj4=;
 b=jijRwxmKM+gdIOaS6vFC5557aJAZ2f062dOooVLyBKpjDVM1jCpQPiYqvaSXbalwOZ
 yhOJQQWTRFUgyDdVlgFwpj68YaFtUoHuDz5xdBv9Y06f3coEARbnJqv4YgmJCkWO6Yqd
 eZrpRl2wi/KG5sb4oVtfzZAUrGIlcws903avM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751641734; x=1752246534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0SdIBBdpkXzG/fjhQIIY0ODay5l6TCTCw53ww4CCj4=;
 b=AbpHz8awpV6NloBvuE/6FO35vVqatUc+b+ZXo/H0wMOGtikCcHPJ/nYxXdiPPlO9kl
 02FvFi/WC0xl+5a23xBYWYVbpYBssy0PQsrUGJk3SLEyZ6xvvdnkpt1LRNzpPGeRwBzU
 U1miYRfeWt+Y/mx68TJEI2kElNIVCCzMx3h4sb9y7DPH96aI3i66UE91TGnmQfF6JIRc
 RpkMtqNEmkeWaNmcEaJkp7sFiO4NVv1ghoGu8+t1FT6Y7UBw5jNr0tQcX292HqQrW3xr
 keW9X2cvkPBgDQjlpN9IcI2Q9XS/Nrflu6vXN8taFwB3+zZj1sSqY+rwsaL61rw3OQ2n
 qh2g==
X-Gm-Message-State: AOJu0YytJwkVhcPF8nMVV/l0fjYTTAfowz4neTdsu1eucHiqp/+/QkVr
 +6xSv17vGHyUnHLxtPEA56g/QhDuQF9eg90Zhwk0P2IRdN8dkLKSuiv0qELWj07PrM0=
X-Gm-Gg: ASbGnct3rghBsIA6q9OkTrgnt81T4gOfYxNZsYU0/0EegB6hXLVGMJPx16Ndy4jyPLj
 fDFnN4prmtK+GNn89ECbcbu6l7ZsJGTJoTzGDS01pjDD1VY+IR2fwsr+uwIUGY9Kdb5v0SQjRWB
 nh8b52ndNK/Iw9qxQ5Snku7o/HgT1dIRL5LJvRCRyqtN4STvkP9NaQsF9z5L+cdrOBl9WmWx3Ai
 qgrUn/LwdirIaBV3Aiv6nFaXpv0wroDoKI4jIADi2hpMVFdY4loRfFgb7o6kBM325E1NLr9jX07
 JD98rH2KnnTGdO+4tt6GNA9ERM1X85+7vkYWhKbkmK14R3Kuou4cYl5kuWIveE9FKjzryeZ4DhH
 xlLDJV9g4u8pO0hesEn7j
X-Google-Smtp-Source: AGHT+IFb2j89+kWmiyWFUqKlvzEeez8MMZzgT/eEzgAUba+MgD/TvJjR9RSyKIitDFSi3J2UVCebbw==
X-Received: by 2002:a05:6870:c05:b0:2e8:7505:638e with SMTP id
 586e51a60fabf-2f792168420mr2498341fac.39.1751641732409; 
 Fri, 04 Jul 2025 08:08:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f772500sm399834a34.30.2025.07.04.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:08:51 -0700 (PDT)
Date: Fri, 4 Jul 2025 09:08:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org,
 otavio@ossystems.com.br, michael@amarulasolutions.com, uboot-imx@nxp.com
Subject: Re: [PATCH] mx6sabresd: Increase CONFIG_ENV_OFFSET to fix boot
 regression
Message-ID: <20250704150849.GG6424@bill-the-cat>
References: <20250704130319.3814676-1-festevam@gmail.com>
 <20250704133105.GD6424@bill-the-cat>
 <CAOMZO5AtVXOxWjMQeVeUtbU1Z_D_DvQ+0a7OzzHUskSK8wFJ6w@mail.gmail.com>
 <20250704135338.GF6424@bill-the-cat>
 <CAOMZO5B+EV-PPhT0pExj6TFYWNw4OAepob_M2k7RiHX9O_b_Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rp6G4zkpjmiCl7oN"
Content-Disposition: inline
In-Reply-To: <CAOMZO5B+EV-PPhT0pExj6TFYWNw4OAepob_M2k7RiHX9O_b_Uw@mail.gmail.com>
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


--Rp6G4zkpjmiCl7oN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 11:11:34AM -0300, Fabio Estevam wrote:
> On Fri, Jul 4, 2025 at 10:53=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > Yes please, thanks! And I would like to explore a little if some other
> > compression algorithm (that we don't have support for yet) might be a
> > larger win too, for v2025.10.
>=20
> Ah, I manually tried this change below:
>=20
> --- a/configs/mx6sabresd_defconfig
> +++ b/configs/mx6sabresd_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_BOOTZ=3Dy
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
>  CONFIG_CMD_SPL=3Dy
>  CONFIG_CMD_SPL_WRITE_SIZE=3D0x20000
>  CONFIG_CMD_GPIO=3Dy
> @@ -65,7 +67,7 @@ CONFIG_EFI_PARTITION=3Dy
>  # CONFIG_SPL_EFI_PARTITION is not set
>  CONFIG_OF_CONTROL=3Dy
>  CONFIG_OF_LIST=3D"imx6q-sabresd imx6qp-sabresd imx6dl-sabresd"
> -CONFIG_MULTI_DTB_FIT=3Dy
> +CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>=20
> After running make savedefconfig; cp defconfig
> configs/mx6sabresd_defconfig, I see that CONFIG_MULTI_DTB_FIT_LZO does
> not get selected, and CONFIG_MULTI_DTB_FIT=3Dy is removed.
>=20
> According to doc/README.multi-dtb-fit:
>=20
> "Usually the DTB is selected by the SPL and passed down to U-Boot. But so=
me
> platforms don't use the SPL. In this case MULTI_DTB_FIT can used to provi=
de
> U-Boot with a choice of DTBs"
>=20
> mx6sabresd uses SPL, so MULTI_DTB_FIT can be safely dropped.
>=20
> I tested it on a imx6dl and imx6q sabresd boards.
>=20
> I'll send a v2.

I guess the question is if we need to be using SPL_MULTI_FIT_DTB to pass
the right one along, or if we don't really need to have the exact DTB in
any case?

--=20
Tom

--Rp6G4zkpjmiCl7oN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhn7n0ACgkQFHw5/5Y0
tywsjgwAl6Gr+teEpJ9susStOhw1o0TKniz61x1k5rnaDiYZJv9GIU+CPRQ9Kv4a
Sefvq1hYbcN4H50YOPXGnUpP8hQIt6y0zK6GBIAXwelt0G4BCQbGMOVbiAlr+dPN
msfa8XstE9MHeEjg14xMCG+YaddFjb5rIymGljkc3MvHVEJk9AA5LrYduVRYTPly
oOnoS5ETfmzw7F2fxJplM25Hkxn9U4esupoiVVOrWaBw66uRUVe9paZALFJhLOO0
BLVgbjJwd5ZB2m/V5BMGK5GV3cG3aZfIyKxoJ8OBwC0KAJW1of1NDwMTJBTk/2tJ
RIsKqQxlo/zTksU3kpKUYw+/s1lJ3FCMkVtKitHBLUZ17qROeBiykHtF9+a2JZDK
WvPqZSgc346W3QyfpJFxBxbCP0K8xCe65ukzoEmobYFvTuVDYDt7Jk82SFGdt1Uy
igbMX+lOod2r+1slTH8ubCTQTvdsbhNb5YJ8MNQrH40s9h0nd8suESsLbHKmXU4c
EW0sXBS+
=7+Xn
-----END PGP SIGNATURE-----

--Rp6G4zkpjmiCl7oN--
