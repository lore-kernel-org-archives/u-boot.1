Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1281C87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9992839A1;
	Wed,  6 Aug 2025 07:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wXDRwsN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC7283968; Wed,  6 Aug 2025 05:22:55 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685B483965
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 05:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaYhv7J+rP/8oL+ZeImR8aP4yIoG02hT+Qfg2Nh+OplfVG6K/lKFqnDYOKm62Iy6YxqB1JYhrArqj6QEO/YB+89h+QeqXpNXYU/TIiVDPzLDwKQSU+OKDIu56C277TWM5AJwC+UZQ0PkNHSBM80yjwdscwdQlUWs5JKbOPtuo62/EwLxU00B6z/1JpoS1vP1xNadae8nzmKj9mlRknXhhmWd05tC4XUDbHMkgg+xIIxAIy0a9k2zF1cnPBFGyIsXOKRpVsFmcmcmQvyJl8yYaI2nj6WIGwQdKQlYQnMatNGyrB2f3olZF2nFQu0RwTErlJZRQVBJ3gdvPGLVqizAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eP6IpjvBnfxJ5Qw6SAkWKIrPkeGDec5QNtjNt6W3CE=;
 b=N1PJV1iM86okjFfBBGDQQW0xUYtCixjDecpFN8cdCNKKpcio0r6PKEn776czyvMb6KnDjA75+ngLnkLfDz7Z2K4EC27DiGu1pYjwbPqy0Uf97pp76QvOSzS2t6OqfFM5h6hFl3NQ/BdIbfo56Zx9QBAO/R7pzkLVBo47Dp0i2XcAGzaT1ejpIZPTnMoWKzt7mLoLNVxn1RHPGOrxrHANgOEi7e8At8BwfjnNHZnuvRHLbvNDWv3iAd4ke1sbp2BZx5rb5jBgd81GTIBLbpwzrIWwUeWKLYoES6BE54+WZAxd7qjVdk9mCDAXbw7BP2J2hSRuP5vVlWGkjz8uzGLj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eP6IpjvBnfxJ5Qw6SAkWKIrPkeGDec5QNtjNt6W3CE=;
 b=wXDRwsN8pAR6L6IfgCWAY1kLA+zjXATvm87IkWoqcLr6wKjCU53qFnmAeZNnj0bJJeq0zWPR2OQHaPFkAMjG/KqUyiGXNtgo9VD+6m12Zmo00L+/Jb96k+BSKUdm4q/a0wcDEsmTAhl+NPK/uBohoecdGaKq+mZumA8OcEwOq6WGrf2W7kqtumWuX03zq2Ylz2IGDWhNjUVwyLKbUdhnFQ1ha6uoiOspJfGmy9Vnwip+xXSMf7eyFpyDlq8Pbs62otu1Ps+dNKAm9gse8ooGrA9kqfntN7gClStAnXR9t7Jd/tvOeWvGvI3H3fLwteU1tKJCqMGXTkS/2fFPFCqIVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 03:22:46 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 03:22:46 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak function
 in cache_v8
Date: Wed,  6 Aug 2025 11:22:05 +0800
Message-Id: <20250806032206.16688-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806032206.16688-1-boon.khai.ng@altera.com>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 135ea120-0471-40a2-9fdf-08ddd4988393
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HeQYJcOEiyugZvqvT302fbra8TIHxFkB3GNx9llgWgi7yTMMjfVHUihd7g6Q?=
 =?us-ascii?Q?XYlI6mzhezN+bYykZVRKhRkXZ+Wg2FG6MiD2us0/xd+I3Ktdj18XyAMBUZAL?=
 =?us-ascii?Q?v/4Q3Dco29q9tlPu3I9uBNRYjJiTctGI2WloOl7MEva65Qs6FJDKzcBkM71z?=
 =?us-ascii?Q?2vKfcWRB/egEZ+wE8GPNmHUaaILqKAFV3Q16f9Kb/M/Rd7Jgo90P75VraePT?=
 =?us-ascii?Q?/UGNWnNQVYsY0gNY/boUZQMfX+yrM0FCSkTVZiy7WhWdCcLsLNFldmCxE0w5?=
 =?us-ascii?Q?ZfrRD28GWWuMfz2PaiwHkL6D4XZr1IIYg5/yyioE9lqoW3VzSM1ulcd/z/U5?=
 =?us-ascii?Q?eo4845dHJli6VdtAMtHuK+NUEqZh8QecVS9aplcxE2OKJuKGOqaaVLjuRcMs?=
 =?us-ascii?Q?Zoi3s4gxVYqMC0Qst9mq/um1vM+fkm8WDm62qZlbgVYL/um3TJ9GzkPkOf4w?=
 =?us-ascii?Q?BNB4crRXzmNb03tQ2IoYXua6kw/iqDP2y0eKYrr1Vto+wwKJM0XuDDnD9sLd?=
 =?us-ascii?Q?ijYll+3tKX3xIZ+p+XZuTVYI+tF1mzrTtUrVXNtG7MxZ+cai6ruI0e1nyr6G?=
 =?us-ascii?Q?qBxY6X4ulTWcwH/2mk4M8pzw4ryxrteeBW7qeaFuV4ibZglFQ0W7D++aAZie?=
 =?us-ascii?Q?6Ei2d1fbljxO7twnQ4sS0XPT2XHW/JTW9MTf8MUdb3tg8c/Zexw0T5vE063H?=
 =?us-ascii?Q?4R0i6OqcwohCeyrZovglt9i7hngpeG7VIYDJKDixQbjUo/6VlMjDL3K6XbSl?=
 =?us-ascii?Q?E7cIbubPRp4RIT3SUFUFC5X/0VdFv7ydzejSNJgrfICa/vXdwLtZiyzYnO2V?=
 =?us-ascii?Q?WWPU5Wy8JTQkczFIxsPejuJ6v3blKUHscWTkknnypYoM/Lvixe7HmrdvGGE8?=
 =?us-ascii?Q?xfh2XmxH161HMu8HF8A+gadWQHSEk7GP2W88+NGaqgrpDPWY1AbYk+siEWXY?=
 =?us-ascii?Q?i0FziyExyH2YTEdEIou7TK40kxQY1BdqFDX/SJVCfhrE8elnatQivEkx8YHw?=
 =?us-ascii?Q?bRzRKvDRtRrpOFEyCRLjpgeiFEAioG4Dj9a/MbfLqeLqzdT7PwgnYA4NzsdZ?=
 =?us-ascii?Q?p6lrlpNsQYY2iX5X4JQVjM26/qJdjaEMVmAbQw7bsNgdXyQlrQdxkYcf5Cyf?=
 =?us-ascii?Q?40YXPnjJ/s1CrCk8rko+RJr6hUQgFhH5ArNj+hBQjJAY9N3FUP6jTSCYzAmb?=
 =?us-ascii?Q?SbilYXVA31xkiU4+GofgjT9LK9kPZpeIr95ANQWYseBF2LMQGg7aNFAo0MGa?=
 =?us-ascii?Q?GtchNCVhEtgXvzgDvVjmcAUOkjA6hLt8aeXAWpzAH4uscnYPi3L5MC55MYp9?=
 =?us-ascii?Q?Z2mFYhx9tvKEsQiT6ABhfEJfrFwZiLiVACEo/iEH6VYlny/4uVeBUEyfBA5n?=
 =?us-ascii?Q?Y0eQ/zFxuxEH5qo5+1khbnrgBp8xlxsqKSja39/SlR91eqvKFI8eZsZ/pNk2?=
 =?us-ascii?Q?lt79vUEPnqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/XFema0goTCYx4XsST3Cm9uEO/7QkB1GzFa46MIS2P2nmwMmQVbPoPcmL3q?=
 =?us-ascii?Q?fJqIC180wJuoZap3Qi2uGy405NzCPCBOiz/FEdn3icXK++8zJGnSCRfJmPjn?=
 =?us-ascii?Q?sufSyF7KS8YZzmmeDyGkJEcx2U/bG/DC8gjfdfnxgpOavwgsjEtOH2pYscis?=
 =?us-ascii?Q?kxqqnL9iWXroupNlOkNAn/351aQ0+LH0+raMufZxCJaFFaWqa8gijfSJeL5i?=
 =?us-ascii?Q?lPVpCVaVNqmwzrfA7VgZwVn6NbRXLFCWEDx5GI+wjvfPsGhk/IDhlGipRC67?=
 =?us-ascii?Q?AOvH95f6fLkaZiMr2xnbxdvW6jgJh8fTFHQTrzgkx1e8tiKdoxpsaUrsbVuM?=
 =?us-ascii?Q?rWWXTjlHWe5lJjMC25iXWw4eZVbucXlG5GoAGngchaDhEEt9uNYAiJ1PF8JI?=
 =?us-ascii?Q?ClvXDwuLi2a6FKBug5OZ1iYJpP4OhUI2RCyixA3tlFpctiZARUT6AbTmkSiq?=
 =?us-ascii?Q?LO/znh+x4jRkpBQoGUD/k9lO1BbEQ1SBkNB8tgSnoSRSgZkzpVSYqHV2lrAz?=
 =?us-ascii?Q?WTDH/8WfvtFd3DcwJOH6GIlouqILBs/tNDeOx2hds+jp7r7yI8sEJTiWKy5f?=
 =?us-ascii?Q?kpFSIKmRjo/YcSCn4t+WVDxo67GfPVAM6N0BqFtb3KM0n16LEzAqdsNuKpJE?=
 =?us-ascii?Q?ZCHkWmsNCMi1T/VPg9FxXmoBNGVpWc5FkY6AtIbs2rlwlD/tZIaC2Vqbt1KJ?=
 =?us-ascii?Q?6tSvom5VqVwXINqaLmmo1pwpJ95lhBpeMo76Udwo2f1eAje0E+JfBxobGGNP?=
 =?us-ascii?Q?qoV9XgUH6s1+556U2f9diJ+j92NQS6wdyVwDdHDgxTrjoknM124dZeKtJ2YL?=
 =?us-ascii?Q?nWmOLQ4ISbrlQ2RpnUDtlDFtkBIbmCCGnofu9TdDCmWP+VsUjD+A5wuUGLSG?=
 =?us-ascii?Q?3RAmJ+GD74gSspurAIWgChlJSSjq8RGUU+RsDmm31hg3DV504qjvZoyzCUi3?=
 =?us-ascii?Q?aRseVxMGAf9f3gfdUqCwtggM24I2xQmyEWVSJAYjIqJmuEuEWsO7AeyM86R/?=
 =?us-ascii?Q?Y6lU+mJXoQ++KCBAImVUDbXKljLxsKjTqSUmHzwu4EIiFOXUB0yCv6Ml+2Ws?=
 =?us-ascii?Q?BBkzz3viFdlp1fGpL2UF/0Vzrm/+omtd6WuKKF0f9RJ8MT3ZjCGO1JMp6PLg?=
 =?us-ascii?Q?GEZNTYeIr8ij+rCkU/BvQ1xrSWLzDyil8+4gsSCy3+QiF6rUwtx5tv5t82GF?=
 =?us-ascii?Q?gcxU7henIqUqnod/sXr7cAGVDKgH27GlEe/uGRDYMGj0EBV+m/IFeWoYWxi7?=
 =?us-ascii?Q?AGEVAJYEm41TBBwc5G3cOSWJPUGAZYvD+TLp65hlcGLrLXUrkkIHXpH06bGL?=
 =?us-ascii?Q?Bf9bH7mX3bnkK5M4AClx+I/zTUtA/lOt0wpUOIMePECXgoFJ4U3VwNjN4YF3?=
 =?us-ascii?Q?zfZeBvdjOI/WlHDeH09stTA95E3u+WY+jLIQME6WRpL69NgNeuxRNn6czHUo?=
 =?us-ascii?Q?5qUNRToz0o3kyGNnHmHw9jv2brZr7CLVS5/Aqi+BC0lhPs0vGEBchDj75s2D?=
 =?us-ascii?Q?fYv/EUT9KR7nsqw43zNjW9m34yDonLJT/rra/n/QzoUjANxwjB7N8kQEv+M7?=
 =?us-ascii?Q?pOUYccQUAoR702OI2BtoglOx0fpJ/h/qbIR5RC+3?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135ea120-0471-40a2-9fdf-08ddd4988393
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:22:46.7215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RCKgt+ctlkib99hHcFeA5LyRNgq1NO+7y9ZTzPkDV+5lsmjtjuE78CoTO714/D9Z4avtAblzSzRsKeagZVNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Add weak function dcache_disable for undefined symbol error
when dcache for SPL is not enabled. The dcache_disable function
is being called from spl_atf.c file

Add weak function dcache_status for undefined symbol error
when dcache for SPL is not enabled. The dcache_status function
is being called from common/memsize.c file "get_ram_size"
function, which in-turn was called from "sdram_size_check"
function defined in sdram_soc64.c file

Add weak function mmu_status for undefined symbol error
when dcache for SPL is not enabled. The mmu_status function
is being called from arch/arm/include/asm/io.h file "__memcpy_fromio"
and "__memcpy_toio "functions, which in-turn was called from
"cadence_qspi_apb_write_execute" and "cadence_qspi_apb_read_execute"
functions defined in cadence_qspi_apb.c file

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/lib/cache.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index ed6f15cb570..4762d84967c 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -42,6 +42,17 @@ __weak void enable_caches(void)
 	puts("WARNING: Caches not enabled\n");
 }
 
+__weak void dcache_disable(void)
+{
+	puts("WARNING: Data cache not enabled\n");
+}
+
+__weak int dcache_status(void)
+{
+	debug("WARNING: Data cache not enabled\n");
+	return 0;
+}
+
 __weak void invalidate_dcache_range(unsigned long start, unsigned long stop)
 {
 	/* An empty stub, real implementation should be in platform code */
@@ -51,6 +62,12 @@ __weak void flush_dcache_range(unsigned long start, unsigned long stop)
 	/* An empty stub, real implementation should be in platform code */
 }
 
+__weak int mmu_status(void)
+{
+	puts("WARNING: MMU not enabled\n");
+	return 0;
+}
+
 int check_cache_range(unsigned long start, unsigned long stop)
 {
 	int ok = 1;
-- 
2.35.3

