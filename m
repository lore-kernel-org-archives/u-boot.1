Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8EFD65C54
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 14:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01D683B32;
	Wed, 17 Dec 2025 15:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WN82bvyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A233483B4F; Wed, 17 Dec 2025 15:17:34 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DDD83B2C
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 15:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45391956bfcso4709041b6e.3
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 06:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765981050; x=1766585850; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nvU2xROZfgn38c9h4bj9kJFqKOf/YTNIEytgUOa0moQ=;
 b=WN82bvylAZ6Es3BPz58eLifbnURLmw/xchlD0hX9pWJ0MUdIf8ci8nSmJN08vwfTjS
 PstkDHtdYbICkrTbSQ6Uow63iXlGuOJbLLg8Ej7fozWfgrsNeC0p/vNV6g0gILh5fah8
 IZKHvneMlNVpG2XuKPo08qxsIadPaOnDUciWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981050; x=1766585850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvU2xROZfgn38c9h4bj9kJFqKOf/YTNIEytgUOa0moQ=;
 b=Iq0lv4xWzZstzMLnT+qKo4JAa075IZZ6dYXsdStfqRXS5XBdW5sG8U9V2qjwPZUwZO
 0kW8Tfpo0/1qxZFexaDoEkI9+Q1PkglPr4DItNCa+heyAdK2mfustAruVA3oPM1xNVFa
 y+gEvwH914/xpYq5Ge/4imV8kerFZaDY6QZ6ReApRdWjwOURtXZILisDvUZueK5kfBcK
 IsxT6/ZT51rnxfiHKieKJLJryY6MMtBC2sRautuFGNvfha4qxHz8rP6BufHcQWmjRYvf
 shQaXt+a3FMebZIHD3lfcfOwCCvDymuZnHbTTlZIn2kZ1GsBiRQkyhPm+MHt/KVE5chG
 /SwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiPP6f+VWcpX9V5ntvtnefYx4xIoyqbJXHAqjRe59+Zb3BsYam+Y7eTe+Q99b8QEvPfbRfRmU=@lists.denx.de
X-Gm-Message-State: AOJu0YwKi8n1rzlbNCkrNbGSD8aCd6nmvhhnxbt3syHhn5Jn2k6+Johi
 pNofB2HMqly4IMQfKMTlVaRy91+kFD5EYMroz1ZLfDBBL91fX7dWi6d9l2khox9HW+8=
X-Gm-Gg: AY/fxX44qS7q8l8HjLptPgVysvDG06EPA3ja/6eyVeNwnzM92UDsbNHFBd1A2hQSgwR
 DopUi5PP8fxIzWPGn1V44XTMtrIjGWNVCiQcNqSYXHAZAU+ddK5MiXDWB2e3PPaz+o3triXDWwd
 L+LkJ36Vty0DWjz5ebgVZL9HkCsMtYdNF/0E4TcTVt9RtZB2HrdtYDdKPEsjaRrLsIRm1MP7h7/
 HzDuTzg7r7j5bI3L69pzbzb/kJBtTS7sYqtRKNrp210uRYdE3h3Xzk8FayNsug55fMiOJLrY+2J
 plP1wSveTSUksypAndCjQYA2GgzEqMWhwXniR6hrITuh1JyeowGTzBmUqfGClcbPdWf86AD9Zfm
 IFzTtU/gY5aaRJhWTjSz5drieOr55Ni8mblAZ/O6FCqQ17PgLzQNSAZm1Fz6WB7PTKAdZc2yBWg
 7czl6r6SpeSHzAYmQjiu21HcGlLMLr/1tBKBhwSMCaT6AICNLoZg==
X-Google-Smtp-Source: AGHT+IFGW7Gff/gIICdNX2e+EFpz+nbOaF9g0SL5MRKUzXE9824a4Uji1oeQZicX5x4fMQLyYxPh6g==
X-Received: by 2002:a05:6808:4fe5:b0:450:dbe2:a9a3 with SMTP id
 5614622812f47-455ac951a33mr7711384b6e.42.1765981050252; 
 Wed, 17 Dec 2025 06:17:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598d34941sm9226735b6e.19.2025.12.17.06.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 06:17:29 -0800 (PST)
Date: Wed, 17 Dec 2025 08:17:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
Message-ID: <20251217141727.GB303283@bill-the-cat>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rgEy/vlmyIkRMbZ/"
Content-Disposition: inline
In-Reply-To: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
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


--rgEy/vlmyIkRMbZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 03:01:10PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
> intent was to allow print_eth() to be called when NET_LWIP is defined
> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>  newest (and incompatible) stack). There probably was some mix-up
> between CMD_NET and NET options.
>=20
> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
> to run bdinfo without CMD_NET (build and run tested). So let's instead
> make the dependency on NET || NET_LWIP.
>=20
> Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=3Dy=
")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  cmd/bdinfo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index 20c8c97f0cd..09fe8067642 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
>  	bdinfo_print_num_l("relocaddr", gd->relocaddr);
>  	bdinfo_print_num_l("reloc off", gd->reloc_off);
>  	printf("%-12s=3D %u-bit\n", "Build", (uint)sizeof(void *) * 8);
> -	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
> +	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
>  		print_eth();
>  	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
>  	if (IS_ENABLED(CONFIG_VIDEO))
> @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>  		case 'a':
>  			return bdinfo_print_all(bd);
>  		case 'e':
> -			if (!IS_ENABLED(CONFIG_CMD_NET) &&
> -			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
> +			if (!IS_ENABLED(CONFIG_NET) &&
> +			    !IS_ENABLED(CONFIG_NET_LWIP))
>  				return CMD_RET_USAGE;
>  			print_eth();
>  			return CMD_RET_SUCCESS;

It must also be the case that we never both build cmd/bdinfo.c and also
have no network stack, otherwise we'd get a warning around print_eth
being defined but unused. Can you guard that function too? It needs
eth_get_dev_index to exist which does require a network stack. Also,
maybe we should be checking on the "no networking enabled" symbol? Or
no, because that would then conflict with the other series you're
working on that you mentioned?

--=20
Tom

--rgEy/vlmyIkRMbZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUK7bAAKCRAr4qD1Cr/k
CvAAAP9vbUvYURQU/GW0LIjBjrQNwy740fHYl7cHbmuKbqbnTQEAwTZg0kf6evr9
lRCCnw+CWC7ENZA3WTFhxymI2bTIQAk=
=PZ3G
-----END PGP SIGNATURE-----

--rgEy/vlmyIkRMbZ/--
