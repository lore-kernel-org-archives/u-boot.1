Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF0CFA0C57
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 08:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D364183936;
	Wed, 15 Apr 2026 10:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="avLlHUSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DEA83B99; Wed, 15 Apr 2026 10:54:13 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190B9838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg6h5vcfD5X5lrXXjPNhFFrJXm+PFBFzmWWm4HL3H5jQK5IdxxGmPWC/X/1eczX7iJ42kA3MgpTrEuy3DBh54r9WLOFk8iIOzzAx87FMZ1SlZLKz5vauj84hkq/95pyZ9cqoCEdSfL9aga/ub28PfPIZzpsxiMOUpAE7mesTjQEUJztvUNhA/fDryna3qunPiKa6KZ4Y3jjxAmiXZ4KM9mos2b5YGBIV5MMcVRXbS68VklLVA1BXHgM9XoR3LKtew76nlaGcIeXjn5qaSEY3CaLnJ1jqPyAzgH3BuiBetGwfRDBzL4u2CBtXADljiWDYRKwZlGqtHysU/pqIWc/k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezEabE2/eMKa0QXsJWGU9WNZwsyYbKsXm2w6g3oWtD0=;
 b=Oqp8QfjNJlHROqjrGl/XTT3EUArCndDMGg9X5QDkWry1K9sGwou8F5iNXDm4xLxmLyUTmKMh0Juql8yCFo0a8ioVuA4jIpwvbN+s56ExpEsYZa6rtWa5vhOi5LLNOugk4SbyKrGZzvQQsNyfsiQ8Zca+eFImyTXpmRlr9WWIeWWZxH89bLa+vH/J+wrKgJ1uMbcMnqpBB40mKBZv2V++0XEy+zdCdjnHQzgDes+NdXi7Y9qVv0WSIVDtsi75Fweb4Lug5Wl9Axa/K80s93MYn/dAYJE8T6SOLC0X/zbk1S/4BRtNbKDwV6+A82x/Cd/ZnmU/tut9M8fz3W97vct53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezEabE2/eMKa0QXsJWGU9WNZwsyYbKsXm2w6g3oWtD0=;
 b=avLlHUSRNFze1l/mLtaCGkFD+rre3iTFURsAzl7SJoFkCCT3bR5Nm6ixisPXU1tJrRAPbMEbqGHSGCwxn1+oQZetG/lcaY243J/A5XPhc98hNZFaCR3UVn9WVAoS9v5goDTctTazBmprv3bG7t3hKPEO0qkEELkGpgs9eNN6W2lFlEh9HFtHbV6DzpZr/1nIGaHTv4eIcWoWBaLb7pSHNhBo1Xl8nCb5fInj5snzRVNBnJ9uB9PCOG1cxDz7teoWonEo2Pa2fxo93VpABtRYdX62+OI9qqNv7y/5WjK0XcmpUjVdL7zWUImnket8x3yOdXc5w7lrGc6/o0QVRdxEMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11847.eurprd04.prod.outlook.com (2603:10a6:10:622::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 08:54:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 08:54:08 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/2] net: fsl_enetc: Add iMX95 10Gbps support and PHY fixes
Date: Wed, 15 Apr 2026 16:56:25 +0800
Message-Id: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALlS32kC/yWMyw5AMBQFf0XOWpO2Hmn8ilhUXVwLpEUk4t8Vy
 zmZMxcCeaaAKrng6eDAyxxBpQncaOeBBHeRoaUuZa4KoeQgjCFbauOyjgyiuXrq+fwqNQ6F5t/
 C3k7ktveO+34AnVgBgWsAAAA=
X-Change-ID: 20260415-10g-88ea628c3de8
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
X-MS-Office365-Filtering-Correlation-Id: e1511763-75d4-4e66-9b3c-08de9acc8ded
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: h6HPXNYlUcP7K0CVD2Wt42rys5sIwCJI2WAEXC6apoZs4I/ewR9wfjmmU4Qgw9+n3GzyCmh14efzv+Bev0zHlsSCoiHxQihazac47BavqyyDsRGl0ylOVOPMpNfrj6IJA8D9kM/MFxrrwgwjOiS+IOBJNISZ9kcdgR67PNXZ9jjES3UwWFRLvHXBedFd7GGE3EwEucTT6GeUq+QjauK9ylZ7r8RUapTP4njWBi/nc4ZyNu4qOzyrHHVO37asdkD9rTCdnaZujYZKS/zFZEOAhRDv7y9p52fO3KYbPXbrYySAeSRwpcMGlb5Z+a7fOMLtuAlrRNdGbiGqg1q7mq2LmUrlSmnJcWDi10EtPdTzYucGKUd4UKSUJHlavA6Bg1y9MpuE0qCyFUUlBL0VRWBd0AbnGok74FZbg+wVW2UovRMkoivh/PqJS106Rz5ZXxwbZIlhssLWNIa0EEQp5yv+5hGIrkBgsdbICbfbzzmMlf85xIDKjTF16Lw0qlYoYlfs3ml/6veCK3g3f89PGG8zCWfalzimIrB5ABJ223bt0SigI/KPiGqiY7Cq+odWIek4ws4CJ4uaT//Pv6glOyonC7Z3BQ0IS7lJmulCbA/FYiKKLFokEmU20kZwNQdgbyF6FRXdBNdYStguXDeFg6FYuz7SzBUMur/wnAkjctBSFvOnUicGUaLH83Mh/Xz0i0a14KwI9GR359uPlUpR4zitl/hpwiGUMCyazvbGTNSFxyfUDl//xkgZKuxwIV7obx7W1bhPQ28e1I/eN/cMbydZPLFEF1VPbSGz7pK+pEI7+5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szg2eHlzSStMcitsUFFnWmhIUUVycTg0STZtbUk4R29aRVlMSUl0UCtGQTFG?=
 =?utf-8?B?dmxlVVh4cnlwVk95ZEpHWEJrYTdSM3ZuK2hsN2MwSkVzNzRQSnZzR1k2S2xt?=
 =?utf-8?B?Mm9DWEFkcy8wY25vSjg2Vi8zVTQ5bHVySHJJR0l6SUlYZXlUV2VhcUtQZWk3?=
 =?utf-8?B?dmUzdXNEa241cktzZWtwbjd0VDFsRlhKcUJpZjZ4dTNHUmtSVkc5ck5HUDkv?=
 =?utf-8?B?NEEzdDYzc29ZbkdORWx1cXpOZ21aQ05MamlENTR2V2VDTVR5STFxYXdCUzFt?=
 =?utf-8?B?SmJxb1BNaU5RaG1Kb0RNUWdGK3lkeE9Pa1FCSFBGd0doL3FpcGl3Tlh1cFRB?=
 =?utf-8?B?RW1lVmpMbk45NlJlVGtTMzJ1cnpLUi9xRTQrK1JoK1BIRUFIR3lpL0VyNHRi?=
 =?utf-8?B?dUFCWnhZbDlyaTl1WmxDUGlicjhiYzB5ME55NUpacFNkSVRzY2FxQnNCbDVm?=
 =?utf-8?B?Z1IzNExvN3ZjeGIzVEplandIcVNtSFg3TjZWSFJVZGtCQlRaZHczSnIxK0h3?=
 =?utf-8?B?OTc5YXpkYTNxdkprUEgrak9ZNFFvelJJTUJ4cEQyWU5pUGNwOFpQMmxlRFNw?=
 =?utf-8?B?bTRhcW43RlhremVCdUZQdUVKcUFVRlYwaUVMZXVDaDRxZEd2TUlhakw3UCta?=
 =?utf-8?B?ZkpDWloxcnU2dXBmS1V4MXhrQ1V1d0lJU0htOG5ZejBtS3dLdFVHK2Z2RUVz?=
 =?utf-8?B?c3crZjJFaCt6R3AwQW12VHdaZnRTVHpFcFg2VFJpUFhZQmNZaEZnQmtmVTU1?=
 =?utf-8?B?d1VoclJDQWJPb0dsbzVhWkxlbTZNT1pEYThxVUZsWlI5UlJySkZBNXVzNlhi?=
 =?utf-8?B?MXgrakRVSzRYY1RoSTVMWUN1NEFWc0FzbDkyWVNhRmJ0N2RRRmUzQ0lWLzBi?=
 =?utf-8?B?VmQyeXd5SlFQNm12aVpOUTRKcFNtcmw2VlFia3hvQmJJZVlyQXZ6VTNtVHVs?=
 =?utf-8?B?U3FwTWIrNVFxQnFvbHlHeHdEaURKbUZxK2RiZExzSFpSaGdwUGZqczg4Rjhv?=
 =?utf-8?B?UUFhSGFKNlNVOVJUSUc0YWhNakdVbWVaczF4UUsyY001MzRjSWY1ZS9XSnNM?=
 =?utf-8?B?VGNTb1pIamxhdnZQZWwvaEhBZ0duakpna2V5ZERWSjhqVzdtWkNoZ3h0SklD?=
 =?utf-8?B?Zk42blhWNFA1cGVJdnBOb2ZZNE5MWkVPMVQ4VzRTODYvQUNSTUZOZysxTllT?=
 =?utf-8?B?eTdqUGQ3UjZnOFR6WTYrU3RiNE5KMUlzS0QxRW9OOUI0eFMxVTd1VTdKSmM3?=
 =?utf-8?B?OEh1VmkrUlVOS0MzZ08vcWNDb2c0c2JNeFFkYmVzcHEreEpRWW5UaGx1bkJp?=
 =?utf-8?B?SHNZM3p5MkprYldwRVBHdWFyek4xOEQraXVxV0QxYmJsanRNQnVnMGtHMnFD?=
 =?utf-8?B?MDBMaFlsV3VoeFJWTWJyYlZneklPWmUxOTNDbkhCK0VTK2NlY1J6N0Jwb3Rv?=
 =?utf-8?B?b3dVcUVZbDdobDFHTUI2ZVhKQ3lCdW1jZ2YwbGdRQjhCSlROakZhNDBoV2tW?=
 =?utf-8?B?V2Q4Ym50cW1IRlhveTJIR0hPS3VSL0J5NGdjc1BvMVcvblFOZ3RUYWp3aDdB?=
 =?utf-8?B?Y000TGFBdVJPeW5iU0RUWEY5eGFIS2NobDNEc09pRXhPZGNVVkVSRzhzM1Ur?=
 =?utf-8?B?RDRxWDRya3FCZjlJSlFYZzFjYTduVWFZWWw4M3lpcGgyN2pXL2lPbFhSdk41?=
 =?utf-8?B?Uklrczd6WGFwbS95ZXdVYXJrczMzMU9PS3Jxb3d3TEpUYVhOaGpMYS9yVy9j?=
 =?utf-8?B?Z1RHVllQMU1yQ2lQaDNYUWxHbnVmemY4aVc1YVF4MHBNWC9LTGkrUmlGeURz?=
 =?utf-8?B?ZU5yZmlUTGRBMWJUczBnT3Q2eDdkTHVvYXg5N3NrM2JFNGJ6eEJhcG91a01M?=
 =?utf-8?B?MkFCOU92c284V0dudFlLZFJaSThiQmdUWGZ6OGRqTFNqcFh5ZVZFcmh5MzlV?=
 =?utf-8?B?Zk4yK0N4RGIycTY4UEljc2dJRTMzV1Y2bkFZRFNzTjFUWUJJcndBZDVlbVZJ?=
 =?utf-8?B?RnlZbmk0RCtOYjNPaFZhTzBJVjRoYzhtWHRxMWFWK2pCR0NDNjQvNXFsV0xy?=
 =?utf-8?B?c0I1NTE3Uk5XSCs0VHR3N3JVcFVabnFXcTdDRGVGa0JURG05WkRKZFdzT1VU?=
 =?utf-8?B?WVFyWWY1UTN1YjhpeU03Qmh4RStadEU0dUszUURrT1RPTytFMWlDZFBwYlFq?=
 =?utf-8?B?RFo0Q1ZYb24vYThuY2g0Zm5maitPbU80Y2s0YW84UHBieG1mUUU3T3BmUHhX?=
 =?utf-8?B?VkdMeFpQcDdoOFNhQmRLaTQrNDIwVmhWMC9CT3JjU0I3d05NVEtiTjdkWGVi?=
 =?utf-8?B?MWZNcVd5b2VaV003Nk1iRGg0MlJTbHNONk53UnFEdi92bHRsOThkQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1511763-75d4-4e66-9b3c-08de9acc8ded
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:54:08.1480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYQkZQyNaUzm31bGksOXqxDHXp+YsIHhSv3pBu6pUiifkJtXw8PX1FJUkRuviHYEsJaveSuzmQ8+C/3gxMKiWw==
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

This series adds 10Gbps Ethernet support for iMX95 ENETC4 and fixes PHY
reset timeout issues.

CI: https://github.com/u-boot/u-boot/pull/929/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Ye Li (2):
      net: phy: aquantia: Increase timeout for out of reset
      net: fsl_enetc: Add iMX95 enetc4 10Gbps port support

 drivers/net/fsl_enetc.c          |  57 ++-
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 970 +++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/aquantia.c       |   2 +-
 4 files changed, 1018 insertions(+), 12 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260415-10g-88ea628c3de8

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

