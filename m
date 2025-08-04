Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4387CC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA4183EC8;
	Mon,  4 Aug 2025 03:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DAqWnfeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1295183E76; Mon,  4 Aug 2025 03:26:13 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7315483E83
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVkEOuLjhFiPAAramPZjFHkQAO9pSa2kPa3qpibYZjZGi3UoQpN0WJRBTkF+hqYtHvVjB5UMUt2UlJbeo70/WLkhOovYJDLJcSjwkB12RkhKp8pLZHW2eYtFFiJNvbF7pY1IMQniKvmTJZ8klkE0Ndu/gVszlrd9yVvKH8sSiqETP7clVcAQfuAP/HLmEhInZNjfkDERFGZohig4OaqntAdhlLbdZACWLMcwM4vXs+Gu+9Zv02IVSJs9QeRqgNOcbZLZ5Seh3XENhquaES0bkDFJmrMJZpK3PTdWf7E/HkFKtj+uSwC3zvw6Y5iOo+YMaUTGxkZMvg2hG07kb8tZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grHnhNOtOt+Or/GKLkt8j+ZRBkP5Nd0PID1ERPBG3DM=;
 b=vnbKfzkWr/n4G+8bccJxGc4RTyJR4hvQXT4ow2slfQdFFrkNnLbEhb4FyU1zQdhK7k+EtFw6C3Yfk+oA+dCo1gKNGt3HF2W3Zc6uk9qW5hX8FUW4JokyO6D6zetV+/VeZn9YFFR484QXlwCLK5VDlTS84Ri2srSPtW5gT6OX72DlVYuwOYEg6MIh3WwxcVtXdiV0GTX0YojTpYiKvg2NeHOfCT5Vbd46w7alS2JAwSRrAbnnbPX/6ylvbSY0ukXo5MrnjYhmoMV0gt799qtHYOZOknpVAzSKpcgCAGkm49AAa/8heE03VwiNtwykzjrBU3z7z0AX9ryTAn5xZrqnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grHnhNOtOt+Or/GKLkt8j+ZRBkP5Nd0PID1ERPBG3DM=;
 b=DAqWnfeha1TXzj+HcH7hgjS7Axmnqh3Fyr2zfABeoAGfxXWoNiDSqtPu0LUzRVZAS6GNGKxEKUX58q4x/r5DJhvIi9WyGh5nDTwXD8lWDaJK13eeKhU2f5GrpONyFisQ+x78OquA+MVpRXhPHPAl6wm9p4tTrgvlrpg3f95tPXpLuHJ62gT1hN3RVY30p7QlK5Bri7+T11bols5L26j+6f64ICviy7qkEUqt7KNtes+IQGyOb1/FBziuAAdQA4lufxekdZ5Ow1QVtTlQJbIDI0QonGBIsyLuxVlPuU5y8hh8HK9qzy1hCHLaLvPPkfXpcm8nWPaZGwYADbyyP/bJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:26:06 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:26:06 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 32/34] arch: arm: mach-socfpga: Update kconfig for new
 platform Agilex7 M-series
Date: Sun,  3 Aug 2025 18:24:59 -0700
Message-Id: <20250804012501.21811-33-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: a5eab3f1-bd1d-4256-529d-08ddd2f5d0c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dVclYCaQBM9LyV8Q85Qzmw3yU546qdlyXc1K6qrj3E6KyzpMZ5KB61vwVHmo?=
 =?us-ascii?Q?9VwxA9wueyT6CoL32JS0AxOHz7L+feMg06jI5hEKq/QSNw+00R5ZtCScoG7w?=
 =?us-ascii?Q?LtnWu4CfYDS9DOKLBeav8CuRgplwbes2XPoSxrUm00Aw/BH+aoTNFiSNsRTF?=
 =?us-ascii?Q?F48Yg/b02t9POxUyGRQCXLEdJqFPWnsLGgXR/aSdzbTpwqfHWApldaG9vpbS?=
 =?us-ascii?Q?szpzhmVJChUau6evh5+z3zNi6UrP/mjXrIepy+RgEILrsJOKKcKSw+VAcwdl?=
 =?us-ascii?Q?44FGMI0YXBUe21Zqz8FaTjkuAapQxGYe6e4hYoWpBC1dfE2vTFY5SnkSpTxE?=
 =?us-ascii?Q?mqL3LtLzMwzfgdItBFJKyR0VxFwE6hl97UUjfU/P+2+RLT8IN2uorS1JsBGX?=
 =?us-ascii?Q?TqyPeaAdRgAdN0g5hXjFwUut5krKxWsoUg7wplqX7tWhjJrJB0e9N83Mvnar?=
 =?us-ascii?Q?M0QtcFAiCF5KoT4FNQ7UpfDU08+RTVzM+OI/jHoRzH00X29hwAhNtO06h+jm?=
 =?us-ascii?Q?NbGHVYl0fClde137UqsmT8CFBM1hS/2FahRQy7cE6LDK6Xkp8j6ckw9J5GGj?=
 =?us-ascii?Q?Edqbcc+kZxUvAC5lxv2Xcf4RKcBD2Lg218HW/dl+lvfAQYgYO+sBbVV1TAiI?=
 =?us-ascii?Q?qy8z8Bq4eLPcWVrPAz8asRX9pmXBoT3bAEhU0b2KixVCS5uHlcTUNO5vHSKV?=
 =?us-ascii?Q?f0CeKlT77qRA+1rIOCPMeuy43fFouzxwVaHG4yw/hKLzsRzcz0gL4VDPih03?=
 =?us-ascii?Q?M4G12N8Kj4kWMO9Ck9BfyS6znxei3cqWmLEpCG/BHFOE4xDxjDuqV3R0nXSC?=
 =?us-ascii?Q?1VyEugUEN0hdlwJfq6L21crm9W1VwkeHr/jPyzBFvmMeuoy40mz1x9704hfp?=
 =?us-ascii?Q?xZkh61Zg8VfyNl3FuXTQL1Nmi6OclkugOac5MCueuIHjEHAi+XGVl+1HEQLu?=
 =?us-ascii?Q?M0Y10cjog8f50y7pvlR23/y6w2ZQQb4vHk0yMPdZg/yaKbQIgmJ4puI10A1Z?=
 =?us-ascii?Q?fkp6EohSU7exgPLMxQ0M6/fqUkL++YLAmkWGB4mMARcRv8I6RN2FXWr3F2WL?=
 =?us-ascii?Q?FVPg8c3RMdbPZ8i7XfIIhSXtC8MPD4d5VeQ8oAyFU9qj3NpHUEqna2gOYg6w?=
 =?us-ascii?Q?98SsNXjZ8xNkTgIZhfm5HQUJMRNqHkB+6779Im3ovXVxZ7oE4IJqKE32NXgy?=
 =?us-ascii?Q?IbYS7ROssNI4rn9lFPg+7y2AxkGk57oKaHTa9mduZK67vF8owJjO19DIJoih?=
 =?us-ascii?Q?XuZz2MAcrwaI9qRpabq1iHawtdtGCDglXfMNLe6t0/65WFdOZE7wrtXV3VfQ?=
 =?us-ascii?Q?jrKfwPOcQQ8gylwqCP2oyMJ+U6C5dGL7rtESXoN4ol/7szRSXC68onJAr6gP?=
 =?us-ascii?Q?v5VtZD51N3Mplc9s31lMj5GCJCqI0VsAcuBIiE1xxBBududAMQotF/8QlpUK?=
 =?us-ascii?Q?hr2MbqdnnJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uM3Ry5B6ZtkzXxfgUnF3pO9MX4pW2bAxexz7RvAxnBSVj12g3n9ZaYHZ1wuW?=
 =?us-ascii?Q?fgNtYWYNlBr0Iebz9ng1mfdqYPcxtmJPkqZIBIqripQ98J9cunyJhrJ9zvgq?=
 =?us-ascii?Q?cqPbaOTESWLb1Acqz/51ebJbHQwQ5sSa0lmr52Gt5nNnSwh2YJodhsQgq5sS?=
 =?us-ascii?Q?S6NW/wIeEu5wShoyEw5DuhBxAZguL0MkFU22IPMFViuaxysgQkg9FP9qGvwN?=
 =?us-ascii?Q?0nNKufNPkdSsbKL3v+yY4QeSe9HrK5fQWoS7hpL05WmRVT8B1oBZ4/lML32W?=
 =?us-ascii?Q?JZvy5+TszIyVxP7+xMZ2STYCxwea1pFI8w5oDiB813/xqkoJ0FVNOiDFTna0?=
 =?us-ascii?Q?oXDRv/5RGoLeNCPHtPd7omMgTHwsUonhx6PKXbdFFAllgAl4WwMm12aiagm9?=
 =?us-ascii?Q?icLNkLe7sqmTTOyX6Sx3CTd7Ne/OwW1U2twdoNc4R4PjMObRmo8Yeu5Do+Pi?=
 =?us-ascii?Q?0Yq6TbTNHqmLlg4MzwUbLJVkFu8IYZrLNeHg/1bsAnBRDuuvVPbTXSv/8Pql?=
 =?us-ascii?Q?4RTBHDtdnn0swsyN8achbcUwkZFrZ3mQGn5mdQ7vcWqd4NQYduYL8UyRaWGX?=
 =?us-ascii?Q?KD5utEt2/RHEMMK7i+SojUXPRhHChd1wWTjvHEeREX51UHSiX+EvtTFf1HoW?=
 =?us-ascii?Q?dHqWeK0clGqXNzTcTrZQ4gsF+jMFwkm+fLdcDMZkNKNsTf5tMpn4XGp8RLds?=
 =?us-ascii?Q?7NFG0FvnXzDRYfeh2CPdrKKdtbwVsm2OgSfbjGp/sy2yGzYU8FexRP2Wyp4L?=
 =?us-ascii?Q?0fnTDH05z/URL/QUaz/XfXbn+3Rgq0ewLZNNPvFnmd5vYOevCVTDe0X3hOKJ?=
 =?us-ascii?Q?5iMpwArh9pfeCUX9DxSyBvoi6tsmjLuUWydH3M5c8SOV3bPXVqwB2NPBhAD5?=
 =?us-ascii?Q?VBZ5CJxk9yUPyVY+MQj6jSmyihtmb/C9PGC56UQRUptp0a3griqMyQNH1Tuk?=
 =?us-ascii?Q?LVzsOOP+iAvawHjekneBcAZzLfE31mizdb/nzbmZSTLA9kOx+Tv4sbtdzDsd?=
 =?us-ascii?Q?tq5GcxDk7G5A1WUQeHTFXxNKXe8wMdEfiU86ecqOrHredKA5+WWL7/fmRGe2?=
 =?us-ascii?Q?x/XFGICp4U35RViyZyI0gcjAmomGeEhJeJ57zphhcyaBVErpqHKnR8Rh/d+l?=
 =?us-ascii?Q?q3/RTXwOD8t8UJyJnENqeCRydPogj+syJU83Tzubg9eFxG/BDrZNcdi13tnq?=
 =?us-ascii?Q?z70TbgUBCBoPLmPleoERtoZHCBvhrllYTK7PVRK0DENVvNc9mDmg4BnIXjUT?=
 =?us-ascii?Q?v56sFY6ByjBmoTKJOsrHCxsTQkiF6cGwmG/7Chq83lb8Ur8dHzmUHNuOUU9p?=
 =?us-ascii?Q?c/4yaTBrdFCaIgECSsOejeICMnAjlnS/BPI75X+sgz6DiQphUUGFMaZ1ykR1?=
 =?us-ascii?Q?qARtH/j/YSLgkzQ7jJroNS5oRgsK7bbbRm374AxsGTxZjeDQul93COnd2XSF?=
 =?us-ascii?Q?rf4Ui9slO2KKzLJubmKeXnF5/n8UE4G9N/U9XMeNeuHAP3pM1z6ELuPesZqF?=
 =?us-ascii?Q?bJtr99tD6T6JBDl8TXif7tMrWro0wmBF09Tfdo+pHuXqAuZEg8HqQFWkEJBp?=
 =?us-ascii?Q?MKtig0rHXi7ee4P89pyKUKSF5LeweD409bgkHCN1VM9+0i6qK27zvKH0vHSh?=
 =?us-ascii?Q?zYq5vkP6+JptGCG2UlnGn44=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eab3f1-bd1d-4256-529d-08ddd2f5d0c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:36.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4j3GrYlmaYA8+aPiV2rg/xET4eHRlqYnI/HMyUU4khPg/pAuuucSHrxjlbMDCp9wSu5I7yt6CVPzLwtQE52JZG2Sf6slRCg+0JRoANDVcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613
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

From: Tingting Meng <tingting.meng@altera.com>

Update Kconfig for new platform Agilex7 M-series.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/Kconfig              |  2 +-
 arch/arm/mach-socfpga/Kconfig | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d7c9e18fa41..fb386549ae8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -33,7 +33,7 @@ config COUNTER_FREQUENCY
 			ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036
 	default 25000000 if ARCH_LX2160A || ARCH_LX2162A || ARCH_LS1088A
 	default 100000000 if ARCH_ZYNQMP
-	default 200000000 if ARCH_SOCFPGA && ARM64 && TARGET_SOCFPGA_AGILEX5
+	default 200000000 if TARGET_SOCFPGA_AGILEX5 || TARGET_SOCFPGA_AGILEX7M
 	default 0
 	help
 	  For platforms with ARMv8-A and ARMv7-A which features a system
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index a76a9fb2a39..d6905ad2444 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -60,6 +60,18 @@ config TARGET_SOCFPGA_AGILEX
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
+config TARGET_SOCFPGA_AGILEX7M
+	bool
+	select ARMV8_MULTIENTRY
+	select ARMV8_SET_SMPEN
+	select BINMAN if SPL_ATF
+	select CLK
+	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
+	select NCORE_CACHE
+	select SPL_CLK if SPL
+	select TARGET_SOCFPGA_SOC64
+
 config TARGET_SOCFPGA_AGILEX5
 	bool
 	select BINMAN if SPL_ATF
@@ -150,6 +162,10 @@ config TARGET_SOCFPGA_AGILEX_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex)"
 	select TARGET_SOCFPGA_AGILEX
 
+config TARGET_SOCFPGA_AGILEX7M_SOCDK
+	bool "Intel SOCFPGA SoCDK (Agilex7 M-series)"
+	select TARGET_SOCFPGA_AGILEX7M
+
 config TARGET_SOCFPGA_AGILEX5_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex5)"
 	select TARGET_SOCFPGA_AGILEX5
@@ -227,6 +243,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 endchoice
 
 config SYS_BOARD
+	default "agilex7m-socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -249,6 +266,7 @@ config SYS_BOARD
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config SYS_VENDOR
+	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
@@ -272,6 +290,7 @@ config SYS_SOC
 	default "socfpga"
 
 config SYS_CONFIG_NAME
+	default "socfpga_agilex7m_socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
-- 
2.35.3

