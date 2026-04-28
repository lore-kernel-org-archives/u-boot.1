Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394D0FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F167284307;
	Tue, 28 Apr 2026 05:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HBcrekTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACC5842A2; Tue, 28 Apr 2026 05:48:38 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F449842CE
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGSjim6Re8rj1IDS4jOnTMjfzRzSxBaS20IR7N7uEGTtbsLh4PvZhJ3o8uw3neroRq3IhtY+9ItJ94HRC8bVOUnnpICQq6h7rPqpxgJcyKFvq+IPVaMYRHTD1Hc5LSKwu3Wrf26wytAmH+Co6eS0SzJsSVLghkCKAU5HHzQyhB0gEBiaKIHCYLDIjHjc0tZaYTJnUHPwpQlQWfp7R/kMzsK2fhrYIiMRaOKSjgHwISq+ujKq0fX2NuADJOlm3dxUUzT+vKmpQZrBzI7Rxc8WHC9Fz6JknPm3zrBQgqRf2fcRxlclqgw0rfu7UvyuIWxzf2gA+yUKPPtVO+6z5XQ5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm57uH8OTUY9MJnCb+LhMW7oLT0d35RCN7/rBMSB3C4=;
 b=Pnueh30rjhwWu/8lRQFMrxHP/8jmoaPs/4bIf96uP7ueHYEKJ33fHrJRoNXHhf60ckDP02lkYaljnJT10R3bAdstvSOSTGCnv1bEJW2q9AJbS+3t/q8cembw/m+kBF4fH/wBxVj9fSol/pUKijqBrx/DEXtYJeQt621hPdIl/4P9jEP3Crtn5/aEa39Oof69chkUUWJ8hcN4JI3CWAvVPZK7lTYZ0Vo3gBrfjC0ffLif5lzqMyAq2JQSaa27cIfpDx28VY1ibmGQUtJxf4ju3ggjZaIq0NmP2lQ0LZMm+Ku0ZSPDkWT1Ps67+yZmJGj8vkuGYNUXFJFFMTI1po4EaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm57uH8OTUY9MJnCb+LhMW7oLT0d35RCN7/rBMSB3C4=;
 b=HBcrekTGqSxQ7MpvsZ6lON5au1ATRS1lPKq/r5/8ZsufSOZRRm3lfoCj1KpLraHOONHgcFC1GxVYW9iXPdlm8DCTo2Hcpq7uC2axYbFl/UJHYNZ/RKX8RWA4G/9E4kuxKtJMbUjQZrwVA+fIZMVhnS36xFO3m8MtqmF98xCdBNAHU5pwsOXNSINHIqjA+q2wNdxQNAEL56Rr2Hwj5oretko8i/i1UylH1Upcp6gZoeCYQSzUcZBwPA8l1zgEtHpX1Ma1EgXCC7to5AU70EgnTm9gIegErMbBnQIrGwtxeGZB2nfncxFROtELnJQjMWyu8k4IYoNX1R5gHJZH9+/3pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:33 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:32 +0000
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
Subject: [PATCH v2 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
Date: Mon, 27 Apr 2026 20:48:17 -0700
Message-ID: <20260428034822.23756-5-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a214791-2587-47d1-420c-08dea4d90468
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: wxmQdHgU/2oE/NI46ZcpqTan5l0VwY4KfP0WHPtqWZHaTqnWvlW02JOFM9qJTpxrATM3XyxzRfrbVD24Wp3WhwtZpHY4eXGbOerwstE3fErSf93wMIqqeSSY/dhDr2Czid8+LkHy3EkAMddQZI04A5DAoKo+O21cI/vajmltozmPTAsLI8JruUs9VYlIAOn9kiIgBaJnr7IOr5ILBJEHp9vgX7/4o4orRqd7/qNDGISzrH9LBYJ6N6yJ0eJAW/LDG/lZhQHucwgS6yFt8UIy+L7VA6omfaESkLpUEjwcTihs0f17U9ES4tgbgOeA/3VCL/42iYf9zIPocVEEcmdII0+Zg+caTq840I/iaJzkHm51f7h2HB/Lt0Qr0D34J1y2QxYAgywsAiarfrpquQcXdh3aIdOWUf94YftqUhMnB3NLl0yUpKCidpKar4gv/cvf4wka+MNcP3wy7BeQ5jqo+GURFXcaE/lgz6ZyNCMsZrwwGBHxAdOtZDV+F3VJADy39sgJk2cBDvpWn8ikFl99y0EwFE4ZgA9Fw4Av+Ysw0Pvk6MnRmMT3xT7HhBtN31QgaVMwlJQUF3/RlGs9a7at9c4tZBAyvw37uvpGNOsGeOsdXyfGvhN7m34HyieMHxw7JuvI/G6NKOZY7RJChmQw5kKiQPsKgno11TdBnGVEg93a/n5aFDhW+ndMjJIsSyUkcXnKOPSwYj6zPe2rlN30QiXEIkg9Z/BCOBT3hPG9mKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bvgLYGvQBGDrW9DIMDOcG05wJaag4jIw74pe4H4DlqSu6Fpn02HbpQ4LUZJT?=
 =?us-ascii?Q?h4/nuSDSkj6mUNL21KqAc/llNnBXShWwKfBjz18eaH3i+qEwpbqyZjmiAKry?=
 =?us-ascii?Q?NWHANhcbylloeRT8h/HSvd8ej3sZmwZPYQsMW0aqHXxMRF7dDIeyAmfZL5bK?=
 =?us-ascii?Q?G7DQRZTDj5U6JlNYPXDVa4iHJjvfYToYBJIsM2YwidgeJIkksklYbHOrFUXu?=
 =?us-ascii?Q?We9gaBuAQng72Id8v1BkXPwHBp/AiSXso/+Pucgr+6/xS0IGCrXuFXV7Dbzu?=
 =?us-ascii?Q?fJJ+N4HwKfuE/W0pKlVuZdx32uUUBiDdtMagDqq8G06DELjJtehuwNc6UlZQ?=
 =?us-ascii?Q?w8WYTnYuu2y4wcNk5J5HJKF4tquDKrWDhTX76wMa5wnbFb5c2DB4LUiu35Bd?=
 =?us-ascii?Q?BMaXjTuJMlhF2Whk/w1jlFMwYfcYX/doyf8rkkuCu7SudFCDSS87vD0DMY1s?=
 =?us-ascii?Q?o0xqUFDfB+3eMn/1wCyuaYN9sYtiYuZKmUtYXE46ERRg4UgBmbLUWRFMl2Mm?=
 =?us-ascii?Q?PrhqldWKyyUJPV++4D5dlKWkFGR9ealSWAVjNXSRsKKXzwtaBWtapDE9S6+E?=
 =?us-ascii?Q?P3n4NWXqQUllB+XOWIr6hRafw9T/kg2Ic5BebfI4tesis+Gca7G74rNwFDPo?=
 =?us-ascii?Q?F8oQjCXqY4ssZvqCYS+4dgMrI8xTwc78lNYU4RMvs5U0xRA3eBrjrzW/nhCT?=
 =?us-ascii?Q?cVSIs3V1jdl6bc+vWM9Ds+BxwtdbFgOXpEJHJHbKcblHslKZj6w2OG4gd2KL?=
 =?us-ascii?Q?SYsipkA4UYhpq1hC06+27nK1x5VrPFH4fCv6qQ/e+v0NK4987Fc7301Fl8Ls?=
 =?us-ascii?Q?74Zh0eBpYWA5XQjMavmcChnsEuv31F5Gjs7oYH4nKbbHiBEAEki0MQhigzPe?=
 =?us-ascii?Q?xa9OYO9Dp+XscWm7mffC1bXjITdH58+XJNxJb81mdYnKjqAS3pr+Zdjudiy+?=
 =?us-ascii?Q?DkVrPiwdhaH0HD9AAalWa6ggPeEExdk8Bot8S4Efkr21SDGbJjIBE9yqrtHs?=
 =?us-ascii?Q?cxpDDZ3FXVIoq58cjjqiVRUiJKKAAqHq69SjoPmohGTyKg5YqVdMxVgqQteP?=
 =?us-ascii?Q?DKfexnYQyJgARJCpCpiTfqM2zzJ4piyijPSXQc2q+Flshp3ZIs9Ed6hgflt3?=
 =?us-ascii?Q?Fx/WW4VrsHl9FcFIXYHZ4RPCjl6bnWoJp/OASyLD4uKEDgk/STbvTeSsvuLB?=
 =?us-ascii?Q?pwwF+Rn/RHY0rS8l3f30hzF51qrCE/OyUqs+tJyHnWsA94JoIfH/gYJ0gxrX?=
 =?us-ascii?Q?g9JpGQMZ7g4CAayxySU4hSe3K5898ThwYPZGUaQs5901K9Bxr2mDB2lOPtPS?=
 =?us-ascii?Q?/ne7RzAS9ZJnCM/FV6DESkBJ424Z603Uu7p+8Wl/DekhZiP1PgFg3KfWjRIB?=
 =?us-ascii?Q?jiuByrb0D5fOEFWBVtk5rm1YEekNvNKnssOGDVrj/eNVMyYYUUJyAS0vZCff?=
 =?us-ascii?Q?qBAzE8N4JXJymZnoAunz1ef3uCul8A83pz90HFMd9oPl4kzsS+c6ddbHqCc+?=
 =?us-ascii?Q?fdhhyi40GdNaKnnaBStOS0lEKXr6NmCVfUyFHkOkNpt9/ty9iwpQWtWsnxhc?=
 =?us-ascii?Q?hS5aVkmGIkqaXsRcH9dEHI+REfSnmklXSyeHePV/cOeuYk0PvQ4KlsWhKSUj?=
 =?us-ascii?Q?+ZpIoGLoV5wJL3ExQWQs9+hchG3IGr3LvD4+/S3nASkxk/gT+VYg+uz59XGW?=
 =?us-ascii?Q?FoFIRTLrpGmrEFEsiwhnFkwlhXzLtpEeJSG3ib967wYXH1PFXbgTC48iVJZq?=
 =?us-ascii?Q?cmrWv6bGbcIE8kw5NUtXtzTYybVDMMdEiAxjUN9iSqVMk4G1eRpi?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a214791-2587-47d1-420c-08dea4d90468
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:32.5413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNBrUeJEHd1179jAUgfvYIhWIFGclKzOj+nYplpEvjkqL0YnZIGtVn1bOEllLBUZ0uk9ETj+azDIH/7YYWewTTLORO6hahaEtyTq7UzgDPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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
 arch/arm/mach-socfpga/spl_s10.c     | 17 +++++++++++++++++
 configs/socfpga_stratix10_defconfig |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index 8ab80740c6e..ce1d5d4c8ff 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -21,12 +21,29 @@
 #include <watchdog.h>
 #include <dm/uclass.h>
 
+u32 reset_flag(void)
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
index 02a1875a72e..6a6f1d98c16 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
@@ -16,6 +15,7 @@ CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_stratix10"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
-- 
2.43.7

