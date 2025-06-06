Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93360C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 21:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDD281F0D;
	Fri,  6 Jun 2025 23:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bnz2+HyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108BD82998; Fri,  6 Jun 2025 23:08:12 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E811B807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 23:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73884ccffcbso1312124a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749244088; x=1749848888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2QFctj00kHguI+p3U6JmvZaBIi6ecioRkp5jfqGRRLA=;
 b=bnz2+HyNEUB/u7pMYRoPFniIJ5MpUVaXZqcRLfbuQ8q7GiHKGaqTptIdF8gHbznJT/
 3Tbj8dkL3aw0erBIdT8ePsFxMt0PLyk+zgMbQ3vkR8o5j+A3EqEgb/wp6NgTz7Pr1xpC
 MIS9wypQsZELSNnE4+4lbP+4Fh+2yb0MobnRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749244088; x=1749848888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QFctj00kHguI+p3U6JmvZaBIi6ecioRkp5jfqGRRLA=;
 b=k2wF1Oi9icVxDsoQ9ZsHRbNjb5x5el+m4KNQ41+O8wbmcL0/aWQJIkKvacm4jzHf2b
 KnjqoFKVwLZMM45MSMb3R1SDPp2tFJqeKB+UICn3JcfbJsjmYiwQ5P6qXgryjsUhfw/Y
 lat93BFzEQvDYO7iWeprxAlR9fnh4Uz6qOSferqvjJO7KpkoVoVaoctfk6QvQV23Yg02
 WNHtpFS9CmZcZdfmbkBey48DQ7ltQKHbyQ2QrWpSp/7hs4L7XdL7jdWa0AUB/0f4MW53
 WiUgd+jrv4ncwPTgH7PTmRDH/E9I3xrdI6Yk+C5RifFUneXQfqtB03oBxjHX1tVRRron
 jsyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb+0JiRbJcjc/0YupMkkqP8CBcalB5TugbZtM/kdOXJpN50YkAxPHNIDrhGSdcaohV1da6PNA=@lists.denx.de
X-Gm-Message-State: AOJu0YxdiIetEdTbC8JBeDDTScOhpqKi2BNzdcduRGlOq2T9jMmqXIIG
 xDPgdhoMr1qQcEudiMRqol20uXlkQsj/0Nv3dQYp5Ke3FHg5yhstXG1imbH8N6QzmXc=
X-Gm-Gg: ASbGncu1b+v6khqYT4kptAJ3CcQgJbJ8ZAZDnBoB6o7CH+t4yYPHpa56GlJI6r1npF3
 dlVZnLkOMzeYKgyGJ31o5bCuDPkTV+9EsTho+hdP3GSbwKxJqBMz5MV2uc4VPPq9B88THhLAZhS
 PrUQno3tdhJFsQhG84LHK3KqqpMSSkHK/JMOaAdpuZB1Y5RPBRHdNmcw4ZWnGb/2KgBvWBHw4En
 bghUp5N+HiKZeBMn04r6tuoQcHxEw0zsRuGVDptFHb99rIKbD6VPPttiaqEMXV4pPnPbX3b+HNm
 lIFirrNCDI+J4S3anQj2WQss9o9KvIgHqRDh3iHYmca8t2xEkWnqiBOsJwP0czg9wgrsUJ6lWIN
 lnYRzptebQQwWTqVnTF4HkiQ=
X-Google-Smtp-Source: AGHT+IFzmiIoc7tFuALgwzPyrNUr19aPSZITnYv4pflieINyg1WaKv81hIMd5iwDWB8DhdWvnJ4kvQ==
X-Received: by 2002:a05:6808:2f0c:b0:406:7054:f7c1 with SMTP id
 5614622812f47-4090522fa51mr3061523b6e.27.1749244088602; 
 Fri, 06 Jun 2025 14:08:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4090696389csm506068b6e.21.2025.06.06.14.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 14:08:07 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:08:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm/airoha: reset_cpu() does not take any params
Message-ID: <20250606210805.GE1382132@bill-the-cat>
References: <20250606200321.461248-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fUs1kG5zCGHDVQWn"
Content-Disposition: inline
In-Reply-To: <20250606200321.461248-1-mikhail.kshevetskiy@iopsys.eu>
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


--fUs1kG5zCGHDVQWn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 11:03:21PM +0300, Mikhail Kshevetskiy wrote:

> According to include/sysreset.h the reset_cpu() function does not take an=
y args
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  arch/arm/mach-airoha/an7581/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an=
7581/init.c
> index cefe9c6db9e..e127ab2ad68 100644
> --- a/arch/arm/mach-airoha/an7581/init.c
> +++ b/arch/arm/mach-airoha/an7581/init.c
> @@ -21,7 +21,7 @@ int dram_init_banksize(void)
>  	return fdtdec_setup_memory_banksize();
>  }
> =20
> -void reset_cpu(ulong addr)
> +void reset_cpu(void)
>  {
>  	psci_system_reset();
>  }

Please add #include <sysreset.h> here too, thanks.

--=20
Tom

--fUs1kG5zCGHDVQWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDWK4ACgkQFHw5/5Y0
tyyC3wv9FRqjLslt08//a6NmuTftg4yFNIsaB9Ct4rgmTlEG+fVcqtwLV62DfEID
tFCE4LtoMth3lYwbcC73L4tdImIDhxRp1PP347qEzpIuIixxbK0leS9M0zUsQfTK
+blTRtivOkIBaloR6h49nAy4qYfJyJ5RTe6aeesZz5W5NMdzVVLGhtG/Sx2g/qbG
yEdCUh0aJfU1KlbTBOKCS4kxJCbNMF/bMHU4PtWA44/YKrJ3cHBhALynst9Y9RJO
QTWFpHsifNSemUCFUq+Lg9/zYSlsaBRfB12cf0ORkrUN8WQLtNcIG3FkkKVl5p6b
IviVtldZtLIc16zzWT3+pKYHMHL2gXnii/HiOZxp8500jen+2QdVv8kRNGLuQygH
j1jxLdtdcoNths+UwZtTilPtI5L1qx2ZEhCsTfnU15F3Y09meUiwW44OuSvAATx6
tVbxj1770NIbeyK7FwC8b4Za1MucWnOOhQX8WdE/KbUMzjH1nmW9qcYtriaiq64k
PynWM4Ki
=BFzD
-----END PGP SIGNATURE-----

--fUs1kG5zCGHDVQWn--
