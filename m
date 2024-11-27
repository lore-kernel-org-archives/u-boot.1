Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC81D6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E607897E3;
	Wed, 27 Nov 2024 13:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="TUHjCupN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665E4897DD; Wed, 27 Nov 2024 13:18:02 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C18897D9
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIOMoMY1QTbaohFyI/5G79xlU8l/COBTTYlPuD9d0h0mEyc3HTuqxFpSgwaB4asEdsmf9IA9YMFRtODkQT3+qW5V23p4tbqutI0b95VA6kPS3NankKsZgQVTcrqRJK9M7sLT4tyAnoycfA3fOMK69hh3ESYu3+oF7WOG4oDexYaRN0xjVPMAoCI2Vst2mrkZTa+ZB8cfeYo07HdIpo0k6QTb7efwpLp9uv415dHP4MFkF/kihRzjsRRR3CnvbrybvsoMnS4+8QxAUaBkIFerYzAoKnMJi2m0il3hkaVKUIBgI52Vl/jPVlyeNnvG8fn9eZsjkpv7pu+6NiVCM8NOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T25DUTDAYHtmjPrryK53F/fP9rBEbFrTKTZIAcmrQ5A=;
 b=ITNjkvjeuZ6EItCOak959/2T6DdwAsunYv2l/RYCGpiwkqSBeFQfPXAO8dGJ0lYdfkormxXz2WqExbBi58IxUnq1Dnu/ic1Tx16QJodwodwFHfTQDxmidNsCY4EutO0YMSD7X0tlgV2I+VJ8mxtzNZSAYYVESc2GEYl6CqxztuTF11PGGr1eY2IalUvNhluhgllzUHsUu3mKjK2jVuvYraj+lVIKYRfSR9sdAZILBhTRb8RoP1atZTqhwSBd47J4H8EQo0jXi5DOZ7y8kI6KVGd4kUWnJ3aUeulgBlRJzC4xjLq3Ra+FjPs1iw+Luoy6ukmmlpy+gcsI3paFfW1UFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T25DUTDAYHtmjPrryK53F/fP9rBEbFrTKTZIAcmrQ5A=;
 b=TUHjCupNpvIsekO4GCqQVFNF3mZ2+Z9/impuRg4AfUfh0paG5PpmkUNwdFYxLQMIdLQtBS9kAKzPAAClNEul/xCTtJPsUPFdVuklOSMmTJcIrS+pN8N15hNeHyeQhly2nbVm2j+b1j9Df4QQdSqmy4pUTHhNGxI3MBvK3jaecDU=
Received: from DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) by DB9P195MB1513.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 12:17:55 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::8) by DUZPR01CA0342.outlook.office365.com
 (2603:10a6:10:4b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 12:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 12:17:55 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/4] arm: dts: k3-am642-phycore-som-binman: Provide capsule
 nodes
Date: Wed, 27 Nov 2024 13:17:34 +0100
Message-ID: <20241127121736.1525948-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127121736.1525948-1-w.egorov@phytec.de>
References: <20241127121736.1525948-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|DB9P195MB1513:EE_
X-MS-Office365-Filtering-Correlation-Id: 320673a0-d4ca-4881-d041-08dd0edd85d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sg9U3riSg/IAEFclzY/TVjU1Dn3q+evxfvK13yUJ3SkgTXIfr+GVUcdBmX9P?=
 =?us-ascii?Q?VkJpE/5BCyfXrdk1jKhowNAyQqv9Nk3K+1AkJ54IJdZhcnCei+x1SElPz4Hf?=
 =?us-ascii?Q?xDPcqT4ECccC6TPLLHhk66ZYKEIRtO+Cg9rFITw92bSXKRjwWw8FU1EHS6Cl?=
 =?us-ascii?Q?fzA2CWE3oGRChXCUHyc/LQXc/XN6m8mdQG7ajzfwT6g3XrGxg6Fv3DYsSKLD?=
 =?us-ascii?Q?u7hwKgdvRGrdPdyZ5fT+xjkl/fT7pwuwohNDksNr45zOf3rgrNPmnhzHl0ia?=
 =?us-ascii?Q?7mb6ebXhd6q5M9r/dRigOxP74jNmtkl+ClzYyB2u3UdfOKUbvHxVLNDiStXt?=
 =?us-ascii?Q?+ySD2E+ErM8hAxEVAnX/ztLTGpKdEeExVtYaVQwVLkjH6lfzWIpD8XdJJDyM?=
 =?us-ascii?Q?5zE3fGeGNWQ7W2pcgQhP3jfrIkWDNg9t93jE56rIAPJIWuYIcuOoTDYRTsiy?=
 =?us-ascii?Q?raq6txULrsaa/SEFIQuf1C+Tw73w8O8uvUdMmkT/Spqhm0lp5fUQhSox4UAX?=
 =?us-ascii?Q?vNvviKrTSGJ1gEG5i6drfxozJk0VpoEHmKmC3rVGQRn6zCLokxwodHYdYThE?=
 =?us-ascii?Q?qhh9vO5GryzcLL5cSCccz+/09e/Z8REJZ95yWp0He77Yaw5WJ4k9aQ3iHfAb?=
 =?us-ascii?Q?SzNWcSezp13dh95KXaXjVuwy6q4vF9Ha3WYdo4lnRiISCCOasy0pHbmr5N8T?=
 =?us-ascii?Q?x0S3cxoV2vJwoodi9EeuydmUbzDmtPah7DADrdcTl9iE4vnREfWhUzoIkPLQ?=
 =?us-ascii?Q?J+DUI8uZfEpwAJ1S8HQFJ3MgDCHbm7Z7LTK1apN35JkqFzPAZnILAlt76Ml3?=
 =?us-ascii?Q?Xpvu3++8h7sItt0PfW9ANDMKGyqMnHLomeley0e/c+dO7qPPIKKLUpSQtaWj?=
 =?us-ascii?Q?tY7mI9bag9KRcOQcZUh+Jf/sF0Csd2vuLzI2UZETmNH2Xhd5ijOVW4i/mwfL?=
 =?us-ascii?Q?A48g+CjOm5/bcT+bNDuPCJ5ELrnbIz6/ESqvJQhpAG+jTqD5xLVeGzIR4ixa?=
 =?us-ascii?Q?b+AF1000SyWzRuT2DAF2Kp2sQoyLgYCiQg5y0FiZ2TVFqY/vvnrRhs4HW0s3?=
 =?us-ascii?Q?Akn+OPzOrq0I4F2nzdat3pMkcjKpn3yzFbo3OJe01Fi8z8KF+M6jHI3YTEJh?=
 =?us-ascii?Q?9SNsSkyEIGYnYgFbEydmxoe0PDOZRtHMisutXoOXBYLWB0d0J98hVDlwhM6H?=
 =?us-ascii?Q?L5shFjIcazYnRMpWuy+E8QejFGS9oHKCwFmY/l2hJUZ0LMF0+x0hfoQnIefp?=
 =?us-ascii?Q?VlakONwTVWQBsF3tq3ScAUVPrBeNA1YhrBXgmm2wQbJZ821vBjzmFT3lF0S6?=
 =?us-ascii?Q?XlnQcftL1mKNDgtskpdO5KRtQYbjyjbKWCGggiOZJgRcbqDv5zwpcRklt7qM?=
 =?us-ascii?Q?9dk+w9m8aaC5ZerQvLdmkBv2JIWmeOxlBQUpY8BluvkWjRfGUZ0mQjZC/8x7?=
 =?us-ascii?Q?umlhDThjBnpFOfrqzr4CmBf+Y6apuF2l?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:17:55.1378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320673a0-d4ca-4881-d041-08dd0edd85d1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1513
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

Fill in phycore-am64x capsule GUID properties of the base
binman capsule nodes.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 88d6c40e95c..ffc4a02a03f 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -118,6 +118,19 @@
 	};
 };
 
+#include "k3-binman-capsule-r5.dtsi"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am642-r5-phycore-som-2gb.dtb PHYCORE_AM64X_TIBOOT3
+		 */
+		image-guid = "B0A6B4FA-5DF0-5CD1-90EC-B60BDE798486";
+	};
+};
+
 #endif
 
 #ifdef CONFIG_TARGET_PHYCORE_AM64X_A53
@@ -502,4 +515,29 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+&capsule_tispl {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am642-phyboard-electra-rdk.dtb PHYCORE_AM64X_SPL
+		 */
+		image-guid = "D0F34382-C2C4-509C-A1D4-BC1CB1B992A8";
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am642-phyboard-electra-rdk.dtb PHYCORE_AM64X_UBOOT
+		 */
+		image-guid = "0BB40539-DB41-5407-B4D4-EAD057FE10F4";
+	};
+};
+
 #endif /* CONFIG_TARGET_PHYCORE_AM64X_A53 */
-- 
2.34.1

