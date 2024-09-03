Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46397CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6405D88BC4;
	Tue,  3 Sep 2024 13:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jeJT2g7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD67C88C30; Tue,  3 Sep 2024 13:52:53 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D0288C19
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOebfK40osu8m0NgPlfatARO/8g8D8yJ3OSTG+xD6E1yU8xeTGTqwskARixPyVZIPIrdb5xue/zK223Tio5dY0x8xLVfovBZSXJ1vVINoj4BwDpFqNXpHMcj2H0UEq57/xcLWdY+iqHDXPi7wuMQ8HPlLvUj0zKtilavoz7fVS3QI9LwYoOzkTlV51dbSJEMJf2k5lcFMkboHL6Sjr/m4osa2QRtRP5F8C7MOqRF8TroDIvdYjcLaqHnH4Wcd6S6VnOnNW97envI+/HQZq4WTDR/qBJreX14MtPT8g2V80+kI2arIIMGBDFzWU06J65KGrrFLrhrnTK5UVpL9mdyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8ZlZmifhESPtOx9znObsgLuywzq+qDTD8tRNIjkXoQ=;
 b=ncpekS1LHYLVug3zzN9BuCNsuYnnppgbPwEdxjzKYLrrS5b3ABvM/2UpI4pvLwTleGAhwwmAAoKX4J9GvhA9u4w701nnqPbznkDxZDnFiqgyT2sMnUHeaIkrtJaI5ImFFCygsLDUJskWtGgz4p7RY3TeEuqQRYKbHYgb29MDS2kec1LO+52noj3jrMyybmqTkrHCynyAgqJF/ZKTRGReYbfSjQ6I5aLCN3Gj8ORWzrT90N+ei7/wjiIYK0509ZsdZ4gPlVXPGrY1QcEEI+j4sUn8w5gLHupEMCTWk7BTMWfQY0LlpxFnK+w+8l4kDukR4TooEtvqNjqbJuEiHx1Lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8ZlZmifhESPtOx9znObsgLuywzq+qDTD8tRNIjkXoQ=;
 b=3jeJT2g7vl6Dd2SxBL2JentpznrVOySjE5txQrajgEElDgzjgcbFtPfPG2+3rksXo3QknrFUDisMitxUGp2XKgaqdgflr/vopfTo6hqkF/F+bIY4fC6daHw2CGAZzxj8LcezfE6BFfi6k/9cAxSdLFEZH33GFZByH01qjDZgp4Y=
Received: from CH0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:610:74::6)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 11:52:44 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::a7) by CH0PR04CA0061.outlook.office365.com
 (2603:10b6:610:74::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 11:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:52:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:52:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:52:37 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:52:35 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 1/2] kbuild: Add generic rule to apply fdtoverlay
Date: Tue, 3 Sep 2024 17:21:51 +0530
Message-ID: <20240903115152.430335-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903115152.430335-1-prasad.kummari@amd.com>
References: <20240903115152.430335-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e433778-b90f-4576-ec2b-08dccc0ee93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N1NkidcCpvn5lkv/BfoUVFyolvb34u0vklNvHxideyWZZSOJSsaB01Qfoikt?=
 =?us-ascii?Q?cAP8eVYy7WCFwCN3W1rKUbBUKEPtASVdv8KyL5myIVsJD3v9zXWxJo46umsX?=
 =?us-ascii?Q?FIJigFg6pa17uUhqKn0pO04KhiP4+T0xTUk9h/5jDNNBsRtCRHZ1kq68awVO?=
 =?us-ascii?Q?X7QnZi79ccvP1jq01p7DgLIKBPsryd0jniniFSzbSR/63SNEW8l2lLnkVb50?=
 =?us-ascii?Q?E2nhlsaXIp4Ug7PBITODpkZxYqRLlJnhDKeHf2DNu0GrybXQjgrBlSQHXHOq?=
 =?us-ascii?Q?SvgqRMCghrXPaSBk5q1U4cTkvCocV6DVPTjyftjSe4aKlTlCC70KH2nL6DV2?=
 =?us-ascii?Q?dSdyKkq9swYmsYIn614FzsHlhvV+ooApIfiO2+otRKi8vOyDzaxnjWSeayvV?=
 =?us-ascii?Q?/1njk/508irKr38ALr5rrGR328yJuIcfWT1JFhuA+on6IuVbNmbXlyVnhylG?=
 =?us-ascii?Q?ojynCcx/QGdvgbMeW+sn6bfuHBu3GCqEX5DnNVxokyWP7DLdzgmjD/ExC16L?=
 =?us-ascii?Q?YgOT+MjarJy4cC7G9vDE3m/0keCJmNyinNGO0Gd92nC6Rdkih0g+72jC+zNV?=
 =?us-ascii?Q?Al/eRYdfWHpNvrB+c4KVaCEozbubeKN1lK3vA0pdXaaW4OXRMygD5Bqt0tMI?=
 =?us-ascii?Q?iavli2cSXC+FLywLwo0LSp55YUx0+LH2D0pemoAYidzV/Van7LTBkIFZGbIT?=
 =?us-ascii?Q?Z8T8bMEiMaOxo0AuYiguSj1P5Fz5viUkyfGAQ+ITRNnsQCJXprAQFt2FGK5H?=
 =?us-ascii?Q?SjIf30vsVymROO2q5un24CjqcW4JI/qyDFbEo4ZqPbQJBasSIkr4pqb+kEBi?=
 =?us-ascii?Q?qUw+7jQSrIj6xw8XIIG/y0TV3Mm7v3e3ECStyWLzEdLTl75rbuUWsetn3yGd?=
 =?us-ascii?Q?j8zd0A21mbekgA1W4wBOiKX79zbyqSaLgpbOOUfYF9J/flD8/zdk96YuGM3/?=
 =?us-ascii?Q?hIgOGRkef3nMJhUBz5M8xNXb+lVHKkoIPTY9fJAuC105MQS8u3aTDiJJppd3?=
 =?us-ascii?Q?j6MbjvI5UOAEw7xGDjkgQiQG2iYWOhPUfVXUFYob6EOAtzHsdhy9XG5gbwZp?=
 =?us-ascii?Q?LspC+w/YVH4SGooXxKoW0GB1lfOshAhMuKh5atljhirzwfLmuBNRnRheIEKn?=
 =?us-ascii?Q?1e8jvUYzsk4ST5dbPN1pRPyVGDkNTp8bmAbPTA2TkRJQzVXDRMNYc1pymrMD?=
 =?us-ascii?Q?KZFEHziMCmwyocb8S6LQnHxN4AoRQSzAZitdlmK+cP2gYFTsi3mWfzje68pt?=
 =?us-ascii?Q?OQNbiA2h/Qt9HS2U3Ya/6vyjwXg2+wkbRqJmzA2UevHn41ICOokPNAV7nZEu?=
 =?us-ascii?Q?wg0gZpR+NMHoYL0dXvKqVZ8V4SlIliDRWqXlPuujtPrOzgGhAfgXCViT72wd?=
 =?us-ascii?Q?qWb4qKgo8xXh1fuDMDI5vKdNIXuaBZAl2zxQxCM4nyzWSQ44bcSJeQALtx3c?=
 =?us-ascii?Q?DgklFS5TGNFktTKtAdSr++64L7LT/5e/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:52:39.3522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e433778-b90f-4576-ec2b-08dccc0ee93c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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

Add a generic rule in Makefile.lib to automatically apply
fdtoverlay, so that each platform doesn't need to include
a complex rule. This also automatically appends
DTC_FLAGS_foo_base += -@ to all base files.

The platform's Makefile only needs to have this now:

foo-dtbs := foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
dtb-y := foo.dtb

The suffix-search macro hard-codes the suffix, '.o' and
multi-search and real-search macros can be used for foo-dtbs,
multi-dtb-y is a list of DTB constructed overlays, and base-dtb-y
contains a list of base dtb.

Reference:
https://lore.kernel.org/all/20920b0df6b067aca4040459a9677d7d1d6d766a.1615354376.git.viresh.kumar@linaro.org/

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

