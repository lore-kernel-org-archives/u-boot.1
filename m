Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE9CD2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461E2840A9;
	Tue, 27 Jan 2026 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GFqiyHY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1CE83FBC; Tue, 27 Jan 2026 09:17:53 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1718083FCD
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDApGRSoPxipTXKrjjEg6ITf5BHWlDYQnUFPrJbOE7wJG4xWfVEkbYbg7OI2p4gLLiyOl+ve5BEkp4QN3U1fm40DXQHZf27ODiQ7xdmwqqrQleIgLho454jXujY5bGyZsBWvNF5YeIiJdja+6qeIOE8Zy3/8DxEqQhjMsnh/E4UxQfOALEPG4tM6KaIZIC4jTIe+d4HwHh27wQzb2FNlDMVAnnwHXlpa+uBph1nnWszPSMRsRydFJBvviXsjsbxxQZnYReL+ZO3i35sZcIaA2y12yWgy42uedUST04n/vSpbCobBjU+X1Nn9CUDNg+RmG9TELrPnYyxtrCiWZOWWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtHixA9zuPO7yDp5pvQSQ3eSxZxNYE9BsAPqsC8Jo5M=;
 b=Mk30o+8RDf7GbxH/PcZHBKAWNDkUzoxgIp33DDOMhW6ygMWaCKHb8+LpVTDr3PkWb8X9DY65N90WiDGpR0l+FkyGlb+k/uCZwpNMzJ+ZGAbWuD7XWdEGULKwWcZPdsKU5J965KYUmGQ6py+TRzD+PBYSkTLfPbagx34U3enM7TThy7wuQ2QP7FsBmLvLOzlXv6APBtZoL30y0VK1aZFt85mDVZI625F+cAcbKr34DM5xC4tdW86MHFD+Z0aa0hTkj7qJl6db0u5QBN9mes0DxdI8xsFwWYPPLK6T+aQm1zNYbllEd3c+Hdx3toFmVwSrcl9WFS4lUa4Hkt4Z2oOreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtHixA9zuPO7yDp5pvQSQ3eSxZxNYE9BsAPqsC8Jo5M=;
 b=GFqiyHY0VioU7TnUUfogysCp7G0PIkh2hvZ25A7KdeGuT8nQwNUlIiUVcJDzaBmdNQDEcEH+tO8eWVMQaJgDxhbbEVXumz+PkGrC6Kcj2mlgbrcoJH36NOehKXdWVgL/KyLSxBTXBL7S/OxEyJAEjAy4I7kg5b1EprS1IgN9Sx0=
Received: from BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21)
 by PH5PR10MB997709.namprd10.prod.outlook.com (2603:10b6:510:39c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 08:17:49 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::d5) by BLAPR03CA0076.outlook.office365.com
 (2603:10b6:208:329::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 08:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:47 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:34 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:34 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HX034030025;
 Tue, 27 Jan 2026 02:17:34 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 04/10] arm: dts: k3-am625-verdin-binman: Configure Firewall
 for ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:46 +0530
Message-ID: <20260127081652.506357-5-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH5PR10MB997709:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b66cec4-9acf-4682-c984-08de5d7c8e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UNd1mBnfC2FrKfMBaA+dd2DMvLG8BazqWaCm0upPBFyv3aLT8r3hrWcmC4vW?=
 =?us-ascii?Q?rowVMld9YSW65bqDRZB7EMGv0dZ0OcZpFjO55qWlOHHRaVidjMgPRVGDTLdL?=
 =?us-ascii?Q?Xjmb1JxQobWf0j/rmtE1vvnl/ruWt0+lYPi4HXbmd7Rz7uUo+lYLt3s3CUZK?=
 =?us-ascii?Q?1M3BTcofDeQkCfjt50NUAFP6a1WZLt2jI8ldJVnNCH4PE2Wf5dZqZMJq33oo?=
 =?us-ascii?Q?Sn1vD4iYoTXd++dPPQ6M/fYUBYYml/ugVxvDVlqkqDUS3JwLRgKLzmGfuqPg?=
 =?us-ascii?Q?CyBfgO9U27Yi4yNWBFcLSlv8vEjVaSIYyx+moVmqf03Pmb1LK/1N5/57MuvH?=
 =?us-ascii?Q?noI9spASs32wMjYcjGe3sK3Sh94cuTkztUMf9EjnnKuv3DQLTA0+P0itpGBz?=
 =?us-ascii?Q?ucm4wYI8cCJvMnWP8gge/JyOSDciJUNCMqAuxc7AyX8e0g/kEIiNdIbow6sd?=
 =?us-ascii?Q?6TWFGbQsuLfv/bLew7kVaXiw2tN57xK8F6t/IqXQI7EDIQMCwjuO1ZTdpwW3?=
 =?us-ascii?Q?gGMbyMyaZWp+MkR326MdcgrwBplpD5Q6++D+aBQWweI+JHJk+OEmhBEcS/Yn?=
 =?us-ascii?Q?HQHorc+uDmengS2MtjCad7hpnMB8MRw9FsT+JIZ/YkzGUmHfFK9q+gDittIY?=
 =?us-ascii?Q?hBToPcTFAEKzLQToxuhluTiwnnJKzQn9qJV3nmS1HT0J19cHcRgDZpQoI4iB?=
 =?us-ascii?Q?AMVSNRdUkQ1ktGstbznse1LKCvPtYbckOAa6Xk8U2HEKAq3EsoGFdhmZDI3H?=
 =?us-ascii?Q?uL553De7Qr5R7pU1/TWxry4YEAw4e4LENM1MRVwYKWxnC+fl06cuO9O+ptko?=
 =?us-ascii?Q?ija12CDrljEE3fzyV0hfku1sAWoaV6bJok6Ey6wEhHurdk46c/TUjLQh/1ID?=
 =?us-ascii?Q?w55TkBVQ+i+CDrzQTjCHx7IMOqsdrEauwV79SV+mBMRXd/lxWAw8M7Zs3KLZ?=
 =?us-ascii?Q?nKlUdNfL78zWhbNlHpK9PcPaUfyGKX1qfYTZcADrF6eFL/Pr7A29i61TulW9?=
 =?us-ascii?Q?MtwwaEYWtF5vHL9tEjFN+Co2AENLDutEA0YaUTEo0nFx5Um3lHIheYoiX+18?=
 =?us-ascii?Q?n/ElkixuZaWAyCUzwRm7cV6zomdG2bzBTex5PSpgl3eyyBZUFxQkWoSLjPiV?=
 =?us-ascii?Q?nG7ygMnIC9i8TgrSDabzBeKh052iPTakggSVuGKieQW+ta6If/PWdajRg361?=
 =?us-ascii?Q?Fw0GRZk10EKd7DvMLL6/eevJ8cutqZWPj229haUitBxMTC9CkKffw3dmTm0p?=
 =?us-ascii?Q?0V1rPCYFKADZEHlhU1LeXQaXp9uQqHdJXqTSAeQcjn920i6d/DiR/D1k+NED?=
 =?us-ascii?Q?kdEqBOIkaZPGDZ9ejmueL8px6fbDwV+HcK6ag2k8AlX8g5O2I/4tqpFu68rT?=
 =?us-ascii?Q?ulgJW0XffFufqySOI6SACiBTSvFhMMNrqrdYlq6Ha2ION5hCgB9sC4N58tXR?=
 =?us-ascii?Q?2BrPkX8Qvo/iQ/mRTov7PqmoZbz2bveezLaj+pP2xAdycAvo1xk19BigL3du?=
 =?us-ascii?Q?G+7j02+Oz4B15aF7IvnoPfsE+j6aua4vajn6bZGh11nvcKKd7XHtM6P0AB9j?=
 =?us-ascii?Q?35D6JmGBmL1FIanDPfzXeg1P/xzYte4+TkPwicD9nJ2chx8MBgIdGNMwPw05?=
 =?us-ascii?Q?L83TUiixl3bSJxDSNGNTir0MtyWk+/J3hc2N5e9/TcE2SEMRR1d1DspLFOwJ?=
 =?us-ascii?Q?zlDrUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:47.3508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b66cec4-9acf-4682-c984-08de5d7c8e1b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997709
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure read's and write's in Verdin AM62 board.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 65fef6e4790..7b646629587 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -200,6 +200,36 @@
 		fit {
 
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

