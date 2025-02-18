Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB77C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC6680BA8;
	Tue, 18 Feb 2025 13:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l2UmbESV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DACFC80F53; Tue, 18 Feb 2025 13:07:56 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B62E80F7D
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFpcOGXNEwBinN/VZKSc3WLhsgExSYJ1NdU/WDJlpuv9zleQwpGIRmzfsqTAi6h6XC8lL0ky5yYS5EMdH0tN3ld8tAWtLosxl2vyd/YZRkjc1L/fXxfAHsMFuFpz4q/8bS16tbQ9rezUStqPyoYr+zCypclFqKNcgIHGV3qewM6dVKkEvI+iEBJn9nwyIU0Y4A91Yh/iiVjj2szltuVzcerFBe6f1IxeQ0zKqrxrq3uzOG+38Z4KK2mtoHPmGK9aug8MVFJp1ZopBJs21sWySXwo9/5OoBLFKvtrlmNvjqz+hosN4m22VvJpEFpA8KdaN+3LdmYup95c0zOnEgUqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrDqLLeFr4JxmouqoddrW99tGuz82GuISgWvffDpqug=;
 b=e0Rhd+P9kA+KRwjLAPHKjQwbzM4DzooQ/C5iwLV/0+FGUMohlvlT6gocpFTX3BShPZ0On4BmVXbJdFRJzTS5jTd4EvqHpqtM/aaLr2EKVbqveFFuioRNJy0Is59OVZt09XKQ687JZtKbuODU1PkAc9F2N2FymVdsFbBwP1QeYOysHxfHDgDHaqZCX+YW1PI5yx62ihaj8auu8AVtpGXYyHulD0vpmWtdiSRAyu3/ZQnwQFibWB2zvg1h+ndkNNnd+G7fwE3fwIYs2ZB7VF4mWkqS51BoDF3k0/PYfMXQgd7ERMW7HZ5GowiSFILGwLsG7opFdj068S6WEZAnhU9pIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrDqLLeFr4JxmouqoddrW99tGuz82GuISgWvffDpqug=;
 b=l2UmbESVhi/5t4uf2oSGTdiovjAfJHrQuL/28H1VEtV70x5QpGZtbKDNerNukNMh7m+TSY6+2APH9ENdJOjKlqzAIzNg5evyAM1qxnfBTepIwYqvYCEmZcWfixMp2Epj+OOkeVDwp9NNKkv55IdYSrNMWJmhfwRZ2y7HUdelGvJgDuJJfsaWmVm8pKVZROZHbTlblaRHNakEouKl51xzgL2rk5ujiBtxcrAXdpBd2k0v6ZWCjzJTVL/rnSNJIsA+5Ckz7cghngMR6iNFWuFRoRs4t15ZGM4szeQhhzSAgHG0sjvndRqOSY+DViRMEUXL1+rvTTNRwBil9c9pZcaPVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM7PR04MB7126.eurprd04.prod.outlook.com (2603:10a6:20b:117::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:07:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:07:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 07/20] clk: scmi: add the command CLOCK_PARENT_SET
Date: Tue, 18 Feb 2025 20:05:44 +0800
Message-ID: <20250218120559.451678-8-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM7PR04MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: c05ed6d1-2b7d-443a-8f1c-08dd5014dee3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJHf6jVYx33MyUeR3210TKo1Si0E+ZqCeveE8c/dHakUZwwGpsz7k9+o4V89?=
 =?us-ascii?Q?bPaM8OISQ2iwRWul3TINi16XkUmdK+D90UhGfJtc/PezHSs1r0gTjpJI/lPq?=
 =?us-ascii?Q?dfA5cpcAWKjhO5KOQTs6mWkxNdHc0IzpG7V04+K1WAG1As0FuhLF0AmP3Eps?=
 =?us-ascii?Q?qj1rebb0hVLYR6emog8X0FtHEPVb1yVHddfjiNVrdeg8zs/oADksYXg7M/4F?=
 =?us-ascii?Q?LZaExGuHur7Cq6wfKT69TttipAkpBxS1i6n2zEarh1PihttAAsSBDITSkbkb?=
 =?us-ascii?Q?9bSiDKSXUfaOJWPSi9YKTiV3syzr8NAkh0iqsO2uzG8QlrnJQm9oqHKpSBdk?=
 =?us-ascii?Q?ocH1FgpQt8gRnbFqGVTa6bi8DF9YvjZe8bStZrZ7yUe/hOLA52LLSl4RtR0K?=
 =?us-ascii?Q?KrDKFxXbE/fTz3oeU+5jNuVmQ3OYYp+ZxD2jYm1ewt4czDRty/5363q2k/48?=
 =?us-ascii?Q?G8C6dasvYarywucQQAHxlcTJB6vF50F428FudjnLQeUQ4IomHAN59McRG/Cp?=
 =?us-ascii?Q?SoY/mTfOmkm/nMawyK4EdPjxKKNA0tkKof/9hLfwtVcgDQhlWDIHE0pmUmw9?=
 =?us-ascii?Q?pwVhb1rJlPrfM0TA6oSrkDZKyVM9j4obw/dWev4W94LJGKiPWovAnB32dpm+?=
 =?us-ascii?Q?H2HZ9jQgUQtRAmH2c7hq4t+ukJ45QzyT63tZwUQ9xWBOM6cYXuel6kykpyfm?=
 =?us-ascii?Q?YBMq4Xf6qnR50SrASlcUrFRgEYjjf1RR8PWITEssw3RRLwZBzNXRMvKt4Hes?=
 =?us-ascii?Q?OSyBbAXzdjZWdybdRYl0fGOxMbcTxn9bjFYd3nIRlJFIclQ8aoZz+BGXBqdp?=
 =?us-ascii?Q?bDEQiagwKaTI0oBz0NAizjRo1z+JbPJ3hoayQKl9250Y+E0jL3iEHejTDZnP?=
 =?us-ascii?Q?SUjpCDw6MIN01j0y2ppityHGD/1YjRDj/IJEVveKeMoLdRZNa8Hao6mp9ji8?=
 =?us-ascii?Q?rcqFlsgoguxfjlsYk1GF9Dg4G76svmlABRi9RT4pUWJ0nTgvcdxnPbRWMF1o?=
 =?us-ascii?Q?M0lN9ulhF9atNHuUYgEBToVWimBOIJy1k0oolWhQtHidqe6ECEVejVDLUltJ?=
 =?us-ascii?Q?ra0orwgQT0/5YKzmNGt3aTtCUC58r3bFMOXaJoDbUAw6aOFpwjJTkQErKarP?=
 =?us-ascii?Q?eGuiMYdpRFyX0ytxj3K5Zz+zqQdIVk/+NSqqxEoZl7iyVnU3gEdoI/keNubo?=
 =?us-ascii?Q?6KnvVx+9+mYSiX8BVEfmPnu90D6r6lXQKs09IcMAylELCES8kK0fLW/Sx057?=
 =?us-ascii?Q?wDzWkt0Nyh7lUTFPuLSUueRjm2KfORnUiMQhY3SNk0tSMUQwY4V3L2INvMS9?=
 =?us-ascii?Q?BFxU5PVrrW2Z7aiNHt3nlMEJtlYBXo2C7s6eYcrS2x8dXAoxJpjS1PxHK2pF?=
 =?us-ascii?Q?L/ClL0ILwfcVHjEmyHw7HJ4QIVFyGJo+WA8XnIJkeQ1Pyp6F2mANHfNtAais?=
 =?us-ascii?Q?38MUtom9oVAl48MITOQUy51mlIinM7qB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXK4kQ/NOYDNp1PgGzrbinXrVHmunQitG8ggP89r55hJJZ41S3pDd/G0/i5j?=
 =?us-ascii?Q?bIoIo9GtxO+V41NfJmbvWsa+FBtHYlzGr2Urim4cL1Z1bkdXNHZxcprUikN4?=
 =?us-ascii?Q?CxyUE+O/HedddpYJ9Li8NUe1W8s/4vIejyNKrnRGx1b9x+Bf0Y+ZG8WjiO8z?=
 =?us-ascii?Q?fSANPyVZSureBNcEFzGA1/J43CX13ytDr+uDZqZhtZ8hR+OvWeBW/Zx0Ltbj?=
 =?us-ascii?Q?BLqREt3HK2BDSGe2If8jIU2WiOMROolZYSC5FVIISpIr2wmV9BVYzkiwixev?=
 =?us-ascii?Q?1Em7m+k962bshrfFcpbduPCmIc1w4bJQjKMMeJSRMdPDwe6Ek7KnDCvdd8DP?=
 =?us-ascii?Q?lS2XfEDF+lf1gttl/8EB81wIP618fEtR3zN1SckJixclN3zwDlgNRSPPXmai?=
 =?us-ascii?Q?4SMp7dSYGFWFM7MagJY97+VWTM7gXXMJJPhHJ88IVN0RpPatuEeVKlDasMQm?=
 =?us-ascii?Q?oViJVSgRovZ6p1NPY+b5a8RrwlfDjJJ2X9KFtveSynVGk0iOLkUAPrSpJU4l?=
 =?us-ascii?Q?/q8urpQl0UQuHNRlvD5ctfsgHaUjaFOfM7Rz10NwbSMVnW0BkurlT1U8XZUF?=
 =?us-ascii?Q?SQHQG9heXSTnHbGWdjSgQDu/FR2zfV3Vj6RNoSClnPDTXSr5e58QIFXmaPso?=
 =?us-ascii?Q?FfvxKDPGei1wHO004+huJNjjdp2CFuDbbWFOWKVWP2TCrEmaoxrivE91GmFd?=
 =?us-ascii?Q?3me10cTaALHJA1HqSlBKhmR5JC21xMrJzcm1zw+e7skF2afTUcUWgjn6sVNH?=
 =?us-ascii?Q?VAdO7SbMRZKfTwN+rmair6V0nIgkMBfKQ/eYWraxmbmcNYWmdxNExLGSycl5?=
 =?us-ascii?Q?e1GKgcz2OdjBEGoKtJX3n9gWRLSdOKB6Mx8pJX6Od0hO/7d5cblNkJOtx5e0?=
 =?us-ascii?Q?haPKzXh5Pa/rsCSoHZa1FIHlj+vwJ+KNzY2XQecGxPs5RP8R6U81N6IMI9kr?=
 =?us-ascii?Q?rDQTS92rQYMWXO5mQa2NN2kTIWVfQPv5EhGXlV1or62GiW4Zsqm3/+nMkcDW?=
 =?us-ascii?Q?9rTEiKpVw1l3Sf96L1cKTureSDr/cH8ST+NkZo+meaiInlk4+MzrSgHTidOf?=
 =?us-ascii?Q?z8wAHwbSU8HY19EMlEYdOEnMn0axOHZA3cn0YaQ+v6iuBdyt5mtrJft7dd76?=
 =?us-ascii?Q?H16c7elYcLeJqiNPJJX29U8t61Y07HFpVMhemVMPvYDWD3dvKUXlBKk7qpqY?=
 =?us-ascii?Q?xL8fR27PQ4uLo4gbA3dSlZWmahZ78oQe5E+4JHDfBqN9Gd00fI7r6KFmted5?=
 =?us-ascii?Q?MHedy8pGClUwcKZ4sT2xeQlpIxryfU65douOkKj/QAZyvsWgAhrqRlzbLmDd?=
 =?us-ascii?Q?zSz316zshgNiqB5dBX8MqEH59A5McOMDJdHxwtBN5NLWoO31RAMtaHG/D4F/?=
 =?us-ascii?Q?7yJKSFDP38+c+Pd75D8LsVoirRv+u1D5borhIg1zwkBl6bvmyvVjN32q0zWz?=
 =?us-ascii?Q?uYoRVqkvAE+/8vXH6gHy2YV5P6wvkdNMfhfsJULxGCw9OzPiURc5Uvwk+DpS?=
 =?us-ascii?Q?lgU5tvuwVBShNCH3Lfx9NtWnyIzlGO8KfXGB/J6mPZA+Tj3WWwXwov0P7A5T?=
 =?us-ascii?Q?KWgS9RfIj92WdpL5+F75IdwaJquKlFJ13wCXFLB5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05ed6d1-2b7d-443a-8f1c-08dd5014dee3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:07:52.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS1i4Sf6nqOw4VR0Q0h8OqE/DOMVfi0Saw/JGyVWRJ1LrIQOwRl1D3iAgal0HBI+f85a3ePpFSiup24dlHVGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7126
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45..84333cdd0cc 100644
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
index 34f272c448c..0d8c177025c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
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
2.43.0

