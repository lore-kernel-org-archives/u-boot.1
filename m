Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8372D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A7D8407B;
	Tue, 27 Jan 2026 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZbF2uwfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB6983FCD; Tue, 27 Jan 2026 09:17:43 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A390D83F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9ngkmI/sQHzSmQH9s7lP5AZQWEqkF+fPlXbDwQT3jg87hCfP/2pmGUe7LJP7P028fxOp5aM8VmrW8S/XMvVkF+DFyywX3VkD+GtnLB9XzZQHkhFzU0MQG8MXK9JEbeOcoPMMbWDOuqoepoygV2A74fdW70VV8H8Hl57CdoYDYWr4KefZzuyfS36wloB+KVazRMO19+cdW/GaOdAOLQc3LgOl580+f2ZrNEozSD+MRzrtzgtdY5hT5hhXFK/NuGDfzZvCdNqu71Q+gnlzWUvM51PmC8vh8hElaAN2bHlXBHVXD4xTjMFIjK/UCNNj8nsc7vUzhXt6mFpRML4kCjWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgF7KwOUGh4gzDwA99JvgDHlXIlhG2f9WLtb0b6gb3s=;
 b=T5c7llGvi5D+B+pGrbEv9cCvfuX/rgQfL7RGo3n3Qec30Bgh1mMGaKmfkFmBv66THuxIdF3Fy0XV4tbmaIBBf+3cPVYx2fDjT77JhewrUGROOIdlI06T+cQzSxAX2oCAkLF5jjYcUy51KBgllysEzpA1DqRM/winYH+HkvqFrPLNDEqYbkLEsXlRaDU1u/GgFFcitUqsQN/RvBtdKnWFhrHmaP7yjVwhNp3hGI8olXqcWi3ESjVT+Is4AbrcjbcSgjWn/ZK+rj1z+5c4Oo1YCd8QBkA/5pa2mr8u+GteOhxLbq1Sazem2NNSFWw6KEdm01lgUTdqNIPhpoOZawPuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgF7KwOUGh4gzDwA99JvgDHlXIlhG2f9WLtb0b6gb3s=;
 b=ZbF2uwfIF7dNKyF5jwzQMVwv5IP6VmJob7n6pxDMP6uc/zjzYcmKtM3ixPAm2vg2wwUiF5CumqqKCR1IRbrn2CMz0gCzzjWGhHhTFp07BIx+PMunKgHdkLTUL/CXUG4CvGWZ2nmcOoDHlWf+CKB2xcdo8XpGfl63SHLkqxRGC9w=
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by SA1PR10MB7737.namprd10.prod.outlook.com (2603:10b6:806:3a7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 08:17:37 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::18) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:37 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:36 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:36 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HZeW4030045;
 Tue, 27 Jan 2026 02:17:35 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 05/10] arm: dts: k3-am62p-binman: Configure firewall for
 ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:47 +0530
Message-ID: <20260127081652.506357-6-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA1PR10MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: c01fee38-943e-4750-a470-08de5d7c8815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nXexnu4h7xJNs7Kb9WymzICM5ZVeHhWcn1dT5ywoRtPMNdNFzf5wF6mu5ge?=
 =?us-ascii?Q?PPrDwpOiCPY2wdrk+y0iN4IcquhDxFGUDhx8Tk3PFy8cwfL520Y50L5dKf7U?=
 =?us-ascii?Q?ELwsWq8QhWl6CLhrz5OwYFJDD+kq8i/KRu8RgoEdKOqDwYuEWdOkegw9YT5V?=
 =?us-ascii?Q?Z+2M/h8JWB8HaeseIvbWvW2UefLbPZdj/s8sGm21QMT/5QNHvXUQTgkUnIiB?=
 =?us-ascii?Q?t4NicaTXlvwywgck6Cwku36JPOJpWnxBxKlHwSs5Gk2FUVOEAtgAjiuCAiGe?=
 =?us-ascii?Q?IjFbyQg72At5zQbkjMSrV4YNaJuBMGpc2YGkMDoO1aIG97cnWsek7vWB4LC/?=
 =?us-ascii?Q?mv+BuDg8eDJacEEMPF8lbniW0t8u3dT2YMp8pubZZ+uycLRoAY+cob88rDcq?=
 =?us-ascii?Q?LNjm9vBRA2RNLIxG+QcGIoDxtzgfJRm5UWPwz5rrXpN1KpFHHiDyVHITCsXB?=
 =?us-ascii?Q?Mg9jXKq/623SsMQjcIq4nvHJUroEfgrJyqH4bikgKecZQnR4BlIeqnGATpR3?=
 =?us-ascii?Q?7LdLlyl8gqt8lIWeV7EkDTxmi50eHT0Xs4t3AVqKOgDvCVdf0IkPVvVDPkAH?=
 =?us-ascii?Q?nFq+7KWyaMDIeXRnDud2ZvNMKm5QIluUjMnIL6mV75Rtzxz/OLUkr2idKAM+?=
 =?us-ascii?Q?89CfWk8m0L9jH6pSJrROpud6fyT1wCJcFyt0bTRaHwl/JQNWwfRn6LByGJBr?=
 =?us-ascii?Q?Y1DEC5i5IsDNfRy+g/TVSSHDUo4pwMfuJtAMLAq02KY/zUz6RFpR6Cvs4/q5?=
 =?us-ascii?Q?8Hc1f+HjmYPmQFjcOKmhin2ZPzXLkeWh/YXinwnYJKE/shqH/2fDN0C9aKlb?=
 =?us-ascii?Q?e33wCa1bdCiwnPUSONYoMP2FRLV9hZ4DmhzFEQt5teehNlhkJGP9W3NJe2Qi?=
 =?us-ascii?Q?TjuQiY9MAAGTfhVIj0Vgq17EjXpon87oApOuWlgGPt1HzLlNyma2pHoPu1HJ?=
 =?us-ascii?Q?Rdd6AgeMydtkIPD/fWn+ahTq+5Lemnc/guDYnyUJifjNfzDSo5HpIl5OL/3F?=
 =?us-ascii?Q?9VQi1W9vGXoUGVrGCKJOPNCJ6ytRut6qxGZtkWgRQfVOpmwRviOJtcSXZXvr?=
 =?us-ascii?Q?/is1pTQeGwehTty2HZNjxnVNtmzKaF2Z3dUEtkeTmAbvx5cl9yGZIEgUj/It?=
 =?us-ascii?Q?Igp8q5K7jdDKZQQ9Zu1PCdHwOSey4d/v7rO0AWp5Yq3i3uDZy2iGGyY7oqmd?=
 =?us-ascii?Q?EwETKJs9UMwE9hXhJXwtu920thYQi939FLa5WFGnS9FsRCZGmi4hEwYzXMHj?=
 =?us-ascii?Q?qMdZLtlTavxawuPVwD718o6A/SzY2/KQhRKAcVyUsRGh5N8v/xwqqnd3UPDL?=
 =?us-ascii?Q?8Fo3d8Ktbn6nFD/laveCcLyVtbILDGMLCyCbogJ1YxpACtDTFpFFF+Hufu19?=
 =?us-ascii?Q?fvwhbiNqucXmTLWR8vMAHqiX/c87+R+CNGqvapRE4SIpuqVNsfHYi61QKrkZ?=
 =?us-ascii?Q?leAn92g/HB9Ke0k0EUYo6AvoY1ZW081aQqZgEj7bD3mLqkiYuY1kh3ZpvdLE?=
 =?us-ascii?Q?4B94eTpbQZTV+1XbWq80r022OQzjEs4gEnpqzuSkuxy4D2m0Ng5cXneurxE2?=
 =?us-ascii?Q?Ez4Vgo0HXcoeW109PLv03uywjajbGjGQ+OyvrMBBRXywC1W/21BJWFbkGjES?=
 =?us-ascii?Q?4dZNjcX0FDj8SG8ZajeQ1v5g6KoAULJZdxuIK8c/OAVG9AuLSh3km8ddDBKf?=
 =?us-ascii?Q?wp/ZPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:37.2353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01fee38-943e-4750-a470-08de5d7c8815
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7737
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
from non-secure reads and writes in AM62P.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index e1443d6226b..603487341d2 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -217,6 +217,38 @@
 
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
+
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
+
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

