Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD6C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE34080F5B;
	Wed,  2 Sep 2026 08:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13-it_V4h5Gj; Wed,  2 Sep 2026 08:53:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339222;
	bh=yidl/wJ6/ln15iLNMYJP5tfXRESOsNcz5kHoDTrD8p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yoc6eNHG9vHFe5XZivBjDcEwWOoq0ifeDkz2OgszqDLqjOijQAr6FeEvLLj8krgPm
	 fbrwRT2AvwvxPbPCWQweteplPZJWwuAxRGudHvYG2v6ntpVLeg6qi8RrouI84WPIo1
	 cvTgjMmZ3AsZhAQPQw5kEg1n8Vd0geeokeVEcgyVx06dsfU6prJa7d/L8FzVBZ8sIl
	 CnfR1BD+TXwLU94qRRxYnPI8SdJjCywOcn6zqsVhbQDwkhbFyM+EWhJ5kKIHz5Eesy
	 TKKahejc5ZcYLVTS1Qj1CcWuEBBbycZoUdm4CP04vks6zHkAmndQnvAEJ0r2s+kPiu
	 /lSK628F3P4Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BD3F80F60;
	Wed,  2 Sep 2026 08:53:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E80A498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9FB94031F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5y3INDR3fjn for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=EPQspubl
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 525BB40329
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBIo38qp7KD7RYp7m6hS9ecdFyPgaBr7goP9U6YHg3iJCnh2B48VX4OuzV/kUna85wXFIaJJI7eqggT+KJ2rrC4dtTgMudS34uV/Z8fBM0h3/SCbH6lEqYbQ0R6RdyNaac/+eiwWCTObM7f4Oj45IMLks7u4j6FMU1sjePr5dfjpmMgJY6Q5WMnDNoYKfO1B2hmbuP/fKTb/r+5PTEAP6+kgQnlp9hduMTcxCetyo7yRQKNbXqpGammxUtyySQkTr+cTjirLohFBUo98zqODU5eQs7hVpImXgQqOviIZ+WXFtLmX0xzgg33D0M4LFA44RWxr5EBTpM8rb1NNph/ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yidl/wJ6/ln15iLNMYJP5tfXRESOsNcz5kHoDTrD8p0=;
 b=B+4yESxVebaQhsb8Nem7XsZg8/llDQZipVDYWolKYKD49ZPhQhHR5wL+3nEnPVn38gVR47dKfQPFQhXRLk2w3UVsRaGx/ePvWdPawqNDXI3iYu7bVNMbs2J/jj9MVDulPdpuqUUmRYeydN7+ZRUnvYmsnAn0Ro7eVLDZwmH9oqEamkx8ge5FiZt7jBe8RFU8WBPaKi3uDvwBdjcHeZRv2DmTj2wgca0Gi9d0vK5dhtmy52HvcbzwbuRNKQLtwMkQMLSUswjktbIaJWBt1Gecx2EmTvuIGRxnpwyrF7WgDYK47DpZYeK7wjYNsp7oovUy9T5ducho18KIoNAWu8jvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yidl/wJ6/ln15iLNMYJP5tfXRESOsNcz5kHoDTrD8p0=;
 b=EPQspublUa3ZtlfJ9skn7+C+krj0+JvVdNxVHtKLH5b53PO9rObfh5xUcyEESeavp/CCc2aaIGkurLteD4FLUYIIbcudW1tQFPcoYN0QJ8FZPLvaOQeSMaFN4676CLBIJlq+ke88lx0DbFRfl9XvjFqviG2PuUnqPL44olz9mohTU7KZAvAAVZl3BCM8nMhYu2EGs9P5QcZt/JaUdmtCWIl3zF0rDVrlA9ZIepgkiLzRm8ARDx55JNvIlRBWUL8cikgO7P+MgblYeaE9YMmkn4aV6XN4LEdf/mLBXHT9KTxxOy7qu3y0icoH5KDqf2RANBQNq/JzWliXuWhj1tQRmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:29 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 03/16] dt-bindings: clock: airoha: Document support for
 AN7583 clock
Date: Wed,  2 Sep 2026 11:52:58 +0300
Message-ID: <20260902085311.1550804-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7449ad55-41a2-4f28-17a8-08df08cfa8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|3023799007|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HKb4M2InlSiEMebiq9C+JzrnbQd0u58seHqRnD6XJ57n9FbebBLaQ5fD1us+mqu1kBc+DZjFIFoO1VWjpsbSXtbbVh2UkGHCvf+YlsAxv7UV8Z6ryKpHN40M/ZMyTVJCfmrndg6ICv2WR9FH8HJPDOImftrokOw0VAU6oyxDrQWjWyNh7X5np9oos18NcJm4MeA45boIz26jvKbgeAYktu1iwIIYyc94Be1i9UEITff3XdJEtp30oV+h9mBi60AC9rAZUl72iM6lpevMWGDDomdg1o5bXA9SqFTbqIDxudb8xKb5c1kpuwF0Ee0jowXR/HW00uK238IIpo6LmQrP9eEbgcka9HOmSd78lpi55L6ALP35ndmjnIc08AivHOevaQTFBtx0eMMix0w8S67xQSumwQhDfQ7FXOwkgzZG6HY0bQM3r7ioYmkv/zXLy/j4keIhybBe5FjJXiDYAQ1v4ZsIcVp4G0rG8vBMEEpJ5oBMLUAY9xBpTHFfDgChud5Ds4lYzeMmghLm99Tsa/jJ1Cd+z4i64+ZIh9Mmg8+QZNHnwY60x+WBioTBXZmKvBfx4SzDMYNmuePGJCDtKvNu4hJ9zuzNKVFijlcR6y17FMbLtvsBJ/bXR5rE1b76uUsv3iB/j4dkoMKJlH0pe1qN1YbAL7PyIkrt2eTFHC9YMktPFS3zdmDWRDfQTqp6z8G/MoFNQnoJ4TgbIcGhJGSg26ztxxklH64dCb8Ff+2flpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WN3A9TeBXaOKnd+C3IMGjkDunc+JWtDNY+P1tJmoG6iBDlUnAu9NlREZ96ri?=
 =?us-ascii?Q?/CUR4x3vesUboPi3B/q4DN9fcxpuwvirCmaGZ9pbWhGxlRu+romOxWJlQ/25?=
 =?us-ascii?Q?1i8/R8L7Ihtqq5iiE6KRV1TaF1FAtpx9lHfwDvwTPVZ7b4XG1AXWaMjjv7ND?=
 =?us-ascii?Q?275l9g4Kwr/pj/OLWjun74HO1fYTj9r6fLBDUq6aSYb+4ABCRLJ7xPbZEgam?=
 =?us-ascii?Q?YQm/T4e7Z0Kbx2y7jeWKsDUIWaIRVVc5W8+ra6EUKAs6xLShfsE3d6LIbJta?=
 =?us-ascii?Q?PRn35RhetsftdupSz2jMSmfc0X9vN1ppohYiIHLRrH5srqap2nFpLPlxe44d?=
 =?us-ascii?Q?gPdd6NXZGuIvkF7oieC9vWAQSjIdSNtewPA9APjYgxMd5zks18jvdVtVqQPp?=
 =?us-ascii?Q?ymedyda7S3Y4w0OUu5qIqgCIKGp/08IgKJ4kGKyWHkSEBZSWaRQr+NNHPCcY?=
 =?us-ascii?Q?jCJlxHWkUO83iHpLv+yqZG0dW63VcsQ7x5/c3KDirDWXQfZPuX7RjqX8pE/z?=
 =?us-ascii?Q?F6hB/zjsh8Yw7jom+k4jrqyQ4dsKDMqZk5q+5TJiMMXKfgr/cO2BCapz38yX?=
 =?us-ascii?Q?SO3x5q8eROYskIDAKJYEUL89ndO3hHF4/f8hlVVwebdsl3rDK5NRCaCf6ioX?=
 =?us-ascii?Q?o1kXwZ6HVH87JuvBr4j7ZmTQwg/GK4Lq4zxqtCcFdZEr2akSlG9lKXt4Fx5T?=
 =?us-ascii?Q?V5+IH4Cn3RHGl9uCsQ8cDfxu8BIp4ENbcBksH6+EkXIh//TIqS8hzHs2PU3F?=
 =?us-ascii?Q?uZUcP3a/H7uIotBxnGBqWG63C3EPemuUJCIySgHUkY3b1YxNcCSn9N8lvv5n?=
 =?us-ascii?Q?ljoR/QWyCMCUT4uZQCrUViRMdiiZZmqeU9WJK8ylagvB/OahUsYyeVHxqBTW?=
 =?us-ascii?Q?HRtPjmnsNyEZ7n1yYQFfjm4ddBp2YX7/8bWZMUxqATp+qJCWEQ0mC3lv8JRh?=
 =?us-ascii?Q?PwpeBHNS686t2X2qVLtKkHGUS4SZfQOnhFkL+Zut33MbdYV/iJc5VHSYcal4?=
 =?us-ascii?Q?O4IojEJ+SMDS6w+ONlrgAjhxUKk/R6nYPgPFtkljqNtQGFlGDaOSSTIRHs9H?=
 =?us-ascii?Q?tLmDsCnwp1BZp6Srh/CDL1tQT1Qud7TH9h/ZxHN5x3QWhhdSQLGy6MMJO7OG?=
 =?us-ascii?Q?sYe0FMnQya9qgEm94zBr+pCW89TH2GL8ynhRDGnp66UinoHrOuj52Qwm4eoh?=
 =?us-ascii?Q?mDA4b3tVRXksWMnN1CaEX/LCOQRboqaqVo8PlBQfxaaib+y8AwYBfSdqygzd?=
 =?us-ascii?Q?uNtrtwuQenWvIjRFXVAseBttD6jYHwn0zzJ7focTW3ZBjni7sPpSmYFTxCss?=
 =?us-ascii?Q?OnWV4U8WcnoqqR11xVE3HSZenRsbCD1BX0zFaYj339ug3A27Kp4a2XPESPoO?=
 =?us-ascii?Q?v/FBV5UIYS9OZHpX2noAsTvsUxGkhWO5l/cHGPSp1fmGRSaqsHppa+KMqQGv?=
 =?us-ascii?Q?bpcD3Wr37oVFi4K/I5/68GJRDfECLPCjJyOnKnNR49Q+XoL2Eo1RFutwjlDT?=
 =?us-ascii?Q?UP3x/NEK9XxW8HEok00dMhsez2N3nuVeOf3gcGuEEzKpi/A0FqnHh/K5U4os?=
 =?us-ascii?Q?jl+B1yEGhjQa3XrGbm4ehFO9mQOUOt/UFKeCmKPBBBk0/JIMZ2gnfbljeXea?=
 =?us-ascii?Q?LVY+5S4gIvkG0BwyHBwg5nCg8lAgUHVo2UTcsxIAhDOdbayeDhj4tKl1bfXK?=
 =?us-ascii?Q?g4e51xgxcHfoYUPn4PdAlFf4Xh++OX+VEDxMaaRSpLAhLk9yBrBeyIvbbzvj?=
 =?us-ascii?Q?nb2Vw//hYPgjhRciuk2uCyoW5cQqwi4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7449ad55-41a2-4f28-17a8-08df08cfa8d4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:29.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T98OrVJ61lgrAs2p4zdc2/YfIoLN+jqI+2oANqNuQfVWBeaxbvWbAqYrPyIRioNaodtc4wU9tJbbWHEJGpxdQ826uszN5XfKaQZSrW8CXzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Christian Marangi <ansuelsmth@gmail.com>

Document support for Airoha AN7583 clock. This is based on the EN7523
clock schema with the new requirement of the "airoha,chip-scu"
(previously optional for EN7581).

Add additional binding for additional clock and reset lines.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 dts/upstream/include/dt-bindings/clock/en7523-clk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dts/upstream/include/dt-bindings/clock/en7523-clk.h b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
index edfa64045f5..0fbbcb7b1b2 100644
--- a/dts/upstream/include/dt-bindings/clock/en7523-clk.h
+++ b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
@@ -14,4 +14,7 @@
 
 #define EN7581_CLK_EMMC		8
 
+#define AN7583_CLK_MDIO0	9
+#define AN7583_CLK_MDIO1	10
+
 #endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.53.0

