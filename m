Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E27CD3436
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 00:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5A68490D;
	Thu,  7 May 2026 02:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="b0KoSr/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3C0849F6; Thu,  7 May 2026 02:55:56 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2869E849DF
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 02:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8vSatUGRpRzmsiy8/EZ8/SMug+TLx0LwcNvrsaq9dN9sZ8m05GmKyfvtvAQwLXwg+hDHR5DRUqetAyVYKyC8pxPBhrkAapDFToZTtpzUp2lOBjSMUeT0pSk8Lpn+wGq0vjU7xpD0dIVm4gLhQ8mdkbnmYiDH2ckkxPdz/J0zjGZ964qbz/CogyYwwROxFSqcSi5Qx4CNRgKOjKpLsX7PqAKjvht7KzU7W5SBd+GoBgVu2Ws/rxg/r3zRyUr/44cYNECqNWjdEikgf+tQF4WEudG/2DUg7PH7PnfCtYX8n0/hVHTTYctsLPQ9k7f5W1BDfarxCZfyGEWWVvqHLrjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUEgGuAw675kqV6YeZCQzEnWhFmRNuyYGRPyTxpT9uc=;
 b=hUO0lby5sWaYhNSJVrlIMkUrzjEKEWZ4jIR1ZD/Ka3pJ3pMHmqVAax60xj32QVkB0XLcFss4lwpoW8SK9IXlpbWPl8FmmcSLAZk8RVWGoE614bIFUJB1m0Pu5wObX7smvsO38chRSVlZqhJQvp+/tAZXBWE3YX0AButHOzgmsdX5IEKdfL0nDyf7GlQJyLH44FP/bU5m/U3SCyT9G4RZIfwJVIrHEANwzCVvL/BiPPT6T+ruHJQEQrgs3Vz+RZ4ytqjCeGdFTF7I+jef1MraVeg5cAqXHO7h76Y69liLUVpzkBNTinWvVFu9mgX1yad+bv91FwbaOV68cP6edFcY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUEgGuAw675kqV6YeZCQzEnWhFmRNuyYGRPyTxpT9uc=;
 b=b0KoSr/hR5H/6spXuadJncVU7f9VDhqTckBcIm8qBmgyxG7S/RyDOQnnZRMEn849lyguihq6EA3uCW0EfXahIs78otbY2I22QPU7A8FZ7KMUBLxU599K1oQYn+9af0fT+nGi3mGborfXPX7CtPQl/movw4OCfJQStNHgPIbUzvSgUxvNklDriS2YG7nnb5V6lP0pH9mV3YLl9FhM3Fbrzf6lO1Ms0Ro5HioJA5UPoUtcyOK/K5MWXdSUpxZBg6uQooOAddLiGVTVs3KtV4QPwgmHthPq5sqkJ6xOs/HWPyErbPTs9/0rs1UbDus9w2p6N87uqSOR8LsC0d7utFoJRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY1PR03MB7826.namprd03.prod.outlook.com (2603:10b6:a03:5b4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 00:55:50 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 00:55:50 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Elly Siew Chin Lim <elly.siew.chin.lim@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH] configs: socfpga_n5x: Set CONFIG_SYS_LOAD_ADDR to 0x02000000
Date: Thu,  7 May 2026 08:55:38 +0800
Message-ID: <20260507005538.7502-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY1PR03MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: eefaea54-0671-4218-1392-08deabd361aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Ete4uH4JADo/xh4hWjajHwS0tOOs/eeWGnvqaG5u5fBWkW/upUCOgqRo03IGipPvNu1F4VTEjcr7I4f6hKS15RiznrBCZqy+XhVVcBy5ZeQ1xQ5Scz9mGhwjJuFNEubjyQCGMWV9MCo5DFDu6r8NO9ZkrHEl2GSO7N47X97lfcqE9ZtW7u1DyDlrfDSDRprVvCmt9F3HujLfUuySCSHHlH+lqJifucDowCkRQfRQL1TVdmgHskN0tVBYA09YcOiEaeKK4pBJllokd1nBpIVEBN42Pv9SnUNT6j5ALcTPaM3t4t6Sp+ybEhGJfQc68L7bbksnxNwf2GYAA5wh3eV/654ick9nRsgTyNKsV4GcFe7WmGOeYeNrfWnXLB4k3gRcLA0pWXxde9aM4ewUanbyNu6uD0un++fw80iZPS/7QSvRooESne5j1IeulRbE1Mye54AiyrrnwBULebYLRY9vXBLtgiVtymfDkf8vIrg6dgngf4EUVC/bloxr/bynWEQoRoXuW4N9zJT4nruFkK2QdyqaluUewLdddNPLmzT9NKmTOaWqJNIaiBuvm98rxei9UIfu618LxZvUQJvss7fCuhiJmKmRfmZ3kkcYgtSMhfgj8Vs6l6VNc7H0ZMMVkIbuOOC+lyp2dbkpaQlh3gp1a5JLaPM0Zf8jXl8CY7j3Q+aBwlnmzS7M0eDXeP5d6twS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJdihIWUM/0/HWcbfWyK2VzrkuqZ5PrxRxbpju6O3ZCtrJCD7LMU2M3jNil+?=
 =?us-ascii?Q?uySmVTf/vTpGnFGIgvp3IBUOTsla8Edm/Algsth6jL3cmE43otd4JGhnOKX/?=
 =?us-ascii?Q?LljtKr4Zr4LeNLKCiDStVlicVvz+lQOH5yGcL5P9VN46Z884bHumt6NDl3MB?=
 =?us-ascii?Q?ozj8mJD/s30PDI5UWQ4LsUGMLTA8JAQw1ZhEi05pGkrohNMinvI4xHSbuBJO?=
 =?us-ascii?Q?rzpwwzoy8WXe/JMPA0rmzPCSxzOBfuUUvlGirOFFOioA6FB/EqyzDS05/wk1?=
 =?us-ascii?Q?K5ziiaY4YTXS+CRAHPDCNlzg//snPVaYh6ajMNy9dOf572KQFzNLf1X322df?=
 =?us-ascii?Q?8z4NTJivnzUjAOndnnfQKXLcVJ1bq35JeWdIz1rm/68kA3dMEizeHsCk1M6Q?=
 =?us-ascii?Q?y+pyand3RF0pFJTsyDVXQFbVKhpiSpgxsDqwnH99qvttrUTmZOUD1bKSVI0m?=
 =?us-ascii?Q?S+rUwctB6gTWq66RDB9YPZcBQc/xlLW306JcgLbJ+lDYZ5tdYXGLbJJLSjjS?=
 =?us-ascii?Q?P+7rBBKPkMUaUSH2vH4Lx7jivZV4S2kf+JpG/3RtwuSMWIKvUxAmMbA4SjjT?=
 =?us-ascii?Q?3uCg27fUaaznjjfMgJ90D02u5dS2lkDsdYNRNaiwm6cod/5igdonARC/HENO?=
 =?us-ascii?Q?W/debHmr6dUQrIKwXaJFu/ytBxaQunapAag0YLeH0/y8D1kAMjqjVsArLDey?=
 =?us-ascii?Q?I99bJ03ormo8krjqVgSvrjb/paveM+oYMbgXWM8zCZapK0bnAmUttoUL3VL6?=
 =?us-ascii?Q?HSV7ad1V/SHyf7Opod8yic2oN6dRAbIeRxdRBlNaz7DiN8HLSJFY52Sj7qFp?=
 =?us-ascii?Q?SCKnGGi44A62H1Qn98kS7/o0c3u0bwisqv2BmSQtXh+dQoHN26OgbL3BZQRA?=
 =?us-ascii?Q?RZ8YAprrPnOOvAGpk4QoL43SMBHq0o6Gg4j8m+Qp8VsM02qcVyEZDge+7Avd?=
 =?us-ascii?Q?2glwZldMNa3Ew8bFr+8sMTMMbEOGa6OLVNQLYEMd4HfDobmdZaS78SGjUDw3?=
 =?us-ascii?Q?GhNdgUDModm+d4UwG7Kad9eyCaZAB/5gy6F8GBCEeH1ZTBrGYtGQIRFtNvFw?=
 =?us-ascii?Q?Rxhiw1XkcIWop4Ok3cZkfJtC+APwYC+4jeUCn8T9Mw8T1jl1E/DWMi4pgbnf?=
 =?us-ascii?Q?LW4hW1rS0o+cfjcFAvvxd5hCCVfWoATuLZmFmnfPv4x/8+QFGPirjepCATQ4?=
 =?us-ascii?Q?BoD1clczXt5CoUsqvHqFvXO4Aan8eA9hPw4gK5YLAdc+dykL72dfSSeziUHE?=
 =?us-ascii?Q?bQH/0ATmJ5H6VJTzfquIAuoyZMFc8mevLjItg6Xw/rZNkODUte0K2kP9Mxb8?=
 =?us-ascii?Q?8U5dkckvKhhnubgXZkv8adYN2vjrVLmWbDYWzLdw/55KG5Ru4P6/XGKKgCIe?=
 =?us-ascii?Q?OIZ3+LdhmWe25HWcLBPy/x8PyIak21yJfzt4lm4CS67XuAPsY2E3zefz5TT3?=
 =?us-ascii?Q?ITxfNqsOuZ1lkHvhByZGAA+J9bXF2hZthKC4hIIetotE0xedsKxMecouuqjK?=
 =?us-ascii?Q?HG9wMaj24kZckD3Oydj/+y2aetM1rHCK77N2HeTXgtSwrxxsMPIL12XRLMQg?=
 =?us-ascii?Q?kjUAOa5MYznRRr+5ZDhNbQx2us3CRcgbkCK663s0rkT0crWZk9L3N4FASvho?=
 =?us-ascii?Q?xoQn19Quedxv7JzV2dsdLNn2iEIUjheZBBqTE6jBY0ZBJbl1vJ6XxRPFcF3m?=
 =?us-ascii?Q?ELeJ0XVSGQWWxH1ue541SLzha+gYJRFa5cnPTt3XzO+VnSGjmZX6AkkrpdQh?=
 =?us-ascii?Q?+KJdJH7Kg10PmynSQmapUJJ1R+EbLEo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefaea54-0671-4218-1392-08deabd361aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 00:55:50.1687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfEvT2NyCh6GzlJJBbnjcLLnww0St5jVjxAXcG9PqEfsySrJCFn3JptJcSqTnr03drkfi6AIUcCoWwvfcoQUtE0n1UurQa3AhUhhW5/ZTu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7826
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The default load address of 0x01000000 falls within the 32MB region
reserved at the start of DDR. Bump it to 0x02000000 across all the
N5X SoCDK defconfigs to match the sibling Agilex / Stratix 10 SoCDK.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_n5x_atf_defconfig | 1 +
 configs/socfpga_n5x_defconfig     | 1 +
 configs/socfpga_n5x_vab_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
index bb8f1eb7264..b8240407fde 100644
--- a/configs/socfpga_n5x_atf_defconfig
+++ b/configs/socfpga_n5x_atf_defconfig
@@ -18,6 +18,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index c9fa50b3aa9..a7ab32886b5 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -18,6 +18,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index 78fe42e107c..bcb1e510a64 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -17,6 +17,7 @@ CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
-- 
2.43.7

