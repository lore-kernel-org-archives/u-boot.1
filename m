Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBBBC369D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB4F681F0D;
	Mon, 21 Apr 2025 18:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AKsEqWaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB075805D7; Mon, 21 Apr 2025 07:13:34 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661318006D
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 07:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOewn4inYSqYEHSmBhPc5cYg0e00a8FvBZo8uluZ6l2k7ljDCumc9cyHzU8smepnjfTnzqzumEbGcLhCKavHh1F1jGzW+c610yXybzEHlxq/WHZGr1EK2n96eZC4aTGJDnckgA5OMDT/VfpaI4iKebDOm5YZITUBK696CurSWovim56TYNAUlm3wNSOdvSIY93mUCu3NBlL/jKkL2RWVcZSs9Y4yyFBbh8EU5j0fL/BqV9IwI0VH4XsjUpz+/QnIr6j5D2tqY9+8MXpp7OlB+R61riIJNnTNmlAV416d3NkscnU/g8U7BaQtqXfJrxiqCFL8M+Jf3OD4c1lPXrMS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nFM/9BF/RW0R83JkQYa4Brj2Gn3FkRVY6w64iegiwU=;
 b=ZYoPRhQHZm7U1foVPGYyoIWnSJCPkWK95U3dJb3/1wapj5l9vAAddcOKM/+jp8WH3WedGPrP6U4h5TitmO1KcS9+NKzP6gekoG2tsMwvAbbKsM/e3xH1MAY6VYNWLX79RNnYyzAOiCKhLLkgknK2EXPhC9LWRwrxUIs2aV+Pc98Sh35KVUFsdpsTqGSo/ZRBYmmVOSUbnxiP9i7f/HQTZs/HTWzSt1GGK3JtaWG7DtiPim/RhNjMIBOqCyrCvlwROFeaPwrSaao4VRhy5wmgsId6r5VGNlZqNcOqa1+u5kT50+DFIil3Oiz5rhfEnx4oB3JD3ncqrZn+P47jRc0eeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nFM/9BF/RW0R83JkQYa4Brj2Gn3FkRVY6w64iegiwU=;
 b=AKsEqWaqHPwntScKU82+BIkjoe+BcIzm+6eVb5d3UcHAFXYGgso57zoFLstoai0t864XPTXMK2mRk94UftOlz+u0VLlQiMQu/Kajz0l+OcDua6MIJ/h1TBw/MuVIttQrFWi3kjcsNRCj2dOxBkyxKXwJlukPljOmkRYDA0jfBypOF0ShJHa8z4P6XRrCyF3o8rXA9yY0ghq5ogOw9QdQA8PBI1cVqkjGTKbi/nXxy3a94RqUuAI0Q0vXO49cjTm80jJ5dnTtUTx3vxCzyGgGwYk74NbBF/RNuiejieSKsS45ioyssuYaHX5Y9mYRoLAUvBRPXg439koJUNsobqSt9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 05:13:29 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:13:29 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 2/5] arm: socfpga: socfpga_soc64: Enable LMB_ARCH_MEM_MAP
Date: Sun, 20 Apr 2025 22:12:45 -0700
Message-Id: <20250421051245.21385-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|SA1PR03MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cdb2d1-9f54-4fe5-7249-08dd80934108
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dePdgG1WQGIfLkRk3T8uemy0u7MRzK/x77gYfKSHGhBpi5pGE3uS45AU5vg8?=
 =?us-ascii?Q?FT5yn1tUatLP0XA8IxnnewCOE4RrtYD0RC1JR8UygRohVeuKBDrAwKL0g9Yb?=
 =?us-ascii?Q?DcmxkGc0TvXODBm73JQlJE5CTmX7kdv+UlzzpC2ylf+NGBnbBITOnxVAKBqp?=
 =?us-ascii?Q?Qwk09n49nrmQdXQbkfRezcAHWUGwrpWcJf+v/hSxQ719ZLPsBIMkq67R7o5J?=
 =?us-ascii?Q?Ln3F+z2DMJFsxXCl7dou4aKrfwAwl3HT8ITVNn6lbCYJVWHd/2TDTe7+vMRU?=
 =?us-ascii?Q?7+9IBcozGo82wlm9uU9Ronvq4Pcc/PDU19VdexOxXlOpQM5q3kUemSi39GnN?=
 =?us-ascii?Q?d20E5IPhKrqtnta3bnNSlcEwj8yYY7qMgw/VtUg1NSSgDRWcfTaUZyj0Mlu/?=
 =?us-ascii?Q?wTof+S5jzGvt+cfxsJdYyapUuEaDRDr527DUNVVpdK3KmzkuKALSQlRKpiVJ?=
 =?us-ascii?Q?XWTlnyE7cMpuNk71eCtRPLAEKtZRjkBy93A0cQam9INDDjT1GAceH2iJiJNj?=
 =?us-ascii?Q?fXNQ1w7fNP3K6tYunuMxX0ZdCQJI0pdMeuNXzQAiSvsPcQbcDptTz7bzOmym?=
 =?us-ascii?Q?NWnlIAnrGhkzOW5RiJJG6m7CkVOgFIXCWdFWjDBX/XV6gDiDiQuS3bCdt1+n?=
 =?us-ascii?Q?mLcOm7OIj7yNDHWcNc646bVtovpvP1CJfjU6SJIctJO6Ug73+leXjNRfH8xK?=
 =?us-ascii?Q?IoG0KNko4dZAbn30K/dclusc5Qo2At7jrY4W98kUc1Nw89OpcQpreYFEj6q+?=
 =?us-ascii?Q?UhmWrbNfXmQS8mmksa0Mr+wpGU3zOQkmk2e4/AR0hp6JNaNJZsFeadSBMXtr?=
 =?us-ascii?Q?KeQcvnwzIUuVLUJpTBFiRBzIwHPuTgV/lpGTqcCHkBAyx9Tmxsz02lMKjZwJ?=
 =?us-ascii?Q?+yokmO957Nd68mKIBwwX4H2dyzHnX2jyhkekyWoA6WUp8CHqsHWhyj1nPJPT?=
 =?us-ascii?Q?cJkI1si598ASmSrsjcPAEWDAofAriSmxgjLJ79qVCxZ7G5fHcRLdqMe2hMCa?=
 =?us-ascii?Q?PSfep/V//SGxi8J7AHrfg0nC+P4BYIevUa9o69dcHwHm2T1YgFTQPHkZbTYj?=
 =?us-ascii?Q?raXI5nUIkE4kLKZDBuiisqLATcfn4k42nsuRgek1xJcA0xA3qtlVOZA78cN8?=
 =?us-ascii?Q?DGHDuGgd4XdbQtoVSdwtrMxNO+3ABjTvWUPWRi7sx58VzlDSoeKZYkiqlJmb?=
 =?us-ascii?Q?Go3I75Kj8ZwH4qNMlr+OO64hSnivxXdBNnxXro7z31UR5Cb62ojMhNACTE3s?=
 =?us-ascii?Q?2DkTg8wSBXfPR3zBQ4EW3twaLtJt4keTNRcKyA/8TDUUV8oI2RCEO6v+QqdJ?=
 =?us-ascii?Q?j1ADWpe3e8tyjeDJf6e/mmT4y8Nn2haRANHbwPOVlTYfT1ke2h3oMHniGRBp?=
 =?us-ascii?Q?Zp/4qN9VQLqfP54UEgJklbB+jCTb1X1babx9i/mPS7Ozegax60BmIqf+T/K+?=
 =?us-ascii?Q?V2i8SgYz+1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qn3f30DACdYtgi2Re0Ad92/ynaZlZ6PRAsni4N1CsurzzHBHonLa+Ol0W61d?=
 =?us-ascii?Q?BquJXV/ZgRzplX/6On02H/+oLopeZaWH1Bm6Jla8LTMevyVBAU306yvfZ4y0?=
 =?us-ascii?Q?uPKo6llmscQvekIXJqN7FMgbc1ckiujDBuxStgxkQgOcdWZlTYdS3jgg2xcr?=
 =?us-ascii?Q?HztOlaImmrAsU+X/g6/fhXx5mcmsUaQmKq7YiB2pnv3iCOj82nTdManRCFkN?=
 =?us-ascii?Q?1PmkxYLyY0xqW14wJ8HXJcHfARP623V3rQzSul0v0Vs/q1WemR9OrQE/zuN9?=
 =?us-ascii?Q?hhpoI/FcEKYm18fmuX+TvJKE/208SM8nQRFDhbwKNoGVCzRnSp4tuNt1Uab0?=
 =?us-ascii?Q?t/gCv5Dgw1GfZLUFpAubeYaxxbzxEOa84tA90jAIUNdbvTIrPlQsH+k/VCFh?=
 =?us-ascii?Q?spkqjy625dxf/yvZJKfjDFXaRkXSQ+jo7icQgRHWwvG3oUViU+0QZioo6MmN?=
 =?us-ascii?Q?e6UBv5sb3LaMNZFFzXZW2TmzUiMLFhrHD69ZKvoCQiBloGFcno8nkpIKF2cu?=
 =?us-ascii?Q?p1h18LYPVPloaDbTSGtH895CoKkGtHDn9IRpOyspPmTfWh2DZLXzdUWJgNCk?=
 =?us-ascii?Q?p0Uzv+7SxO5aihUlXzevziij5TozDmWr0PLWYcvE7y3QCpBKNXhgVHG5Ngah?=
 =?us-ascii?Q?GQvp9Vu77Pzvy8vT52jsJ3zSjB07Bi6+rGcM1I9wLgrZqyZqkS/KyG+IQ18a?=
 =?us-ascii?Q?su7pWRbHjq8Ry8SHdxJ+o9/PWdNAml/xGChzsO6CxnSM4cXNGKTJt0n8at+F?=
 =?us-ascii?Q?66IzdOelj+u1wiOpTL1hpOUani75jMQXjvP+CrsuepvOfFZ+u4Ca7jFLTwa0?=
 =?us-ascii?Q?R9iTjiUBfBwpKd9LztRUw3khsXE44YZ6KFa5M0bInamyKvkqqu4SJFFbrsdd?=
 =?us-ascii?Q?AUaXwafiGqAr0GXn9c8EKeuZAGVWb+Dz6TaS8xw8rn2JjzebRvu3MY/PTJLd?=
 =?us-ascii?Q?21vxO1pcAxbrpGcBuDFSwafUj2GQljDu5hkFzSlZpjEqxZqGD32d2GYCZSek?=
 =?us-ascii?Q?xgzS12XQn8IJiy7Vyt1FvJW9imOP8cj+vmMNyAMFbmU8c19F1QrPb39uNOvc?=
 =?us-ascii?Q?uLB/g0AdU3vC5YkFsgPayEmCp1Xxl8j9uXY8HCi9xXYh+p1Czr9VBA1yIJTP?=
 =?us-ascii?Q?bjRgn8BKceyJmru/nAG5yFL0Es6CpChiLFd7xdDEYEmu9SJ9ZOOvPeYgXQfO?=
 =?us-ascii?Q?7UBiJPMWLohA9+6YOUOZx2nNZY1z3ggmZ/uici6g+CgtkL1QqY4UFKqPN/BX?=
 =?us-ascii?Q?UahWiTNv8IdDBPhss9jpLrVNUluFh73X7HqVq6l+PTWKgmZvHwQ2sc4BYsDq?=
 =?us-ascii?Q?PCqN+t3bm9rtmJh5Bb7qT53OPsuBF/fKowKpg03b5usIVCfHzklruELkdYZ0?=
 =?us-ascii?Q?ZBbh1jjLZlGOaFmkxM2Yjfz6s0L+0kAE2jhaXmc2ZHFpf3n/ib2lObT4bbBH?=
 =?us-ascii?Q?r0zZE59Ix2X/k8nV7bKwS2qhSqvvFVu8lqBG9KW6i/2C1E31HiLl7GJv2thz?=
 =?us-ascii?Q?syluI4L7ac3qv27Kqa0+sKb9Mlj6Ir2rFxMKpsziQkfuxF7GVWBQpkH+DdFZ?=
 =?us-ascii?Q?zctafy2+84OLEdK27lTSwz3smIkuOZWMVwSleY72PvRoUAbATO/zB9IVFFMj?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cdb2d1-9f54-4fe5-7249-08dd80934108
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:13:29.7980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCWa2POCm91tHaDTF/741yBq/3feyMhXz8A2zGGb2q3vi2SiFr8T4GynK6GB45kiieIUIk3J2Fub2QOgiQuCCeNeEOQGaTWHjmvIJ0m4ab0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

LMB_ARCH_MEM_MAP is enabled, and lmb_arch_add_memory() is introduced to
correctly handle memory reservations for the second and third DDR
memory banks.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/mach-socfpga/board.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 83f6cb6edcc..df373d38a55 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1138,6 +1138,7 @@ config ARCH_SOCFPGA
 	select DM_SERIAL
 	select GPIO_EXTRA_HEADER
 	select ENABLE_ARM_SOC_BOOT0_HOOK if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
+	select LMB_ARCH_MEM_MAP if TARGET_SOCFPGA_SOC64
 	select OF_CONTROL
 	select SPL_DM_RESET if DM_RESET
 	select SPL_DM_SERIAL
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 27072e53135..8506d510413 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -195,3 +195,16 @@ void board_prep_linux(struct bootm_headers *images)
 	}
 }
 #endif
+
+#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
+void lmb_arch_add_memory(void)
+{
+	int i;
+	struct bd_info *bd = gd->bd;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (bd->bi_dram[i].size)
+			lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
+	}
+}
+#endif
-- 
2.25.1

