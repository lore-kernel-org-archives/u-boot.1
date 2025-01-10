Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BC4E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F133806DC;
	Fri, 10 Jan 2025 13:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="I5v/Kaxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF1780613; Fri, 10 Jan 2025 13:36:00 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F262B801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU6RrQPLWdNIi86ScRiv1okN3wk/daDkYNpqbQcSAGOBYBtSV9denblZ1hoHTrEgRbVmww+8WYUyK3vUEuq0MEbPjp6jbpPx141MZKtGLhCu+kQDDiXXj5X5ris8jFhhqmGudliABtOc/kYDya47FypAl1Vdd5g2+MQEgf5giCSSpBM1hRRVu7QpH5cbbEOLHK9ehgeEZeMtdVn7EeYfBgLrjxfZB9nhLZoJGTB33hWUxeROhf+IZuLCJdfJXlzle2jf5RRCGp0NHMzKRdviqZMQoPCzHSKqmlCH28mRCThrbE5ithpiX0XXcq+7juAcS1cAFtp67W/eukodEa5SsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdTNyq3RpfjGA5iD/tKNqQX3JdwQVXync9MkJVbQrEM=;
 b=lkECZC+YFe7lxwN+5z9OaAHtrwWrR8FIC6Rfc1HTAgOg+UUJxzDUk++L2qsXdQybSd+r6K3b/FX9rMIys50GPrDA9CacqEH/N3s/7Pia5ZELe9NH+1SRU50b4aSM7sTNd0wEmD6IQE21aX3QWBfQLcgMNi8rWvD9M4nCXny+U3wOJbJPictr5nkVLmYQvMGlPhGllgrgIG2kUyybILNLc8aRA/OoOmMncQgZnkvjbc4MzERIj+E3CRmXI/TSqLW+CbnpMg+agbfKBgCAM1ZBgPhdaN0Vj09LLaNxCxwjOSrGmMgpW7dRCyCyQeBZPJKUnvRjAnCFY5nQpCPr2AANng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdTNyq3RpfjGA5iD/tKNqQX3JdwQVXync9MkJVbQrEM=;
 b=I5v/KaxiS1GjSpJ31T5wlLxBGECPpu3SteU6EHTykmryHx8gQJ2CruIAIhOwkdow8peUR1acrhZRzjJO/IcdSGSc9z2renvQ7815zWB1W3qvTmYpTRZGmxkxI/8uGPaxIT2bmKquCFOU9fANWYQrYuJig1r1jc0wegDwCFQuL88JUGoOEN0IwNL/0R4x0NDTxkFm1pwAikfC29jRYbOhCofkVIR0GaC9uKX6Gu8hQC619kvEBhBz3ll466eD/uK+NTxwhVd6k69nCcOoLcDUEaSJn/EkevvO/BFv3RoK02pA6tS4UGPkE6MH+eSq+zt069obPmvrYWCNHpUavfCgJQ==
Received: from PA7P264CA0147.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::7)
 by PAXP195MB1342.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 12:35:55 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::33) by PA7P264CA0147.outlook.office365.com
 (2603:10a6:102:377::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 12:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:55 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:51 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 10 Jan 2025 13:35:38 +0100
Subject: [PATCH v3 6/6] doc: phytec: imx8mm: add OP-TEE documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-phytec_imx8m_optee-v3-6-6c39dab15592@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|PAXP195MB1342:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b47249-90c0-4483-feb6-08dd317353d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3lyNmFHd3d3VmNoekxuenpDNEdHWmRtL0FYa2t3Ty95RHVWM2lha3UycHVa?=
 =?utf-8?B?Y2lKZFJ4MitFUnpzaTZkQWVUT05weTlPY2Ntdm42ZFRtZ1ZEZzJsazVtRFpH?=
 =?utf-8?B?WXdWWjFWWjJzQmQxbXpiMEpPbmJOUGtCSCtiSlczU21DRnBtNVgwUks0R1hw?=
 =?utf-8?B?Y2QybHhCUEVDeldFTmVwUFdpSVVhMldoMTFHTVpZR3ZGM0dXNE5ZcnFPbDBR?=
 =?utf-8?B?eDEwUWRpSGNLcTJ2bmE3REFSSWpURlVRYTFzMit3TkN6OXptODdJZWFrb0Fz?=
 =?utf-8?B?YWt1ZTl5RHZPOUVsN3ROdG9EcndPc1Q1QlVuRWVBN1d0RnJXY3RuZVRrN1Vh?=
 =?utf-8?B?NFVGMTBPYlF1WnNkWUswWUlhVGZNV2RsZ0dkdytmZkJQc09LTmVkSENGTmsw?=
 =?utf-8?B?VmtuL0padHhqKy8rUk92c1VjSEhraWl6aHlpNW9Mb0NZeE9XWmU5clFYNnpj?=
 =?utf-8?B?MnNoekdaYWRvb09yMWVCRVFFUU1nd3lYbHZFODZzcytaRXBBbkwyT29YYWo1?=
 =?utf-8?B?NjR1Q0oxTXVJZ01SNHFJWkQrNlNmdnA5Q2ZUaldnNUlKdkx1T2dJL1lYelpK?=
 =?utf-8?B?T2g2QlRwNzArS0k0MU1qUUxvRzJkZmdDTEhBMDJHQ0VqYWh4WGRXc3VKSDhO?=
 =?utf-8?B?U0N0OXRVZGtVdG9oQ1NWbWVvSitCRm5UM1JmR05ZZ0FyaXp1ckVjRW5lUXpB?=
 =?utf-8?B?alphaGxUcG9idkVJbGUxUzM1YUFTNUYyVHQ3eGtBNkZ6K0VXY2EyN29qWUp1?=
 =?utf-8?B?dU13VU9PbmRWdUpQZ053YkhhNDFpSXlHdW5rbWtnREJQdW5xR2VldlZra0hv?=
 =?utf-8?B?MHFmeW9GNzVRMWg2VjYwR09MRlF4VHZpUGdxYVl0cWs2dWQ3ai83d0ZGZGxU?=
 =?utf-8?B?KzhsdmJIRTlCdGpaUHNQUTR3NExDV2d3RURkZWJBcTZDYVVUMDZPOVZOaXBL?=
 =?utf-8?B?cmtFZmNybENSRnVjT0tqU3FnQmk0aHU3eHVVRGljSUZxNWdCVW5FblpQS2s5?=
 =?utf-8?B?bWptai9JR2V5bEZTOHFtc3JtNzg5NU5vdUJnbEQvV0hZZWlsUlQ5RDIxQmJB?=
 =?utf-8?B?TVRGT1kwc3hXcnFWYUlVczR6ZDJ0akxvSmQ0SStqWldPZEYwOGhvVGNINmc0?=
 =?utf-8?B?dVhCN2dHcHo5azBTZzJmWDg2MDcyWk5ISVk2SnYxcldod3ZvUTYycHpXN1BG?=
 =?utf-8?B?Nng5eTRydWt6SkQrOXFNL3BCME1CakpsZ1pYZTVDT2FScFlKNFpMQW8vRFlt?=
 =?utf-8?B?Vmx0SWJmWENiQXdGL2dxOS9wM2NzY0F5UFAvak5nOHhQVmwweXJwMGVVMEd2?=
 =?utf-8?B?SWI4czg3MCs3RGhIM2NLSFhicGlpYlVxY0Z1NTBVK2FsTlBCV0s0QWUrR050?=
 =?utf-8?B?Vy9iVEh4bFJYNzF1NmVMcTVYNFdzYXBvdG5LQmJEUUpsSEJyYUFJcVBwSTdm?=
 =?utf-8?B?RGlhd1BQSllNQWJSZGcxY2loR3B2WnVUNmtaMWtwaDc5elpVMURsVTRrWklX?=
 =?utf-8?B?SG12WURMc1IzRnMvZzVJejNQR1hETmRlNG1VQzI3Q1NCWURROXl1VDBiVXJx?=
 =?utf-8?B?UmJqVG1Uc2NxbWhVbWRFSi9kRVNtcFl1dTFRczQ4MlFBanNnZTdkcUVQeGtF?=
 =?utf-8?B?ZThXSW1tdzU2UHh1TjJwdkJMbTZCN0ZMUm1BSHZLaVdDTXNQRDByZ0NLM0RY?=
 =?utf-8?B?MnIySThLMDFvTU8vZ1ZDRTNJdEdRYmJwdW9BZ3Uza0NDbjIxQjZEd1p5aUQ4?=
 =?utf-8?B?RlkwZ1VsQ2JHSG1ocmx3aHVQUkQ2Y3lmWCtjYWdOZkVNU1pUQ1Zka2VKbGNw?=
 =?utf-8?B?aERWRnFraER0bnplUzBjSEdHLzA0OUFKNzFGR2w3RzJOelUxVThnLzhXWmpn?=
 =?utf-8?B?dDZGQXlTMG1MVGZGU2QvUmlYTU9kZlRWN0lMSi96bm9WdzMyZlpmd1JZS0tI?=
 =?utf-8?Q?Yn7cIxpPEdU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:55.3961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b47249-90c0-4483-feb6-08dd317353d9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1342
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

Add instructions on how to build and package OP-TEE for the
phycore-imx8mm based boards. The build instructions are identical for
phyGATE-Tauri-L and phyBOARD-Polis.
Also fix missig '-' for TF-A build instructions.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 +
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ++++++++++++++
 doc/board/phytec/imx8mm-phygate-tauri-l.rst |  9 ++++++++-
 doc/board/phytec/phycore-imx8mm.rst         |  8 +++++++-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 58c5e2d0af9..7631e1cb331 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -9,5 +9,6 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
+F:	doc/board/phytec/imx8mm-optee-build.rsti
 F:	doc/board/phytec/phycore_imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/doc/board/phytec/imx8mm-optee-build.rsti b/doc/board/phytec/imx8mm-optee-build.rsti
new file mode 100644
index 00000000000..c83de5cc7cf
--- /dev/null
+++ b/doc/board/phytec/imx8mm-optee-build.rsti
@@ -0,0 +1,14 @@
+Build the OP-TEE binary (optional)
+----------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mmevk \
+     CFG_TZDRAM_START=0x56000000 \
+     CFG_DDR_SIZE=0x80000000 \
+     CFG_UART_BASE=UART3_BASE
diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 28b614fd144..0d9e1024f8c 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -9,6 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
+- Build the OP-TEE binary (optional)
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -20,10 +21,15 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
+   $ # with optee
+   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
+   $ # without optee
    $ make PLAT=imx8mm bl31
 
+.. include:: imx8mm-optee-build.rsti
+
 Get the ddr firmware
 --------------------
 
@@ -42,6 +48,7 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
    $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index e9dc2259907..08f5949e02d 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -9,6 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
+- Build the OP-TEE binary (optional)
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -20,10 +21,15 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
+   $ # with optee
+   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
+   $ # without optee
    $ make PLAT=imx8mm bl31
 
+.. include:: imx8mm-optee-build.rsti
+
 Get the ddr firmware
 --------------------
 

-- 
2.43.0

