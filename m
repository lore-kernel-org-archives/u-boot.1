Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF8CC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09A6848D2;
	Thu,  2 Jul 2026 17:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bIWrA3MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD18A849FB; Thu,  2 Jul 2026 17:24:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E455846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMKSZUl2ldfLExcnHdcIIabDIOYoxNkpwBA3FbEYlqAYrJUnL04sRUI64hSJ6prUEvliAVVNXJNWZWZNKawFGMhd9efacEIuye6YwyjYy7GDbN1NXPOEnD4jn2nMBpdhZlYyUm8rR3lc5Ioz7T2+mngeKcO5vi7I2Pw83EJBBdk0NfxB3cqeBpb8/0d1xyYpB6CnHJCrb4sMynwANq5zWGxxAl30lVwnneoWTnrjMIotht618antMwDlTx5pezm1Cjo5RbVvM/RpxyuDDQ6MkPZoI/xJuYoCt9tyi6tH94F6jb4OWucUN2qI3HfwsTyVvg8n0MFCuFryU77O3K7v0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d7ChlX7J6AYrRkl/mbuOHnRe73ferJKbHve55eIkRU=;
 b=GDFNK0rdUGt6tl0lsk0gqtbBjq0kP+oN3N2Cr8Agy5cAvi34KKT/KdQLQIXFOB8JCOR/rXFThB9/8NTZalNG8+ZlspYoEhreRJ446YwVQks/Ec5Ygpkacs+evPmoqarfUx0WXxDHYfpOOksxQCwJ8KVENMpHxg7DT2IRGmekKsh0QUn4HEWQV/QAkbdDEjEOeAd1glEwB7X7XSpcIQj9QEJTl9ea7v6PGMATF1EoyhiVOr4pcX8iujlPzm3Dy4h+Yna4mf4S0eU0lzHGBFQSstkUowEKymWy1Pzqv22odrcU1fRuqsr2hhpVK3bxFY7j1uyz8gAmOKZeRuxQlR0gEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d7ChlX7J6AYrRkl/mbuOHnRe73ferJKbHve55eIkRU=;
 b=bIWrA3MBEWWBC7H+U9ROFFrgBQHIZ1rPZEYAjDNPdcuSch22k9XJ4BMlJeW+3BhJhW6eCWsVdEbKS/Y5xfkRwN1oLCSBBkgQ+5wpIeA1VvF/MANWGEJ/M0QoS1n7CErQc0qQTolyTJTMZsVDGDLxdFMODtyebeUABfylnLg1RXS4ldfbCxFoDkagMaMy/Ny6+C/t7l/tqjRVrwIVXEDT0LSgXTEQKpLThgpnIkbXhhbjDvggMSBAdrzZWbsvRgrPHEPq0pWT1DbIjNV9MiqcPOkXA9kmsf+LABtk7Xi8jkRvVSEvj9Eve9LUyi1BiYfO3n0wJWkdkFurl0XtY7KDIg==
Received: from DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) by DU4PR10MB9640.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:645::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 15:24:39 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::2) by DUZPR01CA0235.outlook.office365.com
 (2603:10a6:10:4b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 15:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 15:24:39 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:28:56 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:24:38 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 2 Jul 2026 17:24:36 +0200
Subject: [PATCH 1/2] cyclic: replace uint64_t by u64 suggested by b4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-optimize_cyclic_run-v1-1-92c5a7011f54@foss.st.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
In-Reply-To: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|DU4PR10MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1d65c0-de1e-42b2-ad25-08ded84e086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1MhdBjCMggb0/5lhS27280VzIzJPhDMlAPCycDDW8UZHShhpcb7p/G5hPumU8xxd72C9iDW2ZRzYkvqjoEqira7euMDyL7DKhW+62p9GuP1aKnnF7Ul4favIbR7g9GHETfACfPk7sI+PK49Nn4hXCcvj+ymH7wdKPy9fhBmj8TVsxwmYeAwidQBqXtXxrr4TV8G7i8cBiq1wi/G7Z6t/7dERuvDLG4VHaqzMhVnKiiXgJdYOQTvR4GXnlHho7mq3cFZ7r6bsZsbzUUD/X3dC7MBC3QazmsnGpHy/njIoHIoJULp5Yz0nkLqrOQcR/Ohx7UsfcGqF4rzeQaKn4O0yuqIdpzm1685gb7hMaLcVPO4jvo82YPwDHoydcd0zKtKwuXgR4mkVXhU5vX8bqPa6mrSk0hhJVCvFSjba6CvSRd0CDjJx8n58tBwB3aO3Noot1hgrAp7De7+Ri1/vdYrqafBoG18V1OmMNPQGaJAL78ERVYiYfWnM03oetTpBNoovcBUTcPZddDEg7vo40j+jGVh86dXMHJjgJCFHlsJkhwrdigt650tvj+CyiIqjVAaWlBn5j8RgufZ4l6kb7/VjKKmmym2AY3ZAECMjKOOXOZF1TNzsVZYFtpwZhvF4vOZn75XdfnoW1QVdHnXPqGqfZXTN/21XycMOz6rZevtvXXx87h76exDo+JQb44K1cFM4bA59/rWUVqehO4HiZz7VBA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UvtUsIGqd9Hlp4NBtgDmAP9G8LYcVn8STg4b+ZinXEPIW8Psrh1Gw3ymIm84/7s4PBa2wMt/TF9ihYogJs10/dcNQN8cztXgm4YGttR8ImqzNwU4OXt+4L2oLlupf3DwmTVpE5c6m4dKSXsTmCsPKroGt3ffXPlHMsn/IRqiiJ8O+Ob4cc6ZkZUUl3jjahnIes+oD5FKrSmn7YngbTZHk7PXyRZN4dC+4o+eQT+lwf41IYlw5WcfdRuJCFYaFY9p79ivPRmFM0HSiVFC6ff1Zl37zCuspyzuVZHiXeiT7bQxQnuo7FezUGL3wTpbtm7cST6boKbb61G2gLruzybqJuTuJ2YKX84sooY91pu2sdAS0nfj2KGu5zKDvFRTCBBY5e32mDhIrYMgYRHxbTnq5TcQdGw20bRuKdp79qfb+iWTpJm8gvNiYNXA0OL4Jf7N
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:24:39.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1d65c0-de1e-42b2-ad25-08ded84e086c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9640
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

For new patch, b4 is suggested to replace type 'uint64_t' by 'u64' :
      CHECK: Prefer kernel type 'u64' over 'uint64_t'

Update cyclic.c accordingly in order to be coherent with following commit.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 common/cyclic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index ec952a01ee1..b37cd6d8ff0 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -41,7 +41,7 @@ static bool cyclic_is_registered(const struct cyclic_info *cyclic)
 }
 
 void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
-		     uint64_t delay_us, const char *name)
+		     u64 delay_us, const char *name)
 {
 	cyclic_unregister(cyclic);
 
@@ -67,7 +67,7 @@ static void cyclic_run(void)
 {
 	struct cyclic_info *cyclic;
 	struct hlist_node *tmp;
-	uint64_t now, cpu_time;
+	u64 now, cpu_time;
 
 	/* Prevent recursion */
 	if (gd->flags & GD_FLG_CYCLIC_RUNNING)

-- 
2.43.0

