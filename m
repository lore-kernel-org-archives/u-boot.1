Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E809CD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1329384A02;
	Fri,  5 Jun 2026 03:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QTbOCU3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38437849F7; Fri,  5 Jun 2026 03:58:22 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66496849E9
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGsZ2kKh260BEUSM96XCIn0iBm0Q8vnwN1Cru8Q20eHHGec/xyDMyNNlQFMGDiuBhrZpdLt8noz4a0UYg9pwcwb9d4FjT8+FSrBIJ4QogspiLWZObPJj4YXATm0JBiA8ebZn7I4/iq0YneHwzC485GMqmTrZ2IWkGzcR8dqs6DY2U4c6JOhTLejCPbj8roU0UqW/VQq2Y9sdry+Zm4ItJwM+PPczcke3ThwOqi8/m1UKxxhJYUH4usHGwyVXe2Qbp2pqGfkhSd9Ggn5F2XZkqN6XMSMF3n7N4/ZtmxCTmOJN9rK8hlQipoCqvE69Mfozs6pVlj4sDFfIQjZ0bgpEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWkp9B6S7KyFrQCFGOxDa0lkEn1KnBuB5FoSbMmx1xk=;
 b=J4OMgV9PnwW+ECWZiAUvnbKKpPXBQDaXF/2fJ7M+qfojq3V3dNEgFBz6SyHgw1ClXKXD3B0qyJG6s6K9Zk3SJA9h91k5azXJcxbYoHC+tjiln3jLWB2CwvWuZ/GJUSZ9ozEYHs1KNxq+br5utpHKEumDdqeDpzaLssR+jr6F/rJZmPlVEQKDCH/ChCZZZHfbzYR8uDIHRSwWNSBh9w9+qEEaa2HWe+NDLsG3XeMFzI359FpHgTafY629IA/YTmC7wBFaZ0Qofgm9wfpHcdIV99xlC5srQZqRAqn0SRItrsrytzFXKf0XzLDOsdsy3Lq32EVxOWHPR6qF6gAslyEODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWkp9B6S7KyFrQCFGOxDa0lkEn1KnBuB5FoSbMmx1xk=;
 b=QTbOCU3OfRs8VEbg2bBQfR83gPfKzX5YN8AZ+X1drTd5z4j3ZDWPoswUJWYNUoAc2WKV1uIYV4NM8J6kfQAMfOqvqEHZ+t2JUTQ48SLqdV0U0kZvVrI4VMpYquoK6cHPKkBuNIl0X+YkPhapYfZqlUuyZsnvcmN92XBNHxzkOM9/IBRAKM2lCLI4bzhTxhghcUb5mLie3KQ1VqB4457rtdalwtz5TP2N2yPwozHMzLn5P7TT+9jwjXTH2qGsI1UDc4mmzVpHfiyGnFsZ89F+bDErRQj/bHXdbbrFk0S5QOIDly8zZcY9JUXaKDcvZd8IZkghzmH+8mPhWh1W1si1Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:57:08 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:57:08 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 9/9] spl: s10: Enhance watchdog support in SPL for Stratix
 10
Date: Fri,  5 Jun 2026 09:55:03 +0800
Message-ID: <20260605015503.11709-10-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b515bbd-adb5-4f88-b155-08dec2a5bff3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: isNJNbSBlQrkZLBd0VZ+OEax/dg2XakIsf/HH5N5VoUX0lywpy5rfQfAoSNjIbW1gScRlCmiAVx5AM0zj1bK1KiI1ABwiSO00JXYN6M/k4XxzAZZUlmUFoRlQHDvSRtRIzCMi94/egYraMbW/ZNcdPOjRs7l5/6YUGWl5QpgvDN6D+61ektKY4MSK2epI2+t3ExCCkoEkRa+DghBV4FuJr5zbbBQNqrqIZbErtvlIUrqw91MadSMhVMLT/m9EGOgQWjafs77iEekNLokrTpGCKOkGlWJB7idFWCbMqFabYNmc1RU1fJm3afMavSR6lh2X33lDVWprhiMn+NZfBDJYGe5e7FwKGR3VnmhpEHMuIW3HzLfbGzdbbzc1g4G1EQlMuHNnKkRVjWUNZwOL+RxuvuTToRS+sK3IrnQLp57HsR24pL8Z32ZW28gmN69km76GllCUkL/msO4v5HUzbuOCgMg5lWNw2TtU17PXBYTGekJMQ9Dr88Xu0UxWcGvZcPto1u1UxhjbpROZYsCPQfm26YmpmIx1zhY/Cac6p6iTRWsaF53xcNxJSW73na1totX8iNeSnyyZzTZ1FjT6uaAlHTJZK0mxeNrxnDfEOdOKRD8RMqdfd9oAxbEpZs0cDDJLK/B8O/SMQTnMkHMGXEQdtn9hrGlXW4xH7S0Wdm1Oj5s70IDzJ+LU4fo0B8wSTPS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X2TrJi4oh7m2/WDzFlpWyIoO8By5QnXm7YtiQkIVTLPCorl6SLCr6mc9Yy4U?=
 =?us-ascii?Q?NI3qyUXHMsaTfC/b/vTEXz9qJF0QxoEKSIACdVR1OjnKrg7TajxL+CE5sMK3?=
 =?us-ascii?Q?39HCe83rk35sBw8MQmXL0RGzZsqGFiN/DxFHEOTxBAIBJZhFh+ewd414eaYE?=
 =?us-ascii?Q?tFa5IPKVQmvUkBRu1LaPmhi6LW3l730fXovuFxxzK8SGTuE9N+j8yPZQx96m?=
 =?us-ascii?Q?IguE/twS859OB0vMooghpoZbriDL0faAf7TYSrXo2bV8uENkX9hxOENgQUcd?=
 =?us-ascii?Q?oi4BBYv55bhQCkC9Yp/xXrw6Kw9pI7oGDbGPhhj3YxUtHIJ4X+kxrulDVGN0?=
 =?us-ascii?Q?SctY/qFSq3VuHuewY68jnmWCaxZLxYcMGrXJRwMFqKKoGGpLWov4sBi/iL6l?=
 =?us-ascii?Q?2YPkV2uXCNzMzfzNcH/vqonMsPUM8MVDKUj4DVN+YoVzFaqlnz7LpjxPpAo5?=
 =?us-ascii?Q?wQsuFxIhrL/ZjrZhWHAKKA/yw+tugukHCHXV97Zn9BcLGzgS5b6xmv5Hu7i8?=
 =?us-ascii?Q?wdco4mEGlm8GOWGmVykAcq9NCeF745XFUcVNHat0MyAmXC6dh5cgw6n9YjoP?=
 =?us-ascii?Q?BOc6O9eBQiuOdU3jlzIx+PU/bqjk6hJgIaCngmkQ2PHBa3Ew4HS19FgtxFgF?=
 =?us-ascii?Q?JlWXziflQsiUoyHMZidmeB8V9EbWUo8r+Zl1Ly4f8Nhz2CeNvtNuIBiJQKj5?=
 =?us-ascii?Q?PG1SEff4feZPtzAfyOJhmCYNTfnd0yX0B9a8YExrBV+OtymMtpJe+I9fr9pQ?=
 =?us-ascii?Q?wQ11VCg6shlNZ8Hgyt6fe9Md+coP/15hxAcpsOEKI11nR17iijs/AcA6fREl?=
 =?us-ascii?Q?wrP3Mauvg/rUiQOY5Ob1Kg1bq6viuvzDb2A472xA59cGXXh2hrtwO3lUj72A?=
 =?us-ascii?Q?Ot8MCuGQP/cL7F4say1jXjPMkjo5VW7TdCqTIY7KeFc/GBfDnK6BIBT1MqkH?=
 =?us-ascii?Q?i/J71hT+PcfTLBusUnXbS1L/11L685FEzROV7Zdrn4mPK7g4eeU/QJoZr9eC?=
 =?us-ascii?Q?hhjUcL/mvRZHqsEhGGgAGHA/7ifYcpoZWyrUnAwpL7+4iZM/Ufa0za1gklc6?=
 =?us-ascii?Q?MRWS5cCPTbNa+AqwQLtHmd8gIBwIHKaTK80+WUPKZQnooAE3Nwk4GQjhPFmS?=
 =?us-ascii?Q?RwSAjd1a46ZUcWrZe5a9RhizLIrWTg0B3S6dmznoNh946Hjz8fUWnotzcYrZ?=
 =?us-ascii?Q?zGCEBM3Eg5lRJAhD4p1hjhi1c25M2In5NIUqSQBRbjZg8NqxU71ZRXl0kkIa?=
 =?us-ascii?Q?lQWII42gCF4CQ+2HEwEpQ8VhXc5ErzJ0cGmiDtY2FpmpCYHahPe4dvkhctdo?=
 =?us-ascii?Q?UcEik4nixwCmkPqCH2GlzjrJjCYnIohQTtUt0McLMAjpdVSF30U8OgWkSWBm?=
 =?us-ascii?Q?N3MTbB9T0r9GXJ05Wxg6RbPOb6jYqD3P3QNzlMupuCIitGrPZfqLv2McK96B?=
 =?us-ascii?Q?UCN9o0C4GDzMpEvCHQ9rD2b8oahEtwtZZsfQk0b6aO/pSYOofegyFH8agKwy?=
 =?us-ascii?Q?sve77vtqPOhwtkslANX3QN9L/oKl38yrzksUBt0tYz7L2GoJpxrcG2DiKykl?=
 =?us-ascii?Q?YX11oCLgAmWmGwqVRLPL1OUPOZ7fviMMruzs6UZRDbFw8Qz2mEfZpcWR5Ym6?=
 =?us-ascii?Q?YZRBrdfqv6cGvrDNMND2Kmt7YxJOdUbtiMyJi+lXOvOmKcDMl91K0q7y5z3c?=
 =?us-ascii?Q?gTdc/jwi+/2Q/5L7402+c4PIqQfetHtVqNE9oQMumVjCx3LEcqyaHoAwJp7C?=
 =?us-ascii?Q?wEQFh3bNndrdE7L3chWIxPFUIm5ZDEw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b515bbd-adb5-4f88-b155-08dec2a5bff3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:57:08.4547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kep27msrwBt8AjnnKDxrUMULRbqQ+ItJjY1ZXrO+yB/m8rGsFwoSEQc4t5g1kcqmF+CAYFQQAb5P4ywbsq/W9PjogW2gKohKr8LN4iab994=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Watchdog should be primed before longer, failure-prone steps such as
firewall, SDRAM or QSPI initialization so that if a hang occurs in one of
those steps, it is able to trigger a reset.

Switch from the legacy hw_watchdog_init() path to the driver-model WDT
(initr_watchdog()). This requires clocks and reset to be valid for
the L4 watchdog block, and so it must run after the clock manager
(uclass_get_device(UCLASS_CLK)) succeeds.

Enabling watchdog immediately after clock init keeps watchdog coverage as
early as possible.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v2)

Changes in v2:
- Commit message improvement

 arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index d803c13cdd9..1711688cecd 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -18,7 +18,7 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <watchdog.h>
+#include <wdt.h>
 #include <dm/uclass.h>
 
 u32 reset_flag(u32 flag)
@@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
 	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
 	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* Enable watchdog before initializing the HW */
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
-	hw_watchdog_init();
-#endif
-
 	/* ensure all processors are not released prior Linux boot */
 	writeq(0, CPU_RELEASE_ADDR);
 
@@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 #ifdef CONFIG_DEBUG_UART
 	socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
 	debug_uart_init();
-- 
2.43.7

