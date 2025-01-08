Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61090E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBC28071F;
	Wed,  8 Jan 2025 16:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9+39AOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD69803DC; Wed,  8 Jan 2025 15:04:19 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B606B800DF
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgV1+Kx2qIGsGcNcI7cQ4GAoqfMeopi/OuIubYcSyuA3kgoT7PZEzXa94buv8tn/OHK8igwqfBfUP3bSZ/SBNHK3nZfEJ0iBHWhXy/4Aw35g84ixCzRD6hBtol+WcKaaq+Oo2m2Flt9UkZuoMC+2DZSgjvC3p8EEdl8HWxFk6zNd+5ff8g4XpKMdn4jGQBVnA4blN0Iq1S4vnnBMkmLJWZr19V6M+rCWIp1Y3Cp9T7oWhrePHi4psoif2U0EgjPaoRSON2BvhMZ05rHu4sy+RztFT/mOjq3LREkzLoKDAGZv+6dM7paIUzJyfiJf0rDzKTZzycuESXT8G8qaMfJ+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw1YI+/SoCRpk6uuJhjl+99g2iMjGD4gM/PBK35KdRM=;
 b=OCrzsmoW8Z1Ih1ON4F5wuFZD4Lv4jg69V2wnkdm27iTmTgVyrWAUlmsTtF4Axos42y0fL3D5tFD933x+OaXbt4ys7PeuOJepzECdOops7M6g2Pf4c3lNd8O3+clGmkHUGkS1pPgWF3c62K4kr2T7ro4qTh2iNlj0CVB5MKLGqTc/+nxhPhbJwJLol0xs5DNVZBTu0GILHOYhTnbBqMR8ZSoKTJL30BmeoHVB5DTv11L/Egppj1ZciZ6wNceN3xt9odiY5gSOQK/aCM21mTyDvwVXTQGYRC5QnLw5MkGuO2JCrPfx12K9QNf82DWkf8lyl088z0quQ2VmmTJmFxgCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw1YI+/SoCRpk6uuJhjl+99g2iMjGD4gM/PBK35KdRM=;
 b=y9+39AOnCR7mWtGJNol/GfTJLu09PYbiJJVbNlo+dtHo7u/OlZwLgHbPjPjZ4fMLVspzfqErdTZEnMpHniyeYyDD3FwnoY0GInuIiiBpbaeTuWCdvGHRsZRLQQ2DzRRZJydTQE0EdyzhLIyI5p/pP+UucwxHyJFIqiPwWMmEfto=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 14:04:13 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::28) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 14:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 14:04:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 08:04:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 08:04:09 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 8 Jan 2025 08:04:08 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
Date: Wed, 8 Jan 2025 14:03:50 +0000
Message-ID: <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc7085d-3a6a-438f-5689-08dd2fed53a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GFLBPh6OGMGvIvhDFJGLecmHGE3P4nQM4Isdd54LHgNTOYfAVC5cvXKIHpkO?=
 =?us-ascii?Q?3/eyXlyTnB7NbNbyMhPh+klx8g3O7VTsBiNrpUM1HKPwc/d0DOmdTz2exoEd?=
 =?us-ascii?Q?GO4hKeHhkpHWZ1EK2yhnu1rE8nMDjNJ3gM1dqMuG9IfDU2aZZEyandJkgh7A?=
 =?us-ascii?Q?7lc3x3BuN8izxosBJRfdArj2YP6TNdtUfOazG6+kFGsbLQQe3sRYrVGAuW2O?=
 =?us-ascii?Q?moqXvmEjh3DIWcvSYXjKTpCGiXVZUMNW4ToiG/nB9purKRIk1yJvfCuqKyoc?=
 =?us-ascii?Q?Drj8x6atQN2FG/HDjSHH5afPxvbsQ6k7Pl6YBUiZH4V1zpLQsXnPJhyWxSqs?=
 =?us-ascii?Q?L9tQPkKDxUbosda0T9zBPSoFaDItcNz1znHHCayXIHaYeNXFku9J8011QsvM?=
 =?us-ascii?Q?/X1qB8Aw3D9MSGjmdsHp+QOrhujFuSHkL7404vfuyu90s2nkuO0On0b6V1DO?=
 =?us-ascii?Q?xN5atfJOfAVkJgeY0coQMD+m+zrYdyzXyOuhFLghEHRWp4Ug2lgomCuvA0dh?=
 =?us-ascii?Q?RlGSoBHqrK22zr1hXAL+BkMQARp4RGk64JtKZ7ClIxLewy6An8zIRObvty0f?=
 =?us-ascii?Q?b2m0T+kbnnTKQaAP63Y3w4nrgoqpnwbXaNUDDHeYCcWEr43TIMx+5Ruhr1nJ?=
 =?us-ascii?Q?2Q4EdDtYxpRw6GRp1w6n0DUJ5DlffCkz3jApDb056OvtfdHCiM55BSaHp5jU?=
 =?us-ascii?Q?JRFhPzrLRZcd2IxtjEW3ji5epyc7gJTWzP3VadrcKxLjmIkVHpPHXPGdKc1i?=
 =?us-ascii?Q?RtNiTHra/Gj1Pcy1F34uqq3NJUyaC0N/NxzZ85mYJHCcIX1/fzW2JYCXS3wi?=
 =?us-ascii?Q?NS8+tAB0qfFr+tgBfiFIu78H3rB84Tx2ZS+R4gEGQSxzP4fzkmqlg2TfaalB?=
 =?us-ascii?Q?AVS/EAAyOXN3AnUZ6Uy9sZjwb2ViX/5E4D7JyJb0YIzP6NEkFwnEPXASCZmB?=
 =?us-ascii?Q?zKwdWjRdc2lct4rNzr+xX+aTW6bfzhOsLfFe6RToO5s9s6VXyZGr7W57Er2Q?=
 =?us-ascii?Q?uYnVjHVBM+aAR7MD05zoTffremRGfWzzypbtMS+VgiKBzPjRStLY0O3OJnU1?=
 =?us-ascii?Q?7ZgXn/WF9gvztNa8J3ddnOmFX8Di+vgYxOoo4ySX6BvlctfqknVwkEQU/o1T?=
 =?us-ascii?Q?rnotUdC20UgDF7YEcp5hrfznvo4FjHy1o9vgiWYnqUoAs53rdMVsEk6HPnQz?=
 =?us-ascii?Q?MDFwj/FfK0Gt+7FB4AAFxu5BoGbcbCwDZeD/GOToy7my7AyE0XIANhn32Adq?=
 =?us-ascii?Q?wtMMKmuY7hEypYsfAaoyTTMZ5/89L9x9TBkM/D9p4V+pK2V1avURnfIAyljn?=
 =?us-ascii?Q?CSRswZA4wdLpi5d7j00r9vUQrvn2yI3Yr4c5Hl5+dMZxPdFzLtdXBafeE9rq?=
 =?us-ascii?Q?0gkdjagyVV8VZBpsZanF1SUL5GSfKoTfSaJx4kad8tEWn3ihDUF+RK+zUqrm?=
 =?us-ascii?Q?aIN5Ta0mD9ELS9pLtgf0H2RvCCDptUOzMLMI2SApQsQ55Max3PKtlVsf7FfP?=
 =?us-ascii?Q?nyWHWvGd8A6ZTd0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:04:11.1752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc7085d-3a6a-438f-5689-08dd2fed53a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

The current implementation generates some alignment issues as well as
some overlapping when all the fpga command options are enabled. The fix
is intended to improve readability of the usage info.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>

---

The current output looks like this:
  loadbp        [dev] [address] [size]  Load device from bitstream buffer with partial bitstream(Xilinx only)
Load device from filesystem (FAT by default) (Xilinx only)
  loadfs [dev] [address] [image size] [blocksize] <interface>
        [<dev[:part]>] <filename>
  loadmk [dev] [address]        Load device generated with mkimage
        For loadmk operating on FIT format uImage address must include
        subimage unit name in the form of addr:<subimg_uname>Load encrypted bitstream (Xilinx only)
  loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
        [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
Loads the secure bistreams(authenticated/encrypted/both

The new output lools like this:
loadb  [dev] [address] [size]  Load device from bitstream buffer (Xilinx only)
 loadbp [dev] [address] [size]  Load device from bitstream buffer with partial bitstream (Xilinx only)
 loadfs [dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <filename>
        Load device from filesystem (FAT by default) (Xilinx only)
 loadmk [dev] [address]         Load device generated with mkimage
        NOTE: loadmk operating on FIT format uImage address must include
        subimage unit name in the form of addr:<subimg_uname>
 loads  [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
        [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
        Loads the secure bistreams(authenticated/encrypted/both

---
 cmd/fpga.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 93f14098ccb..cba38662958 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -411,46 +411,43 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	   "loadable FPGA image support",
 	   "[operation type] [device number] [image address] [image size]\n"
 	   "fpga operations:\n"
-	   "  dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
-	   "  info\t[dev]\t\t\tlist known device information\n"
-	   "  load\t[dev] [address] [size]\tLoad device from memory buffer\n"
+	   " dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
+	   " info\t[dev]\t\t\tList known device information\n"
+	   " load\t[dev] [address] [size]\tLoad device from memory buffer\n"
 #if defined(CONFIG_CMD_FPGA_LOADP)
-	   "  loadp\t[dev] [address] [size]\t"
+	   " loadp\t[dev] [address] [size]\t"
 	   "Load device from memory buffer with partial bitstream\n"
 #endif
-	   "  loadb\t[dev] [address] [size]\t"
+	   " loadb\t[dev] [address] [size]\t"
 	   "Load device from bitstream buffer (Xilinx only)\n"
 #if defined(CONFIG_CMD_FPGA_LOADBP)
-	   "  loadbp\t[dev] [address] [size]\t"
-	   "Load device from bitstream buffer with partial bitstream"
+	   " loadbp\t[dev] [address] [size]\t"
+	   "Load device from bitstream buffer with partial bitstream "
 	   "(Xilinx only)\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADFS)
-	   "Load device from filesystem (FAT by default) (Xilinx only)\n"
-	   "  loadfs [dev] [address] [image size] [blocksize] <interface>\n"
-	   "        [<dev[:part]>] <filename>\n"
+	   " loadfs\t[dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <filename>\n"
+	   "\tLoad device from filesystem (FAT by default) (Xilinx only)\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADMK)
-	   "  loadmk [dev] [address]\tLoad device generated with mkimage"
+	   " loadmk\t[dev] [address]\t\tLoad device generated with mkimage\n"
 #if defined(CONFIG_FIT)
-	   "\n"
-	   "\tFor loadmk operating on FIT format uImage address must include\n"
-	   "\tsubimage unit name in the form of addr:<subimg_uname>"
+	   "\tNOTE: loadmk operating on FIT format uImage address must include\n"
+	   "\tsubimage unit name in the form of addr:<subimg_uname>\n"
 #endif
 #endif
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
-	   "Load encrypted bitstream (Xilinx only)\n"
-	   "  loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
-	   "        [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
-	   "Loads the secure bistreams(authenticated/encrypted/both\n"
-	   "authenticated and encrypted) of [size] from [address].\n"
-	   "The auth-OCM/DDR flag specifies to perform authentication\n"
-	   "in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
-	   "The enc flag specifies which key to be used for decryption\n"
-	   "0-device key, 1-user key, 2-no encryption.\n"
-	   "The optional Userkey address specifies from which address key\n"
-	   "has to be used for decryption if user key is selected.\n"
-	   "NOTE: the secure bitstream has to be created using Xilinx\n"
-	   "bootgen tool only.\n"
+	   " loads\t[dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
+	   "\t[enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
+	   "\tLoads the secure bistreams(authenticated/encrypted/both\n"
+	   "\tauthenticated and encrypted) of [size] from [address] (Xilinx only)\n"
+	   "\t -The auth-OCM/DDR flag specifies to perform authentication\n"
+	   "\tin OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
+	   "\t -The enc flag specifies which key to be used for decryption\n"
+	   "\t0-device key, 1-user key, 2-no encryption.\n"
+	   "\t -The optional Userkey address specifies from which address key\n"
+	   "\thas to be used for decryption if user key is selected.\n"
+	   "\tNOTE: the secure bitstream has to be created using Xilinx\n"
+	   "\tbootgen tool only.\n"
 #endif
 );
-- 
2.42.0.325.g3a06386e31

