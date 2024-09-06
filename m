Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17926CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6E288966;
	Fri,  6 Sep 2024 09:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lNqOd0yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F57688D0E; Fri,  6 Sep 2024 09:08:51 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D28A88580
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB/ZfvU+eM06MH3SAEWWaKCWNyt1eo/AYRPGwqyfbt4RKUSF2BNK+eFas5yEDeJNTtpvljj9cCcWJwF0PzzmiXkMjJ+Ali6gC3CeOA4SYeTK2+RmN8cf6NJHi+H5J9xrQRDiL7k3H2bPcUNLtSsBlpzMCwXsbR1NGU6sALTc3NRRjOZbrG1TJ/bHTDiDz60PNIorq2RPpv98R4r2jutEkQ2xm+SQ1hl/BpZJ9IbojX23Iv1orEgFKjfB6ZaisadLjwPYsTd4oZ2EjX/e/RAuAoPom5g0jBA6PD8f7abnTOAsLW4onhM2TawYD/zXlfnDgg9tNtaY9vc5xIA4etzoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqQUG0CIdRqV6JIhX3DPHDzmGb4hR3tvYKQ5D19e+kE=;
 b=pctiILlxOZian6FvVa/ZVKV+oZv94H5LrC/6k5g2sOrhkKjs5nYiPx5svVmULFxnPDh+d0wcmaSW8iy/T6J46YFIkjyaecu3AlWZ5sXDjF2Nc/sTLy6oC2/kB5kJA6TpKiyTYdwe+WCUZK+lbyKooXg/zkMPqEmohlKPJTX13b5udCheODPKSbb2ZssQPD6Q9Tu2SnmSHWXpHh0FT3m8q7k3OlC8PVCCgnkn09Aitri0qmRHTsF6+nuaIIPKhP+ir12o4bVcVzNrMjyPPAoEztgdaEzoDWn/nIdVkwHGJAprCBpKwBu0320BtxNTGBayxwjNl4pZcu7p4qRPHCoBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqQUG0CIdRqV6JIhX3DPHDzmGb4hR3tvYKQ5D19e+kE=;
 b=lNqOd0yuNPpa+77qWHPm+SD+mKt74hpxXJm/EFxDYZPYY9wpRWqkQiC9CWZ6LixmZmP7Q0x2KfDb+bkcpBsk0tnxyE3jZCxOKRptUL8KAm0R/3uLN6MfcTKsIBqYoAh03hKJzL7sJoLUt7iaP7rLB8Km9KoLCqzc+5unk1bL8dw=
Received: from SA0PR11CA0165.namprd11.prod.outlook.com (2603:10b6:806:1bb::20)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 07:08:44 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::f3) by SA0PR11CA0165.outlook.office365.com
 (2603:10b6:806:1bb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 07:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 07:08:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 02:08:42 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 02:08:39 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2 1/2] kbuild: cherry-pick kbuild fdtoverlay changes from
 linux
Date: Fri, 6 Sep 2024 12:38:07 +0530
Message-ID: <20240906070808.1045991-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906070808.1045991-1-prasad.kummari@amd.com>
References: <20240906070808.1045991-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: caf933a3-af89-453f-e152-08dcce42be4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ulnCRrEU9ox9s7rlv9rTbaSCxIcQ4OXPgEP5939j2cZu70HbhlE672rLbKYT?=
 =?us-ascii?Q?NLbgq3ay/M6QgdtddsXzl+wtdluNmB7k3xDbnWqeX19ACu0xqOArwSeMC6W5?=
 =?us-ascii?Q?KO6zQyyFEB6LYwRm10qKU7z7dqPLtQK2EwfJpcricWwWaP4QQkrDxOqq4MUc?=
 =?us-ascii?Q?CbwNr7cfAauRUtlX4DJu0c5xuFJu8U7jlwJCkr1t6h0ObQWLoHvot644aD+/?=
 =?us-ascii?Q?mzhKG6AWTXISrg9veLlPcaOMcCgfU7iBnJ2Xh846wxWTfryPqR8jhPchCvca?=
 =?us-ascii?Q?PiJ92Nn1i0lknH+vDqj79CAIzGUFy3DGpr4ZYh+oNIE38mEPCsW6+r12/+7x?=
 =?us-ascii?Q?06fspCBxt0S7cGI9nl6tnPqQWIT1IAV94RiOODtkupVgSIIjoRuwL9PC8csk?=
 =?us-ascii?Q?IRvvrnLPiN54PvHtf1ULg5UwCQn3l1e+3op//2p6LIy+pu8zo0G9etr+6vfW?=
 =?us-ascii?Q?7ybSGQJgJbXXNozlYmYJDUZGbaBiBH8sV8uuVZf9Mc4zAWLGZhEM88zMioGE?=
 =?us-ascii?Q?gOC9V8j9vRPXyTE7czSqXgejNZYZGVr6idDDZAZKjWumoAPZXCNr94yYWIze?=
 =?us-ascii?Q?ge0qjQrATCTHNBuPpIgdzJ8J3yk0orw3iIEbWk3hryg/GH8YEV9j42SQPr4d?=
 =?us-ascii?Q?fzAVt3pcEwqrpP42Tn4x6HH5VsLRx1z89zYs43TNGMJ1wRe4Myj6WwNU2KMz?=
 =?us-ascii?Q?3VCj51/c8h2kcfs/Jq1IRy3/0tOvLIcJCb6R3yutuba43DTgR9KbLXh2xgN8?=
 =?us-ascii?Q?x31CO72h0J60/1rxfI7UrRRfOf1oIcx+RN/HcGGpqI3NJGgZw9mzGFZ9h3ZH?=
 =?us-ascii?Q?Md43uUbzHuCBGrNJAnUWKu4iTK8TuFTBXq75oyhORTlO4eDtUh7qhhgNfWw8?=
 =?us-ascii?Q?M5srs/bo0TujtvpbXFJZ38T7x/25iw3+0s7w/ar176AExcTO8JEcnvxw95Gy?=
 =?us-ascii?Q?DdAtChgga4zwGKxNoIclA4LznlNKohhw0ZxJePiZp7wZvYmJ6kXMS/UpNQKS?=
 =?us-ascii?Q?CpG/twTSb4nJKkprqgIppAADvxUm9Gse2Sr4n+++a8qDVdmLZN7N2/PjPMeK?=
 =?us-ascii?Q?sZK99+/EPA1eTbEsFz2RcVh5JI63IjuiMUcOJA7XtJfSGqu9Ug6BzD9TtweM?=
 =?us-ascii?Q?oNZBMFVl8ymdrKU/Zgw2fM5IaQtAIl4DsL+SNl2Lt0ZSh35p16eAHPq8/CcR?=
 =?us-ascii?Q?n6xN064fxEYthEvPvSk1sp0evO2FTy9ftTv3cpyJPbK+mcShS6g8zNk/ueJL?=
 =?us-ascii?Q?aPqoIJlxR3f8/h4wz+hQaXdDzNPbR9SeWbFYA4pl/gmgyfCyyC0JnU4WwHNT?=
 =?us-ascii?Q?UiMy5NPh3HsTl5TNi4f67zwT5FHC/QqH8zr7B8bFDhiML0MHxpttc1stGGbd?=
 =?us-ascii?Q?gnI2ILhoyRrDYiCASZ1JIq5NPo7Om/evf2IvE0d21pyO0ZMM9h2dqYmhQkK5?=
 =?us-ascii?Q?rFUalRJiJBUSjtn02jlFPiGHqlEuaORp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:08:43.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf933a3-af89-453f-e152-08dcce42be4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

Linux commits:
15d16d6dadf6 kbuild: Add generic rule to apply fdtoverlay
44f87191d105 kbuild: parameterize the .o part of suffix-search

The Linux commit 15d16d6dadf6 adds a generic rule in Makefile.lib
to automatically apply fdtoverlay, so that each platform doesn't
need to include a complex rule. This also automatically appends
DTC_FLAGS_foo_base += -@ to all base files

The platform's Makefile only needs to have this now:

foo-dtbs := foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
dtb-y := foo.dtb

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/dts/Makefile  | 57 ++++++++++++++++++++++++++++++++++++++++++
 scripts/Kbuild.include |  4 +++
 scripts/Makefile.build |  1 +
 scripts/Makefile.lib   | 27 ++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2d931c23fc..c82fbeb1e1 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -324,6 +324,63 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-zc1751-xm017-dc3.dtb		\
 	zynqmp-zc1751-xm018-dc4.dtb		\
 	zynqmp-zc1751-xm019-dc5.dtb
+
+zynqmp-p-a2197-00-revA-x-prc-01-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-01-revA.dtbo
+zynqmp-p-a2197-00-revA-x-prc-02-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-02-revA.dtbo
+zynqmp-p-a2197-00-revA-x-prc-03-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-03-revA.dtbo
+zynqmp-p-a2197-00-revA-x-prc-04-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-04-revA.dtbo
+zynqmp-p-a2197-00-revA-x-prc-05-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-05-revA.dtbo
+
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-01-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-02-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-03-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-04-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-05-revA.dtb
+
+zynqmp-sc-vek280-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vek280-revA.dtbo
+zynqmp-sc-vek280-revB-dtbs := zynqmp-sc-revC.dtb zynqmp-sc-vek280-revB.dtbo
+zynqmp-sc-vhk158-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vhk158-revA.dtbo
+zynqmp-sc-vpk120-revB-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vpk120-revB.dtbo
+zynqmp-sc-vpk180-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vpk180-revA.dtbo
+zynqmp-sc-vpk180-revB-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vpk180-revB.dtbo
+zynqmp-sc-vn-p-b2197-00-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vn-p-b2197-00-revA.dtbo
+
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vek280-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vek280-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vhk158-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vpk120-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vpk180-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vpk180-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vn-p-b2197-00-revA.dtb
+
+zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
+zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+zynqmp-smk-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
+zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+
+zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
+zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
+zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+
+zynqmp-sm-k24-revA-sck-kd-g-revA-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
+zynqmp-smk-k24-revA-sck-kd-g-revA-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
+zynqmp-sm-k24-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+zynqmp-smk-k24-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kr-g-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kr-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kd-g-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kd-g-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
+
 dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini.dtb \
 	versal-mini-emmc0.dtb \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 62e0207f91..5daceb2606 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -31,6 +31,10 @@ baseprereq = $(basename $(notdir $<))
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
+###
+# real prerequisites without phony targets
+real-prereqs = $(filter-out $(PHONY), $^)
+
 ###
 # Easy method for doing a status message
        kecho := :
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 99cc29595b..90aed148c4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -293,6 +293,7 @@ $(obj)/%.o: $(src)/%.S FORCE
 
 targets += $(real-objs-y) $(real-objs-m) $(lib-y)
 targets += $(extra-y) $(MAKECMDGOALS) $(always)
+targets += $(real-dtb-y) $(lib-y) $(always-y)
 
 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index df754d1d9f..8387008a1f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -47,6 +47,13 @@ obj-m		:= $(filter-out %/, $(obj-m))
 
 subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
 
+# Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
+suffix-search = $(strip $(foreach s, $3, $($(1:%$(strip $2)=%$s))))
+# List composite targets that are constructed by combining other targets
+multi-search = $(sort $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $m)))
+# List primitive targets that are compiled from source files
+real-search = $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $(call suffix-search, $m, $2, $3), $m))
+
 # if $(foo-objs) exists, foo.o is a composite object
 multi-used-y := $(sort $(foreach m,$(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
 multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
@@ -58,6 +65,13 @@ single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
 multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)) $($(m:.o=-y)))
 multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)))
 
+# Composite DTB (i.e. DTB constructed by overlay)
+multi-dtb-y := $(call multi-search, $(dtb-y), .dtb, -dtbs)
+# Primitive DTB compiled from *.dts
+real-dtb-y := $(call real-search, $(dtb-y), .dtb, -dtbs)
+# Base DTB that overlay is applied onto (each first word of $(*-dtbs) expansion)
+base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m, .dtb, -dtbs)))
+
 # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
 # tell kbuild to descend
 subdir-obj-y := $(filter %/built-in.o, $(obj-y))
@@ -69,6 +83,7 @@ real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
+always-y        := $(addprefix $(obj)/,$(always-y))
 always		:= $(addprefix $(obj)/,$(always))
 targets		:= $(addprefix $(obj)/,$(targets))
 modorder	:= $(addprefix $(obj)/,$(modorder))
@@ -83,6 +98,8 @@ multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
 multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
 multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
+multi-dtb-y	:= $(addprefix $(obj)/,$(multi-dtb-y))
+real-dtb-y      := $(addprefix $(obj)/,$(real-dtb-y))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 
 # These flags are needed for modversions and compiling, so we define them here
@@ -304,6 +321,9 @@ endif
 
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 
+# Set -@ if the target is a base DTB that overlay is applied onto
+DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
+
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTBS    $@
 # Modified for U-Boot
@@ -425,6 +445,13 @@ cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
 $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
 	$(call if_changed_dep,dtco)
 
+quiet_cmd_fdtoverlay = DTOVL   $@
+           cmd_fdtoverlay = fdtoverlay -o $@ -i $(real-prereqs)
+
+$(multi-dtb-y): FORCE
+	$(call if_changed,fdtoverlay)
+$(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
+
 # Fonts
 # ---------------------------------------------------------------------------
 
-- 
2.25.1

