Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64327FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05E484329;
	Tue, 28 Apr 2026 05:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RxOczy6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D291C8421D; Tue, 28 Apr 2026 05:48:50 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F75B8437C
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPqO3DTkuIJuRbLwInyNB9WzYBwpAJVexgmDLyiyif1LD3RMnpzB+POAzGEOj6t73JbCgbzn329IEp6f+MlkkueopihZjkuPFqKnKuAzqLRpDWrmwGp0Ww/Z86KpwPzIQ/7lrfyVgyCdu9cEIsQSjJO+M7FzXwRpxOF2+M60XGHFkImv55oIMcCStBdvu8z/PlQMdHLmTAuHAYuY86ImNyyX7ylucQ+8RkYdPn/u3Tg6uEbIS86Btr0iWza56b3nNWhup7Wnz4EKTpfVeyVBn1JXp3iDpHBCk02ERsTo/BH/QXP0PKwqbfmZrRDQy7S43JrFawVdJXRMIP5lS2vkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A+VAj3wHtbpBngvCgBxvSsXHKv4J6nwZ2o88Rs1SaQ=;
 b=tGrDRt44n6JO7sfrOWYXVSe4mH2YBhKZADzjTpE0twDdWrVmCakmYKrw/+r40nIXPiELmE+qjy6en7nb1KtDk8+mz8xVb91XNilhuVwUbEt79bPCClx2WbmR+pXOuUbmNMDAvk2bGLBd4L1/IIo/+y4bLdAmf9CB0aKtHGFYhtlKupxd3Rc0bxjnKXPxR9zm4s5y5Vd4sSV9HmEdZmM7bb+GwZqyvMUopI78AN2qY4STuju7Snfz+sWbaD81bNysZ1z7vWIk1NqnxI3adNeS5qWGZdpOVubeD+o5t+9SReMPqmN1KSltg2X83FsmQk3vO1nAcTIjdXDR+jAEDuLWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A+VAj3wHtbpBngvCgBxvSsXHKv4J6nwZ2o88Rs1SaQ=;
 b=RxOczy6Ep+QS9swvW0CMVBnWWFcWKZr1+7TfYisghNtOz8P2zbZYtbYdYWowLgXhjsQvmMljBNA0GwchTlwbpBPeDiHCYamy75Ti127K1CmONq1zS0+EJNL6lGBXIsZWY5a1dfBCGPpcV/orbCQUkSHXprrxpyd9601RFEK6YsOsRB0FkpiGPHC7JHfb2j6/Kop1CDiMmSiPmTQ3wYVw8gjEfodrlYCMfcc6uEx0ZJmOXm0kSaniRLYbDVwzQ18xJzrlK9/PkztObA0BoGjDrguEXg0Db51DtK9u2qUhAMv3FyjjRXP7CXkE9ozhWCKiWr12xwrUjqGzAenecdHfdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:40 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:40 +0000
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
Subject: [PATCH v2 9/9] spl: s10: Enhance watchdog support in SPL for Stratix
 10
Date: Mon, 27 Apr 2026 20:48:22 -0700
Message-ID: <20260428034822.23756-10-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9eef7533-f29d-425e-5563-08dea4d908d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: AcyMRw31N9PLBGrNRM+Mm/bHaAvgjhITtZGGCFKuQytr177YjmT3HywSRpc6VqzITlMu/fQWIcFH8UgcjB/+KzbHvnfKeiEdwhkHVtRFjXz74V6noUwUbexmeTKjbHbnQEhXEuHVcvjTErjb2OAA5HCXjHF86daxDWBPLJ0ZGtp45ECgsR/eVSImHcRedWIgx7wUVKKBVzKPwugiLBBjo+DpwGon/ADwjTFsJrzvsjn2+oYRMbtuTcbel1GAq3WApeqNJIRtdI2DL78ZqXCQK82PE6gUP6cHJ96/VnMVNg28v069bn0VTyB107y5i6BhpPcx656uFnsnHqliIJX9G82N3ZRdNmni3E3cLQl+rE0Owr7m7HsTyJdEyTdkteo//jUcnHfmIg9/rFjC80J1YKangLASbbYHoUZGSDugil7BHD0xM2gFAlHWs3cFM1qVTOuQrS9dWu0/H/Q6JPAXiZGxU2npYn4GSN7AzUW6GboOlyYlRMhSQL2UCMty8NGkKEOBYC8X3oqwmbdy1kONMevDch5bQj+pJaeLFITEnGOkk6QVEgo5WybPuNr8QyPjG85SrPvYJtBPOHNRMIrYsBmkQPbUoARw4nsnGzPschOAYXClQygbE6O3KYXVWPSf53IgDlFFA0xmky4BnElF7iGmXOuc43u/qOEZrD+MTAUGqBvba5ftuK8BJ7HLWU3FJMYt5mHI72DoIPiJ282xR3w9/c7WlFikivuAxBd/23Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fw72GvuK7lwMwMIjlCRKGM7Co6yfh59HeCbkDyavTDlkPB+EmiAAU8WU82Cq?=
 =?us-ascii?Q?Ofm1tdd3iZrlRs/8avxKHKVCLVdWyJc502E9DmIilgw+y5b31fC7xGDRgOdy?=
 =?us-ascii?Q?VUitEqkzeJrsgjLwukBKpfp6ODZyb1kn8DTTeTypyXgcMNEdJZN2pAB5ZmvW?=
 =?us-ascii?Q?6peZ1IqJ0KCrKDovrWhv2svjxOV+bBrnxbAIl0vusKpPRtUcODH0iMaYrxHf?=
 =?us-ascii?Q?cwrWQ2CvlWU/UX6rHMH9UDyZ0aBGwqScNxGuDw9s41bE1KMl1Oy8tAExeiYg?=
 =?us-ascii?Q?76RZNVc9R5dDXmctBX1szDVxgqHBd1d5Pxwxqh4MS79GbtyEgS0dSQt9TPo7?=
 =?us-ascii?Q?1PSlHVLVXm/vGZrMVRRNpxmWjk0rEWR/OkU7Wa9gXoObhC1onvQmelWzj00O?=
 =?us-ascii?Q?oHDU/VQUFiFZr25SgvK0e+h6bQV8e88sy8JfheC7Z1r1aVdDnchE28dV6C0g?=
 =?us-ascii?Q?/BitTkh6dxYgC+f1lOORvQ/qOO3FlvVTYHs+oRTLe/ywR8djfnIMlL7i47eS?=
 =?us-ascii?Q?VCPRIaFADAINk30evJf1jyQm+oxJ/wWktK8nlkf+k2Pqco1juLzKJa9SN4RG?=
 =?us-ascii?Q?m4Qt1qXN1neQAWsIOouacz1C/R8FNZ9jz3TXG80HQjBzr6HCXdYr18O7/NkS?=
 =?us-ascii?Q?FEuSpCTL6mb6C1/yhdX9NoriT0bdCVlJUu0jWXqMUIWoreYCfkZpsRCUPrma?=
 =?us-ascii?Q?L6Eq+Np73JC0CF8PTtXS21V0BkIX7PaG7xn2j48bxyV4gsnf5Wf8ihG1GobM?=
 =?us-ascii?Q?5Gz34N4ZOaUC3Wg1w5JTH5uGfAhRrY85yhYoo5w3w2j7IdKOyOFwrBiqNjGJ?=
 =?us-ascii?Q?6YKYjqMkSACmt+v+sDbbgCaOF3hPiIXoweDuUXKaPuT14jpAt18QFF6qcpgO?=
 =?us-ascii?Q?CLOfUONyK2Dmuc0bs1BWOdQXrgoO1oeogFI7XWn/CptU872djDwv3RWGU2ws?=
 =?us-ascii?Q?nFgbhhEwH0jcGsYlMeWPw0wvVxHWebFexTPY12FX2Or5wSLPBuPCo9s/BD3o?=
 =?us-ascii?Q?Xc90dm/DWzbBamZZdm851lBOGGhd9mRSAXHdU/alFR2/dS7JREuR7fvTtIrH?=
 =?us-ascii?Q?J1glfqQW1ab8ipaJg2XmxynZQx+r02WTMW1AJGAqS5/pkQ0syYXP+ZVpZjMK?=
 =?us-ascii?Q?gtZDZyW8+Dk4lQvwGJzaitpHT8vbls9iJr9HLUkbSNKlIs2HT110nWvG1lDy?=
 =?us-ascii?Q?lAxY2J+7s/ToAW9UYYLhcur2shioZ2sQi4XNz0NG4IYXEKd2qP9NcIx3evbW?=
 =?us-ascii?Q?dOX2Zdly6g9r97kMh5T22+M+fnY60Uma5MVrg9FqkLfFlwhJRhSgXD3JyjEl?=
 =?us-ascii?Q?nCCxlw3lhTXcbrcHZi/uqcBu0T4H1p+BLTpmwU0dWhVCRgMwm1nYV2HwxwJW?=
 =?us-ascii?Q?CUZsdTsMYrAg14zRwXUy0WXgjbomQFAJkQWniIh/3IhP4pC5SwiTH7oeYkFj?=
 =?us-ascii?Q?L8PTAvyUDGvxvYoHpMnr31QkPjFdMrmXXmYbmbhV3aH8qmR+ENNPhIw+gyvH?=
 =?us-ascii?Q?Zn++3eRbfQKbEEE6Q6nFAHGU8+TWKSPMgY3/FLWO71fJgqBe2SRewVpd6SRc?=
 =?us-ascii?Q?73l+1/avh4N9mKtTbsPgzjI1xqfahBoGodZmKbogj3q+rPKwLKT1r+E1zyzX?=
 =?us-ascii?Q?r1j2t+sPpFLRAzG+TUc0dAqxWmVRTa2oSXZ2Z8LC9KXu82NLtr8ou9bmU9Fq?=
 =?us-ascii?Q?3driq5ka/KXVus0l6vZ4yNkspmJCFnRM5ugHJGxHizUZz9scUbymLFVM+Ebz?=
 =?us-ascii?Q?iu+q+nyvLVJQIFlXU2a+Llc4o3S/cLd2+EdePTWuq+mMVeMNegFX?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef7533-f29d-425e-5563-08dea4d908d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:39.9453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW4Dy73CahtnsrWCJ8nImzPSJVt1AZ1NAN0vx7xiYqRVbasOaauBUFU4fLDcxiIpPhPUtC2VVDN1ikCOO68BD5Isq/cbwcNe0KIlf5+Hd4U=
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

Watchdog should be primed before longer, failure-prone steps such as
firewall, SDRAM or QSPI initialization so that if a hang occurs in one of
those steps, it is able to trigger a reset.

Switch from the legacy hw_watchdog_init() path to the driver-model WDT
(initr_watchdog()). This requires clocks and reset to be valid for
the L4 watchdog block, and so it must run after the clock manager
(uclass_get_device(UCLASS_CLK)) succeeds.

Enabling watchdog immediately after clock init keeps watchdog coverage as
early as possible.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index ace029557f3..588dca4fcd3 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -18,7 +18,7 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <watchdog.h>
+#include <wdt.h>
 #include <dm/uclass.h>
 
 u32 reset_flag(void)
@@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
 	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
 	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* Enable watchdog before initializing the HW */
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
-	hw_watchdog_init();
-#endif
-
 	/* ensure all processors are not released prior Linux boot */
 	writeq(0, CPU_RELEASE_ADDR);
 
@@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 #ifdef CONFIG_DEBUG_UART
 	socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
 	debug_uart_init();
-- 
2.43.7

