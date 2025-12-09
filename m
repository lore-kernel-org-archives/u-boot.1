Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6873D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3522783885;
	Tue,  9 Dec 2025 15:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o0B2/yxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2651383B24; Tue,  9 Dec 2025 15:24:43 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0601180050
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3eae4e590a4so2791660fac.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765290280; x=1765895080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9vnJFc8SJUgNq60OGf75oW0oNxKauSODhofRKkKNZdI=;
 b=o0B2/yxwq1DrjY54kSnOmAw0wmNFGVdYIhlY+5h1xSQAPL0QHn7/hnyHsHFgYb3x1S
 bVD679EAdP/y1cONUbAa/fQHu1fHT8q4BLxHR7fZtNsj+i+6N0mhZr49ifxr4hJbM7Mv
 8buF7TeVmDqyrPIjFCWBqACn8XLj5Dy7TlAMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765290280; x=1765895080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vnJFc8SJUgNq60OGf75oW0oNxKauSODhofRKkKNZdI=;
 b=rqgPlwkVqKKDoIES2Vn0n5yqbaj4O/eFoBYudnSifcsIoUMQ9Z0nqmwD0LydXLMgUR
 yNGw8SuSzgXGRn9D+nV9JSRMufyTKzZuyD6wP8O1HMEEQ/sEOsS/u8RhVSJysNqbAdBC
 s3NA+lvgZ279XUM9Dc7uzscdmMyS9mKwOMJ6TGsQZ0jqk/H7ARZSFr3XDQWvqr/ZNrFJ
 kTiCNqyABCjuiS7MmtZFagmnEUQUIi6TqjGpgNq9aR5m8CJwydZPmyreaa0IynRd3mwJ
 ZvUqN2yl8OIVj6/k9gHcgIMHjUoROf4bcDU6QD9WQPE6ERLIiCBWPwed0cpeWBwp4Sd4
 +TTw==
X-Gm-Message-State: AOJu0YzzE7Y2MKEQ3stzUAnEsWay1DleURik/TWbmBwrQTCkoeDYwF8a
 zC5jpfqwWdd6OXlm53Kiu9Y7UPJQzRWm9CLBHpc2bPesMKetbAABJ42jnYgBxh+uXSo=
X-Gm-Gg: AY/fxX7JRPhsMw4XqGuiYcpSJBdxxBvoPxFEhAPjRt0cm4sxR/3bDs0PAJxpn/NaUuP
 Pkvgw1qRZh6ifX7U8YDhsRZUVrMMIP7ph9vYYuiZH1EHuhhO9RcbFlLPng135qN6MZZKqlHAUD7
 p2jM9uoqlra1igtKrHyVOt6zplxW604TevjmagYpb/5x9iFNks8WbhbNrCbg+PPJ2g61oNW92u1
 sUZ27MxjvqtwYSXZtvN+odVXf/gadT4A+WDOz9xRKzoCFmiegctLhJNwJUWFltAhmTuzLQan2jx
 QJ5JauV/UuS6IlYWXmDrL6IBi838/CNCqnzdncnDUvDWXEE3Mle3JLIQVtBbefoeDNAP653pljk
 dwFVcgOOshNBmSlIWztv/G6/bLcz9ETGihgPubv8e08Ny3eRCzln8uf3+JvcCPOqBf5ikeU4fow
 WIv/+izGeIGU6unwbVrQacy54u7rJTBc5HeXFFfRQTezR78GPYZA==
X-Google-Smtp-Source: AGHT+IESizQmJJwcc7xQN3ogg21HGoarTY5H8xgnfint/JdOhM1XotejRxt/ooOxQ8n0pnCOXdCNDw==
X-Received: by 2002:a05:6870:400e:b0:3ec:3ee9:3aa with SMTP id
 586e51a60fabf-3f543fab203mr4519535fac.20.1765290279759; 
 Tue, 09 Dec 2025 06:24:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50b512417sm11158521fac.14.2025.12.09.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 06:24:39 -0800 (PST)
Date: Tue, 9 Dec 2025 08:24:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriana Nicolae <adriana@arista.com>
Cc: u-boot@lists.denx.de
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251209142436.GW303283@bill-the-cat>
References: <20251208193857.GS303283@bill-the-cat>
 <CAERbo5wWCSdxcN3mgf+GxGLNQf6mP5cvbNm_qq7LkY77bupwzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MykjG8llFd/17EBP"
Content-Disposition: inline
In-Reply-To: <CAERbo5wWCSdxcN3mgf+GxGLNQf6mP5cvbNm_qq7LkY77bupwzQ@mail.gmail.com>
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


--MykjG8llFd/17EBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 01:06:28PM +0200, Adriana Nicolae wrote:

> Hello,
>=20
> A possible fix for fdtdec.c tests would be to validate the fdt size
> before using it.
> All 3 tests in this file are using the same approach, if the previous tes=
ts were
> acceptable the newly added one has some identical parts.
>=20
> If there is a way to test and fix all these 3 errors, I've put some
> changes which
> might be enough for Coverity to assume that the size of the fdt is safe. =
Let me
> know how I can test it or should I send an email to post it as a
> separate change?

Thanks. A frustrating thing to me with Coverity is I've never seen a way
to test if a change fixes a bug (if you *pay* for Coverity then you can
do many more runs, and also run it on CI test branches and not pollute
your main results I believe, is why). So we need to do it as a regular
patch.

> diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
> index ea5a494612c..a3c90d38115 100644
> --- a/test/dm/fdtdec.c
> +++ b/test/dm/fdtdec.c
> @@ -14,14 +14,21 @@
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#define FDTDEC_MAX_SIZE  (2 * 1024 * 1024)
> +
>  static int dm_test_fdtdec_set_carveout(struct unit_test_state *uts)
>  {
>   struct fdt_memory resv;
>   void *blob;
>   const fdt32_t *prop;
> - int blob_sz, len, offset;
> + int blob_sz, len, offset, fdt_sz;
> +
> + fdt_sz =3D fdt_totalsize(gd->fdt_blob);
> + if (fdt_sz <=3D 0 || fdt_sz > FDTDEC_MAX_SIZE) {
> + return -EINVAL;
> + }

Since these are tests, can we ut_assertsomething here instead? Thanks!

--=20
Tom

--MykjG8llFd/17EBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTgxJAAKCRAr4qD1Cr/k
Cps5AQDgtucfVdKL8js3Cu0pDXRAgMUyu5r8DIE5wd4+1eUK5wD+MvHqwMeFHyE3
/SoV1WKRZFN1+tHgNR8JkZ5LHz+K5Ak=
=TxS3
-----END PGP SIGNATURE-----

--MykjG8llFd/17EBP--
