Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE7FC369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2362E82114;
	Tue,  8 Apr 2025 16:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tBvGTRj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A8C82C55; Tue,  8 Apr 2025 16:00:47 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B2D8210A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3feb3f54339so4054802b6e.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744120843; x=1744725643; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JKIMPGTDc/34iB6wpBo3bWiYvADtafzgnP63YZyvBCs=;
 b=tBvGTRj2UepRi3dmRqm+JXy0lE/GQy6AtE7ZMpEsCsswZcQJu2xPmmJz69GVE6njr/
 7iQU2Byk9qL+OXeqnS7jyXCEs5/N7Z1hUcS38cm0XcTYlvoHn5Eb9L9SqAoviU6xLKCy
 Sr7ZXBYx7oM9zYUFqKnyA+MMXEAnljj2ImO9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744120843; x=1744725643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKIMPGTDc/34iB6wpBo3bWiYvADtafzgnP63YZyvBCs=;
 b=IwGE/HgdjJRD29CR2qTDnhaJI3PHPJyCY+XC17v9IRHOc7xnaIxC6ODKuUQpPLgKz9
 NlVqUvDnn7Uj8ttcybguBJtye8yrRmMufpT+g/oTRDdKU6TwCBQkPa7rv9ypaTvi0fBv
 jQw9ULc1ZcbkBnfmIEow5PEmUFdweKI2zRO+fXpavNOgnGi0Sv4ZSxqvK1Sp01p2fl3U
 1R6/sV6XgOa1zV09eFwBFmdJsjZ7b26dGjqQnEeoUeJ5NxI5v9+m0M1AkrMopUk1zDl/
 F4ru4diURkrxUYm4DXY3AmeAr6Q3fWSIXG/CEhkAZBnjFYsabYu+4rTNLs12FuZYfvTl
 kBvg==
X-Gm-Message-State: AOJu0YwaQB7tSgShada3JdSBbDecLkiQ/4n3EUNxtc5CUS4V/1TTfDi/
 TL0xct1h8ZLdnkxSxV9wdqZgYotDfeAydIRFTg+rhTM8vgf5OGcr9su+OiSZvss=
X-Gm-Gg: ASbGncsJr2kXfOc2SWV4jPiA2w+F2z8Sj2qFO8bB3xnvIyOT/w4dBE6ddCvtwNrGOrs
 FuJM1Tq3VlMtXb8VDPPDtsWi41P8uz1GvYswNkALbxMHBWI5W4ps3dN/8ibeMgZWy8qZj4xLwGS
 XsEFw1tF9JjlHgql1nQ29RlsDuNoV8YBjrZ6v7YHaPS+dB67t9/tfBMsTca4T40xNWqRSeLx3gw
 EyIS/CM5N1vFwhNRw11iZF0rtGO1bW6XZK2rb92jSOfcLkiakxoaWbi4qK1+s5a5mEBDB4QNiyX
 FQ8lF6RcLjXi5Ywi/oJnhHqyOyo1I9xwZrkIkRzJjgsHqs1wTOtLmRD2lI7xkyjFaJj4GcEN1hZ
 MMMZ9DQ==
X-Google-Smtp-Source: AGHT+IE7dOwhrXFXApH26THxrY7u9NqAYkZcwjAHxbMmoxkrlfyX1r2zmDU/OCYN8CO6nBUXHjOsIQ==
X-Received: by 2002:a05:6808:191d:b0:3f9:6df8:1d33 with SMTP id
 5614622812f47-4004655da69mr9324730b6e.6.1744120843344; 
 Tue, 08 Apr 2025 07:00:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400691063bfsm452006b6e.12.2025.04.08.07.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 07:00:42 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:00:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] cmd: fwu: Dump custom fields from mdata structure
Message-ID: <20250408140040.GV5495@bill-the-cat>
References: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
 <300f75b7-6c59-4b58-b4b0-e8aaf7919318@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bhz7qLXfvLMpO/Ky"
Content-Disposition: inline
In-Reply-To: <300f75b7-6c59-4b58-b4b0-e8aaf7919318@amd.com>
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


--Bhz7qLXfvLMpO/Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 10:18:58AM +0200, Michal Simek wrote:
>=20
>=20
> On 3/21/25 11:25, Michal Simek wrote:
> > The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> > data to the FWU metadata") added support for adding vendor data to mdata
> > structure but it is not visible anywhere that's why extend fwu command =
to
> > dump it.
> >=20
> > Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >=20
> > Changes in v2:
> > - Extend print message
> > - Cover hexdump dependencies
> >=20
> > RFC:
> > https://lore.kernel.org/r/75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717=
599342.git.michal.simek@amd.com
> >=20
> > ---
> >   cmd/Kconfig     |  1 +
> >   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
> >   2 files changed, 26 insertions(+)
> >=20
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 642cc1116e87..1f8aa2521a8e 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -185,6 +185,7 @@ config CMD_UFETCH
> >   config CMD_FWU_METADATA
> >   	bool "fwu metadata read"
> >   	depends on FWU_MULTI_BANK_UPDATE
> > +	imply HEXDUMP if FWU_MDATA_V2
> >   	help
> >   	  Command to read the metadata and dump it's contents
> > diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> > index 9c048d69a131..5b5a2e4d1cda 100644
> > --- a/cmd/fwu_mdata.c
> > +++ b/cmd/fwu_mdata.c
> > @@ -7,6 +7,7 @@
> >   #include <dm.h>
> >   #include <fwu.h>
> >   #include <fwu_mdata.h>
> > +#include <hexdump.h>
> >   #include <log.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> > @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
> >   			       img_info->accepted =3D=3D 0x1 ? "yes" : "no");
> >   		}
> >   	}
> > +
> > +	if (data->version =3D=3D 2) {
> > +		struct fwu_mdata *mdata =3D data->fwu_mdata;
> > +		struct fwu_fw_store_desc *desc;
> > +		void *end;
> > +		u32 diff;
> > +
> > +		/*
> > +		 * fwu_mdata defines only header that's why taking it as array
> > +		 * which exactly point to image description location
> > +		 */
> > +		desc =3D (struct fwu_fw_store_desc *)&mdata[1];
> > +
> > +		/* Number of entries is taken from for loop - variable i */
> > +		end =3D &desc->img_entry[i];
> > +		debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> > +
> > +		diff =3D data->metadata_size - ((void *)end - (void *)mdata);
> > +		if (diff) {
> > +			printf("Custom fields covered by CRC len: 0x%x\n", diff);
> > +			print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> > +					     end, diff);
> > +		}
> > +	}
> >   }
> >   int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
>=20
> Can someone pick it up? Or should I take it?

It's got Sughosh's tags so I'm fine with you picking it up.

--=20
Tom

--Bhz7qLXfvLMpO/Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1LAAACgkQFHw5/5Y0
tyyqPwv/V2bqM0CvtiUHZxd3xMOkBGTJajRtlxqwVzI/ZuchYrojNB5FTTLPz07G
IiVr8QDdrtvcMqmzSZXNTUCQt/gsf/D6/lilKjFwFqxZVQxpIzD/WRDcGHlsSWnx
u6SM2QUZ9uQjlIGoLk5VeKob9VphIh2wt9P9c78tjAcjlM8k9xEnO5GwwlLqpKVt
tBq8/D6zG1BI/BNQ6BFZ5Z++tajaK9ptZoLwYL+MSm4Gn2dQAIzP7c9vQ9MAhb+W
VF7W8Pxd0un03B8Cu/pEl80tt16oyAOxq5p9gPGjmYuByxY6/TdAsMTJQkK7sjah
LRfEEV9sdOFRCy2rmoc4kEAbzzwWJ+cNPYcDXaFQrX5VaR7rGD9WGJJj6TeXz1lK
V2BxYviDA4OEgqqf+V0Y37utujmVaN6ub5IocC3Bo6MKAZl9yuREEvbgWitJ984l
MaPLpuZUd/7ALtGeJ3nEt5lSKxrtfyEYq0OQ8t0VP4fWjelqI9lSJxR6Ul0VEQpp
1GmiCnQ/
=jU8b
-----END PGP SIGNATURE-----

--Bhz7qLXfvLMpO/Ky--
