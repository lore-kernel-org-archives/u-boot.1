Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC873CF31AF
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 11:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CCEA88F46;
	Wed,  2 Oct 2024 13:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxTLxfsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE64388F68; Wed,  2 Oct 2024 13:15:37 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB29688E88
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 13:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ica0qok5LQubgDBqM/Vo2OdUOa8ZuyLzUQmyTJ02GxnwmIOTIprtfPZ0i55gPyxL580QQj2ZJ0OkggS4V28Ms+Vrsv4af3vheYLIiUaUDIEaWK1TxMj2Z+bJNijPY7szRD2uxen10PVWVQTB0sIAZHfqT2qqMItiXg2DH2OIx3cPVcmIH8nb2Z2MexqM8z8zctdnsTKZnhjggdWKHXvUxa1dHY4/ClTIUzIu+Wr/30//e0gHmh2Z5135XyaZqcmamm5CW+ypsWXFe7wdSrRkFoDcI1kqI/fp/6p2WRnidpx/RV31PGgsa9hScC65mtZCYxs02GkRNcx+Ii6a3RUhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUriAZPUmDhor4WtiHB3gsiI6yqWBS8+DhHZD9MLyx0=;
 b=nA4rtWgdT4kpHhH4orVDp1WTMfI81umlq437e9s+Ci1CKeMc/9bb/U3b5UXIvd3iwPypLdB9vc2q3/nC7KAkh+7cmQHmqjGGaJhKcyW8FbKpEAG5Q1zdUqBKEBmXTgCKc0LtY14XcMBLBhgEKzeaUT6mrEaYskHIoY6h/7DNh1PGCSYim3BEyWQtV2yfUjPoJGGjya7CHeqdXnw1Vpkj8q89LCeYEMgDYBxB0iSee5E8bpMuM+bQcnbn5449XfUblBMLKCVmtmppKPiOhaiPAcTEFIIzDqOxwqjns31dvXMDQU3yX6JXclDNxS8Ra/Z9WIaEf3FqVbE4KoAO4QBNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUriAZPUmDhor4WtiHB3gsiI6yqWBS8+DhHZD9MLyx0=;
 b=MxTLxfsh7xG5ZqA0866iJtCck70bmOP/360Qn6xC3DWjXmtaf7k9NOcsMoALv0rcT3JIef4jYwB9dM5RnP4CqakTGw8CuVMcrLIYONW0y8RhZ4zBZjmGiJGLIww6IqRw7jJNWsKAktYRsAPveBYIKUN4fg9g+YB7C/Epqm2MBBM=
Received: from DM6PR14CA0041.namprd14.prod.outlook.com (2603:10b6:5:18f::18)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 11:15:29 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::a4) by DM6PR14CA0041.outlook.office365.com
 (2603:10b6:5:18f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 11:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 11:15:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 06:15:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shubhangi Shrikrushna Mahalle
 <shubhangi.shrikrushna-mahalle@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: zynqmp: Remove conditional check for bootmenu_default
 variable
Date: Wed, 2 Oct 2024 13:15:17 +0200
Message-ID: <0e30b44ce3b478fdec21edad8d896f4d438ce331.1727867715.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=p6dbOMNRLBkrNutaPK/oLeea8icCvf2GN5iHICXPE1c=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrS/2m6tMev23v283DLlmcjHKfcW21cm733SskXwS+6cc
 9WPvku0dMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJVFQwLJh0icmgU9Wkanfj
 e2eVb0IfPXusIhjmigbpXwhe5bY724I34FuM8uf8bwaWAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9304ef6a-0945-4fc2-a926-08dce2d385eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06wcRrEMH6sBzMQxuSzDN/mDIGXkfP5F9wbpc+CuHOWd1ypPxstx9RzsSRDf?=
 =?us-ascii?Q?wrqyW3qcF84i8PtcXN2MBOcLhXZdH/LWQrGLsJtmKlSHP+lwGu9L+1QnZIMO?=
 =?us-ascii?Q?ig+s8Rq4MsPumPKK7KOAt3534oem6dHCE3x/YuP9ERQ6pbqXSk2G99JWT5BY?=
 =?us-ascii?Q?f6PKZaoycauCxD3qzDXPJg2i4N3qTdIOBR4RylFWbIZ2Oarn43VK7QoKZC4T?=
 =?us-ascii?Q?vp3y1N9mfcmW2I12Q06tKeKD1oGZakSpBjYPlCb+aBf0rNxpEdmBojrK4N8G?=
 =?us-ascii?Q?AkXBkw1/8zhJc7K72iXVHAlrrUCNi7G44LMfawMPrW+QrVp6c7RKqqrOa1DN?=
 =?us-ascii?Q?l5wasiHvf6bu0spQqHIsgk77OoO+6mixNIQMvAWGrcSPoQLnxlI0u3wRycTr?=
 =?us-ascii?Q?joOh6eeE/9akNpOMiCj3XMfnPlLWTMN1l3cGnzbvtFHcr80ZJeAItQa/YLFA?=
 =?us-ascii?Q?/BV1q9//b0Ho4J+t7dC3sUhqK56oxlnRYudFwieYJkwepehbl+pogSMVBVjt?=
 =?us-ascii?Q?w0iGDQCb2xOTm7Ac3ONGj6VffQHhV7nFeRkx7bqJmtCinCXkxryLfg+wTCtu?=
 =?us-ascii?Q?vx4LRy5FD4SVC5F+kNbMsdMVeTNkJQ5DD6BwW9Bgm3LSjCopHyI0588NdiPC?=
 =?us-ascii?Q?NWoNzP3VeQ9U/wT4xhskXSCp4Kx16U2/2UYxqJwTp0lWfF5SjgrRXkWoTiIn?=
 =?us-ascii?Q?1hdU65e1gUrQza1lqg8X0EjqyU850RA0R3NK2ssvudhvb0TMK2rAibDn0trb?=
 =?us-ascii?Q?Urm3HtU8HpTYWArVOLQKXuBExxG8sDgSy/uUX25qgta27lKMMakZUFOivld9?=
 =?us-ascii?Q?5exA6ztG8mRzOPzhs0q/68tYbaDEVneC7ZxwsxBxWzNl+0cRdjxEsWBvJQ71?=
 =?us-ascii?Q?/bRCjn2w3Qqmo6VRfPwrWPa3gZx9nHM0byd8F/+KBrPU11A0b3RV3iSd5ktd?=
 =?us-ascii?Q?ZPRldpTGQLm1M2QYQIGnRIkcF1MkJOdhWL/PnF8nhFsNMpPVTk/ZkCXNISRa?=
 =?us-ascii?Q?Hb8ihP3nAlEPleCSZghgZv/7wYIvazOOrzFfskXt8O6zTR6feMx00+39EsWt?=
 =?us-ascii?Q?nOreZdAWco/4A2FQ29pqQU0BkRcr6Ec32RZ+HODDRaOxNVWDny+AqlusRYxY?=
 =?us-ascii?Q?mc9s5SL4WdBT2ZMXizNWe0WHmVQM7dKOuPrjOz01RFcD11rDktdrc3nlyWw+?=
 =?us-ascii?Q?/3b24T9qVi0P/Sml2r+0DgQgSXGKQ2MlMdhETwVvD1Em9myVcLatM/LXs1Lb?=
 =?us-ascii?Q?Y+b8ivQ7q1q6BDWvIOPErOzSKvTb5O0KlEPNIZBv/RNx74xzXkoGDD8f03L+?=
 =?us-ascii?Q?sPacnNebmbDWKKL0Lb/Ksl9YsPRY9GTpr3MzZDOqSyzLXtEX1YGJpgjCQCKE?=
 =?us-ascii?Q?KcWoH8Wp77lKRrqDtbdPlud1SLYT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 11:15:29.0527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9304ef6a-0945-4fc2-a926-08dce2d385eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

From: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>

As per bootmenu support added default boot options to CC on AMD CCs and
default to SOM on others.
However, if no secondary boot device is enabled in the design,it should
be the default boot option for SOM when combined with AMD CCs because it
only contains SOM peripherals.
To address this issue, The conditional check for the bootmenu_default
variable was removed, and it has always been set to SOM as the default
boot option.
In this way, users can choose preferred boot options from the bootmenu
based on the boot devices configured in the design for AMD CCs.

Fixes: 61bf0fa8663d ("xilinx: zynqmp: Add bootmenu support")
Signed-off-by: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index d0e431ebb46f..927f398c3c38 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -51,8 +51,7 @@ som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
 
 # To disable bootmenu set enable_bootmenu=0
 enable_bootmenu=1
-check_cc_for_default_boot=if test ${card1_name} = SCK-KV-G || test ${card1_name} = SCK-KR-G || test ${card1_name} = SCK-KD-G; then setenv bootmenu_default 1; else setenv bootmenu_default 0; fi
-som_bootmenu=if test ${enable_bootmenu} = 1; then run check_cc_for_default_boot; bootmenu; else run som_mmc_boot; fi
+som_bootmenu=if test ${enable_bootmenu} = 1; then bootmenu; else run som_mmc_boot; fi
 
 k26_starter=SMK-K26-XCL2G
 k24_starter=SMK-K24-XCL2G
-- 
2.43.0

