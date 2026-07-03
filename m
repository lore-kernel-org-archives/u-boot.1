Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE0FC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 10:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166DB849BA;
	Fri,  3 Jul 2026 12:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Cv57ebSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BDC84987; Fri,  3 Jul 2026 12:13:05 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F29848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdiQVSzGZRHNLKc95p4qUpbXha5EOeQA24VuFKJyGZY28urREOvQRQ7HSrJJzLndC+d1pyOuuFxpMomaQWnYeDC8cqLpK0dSKyMSHGbwQsYFfl7JoSW8fRDOOi8gDrLEgRINmmvM/wcTJd4hZg4W7ABbhYhawCcOLF2P88rB+i7OpnGnaidYzmpyA8nObYFY81m39RxXQ40EpMH81RIZ3n4/DNerZNn6538sQ7yfsgD2ziGGK/Kdu7+Jcnr6XpkpULiP9Ds/TiRu+LmqveRwT0jRmzfhFs1qvhVgS0Zyz31oiLsL4mnTzUeSJizVyoeIyTl7QSHczs6k3QFgWmY5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpbOHyVmlngkWtRQUMrsXdlPcYSS9wvnVXSKJ4m/9R8=;
 b=VPuy6B6iKekwXSRO7TOZyr5gebxZrBy9ekkv9i2WCuYxmUVnHtn9EWJmGgBmev1Gv8rgCurOAIvFjW30+hElug5gUiZBbe51lBMLL+5EjkRzTbjWrVQAZKka/v6e4h16uQYJe9/0OrFNwe3zFzparc4d9hrlO4eGFjduMmxkGPNSRchQTL83LGLLkXlmupov+Fecf0/MQ2fyekM9xXzOTOhZ5tcNhNnc9Z7TL0BxHdce8PjOeV6dvSc8+2hsvOG92EsIEbqMV/6fI5DYyHEbScI/P03WsZu3J2P6l8tNg+tzdFwYCdJX6n0zNPe0uFqWzmiDO04AKcbzfQKMqaM4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpbOHyVmlngkWtRQUMrsXdlPcYSS9wvnVXSKJ4m/9R8=;
 b=Cv57ebSXvd/+IGlhrxL/3pwZG5/kz2nMK/BTkZEb9cczQx6Xq4salEj72RH99g3kcHzvo8IGFeni+8ef6MQGYUHV5cxZjMjAMfrlIwE/Gr2mfq3EgpaWFdaCBXTwRMO2YCjtVxbiAuhmw4EsHaN73cR2xAlwZL20NMudgaSjCUDiI5e5ELafbUc2RqKvxX9NmNwp5sa2OWZvlKKzuKo170wEbyG3SFf27sx2aKVCLQUGBDECuO7vGuZRb/mR10bAsZ1i3GOKMv+DfuWYC8vGd54HaznpJajgkjl5skhipYPif301+yGKXj4kIryA5JrXs1NOuF4Tpg84z8aOtI8N5w==
Received: from DU7P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::26)
 by AS8PR10MB5829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:12:59 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::73) by DU7P191CA0016.outlook.office365.com
 (2603:10a6:10:54e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 10:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 10:12:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:17:41 +0200
Received: from localhost (10.252.26.28) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:12:54 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 3 Jul 2026 12:12:45 +0200
Subject: [PATCH v2 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-optimize_cyclic_run-v2-2-81762cff0b17@foss.st.com>
References: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
In-Reply-To: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.252.26.28]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|AS8PR10MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaec862-5f89-49a7-9b3e-08ded8eba69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: DVIGphO4ZQpALYSCMlY1B8BF9VvJ8kl1IuyeVv37KIBzeyngi6ZjIbA9qeoC5mAH5iWVr1N+bBVa+oXuu6Z2bD0ZKIL/fX0g7KyKkdjU5/uPjpZmYrHshUndyrXVr5/NhM5K+OwhZOr+E1I6tIesW5sxyLg5qFRA5YFzvFgTUhSAmMXIx3AjCwKx8nDrT0T0pZw2ySH57manr05xel34yruWhddgR6DB0Vk+EHZY9xn0ZQwVKtHjtc/+2t80G6TlgtbZsr3opUW+R5JaBpUaZ3V6dKzdP2S+8zIYAOfCCQcPbmjZhYdUJ/G7GuhCnX00GeFluAx1YeFxQXUw3xulO9pwWbTFJSpL6AH7eDWAN9GnludqmHDWPa0NLmDDmyPF8rPNMvH+/lIwfmEGfPl0bjn+C9/0jeygyQzIXniTnny2mgEOht8XDxkp/clyIpGFcWFtcs4dw6n99dtqtwqsUN9/DUSSZ5bJP3PrHxAa38eO8h/WTXjurWxrY04tooThapXUK2vVR0nkrs/le/ieASmbMeH6BHT2xWwaPpgXbYOeNYgPblxTWRy635y20ESuZok6EQHm7ClJB2FBj4cpYGvZyfglLFz1+cgiNqPRpvc5U2Y4X312Xcsin2juOETEGPy2qGEZblTh1QvcJ1YsTClXitaPcqHerBKVvQ3LKg33bQWK2PMGqKF+S3mHkQyI4xzTEFh5u3Hu3kXnAg/1Hw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HDRyMf7KaQjWjcGnc/f9XRWH68qzumfY2BdVncye20L6DjEZi8We+1Ix7yQeF9CpWW2wwx2TsbDvudeqgvH9/b5mm4AkafWtWDd76GPUvDnw7Q9c+gUo+uVWYkfspBulCLKMMpLfhGlfcjc3NYOunksN+86Ee+AaKtJIOF7+3PKQ8LMmTAgMbDkLyTMzNt/fIQ5axsiobMd682hClXj9usJ8in7x74I+mo+5N+ZQMUiGVTxstAnEDRPBXZVEIt5KVdPe/dePJuXq6qrCWPiBpTaH2yD7R/PyUMglI9GBFAgiNTcZEiWDGAtj5bPU4oEkwkZlg+Lf3gP/Sl3jsKWbbusEtE63B42kbfKxTeL1/q2BhX3Uzo9j8rdReGtFctoNNLZRK0u9amj8RC9WMiPOpnSPM98aVE/vfe0KMc8eSLgz8GaYc6g/AU+UpLnK+l5K
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:12:55.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaec862-5f89-49a7-9b3e-08ded8eba69b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5829
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

On STM32MP157C-DK2, when using the "ums" command, in sleep_thread(),
ctrlc() is called every ~640ms which doesn't allows high reactivity when
user press CTRL+C in U-Boot console.

In sleep_thread() loop, ctrlc() is called every 200000 iterations.
But schedule is called on each loop iteration.

Optimize cyclic_run() in order to parse the cyclic list only is the
next cyclic to run is due.
During cyclic list parsing, save the nearest cyclic timestamp, which
allows to exit from next cyclic_run() call if no cyclic will be executed.

This allow to save computation time :
  _ before : ctrlc() is called every ~640ms
  _ after  : ctrlc() is called every ~230ms

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 common/cyclic.c                   | 16 ++++++++++++++++
 include/asm-generic/global_data.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index b37cd6d8ff0..10ea0711ba1 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -68,11 +68,17 @@ static void cyclic_run(void)
 	struct cyclic_info *cyclic;
 	struct hlist_node *tmp;
 	u64 now, cpu_time;
+	u64 next_call = UINT64_MAX;
 
 	/* Prevent recursion */
 	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
 		return;
 
+	/* check if the next cyclic function's timestamp is reached */
+	now = get_timer_us(0);
+	if (time_after_eq64(gd->next_cyclic_call, now))
+		return;
+
 	gd->flags |= GD_FLG_CYCLIC_RUNNING;
 	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
 		/*
@@ -102,7 +108,17 @@ static void cyclic_run(void)
 				cyclic->already_warned = true;
 			}
 		}
+		if (next_call > cyclic->next_call) {
+			next_call = cyclic->next_call;
+			/* move this cyclic to list's head */
+			hlist_del(&cyclic->list);
+			hlist_add_head(&cyclic->list, cyclic_get_list());
+		}
 	}
+
+	if (next_call != UINT64_MAX)
+		gd->next_cyclic_call = next_call;
+
 	gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
 }
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a966..25e488d7020 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -441,6 +441,10 @@ struct global_data {
 	 * @cyclic_list: list of registered cyclic functions
 	 */
 	struct hlist_head cyclic_list;
+	/**
+	 * @next_cyclic_call: timestamp of next cyclic call
+	 */
+	u64 next_cyclic_call;
 #endif
 #if CONFIG_IS_ENABLED(UPL)
 	/**

-- 
2.43.0

