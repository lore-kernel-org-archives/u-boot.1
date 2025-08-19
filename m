Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061B4CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CAC81D6A;
	Tue, 19 Aug 2025 06:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OmfO0bkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D428206E; Tue, 19 Aug 2025 06:53:12 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A358A80B9B
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8+MS2P0WsA2SRn4vZHxOH/LAJoTIxFH+mi1dowtax2HtY3SamNd5O4JOC7w0o/PMXQcMHTpan2BbmHibZInCddZ4sQN/tU1TqXhaWm8vEJ6i6jjitiqmLT4IC4ZDLLDeDWOQy+KNyAdpq3ZAC4aOXXOu19ofYXjCjmIDR22Z8Vu95Z2pIcTgW2eQMz+B8tQJovE6vlCs8ss2QGKYtwOriZK7/ZprQ90oz5JckZzVijNC577kd5v1DXEbs36/Az4XkCUddtqfJspAEUItfedr/gOtGirdfjMx8x+j74dK86ZnarH/EEL3RNOeomritg1oPcVIHJow+mSO6dRi6yzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REl4W51vK9jPxHS9+R8Var2i7q+JtnOto/6IpSYB6Lo=;
 b=tgQIChENFyXpDN8AmHa4U5KvwUMCSG4K3KJQUvgrOiVbdoN3NCk2palHe2URQmfedxj9vPeTJFUgCmThFzB39XKN94LQIH/IoyMqlnMm4lzyTkBWpZ6zIMJ+R3uRAQcdV///Uu71yPDs3PuVgBhhE1oRBN58piy5IpQd9a9/MB/ZAht5OsUTIYV9SO9oBr+xobNz3vV9eKEVomQTNAxegF0vRsejgxJyOcfFLr0ahT/pw9q8OMUgFlOT5AjbkubokWe67ZdfhK4qT+cPL0FpdGzLkon5TwQHm1MQREPXxs24x+d4M3v6WitqSUKV36lt4KytYT9sHaQWYn+vP7NI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REl4W51vK9jPxHS9+R8Var2i7q+JtnOto/6IpSYB6Lo=;
 b=OmfO0bktR7cE57Mx4SAO/ujWLVAc4N+KvQYoa/vA5oeGnZL8OYqt95T+h86nJCwtGuy5ZC0LM9cLOQpGK5aadyNG6WHnSTUAC+1skZ0IiqviCkoq2asCtlHx1e42+RwduJoSjwqCfPCnFaEpxVdMS9Hdxqx8vTqZBaRDD0poTMPTxOe+7bFIQkyAczAeS2rUBlzL+6W9qAlNNAK+QPIkzgirbESIuRVPAlIcpuqg8m7RxUV+pN79xlktefBEB2A6uQSdy36pSzDQaLn2Fsz6+9iyfCq8Va12iKUhAhZWvqJH5UVYg5EXztdhVGEZL05TM0ggm0sJ06N1L9is5jgWBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA6PR03MB8000.namprd03.prod.outlook.com (2603:10b6:806:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:53:08 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:53:08 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 3/4] drivers: fpga: Check bitstream address doesn't exceed
 512MB
Date: Mon, 18 Aug 2025 21:52:36 -0700
Message-Id: <20250819045237.18142-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
References: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA6PR03MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea33b3d-5f48-45bc-daf7-08dddedc4ad4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RjYxaF32YBADCqC447II/ULM6WminINUUnEfdxQleHvTwk6pxS6+KZxJLrKt?=
 =?us-ascii?Q?hPPxOj90IdBbwJDI3YZ4cZN7uibcVU5b3iFKXmS9NQzmsWzrJfnJZpk9H1Af?=
 =?us-ascii?Q?01sJ/iHjnW2+AemKRn8kzFQBmKkGjC3xeURV66tXN8zlIdMubb+CxSeIy26e?=
 =?us-ascii?Q?C6bd8F7xj1Cn+hK5OxPJLs6O2A2L5mmH0VZY8hbn/YRsvAvJezq37RU+G8E5?=
 =?us-ascii?Q?xJf7zVw1rM7W+gOK43FYlXufPdvDM6QmaEN2ggdgVk6mN75+a8aHRaxWxBy4?=
 =?us-ascii?Q?rbuHH9QYN/5jRGWgLjpNSQCDXGnNh5bv8Q/EAvDIt0D5HiLUqJuyDy/wP64P?=
 =?us-ascii?Q?YOD8AOpDadhJGquHpuHdQDa/qYUN/crFKAYO2KI3RBgjb4itZHEbYCsqLy+4?=
 =?us-ascii?Q?sGDqebgt6vy/X0f6ZVSN6X/4emLkVa9ybS72ptHzgLYPd8Btf0H+/E0OAME7?=
 =?us-ascii?Q?Yb0cvHjiQL1d2ppJS2ftF2eIPIvf88VGbL/PrTq72osgcG44LQNdDbqyajq2?=
 =?us-ascii?Q?2Op+92vZljtmesQ2riEtmbJxohZ1SjJBgdse5NwY3ZeoSiGKXcjn/mihqhv5?=
 =?us-ascii?Q?9ZcBcwYu0yR7e1DwNxZXZQC+nkAqP9XZcW9sfG2aReEu9t/PwZB29PawabkY?=
 =?us-ascii?Q?yB/UspF8rUK9xfU493671GOUF8HtF8P451QaFeNDQiPjVZbR3SD1I4MtHM7g?=
 =?us-ascii?Q?eN9b/o325GZpGBPE0miBVo/DirF0Ku70K3D07qAIX0Xp2Gzd/8LtieaujoYg?=
 =?us-ascii?Q?bXa94pWDCXq1fPMgyOSOz7RqRAbHOrNcvsE5flHGRPkqUKCt/CG164n854+j?=
 =?us-ascii?Q?4CI7uxCvCIpzEWNyZ050zfYLRk3krnv7OyHNj6XY0B65hD7dfrFZ8iZiCE6R?=
 =?us-ascii?Q?YzCnJGYRB2jd8aC9VWf+dDBnHsdDc2PiE38L+7fl9+rpn2uq+jI/JMoSaTW0?=
 =?us-ascii?Q?4zlK/lk9wLaL6hYGKtVcSBIgNNWHqZgh16zrkARkVh+i80ox69BhuAz1n60f?=
 =?us-ascii?Q?3VgdnyU3KEXDLH3kA5rJwKPV8IZkdTY3eoGsS1V1uZJVpiihtygDwbZsFs5p?=
 =?us-ascii?Q?kA/p7BcpywtU40Cn0dBdrjBhovTq5pPk2gZvM9FjLRv8a7J6eP8C6sxMPC3O?=
 =?us-ascii?Q?THFrlKONugxS0EOeM08WkqqHcsd0EW4M/t+xzOyK+69yyLtxxU7/jmYjwoIF?=
 =?us-ascii?Q?R1eaFcP93UEAx+JMUtkxHX8wYdKsTDM64CpvmaJmn9zHdhImBTgmwHWm05VW?=
 =?us-ascii?Q?DHobHnHzzowf38gp+z24Kl8nfbRPMRQQcH35kyln2z+ET41IkdLxkTC20PuE?=
 =?us-ascii?Q?F0s5hXWYK6+3GagNwhIQtoo0fz0hOssO+IBFbLjERMk3xSelQKv6bPghrp0d?=
 =?us-ascii?Q?pReDDv9HZgk1GeAijhfkeUedur1f1e7h+xtGUpuLnGgEK9yrS0EJMjjhzjyo?=
 =?us-ascii?Q?UskdfU2KqE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GcptnTVPY+FeFu4yVGtqg64QZDZI+QaWPXojgzyS757ae4HJubwVavRpqLx/?=
 =?us-ascii?Q?/j2WyJlxWKIpo/HrenlYqS5WZ0FyH2q0ivqJ4kzHWCa7WB5D4tNC43Lhf7KJ?=
 =?us-ascii?Q?SQ9zjXo+i2ROkx79ijwBLnPkruEgIZ54VJ+Q5U2Vz9J57vy++S6JiKdAz1SX?=
 =?us-ascii?Q?L+JMED2s7/5q63JgFxdapgWBVTaETRkiQykv71tnfZ1jz8OSpuA1c9YhENgg?=
 =?us-ascii?Q?Zd+a55x8dLDSr47VknKeVJULwpqkbvrg1fXYzDWUBo5qxeUijhi/IjgQkDtb?=
 =?us-ascii?Q?Ek/ctfzVmxG97ndgH+h1JrW9mAWZ03R+JUnWh28ZIcBhdM7sgtPK7vG6s+gv?=
 =?us-ascii?Q?Mgk7xN5unQj5GHA/8gERy/wkapY7SaHBRtbHfH1Y3eor2+jWd/7Pm6d/GBez?=
 =?us-ascii?Q?Br1QuTkgyZGlRAhIrocsQhGLDjmyOfN9J7fQ5TqSu5SYBH8bth5UtW/VP97m?=
 =?us-ascii?Q?bLmpKZ4VjnuymmYgTIR51yp6I0DhEDaDGttoQUirShtDi6rergRKscEXVb83?=
 =?us-ascii?Q?/lET3Wbw5wZyENmTN13PPsfoGPZl5lvPXMc7xL2cP9biQrsyI0s2BtvyLhzS?=
 =?us-ascii?Q?xHYbKeBrRD1xgdPCyi7ViM06PAQG7m0DZR2klln7PORxINCVC8FRCDo1+jg6?=
 =?us-ascii?Q?ZZwlWuDgSE47N205HafgY26nokrw6QZBxe219TY1PmHZpkfpa1UT2AIGHVHt?=
 =?us-ascii?Q?9JhJD4YGw9N5xb2Y8PdD0nMbuwAaHoFBpWbdvZq5/o/Heo1mdAXGZDNBVmiW?=
 =?us-ascii?Q?IsmggLsaYRH1xRvrUBP9qMXa86zUXohwF2tTDWVZiBUlAAI+FD3kOqTo5x8N?=
 =?us-ascii?Q?mo6fdxaEUOCr+WL5S8pnhy53zktsQk+7KX1siUvs/AvRmIrcT5oYMfgQs3Gx?=
 =?us-ascii?Q?SY/FwOYhDtZKYGHqZUgzWSDWQNAsHpMLregJQOkz78+BS3iQ2Eye8yaV3got?=
 =?us-ascii?Q?JKetnuFmsVE4+N8QJ4ObHfpuNXsxU7ouy4KWmMOr4NJh9uBd0LtmJ7Q/MT7g?=
 =?us-ascii?Q?Ol8N6FHvrBgmogkOY/lk8Maj0FTAl7rQ/h3zqrnErHRBx3obTv2d0kievOpP?=
 =?us-ascii?Q?HmEu7Kv4hlF+0OE5Qj8b3hs2dfCxe8mzjq3kDVTK9cd3XhXAv1x8Y3B82Yrf?=
 =?us-ascii?Q?Y2f78CUVyYMz9/pFyueMqrP7QNbSxsePs6RxZlmNX0Nq0lYu2Zxwezf4idlb?=
 =?us-ascii?Q?VUWJdTht2LwxMKUo0BD+YHd5b5U5QHfIlfNYOsiaYCeuOev79MfSgBsS0uuI?=
 =?us-ascii?Q?4QXevTtSvLVL9koU/JNgeSb1T/XdRQfINrZkoMCkRCfUzQGqMWkuS+DkPrl/?=
 =?us-ascii?Q?j1t7UXdLR3OFIQRiH+KJ1wd6nb5H8SDVt9AVvdJoRVhTp80VQ6usVHrPnwzv?=
 =?us-ascii?Q?8xYNXSo2Qke0HvsJTCrS9LDgurvzeBac9VhgA6GkjSBeBsvkkHDMy1Oven3O?=
 =?us-ascii?Q?FSLkzxodmbMN4psTD4UnlMY7lcFXpdSjcpdHSSJ4x1tAzFk/9CBoeWnk/jfN?=
 =?us-ascii?Q?4xpFc7tr3kFal6wPFwxHc6g4aYVMmfE2U3HQu/fsmaTI5JQUZWEwQTwIstM8?=
 =?us-ascii?Q?SBhBF50vyieYxGgTP6EnTFJOLHmYnk7DO/u6LnSya/NTl4DsvRD40zhhfHMz?=
 =?us-ascii?Q?Tq93EYMjAT2pWjPbDxU8Z5c=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea33b3d-5f48-45bc-daf7-08dddedc4ad4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:53:08.7231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJn1+ATwHbslJe9ULxvTIu5JNPCASgB0fBR2BP7hwvX3YfOG4O7JlOb5Z6gGNPGiaArReIBykuCkHBX9pMCpHXo4NRVGlJeFw8Xw/IoMOQT7GCwaN4CxjEj37ADPmUD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8000
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

Secure Device Manager(SDM) has only 512MB window address space to
HPS over PSI BE link. The default access range is 0x0 to 0x1FFFFFFF.
To allow SDM accessing the address space more than 512MB, SMMU has
to be setup for address translation.

A conditional check is added to not allow the fpga reconfiguration
for any bitstream data where address exceeds 512MB, unless
PSI BE link address translation is setup in SMMU.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/include/mach/smmu_s10.h |  6 ++++++
 drivers/fpga/intel_sdm_mb.c                   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
index 209caa86e38..d611664e227 100644
--- a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
@@ -30,6 +30,12 @@
 
 #define SMMU_SID_SDM2HPS_PSI_BE		0
 
+#define SDM2HPS_PSI_BE_ADDR_BASE	0
+/* PSI BE 512MB address window */
+#define SDM2HPS_PSI_BE_WINDOW_SZ	0x20000000
+#define SDM2HPS_PSI_BE_ADDR_END		\
+	(SDM2HPS_PSI_BE_ADDR_BASE + SDM2HPS_PSI_BE_WINDOW_SZ - 1)
+
 void socfpga_init_smmu(void);
 int is_smmu_bypass(void);
 int is_smmu_stream_id_enabled(u32 stream_id);
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 5f4aae47d6d..1bbb717015b 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -10,6 +10,7 @@
 #include <watchdog.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/smc_api.h>
+#include <asm/arch/smmu_s10.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
 #include <linux/delay.h>
@@ -1031,6 +1032,18 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
 
 	flush_dcache_range((unsigned long)rbf_data, (unsigned long)(rbf_data + rbf_size));
 
+	/*
+	 * Don't start the FPGA reconfiguration if bitstream location exceed the
+	 * PSI BE 512MB address window and SMMU is not setup for PSI BE address
+	 * translation.
+	 */
+	if (((u64)rbf_data + rbf_size) >= SDM2HPS_PSI_BE_ADDR_END &&
+	    !is_smmu_stream_id_enabled(SMMU_SID_SDM2HPS_PSI_BE)) {
+		printf("Failed: Bitstream location must not exceed 0x%08x\n",
+		       SDM2HPS_PSI_BE_ADDR_END);
+		return -EINVAL;
+	}
+
 	debug("Sending MBOX_RECONFIG...\n");
 	ret = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RECONFIG, MBOX_CMD_DIRECT, 0,
 			    NULL, 0, &resp_len, resp_buf);
-- 
2.35.3

