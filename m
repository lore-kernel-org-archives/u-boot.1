Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3569F9D0CE
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 02:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A5F83C2B;
	Wed, 15 Apr 2026 04:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vSen1aqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D12C83E36; Wed, 15 Apr 2026 04:47:10 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7424A83BC4
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS9rOggKIdCOeeUXq/ZX6oW+x3GxgKsJJz4LE4+naM9lLGBPKTHlzL1MHaR0B3dXKXUgWq1VyqScd05p2VH0ycsk+NgNAuLkInh7QZyXUP6R/4XFsVPakplrDmoDrKjZ+mghon6HnnI3jztvuq3AjqUFl6QkvIoSZvUyA7TU8bsD1uo1zi1RNroqvwq4Zfc1Hu5xH6XhWPYpN7Cl9F6WuywD1fdbWNLyN5p+S1mzO/S7O99zYnSTx4w+yFWvUP22n90wc53mvAee9pqVNq4XpNsdK864YEsaSvnR2rmVWkDelQjQ0d94SzMiMuj5RDKvoh9u28GemCqM5zNnJM//Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXWoIAnwNZ73S7SApJ0zTikOzBehfLXfPliIafNJ78w=;
 b=xmpHoPQKEpWD5GN0Q7bDEjgY29IeXoZ+uifqj5x5hbrPqIcTXyOrvJEvWZOtuvdt7PB7A5DU7mx4tvAwUsKqmHUgfZx0/xfUFv+uMr8puz/3S+AS3wdrUgDbbW7ZjyfMbMbifzu742QYRBIUyUaB45BnW94pDSCysEPW9Htj5r57seK632d5NvvYwKJckWfjC44krGzKt5kHjI0HTaqufM1ZNeLcC5TCKe9967FoIXmgpeo7BxFyKpp0QHFdZItxnnmkv76xKB8RfED/haydShLsaerSTAm/6CjZHFf9TcUsCMnI8MHVddD6TOWMN1Qru0TkLrfEQlhvEf4/NX3e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXWoIAnwNZ73S7SApJ0zTikOzBehfLXfPliIafNJ78w=;
 b=vSen1aqw8kg8u5fir0JMAYaOUMGOiM3OgmYTRkQ4ZpEMf+pAxuSYs6I7gdUqRD1E29680jdGRovoPHFhifUfIePoJ9Nj3SHf2vYOd+OvPWlQhBnIP7bbG/AHqOGXRSYENMBNcXfFQTBG9YzlylNsq5fb/6NbDbyekQ9PTfpBmkp3aWmnm3MhM9RTCRpW9ed7DuKfqL0E5u2giDIVvthWg7+hP6VCaYewuBruvvObLTqpISaqHQN5nv+A3HHng1fEp9+jHc85AscaNzpNg0K3ZlvNRGh0Y/5JX1OAqsCYK9A+CgJXCG464Vv4maIW71QdIBe8pkHYSKO96MJDHxsxIw==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CO1PR03MB7795.namprd03.prod.outlook.com (2603:10b6:303:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 02:47:05 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 02:47:04 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Chee Hong Ang
 <chee.hong.ang@intel.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, Jan
 Kiszka <jan.kiszka@siemens.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marek
 Vasut <marex@denx.de>, Naresh Kumar Ravulapalli
 <nareshkumar.ravulapalli@altera.com>, Simon Glass <sjg@chromium.org>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Tingting Meng
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: agilex: enable FPGA Partial Reconfiguration
 command
Thread-Topic: [PATCH v1] configs: agilex: enable FPGA Partial Reconfiguration
 command
Thread-Index: AQHcpkJmvWRhHfBMIkeKAsee771nfLXft2iH
Date: Wed, 15 Apr 2026 02:47:04 +0000
Message-ID: <CY1PR03MB8121CA6EA84E4186DD645D5DA7222@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260225103444.1851-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225103444.1851-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|CO1PR03MB7795:EE_
x-ms-office365-filtering-correlation-id: 80c5fdad-40ed-4f28-ea98-08de9a99470c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|55112099003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: uJ7wQXDqX7qOb4XTwZMYtvyX79+v5zPHqhGc/2/UXKoWTzPN69B09kT68+tOB8TyzemH4HN48r0UxpPAEY6jtXQklOmMCOGWeeXu2DJJdcyhTRh0xHvpXTWOu3oS8qjG/p1S1aAaTYN0gHEY/EnTb2xbtNLU1P7S8VHiM/H1x1k5CykSzKDrPQYKFmYMGPQ8RR5KHFGZ06QLDUmZpOHYe1opPifEB1kJwtvH2M2LAF00u8tCJnBGtLz+ppMfUeKHdCdf1Xpce4Ka3+jsaL19967C6/vCsOVclpYnkrt/BnpBVDRK5fo+MeFNuu423osQLPTcvhLLvnB4WSCSUNFdPxuhjPuxZ9aM9sM++cxcJMDPfOty1EcKa4VjlGuAsI8jrw3bXcXOHXqDNZp3bEuDy4ob8rVVBLJjREmjzV/lojqaPQeLZYEJhqc0bylg9ds8aEn3QXr3uivQ6U8TM+eQ8f80Ua85sz2bglFxEVpawAAa6quc9gFuwuvTCAQSD7AqBWXwFm0YtJasRIub7fthORK6d4+jEha9HN8O9sczXHlWlFq6XMBu+WzHnotiF55ekgJ9awbE8Jj6fGHUvKLPoSdrf2leIErYVZUaeV81wnvhOmt0XWIWMB3QKLLh7E7rlQU01oxP85K51wFbnz7DiNRIQZbCsGIHqh/Vx73qn2GA7Rbv8WZ9Z+/RzFToSieuQgew+Pbhe87r/hgSyUDpRVbueyLedwjl7wz6fgA8YIeGrIT+qjbUwNpDiy/NaEr9LX7nhXsSkY+0QTcerdXBfd7LtIs6iv74f24+f3kPNAg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BjNXmgNNYODen4zkMjW/NqwSUSLRfTXHHNvyUBJweesO3MRJyNoU5ya8/V?=
 =?iso-8859-1?Q?XJf/FChcnvMTmq+0PRSx4u5yJnph0KIBnAoEG+CFJKC8u+aa1Gfjj2LYRM?=
 =?iso-8859-1?Q?ICh7Wbi5tIVHjCwyCiGo6Vf/GH+r6sP0n1ejfM6rufMhgSol160tEQz1ns?=
 =?iso-8859-1?Q?7M2Tm20iLMpusVR5GCRvKkYeJFUNCz4EkyLwAQBPtdCP7B2CRsEnjIINDF?=
 =?iso-8859-1?Q?SqKscMpSj0jQ6mCLytJhShn+de85kpDkIe9MFqGxjpRPn06UK1PIC+cQp7?=
 =?iso-8859-1?Q?LUf7ActHC+IfSCOOTl3Pue22DJaCt9uxutV6w2QmRP4cgWm/TJ8L3VJVtl?=
 =?iso-8859-1?Q?CVMmgiZaxhEm6izd/7Vvyrdd5AeMDatBwJKd+O0W3eOSi+98OHrTg277C/?=
 =?iso-8859-1?Q?eQWjiZHxqUfT4fGfUD+nYFcxPRyiLPd7zEa3sWj8cPZ2g+MES4sk+Nm9sM?=
 =?iso-8859-1?Q?ui92MLGH2qVrHqzpcSGhFymuj6x5CBpbNS27zYZ7CxKx4/m8yWfu2zRTjz?=
 =?iso-8859-1?Q?se646Vf/0lNiq5FiWi/AlyOFn7AZM04zSB4E5EYsbR46lhACAp3VQuejMc?=
 =?iso-8859-1?Q?lzD/snH6xjRlRZlw8ljrBSGwDW7Ieg+gX23JBzh143t7RTnf8/NKjZfyH0?=
 =?iso-8859-1?Q?yTSA8JbLPqu6xyVJaUcoKAr/YmJ1QnJFcMeaXFkMJlfTnR/W1im2D/z3yc?=
 =?iso-8859-1?Q?UVTvfOyzP9Gv+uj1a3tkdy2+RNkEolEl0/bdk6Z51sKjP2/YPLGl9Ps/oY?=
 =?iso-8859-1?Q?Y4w52RLzTdDq5Gqd19aJiNk3w95D7WsFrObZNUYiaK4BoVgWin3FbPDD1o?=
 =?iso-8859-1?Q?F6ER+VLhjlLeK8hBTMO01LlSCi6bd039BmYfHIbcPsl9bxuyUXdrl8f0gZ?=
 =?iso-8859-1?Q?pPBKLrdNAC+MZJwLX0Komf2iAQ0yQTPw675/FDs4nc/k3XhTHlXryX2me/?=
 =?iso-8859-1?Q?UTN6grZsLbkzspQdnVifs2y0PtEU5gisxe/wjVlvIBEoU+yM4u75N2XGeM?=
 =?iso-8859-1?Q?1FuPekzJcK0xV6fs4XvqTMY5T8KDyqiV5iGUatJKDcP8CNWpYJvtLm5eqg?=
 =?iso-8859-1?Q?2ZvF+4MFVZi5VHnbaHqKgsODTiEpWl5Xhs2B2W3Pcj2EHDPnYJxzGWND4h?=
 =?iso-8859-1?Q?Do3O7YjAPhyU2Lsi3Tv3PWiq64E4ySjZmnEvMfkgu2cysBYVh3oq7/eTjR?=
 =?iso-8859-1?Q?v3fzv0r9Q+ZQvPGHvJ1dhowfJqSeq54pcrecGGunmQHvhdk/GWiSHJVxNP?=
 =?iso-8859-1?Q?8UpyM6vRmgczVbKJS71JoiuKh8/tc4h5xQTRF0GzIaleLXDhcjYdCZVNkY?=
 =?iso-8859-1?Q?++Gq478bEKWlV2qvgwNyXM6wZNMNHKA13k3zcqldPJM7OAwN7j8s4mwBZz?=
 =?iso-8859-1?Q?z7ScnLSEd9a1NWkfc4YYywsBoUF39Hd9xmTy0VvkJqwiy2a0LTqAKlZEE6?=
 =?iso-8859-1?Q?o+pGHZdpwpOEM1t4YTlle9Mf+YvwXsk9o+zAPx8pa8taLT5vDvB/jnsV7I?=
 =?iso-8859-1?Q?HpkRbaHvKj2kHq2oeUMWU0zOsiI8+ji4MdkOz/08w7GfW5TrsmDe7ZlZvM?=
 =?iso-8859-1?Q?V9CxZX1GrgL8DNhlsT2ctP7GOEAIrkyeQYc+qd2trG2tjANKjwbm1HpXxe?=
 =?iso-8859-1?Q?av9LScIXu2Ay5gHVOSKkhp5rrw09aqLmJdjuwK7/oVopAqzWWsJbIXEfPd?=
 =?iso-8859-1?Q?gTvzzZjxnw7n6MotxbZU3+jlhhuohf3/GrE5/CyTvZyuJeU/k2l1m1xRcA?=
 =?iso-8859-1?Q?Kvm+BAHaH1Wkr00fknVODJF6vDP7bPn5REHmsDUK0VJ+gFO0UV+NJaT9hz?=
 =?iso-8859-1?Q?HTus4oESnQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c5fdad-40ed-4f28-ea98-08de9a99470c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 02:47:04.5530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/jNkEHZln8Pbq/f/6A9dL18iSndCouD4YEcDreq4osYd9cQi1NogSLnVtqCc4o2Cm/pn0RIrLd7BcKcUXl5xluxR8rBa4zg7Tb+GDFO2XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7795
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
> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 6:34 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Ng, Boon K=
hai=0A=
> <boon.khai.ng@altera.com>; Chee Hong Ang <chee.hong.ang@intel.com>; Maniy=
am,=0A=
> Dinesh <dinesh.maniyam@altera.com>; Jan Kiszka <jan.kiszka@siemens.com>; =
Ley=0A=
> Foon Tan <ley.foon.tan@intel.com>; Marek Vasut <marex@denx.de>; Naresh Ku=
mar=0A=
> Ravulapalli <nareshkumar.ravulapalli@altera.com>; Simon Glass=0A=
> <sjg@chromium.org>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; =
Chee,=0A=
> Tien Fong <tien.fong.chee@altera.com>; Tingting Meng=0A=
> <tingting.meng@altera.com>; Tom Rini <trini@konsulko.com>; Lok, Chen Huei=
=0A=
> <chen.huei.lok@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] configs: agilex: enable FPGA Partial Reconfiguratio=
n=0A=
> command=0A=
> Enable config to support FPGA Partial Reconfiguration in agilex.=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0configs/socfpga_agilex_defconfig | 1 +=0A=
> =A01 file changed, 1 insertion(+)=0A=
> diff --git a/configs/socfpga_agilex_defconfig=0A=
> b/configs/socfpga_agilex_defconfig=0A=
> index b2c7b30d546..402e617d27b 100644=0A=
> --- a/configs/socfpga_agilex_defconfig=0A=
> +++ b/configs/socfpga_agilex_defconfig=0A=
> @@ -67,6 +67,7 @@ CONFIG_ENV_UBI_VOLUME=3D"env"=0A=
> =A0CONFIG_NET_RANDOM_ETHADDR=3Dy=0A=
> =A0CONFIG_SPL_DM_SEQ_ALIAS=3Dy=0A=
> =A0CONFIG_SPL_ALTERA_SDRAM=3Dy=0A=
> +CONFIG_FPGA_INTEL_PR=3Dy=0A=
=0A=
I don't see this config in any Kconfig, including drivers/fpga/Kconfig=0A=
=0A=
Best regards,=0A=
Tien Fong=
