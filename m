Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0426CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2B584833;
	Wed, 17 Jun 2026 16:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d3vsdVci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6781F849A3; Wed, 17 Jun 2026 16:11:43 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F63A846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=medZxdcbzuDgarIQVlBaTt+NlqiniFN6vP6pBWobOWyx4zBY+BF6RhPdr7LF65ro8Q7d+/kYVeLp11/5hUdeptGB4BTkPB4atJK3dJ10r0+PZ/ZKdwBaBebDW0cGMaTJdC6USWggATTJ7hcjzcVprRuCYfd92+3+m8OlBggev/mR1480GQ0HNb/gqszS9N3zODcZuBPsBHUXYntBqIQ0g1Y5veJr+RcwIUGx6NXdVKRqnFXN3CU5g+DWnjK0U1dKLPJuYfV4pmTdhAH5aGptpfff+rvqhTQhuglbChJsUClp68Aw3hThHcAW+bIorTx+eA1Xdg4pyI9LMXclbZ1IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ckG9yX/31n98Qi+vxwlGr8Ix80TFmZHAC9UzqsY/c=;
 b=HfoydTxmYM20KE33wpgrfDJQMkKTvJjRcyxgxvVFx9+jHpdFSfPzu8VHfUOw7u19OrKzx3FcgB06/i8cLYEfHWEjKL0WUHVKV4VAGl+sl8oozV125qg63SIF+VWLrOwhoNV67onO9UFPoTSOxXg5KG0Y9afAVk5jyCEbV9Ogzw30Pz2v8XFyjmpENCev8szbszl+VxJE/KwithLjP1DqgsfAXE5MrJgdjSO6/zd/agP0SA4nXvYkyn5qg0dJnKHl/rYKYjuVKrMiXIPyOjxGKB9Rm8u1I63jNaendBTyeGB7OEaSrCq+pnKN0izQyiPF9Kyx9Si2Dd6fAVN4yjpqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ckG9yX/31n98Qi+vxwlGr8Ix80TFmZHAC9UzqsY/c=;
 b=d3vsdVciZ1KKnP70iILdtjbxIIhzX38Ph+ofCpqB5eFp5Fv5kt7y3jJIIZaKJQBcHrTkVuPNiYcRvhePxJlq3S75aiHQhyVR5tVcx4rfoUfyXxaYLTGsOqPuEuMpqJlHfy9xoXzkWfVEwkQEGvN+hAIZHugNUJVx/NBB0V+b3gg5QPmGqjwWZEseKz8fKtFTes0mW/+5g8ornw292KQo60f5Ul1SfTJJ33SoEaFukoQsBRA0a8FUu4JejASpH8EfyGxueqrO7ioYdFYzpbAhwWCQZOPjM2reSdYzDJG4ogoEzzAezgm5klgeJcoy0K2+0pOnDrL6O6/UtLyUDizLZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AS5PR04MB9969.eurprd04.prod.outlook.com (2603:10a6:20b:67c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:11:38 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:11:38 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 1/4] imx9: bootaux: Support authenticate signed Mcore
 container image
Date: Wed, 17 Jun 2026 22:14:43 +0800
Message-Id: <20260617141446.2794896-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::13) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AS5PR04MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a6262c-cc7d-4401-b0eb-08decc7a586b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|19092799006|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ou/toPbQ3fKutfT4vJdgcUXI/66BrCatmDOdtgkd4HXFcSxE1SvKuPprX4oyZD7aVqQX+h1HfrRBcMu17Z5jmnmpWdaZaqvNffEMY6OR84SLRixpTN7i/58pxgnOj3oNf2ZBEeDinOoOqSxBi8dlJzw3jQQYtktSyRmowvtkHyD7jzbDRGf3UaxeUEavXZMJ5T0i9Pmvc/kMKz1nAYiOX658D/ZfqjHMchnR0sNpNGcGgpTMpXInxj1HWk3D5U+wtvjglsrGFgfiyD/JYeenRS4LOqcp40/bFJ++d23JkaLbOr5LvdStI2FUdCDI1/o+oQAa7Qsw3etGUCcUmf0dlf6f7tzjyLIc6p+CluGy0wJfiweAMAJaUAbFrfXDhS0Y0D0K/TIqbDFr0k+sywgOkNlvbCTrywmLAEwEKFYZqzIztofZQQ6jfm9aMFvvZlr3nc0dM2ST0xHxg+ELwH+0iKOWlcZ1TJs734Ptca9ldo9g5MQohj0JAdvSTIU0SnuwpZkUH4J9XNkPtAiPPYyD0d1oUsB5fRdfFGkK0kGn1sV817peqAmHEsgKllqjcfdut5WtzGYCO4QMzJLWGVtBN28yHqseSl9+z44+DlqhNIwfTB5ngvoGZGkRY6kXQ0a5LZR+/MC2YV1eX1K4btHBPrk2WxzxU2KZB3pMR3YlIbLHze4s7EhLC1Z/udGUow9b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHtyB3M7vJCxfA/tQ5zcvA5jyuvBaEd8wbZm6EiSFYLd84iGOMre3IWzUwcg?=
 =?us-ascii?Q?8Md4xBgbmspbp+4HqBDA5r5nm3SagY5kEAQeOlgGg9fjbCnbGWdxfjom/HsH?=
 =?us-ascii?Q?Tyz8yWtQ8myxAF6AyUYu8Jx7p3PTfqHE2NE70izusSC+Pfm2UyI3sugd1dTh?=
 =?us-ascii?Q?jKe9lXEXtCHDXTjnHvMY/WK2LMjYnrVfVYWtv+novnLWUroNQDib6f+p/Cmy?=
 =?us-ascii?Q?+mOf/df3si7lJ00sNCsVMjjHqIxFEwyWcNpx7a57Bv5If91cJWyo8+6FBy+p?=
 =?us-ascii?Q?R8amDKiwvBtRokaFdrs+427cqFAOiT//zWd9v1Dc3frF4BUGyF7nMP3YpqqA?=
 =?us-ascii?Q?mtV4i3+ONU3L+QscGkeh8O6o3f+DtzJmK6OFJONWc5KBntMZDg3rmLXgUKlW?=
 =?us-ascii?Q?2vUfr2eYzlRxqO7CZmSM20uRwFddPBBrjdlHcKXLuaiftuE57wRBFgFgaqwy?=
 =?us-ascii?Q?irUTPEmg48/TJVBwlNXJRMOfnVHFWpDpw+sDJRH+9hjRpZqCq7ksp1bSrSdL?=
 =?us-ascii?Q?t9poWjnuMdB6cvLFRkIqQp4NBukYN7OJ8Cmxhmb85s4gdc5vPVlMMQmS7s+S?=
 =?us-ascii?Q?yV4rhb4NyPZ8brlWuJ/qXueK36HsBvSbtN1saxnqxQDv0Y0s2haUySHePGJ9?=
 =?us-ascii?Q?QZQWvGlJFMKiuDKumYuchxo91nYlJ6BMeeK2T8mG/kz8hX96JhmqTBEIn7U7?=
 =?us-ascii?Q?OBix0ATJzXIBa1f2deEl3NYjJB/6tY0TLfpzNngZfQy5+jR7HRRktBmNkoiK?=
 =?us-ascii?Q?hCY0jVDbjsFycBOtSZWPzMqDV8IeHPyhBdMWQ6z9W7+lZ9Gx2SCwHvoKHyW3?=
 =?us-ascii?Q?zXoMEsZ87GAQgNmHqU6UeuzTnLPCBp/6NI4PxGJuAHUnX2n4C3zW5CcBaSRL?=
 =?us-ascii?Q?z8PRiNkNy+6J8LE/wKUalJwIqTpcR1l6OfbLvPhIenz9kIDbdu2UrKOtIovH?=
 =?us-ascii?Q?/jsQ+wY1bzehBCrxi3PLqMlJNWWt2q7vM1dZ2TS/SQ+q11TuR0vP18AcpUan?=
 =?us-ascii?Q?PdYg+xm9pnB/HyODhcyPFpk85c8dJnuvmZzriNDT3CTYK2guQWeej06DEdhq?=
 =?us-ascii?Q?MEOTTkUPG6rtAf0MSnNitTf9VAE2/0brkikdU4zXEcPMksat+em9p6IL0So8?=
 =?us-ascii?Q?sJdy5viy+pDHnEl+Ll4N08q0swd48QSH6ptK8zMkWfaREGyR11Rdtavd+Vh3?=
 =?us-ascii?Q?pYXhunU55J2nmCGI39caWsay2XAtXYt1RXz4sUrtu8SgfYz0JD45AiwVuj4u?=
 =?us-ascii?Q?5tDgZ6DfoJlxcil1UaKeg+0OzieSKyjc3sNYDcQgYGEuRsVKagQUyL1Q5gnY?=
 =?us-ascii?Q?y6YyxYMOLfZPeXt8vhQWOKYUZ2Bw6m6UTj5ewqbi4lPx8afeDCNZIXXzGi66?=
 =?us-ascii?Q?ARsj+CiLhUDBgast5Uaz3AoRs1Tx1BAS6MDuMlZ8+ULlg2mVOMoB+0Dc+wy7?=
 =?us-ascii?Q?J4Zvl4tO7zc9llZI917j/v7Kbpy8K4w0p1MH3GcTSW6AQrxJLU40j2Wl9oJL?=
 =?us-ascii?Q?vGSkpXmk7ZL1HWRBfoI1uj99cFIi440gvmRuJD033ZD9nOpc5CYh7VcTqn6n?=
 =?us-ascii?Q?v4SHWKRUEVIhwWTTkCt7DBPfwImApGR4K7c2lssMRr3FY7Gh384fn+c+tmKG?=
 =?us-ascii?Q?nBfB+so8aQ4Lx9O3KDIAyjsAk3cPjo8waCxSjJIq4+3EYU2lIZV+C8uoaqVG?=
 =?us-ascii?Q?XhycKbzd0wfjAogsp3GXH/J8hz9wRZVpeQRkexOsY7UidSyQ+G+lqEHyAhr6?=
 =?us-ascii?Q?XcX9XYoz3LmhrLwIwwBTe71dpuPHLSk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a6262c-cc7d-4401-b0eb-08decc7a586b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:11:38.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGzTXEXJax+HrBsm6ViT5X/nQCSM2kzf8h9NMstBdGUO15nu9MlO2XHKvxrKZa2vWPJeIiuOomVhtsbwuBkQGO0tIfzCSrXQkcnqbkIA2wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9969
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

From: Ye Li <ye.li@nxp.com>

Add new command bootaux_cntr to replace bootaux in secure boot
(CONFIG_AHAB_BOOT=y) to authenticate signed M33 core image.
The M33 image must be packed in container format and signed.
bootaux_cntr supports Mcore image loaded to TCM or run as
FlexSPI NOR XIP.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  12 ++
 arch/arm/mach-imx/imx9/imx_bootaux.c      | 216 ++++++++++++++++++++++
 2 files changed, 228 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index fbf2e6a2b01..47d6ae9b559 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -47,6 +47,18 @@
 #define SRC_MEDIA_RBASE		(SRC_IPS_BASE_ADDR + 0x2400)
 #define SRC_M33P_RBASE		(SRC_IPS_BASE_ADDR + 0x2800)
 
+#define TCML_BASE_ADDR              (0x201E0000UL)
+#define TCML_BASE_MCORE_SEC_ADDR    (0x1FFE0000UL)
+#define TCML_BASE_MCORE_NSEC_ADDR   (0x0FFE0000UL)
+#define TCML_SIZE                   (0x20000U)
+#define TCMU_BASE_ADDR              (0x20200000UL)
+#define TCMU_BASE_MCORE_SEC_ADDR    (0x30000000UL)
+#define TCMU_BASE_MCORE_NSEC_ADDR   (0x20000000UL)
+#define TCMU_SIZE                   (0x20000U)
+
+#define FLEXSPI_AHB_ADDR            (0x28000000UL)
+#define FLEXSPI_AHB_SIZE            (0x8000000UL)
+
 #define SRC_MIX_SLICE_FUNC_STAT_PSW_STAT BIT(0)
 #define SRC_MIX_SLICE_FUNC_STAT_RST_STAT BIT(2)
 #define SRC_MIX_SLICE_FUNC_STAT_ISO_STAT BIT(4)
diff --git a/arch/arm/mach-imx/imx9/imx_bootaux.c b/arch/arm/mach-imx/imx9/imx_bootaux.c
index 73f2e72263d..d3494a9baa9 100644
--- a/arch/arm/mach-imx/imx9/imx_bootaux.c
+++ b/arch/arm/mach-imx/imx9/imx_bootaux.c
@@ -9,6 +9,12 @@
 #include <vsprintf.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
+#include <asm/mach-imx/ahab.h>
+#include <asm/arch/imx-regs.h>
+#include <cpu_func.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 int arch_auxiliary_core_check_up(u32 core_id)
 {
@@ -47,6 +53,198 @@ int arch_auxiliary_core_up(u32 core_id, ulong addr)
 	return 0;
 }
 
+static inline bool check_in_ddr(ulong addr)
+{
+	int i;
+	struct bd_info *bd = gd->bd;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
+		if (bd->bi_dram[i].size) {
+			if (addr >= bd->bi_dram[i].start &&
+			    addr < (bd->bi_dram[i].start + bd->bi_dram[i].size))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static inline bool check_in_tcm(ulong addr, bool mcore_view)
+{
+	if (mcore_view) {
+		if ((addr >= TCML_BASE_MCORE_SEC_ADDR &&
+		     addr < TCML_BASE_MCORE_SEC_ADDR + TCML_SIZE) ||
+		    (addr >= TCMU_BASE_MCORE_SEC_ADDR &&
+		     addr < TCMU_BASE_MCORE_SEC_ADDR + TCMU_SIZE))
+			return true;
+
+		if ((addr >= TCML_BASE_MCORE_NSEC_ADDR &&
+		     addr < TCML_BASE_MCORE_NSEC_ADDR + TCML_SIZE) ||
+		    (addr >= TCMU_BASE_MCORE_NSEC_ADDR &&
+		     addr < TCMU_BASE_MCORE_NSEC_ADDR + TCMU_SIZE))
+			return true;
+	} else {
+		if ((addr >= TCML_BASE_ADDR &&
+		     addr < TCML_BASE_ADDR + TCML_SIZE) ||
+		    (addr >= TCMU_BASE_ADDR &&
+		     addr < TCMU_BASE_ADDR + TCMU_SIZE))
+			return true;
+	}
+	return false;
+}
+
+static inline bool check_in_flexspi(ulong addr)
+{
+	if (addr >= FLEXSPI_AHB_ADDR && addr < FLEXSPI_AHB_ADDR + FLEXSPI_AHB_SIZE)
+		return true;
+
+	return false;
+}
+
+#if IS_ENABLED(CONFIG_AHAB_BOOT)
+static int authenticate_auxcore_container(ulong addr, ulong *entry)
+{
+	struct container_hdr *phdr;
+	int i, ret = 0;
+	u16 length;
+	struct boot_img_t *img;
+	unsigned long s, e;
+
+	if (addr % 4) {
+		printf("Error: Image's address is not 4 byte aligned\n");
+		return -EINVAL;
+	}
+
+	if (!check_in_ddr(addr) && !check_in_tcm(addr, false) && !check_in_flexspi(addr)) {
+		printf("Error: Container's address is invalid\n");
+		return -EINVAL;
+	}
+
+	phdr = (struct container_hdr *)addr;
+	if (!valid_container_hdr(phdr)) {
+		printf("Error: Wrong container header\n");
+		return -EFAULT;
+	}
+
+	if (!phdr->num_images) {
+		printf("Error: Wrong container, no image found\n");
+		return -EFAULT;
+	}
+
+	length = phdr->length_lsb + (phdr->length_msb << 8);
+
+	debug("container length %u\n", length);
+
+	phdr = ahab_auth_cntr_hdr(phdr, length);
+	if (!phdr) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	/* Copy images to dest address */
+	for (i = 0; i < phdr->num_images; i++) {
+		img = (struct boot_img_t *)((ulong)phdr +
+					    sizeof(struct container_hdr) +
+					    i * sizeof(struct boot_img_t));
+
+		/* Check Core ID of M core */
+		if ((img->meta & 0xff) != 0) {
+			printf("Error: Wrong Image core ID, meta = 0x%x\n", img->meta);
+			ret = -EFAULT;
+			break;
+		}
+
+		debug("img %d, dst 0x%x, src 0x%lx, size 0x%x\n",
+		      i, (uint32_t)img->dst, img->offset + addr, img->size);
+
+		if (check_in_flexspi(img->dst)) {
+			if (img->dst != img->offset + addr) {
+				printf("Error: Wrong Image[%u] load address 0x%llx\n", i, img->dst);
+				ret = -EFAULT;
+				break;
+			}
+		} else {
+			if (!check_in_ddr(img->dst) && !check_in_tcm(img->dst, false)) {
+				printf("Error: Invalid Image[%u] load address 0x%llx\n",
+				       i, img->dst);
+				ret = -EFAULT;
+				break;
+			}
+
+			memcpy((void *)img->dst, (const void *)(img->offset + addr), img->size);
+
+			s = img->dst & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+			e = ALIGN(img->dst + img->size, CONFIG_SYS_CACHELINE_SIZE) - 1;
+
+			flush_dcache_range(s, e);
+		}
+
+		ret = ahab_verify_cntr_image(img, i);
+		if (ret)
+			goto exit;
+
+		/*  If the image is type of  executable, set entry */
+		if (entry && (img->hab_flags & 0xf) == 0x3)
+			*entry = img->entry;
+	}
+
+exit:
+	debug("ahab_auth_release, 0x%x\n", ret);
+	ahab_auth_release();
+
+	return ret;
+}
+
+static int do_bootaux_cntr(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	ulong addr, entry;
+	int ret, up;
+	u32 core = 0;
+	u32 stop = 0;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (argc > 2)
+		core = simple_strtoul(argv[2], NULL, 10);
+
+	if (argc > 3)
+		stop = simple_strtoul(argv[3], NULL, 10);
+
+	up = arch_auxiliary_core_check_up(core);
+	if (up) {
+		printf("## Auxiliary core is already up\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	addr = simple_strtoul(argv[1], NULL, 16);
+
+	if (!addr)
+		return CMD_RET_FAILURE;
+
+	printf("Authenticate auxcore container at 0x%lx\n", addr);
+
+	ret = authenticate_auxcore_container(addr, &entry);
+	if (ret) {
+		printf("Authenticate container failed %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	if (!check_in_ddr(entry) && !check_in_tcm(entry, true) &&
+	    !check_in_flexspi(entry)) {
+		printf("Error: Image's entry 0x%lx is invalid\n", entry);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = arch_auxiliary_core_up(core, entry);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+#else
+
 /*
  * To i.MX6SX and i.MX7D, the image supported by bootaux needs
  * the reset vector at the head for the image, with SP and PC
@@ -88,12 +286,20 @@ static int do_bootaux(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!addr)
 		return CMD_RET_FAILURE;
 
+	if (!check_in_ddr(addr) && !check_in_tcm(addr, true) && !check_in_flexspi(addr)) {
+		printf("Error: Image's address 0x%lx is invalid\n", addr);
+		printf("     Address should be memory from M core view,\n"
+			   "     For example: 0x1ffe0000 for TCML in secure\n");
+		return CMD_RET_FAILURE;
+	}
+
 	ret = arch_auxiliary_core_up(core, addr);
 	if (ret)
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
 }
+#endif
 
 static int do_stopaux(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
@@ -121,6 +327,15 @@ U_BOOT_CMD(
 	"     at address <address>\n"
 );
 
+#if IS_ENABLED(CONFIG_AHAB_BOOT)
+U_BOOT_CMD(
+	bootaux_cntr, CONFIG_SYS_MAXARGS, 1,	do_bootaux_cntr,
+	"Start auxiliary core",
+	"<container_address> [<core>]\n"
+	"   - start auxiliary core [<core>] (default 0),\n"
+	"     with signed container image at address <address> in A core view\n"
+);
+#else
 U_BOOT_CMD(
 	bootaux, CONFIG_SYS_MAXARGS, 1,	do_bootaux,
 	"Start auxiliary core",
@@ -128,3 +343,4 @@ U_BOOT_CMD(
 	"   - start auxiliary core [<core>] (default 0),\n"
 	"     at address <address> of auxiliary core view\n"
 );
+#endif
-- 
2.34.1

