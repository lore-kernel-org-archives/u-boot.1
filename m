Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA652D5AE5A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 04:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF3E88BB2;
	Thu,  7 Nov 2024 05:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zbBYh9b2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822C689078; Thu,  7 Nov 2024 05:20:59 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E14F881FD
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 05:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmERQ+Hphmuc6tRo505H+cQ+95RCbPmITaGvQiGrvThU/G5iYHwj0gIkRzBuPZH9sTW+3Upn6bjWzKDHhq8TehiXRw3dhY5JzhMUGxQ4VD6Y6AcyYttM+nZxSXBJrudwbFaEHuMLobw7hv4uc8u2vyw/eYr9ajDSwUoWU9oJiwRIsThfuqUdkY7vAvk1Zrw9mgQ5MGvHxevaqwUB68jtB7FevWMWX3GYkpjjl48+NY6+ES0PEY3LKeApFborjZNojokGjVVvIJwdbwn2sDro7JxcANjrlHAkagWryW585C0/SIkbAMOT5wCPSWZz+5/fce17yyPjQP6l7xlq1j+3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKLRS+uwp8CvwpqCS9bndJ2sj3RsOXMwBfnJsl7YpJw=;
 b=lUQv8/LnWFMqEmXzBw3wvtNurBvvhbCf/g0cbaCYv4Fm21+4IVLYLBX/H22tuG3jF6h736mQsD7PNABnU23fxzSFIRn02gGufjQn54BfdcIIGXWqPKM18a2SLUL55dcGzgHZ+U501hv98FpC4Vd2laaXEMeDuKfiTALlrcJ9gmpPjtEbz2oDg68hOvm6BYvbRnLnMxs5DOkC3w55UbE55q4XEO8r0WQoqpjhfa5Gxi6pfiVrEtn2fJFehQzZuKZBPvczsuSjMZ4TcctfKhTMALpqZwUohZUhhzb0qXK1gBFjxx/gPmUH6Dv0lOknEuswYFkS5cS6TrYKQI7ozxCuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKLRS+uwp8CvwpqCS9bndJ2sj3RsOXMwBfnJsl7YpJw=;
 b=zbBYh9b22XWvVeNVPmX/nQfgY473ciWCZw7lNH1bxxoiS2gkjq2yOVqmggnZ00Yt6xIiShF3AnjSpcDRg1kXWJj6B+csHZXCacaxT3bJgZVgejC2vqyGpKCuRS6PlUEibbo58PJKPIx6YXXL38nnQBC1Pv5CpNTt6aYcxA90+hM=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 04:20:54 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 04:20:54 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@xilinx.com" <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 1/2] xilinx: mbv: Place DTB by default to DDR location
Thread-Topic: [PATCH 1/2] xilinx: mbv: Place DTB by default to DDR location
Thread-Index: AQHbLENtXRzogLm7jUKGrm5N1Tko27KrQEDg
Date: Thu, 7 Nov 2024 04:20:54 +0000
Message-ID: <CH0PR12MB5266572AD088600B7A97CDCAEC5C2@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
In-Reply-To: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|DM4PR12MB6424:EE_
x-ms-office365-filtering-correlation-id: 3160bf27-3627-4958-b890-08dcfee3920f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yWxmuV96rC7T5hcl4xt6kMVhQ9KL4A+veHsls4Gl5F1ols4OnPE/KNDcmosm?=
 =?us-ascii?Q?ciWya4PC1rLdLfatUf6WkkZUVrvZw6BkIsEGougw5jZYjDN9UX/Jfoh1rc0j?=
 =?us-ascii?Q?EJBSeDr9tpJO0k9g6W3g1KAePPvze9MEwS5cVJ11hFMMju2Eakkw8Zb9Nht1?=
 =?us-ascii?Q?jflJqfnqziSumMlXOFa2K1NVuJNrL6UbqlW1l2cj1n8ztnhdxY347V5ZbmN9?=
 =?us-ascii?Q?ZxCJVjMC0NIK5bIOihF6NKK4g7Q6B/MiCUSIRV68fKZUAZhmBe1wI5vF4EfV?=
 =?us-ascii?Q?lej1RHYuFGp72npPZ0JDzpN3uJyw/Ct9mxt0oN9udmFlnNqigsOXTneHJC4e?=
 =?us-ascii?Q?nLYMJhbg0peaTx8VABKMVz8q1/vGbdd8Bk3bNfKTHFNur0SoolMPy5BihnhD?=
 =?us-ascii?Q?LXQQ9YxB9oWxtF/K8EAOMm16lmTcAlYuUN1BSWOmeOfWOCevVAeFCWtZs9GG?=
 =?us-ascii?Q?+h2mnoUDA+Ma5oY6gj0n4m2mt9Xiebg6e1FFPgMMFtkMq7Jc4t4uQK0UQjEW?=
 =?us-ascii?Q?xsMBJwomk1IsCf0Cz/qr0Fi8Wj2tCj/ho7wRYg6zKbOmYzC8u00O4pqRvV51?=
 =?us-ascii?Q?2ZAUDtyOKsxOcWdNwEakLMulO87TPTp4hsPy1vQiJGw5Iyx0WzAS761XLVVn?=
 =?us-ascii?Q?DwPg8Z0CJG1D0W8sa/kjZXV4ygjvGPgZOGnsL1nbYDgDaXQDsl90qwWmQVa4?=
 =?us-ascii?Q?hWPY4l3aTJ7LWmjvbkjfYIvDHr/YyEe1m1q8wmIVFONp++3ZTFDUMVEL+7ke?=
 =?us-ascii?Q?PgadqdQ1DnHNKqEwSDdVnWlj74PAxsHf1jePQAcOAtAyU368tw3Nqc7kpSh6?=
 =?us-ascii?Q?ym/i5iaSGLQfMd+EC8bmHIr0TwQzgZ18km3P5Iq3MPEEuh/xELd7t7U6Pc91?=
 =?us-ascii?Q?tEKJOm54u4de8vnSU/l2u4Zot8zQhYDukxsQwH9y4mDD4JPpq4tDSiShCflB?=
 =?us-ascii?Q?BEkBAZsKeS3anxuaWtdKX+8YpXZElW+JTyDLxgH8KrddXUTgJx9GfUQ5fwzx?=
 =?us-ascii?Q?MPrJDiTE9Jn++lrvZ9DJh3LjHjXeKuiJZyzb4M4fTmYC/Kz9GmKiH9+Jdt3Y?=
 =?us-ascii?Q?EDTkTQBGWpyKKVK7Zh8IVNrPHm7EhGtdKcRioKohCfMy9ebZv7ST9kK5W5aP?=
 =?us-ascii?Q?XoV4+wulTGnHJ+RZ8sYIsZ6IlPXzmiQ+tqRLamDcXK8je71unMQk1IqYTY4x?=
 =?us-ascii?Q?HvNMJDS/abpOxMPxXBkWiTzBRfm8yxmW+tpt8sWHEDvphxMU35QP9iDq204u?=
 =?us-ascii?Q?SuGYTOmbB8GHuS5o01CbEUpjOclOKdvttqBS8RAbEswf96S+DBEc1hv2roiU?=
 =?us-ascii?Q?zPVbyyYwFdGtzxbPl+PZZu1yL2eeCRx8Avm4GBlTA/4z1YOufoEnb7d0GwMP?=
 =?us-ascii?Q?FFUfI1E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0LcypzBx01PyHwOB5oiDeQE65Yj1MFfcZcGFhTEZflK+b8PZbrot4fHVimXI?=
 =?us-ascii?Q?/J//RsKJPSt/LBEBQHfG/GlSxye6DBFr9zjSs88PZDC6sRLcLJpB826q2zU3?=
 =?us-ascii?Q?Mot1lx882NkqcfSBrlHEjUozocyTgKsQunoD7OXBOEZ6b3Q4KGyBSBctTdJ2?=
 =?us-ascii?Q?RFlCVsN199+YOINdNac8YP4Y147j2GMcqEO4DnowQngPs1HwEln76f2WJD/c?=
 =?us-ascii?Q?k5E3kcBz1PNKD+7ZiN6nFAJKgE/eO+IXsecwOadtOPhgLnkQdakDxwHF7q37?=
 =?us-ascii?Q?4+H7CFyGVEjZ8vLk4CbBQqRV+67Qh3cYQPXQSaBV1f6V8BoAi2Yqu22Nob5c?=
 =?us-ascii?Q?7cuw/9mGnqRSmGrIn/b897aRJ7k1Pb5fymCxzlclVZN1XyIullCbQjSRg6CP?=
 =?us-ascii?Q?YBE4CQzYd9995GLzleFfsbT+CUgP13oFM9GKLil1j1AGTWiwVzrQSJAncatr?=
 =?us-ascii?Q?7Jh3V+OlgV6xuIxcaBImEzZLWjypilW1f/Z+PjKUcMcMIfdNZRPsr5kMNOVV?=
 =?us-ascii?Q?iwirz0/cWN+dkbP10ITKAwRpQ0ayrDOkAXZqUijSO93Dozei05fz6M5LhEGo?=
 =?us-ascii?Q?wSBomfRS5HUL52iHIxF5pGE73dmp6yFEQmRLdGUEIBzGS6ZjTKnmSTb8GlJl?=
 =?us-ascii?Q?lgd5Mex2eDgB1qSnlwBJx6IswILNp2xmCxZsAh1PGrcTM4l5L93s+3q7IiOZ?=
 =?us-ascii?Q?3gkoWfXzgYVhOleJCMEv+OsFvguisvaJ7+fWRE3DPkF2fjOVGqgE1YR4CJOq?=
 =?us-ascii?Q?K5hD6a3VdB4KTWFf049tW1K3fdHub/TuZWFcOwai/zfEtbW6quwaTMr0ExKz?=
 =?us-ascii?Q?xlk+/KHC9Sg2Xi9iPnH2VDXxLm57ugsnj++zlbD13c4TAkkqQz5vRjF+Zh8Y?=
 =?us-ascii?Q?C4SlFOeCrIlGUQzjxqh/9PcziCcbPB1TwRYvVFRw4gwJ3HdUcfADgT4SXyh7?=
 =?us-ascii?Q?TzsD1lUN892je46hGtICh536zWKzmD3JhpNpXsy8Yt4ArkCriQh73J1ms27j?=
 =?us-ascii?Q?Uz6dGhiTYewzaTbVFPZ6YEb9+gRNNIoBN6ci9eMsCOorxYm0WVrkozfYc2+Z?=
 =?us-ascii?Q?VMUy+vr/vFl9ZDBzJUhTzf+V4gUJlQJ+c1OxPI+2uZ8Vn1rTfMDUlis/QDYT?=
 =?us-ascii?Q?R6TZwoPS4mCwmVgkEoF3EvLdYVzityZg/2THrwDaorR0c4Q+MrFr6mpljdA6?=
 =?us-ascii?Q?jVC0TAL5ANf3qjzbP4i0yoFJtbzUxtNqjhLDOEeUVzH9rGOnx9ouuEYILvk+?=
 =?us-ascii?Q?ISYmmPoWcLEsnR5FJbNR8i9TZsWfwgeeDYJenSO/V33oK0acjS09D0QnrZ43?=
 =?us-ascii?Q?2yjzInjCXJBzILL2ER5z78o3jstMM79B/bJeLYOfQfbDjhXQsVIM792myG9e?=
 =?us-ascii?Q?C+aLdwzwUtnR2mpxvPZ08YpBXw7idq2yk2LUlRPtwmeqkcMf4bwWS17xE2Pd?=
 =?us-ascii?Q?1NXUUFiSDKPQWuMF/kX8Hx0Y3y1nEpee2MRIzNp2rkjrACxflmNnqU1XgMlA?=
 =?us-ascii?Q?3e9/EoUuGosn51RFXs2AiaKsWStJqtNXvKMEQzhL83LSlZg4+hFhIJ006YRk?=
 =?us-ascii?Q?bZioKrcEKxhY15pd9Sc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3160bf27-3627-4958-b890-08dcfee3920f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 04:20:54.1262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0hLHkY1k12+A5Xn0eAgtOq270WT1AkxO198+QvpYAhAH3M1NDDbTlAnmWIjxxUKa/JnvLdLDUu1c6g1RyekUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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


> From: Simek, Michal <michal.simek@amd.com>
> Sent: Friday, November 1, 2024 3:20 PM
> To: u-boot@lists.denx.de; git@xilinx.com
> Cc: Leo Yu-Chi Liang <ycliang@andestech.com>; Begari, Padmarao
> <Padmarao.Begari@amd.com>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH 1/2] xilinx: mbv: Place DTB by default to DDR location
>=20
> DTB should be also placed to DDR. It should be the part of commit
> 9d688e6da5c9 ("riscv: mbv: Align DT with QEMU").
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Padmarao Begari <padmarao.begari@amd.com>

> ---
>=20
>  board/xilinx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig index
> c7df4ab5781a..0ff8440e6e06 100644
> --- a/board/xilinx/Kconfig
> +++ b/board/xilinx/Kconfig
> @@ -45,7 +45,7 @@ config XILINX_OF_BOARD_DTB_ADDR
>  	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET ||
> ARCH_VERSAL2
>  	default 0x8000 if MICROBLAZE
>  	default 0x100000 if ARCH_ZYNQ || ARCH_ZYNQMP
> -	default 0x23000000 if TARGET_XILINX_MBV
> +	default 0x83000000 if TARGET_XILINX_MBV
>  	depends on OF_BOARD || OF_SEPARATE
>  	help
>  	  Offset in the memory where the board configuration DTB is placed.
> --
> 2.43.0

