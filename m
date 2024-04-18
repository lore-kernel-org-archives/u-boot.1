Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D5C04FF8
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 14:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A84884E8;
	Thu, 18 Apr 2024 16:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozqynN7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5008988633; Thu, 18 Apr 2024 16:08:40 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABE6884C4
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78f049ddd7dso58895085a.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713449315; x=1714054115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iDdlZLvndZBcRtEdItPeY1RL+yRb0f5OyXb2iMGMtQQ=;
 b=ozqynN7Llzfd7AAxaCVMqbGs5O02kj/k1UHgVz4wadx1bW9rBEHVlu/ywqMikxOI87
 iNu2iQ/tCBhnimSuZH7687MCkRvnzcQ17oNBBZIICZ0iB9t2pT136RuURKd1tFnRHoVa
 tBubeIzEshAKC4mjjuj/1LD/dM6Wt7UeXbr0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713449315; x=1714054115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDdlZLvndZBcRtEdItPeY1RL+yRb0f5OyXb2iMGMtQQ=;
 b=HjuyMF/JdrnlEksbUSU6zV2ZEWGyrwJMiJQ1TEdlWoS2GKaTyYeeq6RJt4muhMCtoI
 Elad9q+4o/baqiXxTaD73sQx80qWsHF4av1ENN4wjh+9qdwvfqN6wqE6Lmf4k81dmqz3
 TD2iXxdZsYNt3lxMJLS1AcaziajSXiILUp1QjhGyT3Nmz77+8uYng3I9pINfA3088evJ
 fNjSBS73fb5Mi50xXoWkhnsQ8IrRWVTCXZnv9zdbyRq+gJd95SFynW28gfwVfFCMvi5K
 s3Q/tEuKgp9JHK9BPF5zsZFHn3ce9buoBmz0rTL5M7K1xtHyDb9C6oc/F1cfY/Obp9li
 tQhQ==
X-Gm-Message-State: AOJu0Yw0yJM2MR+sEMMaxgWI6gMRbxRuKRVCx8J7+6U40qLMVVgToeKT
 Dh5DRagPovKYvJ8vOAO7B7cfT4AhudNTNRsT2MfDDN+LQ6L34h8vMYB5giMT/Ko=
X-Google-Smtp-Source: AGHT+IFCIiD4FA7h95DxunpaJxMNJI3WwH5P96wKDraVoJ0NQb9p/v1xTA97dxh9T1NAKKQD/++8aQ==
X-Received: by 2002:a37:de0f:0:b0:78e:ddf9:5f5d with SMTP id
 h15-20020a37de0f000000b0078eddf95f5dmr2677155qkj.18.1713449315424; 
 Thu, 18 Apr 2024 07:08:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 vu23-20020a05620a561700b0078d66d66d82sm674870qkn.30.2024.04.18.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 07:08:34 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:08:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-fdt
Message-ID: <20240418140831.GH1054907@bill-the-cat>
References: <20240418125024.7388-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lDm2OEJH5V2pqgOw"
Content-Disposition: inline
In-Reply-To: <20240418125024.7388-1-marek.vasut+renesas@mailbox.org>
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


--lDm2OEJH5V2pqgOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 02:49:54PM +0200, Marek Vasut wrote:

> The following changes since commit a712a54dc427708195e6405af4b072d869d0dd=
8f:
>=20
>   Merge patch series "configs: ti: Enable basic settings for SystemReady =
ACS" (2024-04-17 13:16:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-fdt
>=20
> for you to fetch changes up to aad511a488c40393728156333d983c31001aac32:
>=20
>   ARM: dts: renesas: Switch to using upstream DT (2024-04-18 05:21:26 +02=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--lDm2OEJH5V2pqgOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYhKVgACgkQFHw5/5Y0
tyxOKAv+NdcIEWL4zcO5auAdeTRb8arXsSrh21cgaWdTLOpeqsvcXSJ/xERNaVw/
G7Mx7qGnk5YnOFdnXkYbQvb9tPP6kHZdLjIiuoY9CBNiysbPasTqNewlh4Z6/au5
3AXmt90jJ1nnIo6p2GB0lsXUIJYjWP+uTlTuwpyIC10bLz7AvpPIXi2DRm9Sgnl1
DFm5WG9ow+jYNV7q/0Qovgz+llXgDfe77tl3tC3i+7m4UuSPRPyMomRKVxCv+Ng1
q1sVQ1FNpfDVwKmgfX8CjNQUna5aLlOLOA4HBgevacBlAXuzUWp84GirU3Dqejk3
wTjbC/EmiRKL5XYjI1qrqGj7tdJyzwBnQsOH4TQbholNhfJHiXqjPQnmpf8rVUKN
gKlEFFiVM4e1Y7FFM/xMRt8SmYGa4Z7IDPiAaEOCI34wGNL9k2r2/o1cVWdFQTF4
GhzMGnTAmnZNJrjfz+Sw0ByTuCjGiZKtlpxOn5aMsp60VeJmdXUkTqZLMXxrvkLg
YvWBlHpN
=umnF
-----END PGP SIGNATURE-----

--lDm2OEJH5V2pqgOw--
