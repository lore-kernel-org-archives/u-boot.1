Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AE7C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB9D88765;
	Fri, 31 May 2024 18:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dCOJZBdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31FA88783; Fri, 31 May 2024 18:03:05 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D7688607
 for <U-Boot@lists.denx.de>; Fri, 31 May 2024 18:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43fdd85a284so11760991cf.0
 for <U-Boot@lists.denx.de>; Fri, 31 May 2024 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717171382; x=1717776182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SMT86Nezgig0/Xm5yJnoLezW8xtfJjdbh7VRVDQFPCA=;
 b=dCOJZBdJq9guB/u8A9R7YAEUcm+sayTb6cDrZGjvwlYLhGV5Lepi1ogVngpidiALLY
 QdnUpieGKH0kyPeF7LuPTWIoC+eByfBHePnBN9lqZf5tyW0195oGjzworIUddE8J+H2M
 uYwKZW9Z/tMDncRiDcOdmP+ifcFnyogrVv7yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717171382; x=1717776182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMT86Nezgig0/Xm5yJnoLezW8xtfJjdbh7VRVDQFPCA=;
 b=BfiI+CBFeXa9aDJIEI9qx2/AJ0q6YdqWQr+668pddnZ0CSgvw2QbGMKhMphJadASjc
 zTOSS5yhk4x1yL38Sm0vjQ4MnXu6QKyVgHUyKDuo4qL+Baa9diZCzDcztSE0ah80EUNw
 t/n5UAe2y85a1DAy6DAhwQSNw6Smm0kbRUDHM2pRHUa+nmub75M1DoizzVLlkLplLrDw
 8PPP74Om6WqIA0VAI81Ca5k3hs3d5gdqROiNnuWQtuF3tY5hqpw2G4kN1iN+QV1Wk1xi
 Jr1aQpKRdIA/jl0dL8mGsOu/U6XR6aIq0aDLZYTpmGEu4dw8GZgo4lcG/0eP7H5X0xuQ
 4DQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUemErTMBal3euN0g/0OQRZ4mELSrOX73z8h6zc0/QuiS/PkCRVgojO/jqe6ZSpqKQgq3tZ8+NzKt0Sw5iBE/zVWIokwg==
X-Gm-Message-State: AOJu0Yy2fic2Z/EIxb5ja6Tuk77iRx4d2KULTinjQFFvPFfDM0KDxKzj
 30cyWUmbr+x4+MxFrZcZ27Lnm/2H/FRmRD2QQUbWip483dFSXRBY/j15vYad+xg=
X-Google-Smtp-Source: AGHT+IEK2Cb+0nQ0c/GyeDs+pTjtxXAsKjVYmYO0JGlRJ1Vgt7MXLIUdD3LrxFq7492obLs7ueinLw==
X-Received: by 2002:ac8:5f46:0:b0:43a:b1e3:d6db with SMTP id
 d75a77b69052e-43ff54a7065mr25195951cf.62.1717171382424; 
 Fri, 31 May 2024 09:03:02 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff93062c7sm3970791cf.30.2024.05.31.09.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:03:01 -0700 (PDT)
Date: Fri, 31 May 2024 10:02:58 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240531160258.GN3714513@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="un6gGEgKkm9lwvKd"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--un6gGEgKkm9lwvKd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> What are next steps on this change?
>=20
> I'm committed to the idea of EFI apps opposed to examples/standalone.
> EFI currently requires block devices which is not enabled when only using=
 flash.
>=20
> Should config BLK be updated to include DM_SPI_FLASH?
> Should we explore how to remove BLK as a dependency for EFI_LOADER?

Yes, someone needs to explore how to cleanly make BLK optional for
EFI_LOADER.

--=20
Tom

--un6gGEgKkm9lwvKd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZZ9K8ACgkQFHw5/5Y0
tywlMQv/V9loFzzyzT4oXlWCXgLfeYQhjgZCccv71xvbDlwEhAXSoUDUvkNXAgdq
Lo+nxY8VBcxt+9q+dRCiprUOVrKF0kaHWm9UUc35MEJPrxu4Ce1bmS+oyaA2U2Tb
WJUN6k00ekpDbBClqHouNN4Q04xo0NdNkmXHlSjLm/G3zGeU6N3J6l7GLEdRIpQo
ndE46G/QptOfuVZ9/17WR8YhLvHCNtWRxiN/n/1yln3J/dcygNA0edlB4v+Vrs6C
3c42B9H1GERSb+wWZvt1VPGPAr+b1KrFYUZn0L6pTb1PJy6KCfuAWurYXMht/BYj
s3AtMrPXFXzHKyqnIiL72fo2kOhxYVtfXRJv1Uy4lhpT+Q8abakHEbFYLFtLEOA6
pYVxrKXqR7dNnYT7gdv7SwCI04tSp4zvmqrdy6+LYjebDMTKaaOAGi7Z8ULh9LSb
EKpq4+GtzKACwY+ihYflgXu+drpGys0BHvCWkAb7ok24H6suJYiKMisGW+RCyR4v
4Rp7ASrO
=xxaH
-----END PGP SIGNATURE-----

--un6gGEgKkm9lwvKd--
