Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4A9CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C839838CE;
	Wed, 15 Oct 2025 17:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Dq5L/m40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50679800D7; Wed, 15 Oct 2025 17:45:28 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C054836EE
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBpTs0cY5QIVO+b/wcQnlMNF9usxB4W36iIb6F0lM2UdPztBKRUqQI3zDJ2T1cyqWvk7aojiyf92vWKQ+6RfvIL3Vuy2PMHlekN9Ma4YXTdlV8DM8iOTU7F4RkXt5IiTgLle3zwKZ+RG6vzROpDebaTReJ5wayklJ/fvnOGIKOaBGJ1LnrAsqQxxBgqQ5oNmYi/+9OEfy2Ix+GnZXC2yUXjvX2DbNr5PJFi6DHUuzirV43jlHdUVlcInuHv/NOGOTFxJFZCxoXglZOCNuJdwIJQYGAVs6vQOEx/xZ4cuk4pTw+xp8uwb/sdji+qVMxzwjoMeI6y6Kq8ifV7Vw9Jjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvV1DOGLrYTMysFkhAFeuNt9WtX4uD8Al1e+q5SM9hQ=;
 b=SEuIG/DPU7si2j9IIaNgL+v2krXDqO4TasWPxGg/FTm1RNJV3QmvPvqvfZE9FPZjr4THFY/lq//t5oiyTnXoHFdHXzqfLz9j0BwMlVA/pumW3AGn7bmwG+QkqVekq8OEl6BHGE8bpbkeP6HE+dZDtqCGdGQe1sa52R8yRD0DAi1FuBgYU+I5625maQc3xbYNuc6GxlrsROk77hbaWHdFJqCZ6foaN+urDxcatmgbgHDA5Cf07qBo9FK1u9I80w99W5QJgUwYh//ESyrXMLC95J1dfPTrCYiy6TpvTe0bm3VKSWxG71Nw+FaEQrKLgJGQYyd5C3RHxRUHy9EckNE/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvV1DOGLrYTMysFkhAFeuNt9WtX4uD8Al1e+q5SM9hQ=;
 b=Dq5L/m40DwEB1iy/uZuADcFCdHkwOMVVTAej3zIhoAOQzfBhR4cUYDbBubb05/N8oTnNjsuXZz7/5Mt5rKXVoObBqCsFvXPLY4R2OFzH67wAPISIX3JQ4ga0p7gfkETmAFv7xjdlYwlEe1EGRW2FL9VgbjS55q3ax4ePmZGT7PhF4T7GB9n9wLR4b+msn3mTK1OfuXcp2igdFIShI5bgNPlH4bEzPBat8Wm8vgRsTz9sYFds12iNhQwORe9MzrHm659zpJATNM/66GxlOK0nN5tGR302VBNFJLjN5txrrye5eLDufaVP0EEc3xXSHmzD9nX0Ga43zIE0dO0IBgt52g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH2PR03MB5352.namprd03.prod.outlook.com (2603:10b6:610:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 15:45:22 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 15:45:22 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 tanmay.kathpalia@altera.com
Subject: [PATCH v2] gpio: dwapb: Enable SPL support for DWAPB GPIO driver
Date: Wed, 15 Oct 2025 08:44:45 -0700
Message-ID: <20251015154445.30336-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH2PR03MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf0fb72-ad75-4bea-0d61-08de0c01d996
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4sB6hKZVOEW6+pn3JZ311jSpriXaosGfmSIEs7XNDrrZq5lzjWS56zEtqtCw?=
 =?us-ascii?Q?t/lu0Vl5qxtYV2m3YleJxJYo0LQZJgRMsv6ZGVh/mR0HAZoVw8XclPaq6Q2w?=
 =?us-ascii?Q?Bve5jqMmduGlk4XYzloXCvV0X0Jf/zjPIaUO1DEoE/kOwyoOewppIuWkyMki?=
 =?us-ascii?Q?N0CosL/LeUwohUCMqDxEGqsiGUBayEpzpGmEt4D3vao+dPe1efMHlx134YW1?=
 =?us-ascii?Q?e7QOqQG4qBQVIofzrixoxpUwZHc3YzQLxH6RWy2X0cPQwlJsBjaUbme++Vzb?=
 =?us-ascii?Q?1h7+jybULKdvqnikbrnDVPW5KyghfLcyvu1VphmJF4D9nWNfHm36a9k/o6qp?=
 =?us-ascii?Q?CokoSiz058Mk/OWkIYUqQyxUgeCFaBk9+4/+VXc4gS+QPpg1sFT0U05txnI9?=
 =?us-ascii?Q?3AJj32MJ0JYuAzpLT9pCQaCU7W8vuuRCIzW9X7QQiIRDNkSM4Pp9j70BuAxE?=
 =?us-ascii?Q?1Cx5hAujtl/XPhft7Ksvn5J8OW/QLx+HiO7OQFLigfk8NpaU28PF33Wmt43t?=
 =?us-ascii?Q?6OKvlWFtvkbyxHkcSXlA8lOlm7Lf3L8uoNpBg/nmckQSQZ5hLu8qf8QiabQH?=
 =?us-ascii?Q?HOArWBWRrHiKzA/9m3mijy4eax3/5sCVa/oW0H82LERxvisRZB+Ao0Gauh1n?=
 =?us-ascii?Q?zmAZWK8auaPLa2okoTeh9KQSptREDuQ/jTb5Yed6ugKYG8wh+PaAo8HPNo7U?=
 =?us-ascii?Q?+n9o4Jrh46mVJKqy+HaGT2GnAcccG9HxY7cEzC/FgCou3o/pL8w2qeQgb30o?=
 =?us-ascii?Q?zl+5Jp93CCO3hMbGS8XPu1RrQC4x7sgBeLR8EtVUNANisQosg956XbbUiDbh?=
 =?us-ascii?Q?NCcHwIoggk5Kg34oRiMFeFX0EeR0zhxfg7xGMXprDcNrIvIC4+MOmIwcDky5?=
 =?us-ascii?Q?EdPph9GdHQvM4dgiLMIROvYNkK0uFJv5wfIdyAKUozCtMcMTg1ui4xJKSgBf?=
 =?us-ascii?Q?mcZhQO6EqrOr8+XtaSR1XZ38oUbjnQNfD/EoD3ijdrzYCdt7lq1Z1WBxPCHB?=
 =?us-ascii?Q?Aqtz8DqPFPkikkJPO0cRD7O4qjcA6nSrRIojz7kjykk3HxIqUeDs7WE1t+U0?=
 =?us-ascii?Q?I8Q33MFrFyDFJCjhR9i5LzZ89ekMYWhFPcsOCTJXl8jf0UVKE8alPgS1s/zm?=
 =?us-ascii?Q?CpKIKZbBuwQRulw7CiCCJsb9k+v0sJRoDNfBvxdgx2bjrqKMqEy8hPOEtGUg?=
 =?us-ascii?Q?KgkLco/o6oTD3aZZ4iWrAqBycdGpLVnIChKes9GSyFIIj6twlZ5BQPRzvTXz?=
 =?us-ascii?Q?DdTcnGkQLgImxQENiOqLz78y8jb6j6K6b8SGxJkHIXfFu7pl6+ULSak3okxP?=
 =?us-ascii?Q?zXIXObji8luqvsm9xayw0IEDXc0f9hG8ayII9ZJJLCUOOmdmL7oqbHwT+J72?=
 =?us-ascii?Q?fKEsTXgJndh6U2spn3A0oHr7HNoz+Ds/BvUSclgdStRzFkjirzCVGywANfw6?=
 =?us-ascii?Q?d8T6BqeeDFRHo2HGEIKVu/Ji7YursBze?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wr1Ga0FQ7goZ0nlT0/zkwlvg6VE1WT9fw1PlwGuLeTPrdp967wfcI8m8pD/L?=
 =?us-ascii?Q?GAC4pZ1yqVxgmnuZf70/4VYkuLq/erlohUtzv2qWeFtMs5Jbnp0oxrKRagcM?=
 =?us-ascii?Q?72s6CLuLqOs7qfQEH/yX036BKNdPu46yvHsPvb/Zj6ZAmwe0wxgk6CGcSWVc?=
 =?us-ascii?Q?kFEg05e1C7ZlZleqvowJGX2zdwKIy4jT9XqHCDiZXbwqcqK4KvfkH34CYNgK?=
 =?us-ascii?Q?pD6x3NZw5IdWS8nrQlOoAztszqVUl1Dbbblo1xlKaCX1iZ0aW69SrPXaZRqs?=
 =?us-ascii?Q?GytG5jJAq84mOdahGT87AJlZEzx2esU54JuHs12znUqFgax50HUFjeTKA1EF?=
 =?us-ascii?Q?yRuB1e8k2XmOiXsX/9a0FQY8WSHUjCgMpAX2Gax34OACmYKarRT483Vxvxmm?=
 =?us-ascii?Q?kk9oYX6GYKaPXirVL1Z0XhPI1ixPJBquO8JIFDu1z8RVSG+T/gbFhsFjYKdA?=
 =?us-ascii?Q?l6735FZhhsdd3fuyZaYJNVZr1r67MDHM1dFJxIy0cVOb4g8x3enFGgl1K37I?=
 =?us-ascii?Q?VV3fv0tBcHP6T/rQRZFp/4HKQReYXFkvZQFnIWk4LyvigfqCLkYJI0k+OXIQ?=
 =?us-ascii?Q?xHKRFhK1f0IZxrbi8tIR3Y13G7ep+rQx1jyPPArMrqfMmJlyWNAhEz8rps2R?=
 =?us-ascii?Q?AYuon58VfKxnQSYhjMWv/mVxrST2iJmOlwniLUV5Sm54ujWDJfbIakCwLRL6?=
 =?us-ascii?Q?qqt5j7XAhUUVa2dMOWuvEygZub1v+wXLHvnEvb/PnxXs0ku7mjqtfDC4e6nU?=
 =?us-ascii?Q?pofjTq7x9W2SGfe0c8CGuL9Gee5pBRYsvU7qSNNjXjHeUW6V+B/xUMjptQ4Q?=
 =?us-ascii?Q?0TY+aGweq/j4cRKGgdULvmt+NnyhP271CKRPjEc4htj1xzTZGcbwy3vipIpF?=
 =?us-ascii?Q?k6/5c2Oh1ap3stl71BQdA7LifyaCWU6ls5lFMHkHv9uAlgAi6lKGkOVIdzA9?=
 =?us-ascii?Q?1sOWkyYwo+qZHk2rG43TvOnPyTlw4cDgL2aP1UcKVUJVTtw4QgqYCuQoHAvv?=
 =?us-ascii?Q?vyE5JhVX5iG0sUrOBDYBGAS8EiT6c76iSP5yM1ySa54eUa7OtjQNVCitfbLX?=
 =?us-ascii?Q?fZ2x42gXDSfhhjv4Ebla08lJJHtph0sDE9TkWrXuYKiDeXpfVzqe28J0JOrg?=
 =?us-ascii?Q?Isx+wVpwOXv8rEPYN6gSd5l6YRwX+XefYaZ8bQrAKufNctvkaY3mcp7lsPDh?=
 =?us-ascii?Q?+fQknkX06jQY8LuUtNyzjERmeWRqRbPegBwZMwxD0i6/Plt6fRfZrj/Tra9j?=
 =?us-ascii?Q?nRRba2O245PlSTgRQS2sOEcM4fSkwt2WgemaAXz2mSEWQ6DNqv+CNMLPgFk9?=
 =?us-ascii?Q?5zSOCC5SlzdoxfhgQD/ZvL5ntSUJN8GDrVv1IEenjX1yiiwLFIdAjxby8VLt?=
 =?us-ascii?Q?zWXg4trRRieOvb98ckAeil1MXyommpfmKQR4opSZSugwVp7MNhz+CT+DqOxo?=
 =?us-ascii?Q?BB0cctsceTmVVo0iXiGxQX3AbWaPnhfwN/D8X25Yw46ZUvDwaPzq+ef1ZMVx?=
 =?us-ascii?Q?C/6Mnve8VWsrmduo9l0RNvYraJoipAIm7qWS7JhQo1dxlhUgLaLuaV8s8Ll2?=
 =?us-ascii?Q?vPv7j7CTygnoh4wSG9Z5PvSy+R2O9bhGYq1WciC6DRBirVGSjWsrNCneM+jI?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf0fb72-ad75-4bea-0d61-08de0c01d996
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:45:22.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6oU2mDeA/i+EvkY67A+dMKMQPFJjtapaDqbNpy2z1SbhxW+nlsXUrG4duKG4yCjhRojZD3Ol3Z7qU1bjN4m+XktMIm3xQsgVxHZdAzIYWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5352
X-Mailman-Approved-At: Wed, 15 Oct 2025 17:56:06 +0200
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

Add SPL_DWAPB_GPIO configuration option to enable the Designware APB
GPIO driver in SPL builds.

Changes:
- Add SPL_DWAPB_GPIO Kconfig option with SPL_DM_GPIO dependency
- Update Makefile to use CONFIG_$(PHASE_)DWAPB_GPIO pattern for
  conditional compilation in both SPL and main U-Boot builds

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Replace CONFIG_$(XPL_)DWAPB_GPIO with CONFIG_$(PHASE_)DWAPB_GPIO
  as suggested by Tom Rini

 drivers/gpio/Kconfig  | 8 ++++++++
 drivers/gpio/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index db077e472a8..00bf974c0f3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -138,6 +138,14 @@ config DWAPB_GPIO
 	help
 	  Support for the Designware APB GPIO driver.
 
+config SPL_DWAPB_GPIO
+	bool "DWAPB GPIO driver in SPL"
+	depends on SPL_DM_GPIO
+	help
+	  Support for the Designware APB GPIO driver in SPL.
+
+	  If unsure, say N.
+
 config AT91_GPIO
 	bool "AT91 PIO GPIO driver"
 	depends on ARCH_AT91
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 73c94329e36..910478c0c7a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -4,12 +4,12 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 ifndef CONFIG_XPL_BUILD
-obj-$(CONFIG_DWAPB_GPIO)	+= dwapb_gpio.o
 obj-$(CONFIG_AXP_GPIO)		+= axp_gpio.o
 obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
 endif
 obj-$(CONFIG_$(PHASE_)DM_GPIO) += gpio-uclass.o
 
+obj-$(CONFIG_$(PHASE_)DWAPB_GPIO)	+= dwapb_gpio.o
 obj-$(CONFIG_$(PHASE_)DM_PCA953X)	+= pca953x_gpio.o
 
 obj-$(CONFIG_ADI_GPIO)		+= gpio-adi-adsp.o
-- 
2.43.7

