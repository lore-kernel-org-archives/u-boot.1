Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3DCFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809B588D33;
	Sun,  6 Oct 2024 11:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rlpYuee8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4E688936; Sun,  6 Oct 2024 11:39:35 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BCD88936
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuWpDPzU05ZuSd315hZV+4+paoBCGTv/QNJtuiF/GC0ZsJawjnNeXc0OmDZLPw/GK5koAsKltq4m4Dje2D71x/fKDHU4yeizlzzEt3YLlXrVDfwly8dMfwE+MD/rvmrC2Jl/A+BsueaOd0YoFPSNJk+GTaHpi1MC1Q60h6M4DUYP6vA6BECPucDb4wRlQ/xYIf0mrmp8HCMIsx8msYWGhf9XbZ8Nnb5XEL83W1SFZaEAUXqbvABEVhocgI2is2raoTjcMcm8R4gou+gLvuX5wsDuSb5KXB4x/2N6NhXYNJRTiZoOAfZrJ2QyMux2YaReOn9+bJgDEFtpXPXF9JG0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WnXt6vv0vlrXSR+5y76CFKfNWHB1O6s75Vw8c3mcu4=;
 b=HRLwVrY07jMOIpBmbhBhC8/7kKQDsQiZFXo+msB89QoDV4XEEqM+JxIcfWxjRZMzOprXzV7yPmneGTNLm6v2BMy0jlBe7hWD4UBc6uHxBtltjnk29jNTnQD0298JJSLTpzXDEobhQMtuSCS9+TJOgsQjQiMwjOphH9FFv01tWC6EHXDbS0PZ6YVLCjo1tuN48i2CK049KuPblY1PEjsonXv7e8vgxdzLiKWW2CU6k8brKxU+1DTQsj7jt0HaqK3+A7TMrBQwNibUf1EpuCo2fOfWU141iS2yGFdO+YbTSpoqaJpwBlrlwxSkf5kZ1cj6GBaqtd+OskVGAmLjDI6jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WnXt6vv0vlrXSR+5y76CFKfNWHB1O6s75Vw8c3mcu4=;
 b=rlpYuee8cGlMiHAx+iJlSGWmavtpgl/t7M8OHI2xAK0Lu8WGOGqDagv0FUsNsTY1+M11em43+qCrUaIwI7VE+j20IJ7nbFh9dGBG9ZimwDXNDJqB4zWV7Lzz0iJ1m1ermosjGmXFNUg9hDTucMpqmZg+fD3YKIgC0Px7YmrnI4t6qzmaqbrWQ/2dWeAF0/HwDfGy1bQlDb7yo+pCm7n5vhphCEMW/YMPbDJ8mfrR8fhCXoCTpc8HJJg8DK8aXW9p9qXvVU4jG/SpdEz6kectM0uBNc0ctHB4aCYUdZQ5XUVE8lDv19Ze2ICPHLzPDvOmFMHBqwq/euVkAEUp22KPQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 09:39:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:39:30 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, alice.guo@nxp.com, etienne.carriere@foss.st.com,
 akashi.tkhro@gmail.com, Ranjani.Vaidyanathan@nxp.com, festevam@gmail.com,
 marex@denx.de
Subject: [PATCH 1/4] clk: scmi: support set parent
Date: Sun,  6 Oct 2024 17:38:22 +0800
Message-Id: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b0fa50-ab36-45c1-d0ec-08dce5eac720
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VI5L+PzYHZ8nML5d3ABYc4ZFR6a3Yqs+xR+aElLoMS9N86EfmnbrSplczH9a?=
 =?us-ascii?Q?dB+q+RoXX38vdGFOZ7BK70Z3rW6SsZ3KnJ7f1+E8YDp6l98an+hlBoBkWMWo?=
 =?us-ascii?Q?3A9LXxUEH3kXlKDRaHoAyKPHsz1qFniHE0VM9WGfgmQZNpqqX16JuIyZNvbe?=
 =?us-ascii?Q?EKD+Ypp5Q6YBhTZzuNqAEI3WIVepXcbhruoJvB/iVO1ugQv81ot5UWxHYXym?=
 =?us-ascii?Q?xi/ste3gG3MTRmHhqGlx7/5o3H6zjXDX++A4ALEtQfVaN+XRwLuRpeGABJ2y?=
 =?us-ascii?Q?BNDn+vvzvN/et0vkYPcG7J8SVLVIutT3COWmZp7b++foIxyiesUOV3JPMp6d?=
 =?us-ascii?Q?sBTpjrwgZWhNTy94V/sCays/qPCC1cYQAvens7yxyz19AC8rNXP/IlcNDnrm?=
 =?us-ascii?Q?PIipXn9TSqGD6ov9P3DWBolPVoZlRSZ3HgvAOzMzOulg1DY6tRXdDaM5vru3?=
 =?us-ascii?Q?xNSbRbeG+ytbjl/2eeO4Wo4t+QlTUc0NB+gcQlRjLqVPZ0KdEdlnujrBMeRJ?=
 =?us-ascii?Q?B1q6agkhNNtNhE5oS19SUdreyBFl27uyrqTycIvHD8luH1zoR89hmNCrXAhk?=
 =?us-ascii?Q?fNU4nqnY/q4hs+kQd/KtSNECguHRu4vF3PqbvFDy5z8lfUeiV3YZ9b8RYH80?=
 =?us-ascii?Q?fJghjmrwSPbkquxBjUom1GK9rd0KPvePtX3Yyn+PtPrXJAU+Hy6Gy5OY1l/n?=
 =?us-ascii?Q?MW4tgEhO/FjS4sdo7By47nvlUSHO2RGzkogMQad//EgekpY1MxB/160ZXVBB?=
 =?us-ascii?Q?/xjbdaAaa+re0Hg8CZGytkbv/p0sPtfTy/Xvayfmml/xUjadDU9dn6hMF1En?=
 =?us-ascii?Q?/UpQhvUKe9X3H5XG1dnM3FSpUKltU+vLp8TVizQ9nx24x5q//l5ueXqF5rsG?=
 =?us-ascii?Q?C/9D/6Zc1KoRefcKhMnWl3l2CQ4LMoiPZRQAhl/dk0h1BbaabQHvq5h7jl4V?=
 =?us-ascii?Q?GIHluD0P2H8T99NIUDHSzjWJdYhainqbOEForXXFy3wWYkHtmqGptDBP7v30?=
 =?us-ascii?Q?jinQVCV8hDQ+yzQt1nytiCC/F+aloLDsz3k5I02w2oPzIDi72agUTV2dSmBh?=
 =?us-ascii?Q?mjcHnkhUjPdfaCtJrM+IKTlboK33l9n0Ig/824uTVP+isJ2KEqEOUQXMtP2b?=
 =?us-ascii?Q?XJFrz1D7R9sc0WmvEvjN+343aHWdPduVtjqcx65FY917zJiXv1VCaRCyNAWC?=
 =?us-ascii?Q?6CC/+XDNWHCmKyh53TzBzuuSOggxRDdaNB26lEPMd24qrNCdYM+IEGT6XHtt?=
 =?us-ascii?Q?a3gKlWpN3FAHXCS2Kw4nOytz5Pad89R4y80IZqQT6M4VoQv8NYbYb+ohLwiC?=
 =?us-ascii?Q?C8ME5Je5s0lmNJMVM05zEPuodOPbVjYc9aSCL3ke4u6wcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IdUpJxMqezxQ3oA5KbQb2WjwOYq5qBcH9UAtME3A8M6snRonVzlDlhWu/7F?=
 =?us-ascii?Q?qx5SmPr9fA5HUnndQ4jXjXEFWe1lXw6JpS71nuAV1CGwDiPayHXDj1CZSBEr?=
 =?us-ascii?Q?5ohc/RcCyuCC3x+BF9bxxyTRyQGo3hM7gstSfMAO5U89p2mvh/g6vwGYyFsl?=
 =?us-ascii?Q?TLdSum3wDI8rqNO+z5Uy+/jElLGDlT1cZQiqOWrJrK3ls3XCP83LYD7Wwoey?=
 =?us-ascii?Q?HB8nbPAytXvtgTGuHHc+nY8w1lnQs38Zwyy6rmZrzVbvcn/3YXy7dhgSQOLU?=
 =?us-ascii?Q?VpyZBlQyCd8UyJnh/l8IB+HnDs0hmZOqQHdOFCrhCQR0ZckH6xXtgaPhOdfq?=
 =?us-ascii?Q?iAhuEsxsm8dRdU79m/yPucVY2GmioOLM1POM7s/omfGzEPYM6AlaHWIIrdPM?=
 =?us-ascii?Q?XZzCJ57+YjEgSjZAioaIeHwg09o3DxMn6b5BeFkqsxrNxuS3I6i2CuFs20C5?=
 =?us-ascii?Q?YMvBmMiwryQKR01tq4cWwYVSNAE2FnnFOYTjdnlf64xLFWh+9Strntf9aIT4?=
 =?us-ascii?Q?JBK6Ow91296+3QGYq3FVTQfeZJQDqzmW61ve7v3cRmiyL/533lXHaFfqm0vN?=
 =?us-ascii?Q?XjZGPUnHuAeL1Hr68jmdbXKU5+ZKRzRLdAWtTuNAVVbfGkt6nlWS8WW9ntjq?=
 =?us-ascii?Q?mGCYsNbhzN5Y1iXXZi7NmB0ytrcQUQz05p7VoaH2ZGzifSDZFj5BY4oBtNt+?=
 =?us-ascii?Q?kX92XCH5RGbpuXYqnvmrOr1U/j7MitsKYR3NGHXakFV039ALPWedL7JjgSOA?=
 =?us-ascii?Q?YKm5XxQk8nV2M12jZqH3Qe+hepZSrPFI7vZqs2eV7kA6IV1iSLH7wFNOvpn7?=
 =?us-ascii?Q?MuQU6w4OQ1hjujbwPkXaY0kjE4gp2XbGNLPGWdA2E9Z5CzJaDXUoVGMjLtxZ?=
 =?us-ascii?Q?Vb1bvNlfL4fCbvzv7med6G3ctnWi6LNisIxa2AZ90UKUqneWbtbf7UoZ8znl?=
 =?us-ascii?Q?iVcTik/i20qsrtEJZ7trsdYak4FV7uZVUP1d6heQ8oWKFI7S47TvSPa4siQy?=
 =?us-ascii?Q?OzcCyBqpSbK5KOr9JCR+eRt7KjEwQQmJtrB1CadmjmLxTNwiDTdEXaw6vA5z?=
 =?us-ascii?Q?QtD5kLMFy9bZw1nI4sEv99kmX9MYjdhcB6NK9f20z9pbotVfNdAyCQTdfWfI?=
 =?us-ascii?Q?tpJAfZ254vkEye9CQZ2Qb1Aw+Elq+pQtURvOMzQKm1xxwVJAwTygtdSKFqa0?=
 =?us-ascii?Q?28r+iL4NwVtEiT648up59CATBQOhIcdTgfr7ihqVRCWmrRpax+UBp4oPD+B/?=
 =?us-ascii?Q?WcSo1zdULWnCenOa39fZJFgCtk1FYGiSSqmSKS76vqCObEQejL38rrSgQfeO?=
 =?us-ascii?Q?hcMVkmhNDH3BLuZdt32jAxnROPdHJs0EbePcWN07iWVOk2kU7Den+RfXnXBt?=
 =?us-ascii?Q?GamRBD8RSXaFE/yEqBUC3U+AuExAO8V2qfO/EuFckzO8ychRQ96lj2nc7MkL?=
 =?us-ascii?Q?cRloKQi4hRTjcsbLi6fKcNuHdWRF0FEACWSOOxJTh/xfcQq8nJJivRb1m0pZ?=
 =?us-ascii?Q?OHxuemu5jnLWfsU0K/uqcsHIkZsQQkVh7yv7I6n0TYPwK/US3p2C2NPuiil5?=
 =?us-ascii?Q?c++DkD2rMDb3CBQFFasACiYnc9SY6SaDAfXjwGZl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b0fa50-ab36-45c1-d0ec-08dce5eac720
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:39:30.8175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR0pWqMccYSVrBpnQzWA0+fIG+IMjKnON9jnQkD9H5+MQ7DSPn8/fd8sKxaev9x6+KqPsoucysMQYG5oKI9vvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

Support SCMI CLK set parent.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d4..84333cdd0c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index e52c740cb3..e1e4117e11 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -732,6 +732,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0x10
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -835,6 +836,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */
-- 
2.34.1

