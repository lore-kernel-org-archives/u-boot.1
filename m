Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71268C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 07:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D85D81F6B;
	Mon, 21 Apr 2025 09:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="g0BcVfuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2039B81F6B; Mon, 21 Apr 2025 09:00:05 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A619E81DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqIwzAOjaJEu0CJh1b1AQXwFgts7pgvETys2Nm0ZaJ2LQhM8X+04UTmpcn85wFne4r8vjRY1ptedSnfHYgUc0ABc/HWCIzS9kGc7H8jRg5SNmMxY7ay7+qzr8EBo1CxUhK20ykjiQn/TKX7SlqBE9WB+ketVPLGVXNyZTsacsRrxqV+aRvIAmhRT+ccZbum0MXmjR7dGS2Yx9N+jXMOIz1Dg4WDsrfCbhOEHR1TCzreQdNrw57Q54lpXSMat7KFWWUBhRO3NU/K5PrvtnLKaK5ygPinHZYwBRuGuakSNTROi0YUneCXgxw8IsEu4BG4j7oANngrxxMi4tGnCPxkVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk3fLt4CRns2NRz4YS3TPP8Lq62XbU2lXE7nab6QUsU=;
 b=Cz5w6GnOQEpzxkP0/AZbOPAdz5QcVYeQWx5gC5ZiVhL/xzC//21TlDmKEzrT3b6kOCtoVjTerFCVtko+mYSsiCL6P4UoWxJjzTpUYkt45hMtLcXSek5wNEjap4Rl0qxJmufuD/yWY65y2X0CflhU7CO0IKtV3n1/bJ91v5VaQUQqDBtsxVofbfqW0JYyyBezXxT0XJgSN6/+KmFuL1yQobRnxK3M0xk0n+LXFZK4EYMKVz/Ws4eKpl8VnrrgrXSpLh6uvoKJv/FFWJmyFMlFmyCfGD2PtjXjDFJTkF+DMLHqWsDrMGjIuTqAoz1f/LM2GywjL+AAT5Nj1BUMj1mXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk3fLt4CRns2NRz4YS3TPP8Lq62XbU2lXE7nab6QUsU=;
 b=g0BcVfuzw9QHAVkYXDA+uJZk4sDppUnYt5JIkw8gs1KKBLC3E9zYjoQP8ogXV3KNIA4Sag3ThrDiZAzxkPhph220DIBP3JBLhrhy309Og1wIajVaYyKHfQdnrySWAgWZkqDeqGFb8ww652hC8n1ESyjs7SemU81DyTBKqyplZM2SZ2dFNwxDafocURsxKeERUVP3y4Ii0FMEly0kaJHGN5W5DQQZwhRV9/JBWHQ14NQ7DrdpQHDIm/leMNzRPo0Cm/SMs25GNagCEh8w26C484pHOVeSLPSR+SkGQFbHMXp0DeecrkhJ9wGOSGvo/KKGmrR58CSPGY9vGIwgsUGQkQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV8PR03MB7424.namprd03.prod.outlook.com (2603:10b6:408:192::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 06:59:58 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 06:59:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Meng, Tingting" <tingting.meng@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1 5/5] ddr: altera: iossm: Enhance debug information for
 ECC errors
Thread-Topic: [PATCH v1 5/5] ddr: altera: iossm: Enhance debug information for
 ECC errors
Thread-Index: AQHbsnxZ0RZ0FUTsWE+blt2nUVO3wLOtsONw
Date: Mon, 21 Apr 2025 06:59:58 +0000
Message-ID: <LV8PR03MB81377598799FB92B343743A6A7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250421051455.31365-1-tingting.meng@altera.com>
In-Reply-To: <20250421051455.31365-1-tingting.meng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|LV8PR03MB7424:EE_
x-ms-office365-filtering-correlation-id: 4edbd91a-6d8f-4944-ce07-08dd80a22128
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tXkuog88+UmNYNxVfcKNoXxXj6+J3bbT+UWjuTMBq+k1hXT78dmXPWu1tB9F?=
 =?us-ascii?Q?C7Ubex18SSy7IJhVgmeQL6NaRKEt5fVfJhAwPlh2UPrvucSi66pw1gTAH2hm?=
 =?us-ascii?Q?Zje//0nm8y/XA1lFquw5/KeXDxTYitNMwO56KLkUS1Qs9r89gm6CXtYyEpv4?=
 =?us-ascii?Q?/KYVeW6G48dYUqgHEWezIXcgMJiv+VQBJUJpLvaboIpc25Kt4aP912hJMKA6?=
 =?us-ascii?Q?fB/jHA4tG6oPA3j7Ha9clY4Oc6NW1yMXHW2V/qjJkWQE6hdqUIn2l0bB/+Vl?=
 =?us-ascii?Q?GfUG09IfhgTUsHc7VnmYwjbQoi2D4Q06bwz0zGON6sAN57DIv/Lu3UbBhZ3l?=
 =?us-ascii?Q?d+YQzcarmb7aH+tnz2gUI2CW6Teyx6/agEPtBL76EXCC5iEa2bZ5Wh9Nn5f1?=
 =?us-ascii?Q?4ZkcYISzV8YFYqr7u3lL/3D07YJimbyIR9x/GTm7JgAGShOO7cnW4qobPgop?=
 =?us-ascii?Q?tGEkMweM1o044wGZQZd1yZ+odrs9p93ljcrKLj0dQjV0/ZvVK0SMDy9ipSwy?=
 =?us-ascii?Q?CtpaTRlN2+jRU33Gd/My1x4J5cwTczPtGf73w4gSM6Qs5+fb0JGRlPcgknyy?=
 =?us-ascii?Q?bxKLjBZ8a7g9EZfnzCMKHjIUwXL+JssorQrhFBE1dx/WtlRryxEEJogIC0d9?=
 =?us-ascii?Q?kX37Sr7xgGZkudkkUf9VXs2955ivkuxwxs0wJrSBuFjZugJojBchoSJTI2uK?=
 =?us-ascii?Q?sv8DkYiTCeeJeq8B2NNUUDPIk+CHrG0DPzooRJKikemKCfJk2frHP/FIJgOf?=
 =?us-ascii?Q?XKnPP0oIBia2VAJSxsyQFMEspwsnMZ+Sb1Twt2hbehEy/EV4vXdoYU5ahKTK?=
 =?us-ascii?Q?Yhy1z7ZZ8O30vQdIW94OQfmNaFde6RruGOKL3b8OCXOP7bOa2JGBGdq05IdT?=
 =?us-ascii?Q?aofEfyK6e+MOkMdIZnTVLcUB6WbaYHGOr2EHozldcFRV8/FwTg49cJo+78vs?=
 =?us-ascii?Q?OPE2ocMhP4/AnVpL1FweUgk/upYf694FPqRp2kMbIss1M3R5Nd8NSbzfm1Xl?=
 =?us-ascii?Q?yjXNIimaoO/RHVtmV3fYaOcGyl+fLMUzFpbPA55HK1a1TBndmqkGEk79EDnI?=
 =?us-ascii?Q?cnM8BNSTXzvDrZd/IB6/yxVSUMXTKNBpmDgMkZnZ6G2xcO+NhrYC2cTsuoFb?=
 =?us-ascii?Q?JrPk67b76HZkUq1WbfItVDjBRzUXTWAOmRmkbaVZ0ovHG0Wgk/UWxQPAa0F8?=
 =?us-ascii?Q?njpsW9RToRP3U8YTPTnVR84gkXNZ0UF+X99y53qEXQ3DxC2XIIw/ELMAfMI7?=
 =?us-ascii?Q?mIk5xA5XOcgHPiIN/Y9s2MDcY589tuqvICgzJv8HZ+lxCfc5joZIZeQIZ87k?=
 =?us-ascii?Q?XjK5kIJ52oN1EhQUL2c1QBQvGLIAkY6ispCzqAuVrOS79Ro1hEVXJatpH8Tv?=
 =?us-ascii?Q?hJX441TwJ167fOfR0y5rRdmxRpwY75JpQJGh2DTUNqwclX+5q2fShdwXAxwD?=
 =?us-ascii?Q?UlfjoZ0tNe8+syYekO3XUtUYyeL31ibryUi3ch8bC3WOBqdVMsIq8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85n8Mp0Ky/3IT0A/dYiqTqB/mbmVKrkJrkoEfMJWil5Hg9/4KGeo9NRi8xKI?=
 =?us-ascii?Q?Y4ea6EW19zae6HTITB/PNsljD6wBUI0GiRHNrBUs22HTKO/jPFg29QkLqeni?=
 =?us-ascii?Q?r1zIjgXoajktlz/LBHXUgHG5DIfpVgxcHBusaWUFbDwv7I/rKY3pqL3k8L5f?=
 =?us-ascii?Q?/2oe+aTZlXbvjTMWRpwtzWCqXC6kD/mZbVveymssJWKsbwrz6RiunP5qrYks?=
 =?us-ascii?Q?F9cwVwNRV7mD6Q4DT24bv9LIQDMlz5vJo/9rbOIFweF/Fgm7TNLuJYpp3equ?=
 =?us-ascii?Q?5/ykGJGuaSo/uGwkhZnoSQJhctFbHNWqfPeO4n99VX5DOQcPToLrIUS6EJaz?=
 =?us-ascii?Q?zRH0ROdH3CWUuIpdDOlykoYrVdowahbIAaVm6INLaud3QOJy/FVtnTzOGZOY?=
 =?us-ascii?Q?s8rUVFHrmbC4wHw5OJFdn1QEhJv10xEyQS/hwALD0zmU5GGUbCmp6Bqrn0eE?=
 =?us-ascii?Q?Y3e8WaDhgLjytb3sHX8AHPYzqIYIm7XGv7C9822k3k/TjYZ0IDTo1//iBmyT?=
 =?us-ascii?Q?vXuCX2agO3PQ/Lu/gKeamP6VDH85pOpnLizZZQugNvxGV6mqvhwHuocbXs5A?=
 =?us-ascii?Q?ozGg9wAbMPfb6QmHMQtl0aprpvww+6ukpeHNLfbELauOaulljjwU1MCxVYT/?=
 =?us-ascii?Q?TNf5jYO/eZ36mRsAiEvVnk7mLVBgcdB8mNCV1vWBFyCiVqxVwgIKEUAMd8H7?=
 =?us-ascii?Q?9UT1MVoqBfLoxF1JjCrDC1TzSWuetMbBot3jcc7RThpUUo8V38oD0tAwO4zq?=
 =?us-ascii?Q?ELRdCM4bBYDk8QjArNPJyYg1+ZLt3dG0moSf4DLFsnjjt+bOaOe7rc1SR6qq?=
 =?us-ascii?Q?41QyprW3kWfZcCt08oQE+WEIk5Nzkwg7HoRGSbx2ZhtbpfM4ErTjYNTkaKb+?=
 =?us-ascii?Q?nJekDbusHx3+j1yu6G17fFzDJkDyTcOgq6h6hUsIzPep39giQBaNJVRrMRXc?=
 =?us-ascii?Q?0ausjY9jkuPxsYdQKkm8oKLcHe7ziFka4ZDLBW4C5GsXxmMZCcPrW6gK301N?=
 =?us-ascii?Q?6izo0FP4+eiXhpb0AUDPMrgLoNAwvJ9j6G2dAfzQ93UKnBIb60lQr7sZ3JJM?=
 =?us-ascii?Q?V1LORbH6RyNZ8Zj1SXVcxgQGd1/CnSAnf9Z8AAT55zKn7txRPF06fkiFxaW/?=
 =?us-ascii?Q?9UpnzWPm90JFoSh8tQZHBaAhFZ1lxsRORHzAY7qXSQJQsPY47gPhQh/lZtD4?=
 =?us-ascii?Q?QKsnt/sh16OR4oGTFxUwr0jQt5nY7ZY3BZqyJ/XcPiWuhE98H2se0M0744yA?=
 =?us-ascii?Q?cbWFjECPFMgQ9IbrZgNHBSMRdd8wgc0+5xUOBj30s24qUfKd50xBea2+hwRq?=
 =?us-ascii?Q?n+7yvjBZCtzsiujx3a29JOzwdkVWrCDpN/HcCWEgZeH1KBvSRD7l3eNV1p2b?=
 =?us-ascii?Q?6wHhX1pkND6uMeWEMyVJ29sb4cc2iGxkObVNIyQxaVlk/4EbKkYQ6ToMRWZ+?=
 =?us-ascii?Q?DeQiGzbAPW81TMKovwHCbVvORch0T9xYpamYqOpBxTp65N/e4XjgQYZ+VCjJ?=
 =?us-ascii?Q?ZmXubPMb38hyeBHAECZtN+CLqewRv8sdQ5U40i2sABLVrS7PDWD1kbjey0TH?=
 =?us-ascii?Q?Ge6knAsJLFEZAgBQwUrhLxQ+Ec8PMzvSQqhgtqSz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edbd91a-6d8f-4944-ce07-08dd80a22128
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:59:58.5784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sXn6vsjP7daz0rH25E/TA6SHD2Pf4WdP4qN6RPyPz9om86FdtDNN1n6dVBPZ78tsZpWFc6NBXoehgstUWKJxfpsMAGJVyg9aYRzj1dldmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7424
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
> From: Meng, Tingting <tingting.meng@altera.com>
> Sent: Monday, April 21, 2025 1:15 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v1 5/5] ddr: altera: iossm: Enhance debug information for
> ECC errors
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> ECC debug information was enhanced to improve the readability of error
> messages.
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  drivers/ddr/altera/iossm_mailbox.c | 64 ++++++++++++++++++++++++-----
> -
>  1 file changed, 51 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/ddr/altera/iossm_mailbox.c
> b/drivers/ddr/altera/iossm_mailbox.c
> index 26602858777..fc09dde3f9e 100644
> --- a/drivers/ddr/altera/iossm_mailbox.c
> +++ b/drivers/ddr/altera/iossm_mailbox.c
> @@ -98,6 +98,7 @@
>=20
>  /* offset info of ECC_ERR_STATUS */
>  #define ECC_ERR_COUNTER_MASK		GENMASK(15, 0)
> +#define ECC_ERR_OVERFLOW_MASK		GENMASK(31, 16)
>=20
>  /* offset info of ECC_ERR_DATA */
>  #define ECC_ERR_IP_TYPE_MASK		GENMASK(24, 22)
> @@ -106,6 +107,8 @@
>  #define ECC_ERR_TYPE_MASK		GENMASK(9, 6)
>  #define ECC_ERR_ADDR_UPPER_MASK		GENMASK(5, 0)
>  #define ECC_ERR_ADDR_LOWER_MASK		GENMASK(31, 0)
> +#define ECC_FULL_ADDR_UPPER_MASK	GENMASK(63, 32)
> +#define ECC_FULL_ADDR_LOWER_MASK	GENMASK(31, 0)
>=20
>  #define MAX_ECC_ERR_INFO_COUNT 16
>=20
> @@ -167,6 +170,24 @@ struct ecc_err_info {
>  	u32 addr_lower;
>  };
>=20
> +struct ecc_overflow_error_desc {
> +	int bit;
> +	const char *msg;
> +};
> +
> +static const struct ecc_overflow_error_desc ecc_overflow_errors[] =3D {
> +	{ 0,  " - Single-bit error\n" },
> +	{ 1,  " - Multiple single-bit errors\n" },
> +	{ 2,  " - Double-bit error\n" },
> +	{ 3,  " - Multiple double-bit errors\n" },
> +	{ 8,  " - Single-bit error during ECC scrubbing\n" },
> +	{ 9,  " - Write link ECC single-bit error (LPDDR5 only)\n" },
> +	{ 10, " - Write link ECC double-bit error (LPDDR5 only)\n" },
> +	{ 11, " - Read link ECC single-bit error (LPDDR5 only)\n" },
> +	{ 12, " - Read link ECC double-bit error (LPDDR5 only)\n" },
> +	{ 13, " - RMW read link ECC double-bit error (LPDDR5 only)\n" }, };
> +
>  static int is_ddr_csr_clkgen_locked(u8 io96b_pll)  {
>  	int ret =3D 0;
> @@ -628,16 +649,28 @@ bool ecc_interrupt_status(struct io96b_info
> *io96b_ctrl)  {
>  	int i, j;
>  	u32 ecc_err_status;
> -	u16 ecc_err_counter;
> +	u16 ecc_err_counter, ecc_overflow_status;
>  	bool ecc_error_flag =3D false;
>=20
>  	/* Get ECC double-bit error status */
>  	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
>  		ecc_err_status =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
>  					IOSSM_ECC_ERR_STATUS_OFFSET);
> +
>  		ecc_err_counter =3D FIELD_GET(ECC_ERR_COUNTER_MASK,
> ecc_err_status);
> -		debug("%s: ECC error number detected on IO96B_%d: %d\n",
> -		      __func__, i, ecc_err_counter);
> +		log_err("%s: ECC error number detected on
> IO96B_%d: %d\n",
> +			__func__, i, ecc_err_counter);
> +
> +		ecc_overflow_status =3D
> FIELD_GET(ECC_ERR_OVERFLOW_MASK, ecc_err_status);
> +		if (ecc_overflow_status !=3D 0) {
> +			log_err("ECC Error Overflow Flags:\n");
> +
> +			for (int i =3D 0; i < ARRAY_SIZE(ecc_overflow_errors);
> i++) {
> +				if (ecc_overflow_status &
> BIT(ecc_overflow_errors[i].bit)) {
> +					log_err("%s",
> ecc_overflow_errors[i].msg);
> +				}
> +			}
> +		}
>=20
>  		if (ecc_err_counter !=3D 0) {
>  			phys_addr_t address;
> @@ -661,15 +694,20 @@ bool ecc_interrupt_status(struct io96b_info
> *io96b_ctrl)
>  								ecc_err_data);
>  				err_info.addr_lower =3D readl(address +
> sizeof(u32));
>=20
> -				debug("%s: ECC double-bit error detected on
> IO96B_%d:\n",
> -				      __func__, i);
> -				debug("- error info address :0x%llx\n",
> address);
> -				debug("- error ip type: %d\n",
> err_info.ip_type);
> -				debug("- error instance id: %d\n",
> err_info.instance_id);
> -				debug("- error source id: %d\n",
> err_info.source_id);
> -				debug("- error type: %d\n",
> err_info.err_type);
> -				debug("- error address upper: 0x%x\n",
> err_info.addr_upper);
> -				debug("- error address lower: 0x%x\n",
> err_info.addr_lower);
> +				log_err(" %s: DDR ECC Error Detected on
> IO96B_%d number:%d\n",
> +					__func__, i, j);
> +				log_err(" - error info address :0x%llx\n",
> address);
> +				log_err(" - error ip type: %d\n",
> err_info.ip_type);
> +				log_err(" - error instance id: %d\n",
> err_info.instance_id);
> +				log_err(" - error source id: %d\n",
> err_info.source_id);
> +				log_err(" - error type: %s\n",
> +
> 	is_double_bit_error(err_info.err_type) ?
> +					"Double-bit error" : "Single-bit error");
> +				log_err(" - error address: 0x%016llx\n",
> +
> 	(u64)FIELD_PREP(ECC_FULL_ADDR_UPPER_MASK,
> +							err_info.addr_upper)
> |
> +
> 	FIELD_PREP(ECC_FULL_ADDR_LOWER_MASK,
> +						   err_info.addr_lower));
>=20
>  				if (is_double_bit_error(err_info.err_type)) {
>  					if (!ecc_error_flag)
> @@ -682,7 +720,7 @@ bool ecc_interrupt_status(struct io96b_info
> *io96b_ctrl)
>  	}
>=20
>  	if (ecc_error_flag)
> -		printf("\n%s: ECC double-bit error detected!\n", __func__);
> +		log_err("\n%s: ECC double-bit error detected!\n", __func__);
>=20
>  	return ecc_error_flag;
>  }
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

