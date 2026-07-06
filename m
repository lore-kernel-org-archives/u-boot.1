Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7C8C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDBD8496E;
	Mon,  6 Jul 2026 18:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="irRNMcR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42EA6846B4; Mon,  6 Jul 2026 18:06:17 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E8484852
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i87DLPH6QlOFfNwSClkX4hQtmCmSsIi+7UUNQtZXN1ODfQRDaeySj5ZA2+wX72NVvw9GNLtJafVXYwtLy4tIglgkFnvsLAEw9NHeA88qKMEnJ17UxJecjY/+csXGHzkvEEhXsnBeKwmsZY/sNpKfqXiAR2tnE0qjX4Nr1qTPuibqdjy2YbNZEighckK4iaTpmD09tQIosWJhGcNxi3mzUCT8n5EyIEyTLlpNRFz/VmHar0peRBGF7aucBp5R9GhUFvrbzaG+wCrrjTOJAFBR2cDoCuJqGLrhNxtjtLpSZaWX+qTkcKPnSH0bnSQn4FQ1E6v73pWxrlZWcH5PZYrWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW4d/LYsSrklH5eyN/8QSvdcffaceiisDLvuvw1RIrw=;
 b=PFo1YfnYwsiV0xZ/k9ByY0jxe/7jpLvzZCTuY+TklRS6nkTZpskK3VEg7S92pobOZnP6QZzQgg6PCdzWnlefCqmOG2ioAS/wp/YHI/XVIoRme7LApRWgpanALeqtvLdfKRfav4MF01p79F4NREmqzdEpXpnfSdYHlcns5zFDBK4Ad4+fYJus7fXv9c5CN2d/KKuJgTHTlTpZRcUfvP77nNXvyk3N/lwPnFP306/xOpFQVbvd4r9elINV5ebCTsfDx1Ua6TBXon7bilJq3eUwtbWfZolE7kILWghAoGqGorjMu5E5hkt9OGFYnPozJs/M/MU8VRIxMJSUkLV6iwY23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW4d/LYsSrklH5eyN/8QSvdcffaceiisDLvuvw1RIrw=;
 b=irRNMcR68f6GsG6YtMsRDC9Ps9JV/mQB4NQlnEleCwnU7vEXej3h/UiTxvA0znlg//Wi1xF88OnkURmcA0JuOasmKS8aCkewI1elnaAFrm8xqKeQo+XvrGOAxYdkV1pMDKPVPOebIc/2P327T5vyglISY+WLrWgzPCK0x2AkU7T5HpwS/PYR5ygIV+BUhe/USpJPFnNeBQD2fYiWRb1hC4E/eL9cIrKxJXIF+oj1VlT2ecoghRjpo3qDAYug2ElYzGj2VJwnwn/Tq2jrRmsBOI8Vf9NctOQKtq6wsfJiD7MQD95cR6cTMwpxgOgrTfVWqporu+Fo5jvo0W9sZ+dIiA==
Received: from DUZPR01CA0225.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::22) by PA2PR10MB8944.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:41b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:06:12 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::8b) by DUZPR01CA0225.outlook.office365.com
 (2603:10a6:10:4b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 16:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 16:06:12 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:11:00 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:06:11 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 6 Jul 2026 18:06:08 +0200
Subject: [PATCH v3 1/2] cyclic: replace uint64_t by u64 suggested by b4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260706-optimize_cyclic_run-v3-1-06ecbd74ef7c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|PA2PR10MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: fd82f947-288a-4212-0e44-08dedb788027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vEt6RibW6uD65ntiXai48yBVPpOAuLAgLA5sFCAO1c5cPAP1BWqLTd3hgDfwirTMbDPdmCWv34NEO3CN1VaT3MaTweWxU7wlV2S0ZOEd07GRMYJphZ5zmVbKk25SdOSySbypoRxLP4fC1EIMji6cfB3kHnsBRUDYoE587H6pBlmNxiB/5M5UTB/ktYYmkq7SDAtxc6dvK9g9IPoWNDYDH9eka/GN2j8vlvUdJc+NOfCFirZEvJBy71x7Sp21Mo78yV6dN+tF/i7KU10asTU+2DAK411wJPnXkQU4wYug7PzRuRuAdCUPJFYW8rmYeomlbIC+ys77d8xVGHiGQvWANtg6a+Fy+I1nKfwMsmM3MLI3GqbcM/aFFxeOaCfyrfqJjZ9c3gyzgYQYgmpb7op5RmptnsXrU/qF39M71sCDJpK9r+twfrokJHQ/htyyO5RUZXgVNrunLQt0SbwP4XdE8s4LIZhvI1tV6vItvESaE17ch2YLhNUj/m7PepiRX+L4781kcQpMMIuupkUAiAAG/m9GdRvfOQGmRcEFmHo2ptZqa1NmZJ9Pg7vrnnCtBNyeJ4dIcIbKLKGwzVn1FTstU5UJKkIa6prV4fhC9DypPM8vkn+NomduMFJnkmGdMGjynORTAsMsrlFeeNdwis+OvPdBW6i+webzS+VgWGJEnBjEI2UUa+kPLSRK13I7X83GFXaan8GozKb5/46qRgmvLg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qzTB9hCQiPpP6lSlR5nkJjn5/sydTmMjq5yIwDlVCIMNkz3AVE51Aoaqcsuksy9Y3Hwbhw2fuhPkPEAITDm0/+Sz4dwrdfzGOGmAT3j5BXuTdTGlGRAMhXAjXAnjHTYbP2XSROy9+c8YzgCbCrYzdqoNXk2ysydq2/5xesYvY0e3qzyfR4LSzdskEq+O+z46RsfiSPxZyhwy53WCz7dQL3LnjctOWRx2jhWWkTa2e4eayXdc23wdwDjyLpQdUUJbitZDHcO5pxM5J2qAuj42uDSHZR5u3Hn5x9QqpMY1+GsIdBN9JsN7f+7mL4jlqUGpDNF5zBAuHGNi97gQ+4YNB+4ddmOSGhYxD6J5UmYY7TC3iiHpynGN/guA64Y7VG49GRnj/GTcWAxpQxBxlhsqOd+QAInC3gMBzFDcvIIu19Rlwky84P1IZcl3s185Plym
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:06:12.4554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd82f947-288a-4212-0e44-08dedb788027
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8944
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
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

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

