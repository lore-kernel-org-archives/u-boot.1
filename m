Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5571C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8EC8490A;
	Mon,  6 Jul 2026 18:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HnnMbMde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151578498B; Mon,  6 Jul 2026 18:06:19 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0693C8490A
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3fc3DIWhOqdRBUNhyQ4vuVzsT1AwD0h9Zn/mEZDjvPO5OtPLEPBP7UDjPAYKD/HVcp2/ZeQo6iEhKdP0s3GMrHj7NTUZyPMOqyNO1pEvPQ/pB6oMQwwG725EsjWsaXUvHHUc68n/3PP54z7nRfDXeal/lbmqZnaDaaC76yC+o+D5wCQZyKH09dTIxeoTgQScHhwwcQTbTRAKPhM43T41RnY/9a6kfIYMrTetCZ4erHHaT/73AZVwryFxNU7TzwdB1vyLK9jwF7cXfLAcn50ohvfaUC49fyLVXvPRe+IH3BRjJf5xuegwIxr5X0w+vkF6ke1le9rrssJo/2o+Wq4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIsPxJzqZ9TcQwmVrtAoQ7smpDaZSZsdyUqAEnKihZQ=;
 b=AP6FziAlLgxTBx0sXUPDBNT66hVOTtmOqRcrUmSGqJWMLhBIo/G5nPJ7vHznVE9gOwd0E1oKKeJf5KU2ImC+kWAkPB1YjVI6s7yIX8I4/IMMc40lRz5zu1d93TK/O7Z0MriNLF7k9HwFhJukVQIdqT4RWs2jZUe0bS0Pn+bQEfKSXquCredR4KcI7ds6EpnsyNf8enBhxwhMm/nvgKoRq4DRVbOwSQRaMLAT7UIdk24vRBdUsmFK4mNE46KmHVaDASC+xMG9VwzndjOAC5uzfyydoaHABA5Rupg93j/azZRTxSXF9LkEly7cP7TlQAeNTbTDummCCOgZqTkvy5L6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIsPxJzqZ9TcQwmVrtAoQ7smpDaZSZsdyUqAEnKihZQ=;
 b=HnnMbMdeyezKMhzp9aG/TEXMsYYHVJYkNXrk/caEl8UoiujXZZeysUG9FdNWnZwgOWG4slWNImSrINYXShaoO5zQ8OPOb8g9BsYvIN8w/eTXD9XuKznKFuST53nmpKqGgZbhrdatc11gq2+v+BhA61TjqrmZdwPVZapZX3BZICwjizODLVd7MPnsLcPjpbomXrCc9EeWqUabe6SilxPGQcs10Egw8VwtV1vVKGYQ1V4lQswUvvhgnfin2Hn03jGhPKgJtRmJxqjuBFx6GrC1+zfsvRG++PEeWoeY22ojlDGCb429i2FnN3ffAa1ptJnIOugMDbAZ7bjQxWkSAbsG6Q==
Received: from AM8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::30)
 by DB9PR10MB5812.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:393::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:06:13 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::a0) by AM8P191CA0025.outlook.office365.com
 (2603:10a6:20b:21a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 16:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 16:06:12 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:10:32 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:06:12 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 6 Jul 2026 18:06:09 +0200
Subject: [PATCH v3 2/2] cyclic: reduce get_timer_us() calls inside
 hlist_for_each_entry_safe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260706-optimize_cyclic_run-v3-2-06ecbd74ef7c@foss.st.com>
References: <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
In-Reply-To: <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|DB9PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0b2544-22df-47d0-0998-08dedb78806d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: CT4dFGnS89qEIj0ReKME4qapqoikr/Su2sYYCl/3d+0yJG7Zw3Vbh3YLHHK1lg73lB+WnScLJ3DGltRbpdUxpExhuuAr0v8HGBVCmSvH5Or/8R/XL6hUyTtmb4719C8rcFOgSISyOZ94uQHyB9Q7JSdnAfgLyU8Cj/yTU2ab6/DX61rEgnsWV6eDx47EPtha9XWijB27LD+uS1A6bvn/BIBHE4cRTn4wRF88Y2zEQymJ73/XJL72MaHs8uT7FAnfe/1gi3rQ3vwxEpt1JGlXSDTACyRGo1eT8FiBMbJyL3an/NHSK7furULvaDiNwercjprKWuPWcxfoEwWQ7B1e+1b3azvO93qdPESZW2oVx81vCdHAWOcpKzm7D49EfmsxyCZZXsHwFgnKlc8QAKNdTH61GmF6QS8rSJk+mjhTTchvizQbXfSHglSZo0OA+gl3Dxwqt4fWDBE7J/lOUGWnizguoXQniS4U9POILfNOGo+3nVBIbLX+WdnM0eC654CbAvbbpHXShad0kUmz/4PwvO/JU/lClUkdw9KXUsiHaQZEfFU1peUPpbXAARV29AzGGUKUByDDar0IyG4V8ln3Bv7impBW0BVCTTwY1tczBtTQY42AzpCHzBeUTZjC4kXY9KIzJpQiD5by9pUbkGOZbc63MRRRbdCSTnV4Pm+ynZCl27owee1xyl6QQYPe0SeeAaBfYV/0oLhYCrHyFZbdzw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dLQ0WkPU5+y4qo6JuCK6mF0z+NQ0GwEpqwPrjX2JiFTobUGieFXpQmBkfgsII+JzOxYOJoJRh3RFL6rZ9R/bObtsEpuFsk2JhVaZfRIJqlmHkfvip6XE+QfROa1TaN7+h+1UgFuCznqh7FeF+807k1HjfdAX/7VzhYmAXDwn+BdrWHf3W1ZO8mtxUbV6mXHKEWfR+23DQ9fpIX1n8LM6GJvTkt8lrH95d4inVOtUQzt2r+9V1fuDOsWRaG+Dsey3n64GAbrFPP1PayY0nGsPfoROIvGKzSWBsgR8HXPgXCwMwwoov6QAdE4+eDtfIV+LwEVuWICcA7nWWpB1Dbfjlogk/c5YjobYzvo2yzeqBMAtjK1rInVG33YtC/qoELsTl04yRYWg+d2N3e2Mw8QIPQwQLBkca9VPgnqwYijxN7zCTUvY9W99U9NKDfK8yHg4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:06:12.9623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0b2544-22df-47d0-0998-08dedb78806d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5812
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

Optimize cyclic_run() in order to not call get_timer_us() on each entry.

This allow to save computation time :
  _ before : ctrlc() is called every ~640ms
  _ after  : ctrlc() is called every ~230ms

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 common/cyclic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index b37cd6d8ff0..573e715587d 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -67,26 +67,28 @@ static void cyclic_run(void)
 {
 	struct cyclic_info *cyclic;
 	struct hlist_node *tmp;
-	u64 now, cpu_time;
+	u64 now, after, cpu_time;
 
 	/* Prevent recursion */
 	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
 		return;
 
 	gd->flags |= GD_FLG_CYCLIC_RUNNING;
+	now = get_timer_us(0);
 	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
 		/*
 		 * Check if this cyclic function needs to get called, e.g.
 		 * do not call the cyclic func too often
 		 */
-		now = get_timer_us(0);
 		if (time_after_eq64(now, cyclic->next_call)) {
 			/* Call cyclic function and account it's cpu-time */
 			cyclic->next_call = now + cyclic->delay_us;
 			cyclic->func(cyclic);
+			after = get_timer_us(0);
 			cyclic->run_cnt++;
-			cpu_time = get_timer_us(0) - now;
+			cpu_time = after - now;
 			cyclic->cpu_time_us += cpu_time;
+			now = after;
 
 			/* Check if cpu-time exceeds max allowed time */
 			if ((cpu_time > CONFIG_CYCLIC_MAX_CPU_TIME_US) &&

-- 
2.43.0

