Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD2F436A8
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 14:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1229C842D2;
	Fri, 17 Apr 2026 16:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Z+qpYwVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C531184258; Fri, 17 Apr 2026 16:12:41 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98CC84286
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 16:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGi2jHuBzE75PsRrtpVwEwsEl1HjbmfQvqkFJJMfGOo0tPFx/OxZSuAhKd64fVhdEFx7Jq0vnhkZEf79qzumOELHjW70tkU/MxlCjLOFzlx7tTi9yIovkggXDt+FRMBPDzSuoDtBzvHJwbF96ZUpstjgwWIjlb0sRRw1c9zlI+mSnxcW8+L/wvaBv8a378Jp9cSvLUUofTsS7oDnW94b9mqE6Eh0j1+grP54lBcz4aJ6AG2U1McJdqfIHihPUC1UVa6CqufG/SOCgsPjzzbASYLv6v4IR86ZaXIxFJ4kDUDWLx8xHuv5GqohcOdF1Ywkgl8w3e8o//nLaM90ww3UTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udoKxmU4NmHpLh+l1/fuhORvrIuE+YYf3W7Ug0jCmIU=;
 b=lJ93nPw60Dc72kGy64OA7cJEXkP1Ct6B8LeQKcfqhiukWFzcPucDOZYBNYp2qMqH8x2N2fGgbPUwAB6M8J0vDC8if+GvM1rKKPYaDr87VTq0c8+tcJIDbIsLo4Pg/HnJ8WFt8FkgL6j23Y0ARRgFmwm7zd7ZLAJOSM09PWumjcmWKQJlIKAhSqzssNBCRwC1LTjX2IJVg0aQywSqQxG8L77RGqMromfOf/rJecwb1GGtO45oDDw9qPfw04+gxRm7CTCza4FPhgh9bDNwn2n52ZYvmOuHWN8KeTEtaKjlaab0lCZCewHgHPQPI7Dss/GxVCh+Tx+tmPpamrNUkz5unQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udoKxmU4NmHpLh+l1/fuhORvrIuE+YYf3W7Ug0jCmIU=;
 b=Z+qpYwVseKc/K+bJWOpEFuwFH4v0T7oxF/EIxZgnJqLjDOJTQ1trBMffDeYauwJhp8HFrtXj+1hKoI4B9zf1VNEEKmTkV7sOMzpRszBRFwbukA69kZZ4l7EswlTSpgwBRiriBkBBhwGPig+h/3zdkwo7cNNTZFdwhSnZ17z573JEKcl9Rq4jNZStfmoEsxQH4OyxthxpjxO4JCqT/eIpcwaSqntrVItRP6upxRqHgnPEBiZHiqXXNYqRBJWusHvY3hN9KH1q9iOpTL+EIz+AK87WFiAxSJOsDH8+lVr8v5auYEepKv7SWvMsKzWa2FLFFsQsoxx+Xd4oKhun14xPMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GVXPR04MB12128.eurprd04.prod.outlook.com (2603:10a6:150:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:12:38 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:12:38 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com,
	peng.fan@oss.nxp.com,
	u-boot@lists.denx.de
Cc: ye.li@oss.nxp.com,
	uboot-imx@nxp.com
Subject: [PATCH 2/4] arm: dts: fsl-ls1088a: Set dpmac nodes default to disabled
Date: Fri, 17 Apr 2026 22:14:37 +0800
Message-Id: <20260417141437.1490591-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260417141437.1490591-1-ye.li@nxp.com>
References: <20260417141437.1490591-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::13) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GVXPR04MB12128:EE_
X-MS-Office365-Filtering-Correlation-Id: ec303910-16e6-43ac-5ad5-08de9c8b6175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|42112799006|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: oZIUsOvDiCulQmzmD+jl9g2JxAaK1c99fDDsQwtRspv3u1BFmiuB/R4JJYyq0aXAJyyUNrtHhki8R3CYs4flOUt3r8jz8wpUofLoj2WaDWOBeIDD3sBfMm52wIQ2DlzWZeJSbutJc0726f1ThW/YP/2Y9pbRUM69womUOk8YKGcpxZZIRolV/Vzg/ZQY7+QO16bqGJzYqzv19OTodBXxnUU6MQk/5idzKKWcagiliHd1hHIfFXbeJILVZ3PFHONHtz0/37z9IMcmY9HIXW1xMntVqFEeEYcz/tXlj8ZnnGduzs1iV+qv4maVUxYPfU9Iwb+tDJ6tSwKXnyRDch8gMKkJUANJrq1k/M4tE0w5RUTBgGKogHWvskwc6gWhtvX2v3Xe6vTjntyb4dZetbjE2yLGsFQYQDYz/boWFYwHVMHzTBsAt2xM/sLFnimyOUHY7QiwfFGmuouuOVkls9mkLcX4JBCkzTd2tWrtSej9UkAFUtO0wy4h7Rgt6OX5f2m1cY47DUKI5MA1Fb12AXnrCVWSFS49cVisXGJKEMErR+c1qLTbzNEE2P5IReHXXcIZqxnZmVNVvys+GHeHHsT9DZO8u3Mp2bUXJjMzRgE2gLiDM7f0x2dldADt3aWP7ax8pAu/4f0CWstS1nAUpshfg3Uf5u6UeqYX24pUlzOGvDtJixxQXGnrpPqadRNxKPHbygde007PIayos2smNrBhDXbqEXFioTJwN2MVt8e+Iyae/pt9uMN8LvIABFeqrtnPsTq3z4bw8LyEOF89R83+tq3qQL7fEKmYE74LUXE9m3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(42112799006)(22082099003)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyghmUrC5xnyBV/Ei9u15wsh+1ak8M2tOHR5Zx3Z1/JcLn2N1YGnVZGWGFo2?=
 =?us-ascii?Q?HtjHQz9I5Uh4KMota9HbKneRPeyFQu8dXmEkzwsyFEl7MwaONnbg3vszwOwy?=
 =?us-ascii?Q?dafAVvIcLY3ykQgNoySobvgnUFrZ3mgKttVKI90z/VIJrsHZ2orHpIrlKisy?=
 =?us-ascii?Q?BdMVVYalPaYLB/Ev+VA31tR695Ad0u5miugmxxLYdM7nCXWHekKdr202IbKq?=
 =?us-ascii?Q?nQMlXrtMx78YdZ9VMbUaC1D+c0/FxhdQZS6iucA7hzYFhMBWQZi/ihviuV6y?=
 =?us-ascii?Q?RA4B0BKLI5Ywlct8+0eOA+pmDMdmPWUD7II6ZdtUGTNJly1bqP4TDKi3/89d?=
 =?us-ascii?Q?8swFMyV0mgxeORMP6OlwaIWo8K5us+15UNISH9J7Yo9nha7VIibWkPlkI7GZ?=
 =?us-ascii?Q?v9Im2kwsWr3vBnnJDzhpBOz6NhEISnZV1bFp56aWwlSnB/qgLBh0t0ma5UqA?=
 =?us-ascii?Q?EMeREhJ7D+DEFcfQo784vq7PbkGYNsS56iJTis326Br2Fd+E1jW/72Tdetjx?=
 =?us-ascii?Q?jyRHiUz7HHcQJ/nNt645CfmLv+QrjwtqPKMMrawD0+ROU+maSWvqSP/gz982?=
 =?us-ascii?Q?TOoiyJZJSWB1dWLeiQ3GRKeFeSgV5lFIlJ2S3eYeuE68w7Q9WRWDug8eavcL?=
 =?us-ascii?Q?1Q8/tMQieECELQ8WxCXm6v0AOLMlgf2ZACPchh6ZI4N8aVU+gGJ/UTTj2q1n?=
 =?us-ascii?Q?CKumUTZOrUU760QSJznWaGjWFxYoW0WIYNS5Yf6D9/c9Q8imbVn8wRYOSESX?=
 =?us-ascii?Q?OOUPZKT5lx7yB2l1tX60bAQnv/4EdJnk3UGZo23uSGdIAGWMTWQIVOqc/l8A?=
 =?us-ascii?Q?D4SvPYoYzz8gpngEIduLGPDUwlI/Oj5IGQLg3rz4M2vgi4ODyCKDTT8xjMhJ?=
 =?us-ascii?Q?r4DeDd7vbVAEF3izFA23xl+Dr2ioN+qkmXmLtcdF58kTD8Vi0NSFr+PDB6ji?=
 =?us-ascii?Q?g5mEPvXLj+pdpH3ZO0FYyF7afaOyssuoo7yJWT9r6RkvMjEx2z7ExuBiYBYM?=
 =?us-ascii?Q?uOiJPih6lX+d8Lv7NnedCO10FWV1Fx/UlgbAGb2WQy3ljbHTwde0w/JSfymx?=
 =?us-ascii?Q?oNyTgzQ01ZS7wfD1VRuiceDWrNV2VhNwd3ra+LygvpykVOuKULSEID8g4gmX?=
 =?us-ascii?Q?beu7eRzqV4O/trbNhCDxxPGR5LshMoyW+JToDBjZUxe7iy+DZ3vTZdtO9ywG?=
 =?us-ascii?Q?vfROezmfqwra45EOj40v45JoZOXBcFYNsPpMNNy1+GdwTNklyh5/QpFnBf45?=
 =?us-ascii?Q?kz5WBAGx8fFW0WphdDgCrBU3WxZBQipmvOsMPBvmLXnP2C7aG4S2lAEQ1ERh?=
 =?us-ascii?Q?rRzuIOcF0pCjNkdy7F7+AuRDQdCcufnmwWtk7jkNXBV1TJJkcwcpzMitfW6H?=
 =?us-ascii?Q?ufYX5yllENH46GRP3MTjzILpu0cJd3xMa30oh3fLjWLoULQ4zoFrDbn/S34P?=
 =?us-ascii?Q?7dLes8JdXZDHeWwf76atQl98yM/AwtdrC1JCBRfzAuKslxFKyxb1/ZYQNhXL?=
 =?us-ascii?Q?0IPii+I6PMMwmHtApGfXGiixLdFkNIiP6JTwkDac3Ew6GS1SKjKYrcVHeGp6?=
 =?us-ascii?Q?V61IzH/mhLSQKb6NZj02VmZoER9cGiZsHr6bmt/bZbIB9HBO/rTG1I0BxgyU?=
 =?us-ascii?Q?xenWOyykIZq6HQhWr5z329hL2Oxg0ogrjDNUd2g+pljPTa8IcKlpwH2jCvS4?=
 =?us-ascii?Q?7ZFjBwGo8bhZGOAe5ZWVghTaWypWMmKeT/Yg16tVRVZVg3/D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec303910-16e6-43ac-5ad5-08de9c8b6175
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:12:38.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdxXWKM7JOw2eGDenhREjUW66m/MM0dDZ0ImbsNLvZDnQCxh5wDYULQ8A7vItEkz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12128
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

Disable ethernet controller dpmac nodes in fsl-ls1088a.dtsi. Board
dts is responsible to enable them. Otherwise will meet failure from
ldpaa_eth driver on LS1088AQDS board, because only few dpmac
controllers can be enabled on this board.

Signed-off-by: Ye Li <ye.li@nxp.com>
Tested-by: Wei Lu <w.lu@nxp.com>
---
 arch/arm/dts/fsl-ls1088a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/fsl-ls1088a.dtsi b/arch/arm/dts/fsl-ls1088a.dtsi
index e5fb137ac02..9a62f148d8e 100644
--- a/arch/arm/dts/fsl-ls1088a.dtsi
+++ b/arch/arm/dts/fsl-ls1088a.dtsi
@@ -978,51 +978,61 @@
 				dpmac1: ethernet@1 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <1>;
+					status = "disabled";
 				};
 
 				dpmac2: ethernet@2 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <2>;
+					status = "disabled";
 				};
 
 				dpmac3: ethernet@3 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <3>;
+					status = "disabled";
 				};
 
 				dpmac4: ethernet@4 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <4>;
+					status = "disabled";
 				};
 
 				dpmac5: ethernet@5 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <5>;
+					status = "disabled";
 				};
 
 				dpmac6: ethernet@6 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <6>;
+					status = "disabled";
 				};
 
 				dpmac7: ethernet@7 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <7>;
+					status = "disabled";
 				};
 
 				dpmac8: ethernet@8 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <8>;
+					status = "disabled";
 				};
 
 				dpmac9: ethernet@9 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <9>;
+					status = "disabled";
 				};
 
 				dpmac10: ethernet@a {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xa>;
+					status = "disabled";
 				};
 			};
 		};
-- 
2.37.1

