Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F1D63920
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EC18964F;
	Wed, 20 Nov 2024 11:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="wC3dvF0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5108964F; Wed, 20 Nov 2024 11:39:54 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EC6895F2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTJiwrLB5/nQp5MtECc6hJsvJU59xbXgtxSV0AMQ1CxVwgGGnBRT0mmthNP9B+/jerX1ETYzlCeuq4SJso72VRj072xMnV5wflJSfkaSj4yY7ZHm899oe3lozcQw3CWvQk73SBIMjxvQOO0tvDy8Ogeb84n0UOitSmpqGYYeebaerBYp6mrja4t0ePPW8w9WvmmojNEZRndJCsViVeQ8UPg6wP+cVSMtJkYlUazJ8y33ZlXjUVtG4gZeKD22pZ/xdkuJvxXwhg+sPbicEaGs2miYBEHPWrvuncd8rYr/tu6Scbge7VQDo83zeAW2IUKfIO/ebQmqM6S41CzSoGb2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o76ATIlroR89Sd2379vfHghiJ0Obq/I5lNMv/7PQn8I=;
 b=x2cWsngNPIgnmDoNBl0oqIOLXbjr3HZffgiTuE04BUg6VzmqY4Z2aHdp5v/WJgg65c2sk6Fe1ANbNelmnshFoguqnOgPkfLezc7nybkj6d9TL/UlpgEmCmCJLpS1yHSYKv1/3e2WDWdhv/iDONbW1fZasFuCE2m0+vsqPKcvXA/8I5OHFFJfJekUBRw9UlHnvZXt+YITHPGcUHoyUEuRNpGL/7386Dj/6D0fx/hfghWpt64PwmhyqEnvRY45Znn6JkjFNeVt/k6g1KfthW/S38Xm9q8kv1m1l/H/3l5AgYLbelGwsKDr28Q0Ag4VKWFYlK5xv5lopKB85R/2GeyeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o76ATIlroR89Sd2379vfHghiJ0Obq/I5lNMv/7PQn8I=;
 b=wC3dvF0nEeGsIxWOk0VyL92Kd3z257mtwVJ6RQFp1jlTgrdEpfVKNYwQWeCKphGGBkqyD3IhtAX7PaBnY13U9HuZ7RGCjLw7Gxh39Dww4axl48lZPbCqdII66trL6zTUB1q4vDwJlEsSiKg9Hv6t7SEldIYR9ZEi1S34SOjdYf6jzoae2gsng2ROdo1KxbFHQ2/OBEN8XTQEDVbA4EM3CFqGICSCyn+gHmqwocYUaXKn09LcLONPVTsE7aTl+DH3EIzGs3zk9UsQrbHQ0ybjuh5qdWR1b5kFAmWjiR12MfJGE6mkDJdUihsgY/B5wGbXzTKAc9GzFJh7Tzywqr1fHg==
Received: from PA7P264CA0228.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:372::10)
 by PASP264MB5647.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:499::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Wed, 20 Nov
 2024 10:39:49 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372:cafe::14) by PA7P264CA0228.outlook.office365.com
 (2603:10a6:102:372::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 10:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:39:49 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 468A01FE72;
 Wed, 20 Nov 2024 11:39:49 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/1] arch: x86: lib: Add support of legacy 64-bit entry point
 at 0x200
Date: Wed, 20 Nov 2024 11:39:43 +0100
Message-ID: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PASP264MB5647:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4cbceee2-6d98-4f45-1b2c-08dd094fa8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1Hkyv+s9HDBnWGX1EdGNpS21YsyL81P09c56BgKAVf0oLmnS09j+zbcl7Fr?=
 =?us-ascii?Q?r+ttgW4mLOed4xOWKuaiWxust85L7pr/BfSR8Fdt6MmwYdM4cJkoF9HkatiE?=
 =?us-ascii?Q?f/reZKEEHu8L8c1r+uel+r05lNwsTHbIdJ+egNYnx17NeDDbbi9iQ6zX/1HG?=
 =?us-ascii?Q?lZB/VV0ghvBVcl+SAF11ijnP8pEO8ECwO6Yn7/shW+k5B/oTribd+Omqtrfj?=
 =?us-ascii?Q?8bb5NXulyL+HYqAPH1OINBJfZGJzBWAZYnW0OlDTzBhOuHUCDOTgEiQo4puQ?=
 =?us-ascii?Q?Z/4hdCZHPck4ZCRfjRo4JFfkNSTWbYwy7AaDek+BIojOSidm+BiOvXx9pNyo?=
 =?us-ascii?Q?7a03903wpOoEwD576bvHV0M8XYQS/eLSwMkWpWufEeGJL9y7I0Lw9f1M1m87?=
 =?us-ascii?Q?g9nMPfRqW5pC141RjFzMMXAFhdFTp7idSx14peUXAhCfgre8d3XyvjQafFaT?=
 =?us-ascii?Q?tAPsbWA+xEDsIHtSHyYmsfGkJeN0p0W86zq3JPpahqubbylo9bsR8UAwDwvw?=
 =?us-ascii?Q?IabOb4O4o5Y9NGETWpkhiFocm8TRPlKLFsG5wOpNwq3xcuDJY9huUDYdycjY?=
 =?us-ascii?Q?eI33MosQDcU5eGST+5ISmE+cWjPtktZyOgIVry87C9Na/rKFOgdsTGXalORt?=
 =?us-ascii?Q?XlnZEe5s4GzAVb5zrb0fiYGtp9a+8fGcSD4tpFWUwbZ9Rc2T6IYvOEVsu22S?=
 =?us-ascii?Q?gZzB0fURkKFeierigFM/v+G8AdDZWmFtchwkOqBfkLHZexFo0Nj+qDk2ej1I?=
 =?us-ascii?Q?4gMhe++bK6B2SK/JIMO0DNv2hFP7aiCoTDm7SwK8Xuw3plyOUYYafZzpHVdz?=
 =?us-ascii?Q?e1JSBjx7VqIj9lrx+Tau2r5z0c4IQpiI9ZdreIi+ui7ND5bIa/w1a4m5PqhP?=
 =?us-ascii?Q?aZVo7JA+YWdnZtustzAt7pBS2Znry1L0mUPyazhe01TgluksilBzvS2qe0xe?=
 =?us-ascii?Q?gFOluMTqjlPoMHJOWjmB2fbZbYQEpmX7gmu5yiK2IOnIhdnQWciPZeWjxIW/?=
 =?us-ascii?Q?kWKY9XyGLbhDqUkwTeMsk8uJeF4MY/anf0Mu70FRprkT+y09IqitF9Fx5eWw?=
 =?us-ascii?Q?VoHFKjs4VHiOmZezIwVnLTLjmWSErJfeKk/6N23cyAbTshAz/0WDGj7yZakW?=
 =?us-ascii?Q?crL7/R/pnmCPT5ifj8eioj6tsetD4jVueEY6+W3jak4EvZMJG6Dn4CeswOJw?=
 =?us-ascii?Q?5hiQcPJxnkkfGw+EL626zLhpP6YSf03xItMr19gtL7eWpD1moeHt9XvsjAKd?=
 =?us-ascii?Q?Wuokye8+Nk1yOHsLlfUyC6sr97/Sos8bghrfDiyMB4n0RzGQTfTWht4TVXtA?=
 =?us-ascii?Q?9k62UJMUvw/87ImdS3hURlSLhb2JnWrdyaBypzfYUxhQzQC17Yz/LhL2cxla?=
 =?us-ascii?Q?JJSGZZRHoc5wNByi2WuVkNLB+T/Zbq+6A6+PE7pQqpePu7BetQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:39:49.6663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbceee2-6d98-4f45-1b2c-08dd094fa8e5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5647
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

Support of legacy 64-bit entry point was already present when booting a bzimage
with 'zboot' but not supported with 'bootm' when the x86_64 Linux kernel is
embedded in a FIT image.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 arch/x86/lib/bootm.c  | 6 ++++++
 arch/x86/lib/zimage.c | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 55f581836d..38b4ebf759 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -189,6 +189,12 @@ int boot_linux_kernel(ulong setup_base, ulong entry, bool image_64bit)
 		if (CONFIG_IS_ENABLED(X86_64)) {
 			typedef void (*h_func)(ulong zero, ulong setup);
 			h_func func;
+			struct setup_header *hdr = &(((struct boot_params *)(setup_base))->hdr);
+
+			/* Handle kernel with legacy 64-bit entry point at 0x200 */
+			if (hdr->xloadflags & XLF_KERNEL_64) {
+				entry += 0x200;
+			}
 
 			/* jump to Linux with rdi=0, rsi=setup_base */
 			func = (h_func)entry;
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 73a21bc8f0..2eece34a07 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -426,7 +426,6 @@ int zboot_go(void)
 	image_64bit = false;
 	if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
 	    (hdr->xloadflags & XLF_KERNEL_64)) {
-		entry += 0x200;
 		image_64bit = true;
 	}
 
-- 
2.43.0

