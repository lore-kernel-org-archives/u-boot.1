Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111A606A6AE
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bt1jemC2;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f/2QudOS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8151608E9;
	Thu, 26 Nov 2026 10:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYivSruhqNsx; Thu, 26 Nov 2026 10:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 036AD608C5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795688978;
	b=VOfJ4uJAtqsV3KawpobInYFFrd0ILpzvEcl/s2NXKmK4aBEvChbHVc70ZtFND2FTACjU
	 4m1nTheXV1xdZezh4+mV2P7N94oP4058PUXhfHV5QdrIfDImyu7cRwVFEPsKbc1tyHWv2
	 /7x7/yEVjrcozYHYeU4OA7BBtAgTtl96OCBytg3cuz5N89RRo1QvS0S8/ibw4lZcsyfov
	 KSoP05xhEW/CmmJAobs/2aXZ2aH+xC2LpaLgSF/krjSDaV0vjYxogyJE0DKEDImNdIoTS
	 pc0ZaaOHiM8cW6DqxuGgPfDedi+jM4AW6d70R0MOzbdtopvYQ4r76w9O93EHydfDAkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795688978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jipvb4QuuE0BvcqhGg7T7kD7q6Pebtb5rhjlj41JYe4=;
	b=LG69swdxg9ERJAt5OmRVfTvSIfBL4ru6AaGT3evvH1pL1K2Ncin2FElmx5nem3IzPhpl
	 JAD3h5Gws9K9ZjwZch398rrDUSjj+Mhyz6d6o54+2z0wKow785lXbgCFr3NUC5c92ovHm
	 pxNULWJEAQ/nTY5kQiNKhjdK12IwBk/tkSg99EQva1y3N4//bI9actVK6d8FCKnntwrd1
	 /E2tl6xj0n/QnvxYOcGJpmZ3u+QprTSDThzEDej4GDlu8eTiWPmITNscVsNf6my+HFEuR
	 1bBvtvqmAf6k+pX6lIhkGV+sCsIW2ovWJTpSu9VOohoxI0WZRMfWrcSqs1c64iYchhQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="f/2QudOS";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795688978;
	bh=jipvb4QuuE0BvcqhGg7T7kD7q6Pebtb5rhjlj41JYe4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bt1jemC2nGYtYSi8MzqPbJ5DqKwLJSynFoLlbkmT4XWOxMj9iabl3K3PchoqVBDs4
	 JH6wI9i9dki1xJA08R8erL2nfvSpL+Fbx3yKN/vAFS6iCk1Bzdt/HFI9gJ58ab7vUX
	 7JNekSTqyQuie8EENH0vgzfZbpDxfQQmTjCFYWSvjf0U7IAjoZg5ZI/79pIPZ+rSDH
	 l5BzhteW7dGG++0a8lhxobJ70/JWUudzakfhFT4KdhPDulD6xnj/KvxyqUORU+Gnv7
	 MQpldDXabpyJEBBCwYdzHEJiX68xb5EWtWPhoib289cuGv5giuPc1O4YqdYauB29pz
	 nsoOt2W5nGhOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 036AD608C5;
	Thu, 26 Nov 2026 10:29:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4F3C43
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D64866069A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzJB6lJUMCMI for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:29:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 762EF608C5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=f/2QudOS
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 762EF608C5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jipvb4QuuE0BvcqhGg7T7kD7q6Pebtb5rhjlj41JYe4=;
 b=f/2QudOSd97U0EcqDkXwiUqkW4oadsrjGoxLpDlEoaywoJs9z5HqetLBY3wHgcYRCAB3ZESKuzTpLlh3uAFsH5rWzTjCErBPXvB9u++3ZGSWctbgcVsKz8bA/AJA3l5B37bg7wCKFr4Eyx2yvf1GdrK4o+fbpJgN1yApNkn+YHE=
Received: from BN9PR03CA0110.namprd03.prod.outlook.com (2603:10b6:408:fd::25)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:29:27 +0000
Received: from BN3PEPF00022BCD.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::6b) by BN9PR03CA0110.outlook.office365.com
 (2603:10b6:408:fd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Thu, 26
 Nov 2026 10:29:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BCD.mail.protection.outlook.com (10.167.248.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 10:29:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 04:29:24 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 04:29:22 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tim Ouyang
 <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, Yao Zi
 <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] riscv: dts: mbv: Add device node for ethernets
Date: Thu, 26 Nov 2026 15:58:32 +0530
Message-ID: <20261126102900.263559-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126102900.263559-1-padmarao.begari@amd.com>
References: <20261126102900.263559-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCD:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b70d5a-9cf8-45de-d547-08df4ba824d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|11063799006|261021123027099003|56012099006|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uGSgZtz1pGlOBXhwjjzW4WQOZCXgrfcn6rPy40Jlj/+fK+nroGdgjqITQXv0FQJ9tw8DpXj+n+Na8RsVuuPWWJVNyOIS9wp2eYO7vEQVVEfGDR0cYryb4/UYynbqobX1Jfc488jMZ23NFTreXByhOxA3KPwSxzDn/fx40PjdRBXeaWEyzhpg1+MOPkKUV+FqAZ2LJHMxOtAk+D4RXfUK5RbZXEDoPrAvxdNHj5Luxr/JaR07yl4lN+pZ1EqqxnbHobxlXYXFK1PtCooaJ9RTKHDTXDXt3zZ5uUyGNNG7sdIodet+/yHfy0TAOEzsbv16AZkXpQUY6/rpNssKZwLPHPoBOQqDNAMHPj0zpzxL1AWf88JpnhUOpsiY5rmwweLbPt5ezvRqd8nylj4uLzqELrHoFDtqZdGI5LINkESDc/GVeuq7O685JHi8Dm09/+kk8Sc9fNqC8VhRZdawXGaf9ADWEST55lz5BQ+2YEyi7319sGJ1SpwjjWIZ7lZ6/pwDqHaFp9q3oV1vh1nwQ5yzI1Adf2tngNKAtJd7Y1HwoVsdzUuo7cLl8hHTzZodHiK10y2EoqECRLBzydoNkSXdK7VxR94epAXN1DHc5wGH76g8TucbdFKSyblB3Mhv/osFQAHbJ1ZE1LntOTim+iDsMrL7AqGKUW7LWL5lAq2C4ZGP2lrFsFmLcPfMBaahUEtjS8SeA9TAe0odphfei0c3+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vt6KRu4F4uWNOqPvY9wOstRXjcIEVq5Jdg/kCkL9lrBSGBgmZ9E87HaGIgAgtXPjIU4STvVK6b7rPUHAsF9ObQ+GAaRb6eFKoR+WdxVEKmowzeOXBkBkjNRDAjApyy/e1GUEUmYB2gQGGGhvZv8CbW39tAC0hSQ73ovQGK13oFXQ4Y73D9ZiNSMhgADiXL16yFvxtRGYryogLk1NMJBFSd9ZB2L4idl2sKJnPRAN0eF+C3iAV0S7wqstcdzc+vXlN9Z4o9crwMfcvEd2Jd98ZGfLCbgaoEK8Pt/yCzvm6hzqSsJdw5lqLQxntrZvZsp+B+sdePB0WxshXZfixsSMwXmSesly6jnHJKsfLVi2kT8ZskqZYKirz6AqsaCeAHeKPp9h6YkZ8aKkH5qpEtrcGjSUcKJAyj9joWpfWu4Tb5QZFIFi8YPD+7yfM4MlJrs4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:29:25.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b70d5a-9cf8-45de-d547-08df4ba824d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add device tree nodes for Ethernets on MB-V platform already modeled in
QEMU.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---
 arch/riscv/dts/xilinx-mbv32.dts | 55 +++++++++++++++++++++++++++++++++
 arch/riscv/dts/xilinx-mbv64.dts | 55 +++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index 82ae75f4aad..1fc01e02470 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -103,5 +103,60 @@
 			xlnx,data-bits = <8>;
 			xlnx,use-parity = <0>;
 		};
+
+		eth: ethernet@40e00000 {
+			compatible = "xlnx,xps-ethernetlite-1.00.a";
+			reg = <0x40e00000 0x10000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <5 0>;
+			clocks = <&clk100>;
+			xlnx,rx-ping-pong = <0>;
+			xlnx,tx-ping-pong = <0>;
+			phy-handle = <&phy0>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				phy0: phy@7 {
+					device_type = "ethernet-phy";
+					reg = <7>;
+				};
+			};
+		};
+
+		enet: ethernet@40c00000 {
+			compatible = "xlnx,axi-ethernet-1.00.a";
+			reg = <0x40c00000 0x40000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <7 2>;
+			clocks = <&clk100>, <&clk100>;
+			phy-mode = "rgmii";
+			xlnx,rxcsum = <0>;
+			xlnx,rxmem = <0x1000>;
+			xlnx,txcsum = <0>;
+			phy-handle = <&phy>;
+			axistream-connected = <&axi_dma>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				phy: phy@7 {
+					device_type = "ethernet-phy";
+					reg = <7>;
+				};
+			};
+		};
+
+		axi_dma: dma@41e00000 {
+			#dma-cells = <1>;
+			axistream-connected = <&enet>;
+			reg = <0x41e00000 0x10000>;
+			clock-frequency = <100000000>;
+			clock-names = "s_axi_lite_aclk";
+			clocks = <&clk100>;
+			interrupt-names = "mm2s_introut", "s2mm_introut";
+			interrupt-parent = <&axi_intc>;
+			interrupts = <8 2 9 2>;
+		};
 	};
 };
diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index 204a993aa35..f9b2dea64fe 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -105,5 +105,60 @@
 			xlnx,data-bits = <8>;
 			xlnx,use-parity = <0>;
 		};
+
+		eth: ethernet@40e00000 {
+			compatible = "xlnx,xps-ethernetlite-1.00.a";
+			reg = <0x0 0x40e00000 0x0 0x10000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <5 0>;
+			clocks = <&clk100>;
+			xlnx,rx-ping-pong = <0>;
+			xlnx,tx-ping-pong = <0>;
+			phy-handle = <&phy0>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				phy0: phy@7 {
+					device_type = "ethernet-phy";
+					reg = <7>;
+				};
+			};
+		};
+
+		enet: ethernet@40c00000 {
+			compatible = "xlnx,axi-ethernet-1.00.a";
+			reg = <0x0 0x40c00000 0x0 0x40000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <7 2>;
+			clocks = <&clk100>, <&clk100>;
+			phy-mode = "rgmii";
+			xlnx,rxcsum = <0>;
+			xlnx,rxmem = <0x1000>;
+			xlnx,txcsum = <0>;
+			phy-handle = <&phy>;
+			axistream-connected = <&axi_dma>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				phy: phy@7 {
+					device_type = "ethernet-phy";
+					reg = <7>;
+				};
+			};
+		};
+
+		axi_dma: dma@41e00000 {
+			#dma-cells = <1>;
+			axistream-connected = <&enet>;
+			reg = <0x0 0x41e00000 0x0 0x10000>;
+			clock-frequency = <100000000>;
+			clock-names = "s_axi_lite_aclk";
+			clocks = <&clk100>;
+			interrupt-names = "mm2s_introut", "s2mm_introut";
+			interrupt-parent = <&axi_intc>;
+			interrupts = <8 2 9 2>;
+		};
 	};
 };
-- 
2.34.1

