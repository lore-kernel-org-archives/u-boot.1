Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E15C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 04:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B57C760635;
	Mon, 24 Aug 2026 04:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KLAV9oNUxZHa; Mon, 24 Aug 2026 04:48:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787546891;
	bh=8X6wKZqOG1qd1g/yteFXzdI0LSbtfAk8p+PEn7lAmdA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s6Pmid0ZZYs6qiuZvG+IvZPPQpWLwAyv1kqMwq9y/dcEljdnmVEVAsNcpEGZK/cMv
	 hqy5FTBlg+47w3Cw8s8DG2j5eMTXvQugG20x6dwvvZM7ttToC5PacTCxP/sOylZ0g8
	 LTdNTW5ffY2cOnuxPPTzxaD3c+niYps07oNnVSr5WSdVpvbrCZGPykrgzod06iKBax
	 pWww7XQQdaZEUIOK+FBkWQFajTChPmbHqqscm2k1QDi5Sdk/QQyyr7EAG3Pm5bAanb
	 4NXqQV2QmDF34iPuVBe11jNNhi0Owpl7X/QtGnMryGTtyCIsJQPVP3iuU61ELbjLca
	 XqYz79HDsgtZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 415D560619;
	Mon, 24 Aug 2026 04:48:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 106833AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9BDD60622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLisp4MP-JBu for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 04:48:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SRp0BNLh
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 017A560619
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZP7tlNm/vRZrlTN+HY40OQXXf82aHIB6U3tU5HST79HTGVP0bPqbgTPF/OlitsWj3njFXFZPdvYyPCjKzp4+OpIz5EsI7zcfrZQwb7o30/FmgPLwdhXULlYY1skyxrFDTfGeBy229CQzX5jVIfZ4MlYutRJUI5PHju1LnWs5Cw7ZDb4/mqs4dMNrvekSoDFORsuo+0UTaQ2OPS57D2XXiHsaCIz92nHXTnf19DHI3zAyZLSkdTJaYA9gBc/EvYWyp+MAq9fbXRt3YFGSdQCDSX7VBz66ReyOa+Jz6d0aJuV57wdujR4Gd5TrIRYBjAEQHGsS5p1l0wZQQOIL//W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X6wKZqOG1qd1g/yteFXzdI0LSbtfAk8p+PEn7lAmdA=;
 b=rSsAkUkr1QC32xNVAYoN6Wv17xT+JQg+Dd3OI3YWbLfYKQ72mUmXSUSpkJGZbws2qGlsQVURkxP5h2zRCPygGAgbWR3fPSfpKc5MdDF+4J9XAShEiQXEUuBnh8qpBWYmRL8HdPi0Daql1p90cjx9KULHkvvsjgpFMKFax9/z2cBH/zSkH/bKEQPajyug4xjrhcudrHmvz4K10C6RjDoWY+JdgCYqkMkLapTjo79tuIVoyMlEw812D1l+w4d+HBRMJM4TN/9g1zli6J+9/gxVsMpLJg7Q0rGKrLtteQxAjWR3hK4A6pN7D3f+Te+wlTa1xgXFsPWTthBG0bIFZBTugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X6wKZqOG1qd1g/yteFXzdI0LSbtfAk8p+PEn7lAmdA=;
 b=SRp0BNLhc6e+QhuHEsMp7JBkPPhPtw1qga8NFoPAVfq7SmXv52DQZ1q0DE2ntd+jiDbbuQS2pCNowoTzBSyxN6svGv+Y4QR1bA8YuBlVa9CkR/7ntmPheRpxNIO8LQyzTN0lbQzemZmCxR0NyDeK5Hz0L44234CdW9AgppyL1Cs=
Received: from BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 04:48:04 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::11) by BL1PR13CA0347.outlook.office365.com
 (2603:10b6:208:2c6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 04:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 04:48:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 23:48:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 23:48:02 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 23:47:59 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>, "Jonathan
 Humphreys" <j-humphreys@ti.com>
Subject: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Date: Mon, 24 Aug 2026 10:17:18 +0530
Message-ID: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: f3873bd0-5540-4e08-7810-08df019ae1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8lPUgbYMN3YC5Nu2nmglVzmETYsX4VL2B7CMojFKeAqsaTnHq7tSpTTRdQ7MS61mXDwRJ8rl0UCoRJ+Ik0Q/TRtJWAGuzfD532tUJDmY6PEhK1VChfOcrhNB7teVS6v0/VsORdNW8MkXqiXBk4J5lTrSNpag4ZU/WHTRo4l/HWQeXpGtbyAHLBn3gQG3wv4EuEJcFF8VmzEp5/VJDYRMsqMCctBWFr3Fymy1jRo2+f9AETWWHkyHSF7noKqkoyh8LwKQyFoUurLCFvAK/Kgei2HxHe5Bagi2sFgDXviQWK4YpFN03q468m4y0/onPVZcSnWOeaBSqOzCQwCRYcCjuE0WkMC4JU0GzMWpnfHPAvfmXA6td6xuEDhnwWeJUtVn7q5KwvHIEHanNwrzJpZdU2JUEYfEhXlwDjITdiXaoV9fFLwL+4wSNhvWyYcKpZWkRwpxwweZCukBUYYx7oC156xFu/t5qSZlWzBKA7QzijSYdmA/M0isMiZS9zN9H3vAuOQNGJ8fk7UcHudjxeHb0wqayZPzoBmCNvLyjjGYHFN9CdY0wG6CFZBzvo8Au0fCcetHFVJWN7gBATiLcx0sWCkPbX9y1JKY3LKiUljZUOke7G0ObouImhQ6dUUA2VKtcBKR7FwvXb2aeqeuCPqNn116u5ksfGwSBxAYUFSl5LGnxjZX/ozn/q7D6tNSLikutDDE/L2pruLo3BHRiZ+OQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A0fqU84Yqt9x7JsCVJU/IVFEzhLG+ptU1rxXtlKk2paLdNwAKXb+/Wmcvyz6A2mlZGps8x2oBFP7bpSvz03y3QRinLG37FjF2UmDSBiNIljSvuc97R/BkOAOezUlVN9i6c6H6Q5/SK62dPIReZIYr+nZF+VNfD18VEmkvMWN0ReYZKGSC+X9YKJtCt14lJ34059Ac9UeGgcDm7/JH/xStL7ls+CW+Cq4sZG/mOZwYOwxGm2MddDrz+gqwz9NGHX2wEJ3uKGx0N4MtpB9pbV+fvWVgnHEPHugO02987xLtojfUv6U7ynRckjTm5lbV0ajGc5CrEBatP05vjDTdINoc1JltlGPwT5+23QeAt3XHigdNpbdXAt1zhpqFaSLZY9TEOt+cNJa5zVqwtRFibz5TQrUpS2qaSQHEm+ELTX11XBhWCkAQ0uYhyDFDH6JAmnd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 04:48:03.2789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3873bd0-5540-4e08-7810-08df019ae1b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
path) in the HOSTCC command. With a long $(srctree) that command is
too large for /bin/sh -c and Make fails with "Argument list too
long" while building a .dtb.

Write the flags to a per-target .dtc.flags.tmp file and pass @file to
HOSTCC/CPP so the shell command stays short.

This change requires GNU Make >= 4.0, since $(file ...) is not
supported by Make 3.x.

Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 scripts/Makefile.lib | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 24b1a581790..6066abed199 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -448,7 +448,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
-	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
+	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
+	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
@@ -477,6 +478,7 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FOR
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
+dtc-flags-tmp = $(subst $(comma),_,$(dot-target).dtc.flags.tmp)
 
 # DTCO
 # ---------------------------------------------------------------------------
@@ -486,7 +488,8 @@ quiet_cmd_dtco = DTCO    $@
 # No generation of assembly file either
 # Modified for U-Boot
 cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags)) \
+	$(CPP) @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -@ -O dtb -o $@ -b 0 \
 		-i $(dir $<) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
-- 
2.43.7

