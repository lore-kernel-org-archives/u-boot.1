Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036E5C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938A78122F;
	Wed,  5 Mar 2025 05:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kn0jQ+M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194FA80BAA; Wed,  5 Mar 2025 05:58:54 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB13800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7SgFG5B3ZAnAm2xgFU1gVpwFUiln8M8j5CV/Uls5r1kPUaBiiA+0L43CDRhuJrrFbVdcZ7V6hIuDG6i3JZDWwmgIZfcATcQbh3TsKuP9yVzkPBEeIoH6FuFYtlg4cVSYOrQfopPSp9HlY4AMHtOEfqfMzig7YQMAzHWt7tY0dwJaFjf+IJOKP+kmMy1Riz3jqoHfL3iqKszo91Pokx30XzluF+YNrFn5czzwm33yjGALBHtNrxsg4kUBpy0gvJSiJm6iTaUd3iglSBxb5I/r7WgC2w2RcaB5wEuyXuEKIasExmcZmoNQ64GNqWSKxKG2Tt5pZTUZ1vZtfDp7Ouu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWYhbz2jM8gpe993pI6F1G1jedp58p3Jsf3LkLkQosM=;
 b=WpeALeX57wlV0RQTdYmUI1cvJs8ErkcFZ9selEujBepqGh5UnNrKzFK6wTuBLrAU2YeIw6T1cH/Qj7KFfgBP1ynPe/k2cf0SyMuqE4I1YgeMgyc9mcB51j4vQnNeed4NR9WAISr9ETKTWdiREmqKSQhBk5wafaITGVBuYtVwfptqJwCBuJZ+F8AJD+J6wO3lR1VA66d/jsu/c+h8dX4WJ0yUzpmul+gTuBeUYGs5ez3BztIvwD+cnHrNKC2FHvmWG+sfY2YoAG2T5aZkgSe0V61Z4UbYenExVbo9DtmM9L2H6Ta5VNcauH1nDoSh7SPkOpyJZ3IxAGb+kqp4PC9F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWYhbz2jM8gpe993pI6F1G1jedp58p3Jsf3LkLkQosM=;
 b=kn0jQ+M9Of+f98Z6Nfp2V0Oshn/4JJDBQsm8Fxm+RZjNgGofGsNg4FoRM8uo8wRY8iBn4G3RmMWu4+sua7lYHAZ17EvcgO4FcKoEH9fvdmYtyZ8EEvlzB+LbpYMte87btzg5l1CI9FSrmxpLn0+9GvT4Tro2HR7vKygK+aaHh3Z03p67CiV93GuFtNwt0AMWbEUFLWHzUaU/6QOrMOBt/T63PFqixucjOLQ1/387q2alIEu4o+NeSl7VDLyRUZkVbUgt8nPH+Yyb7VWSrVCPqFZrdbwlIZcyzJycX19G5qpDvms2nD7ziT2AdxWIzmo9RDd7MndqrjC9GAaUVBTtTA==
Received: from CWLP265CA0286.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::34)
 by DU0P195MB1498.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 04:58:48 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::61) by CWLP265CA0286.outlook.office365.com
 (2603:10a6:401:5c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 04:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:48 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 01/13] arm: dts: k3-am62a-phycore-som-binman: Provide capsule
 nodes
Date: Wed, 5 Mar 2025 05:58:26 +0100
Message-ID: <20250305045838.3614661-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DU0P195MB1498:EE_
X-MS-Office365-Filtering-Correlation-Id: 73aa7bde-bcc9-4e66-9560-08dd5ba26a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NmzmpIGt8g+9VycUT020wJ3FeqyMW9mhDP98u4ehOke4AC1HjmlbQKaVvdo0?=
 =?us-ascii?Q?hSYjFcLRcvglPCKMuAcZs/lq6v4C6K1dsqNvqYjqtBdUl11YCTYvvmQ8GFZh?=
 =?us-ascii?Q?0zf6DsotK9B0mTCIXpy32GM7lx9/dTEsjhm4ayVfuMnKPoNLdrCrs3kurBZ3?=
 =?us-ascii?Q?0GE88yP3bNd3iw6a3fFC7frBPohqdwRkAV0Q4UEM5TKJB1WQJ8zBcq+bQoMw?=
 =?us-ascii?Q?riTdAdvwq5KV4io8M0CMtNzkwWEd06CLq3VvYzJxh6DNnOZXLpMR1FccmbOO?=
 =?us-ascii?Q?OXDUaENXzGWGOM8Wq08sLSYwyyBh2OM318ikMVFkGZ+FFYd7SBYvYD+/Z8Bu?=
 =?us-ascii?Q?QMnxPo47+O2xfGtPrw61KnNCxDBFlhhbiVqDXewDnTkHunQRkxEhUVRId1Qq?=
 =?us-ascii?Q?+Eb0VY11Mrh8GC6CX5bVKDF3Q52VeYZmfADS+8+h4XbxRszCDfYRJaiMOZQP?=
 =?us-ascii?Q?u8TVF/Tr5LXxf4p9CMRywn0FM6m9oG1LbHlWaFsPCUJ+tu3VK//sO7qG4RUl?=
 =?us-ascii?Q?PsUXyj+0geI55KO+iLlSMpQIDniAG8YcW0fAy02HXSMjz9VSALpffxBn9cEO?=
 =?us-ascii?Q?StZobwVy5NOfuxrAeyK/1U0veZX3iHEBbzan0rXvklmSZT/TvJ3ulHpvDkhL?=
 =?us-ascii?Q?HF5inJAWTN81WJvofUz8iC+dJsF2cVSqqLEgEItrkqgn24iK+oAiOD2hjfgc?=
 =?us-ascii?Q?Riz/a1CZThfMEfjHUkpmmWK1f6Tk8Q3evS+zptPYfgSGs6CXIIutIA8WBURD?=
 =?us-ascii?Q?fYsSmIU4qaYIJkZwkyOSETJOlFMSj8aKYBJGFdIGcQ+b6YrSgZ9ycR6Qb9JI?=
 =?us-ascii?Q?sFgBtEXQo53AkZTiwMdyjWZXq0/JZ6EETKExbtX9bd08Mr8YJkmMy2za/SpF?=
 =?us-ascii?Q?u862lFlnrZawvY70Svvd0vcHNBNJ0c7xwg5S0zQ9bA3YurzOMlI330k6y705?=
 =?us-ascii?Q?DQrfI8/sDKcIkXkX7eV0glrbSgcPNw9QlxKRd1npX+Fw1P455iyA5GJYB8yR?=
 =?us-ascii?Q?XtIYeBgXt74veAPj2xue32EcbBw03khrehX0WxtGVkh45QXQrnxO9k5SshIb?=
 =?us-ascii?Q?oRzy1JoJyfdkjFDSlA0mt61QLWASETTDb+X+hSbDBZZO7saP2u5tj5N5FX0y?=
 =?us-ascii?Q?jyIAEwXWdvj2txGDaf6q84zy4Sc7l21OPKaOgofLkAuWOSXylLYodvz/alUc?=
 =?us-ascii?Q?J60Cg2Fc0X30J+2w1vBjUoyUrgNRifH+jFLiLOlkPsqvB6T16zn0FBFUk02O?=
 =?us-ascii?Q?q0QufxUaX2WuwpZDERl6GBUycX8aoKw/AkvewlpK5qVMfXF8OApW30XbVXtb?=
 =?us-ascii?Q?eERwG5Oaz/DpxV9KwZNQ7L2UVS+YH6gKlnNe2il8206fKsTHsX6FxnJ4V6oJ?=
 =?us-ascii?Q?cKLqy9G3RbV6VdALUL7RH/OJUIsJTBdytrCvKpI0OY1QBKapeVSSHyi1a1DY?=
 =?us-ascii?Q?8PV4SC+ZQilaSnoDKgxO7mBZPoCW3T4vt9x6BlKIMt8h6TAT6bQTU9vLMQy3?=
 =?us-ascii?Q?AP84wUm7H0SLjmI=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:48.6568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73aa7bde-bcc9-4e66-9560-08dd5ba26a8e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1498
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

Fill in phycore-am62ax capsule GUID properties of the base
binman capsule nodes.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 640361e0fd1..7a5b14da719 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -142,7 +142,21 @@
 		};
 	};
 };
-#endif
+
+#include "k3-binman-capsule-r5.dtsi"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am62a7-r5-phycore-som-2gb.dtb PHYCORE_AM62AX_TIBOOT3
+		 */
+		image-guid = "07CA7DD0-85FF-597E-A485-B2423D3AE6C1";
+	};
+};
+
+#endif /* CONFIG_TARGET_PHYCORE_AM62AX_R5 */
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62AX_A53
 
@@ -451,4 +465,29 @@
 		};
 	};
 };
-#endif
+
+#include "k3-binman-capsule.dtsi"
+
+&capsule_tispl {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am62a7-phyboard-lyra-rdk.dtb PHYCORE_AM62AX_SPL
+		 */
+		image-guid = "14F968A2-7C3A-50AD-9356-192F07AD2A9C";
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am62a7-phyboard-lyra-rdk.dtb PHYCORE_AM62AX_UBOOT
+		 */
+		image-guid = "1F1148C5-2785-5E7C-9C58-C5B1EC0DC80C";
+	};
+};
+
+#endif /* CONFIG_TARGET_PHYCORE_AM62AX_A53 */
-- 
2.34.1

