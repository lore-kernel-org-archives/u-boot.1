Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11764FC5910
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 09:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BAF83C54;
	Thu, 26 Feb 2026 10:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aswVvlUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4040D83D1A; Thu, 26 Feb 2026 10:05:34 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD6283AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 10:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrHc/z1IRL1cOqi3PuEtFQWBvbNkiIXcMjhmTavSKK/IqgervUZhY8QvBy17nIlDLMms1c/olDSSJ3js123ppQ6aLIdr74X5ASomK0NDBA/U5StafirzC032+kt4G6f3AhuFKzPnRX8cxpCB0KrL2VI0CspirlPN0JX+pWUGjqAIlTIkfJf2ibd3OLcVWkv+d+G0osBbPESsSkL5qF3QFUBrJaglzYao5OrOGwjO/ZJBD9xTCqrhl2W8GjmjtKlhA1o9EjUxqLpYF3uFAuUrzXSuAGJclr7VM0py80ubm1Q8cDD6zKgy/JHcP0xJRWg16ittnlQFN/yVq/MiDEhJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vCuzo42JjgHPytxyZ+JMtYHct5VQ39bS4cfBB7l9mU=;
 b=rtdABt5nYZ0CDKR14LrAt2q9wgga8zUCBaJp9b3X4tSUeSdazLt+LELh6LH8WHvQSeps9edWzR2v9RHsnkD81p6h1HWuUrxDV7Lt9QCA1GenGnTfitvduihA2oUSH3TTXEQveymnf4EJ8qorMn2N1f3Prmwa6w2yT84RWv2VhS6PyJdYCMJX0P4KPn7safWI02JKPO7zxk9gUSQssLJ/S/RWk0ZO3bbWEYJ2xz7kW4CRw5YsDCuQkxQUcL8oYxWdDasoyePMHga0S6sWFxuHi4YQ6KmJpBfARULNTlya+3gP2AiZbWJJA1UwXmYB1cx+SBuE7oIJRK8wcAZr1HC++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vCuzo42JjgHPytxyZ+JMtYHct5VQ39bS4cfBB7l9mU=;
 b=aswVvlUCqhotzH4o7XcUyXsabll9xQaNLsIxE+rIf4zUdkkbE8i31kl/fPUWr4qKw6EKWpYlbxUdzGW82YPB90QbGU5MyyEyMmOeS4WGLiii3LfeOn/JMdtuiRVnwz+Ba2JmAfA1zOy4ffaAIII4SxflEaolL2t+2ot6E+Kf7w4=
Received: from BYAPR06CA0006.namprd06.prod.outlook.com (2603:10b6:a03:d4::19)
 by IA3PR10MB8684.namprd10.prod.outlook.com (2603:10b6:208:576::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 26 Feb
 2026 09:05:29 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::79) by BYAPR06CA0006.outlook.office365.com
 (2603:10b6:a03:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 09:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:05:27 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 03:05:27 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 03:05:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 03:05:27 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q95ObF2091095;
 Thu, 26 Feb 2026 03:05:25 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <anshuld@ti.com>, <u-kumar1@ti.com>
CC: <gehariprasath@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>
Subject: [PATCH] arm: dts: k3-j721s2*: Enable OSPI1 with 32-bit address
 mappings for R5 SPL
Date: Thu, 26 Feb 2026 14:35:24 +0530
Message-ID: <20260226090524.2733474-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA3PR10MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eeb83a-b329-46b5-3f06-08de75162f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: v9eo1GmvjHEsHi8Fr2jmXuptZ2oXrFQVwyZkNbYucqL32uOOZByGrxdEYl7gHM0YDxdXRLaTDR+ZX3G0obOB6A92lAzruaSup3Yu6UZnZ2lQ/byfkx0XLREEebaAhyE5E11v4CjRqQJZO3MNcgRALEFoXT3inuBVFZXeTmr4qybf045OZCv1y0KxhbmjOXfywCURJQl0f5qo5wUm3nFxQTZJZ5CC86dgwnaJpQDXszHHtMyxMz+XYLUkzP2W9FmUxEC/l01sAT/Nz120/7C31PmTqPSdasD1563jtxadWUu9SCJ50Roq9cEipapwSDEVpz3+Kim+DtEiWG7LnvDTUU+DowbIIUw9A6r68u2FMd/7NkYcZmSKPKwHuU96Iyqt7fitdnFPdiX0qsrQnQBvqqrt/SlBmECWLTr2k/2+xPQffPra+C4bGgan4OAQFkmkhho8NM6FKkKathXoFo1vCZEq+Qqro4hb0HW1AqQU62qrrkiS6Ghww2bLFgO4IC57AlEaUrZoQWobpghC+2WJDPzmHMMgWuoNoHNesU7Fe0PpZL3hIqBvsw6+o4gpX2fXfhzFOs7Cfu7X2TKE8aFzXsbAStNGxwQf38Lp9GqO7b7lLKNaxLDwqwIb0nD3tl8w2PEVZmrT8oZmZTXoi7LS6ctcKolkcZHfJaEbMIK4hYZeq5JWj7h4SB/JU9MGuBTgpi3F8UhvnFKdSE59LWNoTbR77ujxtel19zFK4ZSo/HMkNl6SvWzpfA4FOsPXUP5fU5Mo+BMf0PitEl6O5GNR1FlmVm3SL7Gs8qsde3AYvAUO2FAQxWYaF4KZLG05srGdu84qlYbm8JUodUSXjw1Ekw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ouF2UcF1oNc91/eWbyukSQvZaOxOITGdkQ1D5W9NrwSKhvsc81NetiCUKapwLOUp5/vuknd8jxRhwYiKqh2cR6Vmw0ELDTd2QDV1xdoSkKzTRUeHtyW9leUFOCCxhiBhbQhXdwhBCuvJT5lGv1YSL6p0L7sdMG86+cgpa51zEs64RGNIPHy7OAd3r4Nh/6HB9pU04giz5rDfhsaHb8d5xKIELyjFcNxavhHkVQ5Dm2rwwX+DIojogX3+0DvEzA+SkySSkT7Vn0seWL5pPAf2xZ61MU6W4XWMHf5ePIrveo5MyOsXxU9TkkqiD6XFb76SA2jMMLrjgNFJNqiaRraYpke+wfAZfDruQAJBWBd7CIaGcwQaelGGppReouWs2NWmbOavydb7LfKP3tapBkIjMfCF00CUP7lIZnLnwarMvOzHULxND/uzcw7KfICpFSzk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:05:27.9309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eeb83a-b329-46b5-3f06-08de75162f8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8684
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

The R5 SPL requires 32-bit address mappings for OSPI1(QSPI) access.
Override the OSPI1 node with appropriate 32-bit register ranges to
enable proper address translation on the 32-bit R5 core, while
preserving 64-bit mappings for A72 cores. While at it, remove the
disabled status override for ospi1 node to support booting from
qspi.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---

Hi
This patch seems to be missing from lore, but discussions happened
about it. Please follow this thread [1].

[1] https://lore.kernel.org/all/4234ba47-4009-46b7-9c7b-53966fe26de4@ti.com/

 arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi | 4 ----
 arch/arm/dts/k3-j721s2-r5.dtsi                       | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index 54eb9b4072c..8d51fea72b8 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -107,10 +107,6 @@
 	};
 };
 
-&ospi1 {
-	status = "disabled";
-};
-
 &usbss0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index c1c12e217d2..7d4a6dc5301 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -90,6 +90,11 @@
 			  <0x0 0x50000000 0x0 0x8000000>;
 };
 
+&ospi1 {
+	reg = <0x0 0x47050000 0x0 0x100>,
+	      <0x0 0x58000000 0x0 0x8000000>;
+};
+
 &fss {
 	/* fss node has 64 bit address regions mapped to it and since the ospi
 	 * nodes is being override, override the fss node ranges as well
-- 
2.34.1

