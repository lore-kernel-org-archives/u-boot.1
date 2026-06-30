Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12230C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0E284AB3;
	Tue, 30 Jun 2026 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="H1fDyNd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0057184A48; Tue, 30 Jun 2026 08:56:05 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A136084979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeyX/JdjgiEfi65eXLpzKi1thIQcW4wZ1MCU83/SA2WarZJzXOWt/hGzF6jENdtiDRR+Vfkt8X4TED8GJfLe3uicBaaPqNbDmuTl1Xs+mGFD2zeAdBE95JC6SeF1ibQMQqf4XL+RzE0FqEJK7i8bxOxzymMuPJ/1ukwuO8e2iAhLblJUDs4zsLYunLcFSIAYtWbD8iS1yvIJNR1GHyIyIzQwnfF4LEmRvgmqQ4rnB+eZkw74HuwOTjmH1qAkd4kDdwSj3xNb0Y5zYF8qhhjB8ZcY5V2O6MN4pzfDqsQ3i+oju5GQuvCuSzBbmQaR5PUtnfQf2f64mtCZICcCr+4LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7urQSMJGMpKpJbP7s3p6XUrImUO6jwPy/3fmKMrI5A0=;
 b=fHI+x3eFVzcrkyezT3SsqgzHYqsjcKVqeCsYiuph09df4kZ/qytJiFh+TSBUumCzi6kIvVkEJ2ZiRYkY7FDWHhFB1dGzCs0sxVoIYXPrOu0m17SfPNt+g0iG7uHGcMmxLO7EUeOI/yAMqZRoC3VP/xgbdXQDXiaUwtsilZRBYeSbv6qHYDoHvHt5IhsNTnUI9UYaFKI/4jJe2O1IisYK4nS2pqLNUFG3KLJsYijiCdRQsjqKq19fJDj7KaCeIuQN/4FUYPfFtUCUbPW0wDTSx0b4dY0/XfSRr9OPbgd0oMY+aArIezJXDeV4s8BAgHk1Hm+kquW2lotCDkRtrht82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7urQSMJGMpKpJbP7s3p6XUrImUO6jwPy/3fmKMrI5A0=;
 b=H1fDyNd0NoxgBjn0Fqb2KjFnbY+s7sJUZCCvvLNYjY42l1BOklIUNq5iVc72TiMwX+Z7nTxRh8rUd2XHl6ttTRjOM54ObyiFyF6IXJ9zgDf7gLFF8BuRqM/rcaTCjlvGtjMCIps0KdgCIlV9DDdrWT/7HND057lXKXxDpr80oUYyDalQ0Zddzzz9XEBl3Kw6eLS3mjtvx7fb03YKNQ6SHtRawzRmd+1MZ9JUUqu705e+htMRugA6AdVONubEG66jcmZlvbIb/006Hg5JuBySlVUuXunIWFzCvTaGZ1PVKJML/E/RzspBR231X1A6kNIdv+WLMvj9sk9/BWuGa1+5iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:55:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:55:58 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 1/8] arm: socfpga: mailbox: Add RSU mailbox command support
Date: Tue, 30 Jun 2026 14:55:17 +0800
Message-Id: <20260630065524.27680-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfd03af-b1a8-4cf8-eb66-08ded674a310
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|13003099007|18002099003|11063799006|3023799007|6133799003|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: 1PmbpYDAmJ50/+Qgpx5LxxhZeHMhge6OpE7rUApoRYfuiFL5Na+G64ZXYqumoD9x9vb1ThYhOGoBTuyEDpqknYoC6uF4RxngdU/RgmqSTOEFdrOtHdKFgHQUvCrz0bISXG6NQuFCdyco54o/z4jvXHMF55LHmJpRNZH4zK/Bu1KXIctG4nAKZzixHisw6AxJ1zWHshmPjGAI4m2S0dncsKHlBxv6YxY0B+AvtXSUKptqFhUJYAbJbisMQnWzA+6dfIJPWn0rYxYjkrkT8/5+xekeXZZ3f3U4WWu5iqBKxqvF+a1E6hu3Q//I+WGzUsKU1QfX62dAeuuM0yxdPmQNUngPybbWpXAzmtmwrpOXWyIqed5hBAcLGnAyICFdciNJ2uggvWyllW7Z9Om9yL9FJhagQGjTux9OtULQNEXqHlupXb4TufwLrhHD0t1vfr1yeGQGBmHVAvS+IlmGSoIJbNwOixkqv65knnc/wpVIFC/I00DQ3RMeOSIm67kFChBaDXN/t2uZtwCYRCE/qtg6KFNwflCrYap1uDQTPBkTY94GIKGo+A66E9g7tnqXzCUgRrv/Z1CsgQkj/XhIEVbN55AaKEWLLKODzK0Uym7pmrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(13003099007)(18002099003)(11063799006)(3023799007)(6133799003)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecPolYhgePTmboLs9X727e7pb2tspYWdfk5sZtryVFnA/fFxxNEAyll2EJVt?=
 =?us-ascii?Q?+X5NoBPyH3DtqEPhd7RqM0B/FBEVedaBNRkV8WThBpS8wRVdu1BjyA8pJIac?=
 =?us-ascii?Q?1EeDDoG+vW4g8c9pOfQmmPL8DcQ9CarT39Az9bVHN6Le+P+E9SvkCdqdnkf8?=
 =?us-ascii?Q?4Zsj3Pi1fQD1r4g76zRz3/NTxBBrdYBPjzMO1ZurJ2alVOizVFVOZpy26+8D?=
 =?us-ascii?Q?PH3r4oSTToGqH4bc6qj1t56eBsZXCuJHQPPZvz3K+lLfl7D469DYXqZDMmxs?=
 =?us-ascii?Q?6MEZeWAhq3hp7O8Q6aG1NoCO5rZTR7QKwur8tQnlM2LgphzZnF0F3ZMQ3fA5?=
 =?us-ascii?Q?+80RA/UCXDv9dRxP9UBdXWLyrMByyNTnw0frcCicE5jxnmMJXV5sVpI1JOkJ?=
 =?us-ascii?Q?8s+zRHMNL93ptZfPFiSu+L6hlYHoUl/d8W0Ea5fVuoV5i30957MZjuGwrWeg?=
 =?us-ascii?Q?mWzN78i3bF39vL27qKuV9Yjj2pshfrSm3T4gkZurR+/TbGkzSXzHIYKPdbW9?=
 =?us-ascii?Q?9bnmOZwG4zeA5ler2S2RJolyhxm86Lh3QPdlXFSL3nTn0ZovfcDL8aKFfjCc?=
 =?us-ascii?Q?q3KsO93XJdSmr+jba66jTmUHLVG5lyKYA/rm10TstJS6gmy9k/gqXY18Fihf?=
 =?us-ascii?Q?BRv4/xKvAaFqMHzwRd8W5WeWCvmNPAAzAhlq4fF8Se/EpbdbwitF06C3smPf?=
 =?us-ascii?Q?uymmYVTT/zT4NQ1SqGi5QZkQwMC+HlAQBjxrum+PiMiBHzou4TBxou4HkgAv?=
 =?us-ascii?Q?2FrvCusgKhKCVjcYLiyUU28YxJsykYYucxAv6R+e6gjrHb+qvBXXJt6GOySO?=
 =?us-ascii?Q?oOymuWNA4fBqaFASNv4IdGFCcdKAAKaMgbV/Nv29uBQxI/zKkYaKkDbXMXsH?=
 =?us-ascii?Q?mM3nWQ5hcGUf37IMpsekZoa/Bwu1m9CknfioKHK23PiSdMSFvC9AbvSKv8Tl?=
 =?us-ascii?Q?VuYmv9YtVGd19o2YCeGPjMyjc4MBvmIlZgPqlHni0y0xweaCXqApCr/w1W04?=
 =?us-ascii?Q?GcYzIw7EhhTefZeHlpa9sZkwodVQpOuKYM78IFOva51gEQdV/7fMxgq20g1c?=
 =?us-ascii?Q?AbbYL5QGXuVdEip0IDYmBawiVUQfMhkWSOaBIZPxbLQ7mX2q0ADfuIOXufFf?=
 =?us-ascii?Q?ORkQmCmZ3JHCqgGtsxlHWiofYWnTcMtz1q2XUt9kAu03nXbKCHK+fOb56+Ww?=
 =?us-ascii?Q?3qiHTmCq6O6KbkQiAmXhRZ3F4q1TK6zqr3NQdRUNd/QTKZGc1m28QrVUZqyf?=
 =?us-ascii?Q?/ME9UR4SgckJb03xgFI4XfgTrxYN9igIwtB071P7Fa4/CsMrjOyeJIeCDRUb?=
 =?us-ascii?Q?Ok/RQ8/EuLLX6AWiIQfuqL8GDNyCgqAeLBvGCEQVuREI2wAPCcW0HfL8XVOI?=
 =?us-ascii?Q?FQqu5qz0g/zMORJ8sp60QH4UjdlFyUJhKnYTxThEsHGmJoD/U+IUAuQzs9po?=
 =?us-ascii?Q?tMJkJCzPUaa5Zu6RaOrfB3gj7vhQ/LgcC20rQwls9p6tYRbkVZeOAYLkcpiB?=
 =?us-ascii?Q?oQg3M/yusFkwz9otubKv4P6/GlBGK/SRnuF+T2X5m8VCL1+ES2V6P68K+hv5?=
 =?us-ascii?Q?Y/t9kSxTNPIcgVnOpmpywyVr+jygGScNx6J4gKisVmVIE6MwIItDjMmTuoxK?=
 =?us-ascii?Q?2AzLC8zehocTpk7PDSWOsjhD3XZQgmXOF5a6GYFNEct42+ItVxyq9ESZ/395?=
 =?us-ascii?Q?h+FKhQtN8U8rKx9NC1/RLS6N5Xnd0PQcMjwJsaO8r5got787gLe/dEKRfqqj?=
 =?us-ascii?Q?LCFJIP9WEg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfd03af-b1a8-4cf8-eb66-08ded674a310
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:55:57.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP+ALRnUwulqxSaYxvlw2SaZgFYMM1epT0bELH0RJ7XBy3zoesOq28IKD/fRFJZwHBY8HKccURsQBLSjFZ02jVds/4ohIj/LNErpkt/QoSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

Add the Secure Device Manager (SDM) mailbox commands used by the Remote
System Update (RSU) feature on the Stratix 10 / Agilex family of SoCs:
GET_SUBPARTITION_TABLE, RSU_STATUS, RSU_UPDATE and QSPI_GET_DEVICE_INFO,
together with their PSCI secure-world (_psci) variants. When CADENCE_QSPI
is disabled the helpers return MBOX_FUNC_NOT_SUPPORTED.

Also add the RSU public headers (rsu.h, rsu_ll.h, rsu_misc.h,
rsu_flash_if.h, rsu_s10.h, rsu_smc.h, smc_s10.h, socfpga_rsu_dm.h and
rsu_console.h) describing the RSU session interface, the on-flash
sub-partition table (SPT) / configuration pointer block (CPB) layout and
the rsu_status_info structure the mailbox status command fills in.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 .../mach-socfpga/include/mach/mailbox_s10.h   |  13 +
 arch/arm/mach-socfpga/include/mach/rsu.h      | 419 ++++++++++++++++++
 .../mach-socfpga/include/mach/rsu_flash_if.h  |  96 ++++
 arch/arm/mach-socfpga/include/mach/rsu_ll.h   |  94 ++++
 arch/arm/mach-socfpga/include/mach/rsu_misc.h |  65 +++
 arch/arm/mach-socfpga/include/mach/rsu_s10.h  |  46 ++
 arch/arm/mach-socfpga/include/mach/rsu_smc.h  |  14 +
 arch/arm/mach-socfpga/include/mach/smc_s10.h  |  37 ++
 .../include/mach/socfpga_rsu_dm.h             |  18 +
 arch/arm/mach-socfpga/mailbox_s10.c           | 141 ++++++
 include/rsu_console.h                         |  14 +
 11 files changed, 957 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_flash_if.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_ll.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_misc.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_s10.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_smc.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/smc_s10.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/socfpga_rsu_dm.h
 create mode 100644 include/rsu_console.h

diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index 1a461de4819..5cb6ae4bcaf 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -92,6 +92,8 @@ enum ALT_SDM_MBOX_RESP_CODE {
 	MBOX_RESP_TIMEOUT = 0xB,
 	/* HW (i.e. QSPI) is not ready (initialized or configured) */
 	MBOX_RESP_HW_NOT_RDY = 0xC,
+	/* Mailbox function not supported in this build (e.g. no QSPI) */
+	MBOX_FUNC_NOT_SUPPORTED = 0xF,
 	/* Invalid license for IID registration */
 	MBOX_RESP_PUF_ACCCES_FAILED = 0x80,
 	MBOX_PUF_ENROLL_DISABLE = 0x81,
@@ -128,7 +130,11 @@ enum ALT_SDM_MBOX_RESP_CODE {
 #define MBOX_QSPI_CLOSE		51
 #define MBOX_QSPI_DIRECT	59
 #define MBOX_REBOOT_HPS		71
+#define MBOX_GET_SUBPARTITION_TABLE	90
+#define MBOX_RSU_STATUS			91
+#define MBOX_RSU_UPDATE			92
 #define MBOX_HPS_STAGE_NOTIFY		93
+#define MBOX_QSPI_GET_DEVICE_INFO	116 /* get QSPI size and erasesize */
 
 /* Mailbox registers */
 #define MBOX_CIN			0	/* command valid offset */
@@ -405,4 +411,11 @@ int mbox_reset_cold(void);
 int mbox_hps_stage_notify(u32 execution_stage);
 int mbox_get_fpga_config_status(u32 cmd);
 int mbox_get_fpga_config_status_psci(u32 cmd);
+
+int mbox_qspi_get_device_info(u32 *resp_buf, u32 resp_buf_len);
+int mbox_rsu_get_spt_offset(u32 *resp_buf, u32 resp_buf_len);
+int mbox_rsu_status(u32 *resp_buf, u32 resp_buf_len);
+int mbox_rsu_status_psci(u32 *resp_buf, u32 resp_buf_len);
+int mbox_rsu_update(u32 *flash_offset);
+int mbox_rsu_update_psci(u32 *flash_offset);
 #endif /* _MAILBOX_S10_H_ */
diff --git a/arch/arm/mach-socfpga/include/mach/rsu.h b/arch/arm/mach-socfpga/include/mach/rsu.h
new file mode 100644
index 00000000000..de4e47488bc
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu.h
@@ -0,0 +1,419 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Intel Corporation
+ */
+
+#ifndef __RSU_H__
+#define __RSU_H__
+
+#include <asm/types.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+
+/* RSU Error Codes */
+#define EINTF		1
+#define ECFG		2
+#define ESLOTNUM	3
+#define EFORMAT		4
+#define EERASE		5
+#define EPROGRAM	6
+#define ECMP		7
+#define ESIZE		8
+#define ENAME		9
+#define EFILEIO		10
+#define ECALLBACK	11
+#define ELOWLEVEL	12
+#define EWRPROT		13
+#define EARGS		14
+#define ECORRUPTED_CPB	15
+#define ECORRUPTED_SPT	16
+
+#define STATE_DCIO_CORRUPTED		0xF004D00F
+#define STATE_CPB0_CORRUPTED		0xF004D010
+#define STATE_CPB0_CPB1_CORRUPTED	0xF004D011
+
+/* RSU Version Bitmasks */
+#define RSU_VERSION_CRT_IDX_MASK	GENMASK(31, 28)
+#define RSU_VERSION_ERR_MASK		GENMASK(27, 16)
+#define RSU_VERSION_DCMF_MASK		GENMASK(7, 0)
+#define RSU_VERSION_ACMF_MASK		GENMASK(15, 8)
+
+/* Macros for extracting RSU version fields */
+#define RSU_VERSION_CRT_DCMF_IDX(v)	FIELD_GET(RSU_VERSION_CRT_IDX_MASK, (v))
+#define RSU_VERSION_ERROR_SOURCE(v)	FIELD_GET(RSU_VERSION_ERR_MASK, (v))
+#define RSU_VERSION_ACMF_VERSION(v)	FIELD_GET(RSU_VERSION_ACMF_MASK, (v))
+#define RSU_VERSION_DCMF_VERSION(v)	FIELD_GET(RSU_VERSION_DCMF_MASK, (v))
+
+/* DCMF Version Bitmasks */
+#define DCMF_VERSION_MAJOR_MASK		GENMASK(31, 24)
+#define DCMF_VERSION_MINOR_MASK		GENMASK(23, 16)
+#define DCMF_VERSION_UPDATE_MASK	GENMASK(15, 8)
+
+/* Macros for extracting DCMF version fields */
+#define DCMF_VERSION_MAJOR(v)		FIELD_GET(DCMF_VERSION_MAJOR_MASK, (v))
+#define DCMF_VERSION_MINOR(v)		FIELD_GET(DCMF_VERSION_MINOR_MASK, (v))
+#define DCMF_VERSION_UPDATE(v)		FIELD_GET(DCMF_VERSION_UPDATE_MASK, (v))
+
+/**
+ * struct rsu_status_info - firmware status log info structure
+ * @current_image:address of image currently running in flash
+ * @fail_image: address of failed image in flash
+ * @state: the state of RSU system
+ * @version: the version number of RSU firmware
+ * @error_location: the error offset inside the failed image
+ * @error_details: error code
+ * @retry_counter: current image retry counter
+ *
+ * This structure is used to capture firmware status log information
+ */
+struct rsu_status_info {
+	u64 current_image;
+	u64 fail_image;
+	u32 state;
+	u32 version;
+	u32 error_location;
+	u32 error_details;
+	u32 retry_counter;
+};
+
+/**
+ * struct rsu_slot_info - slot information structure
+ * @name: a slot name
+ * @offset: a slot offset
+ * @size: the size of a slot
+ * @priority: the priority of a slot
+ *
+ * This structure is used to capture the slot information details
+ */
+struct rsu_slot_info {
+	char name[16];
+	u64 offset;
+	u32 size;
+	int priority;
+};
+
+/**
+ * rsu_init() - initialize flash driver, SPT and CPB data
+ * @filename: NULL for qspi
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_init(char *filename);
+
+/**
+ * rsu_exit() - free flash driver, clean SPT and CPB data
+ */
+void rsu_exit(void);
+
+/**
+ * rsu_slot_count() - get the number of slots defined
+ *
+ * Returns: the number of defined slots
+ */
+int rsu_slot_count(void);
+
+/**
+ * rsu_slot_by_name() - get slot number based on name
+ * @name: name of slot
+ *
+ * Return:slot number on success, or error code
+ */
+int rsu_slot_by_name(char *name);
+
+/**
+ * rsu_slot_get_info() - get the attributes of a slot
+ * @slot: slot number
+ * @info: pointer to info structure to be filled in
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_get_info(int slot, struct rsu_slot_info *info);
+
+/**
+ * rsu_slot_size() - get the size of a slot
+ * @slot: slot number
+ *
+ * Returns: the size of the slot in bytes, or error code
+ */
+int rsu_slot_size(int slot);
+
+/**
+ * rsu_slot_priority() - get the Decision CMF load priority of a slot
+ * @slot: slot number
+ *
+ * Priority of zero means the slot has no priority and is disabled.
+ * The slot with priority of one has the highest priority.
+ *
+ * Returns: the priority of the slot, or error code
+ */
+int rsu_slot_priority(int slot);
+
+/**
+ * rsu_slot_erase() - erase all data in a slot
+ * @slot: slot number
+ *
+ * Erase all data in a slot to prepare for programming. Remove the slot
+ * if it is in the CMF pointer block.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_erase(int slot);
+
+/**
+ * rsu_slot_program_buf() - program a slot from FPGA buffer data
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * This function is used to program a slot using FPGA config data from a
+ * buffer and then enter the slot into CPB.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_program_buf(int slot, void *buf, int size);
+
+/**
+ * rsu_slot_program_factory_update_buf() - program a slot using factory update
+ *                                         data from a buffer
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer
+ *
+ * This function is used to program a slot using factory update data from a
+ * buffer and then enter the slot into CPB.
+ *
+ * Returns 0 on success, or error code
+ */
+int rsu_slot_program_factory_update_buf(int slot, void *buf, int size);
+
+/**
+ * rsu_slot_program_buf_raw() - program a slot from raw buffer data
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * This function is used to program a slot using raw data from a buffer,
+ * and then enter this slot into CPB.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_program_buf_raw(int slot, void *buf, int size);
+
+/**
+ * rsu_slot_verify_buf() - verify FPGA config data in a slot against a
+ * buffer
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_verify_buf(int slot, void *buf, int size);
+
+/**
+ * rsu_slot_verify_buf_raw() - verify raw data in a slot against a buffer
+ * @slot: slot number
+ * @buf: pointer to data buffer
+ * @size: bytes to read from buffer, in hex value
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_verify_buf_raw(int slot, void *buf, int size);
+
+/**
+ * rsu_slot_enable() - enable the selected slot
+ * @slot: slot number
+ *
+ * Set the selected slot as the highest priority. It will be the first
+ * slot to be tried after a power-on reset.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_enable(int slot);
+
+/**
+ * rsu_slot_disable() - disable the selected slot
+ * @slot: slot number
+ *
+ * Remove the selected slot from the priority scheme, but don't erase the
+ * slot data so that it can be re-enabled.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_disable(int slot);
+
+/**
+ * rsu_slot_load() - load the selected slot
+ * @slot: slot number
+ *
+ * This function is used to request the selected slot to be loaded
+ * immediately. On success, after a small delay, the system is rebooted.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_load(int slot);
+
+/**
+ * rsu_slot_load_factory() - load the factory image
+ *
+ * This function is used to request the factory image to be loaded
+ * immediately. On success, after a small delay, the system is rebooted.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_load_factory(void);
+
+/**
+ * rsu_slot_rename() - Rename the selected slot.
+ * @slot: slot number
+ * @name: new name for slot
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_slot_rename(int slot, char *name);
+
+/**
+ * rsu_slot_delete() - Delete the selected slot.
+ * @slot: slot number
+ *
+ * Returns 0 on success, or Error Code
+ */
+int rsu_slot_delete(int slot);
+
+/**
+ * rsu_slot_create() - Create a new slot.
+ * @name: slot name
+ * @address: slot start address
+ * @size: slot size
+ *
+ * Returns 0 on success, or Error Code
+ */
+int rsu_slot_create(char *name, u64 address, unsigned int size);
+
+/**
+ * rsu_status_log() - Copy firmware status log to info struct
+ * @info: pointer to info struct to fill in
+ *
+ * Return 0 on success, or error code
+ */
+int rsu_status_log(struct rsu_status_info *info);
+
+/**
+ * rsu_notify() - report HPS software execution stage as a 16bit number
+ * @stage: software execution stage
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_notify(int stage);
+
+/**
+ * rsu_clear_error_status() - clear errors from the current RSU status log
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_clear_error_status(void);
+
+/**
+ * rsu_reset_retry_counter() - reset the retry counter
+ *
+ * This function is used to request the retry counter to be set to zero, so that
+ * the currently running image may be tried again after the next watchdog
+ * timeout.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_reset_retry_counter(void);
+
+/**
+ * rsu_dcmf_version() - retrieve the decision firmware version
+ * @versions: pointer to where the four DCMF versions will be stored
+ *
+ * This function is used to retrieve the version of each of the four DCMF copies
+ * in flash.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_dcmf_version(u32 *versions);
+
+/**
+ * rsu_max_retry() - retrieve the max_retry parameter
+ * @value: pointer to where the max_retry will be stored
+ *
+ * This function is used to retrieve the max_retry parameter from the decision
+ * firmware section in flash
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_max_retry(u8 *value);
+
+/**
+ * rsu_dcmf_status() - retrieve the decision firmware status
+ * @status: pointer to where the status will be stored
+ *
+ * This function is used to determine whether decision firmware copies are
+ * corrupted in flash, with the currently used decision firmware being used as
+ * reference. The status is an array of 4 values, one for each decision
+ * firmware copy. A 0 means the copy is fine, anything else means the copy is
+ * corrupted.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_dcmf_status(u16 *status);
+
+/**
+ * rsu_create_empty_cpb() - create a cpb with header field only
+ * This function is used to create a empty configuration pointer block
+ * (CPB) with the header field only.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_create_empty_cpb(void);
+
+/**
+ * rsu_restore_cpb() - restore the cpb from an address
+ * @address: the address which cpb is restored from.
+ *
+ * This function is used to restore a saved CPB from an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_restore_cpb(u64 address);
+
+/**
+ * rsu_save_cpb() - save cpb to the address
+ * @address: the address which cpb is saved to.
+ *
+ * This function is used to save CPB to an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_save_cpb(u64 address);
+
+/**
+ * rsu_restore_spt() - restore the spt from an address
+ * @address: the address which spt is restored from.
+ *
+ * This function is used to restore a saved SPT from an address
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_restore_spt(u64 address);
+
+/**
+ * rsu_save_spt() - save spt to the address
+ * @address: the address which spt is saved to.
+ *
+ * This function is used to save SPT to an address.
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_save_spt(u64 address);
+
+/**
+ * rsu_running_factory() - determine if current running image is factory image
+ * @factory: set to non-zero value when running factory image, zero otherwise
+ *
+ * Returns: 0 on success, or error code
+ */
+int rsu_running_factory(int *factory);
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_flash_if.h b/arch/arm/mach-socfpga/include/mach/rsu_flash_if.h
new file mode 100644
index 00000000000..7539708e66f
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu_flash_if.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RSU SPI NOR access: driver model (DM_SPI_FLASH) vs legacy spi_flash_probe().
+ */
+#ifndef __RSU_FLASH_IF_H__
+#define __RSU_FLASH_IF_H__
+
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/types.h>
+#include <spi_flash.h>
+
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+#include <dm/device.h>
+#include <linux/mtd/spi-nor.h>
+
+static inline u32 rsu_mtd_size(struct udevice *dev)
+{
+	struct spi_nor *nor = dev_get_uclass_priv(dev);
+
+	return nor ? nor->size : 0;
+}
+
+static inline int rsu_mtd_read(struct udevice *dev, u32 off, size_t len,
+			       void *buf)
+{
+	return spi_flash_read_dm(dev, off, len, buf);
+}
+
+static inline int rsu_mtd_write(struct udevice *dev, u32 off, size_t len,
+				const void *buf)
+{
+	return spi_flash_write_dm(dev, off, len, buf);
+}
+
+static inline int rsu_mtd_erase(struct udevice *dev, u32 off, size_t len)
+{
+	return spi_flash_erase_dm(dev, off, len);
+}
+
+static inline int rsu_mtd_probe(unsigned int bus, unsigned int cs,
+				struct udevice **devp)
+{
+	return spi_flash_probe_bus_cs(bus, cs, devp);
+}
+
+static inline void rsu_mtd_unclaim(struct udevice *dev)
+{
+	(void)dev;
+}
+
+#else
+
+static inline u32 rsu_mtd_size(struct spi_flash *flash)
+{
+	return flash->size;
+}
+
+static inline int rsu_mtd_read(struct spi_flash *flash, u32 off, size_t len,
+			       void *buf)
+{
+	return spi_flash_read(flash, off, len, buf);
+}
+
+static inline int rsu_mtd_write(struct spi_flash *flash, u32 off, size_t len,
+				const void *buf)
+{
+	return spi_flash_write(flash, off, len, buf);
+}
+
+static inline int rsu_mtd_erase(struct spi_flash *flash, u32 off, size_t len)
+{
+	return spi_flash_erase(flash, off, len);
+}
+
+static inline int rsu_mtd_probe(unsigned int bus, unsigned int cs,
+				struct spi_flash **flashp)
+{
+	struct spi_flash *f;
+
+	f = spi_flash_probe(bus, cs, CONFIG_SF_DEFAULT_SPEED,
+			    CONFIG_SF_DEFAULT_MODE);
+	if (!f)
+		return -ENODEV;
+	*flashp = f;
+	return 0;
+}
+
+static inline void rsu_mtd_unclaim(struct spi_flash *flash)
+{
+	spi_flash_free(flash);
+}
+
+#endif
+
+#endif /* __RSU_FLASH_IF_H__ */
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_ll.h b/arch/arm/mach-socfpga/include/mach/rsu_ll.h
new file mode 100644
index 00000000000..b391597cbd0
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu_ll.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Intel Corporation
+ */
+
+#ifndef __RSU_LL_H__
+#define __RSU_LL_H__
+
+#include <asm/arch/rsu.h>
+#include <asm/types.h>
+
+/**
+ * struct rsu_ll_intf - RSU low level interface
+ * @exit: exit low level interface
+ * @partition.count: get number of slots
+ * @@partition.name: get name of a slot
+ * @partition.offset: get offset of a slot
+ * @partition.size: get size of a slot
+ * @partition.reserved: check if a slot is reserved
+ * @partition.readonly: check if a slot is read only
+ * @partition.rename: rename a slot
+ * @priority.get: get priority
+ * @priority.add: add priority
+ * @priority.remove: remove priority
+ * @data.read: read data from flash device
+ * @data.write: write date to flash device
+ * @data.erase: erase date from flash device
+ * @fw_ops.load: inform firmware to load image
+ * @fw_ops.status: get status from firmware
+ * @fw_ops.notify: send notify command to firmware
+ * @fw_ops.dcmf_status: get dcmf status
+ */
+struct rsu_ll_intf {
+	void (*exit)(void);
+	/** @priv: backend private data (e.g. QSPI session); NULL if unused */
+	void *priv;
+
+	struct {
+		int (*count)(void);
+		char* (*name)(int part_num);
+		u64 (*offset)(int part_num);
+		s64 (*factory_offset)(void);
+		u32 (*size)(int part_num);
+		int (*reserved)(int part_num);
+		int (*readonly)(int part_num);
+		int (*rename)(int part_num, char *name);
+		int (*delete)(int part_num);
+		int (*create)(char *name, u64 start, unsigned int size);
+	} partition;
+
+	struct {
+		int (*get)(int part_num);
+		int (*add)(int part_num);
+		int (*remove)(int part_num);
+	} priority;
+
+	struct {
+		int (*read)(int part_num, int offset, int bytes, void *buf);
+		int (*write)(int part_num, int offset, int bytes, void *buf);
+		int (*erase)(int part_num);
+	} data;
+
+	struct {
+		int (*load)(u64 offset);
+		int (*status)(struct rsu_status_info *info);
+		int (*notify)(u32 value);
+		int (*dcmf_version)(u32 *versions);
+		int (*dcmf_status)(u16 *status);
+		int (*max_retry)(u8 *value);
+	} fw_ops;
+
+	struct {
+		int (*empty)(void);
+		int (*restore)(u64 address);
+		int (*save)(u64 address);
+		int (*corrupted)(void);
+	} cpb_ops;
+
+	struct {
+		int (*restore)(u64 address);
+		int (*save)(u64 address);
+		int (*corrupted)(void);
+	} spt_ops;
+};
+
+/**
+ * rsu_ll_qspi_init() - low level qspi interface init
+ * @intf: pointer to pointer of low level interface
+ *
+ * Return: 0 on success, or error code
+ */
+int rsu_ll_qspi_init(struct rsu_ll_intf **intf);
+#endif
+
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_misc.h b/arch/arm/mach-socfpga/include/mach/rsu_misc.h
new file mode 100644
index 00000000000..7777d652912
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu_misc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Intel Corporation
+ */
+
+#ifndef __RSU_MISC_H__
+#define __RSU_MISC_H__
+
+#include <asm/arch/rsu_ll.h>
+
+/*
+ * A bitstream is a recurrent data structure composed of sections. Each section
+ * consists of 4KB blocks. The first block in a section is called the main
+ * descriptor and the first 32bit value in that descriptor identifies the
+ * section typpe, with 0x62294895 denoting a CMF section.
+ * The second block in a section is called a signature block. The last 256 bytes
+ * of the signature block are called the main image pointer, and contains up to
+ * four pointers to other sections in the bitstream. The entire signature block,
+ * including the main pointer area is protected by a 32-bit CRC.
+ *
+ * The slot size is used to determine if the bitstream was generated using a
+ * slot offset address of zero. The main image pointers of all the CMF sections
+ * identified in the bitstream are updated when programming into a slot if all
+ * of the pointers are less than the slot size.
+ */
+
+#define IMAGE_BLOCK_SZ      0x1000      /* Bitstream block size */
+#define SIG_BLOCK_PTR_OFFS  0x0F00      /* Signature block pointer offset */
+#define SIG_BLOCK_CRC_OFFS  0x0FFC      /* Signature block CRC offset */
+#define CMF_MAGIC           0x62294895  /* Magic identifier for CMF sections */
+
+/* log level */
+enum rsu_log_level {
+	RSU_EMERG = 0,
+	RSU_ALERT,
+	RSU_CRIT,
+	RSU_ERR,
+	RSU_WARNING,
+	RSU_NOTICE,
+	RSU_INFO,
+	RSU_DEBUG
+};
+
+typedef int (*rsu_data_callback)(void *buf, int size);
+int rsu_cb_buf_init(void *buf, int size);
+void rsu_cb_buf_exit(void);
+int rsu_cb_buf(void *buf, int len);
+int rsu_cb_program_common(struct rsu_ll_intf *ll_intf, int slot,
+			  rsu_data_callback callback, int rawdata);
+int rsu_cb_verify_common(struct rsu_ll_intf *ll_intf, int slot,
+			 rsu_data_callback callback, int rawdata);
+
+int rsu_misc_is_rsvd_name(char *name);
+int rsu_misc_is_slot(struct rsu_ll_intf *ll_intf, int part_num);
+int rsu_misc_slot2part(struct rsu_ll_intf *ll_intf, int slot);
+int rsu_misc_writeprotected(int slot);
+void rsu_misc_safe_strcpy(char *dst, int dsz, char *src, int ssz);
+int rsu_misc_spt_checksum_enabled(void);
+
+void rsu_log(const enum rsu_log_level level, const char *format, ...);
+int smc_store_max_retry(u32 value);
+
+void swap_bits(char *data, int size);
+int pow(u32 x, u32 y);
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_s10.h b/arch/arm/mach-socfpga/include/mach/rsu_s10.h
new file mode 100644
index 00000000000..8218255eba7
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu_s10.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#ifndef _RSU_S10_H_
+#define _RSU_S10_H_
+
+#define RSU_S10_CPB_MAGIC_NUMBER	0x57789609
+#define RSU_S10_SPT_MAGIC_NUMBER	0x57713427
+
+#define SPT0_INDEX	1
+#define SPT1_INDEX	3
+
+#define MAX_PART_NAME_LENGTH 16
+
+/* CMF pointer block */
+struct socfpga_rsu_s10_cpb {
+	u32 magic_number;
+	u32 header_size;
+	u32 total_size;
+	u32 reserved1;
+	u32 iptab_offset;
+	u32 nslots;
+	u32 reserved2;
+	u64 pointer_slot[508];
+};
+
+/* sub partition slot */
+struct socfpga_rsu_s10_spt_slot {
+	char name[MAX_PART_NAME_LENGTH];
+	u32 offset[2];
+	u32 length;
+	u32 flag;
+};
+
+/* sub partition table */
+struct socfpga_rsu_s10_spt {
+	u32 magic_number;
+	u32 version;
+	u32 entries;
+	u32 reserved[5];
+	struct socfpga_rsu_s10_spt_slot spt_slot[127];
+};
+
+#endif /* _RSU_S10_H_ */
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_smc.h b/arch/arm/mach-socfpga/include/mach/rsu_smc.h
new file mode 100644
index 00000000000..89b66ee0b05
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu_smc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SMC / PSCI-visible RSU state (secure RAM). Keep separate from rsu_s10.h so
+ * normal-world RSU code does not declare secure-only symbols.
+ */
+#ifndef __RSU_SMC_H__
+#define __RSU_SMC_H__
+
+#include <asm/types.h>
+#include <asm/secure.h>
+
+extern u32 smc_rsu_update_address __secure_data;
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/smc_s10.h b/arch/arm/mach-socfpga/include/mach/smc_s10.h
new file mode 100644
index 00000000000..ba34b7c441f
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/smc_s10.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Intel Corporation. All rights reserved
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#define SMC_ARG0		0
+#define SMC_ARG1		(SMC_ARG0 + 1)
+#define SMC_ARG2		(SMC_ARG1 + 1)
+#define SMC_ARG3		(SMC_ARG2 + 1)
+#define SMC_RETURN_ARGS_MAX	(SMC_ARG3 + 1)
+
+/*
+ * Macro functions for allocation and read/write of
+ * variables to be assigned to registers
+ */
+/* Allocate memory for variable */
+#define SMC_ALLOC_REG_MEM(var) unsigned long var[SMC_RETURN_ARGS_MAX]
+/* Clear variable */
+#define SMC_INIT_REG_MEM(var) \
+	do { \
+		int i; \
+		for (i = 0; i < SMC_RETURN_ARGS_MAX; i++) \
+			var[i] = 0; \
+	} while (0)
+/* Read variable */
+#define SMC_GET_REG_MEM(var, i) var[i]
+/* Write Variable */
+#define SMC_ASSIGN_REG_MEM(var, i, val) ((var)[i] = (val))
+/* Assign variables back to registers */
+#define SMC_RET_REG_MEM(var) \
+	asm volatile("ldr x0, %0\n" \
+		     "ldr x1, %1\n" \
+		     "ldr x2, %2\n" \
+		     "ldr x3, %3\n" \
+		     : : "m" (var[0]), "m" (var[1]), \
+			 "m" (var[2]), "m" (var[3]) :)
diff --git a/arch/arm/mach-socfpga/include/mach/socfpga_rsu_dm.h b/arch/arm/mach-socfpga/include/mach/socfpga_rsu_dm.h
new file mode 100644
index 00000000000..05928f6aca0
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/socfpga_rsu_dm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SoC FPGA RSU driver model (UCLASS_MISC) private data.
+ */
+#ifndef __SOCFPGA_RSU_DM_H__
+#define __SOCFPGA_RSU_DM_H__
+
+#include <asm/arch/rsu_ll.h>
+
+/**
+ * struct socfpga_rsu_priv - per-DM-device RSU session anchor
+ * @ll: active low-level interface while a console session holds the device
+ */
+struct socfpga_rsu_priv {
+	struct rsu_ll_intf *ll;
+};
+
+#endif /* __SOCFPGA_RSU_DM_H__ */
diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/mailbox_s10.c
index 5e8768168d3..d65a7313fd8 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -6,12 +6,14 @@
 
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/mailbox_s10.h>
+#include <asm/arch/rsu.h>
 #include <asm/arch/smc_api.h>
 #include <asm/arch/system_manager.h>
 #include <asm/io.h>
 #include <asm/secure.h>
 #include <asm/system.h>
 #include <hang.h>
+#include <linux/bitfield.h>
 #include <wait_bit.h>
 
 #define MBOX_READL(reg)			\
@@ -390,6 +392,145 @@ error:
 
 	return ret;
 }
+
+int mbox_qspi_get_device_info(u32 *resp_buf, u32 resp_buf_len)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)) {
+		ret = smc_send_mailbox(MBOX_QSPI_GET_DEVICE_INFO, 0, NULL, 0,
+				       (u32 *)&resp_buf_len, (u32 *)resp_buf);
+	} else {
+		ret = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_QSPI_GET_DEVICE_INFO,
+				    MBOX_CMD_DIRECT, 0, NULL, 0,
+				    (u32 *)&resp_buf_len, (u32 *)resp_buf);
+	}
+
+	if (ret) {
+		debug("%s: Failed to retrieve QSPI Device INFO: %d\n",
+		      __func__, ret);
+		return ret;
+	}
+
+	debug("Successfully retrieve QSPI Device INFO.\n");
+
+	return 0;
+}
+
+int mbox_rsu_get_spt_offset(u32 *resp_buf, u32 resp_buf_len)
+{
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	return smc_send_mailbox(MBOX_GET_SUBPARTITION_TABLE, 0, NULL, 0,
+				(u32 *)&resp_buf_len, (u32 *)resp_buf);
+#else
+	return mbox_send_cmd(MBOX_ID_UBOOT, MBOX_GET_SUBPARTITION_TABLE,
+			     MBOX_CMD_DIRECT, 0, NULL, 0, (u32 *)&resp_buf_len,
+			     (u32 *)resp_buf);
+#endif
+}
+
+int mbox_rsu_status(u32 *resp_buf, u32 resp_buf_len)
+{
+	int ret;
+	struct rsu_status_info *info = (struct rsu_status_info *)resp_buf;
+
+	info->retry_counter = -1;
+
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	ret = smc_send_mailbox(MBOX_RSU_STATUS, 0, NULL, 0,
+			       (u32 *)&resp_buf_len, (u32 *)resp_buf);
+#else
+	ret = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RSU_STATUS, MBOX_CMD_DIRECT, 0,
+			    NULL, 0, (u32 *)&resp_buf_len, (u32 *)resp_buf);
+#endif
+
+	if (ret)
+		return ret;
+
+	if (info->retry_counter != -1)
+		if (!RSU_VERSION_ACMF_VERSION(info->version))
+			info->version |= FIELD_PREP(RSU_VERSION_ACMF_MASK, 1);
+
+	return ret;
+}
+
+#ifdef CONFIG_ARMV8_PSCI
+int __secure mbox_rsu_status_psci(u32 *resp_buf, u32 resp_buf_len)
+{
+	int ret;
+	struct rsu_status_info *info = (struct rsu_status_info *)resp_buf;
+	int adjust = (resp_buf_len >= 9);
+
+	if (adjust)
+		info->retry_counter = -1;
+
+	ret = mbox_send_cmd_psci(MBOX_ID_UBOOT, MBOX_RSU_STATUS,
+				 MBOX_CMD_DIRECT, 0, NULL, 0,
+				 (u32 *)&resp_buf_len, (u32 *)resp_buf);
+
+	if (ret)
+		return ret;
+
+	if (!adjust)
+		return ret;
+
+	if (info->retry_counter != -1)
+		if (!RSU_VERSION_ACMF_VERSION(info->version))
+			info->version |= FIELD_PREP(RSU_VERSION_ACMF_MASK, 1);
+
+	return ret;
+}
+#endif /* CONFIG_ARMV8_PSCI */
+
+int mbox_rsu_update(u32 *flash_offset)
+{
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+	return smc_send_mailbox(MBOX_RSU_UPDATE, 2, (u32 *)flash_offset, 0,
+				0, NULL);
+#else
+	return mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RSU_UPDATE, MBOX_CMD_DIRECT, 2,
+			     (u32 *)flash_offset, 0, 0, NULL);
+#endif
+}
+
+#ifdef CONFIG_ARMV8_PSCI
+int __secure mbox_rsu_update_psci(u32 *flash_offset)
+{
+	return mbox_send_cmd_psci(MBOX_ID_UBOOT, MBOX_RSU_UPDATE,
+				  MBOX_CMD_DIRECT, 2, (u32 *)flash_offset,
+				  0, 0, NULL);
+}
+#endif /* CONFIG_ARMV8_PSCI */
+
+#else
+int mbox_rsu_get_spt_offset(u32 *resp_buf, u32 resp_buf_len)
+{
+	return MBOX_FUNC_NOT_SUPPORTED;
+}
+
+int mbox_rsu_status(u32 *resp_buf, u32 resp_buf_len)
+{
+	return MBOX_FUNC_NOT_SUPPORTED;
+}
+
+#ifdef CONFIG_ARMV8_PSCI
+int __secure mbox_rsu_status_psci(u32 *resp_buf, u32 resp_buf_len)
+{
+	return MBOX_FUNC_NOT_SUPPORTED;
+}
+#endif /* CONFIG_ARMV8_PSCI */
+
+int mbox_rsu_update(u32 *flash_offset)
+{
+	return MBOX_FUNC_NOT_SUPPORTED;
+}
+
+#ifdef CONFIG_ARMV8_PSCI
+int __secure mbox_rsu_update_psci(u32 *flash_offset)
+{
+	return MBOX_FUNC_NOT_SUPPORTED;
+}
+#endif /* CONFIG_ARMV8_PSCI */
 #endif /* CONFIG_CADENCE_QSPI */
 
 int mbox_reset_cold(void)
diff --git a/include/rsu_console.h b/include/rsu_console.h
new file mode 100644
index 00000000000..4e851069183
--- /dev/null
+++ b/include/rsu_console.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ * Public prototypes for SoC FPGA RSU console-helper functions.
+ */
+#ifndef _RSU_CONSOLE_H_
+#define _RSU_CONSOLE_H_
+
+int rsu_spt_cpb_list(int argc, char * const argv[]);
+int rsu_update(int argc, char * const argv[]);
+int rsu_dtb(int argc, char * const argv[]);
+
+#endif /* _RSU_CONSOLE_H_ */
-- 
2.43.7

