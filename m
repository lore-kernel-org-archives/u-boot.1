Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EFCF33A7F
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 15:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17CF839A8;
	Thu,  5 Mar 2026 16:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pbkvgt8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CC883E81; Thu,  5 Mar 2026 16:04:12 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C66A81E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 16:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40ede943bf0so1894631fac.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 07:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772723048; x=1773327848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7mCeWwR5soCY7ikMRuox95QeVreeQwZ2z1VDxaXmJZI=;
 b=Pbkvgt8IQvxs0oD6Jf2hOwWGX4E9u1iIAhSx3aaGDr8cDJT0HCkGwRH5OuP7043lNQ
 jcq3fR151gOILdZ3n7FTe2sxLVetqXpahfN89EL4FF2xBjbiFH6GTLOorgXVgW1sPT3N
 cHSbRMnbksj1eGfaQMQw9t37cSbThXzkIqRUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772723048; x=1773327848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mCeWwR5soCY7ikMRuox95QeVreeQwZ2z1VDxaXmJZI=;
 b=PT+aikToTN8cPGm7Y7ELfqhcNnVEWFpkwRjd0OtL65CWovz+aCMSDUIlJAKnG6iORa
 VdJ/Z4A/2hcPopnDHnyfNaTcXl+gW3qn3zjW59UsVA6ABvSEjEkr62IIPw8LggYn9goR
 TMstFuR6AcvLXn79Ah6yiOZP9Zgi0MmnRDA0Oe8DJtnqeiEoc0FdDdhwcyD+X3iFTyU+
 xTtiVgfzNMI1y2tAezRggZI+y2N26+QYqeJC14lpW+HxlugDO2AEtWjqr66cREOsVXgL
 w0Nn6F76Ysenbr/dfp2WVLQfbJdmgnQYYU87hS0Acnrmfn25ZSnrcWZUv+3HVus7ZQJg
 DIlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHKsL6WrevlS2Um9lD66pRcM3occLE3aPt6IMhDF/2GVSYirNKGjEnJWm2bUvxIYWRO9koEWc=@lists.denx.de
X-Gm-Message-State: AOJu0YwLWjgBAeI4Cc5kazaHbSLdNtXLqoMSlBazKcfssJAXbQTSQcjQ
 587n4qT46RE5mqELihaLHZvyXpgNqj/FNYPpBiVf1GTI13+umzy55oHjl96EnwavWSM=
X-Gm-Gg: ATEYQzxAKPh5zNSruKGmptJvPURasGysOlTuxyvwWyLFIU6E157FUADenjfqoi0+fdr
 cMqB/K+64qTkBCp+ALV3w8Bjr9J8/y1SR5eJ+chqtXbLBLVkbS2WbQ/cfUKxZK9i3UOuiZhUD+4
 UY/GGegAfJjpWybfaPoaKIlQup1uM1tpsSxL8tUXmILIwNEwkAYLx8uJDIB83SWm9kODINwqE9m
 0lHlggMnTQnSKLED6Ipn1Yrpp71dPCxBYSKkfaACoZ8M5o2IrY74fg6GhdPe5N0FTqPy3OxWG+4
 qgs3vbWngk6GoqsAPzyTlpRsH1ebUAee1+5CeAf3pgdyiSbwEpWMGDY1pjwPWNduK6P9sja5L+A
 eHvl/hOXSLzX+M1OKNbZhoQQKsoLV52Yrr2wvfhaET8gLD09jG/VTAgLFIhw8y/y5hAfGNLPPdb
 D3nfZunz+Sh8/TzpskFCD5XVp3706HR8J4/Hrwl9YrkFOX408NprFEIffieQQwYXUF4vgpfAUZK
 Xwpb6jEKJpMI5GyJ/dO1m1oHgYd6dB18tKseQxOEsBo64bcFsP2xkNg+fKIpA==
X-Received: by 2002:a05:6870:350:b0:3ff:46a0:a25a with SMTP id
 586e51a60fabf-416ab5d9706mr3804481fac.4.1772723047870; 
 Thu, 05 Mar 2026 07:04:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf259a7sm20797681fac.3.2026.03.05.07.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 07:04:07 -0800 (PST)
Date: Thu, 5 Mar 2026 09:04:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: m-chawdhry@ti.com, c-vankar@ti.com, neil.armstrong@linaro.org,
 marek.vasut+renesas@mailbox.org, u-kumar1@ti.com, j-keerthy@ti.com,
 semen.protsenko@linaro.org, afd@ti.com, anshuld@ti.com,
 peng.fan@nxp.com, mkorpershoek@kernel.org, n-francis@ti.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH v5 00/10] Add PCIe Boot support for TI J784S4 SoC
Message-ID: <20260305150404.GD1388590@bill-the-cat>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260304185113.GC1388590@bill-the-cat>
 <b0d3eb09-add7-4a14-98d2-84061adf9fdf@ti.com>
 <5fa4af89-41a7-4e0a-9921-6881a33d0a09@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2R3+YWztcc85Rc6S"
Content-Disposition: inline
In-Reply-To: <5fa4af89-41a7-4e0a-9921-6881a33d0a09@ti.com>
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


--2R3+YWztcc85Rc6S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 04:10:39PM +0530, Siddharth Vadapalli wrote:
> On 05/03/26 11:27, Siddharth Vadapalli wrote:
> > On 05/03/26 00:21, Tom Rini wrote:
> > > On Mon, Feb 16, 2026 at 03:58:28PM +0530, Siddharth Vadapalli wrote:
> > >=20
> > > > Hello,
> > > >=20
> > > > This series adds PCIe endpoint boot support for the TI J784S4 SoC.
> > > > Series is based on commit
> > > > f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boa=
rds
> > > > of the master branch of U-Boot.
> > > >=20
> > > > v4 of this series is at:
> > > > https://patchwork.ozlabs.org/project/uboot/
> > > > cover/20251201110103.845413-1-h-salunke@ti.com/
> > > > Changes since v4:
> > > > - Addressed Udit's feedback:
> > > > =A0=A0 i) Patch 6 has been updated by limiting changes to disabling
> > > > CONFIG_SPL_PCI_ENDPOINT
> > > > =A0=A0=A0=A0=A0 and CONFIG_SPL_PHY (CONFIG_PCIE_CDNS_TI_EP,
> > > > CONFIG_SPL_PHY_CADENCE_TORRENT and
> > > > =A0=A0=A0=A0=A0 CONFIG_SPL_PHY_J721E_WIZ don't need to be disabled =
as
> > > > pointed out by Udit).
> > > > =A0=A0 ii) Commit message of patch 8 has been updated to indicate
> > > > that although PCIe Boot
> > > > =A0=A0=A0=A0=A0=A0 is supported in Hardware for J742S2 SoC, it is n=
ot yet
> > > > enabled in Software.
> > > > =A0=A0 iii) Documentation in patch 10 has been updated with complete
> > > > set of device-tree
> > > > =A0=A0=A0=A0=A0=A0=A0 changes included and the C Program to transfer
> > > > bootloaders has also been
> > > > =A0=A0=A0=A0=A0=A0=A0 simplified and documented with the usage of a=
ppropriate
> > > > variable names.
> > > >=20
> > > > PCIe Boot Logs (J784S4-EVM running Linux as Root-Complex transfers
> > > > bootloaders to another J784S4-EVM configured for PCIe Boot):
> > > > https://gist.github.com/Siddharth-Vadapalli-at-
> > > > TI/2d157003818441fe79a139d0dec1058a
> > >=20
> > > With current next this introduces a failure to build on j784s4_evm_a7=
2.
> > It builds for me without any issues. I have checkout out to next:
> > c0ca147ac62 Merge tag 'u-boot-imx-next-20260228' of
> > https://gitlab.denx.de/ u-boot/custodians/u-boot-imx into next
> > and don't see any issues when building A72 SPL / U-Boot proper for J784=
S4.
> >=20
> > Could you please share the build error that you are observing? Or is it
> > a warning being treated as an error?
> To fix the warning associated with 'subclass_code', I have posted the
> following patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20260305103815.999886-1-=
s-vadapalli@ti.com/
>=20
> Assuming that the above is the fix for the same build failure that you we=
re
> referring to, please let me know if the fix can be taken along with this
> series.

Yes, lets see where that goes, thanks.

--=20
Tom

--2R3+YWztcc85Rc6S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaambYQAKCRAr4qD1Cr/k
Cs97AQD5jh9h+m2QqgDy7oX2DVUeHzOnu8W9UdKhSFaZPE46AQD/aTUzU3ZeZktw
qObQXZR4rxp6sdmM/LaC9jAOkQQvGAA=
=dLDz
-----END PGP SIGNATURE-----

--2R3+YWztcc85Rc6S--
