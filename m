Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C4AD2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE580840C1;
	Tue, 27 Jan 2026 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wEkx2A2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA1383FC5; Tue, 27 Jan 2026 09:18:12 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE7683F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1iEl8hhD8PcXMHh76R5xMgZA/MiYD11m4nCd1L+EhPJn8wKU8o6kPUmHrs8I0gKMptTPEDrVIM3ULZ3imdSf9/fEvLDczUPpslYxvl03hWDT7E6lj64H4MWUHzF+ACa+rQ63EJWP1lsIv3Dvn+m3RkNb6jGQxQ1k9iqb7MEP/Iod9Dg2nZAar6O7ZvTKJbCr+WwWmd+7ryo2CelaiWdex76lcM/Melrk64gpXKE6te4dUKHaso6H7gCvoFiIJzIGuRso7K6a+9ws9yvG082r5NW7mP8zY5yMy+cEJfFAvanksSeJWL4XBLAo/W9JeX4/IEN7zdurnJjpnS4rlItzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O4ZPWrj03xblMrYieGU9F/ERABU6+jsTl2hp06B5dA=;
 b=EYevgdF9Y8kMRgMAvPw8LTp+k/tIM8yHEDTU1lcgz8yK2iBdSwhNDPB7oY5z4nzAYjrhQhwMEDcI/Z2OFElCSGTC3d+ih2HPz5gCTqG4bWkIm00C3Gm+s6mvvo8//SkDYWEQgJRtScVHhfA2PJN2IrqzrSDb9Ip8E5qNWibUXlrR5fsso43O8mOW87wr3JhPCn1Sf/F2GPXzkaJ3YxUKcaw1RARWAYeGL116iz9in6S+/Edfpz6pYGHE+J8UoAsNL4cGOkAMX7zshhYGKG0kG/6uVH/J8bCcoDvC0dIsKaiml6bPv9iQP7HDi57UnFVIXVva1yZDPXoSHQ7z+K3XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O4ZPWrj03xblMrYieGU9F/ERABU6+jsTl2hp06B5dA=;
 b=wEkx2A2DR6vxgzU8gkq6QejJPiRTfL5+cwcZIfQU4rleAnYD/N+fMyQvGxgs03L0JWgBL7zWNq4lZcygdy/1VOPajKc9blNs2g5GKLg4c8lQhd4FZp0niVpWwuSBvh4TU6QJNqJF+w1pBjUETZPpFlw9x6tXphW6qdG+fbnJd5g=
Received: from BLAPR03CA0077.namprd03.prod.outlook.com (2603:10b6:208:329::22)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:18:08 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::2e) by BLAPR03CA0077.outlook.office365.com
 (2603:10b6:208:329::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 08:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:18:06 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:46 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:45 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HidE185638;
 Tue, 27 Jan 2026 02:17:45 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 10/10] arm: dts: k3-am642-phycore-binman: Configure
 firewall for ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:52 +0530
Message-ID: <20260127081652.506357-11-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 910cdfa1-5259-48b0-b0f9-08de5d7c99a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W8zpmB2cBYtkC391/OV78F7ebvpkGGGpVqMt3mp11WW1N1dir/POd624K1i5?=
 =?us-ascii?Q?fw39+JNa/cBzdsg0VhVI6MZWgzTX6EzjSywYwPWWs0amoFovOl0IAazJfyYm?=
 =?us-ascii?Q?YG90SYrMXFDJ3vxAabgbX4aXWbkSESkN09ZU1UNYwfJUUHIQ8iYzZFKnM/8p?=
 =?us-ascii?Q?jpU/6cmXQL/S4MytLGp1NESr0SC8+NK6ewYe9kTh71KXnT5OcvnEI2NC8Qu3?=
 =?us-ascii?Q?67uZMBqoXDY3sXyMctucr5NGI2Yd64Lep6DD7LXA/a4YtI1dYD5oKUw6KfIu?=
 =?us-ascii?Q?nITIumTtWEVzEynZ1spYNdNkkWfgQy72N/0JTGTEVNXG5AlRVCajugSYooLd?=
 =?us-ascii?Q?XSAeDCX9ZH804uDr5Tig9YM2edQYb9evqjCy80c5pd8SlFpfmnb5zx2yz8f4?=
 =?us-ascii?Q?6u6EpR2nZe2xz0GH9ofQ0/TP9XgVjhG/6AbIxhmaZvE0jW3uDf0oF/cuOgU/?=
 =?us-ascii?Q?nid8A8ZeFa7S1X5O4IFGrB7IhrD++fC2fKGWhpeiCSQTlTVMSs8Hag7Libnq?=
 =?us-ascii?Q?bGGjZYYMndhCQZorQWdVxc+FNvngLQRsXObxicdFEsDoHUIjp6iMONHSjOiV?=
 =?us-ascii?Q?THSf1umzlJPuiITEU1rPtPYpvEqn85hLmBL/zU28SiI000HRjV2C0TiBLYup?=
 =?us-ascii?Q?jld2Qabilv0h0nKxX0UnfAJVoXHItF8Fn1e3yxXiF7ii+2fDCneAR91MCVQc?=
 =?us-ascii?Q?cWuA5+1YI7ccHtJDo+roCJ/8emEqIqPFLDKTk7X0RDAmr7WvMoDIvfNku3GP?=
 =?us-ascii?Q?3oHLPIrn9iioPBtUDi0Gt63W3ph0piBK8LBiVqFAaPLTUxx9eR/lKAkvig3Z?=
 =?us-ascii?Q?qX4fR/V6J4TOBhGTiDkXvzzVHEuSAK+SflGSC66nQbqPIezFPF2S3u6ugyH5?=
 =?us-ascii?Q?z5ujoBADFGRzRq/PitTrp52pg+/QjKjUf66nWYKVRGQYigGaY+b3ECz9jEky?=
 =?us-ascii?Q?nnCv8t9+nSkM0bQrQv5TKI+jQX6njmLSmQoUJBTcdcxG2s8I0YzIDsSZaYVh?=
 =?us-ascii?Q?ml+rP+5siNu4F9XwJJkXsBVusVDjllnNAroxLBwf7vtwD45ay9dEE5BK/Nj1?=
 =?us-ascii?Q?yAthRDZjk3W1ftdaQXP1SaMAKZitWkqaiPzCDeVJWXPCDlCohHp721T3dL6m?=
 =?us-ascii?Q?yQuEopieMdg+Fzl4ldNgovj94D9kvWvXP3etk/iHdcVCGVOjK5ZYMxqyi9Wk?=
 =?us-ascii?Q?VXnjf4f1SzzIaNLbaMclJugQVVtx1INXJV1BTdFwBGGO+PQmMIM9+p0vKCbe?=
 =?us-ascii?Q?8FLjbIwl9G7vpuIAeStR9/Mi43TQ1aTOun5a9THkd+ND6+klSNOm1GduYs+3?=
 =?us-ascii?Q?D9h4rzW1Jk2VjVEDgGwoE/6zsjLhvzBwArcjyVcIGgLZQgJTx6UPwveQlVzW?=
 =?us-ascii?Q?I+c9GNQKsVWyddNIfWPHKZQwJdgPj0FCOWppdLwXcxLBvAnWomkUflqZ9g64?=
 =?us-ascii?Q?0eBLG7C9ofD+0+sdj7mXSxhN73eIf1SyOsjx2ZV8ZJXK4i+nUAsB2GdlRDMC?=
 =?us-ascii?Q?ZciVTfOCdkbUne+fABhEIWDE6yAFb7in2R+80lYnJgx3Dfb9idwYxhXZfZXb?=
 =?us-ascii?Q?YyFE7XdchQXV6lwaTFDj7oi+RNDJ8AWjvrPowmk/edsG4u0s9dta60FgRTTz?=
 =?us-ascii?Q?3DxyvN04gNf/UudX3RLLYqBQ2k/5PmOwNcaQhGdzHvqLc+jhPKaEH6lkOshK?=
 =?us-ascii?Q?gsWHng=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:18:06.6686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910cdfa1-5259-48b0-b0f9-08de5d7c99a0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
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
from non-secure read's and write's in Phycore AM64 SOM.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 966905bd64d..07cb79fd04a 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -141,6 +141,37 @@
 			#address-cells = <1>;
 
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-24-5 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <24>;
+							region = <5>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
 				dm {
 					blob-ext {
 						filename = "/dev/null";
-- 
2.34.1

