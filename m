Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E7E87842
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C8EC83C04;
	Tue,  3 Feb 2026 17:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IV4ftBnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D18083BE1; Tue,  3 Feb 2026 17:49:40 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C38839DF
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw/PzOBFVNUSR7k7UZewlxIQJQIyps1mHEOKdzROBRhw71J3p1dd0ZPnsYRgNXr2KMy/7dEeit8hAOCjGlxuEkYzvGT8AqWd7DkXoJxJTiwLgr+w0FdgiJeHrDTgsjYrKzFMcdCf5+9Kz2KTUDbq5g9Mq5Sr8BiZ4ijnT6XnY6smzQ5AjD6PeJ9rvUY0Tunyx65hrNU4z0ScMFu/ZLTaP6KDZReGUthnNgb+2hWjNjCh8FeiGF1/ED7x9J8S9jyGBBvsrl3s+bIux/nkCrpCV818Il1pQCKInhBLv/W7dzngXvfZNzhtjQBGeOdT9uw00+XX8bvLT0XcBU1BSi/1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1so7zF2nGMbnBAnGjDonSAdhe9F2EepyVQZ5YjVKrmc=;
 b=cCxWOepP3SqCP5XYKX2f450qmf6SBIIhNs4jN5oWzwZhCtjT43CkdvSlMcnahv+Hzc8+wYyqWy9hP29PtP/Jw0cuvFJvsbTWfuqTsDhvfXbPZgV9jyQyCk9E9eKWbdTtMmyhtmGZXvlsA9l+ZpmaBWraQhF5osEP90g3NYwVtwhzTEFZSKhBLhXghWo2wlPHQmA9h3wqneuFYEU3EIyEo7cEGbyy6bHGY5rUXAp/5SR1KnlyrNR/T3pkHK3cdobwyBjheKZkp91AviwsogPKwXDuwkq7sRH/s6Of/RTTKavvxfISuqJnF0sP9t0oHao5C/pYi8pLZHwGAUz0WmqJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1so7zF2nGMbnBAnGjDonSAdhe9F2EepyVQZ5YjVKrmc=;
 b=IV4ftBnp1BGzdG0Gl3vObybbzqev19Q+1O5RoOJQOqyq3W4zVOc294gbgyH+q09UPVoU9a6P80OoYDsKT3V7tdX4mWSIL+XmxyuD7YIkTu7PMGWHvVTlo2ehp+YHSB2cvaoT/AouQfZ4qjT83u1CNPOrO1ABh+OMemAe1/2cOyeBF0AFBhxnDW6QkwxY9nssgyWOPT86UkbGcL3aHxQlCC4dIEbhvQiR/+YlIRZLqoBgto48wSE3h7cQM5OlW9qHrDcPHx6okMQ+tnzVe6ho+j4rt26X2Fcn1a2B3wS8zLyjoesD4KFhkCi/yH4dYNzCDbIh9W7gVoG7Px7Ci/eeQA==
Received: from DU2PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:3b::32)
 by AMBPR10MB9273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 16:49:36 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::81) by DU2PR04CA0027.outlook.office365.com
 (2603:10a6:10:3b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 16:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 16:49:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:51:14 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:49:35 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 3 Feb 2026 17:49:23 +0100
Subject: [PATCH 3/7] stm32mp: syscon: Add STM32MP21 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260203-upstream_add_stm32mp21_support-v1-3-48ca3409cce1@foss.st.com>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
In-Reply-To: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
To: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>, Simeon
 Marijon <simeon.marijon@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AMBPR10MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c63de91-a5fd-4a02-5724-08de634436de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlo5R1orazFDcnN2MHhjd2NYTVZWUWlxc1JETFBzZ3g4bWthell0bVlNcXBn?=
 =?utf-8?B?Y0hCL2dzQ2UxLzRQSVNmRW9oMFVDRE1hZGFPUXRPNm1zTFM1Z0lhdjdqZURl?=
 =?utf-8?B?Qi9BdmxWcVhGTDRoWUYwdnhXQzN1TkJ6OFFQa2NZM0hVSU9EaHpqTlRUbDBj?=
 =?utf-8?B?Yk43RCsyM3pBTER2dHRQVzNYQ1NLNEZRSWQzdWhWak8wTitUYVYxNGxwSmRs?=
 =?utf-8?B?Zzd5K0FEckFhYzBML29GZzBxN28zMmZrWkFTbUZzQXlOV2RmQ2pzMjlxbmJn?=
 =?utf-8?B?U2dXYXJVdG1CQUlRNmp1ODRtZ1czdEx2eWFlMzBhR0ZaM2ZYS053cnpyUVpM?=
 =?utf-8?B?MzI3RVJ3TlRkb3BRRGNIUEIyMDdtZmNmZVBsNnV2UGpXRWZaQ2FNUUIzK0FW?=
 =?utf-8?B?WldFOWhwN3NaaGUzQjUwZ3VyQ2JLWHFzd29OcWxDcFZrcHp0N2R4RWN3M3g1?=
 =?utf-8?B?Zjh4eWgxaDYxdlpvQXBCSEV1SkthSStSZm9RQzByQXhGTFZGWlNBZ2JnWnU0?=
 =?utf-8?B?TFdleHgwWFpyUVZJQjJodU1xdlZ6bjVOK1ZZaFpnV2tyTEw4OUlHODdDZkdw?=
 =?utf-8?B?ODZCemVtYWE0ejZ6UlBENjFZN1ZJM245OWxtRWdtMktGcXBmd2NVSUMrejA5?=
 =?utf-8?B?ODFzM1BaZFpRVVhpTGowbEV6dWNVSS8vSU9VQ3dQNDBCcWs4OGdBNHY5VHB5?=
 =?utf-8?B?Z0pIL0p6R0QwcTdhd21mam8zYmtyZi9yQlBDb0ZBamJ4Vmk5LytjbVFPZjFq?=
 =?utf-8?B?SUJKcEllZGhmdWVmQ3lCWjMxeWlKUHA4Q1gweGJCR2huNDhtNjdXdjlNVFhR?=
 =?utf-8?B?YUtjdFp5NVdBdC81QUdqNWk5a0R6N0xXNVFmcmZ3NCtYR3ZNZTkxRUJQaFkw?=
 =?utf-8?B?eXFIYnRmSi9YaUEyREtVbkNMdkRoVS9CbVdwUFVKUkxoRENhQjJIeFlFcWdk?=
 =?utf-8?B?eWFLYmUyZUFOQ3NaaHp3eW1wMUhmdFhUdnBaSnZ5SWVJTFJwb2J2amx2bW5T?=
 =?utf-8?B?bFNXWEozMDVkdGZGazNMeS9OMHNlRHgrd2JJYUVwVEhYcnBsMWFNd0FDWEJK?=
 =?utf-8?B?QloxcUdyNW85YlNoZVNGU3dZSHpGTk1RUmErdzVYL1RQU3UzOFp6alV2Y2ZJ?=
 =?utf-8?B?d2Z6bWhqV2xZY1UzVGsvZTBIeFNlczNMRWtaU0xjY3plRW1CT092Wm1uaDY5?=
 =?utf-8?B?b1hrYjk4emRFVDMyanpxQVFvV3g5SW00Z2hxMHAzZWdFQ0xTZDhtbS9kT1lt?=
 =?utf-8?B?WmZHRDIrVERUcDBvRUVHM09tRTRlYzkrSERMWTByYnczN0dxSzNqYzhOU29w?=
 =?utf-8?B?VWZpMmtPTzRrckxrNTNBWXRFY3A2SUlZWm1rMlU2ZUpHc2VjcEFiMWV5SGZD?=
 =?utf-8?B?K2hYdCs2a0w5VklOV3hRWnp6SUZkdTg2RG9BUmZiM0QvMjc5aXVuTUljY1B6?=
 =?utf-8?B?bDJDMEkvWGZVYWp5N3dDSnUwekwvcGJFLzdaL0x6ZkFiU1pFSzh1M0lHRGlm?=
 =?utf-8?B?L1FIc2FYYVVaRXZDTnBIbytUTEtBMnNvMktWVXYzU216VmlTcEJud05DT3BM?=
 =?utf-8?B?SDVaRko2VjIxZE56TXBqY0tqcEJ2QUwyWWdEVE1adWFGZVpPVlZRUjZQV1Jk?=
 =?utf-8?B?Wnp0eTZWckhsenZYSk1tY3JiUTdhQ1hrdW5sWUZCbCsxM1NMQ3Y3akhJUGZY?=
 =?utf-8?B?Qzl1UmljOWRURDIxL2x6TldSTkE5QUJ6cHdYNUlGcUpGcW90aTltRUlXN0th?=
 =?utf-8?B?a24wb2hXUXJSY1Q3RmZHYWV4b1VXN3hQenJjeGx0Y3NwTG5uQUx2NSswV2Rl?=
 =?utf-8?B?Q28zQ1h2K1JLbVdudGpTcWZDVTU1a1JZeXd3bHVKU1dubW1nSllCRkVzUFBq?=
 =?utf-8?B?RHZwaHZ3WThxOThFR2QyRkFJcVdmcStUQ1hKQjdGbm8vNGM1cFQvKzN1dHdQ?=
 =?utf-8?B?RHJCcUxFNkt6eGs0WVNWeThtbHNvMDZWYmd4cCt6Q2d1WlU2WkQvL2gyV2k1?=
 =?utf-8?B?V1FUaWVSVHlveXFaeWZBRlBKUTJ0dFRVSXdCSldWbW5hREZQcGpTV1AzOU9E?=
 =?utf-8?B?RzU2UWdCd1FaUXg5dVdFcUtXSVpGUDVveGRzbUVkUGJNSmZlVjBXL2w2b1F1?=
 =?utf-8?B?YWIwN2k4SmV6L1VHS1FyNzRXVXJuWFI5TmtXWGJ6RDcrN3lXQS9UbDZ2REZ5?=
 =?utf-8?B?bWxtME84bEJZd092YjlFazRSd3NiVUlnVWpuZmowUjNhOG11cXF2UmlzVDRq?=
 =?utf-8?B?YUhPenBFVXBPUDNoQ3dZQjFSUzlRPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XuAp6b5KGohaue3FvHVfHV41NQjXNGvHPeC0dEtsJPN6ENckaX/qH/BxqYFt/HcJpltANrGvCa0FxAcQXxt5gYBFZNUkoHSYRiord/4bjScnKLONb7/cvkN3W/2JybTqC1DKjKqcd5pwDHOB5/bbMaqcKS82OLXRuOZl7qQoDyad5G1eMYwe7kowB3rhRxxXPHUeDt7qsuv3ndGF7OoJgfxAlhsPAt1VH3E9fxAWcalyZH7yT/+CD9rnirhb/HC7268ApNMFGJV37oz7wYlGjs8ByenFyHR9GvWSjDBL9/CTOvjU3eWkCb34uEweJicMW+j3G21a1N8kqa4nBpy/gwv7Yq4mCzwzL6RtRmi6l9bRVAgf0oO5oJjBpflKRIFjULYlTt2a72Qjw2LjXRq3sHJcp4pOH8veuw464jxX89Vvxl3hLbn26mJ36HYPHlPU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:49:36.1481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c63de91-a5fd-4a02-5724-08de634436de
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9273
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

Add "st,stm32mp21-syscfg" compatible.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/syscon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32mp/syscon.c b/arch/arm/mach-stm32mp/syscon.c
index b00897e87ec..f2cfc9465a5 100644
--- a/arch/arm/mach-stm32mp/syscon.c
+++ b/arch/arm/mach-stm32mp/syscon.c
@@ -10,6 +10,7 @@
 
 static const struct udevice_id stm32mp_syscon_ids[] = {
 	{ .compatible = "st,stm32mp157-syscfg", .data = STM32MP_SYSCON_SYSCFG },
+	{ .compatible = "st,stm32mp21-syscfg", .data = STM32MP_SYSCON_SYSCFG},
 	{ .compatible = "st,stm32mp23-syscfg", .data = STM32MP_SYSCON_SYSCFG},
 	{ .compatible = "st,stm32mp25-syscfg", .data = STM32MP_SYSCON_SYSCFG},
 	{ }

-- 
2.43.0

