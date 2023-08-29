Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB53FC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 03:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECBE86452;
	Tue, 29 Aug 2023 05:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tKUJSuwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D2486420; Tue, 29 Aug 2023 05:46:09 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBEE864CB
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 05:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230829034600epoutp04a455ed7dc0102de4ea5ff28a549e44e8~-veFzr4T32125721257epoutp04W
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 03:46:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230829034600epoutp04a455ed7dc0102de4ea5ff28a549e44e8~-veFzr4T32125721257epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693280760;
 bh=nkfDonXPOhMm3lUtbQiJljDyE0Qz8UnzXyEnxa0CrLw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=tKUJSuwN1y9HNoL53Ha6f069enyswGp+79U3Pa5VZqlb1l5NTjTb3tEzniKJayicA
 HTW2tpbfgCAHFlNUkd3V+YFh9FWFajVqWJ8iMZ8EqwbX6ypo6VgRigKonqC4x2WbfC
 hxNuUYE8oFsw9q9CUptOPpLfihHCVaBMcyCI1Ozo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230829034600epcas2p279e461500a6bec90359cea1fb6a5f933~-veFmiCWq0325303253epcas2p25;
 Tue, 29 Aug 2023 03:46:00 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RZYHW6nF9z4x9Pq; Tue, 29 Aug
 2023 03:45:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 8E.C0.09649.7F96DE46; Tue, 29 Aug 2023 12:45:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20230829034559epcas2p26890fc1d56125bf443b16afc4805aaf8~-veEjezNa0325303253epcas2p23;
 Tue, 29 Aug 2023 03:45:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230829034559epsmtrp2ade158b4ec5fca6f67a066ca0c356031~-veEi8NcD0774207742epsmtrp2J;
 Tue, 29 Aug 2023 03:45:59 +0000 (GMT)
X-AuditID: b6c32a46-943ff700000025b1-1b-64ed69f732d2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 74.DE.08788.7F96DE46; Tue, 29 Aug 2023 12:45:59 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20230829034559epsmtip2af4a0a2e0a63e0f2f6b87f12d54f170b~-veEZwe-H2771227712epsmtip2E;
 Tue, 29 Aug 2023 03:45:59 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>
Cc: "'Nikhil M Jain'" <n-jain1@ti.com>, "'Marek Vasut'" <marex@denx.de>,
 <u-boot@lists.denx.de>
In-Reply-To: <CAPnjgZ1YYHTe_7VZDyCe9OhrmhhdtnOn5szeXfrJma6=Ot39ZA@mail.gmail.com>
Subject: RE: [PATCH] spl: bootstage: move bootstage_stash before jumping to
 image
Date: Tue, 29 Aug 2023 12:45:59 +0900
Message-ID: <005901d9da2b$52f9ece0$f8edc6a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKZ3hXk5y/ArzBci16SCmfCRxrpZAJPjLIAAcXb0k2uX8bJsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTXPd75tsUg50HjSzetDUyWvT/f85k
 8W3LNkaLt3s72R1YPGY3XGTxmDfrBIvH2Ts7GD2O39jOFMASlW2TkZqYklqkkJqXnJ+SmZdu
 q+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RTSaEsMacUKBSQWFyspG9nU5RfWpKq
 kJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcejiJtaCJs6KGweXszUwTmfv
 YuTkkBAwkTix+i9jFyMXh5DADkaJvStvMkE4nxglfl4/ygLhfGOU+N26lAmmZeezbWwQib2M
 EhuXbIVqecEocfhJG9hgNgF9iZcd21hBbBEBNYm3C06AxZkFEiVO984EszkFAiX+TPgC1MzB
 ISwQLPH8TS1ImEVAVaLzz0MWEJtXwFJi+saLULagxMmZT1ggxmhLLFv4mhniIAWJn0+XQa1y
 kvj1ewPUKhGJ2Z1tzCC3SQg0ckhcm7CbFaLBReJE+xE2CFtY4tXxLdDAkJL4/G4vG8g9EgLl
 EjuWJUH0tjBKNLftgVpmL/Hj5hRWkBpmAU2J9bv0IcqVJY7cgjqNT6Lj8F92iDCvREebEESj
 usSB7dNZIGxZie45n1knMCrNQvLYLCSPzULywCyEXQsYWVYxiqUWFOempxYbFRjB4zo5P3cT
 Izg1arntYJzy9oPeIUYmDsZDjBIczEoivJccX6UI8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR
 5Hxgcs4riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoGJked58obF
 RU6B2rwPZp3LvB9hbHv2a9CdptVvf1qs2CsXH/nsy8qFnhque1LOSTzrVpl0oPqd7CqF95r2
 CyJLo3YYlXSnH01MvKg5nSHMP+Ucs+jVKUu/XnviW24x59+zeD5n+a8d02dxzhGIEHgW/4c5
 dpnF4pL9J7aqPdthLlf0z+OB+7TL4fMeBXIll+sWPAmcazjRwmLbks7r5+pLOu6E+3PZ+Suk
 SmlZn64KfPXWwfSjobryPMZrYr46fwz/njrJIpv4cJWQyicHjn3Z+/gXdk4ve/7p++05/1XO
 zg3evlNB4d9GxqdhOmzfb9VbCtqs1dqz/0gVn+1K1ScyUlf+vMvv2O87ycbt72dPJZbijERD
 Leai4kQAcgjFsRYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXvd75tsUg7X35C3etDUyWvT/f85k
 8W3LNkaLt3s72R1YPGY3XGTxmDfrBIvH2Ts7GD2O39jOFMASxWWTkpqTWZZapG+XwJWx9toB
 5oJvHBXPP/SxNzC2s3cxcnJICJhI7Hy2ja2LkYtDSGA3o8S1qQsZIRKyEs/e7YAqEpa433KE
 FaLoGaPEh48rWUASbAL6Ei87trGC2CICahJvF5wAa2AWSJb48vA8VMN1Romt1y+ATeUUCJT4
 M+ELE4gtDGRvuD8JrIFFQFWi889DsKG8ApYS0zdehLIFJU7OfMICMVRb4unNp3D2soWvmSGu
 U5D4+XQZ1BFOEr9+b4A6QkRidmcbM8w33Tt72GC+ufvgJfsERtFZSFbMQrJiFpIVs5CMWsDI
 sopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzi2tLR2MO5Z9UHvECMTB+MhRgkOZiUR
 3kuOr1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRqYGrY
 qnRjUs7EU4m8Vx//KN3C9vPwnLooa7eER/P3pPFonuZJ+yG+c17dDxXWbaoTsi/fz2TbFynR
 NjvtcUmaxrFdkqrrJj2L8+vP/MfNGbxuw6n9z/KuBqtf8LjGpKa/fsLG9QxN/P7v309TP+Y+
 ZcIZ9+2S0XVBW/d9LdQQU83/U1C2WLFgcfI+k/1LuGqS33RefbBzh8fp/wuFc3rDj53cP33y
 pjq9uPOPWzydOGc9sq/SDLROyf37QTbP+2NgVOdO3yeBM/803XbY9DNfPf8/79E0/ZbYkBmB
 qQ6vTzX/NLWzUF8qtG+17MRPi2Z903y8kPPJIUmGtRLbI64JNFZZTltmdyd3y1P1TVXrl+cr
 sRRnJBpqMRcVJwIAhIEEiRwDAAA=
X-CMS-MailID: 20230829034559epcas2p26890fc1d56125bf443b16afc4805aaf8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094628epcas2p39068c0277081701446115fec7584ab54
References: <CGME20230828094628epcas2p39068c0277081701446115fec7584ab54@epcas2p3.samsung.com>
 <20230828094617.2060025-1-chanho61.park@samsung.com>
 <CAPnjgZ1YYHTe_7VZDyCe9OhrmhhdtnOn5szeXfrJma6=Ot39ZA@mail.gmail.com>
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

Hi Simon,

> -----Original Message-----
> From: Simon Glass <sjg=40chromium.org>
> Sent: Tuesday, August 29, 2023 2:55 AM
> To: Chanho Park <chanho61.park=40samsung.com>
> Cc: Nikhil M Jain <n-jain1=40ti.com>; Marek Vasut <marex=40denx.de>; u-
> boot=40lists.denx.de
> Subject: Re: =5BPATCH=5D spl: bootstage: move bootstage_stash before jump=
ing
> to image
>=20
> Hi Chanho,
>=20
> On Mon, 28 Aug 2023 at 03:46, Chanho Park <chanho61.park=40samsung.com>
> wrote:
> >
> > For IH_OS_OPENSBI and IH_OS_LINUX, there is no chance to stash
> > bootstare record because it will not return after jumping to the image.
> > Hence, this patch moves the location of bootstage_stash before jumping
> > to image.
> >
>=20
> Please fix your implementation instead. You must jump to the OS at the en=
d
> of this function and not before.

In case of OS_TEE/OPENSBI/LINUX images, they will not be returned to SPL so=
 they can't get a chance to stash boot stage records.

>=20
> In fact I have a patch to move bootstage later in this function=21

Will you post the patch soon? Or it was already posted?

Best Regards,
Chanho Park

