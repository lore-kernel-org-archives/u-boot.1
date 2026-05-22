Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF71CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141DE848CF;
	Fri, 22 May 2026 23:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bmIn1cJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33723848CE; Fri, 22 May 2026 23:28:07 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F45848BF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq1iHOqBtZF8aEjqDWDVBim37kHP5tyEyWBd6svXiq9D2BQN+bZ5TcM4Ym4VRTkKpKshvdYedc52J4k/W1Gmr2+8s9zCnKRS7cvtTnnn1KjPVhPh8mChT/lAm3bKeM5sf2WQYQiY/pFhgfJKOPqOXVPbDIQ4/Tw26wIKpLx0nELI6QkjNKoyzDOT38pDHXwhUAdwEtxQ/gjta8r4wdrn5kZWMueK881jgVBr4g7V1TgmOuLCw9mdj8GBRj9fKkVjskQ8WEgm3D1KeWxAdX6YnLghlwaeIux6RB9/RbxiEo+4stdGc69ZDhVG95hKsVxOQuMjVo0V15iZkLzKnHs+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yyhQfZOrKnZU5G/tqNvLxBqbyG7MMf/0/5LR/El/NY=;
 b=JvEIArL8StKoCCgr4Ytl0/4pkKTKLJCACwwfkC+5PsR0G9xNJree26XokDV83sBnGZ8nNA2ritc3zE+Jgrei81KVXryyIlvTmm6g+22qJ7iOXofj/7SVlP6haWpQezWT5oJ72M4a+rO0eWxf862EHUHojM1lSSuyv4TlnOnj1NegmQABd0gnyR9ptWvDfH8iTlNW7IaV1+QgXhZNdK8HtnM2eHEAeFGef+CAx50bNtj8cbIx0OgAxlbwqVzX6qunaXodjhbcnH1G4N0Ew9aq5j80ysuC9lJ1LBPomFUR8IZvtHsNoyBo+JIspALZXBZ3cPeUgpHcyH/ZxwrCFawBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yyhQfZOrKnZU5G/tqNvLxBqbyG7MMf/0/5LR/El/NY=;
 b=bmIn1cJhdcq8CsJtuJWK7UMY8u6vLTDLrf+UEioLoSzBPJshQIGitpsfxKw6mGhfDvvjFk1rEkIMVcS0x5XzRgGK6krROKLDpJG0eGGjCf8lGoiXOmqXAB7K0vkz8y/+HgI/VATHKmC1IYCLs88tEhYUTN7R50hoYc86NQpTEGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 1/9] sandbox: Drop special link order treatment of start.o
 and sdl.o
Date: Fri, 22 May 2026 23:27:48 +0200
Message-ID: <20260522212756.3169222-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0416.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 041163c6-cad8-4865-e2e3-08deb84900e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|3023799007|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: pUrpj0QONNzYxI5t8/s9arJa8z4kWV8i+NKms5crpDqlOnxIdMxGL3O5f7RX8Q1g3RHXn7F0IqpQL6IjbYCfYE6bVusHQ5bsJsLeTUXUimj/dpfq9pFaq4PnbUue2ligWDhswiMlwcbGAlp+KtL3EnPBc/7ShOvizQvJZs3lz0MXG/XKNqA+52LE3UESjE2iMU6gOhw7kXJUPGFgteIuu9lomB03FStkYxaIsa+2/65es4iLLQvGcoD1KgTDYFWnUBALhHLFk/zsJFChjikz27d5vHbtV0Zxklz+ji/TYX/xQA0IJlbYNSxv+DbEUjvQaKjgP7D3RcnEYCtSS1iJGWOJgDGJrMi8Gan01t3Yvr+Y8+UGH9nDX4B2qPTOaUbWlQDedg11+4Lb+mZwG5tqyL7S4Jh0uzqfY9NlhM0cWmnHzPLqJGN1SdWqP3HeFxcmCMAmnlC7mjGXqXR+XL80coqpl9DctwFqaYz5jXsA0ysKu56yJZhqS8g4NNFZhEssJsO3t0KNwNywfRJ9PKCixYoBcGMUHIBI2FduYjIaTJ3nHgqpiLeZvbVG3+/UkymlHvbbrX5TzaUI0yBR6pgQnyQa3JDy0ZArIbIMfoRxE1F3625815n1BMCywh1i+eFeul0vIXVNGRvt5sNjtAapurrZ5CLE8yWyCiJrnQZW/B2209p4IeYaV2mA64wdORvGJHG8aXGumoxdjzPUY2wF3To4WqwCMDrGONM0bazHHZAzX33vA2ndyvQFO6e5QmLS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSHXcCwbuY282e4vmAWa60yYupRwNOAAhGqwXzxCMfnn/Ui3dqVvJQ4HxQnw?=
 =?us-ascii?Q?uamTSK5AMvbFmJzqO2ZZNiLi/pz9SikVnwyhXvCkrY9aQE1GLvbJdFkVQTvb?=
 =?us-ascii?Q?7HAl3ZTfub01gbekist8tV9kwlR+QYNe6GY1sjkOBlYNb9Bitt3ygqsQZVzF?=
 =?us-ascii?Q?NID85lAl04IGyUOLC6oaqTf2zbTGDnU+GT5gNDEpTinI7o/C2jch63iULmIU?=
 =?us-ascii?Q?Lm1Xxrhpl62OqZzF/Zx43jGbtjCeaw5g/OHCjKZS8v4CvWCvHH8fnLaT9sAc?=
 =?us-ascii?Q?BaatPqAT3cy3lGwcazGmRK4uQJl0zOu7Ot13OrA+OfSIY1QoH3lM/D4OwodJ?=
 =?us-ascii?Q?3ngRJssaqCql93Bi3ftVGlJVKBJ4gDNCuWw7U8entC39n9R/u6myOdP3/CrX?=
 =?us-ascii?Q?xJOI99gzN4ixJmGaOZ/P9FQJFS6fr5EpW2r20cCFUe3swCPfJQ0oEYgOeEBo?=
 =?us-ascii?Q?QX9Zzvo6uWRkgrTDUAiLdsKi7Z/NSiAwgIL8PznJapI0xWSpf1JlF/szeuHa?=
 =?us-ascii?Q?5qPV9N4JT3qIlGIviKKOLRnRowtEK2pf2ywcbIM6+b7NqyRwxoAmhrfkUlBx?=
 =?us-ascii?Q?VnWiHFMAHffxQp89te6JERDZeDgwJSryHSaupu+kXIOTZnqY8icSAsVYmwyw?=
 =?us-ascii?Q?Nl3bvIqW7MA8I9rUr9y6Eu5YfwqhjEXSt2GONyAy4uXwfYa0lhmsz+vKASRc?=
 =?us-ascii?Q?MKjRVLBhb0BKfgq6D7t6Wpytc70MGxrdetUjRLz9BpPXiHKwTemA1GlYpR8h?=
 =?us-ascii?Q?x2hdscj7WD8BHXt1d/ttpaeWjTxneTmJZWFxTALMjrGcqAV//YRoBWv/AcWq?=
 =?us-ascii?Q?ttfzNNU+3YGzapyxGUOtGtQkthOJTX2bXaUBTeCDf/zf+lAUBGxevcJJ/6wc?=
 =?us-ascii?Q?niOa0LBiDr6372rblMr4svOk4fywp3PeSl1EP7TU49im5V8O6rA/AA2e1yLF?=
 =?us-ascii?Q?0AIro7L8OiJ4xXnAtGXZLtD+jkonuw82U5pPnlTNZsvTULX5ZU+hYT7u0j4Y?=
 =?us-ascii?Q?u7FRry0fIuO/wqkrVVk+9++/aE6bYAeCTTTZd4+QOUQ8w/O82RlKEQmBcsMv?=
 =?us-ascii?Q?joKMiaSQZi7hxgoZWVdU2H/ElR/E1TwBiCDWwpRViGpal/VFUIzGAbAVytuP?=
 =?us-ascii?Q?yPeUvURAL/2excB5B0hM+cY4OemD8Dn0gjYg/fECLixeWNc0aFUW+XHyh24v?=
 =?us-ascii?Q?z3i+lWfLoudbRFhMY/1s+seRp2svtHg/YBJQmGvNE6oP13mpqe7xAN/PqT0U?=
 =?us-ascii?Q?U1YTTUPZq9EnnzbogFZXOU+yM9pIT/vaeC2nBSZRK2iYwwPBy1Wwtq2OQKc/?=
 =?us-ascii?Q?rhl62wOTCHNUvwlFeUom9UsLZbFjrLjDO2FnD98VnUkiVMDSi2M8xMQVa0QK?=
 =?us-ascii?Q?4TEAx5FL6AfLNWj+UoxKkmdK9odZb91cMw0apxi4ToPspADcGej3IwBXb4lw?=
 =?us-ascii?Q?iqeO/X/OUsfMWxx8rkNbXLEo/1UTjCFuE6H5OG/SI0XIE2yNqoJen/2XuZ2h?=
 =?us-ascii?Q?e/eJ0FewVW5ct9fC/LFnWJ4Hb7HGFCgrLs0+9Dm9L3tZtKzlMPqtSV75QDau?=
 =?us-ascii?Q?z/x86M5vCz1MZFK5osK2NM+aN356dFpaiviVILrcftNfGyi7z3CTEOOe93Jx?=
 =?us-ascii?Q?PB4jjOPKlfgR1N7RbyVnNv7CQz896hm6HjcKtnzZbeZMqthKcQZ+znsESlRA?=
 =?us-ascii?Q?P1Mq8Tc+GAKcrIM8ZJqG8Z4rqJpjWNh+lAnHsXC+N1Peb4LMZS1IVOLgvHCp?=
 =?us-ascii?Q?bj27tpgnQJXuQcVqSJqSfMzdKP2V5E4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 041163c6-cad8-4865-e2e3-08deb84900e3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:02.1758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGhDmus8s7MuEwOShoH/ou8/Leum7DHCvj8Mm6k6JcXmqj8vpGqX3P6/gIU7rvZc1ONACei2PLBLWqtAiajXl6FeCZ6wk44tV+N6PJbLVy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

From: Tom Rini <trini@konsulko.com>

On hardware architectures, we need to treat start.o (generated from
start.S) very special due to the constraints of being a program running
on hardware in an unknown state. These objects are treated a little
different than the rest by the linker and linker scripts on various
architectures.

Sandbox is different, and doesn't need to do that. In fact, it can lead
to hard to diagnose problems because of just how subtly different the
treatment is. For example, the comment about LTO in include/event.h
introduced with commit 87a5d1b5d012 ("event: Add basic support for
events") was only a sandbox issue because of the event in start.c and
in turn linking start.o isn't treated the same way as an archive with
all its sections considered.

Correct all of this by removing the "head-" lines for cpu.o and sdl.o
from arch/sandbox/Makefile (and unused cmd_cc_sdl.o lines) and change
arch/sandbox/cpu/Makefile to treating them both with "obj-" and not
"extra-".

Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/sandbox/Makefile     | 9 ---------
 arch/sandbox/cpu/Makefile | 5 ++---
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/sandbox/Makefile b/arch/sandbox/Makefile
index 5bbf9f1f96b..0360d2bd886 100644
--- a/arch/sandbox/Makefile
+++ b/arch/sandbox/Makefile
@@ -1,13 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-head-y := arch/sandbox/cpu/start.o
-head-$(CONFIG_SANDBOX_SDL) += arch/sandbox/cpu/sdl.o
 libs-y += arch/sandbox/cpu/
 libs-y += arch/sandbox/lib/
-
-# sdl.c fails to compile with -fshort-wchar using musl.
-cmd_cc_sdl.o = $(CC) $(filter-out -nostdinc -fshort-wchar, \
-	$(patsubst -I%,-idirafter%,$(c_flags))) -fno-lto -c -o $@ $<
-
-$(obj)/sdl.o: $(src)/sdl.c FORCE
-	$(call if_changed_dep,cc_sdl.o)
diff --git a/arch/sandbox/cpu/Makefile b/arch/sandbox/cpu/Makefile
index ee3c04c49e1..eb6bf6302e2 100644
--- a/arch/sandbox/cpu/Makefile
+++ b/arch/sandbox/cpu/Makefile
@@ -5,9 +5,8 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y	:= cache.o cpu.o state.o initjmp.o os.o
-extra-y	:= start.o
-extra-$(CONFIG_SANDBOX_SDL)    += sdl.o
+obj-y	:= start.o cache.o cpu.o state.o initjmp.o os.o
+obj-$(CONFIG_SANDBOX_SDL)    += sdl.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_ETH_SANDBOX_RAW)	+= eth-raw-os.o
 
-- 
2.54.0

