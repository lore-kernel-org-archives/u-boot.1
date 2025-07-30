Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1156DC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DB5803CC;
	Wed, 30 Jul 2025 17:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ICrCH8s1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A98B805D7; Wed, 30 Jul 2025 17:42:32 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A616A805D7
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+jPsUTzBoLnl2/+N7mXEqckSGmd99oxR51+C/6srfJc3nq3UoDHxZIuWp2lUqIZN3z6DFdHRw+YLHTO1AHAKLxzaaxLXKfLlr2G0ORoTLRsetS9qEefK/UVuea4N6IXANQYzXw0M8m2wHlI9nTaaBkmfBZLAKz8swHFn/VyW9YPhYcGtk4Hb4sUEhNfEAsfqYcq2/oRDFvVmgnbIfhZs4+HTETOnMuWONms+bi4VCoyEo+NJ3zzZeb5kriYzdsjZFpesYVYedAjkE9oX4vZCLVILvjuaNwZrVvW+WJRac2CtOd00dErXjLBEYDIW2qghFsRGcQaaGkFQetqsj748w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIGMs9d+lGyMYSyA2qL91uaTlTF2DdiUUniVx0jK4N8=;
 b=sW7WXEMDqwvzoyDQJATlRfGpnxvYqZ0dkShEvQYqXSWkMzHRwuOpHxESZQKVzOs60SZ0qrhaWhVLI0UyCyYpLxibKrrICCg5fGvUe0cMlYfYuHGbDf7E86UwBNal7utF3H4KMsRgHKml5GQIlb+JIiD7ViJ6VkS/LSvkQr3y4E1KASgVHz4NCL/fsdOdQbQfVHana4VBAb95Edyn9uvmCenh0xs9gvcKiiVjo5KptHpbJ30pFIxlQHE4UJ9o9vKVpY15sYYea8roLo4V/+iMMjPuZC0CYNi5sbK4qiycj6eW8P27kHeEToHmpNbwLCZB7uStakjeAgTHB6oEn55p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIGMs9d+lGyMYSyA2qL91uaTlTF2DdiUUniVx0jK4N8=;
 b=ICrCH8s1wx1ayOEm1DThdUqN9LVf0jDHOvzPaKDNZwSorR+knSF5gY0g8Dwu1sG+2x6rap8IK9gA1gCZ4ig6rYzsKpzQvEUb2bZ7V/ZKoFix0oDhjCH9LJE8Dr+fFFtkTLETvNiHf9u7kWPk5ZRdpN8plKWW8kiJN/W6p55+TdK9eZyN3Nl220NLzJkpOaLRT+mtC665nwFU3rcA1d2zO5LeSKOrepIBiFm4IyMruC3756pQ4Csor//+vV8S6LBpRY4Yxb89onLX0bk4Gdy+Q3lIsQyXJHYDDS5k3tarvbDw1F2s7AG+GKYG60UqJ9l3sNlBzzGIkUnUqTdec8+aNg==
Received: from DU2P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::20)
 by AS8P195MB1207.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 15:42:26 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::1e) by DU2P250CA0015.outlook.office365.com
 (2603:10a6:10:231::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 15:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:42:26 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <ggiordano@phytec.com>, <bb@ti.com>, <d.schultz@phytec.de>,
 <nmorrisson@phytec.com>, <joe.hershberger@ni.com>
Subject: [PATCH 3/7] arch: arm: dts: k3-am642-phyboard-electra: Disable unused
 watchdogs in U-Boot
Date: Wed, 30 Jul 2025 17:42:13 +0200
Message-ID: <20250730154217.1116751-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730154217.1116751-1-w.egorov@phytec.de>
References: <20250730154217.1116751-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AS8P195MB1207:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c80b54-95ac-4952-ae26-08ddcf7faf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iK7NRx9+EkN/zzJXbknovmVDg9W2gfkv2ix4GR+5uRonT0/CQ5KTdYxYte6G?=
 =?us-ascii?Q?hXJhzvvEyvQFKHWHqqJ4sNEEnDfY/e1l3WhnK8BqRVeGb7JToZ8QYINpJfQK?=
 =?us-ascii?Q?mWkPP4gWPNHSRvDPPnSyje0SZdliwh0PMS7HO6TVFyPs9fpdPBnlzYaNxLP2?=
 =?us-ascii?Q?wjHGPklkbVpEWUHoJe23C3j7IRIhj6pyjECX0/2ZpN3WVXoMUjjjLK+qRTXB?=
 =?us-ascii?Q?9hh4Ylf2FJ/uDHHsuAzAeqCHfXuGU2YJhBwxKrlvuNypoQzTe8EbGX4rfGBq?=
 =?us-ascii?Q?PdWxn+9dzAN9hm7wmylQclRFpR2dc67sx2KdGkaRjo52kHsmAFpd7LwwKbA8?=
 =?us-ascii?Q?xb7hM8q8R+cWrNSy4I7G2DwiSNFqUMUyu/pgHxveMTIegH5RT9YJjDN8T1Yz?=
 =?us-ascii?Q?K6g5r7DuDAmhTC9uERJSkjZ17Fz8fVFS/WZCiayKEHC60Ssy01plIVLK2cbj?=
 =?us-ascii?Q?suw77Lc+nDbybWQMz4E+A1nkjKMe1LBa21+W6b3NH2WctaPCt6P1o9EpPqlj?=
 =?us-ascii?Q?au2iMM8pVeOUThoJYZzATrAQwoSulTnlZsCwg7o5O58WbpaEMVjJEglYa/M6?=
 =?us-ascii?Q?KZJctxUJqPrr4qWzEyE0XjRwVF4SeYv68Zyyqe7wijdKNABm3BYEpngfoMtD?=
 =?us-ascii?Q?wTojneBHseXo3/ED5WI9wcTR7Vu4REDmcG492EoMdnjGn3wxRzMKB8Z1RD2t?=
 =?us-ascii?Q?M1ryePGRyqjtlxJULHScvDBtxECIN2O4xsdsnPR5kH/4Dr85fVlG14FmmaX7?=
 =?us-ascii?Q?2p39ubDcLa5Bf1RLp1lqXnRGg7ShRRn/zLGMn7xK/f9Qxo/P3Lk9Kz+BnazD?=
 =?us-ascii?Q?3BQku/xVrPOBcYGyQCQzj+g40ltCWeCPEmuO1M2mOiD34J/VUgLjLs0Jt9G3?=
 =?us-ascii?Q?bBJezk0be6A6v7ulMUTGFS6ArdkrLvlmi//RVczIV5ms+8BOXW8446yNJGNC?=
 =?us-ascii?Q?qOduLM4wKk5TueXg+JelsUH5X4HsFE+VxWkmFZ8oFTcYFwRrKF/O89hb33NX?=
 =?us-ascii?Q?uJGvDrTGMh0uSuVOdZ8vBpUFd/4w6j/hiTgXWdys2BlkfDy1avHWuhfSIN3Z?=
 =?us-ascii?Q?1tG19MAyZ4dpjm/JSmcXrwyOTdVfohC8l9neEIOMhlaNMFqe5Ttp+LeZbonp?=
 =?us-ascii?Q?0x8oZyQkrsWVzurqrGsyA4Nh1etfhMNXB36e/o33VyGhf9n7BkqT/9UjPra8?=
 =?us-ascii?Q?jjGBUgJhIyWfpLaOAya1eHH3/5dCDZ9W+kC0vMV62O80sQiztNOPeh1402r/?=
 =?us-ascii?Q?SghsnlYdFABdsCB2jCxv0G5Ht9XXPrYgrAKn8WoOBQf4DOfMDyRI5RWuSWgr?=
 =?us-ascii?Q?Vd6o+l52HmJ10VJ/tt4j/USs9FMieAPLFODIr0RjN243kDA3W6yrd2Cd8vs4?=
 =?us-ascii?Q?Y1blSpWWMFwJ0B/EGr4b1Zz7AmBj+TYe9JETnnMHrUbue0b/fvCasTRo4WiW?=
 =?us-ascii?Q?xJPMfcQPDfVQYliGYPmnTw/n33xagr/bynduTHtnYIajDVECY3N0SeSDPBvs?=
 =?us-ascii?Q?SL6svW7zXMPmGxa+QDLSZwPk3OeioYzmgrjQ?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:26.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c80b54-95ac-4952-ae26-08ddcf7faf67
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1207
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

The watchdog driver probes all available watchdog devices.
This causes SMP boot errors when bringing up secondary CPUs.
In our setup, only a single watchdog is needed to monitor the
boot process until userspace or the OS takes over. Disable all
unnecessary watchdog devices in U-Boot to avoid conflicts
during CPU bring-up.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
index c68a48678a2..56547cbd28a 100644
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
@@ -156,6 +156,10 @@
 	bootph-all;
 };
 
+&main_rti1 {
+	status = "disabled";
+};
+
 &sdhci0 {
 	bootph-all;
 };
-- 
2.48.1

