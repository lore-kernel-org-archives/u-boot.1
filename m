Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10083CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F678313B;
	Tue, 14 Oct 2025 13:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SW+nn0KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D7B5831D5; Tue, 14 Oct 2025 13:19:19 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8118E802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fuhap26+Db9pG0MVqdYa9MJqg5HaSH+kyahhl+qqdrp8CNVQSeTflkyYyCk+4woszoTHoPzhOUEaNQn36gyc9MWDyn6XLAqQzMSa0O8ymplqcTQ9rZZKv7mxAmvIHXXJ7wiKYO9MP0KHLsPBY0y4KdRTz5d0hRGil9uJLpxODvhyqD1SRsC6LeJKxLQo+eYb/CNjA5n1Z4YeLAB/hFfoggqdzk0iLtaOBhqMSAnnq04UgB3qx2fJvfELc4m3VZPyCJ4M6VFrpfTVbp4zcD526zwkhRjG2ba+wEJBTGxLE6SuA02524wOfghV/aWkUZ3z45GubLGxFwxTI1I5+FIZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EcDQH4qkR7MS1oLEx2bL9FsNsyZDoeO7EbeeDjevxQ=;
 b=dhXP97PyFdJxgLANva8/DpZxFifxjT5XSucfCDLMkDpLVA+kgn+SvW1q6cybiIBPhFTQASFzqm3xORax8DjiEWd45AGlHmhySy9YrrlhKs8ZwP+cyMEqo/k+7Nvf+Fxp/t9enjQyKdVduLgP1SRax5kRp9ScMJ2ylFfNXStZs4bcRpQGl3TKXRe/4q2joosAcCNStTOPgFB8iVulwvkMxVWe7PkpTC6gkhqjqR89BqM7+uqR+ioF9Gi8dL+uDqxaitHyMKd1/hfGKGGBU/WVj/hnPuUpeoB6DZmZc47uhXbvEbUWmtuAUXR78qbbdGjz6cLLdnO2NWd6kE1MBv1/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EcDQH4qkR7MS1oLEx2bL9FsNsyZDoeO7EbeeDjevxQ=;
 b=SW+nn0KQVhP69GQNoOZcYzRFFgPDUM6MhcCfqXLylnvX2XCZ72IphuWHtYyujqxNv1lEhrTrdPEUe/lBJqHBdwZ44OODPvXm0DJGyR8o2mwbQzMZgq9mhLRYtN0K8OH/r6pK2M0zgEp5Qp981ztLBJmaHdGlQbxc2054/+1gWiCzbodh0GL60MCazLWa0ffFgPei8njReLQhHCozhF1/rASkbEPSqQWtYOkkvvIgDIsWxISejgEb63jckpTrQk7afcTuV4XSoCgsuTYls549+vXCTmATX/CstpiHir+/qoXTWzPKkXeO2PWgTQF3KrUQVMj2CRt/LW6kX12Bb+RrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 11:19:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:19:15 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com,
 sbabic@nabladev.com, festevam@gmail.com, jagan@amarulasolutions.com
Cc: ye.li@nxp.com, alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sjg@chromium.org, mkorpershoek@kernel.org, marek.vasut@mailbox.org
Subject: [PATCH v1 4/4] imx943_evk: Enable XSPI1
Date: Tue, 14 Oct 2025 19:17:56 +0800
Message-ID: <20251014111756.446456-5-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014111756.446456-1-alice.guo@oss.nxp.com>
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3258304a-ed5f-43d7-912a-08de0b138266
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZFDMB/QOgpCZCDidQG8jwAh9oLeEO3hWrfcfKP8o54jaTCeWF+GokQZHNCAW?=
 =?us-ascii?Q?6aMW67ZXeqqrmYJ1q0u/R+YK/sbhkyIqz5n+HsQ2SXpD8a7Ihzw8UaoL+3Ft?=
 =?us-ascii?Q?mrGDktHR1FrcePC1GefyA+a07SXtiOuunxm18M0Sb+T56nTyBPJKZKjsOf6m?=
 =?us-ascii?Q?TK6hZAofI/fZWZ9nmjWyi6vPh7VWhzIwo2UVuA2HjwVJ6j/7xZu61Z8/jxLA?=
 =?us-ascii?Q?pTHkQEi4FzPv2qY5tVesHPUlS7Fr7/IX3Tb61de+VSDwGNRnzs038vFtw1zN?=
 =?us-ascii?Q?KWgVO7cLkNI9+MbGGAX/PZJ2Tn6q4qbrHI1107zEQ2Rk836LA5akgaP0i423?=
 =?us-ascii?Q?thxAGD0bhzTTm1KksT/9m2orCaAdrWYviFpZrppmBpiw6gUy4B7IXJ1zBu4o?=
 =?us-ascii?Q?HgHUkU4SEpib4v+5EjsWhsTCMFOH0BBb7+z53oE5tTX78TSSPJNKk9r1GhdJ?=
 =?us-ascii?Q?QwDR5R32K4w2Q2c6AXpdBtlxnXi/Jh/6l34K9gAXiy3tR35gt+SnQHrnVt7+?=
 =?us-ascii?Q?PDHKQPPffJD3ioRoeaDGQJXj+ES2bFUsBrN5sLKS7uILtpZvnZVOZrHVE561?=
 =?us-ascii?Q?pDF5m1SwiPO3tO/GPV3pYUtBSHLRH7SbwI1HwTa6FnzGy0ZSBqj9uvae0Bn9?=
 =?us-ascii?Q?SoLfgVui/E9unu325DUX0GlU4KMY8zzNRVv0bz24VVjNvZdZXFYY6vICP4iy?=
 =?us-ascii?Q?wn5zQ7gBizpV4ADY8eZXa3B9PdGUaOHallq/TUQuNKYuivDjLG6L80969ENb?=
 =?us-ascii?Q?0KspUTASUhOWZ5Ja46tgNVGZ2jKEVa8hskIzDJHKkc9RTJig1cJ+X7XFvHIW?=
 =?us-ascii?Q?s/EvOeEEdssmi+2OxTm2HwkkUEIopDviEFKGO08sHyHJ+MBPL2+8Q90CO+VO?=
 =?us-ascii?Q?emayw/bNvZEZL8/pTU1ZxztwIqlC+TIWD099C3EvkWhWbP+YLaGKUWI4WmkI?=
 =?us-ascii?Q?vfpfmXWxpuOvpySDyp8lz0ySXXeGCpxFo3/BEAm+Ej+3SMOjgkMoQSJQaNlH?=
 =?us-ascii?Q?VxKCs+lBI5ev4Hz50SEmUu6GInr1JNrB1y2NSrBHAburx5zxlItMSR8QDWyH?=
 =?us-ascii?Q?nvdrlxEDSJe9faWkwWt9dXOorKiy6xY/k1UQDX3zuvw2kGx/92pNC/8poMyq?=
 =?us-ascii?Q?OQHGd7xXX4B15yUgE2d2EdQK4RSQe+nHAJ5uxZxCMfzqYlWpWpNMZOcUkyd6?=
 =?us-ascii?Q?vcH9H5ejXy3pQN5D3sJCT6jyxutRotjcRH75N3wRzdCPcPFUCxkIBeQMKIR1?=
 =?us-ascii?Q?KCRuf0A1xeWsm7T+KSmmt9uubkrYLH604Wx/nk4V2LDofRJJXZcSVFoLdGue?=
 =?us-ascii?Q?Ia5qIQuQ7gocVwpuL9h/QTzCIAqGqaTJ69JBOTRueFhgZr63J7wgqoZ4ChTj?=
 =?us-ascii?Q?/nW6GchRGlCTNgtcwzta38rchkWAH6YwsOQzxsR+OqmhrWn1Z0VDdkJb2Pt5?=
 =?us-ascii?Q?tejgXylk+Ge/LL55Sq+cg2iVL0pA/bcs0wab45slUxcy7I+xTNUX+0aY/8qa?=
 =?us-ascii?Q?X+ou0JvHYiBJ+1Hadl0+MCFvZx6dfreosb9w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUN14WH4CLpHaMdPyN6H0eTVwaE6cOP0V+MGyW6RA33hI064gx8WA0u4n8XH?=
 =?us-ascii?Q?skg8NxOgjl37gWoQiBmPbIxRMZTHPEkYPJ9GNQFIz+3v3T8yN/sVZmQgLPWy?=
 =?us-ascii?Q?E/aCazVW9W9F2CBolTs7wfOk2IAi8JG/nl4YDqcg9eE6OCcY31/USFmuMmy0?=
 =?us-ascii?Q?oRWIpbA9027j/vKKw3qACtr+aQGb8oXtOCqSsmozcTWVFIj7eW97Vvr7ymvL?=
 =?us-ascii?Q?NHHpi+Hz9fnRc3fL7mAfO4+kE8CBmSzyJfRuztLFuCDg+k4fhpIRWPdr0506?=
 =?us-ascii?Q?d+QuZm+WB4kdyQ4ePNAe2eBmcd1TCeOsVN4JgvXAWc9ik3iwXyj4chqRiQSl?=
 =?us-ascii?Q?h07kkUN9bb3Qgiso8OUiJFGfjyZxsBC7MJQFWFkHQ/28i4xYWyW54Y45ijbK?=
 =?us-ascii?Q?lFrCa2ZbIcc/nurGtkjSKjZpg1yoPdjjQHGCxfyHhPHaBXVYabvY10CulQBf?=
 =?us-ascii?Q?cvDALqLzpi4FzgNv/zyWsm2meCKT9F+w8a/pePZ6WGADHidtqlUWT6ZVk4zP?=
 =?us-ascii?Q?UyiVKq3RuU+82ZzKJBxfZ5AYvHifde7Y5u7qIY46fMNmH+/OtGv+IR2B03wO?=
 =?us-ascii?Q?daUV0SyrCRWDRLy4pdwCvE38riXjdFK8nt6fTSvpWVNTnLtKmwmN7rOLjgLJ?=
 =?us-ascii?Q?9aN4UD8gMBNRO8uxTUBfkTi6cQJ2HsfZBHEEFvcDIp0eRqByMJ0S3mLU7GqH?=
 =?us-ascii?Q?U1tRN3FfpbMk69yqXOKoM9LecctSUPS3UGb+X1ENooQMAkHkmATSCOIeq6Ll?=
 =?us-ascii?Q?u5Qv9wp6HN9Vjnljh1cUHD3FaH4LRwLKA297RTMIfWroBxT8NCAXAwu/0DIA?=
 =?us-ascii?Q?eCueZgxntJBpdULZOZpm0L43TujGvLkaYU/4rVFd/2WHr4txITNNnFDvq6z+?=
 =?us-ascii?Q?boti5jk5urM9qz3sHGWG+hgASa+axf8ZNb7WOrdrxIXc31X813LP1AUcdBn2?=
 =?us-ascii?Q?fJ3KDFE0hZjOhmbaF6eNQazkPYg1xFbciQfe5Ku6Zm6oMWKlVwdod7djNz4F?=
 =?us-ascii?Q?sRJVvDpD11ktXucpdjC2mj8AyZ0S/OwhRdsGvxL5wL0Mes1KXT6l9dMPX3vB?=
 =?us-ascii?Q?GWObQAmIf4ClA76aqFXMcAycPnhvTuD44Lz0LhSSLDaynEZpSd7gq9T9wUlA?=
 =?us-ascii?Q?CMKKf6qo19bYAAg6FeD2s7SIsEMJbe8m00vkoLSSGuFFv25RzVNg0KwRj0Ki?=
 =?us-ascii?Q?WbeFuZauumvLxqWta0VA9cfFKzqZvmm6ZYdgU3fzOR744dDWAESWO9NkRonI?=
 =?us-ascii?Q?VxytFtIBfY3iKgNRvJlsMMk9vu7X/MJDvDnKDn+eS4nDkQ77D9SItKm7nGUv?=
 =?us-ascii?Q?YZXe028KnQ9ZnERcmX8FrWPjBQfqbbKoEXeBlfDyUBQnRrq+xLYOm8JUIExM?=
 =?us-ascii?Q?x/HClhdqV1MGAesvRNwhk3C1uRsoHogRacs23u2teWE7QsiiqbXxBX3RyX0V?=
 =?us-ascii?Q?9V3UlFAvFlVyCvKy0+5zxtjFojt3pe+LlXE2Z6rkeP1m3tC7iFBePHwV7dD9?=
 =?us-ascii?Q?uS1ZeqKL+ML2PgIYjGV3puRBBynVRIsfgRqes55Q13FTFOK6/6zwLxyw2kQ0?=
 =?us-ascii?Q?352zpINz4D1Mkhrlh8bVZI1E2a+EWHKExvuu4cIx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3258304a-ed5f-43d7-912a-08de0b138266
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:19:15.6573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0jufgcNIxrcOsk6LdIAQIMgBb23wXxhCNJ6Ky0Hw4FCe2T0CAvrZHRVMX52dh2GmAdkSsQtgREW60r4jcRL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

With this patch, XSPI1 are functional on the i.MX943 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 34 +++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 16 ++++++++++++++
 configs/imx943_evk_defconfig        |  9 ++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 528b3b02a3f..247a7ed6838 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -157,6 +157,24 @@
 	status = "disabled";
 };
 
+&xspi1 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_xspi1>;
+	status = "okay";
+
+	mt35xu512aba: flash@0 {
+		bootph-pre-ram;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &scmi_iomuxc {
 	pinctrl_emdio: emdiogrp {
 		fsl,pins = <
@@ -205,6 +223,22 @@
 			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
 		>;
 	};
+
+	pinctrl_xspi1: xspi1grp {
+		fsl,pins = <
+			IMX94_PAD_XSPI1_SCLK__XSPI1_A_SCLK	0x3fe
+			IMX94_PAD_XSPI1_SS0_B__XSPI1_A_SS0_B	0x3fe
+			IMX94_PAD_XSPI1_DATA0__XSPI1_A_DATA0	0x3fe
+			IMX94_PAD_XSPI1_DATA1__XSPI1_A_DATA1	0x3fe
+			IMX94_PAD_XSPI1_DATA2__XSPI1_A_DATA2	0x3fe
+			IMX94_PAD_XSPI1_DATA3__XSPI1_A_DATA3	0x3fe
+			IMX94_PAD_XSPI1_DATA4__XSPI1_A_DATA4	0x3fe
+			IMX94_PAD_XSPI1_DATA5__XSPI1_A_DATA5	0x3fe
+			IMX94_PAD_XSPI1_DATA6__XSPI1_A_DATA6	0x3fe
+			IMX94_PAD_XSPI1_DATA7__XSPI1_A_DATA7	0x3fe
+			IMX94_PAD_XSPI1_DQS__XSPI1_A_DQS	0x3fe
+		>;
+	};
 };
 
 &pinctrl_reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 2b93ba9a38b..39092f31a61 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -141,6 +141,22 @@
 
 &aips3 {
 	bootph-all;
+
+	xspi1: spi@42b90000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx943-xspi";
+		reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
+		reg-names = "xspi_base", "xspi_mmap";
+		interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,       // EENV0
+			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,	      // EENV1
+			     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,       // EENV2
+			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,       // EENV3
+			     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;       // EENV4
+		clocks = <&scmi_clk IMX94_CLK_XSPI1>;
+		clock-names = "xspi";
+		status = "disabled";
+	};
 };
 
 &clk_ext1 {
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 39b616e266e..9b678079480 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -108,6 +108,12 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
@@ -128,6 +134,9 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_XSPI=y
 CONFIG_USB=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.43.0

