Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6E9CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 01:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FD88319C;
	Mon, 18 Aug 2025 03:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k30/uLHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2481831E4; Mon, 18 Aug 2025 03:43:51 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF5A83164
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ1XnjkjtGW+ezUen668+/N4ZtSnACFcxzCCWAQTh10SLEJUvmdgEiAW1Sm8VzW2KMrTtOHvzEZjrCVupagLX8Mwau0zdGJilJUwmB6g5oN0mfVrOOQLAZb8azHH8maEQmH8gb6LF/o909T39TTFZpJ/6VBogpRThh/y0bIx3E4/BquSGDJrJXz0DGGvFYxA8He9GRX61EY1Tt1zBSXWCEHCWa9nLcuVZXuFXybx8ZYA83kzdGTy3lR1l8FSjkb1B2lfZgnmJ7Gx9qP0M3C2PEXvgsv2VkiU2EnVBzWlwbAKY2NC6ksE7TJqJUzkRBZqKp3+Wo+VKq+em01Sg5vyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IAOu2JTHY9Kb34q/J3AKGiRNy3ptiB9RvorN8P6/Cw=;
 b=yX3FngGWanfmpteGnMeTi3xzHFUE2uA6wp+mWlGNkuHukknDBIgjeLEb4BQ88FSRejiyWVGbpA3GEkLaeWG9zgRFFebwyHUrFfO0Ewt+A+PZXXDW4cWnkdQwSqPbA6KIEPsnr73E7DuEJZKT0uF47e7LeTRWMA59bOQl9pJU/Qni5nH+ebZ9bsVo7UQXTgUyienwjwfJ/wxj1oxQ8vYVHugq8usG8Zlqaz7F+2HyqbkGXCYT/Th46J0R48jeQU5HOLkGrKWOvxXfQpiPnWz+36E2qccaNlLhzSNGKlUu/28DQX6Z+kIYnNBCbZFEp9HFusZSaDzTc1bn5TZe3L3N1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IAOu2JTHY9Kb34q/J3AKGiRNy3ptiB9RvorN8P6/Cw=;
 b=k30/uLHMHw6OCN/yLMD4TXtJPReexe/p1opWiuXVFH8aGiT17KHFXMQOZm7e2owLtrS7AozwRwS+8gDbY8kgP7+kCxURBIg+QWTf3qBgwyqwMsdNavS+zsSgq6pKJdLJ/wYEn6sniC1DzZ9ivC5LyG2pAZ+ES2rdDRjxKSg7/pcuj0z4IEaW48HisNJVA11oc0TxAuoEjXLKh5qgmWsgq1mM4DI9Qel/E3xRwCkGMGob9itP3HzHMr+fq4SJrb9XlgADkEKsT+r6jjsm/G2EKTQUsQ/K8iLy1d/gaA/rKScEa1N7MmSrj07CGqtr0tbn2lzh5sr+dlCMLXTjMrpvoA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7655.namprd03.prod.outlook.com (2603:10b6:8:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:43:34 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:43:34 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] configs: Simplify Agilex7 VAB defconfig
Thread-Topic: [PATCH] configs: Simplify Agilex7 VAB defconfig
Thread-Index: AQHcCEdZrrpVAc7Yp0i2Vo5IgOPI47RnsjNQ
Date: Mon, 18 Aug 2025 01:43:34 +0000
Message-ID: <LV8PR03MB8137380FD5AEBD12343B05E8A731A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808093041.15011-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808093041.15011-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS0PR03MB7655:EE_
x-ms-office365-filtering-correlation-id: b261f830-1601-46e3-5523-08ddddf8a51d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7iremKYj5o4jL5C7V+MVPz6dF3jri8WKOjBBM/TEHllc1Am8+cCzdcIfm2YS?=
 =?us-ascii?Q?qLrTDoJmIb1+8URPZViTYxuPAFLJ0OPxUrTc1lGwInE0nyjHAPWl6kWtjtJG?=
 =?us-ascii?Q?Z8j7Tj1ug06g99kBCnnBn+xo9laEJ5gy1ebtbnTx8hZtU2Gsxr5wDmIalHPx?=
 =?us-ascii?Q?aTdms6sQpvcZzGb4oKkg4sa22s9nAM11N84yauuZpSbeNY36cDdc94dRgiOV?=
 =?us-ascii?Q?dvkiyGS2ul8lcLQM5gb84OyUYOP3hV6/qI9rOMgvjCAo7+aJW4a8zoN7NYwe?=
 =?us-ascii?Q?PKS2gSmLxeEt2/57/6dDDYnjwLIa/0gG6h/A9aJqB8EFV6XQ4AVwnQEeO8kO?=
 =?us-ascii?Q?fD8cAN/egYTtpxk7cV2/+tjLWY3r1MhFmVIzWGhfBq4+yZ5MPNPg2lcd+V7O?=
 =?us-ascii?Q?6yX0mNJ3XFI4uvj4LFwOsDvIWAQPvWJyomOu6WIZjg5pcpsgxJCD2FwF90DW?=
 =?us-ascii?Q?IL2twpX5qywDhGa1Cqz7uZjyGOusvbRWCTqh/AKHGZUxMmIH+Efr9QoxGdF8?=
 =?us-ascii?Q?eWBTW5nJdubUUSmlLNheSlX0iUdh7uG8JYxNI3DmQtTELO8+G9999KkMzOBf?=
 =?us-ascii?Q?PqaLHT4H1+snmVUdV3kEeRriHqZVeruUs6zClg/LCQ+UADYPpMzfk11O8fx9?=
 =?us-ascii?Q?AIwa3oblmJtMptQx0SUX2WzsXbM9Y9Gt683spPOceZF/JVbf9Xwi8KfMopR9?=
 =?us-ascii?Q?epO/MG9RIs8Yx0pLs3EYFX5iH84PCsTkM0ZTD8DcGPQD5LGHQPqJYjHvY0do?=
 =?us-ascii?Q?XxEswDSesnEGOp4xTURMfHfq3W2tm9qH1J8SxFwo97Mope0ardoLSd1RTUQ+?=
 =?us-ascii?Q?GJGxV1KOcdN+2QfobHuBS7EX4yUmvR89mQWuJEj1vUg8ALWmF9rWrv3yiHhc?=
 =?us-ascii?Q?LAybHB8L3v83OYZ1TkFNTg223LSmI34LcyTZhISn8QpWAUFylLB2ZC5/0e+I?=
 =?us-ascii?Q?k9i8sYSwbBzy1WdInzQpz2H2o3hHV6hgBWYcpquJUp5kZ4hKePMENVf/v7fm?=
 =?us-ascii?Q?QJL0fQhYHMGMZlPyn5A7G+1X6lArw1E2aNBLlcNdInu0ThGrwoNiPdfexBSi?=
 =?us-ascii?Q?770sEQem4w+d8DZNOu9maTNvtOqCscYnEGhWcm+2OCN1cbw9txaDjKhbfW9Y?=
 =?us-ascii?Q?BTFWgLweWD5SGILAtBdglaAPo0GMrubjdqwAoYZJI+l/UAhVCdqlKLf1uQ6X?=
 =?us-ascii?Q?KAP5iGGsE5wEohMGM7oxhdsA5ITXUsGQCVchRKrJJLR0gHGZJPC4CN1QazNT?=
 =?us-ascii?Q?G8o2rnqi+usPCF6oOVnTF4SDaUc+Spuie7lXtH9Es4veqSC3sbY4h5iqg8UL?=
 =?us-ascii?Q?fZ3koA99Bh2EMqCU4Mxjf4gEN5+nPkd4j0eisTTyc/5vdm5RaqsqYQvbYSxM?=
 =?us-ascii?Q?SNrnU6utJUjnu+HbY9VBS5UFGSu7UJspzbvbh5px/WNSM7KxdJZu7QBx9HWn?=
 =?us-ascii?Q?P08QHWIsPQbwi1ekvt2HMrxU5mX0Hh7cUqYGmtK0rxuzoUUwdroYHhV7rMwo?=
 =?us-ascii?Q?/i/x++4FaSmrlaU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N6OfTqG/pfQdAS9kg1qR3mxfhea5iIXAoPMZj/4Cpqtpqu57XIlLkU43V6X0?=
 =?us-ascii?Q?vKMC8cx9bTjINsZVI6+0GZVe8pIzKk6w8TArh6LOME5qGvsrm2WeaVCGQ0up?=
 =?us-ascii?Q?RzUPFf4e/Ks4nCGzEDVVW9toaqnfBPLpSaAxBVOBgq4PtzRXP/JyjPqEiuaH?=
 =?us-ascii?Q?GGk4IY4gsSHLWvaukpgWqff7/7QCKCG+rpCULSzKkhM5QEdF12jKJWee/vQS?=
 =?us-ascii?Q?Yx+A7nQu4cEc0hIsdlYCvLQRRpeycjrVDl3DGplWqE+xYTgIPVGIcdMKLqGu?=
 =?us-ascii?Q?YB+tct0w+j+F2c/kUXLnk7zfI9RTUJPOA9D/9hJ6J3AufxlrdQhP779bGXPl?=
 =?us-ascii?Q?w13CrSijmWwSAJV/MhYdQkWiKUaYBUn/X+hwLEDwcQtiK2NwfIZIL/h5hHl5?=
 =?us-ascii?Q?/9LLrYQZoMBq6VuhLzCF6Y5BAvwA8XF+vayT8CEXZQQRZMcllANs6mx7480q?=
 =?us-ascii?Q?J8mjRbn4Zd8qYgceuTYGDE0Jyr4Gsl3Qjif0C2u7djiB07aJmavA4XGw+ez6?=
 =?us-ascii?Q?UKjeDw4wd4vPvQNCnbIZAxE4s7N8cwiRd2kR4C9qrWj7f4KsJj8Dcip0/rs0?=
 =?us-ascii?Q?W27YgSfOg9eNdJSaGWCZo/nWemfK9v1bjss7iUZoV0RGApTGGGayKrjl55Ez?=
 =?us-ascii?Q?41RZicV/FitFxgJ7UJVvpvN3BMt2pqz/PrlXCfi0pwSbhtGF98onVHy84Skk?=
 =?us-ascii?Q?k///RAmrgSx5fIbtqfcjgqko0/L5SRQLIMyUTTh6JiOzFJpSU1SWwm2dEZ7h?=
 =?us-ascii?Q?OJHKEwafmBjSIrlADOf9F6gcsJm37dDfhx+N+DT4AmPQK3W1uY2Sik0OVBS2?=
 =?us-ascii?Q?QJ+OTD6011ZNy4nsWbIT414ILNEvG3SEDYLoZqUBsvL+0OdNfYVbblnw8Mpn?=
 =?us-ascii?Q?kBvfwqf2yfqqoz1ZIKOhvcni9H9JJxG389bpYrW6WcLimbZWXDN97eJy6mhA?=
 =?us-ascii?Q?vWa33T+koWGA4fTTj26lVZjOEt5pRi2OjL3uyafUfNTt9nGEI1CRGrZP/EPU?=
 =?us-ascii?Q?aen3ug0A/s6SfR9YLFVsMNY15eYPT/R6BBuzPjHhxlV8/lzzKE3Vetx6vUmD?=
 =?us-ascii?Q?7sc60QJUcmuerIRqYsNArzoCOH7uzn6Y5pyc6dPEtIPNSkdCVsEthXo89ntL?=
 =?us-ascii?Q?yXeSi1Y+F24cGWLDSJmKgLVbR6bnrXXGZ3QduLU1AWpPQrtvD9EtzWeMzqNB?=
 =?us-ascii?Q?kPRQHq6TMihtLzVOEZxWM7s3olpJgVx9JZ6TsUmIQCwD3jLpBY+KyK6VNKp5?=
 =?us-ascii?Q?f8fDvmJYfdpBVOdesAg0FiU9NVnVGNTolSwDss3qEhcQwdvgBhK08+alB6SL?=
 =?us-ascii?Q?afNuUGqYCgVqvKe2PsfzPFZg5lUeBAHLOluqBdQ6PR+o2UtwAjGtjAyARysJ?=
 =?us-ascii?Q?AOx5+OIa8+uBRSrqt9rui19ZRPySeFYTwu1KAE3v/wOSE1uPj1UnHKAUC0k5?=
 =?us-ascii?Q?d9P0vD+yKzOcrQ7hq+Q2a/sjmN1H7807HN/Sy5rUiEyH7Cd8z+kFywpxwnoy?=
 =?us-ascii?Q?VKzex5GKVsGt1Q+CRu15/MO0H4V7B3Tol0BFBw2CMcyZp/T/2OVduwSipaPm?=
 =?us-ascii?Q?MuVa/WUr2vCH22g6kqzKGbmhQZlX457ywOL8hasG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b261f830-1601-46e3-5523-08ddddf8a51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 01:43:34.8159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfPs0XyLkQ/ajmNEOP0PXjg4M/e4ZWAiaYWlogtEVjk+WJNUK0A3fkgWoLThVz6SPkqIkW3pH2Ps1w9Mv7k/+uKFkrCbF1kPnSjLIZCE5Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7655
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
> Sent: Friday, August 8, 2025 5:31 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] configs: Simplify Agilex7 VAB defconfig
>=20
> To ensure unintentional bugs occurring because of config changes in maste=
r
> defconfig and its VAB variants, VAB defconfig files now include the maste=
r
> defconfig and enable config values specific to VAB functionality only.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_agilex_vab_defconfig | 95 +---------------------------
>  1 file changed, 2 insertions(+), 93 deletions(-)
>=20
> diff --git a/configs/socfpga_agilex_vab_defconfig
> b/configs/socfpga_agilex_vab_defconfig
> index 8eec3d8d67a..4607dc73343 100644
> --- a/configs/socfpga_agilex_vab_defconfig
> +++ b/configs/socfpga_agilex_vab_defconfig
> @@ -1,94 +1,3 @@
> -CONFIG_ARM=3Dy
> -CONFIG_COUNTER_FREQUENCY=3D400000000
> -CONFIG_ARCH_SOCFPGA=3Dy
> -CONFIG_TEXT_BASE=3D0x200000
> -CONFIG_SYS_MALLOC_LEN=3D0x500000
> -CONFIG_NR_DRAM_BANKS=3D2
> -CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> -CONFIG_SF_DEFAULT_MODE=3D0x2003
> -CONFIG_ENV_SIZE=3D0x1000
> -CONFIG_ENV_OFFSET=3D0x200
> -CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex_socdk"
> -CONFIG_DM_RESET=3Dy
> -CONFIG_SPL_STACK=3D0xffe3f000
> -CONFIG_SPL_TEXT_BASE=3D0xFFE00000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> -CONFIG_SPL_BSS_START_ADDR=3D0x3ff00000
> -CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> -CONFIG_SYS_BOOTM_LEN=3D0x2000000
> -CONFIG_SYS_LOAD_ADDR=3D0x02000000
> +#include <configs/socfpga_agilex_defconfig>
> +
>  CONFIG_SOCFPGA_SECURE_VAB_AUTH=3Dy
> -CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK=3Dy
> -CONFIG_IDENT_STRING=3D"socfpga_agilex"
> -CONFIG_SPL_FS_FAT=3Dy
> -CONFIG_REMAKE_ELF=3Dy
> -CONFIG_FIT=3Dy
> -CONFIG_SPL_FIT_SIGNATURE=3Dy
> -CONFIG_SPL_LOAD_FIT=3Dy
> -CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x02000000
> -CONFIG_BOOTDELAY=3D5
> -CONFIG_USE_BOOTARGS=3Dy
> -CONFIG_BOOTARGS=3D"earlycon"
> -CONFIG_USE_BOOTCOMMAND=3Dy
> -CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcfitload; run mmcfitboot"
> -CONFIG_SYS_PBSIZE=3D2082
> -CONFIG_SPL_MAX_SIZE=3D0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set -
> CONFIG_SPL_HAVE_INIT_STACK=3Dy -CONFIG_SPL_SYS_MALLOC=3Dy -
> CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x3fa00000
> -CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
> -CONFIG_SPL_CACHE=3Dy
> -CONFIG_SPL_SPI_LOAD=3Dy
> -CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x02000000
> -CONFIG_SPL_ATF=3Dy
> -CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> -CONFIG_SPL_TARGET=3D"spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=3Dy
> -CONFIG_SYS_PROMPT=3D"SOCFPGA_AGILEX # "
> -CONFIG_CMD_MEMTEST=3Dy
> -CONFIG_CMD_GPIO=3Dy
> -CONFIG_CMD_I2C=3Dy
> -CONFIG_CMD_MMC=3Dy
> -CONFIG_CMD_SPI=3Dy
> -CONFIG_CMD_USB=3Dy
> -CONFIG_CMD_DHCP=3Dy
> -CONFIG_CMD_MII=3Dy
> -CONFIG_CMD_PING=3Dy
> -CONFIG_CMD_CACHE=3Dy
> -CONFIG_CMD_EXT4=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
> -CONFIG_ENV_IS_IN_MMC=3Dy
> -CONFIG_USE_BOOTFILE=3Dy
> -CONFIG_BOOTFILE=3D"kernel.itb"
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
> -CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> -CONFIG_SPL_ALTERA_SDRAM=3Dy
> -CONFIG_DWAPB_GPIO=3Dy
> -CONFIG_DM_I2C=3Dy
> -CONFIG_SYS_I2C_DW=3Dy
> -CONFIG_SYS_MMC_MAX_BLK_COUNT=3D256
> -CONFIG_MMC_DW=3Dy
> -CONFIG_SPI_FLASH_SPANSION=3Dy
> -CONFIG_SPI_FLASH_STMICRO=3Dy
> -CONFIG_PHY_MICREL=3Dy
> -CONFIG_PHY_MICREL_KSZ90X1=3Dy
> -CONFIG_ETH_DESIGNWARE=3Dy
> -CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_MEM32=3Dy
> -CONFIG_SPI=3Dy
> -CONFIG_CADENCE_QSPI=3Dy
> -CONFIG_DESIGNWARE_SPI=3Dy
> -CONFIG_USB=3Dy
> -CONFIG_USB_DWC2=3Dy
> -CONFIG_USB_STORAGE=3Dy
> -CONFIG_DESIGNWARE_WATCHDOG=3Dy
> -CONFIG_WDT=3Dy
> -# CONFIG_SPL_USE_TINY_PRINTF is not set -CONFIG_PANIC_HANG=3Dy -
> CONFIG_SPL_CRC32=3Dy
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

