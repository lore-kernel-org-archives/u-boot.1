Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF725C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A0880FC2;
	Wed, 19 Feb 2025 14:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jVfn4/MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6584A809A4; Wed, 19 Feb 2025 08:25:30 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148AB800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzC1bzWBc3Oocxme9P3ozc9+1BM22zMvwosrjTRRIGoufrbXspwhoAfKzHBOZ2fQEJghv4mhuifDlWk6cg4erXApBveuXmxhjbG6lTe5rhd7pYtxXfYCHwAxbx6l0APx6L9RI1ZVZCvVxjQYRC6m5z4LpYRo8hRrMCilj0soj/IZWswkSiDwXM5FDkDQpJy1dbyuMM63bKRP8C23zjQ3Gdup0hlLtpla5UI5DhPdsOqPLkD9GUxgc4HpkwSNiDmlrqb7iIFvjqTYBiYO8+mnhMTd6/I68Dg492Xxg8023MwZf+IarzrZP59mQVX2XjYZOBxL2pOxOldIohUtPUvH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdaz8x+pGS2tM5Uu5dtl2SofsVLB1FVYi0vdulpULnk=;
 b=Wmd96ArhvINn60X6FrluItVSmjDAp6Ndp4b013jWFSNS40F9brWeUaHwQdOag5dTDKpYTGsoczvIBbVEW5zVAvxLMXW22iufQ4CM5P/eNScOjCgj6/LDVT/tDQIyblcrZ/F8eMswwol/LrLN3YV4IIqfcgZjpGqwyhCcROysm9SnmBAD+k6Q4kREtC5a3CvZn31DjgLSCl8g3uU2CCYpxCKQ9l5MFQBSUlBBEDLPiKbND/vNJzAKQm+ve/klE6PhHcqBvqFutX1/iP5URwQfU1cF7HldL1BGyX9RFqkIAByRkg6J4y5Tz0whzvDmfzwE1vULuRsMWFyh6CJjyCmxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdaz8x+pGS2tM5Uu5dtl2SofsVLB1FVYi0vdulpULnk=;
 b=jVfn4/MKZY4zjezGDGOq4cnltJLsdbVhSwUY8IGYlrkzM0I1qDfSWXtQ/0yEd/0VA7HlK0/u6h7XuXfvLvQ504Wlbqrzh+8LPJUS04SX61AYZbrgRzF790pN0pqXkoFAE8z7K3BljpCCHqYNJM0rOVRZw/WcTe0+G2sN6nOpAekt+QvHIeXpJnoiI44LfOeOTFyK6x/rGyb6obw/JiaNjJ9rq02BT2MB12obgwT/v5CzxBb6g1nQ7Z4bPm3LgxEnq+v/8lXgzELhWrjma4r4s9WAlDr304QkRiQ0paPlYx+MmBh3ECLecE//zYrmYHi0XLQXZD2snLDCWRajQ8IRAg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:25:26 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:25:26 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 21/26] arm: armv8: Improve SPL data save and restore
 implementation
Thread-Topic: [PATCH v2 21/26] arm: armv8: Improve SPL data save and restore
 implementation
Thread-Index: AQHbgeAsvIg1S8JiEUio5mP5As9zPrNOOxvg
Date: Wed, 19 Feb 2025 07:25:26 +0000
Message-ID: <SN6PR03MB358389DEBFA061B09672D3A5A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-22-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-22-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 89466c88-24e8-44e1-af45-08dd50b69481
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dcUqTgvtwYy2gUgww+tQHGEKQlyAcvf6Y4eY6KUk4b3JEhmLRonfpl8vknlG?=
 =?us-ascii?Q?tSQoOdCKcpkaqF/+fKCKmx11rtc+LGJRuKcoJH8rEHM/NfLar3MRP0KupoR4?=
 =?us-ascii?Q?d/2gduLTHoBr1VIXxC8GzE0N6KE1vqJwODEA5K723FyMtlJr5/XPVO3GfpUj?=
 =?us-ascii?Q?W38OpKU6ydYkDf3al2LRSIxjEsFEqO7lKFBwy1Xlh3hnmkqkSbsmttC+3+bi?=
 =?us-ascii?Q?KVa17yl0B5lcIbx2V+ARJ7kEO6v+KuxOnNThDcbhSEIqsn5T2cgfzB++Rhdc?=
 =?us-ascii?Q?oVQbtaFOCDksq1jhy0KNcJmkFV9+aHFOPY27ZbZpfdt/uFnOyHsgWN4vy69g?=
 =?us-ascii?Q?hcr6omUyIW2VybZHbQWRYi2/fIFEMy7wUs+f1iENM6BvkBmHOm/cEl1xitIH?=
 =?us-ascii?Q?jWWCkmobQ1JP/rynmlMZ0+1kbXsIukpQGSz3fd8eYSojGld3ErKhIgy9F/7p?=
 =?us-ascii?Q?Ac+hJg5RY6UULWVvYnfO39wrQCWyoq+Rlk9NAtmKomCaePq/KYIKPo/tbfKc?=
 =?us-ascii?Q?WuBC8PX5/F9++obxQj792TlSstdXQOyHgcZ3F2r2lfO9LcVZ9GesGOMXNHqR?=
 =?us-ascii?Q?QodT99azhbV26AqXUsd6GdT5x0PcOG1CT9j5saZWoxjmE6V2RrTXFN7Camy5?=
 =?us-ascii?Q?wEknT9lG1RlEfef+q/r+UEOdeRy7BLaGFBfxwG/6s85YeK63gRTTZPYXXi+D?=
 =?us-ascii?Q?E/1hVnaYf1PS02I7H1QKHBOOtEjHNMnjG2+yjzqBX+gg9Tnic2NMH36eWkt+?=
 =?us-ascii?Q?OQg07Pbu+0P0mDLVTCFip9xYAcVGdlWU7UTC6J/69AgEy6qzg1O0N1WsbqOQ?=
 =?us-ascii?Q?cibU4CG4Cyk6tPaRcyUa7kGNnJI7oS0/dm4kAYU35EnOs0y+uCMilG0M4VJ+?=
 =?us-ascii?Q?yIdCv0Vwbh4f+B/Fe93ZUMA64xFK82WvfC7U+QaCNEkf9bYKLd5lL5j0rrYU?=
 =?us-ascii?Q?1ecntamoMJ7oArjx55Q+VVYjyN96DKvG9ZcqlIGdyr/j5xAcMLE0GbxUaAMy?=
 =?us-ascii?Q?Q7eNhwQjdZUG6TfqkLXEKcSIemune802rk/YQuAwJyDceXUeKsIpGnJxtpKl?=
 =?us-ascii?Q?LC9Gn0fwpUlVDvtH4Ft7KqOUlHqoPHmyxuwMoyiK7Hwf006+yhsjX5dBh5bN?=
 =?us-ascii?Q?wrrxaGDtFDoifya9M1RuMXfZZtKfv9oZ/AgiKcr77YnlA76Qt+DJ77AIDfBX?=
 =?us-ascii?Q?qf0ZTHKNMTdequk/cJ2zX38OnVh5ZJnFpxKqc5d3oc/GQwgtGblxHNewk74l?=
 =?us-ascii?Q?3yiiDpTsnnje+QadN+b+zaGeGgigsQ414aXwDaE+q1/ZtOKVhUbfZQ8EVcNk?=
 =?us-ascii?Q?od4oVRUec4UVWnBxu5ngf4yTkVfIA8QVhusaJ6ss/WxjpfcveIVkq8g3wPlg?=
 =?us-ascii?Q?1t4uo2ecUGACeceXj3C04jOmQuL9eX4sQywatW5KYO5mdcjb74qDTJKpFvYf?=
 =?us-ascii?Q?TBqaO7H7xnpz2iOapXnMyAliPMxw+HD1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?19crrFEGTPryls8uNuVCZxeEMqBJ9t5HO+bZTi0W3avrkiSVuVv84LvYnNLa?=
 =?us-ascii?Q?gN9BpxLtS50peQWiNPP0LsZMDAhatfmBhDKO92Z3SSzyXxvImxyoDGy2IsE+?=
 =?us-ascii?Q?v76qEaiNCvqPUd0gMEsgh44FGoZIv+ws+I49dcoDycQC1WWi8dwPnZTcJvMA?=
 =?us-ascii?Q?tuc7Wm+TxiVM7PX/aAV4vf+hj180inWQJWnREfLQ7t337p5kcFrR9MNsrwCU?=
 =?us-ascii?Q?QZROgdtVxcHPJkR2ZZvnxRQN+NhAN1SMLtpa9ShlMunbxAMfmY+PLdBTSoSq?=
 =?us-ascii?Q?mmDdYnJ+r6C7XEmLQL7pgl2a7/UfC/5w6N0cikUW8KlDfQAJzrpCVtSvzyQb?=
 =?us-ascii?Q?kNQSXy45WaYMSAE5n+5iWRK2i3EBA3lKSjQyAqdNfR3KxyqPlBuloCzBffgi?=
 =?us-ascii?Q?cGlPdnJAWytQh6daQk5+3h/QXOi9uKD2cJ1CYI9jRfO9d45D078qNTJOiMmI?=
 =?us-ascii?Q?SfhW8zImpehdnkyPTlgAeih9ZKII2tFfEC9d3SfM+Wdt1SWkqxj4MitvFglq?=
 =?us-ascii?Q?MwuiQ+BJj43gUzF2LRlovZ0HbLtWZzPO1G+xaLz0SwZ60ypq9o7nl6O2j2xk?=
 =?us-ascii?Q?Dgqjm9ec2oBDnIn+0ActOzg9pFtoYI0hZIg10QUyMc8mU1vAbu4biXKH7gEn?=
 =?us-ascii?Q?9kX2P6kJPQZF5FowNZRgmb9ghviI38Qx6PcHlVKYOtPr+y2QpmCeMN10aUWA?=
 =?us-ascii?Q?qn7pnDGyEFvWuv4j0v5sFLX/w9R5M2ydty7bXkuhlb3vpo+mp1lSRtcBzZ2d?=
 =?us-ascii?Q?f5rq1XXslSULBeY6UsiodfoqEMq01vNpgdJxItga4SMUCpNNb6qn9l0TmnVA?=
 =?us-ascii?Q?qBbKPFOrRSFpe3qpp+vXqFL/7MhIFdgTySicH2mu31y9TOgEhxMh8tOn8QY9?=
 =?us-ascii?Q?UDYjEgP87tnSVF3lYQZhpc3B7sD8eI+xkDK3W1ZLfD8snwM4DpCgth3pHeSv?=
 =?us-ascii?Q?rF+8xbNGTzRwzDOdL/1c/PZkhpg1JR+y+VT0S9/FcKeKtxiSG60SQQodFB3P?=
 =?us-ascii?Q?KgjeaCB0wPsTcZDiTqd+OF470wR6NfxCeBjY72R0g5Iz0ij70XFmTTFfFukB?=
 =?us-ascii?Q?3n6Ysv69VcIBaKuNxAxNImX81mYD3MCUqjnUQgY6lxHq2aSFbiTQQsRHhM9l?=
 =?us-ascii?Q?znZcWbE1n0v+5ZfNYi57xQH4NQ2OMOES32Flijp0JSY/6/pOOabxy0zmIzam?=
 =?us-ascii?Q?oACKiLiuz4qPvI68ikXsehSpZ38glggl0kcefTnd/IBotFCYspP8RYge5Zlz?=
 =?us-ascii?Q?VyA2DKrxbEt7PZhiTqkkJoZael1HSLbgmAsKpI5muFSztV7jb2bRf6Y4Kt7a?=
 =?us-ascii?Q?C+2Np32o+nbLSWWcw2MnPQzZZ5R/8FWaf+Me6z48/DUeOMbFxhWfiAug9yk5?=
 =?us-ascii?Q?tHLEPTPm/SJ3fLXbBWeVrYitkP9vqx0SctmHe3+xmFbHSkI45hM/lqkbJcbR?=
 =?us-ascii?Q?vtz8oVBXMMgaDgt92NzitoDzZHz6/uTSTlXKj5AxwY0aH4eMhqG6kLVytZ7D?=
 =?us-ascii?Q?w0kubZ09IA7yyXdVEkU9CcW/oNfI6FL1cTaEI/TKilOlACFfM0zalP5Q7vCF?=
 =?us-ascii?Q?/DcjnWITCHGcLFkw9WlhFnyf7kCHvP8YV92qlDUO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89466c88-24e8-44e1-af45-08dd50b69481
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:25:26.1688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncfMlYpnDwV4MR9diwzhKNxO3ECm0UJ4ZCLh+2w+rv6u8t4ItxCACWrB5P7A/wBqfmlvIapVtSc0yyXYuM3LxydP4vrKAVKqhKQ9H2knzAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 21/26] arm: armv8: Improve SPL data save and restore imp=
lementation

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Introduce a new symbol in the beginning of .data section in the common ARMv=
8 linker script and use that as a reference for data save and restore.

Previously, the code would rely on calculating the start of the .data secti=
on address via data size, however, we observed that the data size does not =
really reflect the SPL mapped addresses.

In our case, the binman_sym section size was not included in the data size,=
 which will result in a wrong address for the .data start section, which pr=
events us from properly saving and restoring SPL data.

This approach skips the calculation for the starting address of the .data s=
ection, and instead just defines the beginning address of the .data section=
 and calling the symbol as needed, in which we think as a simpler and much =
more robust method.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

v1->v2
- Use common ARMv8 start.S script, introduce new symbol to
  preserve Agilex5 warm reset behaviour
---
 arch/arm/cpu/armv8/spl_data.c       | 13 +++++++++----
 arch/arm/cpu/armv8/u-boot-spl.lds   |  1 +
 arch/arm/mach-socfpga/spl_agilex5.c | 21 +++++++++++++++++++++
 configs/socfpga_agilex5_defconfig   |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/spl_data.c b/arch/arm/cpu/armv8/spl_data.c =
index 259b49ff364..492353c93df 100644
--- a/arch/arm/cpu/armv8/spl_data.c
+++ b/arch/arm/cpu/armv8/spl_data.c
@@ -5,23 +5,28 @@
=20
 #include <spl.h>
=20
+char __data_start[0] __section(".__data_start");
 char __data_save_start[0] __section(".__data_save_start");  char __data_sa=
ve_end[0] __section(".__data_save_end");
=20
 u32 cold_reboot_flag =3D 1;
=20
+u32 __weak reset_flag(void)
+{
+	return 1;
+}
+
 void spl_save_restore_data(void)
 {
 	u32 data_size =3D __data_save_end - __data_save_start;
+	cold_reboot_flag =3D reset_flag();
=20
 	if (cold_reboot_flag =3D=3D 1) {
 		/* Save data section to data_save section */
-		memcpy(__data_save_start, __data_save_start - data_size,
-		       data_size);
+		memcpy(__data_save_start, __data_start, data_size);
 	} else {
 		/* Restore the data_save section to data section */
-		memcpy(__data_save_start - data_size, __data_save_start,
-		       data_size);
+		memcpy(__data_start, __data_save_start, data_size);
 	}
=20
 	cold_reboot_flag++;
diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-=
spl.lds
index fed69644b55..c4f83ec9cfc 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -37,6 +37,7 @@ SECTIONS
=20
 	.data : {
 		. =3D ALIGN(8);
+		*(.__data_start)
 		*(.data*)
 	} >.sram
=20
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/sp=
l_agilex5.c
index c87e9ed1641..3451611082d 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -21,11 +21,32 @@
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
+u32 reset_flag(void)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status =3D readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask =3D RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 	struct udevice *dev;
=20
+	/* Enable Async */
+	asm volatile("msr daifclr, #4");
+
+#ifdef CONFIG_SPL_BUILD
+	spl_save_restore_data();
+#endif
+
 	ret =3D spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 10686a0a7b3..61ce065a2bf 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -97,3 +97,4 @@ CONFIG_BLOBLIST=3Dy
 CONFIG_BLOBLIST_SIZE=3D0x1000
 CONFIG_BLOBLIST_ADDR=3D0x7e000
 CONFIG_HANDOFF=3Dy
+CONFIG_SPL_RECOVER_DATA_SECTION=3Dy
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
