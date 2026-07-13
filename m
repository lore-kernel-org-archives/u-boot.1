Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDB1C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7C184C1B;
	Mon, 13 Jul 2026 15:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v70itaDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9977984C1B; Mon, 13 Jul 2026 15:34:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E65F84B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbyNlg3nYyg86G3PJDwHaUPwnhicUSt4R0PdYpNEJAhp61IGUSavoEHq8fkQmX7MmjCPgLrhRwdf7a3svFkYLgcy5oowwJ/QxJli3XTaM406AugGw4iNCqx+8sZBW3jpQdR3oMFxtiJFNl5UL+0CeTkQe5DL4kpSFRNmyDSVmGOEc0/TuqxZYyo0nHr0D3RNuc2sN/chQ99eum3xRGP5Ah5UuMYpm52uv+2VPhfU4gtTps2GNcsVE4hC55kv5oXQsltHnjE3EpzqNpMlIN4HP3ftr3rvvwrPs0c6rDybfVwtlW8wTCfF/k/a3fokFD4bvIUfgolKX/cpt+gmzVqtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLhazGP1KFXCqIn9e9eu5aOfzn7zIq4cnawvPV2Ebdk=;
 b=v+A7R6FjP7wBAT39l406dr0y7r0lAMVyHoXcUyPHKGDON2K6hHV3ljlCfsUBnlaH0gntsLxsA/uiYUDDqmUDQif/NnjQw00Lkdy7HmDTFBGpgCTFJH0Ef818ErUArsNMqgLAILxU0Hmx0FoTOmo5XQ6sI7HOVduOidRMdzDZ5/pBsO/XcFrNaOVgNYwjuvYoOX3fIjwPCchOR/PDTXx+Qv/uZQVJ2pYC77qaEOiZnQvFdAhr7T0bu7tr2HAXl8GTyx87sPQvgTHg2R83dcvxPGpjH3fZmV11Y3VqUG13eOTVNzEt+pcLNcMBnUBmC8jEZUDuhsTccFjBOs+lFy/0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLhazGP1KFXCqIn9e9eu5aOfzn7zIq4cnawvPV2Ebdk=;
 b=v70itaDRdV1bISaeD8n9kF9cqxnxBLsCZGp0B/hShQWJPnIMHpKOqTxV7hS5Gbl3veXr+nfxpXG1OZIul7lZKsZxvjkgOKrOTeVoM0r1i6/2Vf5NgTF4bmlJunYgGW1WnUOAX3soOroCVkZXYpY4kmNLUDykeRta/7Ke+ZFF08qNPexvFJSZZB4fJ5CcqK+x2gvHZIY9jPsu/zjIZ3sF8v8fwtXPkhQ0EvyHReIQSfOrrXsOqzwDeZfmthsUeyoBdaQqoB+Uxy8+xvdVWuXkwpi5GXQGAK1ABzWlUutvepl9RGlI/nmFpfILMChtJRGWeYYSfKwftLQ4EZyV2wTZxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9011.eurprd04.prod.outlook.com (2603:10a6:20b:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:34:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:34:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Jul 2026 21:32:54 +0800
Subject: [PATCH v2 3/5] mmc: sdhci: fix align_buffer memory leak on
 re-initialization
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-mmc-fix-v2-3-b0ba3b4a8d97@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
In-Reply-To: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d47539-8a71-417d-46ed-08dee0e3837f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JZ0uW5nwuslj53xBugSfP77mCPYw4mQy9zo9mR9Vt3M9VVQokBL0sj7rcvOD6vGHYwU0qi9bIcECKIPZnb89fKEZuMfdPZWhsevJQxuth606G13Fz2dEqrPmMmNE3TXY9MWtAM1X9bMxq2iSYCEDMi1B9K4Rahgxy+jmwYhd4O2AKoqSogqMPnBf1PTFw5xoqC228PR2ICubalab/5V/L1OHq1sTFs/I7MchoYLzUjWehy44ttw/hgz8OwYn8yUSAhQZPiNtvTiGenYmxf9IlVJfJ8C7jNxNuyXQEJztF87MkPruvNUsNtDb9SfQEvYdXwJyOm90pgOO0mcp60i/v1Yk++7WwKtH25WqzOzP3H+FN5G+HoI2kn6xCFbU8QYL//X+Gdd1ToGnLhwIlc6akoInYV+yu+SNbIaITihNDnjIkqmNHicshg7JVKg2DMIeJKXWd8lOtIFvdZAqfmvQR+RJj3qItzOTvfhrPSDSgPi9XZujXoe+h+4CY+ajE3ZSptvH66fABsuBeICtej5qq3LexZ2iM54lm/Ci9FJar7AJ7ZuKJ2f2naFeLpguLNIKhNrob0H+GHlcX2W8ykldHVxP/pSofKho2pui7/QKK0cukCjCWF6zSlSY1crqzCoAiBZzk7h+hR2l0oNo3YPnKOdazz13Wo2k8jVzbPQwZ10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajVxSjdRdTZmMWhEQmRZZzB2SjJNcEh0Qy95b2djS0ZEWVU2MjRHNXE4VkFD?=
 =?utf-8?B?eFUrSmNBQUpLTzAySERNVlhvMjR2eHFMaG1ZampraVYrSlBpeFVGcUJTNkdV?=
 =?utf-8?B?cXM3dVcvalBSOWh2cUJKbkhjK2M2OExCRURHakJHMnY0bi9mYnVEZ3gwN0NO?=
 =?utf-8?B?aUtZczJvaVZteEdqV1RMUjV1QWkzL203ckhxSytuaWhUTUVITTJZVXFXT3Fy?=
 =?utf-8?B?R2I4NUdWODNKa1FYb3VhY3dEanlPQ3R0NEh4cmRHNkRPb0pRSDdnenNHS2U5?=
 =?utf-8?B?Wll2YUdwMW9ROFI2b01tM0xUbVNTYjZhcVRFZFlveUpwRkNyb0dSZEh2ZjJQ?=
 =?utf-8?B?am8wVmh5dUFSR1hmN3ZHZHdwcXk0eW95WU9GY05BYWxiQW4vQnZuWjAyS1lU?=
 =?utf-8?B?Q2V1V0o5MlNvS0RWbmJkSnhHU1hhTk12aitBK3RzZHV0cHp3K2o2K3Z6V2Y1?=
 =?utf-8?B?QXA5ZVZFYzBFeDVSQys3c1JOaDNTcG1LSWluOVhYSHpLOEcyREJOdW95Y2xq?=
 =?utf-8?B?clloSWgzNjk2d3VOWGpLYjN0V2l5bktFdmRGYkE0S0VPVWl4UjJ1VVV5a01Z?=
 =?utf-8?B?anhUVTFabHlBQzNZK3RQOUlNNzZpTkYwT1NiRVlWdUJqeng5N0hjdjdrNFZ1?=
 =?utf-8?B?aE43dFh5am5NdWduZit2R2s1MkgvWm42S0lJOC81ZHJhRER2cTMvcUd6MU1o?=
 =?utf-8?B?a3kwSnBCRU9yb00vUUI2dlVYK1VTNFhqaWdkNDA5aGgyMnNDYjlwZE0zMlJU?=
 =?utf-8?B?TEFmOEM3bEZiWnAvTjNQekw0WFFYbkZmM29WNGVRekdBZWJCbVJRS3p6WjJR?=
 =?utf-8?B?dGFHRUpsd3pReC9aaFdiWWIyOHFBaWtGLzhkanJYWllkclRic3VERGIxS1NC?=
 =?utf-8?B?NEN4NWVYbTQ1RmJxNGZSNnM4VkZVRm9jWDdlWE05SE1KeDRzS1J1dU5pL1ox?=
 =?utf-8?B?bFp5VHRjdWFSZFo0dkVuRVhQV2hMOC8wMGZweDZHYVBINWZxWDhpNGZqSFFJ?=
 =?utf-8?B?c05mY2dTcXBLc01hWHpETk9YUC83aS9UQmEva2cydVJpOURkbTkzUFRwa1lX?=
 =?utf-8?B?M2M0TThmQmFQa2REZ1B2STMwUStVdzBkeUhTS2hXcU9KaXJnNjMxWmprOTNZ?=
 =?utf-8?B?eHg2TDM4NzVtUGFiU1d4M2JDc3RMUXUySDdHRk9adEQrYW4rUVJHQW9FUHF0?=
 =?utf-8?B?YVdPUDJwR3NtVUtZOVF6d3RWeXZlaGFxNllmTFljR0dYYjdGKzFueG9iUWFI?=
 =?utf-8?B?UjlWcG9UeHQ1cERkb1pXWXl4cGdOUERBdzdKdGhPMms1UFJKdkhsdlNNcXdk?=
 =?utf-8?B?TFRydjR5MUNha0k1WTdlVWc1c2VMNStwd0JuMXBkV0NCT1dyb2RCR3FNd3Ux?=
 =?utf-8?B?Zy9zaFQvOXRqckcyNXI3dHdZY1RKTEtXMm05TEU0SWt0Y3FoL0lqUTRqNWMz?=
 =?utf-8?B?S3hrWWkrMlFGWDFWTGRndVEyQ2ZwQzQ5b0hvZTFJa3kzdGdTUHpPV2VmYUtj?=
 =?utf-8?B?RWt1QXZPRTNocmluYXFlK1FNQm03czUxQlV0aGR6TXNMQWsxL2VMRk82Um9U?=
 =?utf-8?B?UXA4aTRHcUFZcG1aWFRycnoxbktWd0ptazNLdXFPVkx5WWZ1MnNIWWg5RzFv?=
 =?utf-8?B?b1dUS05CdUk0NVhGZ24rdytmZ0tsQ21NU1FreU1ENXpPQWdsWmtpdGw0eTBj?=
 =?utf-8?B?WEhMdExudWp5NnpJMkJsdElNQnd6MEhPcVhkek03bDVmSVd4RTJWaVZrTTF1?=
 =?utf-8?B?VkUwRUJwYkRMTURRaWhrNEEvMzhCc1Y5RDN1NmJSMnA5QlIzcTZ6UUtMdFdu?=
 =?utf-8?B?eGRrL1YvMDBzVDd1eUFjbjI2a2tPc0RFSDhoZTMyUmdBb3V5MDlBTlIyckti?=
 =?utf-8?B?a2hqNWh5cDBnWDlaVElaNEtYRmp3QjFaMERjdWs5dmg4c29sYlNFKzNkbnZl?=
 =?utf-8?B?VEdtYlZpdkZSci9GZEV0SFJTR0tpQ0pEV2dsZUNQdFJhajFVTUw1R3VTSUJD?=
 =?utf-8?B?a1NySDRvSnU2U2tyVzRJTWJDcnpVNDVPQ3dvbUswMjRtdUdWUjJkWUhzSjdM?=
 =?utf-8?B?Z1dWS0IwV1JOeFdSalB3dS91dE9rL1doMy9GcDM2MG5paTEzSi96dmYvR0lj?=
 =?utf-8?B?dThBSkt0TXZocHhUaDRRZHhXZnlLcGg0L2xmaHk1MmV3WndiaXd2Y1dFdUkx?=
 =?utf-8?B?OUtRWVNuTEhwalMzbGR2MDV1cjlCTUNEV1VWdGU1N3FJQWJ2alBNTGVUOHFL?=
 =?utf-8?B?eCtRbURFM2dyWlIzMzhXYXVaZzZOK3h5clBWUjdhUC9WdVJncW52ejdhaGht?=
 =?utf-8?B?Y2JsMHE5UTdNdWpEZlJxMGUreE8rcWNNaGZyTWJBZmFQYk5DN1QxQUNQeDlX?=
 =?utf-8?Q?bXy6/owl7c318zwqnYZ6KRS/X/gFjMjQS2gKi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d47539-8a71-417d-46ed-08dee0e3837f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:34:50.2559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qy6ksY8TrPnhC+C5IbdQsxlsvjzTaXScVIt7Fk3ITryhSfD61ve04e+f4D/OlAEIGxjEHHQ1rJ5Fvtua4owlRw4sMNlPskSNkE1ydy10Ovcem5fBtVJmHuEpVQs8aD78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9011
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

From: Peng Fan <peng.fan@nxp.com>

sdhci_init() allocates a 512KB aligned bounce buffer for controllers
with SDHCI_QUIRK_32BIT_DMA_ADDR. In the non-DM code path, sdhci_init()
is registered as ops->init and called on every mmc_init(). Each call
allocates a new buffer without checking or freeing the previous one,
leaking 512KB per re-initialization.

Fix by guarding the allocation with !host->align_buffer so it only
allocates on the first call.

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 08594e10266..ef20e881542 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -733,7 +733,8 @@ static int sdhci_init(struct mmc *mmc)
 	 */
 	host->force_align_buffer = true;
 #else
-	if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) {
+	if ((host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) &&
+	    !host->align_buffer) {
 		host->align_buffer = memalign(8, 512 * 1024);
 		if (!host->align_buffer) {
 			log_err("Aligned buffer alloc failed\n");

-- 
2.51.0

