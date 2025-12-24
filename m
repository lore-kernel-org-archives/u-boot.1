Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57FE74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F04BF84236;
	Wed, 24 Dec 2025 09:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aKJWcXXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17DC8423D; Wed, 24 Dec 2025 09:25:04 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E6984212
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftgvAypmS+8iM4T2Jw/S/zbqU3aULjaARIr/mS8os4jlurVrRUqxbo0eZ9T8KkZh8enP5rpUUADA+7Msj7DbpcJNZXvxVwBGArHwo1g8N/uPu9To7OBroMOvAUAC02qkjX6wRe60rDlOq0JHofT82EHVdZO84R0RE1O+mlRNaN/Dm91t2T7oYSY3J4x5otcgJ8B99gqtJUKM4O5ZUtTJW9giDHWt/6tOINg1+qzhna7UZpUZze6+zax+1e0L2Vg+htwEVtb4ZIFMQ9qYa6ZL9ys1UhjgBg9lqRTmByYcAiOhp9W8xQQ2az2R2mKnZDPFrmR9WTvEn9o66vWnKWzRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzeD8Ux5AQ8Cde0RUw/omHMRuyA2HhnbRhWEmejVStQ=;
 b=M7VF6d4rUyDovW4+Iqpyj9CU2EI4iWm64VA3o9IWecqsAtjL3hpNt9mu6lbFN2UtrttTv822vRGg4pOfoXv7BfRe60xgaKIojm0Y9JPA+xMIqxBfROpppGo7EDqudxxLK7BJYtPvC2ysdXXW74tM7miFLCbSuvUn2LFzlO8HEK+w3kzcdDaRdkZ9vAFCpC2C6T+pe9toYt9ZkI8JayKoCsDstVuXK9FNOPY20tj77l+iBEk2fcmEa/iFA2mcwaVyf0Y0ENjablvRyA9cjHYK39UcP0Uh4ekdMIFDnPEZsMiixrCSoGQFCNOcfQk4M33qh6yWdXPYfMF66vTCOlM1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzeD8Ux5AQ8Cde0RUw/omHMRuyA2HhnbRhWEmejVStQ=;
 b=aKJWcXXKvkW7xp0w1wj3AYSuG2UnoBtYb8LR02vUq11n8oylBidL+7tLPF+9KhyOQzuKak5liKOi7gOPox/rCr6mxAKnnpHCptMBTjtttq1ms/2KZ8i1evi8xGbXiQdlrhqecUouAQspGV/+Tiz8ZjKOElNMfJj33uaZVTh7HkYj6ZXNokh9K2IOwjRwKkoh3AHfNVFVMqvOVf/2VjGidDq4PvQDgT02rzk/Hsp51tJW+I4tAUd9J18JjKc+bei1fiTZeQZ2ZkVT6wM/KBjTWe3TC/xHenbxCFXLLMyVQ/EVHGuz6ZUoZvUII4WshxPxPIRI4lC+xNnn/bpE65q7Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 12/19] airoha: add PCS node for AN7581
Date: Wed, 24 Dec 2025 11:24:02 +0300
Message-ID: <20251224082409.1347373-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 244c3904-6c7e-409a-fec2-08de42c5eb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+cTA0CjhknK7o4iUkiqDzivycAR1VlWFSBLvbsAZ2SAFcgxtWZtQrt8JkBGa?=
 =?us-ascii?Q?9gEIaL/tBruSZEuRoaq3K6BJr/LPWgtrbsdUhdyoENU/SH0Z8EXWMXffR3xd?=
 =?us-ascii?Q?ImJlDhwaYUcmsNG6upvszq4vbl/yEYf4FtLoxmDPuoZMvut80DZYvK3V7ysV?=
 =?us-ascii?Q?EUGxC/JniP+CFSMXbqc5u4Pl1+h8Z2weGij5tUWtoumeBsly5eRbXo6mM40C?=
 =?us-ascii?Q?IBvESK0o2xyVs4WVHkU1az40/V3DXbcw9kTGMOeCC4uBAEKppA8aTO7Rd4jl?=
 =?us-ascii?Q?na0JVnRb6NkPwpS0I1h1qCsgHXH2WwhUUkfp4w8tVbFVVoc8N/YokJDBmDMN?=
 =?us-ascii?Q?B7WmmwFsfodORo6HYYz09Vdm9v/AMw4+OqTniA6H+5sT9Aux08uFkzrnW5pq?=
 =?us-ascii?Q?S9hS6h6eq89MGNCJij5GgM1xL8VSIqzgcROagxyvGSKVyWZ2jIfh6zYADENH?=
 =?us-ascii?Q?4NtImFqGs+y4cHl88sGBtJrWAe7E8wxpJsznzuAl7XOPL+3nsXo92sGyA46x?=
 =?us-ascii?Q?0/Uj/uTRFsmbA6NHHUI7WoRib++UUkkXHUozuZpgPl9v7VL1mYt9HfTL9zJ2?=
 =?us-ascii?Q?BFCrLDlL3OQf4bjIGSSxwOaliH3AjSQuQWG8MThG3+cVrPbxCLA9snjdp+Wf?=
 =?us-ascii?Q?GXfYL6j7HzThgnqdZVT6ZcckWN/THTC/8FoU/7gU1cvsXQh2Ih0t5sCE+0Ub?=
 =?us-ascii?Q?NPmIVGxUVDqQ6YUq9qHzPvXbUBsSo5fDtkCZuiRLGJUQ91Efb+aV2ZgTEY8C?=
 =?us-ascii?Q?aRIi0JAsTYIAts2a68paXbx9pUzEe06LNRhJh84zx4MiYPbtzlFTSSx5pioO?=
 =?us-ascii?Q?qsdfnHEA7IJSkSyt1cq5HI3+cZLKNg5l4zFo3EWTnkOoJ9eMpTkz89mnVh4l?=
 =?us-ascii?Q?pkFem2qxOyDL+otRzAzJTAJCcqws1Y0TqwPs8YALOznPp2TRp+FpegTaDh4v?=
 =?us-ascii?Q?TXfOP3iO1yqlRcw/tg6xY8E2cJN/e1GjsaHV4+1h8hoUEFX2MwiQlIbKNiiy?=
 =?us-ascii?Q?nbvR/PV1Cxm7y5Cw+qbJ7dxUdZbNq2Qgk6YUPxvacdBExuzimeSKFXHKMPsy?=
 =?us-ascii?Q?FDKQhteVoBtCbVTP6zKdPAsR81VRMHlNxP7WgN+PQrzvrMdskysXEnYAdqat?=
 =?us-ascii?Q?D5Qe3kdnUc6RmEAeV36eB7OB130HC5cKZIB1cVbNMOHwbGbY1uH0UFglYi3x?=
 =?us-ascii?Q?+7HUC6IWImlKX8IKdPr5OVoFarFAgsnbSNiwEdmzymtglB7fV11qk4xdN1Sv?=
 =?us-ascii?Q?BGWBXuLVcKdQah0L7yUukzJCtk/Fl/GsHF70Q68A7fholVqGoP3achhnEEtv?=
 =?us-ascii?Q?3qUCStc5mnBc1RCCFGnjn7Y7lxaclE8DUKb9X2K8QTNUik9BKSMYpDrYGsIz?=
 =?us-ascii?Q?WtVbsMHVi47R9bgMcVBIZRVaNOfR2KYSxksqguoi81HBaio8LjttZAsHjgA4?=
 =?us-ascii?Q?zUCX1FIyUjrBrXzIs9cXU0ibDXFozUGIX1DF5Xk9sfn1fv0+Qo8bjX7IEX+b?=
 =?us-ascii?Q?kNbq2zTFtyksSMR1ZFbnNG6hRxBR4jSv0TSyeVL/ibCPITCoXYX2cSWI9Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JWm76NTKmJoH/1ryUZ9BUhRO1SuY++M100GEdCh2yolF6R6S1EYmVdYUtIT?=
 =?us-ascii?Q?cXy5Nn/LAmhj6JBIMgmpxNhC4vho/q7qGFTQa0zQSIrGpeIuDVlwFqvufr/T?=
 =?us-ascii?Q?Ipi/lAqbQUmVgE1Wd15JZQiHFTQgxlVDYDs3V/VlNNo1gvqyLGXKPQ+fhV3t?=
 =?us-ascii?Q?2bID5bOSGsKCCSBrT/RZQHP8ed45aducaQZwZu3kz0uAR7Rg5gkvjjljWnIs?=
 =?us-ascii?Q?NqQXJLBbJF2LYR6qp5UXwTOUmly6eCIfD4AeCM8UE/ovNtPIZQHc9tY1P4WX?=
 =?us-ascii?Q?HKKCp/OojbMwkmQKwkl3gHkjdGy6aqM+Ep0yL82S7vgbfHVTW35QiJN9EijF?=
 =?us-ascii?Q?VD2buajXHCVGkJE1mihnEX+SnVIixmm9psAYw8F17xAdJilpzAbimzcQP+iN?=
 =?us-ascii?Q?Ca0w9qZirLh2XLGw6JTaEIWz2nPyJvJwjOLtik0FYx325FrJ+ecOFQRIjqNu?=
 =?us-ascii?Q?dn73KkuOJNhevXCSdDgMFosn4lGVDhxGDJSVpEXJOzdwV7kiGnqdW6fRe37w?=
 =?us-ascii?Q?fpCEp1XeXG342oAnM9KarHB4r8kygg1i4cBCfAPzRxaRAEkUxdJVGi/WygUw?=
 =?us-ascii?Q?5O0Y75Mdr0GhQwjgcAk/0UxtROcwwXR/k6X9q0NvPY3s4a//GsmjjIrGeBfa?=
 =?us-ascii?Q?kGY+mpu77hkKz/55MQTb7ObUnXFiyZA+HImxloPqtzS9vvLmzN4yY6tKVpX6?=
 =?us-ascii?Q?pGzH8YcbhxxQcdZQUbZsijD1BJoZdK/nwFCK5MjXo19ogqP68eWn/b+50qdW?=
 =?us-ascii?Q?dRDLDZzeE7UWJPwN7H3Hr32yky078gxM0SEbGF2fkHgDC4+cz+ANx59ReKWQ?=
 =?us-ascii?Q?WyLfv+y/N5K6/YnCKfPE/XbymQM3hpJvbEkoGDrF2pEiVj20VKPvab4S76EK?=
 =?us-ascii?Q?VukUFAD0Hi4KQP3nyTq4U97KgYczLkUt9ChnQuet3WyGJir8WVJ/Eq9TEDmw?=
 =?us-ascii?Q?ODMXw9qPG6MXGKOoNO7fujb3J3JTmkAFxQSielR8WhE9G470OLSJjxr50nio?=
 =?us-ascii?Q?b3rc3JQh3M3KxTdjaEZInvYctVx5gUDOYsxP21TJbirEUUD3ZX/IgBVfHOqN?=
 =?us-ascii?Q?yk8QGQCzOh2Ke9FiI4C7ALufHcSYMNGSACs4OdSgYdnF0EqF+eINitD5hPZo?=
 =?us-ascii?Q?p+u4SMTYP7qVSd6SW2pHO8ztR1U4fzJVzneW6LGgOY/Y+jX8t6uWRHxFEFlG?=
 =?us-ascii?Q?3Btc/qMZCMlAxkG1a5In4bB/m4NUaZvmLORwKRBXeYFrD/hY26u3sRSL/hFW?=
 =?us-ascii?Q?lHdtsXVw+yUCBLWWNr4bPTlqguU/X7oIj+atRl3rb/9JA2MC92guZx4aJZLq?=
 =?us-ascii?Q?EkkT9qex2p6KMRyg1lTaxrhUJxXEQy+dtzGg48NLGaweT8GcP7jCeGnms1Is?=
 =?us-ascii?Q?Ntfc82ITfHlCFWK6bmTTiYnp5r8J+vuF9kY6JU7ad+NkaRd2gUGnBkO+GR1f?=
 =?us-ascii?Q?rVV2taF3Ne3wOTCdqpE41LjTztr9Y9J5iu6zEIDuunr0TSUoNTMdfMZSnbt6?=
 =?us-ascii?Q?cwEJvosdkezAoZRjHGGnkJfh0yXY98BDEfTlOXvIvLKt7ydzFgF2upqt96Bq?=
 =?us-ascii?Q?r8gViLU1hR5WjOUt0UmaIpCa69PuffREeXqn/52OkW/8ExjwWSv5f4ikOQcI?=
 =?us-ascii?Q?H3YPUkH+tc+5Ge34PyKqg1gmtomXsmPJisb3D86S/kEeNVPZrs6n8asv8NuK?=
 =?us-ascii?Q?NZiSqu6bLukQPkd9NFPz94sgHLn+UYjfJZ9zWa/dfQ1dk4NuE2eE2Mva1U2N?=
 =?us-ascii?Q?5FK3hkpmLCO2llp4wbzNoS7ABizvwG8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 244c3904-6c7e-409a-fec2-08de42c5eb8c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:56.3145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHT+SLZP/FZnKxUydEnpPnIX3QNB1xC/L7tNcYZyz5musc1bhrXQyAe3iqi1DLrgCh1r/IPbEVoDLRbCaQ0g144ZRdzxXXEXomJrOjBWKv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add PCS node for Airoha AN7581 SoC to enable support for Serdes Ethernet
and PON port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi     | 71 +++++++++++++++++++++++++++++
 arch/arm/dts/en7581-evb-u-boot.dtsi | 18 ++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index a9297ca6503..9ee0f808660 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -35,6 +35,48 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		pon_pcs: pcs@1fa08000 {
+			compatible = "airoha,an7581-pcs-pon";
+			reg = <0x0 0x1fa08000 0x0 0x1000>,
+			      <0x0 0x1fa80000 0x0 0x60>,
+			      <0x0 0x1fa80a00 0x0 0x164>,
+			      <0x0 0x1fa84000 0x0 0x450>,
+			      <0x0 0x1fa85900 0x0 0x338>,
+			      <0x0 0x1fa86000 0x0 0x300>,
+			      <0x0 0x1fa8a000 0x0 0x1000>,
+			      <0x0 0x1fa8b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XPON_MAC_RST>,
+				 <&scuclk EN7581_XPON_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
+		eth_pcs: pcs@1fa09000 {
+			compatible = "airoha,an7581-pcs-eth";
+			reg = <0x0 0x1fa09000 0x0 0x1000>,
+			      <0x0 0x1fa70000 0x0 0x60>,
+			      <0x0 0x1fa70a00 0x0 0x164>,
+			      <0x0 0x1fa74000 0x0 0x450>,
+			      <0x0 0x1fa75900 0x0 0x338>,
+			      <0x0 0x1fa76000 0x0 0x300>,
+			      <0x0 0x1fa7a000 0x0 0x1000>,
+			      <0x0 0x1fa7b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XSI_MAC_RST>,
+				 <&scuclk EN7581_XSI_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,en7581-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
@@ -52,6 +94,35 @@
 			reset-names = "fe", "pdma", "qdma",
 				      "hsi0-mac", "hsi1-mac", "hsi-mac",
 				      "xfp-mac";
+
+			gdm1: ethernet@1 {
+				compatible = "airoha,eth-mac";
+				reg = <1>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gdm2: ethernet@2 {
+				compatible = "airoha,eth-mac";
+				reg = <2>;
+				pcs = <&pon_pcs>;
+
+				status = "disabled";
+			};
+
+			gdm4: ethernet@4 {
+				compatible = "airoha,eth-mac";
+				reg = <4>;
+				pcs = <&eth_pcs>;
+
+				status = "disabled";
+			};
 		};
 
 		switch: switch@1fb58000 {
diff --git a/arch/arm/dts/en7581-evb-u-boot.dtsi b/arch/arm/dts/en7581-evb-u-boot.dtsi
index ebd3b8b4958..9a02122fbfa 100644
--- a/arch/arm/dts/en7581-evb-u-boot.dtsi
+++ b/arch/arm/dts/en7581-evb-u-boot.dtsi
@@ -9,3 +9,21 @@
 };
 
 #include "an7581-u-boot.dtsi"
+
+&gdm1 {
+	status = "okay";
+};
+
+&gdm2 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+};
+
+&gdm4 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
-- 
2.51.0

