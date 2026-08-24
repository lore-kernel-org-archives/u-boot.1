Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8015EC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CFC880DD8;
	Mon, 24 Aug 2026 07:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZSACIdG8G78; Mon, 24 Aug 2026 07:36:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556982;
	bh=ga0t5aL985/f2tyFkybZ6Dc5UFAg2f6sSysOLPUl0Ls=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SWJwW7t9/fJsG05xJymjxv2uei5et/h69aD3/r97EN4c8Jks9WjxjlNdBl3cbQcx8
	 cNY7runAckQHglFimP308AzHQZYiPXX335u4XH09Uy4TtJiHuMqcD1x8beknKjkDJp
	 59/2gu24SL3mutXpnf3NvdxNEenZpr6Ms/G/YYgcNNNhbYru3T4SWBBh1Wx4iwKt9Q
	 KzgSwg2F43a7lbQelHCKPwKhecCFoqlZZ4irFgYr7sVPjxN0yy1fZZp+m07BAIwmJI
	 M0CI/Km15tA7y+HvmPMqhyKjfYRfiXFNy5hBRH20iQZDqTNhfFXGX0n5pbAc9UoBtX
	 w4kJHoeHGSQ4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D98C180CBA;
	Mon, 24 Aug 2026 07:36:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EACF3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CAAC605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7N-qxQVp8HPh for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:36:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YHFCdbxY
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9F9C605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0a0tPlE8+k8T2C/dXdnn9AocG6zH5CsVyUhJ46VqSqQxrl8fykIktRSQKpIusRmV4BXS4OGDYQbw0O7uFuCP50rG3E0TTbJNb3NEE6NDqdqVPIu/+ad0bUcgpE+mSeubi6C5jSg3KTQORwB8Y15iyXUJpYUXMokJObnp2cYTdiDWwizt3rko9+9XtV9R0UVXYdSVEEnevFOnKzGMlvdwNhIwfBV3+YtzBlDR8Yr0wYUHk60OSHXapItS6k4DsAeLazihZUgABSDt3Ax+w71hFasURSvIHaKCiIa4NDwvRTjROhKk97OSV7+yYDvdYabqhn8R/kCmW/290k5i864qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga0t5aL985/f2tyFkybZ6Dc5UFAg2f6sSysOLPUl0Ls=;
 b=Z6E7+t69W3cJpYOfQnuWCB5ZMC9HvcQeu9iB1jg0oJhwpTE/V7rQnFFJtnRjNvtxi7oR3C0NMy6Gs9cMekZqhLDff3nC9Hyl4vbv/ZAwBb9fJel9o/UgmfQ/s8hUKClZmtl+4VFlpRiSw0sOR/BM626vZEf5W/XwN4Z/hYm4lbVYdXLZ3wldcFuJ7qR1LAh2VWipmXafzhI3B/b0C09f6uPixd7gggXf4zXX4lNM1ja05R66MUr/e+1Q18RXS65arGQ/O8/yxCZNiNcL8rP0oXooErkB71aShs03GEJLzZUcg0j9aAmr7+2A28rlOoTDsJljpHAQ6BggTQet5GNAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga0t5aL985/f2tyFkybZ6Dc5UFAg2f6sSysOLPUl0Ls=;
 b=YHFCdbxYZmG7pN+AbEtfzDq6HE8p331C9rfXQ/kVziluBK88GGFkuVACs25T+NX7B0yw5di5wTVFSwmdlruUeEb+yQWHgO64zn+ougMlJJ5zmUE12P02yxfOtM3Fsm7C2VRzERR7ygOEngAMBVOl2umlXvnM38phUWKyKGIIbys=
Received: from PH0PR07CA0112.namprd07.prod.outlook.com (2603:10b6:510:4::27)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:36:12 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::58) by PH0PR07CA0112.outlook.office365.com
 (2603:10b6:510:4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:36:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:36:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:36:06 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:36:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <marek.vasut@mailbox.org>
CC: Andre Przywara <andre.przywara@arm.com>, Chin-Liang See
 <chin.liang.see@intel.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>, "Jit
 Loon Lim" <jit.loon.lim@intel.com>, Lim Siew Chin
 <elly.siew.chin.lim@intel.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>, Matthias Winker
 <matthias.winker@de.bosch.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Teik Heng Chong
 <teik.heng.chong@intel.com>, Tien Fong Chee <tien.fong.chee@altera.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Remove unused emails
Date: Mon, 24 Aug 2026 09:35:55 +0200
Message-ID: <a14a6d0d7de1afe226edd49b3f683a3cf26cc50e.1787556953.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pRJTN5yonNjyJ31KFStJ7b1EiDq/BGrP65gjqp5lhtI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR1f0lWEXjmN+FKPvM14ZIfn1vnP9y1/NCZJ3Ul92waY
 /KcayIPdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEymsYGd6cezbzh9y8OaFR
 RYZ1b0NevpfrfXXqC3PXZrvdHhq90ryMDC2SZ44wVK69f/eYe+bv7Gnhmi82ab7sbZ3jEj1dzYn
 lLBsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfab55b-dd93-47a0-839a-08df01b25dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: JjA+41uYrmxNBWpcAPr7pc/y950v6PYdxyi7eKLaXES/KD0kUjJBTybUfESo2Mkhki9U1WNmvXPqjEbXDeTRzsUd0d0NpfDBEWcJkSSoV47ihQNFoR3uOql+ENPkQc5gC1s0VhP4CAoH6MRUUiOQYpwsjghBLVwYq+2IZstouZQsHkdu1405d1MFILByV0iF1Ne6ghRAx/KH9lESFjWKkTjZ3d/oiZEjhzNEQQMsweuu6Py3mNa2q3O2W7ZphzcdmL8w2ml59bydlO2riJMweWmN/StytChov9ouvqjh7DAQ2goQbDe2zQSDqui4ILhFISAUzKAv4gIHWpWk5+nVl4eQce/3I/TvnLmOYclN5jZdxrJ6B9t1Z+XeQLQ6OVCs2cSVd0cFPrKCn4lBGRQWaFiMyCbS4ePfi2pcOBpomUeyfpbXHceXcQ4DeGZPNgQDx0PijnLRKWIfggcN2aLw5bl5zAJJ+duQEQT5lUKMF4HaxVzsQSD9H6ssOMPeZMMkVjPJrtu0KzsRSM77WkX/8/M4LXCkx+gi8Ad/nA91cdO99usCwJPQjXrGjmncO37FI6tVXeTGQkqokjISIZmAIbHWq0jYklyhu6e+Hgf91PN7tiF8z0Y4jf/tZ4VS2kZNP0PosMwpjSTokIlJfwPcV+d9Ex83FVcPMxqe2Y0fJbUs+I4u+IyqS9R9Hdpi66oOZgQgSNQLjzkyJQDtAo9aOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: myZkBuDjBrJSNHShZCmnAYx5xl22FPayGRf1+6LUulvCS0TNgOoguGsxDH6+/SWXo0qPC8r1Ip91dkV4n3/b/ZMJ0I0bhWRrcDOMGtFdJkBTdQ92YYgzTg0DgFiowUTowAtF0FTccP04tRoW9k9MSqDnZOMFQm80a7xCeD6628PsdbIE1ZgrR1SAgbr7ZL6iQCDWlgrErBpiAwBRdvbgJtx94C6j6gudqTTvPQm98VVIqa4rGgb55YQu5db5IBD7xhqyAQHlAeMkCVUqyRWMzfm71c8GGu7Qy/5xYqyxzhFuaCZCUS5Kb60M9nR+gLG+8hisyTnZWl7fd60OHdyRyXuWbgsVvvSuV7o9i3Y0dpYzaoUDxVmcw70VxWKYVtacvQKizvliLK42ojKxEfjx59Gf/6NUM/67Nd5MBnaWPZna1e+g0oqAdRg18T9h+dXG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:36:09.9214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfab55b-dd93-47a0-839a-08df01b25dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

Remove inactive developers whose email addresses no longer exist.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

When I sent previous series I got replies that emails are not longer valid
that's why better to remove them directly.

Not sure what's the situation around denx.de but I see a lot of references
to denx.de emails and also in git-mailrc.

Marek: You have a lot of fragments there.

---
 board/altera/stratix10-socdk/MAINTAINERS | 1 -
 board/bosch/acc/MAINTAINERS              | 1 -
 board/intel/agilex5-socdk/MAINTAINERS    | 1 -
 board/intel/n5x-socdk/MAINTAINERS        | 1 -
 board/sunxi/MAINTAINERS                  | 4 +---
 doc/git-mailrc                           | 1 -
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/stratix10-socdk/MAINTAINERS
index 6192bc917465..a61101a762d3 100644
--- a/board/altera/stratix10-socdk/MAINTAINERS
+++ b/board/altera/stratix10-socdk/MAINTAINERS
@@ -1,6 +1,5 @@
 SOCFPGA BOARD
 M:	Chin-Liang See <chin.liang.see@intel.com>
-M:	Dinh Nguyen <dinh.nguyen@intel.com>
 S:	Maintained
 F:	board/altera/stratix10-socdk/
 F:	include/configs/socfpga_stratix10_socdk.h
diff --git a/board/bosch/acc/MAINTAINERS b/board/bosch/acc/MAINTAINERS
index d6001d824951..bab04a3f9a58 100644
--- a/board/bosch/acc/MAINTAINERS
+++ b/board/bosch/acc/MAINTAINERS
@@ -1,6 +1,5 @@
 MX6Q_ACC
 M:	Matthias Winker <matthias.winker@de.bosch.com>
-M:	Philip Oberfichtner <pro@denx.de>
 S:	Maintained
 F:	board/bosch/acc
 F:	include/configs/imx6q-bosch-acc.h
diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
index 30d8815d2020..a60ac27cdc78 100644
--- a/board/intel/agilex5-socdk/MAINTAINERS
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -1,5 +1,4 @@
 SOCFPGA BOARD
-M:	Tien Fong Chee <tien.fong.chee@intel.com>
 M:	Teik Heng Chong <teik.heng.chong@intel.com>
 M:	Jit Loon Lim <jit.loon.lim@intel.com>
 M:	Dinesh Maniyam <dinesh.maniyam@intel.com>
diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MAINTAINERS
index 0ef39964412c..d5c806b7cbdb 100644
--- a/board/intel/n5x-socdk/MAINTAINERS
+++ b/board/intel/n5x-socdk/MAINTAINERS
@@ -1,5 +1,4 @@
 SOCFPGA BOARD
-M:	Chee Tien Fong <tien.fong.chee@intel.com>
 M:	Lim Siew Chin <elly.siew.chin.lim@intel.com>
 S:	Maintained
 F:	board/intel/n5x-socdk/
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index df745f146494..91ca165fab97 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -1,6 +1,5 @@
 SUNXI BOARD
-M:	Hans de Goede <hdegoede@redhat.com>
-S:	Maintained
+S:	Orphan
 F:	board/sunxi/
 F:	include/configs/sun4i.h
 F:	configs/A10-OLinuXino-Lime_defconfig
@@ -198,7 +197,6 @@ F:	configs/Colombus_defconfig
 
 CUBIEBOARD2 BOARD
 M:	Ian Campbell <ijc@hellion.org.uk>
-M:	Hans de Goede <hdegoede@redhat.com>
 S:	Maintained
 F:	include/configs/sun7i.h
 F:	configs/Cubieboard2_defconfig
diff --git a/doc/git-mailrc b/doc/git-mailrc
index f0ba30a5c746..62d457e6bb35 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -47,7 +47,6 @@ alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 alias sjg            Simon Glass <sjg@chromium.org>
 alias smcnutt        Scott McNutt <smcnutt@psyent.com>
 alias stroese        Stefan Roese <stefan.roese@mailbox.org>
-alias tienfong       Tien Fong Chee <tien.fong.chee@intel.com>
 alias trini          Tom Rini <trini@konsulko.com>
 alias wd             Wolfgang Denk <wd@denx.de>
 alias priyankajain   Priyanka Jain <priyanka.jain@nxp.com>
---

-- 
2.43.0

