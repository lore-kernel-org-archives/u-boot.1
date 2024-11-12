Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35E2D597AA
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 22:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1769488DFE;
	Tue, 12 Nov 2024 23:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="e66sZNGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1522488F55; Tue, 12 Nov 2024 21:40:52 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761CB89471
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJEAhPZzqhWhoK9xTg60x8soOyz31Q/N/BwiV1H85HEm5mRo+CXhW8/aQe9Q9cvDOvQPZmW+iUFhVjwaDSsHh3ehaBEq4ixTmotK4udasXsZ93GLoga0a3+u2fTOruGMdp5mNHXGRpTG4XI+rnd6CJuGMGb7k7Tq1RyrYFS7mwDiB8B6o9f9eMsJZ0Q5XnQ1C8vr/I7z2/YLPZB5rTqrHMD4bpj8UsCl44VtOiLmCtqj2k3M8RUwILvVfHURIn5B3OYZQj0wa5GfOOSSzjLkU4VEXlXREW2sZBxotqbtho/1MILCnMxuT5eXe8WTDAhxFC/m/geO1dDvhB3MZd7jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PglswJbyAddip8RVsAda3qef44HrQy80X9N4m9rdNYo=;
 b=aJnZ/wEZ8uQfPYw8AV+jIRkpPEkrnX47L6mzEaXCu90WFbC6RxjO8TQfoxroxaXBIEv35OIN2s9e/SNT2uAy+SNvRTsvXRXeWmpSBUvYCoS+0BjNIx1hV5WLQ/9IczaoPP07JnXC96tApG9yNX+GJL4uls0ar9Vv6EK7CP+K1sisGYnjxouv/0pBSPl/ooDl8SEwibYCpK80/Yefcamo16LRoy/ZFXLWyL+JRAsAcPjNseNfbfyirDw44VeCQESDj2/9BsrGDb76iZvhK7p3XcxKsOvvJ0Yw9uP5YHdoZvTYt5rXuwIr2EMjbtAHjAJc6zpJSF/KsmzecNFgYI3eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PglswJbyAddip8RVsAda3qef44HrQy80X9N4m9rdNYo=;
 b=e66sZNGXHGxZ1/ml8KVRx0f3PCBS3IEa8uOtaP7bMCOrZE95GGVFR37xeegQzvtQnMxIZ1uaVTFe0hV1Jqe4nN2U+DF0hkQjKZ/miHp1Y7u0yxMHBlujNq3r9tiw5m93VrXdwNgAIvms8X6il9NQ9E12ybLYOs7y9hPPD9mQ9FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by SJ2PR22MB4267.namprd22.prod.outlook.com (2603:10b6:a03:536::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 20:40:45 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 20:40:45 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, afd@ti.com, d-gole@ti.com, marcel.ziswiler@toradex.com,
 sumit.garg@linaro.org, nm@ti.com, d.schultz@phytec.de, w.egorov@phytec.de
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] board: phytec: common: Introduce CONFIG_PHYTEC_K3_DDR_PATCH
Date: Tue, 12 Nov 2024 12:40:23 -0800
Message-Id: <20241112204023.3619557-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:408:e0::9) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|SJ2PR22MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: abb3edb7-3d47-4b60-2d78-08dd035a4826
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2AxVb9Xz0bCdFKMq6wm9GQAOVwvtIozFZqUnovj69u+vuNTKfK4uyCgPtRfj?=
 =?us-ascii?Q?jTh5LpTx6YkMoKMa3+K5RtiNUGjmOLOu+zziHnpQ86c7jaaywjG7O434nMaL?=
 =?us-ascii?Q?Jbf+eW2bXRrzD2kEjCnplNpPlPb+cjhyIOpTxdkL9AeKGby3QgoO8atSPHSi?=
 =?us-ascii?Q?JG71e2osLdjqk0VG+KomgpAxrKRj11jNbjGPT8VNFWXl6wg/R6QorhH6HaXZ?=
 =?us-ascii?Q?064MO/S64NrBph6mb90mztX8bJY9NvVzCGvQ0780UwuRc4/STKF9O3F1/gkk?=
 =?us-ascii?Q?sF9SWl8n6pL0T3oWKw3VObMxciqxJBc5yRV6Z6Lx8wbVFlzi0lg/eUZ6b9fo?=
 =?us-ascii?Q?2JmqBZQVAuh51pNsboEcxrso3fUZQBnCcGB3CsBvpz3n7DHI60iGceF36aEe?=
 =?us-ascii?Q?AKR705VLSABcvvYXOoLd0Gfz77vaM2geZiahcF2wni0LFkBGEIxNOA9bIM2r?=
 =?us-ascii?Q?rWvIOAyGdHfz1o/Oq+rT091oMkmZXpiTietBJINQ+rWhusJztuN+d2THHhRl?=
 =?us-ascii?Q?cAjCmxQu7opdUfp8XpOu4DfC/je29pQc52Onl5nIKko6j6IZiNzUSVG07WP1?=
 =?us-ascii?Q?ZFijEZTvPK8FbeD/MEBDs6VypgqlywJe6h1US5tVK14WAntLVOdObllvZeml?=
 =?us-ascii?Q?HUaKsmKM/DcS2JefXSvovMBn38D/h1nhk58ylW7af2F/kkWu1i8iJmVrv3Vh?=
 =?us-ascii?Q?V3aV0tqk210+QvWM7WZXi071NeekuTlBtD5ubatJQUmcleeWVCkIlpTRRBHf?=
 =?us-ascii?Q?lc3iyZjsx8Rp42yLKCfMAA0mYLz1bKfPxP+NI0u7nccm75iar8lsFYK0MLW/?=
 =?us-ascii?Q?Ed9JTL6UJjnv5ZRfTRbp17RLTJba1QQxCDccmiS07VokE8p6WLX+G71nh9Xs?=
 =?us-ascii?Q?CfxqUikFQB/lBHzm2t86msafFtHSY0sAXO550ss9SeEUFTZwdoiT872rJlWa?=
 =?us-ascii?Q?6fl6uGIs17X+82oYk9gtd6OetgyuQ4mu2VUQ3gvjhp9Tr6P2xwoiySwrkSTF?=
 =?us-ascii?Q?uxlbLnSgBSI7SfdOgHgVtV8E0crJxnzEK7Cu+pIb8BoI+u8lfmWgnDJjYw2t?=
 =?us-ascii?Q?YxhJPgYXG4wdILGyxvMhzNciuBzx6AGB5yuJRfKbWuGZO209jXV3BEBoBeH9?=
 =?us-ascii?Q?519511pIjVgoxdIPLbzjWjMTMjwzH1q31TzneJKQbzt5qzlcVoFz1xbyapNs?=
 =?us-ascii?Q?a95Nn3c6oscpUEBCfpqZDi3OZVS+6HH+IggFzTCxJnyEq+vJEQ+pDBqx7p1Q?=
 =?us-ascii?Q?supP0I36y96isLi++rg4agZRgQwjE7AN7g7sk7Ood0oWIKEmzBDU7sE1u+d/?=
 =?us-ascii?Q?DbZBhE0pIoZyGU8ooXPxoQ6+nDi+1Spk/Suc6N9yII/43BFvGFpVd02hwNFZ?=
 =?us-ascii?Q?wkX+APg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGDc65lrNGSioVxJqpIKDya2i1jV9Y+cvnZk1Y6Woqym2+TY5g8cD4ImBZgP?=
 =?us-ascii?Q?BTN0HkawrPOENkBPAkQ6FBwh6HOhsksMCQc7sl+8QmasyMrTdG96+SZAaGQ+?=
 =?us-ascii?Q?U54MSbe+g/Nuv3lCLQOVMQee0M7u9EngCamGLGbpBI6yWgR/sxlBtSbyky3p?=
 =?us-ascii?Q?4vuX9bzQcAVEPA3fq9xVM79Qn7eTImbRj93V/yWbYgiX+B2enLF5ev2T+4vu?=
 =?us-ascii?Q?AnWn0usNIC269OHFFKBTa09DQgHzqizWWErd9UNxKHqCFtpFPJdcxXYsU4R+?=
 =?us-ascii?Q?4bNRxpQzH4VMH04fJklL3WQHGk6LLsIADlq7l2vd0WltRDowWdm32uHqChi4?=
 =?us-ascii?Q?cQ/rtmz88rp4hrjOj/yeBPCPWSYRH1kbSZWT8a6EU9MS0ncabh44cBq0HhPu?=
 =?us-ascii?Q?mbeXI7nQYF0ljTFJ4kCuXNWsJ0Yr7/UkcKWpadoAQNRpxNmSobnZgja/+L7G?=
 =?us-ascii?Q?Qm+dCITgqBinGoxisjiTK9z+4lQvPEB3uG1YdQ7Xw1xJoZXezJ9/ZrKqZh1p?=
 =?us-ascii?Q?AvMJzwU2POKE2vddjNPhoFcMtk3mR9I18WSBxP52CrirAlm8hLeR1sI41MlP?=
 =?us-ascii?Q?Q74V7CThIUINNFTKePK4QxR18ig1xa6xqu0xuxoGc8eF0/e+hJIGI4VYJqhM?=
 =?us-ascii?Q?54bxb342q6bSCIAn2X9XLpWrcgQgpex48nuT19CC8QCVWhju4aHVU9ZefRa5?=
 =?us-ascii?Q?B8LNWsvsedWN8lAgnyjncCZ2C7yvLhROMWySfvhEuUoTgnT+zK7choI3FqLm?=
 =?us-ascii?Q?fssCI3fU+AWQBe2JrC69BOys9YMEYRsBZVzYZKG3tYf90BtTsuWCMPVe7sE8?=
 =?us-ascii?Q?WNA0iYEl5+f7CX9l3U+psDyeW+lNhHFFdI9TkY8sV6srQPGYILnB/Ltnk4Rj?=
 =?us-ascii?Q?nuo1n6byKf61ENVlecRvGs5e/Bcyo7fiPvgegGuYXsBxVNvsaK2GUElIMHTS?=
 =?us-ascii?Q?tzKFKoveNWXJnGtsKHajesFnEDV0NOojhGHgGKOEDt8dwHnPxvuccaViZtPk?=
 =?us-ascii?Q?6rpuOMSdvwEPhFetsp8U3EYbREt7fLuZG0EwC+TYO2mGI3bSdrrumCeroUL/?=
 =?us-ascii?Q?ug5HrUzydMOCTpLONGEBWPr4C6m57MUjSLqZqccuoKoNp0JoOqHznnFOBnmS?=
 =?us-ascii?Q?NaS1RkHmK0xp30pA26PiStQFew5IZhj83uA0mbJMxr8vHXkczDEz/cmdOFtC?=
 =?us-ascii?Q?xPF55VJXHkpQQRo+8fJCY0O1tItR1e7KZOwPgQmPnvpZ35aszN0KuMVsc6ol?=
 =?us-ascii?Q?R+5MUTaMfMvUvkDWLThu6a1WKSKVROaCYWxHzLawOY/x1R0XjoI1rGEzx0BQ?=
 =?us-ascii?Q?LOrKExjxFU/WmBcHN7K1YxuOKzSv5NVEA4rQPC/CSMozR4ra8ps4JCHnEPDH?=
 =?us-ascii?Q?yCD8HVTERhPpkjyErgWAhU1WdwQizPqI/VIdX96hdTRAG8WgLF4WXbiJ7fzm?=
 =?us-ascii?Q?+DSKXoUckkG7yJSpuYUEFFmsfeoP0aaQCSCsG9gMo8Bc0LXOpNaJyxO0uaWQ?=
 =?us-ascii?Q?giBXNKWf/iTSaGDwNsK8AW4lWqG43v2wPaDNBivqj65NunM/HHDCQ/wi43+h?=
 =?us-ascii?Q?M0vXwCG7YhkOrmx3NTJamU4QyVANB8aIxEWHT+Om?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb3edb7-3d47-4b60-2d78-08dd035a4826
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 20:40:45.1437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OWu3/L8Ox5J/sHOKzGvPsNw35meKAuZO3p436bFfGXdHfMzLvZ7zX7RAZqPKM++9JSRv+O+UjbpHw2XWr83qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4267
X-Mailman-Approved-At: Tue, 12 Nov 2024 23:22:22 +0100
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

Introduce CONFIG_PHYTEC_K3_DDR_PATCH to make DDR timing patch code
optional for PHYTEC K3 boards. This allows better control over which
boards receive DDR timing patches, rather than compiling the code for
all boards with K3_DDRSS enabled.

Also enable the feature by default for PHYCORE_AM62X_R5.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am62x/Kconfig     | 1 +
 board/phytec/common/k3/Kconfig     | 5 +++++
 board/phytec/common/k3/Makefile    | 2 +-
 board/phytec/phycore_am62x/Kconfig | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 board/phytec/common/k3/Kconfig

diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 8b0cdd74f4f..81199ada3a1 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -42,6 +42,7 @@ config TARGET_PHYCORE_AM62X_R5
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select PHYTEC_K3_DDR_PATCH
 	imply SYS_K3_SPL_ATF
 
 config TARGET_VERDIN_AM62_A53
diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
new file mode 100644
index 00000000000..282f4b79742
--- /dev/null
+++ b/board/phytec/common/k3/Kconfig
@@ -0,0 +1,5 @@
+config PHYTEC_K3_DDR_PATCH
+	bool "Patch DDR timings on PHYTEC K3 SoMs"
+	help
+	   Allow to override default DDR timings prior to
+	   DDRSS driver probing.
diff --git a/board/phytec/common/k3/Makefile b/board/phytec/common/k3/Makefile
index 40e91a43e99..6861c70e17e 100644
--- a/board/phytec/common/k3/Makefile
+++ b/board/phytec/common/k3/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += board.o
-obj-$(CONFIG_K3_DDRSS) += k3_ddrss_patch.o
+obj-$(CONFIG_PHYTEC_K3_DDR_PATCH) += k3_ddrss_patch.o
diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index 7c179ef0078..ecee5873c0c 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -33,6 +33,7 @@ config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
-- 
2.25.1

