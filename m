Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BB5D68BD8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 05:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA3B83C54;
	Thu, 18 Dec 2025 06:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i3ptbnhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB63A83C61; Thu, 18 Dec 2025 06:02:13 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA84D83C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU54PtJyb8dKxzr4PSwC0lFDACfFR0MGbY7efu8uBs75HR5QUJY8ZBfjH1gWHGNlXBLFzmxjlMYw9LLBWg5/pH9KLym0XOPFmTsJBjDrHMTX5ob2jhQs9/mZjg0K+v9AUXG1WBgI7HVd+tmPonrDnHVGPJ8gsdva1NlgLel6YLAhhyb/PWVvORrLWALyy6nXbZ03TJExIWUR/sI1+l8SYENsQG0phc20Rtj75EifZr6r6Il8rDmTVklbXHi2g6xf7Y1dSgX/WIwE8jyx/szb7AEyFyMpt4+BO9c57iDNo6TuaUfI+hs2k687KFHPz1W+eKg6oexBtcGeBd+d4kVE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/JjLgubMVbkbyeSUVoKFHbNwn/zmLv5Qq+dmlro6CA=;
 b=GzgkGi/LefJxI8C3wbXGFClPsYTvuz+N84JHpMN+70+o64RglyN9ravoTJQq+bI2z6o2mwtVw/9GFMFl671psQ/tAzdufOJTXbCdyY5iu5xVOMkeqI3HuoxE61UrMeLhih2xZC6fp7XugPhEcecX2mzb5BtxESSofXPUIoaS9iARuBMKWLnT2h1PtvA7nsOARV7x/kVS64Hvvkj7C84ENdjVENj3HEGzEN0Mddqo6Ddt2iOF4pis2uR2xpaMPStRmOW+CpPfns1ROuBd2fTPEzslbRkIyiMeXaWv8rwnoHLiyScdVg+JPvEWbq1UPM+0QnrF2lz0nLVTTcib3ptCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=collabora.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/JjLgubMVbkbyeSUVoKFHbNwn/zmLv5Qq+dmlro6CA=;
 b=i3ptbnhTAfhT9AS/q4J/lKvK10g1+khrdpPoXIu2jGsSRzuRHnl61QjMAwh4lmFcIuSjzPexhiA6xBkC2op1fHFcXoXIbvCHq5t9XaVHNvHnml3YrHp1cZ0cnO+K+weZ01PTcugZE9F90kUlutDZx1HpSPpt+x7u8SA6r65/N2A=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by DM3PPFEDD6F73B8.namprd10.prod.outlook.com (2603:10b6:f:fc00::c56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 05:02:08 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::84) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 05:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 05:02:07 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 23:02:04 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 23:02:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 23:02:04 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BI523r32792664;
 Wed, 17 Dec 2025 23:02:03 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 18 Dec 2025 10:31:55 +0530
Subject: [PATCH master] doc: board: ti: fix alt name for tispl.bin in DFU mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-dfu_doc_fix-v1-1-d7a9eb033b92@ti.com>
X-B4-Tracking: v=1; b=H4sIAMKKQ2kC/x2MWwqAIBAArxL7ndBa0uMqESK61X6koRVBdPekz
 xmYeSBRZEowFA9Eujhx8BmwLMCuxi8k2GUGWUmFEjvh5lO7YPXMt1Bo60YR9tR2kIs9Utb/bYT
 NpIMiTO/7AeukuXllAAAA
X-Change-ID: 20251218-dfu_doc_fix-51c345e19e78
To: Sjoerd Simons <sjoerd@collabora.com>, Martyn Welch
 <martyn.welch@collabora.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766034122; l=1618;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ThT3YoAr+rje5WTOD6f9msBRC54sBMpNjX5cDbgA6QU=;
 b=ABeNvTNupv2HGAOnwMgdzqqCbzZtpgiPkh2DRFk+RMcfIC84WXXpM5w5bTPCoUjinj0/52tHo
 LLYGVpcbMzGD4F/vPXPZXI6c5WkcnDjGLGcQ2nWxKtFAiPnLHiPt8Mw
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM3PPFEDD6F73B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 266342c1-ecde-428d-dbc6-08de3df29854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2k4L2txL3V1eFBOZTh5V0hOYS9nU01tT2k4VXE0RDRac2x0VHpiRlhTdzZJ?=
 =?utf-8?B?U3VKT2FSK3RQRzFuTXBGOUVPT0pvZ2JmMk8wU2JYU3ArNjlpa0JJSzIrL3l0?=
 =?utf-8?B?cVFIaHN3Rm14RE1LQ1V1UjllOFFHc1VJOHFpRFZ6K21IRC9MTVZKWW1FaUZp?=
 =?utf-8?B?YnRCczhucE81VWxqVlNaelprZXVEZzFOMUhnekFZRC8xZGcxZ0dXUXpPbTc0?=
 =?utf-8?B?RWFqbTlDNmtFSXVMQWVFU0QvRnRTZFcxRlV4azlDYk96dFBwbGFvcEFJOE0w?=
 =?utf-8?B?ck5Ddk9LTG53UWh3SVVKNUJaNEYxWjZJaDJZZGlHSmtXamNMVm82TThTQVVQ?=
 =?utf-8?B?dUtJaTErb2M2TnFDazFjZm51VEcwSzFHZGxkTXdFN2M3aHJUQ09vSzZ0NDJY?=
 =?utf-8?B?SkNTbXFjSndIMFFLSktNZE9Gb3hXdlp5bjZlSWFZc2RrSWg1cTBrYmRKMm50?=
 =?utf-8?B?b0JpcXMzTEFXa2ZHYmRlMEdhbU1WdjZsUzZ6ZUp4czlvYTQySDdad2g1UGI4?=
 =?utf-8?B?OWtJayt2RHBqak9sSWU5a2tFT1ZBdGhDNGwvQ3lYSDJxZzBkWnlUL3d4YVZ3?=
 =?utf-8?B?V3dyL2hZRE1kRjU0QW5GRzRrVGRaandmR1RtQ1ZXV0tKQUpoZ3B2YWRidU1r?=
 =?utf-8?B?WWQ4NjVXcmZsK0pnNHROVnZBR0JoL3BZTW0wZTJST2l0QytrTGFOakZNYWdp?=
 =?utf-8?B?Mzg3Wk9jZmp5Z2xKMktKdUVIaFkrZzJyb0NWckwzL1M2V3NNODMxdDl6bHVa?=
 =?utf-8?B?eDlqQ3R1UGo3NGZsSVh5WVU5VmhmL1QvU0hncGJFeFdmVittTWw4MTZ6NTNo?=
 =?utf-8?B?YWJSaDlsVmJnNUhXalhmWnJTMXRvWkR6L2djQ3lHdkd2Y2NTeDRBZmRpSnpi?=
 =?utf-8?B?aGhRN3hteVRSVjkzU0ErTFBKVEtSclIvOWd4NzJXaDhVZ2c0V0NrVTl4YUZp?=
 =?utf-8?B?dkFUYUZLRDVjdmMrWTJydXZCZkhSWTFCN29YelZaSlJ0aGd6UXNPeS9tdW1N?=
 =?utf-8?B?a1RqYUxidWlpb3lxRE5Na01uSnZxM0FrY3ZpQXlnTm1FLzBoQ3g1bDNzSFU1?=
 =?utf-8?B?SE5selovR2FuVStYSjhEaTE4TkhSTFlBdXZMZTYwaldSYzVUZUE3MThUbkNa?=
 =?utf-8?B?a2RsZS81amdiZ0ExYVFYMXM5S0dYU1FHemZBUWlhRGFKZXY4ZFVmeU9IemVh?=
 =?utf-8?B?ZVFFT3FzdjJBVVpSUnVnM0xaRFhPOSs1c2FVWjFVTXhCdCtOWlpmKzFHdzdG?=
 =?utf-8?B?QjZHZlp3KzZxTUI0QmYyWmpiZ3MrNEVUa29OYVdVc2NOQ0RNanVycHh6ZzZI?=
 =?utf-8?B?UFU0Nk5jZ25jY1pyMVcycEFkcVpPaDNxai9YL2Jxemd4aXozY0ErNWtZays5?=
 =?utf-8?B?WUFBQ1d3c1Q4dHR0cnlaVVM2cVB0NUlHVGxTSlFuVGVHbnhwTVhTTmh6ZzhF?=
 =?utf-8?B?UTZERENtTWJXL0prQkluYWV6YWtBVitJbjBPNW1iQ1Fpd0poVDN1SnVWVUdP?=
 =?utf-8?B?eDBNWFhLN0lDdDJjWDc0ZGJCS0thTWhhb0tSWGhFWXovOXhKMW5ZSS9ucW5z?=
 =?utf-8?B?OWZ5cXJWSHF5NkhadDB3NVFkN3dOblhQUFFyY1g4MXl5OTV4N2xrRGQydnhh?=
 =?utf-8?B?VXVBbGVkdDBEaHlVT3A2a2dtT3U4Tk5CSyt5cFUzTHgycU9hdmpiS24yZURm?=
 =?utf-8?B?SGowM3VDaFZQei9TcnpTUU44bkFNc1kyOW91R0hKUE00K1o5ZS8vbmYrUytL?=
 =?utf-8?B?cWhtTDl5cXF2RWZBN1FHWmExUm5RVSt5NWNGUzRBYmZJZWsxUUUwVjloc20v?=
 =?utf-8?B?cFBZYWpuSGRCRHZpOHRONG1pY3lQSjVieGZZM2VBM3dIRG96TTF1NUhORVox?=
 =?utf-8?B?LzlzeE1MaDFxVUZMSEUwUGNCV2x2V001ZlRKaDMzN3ZieThDQnpvUWtrYVNk?=
 =?utf-8?B?M2ZWWVhQdzFFWk1jV0FISTl0ak9NblhOMWxsUmcwOHg0NTRkMzg2K2VqK3Zq?=
 =?utf-8?B?M2htTVd4bmNGdHEwNngxZXlRQk8zUWkxQzJnVGh1Z3hnczB6bXRRdVkvM3VK?=
 =?utf-8?B?NTBYRHA3VjF5MStUTGR0TVhwRUFobHpGaGd6YmhTSFNoc1RwYU9qSm5BaGJ2?=
 =?utf-8?Q?yhm0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 05:02:07.9251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 266342c1-ecde-428d-dbc6-08de3df29854
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEDD6F73B8
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

The alt name for tispl binary is "tispl.bin" and not "tispl", this patch
fixes the documentation to the correct alt name.

Fixes: def64b493748 ("doc: board: Add document for DFU boot on am62x SoCs")
Fixes: 3633fdbb6b90 ("ti: add support for AM6254atl SiP")

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/am6254atl_sk.rst | 2 +-
 doc/board/ti/am62x_sk.rst     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index cf58ed4c03f..7776ffb14cb 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -280,7 +280,7 @@ When using dfu-util the following commands can be used to boot to a U-Boot shell
 .. prompt:: bash $
 
   dfu-util -a bootloader -D tiboot3.bin
-  dfu-util -R -a tispl -D tispl.bin
+  dfu-util -R -a tispl.bin -D tispl.bin
   dfu-util -R -a u-boot.img -D u-boot.img
 
 Debugging U-Boot
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 1a0e5e07c4b..b50fff87506 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -329,7 +329,7 @@ When using dfu-util the following commands can be used to boot to a U-Boot shell
 .. prompt:: bash $
 
   dfu-util -a bootloader -D tiboot3.bin
-  dfu-util -R -a tispl -D tispl.bin
+  dfu-util -R -a tispl.bin -D tispl.bin
   dfu-util -R -a u-boot.img -D u-boot.img
 
 .. am62x_evm_rst_include_end_dfu_boot

---
base-commit: a333d9e59f6675c9541c34643f334dbf50898647
change-id: 20251218-dfu_doc_fix-51c345e19e78

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

