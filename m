Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAFAC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 06:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA8888AC0;
	Fri,  3 May 2024 08:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="VeSuv5C7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76EF588BE1; Fri,  3 May 2024 08:37:01 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D558588A3F
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 08:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVX8eRp/Tn4WOQE97IF/XhjoitcOZoG39AeOlUCbj8aL0tIN024/7YoE9ClF83D1Owa4641uPRa7i4eEh/gq27ex5EQzC37txBX+ENuSr39Lx4bqhM+XmZDqnvRQcJS+T3z9mGLc1hFc6RuYQNBYd7RR4G+jnRUx1aQJrYURdugntNjUX83wUaDQ8MR/itRhcYCeWNX3ryJZoYrRCidpL8bWqoGAH2yV1pumGHC4DnWLWV7TrjLp5Of9yvho8zOJux4oGyIKYmyJ6Q72yCpVLqbwaCwgrefLbOKyLwUrD11iXqV0kVRCACH1U4PWlzOSFwhKmL53XW5KGmZFPQ7Plg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p4Z9Ll4JH7s/AalO20VCZt9MymIr4Ez9oGsDSYjcr8=;
 b=PBIf/vB8ik9miBdeGlUrbec2HwBrvPeLPwWxb/Cu9Kqp3ycTpbMN4qGLNvUX3NdXp76j5ohAUlktv24lJTWKmUEY4MQqHoNslQGxzN84KV+IdUKzGkkRet6TldYAmt5lODf9fyZIY5O551WQHXqo3y6zJCikowdugF/v2qmICqAcVjKT468g3JIVAHA7ixfckzR7Vxh/oUGf/ftWHCfRhI+d07iztwrxzFZgR1er0kKGci/V/7dpMspWGKQUtmM2K54Y7pBc2c8ISCAOIiddNo5plkta/j0WRjNljUxdtlt9Vk0wL+DZRn4+g5xy/zkRmSvYqjpHitqUMQ/M5K7wEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p4Z9Ll4JH7s/AalO20VCZt9MymIr4Ez9oGsDSYjcr8=;
 b=VeSuv5C7Jj+DOuC+wcxgBoyVo3jnylr9vIs1dQQljfuuIVwZZaZ5vE3InaPLEOo3WYBEdBZSkSbqJHfxL+aPwqARElkdyUhrFmmucygVbyGzu7an+fQq0XtFbfnUPiIROsQJNv+jLeIPVWisGqyPiIf2T1gVgAvnEW1khspex4dR9gMil4LmUHhV6fQ40SMWp6GiUj+nBhBauYBhS9gCzI6gust6fNXIhksqGQT4UYBXlkmbP8yRsbhEO1D4iNayrf+FOB2FS61m0GrBI5p/lWLwNHDtQ8Ps2hl1NMV03AOULGMwKMeAJjjWTYtjy8AeorM9qM3SihYdO7wzp4fSeQ==
Received: from DU2PR06MB8334.eurprd06.prod.outlook.com (2603:10a6:10:2e5::13)
 by AM9PR06MB8148.eurprd06.prod.outlook.com (2603:10a6:20b:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 06:36:56 +0000
Received: from DU2PR06MB8334.eurprd06.prod.outlook.com
 ([fe80::319d:ca18:d682:3eda]) by DU2PR06MB8334.eurprd06.prod.outlook.com
 ([fe80::319d:ca18:d682:3eda%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:36:56 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Heiko Schocher <hs@denx.de>, Niel Fourie <lusus@denx.de>, Aleksandar
 Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
Subject: RE: [PATCH 078/149] board: keymile: Remove <common.h> and add needed
 includes
Thread-Topic: [PATCH 078/149] board: keymile: Remove <common.h> and add needed
 includes
Thread-Index: AQHam3GLDMCvjKhUjE+HhFDgPTtjLLGFEQRg
Date: Fri, 3 May 2024 06:36:56 +0000
Message-ID: <DU2PR06MB83348D44C4B44423074128A6F71F2@DU2PR06MB8334.eurprd06.prod.outlook.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-78-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-78-trini@konsulko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR06MB8334:EE_|AM9PR06MB8148:EE_
x-ms-office365-filtering-correlation-id: 56fbd8a2-e215-4608-489e-08dc6b3b6d86
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ildcjfcpv8orqWhwlA4JJiU6EjgUpMuIWLgScBl1OZP+U2MEHw+6PGVXn4Ec?=
 =?us-ascii?Q?InvZ1fkIJUXvPpcfHvfGqHCfD5o9fHL1HxUXqFsUgEv758HhRU+3m13eKPnA?=
 =?us-ascii?Q?jP03Tz+SlGz+9bkCe3sgWeilJvMWib9LKgFtRrmuIkvfAsOwMe+TN+olqsfT?=
 =?us-ascii?Q?DFXFCicRNV9Xh3KkZoChZasNZFzZqpoxMZElqD05KAmIDkn8LQiMPeBThfQW?=
 =?us-ascii?Q?S8eQKDx+Zrm+tvUwFWbkCaPp6vtmMH7YxkQGsN9ummObGySALqD/evosGfHU?=
 =?us-ascii?Q?SiBe1vOa4cTmXT0+GzaMMWDU/BzPnc1YFBbRzHWMRBmvdgVZpLwQRZMZ+Jn2?=
 =?us-ascii?Q?ETZrQ9LEc5QBkwF0eyxHAgPgSrEyLVCzqpQclOOqgEqF1WTj0AKcwq6AgK1A?=
 =?us-ascii?Q?4i/V4ZUVl0YfgcKHYIyVyYHenHOXODRhc8SFhiDg/ENJ1XE5XIbd8jiwlbxZ?=
 =?us-ascii?Q?0rLdC1X6oFF9LD60yMpWKOmNSUV4J5YbCtCH4hfurePKW6rLykQAjQMy6VeL?=
 =?us-ascii?Q?mlYBmLsVKXfduySOLfmiVMUOxzQU0IK86jCpN6OKfH0QlxmpbIHzm5TAMW0H?=
 =?us-ascii?Q?kNyW8s6RCrsMQ2DDXN6NVz3VkW26clNODAz/XmA0pmCPM7CIo7IJmwSxAQLn?=
 =?us-ascii?Q?QYLgyZkoPhX3TnGpEvNo/SZ/nIc9wu8bqoHEj3Cj39pYVhbZJczzpXh34jvC?=
 =?us-ascii?Q?qBjixSVfvG32JSOLEFZUIojDtAuGwhL1SeWjmu5vOCA/u/AgT0+tTBBx/IgS?=
 =?us-ascii?Q?1puvLH69SXtsvDGAGYttylqS4vpnCYgZkDKI2Ynkf8hoKdfr/wSrkdiYpViU?=
 =?us-ascii?Q?x0/BHCqf5XF8CvLGThsgUyEM6ivuor/aMb94BH7Jd9QrKfeUGGhhS3TaIFUL?=
 =?us-ascii?Q?z+/x2lSEcDm8uHYGHaFbSA6gvw8a8kRse0Rh6kJV8jZt4mce5yYyhZA9Roe3?=
 =?us-ascii?Q?CpX+t9VvYdQBqeqnVgY5SkmLFYL61XAD36vu1M2eXU2vj8hUe+GzgH6ezfha?=
 =?us-ascii?Q?6apOgPm30dtM7IHydsj2ZHT1vF4EwoHxWwrPa7nkHwr0sdxEE36jgPMz59OC?=
 =?us-ascii?Q?bJctWcjGXUN6J2aUr39olegLFjG/RZMuETdXfPEt6lWRoJrDazsFjmxyWpIu?=
 =?us-ascii?Q?xOP5wS2MVv70VlgFEX+cz2p5yGiNefVaGHfL6TEQJoKhZPGPq47O1hcX6oRr?=
 =?us-ascii?Q?M520X1KroPJiAUrPhT3KlugX5gEcAo1rknNIsoPoyArbbC+eElgNzzvpCPkT?=
 =?us-ascii?Q?sHXYm2fzA0h19u5D58BcjIfA+17HMF6d4J2LML/Ls6T8LXnHR3es5uJ+q7A8?=
 =?us-ascii?Q?yi+x+zp9Gnmp7Mtqh0giDR/4FDAb2Fi3VbJS/Vn+VYArvw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR06MB8334.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GhcJL4rUYyTmdbVdeZTWeWk8nYwaLhmeB9n770isQx03WcIcWcOVp+D3EsH9?=
 =?us-ascii?Q?zE0i2J2GOBz5EXIOyLoMotn3Ec4c18SkSBuoBMa5FZ+mFDUbPw9sc83FqzYm?=
 =?us-ascii?Q?qh6SosVxBqYcO9S0pgGlKazjawyKu6Q/+NvhaMRmlNobujXKH/Lcagwn/+x+?=
 =?us-ascii?Q?lrZulyDEHcQjq0zydNNiTgJmqisEBinP1Nx246osby7Nj6VleVWjdSqW3Su8?=
 =?us-ascii?Q?xLPnZSKOWKwquYIilp9T4TdCWh7VmTnowtgAcCqd+xzar/pTKJ+v7De7wqE0?=
 =?us-ascii?Q?OzQYEkaXzwhfdcMaZjfkwg5oAxCiGDnDvd0BrhBk4joztrUCTONXcOveHqmQ?=
 =?us-ascii?Q?YouQjp5HwyBe4iQNUjyC2R6gfG022Cs/DGTnpaevPq7Pfplns6atfbpPyQQc?=
 =?us-ascii?Q?xA6TWyaIRXKmPRANWPRxwJb3jtVtGDcLr8shoqSHdG1wfNmjD2qc4rFOIGgC?=
 =?us-ascii?Q?O9rgU1BNthnkUSA4H38VGO5mxQ3uCY56a0/qlW4v8rfhpXSbr9XGkjReRkKE?=
 =?us-ascii?Q?Pp03rUOykNV3hfICCFOHMLCnzxZDEM2rRqIAjAfxRKFL/t0plNtVOf+4GyHb?=
 =?us-ascii?Q?uhiS5yWb1GKK4VMRW8kYC1f2iO6Ty5x+zdgfg5aEGXBZEN0TYX7tYLwHzHX5?=
 =?us-ascii?Q?a4sMmkAAGhBRPnwSufv5TpUd9nmRG4i3eabKyqdHL2205H7anW11f2COMuPy?=
 =?us-ascii?Q?eeXaDZjEKBR9GcFp4dO2Up7BapRheLS0kFA7+EH5+EjY3r2USfxNyL8e7HDt?=
 =?us-ascii?Q?WYxa+eJOAm3n42Rbgigt66GeMYJxiwpq+ksuP75oJGnRlO9mNAy7TwLxjJWX?=
 =?us-ascii?Q?DLZ0ydL1rZyfVVAoJbgTk+CwffxXP6MJ+45P7tHMlde5uLzHv0ocMcRqU89T?=
 =?us-ascii?Q?2OU9XwZ0YMQ4VJBs9QxceDcxqCRdYM0m7zGqOCCzt/PAVao32ZCO9bFbV414?=
 =?us-ascii?Q?0mgulNAesGyH0bLHbIcw60kTxR8xHr2MPj29rNEn590o11kZ+21sr8LeVc6p?=
 =?us-ascii?Q?bUF2j2M40/Cjku0Zi0p/rQw/q3jwc/X78gnCWbbQp0LlNFAiew6RPvO4YtKs?=
 =?us-ascii?Q?ZTx25nHSFciv9e0rHdmtkEGWnrlFmMG2GCRXT8aIU+fGYzyrNItAX/pTJNFC?=
 =?us-ascii?Q?Rp+eEV/SKSwZ9z69HIGObv4fQ5EYM33fYt9I7NBrt8kubWkKO/x7PODB2YZc?=
 =?us-ascii?Q?K0O9vDA4kseaWcppxx/2sDanKhI6ls652rr2luPENpVYITPPlHfPUwsmVy3/?=
 =?us-ascii?Q?4JJaPJpxEuOG2DG30kPgB2ca2vi4zfb4mQgNlVsFy2BO5NlWf1Fc87lud0TS?=
 =?us-ascii?Q?mIyXknLwwiMTbz0pBq2DVzf5Ag6zJAN4JQTQuopv7LRDVad7cs2A213QcTNQ?=
 =?us-ascii?Q?mMyMMNwaFARWt9TGP9HwNTm45jA2GGKeCbGfPl74zTrzfsp1rBDRsE8R6tG9?=
 =?us-ascii?Q?HhmNiSo2OEV3puNPHAhQBVU1nKVXvuXyPm8O1zBx1LME+4J1qiA90TfYY2+l?=
 =?us-ascii?Q?m+DnNsAs2OqXDcVovxQEi5Z949/0ni5wyQXmO8kmUv4i6IQwTeoHRdO80v5j?=
 =?us-ascii?Q?JEVnfFzeJ6QbqRCzNhYh2jfCrGlMVyYAc+md3IZtvjhMOsBmVX6ZO2rZN1l7?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR06MB8334.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fbd8a2-e215-4608-489e-08dc6b3b6d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 06:36:56.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4A3IsXjiz5blnpPnFGmb1Upr6bpGvLlDRF8SV1EsFSj1Rz+XyVK8XYO5LIejQhEN/BYQnPtMwaIeb29SrYTldWBS2SjYEsNXx2ZQfxDnqAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8148
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

Hi Tom,

>=20
> Remove <common.h> from this board vendor directory and when needed add
> missing include files directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Niel Fourie <lusus@denx.de>
> Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
> Cc: Rainer Boschung <rainer.boschung@hitachienergy.com>
> ---
>  board/keymile/common/common.c       | 2 +-
>  board/keymile/common/ivm.c          | 3 ++-
>  board/keymile/common/qrio.c         | 2 +-
>  board/keymile/km83xx/km83xx.c       | 2 +-
>  board/keymile/pg-wcom-ls102xa/ddr.c | 2 +-
>  board/keymile/secu1/socfpga.c       | 1 -
>  6 files changed, 6 insertions(+), 6 deletions(-)
>=20

Reviewed-By: Holger Brunck <holger.brunck@hitachienergy.com>

Best regards
Holger


