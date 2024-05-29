Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F68C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3F988637;
	Wed, 29 May 2024 18:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3dp4eBtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CE2883F6; Wed, 29 May 2024 16:48:19 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24739885A9
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PthBxtmNih38/a3OSJOUe3c3O30Sbp38pxp7uRomtxv7Mw4E0lp4lsZjaRDsxKwtUkoJnUVOK5n0GUNna1hNn2u2fK8ZR6ZqC9GMfU826CiwzbomNh2GwVUiz2KsWsV4BGmu8uszqY90SCUoXtioGpOG/grKx0LGVajYvJfDiPa2OygrrNLN7USB3phNevMeN9qnE91sa7Zm3/1EMNDIK8uTcNs5bnjaFpKuYrXEEHcq2TBzsWxgoGqhrEeieXPG51J8+RnO7aOxjNn1w1acpl9EV8Ce2u6qiPEWY1Yrs5yYTPsOJJGaXHwbYvmNxxiCEuy5tOW3m/o14OQLlBbETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZcY2Ym8IGq0zSEAfNRuhUBLfZT+X9xGaxnT1Cqno1A=;
 b=GDyTOgwEl/gMOkI+8D8ZkmqLb/q5id9WuhwiESQykEDXYrKqYiJ68rg9sh+/fsoi2AtLsbX/Gbu2rojtleV2Rw+tvfieAZjYiH0EezcT4B+vHd/JSqz+57Hq9eTgDUCCd9tNomlCq3MA8lCww8hs38Y27jW6h1PMfdzVFImIaSEmYBVUKqGmIpPNuHQ1PIhGNL+AHU2g2ZsG9bznr32hkQuB68C4qIIAJCnKsYZP1Rc7fHl2tkEGsJCYqfEoFpnDfznrxrOzhtg5nxLAl47P/IcQiAuTVmcG6xzpYpT3cbpjvdP3VL79PDCwjiKtAZb5YbJWECdj8CKrNFm5SPp0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZcY2Ym8IGq0zSEAfNRuhUBLfZT+X9xGaxnT1Cqno1A=;
 b=3dp4eBtFa8dHH5X+fZZ2t7T6mq2/JRZ8TGqlv5a4gq/Dz0tWmWBVNy/4TPAcWZv7F8fc3mYxFn2M5q/RJo/HRauMwbBW7Hd3Nvgd255BVNPuanBMz9vh0UciVow8uoPIiuJ0jFMlzMNtWyWNjyaD/Ph++VBcjzfKY+T+WRmP2f4=
Received: from MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 14:48:10 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::1b) by MN2PR16CA0027.outlook.office365.com
 (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 14:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 14:48:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 09:48:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 "Andrew
 Davis" <afd@ti.com>, Arturs Artamonovs <arturs.artamonovs@analog.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>, "Emmanuel Di
 Fede" <emmanuel.difede@cysec.com>, Fabio Estevam <festevam@denx.de>, "Joe
 Hershberger" <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 "Kever Yang" <kever.yang@rock-chips.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "Nathan Barrett-Morrison"
 <nathan.morrison@timesys.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, Peter Robinson
 <pbrobinson@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>, "Rayagonda Kokatanur"
 <rayagonda.kokatanur@broadcom.com>, Simon Glass <sjg@chromium.org>, Stefan
 Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>, "Svyatoslav Ryhel"
 <clamor95@gmail.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tim
 Harvey" <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, Tony Dinh
 <mibodhi@gmail.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/4] arm64: versal2: Add support for AMD Versal Gen 2
Date: Wed, 29 May 2024 16:47:58 +0200
Message-ID: <bc2b70831ce1031bd0fac32357bff84936e1310f.1716994063.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716994063.git.michal.simek@amd.com>
References: <cover.1716994063.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=37822; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ARhK7CxkRnVeF0yU41Ji+Q0BPR7zQoH5wsVWemfY2vo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRwB9k339bynn2gbDBxw41KnWcXGNa3Prz4YiXng7fCC
 k8mi3JUdMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJnOpnWDCJxXayRdDFU1+8
 qmxD2aZFsEf8S2ZYMCU961ny3Nisi/kczXdP+Ed/U/93CAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 59057a8c-cd50-425d-4498-08dc7fee5be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|7416005|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N2SimZhY9xkQ2gq5gnvc+waUDgTpYe4uqlVzXPaR7yRDjDiZbgAxQdExsnDn?=
 =?us-ascii?Q?ytGjIFK52LQd7cOXI99tocDAOKgW+lWQhiP/Btn8FFSFFV5S7HF53cmAig7D?=
 =?us-ascii?Q?iX77qhxHV7D9p+dEpxJfSlUap7LhTSIYSfCtZ/p8Ibfdii6hiPtQyOOCoGsJ?=
 =?us-ascii?Q?1RJCvZLMXkkG2WlFyraxuiIaHsTw/6V4gFoM5+fQoq0XAjQ097aNPRL06DnG?=
 =?us-ascii?Q?WQHL4jztTLV3ZESU7ANN42Qjq4AE6ZKoiTgt51shCma7dR3W3qqGL6CQNgAt?=
 =?us-ascii?Q?CN6lzF0xYZAWNJyfkHcSDWBOZXDFzAYOEzhlvGxyEnhVBQMd/ODMBHrEQi8x?=
 =?us-ascii?Q?8jep/YfLQLgzca3WeVs2Ik4h3Q34+ha2TYrsHi/lEFVbAi6oTTn0AXzhqpUZ?=
 =?us-ascii?Q?t3XuiKP6hBM9JI193aOCeToGXF3kofhJrm1LgLV28UDR4NcRu8PF0mWJ++G5?=
 =?us-ascii?Q?0C2Wu999X8sUusWzIsQXRanZVdGfuoVRZfnzh0CnuX4OEAPZx7L7mSlqlRAF?=
 =?us-ascii?Q?Y1PdFyTl5N7aGFYTFIEeNRtpTER/zHrD+xy4JTlsBgS2LB6GdBQGQ+ezT+/e?=
 =?us-ascii?Q?1ZuOahWVAuSd20qOQiYJSerQZETQjB+fzRx664P1UgSDJz3VJkLfymv+wLiT?=
 =?us-ascii?Q?Kvm47Al8HdhEJ+iOtt3UZQsHpUYBLPwZCaq14S/d9f+6PEmgnY9KELHszWNh?=
 =?us-ascii?Q?KvI2NNR4H2tfbhehsoqTAhesbQqHfankLmYCzVMthaw1VCTJjYpTKUrFeVRZ?=
 =?us-ascii?Q?XRroIy4qK3JVOAHr1AIjwi9/aWlWoX/pBtGjUF8DuJ9s35SFqQZ9AEIWVwI6?=
 =?us-ascii?Q?h6vrDviPKA8Q8BVtrUC1qJylgub1XKwCR43RK23X7og6pbBk0YIquGG5j8Nl?=
 =?us-ascii?Q?6nb0t3sHPH+qL2cCpoFqN3gG/dzDQTgGtPl0FMM2Ugd2pXyKhF3I+x/tIRzi?=
 =?us-ascii?Q?R1uzmFsHN5SYmPRIqL/HDRQBD8hAgGojS01DQ/MX6u5OR8p8LzTICudy+6BD?=
 =?us-ascii?Q?Gm4OSFDxuOyakfv4I8VPXIjs/4BStX2pwB8vngnYGkXb1kFqIgRIhoIjAOpe?=
 =?us-ascii?Q?gLrm5sT0yHTK0r0VghEzvMfJnwRqeaZETuuPJQa99gaithzvMnGaffXuXntl?=
 =?us-ascii?Q?rkVoEa+ChWiRfhyABm0lfs8HxDar7lWS4zXE+CQIk5eRUk55P/xVTTEY5ErQ?=
 =?us-ascii?Q?03E19sIoZpzkARJGITGKEGGpLYILJolbLzfcRSvaxivDYys/41WtOkr7Wnso?=
 =?us-ascii?Q?pJ84FuPz2v+MI9tYx/Q6M5CIUy5lATdWj6GmN76vjNHDftwvqLmVLvu7pmFw?=
 =?us-ascii?Q?XTeVy8bS9i17+lCSQsVS7dQB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(7416005)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:48:09.9354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59057a8c-cd50-425d-4498-08dc7fee5be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

Add support for AMD Versal Gen 2. SoC is based on Cortex-a78ae 4 cluster/2
cpu core each. A lot of IPs are shared with previous families. There are
couple of new IP blocks where the most interesting from user point of view
is UFS.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/Kconfig                              |  14 +
 arch/arm/Makefile                             |   1 +
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/amd-versal2-virt.dts             |  11 +
 arch/arm/mach-versal2/Kconfig                 |  55 +++
 arch/arm/mach-versal2/Makefile                |  10 +
 arch/arm/mach-versal2/clk.c                   |  34 ++
 arch/arm/mach-versal2/cpu.c                   |  93 +++++
 arch/arm/mach-versal2/include/mach/hardware.h |  97 +++++
 .../arm/mach-versal2/include/mach/sys_proto.h |   9 +
 board/amd/common                              |   1 +
 board/amd/versal2/Kconfig                     |  16 +
 board/amd/versal2/MAINTAINERS                 |   7 +
 board/amd/versal2/Makefile                    |  11 +
 board/amd/versal2/board.c                     | 343 ++++++++++++++++++
 board/amd/versal2/cmds.c                      |  81 +++++
 board/xilinx/Kconfig                          |   6 +-
 configs/amd_versal2_virt_defconfig            | 145 ++++++++
 drivers/gpio/Kconfig                          |   2 +-
 drivers/mailbox/Kconfig                       |   2 +-
 env/Kconfig                                   |   6 +-
 include/configs/amd_versal2.h                 | 143 ++++++++
 22 files changed, 1081 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/amd-versal2-virt.dts
 create mode 100644 arch/arm/mach-versal2/Kconfig
 create mode 100644 arch/arm/mach-versal2/Makefile
 create mode 100644 arch/arm/mach-versal2/clk.c
 create mode 100644 arch/arm/mach-versal2/cpu.c
 create mode 100644 arch/arm/mach-versal2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-versal2/include/mach/sys_proto.h
 create mode 120000 board/amd/common
 create mode 100644 board/amd/versal2/Kconfig
 create mode 100644 board/amd/versal2/MAINTAINERS
 create mode 100644 board/amd/versal2/Makefile
 create mode 100644 board/amd/versal2/board.c
 create mode 100644 board/amd/versal2/cmds.c
 create mode 100644 configs/amd_versal2_virt_defconfig
 create mode 100644 include/configs/amd_versal2.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d9a4c993c34..db692b2d215a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1235,6 +1235,18 @@ config ARCH_VERSAL
 	imply BOARD_LATE_INIT
 	imply ENV_VARS_UBOOT_RUNTIME_CONFIG
 
+config ARCH_VERSAL2
+	bool "Support AMD Versal Gen 2 Platform"
+	select ARM64
+	select CLK
+	select DM
+	select DM_MMC if MMC
+	select DM_SERIAL
+	select OF_CONTROL
+	imply BOARD_LATE_INIT
+	imply ENV_VARS_UBOOT_RUNTIME_CONFIG
+	imply ZYNQMP_FIRMWARE
+
 config ARCH_VERSAL_NET
 	bool "Support Xilinx Versal NET Platform"
 	select ARM64
@@ -2317,6 +2329,8 @@ source "arch/arm/mach-zynqmp/Kconfig"
 
 source "arch/arm/mach-versal/Kconfig"
 
+source "arch/arm/mach-versal2/Kconfig"
+
 source "arch/arm/mach-versal-net/Kconfig"
 
 source "arch/arm/mach-zynqmp-r5/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 734c6d69926b..dbeedbe544bd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -90,6 +90,7 @@ machine-$(CONFIG_ARCH_OCTEONTX)		+= octeontx
 machine-$(CONFIG_ARCH_OCTEONTX2)	+= octeontx2
 machine-$(CONFIG_ARCH_UNIPHIER)		+= uniphier
 machine-$(CONFIG_ARCH_VERSAL)		+= versal
+machine-$(CONFIG_ARCH_VERSAL2)		+= versal2
 machine-$(CONFIG_ARCH_VERSAL_NET)	+= versal-net
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_ARCH_ZYNQMP)		+= zynqmp
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index f7032f1e1755..45f866dd185b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -345,6 +345,8 @@ dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini-qspi-x2-single.dtb \
 	versal-mini-qspi-x2-stacked.dtb \
 	xilinx-versal-virt.dtb
+dtb-$(CONFIG_ARCH_VERSAL2) += \
+	amd-versal2-virt.dtb
 dtb-$(CONFIG_ARCH_VERSAL_NET) += \
 	versal-net-mini.dtb \
 	versal-net-mini-emmc.dtb \
diff --git a/arch/arm/dts/amd-versal2-virt.dts b/arch/arm/dts/amd-versal2-virt.dts
new file mode 100644
index 000000000000..3b6cbbac5820
--- /dev/null
+++ b/arch/arm/dts/amd-versal2-virt.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Empty device tree for amd-versal2-virt board
+ *
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ */
+
+/dts-v1/;
+
+/ {
+};
diff --git a/arch/arm/mach-versal2/Kconfig b/arch/arm/mach-versal2/Kconfig
new file mode 100644
index 000000000000..3f18e3351aa8
--- /dev/null
+++ b/arch/arm/mach-versal2/Kconfig
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if ARCH_VERSAL2
+
+config SYS_BOARD
+	string "Board name"
+	default "versal2"
+
+config SYS_VENDOR
+	string "Vendor name"
+	default "amd"
+
+config SYS_SOC
+	default "versal2"
+
+config SYS_CONFIG_NAME
+	string "Board configuration name"
+	default "amd_versal2"
+	help
+	  This option contains information about board configuration name.
+	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
+	  will be used for board configuration.
+
+config COUNTER_FREQUENCY
+	int "Timer clock frequency"
+	default 0
+	help
+	  Setup time clock frequency for certain platform
+
+config IOU_SWITCH_DIVISOR0
+	hex "IOU switch divisor0"
+	default 0x20
+	help
+	  Setup time clock divisor for input clock.
+
+config SYS_MEM_RSVD_FOR_MMU
+	bool "Reserve memory for MMU Table"
+	help
+	  If defined this option is used to setup different space for
+	  MMU table than the one which will be allocated during
+	  relocation.
+
+config GICV3
+	def_bool y
+
+config SYS_MALLOC_LEN
+	default 0x2000000
+
+config ZYNQ_SDHCI_MAX_FREQ
+	default 200000000
+
+source "board/xilinx/Kconfig"
+source "board/amd/versal2/Kconfig"
+
+endif
diff --git a/arch/arm/mach-versal2/Makefile b/arch/arm/mach-versal2/Makefile
new file mode 100644
index 000000000000..96497b1dfd0a
--- /dev/null
+++ b/arch/arm/mach-versal2/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2021 - 2022, Xilinx, Inc.
+# Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+#
+# Michal Simek <michal.simek@amd.com>
+#
+
+obj-y	+= clk.o
+obj-y	+= cpu.o
diff --git a/arch/arm/mach-versal2/clk.c b/arch/arm/mach-versal2/clk.c
new file mode 100644
index 000000000000..e73ae9af0761
--- /dev/null
+++ b/arch/arm/mach-versal2/clk.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 - 2022,  Xilinx, Inc.
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <init.h>
+#include <time.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#ifdef CONFIG_CLOCKS
+/**
+ * set_cpu_clk_info - Initialize clock framework
+ *
+ * Return: 0 always.
+ *
+ * This function is called from common code after relocation and sets up the
+ * clock framework. The framework must not be used before this function had been
+ * called.
+ */
+int set_cpu_clk_info(void)
+{
+	gd->cpu_clk = get_tbclk();
+
+	gd->bd->bi_arm_freq = gd->cpu_clk / 1000000;
+	gd->bd->bi_dsp_freq = 0;
+
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
new file mode 100644
index 000000000000..2dfcadb369eb
--- /dev/null
+++ b/arch/arm/mach-versal2/cpu.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <init.h>
+#include <asm/armv8/mmu.h>
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/cache.h>
+#include <dm/platdata.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define VERSAL2_MEM_MAP_USED	5
+
+#define DRAM_BANKS CONFIG_NR_DRAM_BANKS
+
+/* +1 is end of list which needs to be empty */
+#define VERSAL2_MEM_MAP_MAX (VERSAL2_MEM_MAP_USED + DRAM_BANKS + 1)
+
+static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
+	{
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = 0x70000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0xf0000000UL,
+		.phys = 0xf0000000UL,
+		.size = 0x0fe00000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x400000000UL,
+		.phys = 0x400000000UL,
+		.size = 0x200000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x600000000UL,
+		.phys = 0x600000000UL,
+		.size = 0x800000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0xe00000000UL,
+		.phys = 0xe00000000UL,
+		.size = 0xf200000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}
+};
+
+void mem_map_fill(void)
+{
+	int banks = VERSAL2_MEM_MAP_USED;
+
+	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		/* Zero size means no more DDR that's this is end */
+		if (!gd->bd->bi_dram[i].size)
+			break;
+
+		versal2_mem_map[banks].virt = gd->bd->bi_dram[i].start;
+		versal2_mem_map[banks].phys = gd->bd->bi_dram[i].start;
+		versal2_mem_map[banks].size = gd->bd->bi_dram[i].size;
+		versal2_mem_map[banks].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					      PTE_BLOCK_INNER_SHARE;
+		banks = banks + 1;
+	}
+}
+
+struct mm_region *mem_map = versal2_mem_map;
+
+u64 get_page_table_size(void)
+{
+	return 0x14000;
+}
+
+U_BOOT_DRVINFO(soc_amd_versal2) = {
+	.name = "soc_amd_versal2",
+};
diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
new file mode 100644
index 000000000000..42e3061a0aea
--- /dev/null
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ */
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+struct crlapb_regs {
+	u32 reserved0[67];
+	u32 cpu_r5_ctrl;
+	u32 reserved;
+	u32 iou_switch_ctrl; /* 0x114 */
+	u32 reserved1[13];
+	u32 timestamp_ref_ctrl; /* 0x14c */
+	u32 reserved3[108];
+	u32 rst_cpu_r5;
+	u32 reserved2[17];
+	u32 rst_timestamp; /* 0x348 */
+};
+
+struct iou_scntrs_regs {
+	u32 counter_control_register; /* 0x0 */
+	u32 reserved0[7];
+	u32 base_frequency_id_register; /* 0x20 */
+};
+
+struct crp_regs {
+	u32 reserved0[128];
+	u32 boot_mode_usr;	/* 0x200 */
+};
+
+#define VERSAL2_CRL_APB_BASEADDR		0xEB5E0000
+#define VERSAL2_CRP_BASEADDR			0xF1260000
+#define VERSAL2_IOU_SCNTR_SECURE		0xEC920000
+
+#define CRL_APB_TIMESTAMP_REF_CTRL_CLKACT_BIT	BIT(25)
+#define IOU_SWITCH_CTRL_CLKACT_BIT		BIT(25)
+#define IOU_SWITCH_CTRL_DIVISOR0_SHIFT		8
+#define IOU_SCNTRS_CONTROL_EN			1
+
+#define crlapb_base ((struct crlapb_regs *)VERSAL2_CRL_APB_BASEADDR)
+#define crp_base ((struct crp_regs *)VERSAL2_CRP_BASEADDR)
+#define iou_scntr_secure ((struct iou_scntrs_regs *)VERSAL2_IOU_SCNTR_SECURE)
+
+#define PMC_TAP	0xF11A0000
+
+#define PMC_TAP_IDCODE		(PMC_TAP + 0)
+#define PMC_TAP_VERSION		(PMC_TAP + 0x4)
+# define PMC_VERSION_MASK	GENMASK(7, 0)
+# define PS_VERSION_MASK	GENMASK(15, 8)
+# define PS_VERSION_PRODUCTION	0x20
+# define RTL_VERSION_MASK	GENMASK(23, 16)
+# define PLATFORM_MASK		GENMASK(27, 24)
+# define PLATFORM_VERSION_MASK	GENMASK(31, 28)
+#define PMC_TAP_USERCODE	(PMC_TAP + 0x8)
+
+/* Bootmode setting values */
+#define BOOT_MODES_MASK	0x0000000F
+#define QSPI_MODE_24BIT	0x00000001
+#define QSPI_MODE_32BIT	0x00000002
+#define SD_MODE		0x00000003 /* sd 0 */
+#define SD_MODE1	0x00000005 /* sd 1 */
+#define EMMC_MODE	0x00000006
+#define USB_MODE	0x00000007
+#define OSPI_MODE	0x00000008
+#define SELECTMAP_MODE	0x0000000A
+#define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
+#define JTAG_MODE	0x00000000
+#define BOOT_MODE_USE_ALT	0x100
+#define BOOT_MODE_ALT_SHIFT	12
+
+enum versal2_platform {
+	VERSAL2_SILICON = 0,
+	VERSAL2_SPP = 1,
+	VERSAL2_EMU = 2,
+	VERSAL2_QEMU = 3,
+	VERSAL2_SPP_MMD = 5,
+	VERSAL2_EMU_MMD = 6,
+};
+
+#define VERSAL2_SLCR_BASEADDR	0xF1060000
+#define VERSAL_AXI_MUX_SEL	(VERSAL2_SLCR_BASEADDR + 0x504)
+#define VERSAL_OSPI_LINEAR_MODE	BIT(1)
+
+#define FLASH_RESET_GPIO	0xc
+#define WPROT_CRP	0xF126001C
+#define RST_GPIO	0xF1260318
+#define WPROT_LPD_MIO	0xFF080728
+#define WPROT_PMC_MIO	0xF1060828
+#define BOOT_MODE_DIR	0xF1020204
+#define BOOT_MODE_OUT	0xF1020208
+#define MIO_PIN_12	0xF1060030
+#define BANK0_OUTPUT	0xF1020040
+#define BANK0_TRI	0xF1060200
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
new file mode 100644
index 000000000000..7b1726a7ef40
--- /dev/null
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/build_bug.h>
+
+void mem_map_fill(void);
diff --git a/board/amd/common b/board/amd/common
new file mode 120000
index 000000000000..cd4d172974b5
--- /dev/null
+++ b/board/amd/common
@@ -0,0 +1 @@
+../xilinx/common/
\ No newline at end of file
diff --git a/board/amd/versal2/Kconfig b/board/amd/versal2/Kconfig
new file mode 100644
index 000000000000..ab46af6935ef
--- /dev/null
+++ b/board/amd/versal2/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 - 2022, Xilinx, Inc.
+# Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+#
+if ARCH_VERSAL2
+
+config CMD_VERSAL2
+	bool "Enable Versal Gen 2 specific commands"
+	default y
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Select this to enable AMD Versal Gen 2 specific commands.
+	  Commands like versal2 loadpdi are enabled by this.
+
+endif
diff --git a/board/amd/versal2/MAINTAINERS b/board/amd/versal2/MAINTAINERS
new file mode 100644
index 000000000000..af7913d8db3a
--- /dev/null
+++ b/board/amd/versal2/MAINTAINERS
@@ -0,0 +1,7 @@
+XILINX_VERSAL2 BOARDS
+M:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+T:	git https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze.git
+F:	arch/arm/dts/versal2*
+F:	board/amd/
+F:	configs/amd*
diff --git a/board/amd/versal2/Makefile b/board/amd/versal2/Makefile
new file mode 100644
index 000000000000..3a044517f0c7
--- /dev/null
+++ b/board/amd/versal2/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2021 - 2022, Xilinx, Inc.
+# Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+#
+# Michal Simek <michal.simek@amd.com>
+#
+
+obj-y	:= board.o
+
+obj-$(CONFIG_CMD_VERSAL2)   += cmds.o
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
new file mode 100644
index 000000000000..5651d516a9e3
--- /dev/null
+++ b/board/amd/versal2/board.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <cpu_func.h>
+#include <fdtdec.h>
+#include <init.h>
+#include <env_internal.h>
+#include <log.h>
+#include <malloc.h>
+#include <time.h>
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include "../../xilinx/common/board.h"
+
+#include <linux/bitfield.h>
+#include <debug_uart.h>
+#include <generated/dt.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	printf("EL Level:\tEL%d\n", current_el());
+
+	return 0;
+}
+
+static u32 platform_id, platform_version;
+
+char *soc_name_decode(void)
+{
+	char *name, *platform_name;
+
+	switch (platform_id) {
+	case VERSAL2_SPP:
+		platform_name = "spp";
+		break;
+	case VERSAL2_EMU:
+		platform_name = "emu";
+		break;
+	case VERSAL2_SPP_MMD:
+		platform_name = "spp-mmd";
+		break;
+	case VERSAL2_EMU_MMD:
+		platform_name = "emu-mmd";
+		break;
+	case VERSAL2_QEMU:
+		platform_name = "qemu";
+		break;
+	default:
+		return NULL;
+	}
+
+	/*
+	 * --rev. are 6 chars
+	 * max platform name is qemu which is 4 chars
+	 * platform version number are 1+1
+	 * Plus 1 char for \n
+	 */
+	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 13);
+	if (!name)
+		return NULL;
+
+	sprintf(name, "%s-%s-rev%d.%d-el%d", CONFIG_SYS_BOARD,
+		platform_name, platform_version / 10,
+		platform_version % 10, current_el());
+
+	return name;
+}
+
+bool soc_detection(void)
+{
+	u32 version, ps_version;
+
+	version = readl(PMC_TAP_VERSION);
+	platform_id = FIELD_GET(PLATFORM_MASK, version);
+	ps_version = FIELD_GET(PS_VERSION_MASK, version);
+
+	debug("idcode %x, version %x, usercode %x\n",
+	      readl(PMC_TAP_IDCODE), version,
+	      readl(PMC_TAP_USERCODE));
+
+	debug("pmc_ver %lx, ps version %x, rtl version %lx\n",
+	      FIELD_GET(PMC_VERSION_MASK, version),
+	      ps_version,
+	      FIELD_GET(RTL_VERSION_MASK, version));
+
+	platform_version = FIELD_GET(PLATFORM_VERSION_MASK, version);
+
+	debug("Platform id: %d version: %d.%d\n", platform_id,
+	      platform_version / 10, platform_version % 10);
+
+	return true;
+}
+
+int board_early_init_r(void)
+{
+	u32 val;
+
+	if (current_el() != 3)
+		return 0;
+
+	debug("iou_switch ctrl div0 %x\n",
+	      readl(&crlapb_base->iou_switch_ctrl));
+
+	writel(IOU_SWITCH_CTRL_CLKACT_BIT |
+	       (CONFIG_IOU_SWITCH_DIVISOR0 << IOU_SWITCH_CTRL_DIVISOR0_SHIFT),
+	       &crlapb_base->iou_switch_ctrl);
+
+	/* Global timer init - Program time stamp reference clk */
+	val = readl(&crlapb_base->timestamp_ref_ctrl);
+	val |= CRL_APB_TIMESTAMP_REF_CTRL_CLKACT_BIT;
+	writel(val, &crlapb_base->timestamp_ref_ctrl);
+
+	debug("ref ctrl 0x%x\n",
+	      readl(&crlapb_base->timestamp_ref_ctrl));
+
+	/* Clear reset of timestamp reg */
+	writel(0, &crlapb_base->rst_timestamp);
+
+	/*
+	 * Program freq register in System counter and
+	 * enable system counter.
+	 */
+	writel(CONFIG_COUNTER_FREQUENCY,
+	       &iou_scntr_secure->base_frequency_id_register);
+
+	debug("counter val 0x%x\n",
+	      readl(&iou_scntr_secure->base_frequency_id_register));
+
+	writel(IOU_SCNTRS_CONTROL_EN,
+	       &iou_scntr_secure->counter_control_register);
+
+	debug("scntrs control 0x%x\n",
+	      readl(&iou_scntr_secure->counter_control_register));
+	debug("timer 0x%llx\n", get_ticks());
+	debug("timer 0x%llx\n", get_ticks());
+
+	return 0;
+}
+
+static u8 versal_net_get_bootmode(void)
+{
+	u8 bootmode;
+	u32 reg = 0;
+
+	reg = readl(&crp_base->boot_mode_usr);
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	bootmode = reg & BOOT_MODES_MASK;
+
+	return bootmode;
+}
+
+static int boot_targets_setup(void)
+{
+	u8 bootmode;
+	struct udevice *dev;
+	int bootseq = -1;
+	int bootseq_len = 0;
+	int env_targets_len = 0;
+	const char *mode = NULL;
+	char *new_targets;
+	char *env_targets;
+
+	bootmode = versal_net_get_bootmode();
+
+	puts("Bootmode: ");
+	switch (bootmode) {
+	case USB_MODE:
+		puts("USB_MODE\n");
+		mode = "usb_dfu0 usb_dfu1";
+		break;
+	case JTAG_MODE:
+		puts("JTAG_MODE\n");
+		mode = "jtag pxe dhcp";
+		break;
+	case QSPI_MODE_24BIT:
+		puts("QSPI_MODE_24\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1030000", &dev)) {
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
+		}
+		mode = "xspi";
+		bootseq = dev_seq(dev);
+		break;
+	case QSPI_MODE_32BIT:
+		puts("QSPI_MODE_32\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1030000", &dev)) {
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
+		}
+		mode = "xspi";
+		bootseq = dev_seq(dev);
+		break;
+	case OSPI_MODE:
+		puts("OSPI_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1010000", &dev)) {
+			debug("OSPI driver for OSPI device is not present\n");
+			break;
+		}
+		mode = "xspi";
+		bootseq = dev_seq(dev);
+		break;
+	case EMMC_MODE:
+		puts("EMMC_MODE\n");
+		mode = "mmc";
+		bootseq = dev_seq(dev);
+		break;
+	case SELECTMAP_MODE:
+		puts("SELECTMAP_MODE\n");
+		break;
+	case SD_MODE:
+		puts("SD_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_MMC,
+					      "mmc@f1040000", &dev)) {
+			debug("SD0 driver for SD0 device is not present\n");
+			break;
+		}
+		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
+
+		mode = "mmc";
+		bootseq = dev_seq(dev);
+		break;
+	case SD1_LSHFT_MODE:
+		puts("LVL_SHFT_");
+		fallthrough;
+	case SD_MODE1:
+		puts("SD_MODE1\n");
+		if (uclass_get_device_by_name(UCLASS_MMC,
+					      "mmc@f1050000", &dev)) {
+			debug("SD1 driver for SD1 device is not present\n");
+			break;
+		}
+		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
+
+		mode = "mmc";
+		bootseq = dev_seq(dev);
+		break;
+	default:
+		printf("Invalid Boot Mode:0x%x\n", bootmode);
+		break;
+	}
+
+	if (mode) {
+		if (bootseq >= 0) {
+			bootseq_len = snprintf(NULL, 0, "%i", bootseq);
+			debug("Bootseq len: %x\n", bootseq_len);
+		}
+
+		/*
+		 * One terminating char + one byte for space between mode
+		 * and default boot_targets
+		 */
+		env_targets = env_get("boot_targets");
+		if (env_targets)
+			env_targets_len = strlen(env_targets);
+
+		new_targets = calloc(1, strlen(mode) + env_targets_len + 2 +
+				     bootseq_len);
+		if (!new_targets)
+			return -ENOMEM;
+
+		if (bootseq >= 0)
+			sprintf(new_targets, "%s%x %s", mode, bootseq,
+				env_targets ? env_targets : "");
+		else
+			sprintf(new_targets, "%s %s", mode,
+				env_targets ? env_targets : "");
+
+		env_set("boot_targets", new_targets);
+	}
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	int ret;
+
+	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
+		debug("Saved variables - Skipping\n");
+		return 0;
+	}
+
+	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
+		ret = boot_targets_setup();
+		if (ret)
+			return ret;
+	}
+
+	return board_late_init_xilinx();
+}
+
+int dram_init_banksize(void)
+{
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+
+	mem_map_fill();
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_SYS_MEM_RSVD_FOR_MMU))
+		ret = fdtdec_setup_mem_size_base();
+	else
+		ret = fdtdec_setup_mem_size_base_lowest();
+
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+void reset_cpu(void)
+{
+}
diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
new file mode 100644
index 000000000000..fbd99918a7f4
--- /dev/null
+++ b/board/amd/versal2/cmds.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <cpu_func.h>
+#include <command.h>
+#include <log.h>
+#include <memalign.h>
+#include <versalpl.h>
+#include <vsprintf.h>
+#include <zynqmp_firmware.h>
+
+/**
+ * do_versal2_load_pdi - Handle the "versal2 load pdi" command-line command
+ * @cmdtp:      Command data struct pointer
+ * @flag:       Command flag
+ * @argc:       Command-line argument count
+ * @argv:       Array of command-line arguments
+ *
+ * Processes the versal2 load pdi command
+ *
+ * Return: return 0 on success, Error value if command fails.
+ * CMD_RET_USAGE incase of incorrect/missing parameters.
+ */
+static int do_versal2_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
+			       char * const argv[])
+{
+	u32 buf_lo, buf_hi;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	ulong addr, *pdi_buf;
+	size_t len;
+	int ret;
+
+	if (argc != cmdtp->maxargs) {
+		debug("pdi_load: incorrect parameters passed\n");
+		return CMD_RET_USAGE;
+	}
+
+	addr = simple_strtol(argv[1], NULL, 16);
+	if (!addr) {
+		debug("pdi_load: zero pdi_data address\n");
+		return CMD_RET_USAGE;
+	}
+
+	len = hextoul(argv[2], NULL);
+	if (!len) {
+		debug("pdi_load: zero size\n");
+		return CMD_RET_USAGE;
+	}
+
+	pdi_buf = (ulong *)ALIGN((ulong)addr, ARCH_DMA_MINALIGN);
+	if ((ulong)addr != (ulong)pdi_buf) {
+		memcpy((void *)pdi_buf, (void *)addr, len);
+		debug("Pdi addr:0x%lx aligned to 0x%lx\n",
+		      addr, (ulong)pdi_buf);
+	}
+
+	flush_dcache_range((ulong)pdi_buf, (ulong)pdi_buf + len);
+
+	buf_lo = lower_32_bits((ulong)pdi_buf);
+	buf_hi = upper_32_bits((ulong)pdi_buf);
+
+	ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
+				buf_hi, 0, ret_payload);
+	if (ret)
+		printf("PDI load failed with err: 0x%08x\n", ret);
+
+	return cmd_process_error(cmdtp, ret);
+}
+
+static char versal2_help_text[] =
+	"loadpdi addr len - Load pdi image\n"
+	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
+;
+
+U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2_help_text,
+			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
+					    do_versal2_load_pdi));
diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index 5c4ad8f1df9a..c7df4ab5781a 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -42,7 +42,7 @@ endif
 
 config XILINX_OF_BOARD_DTB_ADDR
 	hex "Default DTB pickup address"
-	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET
+	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0x8000 if MICROBLAZE
 	default 0x100000 if ARCH_ZYNQ || ARCH_ZYNQMP
 	default 0x23000000 if TARGET_XILINX_MBV
@@ -52,10 +52,10 @@ config XILINX_OF_BOARD_DTB_ADDR
 
 config BOOT_SCRIPT_OFFSET
 	hex "Boot script offset"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || MICROBLAZE || TARGET_XILINX_MBV
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || MICROBLAZE || TARGET_XILINX_MBV
 	default 0xFC0000 if ARCH_ZYNQ || MICROBLAZE
 	default 0x3E80000 if ARCH_ZYNQMP
-	default 0x7F80000 if ARCH_VERSAL || ARCH_VERSAL_NET
+	default 0x7F80000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0 if TARGET_XILINX_MBV
 	help
 	   Specifies distro boot script offset in NAND/QSPI/NOR flash.
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
new file mode 100644
index 000000000000..5eea07f03f51
--- /dev/null
+++ b/configs/amd_versal2_virt_defconfig
@@ -0,0 +1,145 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=375000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_ARCH_VERSAL2=y
+CONFIG_TEXT_BASE=0x8000000
+CONFIG_SYS_MALLOC_F_LEN=0x100000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_BASE=0xf1920000
+CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_CMD_FRU=y
+CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_DEBUG_UART=y
+CONFIG_SYS_MEMTEST_START=0x00000000
+CONFIG_SYS_MEMTEST_END=0x00001000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SYS_BOOTM_LEN=0x6400000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=5
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=2073
+CONFIG_BOARD_EARLY_INIT_R=y
+CONFIG_CLOCKS=y
+CONFIG_SYS_PROMPT="versal2> "
+CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_SHA1SUM=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_UFS=y
+CONFIG_CMD_USB=y
+CONFIG_BOOTP_MAY_FAIL=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_SMC=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_SCMI=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_SQUASHFS=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_UBI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_OF_BOARD=y
+CONFIG_DTB_RESELECT=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_NETCONSOLE=y
+CONFIG_IP_DEFRAG=y
+CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_DFU_RAM=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_CADENCE=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_DM_MAILBOX=y
+CONFIG_ZYNQMP_IPI=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_NATSEMI=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_VITESSE=y
+CONFIG_PHY_FIXED=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_XILINX_AXIEMAC=y
+CONFIG_ZYNQ_GEM=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_RESET_SCMI=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_ARM_DCC=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_XILINX_UARTLITE=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ZYNQ_SPI=y
+CONFIG_TPM2_TIS_SPI=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Xilinx"
+CONFIG_USB_GADGET_VENDOR_NUM=0x03FD
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_THOR=y
+CONFIG_UFS=y
+CONFIG_CADENCE_UFS=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_TPM=y
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b050585389bb..2c0e244b9e41 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -487,7 +487,7 @@ config MVEBU_GPIO
 config ZYNQ_GPIO
 	bool "Zynq GPIO driver"
 	depends on DM_GPIO
-	default y if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL
+	default y if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL2
 	help
 	  Supports GPIO access on Zynq SoC.
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 47f24e0a02e0..67d5ac1a7422 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -54,7 +54,7 @@ config K3_SEC_PROXY
 
 config ZYNQMP_IPI
 	bool "Xilinx ZynqMP IPI controller support"
-	depends on DM_MAILBOX && (ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET)
+	depends on DM_MAILBOX && (ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
 	help
 	  This enables support for the Xilinx ZynqMP Inter Processor Interrupt
 	  communication controller.
diff --git a/env/Kconfig b/env/Kconfig
index 9641abe371a0..451bab45ea7b 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -570,7 +570,7 @@ config ENV_OFFSET
 	default 0xF0000 if ARCH_SUNXI
 	default 0xE0000 if ARCH_ZYNQ
 	default 0x1E00000 if ARCH_ZYNQMP
-	default 0x7F40000 if ARCH_VERSAL || ARCH_VERSAL_NET
+	default 0x7F40000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0x0 if ARC
 	default 0x140000 if ARCH_AT91
 	default 0x260000 if ARCH_OMAP2PLUS
@@ -605,7 +605,7 @@ config ENV_SIZE
 	default 0x10000 if ARCH_SUNXI
 	default 0x8000 if ARCH_ROCKCHIP && ENV_IS_IN_MMC
 	default 0x2000 if ARCH_ROCKCHIP && ENV_IS_IN_SPI_FLASH
-	default 0x8000 if ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET
+	default 0x8000 if ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0x4000 if ARC
 	default 0x1f000
 	help
@@ -615,7 +615,7 @@ config ENV_SECT_SIZE
 	hex "Environment Sector-Size"
 	depends on ENV_IS_IN_FLASH || ENV_IS_IN_SPI_FLASH
 	default 0x2000 if ARCH_ROCKCHIP
-	default 0x40000 if ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET
+	default 0x40000 if ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0x20000 if ARCH_ZYNQ || ARCH_OMAP2PLUS || ARCH_AT91
 	default 0x20000 if MICROBLAZE && ENV_IS_IN_SPI_FLASH
 	default 0x10000 if ARCH_SUNXI && ENV_IS_IN_SPI_FLASH
diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
new file mode 100644
index 000000000000..6a40bbdf3a72
--- /dev/null
+++ b/include/configs/amd_versal2.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for AMD Versal Gen 2
+ * Copyright (C) 2016 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ *
+ * Based on Configuration for Xilinx ZynqMP
+ */
+
+#ifndef __AMD_VERSAL2_H
+#define __AMD_VERSAL2_H
+
+/* FIXME this is causing issue at least on IPP */
+/* #define CONFIG_ARMV8_SWITCH_TO_EL1 */
+
+/* Generic Interrupt Controller Definitions */
+#define GICD_BASE	0xF9000000
+#define GICR_BASE	0xF9060000
+
+/* Serial setup */
+#define CFG_SYS_BAUDRATE_TABLE \
+	{ 4800, 9600, 19200, 38400, 57600, 115200 }
+
+#if defined(CONFIG_CMD_DFU)
+#define DFU_DEFAULT_POLL_TIMEOUT	300
+#define DFU_ALT_INFO_RAM \
+	"dfu_ram_info=" \
+	"setenv dfu_alt_info " \
+	"Image ram 80000 $kernel_size_r\\\\;" \
+	"system.dtb ram $fdt_addr_r $fdt_size_r\0" \
+	"dfu_ram=run dfu_ram_info && dfu 0 ram 0\0" \
+	"thor_ram=run dfu_ram_info && thordown 0 ram 0\0"
+
+#define DFU_ALT_INFO  \
+		DFU_ALT_INFO_RAM
+#endif
+
+#if !defined(DFU_ALT_INFO)
+# define DFU_ALT_INFO
+#endif
+
+/* Ethernet driver */
+#if defined(CONFIG_ZYNQ_GEM)
+# define PHY_ANEG_TIMEOUT	20000
+#endif
+
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"fdt_addr_r=0x40000000\0" \
+	"fdt_size_r=0x400000\0" \
+	"pxefile_addr_r=0x10000000\0" \
+	"kernel_addr_r=0x18000000\0" \
+	"kernel_size_r=0x10000000\0" \
+	"kernel_comp_addr_r=0x30000000\0" \
+	"kernel_comp_size=0x3C00000\0" \
+	"ramdisk_addr_r=0x02100000\0" \
+	"script_size_f=0x80000\0"
+
+#if defined(CONFIG_DISTRO_DEFAULTS)
+
+#if defined(CONFIG_MMC_SDHCI_ZYNQ)
+# define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
+#else
+# define BOOT_TARGET_DEVICES_MMC(func)
+#endif
+
+#if defined(CONFIG_CMD_PXE) && defined(CONFIG_CMD_DHCP)
+# define BOOT_TARGET_DEVICES_PXE(func)	func(PXE, pxe, na)
+#else
+# define BOOT_TARGET_DEVICES_PXE(func)
+#endif
+
+#if defined(CONFIG_CMD_DHCP)
+# define BOOT_TARGET_DEVICES_DHCP(func)	func(DHCP, dhcp, na)
+#else
+# define BOOT_TARGET_DEVICES_DHCP(func)
+#endif
+
+#if defined(CONFIG_ZYNQMP_GQSPI) || defined(CONFIG_CADENCE_OSPI_VERSAL)
+# define BOOT_TARGET_DEVICES_XSPI(func)	func(XSPI, xspi, 0) func(XSPI, xspi, 1)
+# define BOOTENV_DEV_SHARED_XSPI \
+	"xspi_boot=sf probe $devnum_xspi:0 0 0 && " \
+	"sf read $scriptaddr $script_offset_f $script_size_f && " \
+	"echo XSPI: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; echo XSPI: SCRIPT FAILED: continuing...;\0"
+#else
+# define BOOT_TARGET_DEVICES_XSPI(func)
+# define BOOTENV_DEV_SHARED_XSPI
+#endif
+
+#define BOOTENV_DEV_XSPI(devtypeu, devtypel, instance) \
+	"bootcmd_" #devtypel #instance "=" \
+	"devnum_xspi=" #instance "; run " #devtypel "_boot\0" \
+
+#define BOOTENV_DEV_NAME_XSPI(devtypeu, devtypel, instance) \
+	""
+
+#define BOOT_TARGET_DEVICES_JTAG(func)	func(JTAG, jtag, na)
+
+#define BOOTENV_DEV_JTAG(devtypeu, devtypel, instance) \
+	"bootcmd_jtag=echo JTAG: Trying to boot script at ${scriptaddr} && " \
+		"source ${scriptaddr}; echo JTAG: SCRIPT FAILED: continuing...;\0"
+
+#define BOOTENV_DEV_NAME_JTAG(devtypeu, devtypel, instance) \
+	"jtag "
+
+#define BOOT_TARGET_DEVICES_DFU_USB(func)  func(DFU_USB, dfu_usb, 0)
+
+#define BOOTENV_DEV_DFU_USB(devtypeu, devtypel, instance) \
+	"bootcmd_dfu_usb=setenv dfu_alt_info boot.scr ram $scriptaddr " \
+	"$script_size_f; dfu 0 ram 0 && " \
+	"echo DFU: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo DFU: SCRIPT FAILED: continuing...;\0"
+
+#define BOOTENV_DEV_NAME_DFU_USB(devtypeu, devtypel, instance) \
+	""
+
+#define BOOT_TARGET_DEVICES(func) \
+	BOOT_TARGET_DEVICES_JTAG(func) \
+	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_XSPI(func) \
+	BOOT_TARGET_DEVICES_DFU_USB(func) \
+	BOOT_TARGET_DEVICES_PXE(func) \
+	BOOT_TARGET_DEVICES_DHCP(func)
+
+#include <config_distro_bootcmd.h>
+
+#else /* CONFIG_DISTRO_DEFAULTS */
+# define BOOTENV
+#endif /* CONFIG_DISTRO_DEFAULTS */
+
+/* Initial environment variables */
+#ifndef CFG_EXTRA_ENV_SETTINGS
+#define CFG_EXTRA_ENV_SETTINGS \
+	ENV_MEM_LAYOUT_SETTINGS \
+	BOOTENV \
+	BOOTENV_DEV_SHARED_XSPI \
+	DFU_ALT_INFO
+#endif
+
+#endif /* __AMD_VERSAL2_H */
-- 
2.40.1

