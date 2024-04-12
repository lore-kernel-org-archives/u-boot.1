Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C00CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5ED8822F;
	Fri, 12 Apr 2024 20:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lGv25NSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F049F88235; Fri, 12 Apr 2024 20:52:44 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4EB87D64
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d5e7998a0so75353085a.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947962; x=1713552762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a3jl8AYs5T9n3S9l65sWmtXxsLGj3yf8LBybYd6q4PY=;
 b=lGv25NSt25AmxpFwS9hBP+Im5/PlN5QL9sVw0Vgs+hTBz++LFV0PBZiP3082ib7A5n
 udcR3x+p3qJQ6qEU3vdJcg8Z4xQ9AjRLlFD6XKsGN4llngJ+l1BGEruWYEHuUG0oewmd
 nEPEDAs321Et+hi8Eu5ORYqTZZqSAYVxGmlZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947962; x=1713552762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3jl8AYs5T9n3S9l65sWmtXxsLGj3yf8LBybYd6q4PY=;
 b=HNu5V1KC7JZykZ1ZTUrhpM+orcRCTXvJ/+TF684g3PGzeCylxBOxYInx351iI4Kt72
 ykB7k4Pv8yG4VHg6rDYxPq+7QUtTlsN639P3+NkKk1jD/C3475BGtYRjLhCnhB4P090R
 M5LdgTQVJlZqRqb3cfpWDvrWvoBtMCosSovMgIHRio4kvEBD9omg6cuCRNGOCxGlQuR9
 XeEdeZQR0MdxIhXuZXrMOwJ3mlo9L92o5vhX7FFElRq2OwwfcPeG59hUdymNxAJgTO8h
 3jRaA7f99jSfQsJNUsxYIulXCso1ziQY/JD9X7DvwRFeEL9XFgOPdCpSHr5Vlxv65zN5
 QmUA==
X-Gm-Message-State: AOJu0YwARI272+RItNeYCwBkjH9vwKzyTzRZ8Yq7FmpS0VXD1G9N5nKH
 U/v/Y8t42ZIlMudbylq0+IC4h3dNKz9ceYFlbKWXhZSgyZXKHmw+5ZkwcsIRkBcgsQKo4YQTct1
 nadk=
X-Google-Smtp-Source: AGHT+IEHAppkU6Z6vrYdk/xrxzh5hkq7b+iUk9+BiHaeEAtgX3wJTbUT0urxRX/fFkd/94TXux21Hw==
X-Received: by 2002:a05:620a:948:b0:789:e28c:d73 with SMTP id
 w8-20020a05620a094800b00789e28c0d73mr3375549qkw.49.1712947961781; 
 Fri, 12 Apr 2024 11:52:41 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a05620a0cd400b0078d6a0d5728sm2757361qkj.29.2024.04.12.11.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:41 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: u-boot@lists.denx.de, Dai Okamura <okamura.dai@socionext.com>
Subject: Re: [PATCH] ARM: uniphier: Move uniphier_mem_map_init() call into
 dram_init()
Message-ID: <20240412185239.GX2493117@bill-the-cat>
References: <20240405083715.2593568-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZDs+02ksYeh1mnhy"
Content-Disposition: inline
In-Reply-To: <20240405083715.2593568-1-hayashi.kunihiko@socionext.com>
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


--ZDs+02ksYeh1mnhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:37:15PM +0900, Kunihiko Hayashi wrote:

> The function uniphier_mem_map_init() is to change global variable
> 'mem_map', which is referenced to get_page_table_size() to calculate
> the size of page table.
>=20
> However, uniphier_mem_map_init() is called after get_page_table_size(),
> so the size of page table and 'mem_map' become inconsist each other.
> After all, U-Boot fails to boot on chip with memory map different from
> default map,
>=20
> uniphier_mem_map_init() should be moved to dram_init(), which is
> called before get_page_table_size().
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ZDs+02ksYeh1mnhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgvcACgkQFHw5/5Y0
tyxndgwAg5YYfLahDc+U0OzywF4pAg6fVJ7W8kdu1K8X3qdtCbMX6oxBslsgg4nD
6uAA8td0pK9+rUJc04Yv1bkbLDwbl2VRz692I6ZUheYqd5mZsQfUf8JbxJCbyPPt
jO+f3WSMhQH5SqvBSiCZGsE/vA1sQbV9UmsXPW58Zn4XGiCq6lNgPgvBBUEVl6+R
Be9X0C8OkuoGlLj2sy3DWHLTjQni998f4ldH9SfS1qEMkScNGqeuP5QZzCLysmDg
+k8xFJpfNtz78ds3dTDqHRLMS6UTjATxz0/hRO2CxNPCg/ybhTOqa/uU4shrfWpe
tCzTBs/kXmcQlsjId8Nhy1rSoY1NYNEr9ge+zxm+exDahDDLH2vwkxo/vRW4vCsv
lX61fGpiPvSGPBo686WHhdAEtHDGcaOuTJEhU9e30yCeS1iCukW5oQ7cNPovQWRY
jgLmAcptEW7uMQUnox8zleLDgSawwHzK2/wMQ+w+5tqWUww/sM6IJuaL5Y0N4XjA
jT9drQec
=k7Wu
-----END PGP SIGNATURE-----

--ZDs+02ksYeh1mnhy--
