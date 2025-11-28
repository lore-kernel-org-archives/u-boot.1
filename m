Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FE5CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 06:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD9983B9B;
	Fri, 28 Nov 2025 07:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OTzuUiCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A448444D; Fri, 28 Nov 2025 07:44:15 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBAA84326
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpGA+U7+9rzQDKoUIc8HwXAVUPU+S87Q7PnW7xIyy9yQslBV7JPuCDZf5unWPxUlgprRumSTLS2jLpMIAjwVLwZuNfvzdMJRhMixUxtiPX/Rd5LlsND3vJ2X5p2VnJTZWD+PUzjF2iV78yiOk00+3PRJtiD2t3CNTc/uiVat5dPAuZAOmD2aXHzwGo88pUPIT0GUtcEhUO1EhpZuiFC5Qh+MNk2MOX/hJpJXrg6VlApgqysBUF6oEbpnKUuE1xQ1efyQIflsDCmLpCoieYEJFG4EBFDGB0xa+24ZNkdAERBAB1CIBv0konIEoUcBXt4mKnAVf+rDPjEVQxBRKserdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh8KXcIbQQ4ITZhtYQ72RLNJCFM8bqkbnphZBlkXQBE=;
 b=rLIdDbDEstK+l2E9gUl77KaVE5aRk/ewJsez0105KP7rdSVoxOmwaQzQ7s9hvqsXR3/m0wNqmmpC+RY6ZhAy7SKiVTxUeJUbNHhILP3NwBx9Ig0+iCsd85JyqIm07yctqjwG8fqKRpeuk1oELESOJHvIAlCzjFbBn/DI0tW3G0r436LBDIqQBpJlNXssm9L3E8hORqM8LxOF5eeO6pDw6kPlPhf+1mO32hY0dTBJ1gQNtxKhnNiBVtW2+t+PK06oqkSraEgCd+2/z3nJ8V7TPdBG1C292n18sffVdKvdCf2x8Q4Dgh8axuJVNWksly2mcq0PZNpWa5o1sDlUKq2/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh8KXcIbQQ4ITZhtYQ72RLNJCFM8bqkbnphZBlkXQBE=;
 b=OTzuUiCIm3zl51rts2rPl4RX320Jsiza8m6k3OKvguP2BCeHNHa5fR9dWFHmKLYKgYK5iKdfb8iygZzptNB9+Ns0fMjBahZwVCgV3jYNvMdbBux5S3FmMuETmUQZZbg/dTOW07YVjCTDdFWj836ii2Dg/fzxh2GydIMXJP8LoAw=
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 06:44:09 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::51) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Fri,
 28 Nov 2025 06:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Fri, 28 Nov 2025 06:44:08 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 00:44:01 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 00:44:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 00:44:01 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AS6hrRU4092368;
 Fri, 28 Nov 2025 00:43:59 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] arm: dts: am571x-idk: Reserve EMIF memory used by PPA
Date: Fri, 28 Nov 2025 12:13:53 +0530
Message-ID: <20251128064353.1295063-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128064353.1295063-1-b-padhi@ti.com>
References: <20251128064353.1295063-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 132639b9-09d4-49fb-c966-08de2e4987ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hRw/WOs94ipFJqObs8x5qcLd1x3C5uLGCagyJsqRoVJEJRVglxJHd2ekyVaZ?=
 =?us-ascii?Q?KqpANxKht1A2BpsrTrSRpqbUqYuAKTdknI+OfEVnLQPpRU8kqyBWWy0WiE9n?=
 =?us-ascii?Q?b8N/niaolM/Zd7QLxvZVy4Rvm/FigXkbeKEivWuWJRAr5GDYWJtP0od5zDuY?=
 =?us-ascii?Q?JhgMeIOSmzVQ5GIPOt3rAwSCE4L7Pfp7IkmZo3SOnwcccuOW2HRRnJBqnowB?=
 =?us-ascii?Q?SFYyQ1eGAZbULYM7g+NYKlaA9f25DzR882Fx4SJ5yrz4pawBJs9xlraBsvD7?=
 =?us-ascii?Q?qsGdKb/wAxLlXvVKoSyeJcXrGi0muUxGyNeD9HVYrVC7iVkM6Bs5BRvMqoPv?=
 =?us-ascii?Q?TKfW4r0z6Ty+Yh1GaXcyP/2gxojdnIoGsDJ6KmQmb9bF/rKgy+tHJD6I0DZ0?=
 =?us-ascii?Q?p8JwByustHb6L4KN3UO+TC/AuROwukB1/7u568aNwd8Z6nJ/WT8fqgek8c7E?=
 =?us-ascii?Q?WO9xIuUt9x5luvEY/FunCj30RMNN91BGn04ZXhDwB6LyS4mfcnEW0EbZINfL?=
 =?us-ascii?Q?M5xHfAieK1cZQxJARJXwRl3wKJxY1DE+do7mkwwdFYMW/0sN/M8B+EjlmHZj?=
 =?us-ascii?Q?sWCSssDzLpkrx9H5iZcZBN51sFXDiGKcukDg5XmOja+bvuBQndNwzw/fPHTn?=
 =?us-ascii?Q?SeuY36pksF4fa9BK1ZYKtyJ/XHeKoyVmx56sl7NDHwqPfcHJgDUNW4nsPMgl?=
 =?us-ascii?Q?fcUs/Wg0G4becBlZP0+HSA7EZHzC2MWIB8pKMmLO7dKKLNYg9Iu0Iq+IQzRR?=
 =?us-ascii?Q?7dDqsIwzTj82VEOtvsxSiuY87OUKQ3hx45hnjZEZ2uhRr4RcPKbh3pzu6tiv?=
 =?us-ascii?Q?Ce1A9zchtP96Le/0n2Iz9ktaFOgz115+OkrUHT3YJSYM0Tn11gvMv680xZuD?=
 =?us-ascii?Q?WwpFM/0a6+QFZQXrUAHPfJoEkNT74C1FaWdhXB2KJGrgs4blk/7rGjZFRNRp?=
 =?us-ascii?Q?WA1hicUGd2bKjMogCvZ2XzYVKpk4gVE2qsUFzgsmcMBoGRgD45XGcarflPX8?=
 =?us-ascii?Q?xsjQ/s/GMA4WbDXM+ZugaKuOda/hXoHgLudJztL1Hdpfbbli2KYJdwDoIZ3Y?=
 =?us-ascii?Q?ffjHEw18oLx6uOEWwT4nRA2Fo0d7Hx/rgpKdSpch9JV1cT2nhQDja3u3qhww?=
 =?us-ascii?Q?S29ElyHmorklbM5sooJypC5/1owkhzZOVAqFtQMVmIqZMgcX1Yal7cvEfarR?=
 =?us-ascii?Q?ueKMDTzFqIShLcyAIfFOq83kTPTHY1awgflLnT+SePLPJav/aa3akUpbQijX?=
 =?us-ascii?Q?nChRuZrlZr9uT8z+lVMVjb72D8K0bU7TZpDE3tvfLb2Pge8k4zkXYoS6Tovw?=
 =?us-ascii?Q?XseTJplCNDlNazmA4iclXl6AYHPeWR1XGAEKuiUTgTXBk9akde5NYbmSMuaM?=
 =?us-ascii?Q?ORn9QCCfTR/10vXCJioUsaQPDWWhEI0wvKosEN/EVJfN7yISvavMW7hNYegl?=
 =?us-ascii?Q?mV6N88K1nKPxa+8ZBmArs8grSEcfg3LvzbH7NCKsSXnvBY7TUTnMqcGE/M+/?=
 =?us-ascii?Q?ceSg5SpqZu5hQpLOjUJArAMqtu2CzsmdCbBbRyxC4AXORt0zKHmb3j02jV10?=
 =?us-ascii?Q?l9YXUckg14pny2kG8kA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 06:44:08.0100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132639b9-09d4-49fb-c966-08de2e4987ef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
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

The AM571x SoC has 1 GB DDR space. However on HS devices, the top
0x2500000 is used by PPA and is firewalled. We should reserve this
memory in device-tree so that U-Boot doesn't use that memory for
anything. Reserve the top 0x2600000 memory (aligned to 2MB as per page
size for ARM32) for the same.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/dts/am571x-idk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/am571x-idk.dts b/arch/arm/dts/am571x-idk.dts
index b3592b22a0c..0cbd8c8a685 100644
--- a/arch/arm/dts/am571x-idk.dts
+++ b/arch/arm/dts/am571x-idk.dts
@@ -20,6 +20,18 @@
 		reg = <0x0 0x80000000 0x0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ppa_firewall_memory_region: ppa-firewall-memory@bda00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xbda00000 0x00 0x2600000>;
+			no-map;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		cpu0-led {
-- 
2.34.1

