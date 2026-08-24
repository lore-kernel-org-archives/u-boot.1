Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF17C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CDBE60632;
	Mon, 24 Aug 2026 07:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpKxL4m0Bq8J; Mon, 24 Aug 2026 07:34:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556879;
	bh=NqZH29v2sHPo5kFoYfK8u7R+Uye7mfAK8a9V58sHsbA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AQkmTHVHmEoS6SMkNOz9wrIgB0NxY4vDFpSzXMLwE0U7vUjlqR3Bu63KHVylq6Luh
	 vif+Hwn6YH18jFo8Et2eDj85mLZmwK5ecs3uRABTs1vSANNn4uGtmgrPwp/LXSdAjB
	 yb2UF3FKW3+qMRp1R7r2sGPlNVnUy+X/YOF1Whs7mPxFwtwqyabguobs2/Pf+I/mUp
	 DO2X5F+Nkl4ToF8mwP5Jl34EvNVNPGjeQjWDlTPE4lC7yqtV5jTa4GI0PrOXvTprfw
	 xPoA+IW5Us9OTHwtv5Y0ZA8oFMGZLlIlXmfuZg3shki5+FFkd3BmIuehNUL41pJdHA
	 P8RruU6u2owBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BA1B605F5;
	Mon, 24 Aug 2026 07:34:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C03FC41A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B231280CB9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeChOhzywfyy for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:34:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=q0F6AwWk
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9A8D80C84
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5VJp6K8R+fcK0dJxbhF1qsmCQ96FY3Iwxx2IITsugXKIXV/DPzSHcERu177BwdfV9rm4K/ByXUYCFsV92nrqC2peqXueApcFFTRt9EjUi17Sal+V/Re+j3mB+Js9IbjHH929iZ8a9hsC63rgPG8JwYMNDWhkc7iM/MGJF63/DySj6t1INJL3c66Xm6TXt8ivcGzLPgCwEDQL3WUHHqZj0dyn5D8ukrKR6DUPZi4+znEqMTazG9vWamDGFTnldB/TPBNHw4zZQfCrmQWBntB3lOVVMy4WEAOgvqSh9UkA+IRAFb1NH6PFl8rdrN8tdgKNvnoZQGsn09fr+56MTETug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqZH29v2sHPo5kFoYfK8u7R+Uye7mfAK8a9V58sHsbA=;
 b=s/2CXzBDmVUPY4MfIXjGXkotFf6GtX7ds6e0Oph16bN+1cTMS7UDm3Dttjrw4WTAVxbtCZzoa1S1aLAgRryH1HPmhx4cJqBu6Aad7XtON1jZHld/tzDEf+kpClyJ//qzCWK2uMnl6PiyyMpyM5zEuHUV9iKg4Hrg0l4d8gaPLRcYGsWWQUH/lNswsWa10FKPANywR6N6oa8OWkKLdM8aZO+kXKEDgQ4J9Gz4d9fhlpGy2ilIOSoNYTahpDhABBmlN94kSw+nHK4qUXY9/5sV+WdryrF3vers6+H+HHb+hUHf+DqM6ShMkBwbIvBE1rxO3oiRzyNSD68e7WeWJ6rVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqZH29v2sHPo5kFoYfK8u7R+Uye7mfAK8a9V58sHsbA=;
 b=q0F6AwWkEgVPT//7Puuav1A0SLBsp5heNoXhW0KjRKyiIPXEVb7VJvp4yEkR42Oe+yqW12uqDMLpJvRwSiVy/AKsAxtro0qbTPjCLeAMGCA5F/6x4ibr6rpB2Uw+bPXg/5JhM/WTAM/3IQM2tmiNJDWqHuTF0S9oA8nJMuBz+cU=
Received: from DS3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::9) by
 DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 07:34:31 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:8:45f:cafe::89) by DS3P220CA0005.outlook.office365.com
 (2603:10b6:8:45f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:34:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:34:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:34:16 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:34:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: Move u-boot-microblaze to u-boot-amd
Date: Mon, 24 Aug 2026 09:34:08 +0200
Message-ID: <0284af854ed280d87d0d083cb7a2c62b358dda6d.1787556846.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=v2SZu6Sb/Is7hOVxNmzv7UMmYg78AYawC/1hEwdwzS4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR1f/5m+3lO5crwB6WOPgskPscqs8tula8vuT4j3V288
 uEZhQ2iHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRGQKMDLfnvA1a8Pn65bNW
 jjcPfC1UvCEU8+eB5iI/iYMFN9wffpnPyDB1BUeryvvH0x09/1+ZfU5oamGvWDq3lXGrwI97pQt
 XfGMEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c7ad13-913f-4350-c1f2-08df01b2228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: xDb+oDee1YGFQv6jIdxJmH3mSeiu+cMGaEpt9pLfEqyNGgiH8/woIlR+5S4HBjGJ2RHL8R1oGypiVo1tOTmxqCedEu01hnSPlB7/Zj/qqT9sx0M06CKFVgVXo9yFVyFZiobu9w7LpQPi+lbAoP3vi29dw7HS14brjvL4W7FUCjifh7yrKjeVw0Ynx/lo1aSsniaG0yVHg3xshtMfec0gXbWJAUz9s7hdtLgLXTFsYEwhB62yJr1uANV7JdG/R810MiZ1SUcrxkD+R88nQxA9OT0qDXQ9fo8sNfy3LJ3z8Eug3Rhpvbrd/NAH6TDivyZ5GDi1bO/cSxu4ObMhclUmopkQzAfUgI/l+FOqCqZqyXNVEbRkW/UgBMBrmF5cCA41jAwCJ9vXlK2JY6e+3WEXv2/y5lmPdz2yytuu7LLBhUIORbEDKaBhTC9kcWlni369SKWueEQJJWKN8kMif/zL+s6BUMxRV1c4kB50OXSEJuWrjFK4uvnNzRDJ1C+EAOWRFjIkBEg2cr1eT/rAWcTxASUiXlgUDCztL8agxW0CR/5tDSjafTJWV8+GRB9lbAnFV4tYsFRrafVx1CVxeF68Ng8qI476w0hifPTOu+0+5cywnz0qP0qQvGsgYH+UxtEt8OCUnM5W4IrHUHRFPOU/5beEH7VSqpFFAqKXi0FMA6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TdHZCbfztJ8FHDpHfxGSskS6m8Vv94wDISDOfvEjy3zhM1jG18uhR4JHxWB07C472lu2uMqHJcxWFgllnEe5E5i1tP1RkPYUFxyCi3ny46VZJ2TFpIaD4DqB4+IxzOsZv8Duhf+BNFWev8tWFvDNov1X3CKfMVPrakqWIvWlxsQ4wqhvdYW7H+uTKP/kaj5atb6ZsgMKVUqobU4cB5IH6j/quJgPnCc8Z7HMEvVk6j4rAgQ8HIqFOs62taayn+B2uVoKJrpZAR+s5oVXp02tVOUXRyti0QxBkkiDl1OpvhD390k10EIXqyJKWpb66pRRSnBANf7ZWDGWWrGaxGGa29yS7M52lEa9/dEIBT+YgD+CRKCBrq0C5XiSF8JqDc1QBTMKftdDrvNkidIRu16qatuo4FJl6VK5q52B8kpY0gefF6IYnDMC+w6M/9HFPrHJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:34:30.5088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c7ad13-913f-4350-c1f2-08df01b2228d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
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

By moving to u-boot-project.org custodian tree has been also renamed to
reflect current situation around AMD/XILINX SOCs but links to repo haven't
been updated.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/amd/versal2/MAINTAINERS       | 2 +-
 board/xilinx/versal-net/MAINTAINERS | 2 +-
 board/xilinx/versal/MAINTAINERS     | 2 +-
 board/xilinx/zynq/MAINTAINERS       | 2 +-
 board/xilinx/zynqmp/MAINTAINERS     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/amd/versal2/MAINTAINERS b/board/amd/versal2/MAINTAINERS
index af7913d8db3a..282eaddd7532 100644
--- a/board/amd/versal2/MAINTAINERS
+++ b/board/amd/versal2/MAINTAINERS
@@ -1,7 +1,7 @@
 XILINX_VERSAL2 BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/dts/versal2*
 F:	board/amd/
 F:	configs/amd*
diff --git a/board/xilinx/versal-net/MAINTAINERS b/board/xilinx/versal-net/MAINTAINERS
index 50120a88d6e7..85d858ad3a01 100644
--- a/board/xilinx/versal-net/MAINTAINERS
+++ b/board/xilinx/versal-net/MAINTAINERS
@@ -1,7 +1,7 @@
 XILINX_VERSAL_NET BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/dts/versal-net*
 F:	board/xilinx/versal-net/
 F:	include/configs/xilinx_versal_net*
diff --git a/board/xilinx/versal/MAINTAINERS b/board/xilinx/versal/MAINTAINERS
index 07173ee916fd..00170a9cf665 100644
--- a/board/xilinx/versal/MAINTAINERS
+++ b/board/xilinx/versal/MAINTAINERS
@@ -1,7 +1,7 @@
 XILINX_VERSAL BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/dts/versal*
 F:	board/xilinx/versal/
 F:	include/configs/xilinx_versal*
diff --git a/board/xilinx/zynq/MAINTAINERS b/board/xilinx/zynq/MAINTAINERS
index 3eb1a451b580..d505a78ba667 100644
--- a/board/xilinx/zynq/MAINTAINERS
+++ b/board/xilinx/zynq/MAINTAINERS
@@ -1,7 +1,7 @@
 ZYNQ BOARD
 M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/dts/zynq-*
 F:	board/xilinx/zynq/
 F:	include/configs/zynq*.h
diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINTAINERS
index de753c8fe4e5..dd585bae790b 100644
--- a/board/xilinx/zynqmp/MAINTAINERS
+++ b/board/xilinx/zynqmp/MAINTAINERS
@@ -1,7 +1,7 @@
 XILINX_ZYNQMP BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/dts/zynqmp-*
 F:	arch/arm/dts/avnet-ultra96*
 F:	board/xilinx/common/
---

-- 
2.43.0

