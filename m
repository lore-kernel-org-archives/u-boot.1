Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F18CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27DC832DA;
	Tue, 16 Sep 2025 11:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fqduGhID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD28803CC; Tue, 16 Sep 2025 11:45:34 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D92832BC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq1PP3YqkHQ1Pql6ukdg5gCKfWiZGuSXTwKZ0T+qaCtDoHGkARFtUWw91UFQFKFLFLgu+PHmC/mLz00x3XrvNHBBeYBerWfaK1pXvEPdxaVb5RFAGCE/KylF0w+fP7f/saw9k7RHr1fRNOVS9BHRiPl0HgEZhqrpZZvclC3PXlVcTkh+DaBJb/tL5d/sAmiJzpeuW21VUiEy8NZnkoLewPmPXsHo4TD12MZcrQ0sg4ZzcbMIgo49nr1thEUeGDMMLiUCF5K92ZFIheGccJ7VGu7fNn5Xvxs6EHzKoT1HtNIBC/bRZ/4A0FClheCGgKv+4/eqQ44Q1F2P7kux8ImNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8As3EncGDNQ6j993Uvd6ZU+cAlwf1vv5WcDwLfR2HKg=;
 b=WZHDwmmBtrUBOxiqh0yPwHbwewroHYv9ecPDSd54/cQeOVnonuaQ4+5iG9SyEcvLuQWsHQDjJ5/ljvQaOtUFXI0qmtmQ93FFP7aZ2A1RiJcdCCN7bTEkUPoi3i8Im6pTp/XabPCuFsNRan6bt52olj7mSa4o/VSRQfUCevoq/ZAC6h35sTxaOJwnT/bzEIgXJ7iKxg0akZ+VLxmDJ1SzRZw3o7rlzln6gxYVryssbobQA+UOD/ty7wOoNcYvt7t/Db6ikWw3uSiTM/Q3uaJTkygIzAC/9R3oGJ0yRD+f7P/5JLOopgSqpFpkbTC/TyvmETxJhgILlrQ/I2DfUUs5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8As3EncGDNQ6j993Uvd6ZU+cAlwf1vv5WcDwLfR2HKg=;
 b=fqduGhID5ax/1WGyOsJtJ7bCHL/5EU+nOKq3v1e2Gyau9+OZ8yWfMo8LH23ZHnKnRYyK+JP+2rdpDMNZPtxEO8cN3b5agM/eEg9hthdYZEPU0dUjxqDvGYt/cYTKJavk1QRhEgn4Tm6xFSaL4+sG2soUtSWcNJwt0doXe4jgg3oAJ/XURKT4Lm1SiLDrDktT9eOayVHk5PvJFxye81fH+EV7kgTpQGNmhEDMmNwE1JkfLFCsHQtK9sepdppzvPjNr6L0LOcHvpVoBfrKzEDlAO/R1B8IUvXQwsPaslbjRd31tV0cH4w4It+unf0cyatDboJcogpfVeNB5TLBqYp1OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:30 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:30 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 04/12] imx9: scmi: Add i.MX94 support to get_reset_reason()
Date: Sun,  7 Sep 2025 04:37:34 +0800
Message-ID: <20250906203743.3352805-5-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c7183b-02b0-47a7-2571-08ddf505c619
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HACyW/avfPgJdUhoyzJCESIkNIVfi48OOfwTx1Gd1qdSTzqZMiDEmQqtNfeS?=
 =?us-ascii?Q?8AaDvCtl3pI37dtUKXkKqTE7zn8JCO3PDHPvTJ3WcvgSK2RCYQcwinTPPZMY?=
 =?us-ascii?Q?6eisN/MAXcuQKXmeic6dSbRRJKw23iqSTMBFWLfLZHH3L5SOLJHoTY7D6w/K?=
 =?us-ascii?Q?RPqE6u8SHxbkJZIRKAuPEAW/LtYozNzbRAR8ZzSSM4DG9nQa3UA8OA8PIyTW?=
 =?us-ascii?Q?vG2xMGebjWmWY3NWqnnlDR2Q+QHOtMOmLxAi4cGFnZPLkdJc1CNAgDSkzyBt?=
 =?us-ascii?Q?cHJ6U5Zsixx4q1BBiTqeP0EB94ButsAKhL1x7Z13MFYg1CZZZBMGz22m8A5m?=
 =?us-ascii?Q?PHvT5CB2ZzxevBDw4Y0YDkdnFO69IYh9LrHAuS0VmWu5907p3OkC87Ycsby4?=
 =?us-ascii?Q?EdgsZ4stQak5w6SAYzyhtxccCusB682AwSPw/WT6tMEZGMBrih1s9FprS5v2?=
 =?us-ascii?Q?sryNW1y8KjpMEMuZ84wgYFV4DKwpxNfhj7XGmLg1QMA7/1PI3VkS4R45yUlK?=
 =?us-ascii?Q?kwSEvFgwVV1kc133fOJdM7L1vUmbFBmugM7s8r9a0SgUMxy0L91JmSOvjrXV?=
 =?us-ascii?Q?6vKCHyirtMohyyRUqWjmWGdU5zqyxqPegJUKPxJxOQagAwBy6pGI8P3i0U5r?=
 =?us-ascii?Q?5a90yHe41EIcHzD1NCmVIz2hUe+SPk6tDjbYn6UON+3RnWgGA5H0EXhCECm9?=
 =?us-ascii?Q?CDVCts6sWblKKfJxUhB+jQJmVYxDn3cnhPuSLh9gIxAOdxtmn19QQqAcg4Tl?=
 =?us-ascii?Q?ku6W4O4HsPAX7XGhHHdas5IeKz8VFgLZCaOHegBNjuzyD498n1MqH0MriGGv?=
 =?us-ascii?Q?otsd8iBWorguakwgCU8cYvZXgNNETqvCyBGTwKvPDR5F4mGefnjvpCtTlddH?=
 =?us-ascii?Q?46nIuT3uP5+HgqiVTkiF5K7exg6Ip1j5DZ2hHT6NhOd/0yrOvBAB9MR50YyL?=
 =?us-ascii?Q?RnvfzliDb6fXtB9zZGsbH1wQyK6QpKlN/aiJtiG/EP68IqmyMBARFAYrGwLD?=
 =?us-ascii?Q?4Krq00ls2PA20cCjzNanOavarfP4F3MuQlp6owAotXHgwCJqfLkyC1NJ5xNe?=
 =?us-ascii?Q?/T7wO2W0b/1I8Lyt8Rol6Z9f8WX6aOH1vDzf8GGAN9uAYGUs9QTbKtHWBB4U?=
 =?us-ascii?Q?F77xlnbkAb7V7rYORGfIutgGywOyDIX4mE7/kFj0H5irE4urXmLn516lWWw0?=
 =?us-ascii?Q?No2xfJy+ucL6Iqpa/ERxExLVvHNRJtFVZ2RCP1804zSNTOfebMVZ481CGDDf?=
 =?us-ascii?Q?mUVbj6sdrrhigF77VduODkycK2pWEqe9HajRGpHvOm3s4EwhBC9B0JwuIWlQ?=
 =?us-ascii?Q?x/+tioXo2e/NM1SoEpnmC1a99aMdHToDrcqElVUzjZ6T6SYcRUWoPm84uUdm?=
 =?us-ascii?Q?NTsKEYtzq2TChyvQbudy7YeToUlvRrsIpz+7rvUljQWNBvbP9rLYXjbPAyVl?=
 =?us-ascii?Q?YPSPxuhC+GHjSKdJEYCYvrzw0LeeiBwyXFnk2Rc2mbTKzX0Mw7naew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nkg5dlFpVzcrpqzzyxG90UyINY6Ucr9zv9JydOlmZdeKJPhUbqkL1J6ohtMN?=
 =?us-ascii?Q?DZf6J6d35uhNz+VQC9kXsr3gPUxpakOCC5+EmkqF5BzMmVwU7DYG73NTe0SA?=
 =?us-ascii?Q?gO1hLdzLZlfMVoLcpxGi2ZAwxlTyUjYWHDOOZ1ghc0PeTdru2d7fUy+nBq+R?=
 =?us-ascii?Q?tdDJ48TQ7XchwyMcfTB07131dHecIOJuNTJFD3Gg0Cl+uqk3jfd4saCGlWUj?=
 =?us-ascii?Q?V+Y7swODJrXuirhF89Juc3JEPnX833B12xOZNcD1D1V4UukUBq/BrX9ieF1W?=
 =?us-ascii?Q?lS8YC0XT4/uIuVU3cB2QR7eLpaCE3mogoVcTz3//jDCNwhMSyg6LXJ5JW8oT?=
 =?us-ascii?Q?kNdSLqRbRJ1iwf4QXSRtEcDEJ1FQol/aDZoglMfxbDPqjUcCYOFayzQo5LpH?=
 =?us-ascii?Q?MkYg2lZzWCYdtsWt12+t9zL+i5C77bp5b2RfYjknuCC45QhVxD4U2uiUuWg3?=
 =?us-ascii?Q?4+sMe4VCTre23YNGmaZp5itqe26E6lydKFT+6KIpTQPwAAIWKtkc5U1/9RwH?=
 =?us-ascii?Q?QjST+Fmfmq5HIZxHGk9P6kM3H64fodgCm4BT/MtJVH4j9+3A/JForFAa0F1s?=
 =?us-ascii?Q?EZquXyG0mvUTaWp9zkMO0ZXbFGCeX4RMJhkNR0wEePkjQfzekrgRL92G+u71?=
 =?us-ascii?Q?JELGsXxVYolzGUf70o94bcQTb8+kAz2phMcCtA+gEajRytbcaUVGZcMOkHiK?=
 =?us-ascii?Q?87GounWRv0HcLqs/04gSFOynM7/+QlDK9s9Sleg2byxhSyCPwM5ybmKOQoGc?=
 =?us-ascii?Q?XOi6uGDHO3XUncZ/6zlGK6uhUWm9DeZKoE8m8RAYiAKZYVCSdj4jxvJeeO05?=
 =?us-ascii?Q?CAVwtA+IxvGywoPNPkwV2jeqhEKKUdoOUVIzEHATkicglRBqYwE1Ghvczrja?=
 =?us-ascii?Q?sxq43AUf5m4LRbDkqpfHDjyKrSt7tsl1WtS47qP2pslnNl+X0L8b7JRaTH8H?=
 =?us-ascii?Q?zekDaxHuEL2JqDDdKgkzh7WnJ/trGbSvdFkY9cd9DcMdKSLIkibfvydytbSN?=
 =?us-ascii?Q?4o+9YgtaLVk5ScEjqYq0srrKfk1rU8DZOipSSYwvZezgS4lxrdZhAjt4rnsa?=
 =?us-ascii?Q?rX3J5LiqSJRkrhPITN+EKfLEpXkJW4dKioCa4c6itt+XNuytpO+fw/SHPM7n?=
 =?us-ascii?Q?csmIugsPYSPOSp8yVgMA1fqHmuB560MyNGLLDDUdnpzwB+qePIMO6xxGDegT?=
 =?us-ascii?Q?+W5ybyWdwQl51wgPNnTdMgZxvvuil/QxCBB9zcv9kRcEVrfC+Z+T0gBFY1WI?=
 =?us-ascii?Q?fn4/7HKTD/EK9swOeDJa8hInNBADdEQP70hzPyoUla9nwwK1uYtqMHYGgCNE?=
 =?us-ascii?Q?e7bmGqFu7eDhle50GSQyDI50tUcJQb99XtK+BkyyeRsJO1PwLOfEFbwo7DPl?=
 =?us-ascii?Q?QFGNz3gvfXIQP5fFzFXKkcfAJVBFMcLgqjVd8e8r1JclO1c/6rzMyFsbPvuL?=
 =?us-ascii?Q?IpNlE1PMX3yorduY11V8/qJINi59UBbuMbs5s5J7ycThlwSQKbbGC41Wz2M6?=
 =?us-ascii?Q?ZZ2j/nDD7ZXYlmAUhH7/KzRGZ93gq/YFz3n3HTNU4zLDvt0DxJ8qfSeeNxss?=
 =?us-ascii?Q?j3j2BKTRG9SOl1c2Tt8VOQ+ckHWqsASV3jjmdjX9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7183b-02b0-47a7-2571-08ddf505c619
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:30.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnaAIpsE8pSKXGK+AELnuhHrV5hgItUmlDlwdobMCATENU8qCeEQ6l9/BVcCmqIuzawD8junoMF9wGB317zJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

Update get_reset_reason() to support i.MX94 to send message to the
System Manager to retrieve the LM/system last booted/shutdown reasons.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f04b9255cdb..07022c65b88 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -494,6 +494,31 @@ static char *rst_string[32] = {
 	"por"
 };
 
+static char *rst_string_imx94[32] = {
+	"cm33_lockup",
+	"cm33_swreq",
+	"cm70_lockup",
+	"cm70_swreq",
+	"fccu",
+	"jtag_sw",
+	"ele",
+	"tempsense",
+	"wdog1",
+	"wdog2",
+	"wdog3",
+	"wdog4",
+	"wdog5",
+	"jtag",
+	"wdog6",
+	"wdog7",
+	"wdog8",
+	"wo_netc", "cm33s_lockup", "cm33s_swreq", "cm71_lockup", "cm71_swreq", "cm33_exc",
+	"bbm", "sw", "sm_err", "fusa_sreco", "pmic", "unused",
+	"unused", "unused",
+	"por"
+};
+
+
 int get_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
@@ -512,6 +537,12 @@ int get_reset_reason(bool sys, bool lm)
 	int ret;
 
 	struct udevice *dev;
+	char **rst;
+
+	if (is_imx94())
+		rst = rst_string_imx94;
+	else
+		rst = rst_string;
 
 	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
 	if (ret)
@@ -526,7 +557,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
 			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
 			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
@@ -535,7 +566,7 @@ int get_reset_reason(bool sys, bool lm)
 		}
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
@@ -556,7 +587,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
 			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
 			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
@@ -566,7 +597,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
-- 
2.43.0

