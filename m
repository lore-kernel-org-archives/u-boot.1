Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE06DCD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 01:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC911882BA;
	Mon,  1 Apr 2024 03:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dsrqhOLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26E0882CD; Mon,  1 Apr 2024 03:41:37 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20E7882AF
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 03:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrVwg6Ngt/WlYpWRr6HTZvtF54eY1K5BJ/k/Bu3bb71PSDpW8vKfbkgb56vIMx6wfdPjMvyteoxKYbwLK7OSXpeXF6X14aehsOyxLevkgimXGafK2GSZ/vFktmjrV3zuNIWiOHNocuCemwZF6tpZxv8HzNhIM6hf8NzPE7kJ8bHhKD3+aVKNWmb7XsqblI/2Poj6/Po5vjdQcdes5ZOpRAIzdG4XDaiWiBtNbN17QcyPENwClFo5ST93DW67Cu1iv7DPN2OvUeX8pUU4Q4aGCk+EVMH0VWIb7ew7USBJDlC24BtMOe35PZaNghygNZ6+wXw+Y+Re6GV64nhil+ddLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX9mT2Cixw/FvQ8X27xp9mMZdM79W4midxSpWCkLF6w=;
 b=Ubgc1Lt+nmbgE70iZoyVSbIPFyuhvh83+uWSG597xYaovc68a65aZpR//6vLj3xEUbZPMk3QF1BsYkVMXneImXDOnE0lZMj7Kr19KJ/nbDphobwVIZVHk2MPx3rKFO+N2VxqPz9o916EMy8Io2L+kgWCcb8nLbPJzz5hhP9F9F7CwHVYgjEczyMwZp2JCYFQKvgz0HDJDWbZvSFVyxnHMwYZKlr8Av+smzCH/my/VLzk07xRP6xNjr4llkdxFjtMyGUMDq/YdNVOqFZsTWJ617tpCPQuC4nze0VQx5uOiY0JFm0AOk0fYzyn2rEoCHXYCWoLFLtH0h9juIHwxX8eIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX9mT2Cixw/FvQ8X27xp9mMZdM79W4midxSpWCkLF6w=;
 b=dsrqhOLtpKTrLhl7uo9Gqe4DpbyKGd4uSsrBFrKOGs08aFaGAPEpeIuNMehilk3yCNPmIA2T4EvFMzzXPAyWSwX+twxBped+d9/vJB36AQf813hECpN4bGn69M6pU2BJMeSgajI9IdPb31+XQrTssMfdiAfuBOR24HUKpcf7wEE=
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:41:34 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7409.039; Mon, 1 Apr 2024
 01:41:34 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH v2 2/2] arm: imx9: Call imx9_probe_mu for DM post in board_r
Date: Mon,  1 Apr 2024 09:41:09 +0800
Message-Id: <1711935669-26353-2-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711935669-26353-1-git-send-email-ye.li@nxp.com>
References: <1711935669-26353-1-git-send-email-ye.li@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS8PR04MB7910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iG+WWE7eRcKmwfs3hrPIfrT16DoRSTjuWWOBO3QujZ96u1P8GN28KRmgiBWP7sXOCXteJXVPqtgPo16hSt0bIZKTCiWlOQV9nnIgK2iuNYeg+liNTMP4F18qi84xdoIAlopd80wQIabmzVOB6QC0Waj31wLcKXfqYe9VZuo6XLsvH8/AcNTFBjoGYA23XL2q9jEISGo5l/PpFopAGd++QAzhDxPY06GVItftdOnosR5RW/7d/kMPXZl1P0H2pnu4NQUlgoD7SRoGuLY2BTimsWguPR7Q6Q2WQWZCzymE+Bh4TB2O18nEHhmxbVcFrBjTsTdUcfMGAhutHTNe5LHqZhYKBw1u2th9GGF/+4sxETZhs/j7kfb6my6v7p/SHF+7bzdf55EjY3C4aOvY4TVmtqoum0dbPk+HFqM3mXe6yZMrMDCrW5iCEX+K+tkjzEQdGnOEhrGtvgeuKOZSBSeHzL5cgLi+rk0Qm0dGxVbmQLuLs0FM8msVTaCOQjKjYGGpyaGNwvT2BnV9JYDzJB//aVHHxPk1+3TCqzyxaEDjwDqqw7T8eeg9QH0/24wmvbm0uL4Dvj7JV2q+mq//B2G1nWnbSlILngKo8xW0S2P8NTm+KxnWb9IewTcUfHsDgvazat0jf91mVPNtNLyRdWhBqLEnR0WuBRDwWtlEsb6BNPr4hl0m5oO9rV+ZYJjRNkSPVMiROEEmy7vfe9dvkNyezY4C5hZmo9sKGFcb4C69zwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DW9xxbmZwbjOYheSJiNIxH+g/UNLkGMvP8f316mhnU8ekRf4xCiPUtQtCmaA?=
 =?us-ascii?Q?jCbx/h8nBA+YYD5Gk5Hm2b4LKY4s/fZKNPt6vFjv+Arcc0cK4J1ZK9mKtWiu?=
 =?us-ascii?Q?aTSgjzayYMI/gkeeFp37rieeyXAS9qzApalf3K0zT1I5xavjhQ6SVaEr3FVA?=
 =?us-ascii?Q?iFEu4Jy7HmtvvkPgvgRhkP3IUFgHwlRU9nD7I+ATP9A0cOsY1YmJM91SG6Xp?=
 =?us-ascii?Q?kkepYepn6YWLTrz5EMX9n3qDFeKDqVsbis3v9LnklR9Q//NbPsV5T9aqXk+6?=
 =?us-ascii?Q?rPIaAaUHeBKQl/z62a4uO2nsjudSkv4ZCBmYIXfZNRRs0Znd1tHaFV4U8C/H?=
 =?us-ascii?Q?b1Duar/smIA6Bi6REu60JhBrlg0Ui4T5mjr5IPAFWgGy3Lt+WOQEGb6SWl14?=
 =?us-ascii?Q?Z6YQ+bjBXrPujBnql7Gk8Fr3nBor41gz56oEnpCyYFfN+0q/UHYG7MhJZvG1?=
 =?us-ascii?Q?CFJScknf00c8huuptno0kZy4scju5E8iccmhJujUuAFwuaRcbZQ3vocEdoH2?=
 =?us-ascii?Q?9PHs4KR7YMqhb99bbDBt3wnMb7xR5BEFyi/2cXkkZ3ywdzAbIbydNX3p7a3O?=
 =?us-ascii?Q?r5/HwLfUuv8qdAgkT581XxddiN7+frm1k42pELNmcTlZLRZaEXpUEmrmxpiH?=
 =?us-ascii?Q?qZGwBaokWG4/wYjCEFfOjdYH9nena9+NSEKFkUS6fM3UXGkbGPOsn7CNnQKU?=
 =?us-ascii?Q?lh+hYZJ0py9aV4Bp4J+uGPvCB7IVFlZkl6Zqeg7OQXfLZ4eP7DOnbllztUVf?=
 =?us-ascii?Q?O15T0crjXbJ93rtNBrKbqrtaVRd/Gqkr35ioT7R5amQoBcPK8DCJQYjYQLeB?=
 =?us-ascii?Q?A+v6VvPJCHMEADdtRuFFXaHjbpgw5dpBZt44b5IjWVxnWvwW3ZuJk2PbHKg8?=
 =?us-ascii?Q?RkIbGbUqWwvWvymOV5e2Vl9U5lULkukuLv/qIIa1HC7plbBAAKsFw96mykhX?=
 =?us-ascii?Q?pQPOl3xMNXW7Cp32fL59x+Bc+d4iTqh5KNjKSpKuU7CdmjpmGPkMBK4Ymdcq?=
 =?us-ascii?Q?uAcm26ouFn4VXz0Zrw2IsEv1oSo5HlQLeOAS3L/lK9OsA4+Q14Tea0QRyBYU?=
 =?us-ascii?Q?RigLVPa06RxOw4uIE8oPsQqE5pvGt31d2ue4S7n+o6Ikj5SMX+9phK2sAnds?=
 =?us-ascii?Q?xsxcFmsntII8CczgG1hF5jzYoWLhqvgiIWub+sv3PM1EN+Z6OUdaX/vFYHFc?=
 =?us-ascii?Q?98/ZP9dlk9oAVs4Gl6XXZCF7XS+3gK27mQ5ZvaO9eS/GWsSZvbQkIxqidrOY?=
 =?us-ascii?Q?jvr4CkR70RaxQLo3FhFybyaiilyZZjieFQ79wzAULWR6euSOxZDaiol7XMPd?=
 =?us-ascii?Q?xJSknpGcSlGMWWS9x0hHbmGj2WjVQjlG+/LzswzGUe0f2LYsWz9ikHzhpT9g?=
 =?us-ascii?Q?SrAWqV8r1fB6DP1Yk0hJv+wGasqb6jOVMMuKrZEqJInp/QJFOH/wT1SwJRIQ?=
 =?us-ascii?Q?5s8FV41QcmFmU60PpePBzTqkvr5AajrT0eb6c6TaTxB08Wy6uGLfzM/ozcQx?=
 =?us-ascii?Q?yHoHzbN7OGWA80Bf+S3KigOckUf3wE1E3dOyQgA+dEeHHWWQt0J0qkENFavb?=
 =?us-ascii?Q?p2RFAyBWENVYkD2Nr3XE0Evc7zepbJR9hKKHu9B4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6ef8a2-941b-4b8b-53d2-08dc51ecdd39
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 01:41:34.8068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8ObqmlrjS77XP0LIfUqnJGxtd8mlHl2rnYEcpzoYe8UYvqBEO3wFRLMvbZJwNKt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7910
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

This event callback imx9_probe_mu needs to be called in board_r
as well, because many ELE APIs depending on this MU probed

Signed-off-by: Ye Li <ye.li@nxp.com>
---
No changes in v2

 arch/arm/mach-imx/imx9/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index f06339f..15e87b8 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -622,6 +622,7 @@ int imx9_probe_mu(void)
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
 
 int timer_init(void)
 {
-- 
2.7.4

