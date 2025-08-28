Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BB3CA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E2283290;
	Thu, 28 Aug 2025 08:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oJ/VtCIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6717183253; Thu, 28 Aug 2025 08:24:34 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52DB83106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TG4AJwr5Ujt14FRt5HuwxjrEIieESPelDt0vYAGYZT1699HJZu2EPf+G5jpz60Op2RgVscGuPdHJ3kzfp8xYzYjk5HJWu1JqqqXPVuUMfUo/cnoJjgzgvxLETxa1kXaGZlr9/W043l3mPOe8o5NeeCguUdlExClFHbvoFYR6lRmRe4pr4C2q0ewQFPIXRCTvXGW+g4lDiP2E9FWXfqx81lK8tQsRwcPwrr0pxHelGjTvcnyt8NoXdppCMC7IDvk/PJJus2jBy+gmGDrzd+EBICHq8XAE2IqmfaLrQkO/xBfUeOyY84mAsGtlUthuDQ3uz+tjM8moFCYpsaJL8gfN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Sv5eAil0lhFdysLzWRCcM6x2t5NSDzdApwNlFPHAgY=;
 b=YPWGElJzUguckXom4fZ0nNZVcdP5AGhcx+E3sWyH6U78xCTo8m0GnPtsJAZdsuFb6M4zssb0/U4+toadbwow87piXPw3Z3LqhTij7ecDdznb7V+vaNT0WFeswENYtoTKmfNG8UH2fTx74Lgxlm/S4pJKgLbsgfI3HXPYQoi5wjFwv7bxdhirDuLi3saTEp5A95uwprJEy1Po1LblRBfHJZF9lXLiSs67z00ZaTAoUaLuWeYX79nX568OhV0G8hD6OBXZSZyeGg+chg5b7nKbNN0BevI1UQiB+hSqA7BAv8vj7tJrNAPZFzyhvUa5cnbcd/m4aZwEVGCRNiiDbIv07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Sv5eAil0lhFdysLzWRCcM6x2t5NSDzdApwNlFPHAgY=;
 b=oJ/VtCINDGJ4lC4GPxZdh/Ks0HUOewK1cqWmVWVBsVI1FcUv2NCYwc1vmy0gem7sEQbY1k2BiWMHGdRZjRS8c/uTDanQCx5FNAO7R0rWLBH5HcoX9kIu1chVta02S7QGRRNIZFBT1E+U5t+iCWjk60wIPBkFIDmFna+Hezmi+RddMzJy58ETc6iReywJrIWHO0FBrrDGQ9h9GPwakwJzAKVCGAfQj+Wz6Vo9VXH7pb0yhr52DqSF+Ey0qP+smxv1YtLivuhJQD73iu2H15BzSn3eJhMV63V5a1dxn+acweA4q0h7bIaPrYPHj5T0xvw21tHHjY5Z1k+IlcFTplwFnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5676.namprd03.prod.outlook.com (2603:10b6:806:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Thu, 28 Aug
 2025 06:24:29 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 06:24:28 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Date: Wed, 27 Aug 2025 23:24:18 -0700
Message-Id: <20250828062418.17945-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6130aa-7d0f-4c09-8c2e-08dde5fb8add
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jme6KSwlCM1tWhzcKbjDEzFFHz4GC/hYg4RktNUcj2ltkgMYLtELza2elUpr?=
 =?us-ascii?Q?PwB/+iMGPAIVpIhnFBuxp03VG6x6mINnRErLZB8Yem1/Xo2050fFf8eBLE3S?=
 =?us-ascii?Q?yo+V5NikSJ3QA5BcFHpW/lvj0vTlfx0NxRc2B/6yJ48esGiQA90gYdGu1cyN?=
 =?us-ascii?Q?DpQsIHCtEk6PE6QRxOiZplNwns8oSczBtjB+v/fcUjLLfgXcShz0YPhVQirS?=
 =?us-ascii?Q?zOVzmU0/Nw0qZzrnkYKwTLEAEpZ3cHhfBKDcLsTbgGkYn+z4KN+agf80N1i+?=
 =?us-ascii?Q?bXDbd3GDdt7VR6k0cVpIkCLCGAuV04DLfyrMeBG7u17314uCgydXCLujz8iB?=
 =?us-ascii?Q?JTbt8FGG+NyzXGz7eXLcyPXMSBX24db1HXyughDWRiRirTVhg1ft9SoC9CHs?=
 =?us-ascii?Q?xeDJLZIJkwyZi0RT2C8+5zhr0cBi2jK8lNezSI/KizaqhNdI3A5XXImdw/9G?=
 =?us-ascii?Q?p8v6TV6tqRIWQPkg3CI/+bt9gjqT68i9xWR7DfSn7n3xOe+soFSALiqEqCWh?=
 =?us-ascii?Q?ALM02YQ5VJWNPhKjHuF+5egg9oBk2AA9orOOWTuDYNXV7oUoEf01H8eqNoHz?=
 =?us-ascii?Q?blBdQ25gxkGSW+XVlj/LM/IlmqkpgSS8vwMD7qTNKGqXwnK4ztPNKP/hfGu4?=
 =?us-ascii?Q?bFv5KiDVJHN28mN28tAASu9SFHj1hwJh/EhRE/gj3BOMXF+/69pfcRgNiEiJ?=
 =?us-ascii?Q?9NyvEu5oGM0JKvjIKiAmWZ8e9RPnN6UDa6yVvSHclx2hCxR90XDqJuG13Yjr?=
 =?us-ascii?Q?KuIuYidZ3ToXdEXQfvFf98tdQR9sMt6vA2K02auRgmB+mzL+7kkwiXMwYNln?=
 =?us-ascii?Q?ZFE1o+w0kQ3F0X41PuJ2tE/XSccdLWE6QH+qh37brYCc1C4okNrqWalquWD/?=
 =?us-ascii?Q?oBj7xy0SS3KBgedqixtwwFQ/icTgX/81CCWuJn6RBsbBPEB4wtlGER6DsBbl?=
 =?us-ascii?Q?uiYJfJw3CWjgxA8e5ga2JasmIYtECbcZ/+dF3vVI1iTIn0cUO+lORBHs7GI1?=
 =?us-ascii?Q?7miFXTDlzW/xA1pZMny+wmi8XYv1jpMm5ogM0EUqavyF8oAIgHifLXk8a9p2?=
 =?us-ascii?Q?HkYzs9stkWpJu+7u2tJmLVUY+1O9owav9jXWz7RY6QRrYG2+HJgJ3u9JVnTG?=
 =?us-ascii?Q?rNYOpEVvhJ6Tfcn5TtgwPmdLM3ojJSse22yroTv9NGVeiAWOytWAQ8KuQLUg?=
 =?us-ascii?Q?h4ZGymQ8cSLJGFQTVX7ABwPz5/jycT3zRh9ZpyPi5Y9+uG1CmZM3TMcTP3G0?=
 =?us-ascii?Q?4PQxiNLcnAdoph5BfRQZpqQuQfEi4vn4aPHju6VFszQV5gr+H7CvlyMs/+/a?=
 =?us-ascii?Q?QmJ/u86Mg69EJIRb9E1EaAK6QKU0IGDEqYTwZUUHMWZ4TLq0lQnQAviWKvF8?=
 =?us-ascii?Q?pg35Zv4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXWP3z1lpjEEpVwZDJwLJewvJOPdQoa/RApHe+AyQqaJDs2eknV7Tr4407VO?=
 =?us-ascii?Q?lt1ycSkhNb9UPLoxOPaDHfQwHwx2xgqzQ8BXy5LbEYI74ItKxpwRYPsNhMwe?=
 =?us-ascii?Q?4lOWSr7/8LlQ3toLboC3E6LFflJfHbK6t+zzGYSEEihp4rFBQxdlShAsxmoz?=
 =?us-ascii?Q?C09R/tjIUtx6Ea0GpHPtjwWLx5P+iOf6hAzKuNqxqGWwIVDCOOtVENVCzJLi?=
 =?us-ascii?Q?ueFna1J/qxd206P91/jG1esDj2I4jEc3lEtUt7p/3KNdq/NRUY60+QE8IiKT?=
 =?us-ascii?Q?OWMnm/24prsOjpQmZjB1N8dY1HGCNjnbNcajWzeFGVHg5KhwGAE1wn9dr7Tk?=
 =?us-ascii?Q?lPcPk+Bxm8kFsL7jJyq0wChww15DkvXHFBGPpLGt2RLQAwdXiZy3XlfNRuRv?=
 =?us-ascii?Q?PAjj0zHgcqdG94Ql2zZVexQEXl6YlihRavyinzas6dKKfCo8BVswollGvUU/?=
 =?us-ascii?Q?Y9FrkDNUjbBXKxa/x+HbbYrdEiYUM3se5+qvi17qXqH5LroszAhtlzbkh+AD?=
 =?us-ascii?Q?gqpiYBMYSXuSvFHvIGrWkztotdAKT2hXs0+m5qiz0D0QcBdyQfohGNicz1Es?=
 =?us-ascii?Q?cHQ2vM6At36pJeOoX4mET+vDSRu4bfLii+2L4ckQ6ItwTuq2fFf46mk6gVy0?=
 =?us-ascii?Q?0Luj8G7I7Pu2Ka/D46CphuQ2HHEOYtYUqkUXP4afN+SQ1tyJDFap9BuiTzpH?=
 =?us-ascii?Q?TqFe2shJnWY8zIlefQd+DcMNn6QVP4Eh/Lxz49WUXohy7/Obwt9F0DCO1Uaw?=
 =?us-ascii?Q?+3aPirxKkYea02dvZuT5b0l4bVSwSIEw+rBUpXFC89CDhEGKB0SmcnJqe4Az?=
 =?us-ascii?Q?BSh1ecFSePrs60vStix/zNBdaQkwcsoHXsYHY4BS+RdR99ZBwblpEPQZXuPB?=
 =?us-ascii?Q?sx3FnFdA8MniphHAdxmnVdOkqU0tN1B5BWzo02pGIBOuDWeDLxAgVfBBuApI?=
 =?us-ascii?Q?TMc2bAMJrRSyc+kySWwFUs5iFKmh2KkP2hsxEIbimXospbA1CJ3Q8iAFfmjj?=
 =?us-ascii?Q?2L0AOwrICqIJXuHMM2VuLnge9jQlX1LnmDOZ37vmugaPNuBYI+clzvadunaa?=
 =?us-ascii?Q?YelE9RX2IX+cio7/KIrwdsRbYY1rApxjlXhpDUloELspkq8n07iOItG9GE5l?=
 =?us-ascii?Q?tXZT095IviQtEc5TlUk9ofHE/WgMWgfpJn+gv7cghmzb2iBa3ZPUnSNdmsH1?=
 =?us-ascii?Q?rCiZYd+hIuf0xFC6R7QXWmVeMCJjbFeFKj9sMuI7RjD6j73ix0m4XFvOe0AB?=
 =?us-ascii?Q?Yi+oBvlXwhXvuqYrx2uWWpQDyn8PMm4vD1PVsN3Z+ldDbxENEr5bTavczs1j?=
 =?us-ascii?Q?dd2lmMijHyBU7eg8osg0gbrs4LczCAxI40IkYOrtlgus2lmbrn5pAYZ8toW2?=
 =?us-ascii?Q?8xu1qk2brVKtJ5NX9QaJIOCiPKTSh5r8rMjrgV7nbKpzqqdxXfxxJ2mCn+Oy?=
 =?us-ascii?Q?cfL6dC48KBVIAyXtx9YovDqLNechU3Q6XU0vEN2LrUab5uTJxaPUAGOpP4kb?=
 =?us-ascii?Q?3RYRv5LnOz4lWPI8PPLlKx1ndAOC8ZKeBmSrFu73e6bSV9fAVzBg3kEIscXW?=
 =?us-ascii?Q?tE31zHSWcrYXCl6+MRAeOLYGg7fokYuGF5F3FdjgVDB0xws97EWfgjTfitke?=
 =?us-ascii?Q?3NvSZGXyi3B3FdB8GrEAFps=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6130aa-7d0f-4c09-8c2e-08dde5fb8add
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:24:28.6826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/uA5zWZAL5e4DyieqSm9B1h+uwyUpMyo/oCLJS2DYOqwphrCVRtUeVDkOWFBdAxd/U8pyHoFxaiMNOTCuNlHkrZgFdVrnrdMx7iKT51NlGjcOMO6cY9Fc+33HYkGm49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5676
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
index c2ca0a50e35..c0392d99863 100644
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

