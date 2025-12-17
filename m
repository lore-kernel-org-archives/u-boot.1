Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67FED65C7D
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393FB83B49;
	Wed, 17 Dec 2025 17:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RByIJuIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C7583BA1; Wed, 17 Dec 2025 17:45:40 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516C183BA1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV+gX/e7KYMhU0tPgICHx7NnLO5rDR9z49Z43hr9t3kRj2KTYqSYPu2u9h49ot7+a18YHgzthGvJThoZ5eywZLErn6yaZAUCg+lplU7PA7IXtYy+emfb/Xsnu7gDmWF4IxCn7ET2kZKJE910AWz8sm4dAiYZI3ZvNGzelduN4cCtdYMQw9NOFD5oQ4mUDQFf2DOHf/vpbY5LHjVu8klxGw+iLMZiPZK/rzU5Pb/vMhjoR3Y7V2FuS2jUC7SCGWevG/pYPM17Cxd2fQkWc2ptcV8Jw93+El0Hzh6cgGCmkrI7gF7CX+W/MOUqmuuR/uIF8U5t+0LE4D4DRY8LtSkNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFoLLhfCA6MyLbyIEK7dk6kNBhGVzVE655dKNXqYNBA=;
 b=bIeeEN09FAs2ULypJUD50RLrlXw/B3uJZGp/OGvoUFiLjS/yf+UbnE8+QwJye4rBs+ABsbd7jJMXiejN1NZeMbwjy22dvH+soZpiHjBbgODSe0QIMD+ulewpblSuLPrE9WYvIqqUlyRdenBixT7Ocs6Is4q0D9CxUEFhO/nBOY+WZI8vDLGdorIDLjUIAnYR+nxmTPzUs3qSia5QX0I+U/y9/nkFzk5oysdBRsjUkmoYsyoTGGkQaj2OD9jghdgrGEDz6dem18glM81DId0deO0eKOvHlDIVyDCysFud7re/U2Sc0OsKnr4jdVh+WU4BGxtIxc6b7A+J2e1dgVzAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFoLLhfCA6MyLbyIEK7dk6kNBhGVzVE655dKNXqYNBA=;
 b=RByIJuIxF+WZMi8tKOqTBCdcgpWM9UxUv43V10vFmte8COQzBFwT5gbh2b9GKpvI1wbhI5Q9cRI3a0vzUwpee46Mta0D0pABKzQ/OSsRw02Da5IChOxRobLQWR7liGgCtLnmzXnPbxjmi48yz7JlwnTA4EJ0eR59916OQYEhgcE23WDNKz5V5jy/ySnxVG6cHIYgDvgEq2CJvo0YHwOdA2WzLM0kp8FV5UokszgOywibuBbxxQ1aeF+dPPETp3RKX3mIflA1ORiaZ+PtY7zCi9VNF91oDeGz4oLuWP5DX0FTo1ZOBWuyWLmwWrFllVFUbAfrPHOtWtMMsYm/guBz3A==
Received: from DB9PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:10:1da::30)
 by FRWPR10MB9289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:45:35 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::25) by DB9PR05CA0025.outlook.office365.com
 (2603:10a6:10:1da::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 16:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 16:45:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:46:22 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:45:33 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 17 Dec 2025 17:45:32 +0100
Subject: [PATCH v3 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-sqqs-v3-3-f3405fb2ad1f@foss.st.com>
References: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
In-Reply-To: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885B:EE_|FRWPR10MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: b0de9a4e-c9ac-4b31-8759-08de3d8bb38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXYvUVNzaDMvcUdBQ3loOGdsZUcvaEs3OTFIRHJhaVV1Zk1QL3lkQ3JzU3l2?=
 =?utf-8?B?SHVabGdUREhQWnJ0ZDFtRlFXTUlReHBJK0RkSkxDWU5ST1pDZFRyN1VvQUVC?=
 =?utf-8?B?UWRIK2Y0cFJlWk92ZVBVYzFKNXNaKzdwYW9IQlhmQUtQNG5OMGFoM3JNVWdl?=
 =?utf-8?B?TGtyNzFaME5sQVdlbm13QktyNVQxNU1FVEpGdWZSd05pd1lWSFJYZVh5YWpP?=
 =?utf-8?B?ZnRWdU1obzYyUnJvZ3dYQzhwc3ZEWnJlRFF2VGlvWXNkOVgwamhPVUk3UTVN?=
 =?utf-8?B?TnRCWEpQM3Q4YzlONGErTnpNQjRwTG1EcVBwTFRtQUxta1RYZ2sxbnl1ZmN6?=
 =?utf-8?B?cXlidTBKSjBtRXdiZ1d4akVhcVR5ZUNiY0I4Wkk4QTh2eWNWclBhNHo3RWs5?=
 =?utf-8?B?VFhUc1RVeXBiLzdRUllMeHh5ZTBXUFZNNTIyTjNVeUZtV2ZITE9YNWxSWjR1?=
 =?utf-8?B?NU1naVpIVDRvNDZmUnB3NFFYNG9RZTAwTGtYcVQ1MGQycEdXQnNDMzdHSFdv?=
 =?utf-8?B?OXdkOE5ydXhqZkI2MldoQXBNUytBM2x4WmVaYkhwbTYzSHZDdlpQaWErQjZ3?=
 =?utf-8?B?L2hMSWNBMTJMRVBFMGpsM3BQWE40VGxpdVBNa1Vkbm1velNSMUxCekdnN2Jz?=
 =?utf-8?B?NlFueEtYSnM2Nmo2ekRLR0pvWGtyZzJRamk4SWpWN0pLYWk2d1NDYmtQZWJT?=
 =?utf-8?B?WGlocVBiYWc0QWNuMURScUNrRWZmSmxqSVoxSmhNU0pxRk4yZEVrWFBqbU5j?=
 =?utf-8?B?NE1DOVVzdWNIOFBUcjJvWWcrMm12Mi9PNkVLYk95SDZ5RTRsbXFHaXUwSDl4?=
 =?utf-8?B?bytYeDJMT2lZdGMwREZ3RFRmYVdFN1BOYTBKUjdMOWMrNHo0YkNJQUZ1d05l?=
 =?utf-8?B?NHJtYU9wTDA5Y2NESmNpTGo0RE5TaDdpaUpxY2dDd0F1RGV0SkpBRFVaWlhI?=
 =?utf-8?B?eXVtZnJKczJ2dktQZHZJMXkvV084VUZ3ckpwU0xpNzg3bHA1eitDbjZJNjFj?=
 =?utf-8?B?cE9pQ0ZWdEZKTEpBV1hHdlV6THF4aDVjcnp5cnNXUVFQTEwxNlJxSi9JcXVv?=
 =?utf-8?B?alJpYVU5SVlIWUVGa3JNbWJsd1BBaE1XNTRTUXhZT2VQSDdvcmNZaXJzNGVp?=
 =?utf-8?B?NFFMTVk1WGdCSHVOQ0d0emw1Sm5GYTg0UUdSQ0VHeUFSN1dReStvV2lvbzQr?=
 =?utf-8?B?YUhkcjFKSU9rSENmRjBHSm1EV21xRk40WGxrMVNzU2krT2VrNnpoaXlETG5v?=
 =?utf-8?B?WmcwUFZ3dVdKNXlxRlRUZHBhSmJqbU0zWFFhT29DYzdKeE5PSDZJb2YrWTc2?=
 =?utf-8?B?N3BCeURFc0F3Vi80MlpZTThCTjBveDIwaWxYUnMzWHZjZW8xY2NuM2V5QWxO?=
 =?utf-8?B?a05IUXYrTVk0ekRISXVvdmluVk96UzBFVVNJZVdFWXFNQU9WR1pnZWFRUWs0?=
 =?utf-8?B?TmRLcWoraGVJUDdLaHVRWkJRU2ZiVVhuWGtpOWl1NUZVdEF0endTNzJ5RFZ2?=
 =?utf-8?B?UG5MbHJIdm50a3JZellZeDNodGpjRW5wc2wyL0NwWUVvcXpEcWlIL0VibVhH?=
 =?utf-8?B?aVQwT3lTR1FBK0ppZzhXcWIrRmhsNW5wajhmRFdRRGhiczBsSmFoWHZIdGhm?=
 =?utf-8?B?VTFvL1BqcVlpR3dTUkhqa1JIU1NSWmRFcmlEYy9TSExucTdhdVZDMWtOaHdW?=
 =?utf-8?B?OVNtcnh6eU4xK1UyYzV0L3NaYkM1V2pIMDQzTG5kNGEyQU1rVVFIWlJ2eEdj?=
 =?utf-8?B?VUdCbzlkMHNXY0VqTGp1VzVqcy9LeEx6U1BKRmxtdXdQN1owU2hHdG1aVUVn?=
 =?utf-8?B?SUMxcXpNNExjYWVHNWpIcFFxdHF2QTc1QUUyOXZYbUIzWGdFRWcweTJUaGRu?=
 =?utf-8?B?dUlHWEVIRmUzSXVkcHZBeXMzZGNrZ1BFSGlXMnIwMldYTS84cUNUTXpKaTNL?=
 =?utf-8?B?TzFUVjl1Q1pVRnQzL0dxaVo4WlVlcVFIS3NYeVZSQWJDSzcvRnNFMktYU1ht?=
 =?utf-8?B?VjVBamtUZENmNm9KZStrV0VTN1cyUFZSQ1ZJenFLTGVPMXRhN0RmTGJscC9l?=
 =?utf-8?B?Wk9zc0pNN0oxYzAxRUkwMUJreXU3Vi92UVp1c3dZMExFbERRQithTlpFalRJ?=
 =?utf-8?Q?JafA=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MxzdhS/o9IT2c7dATF9v/nwPqPgdJ9sRvPfgFZbL8fkxBUiWWU5Cxc2VIoVwCLhUHQYbE1KNcxpBy635mnK/38+HPuU0ENaTe1rmWJU/J0MVixUmsDCh8THRetdF0z0K2E4cvVoUgxUrwLikuYmNGnVQsxqaoaD/2oZc2eBF0wiJV5fZzqALjkBamNIBUQwTyp9P5a8PZSlVh6gwYcNXaMHH2iXrBId8Hbbpd1p0DppI/Q1RkoHeT+DkqlBgX+SDkSBgPEDZptv9A5uvFLmPeNxuHihaQ+Nzkvnag372SF5A1DP8pQHbSEfd3vRwYOK/12lXNv0qry6jLg7OWH+pl9TdrZo4/KTKj93XCjFkm7YRgg0Kk8tEo6NTFK7bvB7c/bZAPs2eR9J5Akq2oN22ZRXbZXBLUyMjS+eUtWMojXZr0T0Ob4IrLcVJ2TjsMWtcaSN8Bq0EkILb6qb0IgHXV4Hhzi0PhBnPAKIJe3dFFCqDyCsOm1MI3B+2m76Odzf3DYteGbf/zJPqm3a6HOd/dfaKdYIEwxZjWG7f9qdNaC/WhAyu/pyqHCfLYTJjSCJQzufdUIKX8YVeWqY4SOad4T2JsffTki4F9ZfycLg0UWUE14Uwu6kLE4uHwLtONy31xVPE/7r8p1BkNJjS6uIDls3ZTZ7neaouS4J3MVFVF6vAs7nEbAF+klfjMJVti2ISix59ZeQ2sAn3TmCagEoxEw==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:45:35.4102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de9a4e-c9ac-4b31-8759-08de3d8bb38b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9289
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

scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
Remove first call which is useless.

Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 3dcb18a7664..9f311b6118f 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -343,9 +343,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return 0;
 
-	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
-					    &priv->version);
-
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;

-- 
2.43.0

