Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A8DC87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDBB84238;
	Wed,  6 Aug 2025 07:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uPuFEDft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ADA83950; Wed,  6 Aug 2025 06:33:10 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E22883950
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ6fWvWCrymBFH4iJW0xLyEnUgt7zLAZY7thbXL9CL1XHb3HlME6njxXjOOT72GKteadqgXInPqBvxIUOXZ+yqXnlkk5z+Cdm33LO3cHC79JD3FAg4W1JxXlfD1XL1KU7DbjdANZD/AB/wNH4YskX/+YTDqGaqqN3AjTlmzeI/6b1KdavcovWoMBTDKMxzhaZg8OicWbI2uaCQSKb6D+IBDRwEhxVapeuCFzTWuuU1qRqBvMcH3dcxBTqtz87aGIKpls/OGk4o54OolZFPcMPcR2S0siN6Kv0gCgfakOpm4cPh6LFU5jKYXiMRXzbPEMkhFEsnUPdlmsjVj8RMSj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvzOOp2ds9gOPnCYMrpD5D1N9S6cYSv16MKOopeSfIA=;
 b=TN5hrPAYK1nGlRdbPk1i+kPrQKAgHGuKevI0O6xLLTipLnMq79ItBlWcO7A+0ngKGLzFHTVZmhsOYDkfY8zRkqAtEoCdVhCV3XIfEhmOQNA2gkDrWbDJbWL6afQRC5LpFeXcpf6bppa/LMAKIvcSlln+RaSKZKKTE+TYagcU54Vfj0gMSi3kBo93yqlPWiTykCaV8VuCDpv/zvRgl7vxVRhW4k4E4SK0zEBdsEZCK6LmuQn3b7RdiiJ2JKltISfi3E2OJ16XzpeEf7IPlE0UKJnWtFQ/gLwl0AbqbXyOjQNfJe49h07xvmAqCGHnJ1vX3XdfML0ymMn5GO0VMHA9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvzOOp2ds9gOPnCYMrpD5D1N9S6cYSv16MKOopeSfIA=;
 b=uPuFEDftgvxdnga0Jxat1WUgcfkCGfUBVNfeFkGPUFqGMXMKvLiYOADu7o34L3iEOzDHoxxkaFGQbuYJJd+MobhY7rP0P558mpTnhlLvDkmW/QQ+ew84IQsrYmJSEd/WoCs0t9yg3vH6CjB+ZgsqLFG28W00OPzaBZuaBuRoBmsBGUX44SPPqPMKPLEtb9kuGg8Jnfn9jctaQf8R745xv+T0jb9h7kTb3ltgnKhkHFLpfB8wBAMmxrJCzk1iVdhVuuvFLvBOU3cXf3OXU+o6aHkRgXXN2FLa33+wIAtTwqC+oaWUwwcbmuKH9QeryjlZBI0TEwpGHjACiBiZeY8B9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:01 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:00 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
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
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Date: Wed,  6 Aug 2025 12:32:22 +0800
Message-Id: <20250806043235.2260-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: db6af261-3fe2-4873-f8ff-08ddd4a2535d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fJz6ElyPUWdsULyXqih2FuWFja8h/5daZSE6tgeIcjtiVH4voGwO+6I8vlVZ?=
 =?us-ascii?Q?t0JGqGiXJaRtkAnSFJC7TEO5pK0KL+LGzM4IpgA81Vn/ASX9T8V1HJJMP4sc?=
 =?us-ascii?Q?FDRQ/JkAHp2p9irqEnIvdQpe93eYO8B+ZglEIOyUCGnXijbZWRBK0ZetGYu6?=
 =?us-ascii?Q?K+y+pAH1EmG3TZVImN3wCrT/ZbfQYw6zaUlr06d+6pca3fb2zMeHZvPXsIzn?=
 =?us-ascii?Q?1reem78YzVLtZ3ftiNpu4tJwNA8+KOx5k74KfvCjisesUI41qSDw6ARsh32o?=
 =?us-ascii?Q?bFhl0Ty5DWEE+3coi1tKU/9RA9odw5Cf9Sl7ksqefXqUdJ9Wb9Ptbp0SP8IF?=
 =?us-ascii?Q?1ut6YubB9pknfsupoF9U4TCaC2sLlkaN9NglW2b5W3wEV9gQ91/2YL9Wxfbd?=
 =?us-ascii?Q?34HfuXQfd1W02fVsPDBgeG56OlC62tb8pQj/nxP5JJNz64C9GC5Ki9mz3FZl?=
 =?us-ascii?Q?a5nWh6BEDISLDKYOgp0rld46hrT+pxXukLo7vsjStbQ/YANous6424+DWs5r?=
 =?us-ascii?Q?jr+bj28JGPUGFJLN3wsMqgG7g8dFQCA/8fQ0he7UcdbTkc00ij8M1R5KHeJD?=
 =?us-ascii?Q?5vq5r/YBTbDTF+f721ZzZXONSS59vgXGAgxwgJ/poU+dRC+L3nn0kHCm8Clm?=
 =?us-ascii?Q?rfqjTTB6+mgslRPhrqFvltXT09uxnCLdgEnbfIDF8EKnHAIYJu7CvZP1GUVX?=
 =?us-ascii?Q?/rso8Hh09IuHbe7yPIMDsC4Of13QiYeDAT1KPk57Hw5NIjV/tcsP3DD2HfML?=
 =?us-ascii?Q?PhwMpjl5awpkeG7nj8MWCqPbbz/7T1zct2J7C+2XV0+D0t5oUy//DRiI3g6+?=
 =?us-ascii?Q?nwVbsCN4UeBNgQTxCpat6jBajDh9/4CRbI+KX02VdeAEU/3H/qg4LiO02qIR?=
 =?us-ascii?Q?vHVLvbCK0O5cB5A6nbftoQWJJL99ttuk7a+NjX2+Prq07OzyZQ5bAdSIKBlK?=
 =?us-ascii?Q?7EEVQXKCzMfixu1mcynsjBlpqzT4odp03yB10d7Vq1s8mriVM6n0wWKpL6Kc?=
 =?us-ascii?Q?Im33k7grhNyK1LVKVcj/Cn99rFQbLjTL6tBHxAgK5clAp3WDv1obsXMw80u/?=
 =?us-ascii?Q?t5/REHGNz+h0ryUGKQq9Ybn91mkTBegheCq/GjysLGJxdser8IYKPKepMy8T?=
 =?us-ascii?Q?GvJbmYFT230fGyiYUsYnJ9JOC2K2gaoiEgfv6R5imnt+BLDiKxkA8Di/v01n?=
 =?us-ascii?Q?qDVQ7hg4gBr1vRO0GygpDt2FBSEF+1RsWAdAMBXGvciInkHcTZcbWAk/nKHr?=
 =?us-ascii?Q?OghexyexyizSt/0Ih+ZAwMWeIt/6KCCl+YzKuHbOxTUt5Vz7sZMRSVWtBPA5?=
 =?us-ascii?Q?vu+R0MLXPgOPXq0nrBKSfkcPWm7un0NwgQKimBZF7hZoaYyZI6x4WTGhlD/V?=
 =?us-ascii?Q?a3yL2+PGKzITsSmqMBah7r797IweajFH/CeegP3n943W9F/UwL5E4VdXB7lU?=
 =?us-ascii?Q?5mllFmLcjmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQX7GW5ZfcJ0cYIwKMvg6A+8h7vM+ojLHcaXJ/AnbJ700ovd+ezemqOYWpyW?=
 =?us-ascii?Q?g4tpH+Yxbvwei1FeDSh9rXNBJ65zYduSDuKBM/qKxYrfeTLGExAjrCIwJ3vp?=
 =?us-ascii?Q?a+PIDaI3lXQlLT8kFx4c9HYGzuYZSBfXe+Fd1Ze+BYcPdPjAEmGD2QvA5npm?=
 =?us-ascii?Q?/Ex36dkt0+EcVCnvz4VLHpTm0M1eE93wSJ3S4X+yaMLnwxtJDZSfOujUputG?=
 =?us-ascii?Q?gD71zESWw95RP+6xRnVbLcjmf+ePH1DcsII3QuXJkutkIQRO6xFMNU3xcFZL?=
 =?us-ascii?Q?kdYPEjdInMi0xp0z41Sru1gSzgq8LtIRSHFh38u+GoteHD2GOMeqZiQ5Nf+R?=
 =?us-ascii?Q?WzHtT3QbgcOzmBmxCHcvdd2JaWa6aloxpRH/P5eM9O9C27l6chV+WJDBCPfl?=
 =?us-ascii?Q?hDUZYNsFtKuxrGL/k6iQHlpw3J1a4TXqqLU1LWtktdXZtqtMM3wzYhrgx/u6?=
 =?us-ascii?Q?/qpYmVXkrjgWFAic30HhV/v6p1Ip8J9AbSl8XSJ/1QVD5QqDGuuC29scVCLO?=
 =?us-ascii?Q?CF0vHyOSTW0oi74wK51LLfDTe+QS+I5x9oYUzwY3jyqrm0JYfN52cAqF40l8?=
 =?us-ascii?Q?1qrcSIkjcgN6BJDVlhfO/y4aJ4P1/b660eSWf1sW5p+9obQJ85SHd5wkkWVH?=
 =?us-ascii?Q?j37Ef3JHQjWTgr2UDC1K4aRUmLdYSJc7US9M/1pfi6OpqMACp7iRdnmjMx6P?=
 =?us-ascii?Q?UCSDgNQA7DK2MssBbJ3Gv1JuwNwGySLo3SDesa507cLQ9moDD0VqTfw3qc3X?=
 =?us-ascii?Q?dOsAdo4VvGAf3JH/T0z+i2Z0dk2WgKvIMpCxVoNpPTOjumPRG6sJbVBR/4/Z?=
 =?us-ascii?Q?03bVp7RBPn/MlMlsfSlu9NGbjNpaqBU5dWrjj0Yd3r7pQDkoGybbRzgAR3iX?=
 =?us-ascii?Q?ZvC+E/eIHY/zWq4iNlZbQXBbxmJDgPLCBKRGXSLEbUJpPSawNyec/qYy5fHA?=
 =?us-ascii?Q?W/UmBZdL0rV4q2zmGnMkbp52UBUfK/gNkrf7L/EQdxM0CfeMTM6kxdKty8PM?=
 =?us-ascii?Q?BD3KE5gC+ApWMg6HY4UcX8x9uwkA6sVGgwoX62GCuH10iqXa45oLLRfJjj3F?=
 =?us-ascii?Q?4b5nb+p0uWHN3hCFwPLstQ6RW9fpBeGTAQarjqNxY7zIOBJpXB7Dr0NpW9dB?=
 =?us-ascii?Q?1mhdwsMYo19jIfHGzjtoiDUe0W2v3KMf4EOiVgJFrJ/97VmxDhGmRI+hkoN8?=
 =?us-ascii?Q?J9aYixWdSQJ7WcihryJ5/HUvL7HyBiLfZA2Pi0oqg29Ng9ujumMMi0SbWM3a?=
 =?us-ascii?Q?S+R5qUH4TXjqxSWoLjKFa7PuXJQ0FuB0K68izo2UjxKepxLXSX7p1XcBIsA8?=
 =?us-ascii?Q?JIwxNf5TYFyI9eqvxKTxkCxZmQ73N5a5TKC83mFwqhUZEomwMurmS1Ug+1pZ?=
 =?us-ascii?Q?rrLqyiWAH1kE3AveiGr/417LGe7B+25KEaLim/M7cAcl1+QVBy5HDDxRg/xm?=
 =?us-ascii?Q?GrA//8bqagHezhiU6SGjlaz/AoehPgu7pnWNaBBcvf/eTwCwmz86MrXxoE8p?=
 =?us-ascii?Q?M8UNs/ZrNt60kqyOEPto2TEHUPGNOfF1tZ9t+hzUDFpOLV9mt+Zb458BhJDE?=
 =?us-ascii?Q?sT1dDL0LzmExyqi8B6ENnlZoF1+lUEcjZiN5olVQP8yqbooaTxgwW/FAnE6W?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6af261-3fe2-4873-f8ff-08ddd4a2535d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:00.8684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZoZMGXVXmVBDtda75jBl8FaDdLDAo9Zbg2FexVtULhLXYhDjNOpkFC0U0GKV6hlqps22EMBNeUgiAWXWKtOs/ZjNN9qh2PCqn7gGSEYBks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

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

v7->v6:
--------
- Remove extra variable in struct udevice
- reuse the existing dev_ofnode to get the node in  master.c

v6->v5:
--------
- Resolved documentation warning in include/i3c.h
- Move declarations to the top in cmd/i3c.c functions

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
[v5]: https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-dinesh.maniyam@altera.com/
[v6]: https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-dinesh.maniyam@altera.com/

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
 cmd/i3c.c                          |  271 ++++
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
 drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   56 +
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
 33 files changed, 5816 insertions(+)
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
2.35.3

