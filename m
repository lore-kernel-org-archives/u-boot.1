Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB668D73087
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220798407E;
	Fri,  3 Apr 2026 04:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BZZN4YRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E098413A; Fri,  3 Apr 2026 04:25:55 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8CE83DC9
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjc2Wk+kJhVcggpGypri6bGLMMuTQADaPAh+VbJyuvP8RBKArocO0Hl/eG+nbKjQDjz2odZZAFYjqW0pOcfonKLb19U7YPl9hhVPJZPLhJqc1+2LcNfz7YvaGS/qL52orQuck9yEuk21+hpQLwxWOxyAGCfPl2tQmT1fSiZ2UHG3jVSeWDpIPj6aKEg+I6YkfpMrKwt4PGH6NbMXUoPmy4rP8ntnDL+0iq2MM73e5WJEklhmF/uPwp9qAMpFQ0UNqOBFOqcAGPmSmxAcSFkRnv38Une6ECnB/bpPs/epWs5u0DRJD6rRLy5DLcm65QNB0EuHSQIHYacD0fuHI6yQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm57uH8OTUY9MJnCb+LhMW7oLT0d35RCN7/rBMSB3C4=;
 b=KXVKqkjuoZuZvBsU2OtksY8obzdq4I3zFrIJNKvZQgMgo9rPgRuwX/HG5bPpZZtvlQ9feTIUg8ttbpPZdKnaYYicsVK+q1X2Bnq/thm/1csnFf8vC5BQcjyX8ZHcw1tI6wzBnUCSHAUhBj35i2VIjyl0SVd6GUrrbGR2mkV4He7Qh4xo+fwBjsg7Ri/CNoDeAEo8WwltEWI/6Fc1TTO2/HWjlxmfv9qXu30MIgOwik4dg3V7xXGMBIjhS8Fp89Kq8iPJXsVPMpv3cFOMNpwRuJvTgacYhDEthZnrkH5xBEnVcIYJv7Mho3MDYzR6w2qe0Bn16XdtbIfXeTzBkmF3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm57uH8OTUY9MJnCb+LhMW7oLT0d35RCN7/rBMSB3C4=;
 b=BZZN4YRyqv7D9i+rdrRrrmHGHAzxkg6mQwgTEPIkBxkqZID1aml4Rxe0kAPBjOs9z3UX269bJ2P0I8fiDFlGsNEGYLovDR1HzXh46DgeIwzdOQMaZI1klSswBD73N2UdRFqQ2F+gG0UjSNl9nhXM+RlSzHso0wLBG6s1cN9HuHl6ZwJCe8oehNE0lK4JX8Z3IJeR9chvH6DM2JHAKY9B0j55WnMcvvyzyOnf+ZRGUv8JTG4phoO6wQW6lQdHrcuBeZonjUflxD6PhPeFEvmgCPWWCp/jDtKF/3oacnvUkJVUjc/+fJgP9FDfLL9mu2+FF0R1CKV/6D2RX3ZodTWboA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSWPR03MB989164.namprd03.prod.outlook.com (2603:10b6:8:362::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 3 Apr
 2026 02:25:48 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:48 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
Date: Thu,  2 Apr 2026 19:25:08 -0700
Message-ID: <20260403022513.9446-5-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSWPR03MB989164:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ba5347-02a5-44de-fa69-08de912850ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: w2alxlpPdIjFX6RUIqfzdcITvDwcGvyEjILciaooz0AzZLrGM9rOEwahTouMSX0aAYBUuWyX6V1SbFzkGuJafP3N2BGq+Js5DvatKegkeUwsn0ftve4EK3tXLqlun4ozyx4SLGriaoLXUYLEX6BBwabONtq5FEg1bVinnSQwdUXd6Sr5TyvXiv0wliB43bKLtfDbkMjRXmA9uTOH05PZXGUh2XWOh+aUE19GZlPXaZv/99Uy98XqWZZ6oDmz+UlkkuAasjtoHkz9LUmfa2fU4/5VoTJAndX25cN6/MwoQ095/Rljey5pegKBfIEGIkcABM/4fmjdPV9TnCjKihOh1suBnA6eKqyDJFIJFGa21cdsKc0o25Fy/uKZW5CfTfZCReeVEJXAyiXRKdwJhDJkY9bXPNPaoijwJpuOGHWin15ONa2SADqzVf+dz58vCPzd2ye3rbujumTIXdMzFB70Kx1LLzhl0xKN774CZzJXmD4XbT581zc0dX/HH0I9N220oVkBXF9mWKWQeJWKGaYr4SyTpf5y0fny7N3imViF2R3AfOkiGBG3/c7Qtv7qqNLakdSsYHYN+QundMMluLo/gNlYJl6K6yU2sY4Ty7e8LdABgbHWN2NQzo5HYR17lZ+Vi+nzeOjjl9U81muvrCjurHTxj7TzTLFpTZRdEIPjqiJGXLcGQe+o8uPnHeUw+iBq9eijYzlSS4uEwgiUG7gUdP2qrb90zFF7nbAPHk2wblM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jk3UxAZsnKLg7QAxz0TICGmqpdp/x0vOSdczkzsmJg/9rstButm3A9+PZPqY?=
 =?us-ascii?Q?gIsb4Wi8XoxDH7wOftU/YGb+Ehp6cnEuhxBMD5x8JQNkg7lQgYO3k71zVsUp?=
 =?us-ascii?Q?AEeQ905bjlsn3egQ6+B3PePG+wW1stgMy2vh0DOIH0N2BN52iGyA6lCZAxwV?=
 =?us-ascii?Q?7qqXz1mWHtCFah0v6H5syMGKv7aubhe70vrV4kH4sj/alWQZ0g8iVEYQZO1D?=
 =?us-ascii?Q?n0/3vYjJVnH4neYXXkpua3zn85lPo5c1q5Mr0fhebG6yanthg0BdXzgfXQMc?=
 =?us-ascii?Q?Y244j2DfwieYFuwjRX2tSYKf7IsHxYnclxsKx6MrJgVhse1bem/o72IXQkt5?=
 =?us-ascii?Q?m9JztTRlyI/0OPq011Nfouith/q0LYw8wQ+w9Qac2CvyIhSKn/M5xH8LGDLt?=
 =?us-ascii?Q?N9oji2ukVzh2bUf24ieE3Odcoow/DMXvgODuM7+S6OTLT3KldB6wE1tKpbCy?=
 =?us-ascii?Q?1zaesP/GUgiWyZJPFN0JUiioEj1CXITEhka6j7VUgCvHL1M3hu4Ue1dmSQxT?=
 =?us-ascii?Q?OPt+3zDTTU9TiAUyE3wWqnYQrl0msAjX0szqFkVl5SMxbHuB5sGwYQ5VDt8m?=
 =?us-ascii?Q?sO4Plmmva4ya1/ORUklRHvlMEp1tK4GFvbuM+9LDNgsifj43uYIfRO2iCxcl?=
 =?us-ascii?Q?qgAY7yTN0u7qaY3JO0PYWORMR/o7HBRocjB1zD/tw6OIUBQmsGsnSBb+rh9T?=
 =?us-ascii?Q?gmkaHIDXf+9DrJicF4PrDu2un1Ih3BDCEEY0u217aIcT3mE5IL9j4c/mfmJU?=
 =?us-ascii?Q?46NQLm1+I0zMZi4IjsxDLpAbEauzqy7jm81tqnTz34O1j5SxAPq3dhakIjdP?=
 =?us-ascii?Q?Kht0krT3Q5E+CwzVQbnXIBn2azcwZ6evIuuFENVyG+uw4TgUUyf6xekVVbuf?=
 =?us-ascii?Q?m+sdPglaXhEW06JFhmXUgQfZbS/QcCZoYz49lEaMVcXHpkyeH/B4EWC3fNYh?=
 =?us-ascii?Q?tj1e++yLjPgZx+yNPgrlnEbGnLhPPPlNAXcZyTt216NNQG35MU3f9QTgsg0O?=
 =?us-ascii?Q?2mLgD61knRREPjKEZE8xQygd075BP+MM5dJXnBKRTd6/9YzGSxdM7BzIdEDE?=
 =?us-ascii?Q?GQBwnaENoE8KyltN+3oscRXtO/VJuZabh1Qz2PQh/7ufhLeRG9DiFp9kUnJt?=
 =?us-ascii?Q?Z0UgjmOUMCmPHakRWoNL2gvKJYZReKTpmD65INMM4WvZpw0F9+1s/MQFcNRY?=
 =?us-ascii?Q?JRA375cZGYGgSrxc5LySypiIjKAYgRZPFQhuLbDkvfKQIsNRckFEPqb0epgz?=
 =?us-ascii?Q?hDMbL3h41zd7Pf45A0ympXH96rnDIEOEUMhffGL0RsYOXAbbFhUBBlyhBCjZ?=
 =?us-ascii?Q?hWRPIdHKtiInnOye0gLGHEq4XKrgjPoc7ORNWKRyj4bGySphX3+AKbcGEF2r?=
 =?us-ascii?Q?wRP43LAJyqQCOYCxumAA06p5VvIvxo8Hdpq27HnQ+C0iiso4ctDPRo8DMM0C?=
 =?us-ascii?Q?TFHppIDF30sKcMURNotIl/RguBul5zO8zGQKVSiBlKqA+7HC3tZvD+BPHdjS?=
 =?us-ascii?Q?8oC2W3KiYE7X+iZwrHqxU708JO0tlCbW07mEODlcmGHAiNcujs2DOqZFQlZJ?=
 =?us-ascii?Q?A+sok2C1lT0BUDb6cqtXl1pc0m9CQ8L8pMIM1UlWTRk4jDGcW99SewchQFnO?=
 =?us-ascii?Q?2ODestafh87085GnMxCN9tjUTXUFgZjfg6Zi+2I6g3JApbJkhUdbDfcxkSwv?=
 =?us-ascii?Q?oey4BbNioUWzQFyDYfPcsz511yskfMqrOcyiMDmlkbMtAua4wAXnOCyx5U9K?=
 =?us-ascii?Q?dcMmBmq/uCUjKb1bciRiVQ00iBTEb+A=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ba5347-02a5-44de-fa69-08de912850ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:47.9848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jdetc9xgFHR+MxgaoCN/cgoO9qqmJhc8EWcuEhxzVgdcRA16swhL10Dwfj4fhIxOt27N/Ycv218pR8ZypLkphgE9Gj+pxXDc79k9roAYuzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989164
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

