Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEC7C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D28E60876;
	Thu,  6 Aug 2026 23:45:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVdEAO1Mbu8x; Thu,  6 Aug 2026 23:45:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77F6660868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059903;
	bh=N8c5qWK+fX2ckBKr9oSa3X/Ns8nu7eixdIg6CBDykpo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MQu/JkbXBulkCBAsS0UV3ABt/ete35Mo+GJ1zjwD5U/IfL4mndaMC6rNzmqDRNWTh
	 sFHrE16mstdq4WQLuiHw42Zm1MLBhAJPADO2yQRU1hbFaP2uFz0o5rDW7eyF9vu0ih
	 eF+q2zu1tVOCwCCIwTMgZvRKqE2GGhIhcpYWMV15hX4Bc8M1J8h7P1KfoZqboMYWhM
	 LkR0GY6v6bc3+SxC8IVHtV89ju3/tRnhsAXznOEO1TO5ldS/znxQo7iTGBmjz3M8rY
	 ohyLnWrMVSz30CIhHtm0n+pIKRS44a3gnBob5ZqOno3pKyacBqEVszRLV19elHCq+e
	 gduAJlO7LRxTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77F6660868;
	Thu,  6 Aug 2026 23:45:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D24DB522
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3EDC40917
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TiXDUTPT7zeE for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89F1840909
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89F1840909
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89F1840909
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD+X8XT1yUR1J9HEArPZqDQBV4vTerUDVTZ4mF3x0x+tE209pOebGQAE0qf9qNy2if72MPBParAnbHAdbODJVBDi3aDfIIs1LxSOrpoVdJPjxuwqTn6Y3grgbEozPL0Jik+IahbK24aPol+5rUv9F3wylW5r2OsEbfDfXc4WzoFSVI5hx1U0Mt3sL/4INBH/1lL7OdWod3Eug/VEsZ+mU0jb0HVar1umk99LSm9/QNLI11mHbRznPQlB/pxjEz0gAOgWCVXBoH5pcf4h5z+7HrgMTwKkfxpKcO5tPe+7CitdYwqso63jboA97CnGOv33f8/f65LRYIwZFQIiZh7X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8c5qWK+fX2ckBKr9oSa3X/Ns8nu7eixdIg6CBDykpo=;
 b=vG/P1PL0+lYCJCEqvX/oeTqrr/9K76Mh+9iNMcLFjecQt3sDpKYDoVEkXLBb1ILbFq5ZSwToV8Q5bcnFa4syEiKIf2ja8Z8igGP7m8Mkz4c9Gi4Jls2vhBFcndPR4IS83dOE6XUaoLnTZY8LapWTj6CDHEzLofsyVqrY10PaGzZGi4zxxncjC5qbK983MAP/b9Mgujhh4iPNvFNwxAbj/HeUtGeYfO5s9LL1/5lntTYczM+BH6oca+Jp3udOPRb2c+HEni8gTwT8Qmz3bs+87AFOlbHN3M7LaqDowDgtFxorbX0PsELqcMXJ8Ws/pEDwTBQEX2JPoYEz6MdDRTGo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:47 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:47 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 06/16] net: airoha: add support for Airoha AN7583
Date: Fri,  7 Aug 2026 02:44:22 +0300
Message-ID: <20260806234432.4098414-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: eaf7ddff-84cf-4aa0-67bd-08def414b2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: liib4XYLAgu6k5PRkYUZsTIkYAcnAS4d2nztUrZ5+TTteSclwrCHjTCmN63bED0W6mX8uVxX2H7hJfFBPGC2PKG/AdLQOzIG+LMqcQHflf/+YIfvP0PIwt+OQLmCPv62B7Kt6lPTYEcuXIjc/GutFjQ/XaFneEczfYs3HB1KVD5hGUE9bMBUWXqCkj2l6BXmEFHiwEa+1ZAtL/YprA+1nov8M9lhY4B+e13awHPI8vx8Qv2wXDEfLaTw5B44PhmZnXu3JrQcunIWvVtsrIv1YWSfPOj1/7BeXjS/ohpe+MPQrAkkPnwf+Zy7Ns5M6TLxq5Y6DaDD2uLY18Zi/oXTTigNVGfLwH006wagrN3ZD2M6+CXwxvUeCWCIdzDq0/dGsCHd8G57OZaKtsEEtoDmxOXlxudbE0jLbjMgtbrnNuILREjwNNB/hv99aVKty1h9TnIOWKFvYkKvQhOYT6RqwEDPNRNs0MsrbsV8urQHPYou7CidP7SCWAS9wre9VXVYKmDBnSOLUHGgngh/SHufAI4rHq1HUSwNNmmdFC5mTFJMay2TqHuSqkxth8h2YhEMAVdcn6Mg7pwGAaCCUyG8hNuBi3CuEmkNCZQPuIs5ReZrGnWl74/qDvVNpATfSjOj69Fj9R/XO9IXFDlGXcF4MDF8Fz+WbFSlU7t2s7NTbMEobnGI3+QkZQwa5n7z9We2pu0THd9qNHtuer5Jk4FWv5RmZp3J93C9YZjRbcSB6AaqsIW3zYR87QHdcUu8NI7f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L16IDqwD2sFv1wMgoI1li8VVcwEa+s5pRi8ZiH5D5BFopUZkxbA7yyPYO04t?=
 =?us-ascii?Q?sspWBKu7uYHeW2RJCQ/5pqyDVsigo178oEqkTniATAM/Jv8XZkR2SJWDUrbW?=
 =?us-ascii?Q?lwcNVrC//D+2Qhi+lmB+GGuz7GVvdaVZiLoTlv0PA1fZG0uJKiSmewShzuoW?=
 =?us-ascii?Q?LLeh0H26AoKiku8rffrDsLb3nBPMkYujZq4B3wBZN0Ko8ZsYNGG3DynPBEUM?=
 =?us-ascii?Q?YoOjkiHAJhJC4bgCGv7oQGmvFreAYHblH6SxXqU2xx9grgMZrReE4kkUjnr7?=
 =?us-ascii?Q?tURvW10V6DIxjsSGLIBzEvsQ4XocvyezyC1ClfD89AKvegkm1bVebPKMiKjm?=
 =?us-ascii?Q?GI5VbBJ6J69wiq4BBNk8Ipe03RhPytOix90QPXv1d1+4hB/JfbKpgHVX5kOK?=
 =?us-ascii?Q?tpntEj6wW0jmhzK952mfTf7jbPlUgkhsxb0Mfwkb/7jl+fc66gAwXDIYRZNH?=
 =?us-ascii?Q?8UwmWLvaMJQjKmlsentYHFjpXoLXmqfGqc8JHoZSQovnzbgOBjgtDUFAwpBz?=
 =?us-ascii?Q?RxqHv3vz5iIW+kDONOIcDPRRHQYJWsBbuZKqSaWjtfkd3rFtCrA28TW/M2sv?=
 =?us-ascii?Q?dVoPC29DbIIQ97R6sWiqgRDskBFsFMGOVE0QF1z9RSqai5qoa9/JXi8zmJtc?=
 =?us-ascii?Q?ax3x5k/8I/2KkiIykMCVCfyPfSrqF7/krtaouYGGH9FQK2C/eXOFkFkAduTF?=
 =?us-ascii?Q?YDxGuiWk1fJoALAlnFswVwGysqq64/wOOlV+USHW4jHCyZOfUX9SQIAq+1oj?=
 =?us-ascii?Q?WLS5JY6tAf2nyjywbPR3XHU5A7lpt6+ZTD18Ph59wf6oJj4ngC1dCyTTi2XM?=
 =?us-ascii?Q?PhaegkXQRn29Q6MNf41zQXq6PTaPjHMtHeTTufMk5GXC2qcDIpvaApZnVt/O?=
 =?us-ascii?Q?WhVfLxyR/UMFObl3nYyf6SSAotlCkFxRTzl2yXQ03rQa/P0Lu3NFExe1NvLo?=
 =?us-ascii?Q?ubu0nbFEcjedg5Ix+C9quJyp7xtmqD8XUo2FpBDdPfCLBE4GyD4aZClKADfv?=
 =?us-ascii?Q?o7zNb9Orxtnsx9npCLKn/jCuqUPHsSefbTWon4BUlkE/GWF1kjS2R8nLNMfJ?=
 =?us-ascii?Q?4rebIoY82fIHSCHTh8MP303Zxy+XECFEc6nsHAgOSft0LniOUIiylYU2O22M?=
 =?us-ascii?Q?lVb2ttrTxS4QEXaVwUyojDZx9+Nw9rr5dHwsUL9+SslXyBUWDp61S795sP9w?=
 =?us-ascii?Q?30ib2pNOgZ5y5mqZwF+nGq6aenADmTOYhMoU/8l0mqCSBWTqejtQq3i0u5K5?=
 =?us-ascii?Q?CakiOfi+F5K3Ye9KLe7WrrOJBG9tMRvzTlypYH6hXHVAutaaJK5esL/94FJE?=
 =?us-ascii?Q?Qhnb7DxOfkJDGKZKCZPV1v7w5OBiWSIbu3a6Aa8H0yCBl4kKSJ0dEEAdXTbb?=
 =?us-ascii?Q?NN6FAvmwHyUJ35molXStZJU54zPjCfKRCfzmCEf69b3cDdS9Ss9ZmPjqGY3L?=
 =?us-ascii?Q?xwW5UuzgTfuSYmgstVdFr2okxRGc+eRhfMcvBB9+bIVqsuxK1gT7zrLOIYUg?=
 =?us-ascii?Q?N4g6ZKzbaJjVPZYMuKUdEpemgtn6R6U09gh4eurwGJ9a4IfsNYPBy9MGdCsy?=
 =?us-ascii?Q?rU43/h/MgyQKv65XRT3HMs2NIMapdKWWE6bhyVxOpJE4zH1OuHLN5oay61yX?=
 =?us-ascii?Q?9sG40tT9fuKyJO/TU//lj+VpRX8qBIskdbdjsD692/925dySIW4jSS7+L+pw?=
 =?us-ascii?Q?sohrP6oQEWyCI/qbKLpItYcwtW2nWswMdTQ7rP6E2lw2ldDm1GQwXxUYhF/E?=
 =?us-ascii?Q?/Uum8I0qAkW5hrm3rxp6gmghGfRPQGg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf7ddff-84cf-4aa0-67bd-08def414b2c2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:46.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyp7+ZgDOlywoZ28NFXHy0+h69jp/SvkQ3qy6Bfh/YE0dR09WsMm5D1G+A6fOBq2XJffpRMivRd+DWV0RqVBCgVR1DU4IYCRjW8pG6MA30I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8c5qWK+fX2ckBKr9oSa3X/Ns8nu7eixdIg6CBDykpo=;
 b=eVK+xZ6Clev1DYewJec0Wu8xSBMwK8M4yvmkqQKRKnMXWtQMGPrQjJuPyAQOHKuqMyNI9neAwEQCiU+xE86eGJcb5DW7/SM/sLLfMvEm6VxygpIEoQ7g0fmZFsBGIBtlXWdZIKappA4lVqagI6ky376fJOYquyoqn1wyYNX4R2FsQp/iNU12GHlo3giZFBPCsgLCH6z8EyyGzReeQ8desijdFG1ZCW//1pHmnCKXk9RggelWK1i8yfQ/DLYkD94u/3znxiuW/XUf/wfXrAlMtXDs3xs2ssoH0+zRkK9p4vfEsfVjMFi32gBbu1xgwipV67IvorQts6SJ8aFXOauu3Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=eVK+xZ6C
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

Add support for Ethernet controller present in Airoha AN7583. This
follow the same implementation of Airoha AN7581 with the only difference
of having a different reset number and a different logic to reach the
SCU node.

Generalize the driver for these 2 part to account for these minor
difference.

The switch init part also required some care as the Switch Internal PHY
enable BMCR_PDOWN by default and tweak to GEPHY_CONN_CFG is also needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/airoha_eth.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e5d39b95cc5..d552b9e9de9 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -24,6 +24,7 @@
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mii.h>
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
@@ -34,6 +35,11 @@
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		4
 
+#define AIROHA_MAX_NUM_SWITCH_PORT	4
+#define AIROHA_MAX_PBUS_TRY		10
+#define AIROHA_PBUS_SLEEP		100
+#define AIROHA_PBUS_C22_MASK		0x800000
+
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_TX_RING		1
 #define AIROHA_NUM_RX_RING		1
@@ -86,6 +92,19 @@
 #define   SWITCH_PHY_PRE_EN		BIT(15)
 #define   SWITCH_PHY_END_ADDR		GENMASK(12, 8)
 #define   SWITCH_PHY_ST_ADDR		GENMASK(4, 0)
+#define SWITCH_GEPHY_CONN_CFG		0x7c14
+#define   SWITCH_DPHY_CKIN_SEL		BIT(31)
+#define   SWITCH_PHY_CORE_REG_CLK_SEL	BIT(30)
+#define   SWITCH_ETHER_AFE_PWD		GENMASK(28, 24)
+#define SWITCH_PBUS_PHY_IAC		0x7c20
+#define   SWITCH_PBUS_PHY_START		BIT(31)
+#define   SWITCH_PBUS_PHY_CMD		BIT(30)
+#define   SWITCH_PBUS_PHY_CMD_READ	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x0)
+#define   SWITCH_PBUS_PHY_CMD_WRITE	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x1)
+#define   SWITCH_PBUS_PHY_PORTADDR	GENMASK(28, 24)
+#define   SWITCH_PBUS_PHY_REGADDR	GENMASK(23, 0)
+#define SWITCH_PBUS_PHY_IAWD		0x7c24
+#define SWITCH_PBUS_PHY_IARD		0x7c28
 
 /* FE */
 #define PSE_BASE			0x0100
@@ -365,6 +384,12 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static const char * const an7583_xsi_rsts_names[] = {
+	"hsi0-mac",
+	"hsi1-mac",
+	"xfp-mac",
+};
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -405,8 +430,12 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+#define airoha_switch_rr(eth, offset)				\
+	airoha_rr((eth)->switch_regs, (offset))
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
+#define airoha_switch_rmw(eth, offset, mask, val)		\
+	airoha_rmw((eth)->switch_regs, (offset), (mask), (val))
 
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
@@ -438,6 +467,8 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 	case 0x7523:
 		/* FIXME: GDM1 is the only supported port */
 		return FE_PSE_PORT_GDM1;
+	case 0x7583:
+		return port->id == 3 ? FE_PSE_PORT_GDM3 : port->id;
 	case 0x7581:
 	default:
 		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
@@ -809,6 +840,59 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 			 FIELD_PREP(SWITCH_PHY_END_ADDR, 0xc) |
 			 FIELD_PREP(SWITCH_PHY_ST_ADDR, 0x8));
 
+	/* AN7583 require tweak to GEPHY_CONN_CFG and clear PHY BMCR_PDOWN */
+	if (!strcmp(data->switch_compatible, "airoha,an7583-switch")) {
+		int i;
+
+		airoha_switch_rmw(eth, SWITCH_GEPHY_CONN_CFG,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  SWITCH_ETHER_AFE_PWD,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  FIELD_PREP(SWITCH_ETHER_AFE_PWD, 0));
+
+		/* Disable BMCR_PDOWN for every PHY */
+		for (i = 0; i < AIROHA_MAX_NUM_SWITCH_PORT; i++) {
+			int try;
+			u32 val;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_READ |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+
+			val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IARD);
+			val &= ~BMCR_PDOWN;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAWD, val);
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_WRITE |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -1269,6 +1353,13 @@ static const struct airoha_eth_soc_data en7581_data = {
 	.switch_compatible = "airoha,en7581-switch",
 };
 
+static const struct airoha_eth_soc_data an7583_data = {
+	.version = 0x7583,
+	.xsi_rsts_names = an7583_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
+	.switch_compatible = "airoha,an7583-switch",
+};
+
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7523-eth",
 	  .data = (ulong)&en7523_data,
@@ -1276,6 +1367,9 @@ static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-eth",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.53.0

