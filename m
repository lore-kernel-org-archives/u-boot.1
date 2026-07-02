Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23FCC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F204784A0B;
	Thu,  2 Jul 2026 17:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Xv39WkNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586AA846A4; Thu,  2 Jul 2026 17:24:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D03F849BA
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYKB01Z9LW9tP2CR0TOLVoRFhBjZUQ5BkPXY8DPexzP1jdTsRBTV2N2z22vlyzq59GeweavxYd8PWT/SpTFnXND56t5ctp7lwKUDkb4ETSbL6vf6KqI9JKclbHrYw2Cv1K4wYAj5K0dDX46qOWUH1oKRqiZpRmSv0y+LTiU33QYVgVkxsjXeMLqSJRJ/FTRGRQ086tegMMa6lOpubiHpn2tRILr715CR+S/NcNLbXjuuc1n8sTalNe0xxdXADkR8C9uun0oO2QeaU2i8gZSAGgPJRuRwDbwH6DQhlBOEsuNftf5l0ykXWwBC9hC1k9+GOCT1VycK7wzzyK159xWGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfU5BUtrVeAOiXhjs05iZ68ahs8BN9EF7CvfWfQmUDg=;
 b=YqZM9mm7RFkMse/0HcasvQx3Et3DjS5NwIr1FlLUK0aomu5rWouOfD8HIrzV82NpjVYWMuz6iJwvpaSrExlmG3uTWfTMUvfsn78/tRIlUhLtv8qewcwB2tAUlHxWUFx+Wcz3rJ3fhL5lW7C6y2zv3j8jDeL3nrBu5WG2oTVhHqOsU39p12NhX9/ezis52MNY/KNrAbLhu0iaEHgoPdp9iVBwukMcnGnQAGTf8zxlMV6jR+Axav4xistylg28sKTeRKaZwpPesyPuYEdYZqJ0DtdPow2+wz8r00sqTm3wT82IZenfF5CYuJELmbZYcjnu47Kq0ufEeXvX9OTHQLdz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfU5BUtrVeAOiXhjs05iZ68ahs8BN9EF7CvfWfQmUDg=;
 b=Xv39WkNe7ZYQrixhQzTiEs9VffZ3y6UzYXfHEBP4F/32/LA/C5X8+lW1iqyB9u0hgNgj8NXSnjx8C2ll2+TStTE3PvUp20vjjda2bG1hrmS6YP9RSXH0c0/fwPoKl6wyo73KjUwZ+sHhr6NWyK5LsqOqLuhEmwCrS+UiRvDAoj6uTj27gd1nbEbaKOuMCn45hxGjuNfh1JWyHxpnSXH+mnhArQvC56p69Ub5rZc1XIRy3o2etkolZf7uhgX8g9L4ShdHheRtbjlIUikQi77HLWLPL8KDXHr0Um1uCnn7OdkrxcjF57nA6i3da5NTbjsyu0Cvf/TGRxuW/l0HfdoIAg==
Received: from DB8P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::25)
 by PAVPR10MB7089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:24:40 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::a3) by DB8P191CA0015.outlook.office365.com
 (2603:10a6:10:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 15:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 15:24:39 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:29:25 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:24:39 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 2 Jul 2026 17:24:37 +0200
Subject: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F6:EE_|PAVPR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e07a14-e23e-4b67-7e1f-08ded84e08df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: niG4Oa84QMFMjW5kLaFZgCHUQL+xuVKwt6bxiBpSkKhVNFDjs1luAM+HCZ/CNXBcL341adGx0HvqEXCXFkc+ajtOfg2khnPYaoDjfvPrzQnmk6md0oaWF9+VYuT0g6AYDU6WrOZDUJs8suAhPGiHA1uW9AhmJQDM6qWRkhAuXXZG8c14VqT82fdfv0RBEUVtS8xtDdH694MrXvgaT9iNKqgMjUom+ua+Nm8R4+ZviVDD33tlFC1l7szxZrh5Sa7sbCnSZriVqhsegSx8p3Y9cQS92VViU91mXNcYHzi3SYYgQGNF92ywO/kkwE4azwtd1vTR8cgr73SCSupXw/8bIJYBWanKhS25LbEwxq7dbtYxoFRXLIfQzCrcnnccIG/GEK9BMkSPthQxw6a+SCxx/LO77BpQ2tXmxwNwEFKAXyAes1A6/rU7nS/NAIYpH5NpAq6Az/ocE5Ep1tm+SWz6XlVAXUb7AP/FurUGNQmX38XG9lIHc8ke3UDlWowNCvS1QFTDePljMMdg8/l+wYETuWx/VqeJCmnCUrERkGPcDTDw8WclXwwaaxMhFEoZNqrV7BiDIxDREXUIzx6e0hPQx+wCI29K7R2FjcUCxE4u+kBvFWcX2f280Tuc0IsTDSfgRNn57baTuIPEfN0HOoSrIM/J5vcqnsoYXto7sf9PCaLcMNvnAv+DbyebxyVrm9HLnZuXiH5ccaRQQ+tOh/inNg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qLzkUzZKJ42L0/FJIYqsvSwbwoX2WffF43z/8s8IebtoObNbZ4e2/SbYm73osMCF1H2o8oIzlqCvRO8MQPPtpDwDjUXDCL7Ek9o44dl5ZnihkyVbbcNUQAzHPc0VBo8/C7ef2OVpQM18UoW8jq7fUs1yzB/yRADuHkgPbJaI7N7+7b8Iw7QlKC1+iTZGySh3duzwivv9tjT/65gyoy8WwRkYebUkXscQsFKOdrSkLk0aXHIxLcTlYNhbGhLSoUge5XO8gAlhEOTwoCtLhbvnFC/TT+gI7NChQkDhbigFVfjkEoz7jH3zIXr7RBfGED13hTjCAF1dro+8XtFoQ2K1EVh9YIwbpQok6lKXbo3EdjVVtrqru4rTwvTbz02JoDnW9KGNU8I3eA0sFPFCxxyS4VbjlknnH3iFS8WQDoy2LtUyZeutqkK9FdaLCEGYUJdW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:24:39.9979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e07a14-e23e-4b67-7e1f-08ded84e08df
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7089
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
 common/cyclic.c                   | 12 ++++++++++++
 include/asm-generic/global_data.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index b37cd6d8ff0..714d6863d5b 100644
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
@@ -102,7 +108,13 @@ static void cyclic_run(void)
 				cyclic->already_warned = true;
 			}
 		}
+		if (next_call > cyclic->next_call)
+			next_call = cyclic->next_call;
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

