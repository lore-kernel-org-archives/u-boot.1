Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E55F531E8
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 11:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9574B841D5;
	Tue, 14 Apr 2026 13:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dd8dLhhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919B7841D5; Tue, 14 Apr 2026 13:08:24 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402B384181
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 13:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUm4C4hGCfm8HUfNGwjPN9lYLVOKSTITDwvescSxphqph9M1Lp7pslVAYbJv/fMoomHcGOl8EYfU8HqtEnTDZGmTlawkj46M5PiYge+idzL+y4sxsOtoLzxdzBV39VNMGtEMVm3IAjEuFJG5YGwW/9exnkeKhnc3Wk7aMtjj/ubOcn5BTPBu24aVSzA+xD2QWY50nY7Auo/XLdOzIBCaCoB0ar9AQEzN0ioDeNBiIzoZ0970LIUjE9aAnfQbdD8Ebfhlwo1Jc2Kx1oMxKFTWsXNyAD6AWo0foZ2HqMVEJ25k1vfytDp9cXVxjnxB++tXv/N//hG2MMuxpH95jqCsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLZbB3e4ljTrqs0M0xm38JgD+jmFlZqx0bwVSr8n7As=;
 b=QZIDre1iEdGaFRs10DwxgKTcTfpRaMjMRReBTLz+dNxqtAQBHIyR6FvCmBaK1GmFvt10Tm870ZDBXudxmLkxCFGZbvpBA3rJOQsM80OWFnnH+dDHaWVhetAtE/eLT9wlDeuxZdUnCCdRMjwNXRAcRdySWawWlUG576HGJc/Az3hqMXDsRQVSiPWrgPO3Yh0Voebxydq8llsOuyCa9oLB8mCkaBFZjFX/nU0RqW32u/aQPhsAF/b2b9GanEAVgZDDJY+w2uN03L6DpoWfNtzY6s5yaYmjekG5T2pIE1HbXHEyhcyBfEWuTnUF8xAPiQ4L65nG5JwdCCYlYJDe+UxnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLZbB3e4ljTrqs0M0xm38JgD+jmFlZqx0bwVSr8n7As=;
 b=dd8dLhhkQSb1+LD+zs795P5D+pasuIDV7yAw91c6qTARj6OC9hH45SJgr36B8GFUd44EtD80bD9avCifecyhpahKgU3jxhE2jvg0tke0JuBTh1RfH3rHEJeaBfdBooceV+4hU938J7zDQQWZB4noYiVIPsWA/o/2GNhpJbS1WU6EtdmrLPK+JjOoWHaG15Q3pDFQ+DxGmromHg+F+5nPadlAS9R7cJCa2GG4ENInyGFzekKwWi8Ef2oc6J8pA/6xXDViT1LrtKevZOTzsPFukhcOHkMyyXmQLPcprvkRMiQPguOjWuhorF0Dp+Vfr0No85ibPVm2QAAUzqlBuWnyBw==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA5PR03MB8403.namprd03.prod.outlook.com (2603:10b6:806:47c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 11:08:17 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 11:08:17 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, Anshul Dalal <anshuld@ti.com>, Casey
 Connolly <casey.connolly@linaro.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>, Tingting Meng <tingting.meng@altera.com>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] drivers: clk: agilex5: Setting correct counter
 frequency in boot mode
Thread-Topic: [PATCH v1] drivers: clk: agilex5: Setting correct counter
 frequency in boot mode
Thread-Index: AQHcpW2LtDCy5TjkN0WZCDXEq0KpRLXeeX/NgAA4TvM=
Date: Tue, 14 Apr 2026 11:08:17 +0000
Message-ID: <CY1PR03MB81211891617892E8CF3826C3A7252@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260224091109.8181-1-boon.khai.ng@altera.com>
 <SA3PR03MB718727B42ADF86B94EA4D3EAB4252@SA3PR03MB7187.namprd03.prod.outlook.com>
In-Reply-To: <SA3PR03MB718727B42ADF86B94EA4D3EAB4252@SA3PR03MB7187.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|SA5PR03MB8403:EE_
x-ms-office365-filtering-correlation-id: fe889c0a-7d62-4c76-43a3-08de9a162170
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|18092099006|56012099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info: 6/OCtdscK/KoCWQTze4XQrmT7jkzdmXJWHQO911uYpIXyMxREuOkfxyq7FzmOcq4OKQBx0C5Lm+i4+Lsl4x7CsY/oy6Jzv0GoFVKUfwHIwhp31MeJF9ONXQ1nmxXT2Vk3I99wpNu1/8lvW+IGRbrXjDWW3ZGtlJ1Z2aAsw/aY0HgmOmtE480eOPxsujtEMfzupAI8LgtYZLHpPyasyx8vGfwANnaECBReiT/tmJQIanr5XkOhE43sHCI/cVqnuXUR2I2KameI/vhTEsZuHaOmkE2CWcChv9cnm2AWM4Bc4DwANaNprgaQVPdQutDwT63XQk0zqi9fO30yPC3P/kS1Uee3+y5VcoDcPnfExWM/y4/NBlZnnmyL3OMMl+r9ScA0fP6l7mFUbSGh5EnGqLnebeHnddsi+A0WnEWROgEo7fA7dQ9FAYPlaHA7lyHU7klYMr39/s19xMG2U8B7q2TOynzcUrxZ7SbVjTmUeF/piufPygjNZxTgYTa0iHCuTU5B1qIceApDfwBQGtetjMf9np/YqEHAO1sPGOpg+17Uvdokz5Czn1lJHHturopg6h/L6x7f73eqT6+V73mXEVlVRYNwgXHSi4xKgukvNbgiQ/7id9nTOy54+SAcuKA3Ls8VQBdkGFg+3YUsy9IR73nr1ePHfjIy875nzby283CqqKrG1AbOP6SZH8ZPatfCbrQx+jL/raV2aI/4n99ct2W14/0AkZF0+uv0IUBvjilmqbGtrzBdVcZsjfI7dJy+6ksyOSMe8MU49JaQsaJrNq8ZjCR/i8xzngRc65hwg68nUs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18092099006)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wwADMv58ui+VhuQZ/oo6xjVMYLXrFn3AgdokSyvziLAl17+MhSVIkmqERO?=
 =?iso-8859-1?Q?1gASPuouANas5sI/VInaEJUa3XJ7rA0Ij63LJG/iyqoE1LHxYPAni9+sOe?=
 =?iso-8859-1?Q?1q2kRtKRgSifo2uIm0rgvKUJw6P8bmEPNlV3pTg/mFt5oL1y1wwjFUYXsO?=
 =?iso-8859-1?Q?7L5hTr2gUx97l20ohyMxQ2YOozIk50U3BkH+ohRJt/juRgBPlQsTRUGomY?=
 =?iso-8859-1?Q?e6/nBxca+NytYBIgWorSKA2Lw7lTTF8kaNkJOuoiGdzbya7mNucsX0Ybvh?=
 =?iso-8859-1?Q?FmbCNDylgNQqLfiUqU5dBMBxHeRJxh4McGot/82tInDsUhXhZj2XUzoVTG?=
 =?iso-8859-1?Q?5pej1lo5abWvlE9nTmUKJZ9KE5gYeEfS/T9XWXQyJwqq30iH7FtR6qYwhJ?=
 =?iso-8859-1?Q?6qqxmjluF6IVEP1TeA1xSKS3oZh75pU7+hUUfagCQ8yNPv0lVcZoWDFDyU?=
 =?iso-8859-1?Q?kPruSRipzmHByj+6flrC4ep6Ojo7DvTGHaSUmY9GKrKYnfqcgsl25IhSFY?=
 =?iso-8859-1?Q?oiEItKFMvQdJ77JeyuO4hARDcTduRTNiCJX73lAeoxuTvxrXF/lRw17eyK?=
 =?iso-8859-1?Q?tdvEdfxMLKJChPig0vTlA/dj1k3PDnXdZC0x3fnWP4shyglROv6kQOGJFz?=
 =?iso-8859-1?Q?ueleJQmSodRyRiykI2ZBk3OjmBeMPAC9IlvR70bwWjJ3Wsc+JidD2gxXE6?=
 =?iso-8859-1?Q?/hDwMRzacn19QDxq/gpoWp2vDePWK2dalTP2QrLLrIUmePs4Wa0hb0/2iK?=
 =?iso-8859-1?Q?5g/vq+Lina6hvNuENnUjQCvn1qYN1ssnjOjrhXMszIL7W3s+MzPI+8wtec?=
 =?iso-8859-1?Q?Z6WLkSuZfY5ZeL9OYJkzDucFUJH7nycqKuowhe2O6FUp/29M1lQN24wf5o?=
 =?iso-8859-1?Q?dfukOskNNCfPvvDWGZQRva+7eBV7yZJvVSGoFKTnjhwO16QtL0guI0eH1l?=
 =?iso-8859-1?Q?mWIJTfIxaZHsQc4fD3kImMBDFJUWS2mC/yzkCEaXOGmkjFLSJja1J/Tajk?=
 =?iso-8859-1?Q?7qGxcIRAq1eYsLRNWUHjg4Q+mjaI27VxsDxfn+MSWRzRA+fXK8/8/vc/nX?=
 =?iso-8859-1?Q?OnWwGoMkJVhxXAfXuFk1zj7kF3of/ABYkIsO9wAzjrpJObGgSZRzAGzo/7?=
 =?iso-8859-1?Q?g2LDMhcsNfwJGy0RJXYfTMfzNPVYSaONnhFRV8q9OSpnWBDzuJuHQSQNNM?=
 =?iso-8859-1?Q?p3AXVrKTwl2sDWV9h4FcbtleB5wYwRQaKDmiEy0SUdTU2Vml/ZroZLz6MI?=
 =?iso-8859-1?Q?TVXuDx8Jl8IwGtDWbShI+3rZdilCdPUQpSZzYsuYs7iD28ITx+DGvQ9BY3?=
 =?iso-8859-1?Q?WUH4dfeJVBRNxfBPYpWaIqdu2y187OexsmtbsQTBe/pffd8bG0ullOstNN?=
 =?iso-8859-1?Q?PkOOF47iqGhclyw5Q8JM4bWpZsZup6K4BiBRXnTP1s4wLlsu2A7XNtR2gD?=
 =?iso-8859-1?Q?kCQpHiHgUT1hlBZUYRgiV1AAYy7ZB1xopgT33ajyuTRYOnHkQpxjXOb44b?=
 =?iso-8859-1?Q?/9+TTB9db0pczRi7Y0WeN5J5amWNbXENkTEqJ50oJmw+IQtC2+I+diZcvq?=
 =?iso-8859-1?Q?vix12CGRIYBm3UAQvm5mpUOpC1LvfMNQZ5wPF6CcCcOhS7iYYsY8zHxs+A?=
 =?iso-8859-1?Q?1yY5jJ/nAZ7LFei8usIof3J8TLebivYHJnoKfhX64k6Lc09XsXMqQL9Os7?=
 =?iso-8859-1?Q?++/XMDDPBV0IKEc0I4uivTF4nP/rx4VMEXFdaPy6aQMqFc+ov6FvYgGBjf?=
 =?iso-8859-1?Q?6afP/NC20aS/ogK6kdnTMnLu2dxqyajVQ70+yq0D2gnAI51bR0GHNGl2OM?=
 =?iso-8859-1?Q?84Uz5eOIxw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe889c0a-7d62-4c76-43a3-08de9a162170
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:08:17.3084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeGiqnwUmkrYZjJWMlV+CKTnZBjcBrLtIO7F6kyX57tRlUeTIVGJOJEAANftPkEPCfBZUO+9PHpVoTeFdjWAjgQGeHwj+tyd9S566J6AoHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8403
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

Hi Boon Khai,=0A=
=0A=
> From:=A0NG, BOON KHAI <boon.khai.ng@altera.com>=0A=
> Sent:=A0Tuesday, April 14, 2026 3:43 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>=0A=
> Cc:=A0Alice Guo <alice.guo@nxp.com>; YUSLAIMI, ALIF ZAKUAN=0A=
> <alif.zakuan.yuslaimi@altera.com>; Anshul Dalal <anshuld@ti.com>; Casey=
=0A=
> Connolly <casey.connolly@linaro.org>; Christian Marangi=0A=
> <ansuelsmth@gmail.com>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; N=
eil=0A=
> Armstrong <neil.armstrong@linaro.org>; Quentin Schulz=0A=
> <quentin.schulz@cherry.de>; Rayagonda Kokatanur=0A=
> <rayagonda.kokatanur@broadcom.com>; Tien Fong Chee <tien.fong.chee@intel.=
com>;=0A=
> Tingting Meng <tingting.meng@altera.com>; Tom Rini <trini@konsulko.com>=
=0A=
> Subject:=A0Re: [PATCH v1] drivers: clk: agilex5: Setting correct counter=
=0A=
> frequency in boot mode=0A=
> Re-add Tien Fong's Altera Email, with the patch's content.=0A=
> >=0A=
> > =A0=0A=
> > From: Tien Fong Chee <tien.fong.chee@intel.com>=0A=
> >=0A=
> > Counter frequency need to be set in 200Mhz when system in boot mode.=0A=
> > 400Mhz need to be set when system exit the boot mode with the PLL=0A=
> > generating the high frequency clock set by user.=0A=
> >=0A=
> > Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>=0A=
> > Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> > ---=0A=
> > =A0arch/arm/Kconfig | 1 +=0A=
> > =A01 file changed, 1 insertion(+)=0A=
> >=0A=
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig=0A=
> > index 5508fce796a..4cc42ca393b 100644=0A=
> > --- a/arch/arm/Kconfig=0A=
> > +++ b/arch/arm/Kconfig=0A=
> > @@ -30,6 +30,7 @@ config COUNTER_FREQUENCY=0A=
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 ROCKCHIP_RK3288 || ROCKCHIP_RK322X ||=0A=
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 ROCKCHIP_RK3036=0A=
> > =A0=A0=A0=A0=A0=A0=A0=A0 default 25000000 if ARCH_LX2160A || ARCH_LX216=
2A || ARCH_LS1088A=0A=
> > =A0=A0=A0=A0=A0=A0=A0=A0 default 100000000 if ARCH_ZYNQMP=0A=
> > +=A0=A0=A0=A0=A0=A0 default 400000000 if ARCH_SOCFPGA && ARM64 &&=0A=
> > !TARGET_SOCFPGA_AGILEX5=0A=
=0A=
The commit message describes a *runtime* transition (200MHz early, 400MHz=
=0A=
after PLL), but this patch only changes the Kconfig default (static).=0A=
=0A=
All SoCFPGA64 counters are sourced from cs_at_clk and are 200MHz at early=
=0A=
boot, so defaulting COUNTER_FREQUENCY to 400MHz will break early=0A=
timeouts/delays.=0A=
=0A=
Please respin:=0A=
- keep CONFIG_COUNTER_FREQUENCY default at 200000000 for SoCFPGA64, and=0A=
- perform the 400MHz update at runtime in the clock/PLL bring-up path,=0A=
  following the existing pattern in drivers/clk/altera/clk-agilex5.c=0A=
  (around the PLL setup section near line ~403), i.e. only update the=0A=
  counter frequency after the PLL is configured and the clock source has=0A=
  switched.=0A=
- Ensure correct namespace is used  CONFIG_ARCH_SOCFPGA_* .=0A=
=0A=
Best regards,=0A=
Tien Fong=
