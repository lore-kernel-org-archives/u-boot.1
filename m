Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2288FC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720CB83F2A;
	Fri, 11 Apr 2025 10:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LtQTnIli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8201983F2B; Fri, 11 Apr 2025 10:09:02 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E40B83EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFJ906lRXd8Pu2L+9Qo15d4bOTMq7KGxAHHtPxyXo2dIVVLIplfP1nH4ti9z21yNoNSA2hS0fFeBPsXI85YzV1gdwufX/0+hlPBnainTFPwpG65wLtdOXdI5OwFUYbI2DWkMmUnQrwc4Q9QdhH2YQvT20y+TV8/3meXqg8BYsh9Zvp85ZrrPoucKT00hzBzhIzjkDOm/f6one5MXAMtJobRr2sc7ML12gQ7gBrUZYEWmlwrquzmDzAoNWDY0APD4HWhoTE0R/oWzqZKNMkogLQGdVjcmyxes42rtrtF+IPT8rJDy7lNz0SZ4++OnAKw/2u+MJEzwQnL3Ufx88T0Q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScwxpV/e8hBgmgiufee2yZM6QjFGIc/tPT7dbGXKEC4=;
 b=D1/LEVvTCFWOGAo+XPPX6/AD32i4auKLCVjVUg/Lulkdb/AzvTv4A0JhoW1mkThneULZYTHHug8h8Yf1d6aAEuEvREX+YYg3R6MamUP1L4wm85N3krA0koSniYWfCUbnymE8TVBi74Q94dKxCM6O78n4MQkIVBSdRCY8vAnd8vwuwEr9vUHZrVFLItHVTUlrMfcFE8KHxA9Q3mnFGGPE2QO/w/kw8PMT1TzAkfwE+/HXWrCl9NDarDYbrxqDCljpCXsUmUOZVdZwALUzjDEDv2Vk/XQrYTkyCO1BlxSCijYt1C776OyehtdDV87RUAtWrbRJC5HN1ZcQGnYeAaugYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScwxpV/e8hBgmgiufee2yZM6QjFGIc/tPT7dbGXKEC4=;
 b=LtQTnIli9ebaszFXVPIc6UNv5u82/WjgqlGRnxULaaqUgdNqAPdDR1UMY3Ceh6cqsaontYimWITsgqU0Jm2GCa3teM6WicyUBv+nMCPjAhggDL+s9w4gZIALcyzlDgDxYlpwG0GZHpsGDDmQikiLn2FroKUW6kwxUylK9u82fnoxovLNcbwdUiPHd0vvomk91/la5A5DoQiBKnZGVMDRXlU3y8LNHAunLZTUqkkXms9LRPk4YuZ6c3jfsT0B35hDIAi8csZgkraOQVrbXX5DftDlc7cbftsOWUXkjve4ZGHTfvGuUC917BOzmvdn87DOwwPkR14uxckCmpx+AGbZfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 11 Apr
 2025 08:08:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:08:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 01/20] firmware: scmi: use scmi_proto_driver_get() function
 to get SCMI protocol driver
Date: Fri, 11 Apr 2025 16:06:44 +0800
Message-ID: <20250411080707.602371-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 790ca657-2331-42fe-a20f-08dd78d01b6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zaBuf28rSZjc+lGvfZLpyiBKrW8fWHTwcNJQ0WXmNDhQmzn7RVRVtFj65XZE?=
 =?us-ascii?Q?Vo3vq/43lUtN0FV6l3QyriztWdLoXEc0B4p0hFfTaUaHBvHMIXF1jHhioP+6?=
 =?us-ascii?Q?F7pW1+tyUgcoF7E7+P4tgF9Agw3UaXLvZ49L9VobIl8RrmiAvLujZgKBe9i7?=
 =?us-ascii?Q?TjcOCuD0Gyp1SxIQv7SHpUdUOKPG3fSVLGegsia8qgqBxKYXCzDAQ3Cb2Wj2?=
 =?us-ascii?Q?Dj+idEyL6jOr8bfOM2sGp0zKAVBX4P8K1BaVyaCiClzTagzMUMFzrBL9YFvV?=
 =?us-ascii?Q?uWMrXqNc9egKLd6VfpSuPT7FsHUMg7JOhroCsOh0kNPR3bDYCLVychgC7Qk5?=
 =?us-ascii?Q?3glYVXSZxO3uuQ5VTBPEjK6up03Dtn0YNXTBY42+rcC1bRv35wMF9u6RvE4J?=
 =?us-ascii?Q?V/GAsKPaFwxJiyy337+jgJlo96HJLLFdonCbrb+E+7Lo2SKsDImUiEe5dR2h?=
 =?us-ascii?Q?8ToHf1typliZwD5TMcwy7TTCdnK+Mla1N3ow+2NhDk/L9KombjBqY+29eK9u?=
 =?us-ascii?Q?5/tESWzjzfBR6PDpeW0s02aFVm6hkUk9oROGDKbGzxnV0qWJ87x/vQ7Ger/c?=
 =?us-ascii?Q?N6nur2PPpVbnRhq+V9E1KioeZx/+sweX53ItGzwa1IgjbCTjNISFUaVKwMlr?=
 =?us-ascii?Q?sDT53lTbaQ5oHzbHrUExGaBFoFthiDxArxbaNZXDZcG9hGlp9/sl9+ogwGF2?=
 =?us-ascii?Q?DfZIdRUboMgAQKeVWRQgV9OBiwho5BqTkQTf6/S2JnEKESLMiQ0DqUNWwQUx?=
 =?us-ascii?Q?MPltoGqSfkZdJoN4Vk/JqcWSDq8wGBnyNeGMDuV7s5HAeTHrRhRRYxrs6VJH?=
 =?us-ascii?Q?zT0dK/bQbcyjIANZm3I2UKsP2pbOqMu+CIm8AVJaIojzrfXXmRwM6NqwsTXh?=
 =?us-ascii?Q?fSxgwSYv0hi1cgFzPFOE+HUUoBLmIsES2jTFD8PoMs2oufsEJ/EN0Sknf1fC?=
 =?us-ascii?Q?lWZEqNU40lYm0vn7A/bAMoGWI6CuwE6ymZYxP4UUtffPZOWoYFzR50tM+NqB?=
 =?us-ascii?Q?/UmIDkKg7A5XwJvqMF4k1rPMTM+dirQZsQsyrJHZ3Tii8FySblccGnlx0QEk?=
 =?us-ascii?Q?Xm1BZeqI4M7Qrwpu3nNnmkrDGJXDRRAb92jRu08bHJF5z02KF7dTHqiCXXq2?=
 =?us-ascii?Q?N9IMGEZAbWIPFzv09UeBLcek4rBk+2cF7QAp1KT9b/VQubyU/N1hmUQ2nLkb?=
 =?us-ascii?Q?LBSViFXMofd0zVeyLVv7T6MaoqNItyqhRMlFdB+1kBXOeLRI+9QxDOHAMlnl?=
 =?us-ascii?Q?3jXfabnDORIjHklCGaS0HPGfF7KOozUw13zc+rqJ//MRarEIW/QRjEkYQ9BY?=
 =?us-ascii?Q?2dyTdfhupsTRe4qLY6yVE4d/i24Pwl54xKt8j6lRtR6fDLBQYWCIRH4qpmYl?=
 =?us-ascii?Q?My6uSeH8xj3qECjlJvp5oUGC//bfjdK1hE1uGfn3Py0sZWxBvmZGpHsvwC7S?=
 =?us-ascii?Q?yatW1QNpR9Ymc9zVhHE+DZJP24WXvFzRhRWEU8CZWiJ7rtbsf7zu7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYd6OeNwpK7iYdHt7UmiTjxbhrB/griKiUMNl33Wqoi9fys/L+FWewAm38hV?=
 =?us-ascii?Q?hNWuW53BKTCeJpECCXJn0H3mOZGuF2Kz6NloE3DNyS3CS+sOcXUEShvoY8vB?=
 =?us-ascii?Q?EvunGBGk8kejnfvP+EHIDJWXvs9KFLzjSO3VninCoY+B3SzAReQElZ7FgR7T?=
 =?us-ascii?Q?9Ityte8fPibCvWEnnRuntmF0rAen+LYP8+ETvMSeraocHHGLLKWihP8zigx5?=
 =?us-ascii?Q?lhD0r+sQM7qDMR7WofDQBfBV+v2LBk08wn/CjhXe6Wz6yqTM8A2za4xKR7ku?=
 =?us-ascii?Q?AKUKoeGR6ApgiStXCCc+aOfK3SsIFkHyhE2S/QZaa7bq04PZzeLLuATlD+RL?=
 =?us-ascii?Q?AIKkU4H/u0ZWSaf98ZUpbrSAXSlHUo5eR+MTPv4N2HGppm05JyOjCbgupxyv?=
 =?us-ascii?Q?KgSN14pEgbRtCDk+CWHUqFCUxDzD2y55mZZOCheMvBaaDRnoCnnfUwqyqBpU?=
 =?us-ascii?Q?rx8EkUhnixHrNa6V70T9NZQgxO8FNCO/ObtwgSdvdgK8QjpUkXUxTA+TarcJ?=
 =?us-ascii?Q?gaaNZDXChwpAdmOcvWNoM+pQjg3wW4y1A8YgcfLdOo1csALtRrgETMIawJRA?=
 =?us-ascii?Q?UeNpPkFa27YIQ/EJuN/3ONUXkzm5kPYWWLfnSXCwB3hTx5CLl00xImuK6HnI?=
 =?us-ascii?Q?YcJkVXD/JVSMF4HFPyAWwJfjdpI0WnhMn350h0+eNUdFS8zWD10G/lx3/6IK?=
 =?us-ascii?Q?0hrzrihy6NWuIjl9bzzZ7r5+unReG2JX+q5efqQ+dGEtLXDswpiQJUj8OOJ2?=
 =?us-ascii?Q?0PymlL8UpVSu9ul9sdNS/fPRYQHti/uV1z105Tb1UvzJuisRwgQTZcca42lI?=
 =?us-ascii?Q?/rfxTilr3NTw1ZVXuXala6bX0nkhkROUrYuWiP4jFrZ/z/Utr5furZBPRUrr?=
 =?us-ascii?Q?9l7Mp+fzonfqgASDzzpCPiPMvAv7n5+fUo1WKaJbHJisGk9JYXeBUnmzFgQw?=
 =?us-ascii?Q?5sznnd/y8+pnTo8t6A9AcEJY9B3ep5F+L7wBJSNrEMZbcy+ZL3a8bNE34+ZZ?=
 =?us-ascii?Q?SrgZKa4Hfn4ekPGuxMTT6UK4V0eEKBxhT4aTd8V3DVD0zQRVRXaGUJIhad2h?=
 =?us-ascii?Q?NQImGrL4YB6fY3H7fARW7DjO+kgxXtBZyyEzvjEmbUp4CXORqBCR2NU0PoHm?=
 =?us-ascii?Q?2ixYQFjzahMk0b+pDE1DPgnLkzuepzmKpXT2ELW5JJ2z4vqJdynWnsV4RBja?=
 =?us-ascii?Q?KkMtwSvjuVC3OuYgu8FHEIae7jIMTz+X4pat6o/y4rrBbChzFZehbN0u1TO0?=
 =?us-ascii?Q?DYPZBdrAts4Vsjl+NBjrjYhCh0DcPvlsN05g3o7SQeY7bqAGLTDjQrgNEDHx?=
 =?us-ascii?Q?+vAZSrsDCSV3MJOZNBqliZ2w8Aqc1BPCr7R9gKvm/VCgtZEMZkupBUh+bM2E?=
 =?us-ascii?Q?21VldtHUthVSZShBqs8Vb00I1Q9ezowBbrTCsFDtY/Yd66jpjZWPQA7ktNMH?=
 =?us-ascii?Q?6tVuxQ1eXX2RJ8HCZxMpw72gy0Yhwc85oa+f8TyebjW7VrUKVLms40WwpTK6?=
 =?us-ascii?Q?jiVwy9pekKbr3H9UUL6rOZbU2IJwm1U52IV0EiOrDLn9hUC3Pnq62PbHFduO?=
 =?us-ascii?Q?Rw0RCf1va8w5oLwHGp2WZ+xGQigwvdsgPZn4BG1h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ca657-2331-42fe-a20f-08dd78d01b6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:08:57.0441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC8P2msbFPQ+0VhKICGB8Ky1uvE2H0rzloggmWsGSLElIicTgZwrf6Y3z/xpnv35c7VOA/sdVMQs9QIIzi+wzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624
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

If there is a SoC specific SCMI protocol driver, using
scmi_proto_driver_get() function can avoid to add SoC specific code to
scmi_agent-uclass.c.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/clk/clk_scmi.c                    |  8 +++++++
 drivers/firmware/scmi/scmi_agent-uclass.c | 28 ++++-------------------
 drivers/power/domain/scmi-power-domain.c  |  8 +++++++
 drivers/power/regulator/scmi_regulator.c  |  8 +++++++
 drivers/reset/reset-scmi.c                |  8 +++++++
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45..b8d40cc9653 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -8,6 +8,7 @@
 #include <clk-uclass.h>
 #include <dm.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <linux/clk-provider.h>
@@ -191,3 +192,10 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_CLOCK },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_clock, match);
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index ea79cfa0cf2..cc3f31d881e 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -425,31 +425,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 
 		drv = NULL;
 		name = ofnode_get_name(node);
-		switch (protocol_id) {
-		case SCMI_PROTOCOL_ID_POWER_DOMAIN:
-			if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_power_domain);
-			break;
-		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_clock);
-			break;
-		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_reset_domain);
-			break;
-		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			break;
-		default:
-			break;
-		}
 
+		if (!scmi_protocol_is_supported(dev, protocol_id))
+			continue;
+
+		drv = scmi_proto_driver_get(protocol_id);
 		if (!drv) {
 			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
 				protocol_id);
diff --git a/drivers/power/domain/scmi-power-domain.c b/drivers/power/domain/scmi-power-domain.c
index 3cd0f075d95..e8c0ba8878e 100644
--- a/drivers/power/domain/scmi-power-domain.c
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -11,6 +11,7 @@
 #include <power-domain.h>
 #include <power-domain-uclass.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <dm/device_compat.h>
 
@@ -190,3 +191,10 @@ U_BOOT_DRIVER(scmi_power_domain) = {
 	.probe = scmi_power_domain_probe,
 	.priv_auto = sizeof(struct scmi_power_domain_priv),
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_POWER_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_power_domain, match);
diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 79db1a6a8aa..7d2db1e2bee 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <dm/device.h>
@@ -202,3 +203,10 @@ U_BOOT_DRIVER(scmi_voltage_domain) = {
 	.id = UCLASS_NOP,
 	.bind = scmi_regulator_bind,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_voltage_domain, match);
diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 6dc1fcb3365..f92a9e35579 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <reset-uclass.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 
@@ -81,3 +82,10 @@ U_BOOT_DRIVER(scmi_reset_domain) = {
 	.ops = &scmi_reset_domain_ops,
 	.probe = scmi_reset_probe,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_RESET_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_reset_domain, match);
-- 
2.43.0

