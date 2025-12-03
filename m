Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D7D12D55
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66BC83F98;
	Wed,  3 Dec 2025 13:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OJpcdxY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A762483F98; Wed,  3 Dec 2025 13:22:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C937E83F9D
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg/UXQ6lcuxgXMFKSX8GaoMqaaP29lbNEEHBr0t5ysSJyCchCU3PdIfaNTfjN+hKE5t79L6n9Xm7pFpZZZqL/JPbdUs5CfiQoVUK+SgMu8G5LzRxiJW8pZpJL4NR8/R7kvbl6sWRzFwEnR76mrnb6DcxVKRnyuZCmuTNyAsg6tm9VaaVSl7lWKBNeLVI5fK6GYJFFSSWY6ed9xbRaFl4IEJsDt54lMK7OKw5T6cQ9AM+NbsR1zX8gSbBmDnAI/vvgUCtss88Xdy+KaWEg573pC6d8iyVPEiEptjHPwAv1JuPEqxan27QMh+K3qWbNnC09naMQ9Ts7RBhzWw006bngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OBbdAhahOCS+2zd2olVReStwLVmcgwTfvROq8p1Ggg=;
 b=X8GnZG1WXgQj5+fX2GQL/8lt9xBAPcVQqmnO5PYCUpfgsgDvZEkK0oLUSFEIah0nR5JkruJPcK47Ur+uvXVvNoIZfuyLMJI7vxeWU0lWKNCKJx/IbdNOSCe0V/tbOO0nlbcaZ+jU5aV6Wn6fws6CQgAxckcgodkb7uU+bQhYR2tPHNTiiahRrh98/FpIcwVA4axcRE/IY/Pa8744TbgF/1QdV8R2Qm75gIfzoQOeleNYOpzNaHK8FzpzUFwaXFQzL8P9RCw665OkU58FHhI7hok4SFR/ch3kcTBjOdMF0X9hwVnct61249+kOrbD5y5EUXh83WXf5cOr9QQQG21oLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OBbdAhahOCS+2zd2olVReStwLVmcgwTfvROq8p1Ggg=;
 b=OJpcdxY3IsKG+FvFPRh+a1JicXFvejlChKaI9/oQRRuNsC9OGnLaGKTV/PrhUkDsGqvVQYx+bEnlWY3KtGo1ZcY4KcOH8C1SaAyAYk8VvTJ9rNrsfYoY+BRlUxcPNMNVXmv7+mxxsVKZzxE5Dc5YSEFAzp/4TTHUFqUMZvl4zXfPvCePNKNkjmycJ2s1DhkfWDlOR8vsHwoUjOD/xEZ4s/b3qGh/CIsJNiSOS//XG+2jKPjARYzVwm4RNEMiBQTGw+deMmP7DuZeojOqAR5eatmJ7D4VahRpcab72dtC3I1AkOlzc+JjFhmUHs0d71eRgrDkfYVaO8H5PvT9TU9GYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:30 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:30 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 5/9] mmc: sdhci: Add SDHCI_SPEC_400, _410,
 and _420 version defines
Date: Wed,  3 Dec 2025 04:21:35 -0800
Message-Id: <eb896ddffe4ddf9c7a159b2ad2c12e71c7d7101f.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c86ead3-d049-483b-470a-08de3266a11c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lFhmvN2BEk2hTjmgbBHnK/BVrQbm8p8VkvpLqhTsSrKE8OEZsP/IaPpHL9In?=
 =?us-ascii?Q?B/hHnfoz0F9ZS7aHF5rt2dqTos6AIJ0YqXVQV1FDbYpXaFzidWejbGHa1gTV?=
 =?us-ascii?Q?mEjaRJQSzspX0RKaitDiaMlvSlZy3vrjSxfZAUQ1Aj6trJTi42Hde3fK+X3W?=
 =?us-ascii?Q?fJagcIaLuQ/zP1W9qmZwxbpNs80MkJkUp44xpRzSu5Fgou7ald95rFc1l56I?=
 =?us-ascii?Q?I3bcc/2CbTDNRJomsBT+CQcuuW2bIgy9bjFCeUGMA9i6sEWbgeN/NGLSNO/d?=
 =?us-ascii?Q?mi2qntaUmLmLXF0O3DdhF41NlXLdHexb8HVX+PODzLBVdzAcM5OyO952HW79?=
 =?us-ascii?Q?LgxoJA6/yvhaAcvuE7mJBrT+NaOSrPgU/RKKABZFgIAbahJH+rTZ70vkR/mr?=
 =?us-ascii?Q?GO03V9c+J17M3xjLVbIr+7bOwHWujF4FnhDWfXIln+kHXNWhxrsKHF/sdz9C?=
 =?us-ascii?Q?bXnByCC0uztYdKMmwzr6LYJgC8Si4lTyN70j4iqDJrUZPHVxfVCizZxP1Mru?=
 =?us-ascii?Q?EfqY6eO+xpya7+rp80RfOJMb+wbNJMcmIjghlYlxMt1koMBKJnemrUO1TkMY?=
 =?us-ascii?Q?lzXm+wJteboMcz8q/90xeu0F4DaXHv2wUMxNlkjsOmivXYIi8OSBb0nhnbPR?=
 =?us-ascii?Q?sSDLaHGyHtvLepEhQWljE03nQPXZJGqZcRy0XtWYuGk+W8fIlyOyzv3wr3jg?=
 =?us-ascii?Q?tX96uYJAUr7Rr2IzkRlkcm8Ep8qnpHyOFyb2l5JW9BRswz2TopNp3Yr9Q1Wg?=
 =?us-ascii?Q?aEw6mMpNQzadgFN7IND1RuLMQXbv9bzzqGNpddlXJRUF1VWaG0aKLtNx9HtU?=
 =?us-ascii?Q?w8DE5iqm5bQkvbHWKHihvhG6JkUTEI0U8v0ffeBTh91JLvBvbuYzML2NZGBh?=
 =?us-ascii?Q?RkuNxUP17kS8nEvvTQL/xCxyF3cwDoG1C/0AYk19A7g2P+Oz0i8kc1hg4hkO?=
 =?us-ascii?Q?RdxHebCQF28hxPoOYfBr71ppGzwCqfqiPRy6csYyW5qTt9Ap0cQ+IArvB6WR?=
 =?us-ascii?Q?EdAx3TgMFqChmeJB5jgWKr9VkRivH4ffc0Wum+zCSHvlz3ZoCS0D5ISYRoK0?=
 =?us-ascii?Q?oY0ovHYwrOnbE6tp3ViZHBJKU1hgwie/CipkHPMu5e2IqY/mFzucZ65MS4XG?=
 =?us-ascii?Q?qmIR5tc8FkDvDMv4juAAJcy9hLRURgjDaVCjYi2BuiJPC4Xjt0vYLF+K+egK?=
 =?us-ascii?Q?LsVurPmjD5yeNisYFn3g+1mGMHlpGDG2xNHfIktRX0vYsOxU/mrJnJMaxvc9?=
 =?us-ascii?Q?vf4ujB0FfOaBaPiwK8qlahuJsC/Aib07vVsowQYcfxtWcRFa6Z9sTr/MDFRa?=
 =?us-ascii?Q?WS5VNzU8l/rSxBaWgqspG4pHQJmNCu5HRgd7Po4LYkYg3FZc9LYGcTsZq9Gz?=
 =?us-ascii?Q?mkFUH9ye/ETaErabsBvgDtbjr1PBzimabeLrRCOIoIphLUt49mtP+1aabTrY?=
 =?us-ascii?Q?AcFdiWX2kpZI88+I2pmKMINnAqSrBrGT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3uFS4/Ek1ewUI/zXmu7RCgvf65ZT06Upgj+KbEXNCsvrRPsjPL/XtZcXZJ4?=
 =?us-ascii?Q?lSacI/Yxrk1GTUFf1VNEYZD1VPZzhGpkqQgMWxgUpfuDEsGq7F+CzWdTvNjf?=
 =?us-ascii?Q?UygIUS4de+2b4XRL4u9ewlAA/VmokjZXH/tiNkil3jDF99AA8rdp6C+f3rAo?=
 =?us-ascii?Q?YL1XHaJ/LN5vnm4zCZNDvcwpN8pWOlLkr9zGrrIcids4LaUj2UUDzC3H1XTd?=
 =?us-ascii?Q?vENTmBEBs648oon6jpC3J8vixy9Mxu7G4tbos/o0+4pUmPapu6iRkk5bxGD+?=
 =?us-ascii?Q?HHVhKaxHD1KFcp42jNjH/ioV+Hcc7GCaVkwF3lOpiutwvJQKRKEOvfR0Vrtq?=
 =?us-ascii?Q?iTA76+zunkTuJJ0f8pG5n1kWChDq8o48rNdg7Kn4D8QuwPJ5PK/P2qUR9vBl?=
 =?us-ascii?Q?gTxmEgqx6GHpr2vTm9551NCKf/HiAtcLd1O+tsW5aMQnslTJ/L+N3F+GrHVU?=
 =?us-ascii?Q?mLur/zPCVCFtUS5/Y2FQQ64abi4LUp6uhE9Wnv/fobPcuMwbPAJlPy8qfgIv?=
 =?us-ascii?Q?7J2/ow1ENfVGEFydBGdRKQh50qrm+NCPfR6HJLZlr9CY8PE/H5Qcv8p5IqXE?=
 =?us-ascii?Q?Yc4mQRck5Qg3VsJm/yhIGX9YuSRgrYlTaBRbsgFOCQiV2ufQsppzSDshe8zn?=
 =?us-ascii?Q?8MVMB9twFm9Ih8GfwXSAeymdHxGMxsjeRQ8i5QK5HVgwBCr3UIknmq9tYUv8?=
 =?us-ascii?Q?Uf3k26OUsnG1DjuXy+xiO6D5K2XIaZaWw+DuCLlDgNuqqyj6pwyf62QmP9IG?=
 =?us-ascii?Q?Lsb9lPx2QK9AQXaoD5mEFTCSTHQ6IwFSA4RjE3LHerbb0BCVSok59BampXVE?=
 =?us-ascii?Q?jOR1QVf6g7Gqm3nOpKYeCDv+C+YZSrmr9uGxzgwNfyt/dYbAk8EGLe32/j5c?=
 =?us-ascii?Q?5SlafQvrV0gZntf/1NqqS2QBtXrHQhkPdf/DCEhYMhl3GnkJdnjLQbtMu/Cp?=
 =?us-ascii?Q?Ovy7m0VE1udGESmBD4lQj41OtnBYZ3oXBmHf1WjIZwPKVaLlQX6NIpxpk4Uu?=
 =?us-ascii?Q?kajVWRYvSJiSFAseVGAn/CepN+z/gCUDBrIIn0wUCZybtgvkj39Xh2aokqI6?=
 =?us-ascii?Q?Tal5bqYeVMjp7vEEHV1hPVyPxRoFmTlHRQLDkCbAi+YWsVKFUX3mLCgZa1wR?=
 =?us-ascii?Q?samNxq7Og58JwDk+ZWjcFCXVxq/uthuS8es+SvgZFNYC6hBK6Z7B2SiXQEnO?=
 =?us-ascii?Q?kKSvNhot4ti6wcm6LSf0mRkXKFiUqDWMSJNMmHZXmWG6jc5ZPrlfZtMzu2Jy?=
 =?us-ascii?Q?TZtI3ct+u4oZXMYXwsc8/jTT94aWEixGVCNbX9Go11HVQRhu1j7E85c+P6w+?=
 =?us-ascii?Q?0OMQvOp6F4ooHlVpIFwaPGxJmLqotnDsQ6QvOVgk5bloqmIKVg/ffuFcaqT2?=
 =?us-ascii?Q?NTKXxGHjA0PQHgNjrx2zPNn+vSdVWbRVJByMYyR5n214YnOhgcCEWqI+be7Y?=
 =?us-ascii?Q?9AzRIeNetUQN9q6EQbc3Pr2c5JyPqOmZZEWSBzgm2vl2YRhYe6AOwIyx84ex?=
 =?us-ascii?Q?EN5AmoVtY0V4XHeJAVJQiFYMzEeFyfj9y8G+q8yC7+84+Z+lfRItyuxAPbCf?=
 =?us-ascii?Q?WVw1sADtLBsi+1nSttsup8nuVVcf71WKlr6PoaC9TsPEJZhGMvQTlNX6fNiZ?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c86ead3-d049-483b-470a-08de3266a11c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:30.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JahRuEgSAusRlHeLRy6AU+CcnbjN8Vhzs4/bxh515X8nVqQ3ugP6Gfyg7xx9zzMWWZDAWS1RvLVoSeOFP2NuirPJ++q62edFwEcVJZwtj48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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

Add SDHCI_SPEC_400, SDHCI_SPEC_410, and SDHCI_SPEC_420 macros to sdhci.h
to support newer SDHCI specification versions. These defines are required
for compatibility with controllers implementing SDHCI 4.0 and above.

Reference:
https://lore.kernel.org/all/1535617305-16952-2-git-send-email-zhang.chunyan@linaro.org/

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 include/sdhci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sdhci.h b/include/sdhci.h
index d9c0597a0c1..fb847821d58 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -223,6 +223,9 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
+#define   SDHCI_SPEC_420	5
 
 #define SDHCI_GET_VERSION(x) (x->version & SDHCI_SPEC_VER_MASK)
 
-- 
2.43.7

