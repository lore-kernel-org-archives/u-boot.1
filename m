Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F92E9536D
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 10:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA0283AA7;
	Wed,  4 Feb 2026 11:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="CMVTNMg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9743A83A3D; Wed,  4 Feb 2026 11:16:18 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B5C83A47
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 11:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oULUea/0eirec8O8OkFd8B/hwf/AbPn89w0AiVV1UHrDB3DHjKY3f4Om1tCRhlp5F7sQPybVYt/gRTiQEMitlL68hCNqQ6FSu3v+q9s3UgWAiai+k5QX8SCGKOnWGWulI1Mn9gqDAe6FthxYNbZnnhwrp2WPm9Y71ku4nAW7NtAnS5t4o+pMODHX8/i0inrnXJmBILnFfjYJE3EU933Mys4Hcc5yT8IKU+XLq0o1HZHOyep0dwd8baB3BhzOLqFOlYTWA9/9eZDzULK6fH7foKuEWDCrSwLMdxxfpRPZnflnXgH2dovAzCFeo5TiNz+f/ZoDGAmLwwf2l5YBK0Y/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xik5PlG2RAFwx7lt28rcXL804EY0t5evfTapgzGppGs=;
 b=Kqxy/DVELBwgnqht8oLHnfDo3jQSWBLiSU/dvwVuZte7WhysbGROgA3+8FSIpFYjt/6MBDqVpwoA87eMSHG2fKLFbjcg/iidXjmX018NP84Xq04LH3+rzwVE0BtAmClCBzgrFtct393HBQGE2PkOVH33QOZi3IgxcwOYiO6pJVEbry53t4C/RAr03vnBjRxqTPf5vZeOCHvZOBORllwHUjq7uI6sAP+LZbZfxDpm35bsJXl2hfYOfenpglo90bOCRhIm1eqUxsibCRkr58stVxMhJd4PWXYWYUMvLNHp5uVbD3PcOtvnutbiLLokf9/Q3/pq1p7LgbmoWW7O1Mwf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xik5PlG2RAFwx7lt28rcXL804EY0t5evfTapgzGppGs=;
 b=CMVTNMg2gM9r3Wb20umN66XVnwbo4i7md1CQLiOrpI8F9gpxar7c5uK6kt3qi2LfI8S0E7uUkZlJPrjd267GNaYFPBA3h5UUbdxtWrKE8SdNo7Dtf7YfaC4oQEFZVaPB2ZjbaMVsiEZ+DlOLS47YCHoxkAWDIsAOym4ApQZNEwOEojA4ZMc29ghncYbNueAmvTfspEI4kla6H1AgXraREOzHU5Z79XEYnoVTDi/CBR6jywYYASPSE79/fmnGBrhMDYs+/VgpocWurlp8uGMRpbwVRqI71vTSHGZ0mZ2TNljKH9Kes/H8wAQElKeYpF+SoiT0papQJ2X2dksh6MgWkA==
Received: from AS4P190CA0057.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::6)
 by AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 10:16:11 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::b0) by AS4P190CA0057.outlook.office365.com
 (2603:10a6:20b:656::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 10:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 10:16:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 4 Feb
 2026 11:17:48 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 4 Feb
 2026 11:16:09 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 4 Feb 2026 11:16:07 +0100
Subject: [PATCH v2 2/3] stm32mp2: Add check on syscon_get_first_range()
 return value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-upstream_factorize_and_update_read_idc-v2-2-7f0baa41d2f1@foss.st.com>
References: <20260204-upstream_factorize_and_update_read_idc-v2-0-7f0baa41d2f1@foss.st.com>
In-Reply-To: <20260204-upstream_factorize_and_update_read_idc-v2-0-7f0baa41d2f1@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Asadeds <md.asadullah@eds-india.com>, "Marek
 Vasut" <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AS2PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc6ff24-5e12-4e4f-ac86-08de63d66c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWFBMUVSbEp2WEVNaTRFNmdpL2NSQ01UZkIxTGI0SzJyVWhZb2hFc1BQbkNw?=
 =?utf-8?B?ZWlsR1pnTzZGQjd5UUUvNEZOV1lYMWk3dG9jeTdJMHFUR21zTlMxN2labk9E?=
 =?utf-8?B?aTZrejZiM0duZ2RkRVBsVkI0WERHaEtJODNpUCtXZndhSytyTEhjUDFaUFpU?=
 =?utf-8?B?OWJGTGtXYWNzaGFmaXFHci9MM1hOVE0zQ3JRRU8vMWJCMjA1N1EyNkJFdktY?=
 =?utf-8?B?TEpSWU56RU9TbUJmOUpmcW9ZbDAxYnhuVXJkUjBaNnQwb3RxTUxsaDJPL3RN?=
 =?utf-8?B?cFFhWnlkR1dscGExdytSdzhHMmpwZ09CbHdTTTJUZWdYZlRRUFZlSE9jSWdr?=
 =?utf-8?B?U2NKK25IeU4yaTNKR3hPbTZvellzenRKNGlSV1pkdk5hZXNzOWF4RERUUEpS?=
 =?utf-8?B?TE1Md3BEWlpLSmgzOUg4cVNhSHFDaHdLSTc2dXgrWTN6d3FhN0oxb2puTEZh?=
 =?utf-8?B?bTduNVJ1c2I3MFE5OGNTdTlCVnhXYitJS2NLZUxyQVIyVDR5WVpadTA1TFJv?=
 =?utf-8?B?Z0JISkwraEwxRmhrVWI0Qll6VEZlS1NnM0xOb2NPUG9iQXNaZEJyREJiUmJB?=
 =?utf-8?B?b3Q2OUwxLzJuUmQ0UkRFTVp0SFFGb1lnb3ladTFIbWpPU1YwZGdaL2tZU1VK?=
 =?utf-8?B?N1orUkdpUHpldVh1LzYxQXV4cmZreFBQNEgyVlFjS3F1Tnh2a2VNd2dLZXd5?=
 =?utf-8?B?MStYSitVWXgramZybkJGanFLaWFnYjA5bWpGSG93ZWxTSDllTEVpY2VLckZm?=
 =?utf-8?B?cm5hNjJ3RHR4SEdPSDRUcWVpb0dPdTRCQ2J0U3U1UnRpSXRNSHk1bVYrTEI3?=
 =?utf-8?B?b2RQZVRab0ZVckt0NHlhaUtUZHVPOEdaL1RkVkRDeXN5QVhpb2pEaWtFWER4?=
 =?utf-8?B?NHFUNStuM1ArWkN3ZlJmdlVRK0NZQ2QvajUwYVhCYlc2YU9raStlSk14WTkz?=
 =?utf-8?B?dUlWWTZ0VDNCV0JubnBkb0Vkb1hKbjJXSVk0Vi9xb2RKdHUrUSt6OUFCaGlt?=
 =?utf-8?B?ZUxTZHQrTHhiUzY0eENpS0dCSTVLcWhEVFk0UGNIWFRZMDRnTUFSQS91Q1dz?=
 =?utf-8?B?VzlqV1lXVDBGNHgzeVByYkMxV3NxZW54TEJ1SWxkVVpWQ2pReXVTOE8wOG04?=
 =?utf-8?B?dHRXSU1qMC9EMzZGWHIwODR6WGFGdTlqWXdlYTZJdzZNbmM3TGtPNkdwRU1D?=
 =?utf-8?B?Z1JlOVRUL2xNL3ZsRlkxZXhWRXFySUVxT2NWaDlKemZJUFJDTGtURTR5NER5?=
 =?utf-8?B?Q2w4T2dtNmNjckFKVXFHRnBtVGdkR2lpNlJ5Y0l6aTd2eHpZQVFzcVhwakZP?=
 =?utf-8?B?ZmxRYU94clRNRy9aUnBRbHBVYXBpN1ZFQU9GZlZiOHBZbEZId2tZZktIUWt5?=
 =?utf-8?B?MTR3NTJ6cmlHcUtHaVRuajJ0L1NxdlVMY21mZ2ZlLzlFZ1MxdHphVzRVS00y?=
 =?utf-8?B?NGFnd1RhL2VYcmtmeFBMY1VuS1AzeCtyd1dZSkRUbFRLNS9PNWpSOTdxMlBa?=
 =?utf-8?B?YzZVM1UrV2Qrb29SUGtVU2xsSThqUlZXcWd3NUFUQUNvSGRRVTVnUitsT080?=
 =?utf-8?B?WmI0REEvNFVuWlRMWXFCdm80UmlJNldIbmJ1OGRZSkRESmlVQzBENjBYRjdt?=
 =?utf-8?B?eERHZ2FyNEZqZ1ZRRityZlBDek4rSitPNzBsNXBFdWpwWTFoalhyWjQxZVFs?=
 =?utf-8?B?alBBWkZpS0UyZ1FrMit1Y0hqUm9id3JqRDdxYzRibUpmaWdNTC8zNkVISTVy?=
 =?utf-8?B?dVdZVkNDMUxhUGZGaDA0RnBaNndEblJvYnora0dwVzhDWERReUM5SnZSRUYw?=
 =?utf-8?B?RmpMbEVIZEhqc01BdWtJY0xqR05xZldsWlkxYnVQbEdvL2JBWVVzTWM5R1Zo?=
 =?utf-8?B?LzliRlJRamVNSnFaWnB0Y2pRRW1yZGt5eGpZMjdqejJZTk1QeUxuVEhlVTBE?=
 =?utf-8?B?U0ZCeUlNTTRaZGl1NGNhOWFlSnhlMjh6aWsrc1hPdFVKWS9hWHNsaVNyWHcr?=
 =?utf-8?B?Mk01enZTUDhGakxQQmRQdVBDVEFJMGw0em5JZExMR1lQa1JiNUdjZE1EbTBj?=
 =?utf-8?B?WTQ0dGV6QkNjeEgvM0k4MXZUem9XYXBEblVRTGVuWkJPTzB5NE1oMTlIL0pw?=
 =?utf-8?B?S3Jid2dGUjZFNStMTmd4SHpSZFlrbGM3RFRsUWhXRXc5Yk9wMXBEdVI1VlNJ?=
 =?utf-8?B?ZnNuQ0N5QXY5SHVxK2o4M1kyejRieTBoRlc5WE1wdGZoQWRnVW9YQ01iVlFI?=
 =?utf-8?B?VkNIdkd2T24rT25pZUJsbkhzR3p3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wr9p4VOwr/XMJhic3EED7FHNvyx+9myFAsm2afB3SjzbCT/gPaISYxmr6Tt6Y/4wd6gKpXBgFteuObJhsWUNOR169JYc/Zn1ARyxTc+sVN5s9nrF6POSfyyYPMlleajr5Aehg7gI/GrkNpcb6foeyq0hQYkQNQX7FsWD5zGHxA/dCfQiu+SIRMHRgkowySDWp5iHCWDMAoISeriO2Kx2C42iQLvMk/es75rbNN/UKhtljcTQuaZ4zvJFNb9cOiR5Fk8+7mOejJM09sMCLfhvr1B6BWsnj3a7mHNy7qyR7MhUHBCSpW9GiwrIZE7FINwzaXRRfcKCWaMlSSM8EuQSQ9snRQpjnzLkyDaTDkliXpcWZtSx/LkLYSBOWehZ2sW4HUGgC4YE/nXROvvp+bF4JChfrxpWZGXEcY9hJ2LxUnmeSq4IETBq7+4ylUwigrXq
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:16:11.8910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc6ff24-5e12-4e4f-ac86-08de63d66c06
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6711
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

syscon_get_first_range()'s return value is used as base address to perform
a read, without any checks.
In case stmp32mp_syscon is not binded, syscon_get_first_range() returns
-ENODEV which leads to a "Synchronous abort".

Add syscon_get_first_range() check on return value.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
index 551601a12a9..40fceac402c 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
@@ -9,6 +9,7 @@
 #include <syscon.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/err.h>
 
 /* SYSCFG register */
 #define SYSCFG_DEVICEID_OFFSET		0x6400
@@ -30,6 +31,12 @@ static u32 read_deviceid(void)
 {
 	void *syscfg = syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
 
+	if (IS_ERR(syscfg)) {
+		pr_err("Error, can't get SYSCON range (%ld)\n", PTR_ERR(syscfg));
+
+		return PTR_ERR(syscfg);
+	}
+
 	return readl(syscfg + SYSCFG_DEVICEID_OFFSET);
 }
 

-- 
2.43.0

