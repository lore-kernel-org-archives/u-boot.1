Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF57C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A164287876;
	Thu,  1 Feb 2024 13:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAKBn41U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFC68786B; Thu,  1 Feb 2024 13:38:56 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8FE877D7
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj9641EqoK46gLTRCE8ZBWUcFppzGrFwZ+axdCa2ijMboFgMdHL1zC3J9hSS6F+gkcrZ3lsodV3jm6pOm6t6hDYkjaN+h/W9vCEHxCuC8QydzDckSswXlCIUt3STIyvgciu1WOB5GyUERBJHCs/JP1JRAbVfrtKfZ8PJolWioNa0UI/FRPRhHw/MA7St8t0cB/6soQcKD5IVvmj1ROk9J9iMh8u2f0SugQb2UN8oVt/7As4roKMOO8kzWqYYdJY+XB2DXdOYANt9OTEQGWZdkpXYgGteeo8BF5US/GDJErgxsMKI6CiwyOnj5h0k2s54QDNnF/P9klV+vpG0siTHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1zGrra/GmS3X0NtjWzrXZXlTMNb0Gj1PYURA30v2eU=;
 b=g0NSxUSIpJL0xYxIU8fWTL/S8JpoKc8aq+TNkDFw1IQAq8A0Yl1aAEBoWobGr6riPxv7fWP8yVBptyGeRSTCd76sgtQ6+0QsoEmyOZk0rdfhCPedO5M9YIwOMnzPtHKCx4tz17w96CM/+OOHIQjryd4j4kiYpiHCzsot5OmQqegf+pDhTCkFGgtWUSJVydH0/ClW+zvunPBeX570XE+x2iH8Dx6stGMM5uL0mxaB7dfrgr9iICtzsE+myprE9FpeJfN8wYwVd2ewHGt3ZY32RAz+55XTyxEalGJoN/cFO0iORO7eXYgiNi1B+4NJjosr7lW0sR41rsKpuexg8NaMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1zGrra/GmS3X0NtjWzrXZXlTMNb0Gj1PYURA30v2eU=;
 b=VAKBn41UKTa+AgTL/YlHhA1lnX3FIV6BL7uBx793tEqVHqCO9Fh7tTGAT9RZfXJvplwkr6hBCT01WlYXvYATNe4xngpXdlySre1rxsPOj9oe3DGjX/o21YfIDULXMknkIiKGOyhD378jg5Rd2JsVax6qT2yiaaaJYsNfOnWrkkA=
Received: from SA9PR13CA0089.namprd13.prod.outlook.com (2603:10b6:806:23::34)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 12:38:49 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::f8) by SA9PR13CA0089.outlook.office365.com
 (2603:10b6:806:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 12:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 12:38:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 06:38:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Simon Glass
 <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>, Varalaxmi Bingi <varalaxmi.bingi@amd.com>
Subject: [PATCH 1/5] xilinx: Fix fpga region DT nodes name
Date: Thu, 1 Feb 2024 13:38:40 +0100
Message-ID: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4IGCq3t54wdhb2WGIH0TIOe6Oo2FTIHPjETh0kpp03s=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTdE86lTEiTudCdExoltYS3k+3tw/svjV4xSNb7WIhMz
 e3tC1TriGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABNZeY9hfvrEPtmw2xkr3s05
 z7LjYafR4nWLVjLMr1xg+Ub7uOvvRxqPV7/sYxB7FqiwBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d765a1c-8111-428a-860c-08dc2322bd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZKFT3EHB6hIJgWA0gt8EVDQbFeNERLJUGSNucZ9sNPVberz5Iu9AQoribYAzq/GHo1JuX2oUMK1FzUKx1f36Z+9F5QhNV/Ilo3t32B+s/31UWYU19Qqscl20nZkOtDeC8NmG5GH6Jz6FWSnm5UqVoX4gZ31H8XCYRZoWy5Ep0o+uYp6XKNkAjN4fL5tSoLr85cFeSqNPXr3NSlPckXNLB8aCAq8QFIWSaDmN1jNYNOS1IdVjOZnvGl1bCpURZot1t2wj1xLhLhyKxcTRmZhxjKtyutKVgK/64ZJXjqlv+mS+Of1kdotickq+yGrz8y77dTeTq46/2Y33SJBE3ItBtLx9+Qf32iUuiD0dKPcXLGxDv0ZEPKhC6caXTnsNxH57RjMHguuoGOCDtbRim+FWEnBF5WiUEaHk1v3DyjcZ9GXDB7cG5A2BPG3OtVSY2lUsVj31vJxG2XIwJEMPQAQo2qJOBseZ6B2G/pBpt4o+NgElQYvpR8txkQZ9tqYoK3gNTBvU9Y9WHOStqgdnInoxndl/dBBs3pxZi8ALkRiLJ9oXIU+4gd8SBVJwYHtbmuqBh/4R8om+P6mm4iKd+/5pyXeTSZQVAyEKUdN4Dn/Em8A+XQGH1fcrCY3hg9XfzPhyU78UfYy24p1TxsgnxUL+WH2Y3lXDbqozJqL6jgnZPrV/gMMbDTJXUoQJmDQoztCbzixUCnsxwMw3JhNtHHXN0O0htCK1KRr3uUoRV0dP2L6rB+CD+ZZuYYkyOcerHPb9YMyvesydElBIzAWk96+eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(41300700001)(83380400001)(426003)(86362001)(36756003)(356005)(36860700001)(4326008)(2616005)(26005)(336012)(47076005)(16526019)(2906002)(6666004)(70586007)(478600001)(966005)(316002)(110136005)(82740400003)(70206006)(5660300002)(8936002)(44832011)(54906003)(8676002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:38:49.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d765a1c-8111-428a-860c-08dc2322bd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

fpga-full is not aligned with the latest dt-schema. Generic name
fpga-region should be used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Aligned with fpga-region dt schema
https://lore.kernel.org/all/37b107d86b39ef4bc9c482b57b27de8b92c3fa43.1706530726.git.michal.simek@amd.com/

---
 arch/arm/dts/zynq-7000.dtsi | 2 +-
 arch/arm/dts/zynqmp.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynq-7000.dtsi b/arch/arm/dts/zynq-7000.dtsi
index f8c786ab0b7b..75dfd2f069da 100644
--- a/arch/arm/dts/zynq-7000.dtsi
+++ b/arch/arm/dts/zynq-7000.dtsi
@@ -44,7 +44,7 @@
 		};
 	};
 
-	fpga_full: fpga-full {
+	fpga_full: fpga-region {
 		compatible = "fpga-region";
 		fpga-mgr = <&devcfg>;
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 63238c08780d..ee2fbcaedc52 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -307,7 +307,7 @@
 		compatible = "arm,cortex-a53-edac";
 	};
 
-	fpga_full: fpga-full {
+	fpga_full: fpga-region {
 		compatible = "fpga-region";
 		fpga-mgr = <&zynqmp_pcap>;
 		#address-cells = <2>;
-- 
2.36.1

