Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134CBCA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E949835BF;
	Thu, 11 Sep 2025 14:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="IJZii9bf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457AD833D1; Thu, 11 Sep 2025 12:56:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9BC833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s89LrmDUWZvtaEvD8QwicMbFFyWGUU01cd28oLCJEij4XHyz2ZMVG1ALfvOS3/cG9vxZs5CioU6sX4S7erdaYt1Ts2prD0oXccoGh6Pz8AZ+auIKaYbijS5WW54CDuh8xByBkA5Up8Gedk7zub96DrWgEoswVTL1+hlr/2jXwds1mpRD+nvrL2PShjwFjCRktfaPUPNQV+ViQ+lLPJfk1fyLnoyMYF9ktuMJq+KYBtMc0gWp+wRjSD82KkndTUaa/RyCTG6tFTuXa8YiAF6+l2jgw/GxLxWC59iNzbKvtNXXZ9d/EQ9U1s788T94nHhNZIPx2/l6K7kPkgvwontcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNXiBKdlqPNj1RUxk4jCQUtDvUqmD+o68V2TgL20uw8=;
 b=oXRKlVS66puK/S8mZHa+mU9LXTwnzwqctsiwalH5LsCrXxuv2HUoII7lQ4KGw13kWg04nZeOcmi92Qb/xqspTBpZRqAH4DqRrHgAnhWyvdJnEmwNI0kTL7PggDoZMud143wJQRogtKopLHe4wr+aQtyyF5OMGjL3x5OHTXDjEZJ0psorFoaJAZcus3ayDeagDVM8u/75GAb0rTYLHmHvZ1Job0oNXJz7Cj8MpoFYhfcuKW9RfitmJhZW+IJWhIASi2hrKqo55z28dzz7/V05+mYazLj6swXy1wUJ0w7J5Kvo7G/IHydCvPW7oxmdNvbdGrsDZP7fijr0Qace1ctrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNXiBKdlqPNj1RUxk4jCQUtDvUqmD+o68V2TgL20uw8=;
 b=IJZii9bfjvsFzMIH4BYxKxCDAMe7CVzWdDv2UabJlt+pvIq+mOUha0c/6Od+wu+lbBpqt7z9duXXhUGCeYB4xjxkxWfElIJ8+VdicxI1zHZVMXFTf9D5FPKLGTTGskv8KJjW7GrD2fADLBi9QkwNWB5rgc55aEhZ579++fSq7SEI4riiysG5gewIe6REmPreVJeO/YcuH5xh5G2HUKwn5xX43iL/K0aUXFF/nloWc0uOzQRgOHvhJr0sVzsF1YpKXtSHRK1pqT+eOS94CaRiFKZoxr5CdrANVJzmRu/oiAJMFybpOWGa/y9t8L6QzBQiz9bovYbnyQNFVDQqBC6CMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:51 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:50 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 6/8] arm: dts: imx95: Assign HSIOPLL_VCO as HSIOPLL
 parent clock
Date: Thu, 11 Sep 2025 18:56:09 +0800
Message-Id: <20250911105611.3664965-7-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3e41e9-f878-46e6-152e-08ddf121e906
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W9pV1AKd3ELuiui7L4+RTFVnpR55YECpsk9JUmS3UwzeUjTWpv2KJ/H25aAS?=
 =?us-ascii?Q?jD6u5A9pm3gOjK7xnZg8CCnwwQTU+oNBv2AN6OzUhKvdHLpRLL8CDWsNiZyf?=
 =?us-ascii?Q?oi8sHLmsAViaZzQRqWCYR7D7Jl0OVpITr+/MVHjYBTVEeV/TARDL/FdoSZ2E?=
 =?us-ascii?Q?/ZErNsSFskWrKDR/44O6p9h6On+BBKT9FQ5C5mRft00B0PcxKAkFX8qoY+lJ?=
 =?us-ascii?Q?DRbX9AnDlO3gRgKc56zrrHJ2u+2kMew6OY74A6A7NF8wjkHMSNeO/8qdDk7P?=
 =?us-ascii?Q?vbi/G1UTZIWnopaSg+U8T2DoNlW8P8bbzjscbAciGkNk6fYpP+kzTYmMZxug?=
 =?us-ascii?Q?NQJSWmtApYKvnIyWmIhVEq/Gfi+jXW5aNdCBZGRakZsy0WdwE2UahplMKR4m?=
 =?us-ascii?Q?vwUpVPm7+IQnuTYLGEGRDi5IQZ4BX1vCh4Si3cXBPgfilMcuVv7EGOXYGe39?=
 =?us-ascii?Q?9iqVb2reQskykOtfulGRWOLDYRQ8TgM1v1pZc3ENmI1njViGL/Rh5Wuvtsk+?=
 =?us-ascii?Q?AWS6ofw8DJWxguq+J4eRP8M4u6XN+EbZoNCBk7jr0BmoOVRJUneyfyOlgCcM?=
 =?us-ascii?Q?+XlFwEqD8inw7YTG46uK2YWZG9/yeKePGnhbbpB8awMFiXaoXsFTOM7ruNWL?=
 =?us-ascii?Q?U23OJ5J1DWqlDAjI2IoLrObG5jhrJlCtydHedK05ikzHHUQ/awoEUTEe1Ne9?=
 =?us-ascii?Q?1QEDlJq+9i9Ny4NvQwYHPL8YNyUkGtXiPMv3fcDtA7Hr5jBWFheu33NGZnbl?=
 =?us-ascii?Q?rfvvrLlQ5Pj4xRpXFoM3bdf+CeM21fTtoUBkNu5woH8fG2wV30dsSaElj1e1?=
 =?us-ascii?Q?JzJ/1fRXK7qRPpL8Xw50joVyL2PIREjETImOVVWj0xNFuY3/yrfnRGlWW71H?=
 =?us-ascii?Q?NeL4FItdqj/l2pKoh+C5SYtFnYLagmKDtaImBFCS80FotXG5hZspPC4FbNxB?=
 =?us-ascii?Q?D4Cxx+eU98jHs2Wvg1/0/ca8uqt0BZEq3mM/9ky8hrF9zVTQB9u6YRaE093t?=
 =?us-ascii?Q?24Ze1Zi/u1vSTLJ/9Dd+T5efmsm7x8qjR/009PM8CKmkIyNObAQpYEjG3UM6?=
 =?us-ascii?Q?hqmblXutcfm+EEC89Ov1KtyttJwoU/QEowD+vKQtwh7KvKHCNcDs1VB2rWGY?=
 =?us-ascii?Q?eFtmqoHCIDeOzyfQpdaEPgh/4ORnmNuM/3bf2A425z9WsMx2iJgfP2ABiGtk?=
 =?us-ascii?Q?Y2t99mDxPNltqIs1us7QdY8SAdseELVw2DV41VVqH8pVLs+CvTZ5Zo3dndaE?=
 =?us-ascii?Q?TfmUk7oFHuyBokB087JETBZ3WMFX8B6+zZGCaezdnJ/N+T5C474FdyrzvN49?=
 =?us-ascii?Q?+fsH2I2Wj1WKFLizDdJC6Lz4Myw8mThAhUfcAtJOzpEvO92D9QNyukeTBLEm?=
 =?us-ascii?Q?cUnO1JWBU6LpPDw/fKVdJp9Ij9EBD3zVLWOHgxFRZD+XQ45jl0GHjenjucs/?=
 =?us-ascii?Q?IpdcCHsdBDXV8TB/Wlnd3wfB5kwLq3jjwOQpGvAIkg+v1nVehB+gpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXr1m3DJGhC9E411Bg5kE1tI5CZT1VETB8iASSeoOrcqVuJKSjtVRFBkHgHo?=
 =?us-ascii?Q?RC0MwUbvNfLZtCzAmQvkGq6BZB787+YKIGo4SRF90RQk24pjq7TxmzvMr8Aq?=
 =?us-ascii?Q?2flJtK035MONh333PRc7c7JVQmkwCovbqXSQpfVYr0yT1Zb4Yqda2Z2KlZwA?=
 =?us-ascii?Q?g9kAF8mDDzUJS8qP60J1uQ9laky0qHmc89eiavMAP9p6Mgoi4wlhNn/FWWUB?=
 =?us-ascii?Q?MD+EDaRI68cREVteI0cjkW4PRfOGtcgdioTItqrr6iDqxSVw/K3EfQmZq4Vn?=
 =?us-ascii?Q?/iSl6NFqP6ZUYYPf5vjLSfxhBbQvW1UasAu7vI2EDWQUIm4XXBltN7ejR2Ka?=
 =?us-ascii?Q?xHHlrkkF01lytqsKu9rBLFIfpwDloFEzefCq/PnsakztndawG5XBUN4nF+aY?=
 =?us-ascii?Q?5yWYJgOTCUbagPFCf16s9mB3fgwtNh2gWKQH6Fpy37d6aobiGrqn2B7rTWr3?=
 =?us-ascii?Q?wgMQCL9mx4uWnZAfaV5sQBboii+bNuRRkmJeT8y+0RA4aqD3vQaQQIV1qvxN?=
 =?us-ascii?Q?B1wBNn2/N6YHJspGJz6q9q5+rCp8ycfyPxPto7eIPmWWZ6YBYbzt8eCFEjej?=
 =?us-ascii?Q?kX9c9R29mvXl4GxSN9q7YEn4kpy4KpTQzXgTVjG+e8co4BBbrsU0lJfOyzzd?=
 =?us-ascii?Q?HqpeBiEZx0+TzFN99m6M1WLOf7ZsMYoneYzGZTlVPbQNLOGqCAFm0i/9KrTj?=
 =?us-ascii?Q?Uw5dPuh6SKQNdNQv2/x/ku621QVBKO6rS8KKSCY6PYSeuc0lsyYWoqMymoHB?=
 =?us-ascii?Q?C2E2uo4HWZP/NfgSPzSgZPoAtm//Jr1B4P1ScdmvAyrzKlEYy+FNnrMtH2SS?=
 =?us-ascii?Q?mHf17JTvEM8Q4TpKdhrqQLqERbzNhBdwGH7UlEuC1MLRJCzlF3cyBIbF1TE8?=
 =?us-ascii?Q?AScEwr+nqXco40EwBEyzvb4ABsRjYjaDzTChfsc1BaGNRmR0OL8KrcO/nJzT?=
 =?us-ascii?Q?AONDR53ABfUt7SJydau0LEMeWcI5oyL8uLce4LhjezGhfF652iUTUmUmXl+Z?=
 =?us-ascii?Q?LWm6SkGq134OTv0K3OX50tuLu2+V9QqvILEQqjnpEIWib1yEcGk4dFHgZhQu?=
 =?us-ascii?Q?do/XDTe1w6+ia9oQh44NbssDgD6GEpcxijfcfvAZZcV8/J0Ifv2N2UhzkAXW?=
 =?us-ascii?Q?0bOS1TMRTqt7bOaQQ7ETFwd/FJZ7AaZzBg0Ppu5KZuuKk69cwo751qNHxR7z?=
 =?us-ascii?Q?mwumZC9XJDJJHVhcIOcaJs/7MJYtMdYrMNkGaFAiLePIqshZm4IxMI1n3rN/?=
 =?us-ascii?Q?qSax2YCg21pBVgX1PVoJqpzn+g5l7I4ln+UBsmFwl6QgTrKBSAsCTaZRqJXv?=
 =?us-ascii?Q?NYOn4PdyH4kllCBCXGtpPkJ7J8keWH6RIknHUaAjMGaAQUlFyIOsCdzV6Nmy?=
 =?us-ascii?Q?3U5PLX5gjiaw3gHYIXCJHrI/aiVaQu0Biqy2bfpNoU9668+hzu2NgIS4AnQt?=
 =?us-ascii?Q?IL0gCib0LAOYOnZeCNATS6q6Hlce7wf2f/ChBrEQKpmx/nOPshUFh9zkHEEV?=
 =?us-ascii?Q?TEnNJDz/pb0Q/gaXDJ2XVPROQUvnYzRVlvF6z4ZyeiY1E0BKSUHFpWusEV+x?=
 =?us-ascii?Q?IS5LRnOEqw+4exEnPfTjGFdB8iEA/uxVOiO3Y/1W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3e41e9-f878-46e6-152e-08ddf121e906
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:50.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43zGw+hakmgEXl2wuUWctAd3FfD0SuMYzfxcWkPPmWwYDUGRWqkpnmihFUK7RzEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

We have to explicitly assign HSIOPLL_VCO as HSIOPLL parent. So when
enabling HSIOPLL, its parent HSIOPLL_VCO will be enabled firstly.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 9bf8f9834c9..27f8209b19c 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -170,6 +170,22 @@
 	bootph-all;
 };
 
+&pcie0 {
+	assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+	assigned-clock-parents = <0>, <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+};
+
+&pcie1 {
+	assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+	assigned-clock-parents = <0>, <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+};
+
 &{/soc} {
 	bootph-all;
 };
-- 
2.37.1

