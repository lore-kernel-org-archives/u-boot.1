Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E080DC0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD5082114;
	Thu, 30 Jan 2025 18:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tGt8+h8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2C382119; Thu, 30 Jan 2025 18:06:11 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DE682106
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb9ba53f90so310819b6e.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256767; x=1738861567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ywooDxPmgmW7j2IMiK5GjyTWUNY5xOJfMBZPR+SwcHk=;
 b=tGt8+h8KsG8/+FpJnu3RHZlipyzNrC1VYFwKJd0kW+EbRE4lpG63eDdcslUZEfegGn
 jkYF/DQ8c4tYyPd29KPKuDkGqFldB688K0zSREDdx1I4oj/bFYWlermVZiJ1zZQKa3E6
 9ksiMHjRccTDGmRLBW4+O+tLyyBZvyPRgvBBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256767; x=1738861567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywooDxPmgmW7j2IMiK5GjyTWUNY5xOJfMBZPR+SwcHk=;
 b=Xe73iKE8QrIuIpz61Q/41aVdJ0zwkCI+65j6KLG3eiuMyVoIJhUBfPSH15dETq1o4s
 lHVqDGvWG7QRUmEHtEorZD/76Z9SaLzfHm8UG5dCFs6Y7l6PjejJhj+Mh6CNy9txst/N
 R5JFDYNmxDB60ykYdwAx5GGydZVEg0lGYqJ8qMOOu//WnnOlQ8KYEZlgc/GCWJIc26gO
 9XmqZVHlcITzFbmdYDm4MCy6OL2+d+4S2jzLOe9D1AdY4PKOx7n0IzPsqNL/oaySygjC
 P8U8iKh7DJpzInOX08QZQxeVgjUdGeptqMuxgtLCMPDhGxsSpeDtpDMww8BlFIz1RoPd
 /65g==
X-Gm-Message-State: AOJu0YxufludnESwuaspg7u+jcEbuRmnlGgvC1/i1ciay/NUdmcrFnLY
 TR+n8/4DZPrKOFv7LnSFx/tz+MN/DKqwzvCI6vg0gpwDuweWITme6mOtlmIwbto=
X-Gm-Gg: ASbGncu+9O0FKDpX5DXDnO6D+GMy11xh03YFPV6cUf/wTJVqK/3PGZ70sg6qV0wNZh5
 KLXfNJEh8+PtCrlv/i+V3HLw0CWzkALewMhISwAgzYXl1PTKHADN/sy80VeinL3Af4oD0R2xp8I
 qMxV4FiUR6ef29t9CHmvZZaq/m9ruZECjllNndaxHzmhUJtIPbfMF0UTi/rkeEP8OPL5DppUSvu
 ogJwWy5RMFFzSrO588jxRagMLLLd8942Qz4pZaHdTD1VGfbprPIMrkPiGomakndRYX1q8dzPJPg
 ZIMkADSXH+krKAM=
X-Google-Smtp-Source: AGHT+IHwHA0UA4lZcGbV+Pq+tSCcIt6pJkdDRplsKrPNve+AUWyRp7npq1JtpT7BvB/9I3BBpyxFLQ==
X-Received: by 2002:a05:6870:de10:b0:29d:c832:8422 with SMTP id
 586e51a60fabf-2b32f0c4a26mr4442545fac.18.1738256767219; 
 Thu, 30 Jan 2025 09:06:07 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3566583d2sm494874fac.48.2025.01.30.09.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:06:06 -0800 (PST)
Date: Thu, 30 Jan 2025 11:06:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 05/19] spl: Adjust debugging and xPL symbols
Message-ID: <20250130170604.GH1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZJsWZ8IPB2QAn6hI"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-6-sjg@chromium.org>
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


--ZJsWZ8IPB2QAn6hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:15AM -0700, Simon Glass wrote:

> The size of some malloc() fields has reduced on 64-bit machines, but
> the spl_reloc code was not updated. Fix this to avoid a compiler
> warning.
>=20
> Also update for the new xPL naming.

There's no naming change made, otherwise:

Reviewed-by: Tom Rini <trini@konsulko.com>

>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/spl/spl_reloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
> index be8349b535b..324b98eaf98 100644
> --- a/common/spl/spl_reloc.c
> +++ b/common/spl/spl_reloc.c
> @@ -154,7 +154,7 @@ int spl_reloc_jump(struct spl_image_info *image, spl_=
jump_to_image_t jump)
>  	rcode_func loader;
>  	int ret;
> =20
> -	log_debug("malloc usage %lx bytes (%ld KB of %d KB)\n", gd->malloc_ptr,
> +	log_debug("malloc usage %x bytes (%d KB of %d KB)\n", gd->malloc_ptr,
>  		  gd->malloc_ptr / 1024, CONFIG_VAL(SYS_MALLOC_F_LEN) / 1024);
> =20
>  	if (*image->stack_prot !=3D STACK_PROT_VALUE) {
> --=20
> 2.43.0
>=20

--=20
Tom

--ZJsWZ8IPB2QAn6hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebsXsACgkQFHw5/5Y0
tywwDQv7BlvkSoebwif1WS+mZpJ+YGr3T5ecm/gjWdqyh71WLL/aUc6DMsLTt61G
ojz7WrUkYm2mvRTfZQ8u6iDkdhBzdGivyseeMUi+qC9l0GakuTKMfSa0HHzsH/nX
0SqUxVm7J73L5KI+am01h+2LFj7tlok1XqmVBYe7RTtYVlDNjvqFQFb4nClsPdVR
KOczOYfq3405qQVrOfXlxCxow0zCN1+upzH/hO1O0fFNCdV8ubzgMkchCsRcwWUE
EnVJtOCO1DOF4tW237O2g9Wd4lUZ+sUwA8l6ooyJ3oBQK413o32+HdJe90TiXXuO
jsV8T/KST13F5+48vgoL95/slZ7JI91bNA2JGW5SII+6m/rZXEQJmlDwT4Qc0769
LngzwVzJdAK9/5lBsiXQZhaDTxs3iCLMBe2vQCtLSYseNj/dbK2morNmY5VT+MBq
7vpBXAUU64MnRZPHIIsEMKl6PJsomi6GO67XCTUL2Kc1CHmEnS3lyYwWOW29N2mA
9XBw+W1C
=X6br
-----END PGP SIGNATURE-----

--ZJsWZ8IPB2QAn6hI--
