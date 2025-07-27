Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E9AC87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 05:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3F182F00;
	Sun, 27 Jul 2025 07:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="RzsOPx42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03AD82F33; Sun, 27 Jul 2025 07:55:51 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D62381FEE
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 07:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTqAS+FNdhojPH8iTVloYDNaHWyNs9QQMGW9ZhtpJNhGPqXaWZWz8cS9NW8GKyy5sKQoSbLHDJCxbgNLDvs9vFfISFf6jEQ4CjINCbpED7yCLdBb/CVOtLkjW55RaxS0dRTh8XWgZXQlLzDSUdcJvSUh8n9So+yNl2PtvdNFpiTs1Wuhs5gWjTjoHYM31Z9Uh5o2ZbuDU/f2Jd00tVS/I0w5rt/gIYe3NWFwegIEQACq0wyW76D4jT/5BuSPAE74rReiIycV+0W3PB+QPUEJ5125JVi3//ga208kTBpOSRRzFqE/dfvwJ2yRgvCoYPs4Aol+V1HA9pguuXX+eRoFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTERgMx0xNcslND/5r4T/1YxutkQjeqXJQPdRTM4zmw=;
 b=tvHLimMKEK91Qaj7Ceu7GsL4D8YUbJHijjalI6Mhvhm8H7AV2x3zlUInmHAaJ0ML2vTUW2HQQ3sGRQNe7TnU+zHENAMx6TZzUQJWmrkh8vyeFGjpXLoSxc9yHDb04h57H+9Z7yEsyaaMr1oAZ25nZVQofq4uHTp86SqZRtseD/+amAc7Wlq9ULUxeX/BxQ1fdQ4cpw2b51niChwOzEXRL763+7w/qiH7t5ARx6YjvdUAObYRAl4uD1/u4lR7LRH6H8n68l6jHvu8GmiNXfIGTqDy13/4q497YOWXFFoh9sq8ivy6SBDk5cUcVZqAkzvHncNlVNAuuo37ETpaWcp8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTERgMx0xNcslND/5r4T/1YxutkQjeqXJQPdRTM4zmw=;
 b=RzsOPx427MTHTUdMqKjYXO+XkzXrwDmgY+WAwLhSlg0WPBNUOvkhJGXX5qbeWNhZVx80JqwMyuNxbgQoP12SUZ2CNk4orJcPEaTVNIrjV/opFoU0wHwTgD7YJnwPAAGQXnXguaqXOcrrAxjgCGnKyCW9tvSZVKcU3BUzt6fQlkXxWq/ZYGor/bc9P1DDKqdZ5avEFLPJMb3QqEUbjQFeuP2K1aL9+0a064vfW7TeXQjHzSlSr3YIEHKObSmqmdv+Cobt/yQhjTjdy4NIpeb6IBFuMj3LR9Sr/hZNT817wNjDWmJ270nbtwPLNFwkg0iMeOnXTYMpwWr7u5qu5ALNFQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYCPR01MB6333.jpnprd01.prod.outlook.com (2603:1096:400:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 05:55:45 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 05:55:45 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mips: mtmips: add CPU reset support for MT7628
Date: Sun, 27 Jul 2025 13:55:20 +0800
Message-ID: <OSBPR01MB1670973BD7364B102A973F79BC5BA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250727055520.24051-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYCPR01MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: fc70d5e3-09c2-47f3-a27b-08ddccd239c9
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|15080799012|19110799012|461199028|5072599009|21061999006|5062599005|41001999006|440099028|3412199025|51005399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dVVhI1AAm214pRFtuTwPNAODHLqOd6FxK+JUHWvdiGIiXBL9KQ6jNdoKXVYT?=
 =?us-ascii?Q?dLCAjOXNsWIWQ+68QRo7GfMJS/X+fa8LeqODyDcDRmKme52QTU2YbqCBsYxs?=
 =?us-ascii?Q?gJl8lvb73vfS5BR7K3IPLzAtyTjzTcNQoHqr939L8rOa8lJxrMM23o90UB+G?=
 =?us-ascii?Q?LZKopGm4w2vb8QSaLp//u6TAcQmFSUCaVMqF1i8KJ3a7CoNJPqyXIU9plYMn?=
 =?us-ascii?Q?5hV0QrYrdWFqSfdXm51g/kdAvPyt6BcX7iteFqh3Ob7HbBOKGCuWrMYx0TMz?=
 =?us-ascii?Q?KvOgRvy2jaSsfez9smzirpqePHYmEUwoakEFTYbrC0+USSMLc63qOhiBCNLP?=
 =?us-ascii?Q?bWLyfRMmydGtKmvAhQkyLcY5rTJstJpz1384q2SLd9/g518kxeoeCLDRXdWP?=
 =?us-ascii?Q?A38F4ZSMcCGKGb53kaXPFoMW9NJP090by0ixEk/ZFmdn4zyc+5OoQpNtt+Cz?=
 =?us-ascii?Q?roz/WGty+EJuJeiDayBkQDby/Tjzhm0J6X30RP27I7vIMhLBxJifyw6hl4sj?=
 =?us-ascii?Q?N7PTkaQy/P6zHB+HqMj0GI540ynbToxj8OB/tt8jZe2oH4cMrogNJZK/7I2/?=
 =?us-ascii?Q?0vTYv+AkHegV4JyyeVFi4E16LxmCIDMId6pMnDNA7KvDJmbDeaaJTZveyeDT?=
 =?us-ascii?Q?uJWyKGHYeRfD9FMHcbdQSro9Ucc0vl6jL0xBiZnDBR7GpRpSMOYuPSUPzUbX?=
 =?us-ascii?Q?VYEA3ZrQrumbf/7yU6BIgYGP2kGSVZIcg82XEGuMt6GatrmMNbX+XHUyTqfe?=
 =?us-ascii?Q?rlyc4zFaThMek2M/Px+Px0Eh55LSpZAqeAAPYAT0fcWOLfeQ2vUjdS3L8C9v?=
 =?us-ascii?Q?izxVlaZkf78al8b88cDNXS8h2LjVR00EuFHevDaTaDriwLm6w7Jg2PrfqBsP?=
 =?us-ascii?Q?4l2i17ttMx9epCCprwehqDF4SPo1AFabm4jbe4VmFP1H5Wqoi0Uc8q/Hsz3F?=
 =?us-ascii?Q?1RxYEnNufuH3IY3dY+H8LMYFv1Ab3fe8DJQJxbXDPM/6kPwJqOIv21AoxpaX?=
 =?us-ascii?Q?pYXcWLxlL2gXIyXbKXJn14S6DLwV72VbCWNVmJSNnaocKg0HwgY3PaWQdUCX?=
 =?us-ascii?Q?nNbRnZwl53j848aSaYQ+148wnfiQweXCi4x1EdtrfovXjR4W+Yb7DYdbAr9p?=
 =?us-ascii?Q?hbH/dgESqFwxGFo4CpOqS/58xFbwcuZiWMjhbWTMfrteNoRe+AQnS8N4m3Qw?=
 =?us-ascii?Q?ly90NvfLwiDA9AFDMe4kN6cCnC9/r/aDpsvWwRaFuwtkpfpPh8b3HGH+GcA3?=
 =?us-ascii?Q?wFsGINOuHcExIfe8RyACd3+tsbQs802j8xtNoJgoRQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTCwNcXRDj6l1PXjPObhD4Xyx3Pa+MA2P+97qR0kzBrWoPzReNG4djzNPn5j?=
 =?us-ascii?Q?7OG8+i5XGYB0kYl6XZP/E/DXlAV9o+nc+FoaE/jNwVUH7SmwSXzX4HrWwEVv?=
 =?us-ascii?Q?ooIfB+c4RjloV+IIJgpxtjrm/BHtXKVqc+/MvS8z9bIvzzB2oKsvSRQ0pP1p?=
 =?us-ascii?Q?KTT3bT0C9XJqApJeLHIoOr4FNYeSlu6WN7J4Akj+dIYJxfBspgBnLMkiJqbp?=
 =?us-ascii?Q?U0uC9S5RND+QPErvTnAkQ9UNeI5yQUc1Pgam7TjwdSqmTOxxsKC8Z+QAFxiN?=
 =?us-ascii?Q?mfBqwm6b55FsA+qahYl1Z/+ewvv4atM+DOLO8IZg2l48nvqQm7jeIhidTOmn?=
 =?us-ascii?Q?R3sPRBUkVHr9hraTqa9PzeXNzlJWGk1FxRbBCcKrgCfQUZfyY9qZ2bSu2TjC?=
 =?us-ascii?Q?dkb+XZl3kaoUEtIHoFxISHQ9ULj52gvkoxntbfDXYolbw3Jfs1Fn7SlZMqza?=
 =?us-ascii?Q?i4iLSDuANumkuWxMmiCvgFRwbBWm+fXeGH9vVcv4suAIxohnyUurXJiB0KLP?=
 =?us-ascii?Q?BXNaQGqNcLzk1wIeP69tZp6kwrtSuLlVwmdObsBKKP8gWmItTD4+pt9mhuxs?=
 =?us-ascii?Q?1oiqLNRrklT55x/kBwTpOPgDLaVzH6h5Zkz8/Rmtv6zDaZ6RlvJgP5tigI7I?=
 =?us-ascii?Q?o1/cQHsomlHcy7+nitOtldr4YcrufKik+YCKL8CruBXDjc9dNvjF/obrO+4V?=
 =?us-ascii?Q?u53n/L2ghnLjfPqimrDB1MFNTKCNExnNxMy0sHA55zHp0fugwH/BQANxy6dX?=
 =?us-ascii?Q?LOUQWap0iK3wbWrLuxxmIk0TOZyjjvMvAlynCTBN0vyWt6J55vMyBC7YBbFL?=
 =?us-ascii?Q?T0aEeuHDM5v9YUE0ET64TJzsaz+5oIpEaPZPtf6VuXeuIhtVfX8lEh5LrhZB?=
 =?us-ascii?Q?YO8ssdenZfLYiDxXEA3PGPCcyvfm9GN7TuppE4H0uD2HfKxSLZy2uW8oyTIs?=
 =?us-ascii?Q?oDXBa4YOWrsfgu9U2J1Ab4GCs8crkEQ/WXX5Xn6H9wb22dlX3AXUh2sz2WM6?=
 =?us-ascii?Q?v3aX547HKtGNgjPGKrqhGadiudTf3hw3rc39z1bGXnC3T2KXlwjZC0egfCXd?=
 =?us-ascii?Q?j1YTefFxwnwZpMeOJzPjaM4BtGxw6VsY9Kz4qLo4g3VCDFflcy50WeiLSYNN?=
 =?us-ascii?Q?sF+OMkQCFNUpRqSFIgjh4LdlTZS3WGOQ+ogn7BIqjs+ydldsl0fv+UpLjKz3?=
 =?us-ascii?Q?rj2Zfgx5qh9/cTAI1oEveGlY8pybOq+W2r+IejbFxNs9fwFtJce64guyZiM6?=
 =?us-ascii?Q?zzfXBVn76Drt6lXlmh+8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc70d5e3-09c2-47f3-a27b-08ddccd239c9
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 05:55:44.6901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6333
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

Allow the system to reset the CPU without calling the reset
controller. This patch also removed the default SYSRESET controller
for MT7628, as it is now optional.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/mach-mtmips/Kconfig         | 3 ---
 arch/mips/mach-mtmips/mt7628/init.c   | 8 ++++++++
 arch/mips/mach-mtmips/mt7628/mt7628.h | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
index 3fcd0b8465b..337d2259fa1 100644
--- a/arch/mips/mach-mtmips/Kconfig
+++ b/arch/mips/mach-mtmips/Kconfig
@@ -102,8 +102,6 @@ config SOC_MT7628
 	select SYS_MIPS_CACHE_INIT_RAM_LOAD
 	select PINCTRL_MT7628
 	select MTK_SERIAL
-	select SYSRESET
-	select SYSRESET_RESETCTL
 	select SPL_SEPARATE_BSS if SPL
 	select SPL_INIT_STACK_WITHOUT_MALLOC_F if SPL
 	select SPL_LOADER_SUPPORT if SPL
@@ -111,7 +109,6 @@ config SOC_MT7628
 	select SPL_SIMPLE_BUS if SPL_DM
 	select SPL_DM_SERIAL if SPL_DM
 	select SPL_CLK if SPL_DM && SPL_SERIAL
-	select SPL_SYSRESET if SPL_DM
 	select SPL_OF_LIBFDT if SPL_OF_CONTROL
 	help
 	  This supports MediaTek MT7628/MT7688.
diff --git a/arch/mips/mach-mtmips/mt7628/init.c b/arch/mips/mach-mtmips/mt7628/init.c
index 2996fd9ef4e..a0e731121c9 100644
--- a/arch/mips/mach-mtmips/mt7628/init.c
+++ b/arch/mips/mach-mtmips/mt7628/init.c
@@ -110,3 +110,11 @@ ulong notrace get_tbclk(void)
 {
 	return gd->arch.timer_freq;
 }
+
+void _machine_restart(void)
+{
+	void __iomem *sysc = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
+
+	while (1)
+		writel(SYS_RST, sysc + SYSCTL_RSTCTL_REG);
+}
diff --git a/arch/mips/mach-mtmips/mt7628/mt7628.h b/arch/mips/mach-mtmips/mt7628/mt7628.h
index 391880b014e..aac6e1278b2 100644
--- a/arch/mips/mach-mtmips/mt7628/mt7628.h
+++ b/arch/mips/mach-mtmips/mt7628/mt7628.h
@@ -49,6 +49,7 @@
 
 #define SYSCTL_RSTCTL_REG		0x34
 #define MC_RST				0x400
+#define SYS_RST				0x01
 
 #define SYSCTL_AGPIO_CFG_REG		0x3c
 #define EPHY_GPIO_AIO_EN_S		17
-- 
2.50.0

