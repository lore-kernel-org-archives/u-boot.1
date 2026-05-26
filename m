Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A79CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B17846DE;
	Tue, 26 May 2026 08:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GWc+pDuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F1483EF9; Tue, 26 May 2026 08:52:44 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7F4846DE
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij3NdwfaU/WXj1dlw33ib8/SMe+x06JUquk0ddzjqBpLt+6uBF0DqDbXTHK5gqQBMTbsu+DKe/XA53AitSE4WcSCQGCqgHA61V+tkPDrPGO8roitIEW24Jnygy+HcNaSI3DCIB6mZpJDO/dhxTjAerGGgbhc1avDW8M6fpkz9ZVlq+QKJLHGWqx4rDCMzXjkiWDbpvDwfmGS6u9VMB9evwdA3k0bQXXmpDM+VJnyfcgKNv7ZPASvCnlKxN4tuI27Gdikq8Ae2uR7mhGGd/ZTQmpXcTtS84h7KI819XO/SJ1EVMx1pvl16NGrtiPabqmElzXlVUtVowF81RWNhOTtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbMV2aAN6Hklt5mxGGblhPTUJY8YSz4YFckk+qjooos=;
 b=P7pS52CbVsKpKwZi9F7DUTYyt0TPgAS7GR26hmf1O9dZTtFlYmbaV6Vvd2EY8wc3Jwh9/vIIr+nCB1RBYkPUVTLaof7CMVHQ+nlTTltUU5vhas6yS+4Ym/ijhVtD8lf1UT5YsXkpV0BeR4C+BIN/eYOeTHV9tH6I05pxRiaOyjGoq68poDVdLzKRVBtxHA3vtEMFxFvh0Vuv3cGK2L0WHChp85c8MgvvZieGCQuwi+h1WzWaVYDwf0eTQTepRgXrLXWR0pjJCZ3rtG/L2M+bFgEhK2ECscIRg6h5B66vXNZnHtZRLQ0PZX613O+9IMA0RlMfMkWnlnXnKbWpX/r+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbMV2aAN6Hklt5mxGGblhPTUJY8YSz4YFckk+qjooos=;
 b=GWc+pDuN05NmpiI8GS58Xm6n9auCPoF1KrOwvFG6fPoSQ3WYTDRM2IpPyIj0zfLxjBxZpc9rMKCSrBQhHw4FPOtI95ERZmO7e/VlwkoaoXPb6m5qnet2bMv6chDySWHs9Ot5Zeo/8SrbVWs570OvKcSR1lCNDJNJk+WwLCfaC6XQMmNb4zPXZ+SnElC2rLeFXAfZg3txSUHqApf3DNfPYP+TJkER3YOPJ3VSBCHA1GGOqUzLqxp/0czjGdeqAgnKvW0oKa/ZFu/G4cODDjfc1x8olptBp81RoSXaz6eO0u+mAuj+WNAQCJQqnPUFkj+6wn1HsAZDF3LQfoAwbrKcZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB7631.eurprd04.prod.outlook.com (2603:10a6:102:e1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:52:40 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:52:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 16:09:13 +0800
Subject: [PATCH 5/5] pci: layerscape: ep: Use dev APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-pci-v1-5-ed7f31d73938@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
In-Reply-To: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: df44d15d-cd1f-4a48-00e7-08debaf3610d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|22082099003|18002099003|56012099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 5HhhYyDXcc83PEh8YCZvpY9KRPNrk3QheKRmJUOajPF5chteIgvH9VicgDPKFF2DVt8ySO2RvWav4Zg/kk1xs95NPKGSYEqcKxs76nT6Elpa2+5P2y0ukjC7HgMVEWTFUS3Le6oSYh40nqFiqNQBmhQHG+KbP+8OEKDnYQsXlWmm3MbqCYa3eTfBdtcqI8Ly1soG820q7zfkeAIq4J82KKV94Whfkwhd9d5AH0mGyrcRuFsjXZtZSZqS1tTYdeN4bhFzdV0oj94psXHQMrhjvLcDiTcvXRkLcwGw6v6LB1Z+33tFi9STuAdpLpARkcyauLsXY5CubpwCI4GIJbFUM3yT5lp7uBrTiMZ1kryLH2UanQ2M3aTP2cR0ymxXSUaJnwiqAlIdTE1B78Mmww223b09HegrZTji/s1HVgMCYEwNO8+cO1a8jgdk9Gkagt/DWnrbAWzNY4neflZ4F46tBHf17yY2X0LPKjuX1tjobJzC5+5DofJ8GV/YV6rzbudk78fAcxtV/EICcml8WNK8mAFzY1/YCISngMvnmay18SrJlWXERhBeJpstuqodSBHpGV+50K67pdga7CBxUWmx8mmR24SodfgKqmkkGi5XDpSBCIWQ4C+rdUN9geXUDEkDmeM5q77hHvoFx0filCRTvXK8oxPOm6rxwD7JOVLUIPDY/nkP6FD1FsLs4txT+CkWg8wp2Tmt6wNNTyVUR/xttHaLG70vP/NVyEXGOZdUTaHjbsK38xUVoxqE+YbRPaO8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(22082099003)(18002099003)(56012099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3gxVDg5VkJ2Rmt0eUNZZHV2aExHOHY1TkVsZDVsY3dnaGx5VFNaTFVTWit3?=
 =?utf-8?B?T0dLVXFqU0ZtWW5UbkwrdGJFS041Tm1NUmFyemN0elFVZjd3VlNxeC9FYllh?=
 =?utf-8?B?U3lrN2hmcys2c2FoQi90UlJOT0tnb1BUR0h4U3REeWtBVHd1TFRYR0E0R015?=
 =?utf-8?B?S2tJY2YyN1duV2RBaGtyTURlbzlqYXIwL1RieEdURDhNVE5wR0pGQXJwbGl4?=
 =?utf-8?B?T2ZTZnBlMm5RTysraTAzbUQ0SEk1eXZHSy83ei80dmU2MjhsUzZad1JxaitM?=
 =?utf-8?B?aC9jRlMzbW1TSEE3S0tSYkYyNjBwaklKR2M2TW1BUG43OHV2SVhNTGdxanRE?=
 =?utf-8?B?SlprdzFoWkV3L3NjUU9qTmlGb3BWOUxTWUd3VnRKK0xSWE9ZNHoxV2JoRG5W?=
 =?utf-8?B?K0VVemF6WGdaek5QaE5YRGRCRHdLVFZYd091ejErRTEwdllkbkpDTEE4RXhr?=
 =?utf-8?B?NVUvQkxrT05nYk1UR3AyM2gwTGUwYklTb3V3ZVVnSVlpME9ueGZUdXFrbjRl?=
 =?utf-8?B?dHNiMnZYUVo3MGFVaXJTdzhvbFhTRXVRRXR2d2xPeW5SMzZ5elBMTHBDMGEy?=
 =?utf-8?B?enhGWnYzK0tFcmRiRnB5cGFpTkxpS25qTXNtRFdkQkFGMkE3bTA1RGMzamZa?=
 =?utf-8?B?MEtQbndaRGxCWkRTaUR2cFhqT041Q1d0d2Rpd3liVFN5RWVDU1hQMWptcjZS?=
 =?utf-8?B?QVdmRWxEdExjazBHOURMMHN1UG1JUXBmNkwrcTQrdnhnZldYYXJ4R2FGc1Ir?=
 =?utf-8?B?Nm5icjUzT2pHaTI3clVkTjVYa09TNHJtZ0M4MTBDWi8rT3VnU2svenZnTGRD?=
 =?utf-8?B?cis2d1ZnRStvT3U3Nmk1cGUrQW9lMWIzL29sdWtFdXc1TFk5SXVUazlib1Va?=
 =?utf-8?B?TG4za215NTYwR1g4NlFjQzFrdTlCT3Jud3d1VjkwU1NxRCtITGVFdHFlZjZW?=
 =?utf-8?B?aEQ0RDJPWjNkVk13UWZtZXphVFZZWGdqam9DaVBQWUhWVHVKV0FicU5lU1po?=
 =?utf-8?B?dTZZQ3JqWTYvdW5OSWxrZ3dqbCtoWndBMVB5R2F0NlZqUTFmRzV6eDdMN2Nm?=
 =?utf-8?B?QThncENuSzdxTEJqZ1BzRitBZGE3SnlVcU8wMmJMZ3ltUW1BTU5TYUN3TTE0?=
 =?utf-8?B?WlJKQWRoRjFmaGR0M05hTTNmRHlIOHUrbU5OUzRTd3MxUE02Ymh3WlZ2Kzda?=
 =?utf-8?B?QU81Z0ppS3RVNVJXcXhNUm4vcW5WdmZPWlZTZ2dRdXlNVUhQQjlhOE5DZStZ?=
 =?utf-8?B?MkJGVDcvTGswZ2V4d0xwYzI0b2ZzMFJPNmh5TzJyQVdodW40alJMcWwvT0tE?=
 =?utf-8?B?MkZ0anNLd1V5M0NObWRqdlRJZWpYbmJ4dlVudjhxZlhiRTgxL0h5N2R4UTNi?=
 =?utf-8?B?R09BMXhRemVoRUlaelJzd2t0S0hSNXI4UFQ1MGw4NmtJekhQenVWWkNtOUR0?=
 =?utf-8?B?b1djUURHWWhCcW5QV3ErNFZzSTZ1YVFBbVZWVTR0NUwxNTRNTFlJN3lmcmFk?=
 =?utf-8?B?Z3NSTXFwSGRWU1Q0ajM3dzhQSE5tdStFbFBUSnRCZjRXWEpZY213M2YrUjdo?=
 =?utf-8?B?Z3J3RHFJMDgxS2ZjTVcwQmh1anh6Y2Z3Sm9zSkVteXg0N0I5K2l6Z1JISGFv?=
 =?utf-8?B?dWdxRERtRFdnSktQTkVlTDBsMEZ3SlgxMVhCOVFjY2xaeUs0N3J4RURseUlN?=
 =?utf-8?B?R3cvT2tZNTY5S0YwS3A3TVVPdXlYSE5UUEFha3dlSHdsWThNbHFFTS9qNkpa?=
 =?utf-8?B?Y3hrRE15MW5kRHpWTW4rTUdsVTc0Zlc4UCtuZXpsTUtBMVE2WTdFV0xqa205?=
 =?utf-8?B?ZCtYRGVnRmd0TmU2ZTFPRDNWRnVaeUg1QWdmamhnSVBONnNGTXdRenQvakN5?=
 =?utf-8?B?WGM5Q0RTTEJKRTR0LzBrT29tdysvcEc5YjVtb2d6Mk1jV0JzcVhIV3gvdFRt?=
 =?utf-8?B?NzRubit6alZRTVMxdjFyVXNacGFMcVRwa2xQVWpQNVdJWTdkNmZKNjJ0ZTRt?=
 =?utf-8?B?N3pWa21IVDR4eWcySldreFY1cG41N0dJeUtobmhZT1laM1NteE0yWFFjOGh1?=
 =?utf-8?B?aHcxT2lIUVpXUytiOFBpWEdnWit6dnpxN2hJbWpBZWVoTlJDbGRQTVZiWFl1?=
 =?utf-8?B?MXJVcG1TaWdRYlFPT1VWSnNGU1JBVVhINVE4aHJScTBncnh5cUpXTlB5d2RN?=
 =?utf-8?B?OWZ1WjFTSlljVEIwR0MxU1V6ZUkwWXloTjQvdXZFaHpubUdSNVpMcTJNQzJT?=
 =?utf-8?B?cDN1TTlQa1VrdUd6VHVKcSt1WlpDSFJaNU5NbmZKeHNaUWpkcUpjUGFlOVU5?=
 =?utf-8?B?UFNYdExxc2tGWnhlZzdnVjhXNU44MUw5OEI2SVRBOEJxOE9tanRQZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df44d15d-cd1f-4a48-00e7-08debaf3610d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:52:40.3730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6keTZ/XGXpUI3s0CJBNzgczfiYdtHFsY1csLJFIvJX8F1rn10Si0aHrvaTr6bPwodqWr4h9ziwwS3fgs/8ruBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7631
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

From: Peng Fan <peng.fan@nxp.com>

Convert the Layerscape PCIe endpoint driver to use device and ofnode-based
APIs instead of legacy FDT interfaces.

Replace devfdt_get_addr_index_ptr(), fdt_get_named_resource(),
fdtdec_get_bool(), and fdtdec_get_int() with their modern counterparts such
as dev_read_addr_index_ptr(), dev_read_resource_byname(),
dev_read_bool(), and dev_read_s32_default().

Also remove the dependency on gd->fdt_blob and global data access.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pcie_layerscape.h    |  3 ++-
 drivers/pci/pcie_layerscape_ep.c | 24 +++++++-----------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie_layerscape.h b/drivers/pci/pcie_layerscape.h
index d5f4930e181..e6d47241e71 100644
--- a/drivers/pci/pcie_layerscape.h
+++ b/drivers/pci/pcie_layerscape.h
@@ -10,6 +10,7 @@
 
 #include <fdtdec.h>
 #include <pci.h>
+#include <linux/ioport.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <asm/arch-fsl-layerscape/svr.h>
@@ -164,7 +165,7 @@ struct ls_pcie_rc {
 };
 
 struct ls_pcie_ep {
-	struct fdt_resource addr_res;
+	struct resource addr_res;
 	struct ls_pcie *pcie;
 	struct udevice *bus;
 	void __iomem *addr;
diff --git a/drivers/pci/pcie_layerscape_ep.c b/drivers/pci/pcie_layerscape_ep.c
index 3520488b345..b7809857565 100644
--- a/drivers/pci/pcie_layerscape_ep.c
+++ b/drivers/pci/pcie_layerscape_ep.c
@@ -7,7 +7,6 @@
 #include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/devres.h>
 #include <errno.h>
 #include <pci_ep.h>
@@ -16,8 +15,6 @@
 #include <linux/log2.h>
 #include "pcie_layerscape.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void ls_pcie_ep_enable_cfg(struct ls_pcie_ep *pcie_ep)
 {
 	struct ls_pcie *pcie = pcie_ep->pcie;
@@ -250,17 +247,15 @@ static int ls_pcie_ep_probe(struct udevice *dev)
 
 	pcie_ep->pcie = pcie;
 
-	pcie->dbi = devfdt_get_addr_index_ptr(dev, 0);
+	pcie->dbi = dev_read_addr_index_ptr(dev, 0);
 	if (!pcie->dbi)
 		return -EINVAL;
 
-	pcie->ctrl = devfdt_get_addr_index_ptr(dev, 1);
+	pcie->ctrl = dev_read_addr_index_ptr(dev, 1);
 	if (!pcie->ctrl)
 		return -EINVAL;
 
-	ret = fdt_get_named_resource(gd->fdt_blob, dev_of_offset(dev),
-				     "reg", "reg-names",
-				     "addr_space", &pcie_ep->addr_res);
+	ret = dev_read_resource_byname(dev, "addr_space", &pcie_ep->addr_res);
 	if (ret) {
 		printf("%s: resource \"addr_space\" not found\n", dev->name);
 		return ret;
@@ -273,8 +268,7 @@ static int ls_pcie_ep_probe(struct udevice *dev)
 	if (!is_serdes_configured(PCIE_SRDS_PRTCL(pcie->idx)))
 		return 0;
 
-	pcie->big_endian = fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
-					   "big-endian");
+	pcie->big_endian = dev_read_bool(dev, "big-endian");
 
 	svr = SVR_SOC_VER(get_svr());
 
@@ -294,13 +288,9 @@ static int ls_pcie_ep_probe(struct udevice *dev)
 	if (pcie->mode != PCI_HEADER_TYPE_NORMAL)
 		return 0;
 
-	pcie_ep->max_functions = fdtdec_get_int(gd->fdt_blob,
-						dev_of_offset(dev),
-						"max-functions", 1);
-	pcie_ep->num_ib_wins = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					      "num-ib-windows", 8);
-	pcie_ep->num_ob_wins = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					      "num-ob-windows", 8);
+	pcie_ep->max_functions = dev_read_s32_default(dev, "max-functions", 1);
+	pcie_ep->num_ib_wins = dev_read_s32_default(dev, "num-ib-windows", 8);
+	pcie_ep->num_ob_wins = dev_read_s32_default(dev, "num-ob-windows", 8);
 
 	printf("PCIe%u: %s %s", PCIE_SRDS_PRTCL(pcie->idx), dev->name,
 	       "Endpoint");

-- 
2.51.0

