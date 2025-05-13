Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF4CC3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6AD8829CD;
	Tue, 13 May 2025 14:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Vl3vqg0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F798091A; Tue, 13 May 2025 12:20:02 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6689B8129F
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3c6f2MntTkh/wCCbERh248cugSD9mar7RNdmNwaAdhKOuZxB0tPmUwzAC+MtFL9H/9iZoS5itH+dNYSuCXJ7CXKuAcCxa1y8DKHwFXlgTVaZIhLGLp0KYk6+2OVXu4zcf7sZjNG7Q+FExYxDZW6IrZLRiNMdVj3MZ656Ip4I6Zh87OGlxhY1GqyiyxvAZxWFHk5bWlqrjpbbgkNEN1BC5buKHE4lwsre5niRLRmoBd5HebUB71ccWshFttwDkh0Q1/F8J7Vsj4tIAlIOhWzDJltQRlJq0qjzKV8GGssLMacui5Y/uMjE4aMSPbu8ia2Ux6PywRJ6axYaKuwBhFKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkPN2wsxTDczREjxlDQQ0BwYbfjmVyK8B8ltn9gwuEg=;
 b=C8ylMQ9cg3+vX6AL1usge/9HjV9Lv0EO1Blpw4k4LQq0R1nORIr8C3Vwcqack1z+ykQUk/+MQuV+DgxPh05fbSqz6j8DNVI9MjGcXDXWxAM4Y+Kqzko3/hgVaZObJn8W573XZFkyQSJEaLYR51qL/WPVkrDXKveggTGxE/KOqmDDy3+9LVpOKp3EsJ2RWjJyT2WY7ZfLUWZwtXVbmmcErVGSjienuJ5TLxuSvVpQ7d8PWOT4T4NxDHgl3knw5e4ASg0/2D+Cn0ELjSGfhtgPjQSgn40SEXwH+KvORM+J4XJ823Tne7jt0bxaHuUSOejPOvzrtghMz/2i2vJRoMtv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkPN2wsxTDczREjxlDQQ0BwYbfjmVyK8B8ltn9gwuEg=;
 b=Vl3vqg0hrWTEt9Bqhpwm+qzqi6rr4VC3o+Z5S/lk+nnb2D6iL7tv6uZLUPBANwsJEvebXFGjxvm7xTePu8nZc1neawQwNsvVnswUZQmsy19FY275ufEn/JKx9x99ind0wTnyOZYZjLm7QFEGXN2Rya+9KESOWVv+53/IWsW8xfjS1pYt1uQQIMVKatB0DOlwBgvnxHJ9rnScTxlcNEfIUPWsZr6ybqVOZzzFcw9dWN+c8wAfyB9gofclTs6cbBG03Va48z+JVP08skWjlP4e6iCBF4SODkpwNvK31kDUBa9RaNThorS13i81VMNegJana2m/4IjEQOwxNkF6qSCNpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:19:55 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:19:55 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 00/12] Add Synopsys MIPI I3C Driver support
Date: Tue, 13 May 2025 18:19:01 +0800
Message-Id: <20250513101913.30880-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2728e822-0865-4042-8970-08dd9207b4a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6j2v0FIR3DqGQqaiqYKgWzbmg8vEeq0yWAvgkyzyf8W8mysB0rbY8TrteNw7?=
 =?us-ascii?Q?7+WpcMrh8HraGXdpYg9lkuPFRhPPpCzz9dikHW95Ts1W2I89ktRxQi0EgDHY?=
 =?us-ascii?Q?ugXgGStLenYAvNJJMGS6ydhmwlWcLyoJbNJI+MNcTyG0sT1YIhTmBy/g13T/?=
 =?us-ascii?Q?gs+qwZ1zFCsyJZ1rWJ6twn6HaTHVEwRVj0J2mixGwbutic2OlyNyVbwUQfOh?=
 =?us-ascii?Q?tskxs5+86FQQsoSTHgkX0tCvUbUOQeyqDD6s4mCZc/2z0IG5BWLnaDLK8pub?=
 =?us-ascii?Q?VjPFXrDylHx2Q5kSeMq6FZKP26vC89VNyUtXDjPiuHNB5HeB08ddOJYX7kwI?=
 =?us-ascii?Q?ORU7ZGtUnARmksjXmmfaCpr5lag6Xw+bSJUki3hZ9Ar7Ff8GVwVbr7BK0ssN?=
 =?us-ascii?Q?4v/u9GS3faHMFTvk45YOoLQwk1bd86MA+I7Rm6pAnsp8Nwi0P096kXDLv0Ap?=
 =?us-ascii?Q?tkkGd5mAh7Czhu9SYOAtFX+vXSUZ2/ot4aSa6ZanoY7HOAB13iA1rQ3whiHX?=
 =?us-ascii?Q?/grsR3raoLnylVtLtcmxfp6JXGvABegbJf2m7c+ZbY+32O/dmqNGjmpVDZp7?=
 =?us-ascii?Q?4H+dIeViDXurtB076aRXGOXWgQfPdiYD2caQR3Xz+wP+KqEsnsvVikbLOfIP?=
 =?us-ascii?Q?OJ9LdPfMeaaajhpXOT0CNRj0ZoP6zLdIoPsQqQZE7pRUHsstbTfTewpw9crO?=
 =?us-ascii?Q?V8rQCUkqIYX30Y8pyvnYr5VY0gVcmNLseikSjaG3s6qJj3GqCmycj88DsAO2?=
 =?us-ascii?Q?kx55uTlXiE3kR2Jtv610Ex9/UEekEGLHFAnC7Tv1gzSxyq8wDdx4ttU2qI8m?=
 =?us-ascii?Q?iQELrGdGMaTKFOj3y9QHGADibE7OC7nvksHomDp8jhQfgZV+0ME4LAAPNhHF?=
 =?us-ascii?Q?NxIsNNBgri18pGLHNQRmUBrS9ZP+2L/OPY1NWafxwGHLANbnbDuyGMpiI0SD?=
 =?us-ascii?Q?ol1iOTSwi5aQiL12iUn9giBx7yNqbPZTQyLHGAQ6lfARklzffzmYjNnycwLs?=
 =?us-ascii?Q?eu4Fkn8Y06PXSSlZFVyY59dZz9Gavv8MrcdSx4yo3SFdHc2e00aP5zMKlQ1H?=
 =?us-ascii?Q?e6Ykv6m7dK1luYmhuAw5GCQlEhe25A5Hew9gGNPhO4t3j/YFEIAGOKbJHYZP?=
 =?us-ascii?Q?PGpT8AvLmGniydWPPa5OaALU+Z5UYU1WTvj33/ziulOWL3yPPqcYxwTMHvc4?=
 =?us-ascii?Q?NpX0OHLnlZMHtOdG52XwpeDuTBKzgtZzA8YB120ls+bnA4nq1LncMbEP3bot?=
 =?us-ascii?Q?TTzjYbbQrB1EHZkIZ2HMpXhieOVdSs0AlyVCKliVBnL4q4M1b26kIpUvzSM+?=
 =?us-ascii?Q?lYl+y0wnDKjQspMXpBN9MVV6tHgbXbBWBIjaHpTyryliWL+IrFoMLJhX5Dx1?=
 =?us-ascii?Q?NWr/lRmqzux1IVNTRDD/m9rtbAaD5TkF8fo1VAiRr5/B3j+1w1A5LdVvnJqm?=
 =?us-ascii?Q?Rsi1/5B0ENc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgOcxzgrXve8ccangB72oiRg9ClFPukqMCT7YcL+j85d4A2HnKKzYPdKH4eQ?=
 =?us-ascii?Q?YH5SV61oy+j+FibDzxLK9qtjaJBLmHeonqqpVcQXOdR870KKQ3MriVwIFFQA?=
 =?us-ascii?Q?yQjiuZY5EgbIpVUulLo9tQJnWgy7M2S/Ik3xXZIeVGKB4syiV7zsTPmTxyeN?=
 =?us-ascii?Q?hxrR0wgdam+Y9UDW2fR0ndoS4MIbA6HKXwa2DP2GaaKWByvpsTudk9stAZDu?=
 =?us-ascii?Q?1FWI7moTZCLAkydUFoQUEkpEuWaLXhXxxFMeWrC+ug8L1eLK4fEVPYbGRatL?=
 =?us-ascii?Q?EEWue/fZ9LjM2IRCwJT5TyNtJEwuzra/J50ehL9J8IHJMUPkNC2PUZ50c8yF?=
 =?us-ascii?Q?loLs4znR/wUD3AfAQ4nAcGT/sacNuN2EFx2ORXPcOlxw2cRFnzuJfZDRY/yQ?=
 =?us-ascii?Q?NKpnQo45xi28OKyOygf9dqTX86ALRZvzUrux+wUGKVUYyeeavq1PK4PBCe8/?=
 =?us-ascii?Q?FFoWgEi5hgq70kMTUMGmtjZusBvSAw6awT1LSCvKQfO0uLMyv10Hx85cXJLj?=
 =?us-ascii?Q?Gvz1UWK68QENT2c0mCaTuwdcsfvoK1c8ivVIF0pmTWVonRKi8epEOBPZjrkG?=
 =?us-ascii?Q?eAqxxRER/ZBryzsfFlEXt1Nj9sXM7YfksNdlZt5O23R+GZYs7Gf1FYq4luXb?=
 =?us-ascii?Q?XJfOC2iadAaDKLxvvDow90hXKKB8HsIXiBb7hPpvuQIHdoh5cLz9aqKe8ixN?=
 =?us-ascii?Q?jeqJU4cie6IWYeulC9/Rmq2bq84MRQL7YP17T6BQBFAAHCrCNShVjEF8npjY?=
 =?us-ascii?Q?sXwy8hbvkyb479u7dr6MZ7teO25MPWQ5sHAFAHx2rnnJTdfxCo965lQOxmrr?=
 =?us-ascii?Q?DPmGGDNBNAW5iOXA4ZBHSSRzAx85MrvCClBLlZMah9dSFGfOyEiu9cfKv0f5?=
 =?us-ascii?Q?t8m5w6CxMJj7HyyNg0v03s0Z429pIhmITjaEhVG0StnHPPPMifyfqvSWWUQm?=
 =?us-ascii?Q?zEtaNVyKKB/N8D9yoiAYS1AIWxpRFuDrQK3GHdZiUNLsqbfF0Y1JJCs0RAg/?=
 =?us-ascii?Q?DyvA4GsqY0Pv96W4rzijybxqtFjCmh5MBGJeqkr9Cx5dy59Q4keCzLFf/nVj?=
 =?us-ascii?Q?HDlKuH/dVluj/20jy54XKfu9J8PtYmkZpI0U5gtoOiRDeIy+dLypetZmCpMu?=
 =?us-ascii?Q?Xq4unKUrUMxL4ZUWKeGdmJ4xX7H4d5mSYasYeHo0J812tbVLRD4jkb/7trr7?=
 =?us-ascii?Q?fktoNsIHB0W8uA8z7WxOb3F/v3gb6HIU4eFlkRg2xRDHEIYw3xAcllU0gN5L?=
 =?us-ascii?Q?HJ+1P5CM0F51cSotyV7xp1wfJBZfjUJsafSBeY3Ci9aFaUN+l3jXGnxEUno+?=
 =?us-ascii?Q?/KnbJnOf9DRDvJEHipD3A0WgpIGUcpRFl7F+9P1ADyYa64+ONTZxzMWy4sHk?=
 =?us-ascii?Q?gbFMIw7brUd9qwKuGvjUa19AWV+fNorpeHuFFd7V3V0ARYLgzf55kUgDCtU3?=
 =?us-ascii?Q?RS5Bv/YjyP6k6KynGLeDPqnRYmsSzLCiZfWsoDH2gyrq8UBQpk7wU1p1zp+b?=
 =?us-ascii?Q?sVRLn7dsUwucS1lSEytRKPlBtER1YE2FF5lw0782dVj2cEyQr0CTxxumZxr8?=
 =?us-ascii?Q?y5zJABqyYZo2RG7pBOhuQN0yGGw5C2fICAnCxDYtG01Hdq2EA76Bhx1VGPx2?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2728e822-0865-4042-8970-08dd9207b4a6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:19:55.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfM3J/CY05oYauMOv+i8L/JEW7MMT/SZT0eFlil8mg1osgWYAoHXHBX8fyRRtG7dwWIvX/qOULKJWkYFsbCJskU6H3rtlvN7/0d1IcbTpuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This patchset add Synopsys MIPI I3C Driver support for
Intel Agilex5 devices.

The i3c driver is leveraged from the master/dw-i3c-master.c,
i3c/device.c and i3c/master.c Linux version 6.6.37 LTS
And few header files included to be
part of the migration; i3c/internals.h, include/linux/i3c/ccc.h,
include/linux/i3c/device.h and include/linux/i3c/master.h.
Additional i3c uclass driver and command files added to support
i3c read and write in U-Boot.

Patch status:

Detail changelog can find in commit message.

v5->v4:
--------
- Add header file to doc/api/i3c
- Rephrase function description for i3c.h 
- Separated subcommand as a function for cmd/i3c.c
- Used memory address to transfer msgs from i3c
- Rephrase description in cmd/i3c.rst file
- Replaced int with unsigned for positive variables.

v4->v3:
--------
Resolve ci test:
- Add i3c node in index.rst
- Formating error in i3c.rst
- Resolve cpu_relax undefined for sandbox

v3->v2:
--------
- Squash commit 10 to commit 9
- Resolve index for new files to pass the checkpatch

Commit: sandbox_defconfig: Enable configs for sandbox i3c
Commit: agilex5_defconfig: Enable i3c configs for agilex5
- use savedefconfig

drivers: Enabled Kconfig and Makefile for i3c support
- Add maintainer for i3c

drivers: i3c: Enabled Kconfig and Makefile for DWI3C
- Add empty lines for if/endif

drivers: i3c: Add i3c sandbox simple test.
- Removed DECLARE_GLOBAL_DATA_PTR

v1->v2:
--------
Reorder commits.

Added commits:
- drivers: i3c: Add i3c sandbox simple test.
- test: cmd: Add simple test for i3c
- configs: sandbox_defconfig: Enable configs for sandbox i3c
- configs: agilex5_defconfig: Enable i3c configs for agilex5

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-dinesh.maniyam@intel.com/
[v2]: https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-dinesh.maniyam@altera.com/
[v3]: https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-dinesh.maniyam@altera.com/
[v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.6212-1-dinesh.maniyam@altera.com/

Dinesh Maniyam (12):
  drivers: i3c: Add new i3c uclass id
  drivers: i3c: Add driver for MIPI DWI3C
  drivers: i3c: Add i3c uclass driver.
  drivers: Enabled Kconfig and Makefile for i3c support
  drivers: i3c: Enabled Kconfig and Makefile for DWI3C
  drivers: i3c: Add i3c sandbox simple test.
  drivers: i3c: master: Enable probe i3c without slave device
  i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
  cmd: Add i3c command support.
  test: cmd: Add simple test for i3c
  configs: sandbox_defconfig: Enable configs for sandbox i3c
  configs: agilex5_defconfig: Enable i3c configs for agilex5

 MAINTAINERS                        |    7 +
 arch/sandbox/dts/test.dts          |    8 +
 cmd/Kconfig                        |    6 +
 cmd/Makefile                       |    1 +
 cmd/i3c.c                          |  261 ++++
 configs/sandbox_defconfig          |    4 +
 configs/socfpga_agilex5_defconfig  |    3 +
 doc/api/i3c.rst                    |    8 +
 doc/api/index.rst                  |    1 +
 doc/usage/cmd/i3c.rst              |  146 ++
 doc/usage/index.rst                |    1 +
 drivers/Kconfig                    |    2 +
 drivers/Makefile                   |    1 +
 drivers/i3c/Kconfig                |   27 +
 drivers/i3c/Makefile               |    5 +
 drivers/i3c/device.c               |  262 ++++
 drivers/i3c/i3c-uclass.c           |   38 +
 drivers/i3c/internals.h            |   26 +
 drivers/i3c/master.c               | 2070 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   56 +
 include/dm/device.h                |    2 +
 include/dm/uclass-id.h             |    1 +
 include/dw-i3c.h                   |  252 ++++
 include/i3c.h                      |   93 ++
 include/linux/i3c/ccc.h            |  385 ++++++
 include/linux/i3c/device.h         |  286 ++++
 include/linux/i3c/master.h         |  698 ++++++++++
 test/cmd/Makefile                  |    1 +
 test/cmd/i3c.c                     |   50 +
 test/dm/Makefile                   |    1 +
 test/dm/i3c.c                      |   34 +
 34 files changed, 5812 insertions(+)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/api/i3c.rst
 create mode 100644 doc/usage/cmd/i3c.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
 create mode 100644 test/cmd/i3c.c
 create mode 100644 test/dm/i3c.c

-- 
2.26.2

