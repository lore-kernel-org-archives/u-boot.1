Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9756FCAC5A7
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 07:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6851083510;
	Wed, 24 Sep 2025 09:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OSdqKfoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0899A800D7; Wed, 24 Sep 2025 09:50:27 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6318344E
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/30Zg8H4/gDTzbXLT3rasPnxlucrHBo+v8nq+QNYsmFiV/YOP3EY2XqEd9Yba6zWDCeOD7qbE50fPEUZfTiCFKTlk4GYJbGBs7I4dLhfMAa5/XXp8jZl/b5DcQfkGodpl1ZWqS33ayk2F8xTNKLLOCTKf8/DMlpIkJ1Gp/tJ5zpZfl0ibBwuycJNQjCZZR6T8QZNoUrlhcwPXzesD3rP+WsWkEr0+qZYkYKOSLM8hwAHevPY7fe+3pGxMoPPy8HsnBTC1q0xyOQbCZwoQuMdqX2HvY6EGXGWINU8EvjsjYuxU7UkZTJhejOYx5sUWTPhWTlcqgbPO4m6+6QzlZtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7X1zgRh4HiODljESWnmJGeEFrt3go3MORVgvtEFn6c=;
 b=LubgVdkyNixR0xc3QGFk5ejDl68Cza4uNlXO3kV0aGUIeGtVnJG2IMet68yDIPgCf5jPH3GBCjdH9/8k9yDISqeeE20uvQH46cWRNXMlPJaZP0T3rSc+IjrV1fCyZ8LvtNQdvYBFXki2w9RmJhvEr5pA1YewfJteqYGDEMPr17pybhbCnhr/uTnzE8+ZthIwdKLoa8yb2KA+73J7hKEcimAXPDdR7GOsXq67rtnNaMsbgqGKy+sN3QlebyOocT/xvigmBixhyuVnrAjqVto2Q3gMHOG8fBCvXNX3V46uUEww3unv1PlXbyz9UWY1Buzdl2rxBKF42wHpmaOzXxCqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7X1zgRh4HiODljESWnmJGeEFrt3go3MORVgvtEFn6c=;
 b=OSdqKfoVp8jxrEka0qdiSLdHTiO1wmnFHP+V/pzHiIGI0FNHkmgYD6BEcnulYRAuqjpYHaWaiQ5BafCnvZwAmJSQNsvByctySUb7B7wTxUJCh9+AyHlVxZbs329RssNoJz/Tn4p/uYHsppnjzQY5Ff8rt/9D5ZqMmaFAhcqF3zNnWBB0ZM40Q7dHLbU4NCOutoofHKLcICXtzi0YOahrl7k0UXZOv21C3ZhSAe6uG3usIcGXUeDzMeaMerXyfVmZLZfKrT6S+Dz63xDaSzZnCgfHaV3OSq5X2uK1rQqF3PdyNKxAsbJ2k7krhlN3BarmzfNe7DaLmETW9WdIASidOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 07:50:10 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:50:09 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v4 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Date: Wed, 24 Sep 2025 00:49:11 -0700
Message-Id: <20250924074911.15538-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e98c56-a1bb-4d30-0575-08ddfb3efc46
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2vfbIdLv7CLzShdYxHUnkw+OUx9ZPioLRL7XrHsqDS64ttR3eCIh4X7HuIlS?=
 =?us-ascii?Q?DJF7oLDqzhBgDjXD7XcVWz82ZugsodTXq0u01ldWTaKvqaeRnXP9R0zmoapH?=
 =?us-ascii?Q?9eLZo8Aak2eAZoxuOhrcbze/clm647LAlTgpQBt9CG0NYeTbZeAqVN+wMlth?=
 =?us-ascii?Q?w6nX2OmUSU0kZ11cf6g6D6CJ3qyuEaxQpqgsQC5qxVOBk1qRl5VhSBe9SIf/?=
 =?us-ascii?Q?+U37J3IN3Qhg2cvt3AFFvJF1RwLH3GNM1rjyR6TGHDSFVlcBFMteWFeH5xPo?=
 =?us-ascii?Q?aWuKejviebhKPOMJRtz5Whcv9x9DV0/OcVJEh7mjyFjsNRG6ow9//lm756KH?=
 =?us-ascii?Q?3jf2txO4q/a4yati0sHBx1NUKx9ArPi+bxtGTpKqm6DvBmmTyWD+ZF3k8kG+?=
 =?us-ascii?Q?0H6oV52jvcys59v1kI1qIZn+Cp1XWkHuAZpm+B3d46vTTaWkEZucqpO5ELXo?=
 =?us-ascii?Q?xwZ5jPMUzTSsfQo+wN0f9TaxwxkAcUdhEjoc+81OpngujZDVbqXEF3z2Jqnw?=
 =?us-ascii?Q?qsunWBbeOMwR8bJZkL+1qVxq/feRgZwAUkUGAn0dGJdQqMZNfObfmh/EYsuX?=
 =?us-ascii?Q?Zxa0hLf20SlEvrQBX5Q27FEhW1rDljTzs296BnGVz4vY6bwtoCIAu2NF97iA?=
 =?us-ascii?Q?knaoYgHdlFlCBXdFfHNj/9YWmMvhELzbGF5Qi/j34+O9U2ojC19PgdFSiE/k?=
 =?us-ascii?Q?sTyhWxIcsLIA9jvSzjON467hU+z+qFSC5eQWQFOqNGQ3dPJEBFvaC0Qr+pbm?=
 =?us-ascii?Q?t+bNR31CANAUKzt2etwrwPG/rWHyuNTmXc5roP3xQAblOrmX26Yo+q5J3OBG?=
 =?us-ascii?Q?KLrCNwbRxSq002ejWeiu6o5Eig2O+JlfjmcQZ3Y9GxL7rpqSxDVeSm3mm3Pd?=
 =?us-ascii?Q?B1RC+fCwrXidWIfanFY1qTZma3/B84wMV4MYNYmvMW2Jcv0FAz5wnhx41L5G?=
 =?us-ascii?Q?b9Ng2xAFMT/8PvqRuHm1xxrSIQcvoTahCgRM40Z3ndbjpH4iTKk6e0XW8Ks+?=
 =?us-ascii?Q?9nT1CYA5wWw3xeOk+SknbUuOdWPuZPEhhRhQRyULp2tNWVtxOnNzlM8x2bK3?=
 =?us-ascii?Q?kPqtyGebNkNsUggQT603nUZqipqZSZDCleIxj/+s+GY3chSGmmmZ8fELj5sx?=
 =?us-ascii?Q?G3I4putkVpaZbm36ltJfrir18rMObVp7z8jI4ig7iFNu5qjGrpjiiEPUhbwg?=
 =?us-ascii?Q?Fa6eSOZQnadxcFwfNbPB+/PicZSY/eGkk0JRGs7wA+wZ/gFbXzQXLkdKdiOv?=
 =?us-ascii?Q?CTmkTIVeBC43WEQDpQxBmWXEDb9jALZZlWZuS1/gbG2L72N2qWm8liTbDyJu?=
 =?us-ascii?Q?zqjM0dl1cnA86uPYGcTB/nTgfD0bwUWB/J8Qzi8Wdf3h8WZYYbRh7Z5wdGZs?=
 =?us-ascii?Q?G2IC+EE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODRiFd9WRtxnD/10+H7L+qM0e12NhfhxQqBDzJLa5KN/MXKH3j5a0bKaCYIM?=
 =?us-ascii?Q?IpiD8OXkJLJbcmkr2hNMlC+b4mRB0SwHPzmO+weMMz8TBiQ16Xnv1jHGYTo1?=
 =?us-ascii?Q?4iX7cahz8ts+0oYwtql9hQ3uGV0TjbTUM6np5NeBwkwM5i2zgEET1jyTyMU6?=
 =?us-ascii?Q?cugpNVJZ6EUv8dQRTJdoc6/xeNRERn73ZFdXUiVs3+RrkU2r4MXCCwMXhzJM?=
 =?us-ascii?Q?62dbra7BoYUdZkf3IdO2Q1mtZ45Um2A91tJhxuLjo09QAaewRpF/NVsh9uT0?=
 =?us-ascii?Q?wv4dtyJc+ycWOxkvqa795WljgT6Swvp7rF29skSmsOPxrhUKlx1nRWCW+cln?=
 =?us-ascii?Q?vJi09Ozxe1VxVQCKrDGeEA8ZIe9ZPZxqigyuAVitP4+yififqkBFN6CrV3Ya?=
 =?us-ascii?Q?wPEjMT5pPvAlPPUzA3MjVLO4NHoMRKOZznkXww5ZZFXBnKbqOLe/UcsJiHCF?=
 =?us-ascii?Q?TSefVCW4MUEkxd57ktbYXR83tVy8ROwayyPATma12sN++FWDKlRMzSGZw3Pn?=
 =?us-ascii?Q?n9HJBuV0Z+JXp/1Vzj7TVa8VwaRZ/9A+ZDkbIEtjBoGSgIyeH92m3SYfKv/b?=
 =?us-ascii?Q?P1i5+BCxfypYc661Nj7AnYI5w6CHSYjENJsUmiPB1beJaET7nw+qLsC9JfEv?=
 =?us-ascii?Q?eoJhxxqIDxD0N28knDVD13YopIHIa+7l9oL5CtTXGngw9KTtnV+v2zrm9DlF?=
 =?us-ascii?Q?ai+jLSWaRxZTf+bMANkr2L7SzZVkN0/j3jQdTTietpFFHcrI52LAH4A23lK1?=
 =?us-ascii?Q?fUqKdGbeexeAytczFBDRSF8AyMkLDiscdiYOz+3kZYjpKhty/GjqGkZ5rtpL?=
 =?us-ascii?Q?PRonuw7yO72PJw3R9qfyElR7e7Pbu0a8v6ltg13fXOebWKmmRfPlTa1HJbVY?=
 =?us-ascii?Q?jebCoj8gwb2f81BHzUCZNPgHarL0y0xSRUGp6DY1ttdU1Pk/06mnnNG/lTuf?=
 =?us-ascii?Q?4Y3DL7+s5C96gIRbpwU44Vt01/GnJHN++fiyON2DosiG+NQJICfbJv3RCRe2?=
 =?us-ascii?Q?SJWiXHmV5WYZv3SCoUDszp47xTfbLc9fTSHQUeFRUdjRTtimL0gfQqlNS80d?=
 =?us-ascii?Q?ND/1rMUSam8+aj7zXma7im8Z2fPZiHpwElppJYGyIHc4uTOXf/j0aassUMw0?=
 =?us-ascii?Q?0dez4LmrCOz9p4bWmupHZpt0SEO+G4r3uZvYTh+ZzoX9ZW+lYntxJk/+X3JG?=
 =?us-ascii?Q?uWbZo0Ua3J5FF9wXJtT+FoMpBc6cltNM0DPrrK3lndpr4bdpYXJVwFRfzGJh?=
 =?us-ascii?Q?1wr+FcDS1kS/nYJdDRM6rfjNyQb1DfaTf4Bx4g0snvpy9gVLZsNevtdQwq4K?=
 =?us-ascii?Q?OgR6U4lnTFVVAzqHkc7vgbmrhqj1sEh6oG7GQYSWvW1rjZfv9WUTtI7MDikp?=
 =?us-ascii?Q?wFGdCK5cK5eQkU4WIchtAqRP3Wl+Cn6Xin9MzsEi2/CfR1O8o2KvlPtdBuE9?=
 =?us-ascii?Q?LROP0UCvi24kZnvuLR6bqAbWd3zwd4TojXElj7reEF0JOlJFFI6ZdPhs7OXK?=
 =?us-ascii?Q?Fv4YXz8TFn4wRpGGBBrDektNw0V/l/rCGlNY/nzBQaUCywKnZG4RtFhu24yN?=
 =?us-ascii?Q?8JREckVNcaE0tWXifentkSwpyD4GZpnLgpkAbzqKuY9qYKlRR17vcbCPXsVj?=
 =?us-ascii?Q?KjLQ102ZcDXiti5ZfyREmos=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e98c56-a1bb-4d30-0575-08ddfb3efc46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:50:09.6767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X3wP3Y2h8VsGbfdUup3raWETpdP9/q0CT3vDeSb1vIrk/XDLCXqBEOBiX/v1AZF/3dCzIH+ttEwIBQTVmEbwwLFDXpP+fVsIGGJwyTC++CZEBv9wC7ktN6B1KgfSd7N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
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

For successful reset staggering pulse operation, reset pulse
override bit is set. Port overcurrent bit 1, which in reality
reflects PIPE power present signal is set to avoid giving
false information of Vbus status to HPS controller.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 054a28d845d..f768a3a55cb 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -33,6 +33,7 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
 #define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
 #define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0	0x1F0
 #define SYSMGR_SOC64_MPFE_CONFIG		0x228
 #define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
 #define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
@@ -47,6 +48,17 @@ void populate_sysmgr_pinmux(void);
 #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK	BIT(0)
 #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_MASK	BIT(0)
 #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
+
+/*
+ * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
+ * Bits[14:13] Port Overcurrent
+ * Bit[12] Reset Pulse Override
+ */
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR	GENMASK(14, 13)
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR	BIT(12)
+#define SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR	1
+/* BIT 1 actually reflects PIPE power present signal */
+#define SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1	2
 #else
 #define SYSMGR_SOC64_NAND_AXUSER		0x5c
 #define SYSMGR_SOC64_DMA_L3MASTER		0x74
diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c b/arch/arm/mach-socfpga/system_manager_soc64.c
index 4b42158be9d..88d538cdcda 100644
--- a/arch/arm/mach-socfpga/system_manager_soc64.c
+++ b/arch/arm/mach-socfpga/system_manager_soc64.c
@@ -1,16 +1,36 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+/*
+ * Setting RESET_PULSE_OVERRIDE bit for successful reset staggering pulse
+ * generation and setting PORT_OVERCURRENT bit so that until we turn on the
+ * Vbus, it doesn't give false information about Vbus to the HPS controller.
+ */
+static void sysmgr_config_usb3(void)
+{
+	u32 reg_val = 0;
+
+	reg_val = readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
+	reg_val |= FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR,
+				SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR);
+	reg_val |= FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR,
+				SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1);
+	writel(reg_val, socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
+}
+#endif
+
 /*
  * Configure all the pin muxes
  */
@@ -18,6 +38,10 @@ void sysmgr_pinmux_init(void)
 {
 	populate_sysmgr_pinmux();
 	populate_sysmgr_fpgaintf_module();
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	sysmgr_config_usb3();
+#endif
 }
 
 /*
-- 
2.35.3

