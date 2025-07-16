Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3674C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A2183211;
	Wed, 16 Jul 2025 09:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="q8wPDEyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB8A82E37; Wed, 16 Jul 2025 09:09:05 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CEB8319A
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpnTvwwbFrDpYxsCLH3FMjFja4KzE5Qj2H3u971PlDo9gP2a33ywt++P2wWBxjfK4/7NRAJj66APgVPnubRu1WWFquUus4uGfvwIec0mmfZSLiE7mfijqc2KDE7tmHEd2jUC7ncTIoH3QYvCJdjwZcepMcoJ0uRpBuQR65lT3I1ILjOTDeFV8H1PfiNteEf73grd2sh/9Yo9HAzKDa1v1PfePnA8GUEJOh/vej8UDdsBrHbZKTNxKJDmp4mlnAUd5842GNoAYAWxHLYNrGnvdE19vM50ezbTzN9NKVK/c2BQr7EsDJZ9lZhKs0WS/MY+Zzs9BkWVi6zNHTCjepRKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=e+kxf5xeWRAdri+ZzpsyCOUUpga0xr9sNKRPTMCFdFk9LctgYHLfU9wbQmEypAWv8F6lNzxj3c6qWRoF4HHIEXioL+SEC6N+B8FbWdp7c9MbgDE34Pl+aOKzS9cGJh3VsQiShnmAIPYTQ6vaM/I4NExriXyDUiOTuy251jTEHbrhnYeKOaeCa22CaejDg+/Y/bIcun2jyDblSM2pN1ItrBEl+1lWp47cXHY8kIWs8PeipSRtreWe/JotT36BKR3VZMsnHnESKbS2uRW56/qZz+K8gpDR+kUZZmOdvwxn8vmGVB3nPOyuL6bxvMEhhek8iKBCY8K3n2yJNPB+y/Fz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=q8wPDEyOyvQm2NfQBBh68qf4adWSIMr+2EjEwPuE4KlB+ZLax/n7zNjQjW32jLgZ3C9ZXonZtFHoa+v3u6Zr+A/DT63dJij1K2vayW12Z4TmGQZxxPI15q8E8MRH+ABywM0rfOePk455ZYnXFJqS+WMG0R5hfRjlsCEVqjehVI9goCmzfp0WdmM+Tiz9IAb4cHQlAiP0Eg/rbToeip67aHJBTaNuQZiZNyPoSzZv4JLqRHvWkz0Mu+dMyZrwKo6IuWek/s4I7bJMaG4Q5PZwjKZD80jIMG+gYO4L9ukgymbsItUN3bRHs+MeohwKlbaKqaorr5jbQam3n9At8ZpS0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:08:59 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:08:59 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v6 05/12] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Wed, 16 Jul 2025 15:08:03 +0800
Message-Id: <20250716070810.8030-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e83c76-d348-4f8c-6fcb-08ddc437a293
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?64XdXi5yVRYtwRJ9ZFbXPIUEQlTSi+ma4ZucokiG5qRcZuznrc327EvZY2+8?=
 =?us-ascii?Q?/5BBaLhFeJy99c++nVhPWe42kB+idsTiwGpdfia2krhCau9KTWaRlSK72rcw?=
 =?us-ascii?Q?DLheQdO2BR5LcF34g0AVx9O0YNA3PEOWlUXeoGvJanpgtd1ElgSYMgBqC1Vt?=
 =?us-ascii?Q?Rplrwwgl8l2BRpu7TUxaHi7fguWcUmjHijwiLxGEm0dpeQ/zE1WJsrFeJrYM?=
 =?us-ascii?Q?amBDDTcQ/4fWqd1plwXam+7KEiyRdYGBE7meifAAPYbNIPOn25EOEoelC08u?=
 =?us-ascii?Q?+TuP6ivNtQqKxYv7dKs9/6JNboYUAG5i5TpaWVbUQja0WmWOf90o0mbvm4up?=
 =?us-ascii?Q?b8Z0vwdqem3+KJmVGplGgkprx29RCnTXov5l2yP3gCJa0MRxTDDR+FlCOZfe?=
 =?us-ascii?Q?N1Ik+OORzJ1gfqyTrucR28IS1yabJa9dW6l7tG//GvAKagSWhDDKnBAr1rWC?=
 =?us-ascii?Q?cETbszbb+G7aBSD4a8HAXTqJqGDBz+x0a2I149G/EKj9V0Pu2x9UWLb7Ecvs?=
 =?us-ascii?Q?PkNHC6gN/Iqce5VK9xlDRR+Kdw3hW8kmaOcNe3B2LI4BcZ7LN0FyfS3d5et1?=
 =?us-ascii?Q?DAhBc4L5BjVhaGl1hsoUfOupKBlJtRPtHwf/35BcxK9YTHld1G/7GO1aFXjT?=
 =?us-ascii?Q?AmzneKKAC4mxHbxzNI2wD2PXR4mwdoLau6H7MXC3xwj01KZdLbqDcOhg9dR+?=
 =?us-ascii?Q?Pn8j7juVK+SpDRImyoxYAtno3ir5A6bnZxiM6TuogksBpKKC4iQt+qK1Sfr3?=
 =?us-ascii?Q?1dMBnNgxcOn9P4ebrsdNvka4x+Y0nea3sxZiY1h6jRf9ps25+rpjEzDFEnFu?=
 =?us-ascii?Q?zSl3Qd8nt3V30QNQUBQr2Lgj+q/21DgcnZt1r14m+P/Ez9tmlxEeo8SCnD4d?=
 =?us-ascii?Q?jYxtxOsIorCODo5i4ohqFzccfpyfriRc8dqxRb9N2oB0qZPNcQ1IIJyKCn7z?=
 =?us-ascii?Q?OXW7FLC3xUpNeE1hvP/hRjRq6HSFvxZ9ZpNsYjunruyHHJiZwkIiQ3cEmsdJ?=
 =?us-ascii?Q?GFjVvmtBRThEXkh9k2mMpILjV6oOmLNRUlitSBD/zeT3y4933mtdwKJbd/Fy?=
 =?us-ascii?Q?ZVCyuaHhCTkNa8QJXo2t6udd4KGILBiDSoInF2DEHmaCcLFyZszI8+KeEHX5?=
 =?us-ascii?Q?JCh/Kcv8PvdhlDZn7HmAJGShZhsOTmI4DjNUUdq8mFSvQ793uWoU8kEQBHw4?=
 =?us-ascii?Q?FX1R166qNd88uN8Wrdc+YwVL1tTPbxiqDHjcYgSB7CKDoA7T+D2y6xik7XZD?=
 =?us-ascii?Q?3zJe8nBwsXu1un1dHRDL487++3aoVJKLj32ssT1qW6Gh0RykwwpghvT1W3pi?=
 =?us-ascii?Q?0N3uhLoqCl4n9g/GBOaZ8ms4lEqsVsbt4Pbbi32q42QsBCI9WfSlfyLqoUTK?=
 =?us-ascii?Q?ELxHRkA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1QwaPcFWaMUpmFvbOkO7L+sGMtCBV94C7yPkPh55FQbZGk3O8XFSRFD1Nfz?=
 =?us-ascii?Q?YXBOVpSAGwftDnnnWIDmHQfviqYqL2DMFo+gUBkxBe9EhuVt210icqobWzx7?=
 =?us-ascii?Q?RfKkF1ggNL4Wutlpv/liKmM2JbdufTSqrbEls92j0y2Kfh/RMfgQKUuBA8kt?=
 =?us-ascii?Q?l6NvOm8Y9fHslHLwKir3vj9i2X+5PXtvbN8w9cTc+f6d4xfoKKLLrLh+sKMH?=
 =?us-ascii?Q?K/EJWRHeEHdm7f2+47hwtFjPBknk8JR5qw1DlGXtLhqLaUJwC4pKr6z8zqao?=
 =?us-ascii?Q?4f2XP3OHDQCDuEjlTw+dNZlU94PbWFgk9EWgKfsgHkL33bVN//B5plh0nRwd?=
 =?us-ascii?Q?JeRb+tn6P68PwllclZNh0rVoE6ISTeLxByvtpQhiGEFomvkOC51ks/NtPLtR?=
 =?us-ascii?Q?aQlVo6MOgG1ap5LVnAZshPCrWPifRhvF2vEw40gJAc+TvH5uS94zfO5Ofi+J?=
 =?us-ascii?Q?ErwDbUEiFwzQVmL+3lfGAxcbTVkp+wKogAqXeinExcHhQ4I3LZ2xMeILY2gc?=
 =?us-ascii?Q?wnbNVwYc5XpOjVsYyhIQHb1QqsmLFfRwepA0AjuC/q3z8SMSV0Ay9zHbSt8T?=
 =?us-ascii?Q?vAWHqUy+NNZ6k9PAA9tcvawN3YcmZ+FGf2uIzObgRzjTYbDkMIydYDOcploR?=
 =?us-ascii?Q?vQNEfYm3kgp1j696gCvHlnFLLzoMUSk4i8750hhcxDbG3oaqf9fdAfSQHKvs?=
 =?us-ascii?Q?XjpdBtRxnEw9nh7qrMjPDCvEm05xDgcbpD8HH59P//GkzKw7Ty+yxEaTHFgh?=
 =?us-ascii?Q?fBlUaZrj3SRhZ3xoqwGTIjpZx/eJm/NWEfnfdFv0QPrJKNhu70qdvMRP33u9?=
 =?us-ascii?Q?FUBriUpIWKQr4idVdS6i9fKfxHpHxx0vQAd9QHUmM9zBGdB2R9bmJWoIYsUX?=
 =?us-ascii?Q?TMuR6Ee/bw3GR9oWZRhYBe0cl7mai1A7bjN/1vjhjPHAvFKhOdei0yw3Wnvm?=
 =?us-ascii?Q?/39njsb1m36WM6WGliTyFc0qTCnNvgM8qAVHWRGQWJTL7XlgkyrgUHzCAbGi?=
 =?us-ascii?Q?fecy8CdXUaEjBSIT3m3l1IqDX+LovD0A/RrnIXwfmHR4XUiUTgBZFjtuTfWT?=
 =?us-ascii?Q?rgbMgLA3/MXbooTkmGBRDo1BEALzDJBFYbZeqixgwn5DjbmJ2r2FMjcF5NQe?=
 =?us-ascii?Q?meU3HlUpExtl6flB2PuR/B63Kj8/wr5oBc3GZ6HaWtSkPUE+1AvtM6TgGZDv?=
 =?us-ascii?Q?bSlbNgGCePEMUm65m1UySVah+sA/KSFzwxyspjECcAXlMkGj4/BGjo4UcTW5?=
 =?us-ascii?Q?OirxCuUN0dkfhTXI2qn/3aIDldfTItGU4ohvKdh0v7Ewadiksr+Zm9+SdLDa?=
 =?us-ascii?Q?pAG+pbkE6K5kDG/pCX7a3HtdcQgdo8HUFEtWkILRpRDxDEHY7COox1IPaOFE?=
 =?us-ascii?Q?pm62zmMbAADzamXS/8HPfLizNtLDd5dQMNgs3vpRxGAWE/C/h/bVfLn6+qbx?=
 =?us-ascii?Q?EDONAa27v8x5emBuaZTFU2WpPeoHmOrNyEjqg15pHIrfLh1fEkLSg6HZJ7nM?=
 =?us-ascii?Q?mhF4yBL5hmu3LlGhM9ADXu/gbJldJpKyp/o7nFo5tH7YPZzfk7yOHVzkW76G?=
 =?us-ascii?Q?Ai/inxxmRH/y0XiZ6zsIOodOuFPTHhvsG32FJeGx866Xu+NnTxaQTLZ1e0mJ?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e83c76-d348-4f8c-6fcb-08ddc437a293
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:08:58.9508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlUrOb6WScSaQ/OJ8oc8X5TdzOzKhZnQvRs5Owi/n/UQvKWF332RwQ0d0X08BQYc8PB6ZxwKjEkrbi5JlYYf1WPq33zhrkz4uhk7Rt9iXCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

Enable the Kconfig and Makefile for the MIPI DWI3C driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/Kconfig         |  5 +++++
 drivers/i3c/Makefile        |  1 +
 drivers/i3c/master/Kconfig  | 11 +++++++++++
 drivers/i3c/master/Makefile |  3 +++
 4 files changed, 20 insertions(+)
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index fa68612787b..d4451057de0 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,3 +14,8 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+if I3C
+
+source "drivers/i3c/master/Kconfig"
+
+endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5bb44a8d64f..5ddc4743c86 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y				:= i3c-uclass.o device.o master.o
+obj-y				+= master/
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
new file mode 100644
index 00000000000..22bb7c21ea1
--- /dev/null
+++ b/drivers/i3c/master/Kconfig
@@ -0,0 +1,11 @@
+config DW_I3C_MASTER
+	tristate "Synospsys DesignWare I3C master driver"
+	depends on I3C
+	help
+	  Support for Synopsys DesignWare MIPI I3C Controller.
+
+	  For details please see
+	  https://www.synopsys.com/dw/ipdir.php?ds=mipi_i3c
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called dw-i3c-master.
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
new file mode 100644
index 00000000000..c7562f1aa33
--- /dev/null
+++ b/drivers/i3c/master/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DW_I3C_MASTER) += dw-i3c-master.o
-- 
2.35.3

