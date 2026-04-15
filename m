Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74468FA0C59
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 08:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B7883E36;
	Wed, 15 Apr 2026 10:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hDsq+R53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E768E8407E; Wed, 15 Apr 2026 10:54:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129B283E36
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZEi68N1jN1i+NSwW+3xjQWU24xexTG2tENJFWU++0EErDkjmsQsyqMXFPvjQXBk53YZwH8Zu6zLxYUjkerzFBs69ho8GmMUAj4BdNYabFCcA4jLk2MEoZkYAR9D/ywYV3oJ96jFhQUUn8HRjASsQZYS3yd2kaArsQB5klp8UOFtMA0wzrseMmSgCrSN6batsPEbUXcOipvcCtypela0K0PL89RmSsW8kwEZKblnsd4ZxiRfUUFjIfYpecc3IcvXS0aCc+GeEg0xmlSLbAC1dXVzKNlesqDa1pDiPfyHXjngCN1OaOCE165NyYi4b7/1pY3jYlPnWMB4q19x/Ian2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI2t+GBn50ptFy8Zg4qvSFtrbChgjwKd9Pv3LUqTa/U=;
 b=WF+cjOlpmLI0mZEoiHK4HysmjI6G8EvreUA3A29XKGj5zBIwpNwlaTtgN4nAEnnks1hnMhSqdztgKSm97rIKRfEjM/JS9iE5gWBYDcV17o+hAR3/ZXYoGWf4R377YRFXUvsaa2HMRw/ULmUwyLxDlGGJ1VrVf6Pm+1SxW8bAh0KqrMVruireY7Ey8QBj9sKo0iFVcRgG2pb+Rz7m6O82FbQJCjCHkErZycHvtjI0YJ9TDzlfXUT6VsLoS5EHaDxTGVbqmfmVlKa+CLdEHWRn5f+TzkagieYlSv4j1RwAbyC0BQ221KSEOAZ5DxTxPMIvdewFK6qrmv6D0oLLkjCdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI2t+GBn50ptFy8Zg4qvSFtrbChgjwKd9Pv3LUqTa/U=;
 b=hDsq+R5346TBFE1FE0VuqYYVVZccdNxdaBv3duYs2s+hqGCyweA9GtlUryBHCPORgaOrlE45HIdFezH5OPy9AGVodO6KOKmg5VRl0HCIB9iypI60aZDw2n7BP18mrHYoofgokPsRFKWJMRHMpMzc5tVvXyAjImOprHrEG0m3VInmyCTkciucup8+3UH33cl3F7TvsTzwrX1T+6k3eFVJbwqj24IjPWEcvGbXA8DAwT4rTsRWGTSPGwsMYoN0Hd/WUgAOKJywRfSBQ/OHFRG3v6gsvqe2OgVcZpwW9jus9BNKoB1Y9yoMJqLUMtB9Y2PXiR44GVnsYpQLP5Eit5GkkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11847.eurprd04.prod.outlook.com (2603:10a6:10:622::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 08:54:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 08:54:14 +0000
From: alice.guo@oss.nxp.com
Date: Wed, 15 Apr 2026 16:56:26 +0800
Subject: [PATCH v1 1/2] net: phy: aquantia: Increase timeout for out of reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-10g-v1-1-f6809a31c2b2@nxp.com>
References: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
In-Reply-To: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>, 
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11847:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ebc174-e6a7-4e8e-4962-08de9acc9180
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|19092799006|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y4Bgi9D2P510LtaOEP+NydZDSyJb9lcbadjbOIYie7oQFM7Ifx0uBxbS1Rd8GgJZXquHm7QYUFbR3Qpb2OZ8ltFZ9GzgvBe6b7wl1joZN6INuoj/S8zGZBxB4ogXQd3ywwjtR480THtOMr43IRG9Kgp68vGnwkl3iQ6PsdAYax3xaOsnGKQ0I/kPnKpBC6gbtBOR8XBNSfDtPo8yZK2TYgvOEv95hNiE+oRX/VM9V5EgZoTNy6hUWyIqqq7KW53HKlK5AJWssARszdrzhfwarESdjfy2s9tOqBVuunlt/7AKadFKQDyRd2vUbVGVc9z4C7MZOn+yQ/AqZt8SqYdN9PQqt+kRR7cWQG17ldd8J4x1dI1xESxiSiFDByL99XqvSxmgZdO8CLYUO+03Lf44UfCLr77XvIPxHdW0HLaD5d7a6vJAztTw5bpxVcRVvHM/EMSMPmsL/68qkpOHtctR4wtpU6mxCRyFoNvzOAUkH/GqbP6L5MPdp74ujjUsDyDL0gRV1aBBTEI/YiKo5NbzfvrVtA3+QBVEBXIO4Q0yA/LZkK761LQ6PXVpT13Me1uP3FXR3vwSolFJmeU5embvESodXgDX5hNAg/h0zVwHRcYUcHRkT+Q4a4ns+w7vjMyqe7VwqnJxlFhcWtiym+rgi9XdcmsslsyRUubPCwMuq0xwoGOwBt921GjC2caRM/292oa9vxCRUSxV5NJA/2s+CLu16ocycB3ZUDMhtrlkUqIQre3zs+phKKro/MV2cfye2NgnJ3hjizrXgWfNusbh8NgtbhMGMrhsdwMf+P/DPdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S20rREorZGF4Q2Ntd09Kc2I0SVBnWENmRGZ6SHEyNjFNNVFObnhINExudnlH?=
 =?utf-8?B?bUlFN2FWMnFaTDhJSmtYQmN4eWFxcGpWWXp1N2ZrSnhTaUxOVy9paFZHaFd4?=
 =?utf-8?B?QTB2RU5KYkdmckg4SEpoTWdrTHJiQ010OFlGUUs3cWlpdENNdXlSMGRZUHBZ?=
 =?utf-8?B?ZUpMUVJHYTRQMldjWXB3MUlqVXFoSjJ6M3NGVytDa3ZlVGZoNlB4RG1IOUMz?=
 =?utf-8?B?NlVEbXl3ZTRucU1NUnIzc0gwMURWV0FrazJhWjFjOEZwRmNYUE1xbmdSRGR1?=
 =?utf-8?B?NlMrSVVnWXhxbGt5MmdGdkRZNzc0QkdTMjY3ZWwwUkZ6bXY1UTQ2WTFlQ3I2?=
 =?utf-8?B?YllObTZLc09Qckt3WlR1TnN1anRsa0VzTWhvdFA2RVhzOUNXTHBIaG1mbXVz?=
 =?utf-8?B?djhuMjlwUjJ3cFZtVDB4WStJUE52cDZNM2pFTEhRUGYwVTAzSU5sMHU4L005?=
 =?utf-8?B?TjYwaW5TcENxSDN3VEhIRXVPWUk1cHNnOXowclV3aHQ2bjhncXQ3OEhHcC8x?=
 =?utf-8?B?UEE1VGJXVm5nVGlpRVlSOXZmdnV6UCtkQXIxSXc4WGUxeW1uQkgxRnZmd1NR?=
 =?utf-8?B?elBnSjA0MU1qN3RqQmhqSjVzTjlZa2t3cXZyVTZFUUF0R3l1aWh3Mmx0dm9W?=
 =?utf-8?B?TjB6ZmQvTCt1SnNxYjNKRHlUcVgyUUN1WHBEelB4eUx5ODhqeUlwUStmcklx?=
 =?utf-8?B?TnplWGZFWHZOd2RHS3VwdmxzYVNudnVsdjA4YU1EK21nQ2tTV3RyUEVOUTVC?=
 =?utf-8?B?UDBnMVhPK1RsOHJaaHlCdW5qSTRJbFg4WWVYRXo3M1o2UDdjOEUxcm44T0pK?=
 =?utf-8?B?eEVRcVZmRFgyOG9qVHZlSkdOSkc0c0RGWkFmY2VGbDd2cGMxOUNpdXo4ckRY?=
 =?utf-8?B?QXNVRTVDenVZYk91dW9mN1ZrRHcvWlA3dkJpN2JUV3F6Vk1BODlYQ0ozMk1v?=
 =?utf-8?B?VnJSbWI0MHVCVFVrQlB0RTZ5SzVxRGV0em9JOU5ZVk82RzNBWTFrTlBlWGZV?=
 =?utf-8?B?aFFhUjJ6K09aakpKcGNxTS9SU3I5RnpmTjN0NXJaWGtwNzNGWHRZRTRQVkph?=
 =?utf-8?B?WjA2b1hoSDNUc0NVVVYvNWIzWVhLNllRVk1USEs1ZzF3Sy8yOG5mVDhqNHA3?=
 =?utf-8?B?Yjg1QWJOaG1HTlJVRWpxQkprRm1Jai80TWJLalcwcEpBdDlvUkl1YXJySFVV?=
 =?utf-8?B?M2RNOWhabUF2ak5WYWE5RFdDN0tORmFQLzJ6VzhTeE5xTmE0b09mVzJQa2lo?=
 =?utf-8?B?Y2tDa1REYlRTWXdEMGxhZndJQ2ltbDM2cWZiWGw5SnRvcDVCSllJZmF3SWU1?=
 =?utf-8?B?ek1OVVJBdnFKSENUckNObDdMVE1qbDZEL0JOcGl0TWhIRVdQd2Fhc3RCK3hl?=
 =?utf-8?B?Q0prQXNPVVJHTFZSaTNQZkphNUhCcE83RHdOVGVvQm4vTnUvaVF3SGZQOHU3?=
 =?utf-8?B?QStFNDR6REZjNnhvTk1SRG0rZ1hYbDEzL3RHUUM5KzFMWTduSVhKTmkrTEMw?=
 =?utf-8?B?M1lwOVIvRkxwaHB6VTFleDlLb2I1VTRzZGxDaWJtV3dJUmhyQktlQ0xJZE4r?=
 =?utf-8?B?aysySnFxOW9CMGNSanM0V3d4Y25aekVFcXIvUTVPcXh1a0NtTFBVVDZWVmRP?=
 =?utf-8?B?RC9ZdVdTT1A1M0JUQXUvcDIrUzBTdjViNEZocjZ1TTMrQytWZ3lqcUQxWFBW?=
 =?utf-8?B?RUxtaXFPTXBGRjdYdVczUCtDQVBtdlV0eDh5WFpXVXFhOTNTdGlkUVdpU0t3?=
 =?utf-8?B?b2RGcUpMTVRsMUFDODA4b2RWR01mWUh2V1BiSEkvdUxjVm40cHY1OGN3aFJ1?=
 =?utf-8?B?U3NKOERIVyt3YUZ4V05jWEpyUWppVnEvZlVPYk9mVHBNQjlkVS9tVzMyWjIv?=
 =?utf-8?B?Z2RxWWVuaXMwUmVvSnlIOEk2VEV4R0thYmg4ZmJCZzJzc3UrYlRuYWVsNHlH?=
 =?utf-8?B?UmJlVkJQWExIMkk1Mnl2WGxtcUUzKy9OVEx2VmNCU3NMaytwQldSVUgzNmo2?=
 =?utf-8?B?MVVNVDJWcmp3Z0RuS3RreHhWVzR2V2hBaHkrTis2V2NuNDJPSGRSa2lzRGNi?=
 =?utf-8?B?aXJpU0szekdhWFJoZmFiSXZBQ24veTVUclVWM2ZxNmI1NHE0RjJDWG1ndVJu?=
 =?utf-8?B?VlI0Ui9FdVQ4cWNPRnBIZTNLdjNjQjZwRGZmU3laTHhzeERVL2hlSFN2SExE?=
 =?utf-8?B?N1BoVEtiZ2IxcG5PWlJ2RnkvN3ZYaGJVWmhkSlMyU3Awa1RZdWVBeWczSVZQ?=
 =?utf-8?B?YjZQaXAwTytQeGxPSFQ5MndzNzkvUEJjamFhYjJXUjlmQUkzSDA3WmRpTW5h?=
 =?utf-8?B?ZFQvYW5oM0lhdU5ZVDZXb1NQdkdhNzhTSXJGL1JvZzdQeUxEM3J3dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ebc174-e6a7-4e8e-4962-08de9acc9180
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:54:13.9858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7S9qJh15b5DTXFerIVKjdRllbvUbWrNwejCpLu6WnHmiidjD8uN2yh9EPVV/QKlSuzljI9UVEq+YqnVyUUbH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11847
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

From: Ye Li <ye.li@nxp.com>

Current timeout for PHY out of reset is 50ms which is too short.
Increase it to 2s to align with kernel.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/phy/aquantia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 10b87dfb8ab..83da3e1cc77 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -400,7 +400,7 @@ int aquantia_config(struct phy_device *phydev)
 	int interface = phydev->interface;
 	u32 val, id, rstatus, fault;
 	u32 reg_val1 = 0;
-	int num_retries = 5;
+	int num_retries = 200;
 	int usx_an = 0;
 
 	/*

-- 
2.34.1

