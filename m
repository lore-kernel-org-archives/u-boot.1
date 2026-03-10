Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31466FD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F6A84090;
	Tue, 10 Mar 2026 14:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y8PC5+Rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B650583F9B; Tue, 10 Mar 2026 10:14:34 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D013483981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEaliBW5bCTvupHio7J99rqXCx5+zltcYF/8RIvlzGG7buJDf2Z/gTuO5q+7+fa9VhTnf2+BLbq+NOhMX8tlT6twk0S1ry3KxnA0ZT8lSmjEhqgeYNSjuwKduic9tA3w+nrjBp7yB+7yz33FQYmByAQN8m8Jf4aopgX9J7JvVRP2X1sTzAN9V8dn7zcCXXLxJInI62q2xo7Ittoof1wjTmh8tEdGIyFWMnasv0WvVDoWVzDfZVUBSOkIOz6Dpbc9dce+zMxHmrxrubxIRqSI3LQHYX9SSG7BRypP+t2JfqxPBjH+Jzr1cyA0KfWLk5+VkleuGA2C6yTV3+/8QWW8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27UQphHutMGGo38hg4TpeYVnc48+J3nS6EX+T2V6MPM=;
 b=BXQO2id61lFyE0arpNxAQNJ6PNSYD1ive7bD6zmWX5wUtP1qyt+fTr9fDhHqKJJKoEZbB5lFmrkdxohJORYBHc8hP21ETMvLgq9AnN5R274/10vFzEGWau+9F3fDWvu1KaH9f9Mtl8DO9HgTAPC1Pk2cQVfsD4MVYV66ENbK0e1ZFtI3b9bdtvZ7TQeFXA72VbdwCIKdJqgCoCE5N7OWjmkXQ+YFT02O/LVRGOgxFWs2DQ/UHcxWXtx1lL3OJeZYOEOe672eI/1AeU6PI9ZFe2J2OXJnTKzOZ0awdYOF1nRyI5Au1erD6VdA/dexOdqurD4mfOGrPglKILzQKQWh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27UQphHutMGGo38hg4TpeYVnc48+J3nS6EX+T2V6MPM=;
 b=Y8PC5+Rbnpf0T4j9vhK+buPukxkSX0Gn+7SehNulnZuQrz3FqQyVFbJRPN6AKOfCqznhyZvftIT6Y2v1stPYfKatu2260ZtevJ8KDPX1rJAj7Zftxxlf+4/G+bM8qWXE+x3dGmQXgSxEfEKQH66zOuetVJthG2gvAWo3bl/bE3DcAGlYFWVbo2hfq0ILQApZ91lSGfGYranFkxfrRO9Rjm+wWWm3fxFGbHQyXklBWQDTxOPGdiEP0eZ0f/19C+kbcl4b6v6lGTs1P6iHu/Bw00ZxwSVa43aJ3VFWp8fNaZqVTx3CvXrwEmNfstEYcAuhWWozv15bS6oT7FTlJpqc2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:28 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:39 +0800
Subject: [PATCH v1 05/10] imx8ulp: dtsi: Add wdog3 alias and bootph-all
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-5-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 00896168-39c6-47e4-0095-08de7e856e68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: eQlR4hAfWxw2V+PE95SMZfEjV5B/1g2LVApz7KMdKnsBm+ZEz6Af4++CJH/tq3CRDE9wlKQWCcKwAgGoq0AvJocrVDqKT3gCuh/eqtMtrM3hckqAonlbHewdq7KxdpTRvfIFpSwE2PU6oQE7hPis5UipjpsQGZ6HG9UDwQ0jxgU05iz6q5Kmf/JXUuQYGI61Vdcae6omKHFhnELHrGHcgkfnjw5ncpAS+udWOpPVcVsEK/x+CG2x+g10Zyg17dxNXKy8QAwQQNfx+Tk0TVxXukpAr/8LnWkQWGrih0qO4OamDFph7OS5UyI5yUwiTLUCGR9L3QMDDmQGr0lnD6tyhpBv19hkP6RM3E0A6wFOFHtur4mWFwCVqNwX4jFYCrQmgmB7nhcs07y4whM7+U7V2HpfjUXbRsU34uSbjzMBG+xBbzsZwoY69VDwm6uC6miFoicSpd/IVpAnNKzuQMSfoZYn9TxMqHCdmFrLcNOw5A8lC2tMlrhy6uOeWtiFGy8D0ZwCadqES7EVN5Yipzv74vsIacYv08nILvWXRHhkdsmHxcu+a9fL8TrArUkXJYGCugJ1aGvbCAE72sqCWKDQJCJkop0mbO8SA/Nr0s7dIp+GXT+tW0Bxb+4BKc4o2aqJIQ0EOW4bXtzst7S/fkC5ciYrjo1vGPQhCQT0DsVGi/JmBipBVzdnMcMRNAaBOKFbdzAux8nCmMjwTK5vORwbc8HI5qBcO2A1EDqZFy7zOyddY14pr+SRnINkQPhZhMnmFgyQLPSW1OWtrDhyIRu02fp0hHdfHKt+bvWhxeER5HA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21laG9iUjZPQlRKY2NGRWUxVXd2bTZHcCtCbmR3bUNZemZuY0dnTGxLbGhy?=
 =?utf-8?B?WkRsbnFCbGlueUl2dGl0Mk8zVmtsa2lxdVQxREp3WUxVVkh3TXJGL2d1c0J6?=
 =?utf-8?B?SUVuTE5OeEJzVjF1Q2ZWc0JaYTNiVjhnREo5Wm5FOHVhQzVxTVBCN1dMeDdR?=
 =?utf-8?B?SGR6LzZOdHFVcWFNejZXemd2L0JpY2FLbVNKWjBkQXIyQ0dZc05oYjcvWm1z?=
 =?utf-8?B?VzBvdW1STXVQVEJ2NGRUVXJJUlZBQndpQTBlbkJKbnVmejZWNlNjY0F6dkFp?=
 =?utf-8?B?dHg1Q213THpwY1BXL0FLM0t3S3pBZE4wN2NOUEJOQmZib1dSM3lnb24rcEJD?=
 =?utf-8?B?OUFFNkhNV1NIUU5hSzl4RFYxQmxxVTc4VlFYU2JaMTJydGw2Z2RuVUdsSmlq?=
 =?utf-8?B?OUFvdGtWSnRVdkxpZGpuNC9oWFJIS1ZKOXFSeU5MeEJWdXBpZHFlUGxSRitO?=
 =?utf-8?B?U202SHB5K3U4STd1T0ZqcmFDQ0dReS9uMzMvNWhobmpwVG1RQWxRZkZHYmdW?=
 =?utf-8?B?UTg0VkFlTThiUmc5N2UvOXAyZ0Q5T0J0VFJqNmwraHBTYVozRE1OL2tmV09G?=
 =?utf-8?B?dm45LzJENWllYjY4NHBqNGlOOTg3a2xCNjhNdkRONlh5dkNCNnJBL0NHMTQr?=
 =?utf-8?B?cmxQS0Ezc0d0aTJ2MEZ1NjI4Vk80NS9Gcm0xcnVIVnk0RE94NVhVbWtoaDVj?=
 =?utf-8?B?U3JBN1pZNGovNzNsZXZiOThpT29tQkN4UVRUZms1QTBia05qdFUzR1JQejM5?=
 =?utf-8?B?MWhaVTlETlA3SndxK0NwZzlFWkNCRDFBRUJtb0YydldRM0FkWWlRd2ViWFdR?=
 =?utf-8?B?eHJtL0ZlbWtVVlcwRFRzbFFCR0l3TisxeVN2N3FxRTJHSUJSeERGazlWVm9Y?=
 =?utf-8?B?bFpBbzY1TVBneFZpc1N1QU5xWDZPeG1PT056R2pGbkFmYm1oV3J6VmtleTZq?=
 =?utf-8?B?eWh0NlZVTTAzdnQ0V3RWcVRKYUxkU3RCdFZHUVdjTFNjUFErTFVWY1FzZVQ4?=
 =?utf-8?B?QTR5OTRablZaRmZZRHV2Ynd0ZC96RnBTcW9mellsUWJaaDlIU1ppZFhCcDR4?=
 =?utf-8?B?WGkySmlHVi9QZTZ4eWFtdUR1REdDTEpQY2gyRHR2bnlCU0t6NTltNk5ic0I3?=
 =?utf-8?B?OFU5bzhDV1I2S05lZGpWZSs4dEFDOHZEM2pSeDlWa3pCbEp6LzBEMy8wTzBi?=
 =?utf-8?B?Wms3UHZEK1BYZWFveEloaVJ2bjF5dk5sejcwY1gvMERDT2ZseWJUUWczeXFj?=
 =?utf-8?B?UXE4QWtkbnc1eFQyRThENWJ3eXIyTHNLSENkbHJqZWZLZ25qTDNiU2c0YWdy?=
 =?utf-8?B?L2VIYnQ1ZHlDT2QrWDNDY3Brd3c4dDRMYlZLbE82eWJtNjJnWWNMdGFyTnlh?=
 =?utf-8?B?OWQ1NXl1QS9ZL09sUVFjZFVnM2FhZlFQSUxIcWJyWXdoRzRjVG5BNE9VMk5r?=
 =?utf-8?B?RFIveWpqY0o2SGdCeUc3bFZhL3VwbXY4bStkNDNkOHNUdHlhc0JNcVh1RmxG?=
 =?utf-8?B?U2Z5ZE0rOGd4OTNMaWpCa2s3U05UNDZmRVdhRzdUTkVwNGloaUJoeW9uY1RV?=
 =?utf-8?B?ZWtRc2dlRzdJbjdQUjhHKy9ZSFlTQndQcmhBK2JVRnQvbk9Fd3pmanlYeDhN?=
 =?utf-8?B?RjI0WXNKOUZsOCttTjg1TXlYMWhJRWF4WXNXQkJLMTk4MkltNytHTUNoUXVK?=
 =?utf-8?B?emowcXZwYy9kdUl0eHNlUVJxam9NMFhEaGQ1Y1ZHOTJQWUt5UUIzcXluQWdu?=
 =?utf-8?B?ZUpMWkw0MGViSlhZWDN4RnNUM25OYU5rVmxyMTZsSERvSTBYanUxRTlaR0xk?=
 =?utf-8?B?UzdiRmlyNE5OM3BWT3ZRelJ6TDl4cnMzdVpmWlp6ejJ5dmVlcWlBdm8rMFRw?=
 =?utf-8?B?T2RxRmxKbkVYSHNncUdLNjVMVzFaVVpPNFN2UG9PUDQ3RXlhUWxiZjIrcWVw?=
 =?utf-8?B?U3diNmxVclhtdm5XRzJaMFN6NTA3Wm5NckNFK0RVeXA5bURUVkg1ZDEyblFZ?=
 =?utf-8?B?OGF1MVRCa3M1SFNObXZmMXNvMGI5YzllN1U1b0I1Vlg2SjM4MzZUZkYzQlpv?=
 =?utf-8?B?WnQ0cjFocm9YaXNUY3lKV3JCZTFMT0RYMzdXZjhzd21LNkkybFFweE9mKytm?=
 =?utf-8?B?TkVKSDBpbURKbkVrc2ZOQWtxSFFxWmFzSXExend3MktFeEpCeHVMVkhSVzA1?=
 =?utf-8?B?MENDUXhUZ2pNYWVNbU03elRmc0RSSVpZeUlpQ2lnK0NlTWx3eWdFUVEya0xQ?=
 =?utf-8?B?TDNDa29OTmF0TG01bmdmUDh5MHdxSWV3OXMrOUYxb3lDZUJoUndMa2RCZFNm?=
 =?utf-8?B?Z0tkUFNzNEpYTE1ZWGZkM2lIUVlWUS9RSlRSM1pndk1EdE02S1k5dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00896168-39c6-47e4-0095-08de7e856e68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:28.3430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEyypIlOsDu+BtdziQIgzIYguCq280YbtFFQ1xVsrkhXxYTi0MHDtAmzBPNou6plcY3zUuXxGOINvwGpQth7hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Add wdog3 alias and mark it with bootph-all to make the watchdog
available in SPL and U-Boot proper. This allows the watchdog base
address to be retrieved via imx_wdog_alias_to_addr().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/imx8ulp-u-boot.dtsi b/arch/arm/dts/imx8ulp-u-boot.dtsi
index 30baaeff8ef..e7312232b26 100644
--- a/arch/arm/dts/imx8ulp-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-u-boot.dtsi
@@ -61,3 +61,13 @@
 	};
 };
 #endif
+
+/{
+	aliases {
+		wdog3 = &wdog3;
+	};
+};
+
+&wdog3 {
+	bootph-all;
+};

-- 
2.43.0

