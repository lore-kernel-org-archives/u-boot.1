Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C531CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F9D84308;
	Fri, 10 Oct 2025 14:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1t93NHwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1E684314; Fri, 10 Oct 2025 14:41:30 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4B0842BC
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfH9Q1qSiUgN2BqTXmXNcshgd78ITe62bsWQwVriO07ZeS7LOCC4CWrWYYM75WDSrmA5xPCpmk/mqJj6NC77p1SrfqN4Fm5ZFUd9Kmi0LCihUnO7qeB9bfyr3Pm4YgcJl3A50MIWma5wYV+hay9l77lhQsnZXMJazovRlJLlhXM+y2yzp+MU13ZYKz7DMT6pDNAABcy4vzFKuby2crhVbt9myXxqFwH2bG95A60z1twnyH5oi0joPeXCrj8u3UIF/C5aYl8YwuMGK1xjXhF2hNSgF7rXZ/Et5bNLHMxk//TItYR6aCDZ/QNYdvQYupegmKoUnU3SUTzO177955Cefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI3asHmYoF5yA3FabErNdYfJ5nB8vaABHxZxm2F0zeA=;
 b=y1rx4M2iruhYYzyiT1AGmDFJjtCqBai/8ScBAqwvaNU9lvnzdCAIsq9+wVBFv4fA5O/ZVJnWkc8bJsKnOFp1Tm0GI///gk7Ih0+fYCvP0Pn/chy6dtpVhhrrLi7tiuvsYTF8u6U/z2rWt02/J3Zr7Z5wqdl8Bw5KeWT1km43OMSUJP1dQJymtI/ouE5dyARrrpsuSbLgl+gpoRWdr5n6m1y7mHEKsUCQ6/lenExC0r/AKYkbwVxBkyK55FWFz7b99NCQ+qAFAPXFjxKuigM2lOqZTCArDhJPgfmRxqac5GACYLj1k/4MmETCb5Z1RGaVX0BmQrV86fatX3dG6Kk38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI3asHmYoF5yA3FabErNdYfJ5nB8vaABHxZxm2F0zeA=;
 b=1t93NHwLJuOjlxvAsjsR4IR7QNf5KqAHURkx3JX7ZhE+nniFaGX4M8Nwza9Ei2Rzx5WsQExpTOMiWgibz5oLPgfqdl8uFgvSTxLyHkvk34VlrA6p/6pny64ferL48LjIR1W6NTsG7qiP3CgHS8tcnWHwNXPJzxf+r85Nm9o0keLyCxLrgEe9vTG5skg6GzHTGjf+7U8ikMpHiWlXxQtBMvuWGZVd2KNsPzimrCGVa+fVHU9lCYLd1CP3SBqalwJrNQdTx4tWFAWt+Awq5d3elnw5b3DeHtVPf8wAYCq2kNePmZPnR6QyJHmnjAU4xMPOzI1GvkuTJzPooc6GiNuIGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6259.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:41:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:41:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 3/5] cmd: mtd: add nand_read_test command support
Date: Fri, 10 Oct 2025 15:41:13 +0300
Message-ID: <20251010124115.1545865-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
References: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
 <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007577.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a627a3a-ed61-44be-5ffe-08de07fa5477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lCGwR+dc+r5L0oVI1Qu63piOaEHyLOmR1K4tGcaazmIFLZHDRV/uCp6pJo2e?=
 =?us-ascii?Q?OsA3Fljoj+pFyJXQLsnozO7y9WaJDwY1VVHElStfKY14Q/V6RbazUgl7s9B7?=
 =?us-ascii?Q?PcyIEaTIxkaM+ylsufZ6PwbWwHArG+aundiOrUZ97HLbRRVuPUbWZzeGKUtY?=
 =?us-ascii?Q?8SlsVZj/S+L2wRD988K9o7Cp1lNSOCoFN3dx/LSSgt3G/fDwrpr2btIKs+hX?=
 =?us-ascii?Q?+UMwpzhRiIFjgqwEojQtrFNuxZRt3W8oAmCt/7C6IM6NlpSRLlUGJ4DEMjMf?=
 =?us-ascii?Q?3Ay/I3oznRFiU0ZWkzIlaPELP30UQ6wJqswBgStbHHob7ucnaOjeGWJ8VKGE?=
 =?us-ascii?Q?RWyffFtGkVRfhMrKxgQLt66gX58v4CrYaNzR02byOiu2kc3ITuwFFzrnlTzV?=
 =?us-ascii?Q?A/swZvvj27OoPKrwesfcLqARhagsyuqw8vbgpgL21m4quf7ivqZ1L3fXtOS2?=
 =?us-ascii?Q?1QFXTch7qCfiDts3Yz/7h2tnV/kh3MioHXD0z05Gw+os4Ey7nnwHecTSmW4B?=
 =?us-ascii?Q?ZhmzVXRkEQ3wMY1UL05Zn9fttZEN/pWfhQGEKM+lNRtq9ZW/Ywb43BA4AKtG?=
 =?us-ascii?Q?2WxVT/ZtPVDanlMWEVIur8U72tmcoNQCIkjqWKvOYmx1Yv59ZRPccF8+YEhf?=
 =?us-ascii?Q?heT2BnSkKuRyuUagJk1sHxuzSn2vEFWv0U5sfNXdMUTNAJdJRYTbpOxnCqqx?=
 =?us-ascii?Q?B1QedbuOReOf4m4gVdiei35Lr3LUou0j2TZfKSrNi9sKv4A2JWX1Ey3d/LZR?=
 =?us-ascii?Q?cUjTJWdkqvWmxcybBp917VxA789o3v7gnQhTIuZOjNWeDXdv/t8lox92pBAl?=
 =?us-ascii?Q?2jQy3QkxvnN+nI9S+UuBDob8EPw7y0hU0k234wPAHCBCMAsl0kIMRBK3i8f1?=
 =?us-ascii?Q?gUwoVNRDAlYDV/ytqMfv9MDmZr1qBXYqHqECbZAM10I5TVut3XbsJM8w1OlL?=
 =?us-ascii?Q?dulEJI6G/khpXt3JKERTjqrHsY7/ijFT+pWC6RlETo5W7DYfe0r7E+sU3oVl?=
 =?us-ascii?Q?LbrXpiRawsV+ZsC0N1+VgitmGn95FNgTotM+Ew2jF6fbJz/Lt/5plcUre2w6?=
 =?us-ascii?Q?vQGnNUe3MNdRGhEjD0lydPxTSwYmFMLpm+VWk81dIKAubNuj98gHoGHhxQe0?=
 =?us-ascii?Q?oOeNdrewGBtvViCqIlsqCvZBK3qkdlzhEv+eEVaj59oaK4WcotfI3Lcj2iP9?=
 =?us-ascii?Q?TVS91AX1LIA8H4DNz9YV2bsoZVdZ06LYURHYqKLKhA9KkB4/9ZRhIYmICnHg?=
 =?us-ascii?Q?IJhr68rWruUZQ57/TZ+amP3L03lLedHQDlzOPSK66E3Z0RLPh4f1TZIxpbzT?=
 =?us-ascii?Q?x5jphlOttbap3AZuhVE1n5os+TNQf3Sj02ChWMUpE6f2R6XIVq/UjXjf7xm6?=
 =?us-ascii?Q?iTGFFAh4rECmqO9eyvmyMlEd8KTMxEO0s/Ehvn56jCCPoIUBXDr8XojZhLXH?=
 =?us-ascii?Q?qCsHrhtRt/uDC7rDFYhgyoN+51a6PRWSBsq5qNClqqe227B6QqcBaEaZ1LTz?=
 =?us-ascii?Q?OQPDFMorybAhvbSVLN4dHJnbO73tp+twUpkqLgzMDMxvDpAGzA4mRmuozw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wypeHpK3+Mn7iDkADvK9fNPpODWsqMdBNZW8a9+lezmeG79lzvp9nAfqFjH?=
 =?us-ascii?Q?WyJu9MuyfxoKyotRZhohw9GjgRW6Dn+Z9+aE1r88Zofaz11K/Ki7kr1gUTh+?=
 =?us-ascii?Q?0gUdnm8Rv87hW7jc67ja7Onqutf9J/uNFaRiSgUo8qOUCcNs0iWJzu7+tjoO?=
 =?us-ascii?Q?1VCOCcL+eE2+11M6l9pYav62TRR3OMDjhN4UYt+D94ezG8McJdaR0llNcbzw?=
 =?us-ascii?Q?cXxwXYT4QGeHHOJZAlhpyCsAIge9n/S6mlwJraMfFj1DF0pDyLsscdYBuWfk?=
 =?us-ascii?Q?O/2QXKr4orKNEpeRbI4xG8yIOi9BXkwaNi9rGJAwu+wusEEwNhqLWhJuSXQm?=
 =?us-ascii?Q?lb9fTzmv26E8ZHwoVSXC4jJgShvfI52F7RvIVrnAiVRVHBY9CqILnihsIaEm?=
 =?us-ascii?Q?w4yOih7U9FJyUiqA33PNLFMirsva22kA9DwIf1EH9tzuWLqGmNJs04MSHRIU?=
 =?us-ascii?Q?gydo/BD/aDcSsfcVa0PAFXg02PWL+7UbAE2kFwQ4jCPuWjGKowbVAyL6rE0M?=
 =?us-ascii?Q?pAfisI+LBTuYX+elMVEaPr4JNhYvoJelDQPy4Bcswjcq/IeMhWP+g8gopU7c?=
 =?us-ascii?Q?RJvoBtq1IiOP0V2PjeqK2mEoDnpogyjGMTl1DuwD/s3PAS3Tn47SK6YZ5+NF?=
 =?us-ascii?Q?Tatei+3WEwK3zjAxkakJGKI1o7OmhCGNa60eynM6Jfs1m2HhNTWgoHtVuX+R?=
 =?us-ascii?Q?weK3GsNsxz+d9eCwpiSY6XhmToRBtsSpCKvnZ5xCxmaSXfH0kAzIxQwWk0Av?=
 =?us-ascii?Q?818yTjbCYn6R7tLjYe3o4F2z0AQYtQS9y+YE8L3qzVkLJzppAtBv0xu07Nol?=
 =?us-ascii?Q?lA2wL/VxCWHQ8YxoKdm8+AD3oG6a1cUi+HIezQXdNN/ZM/w3nWKXG8MWROE3?=
 =?us-ascii?Q?oA601BEZuVAI0T0W+Z5Y1PIediQVKHCe2/gnHTblFOuqQUOWUaB8uO79E8//?=
 =?us-ascii?Q?X612gzHczjx9f2b2cxbHTePQfppSTQtMKY7LDjHIgAzaL7OxI8g8I2CvhF0f?=
 =?us-ascii?Q?/pH/qR+oANSLpf8tDrVbvrZe5qJ5jqv/qylopIzepjhHzIx6VbpndfFLD+1g?=
 =?us-ascii?Q?oDsAUm2RF7fmTfhpWpTxjHORjxwG8SfizA3JG4c2PIEeQ/Fc55kNCaifb21z?=
 =?us-ascii?Q?BGhXM6Eaha1bzc0iGk3aW9M6ORHcew6WxNbYuddDW2wXCRuiuZXe8I7AnJTL?=
 =?us-ascii?Q?yX8P5/fxwFN6BWemWNnAIYy3dVuZ8LZONrqo0rHXIRFdVsT0RaiouBZiIQUy?=
 =?us-ascii?Q?9xzddX1r+rCYnMRToQOkEeK79XI1Cmx8ptiG7j+8Vj1PChme7vGBDTYoFZ6k?=
 =?us-ascii?Q?F7ROPLhJCgnmpvA4ySAZ4xq5VwQsdBsS7RF0PyxSVbkq6+/4s7inZijacv8E?=
 =?us-ascii?Q?zK1kgBMrXRswo/mZ/XAINHlzDEhRVPSfOIuyUv2yMCJdOrvbaiXff9BFt/9e?=
 =?us-ascii?Q?VXU3Ae3DJkz/CVdYkMTlUOrI78zqtuoDgxj6jGOg7UKznjtmCYUqy7RDtzSY?=
 =?us-ascii?Q?jyF3wykh6tOPkBqkXllT4fGdHeyWXBvOw+WTraFaWCc1p4okFDxG8FEweQvi?=
 =?us-ascii?Q?ScN2jczdDGWlEN61+SrTfbsEXe2yxWp5hG2cuXyrD6ghmw6S6hbOamSzizrn?=
 =?us-ascii?Q?d6zWxsnR3QYXgz77/uzFZLo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a627a3a-ed61-44be-5ffe-08de07fa5477
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:41:27.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWpvatIAdTTcQdQ5Eb/4SaEo+zsRsQga54Qnp5+fQ4yL8ZvlCkIqRn8q4ukOc2IorMVRZpaK1+PDu44+OOyN0GQ46kymuXOaLbx/xCdtq3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259
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

This patch implements read-only test of nand flash devices.

Test reads blocks of NAND flash in normal and raw modes and compares
results. The following statuses can be returned for a block:
 * non-ecc reading failed,
 * ecc reading failed,
 * block is bad,
 * bitflips is above maximum,
 * actual number of biflips above reported one,
 * bitflips reached it maximum value,
 * bitflips above threshold,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 809da34e963..dcf63f423fd 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1535,6 +1535,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
 	  WARNING: This test will destroy any data on blocks being tested.
 
+config CMD_MTD_NAND_READ_TEST
+	bool "mtd nand_read_test"
+	depends on CMD_MTD
+	help
+	  MTD nand_read_test command support.
+
+	  Reads blocks of NAND flash in normal and raw modes and compares results.
+	  The following statuses can be returned for a block:
+	    * non-ecc reading failed,
+	    * ecc reading failed,
+	    * block is bad,
+	    * bitflips is above maximum,
+	    * actual number of biflips above reported one,
+	    * bitflips reached it maximum value,
+	    * block is ok.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 4d69c7b4915..689d8d11655 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -951,6 +951,200 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+enum nand_read_status {
+	NAND_READ_STATUS_UNKNOWN = 0,
+	NAND_READ_STATUS_NONECC_READ_FAIL,
+	NAND_READ_STATUS_ECC_READ_FAIL,
+	NAND_READ_STATUS_BAD_BLOCK,
+	NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
+	NAND_READ_STATUS_BITFLIP_MISMATCH,
+	NAND_READ_STATUS_BITFLIP_MAX,
+	NAND_READ_STATUS_UNRELIABLE,
+	NAND_READ_STATUS_OK,
+};
+
+/* test_buf MUST be not smaller than 2 * blocksize bytes */
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off,
+						   size_t blocksize,
+						   u_char *test_buf)
+{
+	struct mtd_oob_ops ops = {
+		.mode   = MTD_OPS_RAW,
+		.len    = blocksize,
+		.datbuf = test_buf,
+	};
+	int i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.datbuf = test_buf + blocksize;
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret == -EBADMSG) {
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0)
+		return NAND_READ_STATUS_OK;
+
+	if (ret > mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = test_buf[pos + i] ^ test_buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	if (max > ret) {
+		printf("\r  block at 0x%llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_BITFLIP_MAX;
+	}
+
+	if (ret >= mtd->bitflip_threshold) {
+		printf("\r  block at 0x%llx: bitflip threshold reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_UNRELIABLE;
+	}
+
+	return NAND_READ_STATUS_OK;
+}
+
+static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int argc,
+				 char *const argv[])
+{
+	struct mtd_info		*mtd;
+	u64			off, blocks;
+	int			stat[NAND_READ_STATUS_OK + 1];
+	enum nand_read_status	ret;
+	u_char			*buf;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto test_error;
+	}
+
+	if (!mtd->_read_oob) {
+		printf("RAW reading is not supported\n");
+		goto test_error;
+	}
+
+	buf = malloc_cache_aligned(2 * mtd->erasesize);
+	if (!buf) {
+		printf("Can't allocate memory for the test\n");
+		goto test_error;
+	}
+
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC theshold:     %d\n",   mtd->bitflip_threshold);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize, buf);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+		case NAND_READ_STATUS_UNRELIABLE:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	free(buf);
+
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX] +
+						 stat[NAND_READ_STATUS_UNRELIABLE]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+
+test_error:
+	put_mtd_device(mtd);
+	return CMD_RET_FAILURE;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1039,6 +1233,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1081,6 +1278,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

