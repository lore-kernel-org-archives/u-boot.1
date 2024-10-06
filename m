Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59ACFB422
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 00:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CF088CA2;
	Sun,  6 Oct 2024 02:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lHYGZX1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CE388CBB; Sun,  6 Oct 2024 02:28:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E230088A24
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 02:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrYgFY5EF6JZp/FykgEeIUxdx4HyFCpGTpsts1zago+68Kcyp0xgHtRMIe3z0Tb1Vypi0nlsyCMLpOwmeZKZyiI3O6ZZwGDkhX7KSjrjn6QOwy83z983/VaXaWig8xntFiY9cE8t2FkdTNxJqnyX+6GAk1Pzlj7MiHvCot2tlqDJrux2p0aFz35CMm4NqClxe+43jA4CWNcDm5qJG3mP/AKTDOqkd2/LdqraZFTtGpxsXvnKnYjDq+sD+1xGpcgAN/Nrv7VGydq53TWu246mi104e2Cp9/bElxjoE9Oqbfxh1o+YjrEvpanErtsGV8vPACAj3T6X5anHiUrMLd2rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35MVNv52nrBaWNIaPWvbhi+bLmpkm1qNs/2qbpjFTg0=;
 b=SUuXPlbD4JI3KEpVwdJPqmId8xQn9YMemUBrpH1x4P/sd/j2v0ha3jWMzTt7Bb/iHJKZ0xhjfhkn8KryArylfyMToRf4Dxcf0D8tJQsooH609s1vyldnb3aFG4a3iEUlvebO5RYWg3Ee0DuoFJBsYiCtRrrb2dsqycVhSE3G3KIwphk2++FaM6YimdKM8Uf7owEp7CXc/B85JKEui9PhcpmWmKFSV0xYAmiIjQPg8lIid12Wt53MHcmnVT7YTpfw4287TNTMkg2X3xkBOeep3XE8BcZZRfL5JUsDhJFEL1QnUqrH8ZGEq3EYeXmEL5Q78dl8P8yE9hWV8/dzaCaIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35MVNv52nrBaWNIaPWvbhi+bLmpkm1qNs/2qbpjFTg0=;
 b=lHYGZX1kEM0zUmbbk8qkfy2PhJltNtwtHuzz6M7WpLW5AiDrvWKK+2dbSVrr0XBMmdJLmCdaILJt5T17AEGRZNboNLt+6HhLWYEMQXqmYk06xORJ/Kl+wDoGg+LWxwsk6VeEmcNC3dn5diB9n+nPyYHIbPtt5caPbtoEjGeiRKpXtT72IN7v1Mz8NcWTtrLSkc/qvGVo33UTUGtuFesM9PnYl2+mMXXx12/doa5z/gDn5EcS9T1NSiaTEBDukQbaB5MqFdZinCw+5BEDwJIP93MGFxogB6JSzX549VSyv9vwgkOh+34mB+VnbS2XTh/RaawCgbRWhHrIGgc6Tyrc8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10356.eurprd04.prod.outlook.com (2603:10a6:150:1e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 00:28:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 00:28:17 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1] misc: imx_ele: fuse: Read fuse from ELE when System
 Manager is enabled
Date: Sun,  6 Oct 2024 08:26:39 +0800
Message-Id: <20241006002639.2786533-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GVXPR04MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c355b5-566e-4698-5cad-08dce59dc5f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OQeAVKt8cm+CW5Cvp43+8SDUiKYDqTPCS0IvIbmJ7uKSgEFPN2Vld97v52Nx?=
 =?us-ascii?Q?duLqeef4poV/87ILxZDBtzaarpZAf/XBeUJbJrzyFvq/nlH1iKmeiiW2/eVa?=
 =?us-ascii?Q?8HWru/jj7uum+PT43zXov3RvQa256a9A4teUq5VWh7uHIh4A7bzURRT0TNXA?=
 =?us-ascii?Q?w8t+k4HK3gVeP9pXwTdjvpH62Hc/WI22bvt/lSjwB1mGZy2dSOtEBWbDHUWV?=
 =?us-ascii?Q?pHhoMG4V6YMiDn9JsD4lYE4Zea1L3QmezKXIX1ECPMggGaVk47rdM0q02lj1?=
 =?us-ascii?Q?sV2tpxHXUTYsrViina28i8WCJw4ED41v09bJcyGHgFBlYYLpzz/wSr5hjPUo?=
 =?us-ascii?Q?oIOCSTqZOh517KEXH3YazoYA1c84LMM3hMhGWyXwYfMr3JAawEh39LAXhoO4?=
 =?us-ascii?Q?KzDZdze+a8HlT2fA1E0GH5xz+4+YIiXjfGQPXe91WTu3zVS6q/m9XJuEs7p5?=
 =?us-ascii?Q?J/31MlPy+ub1+M/yo2aRIAYG/WvFBhiQyIv+OxLnP+f3cTbro5L2OKQoA4z6?=
 =?us-ascii?Q?n8F/FWnK1YIlHIMmMxVbHYvCq783CsP5yz5BgIyjYvzTzsPLnh9h/jk1nr+/?=
 =?us-ascii?Q?ZCQ6YDIY9sXODU777eTUoZTNmOK3l2L2Kme+1QW5hfWqph7EFFu3UDs/Mfl/?=
 =?us-ascii?Q?vqK29nWlMwTIMF99GOQZhbdGQB5jQ0ooc6+Xhmc31UkN2040KOtccI2/0/CR?=
 =?us-ascii?Q?Y+sZF4iIp1ZjbZs4t5NCx9sEOQEOkiqY1s+zbf5ONUgntsb2NyP+PbvHAoM1?=
 =?us-ascii?Q?eU2G8IjM8IxLp6/oOZORwslBIiYJR/yhEwQKYDHCLOkms35+Lrp0KolIXlQC?=
 =?us-ascii?Q?GRa7fu1PjcSJwpCq6FvJMuiJYt6/gKsNy/Z+RY4LVRuYqLjrmPus1tyh9gA4?=
 =?us-ascii?Q?tzUYI/CgmOkI0ldgA4f4h2M8SQQgwjZs32L9y5N+v8fGpPSXUUXMXi0ssa5n?=
 =?us-ascii?Q?f/BAHv16BMpZbrPnX8RCs/sy89hDanv89Ly7Ulqs5wSusyqbd6KtbtS5sEwq?=
 =?us-ascii?Q?c5VMt1iE5XZ5VFUxQkXq+9ir1M5L48o+dL8gWtjd/dtVZ3lp+2ggEa68cKD/?=
 =?us-ascii?Q?mukj8SmcNI04B5HLGRl+EYadpFvyDW9TvqznxbidmnwjlaSyVvTmBmKbZ2Aj?=
 =?us-ascii?Q?xUyhZm+yeUAwd1WFgs6eHOZEFd6MyBjEIJcyMgdKXRNaaT/CvAecVdyzgzA2?=
 =?us-ascii?Q?xIR/A0OIGV/KMaM9/oHOUqofgoocWQKewz5x4UM88ZH8dJnYGdUyxLmwuhAz?=
 =?us-ascii?Q?jecVeMUR647+TqeYJi8hN1+mf1Q5SGhXfEUATQIhSh1f/AOfFVjZUz0jx34E?=
 =?us-ascii?Q?ajvUHGVQLP3j9Poss4DSpLmHmx7t1JUeHVxvDIMvA0xHOQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jaz7LpiOSrHTe7plP050+OlAId9q69/J5DKwpX4XRqVTGdCL5NIezTrjSvD6?=
 =?us-ascii?Q?1gyFeV+eh2lWebvq2XOEsH8m0NIeoUhdbu4EaYh8aGgI1c5CD3LIzGDP7JIk?=
 =?us-ascii?Q?wzfe2sy98NRshl24asGMWQBlzNGbr6StcV3aG4wvACyl/OamBU2Nors15mxr?=
 =?us-ascii?Q?XVX4nVeWhVPjzPeIGOquYaEiLzpaQlfEv+wUzAeG1/ZlLQBRxn4HbcH2/DnG?=
 =?us-ascii?Q?4qgsZhmjQ89Js/CFwz71u1kXtRj6WWVFgjA5Z6pfoaJ2LsLIF9sPitDkDvjz?=
 =?us-ascii?Q?6enXEfSU5kot1yJcuJvZ71rjeT5eEs+9arvvjJbe0W9RY5T2Ce/OAFaJBztP?=
 =?us-ascii?Q?AJeLVOB7i/oF6OmNvHOwCEePhK84ayegXkj1LTUYyrUEqzJ7oku0xWWPbdcW?=
 =?us-ascii?Q?XM6vsYvkbhYNK8JZCHZeti2J1DkCMB+RweTtAP4OJhn3U2aH4+1d65P5Ir+y?=
 =?us-ascii?Q?gbFWr5gJj8ttiJihdT/C4hJC+Z8PAlV8kGFR0yUZIve6fIAoRb6TIICBalmu?=
 =?us-ascii?Q?PutgqYH3zKCGMAsRYzSJZueRoAffZ5KRP3TPsA9VS0jhskV9UW4wqzXTYyGg?=
 =?us-ascii?Q?hytIUd2Zm97qMepDyYiA7rAzxMyJeXvLz5iMYd2Qza6WvU8YeCTXATgMyowf?=
 =?us-ascii?Q?aZuoSRTiBAvgrmZTFktI59A7ApSlENcKAvVDQRhsl0gptbTnGKVCparm1d3p?=
 =?us-ascii?Q?cSPfWoGOJTXJ7V6gThATC+KI90wVo4yW7KC5lNGTzCuHPs7PYs5bIiU8QNPE?=
 =?us-ascii?Q?ifyY7533W/C5sPBsG7I3Mla60vJ62DJJNcFCYbElaHRw4owH6PIetX5J3XFK?=
 =?us-ascii?Q?3yRQ74l/ayEP7CKfD14f0nra0TGhMDyUfRexkeEPH2PVIONiVxLteUs4KyYY?=
 =?us-ascii?Q?bXNq57WQw1S85tDz6jD9gNdjoQoTCcDMZYh0AtpHNvGDhmegRiK4VC1ytyTv?=
 =?us-ascii?Q?qv8LomBDeV/8FZSQnletVZMAnEhkYWA3FNj/cj0pTk6+zFDdIrUWuq3E4Qc/?=
 =?us-ascii?Q?YYWMbHawqzSrbpt7WXqijWlK+Iqmh+cV9w7SpEiIHuTgNmehDUx3oyyamUhv?=
 =?us-ascii?Q?aPgylpO01MstlFkk72ZBH2qzeRBxL9cIEQMT5VNaKEwyTKARVaJCtJSgMk41?=
 =?us-ascii?Q?8YwKBxNjaKSbxrhf3zKxNCWZ6H5sYIzBImKGxUXk3KD8Q4o1L2YAnTg/eHz3?=
 =?us-ascii?Q?OyXLSP8R7sC30UVwSwqPShCCiLrJTM84b5TRiu+3qg+jw8RJ3sZadCzl6uVf?=
 =?us-ascii?Q?sYULDBAOaYaQ8mKLH3GJ40+TXpGP6EsC3dr7XJWYuv+tTJzAL45ErLPW8e/t?=
 =?us-ascii?Q?b2xKXuvFyVcym2BFjf1oTeNul3z4tYJpi3tj+XbehoKPkPwOtU4ZN+Yt5ZQ/?=
 =?us-ascii?Q?B1hzpLH4ThZxF+l703arfXPygZquQbntqHsXl/ppldtz9rP3BhzA4wo7lhNO?=
 =?us-ascii?Q?0KIbXVuU91sSJ/LNVaAuRScfUsid3V+gck7oCeMVxPHlqsx+p6+/7JaYAOTM?=
 =?us-ascii?Q?jKtT7zBjAlj61iAxWyag5kkwTXcO9dx1MlrkwB5/uaMbBaucNYOPPFSul5b0?=
 =?us-ascii?Q?RhyThtMNBo/MknQvTNLaC9qg7gdcMrR58rhhKdTs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c355b5-566e-4698-5cad-08dce59dc5f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 00:28:17.6501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOGWtlr4hTJELrkkKc2Zjoi3pJz+NlKTvJF7T8ROpxtw6BYmQBg5kIhct6SCWshndKGacFvZS9nA56/onjjBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10356
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

Since System Manager will protect sentinel area, FSB can't be accessed.
So when System Manager is used, directly read fuse from ELE.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/fuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/imx_ele/fuse.c b/drivers/misc/imx_ele/fuse.c
index d12539c8aa..e4314cc661 100644
--- a/drivers/misc/imx_ele/fuse.c
+++ b/drivers/misc/imx_ele/fuse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2020 NXP
+ * Copyright 2020-2023 NXP
  */
 
 #include <console.h>
@@ -246,7 +246,7 @@ int fuse_sense(u32 bank, u32 word, u32 *val)
 		return -EINVAL;
 
 	word_index = map_fsb_fuse_index(bank, word, &redundancy);
-	if (word_index >= 0) {
+	if (!IS_ENABLED(CONFIG_SCMI_FIRMWARE) && word_index >= 0) {
 		*val = readl((ulong)FSB_BASE_ADDR + FSB_OTP_SHADOW + (word_index << 2));
 		if (redundancy)
 			*val = (*val >> ((word % 2) * 16)) & 0xFFFF;
-- 
2.34.1

