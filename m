Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BFFCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 09:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D75B81E13;
	Mon, 25 Aug 2025 11:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hbU+gh6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A01DB828A2; Mon, 25 Aug 2025 11:34:30 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3BA808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ry5B5rKPbYwd4hUFGSlENimch6yqzX36swEhXH00JlMINzAyDciDyVo1rsWIeXPkL/kwjlhU+jPMbogClYFoOcFu9NyoTbJldfv4GY9jSDXzbVG9jFwcupXZVmHvYFU5qSvQQvhRAIyMnnzMsIApNg001oRZPwu+hnhj7L+WlDgqsonignHEb1IHU5TgJohNU29QLRX7LpGgnsmhNIhP7Vtd2hXJNMMoYSo++mp+qyn05NnpI64byEZ8Uwp4VWrgktrtKmNY+d1wS2Oc+ETmuqFJRdrpuLtziZ02UHlmlVubSCV1TXf9lnhdeI8OszW0blrlKmD4awpgblYExNnGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+v5QggzHorNHvUwYx2TKPVD7EBj7I0k2AW5UKIpYPk=;
 b=l5C20ElLekgL1XF+Htb48HaVSVLdoifzTtZnLjfoKLS79F5E9ykk3dCuuU7T1oiMtUVvGjCbmtkbJcUdAagiRH7l7RFrsg03vaA8wKmqvY1tJvLqpq2OW2ePwppEh4H/+VtiShYH5OOpn6NywRYn7tut2pFErZnb4seyzcF9uoiH/bT234qQ6xN9IfvJ591Y5mXiqThvQcKVdb9s0I02W0lgaZEWGWsvsFba7f0qie/I+gCEUNT76arNeySf6WBEK6KKfyPnEGkVsRJm10TTndPtYUxtMhrSnitt7ZxdijnVMo8KQN7sMjDSR35pX45iL3LVqLKYyN7fGxkfbpnqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+v5QggzHorNHvUwYx2TKPVD7EBj7I0k2AW5UKIpYPk=;
 b=hbU+gh6P/Tu898niNN/J2JBCaKrpKjX8ueUDuGJ2wt7JEfQRxo9IPlVCG7T6pq7pjeAsOSN3xf9DxaiXCZDpIDPByeG831OBcTvF7pNpbgpZZUFkx+iVUgxtpofc5lK+raWC2F0ALfZCAmYqlb7xH+SBWoNbN+8MUASWrR/7j+SFM9oiM9FYgea45YIJ2vOihV2s2CPXVbe9KKJw833QQ4FLMG2XlUL5R0MTZ0eqIUUbohxC2ANW7UPSEgC/cTeHj6sHvIgjSk0BsKuEf1nA2xeTPY9dK7TRXNkz199uqFYqmAHco5RfjRcLQHIagORCcTZrRZBTZSDa9Bq/H0VVEA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by IA1PR03MB8237.namprd03.prod.outlook.com (2603:10b6:208:5b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 09:34:24 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:34:24 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Michal Simek <michal.simek@amd.com>, "Ng,
 Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 1/3] arch: arm: socfpga: Add SMMU initialization and
 setup
Thread-Topic: [PATCH v2 1/3] arch: arm: socfpga: Add SMMU initialization and
 setup
Thread-Index: AQHcEaSS9f4IK4fDBUy43OJN3DW/q7RzIGPg
Date: Mon, 25 Aug 2025 09:34:24 +0000
Message-ID: <LV8PR03MB8137E80BFD22E9731A284037A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
 <20250820073201.8649-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250820073201.8649-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|IA1PR03MB8237:EE_
x-ms-office365-filtering-correlation-id: d486eb41-d963-4c89-5aa6-08dde3ba93ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007|13003099007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jg3zWwzb28KDE5eysWdMKKrfYQjLBLv530ajmKq89w9QK9AZCfMFre40m4KE?=
 =?us-ascii?Q?T+O5P+NL2ildivl3OtqrJA7PjldM1GaPiNNShQRpRhDaSQ2QCZMKtEk/az5d?=
 =?us-ascii?Q?IprMIqAkxlxZRNGvqUA8nvIqwMLM6c7ByNK6euZzn0dXTwjXhpaER4Bt1vq3?=
 =?us-ascii?Q?mFo5R5zhZgSqo6zpcYkDOG7ZD3vw1pXRXFYpmv1Jgn9KN66GLxawWawxG7dQ?=
 =?us-ascii?Q?5B9XKyyP5Vflt0XnZhl5fi/jppyOAcUVxFx2flqK16x+nit7+bmSn4rWZP7C?=
 =?us-ascii?Q?5FZoyUmdSJX6XWL6SVshaaUnwVhyPEQ8PxjnAxyWNwlMEZ1ENOKgfkR70BP9?=
 =?us-ascii?Q?Y9Tb9PEjKjEYvfTOrxlR5Kx+EDyej1N5Oadlf4qb1hRnWdJlQulvcrAVsZwy?=
 =?us-ascii?Q?nfBEMIb/zqsLgCFVJi5UeyFKazqz9ZtbcS2VzJ+5tSaVXJw6oINJT33ERgYJ?=
 =?us-ascii?Q?QkhSAEFkkxkxEbPtt82t6oraHiihSnh8oKbpI06Hm+dPkZLICX5yu86vkcPR?=
 =?us-ascii?Q?pO4fAMpxXzsFOOPvTpomR8mwCluhUevxJUQcjs3OzQ2wbu9dN4/73MMGhqcV?=
 =?us-ascii?Q?lkOiWxkqbVMXXaFvWqWPEPgyVQvXix8Osp79ZAUn4mF9n8NNZj2wtdCvP6hk?=
 =?us-ascii?Q?swYURBBwVm/DcWjk7NJONAL86Hbi+iYvkdeaaZc9UWOlJFnmZDcTsx9HQ1yB?=
 =?us-ascii?Q?PRxSm0Gxv45Ak4EsNYdtJZcMiDs/7TbxqyYkl7B6gYQl2gekmhxUYatqjFCE?=
 =?us-ascii?Q?rSZvPogdR3ji+4D7MPQggQiVFm3rPe30xIsuJSfJtD4Dul7EhUgixpEl9FAW?=
 =?us-ascii?Q?+tQ/yUImS6uKF8zWxTYWEUsfF9dwG3JK3siNCOQEWZ1mPCFv2ctZSnZQFej4?=
 =?us-ascii?Q?OvJ+Se75gx/GLvgYlR5fliLSpFIQoIegg6sddqBfW/vVGyzWpjNtqV4eksQD?=
 =?us-ascii?Q?C891/CN9DIxo8LzSCuLOEFoH/lDkKOIyPxPZGkPbhr+kWwVF793v0CdotAVf?=
 =?us-ascii?Q?kmGcZcTWG317spwtxj1KFKwUvzx7Zkdbj2x2DPsfGIAhTsDLKLUh5Qcdo49P?=
 =?us-ascii?Q?H4EwzoyvOec5WJiGmjmKTHdvqk1+jvtMrcQLIoGHnLEXvqdss07WuvtiU1tb?=
 =?us-ascii?Q?kronyczPZC1zlOKW1huqk7om68EFLjUOoXjP4Ov9obo/XtmFQCqTsVOLZTsB?=
 =?us-ascii?Q?+yHnaMkwDP3Y6Dg1JCVe8h+/n4EXkKIFwvoSucflrgyHvTzeu2753UOrMHoD?=
 =?us-ascii?Q?+9PzUIx8gkuvo4aQXfOLoj7QhBQqNVGO0BvK9bP8pJFjywGMJv6zutwzSmYF?=
 =?us-ascii?Q?Y6Hlx3lJ4h2LrmfCt74FBRec+thGPE6WBYAQc4n63qN3qa/aP7njVgDyJsDw?=
 =?us-ascii?Q?5dTREMaZ+EVX3hLFAl/wCufyVvOxPnQCOwdezR7f8StAGpzHr9gbcP/TLS5o?=
 =?us-ascii?Q?Q+gNwzz0JKI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Phxo/wYGab2CarYED2Im65GeigIBhwQ6xaPOs2rlzB1+ipdwoWZZEvSnLULc?=
 =?us-ascii?Q?VAWbvIw3UBmx1cAJhJzB4FfPok5oji5cXfSrrPQX9YVPy3X4His5ztIJaw6L?=
 =?us-ascii?Q?KkqnhbqCaOMmApr+p5OaP7IoKuzACrwTj3G2C2YhJPgaZtmIo1aiwHslFWHE?=
 =?us-ascii?Q?PXus9JYl2g82WRd36Eqt4Dq9S9D0O/y9B+NaeWmmZfMytWRwh1vcYuIDgmw7?=
 =?us-ascii?Q?sOQf39BVM6E3n6ipFrWu/KExICpHI5B3T4XT3YnMFkqrqKan2HK1kIEaLsOQ?=
 =?us-ascii?Q?lc7TgkvcXCT28Orn4I92v1nxwMriqUXdmVKhHoEP4pYcleweWFeaLvqH7Z9W?=
 =?us-ascii?Q?eGh0F7xIrj6gGpsbp+wgoqp0BfmsbxA6eINM0fP9oPZr20Z2hr4mymP6YdrQ?=
 =?us-ascii?Q?5f6aFGTARtuXA4COqWvbOVWc31+31ZrZMUqRdI5qUsNRd5xSxbL030BE4P1v?=
 =?us-ascii?Q?Co5onLxIewzsypCBDPgVwG+7TMdx68HXTfyIwmhZmm4zZFRW0Wk3ZOy8h7qZ?=
 =?us-ascii?Q?DNEjAhAPoJYWyTTsUSS6ZnQdppkrtXJOQ4YPWw0eawtJGvcgjWayfqApi43X?=
 =?us-ascii?Q?98eiDEWF9zj0QyrWUoani+FihhqGMxZQLYJ9cVpQBOm8V10CUPuUBYCfpw14?=
 =?us-ascii?Q?I5kVNJpow4qWvei665oZ08TvWOk5qCcmM1pIdu+9aTujBkLKqKZF5Ncm6V5M?=
 =?us-ascii?Q?YTJFH5qL39ha0RiWha+rJjkawuQKpF6qr53p/LxbyO7cMksfTu1/MgEqNZnM?=
 =?us-ascii?Q?5aG9aaZNYcjb9Ty0ryfjwtzXG1hbqbGXn+CPUFblMWjguetWFLsxShYqkDUj?=
 =?us-ascii?Q?7SspxX6MCk5iIXmWvn4QEUcuGc2HBT31o4ji1q89dDLpMyrWiGK9XkZPjqLf?=
 =?us-ascii?Q?j0Q0nJ9R+EyGrdl0xmeQgfi4LZ3JsKk/OfvyJI3EXinBnGIywjX5ujpPvZbF?=
 =?us-ascii?Q?5cqyrVz4/cEOwjjfM9Mog0b2pMV91ih+/fLJcQSvrdV1Uk4HrHavCUOKPv52?=
 =?us-ascii?Q?1/fbix8AQ4Z9NDQ3SmKswHzHHgeqdQtVbhpFoCY29gvj3uS7vFs5SrndPnjj?=
 =?us-ascii?Q?D/Q9OWrEaMq3ntPhMMQfxklPp7CkMFmtNpyOhmULlki5yWmrupSV1iuywaCr?=
 =?us-ascii?Q?v8eRNxEdY4muo5AUskd5NBhaNVSz02/qHe+IlPK0XfYqsH1s3zDWauEe2zdu?=
 =?us-ascii?Q?ZY4X1iyN29Q4YyD4ZY2YZ5G3i8V+UJpJBpAPUj8d0X5lboyyr1cHSCLlH8e9?=
 =?us-ascii?Q?HtVUwXc/gFbcArlb9sTmJx1ckssWe3LKlByo6SzgKPF35rgSL0+qY52KZvTw?=
 =?us-ascii?Q?kGWITpp+XyWl1gIc1sL3iuf0dbE02JJRTugTbd2d/rFcAkVZV/2mjd4nMREB?=
 =?us-ascii?Q?npJkVvHsQQfikJu1nXE8mLib4YUBJGXVt2ZJ64t3Pfib/kvkwGBsshai/w8R?=
 =?us-ascii?Q?80SeO/F4E9Z6NsjilaBUbJM4RvS5cubdt4FuYHcXPjv4ET2pMdvremBGunrP?=
 =?us-ascii?Q?IDVF5zX/TG/l/zy4WZFy9qW3qq/Pb03eKkX0vkKRR0+Reux5OxmXXRGw0tFX?=
 =?us-ascii?Q?qBUKeBjf+Km1Fp8jIiU7T5vOaGU4HQwTlP4q1GCG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d486eb41-d963-4c89-5aa6-08dde3ba93ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 09:34:24.1242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrVY25NPsntpaL0vAsht+kTuUY8eIi8kezLGuPwoHdZeEPz0MYdxtRoJ5WNQ5oyb4pHzMx0+WntgEDb/2RJADwVyoFThOIjglnFqHQL4Pfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8237
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

Hi Naresh,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Wednesday, August 20, 2025 3:32 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Michal Simek
> <michal.simek@amd.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Ng, Boon Khai <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2 1/3] arch: arm: socfpga: Add SMMU initialization and
> setup
>=20
> SMMU initialization for SoC64 devices is added and stream IDs are setup f=
or
> SMMU peripheral matching. This allows non-secure accesses with SMMU
> peripherals.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/Makefile                |  3 +
>  arch/arm/mach-socfpga/include/mach/smmu_s10.h | 39 ++++++++++
>  .../include/mach/system_manager_soc64.h       |  3 +
>  arch/arm/mach-socfpga/smmu_s10.c              | 77 +++++++++++++++++++
>  arch/arm/mach-socfpga/spl_soc64.c             |  6 ++
>  5 files changed, 128 insertions(+)
>  create mode 100644 arch/arm/mach-socfpga/include/mach/smmu_s10.h
>  create mode 100644 arch/arm/mach-socfpga/smmu_s10.c
>=20
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-
> socfpga/Makefile index c43fdee4a48..5b414c6e995 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -35,6 +35,7 @@ obj-y	+=3D mailbox_s10.o
>  obj-y	+=3D misc_soc64.o
>  obj-y	+=3D mmu-arm64_s10.o
>  obj-y	+=3D reset_manager_s10.o
> +obj-y	+=3D smmu_s10.o
>  obj-y	+=3D system_manager_soc64.o
>  obj-y	+=3D timer_s10.o
>  obj-y	+=3D wrap_handoff_soc64.o
> @@ -49,6 +50,7 @@ obj-y	+=3D misc_soc64.o
>  obj-y	+=3D mmu-arm64_s10.o
>  obj-y	+=3D reset_manager_s10.o
>  obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+=3D secure_vab.o
> +obj-y	+=3D smmu_s10.o
>  obj-y	+=3D system_manager_soc64.o
>  obj-y	+=3D timer_s10.o
>  obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+=3D vab.o
> @@ -80,6 +82,7 @@ obj-y	+=3D misc_soc64.o
>  obj-y	+=3D mmu-arm64_s10.o
>  obj-y	+=3D reset_manager_s10.o
>  obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+=3D secure_vab.o
> +obj-y	+=3D smmu_s10.o
>  obj-y	+=3D system_manager_soc64.o
>  obj-y	+=3D timer_s10.o
>  obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+=3D vab.o
> diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> new file mode 100644
> index 00000000000..4a28b109b0d
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2018 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> +
> +void socfpga_init_smmu(void);
> +
> +#define SMMU_SET_STREAMID(x, r, w)	(((x) << (r)) | ((x) << (w)))
> +
> +#define SYSMGR_EMAC0_SID_ADDR	0xffd12050	/* EMAC0
> (emac0_ace) */
> +#define SYSMGR_EMAC1_SID_ADDR	0xffd12054	/* EMAC0
> (emac1_ace) */
> +#define SYSMGR_EMAC2_SID_ADDR	0xffd12058	/* EMAC0
> (emac2_ace) */
> +#define SYSMGR_NAND_SID_ADDR	0xffd1205c	/* NAND
> (nand_axuser) */
> +#define SYSMGR_SDMMC_SID_ADDR	0xffd1202c	/* SDMMC
> (sdmmcgrp_l3master) */
> +#define SYSMGR_USB0_SID_ADDR	0xffd12038	/* USB0
> (usb0_l3master) */
> +#define SYSMGR_USB1_SID_ADDR	0xffd1203c	/* USB0
> (usb1_l3master) */
> +#define SYSMGR_DMA_SID_ADDR	0xffd12074	/* DMA
> (dma_l3master) */
> +#define SYSMGR_ETR_SID_ADDR	0xffd12078	/* ETR (etr_l3master)
> */
> +
> +/* Stream ID field offsets */
> +#define EMAC_W_OFST	20
> +#define EMAC_R_OFST	8
> +#define NAND_W_OFST	0
> +#define NAND_R_OFST	16
> +#define SDMMC_OFST	16
> +#define USB_OFST	16
> +#define DMA_W_OFST	0
> +#define DMA_R_OFST	16
> +#define ETR_W_OFST	0
> +#define ETR_R_OFST	16
> +
> +struct smmu_stream_id {
> +	unsigned long addr;
> +	u32 sid;
> +	u32 r_bit_ofst;
> +	u32 w_bit_ofst;
> +	u32 secure_bit_offset;
> +};
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index 8a7d47bee44..3f91707ec49 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> @@ -80,6 +80,9 @@ void populate_sysmgr_pinmux(void);
>  #define SYSMGR_SOC64_WDDBG			0x08
>  #define SYSMGR_SOC64_SDMMC			0x28
>  #define SYSMGR_SOC64_SDMMC_L3MASTER		0x2C
> +#define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
> +#define SYSMGR_SOC64_USB0_L3MASTER		0x38
> +#define SYSMGR_SOC64_USB1_L3MASTER		0x3c
>  #define SYSMGR_SOC64_FPGAINTF_EN1		0x68
>  #define SYSMGR_SOC64_FPGAINTF_EN2		0x6C
>  #define SYSMGR_SOC64_FPGAINTF_EN3		0x70
> diff --git a/arch/arm/mach-socfpga/smmu_s10.c b/arch/arm/mach-
> socfpga/smmu_s10.c
> new file mode 100644
> index 00000000000..50be049538b
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/smmu_s10.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Intel Corporation <www.intel.com>

Remove Intel copyright

> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> +
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/arch/firewall.h>
> +#include <asm/arch/smmu_s10.h>
> +#include <asm/arch/system_manager.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static const struct smmu_stream_id dev_stream_id[] =3D {
> +	{SYSMGR_EMAC0_SID_ADDR, 0x01, EMAC_W_OFST,
> EMAC_R_OFST},
> +	{SYSMGR_EMAC1_SID_ADDR, 0x02, EMAC_W_OFST,
> EMAC_R_OFST},
> +	{SYSMGR_EMAC2_SID_ADDR, 0x03, EMAC_W_OFST,
> EMAC_R_OFST},
> +	{SYSMGR_NAND_SID_ADDR,  0x04, NAND_W_OFST, NAND_R_OFST},
> +	{SYSMGR_SDMMC_SID_ADDR, 0x05, SDMMC_OFST, SDMMC_OFST},
> +	{SYSMGR_USB0_SID_ADDR,  0x06, USB_OFST, USB_OFST},
> +	{SYSMGR_USB1_SID_ADDR,  0x07, USB_OFST, USB_OFST},
> +	{SYSMGR_DMA_SID_ADDR,   0x08, DMA_W_OFST, DMA_R_OFST},
> +	{SYSMGR_ETR_SID_ADDR,   0x09, ETR_W_OFST, ETR_R_OFST},
> +};
> +
> +static void set_smmu_streamid(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dev_stream_id); i++) {
> +		u32 mask =3D SMMU_SET_STREAMID(0x3FF,
> +					 dev_stream_id[i].r_bit_ofst,
> +					 dev_stream_id[i].w_bit_ofst);
> +		u32 value =3D SMMU_SET_STREAMID(dev_stream_id[i].sid,
> +					 dev_stream_id[i].r_bit_ofst,
> +					 dev_stream_id[i].w_bit_ofst);
> +
> +		clrbits_le32(dev_stream_id[i].addr, mask);
> +		setbits_le32(dev_stream_id[i].addr, value);
> +	}
> +}
> +
> +/*
> + * Need to set the Secure bit (to make it non-secure) on each
> +peripheral
> + * so that SMMU can access the peripheral  */ static void
> +set_smmu_accessible_reg(void) {
> +	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC0,
> +		     BIT(27) | BIT(25));
> +	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC1,
> +		     BIT(27) | BIT(25));
> +	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC2,
> +		     BIT(27) | BIT(25));
> +	setbits_le32(socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_NANDGRP_L3MASTER,
> +		     BIT(21) | BIT(17));
> +	setbits_le32(socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_SDMMC_L3MASTER,
> +		     BIT(5));
> +	setbits_le32(socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_USB0_L3MASTER,
> +		     BIT(9));
> +	setbits_le32(socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_USB1_L3MASTER,
> +		     BIT(9));
> +}
> +
> +static inline void setup_smmu_firewall(void) {
> +	/* Enable nonsecure SMMU accesses */
> +	writel(FIREWALL_L4_DISABLE_ALL, SOCFPGA_FIREWALL_TCU); }
> +
> +void socfpga_init_smmu(void)
> +{
> +	setup_smmu_firewall();

This has already been set in dtreg at https://github.com/u-boot/u-boot/blob=
/cb0b67fa49df836627230ba62fc718ea4afddf60/arch/arm/dts/socfpga_soc64_u-boot=
.dtsi#L114, but Stratix 10 board
need to be converted to OF_UPSTREAM first

> +	set_smmu_streamid();
> +	set_smmu_accessible_reg();
> +}
> diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-
> socfpga/spl_soc64.c
> index 651d9fc9cb8..6b219fe140d 100644
> --- a/arch/arm/mach-socfpga/spl_soc64.c
> +++ b/arch/arm/mach-socfpga/spl_soc64.c
> @@ -7,6 +7,8 @@
>=20
>  #include <hang.h>
>  #include <spl.h>
> +#include <asm/arch/mailbox_s10.h>
> +#include <asm/arch/smmu_s10.h>
>  #include <dm/uclass.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -132,6 +134,7 @@ u32 spl_boot_mode(const u32 boot_device)
>  /* board specific function prior loading SSBL / U-Boot */  void
> spl_perform_fixups(struct spl_image_info *spl_image)  {
> +#if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
>  	int ret;
>  	struct udevice *dev;
>=20
> @@ -140,4 +143,7 @@ void spl_perform_fixups(struct spl_image_info
> *spl_image)
>  		printf("HPS SMMU secure settings init failed: %d\n", ret);
>  		hang();
>  	}
> +#endif
> +
> +	socfpga_init_smmu();

This's not applicable to Agilex5

>  }
> --
> 2.35.3

Best regards,
Tien Fong

