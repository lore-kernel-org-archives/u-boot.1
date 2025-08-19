Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411F9CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4CE8006D;
	Tue, 19 Aug 2025 06:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QKxn762L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9AF802C1; Tue, 19 Aug 2025 06:03:52 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F8FB80050
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMkWDQAq8efcZli/8qvppoBucbBN8F/nRMisMeGwVadTWl3dgOsaMBm32BduvFb5jN3oogwiSJv1ffbQWY2s7dVdn9UMZuUhDBuzFaD4gp2Ljaj6nvlFTixiZWBqfmmuIRF5HS+ry/BRweHdmI1P0T3M5hng0Cp6KoQnFIXy9gpPeJ6yoZSKvbgMZOqgmBNmqRL+IrSIqDL+p8/ETIhlA9p9L3oEGBZnk2c5S+KfgiCVaBC12Xa33ianKL4EsnudR5jl+sU+z5kA2yRSr0c5zx2rk1JDqT2nbrQS1/k/v3grZG3pTCpvCzDms0ub1I1mEkrunsYOO+41EEacSavD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqKaTLwEebsiDuNq/R70H/JVHrUmLNCYRTCAqsH9NCI=;
 b=VxCU1GZBaxCPENb5kZhy2CsDtwZPIBVVdW6MXKa1wAqJVavqdtEUTDzLEiLqAGwe2QfPxUh4IAVMQKcyNRvsNGylFWOJ0zG3MW8dsFbpWBVOzRMR/M693x9BMJ//yCfjkcZpd0g1CaM09wqiKtkURnIW9ON+f/F130G1lLh3H5jWOq+Y+T/dRnlXtvamEEtjlfZ6v3njrra3WUCyhwZDD1G2niskZIMrBu0lWhs0aTYrR27yOZl6hblgFEAW63KeHkWUidyVmeGyZZnMkZRIYKdyTM1QBbzsZNkgNen8U6JxWkwI79hvoOzpjv3WQekUFcrCdU+Y0JNnwVXzS3KHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqKaTLwEebsiDuNq/R70H/JVHrUmLNCYRTCAqsH9NCI=;
 b=QKxn762LZR7BoF22fNGEJGZpjHVgcoN7+cQbm0Hkvx2pnE/r7pp9A0kJUrNFEgZiMEnewtcdH1joh79tPM9k6U76xBpowp+8tKJHob415s/oPgQg5q96ETZqo5QXu6q78yDNHZ7m2BVn/dNjUiNFIiLnBPVFSb9smTpzBOXcu+OeDLlLwKbkKCvzfyFcsDTwJQWGS0jXqgPqLE5Vhg2dYmMahDbhzN64F0IzKdzHZE8PodHDrm75BJpaNvulGOGgqY/00lAKbGEzWd7U/7slU0ZdDZ9aUxbn0HUHWYKrkCoaO8KfazXRtaG3A/Ab8CRUnvC471aDK3vwxXOdE8YJIQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7243.namprd03.prod.outlook.com (2603:10b6:510:24a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:03:45 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:03:45 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Yuslaimi,
 Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [PATCH] arch: arm: dts: agilex5: Disable cache allocation for
 reads
Thread-Topic: [PATCH] arch: arm: dts: agilex5: Disable cache allocation for
 reads
Thread-Index: AQHcCEhubZFlrOQEiUuyjmVV7P6zDrRpa+Hg
Date: Tue, 19 Aug 2025 04:03:45 +0000
Message-ID: <LV8PR03MB813782443A2122409571F55BA730A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808094003.24604-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808094003.24604-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH7PR03MB7243:EE_
x-ms-office365-filtering-correlation-id: 7257af4f-164a-4b10-f321-08ddded564c5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rrHyvkJdsrW1YNhszFK7Fmntgu0soMVk99i1jvMgC9IQENc8qo7TzcfUbvxk?=
 =?us-ascii?Q?5OP8uPdfjwvx9tJe/zY28rNgssLlRNmFEwHA1gQbPqIU99s3ZjG4RXArvFov?=
 =?us-ascii?Q?hhsAvY1cVIRyCtAs+wU3dLA3Q3gebcXZbrGLMwMfHPOhZWgWFr1alcj66HE1?=
 =?us-ascii?Q?di6vVX7KcUPX2bEJIUmhgoCWDGF+qYt3yprCJzb4xWxgnJl0qE7SGTs3VU2F?=
 =?us-ascii?Q?CDQMBW/vVI8lMTm1yDeeBNmvxvfJ1PY38Ju7sc9NbyW8LNJjDMdKQ7NNtwHQ?=
 =?us-ascii?Q?tZt/ngLdBk2NkQzQ9Ax8fD8CY4WvdKPqRUfGO30K6xWVaVZlJBho/LipL9va?=
 =?us-ascii?Q?PK6UPzagC5aTlIsah1xa+RCv6tZPia8UKR64PT51hcNRF2I4FVkGV9oejXp3?=
 =?us-ascii?Q?X9p524fkNibObBCg49h57rryprtRvIQqTGn9En7TxWOKz9RuC6WSRI0/t71p?=
 =?us-ascii?Q?mBqj40/MYwSK6hr8eo489jeCTwPJW/7Dn88Vv6bJGCfqDOXFou9OP0GcSgzJ?=
 =?us-ascii?Q?/TrMymXQviDLwP8U1bgVDO65ywRAc0eomvOpERHV36KK9JBWdvRaevYDPrQ+?=
 =?us-ascii?Q?qqZ0T16s0DGyl1cg06qoA09Agre175yTSbx5RDBFX4oJUHNqPRZFEbJH/DOx?=
 =?us-ascii?Q?snB3DL4S1KHXhLbPLG9P1ybJSIGt3vUNtnFKRkXEUbxLbqt3XMvF3njOWGFJ?=
 =?us-ascii?Q?gnTwjNLTSJNaySXn0DCOlmruZlVC29mhXsKVwCT1qP3HDO9UqavHLELg8efO?=
 =?us-ascii?Q?1uHHqjQeq+/oWcwL/CV+azRomLLIpCzaNWVlLQiHi/RNpJuAiLaHF6cAmgon?=
 =?us-ascii?Q?Q4NZ3xpSb12Ewn1aKwv8grsiSwR0hVqpv01/aLapBZ9E2a6ZCYC5ESMZVUOg?=
 =?us-ascii?Q?R0H/ZDjzI7rV8Ddd/0tNS2m21ld1eTzg62isjlIZBh2b4070HxI95BjGkWpy?=
 =?us-ascii?Q?p8g7u9nkJA+qW+h9V2WzsK9c28czmqFZdylJU7NRhYCz0nQ8kOhBgZC355vI?=
 =?us-ascii?Q?KEAb4CoBjYfE1WZMQLMU8CZlKuEFbXX1TXVt4FB8Fqiux5kmOqX09Bzm1Ehs?=
 =?us-ascii?Q?p+KxBApoz2jepV/ShgsAQnAt/VZIGazwxeicg2JshX8UEyi9qM3f2yXeHDMZ?=
 =?us-ascii?Q?0EsBi9BrrMfkvNtTgfc8tQeWxHHkBPNPWJl94nttRUOn7pxIEhep8uf3zX71?=
 =?us-ascii?Q?1LVOr0RIPgYGUnFqo93/OqKZ0JOLayXsAwjCklfgRf2Gyh+8RMjpayb3TY+j?=
 =?us-ascii?Q?NTyQ15u8ziRcSPqqZOByEAI7QWYF9U06ib1R4qpmCq4ByPXQdDow6XUD+umm?=
 =?us-ascii?Q?8cYcY/CAl/XFngbtj9OrbpaAaT15aOzLzaotrCOlChvt+GYc9Cj8BWIcWk3q?=
 =?us-ascii?Q?SU3Zv/8f0BKkx8UGmHLAxa+nLHzs0yYf3qvKreqN6rmTnytTYxe+zBfJewsL?=
 =?us-ascii?Q?bdMdF2zY9k5+R8itg6xRu5xS64nPWm2OEvyczu5YYCuyNEI/CxAIyF/d4KDt?=
 =?us-ascii?Q?Wqb1MvfiDkBMTHI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZg3q0WFoxhWH6UNk+j0ThaB7/zcaenZ8q+jraq0DK/gTWZKjidsbQTCzkK/?=
 =?us-ascii?Q?nr5+KfF//gqtiFJ4tjByLXXMHlM5q7K2UbAtzKUgv55buP7NhuCoYu8pk/jj?=
 =?us-ascii?Q?ZLWwlDOAokJytqGHXgFo6kOPbKOCCLgRlbFeYWkhryrd6u0G7542QKfKLf9N?=
 =?us-ascii?Q?I6AdCzV6X2lJR5b6FWulnJ73HhiGY68G7zx1jZpHgIkGI/rcZaqOGLqcvfq/?=
 =?us-ascii?Q?kk/K+OOcbKgizaCGTYmy1NCMzB+rBIEf2Ot8I6qm8zS3f8HC1HGSt3krlaOq?=
 =?us-ascii?Q?hb5PRjqPlvf1bCUIM/WgAPmRhSGO9yNaYoogbXsrsdoCnyFsQZOYHu/RC1y8?=
 =?us-ascii?Q?Arof38JiTMXbFLqC4xSlY5lC8SXxqbu9d+AfbGg2hwshh05IvoGBxzC0ukd/?=
 =?us-ascii?Q?4IkxCQgNVpWBaTJDmq+oFKwC18YXA5GAbjDSfOy+Fno5goVeCsbKr/PHr2Kj?=
 =?us-ascii?Q?fRChvQx4PYsI7Ai4I1wE/aJ/qSSVEvNq8R6N7tBNmkUk1dq/3/D2FQc519kG?=
 =?us-ascii?Q?IxM5GKHWh6V1Go4tkuKh8QCSVJHfLyh62uE93CLunwSOZDV2Bw3aflGXQJD5?=
 =?us-ascii?Q?sr62gHPD0ge96dSahKJ/ATybXqljg4a2Q33MJoBatqkOtk8wT/Y3URhF336L?=
 =?us-ascii?Q?jBVzsseLQPWCgiuDsiP0Sitb+NpLSpRUh1UyUXk8UlbskcxJ2VJnAVhDqHX0?=
 =?us-ascii?Q?CqpxoCNHxe8ehPD6gfhc9b++CVGXLAlCIhYq0KgW3gEpwOKDWrefT+Hg044J?=
 =?us-ascii?Q?ABMd2lvb2a4M9h6yFlsuIcoZwtM/TzdyrW1wmBYdTKgDbbUZPxoO+V5tsBGN?=
 =?us-ascii?Q?vVm3I6AlvRRSblTLua/meTWk1h6Zf7MLUnjKVT0G04ieMEks6CSmrb6uv6D7?=
 =?us-ascii?Q?b/8W2m7V8KE64ca8nueNr5vYpkke3g9jjwfd+hbYE9v9uDmBiM1Fw01CO1S0?=
 =?us-ascii?Q?NqMbGC+D2stsMGKZAe+vbJlOhKVOLO9BU7t6RNw+sqsM6VwGE9GO5GdjM1gx?=
 =?us-ascii?Q?AXPz+9MuJR5EGpwhFIqte32KxDM6uSUacqppmHS0CaxP43mmz9xtq59BZ7sZ?=
 =?us-ascii?Q?ZdOazM+h6AH7Nh38bcssyx4roCrmBwWMmkYCOduLNQMKf5ssQP8HGNseI/hd?=
 =?us-ascii?Q?nIzpG4jYUyafLT9Ao5/f5JaV7IG9TjkWqCeTV0cpVTE6949N/1fb/M9Hc+xO?=
 =?us-ascii?Q?TR/Q6mxKXmK/naJB2/Z/FTDgUz+GxqzncQAB7oiXnQ7UkP0RMG/To0Cs/aAV?=
 =?us-ascii?Q?wf/YeWm3U0odPMoLWxzAbK2eVVOFGOTkFGVsU6eVeJ1BLocscnLTRWKiYVg6?=
 =?us-ascii?Q?l1dIvDw1GGy9QGkkAjsNBLdYaY25gy7iUKj/q6P+f0TloP2oSm3liDzqXpkl?=
 =?us-ascii?Q?GR3SX5BADBGpuDlE6jQrXLFXIaW2PRh5IWhv11uHyjE7HDQEOkAS1WPaK8kG?=
 =?us-ascii?Q?wmOkUfwHRONHkc3J0NG6dnRAm4gte7CKN8w3GgXqcXBUW/rpjQc4Vq4RzXWv?=
 =?us-ascii?Q?gYiw9uoU+wK2GTwRpzJ88X004slLu8mRC/1v2VHV3s7P084BY2DZLUAG4/i8?=
 =?us-ascii?Q?R4Twf4IR4XEt0o4ReHJxIjDGKpOEu0cr7h1rTbHT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7257af4f-164a-4b10-f321-08ddded564c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 04:03:45.6262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNePXyERCYh37xOPOz1lxgvvl8Zx4L8AXPwATwoEerlrSflVCCHgQmanm4suT8rCzjcV9i399ArnmUjaW5cDV9Nyqzcd/X2hVfVaUGsH+/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7243
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
> Sent: Friday, August 8, 2025 5:40 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Yuslaimi, Ali=
f
> Zakuan <alif.zakuan.yuslaimi@altera.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arch: arm: dts: agilex5: Disable cache allocation for re=
ads
>=20
> In order to circumvent CCU NOC issue in Agilex5, it is recommended to
> disable cache allocation for reads. This prevents hang issues caused by C=
CP
> (Common Cache Pipe) Fill Done FIFO overflow.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> index 402f0bec173..d51a9e2ff7f 100644
> --- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -209,7 +209,7 @@
>  					/* DMIUSMCTCR */
>  					<0x00000300 0x00000001
> 0x00000003>,
>  					<0x00000300 0x00000003
> 0x00000003>,
> -					<0x00000308 0x00000004
> 0x0000001F>;
> +					<0x00000308 0x0000000C
> 0x0000001F>;
>  				bootph-all;
>  			};
>=20
> @@ -220,7 +220,7 @@
>  					/* DMIUSMCTCR */
>  					<0x00000300 0x00000001
> 0x00000003>,
>  					<0x00000300 0x00000003
> 0x00000003>,
> -					<0x00000308 0x00000004
> 0x0000001F>;
> +					<0x00000308 0x0000000C
> 0x0000001F>;
>  				bootph-all;
>  			};
>  		};
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

