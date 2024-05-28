Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1108CC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E59288486;
	Tue, 28 May 2024 13:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hNAmiXqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 106A6884BB; Tue, 28 May 2024 13:13:50 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801DB884BE
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgV2qjcz3Z9dDoqB9JLexWaEDl22flQtJBkd8Y7c9BYESrmAdLUElwsLFz+pYbhFIP1k0KbwBSi8APuXaFMjZVaOctNWWXHkoMoMW/kJBbrDONIj24B2T12O7lRJGxFpJM9SpcbCbhHttcV5aO7zY2lebo2kfiRxQXz2s4jGJH7F/12TRAGJBRiCd1QkjyX/FE7KGIvTOMHU5R/SUWs2nxpEUO5oaaYfFjDCexeFXNjlarFLgNQfgqdVkDuv0bkfzRWeLUSemkFtYGjyT44RERw9ht8rWotDMvWMaS9W1VX59AZdZ34d7ezj+EZJ/ds2F+Pa4jX9DfyMG161Wg6/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGs0pY2M52i+3GoMY08PsBmS8cKqRtdL2adWWlDYOfM=;
 b=DvRXJW9eXz4RqthC+SKB34NwVx6DVQNRmEzCtOXkYXgt3MTnctBzRCdmT+5AyqSWKfq/jcToG3zl4CNYfiSNbZlUbzg+M84Uzuk6grQymBfX39wM7cLYv1MQbHWykN7SJu5CjwJ69zNAkvHLhXr+/XsxeZ5L3+ggummcRnBd7cFr6Oufvvqgoy8RYdx/hftHJn8CX5K6YRa8p1mK4XlKi9SEy0YjZonwwQpuoOF/4rD8Q9lE9XAFlpvcEFgHT8v6hRv8VHUcqb9qBtsKX6+vgpRN421DLnUxGHt7T8YgpDhh5b18Evh7YpHz/20rvAO5n/aHDjvsEhX7Lm5fmPfqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGs0pY2M52i+3GoMY08PsBmS8cKqRtdL2adWWlDYOfM=;
 b=hNAmiXqSDNbH699oVZ0XqJEn4+BVlKfrZ47a5/5OggzLNtW1JHkhd8LvpXWZvVm450JykOaxM8iDkZh+J7JaAt4/xPob6BsS9gvnLBGFVWiLrbpa9cjb/3b0dcB/B3Hn01jxKdIIvEod6xcbS0A3WvZaMOgTPYtk8i9ukTwCMS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:39 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 5/7] sh4: remove watchdog.c file
Date: Tue, 28 May 2024 13:13:23 +0200
Message-Id: <20240528111325.2163560-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: aca004bf-355a-43ca-beb8-08dc7f07399a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+7O4r5WJigvWHFOX7P89lgrguG56Pdg2RWZuS+/NVsvaphuEsKpKFM8RsNfD?=
 =?us-ascii?Q?baX5L9bmKNtqLWLrEmZuVSAfkqabey4Mj6rOdqDa+hrcJ/EkmP2b26qGLn76?=
 =?us-ascii?Q?IuGn0nL9xzWv18cD8izYlC0SuO13+2TKnAENxafRW5jUlxVGIsGIcyVdFIbK?=
 =?us-ascii?Q?xmw4VY9sxEPMINXxyc6Xht0iVooDUolVJJviV0Y+Kz+95THkBTQv4vpllRwu?=
 =?us-ascii?Q?RGbKJP307Ifh6SXrSHdd5mEbq3oGKQBqSu/aHrr+AZ8bSkBZkIQX+RkEDEl5?=
 =?us-ascii?Q?MrwggSKYhmCd3J4BiYT9jiOuBC3AoekBj9qd8cnutkKoQHc0RkDwMPigNsG4?=
 =?us-ascii?Q?oxLKt7b0c0TENDqehQoIaaVDP/g7A233itjnUAqD5yiWSLQEHDm68jQOuvlp?=
 =?us-ascii?Q?HvchKXRedPnZu0hMU9uqNLeEJOuc+PlFN38GjjP7srKySL40jETm/Jkhh5w/?=
 =?us-ascii?Q?zuHAyhRxT+6WaOW6nmjTafwobnduFjaI3HXk9BJt3J2guHHwB+B8313dOqDN?=
 =?us-ascii?Q?8Ur+DLkXMDjnr8RjT2gl8lKW+4GfgVyf/zdUGwy6Z6bepZU63b69PZf9LmTc?=
 =?us-ascii?Q?OBOeHBgRDuEjRAe2MKckpKaUF/cItPEvyNfepkQ1tr6R108UGllQKtpa/Jti?=
 =?us-ascii?Q?WD7Rc7pSwh3Okx0VNlZ6tXmPIlfJjzi3CgUeHWoRbG1HVtA4QcTKJbyOiF1d?=
 =?us-ascii?Q?P2Jkh3imO+U9aWKDR8PKA4snMYRn+wkgAKq995kQtBWsx0sGRJI5m1EaTqGn?=
 =?us-ascii?Q?ySNmxV5uaFhhaMuDfkH5m8z/lddwXV72bXzIcWjYIuS6Q0zshTokZz3W8H8f?=
 =?us-ascii?Q?Akqtt8KL3ZrvhsIevCHJT57gIncO8GbWYZvmrcLI54ScITWnyndIOG/2WLTD?=
 =?us-ascii?Q?ZLtYyEzHDf+361FpYTRT7qKuwx5CffLlJIcJWYNio9K4PrKoc6TH+rd6I0YQ?=
 =?us-ascii?Q?U3yOjKR9851h7WmhTf7PfCQtUtLjH3y7K1quu/DIVJVii/QcFZ3y0gwaRVik?=
 =?us-ascii?Q?FeXufEkutVBpgvF2Ocfm/Kvgdtmb8r9cuOcmDewaZdAYEZAQZ3+sZou0CtQ6?=
 =?us-ascii?Q?KRGqlb2IEZSomQQSGZlT8fvHGOkLqiMkCeZ+IrbN0/SiwsI6QpgIMEZ1MMJQ?=
 =?us-ascii?Q?kidkaFsowjb3TczUr78+Kir/C4JxdP95iiTcV5ljc11jUvipJAk8SMNrfqeN?=
 =?us-ascii?Q?eACbu75YSsSav6DF0cVkabAet8YrNVM0DXz5yuFZ9a7thz7uyBn1gJkN6U0P?=
 =?us-ascii?Q?0peLUWUG8oxe0t9FrRNoIPT6DBhXtGBPxiri7AKoeBnuEJE5zKmsvlWVFGaj?=
 =?us-ascii?Q?ML9nhzQCMiqghP0JAVyRbYs14spvzpgo+8W13wdKkjGOBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvRavIxcWDnJmsTJ+nxrjANnUTyUl4d6dij8kvLTFj5JwZc4qWOVg7C6rfTw?=
 =?us-ascii?Q?tbvrF7Rm1d8F7NsHv7xXN/Zn9GKViX3BVfT0AxPStsGTnUjlz5V2HD6AjgmF?=
 =?us-ascii?Q?MxQshHK9NCZj6UFIy9sZXrOmBD1BLXSxqT4+1h6lqLgRzCAzgQ0FBLNoN/ZR?=
 =?us-ascii?Q?8138CcO73mz/eqKNQ5dYlAk52T03mfPaqNAMr6Vvo91k90UvvbxszGef2zva?=
 =?us-ascii?Q?rJY4BNSY4NOF5u6Srx84MY3/LopSRPtiNcpSMYLiqMOyBHDBtj2yhFeBuidx?=
 =?us-ascii?Q?npoysM+B6K7dBpV6NE0lygfuzSJyEhMtZYTlT3iaCrcCL8+8I+yM6YdZRafh?=
 =?us-ascii?Q?1gZ7LZXTZ+XRJOEPd5+h0uAsgTLnIo+R5MK2DOCfw+8z9G/siqjlDHkBgmP1?=
 =?us-ascii?Q?UU672ImbnXGbt/R3WrKOhNTrBkk3qi/Rl0rFAFJ+8qMlA+3u9PDOK00wzFun?=
 =?us-ascii?Q?mC8nU7cxGzm0ZsydDakNNK5bXrrCNpUu8eAxONZwrF5/froOE/UVsaEJ4d3M?=
 =?us-ascii?Q?4C9cwgtNVdq+5aKa/8G9vEY3UeP7Ok4R1hEE3Mm80PMRVfsgWJAPz+IkxE34?=
 =?us-ascii?Q?1tBvFR5nzWQkbqRV9w3UK5tIXKMYNwpBtaXjq2W9arMfHAcVjxIIEzEaTJiM?=
 =?us-ascii?Q?Bn3ndqUaxuKMHXqrdZHgK5MSSiKFrtnomY0/Z1bxNngd3+ID92m1aLs3aVQa?=
 =?us-ascii?Q?etMqPD3/DQy5ImBfL2/B59cAaI5OwMZEkCP2Et4iRLgtNwNJ3Y2XBDCGljVX?=
 =?us-ascii?Q?RkZNWg1jXFFwwU7Y8iOZu0kBiKaf/fgHK/HdhK1brQdBLMoQetItwkxwXwcn?=
 =?us-ascii?Q?JSlHZABFaqLR4FdFOVRzc4Fsc8DFbJo3vx7qnhPyNXY0/jfyVkeN2ATtVxkw?=
 =?us-ascii?Q?F8uTh13d2kCSRUobQ9ZvRffEjVAh82b8BZiGhhwCCmj9/snJhb8Iu8bjhmqV?=
 =?us-ascii?Q?AfRwdiYs5jW7YRZp+GhPw80aP/fi0JhMKZSzFMtfYT3MKDts5CGGJ6m5hunq?=
 =?us-ascii?Q?jG9KvRUQZkOdeTag9QklJXUjq+xmcS3V3l6Gm+5iCIcwvy+HQqbY1c++r1lj?=
 =?us-ascii?Q?FgR1i/d3AbrSlWZcp2dIvgsfwbmarVD0I7YjVYmp0T5c89SUH3jqXKuHRnrf?=
 =?us-ascii?Q?NctwBLEtOHXqk+ZJT8qpjq9gKiY6y1xvCinit3Y3IRqHWtX9m3fTVwk8BHTY?=
 =?us-ascii?Q?/+dqkJAvnfQQt43jpfU02khxYNqpxjOh/GNyzcs5mD0rDP+4bnQdGrwuq9a8?=
 =?us-ascii?Q?/TrhHfj4VB2N113MYayW2Gf+4n35QLOzSA+jTX8mqn/824GS9Ln4sQzkJDQ4?=
 =?us-ascii?Q?idcPl7hJxdO/qloqjN/IZCh+V02PSCqOv/aruH5JnLt+TmAkwAJQSU8SqHYM?=
 =?us-ascii?Q?C9cwrgzAr3ntncrxaqDqv+j/c6QZe7MLVazsHtVDyc8UyWiKiAW9KDIyh6Bt?=
 =?us-ascii?Q?seRTY/KDIo30RDvYkwYJl8bOsbOCGSwXVH/0+UZlN68piY9AN+urUAIThaJF?=
 =?us-ascii?Q?2oLRDs97Xv+MI+JkYLEMSngu1dlbYWTGbprIF0gA1ZWnQGdyEVdkvTiwJi9Y?=
 =?us-ascii?Q?YWxYy/qOcEiiCkY4poOYTFPbGxes5An/Zs3Awp9nspCKayGjKe4lDvJzUnen?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: aca004bf-355a-43ca-beb8-08dc7f07399a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:38.9433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmROo4AC2mTaVhj0Y/zvSQQmDHBEzEHVUuVAnna71UbIZXUxf/hiZKdHKYwfhhhQjOSvdkHO0fCspvfbix2rnOs6XjsO/ZylcHAIHNPuH+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
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

The external functions defined here are not called from anywhere. So
they, and consequently the whole file, can be dropped.

Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/sh/cpu/sh4/Makefile   |  2 +-
 arch/sh/cpu/sh4/watchdog.c | 52 --------------------------------------
 2 files changed, 1 insertion(+), 53 deletions(-)
 delete mode 100644 arch/sh/cpu/sh4/watchdog.c

diff --git a/arch/sh/cpu/sh4/Makefile b/arch/sh/cpu/sh4/Makefile
index 7403a2c3047..6d7e05ebc29 100644
--- a/arch/sh/cpu/sh4/Makefile
+++ b/arch/sh/cpu/sh4/Makefile
@@ -6,4 +6,4 @@
 # (C) Copyright 2007
 # Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 
-obj-y	= cpu.o interrupts.o watchdog.o cache.o
+obj-y	= cpu.o interrupts.o cache.o
diff --git a/arch/sh/cpu/sh4/watchdog.c b/arch/sh/cpu/sh4/watchdog.c
deleted file mode 100644
index a891333392f..00000000000
--- a/arch/sh/cpu/sh4/watchdog.c
+++ /dev/null
@@ -1,52 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <common.h>
-#include <cpu_func.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/io.h>
-
-#define WDT_BASE	WTCNT
-
-#define WDT_WD		(1 << 6)
-#define WDT_RST_P	(0)
-#define WDT_RST_M	(1 << 5)
-#define WDT_ENABLE	(1 << 7)
-
-#if defined(CONFIG_WATCHDOG)
-static unsigned char csr_read(void)
-{
-	return inb(WDT_BASE + 0x04);
-}
-
-static void cnt_write(unsigned char value)
-{
-	outl((unsigned short)value | 0x5A00, WDT_BASE + 0x00);
-}
-
-static void csr_write(unsigned char value)
-{
-	outl((unsigned short)value | 0xA500, WDT_BASE + 0x04);
-}
-
-void watchdog_reset(void)
-{
-	outl(0x55000000, WDT_BASE + 0x08);
-}
-
-int watchdog_init(void)
-{
-	/* Set overflow time*/
-	cnt_write(0);
-	/* Power on reset */
-	csr_write(WDT_WD|WDT_RST_P|WDT_ENABLE);
-
-	return 0;
-}
-
-int watchdog_disable(void)
-{
-	csr_write(csr_read() & ~WDT_ENABLE);
-	return 0;
-}
-#endif
-- 
2.40.1.1.g1c60b9335d

