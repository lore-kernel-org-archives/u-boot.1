Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B08C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 17:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D48C809D4;
	Fri, 28 Feb 2025 18:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I3nJ9fwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CA4809D4; Fri, 28 Feb 2025 18:08:53 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F42C809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 18:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2237cf6a45dso7559005ad.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740762529; x=1741367329; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tN+Sn3qTRycS+cg5sE10eDWGUofstmau4rTRKcGESRU=;
 b=I3nJ9fwBMoGjnmc8GdU0nEBshp0hS+6hKZt862qAPe/aik7a5AFhhHWFyCzVH1Zhqv
 CwQ6gXMym9oaAeXK2X0WPheaKl8WoDVnnchBEUlm63yJL/Qvul8VqMXgguKQOKol7Tkh
 6DSqT3fvt7B4PYojkUUdQ38pRp5t8/Dfve37g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740762529; x=1741367329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN+Sn3qTRycS+cg5sE10eDWGUofstmau4rTRKcGESRU=;
 b=dPGL6P4Fo1aEaWqyvr1j+bDCMcVoXcXIJaMFx8zO1aJiv0ohJ47spzAOmOI+seIhDS
 0IYncPFv2tdHuxQTazfFUACyX0yTr/l+3WdPHlprqF2KETqNuFMqSo66Xt1HhTJqnfTP
 Udu2Ln83o1G3VjYoASckfTpqsNbvw+aljk5yKbzfzIzp+1kFxCs21HfkYVMFkeoqD8Dm
 okz4+Cpjx8Jmz2jnymDPABHq5DZqD3OisQ7yhKLr0op8UJ5ZYSkNU20xvrDzGutWQ3Bg
 cmSIdKYmPkXlfUScnfLIpVbun5dCkdrXHGqnoa8eOdtnXBXXtMhLQEB2adog3+GhPd3y
 dY0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIbqOcBZBJQuAB13t0W6V6YVeYWtwQb0c5vBqTltV4fknL6IKYYifdcH3WNN6sRHId52v34Vw=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ1f3htpNHDznStgQq48PLdTHgQNOOx1zXcUTZ8IH4Nj4I8ffD
 AN+ddVAK+d7l6xxjekE9Zpml3bpgIZ4KO3bmTUDi2hcus/wT0i8GIN5Wu0KGJbA=
X-Gm-Gg: ASbGncvYOFFqXUBFgpIs72BzbzKJ9EDFhZsxSxoBPIxyFQwlsnwXrcKvBWU8+BBjTfy
 6kyUyXMfyh54c2B+J8Pmkgz0SI8WXJ3Ie/IDaUDLuAIaewun2ylEla8YF6mChGsRG/kh3Zimt9g
 tZOUBf70XRbge041giUe43jgwN4Z7nc7oDxwzRhWo4QqZQH0VdZ6AE1QQ8BFjrfYUFn8tZCRyi+
 zqCKxjZJkEeKc1myoVvCVADiwwW+6o6GRKA0Wt23YY8bg/zoFdgDdXpfbHf8WQTlxt/dnKgyWlf
 8KuxWBnbGYrb7evpRNQ3N0WG
X-Google-Smtp-Source: AGHT+IGqtKcuMH/9v1uZG8eV5AGuMIpwoODlbxY50LhNRUUlNoDxgsoYS3OLMoTaPDp+27dsWhmiYA==
X-Received: by 2002:a17:903:22c4:b0:223:62f5:fd44 with SMTP id
 d9443c01a7336-22369213f15mr71917605ad.40.1740762528647; 
 Fri, 28 Feb 2025 09:08:48 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f97bfsm36004745ad.85.2025.02.28.09.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:08:47 -0800 (PST)
Date: Fri, 28 Feb 2025 11:08:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: caleb.connolly@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] pci: dw_common: Set INCREASE_REGION_SIZE flag based on
 limit address
Message-ID: <20250228170845.GM2640854@bill-the-cat>
References: <20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-v1-1-33088c62600c@linaro.org>
 <e2a0da0e-6246-42c7-85c9-84a2097cf09d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hKgXM6QZxUK2sxij"
Content-Disposition: inline
In-Reply-To: <e2a0da0e-6246-42c7-85c9-84a2097cf09d@linaro.org>
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


--hKgXM6QZxUK2sxij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 04:27:06PM +0100, Neil Armstrong wrote:
> Hi,
>=20
> On 06/02/2025 09:49, Neil Armstrong wrote:
> > Set the INCREASE_REGION_SIZE for the outbound iATU entry if it
> > causes the 4GB range overflow in order to activate the extended
> > limit address by means of an additional iATU CSR (upper limit
> > address register).
> >=20
> > This is required to make PCIe host controller work on Qualcomm SoCs,
> > namely the SM8550 and SM8650.
> >=20
> > Based on the Linux commit 777e7c3ab7303 that can be found at [1].
> >=20
> > [1] https://lore.kernel.org/all/20220624143428.8334-5-Sergey.Semin@baik=
alelectronics.ru/
> >=20
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   drivers/pci/pcie_dw_common.c | 8 ++++++--
> >   drivers/pci/pcie_dw_common.h | 2 ++
> >   2 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
> > index 78961271a8eef8e4b6991675ee9de2bb1968b8da..5322f6bdaee450470d7f706=
bb4b4097a368ec455 100644
> > --- a/drivers/pci/pcie_dw_common.c
> > +++ b/drivers/pci/pcie_dw_common.c
> > @@ -78,8 +78,12 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw =
*pci, int index,
> >   				 lower_32_bits(pci_addr));
> >   	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> >   				 upper_32_bits(pci_addr));
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > -				 type);
> > +	if (upper_32_bits(cpu_addr + size - 1) > upper_32_bits(cpu_addr))
> > +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > +					 type | PCIE_ATU_INCREASE_REGION_SIZE);
> > +	else
> > +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > +					 type);
> >   	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> >   				 PCIE_ATU_ENABLE);
> > diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
> > index 8cb99a12ea1a5fd3687f980cc1ff99839d06dbc2..748945f95975e8251cdb92a=
670e8d5bc575d2847 100644
> > --- a/drivers/pci/pcie_dw_common.h
> > +++ b/drivers/pci/pcie_dw_common.h
> > @@ -46,6 +46,8 @@
> >   #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
> >   #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> > +#define PCIE_ATU_INCREASE_REGION_SIZE    BIT(13)
> > +
> >   /* Register address builder */
> >   #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
> >=20
> > ---
> > base-commit: b3c09eb36529fbb277bec17b35e638f42cb33683
> > change-id: 20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-87846=
5356c54
> >=20
> > Best regards,
>=20
> Gentle ping, this change is required to make PCIe enumerate
> on some the Qualcomm SoCs.

So I see this is config is use on:
am65x_evm_a53 bananapi-cm4-cm4io bananapi-m2s cm3588-nas-rk3588
coolpi-4b-rk3588s coolpi-cm5-evb-rk3588 coolpi-cm5-genbook-rk3588
imx8mm_data_modul_edm_sbc imx8mm_venice imx8mp_beacon imx8mp_dhcom_pdk3
imx8mp_venice iot2050 jaguar-rk3588 khadas-vim3_android_ab
khadas-vim3_android khadas-vim3 khadas-vim3l_android_ab
khadas-vim3l_android khadas-vim3l nanopc-t6-rk3588 nanopi-r3s-rk3566
nanopi-r5c-rk3568 nanopi-r5s-rk3568 nanopi-r6c-rk3588s
nanopi-r6s-rk3588s nova-rk3588s odroid-hc4 odroid-m1-rk3568
odroid-m1s-rk3566 odroid-m2-rk3588s orangepi-3b-rk3566
orangepi-5-plus-rk3588 orangepi-5-rk3588s phycore-imx8mm
qnap-ts433-rk3568 quartz64-a-rk3566 quartz64-b-rk3566 quartzpro64-rk3588
radxa-e25-rk3568 rock-3a-rk3568 rock-3b-rk3568 rock-3c-rk3566
rock-5-itx-rk3588 rock-5c-rk3588s rock5b-rk3588 sifive_unmatched
sige7-rk3588 soquartz-blade-rk3566 soquartz-cm4-rk3566
soquartz-model-a-rk3566 tiger-rk3588 turing-rk1-rk3588 verdin-imx8mp

I see a few of those are also amlogic boards, did you sanity test there?

--=20
Tom

--hKgXM6QZxUK2sxij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfB7ZIACgkQFHw5/5Y0
tyxRbQwAhC/rfr3JLpU8QgzULchR9w/uH7e8j0b3xd0adQtXgxUFvBQxvrXqnnz4
TeNaVtDPUk9qmntqynzoph6Dy3EnMIfkSEkt0hZhg4yLDmzKXr1+uiTepXsnX3v4
6zB96iaElkDc6pcl2olwkgWvOawFVEpMJM9gxBhpFYM6aHeHrhVcFihSoH/cCdJB
jW8ER1Pd2eWbuM4aVTs8Ulv1SU6+v0y9WzzM6ayEVj8+4vGFh9Q1DQO1keYMh6du
3klOzOj5L2iXH+B5G10alUVcAd7uXJel3dyBH7002vzjCOsz+exDEFKDc4apffKh
V7RuqiqRCQZ1BzBS+UXMuPEcAztem6atzZLUJbJp9OgBRFS3QOMYa2NZqtZuHNgn
WIhN1LwV9X2wGD5HtBP4wKjqJr0jKa6lb4UsfV3xhNPefue40CkzpXCrtDsw4lKG
8GsSWD7Ui5q7w0UBuHTCM4/tvTRojuvh8gi3Or7j3vO5eSGTEXf00q7QDdEDaRbV
ozt7aXka
=KUZC
-----END PGP SIGNATURE-----

--hKgXM6QZxUK2sxij--
