Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD5CD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40968495E;
	Fri,  5 Jun 2026 03:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cNQHKvlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8395849EF; Fri,  5 Jun 2026 03:56:59 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B349084999
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPlLUdDR2VCHjdqukn0pP/2da5MqA4YSA4dRZSegQxklez9bKHhEKTfCxO/pN5rZmJjNGrzR8H/sZjMj5AC7OS2hEuA/+cI3DD6i95zwXVtGZ3aqdNj8CZwmObxbZzGvcRXy7laXgfTAeOy+yxRXfuoeksfm/15zALIM/Gh9txJCiIzDQB2uD7tmAW/7gcn43JI6PvHAr86tLLqMfPESNM1kFzZJ3KP1GHl5eBOp+jG1ZkW4xBDhJz656bkVI0WveET2WnJ+G9tpZKzaAyxgQLjOn5gWiMII63fbCS6gHbUA/bb9ikxiWrL2ae+8cKAnZ+rrt2syZ9buZQ1nQBZaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS++m7AzkFEBihkhhUrZOSyWs8+Ql1psOkYW4N5frVw=;
 b=d5lr8EakIvyvp9SDz/Jkc54fWGB8HlhjHOUQZblMQ9k5lN6gG5i3a2EmvOcbq2RyAudy5n3I6jqrpOHfROlApg0Md1obOxoAq7W+WPDWL5V7ELMmkCztuJEIMo8sJOKQtOGbO18nSlqbKqCuHBlJVN/0SceZ/VHmisefdmkUrpHoqaY3k0bi1smTcec1oPwWSuAM/UMR4w05+V/bs9gyUze+VmYaYFgltWv2wmjlgUrNG/L9Mgm2fjvmz6k4ITKzSRsr16bCYGIjSflVSDrz6Y36nk13VyKDzycU3w3g7vQ74Wtq9NV5zj+frqobG5+/tG3PN8Hfcu8+8z0nQ4xIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS++m7AzkFEBihkhhUrZOSyWs8+Ql1psOkYW4N5frVw=;
 b=cNQHKvlCzFfdyxu3zA1p3cYAqKFogIQwzRZIGhq2TjrNO2wB2YuD/U+9CGagmJJ2LNnRrjSVeJ00G0/8nYTCbmorqpnrpdfrlZ+pF51laFWyvpaCVqnPb/GDicukVTtHD1AjJ74n1IDXqinBUvAQnRbg6lw0UT/9ZE7UrldQCjsEfMV2y3xuLtzlugm2YdmdnHyMcTVDp2MHnIeBGwk6Q3y3J6xWY10de8KyhficIGJ4Wh4vBEwcRiqwetZaoaYGgsYY34K9eOglE95e1ynPxAsRJZgQlpYFfhZjxQ3/snwMmBfJYH3SHOFnLT+B5ElubwXyW0oMnJUxSD7OoGZkQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:47 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:47 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
Date: Fri,  5 Jun 2026 09:54:58 +0800
Message-ID: <20260605015503.11709-5-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfbb10f-f077-49ed-9252-08dec2a5b36a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 35xf7UWAz+/Ntv4wtR9kTca870r+aeAeM1Fmq5C80ufKNaoeZ6M25D5TmsR25q6yDWkxSAvg66ZtYl8eSH5DOztshwSY0s3C9wiXufg5yYIbSBBOavuOv7tYIah2qDB6U6hs0iSS7HUY2n64QJf+otHQSriMONujdsWLltyMN1zRr9jTySVVaaQ8fDfXDkKnS/8zchR4uAVsMT5sJVtJ+xT/F1ZfuMb3I5ikEWk77hf4eCc4k9rAxnE5CmyPWiQW5pBkS61x6o4sMKV4KNeJ9tDAycVYwjSvHsn65UP7n/OwT1xqu2Xi1wqZYn4m0L1J7oHEPe7pkBmBEXxcta4xqgFUafZw3dS81PjPhIqsLfpN62nMY6I8P1SfjodND/mposU/N2K1xvlP1Xg/KKxMIgQ5lyr1k3e2UU0UqWK0XCfT47yRKQDiZSxmZXF4YoXDsAsvzD6CpOQuY2MyvbIsmy96f/6potXGR1vWY4PSs0cqGCkqLWlNin5Hh49qO4dDAOgw/v8KbvVw4ghHimXMPpAqmIZgnre7SKEjRPvNpQVGUjaEhDBbnTIXtBDgehG1GZ51MChnMVAqrAtVhXyVtvvwW0Y9HtD6Oon+N5VwR+qxqLfJfBF0h7UkiVwBpnPH78dOPvkrTGgcUaBOVR7nFjSHXXyeuD450VUayCfgcuFApUrdOJ9oMWXSMjdiFden
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjlPbOBZ2bRRTTUcKY4x0qKqvsmMwAECFn/T0pr8Ks4RH1BmflZ+O7dH/hcD?=
 =?us-ascii?Q?gKvlAnoiR2EkPo3TP55fCrAphBdBj+d2dMLRG44HQ7B0vgis64Ny4hVWIAb8?=
 =?us-ascii?Q?H7ZZQ5OPvVLGIMkX4MiX6IO/s+IXxHv/Bpl18u6OoktlR2KUzHC9k3UL476p?=
 =?us-ascii?Q?i8zcCSEhVdUYeOnCSgO3LQNhsCwFmwCEDgTscQ1hC3dHPKK7c6XDjuzLdAmf?=
 =?us-ascii?Q?3QLJk+wifR5ET4Zqrse771hTXblqEibyq5DzCl96Kmp52nddonHr//plUY9x?=
 =?us-ascii?Q?iTIBaZINNEllwcUQ/Q6ukTIKAcOSlxM0IgXdV4rQ0Y3du20gmXfbO64U2G5A?=
 =?us-ascii?Q?nQfIPevPlKZKw611l0ytpLMtv2I2Pahgg5Jq8SN5Ndp9CWGVtXYvcbdBGRE/?=
 =?us-ascii?Q?jxK2azMQDi9R1hb0OqqRuFeFXU+z3y/1RGZklahKiTl+rN/Zxh7/7TmJuN3I?=
 =?us-ascii?Q?5NkFp2ZWcONNxtKvZ2MYCZqzpVP9ueH/RKPZaDG7poUfLfHT2rbPpzOrOUqo?=
 =?us-ascii?Q?gaTgD14N9yELoxER7ARRNf6YRHsUgfQMu9HP0bTZa464GmepebL8/UTD97l2?=
 =?us-ascii?Q?+xlklFw8WKUl4QkpsaiXGrGLgCwIHYomoDX6ozZBmCuA+Wk/w+o9ycuLuwEz?=
 =?us-ascii?Q?u9v4VEN+4qQPgmdx2KuXQzF00j1I+QmQjSV29gXxMoOayKY4CFwtHRTBBnmb?=
 =?us-ascii?Q?xRP1VWljQrodR/oRnhTgqUIQGaNVC1mwgxGnjFbqOjnD1ySlE8N7KtSWZZ63?=
 =?us-ascii?Q?ZiPW9yr/DL0Vdv2XSBL0Q5BDtH/yRmCsx+X7xcB90aSFXCGe+VX3iwN/hFxx?=
 =?us-ascii?Q?HZxKlcrT6j81yD/8J14KjTweWy68t/s0Wk/E5G0FaBKGUDzA9DYy5u7JeoaB?=
 =?us-ascii?Q?mWHeR4wXuQ6Vajl/DXZ6FuXGn2gwvfDeu56n9A2YzNBPzbFxrZiw9rHv160a?=
 =?us-ascii?Q?5wXEQTHTCa1BaC9fiUgjXrGNvSN1F9m6uTJGw2o9nbXzNYS/ggJVTvyb4ce7?=
 =?us-ascii?Q?oITGmxAjHihvmnMHjEpbG/6/uIt9mrqWALyT/la+84sYVJSQU6Ae5vbOSudU?=
 =?us-ascii?Q?vVbprBAjKo47j+b+UC2ZOIUTfy6PUiQahooB1Os3drZu6AJFnVfoNlfO8S0/?=
 =?us-ascii?Q?7wZYWeXnr75UAfz/eM68E31m0URWVHFcAkRqn224gtBEn0segFIghiWLLqvH?=
 =?us-ascii?Q?1fJhN2HGxRrb6NyyIWK29Ds9e9jaL1vv9HCkgqQu7V1AP7oRi0DJDOYrciK3?=
 =?us-ascii?Q?4mA2/HLB6Og+1ec1rKs6X0KZUlqKK6gIj5ycBgPV0/nDICSvkvvmU85J+3vu?=
 =?us-ascii?Q?cmlYPL7f/jtcDAAV1HkatbU9JglNYsWuRdCFbUmZ2cyqUWwXNpva/871efsz?=
 =?us-ascii?Q?HgVCrWo54o/Sf6z3lMQo9TWPu/hrky9rjf/4DiOIZ0zpzMOWeM3GTNSG2yQw?=
 =?us-ascii?Q?OpWgIPyNSFNSAr8easCXjDyNCGbixxuflN7SvyGsF0ou4SyqLFaSuB/UtPVY?=
 =?us-ascii?Q?a6dR3YHRhLfak7A9BTLeBzior70KATETIHUkArfhdcM8DbCtJg5ADgbQ0neC?=
 =?us-ascii?Q?CURtfxKeT10UB+SXqyXIHCDWvcl3uomp6x2olSwcsqp1zu3/ZN5r492XPFil?=
 =?us-ascii?Q?/TRj0/4+hjLLSpiXx//gv7s3ckYcBOaRLoIu5ZX7SKrnA/ruG/uU4g6hllTJ?=
 =?us-ascii?Q?uhwoGA2/M+J+3cabaNm/ECpRXKsFnbr1lavKmkL9VOS2v+nZemTO6PHxOWvn?=
 =?us-ascii?Q?PCJ17PIa4Si3o04CmoN9kAwQPaWBir0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfbb10f-f077-49ed-9252-08dec2a5b36a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:47.2056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmgy2BMqv/5wGCfgvEEl1UKzwNs5c3H9aA68kCHtJc1sKzEX8uDNZIr6BOOQemsoQG9s7P9OPHJoVQFNQeI/CaOuo9SFwZZpA6SJW7joX3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable backup for data section to support warm reset in Stratix10 SPL as
no SPL image would be reloaded in warm reset.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v4:
- Update reset_flag() weak function to take in u32 flag parameter

 arch/arm/mach-socfpga/spl_s10.c     | 17 +++++++++++++++++
 configs/socfpga_stratix10_defconfig |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index 8ab80740c6e..00d43460fce 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -21,12 +21,29 @@
 #include <watchdog.h>
 #include <dm/uclass.h>
 
+u32 reset_flag(u32 flag)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	const struct cm_config *cm_default_cfg = cm_get_default_config();
 	int ret;
 	struct udevice *dev;
 
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		spl_save_restore_data();
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 82f0cceafb4..be0c452ead0 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -3,7 +3,6 @@ CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
@@ -19,6 +18,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_stratix10"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.43.7

