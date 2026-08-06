Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F72C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B558104D;
	Thu,  6 Aug 2026 23:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IeCwm0wviDAS; Thu,  6 Aug 2026 23:45:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A538E80FFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059912;
	bh=AVw+LW7FPO/GWO7oyV/6Z9FmAc9WxURNzNEpEs9CP84=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w+SOIVa10/mJQyEjRMoozdUsIeEC0O9MrfEd/LMn6WSl2pOTUhJ4J3pKBG3FeTOsQ
	 gtVAeoT7+DWXyiTrudhcZiDkhIlw3jmx11RXwMgLI8IaM2D9h/wS2I8CJCF/Ez4KWq
	 DV8eE2oAOFdG++vSP36D9TZNZ/5Q1pXdugzAkRVzs8HWSjayhRhBWPWBNl50+tbw9G
	 96bM0i/v2WD0IU1u07NfKEXvqgILtV7qeQ6NoQ3ZceQ8TNOKuKcyY0Tf79LjnNBr0z
	 ezzS+wGmpEukpgCtDh4fzF7lXe9P1xs2q6x/Oiqg49e0wzFNMWh/OczPWg5/Q5Rxjk
	 KATCXzT4VIYgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A538E80FFA;
	Thu,  6 Aug 2026 23:45:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF2FA392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB5534093B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAGB39fuycvm for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:45:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7A37040923
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A37040923
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A37040923
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhjvbfxcBJSdeyyq+fF53HMlAuUEU7SkcVDMJAR/fe1cUCltKLtA5+3QILd7PyJweN4Bje8eB7bsWlcJbHVP18TSO8r11bDe24XT7V0r2z7n5EkQmuVOFi0ugy0dvQoWJVDyXXnaH10tZzNBp4ZDoBJaS5hJQQkV4YbteKsvF+G/BmtLP0/wPAXy5XbakA3nVKcveXryWFheIP/D5e4WAol4NGcX3aeY2hgnhhfbFnpic0Zgn9xx/t8PoUboVn99j3fJjA2pdG1JwZCera5cARsPjQuWfORWB7ZU4B4PaqIMYy1B2tUPo6Y2/S0zM/WF3ZJRyZA+VQQHduyR4D1+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVw+LW7FPO/GWO7oyV/6Z9FmAc9WxURNzNEpEs9CP84=;
 b=dOTrrAlNTvexrZg9aArA5rqvlIVN9dXlH7DLT/fLFawTPxhy+cfIsYUnE6sDLaV7hoERGtDBZSxEKlFVp7vX8ZCtqXu2WY59t4cRpHjJRElbU+1rUFE5iNmarJYsVjK/mvSYaSJZWmc/rnT9I+d7Hv9tUvTfwJbaN61eQr+HJbZH8BrJ4s0gUZsCigjZpIrepZWoUXr11IdIapgm7w7ldrw42s7wyfcitNjRuiIwBb2xi48DVmbSJylc/2DsfjnERImOKF2sdWGrvhTLQcm0vz0/9z+LsxqfAgUsN+W5/D4ltNBw+w3zXxxyPcdArXmAOVCZSVA65zelNxKOh8oBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:57 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 14/16] net: Add support for Airoha AN7583 MDIO Controller
Date: Fri,  7 Aug 2026 02:44:30 +0300
Message-ID: <20260806234432.4098414-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a00fdf-55b8-4892-18ed-08def414b8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M6IIFPmxlyg2nJk/Ml1mJmn9OWq2//YPkTGhyJXwb6yCaeYcaBviT/jlS3//Hj3KXykXM0lCYJ41tuxUkccEMG3RvPZlX0XuntuD2ZOAkOxkP4VDcEop00w5en527NRRDPzpDbkzCw7Xst1tsfqH5DpAoA7lEJQRQ9kb7In1iT4r7JVWM6b0bKk6zVibx/6d22t+4H+z0W00AISHjJrRssyarOift9GcLXpIu+EabhPWG5uaBU9oa2oJv7CwG3xH2cLbglTIa9AVlM77OtK52ddnwItt4IU7GYPEQbjZuKJgQoMPqxf4oqlmcoVHLZPzNX8AFkQELx9cbJHZWrQct8+TFSX0exyZWV/he19tQlZtMwq8aHGtcavuKrwLIkT+0TvzYuW9qL32/Cn77uLSnrrLrH87IZDBLbLjSbIQWPFpS8VYbYDzy1VXwDeMFIJhOtFknm8qeehuGziKj5s1VdYU9ciWcP1ytqQ68tOR8kwFAGQh27ToRThOy1A+ED2bW0MJnOdViArkAYkJykIa8Qx7sCCOsBNaqLvbwCM7ZKTLRR9WuOQN9H7GzROJUcizJEFi1gJrpEEY0f1VSPP0AmYHzjWT0wKMC7wJrkojXeWhXRUPxABjc8vCTQie//CnudXmjHlYfCjqUA8qwCJoM+OjMdz5OjT5YjZYI+fUSqY2qS2HIsYQ0v+J+L6Rubkx8Rqf4NS7SSDpZOQrdmfHAotPOloQZOL85dMRI0qEkKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2YvpRbLXAT7DsET3q126by3UV/AAD65jF+VJPhScfxYESq2jdjdMNRRc3SMh?=
 =?us-ascii?Q?H30km0wFk1MUg+g9cJaN3qCC2ciXSXspV4UvK522Ry9ChikPLokRBX8o7NZo?=
 =?us-ascii?Q?Y1pMDFleVQYyqtAdh/2lfAt2p539FT6EUHUocbyWgyxENxxtqqexd3DTOUq5?=
 =?us-ascii?Q?kD20bWheeTG3nePqr5yzQHyBtBVWUUZ4Ci7pq9xpoj2/X7/GDs+52mm/sCe0?=
 =?us-ascii?Q?QrgErd6Fe9DBhB3URSrqWPoI8UnPNXroLyYUiY7H1UkIdv9wdOi4ur8cQJiV?=
 =?us-ascii?Q?Pwe4gZxa6h843VRZFJCGw7yV3ffATDz8V1+T2nAnyxl1hjuX024u/rnx/bxA?=
 =?us-ascii?Q?ILg8jn9LG1+1pCTwOMtKRCgQYdIeH62WSRQAQHZf3eGm2FMkLzNLDzdvx6Kq?=
 =?us-ascii?Q?ozuaBi0CFXayc98m8uj0889EP6t1W7Kc7sLJSRHGn2Sdq0yUPt0XqwKMUOQg?=
 =?us-ascii?Q?kiFuV1PiBsHpuVN8dswCiRrfvKJTXvLQoFjhf5SyP/764W51+B/ZyNwjLyp1?=
 =?us-ascii?Q?ZU9CuEppSiMte4P9hW1oCnaGgjWuOdccxpHV6Hjx34zsxa196gKdZGLoTQrj?=
 =?us-ascii?Q?hCQCIRQ08SEHa7PWRENiEA0uHe/+BnpxdG8xNIVbLyGou9uYqGq1YcAu59JD?=
 =?us-ascii?Q?/l6//4QOrqazSwd16uaFG05N7ymBUd4vbN19SLFQ/am3NFZx0m+fwk2UVaTm?=
 =?us-ascii?Q?E1Amt86L2jp/Tzhv76TqwM3rcUrxNxsflWQ0+dCBCCIliV9EiEUs9peZVRBy?=
 =?us-ascii?Q?646RdA9+OCxyC6hK/elvLCfrBBiQjmAKYWCXWuSgmmlpCBFblbitk1OJW+eG?=
 =?us-ascii?Q?wwat3jTIs+6Bij/vLTxH5/ESUuyf6LoJYOVOEq1pdm19FF3IwMb+A3HZY4WF?=
 =?us-ascii?Q?GQk/7X+pV3hVV2ITpD3iEuY+rXik/HjWWhppxKWD3S+G/N15JyODe4WVz2X8?=
 =?us-ascii?Q?zMYDyRUpzpQkzDhMLJLkze4zo8gQvEQuK3wq/z//8P3UFLanLpr0xedbsZ6H?=
 =?us-ascii?Q?ZqucWXu03uFCAQcDVW2rBJt97mnth7M98s1T8ON6xWkr2EmiE2lNLAtVBBHG?=
 =?us-ascii?Q?4zW6caqE0md7CNPMorexiiXTnVL7DNsnLj8NAjjwFZ6ED9R3ozn91cxmC5cp?=
 =?us-ascii?Q?QETfRoWQezQOhymlZT4V1tILVvooo/c0qC7KUMPWsbrw3wuRte/fVUgTeAqf?=
 =?us-ascii?Q?pH8aEsa85+cBSnf8caJnazZUVr7COdrO0sNM3vHFqNNTKmLRgHSYqslYUqQg?=
 =?us-ascii?Q?9WfS2fsttlk04UsE2k4sOggwuv1u4rAneTMsFlphzxdkjH0dhy2UjfES411Q?=
 =?us-ascii?Q?E1VoSEh5sWxcW87XXZ1gXyBY3YAMqPIapDuLfGJE5LsoI1yG8ITAQ601Eeke?=
 =?us-ascii?Q?bQsBtiJxYWRRX3EyvxPz0sXRsHynDUQNwDRETKwiyZ6LSkJDUyWmLwtseNm0?=
 =?us-ascii?Q?AhhjqnxY55h4rlJXGCnNMYyX7blPOIIh4SqUQTf60WY7WZouQKPr6n5yXr7a?=
 =?us-ascii?Q?uurHgQ7w9PfpHz5Hqra3YoqKQ6KndwaM1a4iMPdXKCgsAiKHiyvW37E45PyS?=
 =?us-ascii?Q?dtD49gxhVtUn5iLioP7Ojpz/rJvay7EoyxEg9Jq1qIQDK+1G6jZDN+sVldsr?=
 =?us-ascii?Q?wAOD9HlxZ7d+sqOqFP5ki11l7izFd3boko5tfYTdinI8Y2cosM5pEfOFaJIV?=
 =?us-ascii?Q?V9krh7cUN70xQhyPAYVDMrXMMzcc3xxAPXF6x6ZA77QYD7gX1Zoe8ooAKYEd?=
 =?us-ascii?Q?+SkIECNli27g/4HzCyxp8BE53lT2ONg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a00fdf-55b8-4892-18ed-08def414b8b3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:56.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADTc1m1Jca72Tv09CseLUkMMM6TlFronGgWu+fJ9qcktwsoIUaGJXVRvTE2r7Ls0/B+BNSEZiucqAU5w3HOxcIUQX92H8mdZhOYmwPogmBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVw+LW7FPO/GWO7oyV/6Z9FmAc9WxURNzNEpEs9CP84=;
 b=3vzQPPIrybWIqzmfy9If4e9aX/SGPJGmN1njxUUiDqwqDaDvpjdk65qv8A+5X28yLVAaLunwr1qfJLaXVZ9bdEeiobtPnkm2oGTMVyNGcNSh34WwN/BYvgEar7L3awgtwOxHoAV4CJEI/jIvbF50+JhoAik8FUvaoc+gU4Dfj06fOsx/kW0PxWcZ++USBdUGd9jKi6ndGECJLItyoGHfkrTwwuY2wt/wj5P6VIT0aQScLe7s7AgAFwWZh3bXM9t9StmYrR1p5cOi8Cf0h7uwcwW1YXTgV84xAFvOo8MSkRciZfjbGs08WUIQfbjO6zKPqOHkAwS5mPuqCGZU46oTuA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=3vzQPPIr
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

The Airoha AN7583 SoC have 2 dedicated MDIO controller in the SCU
register map. Add a dedicated driver for it ported from linux kernel.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig       |   7 ++
 drivers/net/Makefile      |   1 +
 drivers/net/mdio-airoha.c | 221 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/net/mdio-airoha.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index faa08e9ebba..d2515a98ebf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -118,6 +118,13 @@ config AG7XXX
 	  This driver supports the Atheros AG7xxx Ethernet MAC. This MAC is
 	  present in the Atheros AR7xxx, AR9xxx and QCA9xxx MIPS chips.
 
+config MDIO_AIROHA
+	bool "Airoha AN7583 MDIO interface support"
+	depends on DM_MDIO
+	help
+	  This driver supports the MDIO interface found in Airoha
+	  AN7583 SoC.
+
 source "drivers/net/airoha/Kconfig"
 
 config AIROHA_ETH
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c1f4094ab2..ad5f6dbd434 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_KSZ9477) += ksz9477.o
 obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
+obj-$(CONFIG_MDIO_AIROHA) += mdio-airoha.o
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MSCC_MIIM) += mdio-mscc-miim.o
diff --git a/drivers/net/mdio-airoha.c b/drivers/net/mdio-airoha.c
new file mode 100644
index 00000000000..ac1fb13622e
--- /dev/null
+++ b/drivers/net/mdio-airoha.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Airoha AN7583 MDIO interface driver
+ *
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+#include <linux/time.h>
+#include <miiphy.h>
+#include <syscon.h>
+#include <regmap.h>
+#include <reset.h>
+
+/* MII address register definitions */
+#define   AN7583_MII_BUSY			BIT(31)
+#define   AN7583_MII_RDY			BIT(30) /* RO signal BUS is ready */
+#define   AN7583_MII_CL22_REG_ADDR		GENMASK(29, 25)
+#define   AN7583_MII_CL45_DEV_ADDR		AN7583_MII_CL22_REG_ADDR
+#define   AN7583_MII_PHY_ADDR			GENMASK(24, 20)
+#define   AN7583_MII_CMD			GENMASK(19, 18)
+#define   AN7583_MII_CMD_CL22_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL22_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_ADDR		FIELD_PREP_CONST(AN7583_MII_CMD, 0x0)
+#define   AN7583_MII_CMD_CL45_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL45_POSTREAD_INCADDR	FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x3)
+#define   AN7583_MII_ST				GENMASK(17, 16)
+#define   AN7583_MII_ST_CL45			FIELD_PREP_CONST(AN7583_MII_ST, 0x0)
+#define   AN7583_MII_ST_CL22			FIELD_PREP_CONST(AN7583_MII_ST, 0x1)
+#define   AN7583_MII_RWDATA			GENMASK(15, 0)
+#define   AN7583_MII_CL45_REG_ADDR		AN7583_MII_RWDATA
+
+#define AN7583_MII_MDIO_DELAY_USEC		100
+#define AN7583_MII_MDIO_RETRY_MSEC		100
+
+struct airoha_mdio_data {
+	u32 base_addr;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct reset_ctl *reset;
+};
+
+static int airoha_mdio_wait_busy(struct airoha_mdio_data *priv)
+{
+	u32 busy;
+
+	return regmap_read_poll_timeout(priv->regmap, priv->base_addr, busy,
+					!(busy & AN7583_MII_BUSY),
+					AN7583_MII_MDIO_DELAY_USEC,
+					AN7583_MII_MDIO_RETRY_MSEC * USEC_PER_MSEC);
+}
+
+static void airoha_mdio_reset(struct airoha_mdio_data *priv)
+{
+	/* There seems to be Hardware bug where AN7583_MII_RWDATA
+	 * is not wiped in the context of unconnected PHY and the
+	 * previous read value is returned.
+	 *
+	 * Example: (only one PHY on the BUS at 0x1f)
+	 *  - read at 0x1f report at 0x2 0x7500
+	 *  - read at 0x0 report 0x7500 on every address
+	 *
+	 * To workaround this, we reset the Mdio BUS at every read
+	 * to have consistent values on read operation.
+	 */
+	reset_assert(priv->reset);
+	reset_deassert(priv->reset);
+}
+
+static int airoha_mdio_read(struct udevice *dev, int addr, int devnum,
+			    int regnum)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	airoha_mdio_reset(priv);
+
+	if (devnum != MDIO_DEVAD_NONE) {
+		val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+		      AN7583_MII_CMD_CL45_ADDR;
+		val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+		val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+		ret = regmap_write(priv->regmap, priv->base_addr, val);
+		if (ret)
+			return ret;
+
+		ret = airoha_mdio_wait_busy(priv);
+		if (ret)
+			return ret;
+	}
+
+	val = AN7583_MII_BUSY | FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	if (devnum != MDIO_DEVAD_NONE) {
+		val |= AN7583_MII_ST_CL45 | AN7583_MII_CMD_CL45_READ;
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	} else {
+		val |= AN7583_MII_ST_CL22 | AN7583_MII_CMD_CL22_READ;
+		val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	}
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, priv->base_addr, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AN7583_MII_RWDATA, val);
+}
+
+static int airoha_mdio_write(struct udevice *dev, int addr, int devnum,
+			     int regnum, u16 value)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	if (devnum != MDIO_DEVAD_NONE) {
+		val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+		      AN7583_MII_CMD_CL45_ADDR;
+		val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+		val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+		ret = regmap_write(priv->regmap, priv->base_addr, val);
+		if (ret)
+			return ret;
+
+		ret = airoha_mdio_wait_busy(priv);
+		if (ret)
+			return ret;
+	}
+
+	val = AN7583_MII_BUSY | FIELD_PREP(AN7583_MII_PHY_ADDR, addr) |
+	      FIELD_PREP(AN7583_MII_RWDATA, value);
+	if (devnum != MDIO_DEVAD_NONE) {
+		val |= AN7583_MII_ST_CL45 | AN7583_MII_CMD_CL45_WRITE;
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	} else {
+		val |= AN7583_MII_ST_CL22 | AN7583_MII_CMD_CL22_WRITE;
+		val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	}
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+
+	return ret;
+}
+
+static const struct mdio_ops airoha_mdio_ops = {
+	.read = airoha_mdio_read,
+	.write = airoha_mdio_write,
+};
+
+static int airoha_mdio_probe(struct udevice *dev)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	ofnode ofnode = dev_ofnode(dev);
+	u32 addr, freq;
+	int ret;
+
+	ret = dev_read_u32(dev, "reg", &addr);
+	if (ret)
+		return ret;
+
+	priv->base_addr = addr;
+	priv->regmap = syscon_node_to_regmap(ofnode_get_parent(ofnode));
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	reset_deassert(priv->reset);
+
+	/* Check if a custom frequency is defined in DT or default to 2.5 MHz */
+	if (dev_read_u32(dev, "clock-frequency", &freq))
+		freq = 2500000;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(priv->clk, freq);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct udevice_id airoha_mdio_dt_ids[] = {
+	{ .compatible = "airoha,an7583-mdio" },
+	{ }
+};
+
+U_BOOT_DRIVER(airoha_mdio) = {
+	.name           = "airoha-mdio",
+	.id             = UCLASS_MDIO,
+	.of_match	= airoha_mdio_dt_ids,
+	.probe          = airoha_mdio_probe,
+	.ops            = &airoha_mdio_ops,
+	.priv_auto	= sizeof(struct airoha_mdio_data),
+};
-- 
2.53.0

