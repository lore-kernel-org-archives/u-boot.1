Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167F0C3ABDA
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 02:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D23382AE1;
	Thu, 15 May 2025 04:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Zxuohg2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECBF82AE7; Thu, 15 May 2025 04:11:15 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5F282AD2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 04:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDFET7CxR5HgxiLDodtYjfROwrNcx+02JucfxdUbmLZapSzeWwdvtqJqU2ADY6htKN/W+9Ze5pTH63fJJ5YT2DsO1Z+pWyQxeuYWSHTgWKQGpjnOdvwvYsn1hXEBWo+wpgmvkUmdXrgEscMj3gvXtVNsz4jfPkpRVNWXcAdaM5pVJVohPIA1XukUJehGaeJkZYfamPaGQkLhNpq/DZ705PrgU8ip3Qf6bjWx6WfQi9k8wKOVJcYyAOpriPQHHrAJvwiIoyP8HmIxyNa9xlvaC0lCclq2dhNdsh/gihFH6FGNeclzk1FtF7w7wBxDyqu2AmAk7KqZNtUgxEzvR4Hh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbtSSFJmH/NVgUjtdR/B5ebAlsEDBXpEpec7oO1+bBM=;
 b=JjiuJ4QGdHdIalh52xhaSo9Qh+222QX1++GISdwf6jfLMXiDd4taib5aSvpd3kNsnoNcqvdIATlUIei5BDDw5RNVoRaeFHW7Twn/F2PON0Tz5Zxoam+stxUwoj4lxXCugKfoLc/hy/tulyP4zs/pQp1IfUTG8FJ3uQRKXtMRek3gzLpdeBDRzN4rshD/Or1aMqM/p92DKF7u+zLfCSl4cmjDuVJF7rOtLEGLIpOIwuwwqW7zvVGK196IXyQABbeqgKqxeDQBAgRsdf9jCjkPyCaxwjsqPciY5SdjAfN2562UpPUxVWE7EJbchdcPpO7h5yYuUS+Q3jfM5/K+syUGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbtSSFJmH/NVgUjtdR/B5ebAlsEDBXpEpec7oO1+bBM=;
 b=Zxuohg2LpVi61nu0P7MyxV+EMg67JVS4DboKHp58Ye+kOSGpjVUrJ6PNT8oQ7ARE4PK8XzgY3QdB/HA64XFWWN3HKEtvoHYbq5dz9JDly0RXGSDgJBVUWi7xorvOPG9/EdVEGdGr/PLGQ5HW3uQH77JvrGvtC0oSCT3+5CmvoD2HJYmQn8cF0PLdDi0qDpJ0LtZjVN50paR+7woJOwZUqKJDJVD3/y5iy1oNV2zdh8PR1Evt2jLtoYptT0w6b09pbKHuobH2aa97RouhhJNmP9A3lunSxsDszcDFx1BtlGDk1SttHPod/74AehmorMovuCFP/uP+DRYpQaMNQ3Amxg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7464.namprd03.prod.outlook.com (2603:10b6:510:2e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 15 May
 2025 02:11:09 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 02:11:09 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Yuslaimi, Alif
 Zakuan" <alif.zakuan.yuslaimi@intel.com>
Subject: RE: [PATCH] arm: socfpga: n5x: Remove invalid configuration for N5X
Thread-Topic: [PATCH] arm: socfpga: n5x: Remove invalid configuration for N5X
Thread-Index: AQHbviUoX/K/kF/d70awXhZiAu6xELPTAOQA
Date: Thu, 15 May 2025 02:11:09 +0000
Message-ID: <LV8PR03MB8137A1B11B718BC491B8F759A790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250506012059.25762-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250506012059.25762-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH7PR03MB7464:EE_
x-ms-office365-filtering-correlation-id: ac7a4455-b2a0-43f1-87b4-08dd9355c212
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7SJhvQDYRbFXUuJXaD6FXHhbeCIYvOAUo2JLiINA/lMFPFFzA/ncDCh5jiuM?=
 =?us-ascii?Q?lMcMA+F1QAJGDjGLM+nVJl3wKnqen3iUwwCrtjTIvI3eA5Lo4VeO6aVVuJh4?=
 =?us-ascii?Q?fy3mG3DjpchWATW2uNZv06IL/lg1qbTfXBqM5umgWISi1CPejVvkgy5yxyCE?=
 =?us-ascii?Q?xsplHbzLTpyiEU1CkLMkd4r3swx1akwTtaQTX52+YVb94KDp2U1C0WFl5eul?=
 =?us-ascii?Q?rfWPlXTRJTt4GtM3tjx3fV5NtH8ycthkeeHotc3dG/yZzm9M+rFS2bw8pHbs?=
 =?us-ascii?Q?hG5EMVK2n8C4Fj+IrSaNqgbDCxJECRckidQaCiRfePFbBAKoVaNy5iikORcS?=
 =?us-ascii?Q?DwlCKena6OegEynI1Gt2bAZfMbwp6EHNzuZh0LfM2/dn/h5Bdk8ciyhjauCV?=
 =?us-ascii?Q?hmczjlGViSprhCFCe8UDW9gQiF5coMF5eBYLuUDLVB0ZwGz+Vvv3ShGr0YVF?=
 =?us-ascii?Q?ZIKvQ4tlj10QD5iWT5Isw1WMUpKQxTIsDyybmy6B6kjPbCGlLwNNq13kQMDf?=
 =?us-ascii?Q?8ZNZk7HT+CWTslrR38bS8DP00ESbVP/7k5wnLEU64KS7djJtps9TdKCjRMt2?=
 =?us-ascii?Q?V5WxhqsSri+K34rXmYrKYzUAjQf7/bfwMVSTWmfF688ENsJVx1O34O9ZsZwS?=
 =?us-ascii?Q?r9ThfVu3u6siq/AxddUey7FloPEVedolnVOFjmqKevpInmw0H0EhaJ0U48cg?=
 =?us-ascii?Q?zNxsULl4w6zkYCRNQIv1FXmnuatwA8cOA4ixD/FyeBwHEZpZwfVAQZBFCGx+?=
 =?us-ascii?Q?keoe/WzwQQxkRJd4TXs6dJY8yDf4Yb86LmguqNu/BgrLb+MvCw6r+7bUQuvb?=
 =?us-ascii?Q?TkYWutyec2mNdOXtlfE1VMI4CfGqCAQB4Q1JATuvfqcEo3Df2zHRWVALjmtT?=
 =?us-ascii?Q?YLrpQnpxowBUtSoqsdk6gUW8fTcuJ8JLD2hdL8pZ0vYhoGZNpiAkDrKPJexA?=
 =?us-ascii?Q?U4ggN8H1E8iw9h6pqIIMX+jD0PBFA3cmTXLWIQZj8Xn9LdC9Yr28e0yoZ8Ip?=
 =?us-ascii?Q?qqhEIMnwlP76c1nFoohtgnjz5t/qfg7sBuaI25wwSSeN4NNAOBAvSuE/eoW1?=
 =?us-ascii?Q?kk+Qj521NwptCVahZYFKNDBvMHxhtgKhMTR0p4ngrT8SDpEZRSmnCH0vqP4C?=
 =?us-ascii?Q?sZgzCJRpde8e/VwpuTxJZdubF46H030JEXlA13SQ/CyWZ02i6mVeZ95G8xPb?=
 =?us-ascii?Q?xE7BeB99/+2fdQXrL0qTgXwU9p/wQUz7h8DefzpnX2jXOLL8XG4oSCHNOQsl?=
 =?us-ascii?Q?3vs2UnSSqKDt5guKIxA3JphfPDODGLvwpv3u3DrIsYpj22sX3NTQu0UOqXrV?=
 =?us-ascii?Q?uZnbkiNrCQ0fWg29GtbAYv5am6cLlSQ7hTDcH4sgPScr7hSYbeejMwqtQjfD?=
 =?us-ascii?Q?bhTqtMQmpZcnVb03IdiTqaxN58/GW9XTCshQa14jJaEwb9Kudb/KoDlYr6Iy?=
 =?us-ascii?Q?AfBr9LSI8gReycMOTGaGpw3eiOBvrD/6LHPNLtx7irSF452dAUnPrs2zdSdj?=
 =?us-ascii?Q?d5/JIY2tFGpL4p8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IEKEA4XN66Q0y6RE4O24uuAY6Qa/mgqiYhwTnFeSAO8lDFTLCWuKibClDdf+?=
 =?us-ascii?Q?W3EbN80S1JX33WYYEbOsHKBIgIiZsYjH+BbTnonlhE/YFybbFFEP+2nzp6S/?=
 =?us-ascii?Q?gaoHHWp6CL909S6kmBzDvDur1Qo5PhNif29n+20//y76qm7uHYqcn6Qg7NAw?=
 =?us-ascii?Q?c8ljFZPNbaCQpIZ4osfxoo0hbLTzSMBiZTb5aY7l0jwfyO5Zgu3pk5r6Lnpa?=
 =?us-ascii?Q?XE0sTzDL7gWbJUOtRvTxhCQXD3IujhoDNYjmxdHieXgqt9b4HwNN/yZpt2qn?=
 =?us-ascii?Q?l/HfXIZs2Y0AhWi8zAG0D12PI63NP0K7QfXF9LItG27AkIfAhl3ICKBYwlxg?=
 =?us-ascii?Q?zLR9pikvmKXCvYX6W8DjQBIRio/AiVIgpLWS16vtLwP1e/mlABw3I8Son571?=
 =?us-ascii?Q?lmzTxurUMCN0fcfMt9IVX4vfmrrQzhGIoD1pXbZKNoCgzNqzdJI9zeYFZwUa?=
 =?us-ascii?Q?FYxGL5Oa4lZBUK+lKVZFUiNtkSTcvwSP5ARWDFE+T83i5e3OSi5aKKHB4McQ?=
 =?us-ascii?Q?hVCZK4l3L97ZT+gtRpkSj2fe+3wOkyONb7OIFyhyt+++I1l6qCSI97sBVaLE?=
 =?us-ascii?Q?ZbHNe4NLkgk52kv5WH/GDzWzgYtEDnB92ZBvNbYbNzQrH9bA5os6OW0+7Zee?=
 =?us-ascii?Q?hU6Kqo+HUXDQp90bEXB/92NZJlZG9l19BD26RB5mJyw27L6MlHlL08kVwwyr?=
 =?us-ascii?Q?B0wKYRJtNuQXWphfE9agWxiUyOP4XhkWvZkLH3OUQlT7/A2viI7q5YzCwQHl?=
 =?us-ascii?Q?pJIIsz8t2Ot7ydcOL4X6sL539t2m17uAM3dxnrymtVntErOImJHXGIfkUr1m?=
 =?us-ascii?Q?9ojkfQzuUbIY1b7VSo5ce3y+C4I9K6Ofg1FDBkaeU/o+OE0a2aWq2rJK3sUx?=
 =?us-ascii?Q?VWOSM7dSyBSQDuckmnTmbvR8U2UZrvamU43rHk8/FIMq0cWFaaiVBG/M5WjF?=
 =?us-ascii?Q?T9mDZS1zV/Ty33PAsmijJGD8rPcK1ef1XtKqBOs0JpihRp2dBstDX8QFVykI?=
 =?us-ascii?Q?1n93noGCMQEvSJ+LaXnP+X2etYWzBuNFYqxUqkZt6GABMMU1OmCdaZXiR/qp?=
 =?us-ascii?Q?TWmlfu0ElaPiiEyXiNyq/nKD0ngSwOaKTXxZvZGytgJIhOLeYIxPghzXQqBH?=
 =?us-ascii?Q?41/yMcblCvTJwPPS7oNm671Yc1otqxM/XfwnZGSSPC1zkX9l/uGaYKnJeKpM?=
 =?us-ascii?Q?Wpf2hQInywonwqvjuNPfazRU06bmsmrXECHIaGktVYpGn7XnHLI6KOiw1pgO?=
 =?us-ascii?Q?8IMAI7BdgFWpoQzJhdxJVZ+spItYT0qlmlLEgstZ4dXzBXuiz6bF4KWdE1EL?=
 =?us-ascii?Q?vmGiSNcqlkDQc4dekK0oCySZtbYCLcmXeSM8SqDFDuBqNhO/SQ+JCxpzT97q?=
 =?us-ascii?Q?QpenqzOe0EXqxZGWN2SLHC/VpPbnkS+x/10vL5cjGWav6Tn9T0Lb8l8U2/3Z?=
 =?us-ascii?Q?f2yW0L19h1qWhiFqDjO4d7rhikCcf8OLyQnrJ9J6V9TGQYn+YoRNvpIxFRSt?=
 =?us-ascii?Q?P5XWivsOGBGbKqWasZMnfB6G4Y5NZlm47ivfDPj13yOdHSHDfueP7mKqm/p4?=
 =?us-ascii?Q?mmcFSVgmautoOnfzANuA5mU3hZf/nRFCiwhF2o4/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7a4455-b2a0-43f1-87b4-08dd9355c212
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 02:11:09.3344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q07IwEfd/iMIJ40Ney8bi/Fv6gorwHAoRS69bZaK8ypE/qHY3EfkNBoFVcWVt4xUwZWbdqFP3IaA2EjxMfO5cWcBuJJLIJrH7t3qI2eskds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7464
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



> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, May 6, 2025 9:21 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Alif Zakuan Yuslaimi
> <alif.zakuan.yuslaimi@intel.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arm: socfpga: n5x: Remove invalid configuration for N5X
>=20
> This configuration is not valid for N5X; removing it.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> ---
>  arch/arm/mach-socfpga/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-
> socfpga/Kconfig index a76a9fb2a39..156cfbbcf3b 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -120,7 +120,6 @@ config TARGET_SOCFPGA_N5X
>  	select BINMAN if SPL_ATF
>  	select CLK
>  	select GICV2
> -	select FPGA_INTEL_SDM_MAILBOX
>  	select NCORE_CACHE
>  	select SPL_ALTERA_SDRAM
>  	select SPL_CLK if SPL
> --
> 2.35.3


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
