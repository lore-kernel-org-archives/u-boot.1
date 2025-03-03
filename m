Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79F1C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 16:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19945811C1;
	Mon,  3 Mar 2025 17:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FQB5HzTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA829811DF; Mon,  3 Mar 2025 17:43:59 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003CE811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 17:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso5196144276.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 08:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741020236; x=1741625036; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DzkleEojhzUylPEc0KLcxa+0MImiaA+WC7abBrlNRn4=;
 b=FQB5HzTaxwloO/MKvFplTGZSpVyZ1ASjdYe4TyxOmWu6SBbyuSLFfA7UKIT2OU+Q61
 hU4WfyEgkXnSBBfQmXfTp3j7j3HhFtGuXr25Md+1Nk3CWt3V+p1xr6ER8AnsayqZgF0J
 wG0DWMS6RT7l9jkbR1Tcqx9N2p5yfHUVzZdSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741020236; x=1741625036;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzkleEojhzUylPEc0KLcxa+0MImiaA+WC7abBrlNRn4=;
 b=g3iAWVgeGlLGgUDwd+vOA/V9s5hl3DH3kQ88GW7moecHX82G4Hi9AJ4gg4SueVpIro
 OLYznXZI8hiO87ipS7fCgMc5w2/TMtJQ/9+N1hGfRDAxga/lw4ZNcey/ePezGIulQ/bU
 VWNQqAxHB8r5i5F9HsW9lwZVkHDv4A6O3tpJBVjR1ChGltadrQAa3lEuFJOxvGDKLphG
 JRJZQaoMhKOsgyWa4CyvfVMAopEf8D9YxWh4gYrLXq5hIWINi5fQS/x//AYKgyST5pYv
 gqn3FBROlYtncKSYniNyo6EeYTQ4e5vrPqsfODsBPIBGSEzrbYgp7XOhAGWlNnqsGhCh
 IKrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXWa21Dkkj/On2mGo4SOkQ0sHNoHZBrhjZ8lpMVlkq6zXspVhTeYYPt3NPr9lpLH86eaxhv44=@lists.denx.de
X-Gm-Message-State: AOJu0YxQ6a/8zhfwH3ztR/cQz4D3/fJTGvxxfLV8TFLAVxv+0/lE1nMb
 4U2dKVnXtRu3qA1CDZzNwM0tHigYdA46zEojO6A/ATVJdxhhbFkfGlAqRjYlt1A=
X-Gm-Gg: ASbGncuLagNyiXWPskAZXNdTApsA4yj9rU2jbDB5FjOIe/q9pW0ZGC/A4VvnERkOXWq
 KVSd5BZ7SWXGqie2712ni6BlFuIajv60mFt6PaVHdMkmYrZePtTR78Un4WsnuzCsZhJAhMMYoNB
 zcP3Su2k0X+72StA50r8BzRc3Y3jqK4IqKpWI5rtKeQHneub0A2RmMl1puFxTDkljdAFQJKYtpK
 GYeIQOX7bMqgATuxRPo+uB8uIAx7updQhYplD5ePqOX/DSgNqkZgVHRlDNVEaiw0b1LVnroWR/J
 o9D3ltwkXgoBgaAW9hLQd838142akUtKPvo1gwLzeW0=
X-Google-Smtp-Source: AGHT+IE3PmYmNGIpc9HrW9W2ikwZiEweaB3EHkhkrYka4eGrZ96m6M1KdjHaJCNudU2lbSJrPf104Q==
X-Received: by 2002:a05:6902:2191:b0:e60:8c90:d8ae with SMTP id
 3f1490d57ef6-e60b2f18627mr15565274276.37.1741020235794; 
 Mon, 03 Mar 2025 08:43:55 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3aa4c8dsm3038499276.44.2025.03.03.08.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 08:43:55 -0800 (PST)
Date: Mon, 3 Mar 2025 10:43:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: caleb.connolly@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] pci: dw_common: Set INCREASE_REGION_SIZE flag based on
 limit address
Message-ID: <20250303164352.GR2640854@bill-the-cat>
References: <20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-v1-1-33088c62600c@linaro.org>
 <e2a0da0e-6246-42c7-85c9-84a2097cf09d@linaro.org>
 <20250228170845.GM2640854@bill-the-cat>
 <ccdc2594-76f9-44b2-ab39-da310eee69cd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bqAotxUA1IzxM8wa"
Content-Disposition: inline
In-Reply-To: <ccdc2594-76f9-44b2-ab39-da310eee69cd@linaro.org>
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


--bqAotxUA1IzxM8wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 04:18:38PM +0100, Neil Armstrong wrote:
> On 28/02/2025 18:08, Tom Rini wrote:
> > On Fri, Feb 28, 2025 at 04:27:06PM +0100, Neil Armstrong wrote:
> > > Hi,
> > >=20
> > > On 06/02/2025 09:49, Neil Armstrong wrote:
> > > > Set the INCREASE_REGION_SIZE for the outbound iATU entry if it
> > > > causes the 4GB range overflow in order to activate the extended
> > > > limit address by means of an additional iATU CSR (upper limit
> > > > address register).
> > > >=20
> > > > This is required to make PCIe host controller work on Qualcomm SoCs,
> > > > namely the SM8550 and SM8650.
> > > >=20
> > > > Based on the Linux commit 777e7c3ab7303 that can be found at [1].
> > > >=20
> > > > [1] https://lore.kernel.org/all/20220624143428.8334-5-Sergey.Semin@=
baikalelectronics.ru/
> > > >=20
> > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > ---
> > > >    drivers/pci/pcie_dw_common.c | 8 ++++++--
> > > >    drivers/pci/pcie_dw_common.h | 2 ++
> > > >    2 files changed, 8 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_com=
mon.c
> > > > index 78961271a8eef8e4b6991675ee9de2bb1968b8da..5322f6bdaee450470d7=
f706bb4b4097a368ec455 100644
> > > > --- a/drivers/pci/pcie_dw_common.c
> > > > +++ b/drivers/pci/pcie_dw_common.c
> > > > @@ -78,8 +78,12 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie=
_dw *pci, int index,
> > > >    				 lower_32_bits(pci_addr));
> > > >    	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > > >    				 upper_32_bits(pci_addr));
> > > > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > > > -				 type);
> > > > +	if (upper_32_bits(cpu_addr + size - 1) > upper_32_bits(cpu_addr))
> > > > +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > > > +					 type | PCIE_ATU_INCREASE_REGION_SIZE);
> > > > +	else
> > > > +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > > > +					 type);
> > > >    	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > > >    				 PCIE_ATU_ENABLE);
> > > > diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_com=
mon.h
> > > > index 8cb99a12ea1a5fd3687f980cc1ff99839d06dbc2..748945f95975e8251cd=
b92a670e8d5bc575d2847 100644
> > > > --- a/drivers/pci/pcie_dw_common.h
> > > > +++ b/drivers/pci/pcie_dw_common.h
> > > > @@ -46,6 +46,8 @@
> > > >    #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
> > > >    #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> > > > +#define PCIE_ATU_INCREASE_REGION_SIZE    BIT(13)
> > > > +
> > > >    /* Register address builder */
> > > >    #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
> > > >=20
> > > > ---
> > > > base-commit: b3c09eb36529fbb277bec17b35e638f42cb33683
> > > > change-id: 20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-8=
78465356c54
> > > >=20
> > > > Best regards,
> > >=20
> > > Gentle ping, this change is required to make PCIe enumerate
> > > on some the Qualcomm SoCs.
> >=20
> > So I see this is config is use on:
> > am65x_evm_a53 bananapi-cm4-cm4io bananapi-m2s cm3588-nas-rk3588
> > coolpi-4b-rk3588s coolpi-cm5-evb-rk3588 coolpi-cm5-genbook-rk3588
> > imx8mm_data_modul_edm_sbc imx8mm_venice imx8mp_beacon imx8mp_dhcom_pdk3
> > imx8mp_venice iot2050 jaguar-rk3588 khadas-vim3_android_ab
> > khadas-vim3_android khadas-vim3 khadas-vim3l_android_ab
> > khadas-vim3l_android khadas-vim3l nanopc-t6-rk3588 nanopi-r3s-rk3566
> > nanopi-r5c-rk3568 nanopi-r5s-rk3568 nanopi-r6c-rk3588s
> > nanopi-r6s-rk3588s nova-rk3588s odroid-hc4 odroid-m1-rk3568
> > odroid-m1s-rk3566 odroid-m2-rk3588s orangepi-3b-rk3566
> > orangepi-5-plus-rk3588 orangepi-5-rk3588s phycore-imx8mm
> > qnap-ts433-rk3568 quartz64-a-rk3566 quartz64-b-rk3566 quartzpro64-rk3588
> > radxa-e25-rk3568 rock-3a-rk3568 rock-3b-rk3568 rock-3c-rk3566
> > rock-5-itx-rk3588 rock-5c-rk3588s rock5b-rk3588 sifive_unmatched
> > sige7-rk3588 soquartz-blade-rk3566 soquartz-cm4-rk3566
> > soquartz-model-a-rk3566 tiger-rk3588 turing-rk1-rk3588 verdin-imx8mp
> >=20
> > I see a few of those are also amlogic boards, did you sanity test there?
> >=20
>=20
> Not yet, I'll have a test run.

Assuming it's good there, the qcom tree is fine to take this in.

--=20
Tom

--bqAotxUA1IzxM8wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfF3DwACgkQFHw5/5Y0
tyyO4wv/anlUNiLXQocfAZXXm7OKkMcCs9UDgDEXbSXm2oJR3avPNe7gOV/K1YNY
nDk6Lx7EyK2E71+IMwCHOvhAVXMcrXDh6vn35MDd2Nx7F2dAREh05BhO6fQlXfs3
1g2hfnLQA/e3jh2211LiReKd7qBKKx1NAZUIl5Mt0recBLA+z99y6Vq1Tt+tBDK0
KZpMu7l8oM7Cdulz0oMCJWW7JQ4pOpqjMe9bmyDAvFPRmxwFmUNUgP2AhHjIUnVv
WI2iyICyrKf9YK4IMkkMe3Qh4B8G8+Jcgu9xYj2YbRMseWCZDReri+FHW0SrJv5z
/rMTSMHM6BQ4BEBZeiXT79emiQkpHpx3ntWmrLCRvOBxe51nrD2O8iOAnOhW3lCL
3T/lDmC8NO2wQCfDJBmWncg+WruAUYQ0AGdeOr157VsqG3QySq6lLCkCnlAA8FO8
hyxE6apVdnbxLCA/9OG66lhIwbGr2waMob3+ItdeviO++2X2TpVac+4+CCJ+FDf8
JAmHwrDi
=n+yO
-----END PGP SIGNATURE-----

--bqAotxUA1IzxM8wa--
