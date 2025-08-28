Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5582EC8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C20B832C8;
	Thu, 28 Aug 2025 15:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5oROeGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8147A8328F; Thu, 28 Aug 2025 15:43:05 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA10A8334F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBJEVxKsCCcUGPUUnhF1MHm80vJJvJoLzANMtHTHL+BRJbGRNWS21jfxSJlxYHGz8sN2SHVFF+SCEMv8FI76WqtJhNg4pYyoNsiyXBRonVvOIFKSZYnZYqp7mP14OdUJEE9ERMPOusmAmaNEz1GrkoYtMvyo/9wPEkNqOxpmuYPcMldRQhElUo/qexZWaY9ZIZs6tpGmSCE0g0/8zAWOmWyysYUAfmguq+xY1171U82A3dDuO6wBZP0ZdFeEFkT0fc3z95f5n/Vte2yzk1W61eNpJF1DFJUlJXuWoL8tf55isX2NCJQe3smKwy99eXb5UPfkoY38J8yyflG/zOoCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjLm7M3TZy4kFdyzCvjDDMRmU0t3KSwIxxSiG1rCnwg=;
 b=tuhc+YHT/sz0C5JlSYPb3JTJu3lPxrnWflFaJyG16oZAsXqQ8h8p597lAzPMvUnwVbM+waQ9g5txn0+PgY3v9phqXgUA7SXzB0OZYSKrmNNwDg/Hz7NdaErc9J9JnoOHBbW9MjG5E7kzJhh+opIIuq63eO9/vzWe3XlJuc2Ua//BbXSsYqEeCewTwoF/fQn0F4RffLP76ff6Q8i9PXZliVRE74a/N+2qBB7PgWvKWKg86ScX/mGLWDZigkMVDR1HnyTNGJLF4yvtW+7V5uonyV0FzUF0eQk8U/H6dOkidApjtvNO3pCcVwQqIUikzajksob0Xuonk8nYW94joARzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjLm7M3TZy4kFdyzCvjDDMRmU0t3KSwIxxSiG1rCnwg=;
 b=r5oROeGEVEUB4yK8C3BpQj4JOeKc+cntU5n3yLRfszXrd9SXD+IL/ySN3gJ4YWLNvx+bbVXx7BUql7Tta/OFi5xe3Wso5XDl8wPbEJjhbkJXL/wuz3dhZYdP2QS1aMfZgI466sjm1e9DDj5ysKF9zkFAdeqj6YcZXH+nYco+3dk=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 13:42:48 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::b2) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Thu,
 28 Aug 2025 13:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 13:42:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 08:42:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 08:42:34 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 08:42:34 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, =?UTF-8?q?Benjamin=20Sz=C5=91ke?=
 <egyszeregy@freemail.hu>, Boon Khai Ng <boon.khai.ng@altera.com>, E Shattow
 <e@freeshell.de>, =?UTF-8?q?Frank=20B=C3=B6wingloh?=
 <f.boewingloh@beckhoff.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Jonathan Humphreys <j-humphreys@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, "Peng Fan" <peng.fan@nxp.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, Prasad Kummari
 <prasad.kummari@amd.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav Abbarapu"
 <venkatesh.abbarapu@amd.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>
Subject: [PATCH 3/3] drivers: firmware: update xilinx_pm_request to support
 max payload
Date: Thu, 28 Aug 2025 15:42:22 +0200
Message-ID: <5ae6b560741f3ca8b89059c4ebb87acf75b4718e.1756388537.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
References: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28117; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=F/kA70POiDA4Tr4ZmuXbSOa1ec73DRIPC4twRFXilYw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRsiDk44dO1a/bvYmoV09zDWXyFejZuurbVqSww5/ISp
 pcPAowZO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi8lMZ/gdcjHW5l541R33z
 ZXUuffvbnuy87Bv/TLlX0H3z8O4D/lmMDIuyROOsbyv39QQWm/2b9eiaUr1oVbvM5rgHxh87Ppx
 5wwQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed327e1-6834-47ba-73fd-08dde638c675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DEgrzKpphOwH9rgeFIMjqyXWimb9U1pKpo68JFL3bpD4CnuGHECjN12npZMh?=
 =?us-ascii?Q?7VTzIJIq9VGxon0MBp5YdBHoAfDNVObmmrB9Cqt54NyHj2Ti4nwnmrTXYpcL?=
 =?us-ascii?Q?sLt8Ca06KFnZ/cXtXoRXBwGH9pJGPMBopXXhkA3A+KtrkXmjrflab/+zpz5B?=
 =?us-ascii?Q?8pYi3onZWzBm1xQ4CThKOTgVdhGRadwwv5YJ9UbaGBH0FlURXlS/2kp6KzqT?=
 =?us-ascii?Q?pArxrcRjC7zT2kheqwF0aAhVsOHcGt9etTCt04BOemHIyUgNbc2JHmwyfUXn?=
 =?us-ascii?Q?mP+fNoSpS2MaQ3LcXJIV66BKfyHpK92z0DC974bNuVLcodNpEPt/cJIw6wrH?=
 =?us-ascii?Q?hXTxGdYlGTGvPLywf7Ra9pf0J3rHOsCeUUyw3v7L1DHXVAMw1FSdzYRP3fvd?=
 =?us-ascii?Q?Usic1K5rRHwDgF1fwr6OoY7UfwpVrtt1kcS2JJKwf/of7NJYbd13RZvfU92E?=
 =?us-ascii?Q?eqoL5xYtL7bQRtEZSKFdePMX3soyOOQfeEMLVTT1E3JVMn30DqA+GK0rdlk6?=
 =?us-ascii?Q?yQba4/Qwnb9OtOrSmP7LHy1vV8BFeKBhYqHn9Y5rUGsUToJbQgleaxQO2bZD?=
 =?us-ascii?Q?PFal2Q+CKDz6KGedMiLOtY9UAl/JN13TIwu9xMHwhUeX3k7vLzvzEdIfUb7X?=
 =?us-ascii?Q?GqMAhSKjYOI+nIeqAzyetn3ElpJlRyo78NKb903YFV/tTqHTnTXC13gA/Z+/?=
 =?us-ascii?Q?t5n9PZefabv23f1ryuFE0VDMgmb3CIH1X7kyJJDKQwyOySMAhlqT9F9wFgmM?=
 =?us-ascii?Q?8wmAg1jfpSBtAQEnX/lFfep+08G0E+3kzO9/xvs8swC8IEXkry1+NSM1uREI?=
 =?us-ascii?Q?uc8pqnGPmhATh1Z55ITtbDEAE7RkvIMp7wtbSsUdD6ahWdoLSt7LMvGDuGPr?=
 =?us-ascii?Q?Rkba5PVl8dQHwlTmW6hp0R04Xj+HkzqOsBtVkW7wyDSmkUGxUWS+2O0u9k6y?=
 =?us-ascii?Q?Ha0QpbAadEKLTs7voU4jfPty75iHD2bhdlaMrDybiZxkxA4gvtUUCGcjC/57?=
 =?us-ascii?Q?FZ7tTzc5y/9Ocy13dEADFa95yEXPkeG7TPV1Bp+PdWf4g0r1QhRa0dGP12hQ?=
 =?us-ascii?Q?+ypoFIxpOZv4drGRncDXWMCMFNDYclgbvyfIsrTnPS9DOsHWR3tlP0C1HoVr?=
 =?us-ascii?Q?BraSBs0QNcaaL43YoOtp9k1JOIt75RmsdrkXpmfQVLNT7aztz2nZMqEWTp/M?=
 =?us-ascii?Q?dXfF9OoyaobwThbHNwEPV/DRSk4Q+0wgcqHdwHkaLvC9ouokiTH9fAUQJcK3?=
 =?us-ascii?Q?w5RzhwQ28fsbgaEE16SIfl1DWUqH0viU/fEb2usfZqPsbuJrFE3t/d1YG1Qq?=
 =?us-ascii?Q?9Y9fbase0Lfh1X47yUQl8rZvdLMO3TChqDTCPtqqiiBZUjv/9xnbvxKBf8aZ?=
 =?us-ascii?Q?g0JXPjdNdjrQGsvWi0PiK/dn0Y/GViMHu6xrj2iTW6T8/7CK8U+dG75K52td?=
 =?us-ascii?Q?E7EVmNqtlDTo18dEdADc/Kk3dSjS4DOahgNy57a3y7WDZsCXcYy59y2AKjAd?=
 =?us-ascii?Q?/zdhZnff2Vn+uWToAG57ryP1AS7dE447ijx7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:42:47.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed327e1-6834-47ba-73fd-08dde638c675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
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

From: Naman Trivedi <naman.trivedimanojbhai@amd.com>

Currently xilinx_pm_request API supports four u32 payloads. However the
legacy SMC format supports five u32 request payloads and extended SMC
format supports six u32 request payloads. Add support for the same in
xilinx_pm_request API. Also add two dummy arguments to all the callers
of xilinx_pm_request.

The TF-A always fills seven u32 return payload so add support
for the same in xilinx_pm_request API.

Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Acked-by: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynqmp/aes.c                 |  3 +-
 arch/arm/mach-zynqmp/cpu.c                 |  4 +--
 arch/arm/mach-zynqmp/zynqmp.c              | 10 +++---
 board/xilinx/zynqmp/zynqmp.c               |  2 +-
 drivers/clk/clk_versal.c                   | 25 +++++++++------
 drivers/firmware/firmware-zynqmp.c         | 36 +++++++++++++---------
 drivers/fpga/versalpl.c                    |  5 ++-
 drivers/fpga/zynqmppl.c                    |  8 ++---
 drivers/gpio/zynqmp_gpio_modepin.c         |  4 +--
 drivers/mmc/zynq_sdhci.c                   | 13 +++++---
 drivers/pinctrl/pinctrl-zynqmp.c           | 24 +++++++++------
 drivers/power/domain/zynqmp-power-domain.c |  2 +-
 drivers/reset/reset-zynqmp.c               |  2 +-
 drivers/soc/soc_amd_versal2.c              |  2 +-
 drivers/soc/soc_xilinx_versal.c            |  2 +-
 drivers/soc/soc_xilinx_versal_net.c        |  2 +-
 drivers/soc/soc_xilinx_zynqmp.c            |  2 +-
 drivers/spi/cadence_ospi_versal.c          |  4 +--
 drivers/spi/cadence_qspi.c                 |  2 +-
 include/zynqmp_firmware.h                  |  8 ++---
 20 files changed, 90 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-zynqmp/aes.c b/arch/arm/mach-zynqmp/aes.c
index 9a05fbf9c11b..dec428c159e7 100644
--- a/arch/arm/mach-zynqmp/aes.c
+++ b/arch/arm/mach-zynqmp/aes.c
@@ -47,7 +47,8 @@ int zynqmp_aes_operation(struct zynqmp_aes *aes)
 			   roundup(sizeof(struct zynqmp_aes), ARCH_DMA_MINALIGN));
 
 	ret = xilinx_pm_request(PM_SECURE_AES, upper_32_bits((ulong)aes),
-				lower_32_bits((ulong)aes), 0, 0, ret_payload);
+				lower_32_bits((ulong)aes), 0, 0, 0, 0,
+				ret_payload);
 	if (ret || ret_payload[1]) {
 		printf("Failed: AES op status:0x%x, errcode:0x%x\n",
 		       ret, ret_payload[1]);
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index b7a4142fd546..5f194aaff9a4 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -205,7 +205,7 @@ int zynqmp_mmio_write(const u32 address,
 #if defined(CONFIG_ZYNQMP_FIRMWARE)
 	else
 		return xilinx_pm_request(PM_MMIO_WRITE, address, mask,
-					 value, 0, NULL);
+					 value, 0, 0, 0, NULL);
 #endif
 
 	return -EINVAL;
@@ -226,7 +226,7 @@ int zynqmp_mmio_read(const u32 address, u32 *value)
 		u32 ret_payload[PAYLOAD_ARG_CNT];
 
 		ret = xilinx_pm_request(PM_MMIO_READ, address, 0, 0,
-					0, ret_payload);
+					0, 0, 0, ret_payload);
 		*value = ret_payload[1];
 	}
 #endif
diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index 279006b4d138..c0398a466ff7 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -57,7 +57,7 @@ static int do_zynqmp_verify_secure(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	ret = xilinx_pm_request(PM_SECURE_IMAGE, src_lo, src_hi,
-				key_lo, key_hi, ret_payload);
+				key_lo, key_hi, 0, 0, ret_payload);
 	if (ret) {
 		printf("Failed: secure op status:0x%x\n", ret);
 	} else {
@@ -260,7 +260,7 @@ static int do_zynqmp_rsa(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	ret = xilinx_pm_request(PM_SECURE_RSA, upper_32_bits((ulong)srcaddr),
 				lower_32_bits((ulong)srcaddr), srclen, rsaop,
-				ret_payload);
+				0, 0, ret_payload);
 	if (ret || ret_payload[1]) {
 		printf("Failed: RSA status:0x%x, errcode:0x%x\n",
 		       ret, ret_payload[1]);
@@ -309,7 +309,7 @@ static int do_zynqmp_sha3(struct cmd_tbl *cmdtp, int flag,
 			   srcaddr + roundup(srclen, ARCH_DMA_MINALIGN));
 
 	ret = xilinx_pm_request(PM_SECURE_SHA, 0, 0, 0,
-				ZYNQMP_SHA3_INIT, ret_payload);
+				ZYNQMP_SHA3_INIT, 0, 0, ret_payload);
 	if (ret || ret_payload[1]) {
 		printf("Failed: SHA INIT status:0x%x, errcode:0x%x\n",
 		       ret, ret_payload[1]);
@@ -318,7 +318,7 @@ static int do_zynqmp_sha3(struct cmd_tbl *cmdtp, int flag,
 
 	ret = xilinx_pm_request(PM_SECURE_SHA, upper_32_bits((ulong)srcaddr),
 				lower_32_bits((ulong)srcaddr),
-				srclen, ZYNQMP_SHA3_UPDATE, ret_payload);
+				srclen, ZYNQMP_SHA3_UPDATE, 0, 0, ret_payload);
 	if (ret || ret_payload[1]) {
 		printf("Failed: SHA UPDATE status:0x%x, errcode:0x%x\n",
 		       ret, ret_payload[1]);
@@ -328,7 +328,7 @@ static int do_zynqmp_sha3(struct cmd_tbl *cmdtp, int flag,
 	ret = xilinx_pm_request(PM_SECURE_SHA, upper_32_bits((ulong)hashaddr),
 				lower_32_bits((ulong)hashaddr),
 				ZYNQMP_SHA3_SIZE, ZYNQMP_SHA3_FINAL,
-				ret_payload);
+				0, 0, ret_payload);
 	if (ret || ret_payload[1]) {
 		printf("Failed: SHA FINAL status:0x%x, errcode:0x%x\n",
 		       ret, ret_payload[1]);
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 789b945d4623..3b28ba62374e 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -293,7 +293,7 @@ void reset_cpu(void)
 	 * will send command over IPI and requires pmufw to be present.
 	 */
 	xilinx_pm_request(PM_RESET_ASSERT, ZYNQMP_PM_RESET_SOFT,
-			  PM_RESET_ACTION_ASSERT, 0, 0, NULL);
+			  PM_RESET_ACTION_ASSERT, 0, 0, 0, 0, NULL);
 }
 #endif
 
diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 5c6972d4d893..c62a747036d9 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -131,7 +131,7 @@ static int versal_pm_query_legacy(struct versal_pm_query_data qdata,
 	int ret;
 
 	ret = smc_call_handler(PM_QUERY_DATA, qdata.qid, qdata.arg1, qdata.arg2,
-			       qdata.arg3, ret_payload);
+			       qdata.arg3, 0, 0, ret_payload);
 
 	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
 }
@@ -350,7 +350,8 @@ static u32 versal_clock_get_div(u32 clk_id)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	u32 div;
 
-	xilinx_pm_request(PM_CLOCK_GETDIVIDER, clk_id, 0, 0, 0, ret_payload);
+	xilinx_pm_request(PM_CLOCK_GETDIVIDER, clk_id, 0, 0, 0, 0, 0,
+			  ret_payload);
 	div = ret_payload[1];
 
 	return div;
@@ -360,7 +361,8 @@ static u32 versal_clock_set_div(u32 clk_id, u32 div)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
-	xilinx_pm_request(PM_CLOCK_SETDIVIDER, clk_id, div, 0, 0, ret_payload);
+	xilinx_pm_request(PM_CLOCK_SETDIVIDER, clk_id, div, 0, 0, 0, 0,
+			  ret_payload);
 
 	return div;
 }
@@ -418,7 +420,7 @@ static u32 versal_clock_get_parentid(u32 clk_id)
 
 	if (versal_clock_mux(clk_id)) {
 		xilinx_pm_request(PM_CLOCK_GETPARENT, clk_id, 0, 0, 0,
-				  ret_payload);
+				  0, 0, ret_payload);
 		parent_id = ret_payload[1];
 	}
 
@@ -436,7 +438,8 @@ static u64 versal_clock_get_pll_rate(u32 clk_id)
 	u32 parent_rate, parent_id, parent_ref_clk_id;
 	u32 id = clk_id & 0xFFF;
 
-	xilinx_pm_request(PM_CLOCK_GETSTATE, clk_id, 0, 0, 0, ret_payload);
+	xilinx_pm_request(PM_CLOCK_GETSTATE, clk_id, 0, 0, 0, 0, 0,
+			  ret_payload);
 	res = ret_payload[1];
 	if (!res) {
 		printf("0%x PLL not enabled\n", clk_id);
@@ -447,9 +450,11 @@ static u64 versal_clock_get_pll_rate(u32 clk_id)
 	parent_ref_clk_id = versal_clock_get_parentid(parent_id);
 	parent_rate = versal_clock_get_ref_rate(parent_ref_clk_id);
 
-	xilinx_pm_request(PM_CLOCK_GETDIVIDER, clk_id, 0, 0, 0, ret_payload);
+	xilinx_pm_request(PM_CLOCK_GETDIVIDER, clk_id, 0, 0, 0, 0, 0,
+			  ret_payload);
 	fbdiv = ret_payload[1];
-	xilinx_pm_request(PM_CLOCK_PLL_GETPARAM, clk_id, 2, 0, 0, ret_payload);
+	xilinx_pm_request(PM_CLOCK_PLL_GETPARAM, clk_id, 2, 0, 0, 0, 0,
+			  ret_payload);
 	frac = ret_payload[1];
 
 	freq = (fbdiv * parent_rate) >> (1 << frac);
@@ -765,8 +770,10 @@ static int versal_clk_enable(struct clk *clk)
 
 	clk_id = priv->clk[clk->id].clk_id;
 
-	if (versal_clock_gate(clk_id))
-		return xilinx_pm_request(PM_CLOCK_ENABLE, clk_id, 0, 0, 0, NULL);
+	if (versal_clock_gate(clk_id)) {
+		return xilinx_pm_request(PM_CLOCK_ENABLE, clk_id, 0, 0, 0,
+					 0, 0, NULL);
+	}
 
 	return 0;
 }
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index e07ec3929b29..3742467caee1 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware driver
  *
  * Copyright (C) 2018-2019 Xilinx, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
  */
 
 #include <asm/arch/hardware.h>
@@ -158,7 +159,7 @@ unsigned int zynqmp_firmware_version(void)
 	if (pm_api_version == ZYNQMP_PM_VERSION_INVALID) {
 
 		ret = xilinx_pm_request(PM_GET_API_VERSION, 0, 0, 0, 0,
-					ret_payload);
+					0, 0, ret_payload);
 		if (ret)
 			panic("PMUFW is not found - Please load it!\n");
 
@@ -202,7 +203,7 @@ int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config, u32 value
 	int ret;
 
 	ret = xilinx_pm_request(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG,
-				config, value, NULL);
+				config, value, 0, 0, NULL);
 	if (ret)
 		printf("%s: node %d: set_gem_config %d failed\n",
 		       __func__, node, config);
@@ -215,7 +216,7 @@ int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
 	int ret;
 
 	ret = xilinx_pm_request(PM_IOCTL, node, IOCTL_SET_SD_CONFIG,
-				config, value, NULL);
+				config, value, 0, 0, NULL);
 	if (ret)
 		printf("%s: node %d: set_sd_config %d failed\n",
 		       __func__, node, config);
@@ -236,7 +237,7 @@ u32 zynqmp_pm_get_bootmode_reg(void)
 	}
 
 	ret = xilinx_pm_request(PM_IOCTL, CRP_BOOT_MODE_REG_NODE, IOCTL_READ_REG,
-				CRP_BOOT_MODE_REG_OFFSET, 0, ret_payload);
+				CRP_BOOT_MODE_REG_OFFSET, 0, 0, 0, ret_payload);
 	if (ret) {
 		printf("%s: node 0x%x: get_bootmode 0x%x failed\n",
 		       __func__, CRP_BOOT_MODE_REG_NODE, CRP_BOOT_MODE_REG_OFFSET);
@@ -259,7 +260,8 @@ u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
 	}
 
 	ret = xilinx_pm_request(PM_IOCTL, PM_REG_PMC_GLOBAL_NODE, IOCTL_READ_REG,
-				PMC_MULTI_BOOT_MODE_REG_OFFSET, 0, ret_payload);
+				PMC_MULTI_BOOT_MODE_REG_OFFSET, 0, 0, 0,
+				ret_payload);
 	if (ret) {
 		printf("%s: node 0x%x: get_bootmode 0x%x failed\n",
 		       __func__, PM_REG_PMC_GLOBAL_NODE, PMC_MULTI_BOOT_MODE_REG_OFFSET);
@@ -276,7 +278,7 @@ int zynqmp_pm_feature(const u32 api_id)
 
 	/* Check feature check API version */
 	ret = xilinx_pm_request(PM_FEATURE_CHECK, api_id, 0, 0, 0,
-				ret_payload);
+				0, 0, ret_payload);
 	if (ret)
 		return ret;
 
@@ -296,7 +298,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 
 	/* Check feature check API version */
 	ret = xilinx_pm_request(PM_FEATURE_CHECK, PM_FEATURE_CHECK, 0, 0, 0,
-				ret_payload);
+				0, 0, ret_payload);
 	if (ret)
 		return ret;
 
@@ -308,7 +310,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 		 */
 
 		ret = xilinx_pm_request(PM_FEATURE_CHECK, api_id, 0, 0, 0,
-					ret_payload);
+					0, 0, ret_payload);
 		if (ret)
 			return ret;
 
@@ -340,7 +342,7 @@ int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
 	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
 
 	err = xilinx_pm_request(PM_SET_CONFIGURATION, (u32)(u64)cfg_obj, 0, 0,
-				0, ret_payload);
+				0, 0, 0, ret_payload);
 	if (err == XST_PM_NO_ACCESS) {
 		return -EACCES;
 	}
@@ -425,13 +427,14 @@ U_BOOT_DRIVER(zynqmp_power) = {
 smc_call_handler_t __data smc_call_handler;
 
 static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
-			   u32 arg3, u32 *ret_payload)
+			   u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
 {
 	struct pt_regs regs;
 
 	regs.regs[0] = PM_SIP_SVC | api_id;
 	regs.regs[1] = ((u64)arg1 << 32) | arg0;
 	regs.regs[2] = ((u64)arg3 << 32) | arg2;
+	regs.regs[3] = arg4;
 
 	smc_call(&regs);
 
@@ -441,16 +444,18 @@ static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 		ret_payload[2] = (u32)regs.regs[1];
 		ret_payload[3] = upper_32_bits(regs.regs[1]);
 		ret_payload[4] = (u32)regs.regs[2];
+		ret_payload[5] = upper_32_bits((u32)regs.regs[2]);
+		ret_payload[6] = (u32)regs.regs[3];
 	}
 
 	return (ret_payload) ? ret_payload[0] : 0;
 }
 
 int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
-				     u32 arg3, u32 *ret_payload)
+				     u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
 {
-	debug("%s at EL%d, API ID: 0x%0x, 0x%0x, 0x%0x, 0x%0x, 0x%0x\n",
-	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3);
+	debug("%s at EL%d, API ID: 0x%0x, 0x%0x, 0x%0x, 0x%0x, 0x%0x, 0x%0x, 0x%0x\n",
+	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
 
 	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 #if defined(CONFIG_ZYNQMP_IPI)
@@ -459,7 +464,7 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 		 * is capable to handle PMUFW_PAYLOAD_ARG_CNT bytes but the
 		 * firmware API is limited by the SMC call size
 		 */
-		u32 regs[] = {api_id, arg0, arg1, arg2, arg3};
+		u32 regs[] = {api_id, arg0, arg1, arg2, arg3, arg4, arg5};
 		int ret;
 
 		if (api_id == PM_FPGA_LOAD) {
@@ -481,7 +486,8 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 #endif
 	}
 
-	return smc_call_handler(api_id, arg0, arg1, arg2, arg3, ret_payload);
+	return smc_call_handler(api_id, arg0, arg1, arg2, arg3, arg4,
+				arg5, ret_payload);
 }
 
 static const struct udevice_id zynqmp_firmware_ids[] = {
diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index 624493ad8384..630d1ecfea34 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -40,13 +40,12 @@ static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	buf_lo = lower_32_bits(bin_buf);
 	buf_hi = upper_32_bits(bin_buf);
 
-
 	if (desc->family == xilinx_versal2) {
 		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_hi,
-					buf_lo, 0, ret_payload);
+					buf_lo, 0, 0, 0, ret_payload);
 	} else {
 		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
-					buf_hi, 0, ret_payload);
+					buf_hi, 0, 0, 0, ret_payload);
 	}
 
 	if (ret)
diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
index 1199b249e368..048d0d2e7a1b 100644
--- a/drivers/fpga/zynqmppl.c
+++ b/drivers/fpga/zynqmppl.c
@@ -291,7 +291,7 @@ static int zynqmp_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	buf_hi = upper_32_bits(bin_buf);
 
 	ret = xilinx_pm_request(PM_FPGA_LOAD, buf_lo, buf_hi,
-				bsize_req, bstype, ret_payload);
+				bsize_req, bstype, 0, 0, ret_payload);
 	if (ret)
 		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
 
@@ -335,11 +335,11 @@ static int zynqmp_loads(xilinx_desc *desc, const void *buf, size_t bsize,
 		ret = xilinx_pm_request(PM_FPGA_LOAD, buf_lo,
 				buf_hi,
 				(u32)(uintptr_t)fpga_sec_info->userkey_addr,
-				flag, ret_payload);
+				flag, 0, 0, ret_payload);
 	else
 		ret = xilinx_pm_request(PM_FPGA_LOAD, buf_lo,
 					buf_hi, (u32)bsize,
-					flag, ret_payload);
+					flag, 0, 0, ret_payload);
 
 	if (ret)
 		puts("PL FPGA LOAD fail\n");
@@ -356,7 +356,7 @@ static int zynqmp_pcap_info(xilinx_desc *desc)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	ret = xilinx_pm_request(PM_FPGA_GET_STATUS, 0, 0, 0,
-				0, ret_payload);
+				0, 0, 0, ret_payload);
 	if (!ret)
 		printf("PCAP status\t0x%x\n", ret_payload[1]);
 
diff --git a/drivers/gpio/zynqmp_gpio_modepin.c b/drivers/gpio/zynqmp_gpio_modepin.c
index 8aaffaf37b3d..4c5de9ba69b5 100644
--- a/drivers/gpio/zynqmp_gpio_modepin.c
+++ b/drivers/gpio/zynqmp_gpio_modepin.c
@@ -23,14 +23,14 @@
 static int get_gpio_modepin(u32 *ret_payload)
 {
 	return xilinx_pm_request(PM_MMIO_READ, ZYNQMP_CRL_APB_BOOT_PIN_CTRL,
-				 0, 0, 0, ret_payload);
+				 0, 0, 0, 0, 0, ret_payload);
 }
 
 static int set_gpio_modepin(int val)
 {
 	return xilinx_pm_request(PM_MMIO_WRITE, ZYNQMP_CRL_APB_BOOT_PIN_CTRL,
 				 ZYNQMP_CRL_APB_BOOTPIN_CTRL_MASK,
-				 val, 0, NULL);
+				 val, 0, 0, 0, NULL);
 }
 
 static int modepin_gpio_direction_input(struct udevice *dev,
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 3b682918b036..eda95b72f49c 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -125,7 +125,7 @@ __weak int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
 }
 
 __weak int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
-			     u32 arg3, u32 *ret_payload)
+			     u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
 {
 	return 0;
 }
@@ -331,7 +331,8 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 	} else {
 		return xilinx_pm_request(PM_IOCTL, node_id,
 					 IOCTL_SET_SD_TAPDELAY,
-					 PM_TAPDELAY_INPUT, itap_delay, NULL);
+					 PM_TAPDELAY_INPUT, itap_delay, 0, 0,
+					 NULL);
 	}
 
 	return 0;
@@ -350,7 +351,8 @@ static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 	} else {
 		return xilinx_pm_request(PM_IOCTL, node_id,
 					 IOCTL_SET_SD_TAPDELAY,
-					 PM_TAPDELAY_OUTPUT, otap_delay, NULL);
+					 PM_TAPDELAY_OUTPUT, otap_delay, 0, 0,
+					 NULL);
 	}
 }
 
@@ -367,7 +369,8 @@ static inline int zynqmp_dll_reset(u32 node_id, u32 type)
 					 SD1_DLL_RST : 0);
 	} else {
 		return xilinx_pm_request(PM_IOCTL, node_id,
-					 IOCTL_SD_DLL_RESET, type, 0, NULL);
+					 IOCTL_SD_DLL_RESET, type, 0, 0, 0,
+					 NULL);
 	}
 }
 
@@ -1021,7 +1024,7 @@ static int sdhci_zynqmp_set_dynamic_config(struct arasan_sdhci_priv *priv,
 
 	ret = xilinx_pm_request(PM_REQUEST_NODE, priv->node_id,
 				ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
-				ZYNQMP_PM_REQUEST_ACK_NO, NULL);
+				ZYNQMP_PM_REQUEST_ACK_NO, 0, 0, NULL);
 	if (ret) {
 		dev_err(dev, "Request node failed for %d\n", priv->node_id);
 		return ret;
diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 665b76a7d4d6..7c11ac4c8b83 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -127,7 +127,8 @@ static int zynqmp_pm_query_data(enum pm_query_id qid, u32 arg1, u32 arg2, u32 *o
 	int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
-	ret = xilinx_pm_request(PM_QUERY_DATA, qid, arg1, arg2, 0, ret_payload);
+	ret = xilinx_pm_request(PM_QUERY_DATA, qid, arg1, arg2, 0, 0,
+				0, ret_payload);
 	if (ret)
 		return ret;
 
@@ -142,7 +143,8 @@ static int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param, u32 *val
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	/* Get config for the pin */
-	ret = xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_GET, pin, param, 0, 0, ret_payload);
+	ret = xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_GET, pin, param, 0, 0, 0,
+				0, ret_payload);
 	if (ret) {
 		printf("%s failed\n", __func__);
 		return ret;
@@ -164,14 +166,15 @@ static int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param, u32 valu
 	}
 
 	/* Request the pin first */
-	ret = xilinx_pm_request(PM_PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
+	ret = xilinx_pm_request(PM_PINCTRL_REQUEST, pin, 0, 0, 0, 0, 0, NULL);
 	if (ret) {
 		printf("%s: pin request failed\n", __func__);
 		return ret;
 	}
 
 	/* Set config for the pin */
-	ret = xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, pin, param, value, 0, NULL);
+	ret = xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, pin, param, value,
+				0, 0, 0, NULL);
 	if (ret) {
 		printf("%s failed\n", __func__);
 		return ret;
@@ -186,7 +189,7 @@ static int zynqmp_pinctrl_get_function_groups(u32 fid, u32 index, u16 *groups)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	ret = xilinx_pm_request(PM_QUERY_DATA, PM_QID_PINCTRL_GET_FUNCTION_GROUPS,
-				fid, index, 0, ret_payload);
+				fid, index, 0, 0, 0, ret_payload);
 	if (ret) {
 		printf("%s failed\n", __func__);
 		return ret;
@@ -242,7 +245,7 @@ static int zynqmp_pinctrl_get_pin_groups(u32 pin, u32 index, u16 *groups)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	ret = xilinx_pm_request(PM_QUERY_DATA, PM_QID_PINCTRL_GET_PIN_GROUPS,
-				pin, index, 0, ret_payload);
+				pin, index, 0, 0, 0, ret_payload);
 	if (ret) {
 		printf("%s failed to get pin groups\n", __func__);
 		return ret;
@@ -313,13 +316,13 @@ static int zynqmp_pinctrl_probe(struct udevice *dev)
 	for (i = 0; i < priv->nfuncs; i++) {
 		/* Get function name for the function and fill */
 		xilinx_pm_request(PM_QUERY_DATA, PM_QID_PINCTRL_GET_FUNCTION_NAME,
-				  i, 0, 0, ret_payload);
+				  i, 0, 0, 0, 0, ret_payload);
 
 		memcpy((void *)priv->funcs[i].name, ret_payload, MAX_FUNC_NAME_LEN);
 
 		/* And fill number of groups available for certain function */
 		xilinx_pm_request(PM_QUERY_DATA, PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS,
-				  i, 0, 0, ret_payload);
+				  i, 0, 0, 0, 0, ret_payload);
 
 		priv->funcs[i].ngroups = ret_payload[1];
 		priv->ngroups += priv->funcs[i].ngroups;
@@ -370,7 +373,8 @@ static int zynqmp_pinmux_set(struct udevice *dev, unsigned int selector,
 	int ret;
 
 	/* Request the pin first */
-	ret = xilinx_pm_request(PM_PINCTRL_REQUEST, selector, 0, 0, 0, NULL);
+	ret = xilinx_pm_request(PM_PINCTRL_REQUEST, selector, 0, 0, 0, 0,
+				0, NULL);
 	if (ret) {
 		printf("%s: pin request failed\n", __func__);
 		return ret;
@@ -378,7 +382,7 @@ static int zynqmp_pinmux_set(struct udevice *dev, unsigned int selector,
 
 	/* Set the pin function */
 	ret = xilinx_pm_request(PM_PINCTRL_SET_FUNCTION, selector, func_selector,
-				0, 0, NULL);
+				0, 0, 0, 0, NULL);
 	if (ret) {
 		printf("%s: Failed to set pinmux function\n", __func__);
 		return ret;
diff --git a/drivers/power/domain/zynqmp-power-domain.c b/drivers/power/domain/zynqmp-power-domain.c
index ac93934eb420..a54de5c1439c 100644
--- a/drivers/power/domain/zynqmp-power-domain.c
+++ b/drivers/power/domain/zynqmp-power-domain.c
@@ -17,7 +17,7 @@ static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 				  const u32 qos, const enum zynqmp_pm_request_ack ack)
 {
 	return xilinx_pm_request(PM_REQUEST_NODE, node, capabilities,
-				   qos, ack, NULL);
+				   qos, ack, 0, 0, NULL);
 }
 
 static int zynqmp_power_domain_request(struct power_domain *power_domain)
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index b9c4f09fdfde..d04e8eef3bb4 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -22,7 +22,7 @@ static int zynqmp_pm_reset_assert(const u32 reset,
 				  const enum zynqmp_pm_reset_action assert_flag)
 {
 	return xilinx_pm_request(PM_RESET_ASSERT, reset, assert_flag, 0, 0,
-				 NULL);
+				 0, 0, NULL);
 }
 
 static int zynqmp_reset_assert(struct reset_ctl *rst)
diff --git a/drivers/soc/soc_amd_versal2.c b/drivers/soc/soc_amd_versal2.c
index 8507da0bd228..7f06c1e70bcf 100644
--- a/drivers/soc/soc_amd_versal2.c
+++ b/drivers/soc/soc_amd_versal2.c
@@ -55,7 +55,7 @@ static int soc_amd_versal2_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
 		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+					0, 0, ret_payload);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/soc/soc_xilinx_versal.c b/drivers/soc/soc_xilinx_versal.c
index 7427f8432c8b..c43a80df1fc4 100644
--- a/drivers/soc/soc_xilinx_versal.c
+++ b/drivers/soc/soc_xilinx_versal.c
@@ -51,7 +51,7 @@ static int soc_xilinx_versal_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
 		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+					0, 0, ret_payload);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/soc/soc_xilinx_versal_net.c b/drivers/soc/soc_xilinx_versal_net.c
index d64fc366a6d1..210f9f8f8fd4 100644
--- a/drivers/soc/soc_xilinx_versal_net.c
+++ b/drivers/soc/soc_xilinx_versal_net.c
@@ -53,7 +53,7 @@ static int soc_xilinx_versal_net_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
 		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+					0, 0, ret_payload);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index 4b69ff3de138..b97cd443c607 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -362,7 +362,7 @@ static int soc_xilinx_zynqmp_probe(struct udevice *dev)
 		ret = zynqmp_mmio_read(ZYNQMP_PS_VERSION, &ret_payload[2]);
 	else
 		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+					0, 0, ret_payload);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 6dc6fbe5a5b0..0efbbf56a5e3 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -199,12 +199,12 @@ void cadence_qspi_apb_enable_linear_mode(bool enable)
 			/* ahb read mode */
 			xilinx_pm_request(PM_IOCTL, PM_DEV_OSPI,
 					  IOCTL_OSPI_MUX_SELECT,
-					  PM_OSPI_MUX_SEL_LINEAR, 0, NULL);
+					  PM_OSPI_MUX_SEL_LINEAR, 0, 0, 0, NULL);
 		else
 			/* DMA mode */
 			xilinx_pm_request(PM_IOCTL, PM_DEV_OSPI,
 					  IOCTL_OSPI_MUX_SELECT,
-					  PM_OSPI_MUX_SEL_DMA, 0, NULL);
+					  PM_OSPI_MUX_SEL_DMA, 0, 0, 0, NULL);
 	} else {
 		if (enable)
 			writel(readl(VERSAL_AXI_MUX_SEL) |
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 9edbfaa821b6..599596f9f087 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -230,7 +230,7 @@ static int cadence_spi_probe(struct udevice *bus)
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
 		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
 				  ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
-				  ZYNQMP_PM_REQUEST_ACK_NO, NULL);
+				  ZYNQMP_PM_REQUEST_ACK_NO, 0, 0, NULL);
 
 	if (priv->ref_clk_hz == 0) {
 		ret = clk_get_by_index(bus, 0, &clk);
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 7ef8a58847f4..7f93241b1932 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -440,18 +440,18 @@ enum pm_gem_config_type {
 /*
  * Return payload size
  * Not every firmware call expects the same amount of return bytes, however the
- * firmware driver always copies 5 bytes from RX buffer to the ret_payload
+ * firmware driver always copies 7 words from RX buffer to the ret_payload
  * buffer. Therefore allocating with this defined value is recommended to avoid
  * overflows.
  */
-#define PAYLOAD_ARG_CNT	5U
+#define PAYLOAD_ARG_CNT	7U
 
 unsigned int zynqmp_firmware_version(void);
 int zynqmp_pmufw_node(u32 id);
 int zynqmp_pmufw_config_close(void);
 int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size);
 int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
-		      u32 arg3, u32 *ret_payload);
+		      u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload);
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
@@ -517,7 +517,7 @@ struct zynqmp_ipi_msg {
 #define __data __section(".data")
 
 typedef int (*smc_call_handler_t)(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
-				  u32 arg3, u32 *ret_payload);
+				  u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload);
 
 extern smc_call_handler_t __data smc_call_handler;
 
-- 
2.43.0

base-commit: a51b7dfc6fec0aa76367114af59a7114b040b090
branch: debian-sent3
