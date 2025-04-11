Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2141FC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7000B83F59;
	Fri, 11 Apr 2025 10:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oJC70bgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C91983F56; Fri, 11 Apr 2025 10:10:44 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389BE83F53
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/6b+4eplbDfygju78uVhB4UXh1AnTG/FPopyL8/nL8PFWnki4pFnHMzQ84kNF+hjsBsvCVw566rSTnWCFTv2wAKL6FYRocxgYriUzow6UAKseQjEGWOWJnKeBih9BaKYoUc1ciKXewWHSGj7A4jZRIMqDJWeuM3F3hMS25qsOBuH1kMRbBmxlQUVnuvJk6P3USagLauRMAbK+JqWR8BIbmTOI+FF8cdq4BfKHgkn9SWkj3v+ot598J4AD2de7EYGgDIntMnW/NJRLF96QFrfyVi8sPHOT70H4wWJjS1xdZD2zLOP0OnzmgN7MElJRn5Tok57KBfS95Gt3WHH4k3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/s75Lq7okUJPN7Y3SZFrBIeszz43Q8+vmOUxRhv1b0=;
 b=Wkqh3wFPrajzgwHE/uhiu0/9JMLTXChnp9JQR08/2U4qLxkb+8ER2IUE320xkBM8boMx8T5DZHtpxS30PHWyY0SSz83cxFIQ9DEuZ6L0nSuxO5j6mtS9tfflORJsg4UErlXEgUAtGGzy+ST4IfbYKmRy2LnmtmRMLn5niSbp7Go4EcwrE30Fy8rinnwS19aoUiljcPpIA2E7vQKeiRaPqqP0YM1hn0sKohmaJudaqCIpAJFvS0Ut37njZ3+F6gyMYD5rUCZgjiVvsXt4a/Rs7kONsl3y0qwRuA1fTtzkEMAdSxyRkRBhs/y66zvmyyfff2ue2FH4BtKImc4kw25N4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/s75Lq7okUJPN7Y3SZFrBIeszz43Q8+vmOUxRhv1b0=;
 b=oJC70bgpNnUXsKuypUGHrybQzQkeu4nwmiAFx45kcWPUDBQPG167+uXxUD5zDx90FOVwjMn6gkO0xaakq3b55Vjtsb9ZVZK6Xl7CfeQn4MOWXmk/9f25r7at/3an5WbV2zbz1g2u+riQdkMSZFeg6sMvd4rkDZLOPdpjzJW1xqwqnXtavOhFXDBmFbRtxMDV7H3qNpl/a7fGJHnAG34sx1u1EhXdaJegcBrG3diZKW60lPw76hj/qHrVBG5hM0Ilhb3y12oj38Do/ssxXyS/AbAhlmqO9p94b7pgNrX6QWXRzEWUAHrsUSj2CWxzqq1/UxAxHMzoA4ifd3OYthCX/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:10:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:10:40 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 08/20] sandbox: add SCMI clock control permissions to
 sandbox
Date: Fri, 11 Apr 2025 16:06:51 +0800
Message-ID: <20250411080707.602371-9-alice.guo@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 23271fb5-0872-409c-4ee5-08dd78d058b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?12y9JyWxTXylbAOsenE9ReNH8MQZReH7i48PKLyt9W3iJpgFrO5WD27yBcdp?=
 =?us-ascii?Q?dh0CYvy1giYsss2bstp9FOJ8FPIwAHX2XKk9z5+jYie/0WRdPkuN+9Mv7e8I?=
 =?us-ascii?Q?Q/Q3GUhZSq6NbjnPFdgQosXEFDfsWaAl+t6UkAM/MdSea52ewyRUmcq0nHlz?=
 =?us-ascii?Q?plEwokoO8sd898DZpRl9+p3fdayoF1kiN9B6xhKfFagjP4Be+W9kn4hKP3UR?=
 =?us-ascii?Q?5PNkk+W4kCL5XAnc4aB6OQ3MMW40xszfcdeUqJ30BIIG2gFkJWlLsZCF3k8c?=
 =?us-ascii?Q?2V4vCIsb2RRjs6+uiKEAmE7I6t9HRx8I+0FMLcMFo5ZjoL/a2c/MziYIlfn3?=
 =?us-ascii?Q?N5InfDCTdeMLXdOsoqWBS+ZcoyJuyx0nsaY9a1PK2cuV7L/R3JfgjnqxCHJd?=
 =?us-ascii?Q?iqg3M3jeLlw8gXqhf76S0Ha6CGeBVnZGuTYCZg/FBA1wGvJJ7B683Vw/HbGR?=
 =?us-ascii?Q?HJAVdcUh4HEd3uTvtrOHx1J2PKsRGpTqAaHQyExIaNyrOIEBb3224Uhhp0dx?=
 =?us-ascii?Q?vS8zR+hma2RccsXIlFHY6uRwZj2hXWwUfVGmShomoz1QAjPqNGxAhtNwxPAC?=
 =?us-ascii?Q?vPhcBi+GNf8FmiQgunoCc9AgHTMrNKb1LCbNrERdxR19CzQTLgp12aYUm+kh?=
 =?us-ascii?Q?o/uadzvmXgtLo+vxuOWzAaKPynWkWbDWXkkgoXJ7r6ilKjgcBBV4dIedvl/e?=
 =?us-ascii?Q?qmmYyF2J4L7vC9lKHcALMmqKyX9veDlpjVr3EeoPJukKq6PcTSMjRx0bHtgi?=
 =?us-ascii?Q?6qyOdQmSUaFyiyPjNxrB3jMtRzifbolPx9DuryVirZgHsoPkS6CNRVcW6Yn4?=
 =?us-ascii?Q?DDWvcTa+hv3moLUfLtaH/DvVKvDbZ/dZ218FlXz6lhlOpYujFWWp8eDjxxXZ?=
 =?us-ascii?Q?2r2W6g3lgHn/4GmaUOz/VGViy0Q1FrJVoX9gCCgJGPek+Hbobyek5LAWqKu5?=
 =?us-ascii?Q?UmCrsTQmPi/EMg57kTCf0uNAK3F7UN/Bhr4pcQQS+6m8Y2h25i6VbuwnUqgC?=
 =?us-ascii?Q?yzvWuIzS1rWT7r10QTkJNrZ6J92jQtL6JWm+zWZobaChqoS6URNSqceOjP1H?=
 =?us-ascii?Q?pqcdyrh94M9JjwnFba7l0XG7cpAy0IT+p3pGG5BE5eKewXZVOP2o6nTsf6NT?=
 =?us-ascii?Q?dBNg99GQYWGPdDCeaNrfN4UMO2BU9nk99uAT3QQevVUrjMbO8iK5GqFoQBPV?=
 =?us-ascii?Q?OS4N60gi5rs9Pf7yYqaWUH22BEAU8JfYnqxx+XgLvdxKB3UOe3sV8vhAGDXd?=
 =?us-ascii?Q?cfYN1szjJOHMVxTVUcAf69xkRGLg8cpJxjC82A721HN6/T7N+bhvb4zcX7N9?=
 =?us-ascii?Q?jw4NxpAi8DmJB8M06KdCekolXP2dcEpikegXRAPTtfw3GFOEeC7USdm8pU9h?=
 =?us-ascii?Q?lXvIYhCgQDWiM/3V8YSOsvK/WXEddyM8gYrhtOcjNDPC8y2O75cvfCqdEvYm?=
 =?us-ascii?Q?WmsXSmqBG8FKp3VOl43vUDLRWItqIjZ8HleA4OFR3GSOAlRrrM9RfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xSh/VcW4yEHxBobxW9fXVciU4G3/jmW9XK7sAKR52WSxAJF+s7dZlLom/3u?=
 =?us-ascii?Q?xjb09xjUi6t0YJjBKH62ZLx6Mf5J1sPJ3EyHlNFHC1PhONf06+PS+IYSuIXu?=
 =?us-ascii?Q?HGokL37yaxN0q+lzmsORU1gdUTyVwjxSr6KayoQnOA03IhKM9vWYj2Bc+LVV?=
 =?us-ascii?Q?wv6Sp51Mk9/tHAPW4pqqNWe3oP1HWofFYv5+5/3NzhqEowobzncbAnNaH33w?=
 =?us-ascii?Q?8WQe2+oZKEw8jLnIgc6nu9sk2mB6HevNgBaPcqkcBHMIUnFn67vbFZtsYVFo?=
 =?us-ascii?Q?AGIvcktpxAFK12oGlSlEYZ1boMIxBuKXh5SpfDso1cw6DeIdfGZZNdLH6t2k?=
 =?us-ascii?Q?FMtjsvS7dEe+8GZK6w2jJqH6IIhjMcIDJZSbjitqsS/KrrCSjmFvNfKAIn0Z?=
 =?us-ascii?Q?npZQDnath4DOZ47BG81zINM2O/LiByzsrx8fuP1u+QMufogWmkpA98I+aN3m?=
 =?us-ascii?Q?B8/+vie+d53YWRpgUSOzX5k9k+9kT1R3WDqIav3aO9dJ1FVYosDeMnvNjGNJ?=
 =?us-ascii?Q?COAPHHvpdgnCMtcK2H8SgM77OaRXGNu/d0/6OToFgC6ad/UaHIItfzJL8AcM?=
 =?us-ascii?Q?BnSA9ZAP4s40uxCk0V1upm851fEWtr2Qn2eoNmm97O4O+S3nZOqDYo/WreZg?=
 =?us-ascii?Q?hLkiWNUy18hGwj61KG/pZ1mlidIC5N9+kRQuScmrxZZfeLZbB1Pv3liW3oWd?=
 =?us-ascii?Q?gMHTIz8SNzUSglJMlA+tkmLJeJIDj6Zl5eFa24Tm4Z6/Iu5PnwQ7Q5o75m0m?=
 =?us-ascii?Q?x3CfKXsPc5GcE/xyzsLD5s3CNU0PqbKXklYGI+3uV3hSl3osXwRzujByvbzR?=
 =?us-ascii?Q?FfL1zQ/b5vb244Y4Lz+yae/tff2G5Tsqebn6D2rp0Pwu1X7CcgCv8Si2qORs?=
 =?us-ascii?Q?UMAC/46XP1WSWr6gyTnL57W6SUMRQiBMz2/vW9gwTLDvnOb4PB4rWOt5/CMu?=
 =?us-ascii?Q?X2XjhEft/18/cK488vCFBur97XwpaxuepTCvBHXuekesOwuCQRT2NOnxjxnc?=
 =?us-ascii?Q?vDDwfjBlMPyxqTQjvgYSzmNVShS6TWWO7mVfsQ6dnNzBzg9Zu9cGFZmPPEAA?=
 =?us-ascii?Q?Ho6mPznrITto2Wy1D0fMgHBEDXZIctWjHrYzhwEsY4tjseQoqM5sckgdEQ3s?=
 =?us-ascii?Q?FsXYgSo0alGUfGsGpR4ukwZTY/3dAqFrjpfLhQlafxEBNUXzGVz+nXOjHE03?=
 =?us-ascii?Q?w+PHE5mzGYsW/kQmSAp7Y6vM6V70SwkRpx3NuAg1lwz5MBrQ5a4LdxSiYSSk?=
 =?us-ascii?Q?EigF23m1AZqDSfLXJA5shy0fywYKP+HIrsxpkKFIhMQlT0XWwWzP424PNBMF?=
 =?us-ascii?Q?uSo13c4uoXeptefVfUKzT89k2XzLkEjtXlsZ6OodURrJ7vdKe7zv8IbvYyqs?=
 =?us-ascii?Q?Ip3xqbQnJrmPHk0i30yLN1+D54j2FJMFcVnuHQERP5wRWjmeHW5gJGrda8Rw?=
 =?us-ascii?Q?E5iI70jX6CYYMKsaj2k/2/9byDlthfZwtu1pQ1D+WNHDYjY6lgsMARIxHN9m?=
 =?us-ascii?Q?ieJRV2VEjgfgI8CO7LXJJi6f2XKJoHny6Wa4ZQc6zuIPKZNLldn6j3cN0yCo?=
 =?us-ascii?Q?qEnnn5yzmkNsNHuUFZXwl3hGYgP8E5XaWSjbYa9X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23271fb5-0872-409c-4ee5-08dd78d058b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:40.0414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vwN4eaoGi7/GbzraDkaDr2J2wEvP9d5gBuDcC9Y9pDRSGYCzd4cMnt0AWQkOzxxW/hREghlHxq4x/8AiuwGHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 +
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098c..b30e536a357 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44..74a87832dcb 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}
-- 
2.43.0

