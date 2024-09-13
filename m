Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B530FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3053A88997;
	Fri, 13 Sep 2024 11:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LpY3FI9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6366F88936; Fri, 13 Sep 2024 11:29:03 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962F888861
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK/IXNe6fGZhY3P3WDmwsgeATJZ8i+Apyq5YIQ3JUmYAhTnbB2+LGxdbFMRz6jGV6iJZpsEyMMEEp9cnRL7K91bA+ET0hjwQSoH0MYKYrzD9pfKLhbc1i7B3nnLoRiZUL7Gc8iJJxbIowYKKkYI1iCg+W9gMeFKaXYfAe4H1Cd9QpirrsUsYnfU1D4n57SdLRoIeCNang9drpVFcvdWz5z0g5RAILPx56GdCaAak+9BV9G3Pnz8yvswFs5iSy/ACiK5Hsf9GiPHvxsKD8N5nrSHkTSZYyUbXfc6W5B/pBjOv6OqP5aO6OR2pXBpwksF6E8/XuAQZ/mGwKgOd/Iq41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CPBpGFfKVwNT7IN8nOlsH1BPcHXRDEnJP/X20TR/Uc=;
 b=WyES3LdKxeQZ03GiYdTyd1+P2HUwWiAHdBUj2XZNKE3mMI3b7hNcePf0CHTZUoya+PDmbWhkmTj4zca5tUXLbI7YT3aGe3uGjk+AYy/7+YrVLmPTwtjErw/t7Hh9khTEQbLlcLkJoSiHvfRdGO3YQ/mpqLq1DyqMNEoaz0hURIirqkovC/UMYybMgucsj0nl0LbafN2XR9+/F3xRcEP+SAwM4FMAQ2ojOubWIz+SyuDOFrl5zB3NDHmGyc9628tkDfZdgL7aChJfTDgtxJvWerKt0jbka/oSZRtzCOtd33cp/SrcVvMd3F04TpeaL6nakqibTK0fYDGA6u3/jMhWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CPBpGFfKVwNT7IN8nOlsH1BPcHXRDEnJP/X20TR/Uc=;
 b=LpY3FI9N/3xKkFfus+8HyoBYXooUhxjgZlxhw0M2pOQhGBt0EMTvpvBtgnqYumSe2L5CpQGuZdOdOSYn+s8tucasLhnr3AXJqXsZiIUQ/ODVlZAQw+5iWaOIHetG6j6JQP6PdQ+LRabirM5hk8enKkKCY/YfkHupT7aXqlu8pGs=
Received: from SN7PR18CA0004.namprd18.prod.outlook.com (2603:10b6:806:f3::13)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Fri, 13 Sep 2024 09:28:56 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::b5) by SN7PR18CA0004.outlook.office365.com
 (2603:10b6:806:f3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:28:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:28:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/10] arm64: zynqmp: Fix status property for m-a2197 boards
Date: Fri, 13 Sep 2024 11:28:42 +0200
Message-ID: <bbf62f5911fcb356d1467b3979b4ff3c485124ad.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7Ct9KTnMLpZfVmWw9ljhm9VYDrcwGjxKXekBsYLnqgo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrKflrx3aN7nJT4d3uipX6RMr62OvD3OxXSou9d76/
 +m1r4pzOmJYGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEnAIZ5hnynvt3eH+JxYM1
 fKsrRSutdTN3H2KY7vQ/uVd2r9wiKdZfOtIClWwieocB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bde559b-b24e-4c02-bbf5-08dcd3d67dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q04qhKOUuYRH2dhCtq8wpn89sW3RAHHI6vUo/PusIgsv0fForQKDUbf6V3/G?=
 =?us-ascii?Q?nsGUViPmbXfejTMzD5L5JHy1UiCoOFaGc0gBCBNEFy1OZVnQV1KncAymGDWU?=
 =?us-ascii?Q?vUPBaYKNaW/Kvpu1EehTS4+8HP1eDjQk9P3IPfixeLKWl+3Pr6lsOC63Zy5U?=
 =?us-ascii?Q?giRb5MRM1fXmNZka8gUHE/OgQ297V5LByOMnezp9kalrQ3q0QZMyhSgLUhb9?=
 =?us-ascii?Q?18ewCDVod2hgTtNNTGPOClhOuUOQdvTGtaZj1n5iqUSf9FoeN78Ywto06d3K?=
 =?us-ascii?Q?+njWrE3bo5ty6HSSmPIc5AaIXe2nMDR9yyNnGuzkO62XTS3JV4NUMZ6k+H28?=
 =?us-ascii?Q?ytIyqXdVhd22kalWmQCzyZ3HvDb4W47zLnnCKHIDJl27/WP0hSvtscAxyq4f?=
 =?us-ascii?Q?E86B269wm1Q7tboEBLrSMTaQ11GgUldG4dlOoUdNL58Ts/QUrI9BLtrUhPwd?=
 =?us-ascii?Q?O1BJqtj/Ctm4vsTTuyBhV+Wp3/jYWtzt3Tr11gKD5pLlzy3ovEB/B566sNC2?=
 =?us-ascii?Q?5D3chdp400B6hoJGjPJDQWKJBUhhKbqdNNbj3L/8vzbOQsXsbnQx2S1gBjQ5?=
 =?us-ascii?Q?zESl/RQ0Urj+TDngqk7LFOtkXFlZ1Aufozonf++rYPrDITivKkFYOkgSQO/n?=
 =?us-ascii?Q?v2RCB87aNWfMKVkPL4BRmO9PpBbUeaEM0RgIKAeK6Aj5PcyPNxJJsRBhGPo+?=
 =?us-ascii?Q?tBtqk2S/OE6GywjQwU/YecohKm7NJNq3DAPWfZGVYUUWZwY1MgFHssyETPwr?=
 =?us-ascii?Q?0RFIO33Y4xCdRm6qnkTbXrYKMEmrBeffxufnd+iSTVBJ1juYdXJw2N35o9vv?=
 =?us-ascii?Q?L8mRLYmn8x+izSOKobF3yf64uGTT1qtPBuL5Ru822fttRgzCM46PRLTeP5wa?=
 =?us-ascii?Q?feIX/bGi7u38mw3ZiN+f9ePkmBOItxJg8cAQI5gcodCw8JQaxy02ORBL7tzq?=
 =?us-ascii?Q?l4Z7+1/KySgxpPw5JpZ2oaOVOn+RTPQ/5SlVP/tQvGf1CsHETbXocLh0x0Kq?=
 =?us-ascii?Q?oKsWsGUu0lj6AUpcWJ7wDpAT4FUMBPCKPZ5QSZa5XElR7cn0MJ+cO0vWFmvy?=
 =?us-ascii?Q?b+09m12mpFsUANF4eavKy8d29Lho3HOH0p3LEn6vPzkzFkHWIiKOTz93NsEO?=
 =?us-ascii?Q?nsXE+l+WGTWMijXqvSBKa7ckG76snhbOkRl60RFv4Xq3ile9fJTYKATjUrMQ?=
 =?us-ascii?Q?Co8fivoelVrl0HoAQolev/yKBydctrzyosG+3HLL8ZI5lUIRaA03LMmAqO9b?=
 =?us-ascii?Q?K14u1ApIFa4Uq8Z+3e23nq6bZ5wlhTVH8vhZacUkl689r3jfZVARkOrGLYKC?=
 =?us-ascii?Q?m0ZNVS8Bhy8GiPyr3aE+CyeRgpGSt5cHfxjBo+pdU/RHZQBB4m4F4nMpvFDT?=
 =?us-ascii?Q?wsdtaRTye2wpJN+20tGfFZMfAumGGWbcDuJXAL7YXNK2bJwNdGHrPzr40OPX?=
 =?us-ascii?Q?qDD4TeLsncMwaXe7Yabqu00PJmQcOLNd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:28:56.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bde559b-b24e-4c02-bbf5-08dcd3d67dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

Status property should be missing or okay or disabled but not just disable.
dt-validate is reporting it too.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 83b8a98d80ca..38be5a0f96f1 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -101,7 +101,7 @@
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
-	status = "disable";
+	status = "disabled";
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index dd37b726d3dc..3c04da1c5fbe 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -97,7 +97,7 @@
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
-	status = "disable";
+	status = "disabled";
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 811cebafe9e6..7439a2f872e5 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -97,7 +97,7 @@
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
-	status = "disable";
+	status = "disabled";
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
-- 
2.43.0

