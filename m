Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A146C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 08:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9031387BE0;
	Thu, 21 Mar 2024 09:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXD0jytW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35F887BE0; Thu, 21 Mar 2024 09:52:41 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8E786DEE
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 09:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/IlV/xZQGc+d+NXjmsA5KyU60jDxZaFnUv5+Ux7/OFNXuFjyQs5aN3o20Wz2MVWx96439M73PjTB3ZkVzWKU67fAqic/ncGptbdtU11q3Rnc4GbldJyJSFue91U42Oz3F9xlnZPS0rxpyvdDVeouCOsSAogpZrYN9dCnwLL451ExVja8kzsE755QTGIBqnANglimi5UaRsv00jaH/8wqs/MR5ghvhJawL5EuV+FQ8Zhg/D8l4xrQYMBcPlV7VNiHkTebZxpVT0g8mZ/lcroTElTxv9uumq4fmRe4snu+2FaOAAM93yncpAuPwMkxpxZp6TwnArDRHP+MBFu8vD/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQAPBPCjYzHjgELstiPRs0qvir6kIpvKWuykY3pZBWQ=;
 b=HAafRCpYk1k5qKxV0+pY2ogf13GFI7V/uGKJjr37VwKDWlRGDwVbL3suimXi72BwxUYPbsVeemKO5IVkcHvWtwKA9/OQhknii1e9p+OmNV0euOg/MQ8m/rIP9wTIZkCYdlFS0TjOPDE2fKuVfQEvBA8AAlPIszGms7QeqiMh+CT5siPFi8SLTfTMcQsyaLHTZgEG45g68PBPATrT/T3MEqgCHD5tVNM1FP9s8lbA5EE5JesLY0q+iwrFUvRvxibefMTn/46711f39o2ah0Yea/JsFUMB+24nRhlPrwLaGioaoMPgf5COm2Ajm7vF9p0Gf7LcyF2ye6KeuEthsRg6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQAPBPCjYzHjgELstiPRs0qvir6kIpvKWuykY3pZBWQ=;
 b=YXD0jytWHxK0mwrQ+uF4GKl7BjBlvLAOKo+1dTfV27UuV5aszZtmv091JkrXmaGgGUX7yfEdcbjqeo6//tQX6IdQbkgI87WialO5bCR49SxBxfQAWHx94xzLbVtXXocue/9saeu0G5f+VvQ6N0XKKFnMh0+ftsd3MLRKtO8AfcQ=
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Thu, 21 Mar 2024 08:52:32 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::90) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 21 Mar 2024 08:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 08:52:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 03:52:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 01:52:30 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 21 Mar 2024 03:52:29 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>,
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH] arm64: zynqmp: Disable Tri-state for SDIO
Date: Thu, 21 Mar 2024 14:22:20 +0530
Message-ID: <20240321085220.2920792-2-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
In-Reply-To: <20240321085220.2920792-1-tejas.arvind.bhumkar@amd.com>
References: <20240321085220.2920792-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6046e8e7-b7b6-4a1e-d8d4-08dc49843ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrjEGLaPFGx+NchZQ7vEYksuW2Nc1/asYv6oFc/FJxcJd7ZccnLFUuz5YDFxew6ndFfXslAzntC7CwmiFBE2s4P2/JRR6bGu/AX1WtUWEiSND4hQ+DUGM+/q5f6wjigsHCzF9xQhqqVzQfGSbTkhK8kNzQBYDt8tab9mD6CCjCQtNAH94wFRB5J+DUZy/YIp4J3Nl5b9xxh6/lh65T9KWd0WXlkRnBARydOgaMupC+gnHvQNsCUVGL0AWW1SEiiRGLsdxe/K1GR0aeRTpTXNu9NjW5J1Mxcfflg3Qj8gJi2n/9Hwmou/LNrmBIquzW/E3S3XjOMK7oxwlVrDAsQYf+WWUN3b20LOyPuokcuhedev6UMwaGiW/Nlck9o0WA0KVkXAIWwBctHKPuOJotWUzvkalOKTdYFtKYBmYF6v9EjTiTucN7DKy8OpYUTfGRtAMZrn/PMmQvYag4+gGb4SXAaGjyEY0H79UFi5vJ6wXt/goqPLz/9UjoP+yLNE84QoTKXHmPNAUwJeCX3HwTBP3cUIUdJlMG2mmpcaxm80Wl/HY5Z7xeUCWjLNHdzQV/qkuZp4/NMgGn7O4L8rsmlqtIA3dt2wesO2lV4UiRNk6ORG9EVb3/VtkzAG7nQcMrPoqHITgmvg2/p1kWrPE26urB3Dcy5nVGZsPXow2GnF1bdGANZf646bRWRu0Lcyr2HZa0LxPHw+WlvQ+HqQCOSndrzZskryTiXXzFQy10cEV/BxfM9wdlAQvAbDZTeAGbJZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:52:31.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6046e8e7-b7b6-4a1e-d8d4-08dc49843ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

Since the zynqmp pinctrl driver now includes support for the
tri-state registers, ensure that the pins needing output-enable
are correctly configured for SOMs.

Currently, there is an issue with the detection of the MMC for
the SOM kv260, resulting in the following error:
ZynqMP> mmc dev 1
Card did not respond to voltage select! : -110

To address this problem, configure the SDIO pins for output-enable
to enable MMC detection.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 6d0d5c487d..561b546e37 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -342,6 +342,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		conf-cd {
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index a4b4465d20..13876fb47d 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -329,6 +329,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		conf-cd {
-- 
2.37.6

