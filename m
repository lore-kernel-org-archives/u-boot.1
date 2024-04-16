Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE1BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09FC88411;
	Tue, 16 Apr 2024 14:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Ox6UQtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242E887F01; Tue, 16 Apr 2024 08:55:57 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4197F87F01
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQRZTGTlIx9aYE3qavr6IqYq2jWUBzsM+TTsKqneZC7WKaKv2q+UCyBxg8q5jVkP3dJSHz5uJ5yHVz57EBWjLiHeGIRYCFyrzXRE52LeETLlYpKB3g/MiYc/Qve9RMGW/4FQtHwVz0MfLa3zkfuG5FHcjEac9N2N7Bl7HzgtvhWkHVLzsG29nXvNG9kL7sLc+BTq6KSDJbuoPkID73Mi3gee2qz56xyiOVCUv4vLixlAvbYXHN+hhlaQiMbV7sbURIURQ4Bewsg2l+MSvHOrxUmgqQzt0YUEt2HgiGO0fM1cHTUYlkzy3wVv9UQAriTdJPBLyQO3cG8gBZi0X9sSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8WHI+9JM6TFDhWvq5Tk+AjCkVsgA8iCpQAP73mLH54=;
 b=e9bYd3pq03QyvB5OHznPEt2sfhVv73Ooz7fDGDGjG/4d7BZhPJcrV8TD5wMjswdMQWiYt2dpOs+TSLhHwlJgJOGE0Sdmy40khdiq0sW2C5c86wszf1oAc+H3kkRDvKvxv+m09Il+UZnsyk3YACZiPOHERTd9YZbMk5hbuy6/wIRP6cdGoT/jcZ7USKy2m3Tvy6l1I97ujwKFZlRmRTopnbzDoZJf95HoWDIslhhX5pv9Zu0pXc4b4RrMPlE99ihEpwYOVIBzxswlzmSW0ex1orPGK0megvnMU7NkD8VDaGlRMinvpWMuKCKpQ3qtl7SQSVidGrk8ibKV6CJcBc1BfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8WHI+9JM6TFDhWvq5Tk+AjCkVsgA8iCpQAP73mLH54=;
 b=1Ox6UQtSrovGYbpRgdQu5djh/0cHJlM8UKi/W/0vP70CZa/VYxPObeopG0X0VGQwTlyWY4B+qegpzaV7k+AodU1LxYBPgN3nEqVP1KRuNKu9n4TJhmRtgLaIIagwoqfkl45imyg9w5Ey6UK/eCQI/Irm36//dASvpkDv1X+Y+98=
Received: from BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:55:48 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::de) by BY5PR17CA0001.outlook.office365.com
 (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 06:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:55:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:55:45 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Aaron Williams
 <awilliams@marvell.com>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Anastasiia Lukianenko <vicooodin@gmail.com>, Anatolij Gustschin
 <agust@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Doug Zobel
 <douglas.zobel@climate.com>, Enrico Leto <enrico.leto@siemens.com>, Fabio
 Estevam <festevam@gmail.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Johan Jonker <jbx6244@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, =?UTF-8?q?Marek=20Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>, Matthias Winker
 <matthias.winker@de.bosch.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Minda Chen <minda.chen@starfivetech.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>, Oliver Graute
 <oliver.graute@kococonnector.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 =?UTF-8?q?Pawe=C5=82=20Jarosz?= <paweljarosz3691@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Philip Oberfichtner <pro@denx.de>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Sean Anderson <seanga2@gmail.com>, Seung-Woo
 Kim <sw0312.kim@samsung.com>, Shiji Yang <yangshiji66@outlook.com>, Simon
 Glass <sjg@chromium.org>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Stefan Roese <sr@denx.de>, Stefano
 Babic <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Viacheslav
 Bocharov <adeep@lexina.in>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 "open list:VIM3" <u-boot-amlogic@groups.io>, "moderated list:ST BOARDS"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
Date: Tue, 16 Apr 2024 08:55:19 +0200
Message-ID: <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28251; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=NinQRD7nziCN2VKrxaFN5jFoz5a4TtLZi8HtPoAolXw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQ5hVvrftd4ynndmZ8Xz/Kzv0jRvtLVWf2M3XN2I7EE9
 /op9lM7YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwESMVBnmGcecrjf9u/P8NbcW
 /nMNl66L2S94xTC/Zvpux9WPp/z1CA6u9zqx5VWj1rbZAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: fb213145-badc-4716-9ecd-08dc5de23ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqVRanS/IJ30O3c0e0Nhwi0Vxqm+aSTZ5l1Cee0hDv3IbPQ6UdLoBIwYGKfLOQ3Onri6b7Fivxhz7yDNOY3Kvo+TG8421nBTX+7kEj+aW2L29xWM3HigVKGuVde3HAGoMFSI8/mY5TMG3Gs/XjUp/3QWJCcdrzNAxw+IJ4A20S2c21y+qOha7xLccMXy4g6zKbZNpihhyZFZ2+YAj1kACze1V5pidUaIf8rfVKbx5q3cag5jpPqXjYFVDT23FWY1DMwnqpRanxqXD06jNejm7vzLAXFdxTsywabthH38wQcYAj6b1O6mKJUETxhou6vnIivu5jhWawVo4sl4UtCvu+2SkbxCB/qi2llcNi6i8UHApEZQR61aqJelzmVRihvKzj6CjJeedrxiY/SEVd7QE3EYufbnJzczOj76Vz86JN5OETbPgDScxU28eDuyLIz1O85aGFlFIgRyYvm/Yzwq/L0z/WESocqOcici2/p62mK97u6yXxUB1yjcKhkkr2cyP+zxPL8zkbgzWjvCzS6IIm1sTrV3vyy+HNpLx6E/EoylUmgAJOvCCsfkXFXOcCEQ4MZkbOBhmpoHFcoXrDBCbr/KfrPCuQP4+f5/J0DAnhHIzkL/+NXH5ZsnzZz9trldpaljQ2eA+Y1u3qlNiWMqq+/GiU9O+IDPBMoZi2TJvLkq7XumZ6AV3nFEtiakOCfXODUs6WM0hNoBApMqx7O83Ci8EqbJ50urtMmNtlsYCs/3W+7jwU+AwyHTvmpU3WztTDIVazUiqUoOs1FDDSTA6H9f4xiGlkNajmEGS270t8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(32650700005)(1800799015);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:55:47.7443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb213145-badc-4716-9ecd-08dc5de23ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

Convert UTF-8 chars to ASCII in cases where make sense. No Copyright or
names are converted.

Signed-off-by: Michal Simek <michal.simek@amd.com>

---

Changes in v2:
- New patch in series

 .../armv8/fsl-layerscape/fsl_lsch2_serdes.c   |  2 +-
 .../armv8/fsl-layerscape/fsl_lsch3_serdes.c   |  2 +-
 arch/arm/mach-imx/ddrmc-vf610-calibration.c   | 12 +++++-----
 arch/arm/mach-imx/mx6/clock.c                 |  8 +++----
 arch/arm/mach-imx/mx7/psci-mx7.c              |  4 ++--
 arch/mips/mach-mscc/include/mach/ddr.h        |  2 +-
 .../include/mach/cvmx-helper-pki.h            |  2 +-
 arch/mips/mach-octeon/include/mach/cvmx-pki.h |  6 ++---
 .../mips/mach-octeon/include/mach/cvmx-pko3.h |  2 +-
 board/CZ.NIC/turris_mox/turris_mox.c          |  2 +-
 board/amlogic/vim3/vim3.c                     |  2 +-
 board/bosch/acc/acc.c                         |  2 +-
 board/bosch/shc/board.c                       |  2 +-
 board/bosch/shc/board.h                       |  2 +-
 board/congatec/cgtqmx8/cgtqmx8.c              |  4 ++--
 board/freescale/common/i2c_mux.c              |  2 +-
 board/siemens/capricorn/board.c               |  8 +++----
 board/st/common/cmd_stboard.c                 |  2 +-
 .../visionfive2/visionfive2-i2c-eeprom.c      |  4 ++--
 drivers/clk/renesas/rzg2l-cpg.c               |  6 ++---
 drivers/clk/stm32/clk-stm32-core.h            | 22 +++++++++----------
 drivers/led/led_lp5562.c                      |  4 ++--
 drivers/mtd/nand/raw/nand_ids.c               |  2 +-
 drivers/rng/stm32_rng.c                       |  6 ++---
 drivers/soc/ti/k3-navss-ringacc.c             |  2 +-
 drivers/thermal/thermal_sandbox.c             |  2 +-
 drivers/video/renesas-r61307.c                |  2 +-
 drivers/video/renesas-r69328.c                |  2 +-
 drivers/xen/pvblock.c                         |  2 +-
 include/acpi/acpigen.h                        |  6 ++---
 include/linux/mtd/mtd.h                       |  2 +-
 lib/crypto/x509_cert_parser.c                 |  2 +-
 32 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
index 1541dfb3ec47..b1bb29bcaf55 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
@@ -258,7 +258,7 @@ int setup_serdes_volt(u32 svdd)
 	/* Wait for SVDD to stabilize */
 	udelay(100);
 
-	/* For each PLL that’s not disabled via RCW */
+	/* For each PLL that's not disabled via RCW */
 #ifdef CONFIG_SYS_FSL_SRDS_1
 	cfg_tmp = (cfg_rcw5 >> 22) & 0x3;
 	for (i = 0; i < 2 && !(cfg_tmp & (0x1 << (1 - i))); i++) {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
index c0efc341afc1..fbd5fd7d433b 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
@@ -483,7 +483,7 @@ int setup_serdes_volt(u32 svdd)
 		ret = -1;
 	}
 
-	/* For each PLL that’s not disabled via RCW enable the SERDES */
+	/* For each PLL that's not disabled via RCW enable the SERDES */
 #ifdef CONFIG_SYS_FSL_SRDS_1
 	cfg_tmp = cfg_rcwsrds1 & 0x3;
 	do_serdes_enable(cfg_tmp, serdes1_base);
diff --git a/arch/arm/mach-imx/ddrmc-vf610-calibration.c b/arch/arm/mach-imx/ddrmc-vf610-calibration.c
index cd7e95e61d00..7d787d045980 100644
--- a/arch/arm/mach-imx/ddrmc-vf610-calibration.c
+++ b/arch/arm/mach-imx/ddrmc-vf610-calibration.c
@@ -45,7 +45,7 @@
  *                             based on trace length differences from their
  *                             layout.
  *                             Mismatches up to 25% or tCK (clock period) are
- *                             allowed, so the value in the filed doesn’t have
+ *                             allowed, so the value in the filed doesn't have
  *                             to be very accurate.
  *
  * - 0x2 (b'10) - RDLVL_DL_0/1 - refers to adjusting the DQS strobe in relation
@@ -184,14 +184,14 @@ static int ddrmc_cal_dqs_to_dq(struct ddrmr_regs *ddrmr)
 	debug("RDLVL: PHY_RDLVL_EDGE:\t 0x%x\n",
 	      (tmp >> DDRMC_CR101_PHY_RDLVL_EDGE_OFF) & 0x1); //set 0
 
-	/* Program Leveling mode - CR93[SW_LVL_MODE] to ’b10 */
+	/* Program Leveling mode - CR93[SW_LVL_MODE] to 'b10 */
 	clrsetbits_le32(&ddrmr->cr[93], DDRMC_CR93_SW_LVL_MODE(0x3),
 			DDRMC_CR93_SW_LVL_MODE(0x2));
 	tmp = readl(&ddrmr->cr[93]);
 	debug("RDLVL: SW_LVL_MODE:\t 0x%x\n",
 	      (tmp >> DDRMC_CR93_SW_LVL_MODE_OFF) & 0x3);
 
-	/* Start procedure - CR93[SWLVL_START] to ’b1 */
+	/* Start procedure - CR93[SWLVL_START] to 'b1 */
 	sw_leveling_start;
 
 	/* Poll CR94[SWLVL_OP_DONE] */
@@ -211,7 +211,7 @@ static int ddrmc_cal_dqs_to_dq(struct ddrmr_regs *ddrmr)
 				0xFFFF << DDRMC_CR105_RDLVL_DL_0_OFF,
 				i << DDRMC_CR105_RDLVL_DL_0_OFF);
 
-		/* Load values CR93[SWLVL_LOAD] to ’b1 */
+		/* Load values CR93[SWLVL_LOAD] to 'b1 */
 		sw_leveling_load_value;
 
 		/* Poll CR94[SWLVL_OP_DONE] */
@@ -263,7 +263,7 @@ static int ddrmc_cal_dqs_to_dq(struct ddrmr_regs *ddrmr)
 				0xFFFF << DDRMC_CR110_RDLVL_DL_1_OFF,
 				i << DDRMC_CR110_RDLVL_DL_1_OFF);
 
-		/* Load values CR93[SWLVL_LOAD] to ’b1 */
+		/* Load values CR93[SWLVL_LOAD] to 'b1 */
 		sw_leveling_load_value;
 
 		/* Poll CR94[SWLVL_OP_DONE] */
@@ -317,7 +317,7 @@ static int ddrmc_cal_dqs_to_dq(struct ddrmr_regs *ddrmr)
 	sw_leveling_load_value;
 	sw_leveling_op_done;
 
-	/* Exit procedure - CR94[SWLVL_EXIT] to ’b1 */
+	/* Exit procedure - CR94[SWLVL_EXIT] to 'b1 */
 	sw_leveling_exit;
 
 	/* Poll CR94[SWLVL_OP_DONE] */
diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-imx/mx6/clock.c
index 1bdc568f9b14..e0da9c239584 100644
--- a/arch/arm/mach-imx/mx6/clock.c
+++ b/arch/arm/mach-imx/mx6/clock.c
@@ -714,10 +714,10 @@ void mxs_set_lcdclk(u32 base_addr, u32 freq)
 		/*
 		 * Register: PLL_VIDEO
 		 * Bit Field: POST_DIV_SELECT
-		 * 00 — Divide by 4.
-		 * 01 — Divide by 2.
-		 * 10 — Divide by 1.
-		 * 11 — Reserved
+		 * 00 - Divide by 4.
+		 * 01 - Divide by 2.
+		 * 10 - Divide by 1.
+		 * 11 - Reserved
 		 * No need to check post_div(1)
 		 */
 		for (post_div = 2; post_div <= 4; post_div <<= 1) {
diff --git a/arch/arm/mach-imx/mx7/psci-mx7.c b/arch/arm/mach-imx/mx7/psci-mx7.c
index 699a2569cb72..0b71fa403446 100644
--- a/arch/arm/mach-imx/mx7/psci-mx7.c
+++ b/arch/arm/mach-imx/mx7/psci-mx7.c
@@ -631,9 +631,9 @@ __secure void psci_system_suspend(u32 __always_unused function_id,
 	 * Workaround:
 	 * If both CPU0/CPU1 are IDLE, the last IDLE CPU should
 	 * disable GIC first, then REG_BYPASS_COUNTER is used
-	 * to mask wakeup INT, and then execute “wfi” is used to
+	 * to mask wakeup INT, and then execute "wfi" is used to
 	 * bring the system into power down processing safely.
-	 * The counter must be enabled as close to the “wfi” state
+	 * The counter must be enabled as close to the "wfi" state
 	 * as possible. The following equation can be used to
 	 * determine the RBC counter value:
 	 * RBC_COUNT * (1/32K RTC frequency) >=
diff --git a/arch/mips/mach-mscc/include/mach/ddr.h b/arch/mips/mach-mscc/include/mach/ddr.h
index 3ba33d27c178..58c89d5e645a 100644
--- a/arch/mips/mach-mscc/include/mach/ddr.h
+++ b/arch/mips/mach-mscc/include/mach/ddr.h
@@ -225,7 +225,7 @@
 #define VC3_MPAR_FAW VC3_MPAR_tFAW
 #define VC3_MPAR_BL 4
 #define MSCC_MEMPARM_MR0 ((VC3_MPAR_RL - 4) << 4) | ((VC3_MPAR_tWR - 4) << 9)
-/* ODT_RTT: “0x0040” for 120ohm, and “0x0004” for 60ohm. */
+/* ODT_RTT: "0x0040" for 120ohm, and "0x0004" for 60ohm. */
 #define MSCC_MEMPARM_MR1 0x0040
 #define MSCC_MEMPARM_MR2 ((VC3_MPAR_WL - 5) << 3)
 #define MSCC_MEMPARM_MR3 0
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-helper-pki.h b/arch/mips/mach-octeon/include/mach/cvmx-helper-pki.h
index ff32dab67b51..25e2877469a0 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-helper-pki.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-helper-pki.h
@@ -267,7 +267,7 @@ void cvmx_helper_pki_set_fcs_op(int node, int interface, int nports, int has_fcs
  *				    buffer separate from the work queue entry. Words following the
  *				    WQE in the same cache line will be zeroed, other lines in the
  *				    buffer will not be modified and will retain stale data (from the
- *				    buffer’s previous use). This setting may decrease the peak PKI
+ *				    buffer's previous use). This setting may decrease the peak PKI
  *				    performance by up to half on small packets.
  */
 void cvmx_helper_pki_set_wqe_mode(int node, bool pkt_outside_wqe);
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-pki.h b/arch/mips/mach-octeon/include/mach/cvmx-pki.h
index c1feb55a1f01..d918f792eee5 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-pki.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-pki.h
@@ -110,8 +110,8 @@ enum cvmx_pki_wqe_vlan { CVMX_PKI_USE_FIRST_VLAN = 0, CVMX_PKI_USE_SECOND_VLAN }
  * Controls how the PKI statistics counters are handled
  * The PKI_STAT*_X registers can be indexed either by port kind (pkind), or
  * final style. (Does not apply to the PKI_STAT_INB* registers.)
- *    0 = X represents the packet’s pkind
- *    1 = X represents the low 6-bits of packet’s final style
+ *    0 = X represents the packet's pkind
+ *    1 = X represents the low 6-bits of packet's final style
  */
 enum cvmx_pki_stats_mode { CVMX_PKI_STAT_MODE_PKIND, CVMX_PKI_STAT_MODE_STYLE };
 
@@ -880,7 +880,7 @@ int cvmx_pki_get_pkind_style(int node, int pkind);
  *    buffer separate from the work queue entry. Words following the
  *    WQE in the same cache line will be zeroed, other lines in the
  *    buffer will not be modified and will retain stale data (from the
- *    buffer’s previous use). This setting may decrease the peak PKI
+ *    buffer's previous use). This setting may decrease the peak PKI
  *    performance by up to half on small packets.
  */
 void cvmx_pki_set_wqe_mode(int node, u64 style, bool pkt_outside_wqe);
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-pko3.h b/arch/mips/mach-octeon/include/mach/cvmx-pko3.h
index 86f89be855fe..bda607203f3f 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-pko3.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-pko3.h
@@ -366,7 +366,7 @@ enum cvmx_pko_memalg_e {
 			       */
 	MEMALG_SETRSLT = 2,   /* [DSZ] = B64; mem = PKO_MEM_RESULT_S.  */
 	MEMALG_ADD = 8,	      /* mem = mem + PKO_SEND_MEM_S[OFFSET] */
-	MEMALG_SUB = 9,	      /* mem = mem – PKO_SEND_MEM_S[OFFSET] */
+	MEMALG_SUB = 9,	      /* mem = mem - PKO_SEND_MEM_S[OFFSET] */
 	MEMALG_ADDLEN = 0xA,  /* mem += [OFFSET] + PKO_SEND_HDR_S[TOTAL] */
 	MEMALG_SUBLEN = 0xB,  /* mem -= [OFFSET] + PKO_SEND_HDR_S[TOTAL] */
 	MEMALG_ADDMBUF = 0xC, /* mem += [OFFSET] + mbufs_freed */
diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
index 1a2f60e3d190..00114e6d9156 100644
--- a/board/CZ.NIC/turris_mox/turris_mox.c
+++ b/board/CZ.NIC/turris_mox/turris_mox.c
@@ -395,7 +395,7 @@ static void load_spi_dtb(void)
 		return;
 
 	/*
-	 * SPI NOR "dtb" partition offset & size hardcoded for now because the
+	 * SPI NOR "dtb" partition offset & size hardcoded for now because the
 	 * mtd subsystem does not offer finding the partition yet and we do not
 	 * want to reimplement OF partition parser here.
 	 */
diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 43d7a8e84f62..a4850364f418 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -89,7 +89,7 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
 
 	/*
 	 * If in PCIe mode, alter DT
-	 * 0：Enable USB3.0，Disable PCIE, 1：Disable USB3.0, Enable PCIE
+	 * 0: Enable USB3.0, Disable PCIE, 1: Disable USB3.0, Enable PCIE
 	 */
 	if (ret > 0) {
 		static char data[32] __aligned(4);
diff --git a/board/bosch/acc/acc.c b/board/bosch/acc/acc.c
index 34088adee47b..65c2f3567135 100644
--- a/board/bosch/acc/acc.c
+++ b/board/bosch/acc/acc.c
@@ -437,7 +437,7 @@ static const struct mx6_ddr3_cfg acc_mx6d_mem_ddr3_1066 = {
 	.trcd = 1313, // 13.125ns
 	.trcmin = 5063, // 50.625ns
 	.trasmin = 3750, // 37.5ns
-	.SRT = 0, // Set to 1 for temperatures above 85°C
+	.SRT = 0, // Set to 1 for temperatures above 85 deg C
 };
 
 static const struct mx6_ddr_sysinfo acc_mx6d_ddr_info = {
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index 962a485acd22..aebdfd4dfec0 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -115,7 +115,7 @@ static void __maybe_unused force_modules_running(void)
 	gpio_direction_output(WIFI_REGEN_GPIO, 1);
 	/*
 	 * Wait for Wi-Fi power regulator to reach a stable voltage
-	 * (soft-start time, max. 350 µs)
+	 * (soft-start time, max. 350 us)
 	 */
 	__udelay(350);
 
diff --git a/board/bosch/shc/board.h b/board/bosch/shc/board.h
index 4cc02f93c64b..a5e58186c9c1 100644
--- a/board/bosch/shc/board.h
+++ b/board/bosch/shc/board.h
@@ -154,7 +154,7 @@ static inline int board_is_series(void)
 #define HDR_FATC_LEN	12
 
 /*
-* SHC parameters held in On-Board I²C EEPROM device.
+* SHC parameters held in On-Board I2C EEPROM device.
 *
 * Header Format
 *
diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index 3b01354bb6b0..d8e5b1d69633 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -171,7 +171,7 @@ int board_mmc_init(struct bd_info *bis)
 	 * (U-Boot device node)    (Physical Port)
 	 * mmc0 (onboard eMMC)     USDHC1
 	 * mmc1 (external SD card) USDHC2
-	 * mmc2 (onboard µSD)      USDHC3
+	 * mmc2 (onboard uSD)      USDHC3
 	 */
 	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
 		switch (i) {
@@ -196,7 +196,7 @@ int board_mmc_init(struct bd_info *bis)
 			gpio_direction_input(USDHC1_CD_GPIO);
 			break;
 		case 2:
-		  /* onboard µSD */
+		  /* onboard uSD */
 			if (!imx8_power_domain_lookup_name("conn_sdhc2", &pd))
 				power_domain_on(&pd);
 
diff --git a/board/freescale/common/i2c_mux.c b/board/freescale/common/i2c_mux.c
index 54f89e257609..d40b34f10397 100644
--- a/board/freescale/common/i2c_mux.c
+++ b/board/freescale/common/i2c_mux.c
@@ -12,7 +12,7 @@
 
 /*
  * A new Kconfig option for something that used to always be built should be
- * “default y”.
+ * "default y".
  */
 #ifdef CONFIG_FSL_USE_PCA9547_MUX
 
diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 0d66a75bbfa1..b1d7e3b1c05a 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -156,14 +156,14 @@ int setup_gpr_fec(void)
 	 *	0: internal clock
 	 *	1: external clock --->  your choice for RMII
 	 *
-	 * CLKDIV_SEL: it controls a div by 2 on the internal clock path à
-	 *	it should be don’t care when using external clock
+	 * CLKDIV_SEL: it controls a div by 2 on the internal clock path a
+	 *	it should be don't care when using external clock
 	 *	0: non-divided clock
 	 *	1: clock divided by 2
 	 * 50_DISABLE or 125_DISABLE:
-	 *	it’s used to disable the clock tree going outside the chip
+	 *	it's used to disable the clock tree going outside the chip
 	 *	when reference clock is generated internally.
-	 *	It should be don’t care when reference clock is provided
+	 *	It should be don't care when reference clock is provided
 	 *	externally.
 	 *	0: clock is enabled
 	 *	1: clock is disabled
diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
index cb103e69b369..c8c0bad5da16 100644
--- a/board/st/common/cmd_stboard.c
+++ b/board/st/common/cmd_stboard.c
@@ -9,7 +9,7 @@
  * - "Commercial Product Name" (CPN): type of product board (DKX, EVX)
  *   associated to the board ID "MBxxxx"
  * - "Finished Good" or "Finish Good" (FG):
- *   effective content of the product without chip STM32MP1xx (LCD, Wifi,…)
+ *   effective content of the product without chip STM32MP1xx (LCD, Wifi,...)
  * - BOM: cost variant for same FG (for example, several provider of the same
  *   component)
  *
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index ddef7d612358..5095a0e9fdb0 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -503,7 +503,7 @@ int mac_read_from_eeprom(void)
 	 * "<product>-<date>-<DDR&eMMC>-<serial_number>"
 	 * <date>: 4Byte, should be the output of `date +%y%W`
 	 * <DDR&eMMC>: 8Byte, "D008" means 8GB, "D01T" means 1TB;
-	 *     "E000" means no eMMC，"E032" means 32GB, "E01T" means 1TB.
+	 *     "E000" means no eMMC, "E032" means 32GB, "E01T" means 1TB.
 	 * <serial_number>: 8Byte, the Unique Identifier of board in hex.
 	 */
 	if (!env_get("serial#"))
@@ -533,7 +533,7 @@ u8 get_pcb_revision_from_eeprom(void)
  * get_ddr_size_from_eeprom - get the DDR size
  * pstr:  VF7110A1-2228-D008E000-00000001
  * VF7110A1/VF7110B1 : VisionFive JH7110A /VisionFive JH7110B
- * D008:　8GB LPDDR4
+ * D008: 8GB LPDDR4
  * E000: No emmc device, ECxx: include emmc device, xx: Capacity size[GB]
  * return: the field of 'D008E000'
  */
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index dba009997a81..c8735d869cf9 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -313,9 +313,9 @@ static ulong rzg2l_sdhi_clk_set_rate(struct udevice *dev, const struct cpg_core_
 
 	/*
 	 * As per the HW manual, we should not directly switch from 533 MHz to
-	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
-	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
-	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
+	 * 400 MHz and vice versa. To change the setting from 2'b01 (533 MHz)
+	 * to 2'b10 (400 MHz) or vice versa, Switch to 2'b11 (266 MHz) first,
+	 * and then switch to the target setting (2'b01 (533 MHz) or 2'b10
 	 * (400 MHz)).
 	 */
 	if (new_sel != SEL_SDHI_266MHz && prev_sel != SEL_SDHI_266MHz) {
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 53c2b467ab87..f9ef07020055 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -178,7 +178,7 @@ int stm32_rcc_init(struct udevice *dev,
  *                ------------------------------                   ----------
 
  * Each peripheral requires a bus interface clock, named ckg_bus_perx
- * (for peripheral ‘x’).
+ * (for peripheral `x').
  * Some peripherals (SAI, UART...) need also a dedicated clock for their
  * communication interface, this clock is generally asynchronous with respect to
  * the bus interface clock, and is named kernel clock (ckg_ker_perx).
@@ -188,16 +188,16 @@ int stm32_rcc_init(struct udevice *dev,
  * the bus or the Kernel was enable.
  *
  * Example:
- * 1) enable the bus clock
- *	--> bus_clk ref_counting = 1, gate_ref_count = 1
- * 2) enable the kernel clock
- *	--> perx_ker_ck ref_counting = 1, gate_ref_count = 2
- * 3) disable kernel clock
- * 	---> perx_ker_ck ref_counting = 0, gate_ref_count = 1
- * 	==> then i will not gate because gate_ref_count > 0
- * 4) disable bus clock
- *	--> bus_clk  ref_counting  = 0, gate_ref_count = 0
- *	==> then i can gate (write in the register) because
+ * 1) enable the bus clock
+ *	--> bus_clk ref_counting = 1, gate_ref_count = 1
+ * 2) enable the kernel clock
+ *	--> perx_ker_ck ref_counting = 1, gate_ref_count = 2
+ * 3) disable kernel clock
+ * 	---> perx_ker_ck ref_counting = 0, gate_ref_count = 1
+ * 	==> then i will not gate because gate_ref_count > 0
+ * 4) disable bus clock
+ *	--> bus_clk  ref_counting  = 0, gate_ref_count = 0
+ *	==> then i can gate (write in the register) because
  *	    gate_ref_count = 0
  */
 
diff --git a/drivers/led/led_lp5562.c b/drivers/led/led_lp5562.c
index 431d7e10ab74..0c5f9bc43003 100644
--- a/drivers/led/led_lp5562.c
+++ b/drivers/led/led_lp5562.c
@@ -125,9 +125,9 @@ static int lp5562_led_reg_update(struct udevice *dev, int regnum,
 
 	/*
 	 * Data sheet says "Delay between consecutive I2C writes to
-	 * ENABLE register (00h) need to be longer than 488 μs
+	 * ENABLE register (00h) need to be longer than 488 us
 	 * (typical)." and "Delay between consecutive I2C writes to
-	 * OP_MODE register need to be longer than 153 μs (typ)."
+	 * OP_MODE register need to be longer than 153 us (typ)."
 	 *
 	 * The linux driver does usleep_range(500, 600) and
 	 * usleep_range(200, 300), respectively.
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 22ea5e2f9076..be60d6d9d995 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -62,7 +62,7 @@ struct nand_flash_dev nand_flash_ids[] = {
 		{ .id = {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4} },
 		  SZ_8K, SZ_8K, SZ_2M, NAND_NEED_SCRAMBLING, 6, 640,
 		  NAND_ECC_INFO(40, SZ_1K), 4 },
-	{"H27QCG8T2E5R‐BCF 64G 3.3V 8-bit",
+	{"H27QCG8T2E5R-BCF 64G 3.3V 8-bit",
 		{ .id = {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
 		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
 		  NAND_ECC_INFO(56, SZ_1K), 1 },
diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index 61d5ed615820..44e8a4607520 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -74,7 +74,7 @@ struct stm32_rng_plat {
  * Extracts from the STM32 RNG specification when RNG supports CONDRST.
  *
  * When a noise source (or seed) error occurs, the RNG stops generating
- * random numbers and sets to “1” both SEIS and SECS bits to indicate
+ * random numbers and sets to "1" both SEIS and SECS bits to indicate
  * that a seed error occurred. (...)
  *
  * 1. Software reset by writing CONDRST at 1 and at 0 (see bitfield
@@ -127,12 +127,12 @@ static int stm32_rng_conceal_seed_error_cond_reset(struct stm32_rng_plat *pdata)
  * Extracts from the STM32 RNG specification, when CONDRST is not supported
  *
  * When a noise source (or seed) error occurs, the RNG stops generating
- * random numbers and sets to “1” both SEIS and SECS bits to indicate
+ * random numbers and sets to "1" both SEIS and SECS bits to indicate
  * that a seed error occurred. (...)
  *
  * The following sequence shall be used to fully recover from a seed
  * error after the RNG initialization:
- * 1. Clear the SEIS bit by writing it to “0”.
+ * 1. Clear the SEIS bit by writing it to "0".
  * 2. Read out 12 words from the RNG_DR register, and discard each of
  * them in order to clean the pipeline.
  * 3. Confirm that SEIS is still cleared. Random number generation is
diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index 7a2fbb0db6e8..ed39ff2fa4c7 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -418,7 +418,7 @@ void k3_nav_ringacc_ring_reset_dma(struct k3_nav_ring *ring, u32 occ)
 			k3_ringacc_ring_reconfig_qmode_sci(
 					ring, K3_NAV_RINGACC_RING_MODE_RING);
 		/*
-		 * 4. Ring the doorbell 2**22 – ringOcc times.
+		 * 4. Ring the doorbell 2**22 - ringOcc times.
 		 * This will wrap the internal UDMAP ring state occupancy
 		 * counter (which is 21-bits wide) to 0.
 		 */
diff --git a/drivers/thermal/thermal_sandbox.c b/drivers/thermal/thermal_sandbox.c
index acc364feb036..7dc0d108b8ca 100644
--- a/drivers/thermal/thermal_sandbox.c
+++ b/drivers/thermal/thermal_sandbox.c
@@ -12,7 +12,7 @@
 
 int sandbox_thermal_get_temp(struct udevice *dev, int *temp)
 {
-	/* Simply return 100°C */
+	/* Simply return 100 deg C */
 	*temp = 100;
 
 	return 0;
diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index 426fdc6224a0..986ebaf69b14 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -19,7 +19,7 @@
 #include <power/regulator.h>
 
 /*
- * The datasheet is not publicly available, all values are
+ * The datasheet is not publicly available, all values are
  * taken from the downstream. If you have access to datasheets,
  * corrections are welcome.
  */
diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index d2f716946814..f14f7642d0a2 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -19,7 +19,7 @@
 #include <power/regulator.h>
 
 /*
- * The datasheet is not publicly available, all values are
+ * The datasheet is not publicly available, all values are
  * taken from the downstream. If you have access to datasheets,
  * corrections are welcome.
  */
diff --git a/drivers/xen/pvblock.c b/drivers/xen/pvblock.c
index 1df04e239ad0..9fc51d203e5e 100644
--- a/drivers/xen/pvblock.c
+++ b/drivers/xen/pvblock.c
@@ -79,7 +79,7 @@ struct blkfront_plat {
 };
 
 /**
- * struct blkfront_aiocb - AIO сontrol block
+ * struct blkfront_aiocb - AIO control block
  * @aio_dev: Blockfront device
  * @aio_buf: Memory buffer, which must be sector-aligned for
  *	     @aio_dev sector
diff --git a/include/acpi/acpigen.h b/include/acpi/acpigen.h
index 2c269ed6627e..3aa94d70b9ce 100644
--- a/include/acpi/acpigen.h
+++ b/include/acpi/acpigen.h
@@ -121,7 +121,7 @@ struct acpi_cstate {
  *
  * @percent: Percent of the core CPU operating frequency that will be
  *	available when this throttling state is invoked
- * @power: Throttling state’s maximum power dissipation (mw)
+ * @power: Throttling state's maximum power dissipation (mw)
  * @latency: Worst-case latency (uS) that the CPU is unavailable during a
  *	transition from any throttling state to this throttling state
  * @control: Value to be written to the Processor Control Register
@@ -920,7 +920,7 @@ void acpigen_write_pss_package(struct acpi_ctx *ctx, uint corefreq, uint power,
  * @ctx: ACPI context pointer
  * @domain: Dependency domain number to which this P state entry belongs
  * @numprocs: Number of processors belonging to the domain for this logical
- *	processor’s P-states
+ *	processor's P-states
  * @coordtype: Coordination type
  */
 void acpigen_write_psd_package(struct acpi_ctx *ctx, uint domain, uint numprocs,
@@ -972,7 +972,7 @@ void acpigen_write_tss_package(struct acpi_ctx *ctx,
  * @ctx: ACPI context pointer
  * @domain: dependency domain number to which this T state entry belongs
  * @numprocs: Number of processors belonging to the domain for this logical
- *	processor’s T-states
+ *	processor's T-states
  * @coordtype: Coordination type
  */
 void acpigen_write_tsd_package(struct acpi_ctx *ctx, uint domain, uint numprocs,
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 7a66c7af749d..ee18a63e4601 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -153,7 +153,7 @@ struct mtd_info {
 	uint32_t flags;
 	uint64_t size;	 // Total size of the MTD
 
-	/* "Major" erase size for the device. Naïve users may take this
+	/* "Major" erase size for the device. Naive users may take this
 	 * to be the only erase size available, or may use the more detailed
 	 * information below if they desire
 	 */
diff --git a/lib/crypto/x509_cert_parser.c b/lib/crypto/x509_cert_parser.c
index a0f0689118f6..34de75a3ece3 100644
--- a/lib/crypto/x509_cert_parser.c
+++ b/lib/crypto/x509_cert_parser.c
@@ -535,7 +535,7 @@ int x509_process_extension(void *context, size_t hdrlen,
  * Decode an ASN.1 universal time or generalised time field into a struct the
  * kernel can handle and check it for validity.  The time is decoded thus:
  *
- *	[RFC5280 §4.1.2.5]
+ *	[RFC5280 paragraph 74.1.2.5]
  *	CAs conforming to this profile MUST always encode certificate validity
  *	dates through the year 2049 as UTCTime; certificate validity dates in
  *	2050 or later MUST be encoded as GeneralizedTime.  Conforming
-- 
2.44.0

