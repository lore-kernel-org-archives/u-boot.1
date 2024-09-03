Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7188FCD37AC
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 19:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC78688381;
	Tue,  3 Sep 2024 21:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NW6kVWPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D7C88381; Tue,  3 Sep 2024 21:53:56 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD68988B9F
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 21:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf90d52e79so30096616d6.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725393232; x=1725998032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L2IH8PdmBh8cslQnVhLvfl7Q881IwJ95Vb9TZwEzuGY=;
 b=NW6kVWPPmUQrwF8gwKhu35zAW1wz5Fos19rRmNSEpJGi7qhxFuiDH0AQCp63Zg98qP
 DDOh3GXQKOHLQdYQHJBuAKp1284cOBGhNvKCChSQFesW20ECOHpBwf1sF1Mc4XFm8ptx
 R7g1rJGakO2wb1Kg116Vl3sOBzPJATH8ISaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725393232; x=1725998032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2IH8PdmBh8cslQnVhLvfl7Q881IwJ95Vb9TZwEzuGY=;
 b=IpMDWJ+eCoWeX4tf5SZw8LNHTCF9+JmEWrL4ynHRQN8fm5xRzPwNVY5jxFHOdGKkAc
 SAWzdNju/SYnGL4V2zj/pNV6ux/MRlhqrSzi5S5eW6E+UEeTNBtxQiAwORwrxl8xFxvx
 BVnOo/TRW+POVyo9kMLOjyZn+Ghw6Fvpl60Evd8PFzb/rewtBueEU0/T6FSFZedTAflq
 ooROBgi87ocxjLnDy/FVdA0qZNItwVb/bVvuOerjI8VbIfk9mMHCGT6Mr5IQhz51VC1S
 VvKDk0jpP2votDU3o99C1xnsvMYJ0eozdYYbU2pv0s46u+Kt4D+xjcv54QMn54nqZlI0
 nAiQ==
X-Gm-Message-State: AOJu0YwIpyGFSgowwpAkXs7p+fqVycp8uyRLgoOL90fJzyyLJNzXY2Gy
 UUV57YldgOlcACzf4JbUAa0RDlLyiFWc2h3VnrA1LOhGq/ffz8ZX0Net/27F1Ao=
X-Google-Smtp-Source: AGHT+IGr9YINcM3fwwbQFW+h/LS6U64C98a08KxxZffJCG3cV4dO+yf7vX/XL7kcNh4PWFqqvM1VLQ==
X-Received: by 2002:a05:6214:4a81:b0:6c3:5be4:cd54 with SMTP id
 6a1803df08f44-6c3c5be5a1amr54753476d6.18.1725393232404; 
 Tue, 03 Sep 2024 12:53:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340bff43csm56712976d6.33.2024.09.03.12.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 12:53:51 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:53:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Prasad Kummari <prasad.kummari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com,
 venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
Subject: Re: [PATCH 1/2] kbuild: Add generic rule to apply fdtoverlay
Message-ID: <20240903195348.GO2479150@bill-the-cat>
References: <20240903115152.430335-1-prasad.kummari@amd.com>
 <20240903115152.430335-2-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lX6ufxgJzp9wVSz3"
Content-Disposition: inline
In-Reply-To: <20240903115152.430335-2-prasad.kummari@amd.com>
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


--lX6ufxgJzp9wVSz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 05:21:51PM +0530, Prasad Kummari wrote:

> Add a generic rule in Makefile.lib to automatically apply
> fdtoverlay, so that each platform doesn't need to include
> a complex rule. This also automatically appends
> DTC_FLAGS_foo_base +=3D -@ to all base files.
>=20
> The platform's Makefile only needs to have this now:
>=20
> foo-dtbs :=3D foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
> dtb-y :=3D foo.dtb
>=20
> The suffix-search macro hard-codes the suffix, '.o' and
> multi-search and real-search macros can be used for foo-dtbs,
> multi-dtb-y is a list of DTB constructed overlays, and base-dtb-y
> contains a list of base dtb.
>=20
> Reference:
> https://lore.kernel.org/all/20920b0df6b067aca4040459a9677d7d1d6d766a.1615=
354376.git.viresh.kumar@linaro.org/
>=20
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>

This really needs to be rephrased to be clear that you're
cherry-picking:
commit 15d16d6dadf6947ac7f9a686c615995c5a426ce2
Author: Rob Herring <robh@kernel.org>
Date:   Wed Mar 10 11:05:30 2021 +0530

    kbuild: Add generic rule to apply fdtoverlay

out of the Linux kernel. We have other cherry-picks, just look at git
log on scripts/Makefile.lib.

--=20
Tom

--lX6ufxgJzp9wVSz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXaUgACgkQFHw5/5Y0
tyxrcQwAgtfFXO4psnoYQUiyLpROqMJkRketCjTvAmoQzBKibbxlCJ0m1+JJbP4+
gmnB0w3xHXkTlzHFp7h2l5sVJHjbxdMRrCET89Aii0eEQ8AmGllXRJvPsG5d1L8/
X4FAlfm1KhHKionN8XEH5PRQOrf6L29XeqpwjZkfp2EaVF78VNt1LgIrLMCvXbrT
6o311uIj9sHrlAklTkbTp1/XnYTfH2VhVOaa3gxxHWDgf+q+te/Bc1fesP9oTZPf
zREnkg+e4kfsqIGLxMtqZBazTfCde5gkt5nu6/4xe5PmU6fgw6a4zAho7yAuEQuD
rSogqAXY5NXdZykugQDaruKzMQoAIMCX+FdW3YoUxJ0Cz8Ol5bPz2nkGBnsWyYwq
ufgG4ZEUIXyswB1zrvrhBozPxK/txpvb/W4MugB++ciXW2zkWmWBmvqT6Un74XP7
OQHdjdKWOGFADsDXTYDSR989yr9rQY6KFm3jvUlD8xAVqWOyldH98Ue8ktRLcUmL
76zbvf//
=aRwA
-----END PGP SIGNATURE-----

--lX6ufxgJzp9wVSz3--
