Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B059EC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366AB8836A;
	Wed, 17 Apr 2024 13:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="T/YrwDhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928078840D; Wed, 17 Apr 2024 13:28:56 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A898E881DD
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240417112849epoutp0485ecb6484cccc0ea4a65f4280f5ceeed~HDcaZYcr91867018670epoutp04V
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240417112849epoutp0485ecb6484cccc0ea4a65f4280f5ceeed~HDcaZYcr91867018670epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713353329;
 bh=Qjbss+qABY3BVAtImFTk9CNQnTQMpDC34Rkm3cstL0k=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=T/YrwDhnYCaEYkXr3wS3muXXF1hLEcT0Yfh8cDLfanYQnmlas4OwaRy98eSlCYgFb
 mKfTB7Uj8K2nCoXLm8ho38dDki83iQs5FxTD0kWudFH8BptLqRQRZFuO5bO2tMH1Aw
 mFx5MX3VjCFxu6aXvURY4hLXrwZc0Xka10AosQfg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240417112849epcas1p3a09dfaee43bc043b0772ae1012d97753~HDcZ7Yf-z2312123121epcas1p3f;
 Wed, 17 Apr 2024 11:28:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.135]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VKJZS2mQ0z4x9Px; Wed, 17 Apr
 2024 11:28:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 06.4E.09662.072BF166; Wed, 17 Apr 2024 20:28:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240417112847epcas1p2bf8bcb4f35637dc47d4f58bd8c36ed6e~HDcYm82k30180901809epcas1p2D;
 Wed, 17 Apr 2024 11:28:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417112847epsmtrp2ae3e8fc1b09cbbc82b066cea094fbbde~HDcYmMWKD1422614226epsmtrp2q;
 Wed, 17 Apr 2024 11:28:47 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-ea-661fb270cbde
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6E.FC.08924.F62BF166; Wed, 17 Apr 2024 20:28:47 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417112847epsmtip220df793f4748988576d7405ea2c72a5d~HDcYZwG9y1424014240epsmtip2g;
 Wed, 17 Apr 2024 11:28:47 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Judith Mendez'" <jm@ti.com>, "'Peng Fan'" <peng.fan@nxp.com>, "'Tom
 Rini'" <trini@konsulko.com>
Cc: "'Nitin Yadav'" <n-yadav@ti.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20240415212747.2678974-3-jm@ti.com>
Subject: RE: [PATCH 2/5] mmc: am654_sdhci: Fix OTAP/ITAP delay values
Date: Wed, 17 Apr 2024 20:28:47 +0900
Message-ID: <01fc01da90ba$69fa7770$3def6650$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG5/NRqE0+DtqCkK0jpqvLeJwVynAHTLt3lAk0WqUCxjHUKQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmnm7BJvk0g4lrBS0+fci0+Nx0hNni
 x6ovrBbftmxjtJg6aTO7xdu9newObB6zGy6yeLw6sIrd4+ydHYweG9/tYPI4fmM7UwBrVLZN
 RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
 QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjKv9
 R9kKPshUbGybw9rA2CrVxcjJISFgItG75RxjFyMXh5DADkaJYz1T2SCcT4wSp+ZMZ4JwvjFK
 dO/fxwjTsunXTKiqvYwSvU9boZyXjBK7Ls8Hq2IT0JP4v2ghM4gtIpAu0b7tFZjNLJAk8erC
 XiYQm1PAUGLzy2msILawgKvEyjnn2UBsFgFVia+re8BsXgFLiV+v/kHZghInZz5hgZijLbFs
 4WtmiIsUJH4+XcYKsctJYuvNF+wQNSISszvbmEGOkxDo5JA41XqfFaLBReLZuj4WCFtY4tXx
 LewQtpTE53d72SAamhklli45yArh9DBK/Gu4zgZRZSyxf+lkoBc4gFZoSqzfpQ+xjU/i3dce
 VpCwhACvREebEES1isSl1y+ZYObfffIf6gYPiYuz3zNNYFScheS3WUh+m4Xkh1kIyxYwsqxi
 FEstKM5NTy02LDCEx3dyfu4mRnD61DLdwTjx7Qe9Q4xMHIyHGCU4mJVEeFuEZdOEeFMSK6tS
 i/Lji0pzUosPMZoCQ3sis5Rocj4wgeeVxBuaWBqYmBkZm1gYmhkqifOeuVKWKiSQnliSmp2a
 WpBaBNPHxMEp1cAUmdjAY7sgokbX486OJV/XKK+6u0OYVfyVsfLiszfuKBX6b1gWNFmDi3va
 O26NL183us7Uqt/Kyn7hucrqj/ErflT/UT7Ot2Lh7ksTz71aXqHD4VmseZhR0j1zbcAvmXWc
 a2SiI+MvXdwgbWrGHa1syGN3/NjJh19l+2y2R1+7Pv/qtymlLFW350VLC6/J+qy+LLb/lviR
 VYndQk7iVnNCfx7hvtiYIKal1jUjP29BmuVtfZFlb2bOe/LYJE550sJ1L/T795Vcu1YcveZZ
 jmzXq7n+XAziEUebVwe/6c7pyT/CoMrifVouOVfq+sEPbfPsu48caOH4NfPY18x7k1pdU9kT
 nLadPCvAdGeuPk+pEktxRqKhFnNRcSIA0ARgrCgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvG7+Jvk0g1vLjS0+fci0+Nx0hNni
 x6ovrBbftmxjtJg6aTO7xdu9newObB6zGy6yeLw6sIrd4+ydHYweG9/tYPI4fmM7UwBrFJdN
 SmpOZllqkb5dAlfG8QNT2Qpuilfsm+HRwDhPuIuRk0NCwERi06+ZbF2MXBxCArsZJbasmskK
 kZCS+Px0KlCCA8gWljh8uBii5jmjxPWdu5hBatgE9CT+L1rIDFIjIpAp0TkvFiTMLJAi8fXP
 VFaI+uWMEr1r77OBJDgFDCU2v5wGNl9YwFVi5ZzzYHEWAVWJr6t7wGxeAUuJX6/+QdmCEidn
 PmGBGKot8fTmUzh72cLXzBB3Kkj8fLoMbKaIgJPE1psv2CFqRCRmd7YxT2AUnoVk1Cwko2Yh
 GTULScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBEaSluYNx+6oPeocYmTgY
 DzFKcDArifC2CMumCfGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2aWpBaBJNl
 4uCUamDi3TPBTOiDhUuGWfqdi6F+rk3Lnk5Z2zj95syOr/K9xq5p/I2vJx6T6Pb/Fv5ZLbhm
 +6e6IDd1hp17Jh9+8ZT3gl1LsJJtnfT0kr33XTqK7/82Y32k0vz8k/1WoY+erdK7N4skLH0X
 cjIrx2zP7feFNUXfj9+w8sxayPk889KNpSf/snqtn3zT6PKtibkGMZusP06sv3/90tsTd3Rj
 f68ti7DbYeGtLfwxvOPUNAFdte6Jbc9eJWTdXaZ2f8ZlSYelM976LTvoKb/7p5vAj3NqE/d9
 TvlUUbaXSft64YPzv6rFJ4os8nob9fLo5TOvxZYGFFyz3brdNMewkGez7H0pBWOzv0ZGm+MM
 Lhs/YZ4Zr8RSnJFoqMVcVJwIAHj+nUQPAwAA
X-CMS-MailID: 20240417112847epcas1p2bf8bcb4f35637dc47d4f58bd8c36ed6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415212757epcas1p40385fb3e4dcb16a7478184bcfe936e92
References: <20240415212747.2678974-1-jm@ti.com>
 <CGME20240415212757epcas1p40385fb3e4dcb16a7478184bcfe936e92@epcas1p4.samsung.com>
 <20240415212747.2678974-3-jm@ti.com>
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

Hi Judith,

> -----Original Message-----
> From: Judith Mendez <jm=40ti.com>
> Sent: Tuesday, April 16, 2024 6:28 AM
> To: Peng Fan <peng.fan=40nxp.com>; Jaehoon Chung <jh80.chung=40samsung.co=
m>; Tom Rini <trini=40konsulko.com>
> Cc: Nitin Yadav <n-yadav=40ti.com>; Simon Glass <sjg=40chromium.org>; u-b=
oot=40lists.denx.de
> Subject: =5BPATCH 2/5=5D mmc: am654_sdhci: Fix OTAP/ITAP delay values
>=20
> From: Nitin Yadav <n-yadav=40ti.com>
>=20
> U-Boot is failing to boot class U1 UHS SD cards due to incorrect
> OTAP and ITAP delay select values. Update OTAP and ITAP delay select
> values from DT.
>=20
> Fixes: c7d106b4eb3 (=22mmc: am654_sdhci: Update output tap delay writes=
=22)
> Signed-off-by: Nitin Yadav <n-yadav=40ti.com>
> Signed-off-by: Judith Mendez <jm=40ti.com>
> ---
>  drivers/mmc/am654_sdhci.c =7C 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index e5ad00e2531..1dd032e1e36 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> =40=40 -513,12 +513,27 =40=40 static int j721e_4bit_sdhci_set_ios_post(st=
ruct sdhci_host *host)
>  =7B
>  	struct udevice *dev =3D host->mmc->dev;
>  	struct am654_sdhci_plat *plat =3D dev_get_plat(dev);
> -	u32 otap_del_sel, mask, val;
> +	int mode =3D host->mmc->selected_mode;
> +	u32 otap_del_sel;
> +	u32 itap_del_sel;
> +	u32 mask, val;
> +
> +	otap_del_sel =3D plat->otap_del_sel=5Bmode=5D;
>=20
> -	otap_del_sel =3D plat->otap_del_sel=5Bhost->mmc->selected_mode=5D;
>  	mask =3D OTAPDLYENA_MASK =7C OTAPDLYSEL_MASK;
> -	val =3D (1 << OTAPDLYENA_SHIFT) =7C (otap_del_sel << OTAPDLYSEL_SHIFT);
> +	val =3D (1 << OTAPDLYENA_SHIFT) =7C
> +	      (otap_del_sel << OTAPDLYSEL_SHIFT);

Is there any reason to touch this? And I can't understood this, this val do=
esn=E2=80=99t=20use=20anywhere.=0D=0ABecause=20val=20is=20resetting=20the=
=20below.=20It=20seems=20same=20value,=20right?=0D=0A=0D=0A>=20+=0D=0A>=20+=
=09itap_del_sel=20=3D=20plat->itap_del_sel=5Bmode=5D;=0D=0A>=20+=0D=0A>=20+=
=09mask=20=7C=3D=20ITAPDLYENA_MASK=20=7C=20ITAPDLYSEL_MASK;=0D=0A=0D=0ACan=
=20it=20be=20set=20at=20above?=0D=0A=0D=0Amask=20=7C=3D=20OTAPDLYENA_MASK=
=20=7C=20OTAPDLYSEL_MASK=20=7C=20=0D=0A=09ITAPDLYENA_MASK=20=7C=20ITAPDLYSE=
L_MASK;=0D=0A=0D=0ABest=20Regards,=0D=0AJaehoon=20Chung=0D=0A=0D=0A=0D=0A=
=0D=0A>=20+=09val=20=3D=20(1=20<<=20ITAPDLYENA_SHIFT)=20=7C=0D=0A>=20+=09=
=20=20=20=20=20=20(itap_del_sel=20<<=20ITAPDLYSEL_SHIFT);=0D=0A>=20+=0D=0A>=
=20+=09regmap_update_bits(plat->base,=20PHY_CTRL4,=20ITAPCHGWIN_MASK,=0D=0A=
>=20+=09=09=09=20=20=201=20<<=20ITAPCHGWIN_SHIFT);=0D=0A>=20=20=09regmap_up=
date_bits(plat->base,=20PHY_CTRL4,=20mask,=20val);=0D=0A>=20+=09regmap_upda=
te_bits(plat->base,=20PHY_CTRL4,=20ITAPCHGWIN_MASK,=200);=0D=0A>=20=0D=0A>=
=20=20=09regmap_update_bits(plat->base,=20PHY_CTRL5,=20CLKBUFSEL_MASK,=0D=
=0A>=20=20=09=09=09=20=20=20plat->clkbuf_sel);=0D=0A>=20=40=40=20-572,7=20+=
587,7=20=40=40=20static=20int=20sdhci_am654_get_otap_delay(struct=20udevice=
=20*dev,=0D=0A>=20=20=09=20*=20Remove=20the=20corresponding=20capability=20=
if=20an=20otap-del-sel=0D=0A>=20=20=09=20*=20value=20is=20not=20found=0D=0A=
>=20=20=09=20*/=0D=0A>=20-=09for=20(i=20=3D=20MMC_HS;=20i=20<=3D=20MMC_HS_4=
00;=20i++)=20=7B=0D=0A>=20+=09for=20(i=20=3D=20MMC_LEGACY;=20i=20<=3D=20MMC=
_HS_400;=20i++)=20=7B=0D=0A>=20=20=09=09ret=20=3D=20dev_read_u32(dev,=20td=
=5Bi=5D.otap_binding,=0D=0A>=20=20=09=09=09=09=20=20=20&plat->otap_del_sel=
=5Bi=5D);=0D=0A>=20=20=09=09if=20(ret)=20=7B=0D=0A>=20--=0D=0A>=202.43.2=0D=
=0A=0D=0A=0D=0A
