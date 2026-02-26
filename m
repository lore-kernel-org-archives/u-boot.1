Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A0FFCE064
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C3983EC6;
	Thu, 26 Feb 2026 13:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="obwljhE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1DB83EDF; Thu, 26 Feb 2026 13:25:24 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10B283EC6
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytAKZDwE4bLB8YdvyY2Vy6jwEEH7vzVQIWTFLxC+hXnswPanjp3PjBTRT3K5raMpQEWGsF0DgVv3S4Yce2hZbmkibnfkjPihRK5SS/sL97o7xOCXNlhwx81k9JuyXODu2bpIW0eRiVqXf51yoqynKW54hShB6MSUB6JKCGcMC8m507bmNMOFqAwGGlLbCvLHVJyOivlryImTImmD3gyCLRiUh4Gg2e2/De80FXO/0fhl0nYleyretCpkiU3wrZG05HTbzifnbaYIEKVKSG2Q0MxrEJZdeHtt7cpqqDLUTwdencBbTreFYNmnIoAKklxnSlrw5ahHBEvXANG8VEqlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGlwjnDZMQmIN0qEig31AJ8qrAQIx0jqZQyuFreCfCQ=;
 b=B7rxTAauEU74upLkXZi0qLMUM1IWkky82POP352DM35qPHDQ/SrwVQhxHHMNDkD4lux0n0d/q/MuWJ7zg1DXudxIWTIpz+/ImJYpkuqDEdhuxE5xht16cNQOv8dKnknhQQHZdIJGVknZNo5Yj85AqNujh64UgCCICM4PFydRpwqPKt4HaUQtk20pnjvJg+xZ5Kfuaz3LcwYETUHJm15PvFD76EQc6pjOnkN7h8SoG7Dc+Lo6+RmmXDjoly92S9koxyvIgCPY64XDvsXINyWfG1XUQLQJrAQYpPtF16gdcoIFqUbOso/GXVhm1JQin8k87eLlSXrXce5fdOF/k7JUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGlwjnDZMQmIN0qEig31AJ8qrAQIx0jqZQyuFreCfCQ=;
 b=obwljhE+EvEBXfcy5lCDb8zcf4Gy9nMYHA1Lhqxq1igVkRRDRQwOGEcbhSPXiH/2P459TPBSxb6zkUfvcq41sy9D3K/rwvOKAiLrMcSBPZoW9M+XoF5O6hNtYRg8Iszyah/f8jfxK/LG2/9rpHIo/cCgqW6nsEdGMDOrJ8i50Dc=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Thu, 26 Feb
 2026 12:25:19 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::7) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 12:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 12:25:18 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:25:17 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:25:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:25:17 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QCP8Re2348372;
 Thu, 26 Feb 2026 06:25:15 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [RESEND PATCH v2 2/2] doc: board: ti: Add support for config fragment
 builds
Date: Thu, 26 Feb 2026 17:55:08 +0530
Message-ID: <20260226122508.2269682-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226122508.2269682-1-n-francis@ti.com>
References: <20260226122508.2269682-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d5fa66-a1c3-4800-a68e-08de75321a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: nOnzbLyHQ//EcEWj4KTOp+WrYd66fOryvgAwbsb/0igg3nNvkqcNUsXRgP1R2AwvjdhXhhANRQiZFZrcV8htFtVPrnVcANcv1Vl9fYJAKDyuJH/SEL2nItHlRqPBj0SOhOe5qWz4UrG7DJihfgbd8Ek0eDxFmCy9lxiYxO3kYQB3yAa71Phl/XpX3G4N+vf6va/ZvJ1YTluSbgqdfrN2tvweBvPIJDtCDbvTiNU+XiVgCi5gN9W3HCdIGCEnY5Z1zg3nPRqLkns2bjumYfjqXKwSox0VglRcgCzJ5F5Z4HTISdWPZKCi7CLsN7s1kGVBmClJ9/TDlg+/2og4l6bvJkCdQmxWR3jija7RQWE8+UeterkXTGr0K5A9VPXZk5IbSUW9xcpdC7r2eulIbN6AMETxxxtejhNjlwLAYsH7oStXK9EDmrxs8OIKLJjjfD/ngLYpiwRwDG+Adwoj0RmsgK2+H89UWuesxTwTnlbQsH7RExFBJXX/z3cn7870CBj44vKxAG9VBB0QQI5wm8APHR9nT3ag+Q97dulmt5XTQAW6NMgIXWWecRQfzIl0bv3100/apxgCZ8+mdsjwg6obU7L8H9CI1J6XCZbvp0X3k6JkSDNUt9GdWoTlVPg3EuseXgVSsysQ+OAgW1Q55OeXbgtjEJCdVCnQevhWsM+CnpG7aXOCEW9kENmEQtahJDlDejoPfmfJNnH0s20KmjayYTHohXw+ahNAP0+1xiAE83LvhdVPJ72dHyiE2xJDdk9p1U5ctZIiW2D/Cy32HtQSzwTt26P/N/Gtbyo5CHInB7e0JXP1vd501kEQ0EfQl+t0Fuir5Zwx+oN8OlCiOAlowQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q6vCsGfzrLzZfIZ/clpXPw9uxt4StFwMuP+nuUZuUvEDYk9PMxH0hYC1MCIvIqk1FZFNc0gmujQWBv4ToUej0thge3ksC58qju3dbm4b0afyZuLT6FdrNkqlcGv6TsDEH4NTH2jXexm/kO1cD+1lweyWrrvNunhYGxBmySjsjge4DxHjnMYLoCs96KSu6F4bHsuMwb9lPc/ooUPy4GvmuA+CcR3I1ppdFjSQS/AUDSdvYWTx///A6nfHf9v0anpVEteuOjpDFPIemyJKZynBO6oBDI4Rjj70hDI9GYWo3nw3BieOEZOoDrpIisR0TG2/4K/TEhKZvzU303TeVHU53YNPWadqmVtlV0KaZd0/kMIvGnFpr8O1xLz2EpfAwNzCE9CAe4tD1K3ktkJ/EkFvIK5FZmjIk/z9wwZxzm0AyUKkHTzNqGH9q9xFjjNlBBN9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:25:18.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d5fa66-a1c3-4800-a68e-08de75321a54
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
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

Add sections dedicated to explaining how BIST and inline ECC can be
enabled via the config fragments.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
New patch since v1

 doc/board/ti/k3.rst | 66 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index ed04a57c167..74ece0c9acf 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -678,6 +678,72 @@ filesystem and then imported
   fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
   env import -t ${loadaddr} ${filesize}
 
+Built-in Self-Test (BIST)
+--------------------------
+
+Built-in Self-test (BIST) is a feature that allows self testing of the memory
+areas and logic circuitry in an Integrated Circuit (IC) without any external
+test equipment. In an embedded system, these tests are typically used during
+boot time or shutdown of the system to check the health of an SoC. PBIST is used
+to test the memory regions in the SoC and provides detection for permanent
+faults. The primary use case for PBIST is when it is invoked at start-up
+providing valuable information on any stuck-at bits in the memory. LBIST is used
+to test the logic circuitry in an SoC associated with the CPU cores. There are
+multiple LBIST instances in the SoC, and each has a different processor core
+associated with it. There are LBIST tests that can be software-initiated.
+
+Current implementation triggers the BIST tests on the MAIN_R5_2_x cores and is
+supported only on J784S4-EVM.
+
+LBIST/PBIST checks of the WKUP_DMSC0 and MCU_R5FSS0 cores and memories are run
+in the WKUP/MCU domain; this check is part of HW POST. HW POST runs in hardware,
+before the ROM code starts and can be selected by MCU_BOOTMODE[09:08] pins.
+
+Enable BIST in (:ref:`A72 SPL build <k3_rst_include_start_build_steps_uboot>`)
+by including its config fragment.
+
+.. prompt:: bash $
+
+  make $UBOOT_CFG_CORTEXA k3_bist.config
+
+K3 DDR Subsystem (DDRSS) with Inline ECC
+----------------------------------------
+
+For SDRAM data integrity, the DDRSS bridge supports inline ECC on the data
+written to or read from the SDRAM. ECC is stored together with the data so that
+a dedicated SDRAM device for ECC is not required. The 8-bit single error
+correction double error detection (SECDED) ECC data is calculated over 64-bit
+data quanta. For every 256-byte data block 32 bytes of ECC is stored inline.
+Thus, 1/9th of the total SDRAM space is used for ECC storage and the remaining
+8/9th of the SDRAM data space are seen as consecutive byte addresses. Even if
+there are non-ECC protected regions the previously described 1/9th-8/9th rule
+still applies and consecutive byte addresses are seen from system point of view.
+
+ECC is calculated for all accesses that are within the address ranges protected
+by it. 1-bit error is correctable by ECC, but multi-bit and multiple 1-bit
+errors are not correctable and will be treated as an uncorrectable error. Any
+uncorrectable error will cause a bus abort.
+
+Enable inline ECC in (:ref:`R5 SPL build <k3_rst_include_start_build_steps_spl_r5>`)
+by including its config fragment:
+
+.. prompt:: bash $
+
+  make $UBOOT_CFG_CORTEXR k3_inline_ecc.config
+
+This enables inline ECC for the entire region. Instead of defaulting for the
+entire DDR region, a partial range can also be selected. In this case, the DDRSS
+driver expects such a node within the memory node, in the absence of which it
+resorts to enabling for the entire DDR region:
+
+.. code-block:: dts
+
+  inline_ecc: protected@9e780000 {
+    device_type = "ecc";
+    reg = <0x9e780000 0x0080000>;
+    bootph-all;
+  };
+
 .. _k3_rst_refer_openocd:
 
 Common Debugging environment - OpenOCD
-- 
2.34.1

