Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFC8C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 08:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A76588073;
	Fri,  8 Mar 2024 09:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vkF+L1zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5258807B; Fri,  8 Mar 2024 09:41:33 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ACEC88072
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 09:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDtK4Flfyf7nQec3gVy2nykmwDOO4vFnghQ3MzGuHdCFNmXnIAftHjm4z0rztyMYnul9neO5zvhMizdjYPWVnoE16ODbrxtdtTa0ew23Pxwy3t3i9hy/xZ4UxfgAx5Yq1K4PTR9u8N6yQ0Gu+hM2ojv52vpEXu1xd5Mn8bgnkhI7x+XqApJkWmsqSrCl1jsJ0zhEd+vIKdV4fLPyBwxHYE1Um7QgO2Su/VcO4KnpnGH5Xq/yYDjr8jwirgsnn977LirSqZjrwvRlO6SlsaB6JVE43nQi0iwWxGUGVRbQnv8eUXSRDNKfQbsIEQtBkrJYX3cUToIgS0BRlW/YBTlEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsiS42OagvnH0G6VbeIetVDr7HXl2j+aWHIoS//5FQk=;
 b=QQcK05RNghAK9I6MrUISCAs7UC2a/lQtqB6g83KgRJXJHYSbWXPUqq1YBoB3DyjwXxeiLrQT4GEPiSGKescDU1QbyBOKoshUHctvxPL9QPRGWMrsuEleOJj+H1cO+bmFSYv3aVzz2SxiLzweqIKV121sT5QKunoMnOolDmOBGEvScPXWqzKgfp+coHAK+4+G0R69gAkBXQqeBKq90pSIFpDykM1ifznNwaxgzRFMeKb/jFrOjYrYSoOtRjub6XMHbdjFvN+58ONiKN3EMXpeqgWcZ2aU6sWLwCCMbCy+07YWEBHDVdftL931AIoQsE2ZOOkp1JLhuxG0V//vgQBAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsiS42OagvnH0G6VbeIetVDr7HXl2j+aWHIoS//5FQk=;
 b=vkF+L1zOdtOBYDHREuDIHQDzbYkZZLxcu+jcOZI+iqNPSdY9LkJf9vrwylvbtFnVW81HF7M6apbWTQNHJ6lycaxpdwjXE0tXQAlZD2kbgB4ls86Bnr5N6kYWdHVkwHDtxLTg5BMu/Bw6YAlPs/W/alK2TMbmPa+iSypTRX9sNhM=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:41:27 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::2b) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 08:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:41:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 02:41:26 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Remove additional compatible string for sc-revB
Date: Fri, 8 Mar 2024 09:41:23 +0100
Message-ID: <54e77ad480c5de8703cb5b22408dc3bf72f3f431.1709887280.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=43RlARVJcQnehoeZLJSstijwUzPciLd9Eu0RvFgSBp0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRX5w3vxj56MrH0CMeOWSlplm86/174F6+8jNW2YEvay
 UUTz8lJdsSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJrD3NsKD9/GZlFkbO6apF
 1z5FbJtzLinZayPD/MSpu3gM1hrvyp60e8elzLDY55/3NwIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f131b1d8-f276-4358-52de-08dc3f4b8b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li+4vQWItHCz/6UUdjqhLcJ6cNAXC9TO0kyqkiniLX5gMS8Z99ErfvFzgQpku64BfKuY8yDKXRjjpCGQWa69b7Ix0LY67KNvowEf1H+qZza+WIBAuUckxTv8T51CsA7S89GFu5wJlDtppOJbbwXbxs8CkWwiDFrxcUNeNEyh9Ww+IodzkpZJKHCxHUiURrpeVQ9eBIcxnzuO40+T/D19/MCEZ89j4KKj1IkdGpEYAxG6dxREo+04a/YyHiYu7GYuyq2O7ZeRRFHNAa7HDJ0Sh6hHf2zLX3v6KkxYWiopvXmKmxAW3m/8xcM/5XrAn7gF702ls3XySCxspVFO3b1Ow7xI945+RYugOcQid6YlyNkoRzBmC6+2RqKjB0KA39UBwh6KH0utPLaDLkwgGo/3W0uAdL0Pd9YFx4aOh4mxfck4aptL8LnYTAN5j2gmDG9VSbZ5Rt6ihznlK5S9xFclznVBTcHWBfF222gkXwaSYjy/nc8qyQEZ0IJt0D46EsG6zI65Vs7ABhlPVfUlEk1EKYcq1roX2B4kTaEZIL0WtLvDsTfH4q0sCR/7kgTpP8rC2CVz7CNIBh5NJnS7XHQf2F+URQveOswkrJC2ndaKGTbUrvLKPWPl8Yxf3IUiuS0OetzNkQAkcw11+1YcSumuncv8J+QK8iFjFwm+6HG0JqxRNL7mhSH8pOy+z365SEe4UVWhD6NViIBAi9gFjYRc/x6WoF2i7IRfuMvUwJr/6dPTt5X3Hn43kgxAx1NebtOS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:41:27.4445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f131b1d8-f276-4358-52de-08dc3f4b8b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
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

Based on dt schema there is no need to specify flash via additional
compatible string and generic are enough.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-revB.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index de2d7842ae28..c1d713b5d890 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -192,7 +192,7 @@
 	status = "okay";
 	/* QSPI should also have PINCTRL setup */
 	flash@0 {
-		compatible = "mt25qu512a", "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
+		compatible = "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0>;
-- 
2.36.1

