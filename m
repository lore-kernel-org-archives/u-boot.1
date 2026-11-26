Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BABB606A6A1
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zU3A6xi/;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Geik5mEN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E5BA608C9;
	Thu, 26 Nov 2026 10:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GgzOTuOWfOG2; Thu, 26 Nov 2026 10:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50F406069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795688968;
	b=SP+B2FJAiUC6zaUtCVKrgpu7CBsP0FS9OhlHTyABixhoySMQKwBmdwre88LJYvCf6Mt2
	 2ItjGR/aJ8wcqCdkJ4RXJImQAtblu2eENz/8jMruvezwh7AZrJk22aleFWQrsMB5HPJdl
	 qiY/UZTTlBlrKMIXMSDgsyzNuOzoOFjXbm0qsXs3GMgJG2xmARYGpp6U1KU6ZUs9CabQu
	 MgITBiry2DyRHPFx4JoknlIwCRga4Vnzmw1SpQxDaA1nHWiccEAa9uubFF1FKIsLhjEZy
	 y2e9j7iQTAPTiKAo17Vnscppk9+LRK8YGdUKZgmdMvAcfk5cUpdladgLQG5YW9l0o9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795688968;
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
	bh=1UYoGTYWI9GsEo6eMpm3fTet3ZCpVNIbBcCa2S0/xNE=;
	b=K5qbv5r6aDUeCDyRM6guW/f80ms7lI9xhkBxK2j1BWpgYepDu/Dp8/chDf3GxvlIli6M
	 0XG/+0R3ncrreVnm/hzOaGloOLAhxSD9d4B/dErQTDJ9QLlUIp7CcYf64xB1scZyzZWwE
	 11YEEKNPflnkbu9AuIAu63qcwHtrmkYd3OIK7cDoLYOCWdIugAYshgveNBJPntr3g9shY
	 xd8zQTdWRVjoc8lYDqk9t9d94WIQy+jtbGORQKN8LGscH7jnKLETU2uz/H4RG0j84MKF/
	 9kjxvCNIDue/JYJmVvEa8LhDG59/+FORRVwnRHFl0TKDFf/elHBszMhbq8YYg7GsxWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795688968;
	bh=1UYoGTYWI9GsEo6eMpm3fTet3ZCpVNIbBcCa2S0/xNE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zU3A6xi/In8fy7u+J6crEJwI87YQ/s33K0OmTkBnRPyYC7f9mPTldehtxz3d6z6Pp
	 lYOMqzQkYpNjnGnx0rPVd7eZYGPEhsrnk0likS+/s/Dot31eZkUSDzkxqm7qqX2w44
	 TXDSnkwzuKxSdc8reS55kSMU8x85hzci5PIgoAZRb2pGt03VROf8yujzIGZCqDSmxq
	 splACvj/IHfGFuIuK4FnMXGf67MinUm6rGorR7b+KCMyeiyXcZaHdWGts9LWBa2Rgp
	 LaIWnA/q9eAQdbg83jFDHNHXKFFA6VrihLbv1NBrb7qhLeXV5f9ssGLkLTYxobik66
	 hG4AxpDTmXb0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50F406069A;
	Thu, 26 Nov 2026 10:29:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB47743
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CFC2400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APE7lqTN64cL for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:29:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DFF88400B5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Geik5mEN
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFF88400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UYoGTYWI9GsEo6eMpm3fTet3ZCpVNIbBcCa2S0/xNE=;
 b=Geik5mENAJDPYXLsl595O8bMqdGEAjwEE5RKrBMrLxsFAkZfuT18odTTbEsLsWE/AFYhb965WsCmylv1MrPc2xnuD1buhxgz9Ch0jWm5OdnKmOAHVUxxolqo/Zy7C1i3JGx2fEcpOwFvQe1sezDEqoAkmPUg4OTFmNF+toVs2U4=
Received: from BN0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:e7::32)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:29:21 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::3d) by BN0PR03CA0057.outlook.office365.com
 (2603:10b6:408:e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 10:29:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 10:29:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 04:29:19 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 04:29:17 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tim Ouyang
 <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, Yao Zi
 <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] riscv: dts: mbv: Add BRAM device node
Date: Thu, 26 Nov 2026 15:58:31 +0530
Message-ID: <20261126102900.263559-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126102900.263559-1-padmarao.begari@amd.com>
References: <20261126102900.263559-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e75a01-3579-4da5-d09d-08df4ba821ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009223027099003|10067099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F6vx3HbpnkqrKu4dwcbP2d4X1nM8lBXUP8TInKXFfudibpYDXdCc5ONTstkuhGd1SzdxZYzdFDlLZbohygHmH4LC4jBL+3MvBNFTUvDnglZc43/vzh11TOdgXpfGnXAduEzitW6QdJXZqhiGmu3O3tp9hWl7vtsFfEeoE/iVL1x0izmwOgyZjE3sau0e9ahFmlHGcdQ5kftFsA4+Tplko3DJEZCw0xK37kmLzjLOI+AWeZeFdfl7JeXAX3R5Gbdoge0sX3tuR0qCfP9QdgrwRMiufYh8LG2ImhgRX+QMBeMSPpbOMYM9lFSbjGhkwsFpjSRcaYDXx7vacPFg1sHRyQ6uBGxky00v+ne8M0qLWMFDqtTIldrH2ztJTHBRhP+DALvtXWPBYRItq2zonXv6AK70MajLodkauoci9+eoakL6uobis1nPt2mTbkMC23k8SUKnGBU7H42DkwOSSH/d8S4bXMDKBxvmpoMIWhgzCvGg0C0qQuaCHgdBnvAbskoA46O5gZehIn+Z0ogOxDRhvu+LpTWsbmzkG6SamhC+ynR+kDWz3Os9ljvdfkO1DsrlRcGpkBGYqK+mE7h81w9slGAC0lA8/b7vgvhEkSYv4LYI4eEOsaObkqgjgUdhW6Nfl5IsGxdWeeH0qVuraozlTVlTLpMSBRVxTqbGhDlDwm4sCyqOZFGeE+O0nRJpx5t2yuLUjJkgnaOdW9E+SvKV5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009223027099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: onXtl2Qjru5pUSMJEhrbvGtbpmd1qnFpxeGTcTAAquL+qk1yLXzCFjdJleOMtHYrETgOaDVqubdrXBQYoxwNEBUd82bH2orrNnSQR2sQTOickcNRMgxFMcSE83oWE5CPWmfH+VLWbLvkxMSOkkD0J0hfZ3qMlDAQqRMVj8tJrB3Ejg+9ZU3r3prhXmHHjVMWg4Plql28euyI8TakTDYHLcAmWoCYjbCywy1J13elDrIs4u/mrHWZbuK1gLWLvAIUvQBkqGUk8LdeIzsFYKCf0GCRznX7nP+OzBBe8jm87OTQJFU5dU0+J5lZWYpIfi6FFY3Mys13b6ELSLPtzB9QNll46RCCMezXyy3C7W/T8NYLjHyQz8B/zeH0mFB1VBRF+4InSVNUf3fIYe2bYbH8UgUVRnSPvdi1mHHhXZG7FjfJXVx6YfVPDc9wP4r7DNF4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:29:20.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e75a01-3579-4da5-d09d-08df4ba821ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MB-V platform includes the LMB BRAM region at address 0x0 with
128KB size, and a corresponding BRAM device node is added.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---
 arch/riscv/dts/xilinx-mbv32.dts | 8 ++++++++
 arch/riscv/dts/xilinx-mbv64.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index f7a3e076fd5..82ae75f4aad 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -45,6 +45,14 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	bram0: sram@0 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x20000>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index 46950155bbe..204a993aa35 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -47,6 +47,14 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	bram0: sram@0 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x0 0x0 0x20000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0 0x20000>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0 0x80000000 0 0x80000000>;
-- 
2.34.1

