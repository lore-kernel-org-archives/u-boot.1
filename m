Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA59C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A4683F4B;
	Fri, 11 Apr 2025 10:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B7Eij0bv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5ED83F4C; Fri, 11 Apr 2025 10:10:19 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1E5683EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOp1lyB9XpMAbkRz73h3NpU1XAUUnCkJ2/Kj8jzbXXsW5pSxvL0Ko+XSfvWT6AYf78F6HcrxQm6ddt1EoWu5n1TFqvyvlgxnt6gBdb8+LkTU00L10MRRw6y4QWEV1VAncxl1SbiXHbcDzoWuSeuZKd06SjEcP4wqGLrceumtSXAzbZdiMueOFAa4BiB+htDHU7nlHzVqlE8+FqBiXASi/Uptl1V/L1uWVD2VFuNzUGJdqBHNBr1DfTqQMnyGtA48yowuee0vqSZ6QSYWpReiHZDjBwf+0gpHUqpW5Vt7AVI6LLUClUQfVsVbv2ungGlh1DpHyvfEE+Wwzi4nrpg8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZJ5C2cp2HBaChY2A4GvJE3CfwUY+oGi/IiYGuYutzs=;
 b=T+5NJ7Rq71sEtp/P8jZ46TgwAsfJc/9bwMcMpM059GF8gPxCqM371sOfbcSsgQRuvIbLbzm+sZz3lFmoFOIhrDaOWFhtyimuJEi4aF34ws789D9hm0x/0D+PeJIICEtaQyteLe4pJg5P/CY0vePy61rNvv0RKdzfMvP2Q1xJPHgIVXBXkf9muZ6/dZDwpUvqA/I2F7TZJQlWboJTld221nkTjAUE4SX3AkV7n+KG7B8lGzcO/soXSwEORozIir7NTU+H9cbrwOZHfw6won+e3kHJ48UL+h+EGmlX6iaQl6mjh7bJtsq+E7s73i1n3g1YAXJppKAPqrMjH9jGWWhnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZJ5C2cp2HBaChY2A4GvJE3CfwUY+oGi/IiYGuYutzs=;
 b=B7Eij0bvf0P3t4tC+k4/aayIytDksCRDHB526Wimoaj4omotcl6SXJGJUrihmDty3LmH77v1edSipKEzuS/As+5iytxcTz6QqesIqxPFMZbA80doE2RfuIzlrZWi6g2OMuAOQBQNSvWJoIsCaYaqxtbLzUuGmdq+/lBzfuqScKIE9YNM1VvJSfk2E5oRt+BTqjmKHCMUWV36CfQQ+V8gTSkS8ASnZLohMuLdcWo96muN0JLWKH0qURyzcz8/gEK5vLqBb2d3rVPZsIC/O3NVzzLKeEeMlALZoCARQ4Cl8BmBjWIv4akMwS2hFiW8UHcZQROigicpC7c0YS4QfWNmNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:10:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:10:16 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 05/20] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Date: Fri, 11 Apr 2025 16:06:48 +0800
Message-ID: <20250411080707.602371-6-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 941f8c16-2a73-4454-14a4-08dd78d04aa9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p/WOajhOtFIpSXCYEFzPLeX6xzlGwxQNYoJSKojEr7fysE9dyGY29ARRup5H?=
 =?us-ascii?Q?AM5rOg/MyLybEzSLEfyugB8icCsx+YcEAf3odPCN9J5QfbO5ZJ58X14RFvTZ?=
 =?us-ascii?Q?h4qY2E/FsLG1XsTJ9JC27CHCbthpxy9CRraX8jH1/9MOllYli4iN2E+Nryyq?=
 =?us-ascii?Q?/6W/s1BuBAeWwB+8Q3aR9dHZulGZ4Cki/QB1G4fhEC5zdBEMFQ+35UPPTWD/?=
 =?us-ascii?Q?cgnllMcqgoX0jkn6YTK7D+op4ZTS1J9oI8e2H3LDAeRc6OVYx8TADBuqR4vG?=
 =?us-ascii?Q?gGtZ4EF5xUgxD8wiTA/DkISB7UscDSiu+jetq1VF5yvxNq3FXwqqcXCreElY?=
 =?us-ascii?Q?E7qDCdXaSxuCij+QH6IYOUDB2CN0h485lQyf2WN3HG/ErmugSVHgPg5N3KGm?=
 =?us-ascii?Q?ajKKLEIWBULt/3ESG7xWjCeD32gQnuCD6U6hDK8aBdN5UjwiY/zsy7756o4M?=
 =?us-ascii?Q?lBx8icviq9VBirxuZMEI7ohCgrFDdAMihgK1+SjIszrETcHv89C0BpuCIcc2?=
 =?us-ascii?Q?Q5HbbvtbpOP88pALdfpQXm3AwAQIk1O7y/pZfgdb1h+SGNQl/OPj2nV3/VW6?=
 =?us-ascii?Q?z6qFP0rkIZzANgB5LM/AxM4Mcih2BXl2tN24j/RzQ0tV5liyBxeXHtbSV+5b?=
 =?us-ascii?Q?3nBkErqzmq6X8JSbh9iLkSuq2CsuO6zrdJQzvq4D0Vm5pI8uSJp7QFPsRkTx?=
 =?us-ascii?Q?8Q2aFNgPI6PNI2ZgqmGgobuq6NiRrO+XW+3PyPimPHsTANoW9H2XhByRQNvm?=
 =?us-ascii?Q?BZGztiNfZD1RaI218FflMHzPGr9Yr9O/p/phh9gAVyF5AIiaML1Ksw8fyeo2?=
 =?us-ascii?Q?qqwFzVM7W7A6slF1KD3zYf6Sw0O5nb4IkwzXR3Yoi864CfPIDcVaLeh4TqnO?=
 =?us-ascii?Q?xmQzVrJxuNb3wJzOXObo+E1zPFcYmhgFPX7suzOinhIR8X+YA0LUEHADDoG/?=
 =?us-ascii?Q?sR1J4XCmf/V8/kaAKCCGh3GDHFXgmEU1ofSdN4+CcmIRfmgqxJ6phtIcnyhl?=
 =?us-ascii?Q?H640PiMIPyg8tAVDH2Lit/VBfZyKDNA+qY2+RFZlSnJb3x/en+ff0MAZdU7z?=
 =?us-ascii?Q?LmN4ELWClS42wbtzk2XqGmHYnWYsy726q/QqZxYpzfpcBdtqBUrDKoKFkOb9?=
 =?us-ascii?Q?/OWqDX48EFyfy4c+qwVLJ7rWfIahXNHWob6B+W/7YkelFGdjkM90MfjAPUjC?=
 =?us-ascii?Q?jbxOWOFsbJ3PoeH4pW755u1OFaNxCEt+pqOyUr6EeMw74wU5iqJGcTBBF93B?=
 =?us-ascii?Q?F80Uj0ctoUzeDIFdZEq0W6KINTmZLUUGapxooVM/O5Ew+g4s9Dvze4bql9/d?=
 =?us-ascii?Q?OAvwpVTqlU0ntW+V+Uwnc+CggME+LwSqmibR5ZANnkaooP5PVsJelVUlGjvY?=
 =?us-ascii?Q?qYqLj4pJkGtKIcHSkhkkjcfTh9cd+f0NeRwGUI7noC0urkjch1h9CIzHFWiY?=
 =?us-ascii?Q?CjGZrq+tq+cn3YH5ILGqAUfykpw4C6gPa4+Fwp1imfA+oT5M4rB4Ow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7WN4jLXlNUUsfFIQFyC4DxZZ+uvSCszCS2UhD51Anb07MyzGO5gFwVpUk6Iz?=
 =?us-ascii?Q?iVBSachsAPygj9han5ggtMYl/la0PSgzf4FsfYYOhQmxu/A2HUWcN8TH6hVc?=
 =?us-ascii?Q?lR9RsH7Gj8NzpehGcrA3GxH3ZeREiIWsXksTkyEhV+uImDG82UYY7Q8FZFWq?=
 =?us-ascii?Q?0OLUoDV+vpX/3jZCZymYZW0wwldhYojMdXJw4zyJ/y+uHcnOJXaJdQkJ/rFq?=
 =?us-ascii?Q?VPNzFbCE4+7aBGlMBnb+nH8No2JtRnVOpTH78ld/zZ/YlfAlh1y7OD7bbKDs?=
 =?us-ascii?Q?8fp5f89Sq0AGeCVS1nwpOOMrAgKVMBj0Oh9jeSf47966msHNlqSPQ1HL17pf?=
 =?us-ascii?Q?z8beRPJjYexiAh5z5h8t2rH9Oi+ktZaufExJq1hc2obHc93Ff8ccLEQONk5b?=
 =?us-ascii?Q?Sa0M1pTKt/Y0zjb4oHQnOaL21dadzECNLuPG3PGnTAjuwMlDN/JFNH/hTGkS?=
 =?us-ascii?Q?UXerQRyS6sDetQxSO2XFOZShfuxrxNTc9+iHQADX1pVE4XJr/qYpO/OjAkRk?=
 =?us-ascii?Q?9ORkPEQUk2jmClyQwoutMmiaTypu2SLnjB/GbMk5zu64QOfBFCERs1DVvxSU?=
 =?us-ascii?Q?ayAOiZGKyZMrpzPUHV63GyeLJNhcc9h+poOTweP+cDQXox+BI7U013m1es9U?=
 =?us-ascii?Q?9xt5+ZC9Qw7rtchCTcAFooOnyNloZcY73A6MIXDH3YAgn/N6NweTNgm0+Mqt?=
 =?us-ascii?Q?Kuog6Vz7PFGKqKqJhvPomR6qkf4894GendRF1qln9zE89A8ZQxXDTuAtvCJh?=
 =?us-ascii?Q?Uz8Pbbr+zEdM+OeUQBrQpphcwUBuwKC5E78K9nsjskLjWyQ0VlF/YuD2Uds0?=
 =?us-ascii?Q?fInLhqdVKzS8dSOkAJPecK+Xp7xlGu/OjoSvjWhfxe30thM9wpSkDM8OADOa?=
 =?us-ascii?Q?cdI7NVwSZA3jl1BTLXNrpi5nbr8Ic7502IzR0jEuUz9YlTWlAdvk6jNMG/lo?=
 =?us-ascii?Q?cwYuEd2NGwEahjsxX9xPoJYTHkgyg+G6iZY2OFF9u60IotpkYpYikyvmYPjN?=
 =?us-ascii?Q?Y/7PryGlyJFC7mH3/nUS/MVsHruxX2VXLeDi+wixTrniYA6K/JH50z7OsEJ4?=
 =?us-ascii?Q?yeyAQnkFv6xC5VobSNIsArhpXZ2nQaBjCx3+dVSueer9ubqpbGFqaL2rZJjO?=
 =?us-ascii?Q?UIJz3b/s2ubLcXjR1R6snCYZ/6rLA6ZqPsZoEeS/gtEU+IOAVQEAn6QKqWm9?=
 =?us-ascii?Q?DRWEWRo04pQDwf1dDWOgnrAj4wLjfBYGTdDvPECNdk8qgGO6GsSk5M9t6a1s?=
 =?us-ascii?Q?X/RYZm4IFtJLtY0E0GNXSE9EKCIvOvhR10Dbork2tbAxE8vYg2TJntf7U8wK?=
 =?us-ascii?Q?hvbks2P70ZgGZB+RsG0WrDxBAhL8Zwp7XPTFlVxzm/1IsI0CWYV/dubwE9zT?=
 =?us-ascii?Q?bKhhu8q4wG6e5p+U2QyR0FIEcT5a02ag5zSwIizLCY8uidZ9YZ2Ey05Hej8l?=
 =?us-ascii?Q?vlkTClzX6+0zfF3oo9KsHOB4prOLIbdGnq/6C4xOqgyy+IuDw581jp/V9REv?=
 =?us-ascii?Q?6gyxaP6dmbXFZg0lo922vrFYHO0ApbmC4cfgDoUmk3zwXJ2LOkPko+//NIR0?=
 =?us-ascii?Q?NXqygMViEuQ8Vpfo9kVU8aNFsQhhSZoGWBzYLMwn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941f8c16-2a73-4454-14a4-08dd78d04aa9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:16.1253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGOmXjG1hV3e6ZK3kKmtZ+aLu0cYvvz8nf5ZMrfDP5OVDK9JcauLYUPSYpUJ5vUyq2YqaE1QrrSmq2AnMhX26A==
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

From: Peng Fan <peng.fan@nxp.com>

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f8..34f272c448c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.43.0

