Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F27D0EE3F
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7943F89435;
	Sat, 12 Oct 2024 03:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FhNbYN0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4A98941B; Sat, 12 Oct 2024 03:15:13 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1728C89435
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-460407b421bso19934941cf.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728695709; x=1729300509; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lyu0n1/hUZq8kMjS/WzoYBxZRGKhDJ7bZMrxzgFNs3M=;
 b=FhNbYN0HZySbbL49+y9hmhr65/XskIy48bzcQG/47yEQ5JBMsGZUK49CDbAG3xYbv5
 RQjD9Jk5R+NwwHLfgq09gHFBu04mVpm8X6Vf/R0/0YC01pZkBP56DQ6ZeXFjJhzPG36K
 bui6IOJeYxiyTEaSG6V3F/Mair4VEuxS8Fh48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728695709; x=1729300509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lyu0n1/hUZq8kMjS/WzoYBxZRGKhDJ7bZMrxzgFNs3M=;
 b=Qu2U+yemmoXxVjKg0C///NcV7QV4WcCKy/po405WPR/nqJeeFjv0NBvyVjwi3JDuuy
 n33woQ3QCypHmv1+YpIOviP2qxLIc6hY9Mj5MDTr4eOPm22MwRSPJnTrmao6cuAbBB5a
 QkKea5CNxXspmnJL5ZrP6yYLawmFJaTf7dUtetJanBeVJmYoD6PfI8cMkrrXKILZjglq
 w+7CSBfi6+Yr5H6iWGaJsEOrAIyqEXjGgonwQrrmhF+SbqCCt3fbcTOHNfFfoO7uAR+I
 N1tggSBBTKzGVqsGXisf5R08pZLvNnWnLTNphXkp1z0ykkJ6xK0Sp+8/OEK7ejMUsxBH
 1GdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX0P9YMatFT+rhj9gO+Sq5ubmngX7JuR5x2MGTCG9GSG5AGOjdpdO9bgHYb/vz1ba77UHKgKI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywuo2KYaCStLmxKENuukNtt1+ThZZSIAuRY4Bzfo+9XQXG5DjSF
 BDfjMKAyBeMeNyQh38YsVlHw2mVVQCrFI5cHufeJmv/7Hq7zsfyRASys0NdhNfg=
X-Google-Smtp-Source: AGHT+IHxnktfLHM0hIccyZN4TFt6IEsfOjvPI6Svka5XoTHoXxT15pgSCzTtKr5DvxarlC+WkTEfEw==
X-Received: by 2002:a05:620a:1d04:b0:7b1:1be6:78d0 with SMTP id
 af79cd13be357-7b121a08feamr159128085a.36.1728695708927; 
 Fri, 11 Oct 2024 18:15:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148d80a4sm186056285a.44.2024.10.11.18.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:15:07 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:15:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, n-francis@ti.com, a-limaye@ti.com, seanga2@gmail.com,
 sjg@chromium.org, marex@denx.de, john@phrozen.org,
 ansuelsmth@gmail.com, sumit.garg@linaro.org, u-boot@lists.denx.de,
 vigneshr@ti.com, srk@ti.com
Subject: Re: [PATCH v2 1/2] pci: Add TI K3 Cadence PCIe Controller
Message-ID: <20241012011503.GC14210@bill-the-cat>
References: <20241011130258.3452687-1-s-vadapalli@ti.com>
 <20241011130258.3452687-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bCXsS9thwPOlja3N"
Content-Disposition: inline
In-Reply-To: <20241011130258.3452687-2-s-vadapalli@ti.com>
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


--bCXsS9thwPOlja3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 06:32:57PM +0530, Siddharth Vadapalli wrote:
> Add support for the Cadence PCIe Controller present on TI's K3 SoCs.
> This driver is an adaptation of the Linux driver.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/Kconfig        |   6 +
>  drivers/pci/Makefile       |   1 +
>  drivers/pci/pcie_cdns_ti.c | 851 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 858 insertions(+)
>  create mode 100644 drivers/pci/pcie_cdns_ti.c

Please update MAINTAINERS somewhere for this.

> +#define CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7

Here and maybe elsewhere, why the inconsistent indentation?

--=20
Tom

--bCXsS9thwPOlja3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJzZQACgkQFHw5/5Y0
tywxiAv/ZuNeWGP7NiqqmoDMdTxqYrn/+OWsWVhuxLeBOqZKN9HKuWj7ylDLMAuc
yyzx546NDrNW1bexg/8meUQgF5NNvS+bIzqBgkUzb3thDlIZNty/YpoL5WmV7KO5
2YkCGzmqf7Rk1yzKnW4ii2dug1UebctLZ/Wnhll6wH5330wFvR3w7g0oTb4/Lml0
xDUoMC6Z7E8cHBQ+395T2etcmeZVHiVmoowwwG+CdHLPQwJKQTSoGIx2pJIbBlG7
UkgyRCF/Qi0+A50gk83hg8o6JUJIjKh0ji+aLJqyQsDaH9Bv5jntHpwNgV64Rjer
9eMETbJMM4br6iz8v/LoqZYdpNn0+FMLcVNrHUCpIGVp7XxjHNXCoQWkBc5Y8Ygx
de4Pujh4SNKzz4pwKBqZ9rSTkuOcz2VzI9hMFAa0tePrSCd7fQ6chaZCafEeGKzQ
GkrEGSFDQIQalHdrQA1GtZBlKaojRcGArvgIXqsfYmhdPK5ivjVOInF2lTZQl3Fw
x1lSVlWM
=KvvL
-----END PGP SIGNATURE-----

--bCXsS9thwPOlja3N--
