Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB7EA8108
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE6283CB5;
	Tue, 10 Feb 2026 13:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="q586HbVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0AB83C67; Tue, 10 Feb 2026 06:24:33 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41578309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 06:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py7eJg/Cx2VoybYTDOLtd8tIVi+Os22Rxu1PapPKl+c2KSZm+59+jpA8qKwSCR6cfAONEbjfCTL0fgHiAh9C2Xo6wwRmv9EtpZEgeQVS5YaOHmLWYD8B7EfpEjIUiRjOPTDUe/qB7OKn+ZAtIBf4d394j8aUiVgRxyGhoIi2QYiQfGwsM3dT/wgRdEfWUMRm/P9GbOsCWCXbHXoMwHYCeq0uzmNpdyhdSs7ojQiyhnh0kMaPsemGojo8gL5fQs270cp/4juZjCz8RxKamjWJVbNKvPJr0eRD2S3U6DIpTwuJL8OvQHv8HTyCqL350fyJh//f4jAnHtwPBLu3fcZwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axxfMwK8m9vw5GE8IiMrV4Mz2WLKD5GTyUzvRGq2jCg=;
 b=onlnsjPVst259yVSCs/Ghz29N8k3/a8bV/PaqoX2IAy/92kRQV/0dDqal3/aE3MCp7fVIA1NjWmj2xECzn89Cv5VazdANP7dVb+dFeCKfMwebD1eyxjbl9PSrqEBXCv+WE0OBmYlgDIoXuPVOCv1AoCG8OZ8abtlzsv7LfeTh+ZvUcPd9Z8JJmRqK37BKgLrdREu5v9UCe6flO+tlFm7/ouxNOEgdWGNR68cdEMcKGjLQf5/f34wT36ocHzTPHXXPITCuJlT5pH2jlVD5K9ybvNuPVhG2nUA5D1yraFxFd0MeH42/kV/irgOZqV6Mkofwsq2myfuCxfnm+FExoLGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axxfMwK8m9vw5GE8IiMrV4Mz2WLKD5GTyUzvRGq2jCg=;
 b=q586HbVc65aU5+OZrLMyes1imv8Kj8JffFr3DxCDwPXZa3loffh+rJO/7Ja6qco4lEfNWHVbMZd2V/KFotWZHR/3nq5qnK6QobwEGjrtymZHjjwmAZhnXRRvF54DQDsZaiT0lAP/XP5rdYVH5pxMnEINP/DBQJ+7ffFkS6gAGVYBH83J7yhtCCUT5IiVXiTOA4htxIvlEKpfIS3+OT12ecJ4+PSS26iMhwAXIOUTHZPPpQIW1/DMU9pvC+OWFOje4XpDuhFI3E1ycvwQI3huohk5aJCJC2vBsGbAfqon/iTptqDU/9io6MedbxjwVpBGK2pFRqW8WToSD9bYnH8PkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB6533.namprd03.prod.outlook.com (2603:10b6:a03:386::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:24:27 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:24:26 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 drosdi <danish.ahmad.rosdi@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v1] arm: socfpga: soc64: separate reset manager into common
 and platform-family parts
Date: Tue, 10 Feb 2026 13:23:59 +0800
Message-ID: <20260210052359.2644-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe9e22c-cc69-4496-fc93-08de6864a830
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kwiO23hGcyZ2BwcmFgZfVpZpRV3TJ77qfZ9ftuckRef70134No0w7Rxjuo6C?=
 =?us-ascii?Q?MNU6jRIEnZBrScIgwwmRR3fJZJSsPDc3yLQpY4teJG+a4xWKVFSG7xj9YdoS?=
 =?us-ascii?Q?AiUZz4euUw/JsbG5SlZn1Yo96FfSvUR3oAUrR3ZD+33QoiI+2uebO8cqjJxF?=
 =?us-ascii?Q?3KyJGfZRDtJBERwbJHtveZPUWRxEh1A6LMopvuvLZjmAEwt4oB4dAAL2n8Gr?=
 =?us-ascii?Q?vndlgzOgZdZ87GBV7jVjY07tLug5FSOZXrw6ohhh7o8tkHiKfuy0lrCT4ceX?=
 =?us-ascii?Q?taTOo6g38xGJM8VA7UkHktcelSCY+2mrHM4fDwDkD5lXpLxylUFx1+Tt0dL7?=
 =?us-ascii?Q?EJCkIDM+vtlfFa+ycUeWjhw9NHvB0jFjnnoU5N5AFZIehsvnpy+R6k1bAraV?=
 =?us-ascii?Q?q0Ap5oBQbXX2tZc+tPYpONcbOGGWe5NX7IYRHYJ56g7eagrjljNJsPPKyHYt?=
 =?us-ascii?Q?NeuqQ694Y+lysTDcLutq+W6cUe/73/+dMR46+m5gOm/fCz9SFsOHbEpuxuGf?=
 =?us-ascii?Q?cHLNjsiHsWljjnBjksYLYIdY15dkuCpijHfHW/qLnmyKAqkVwCNnze79Xw6w?=
 =?us-ascii?Q?xWrWSY/8SZ9y8vnhx7blziYglBLZhNqK/VSwxY8fOMp07uTSOmiQ5VRSL14s?=
 =?us-ascii?Q?LMuhQ674g1RYYa8JkL31VakK/rpJQMOa7SWDYionsdjF2lV1Jto01JBjVUqA?=
 =?us-ascii?Q?yCHGVy+dHIy6ZFdtMaCOlJvxRVAQlkkz3dW2TBfP8A0eQWKc4vspkNNMkJPt?=
 =?us-ascii?Q?fxYQOloSCqDoYkA/LNfIJwx1v4mVhbaTpYCG/OzsM7MBFExgkh/DXx2IiOid?=
 =?us-ascii?Q?yzAOVOgPn3vPQB9a7VDVwJDG11lAldW198sKTqVXVhTrOaD1F7k4rg9WZh8o?=
 =?us-ascii?Q?+S8ugT6e5vWc0dVUJtY/QC+/Lv/sNkjFVUtfaXl2dfmZ9Mti2YYGyNdr3seN?=
 =?us-ascii?Q?5M4dF27tv6mmfs4kuHxluN6+F+XtVugP3y/WyP7OO7wVzGNNx+BKXGv0SCfY?=
 =?us-ascii?Q?XSkxoxFqFhcuLTNHyBuq5jH4SjP1qdZa1aW0Fq1sSU7wqwR5T5ZFESHUx8mx?=
 =?us-ascii?Q?V6/cfwS4O42qswUj+QdbQgIU9mTB7CatAGH/BN/SGh9USKJkLNPhvzLNO6uU?=
 =?us-ascii?Q?IrrZ+pADe7jDiAVlddunJ1Vo5w8H6+0CnGJq8mrP4+2EJ7v3Qm2IvCgheqHh?=
 =?us-ascii?Q?eUxtJBg81e/zpInYmn8GbqdhYufjhirQ/CMFYs33LUricqdTI0IXfa9F8i2J?=
 =?us-ascii?Q?cy0wnvpFWcoSYClqkVDCV9PlSbPS8o5Qj9RYj8ICvHvNhGEMpuFMlfX8YZg2?=
 =?us-ascii?Q?ayYGydAgVn4OEgomcyrfnZTaa5gXqXvlQX8tmpo47nhgmR052b27HhBA/DE3?=
 =?us-ascii?Q?kdfGpE4M2D/4GfDoAUF7IPbbqbFwYKJMgJuitZ+MmJSSLmBtT13tvh2ZoMYM?=
 =?us-ascii?Q?tmyvgHnAx5FuRme3t2HYIIwFxWenrDCkNvalZ0atFbpMNX+KSBB3GDOx8m2t?=
 =?us-ascii?Q?wlIk/bzJrKu5zUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lr+ilayaBPAedFjJAzCwCNhOf6+pxDCiwiYzLVbjsq1UAb4eSkbKlBEpbKpB?=
 =?us-ascii?Q?C0FtGWUWzaX5HXcG19tydtMeGtubuujU9eV2s14UW1ZPNUt1ynGcr4NjQDBg?=
 =?us-ascii?Q?XNB/17Cne04S89nOm+zXN1iYbmuZQlbop+xCd8F8i7mIw70gGimQgvDSqbB5?=
 =?us-ascii?Q?+D1hpnp4jIKExTgub92sNzK+3WomRxUfYDXZYVQzDO7EWWa3CvLaReN0UR2z?=
 =?us-ascii?Q?TmjVXLRqk4rNHqK0rPnoMveholxXt2NVZDve4E6DXf+0mSf6a5HSj12V1aRR?=
 =?us-ascii?Q?z5f222yM5xkwEMBxjdh9v9KxQTv3bszbQ3qtQp+YIrN9W06t6vFf66MROO4O?=
 =?us-ascii?Q?v1LViFz5z9VqmPM44FRZv+sqK40iSmqVI+rAugbs+B5Ekfxfv7mFUwdNfZaI?=
 =?us-ascii?Q?tL9cokDolPcKCMT8XBNEHksvCwDgKuHv3JBlw86FvAsvRYWbCgkiEY279yR9?=
 =?us-ascii?Q?b9JwLOhKgMUigxA3BWSxRufbWV3IBlJB+xxYZr4zWhi+qnh8E+/VtwMMKwgr?=
 =?us-ascii?Q?6xn/wksU7XS+y5HgfrPpClQrUJQ2XlvUzcz8r6FdtQuSAmRP568JqNLM5jOi?=
 =?us-ascii?Q?RO7Cqmsumzc9/dWKkDDixfwHYV+P83gkPfl3MklrWny2FtYsqOWIA9qMhXTq?=
 =?us-ascii?Q?crskKHZcttQQMtSSPoQkXiUyCZvePwHg26wRWGd9TnLjhx4273vhzRJeG6QM?=
 =?us-ascii?Q?wimbUxHirbRKpS0ggDyHUKLBW/YuzvZ9+t3BZFuuiAnxjxDt3IVVfdFBbyE3?=
 =?us-ascii?Q?FPA1Ugwrl/Z4jy81vsS/LVQh6TQAXNY/VQs4UmfqBEmfJnEsBmX5M7LgrsAc?=
 =?us-ascii?Q?FZfbTkpH2VHrbDH4GHOlNPAl28enIM2yZJEDJdGdiARE0Ky/HElHQY9Oq48x?=
 =?us-ascii?Q?67SyETJjN02A1+spdtwReE1jaYr28qwvTiFh/ziCLl1ZdBYQruw8W2Lcv3pq?=
 =?us-ascii?Q?OqfJGdGy49VfBPH9jVDzNUWjEHgJ+bEYucUCwxXwjc7p7EEQ80ARRykGcxk5?=
 =?us-ascii?Q?1EcIEQQPje/w/W5M7yR1mW22gLXEAkDkPS2obRieFcBxki9E9///zmWRZt5f?=
 =?us-ascii?Q?71dkk1jVInncCnHMeajS5CClV1DIZDrubv3S5GoSg+wS+gEMnCn2dLZXCL+a?=
 =?us-ascii?Q?3gTztegILsoesoza7gjHUcJ0n93fj3nThq2IrB74ywQ0C6QdVrbSs2VRaQ/u?=
 =?us-ascii?Q?AUvNOHKuGhhWdP46lQD+q4hs2jOmioI1BSZLv6Yt6cOS0eBMf1NO60ZUvH+3?=
 =?us-ascii?Q?GwrZrJ5MSD+Gne90+iVtcdSdOqBE7R8ON2BTrGPso95k9Wo9H7nauwzCrkjo?=
 =?us-ascii?Q?OxAzKsunYP20jHRAFp+cfctfIcYt8JCdmRlkPCSCDckJ0la/+l6oYtxietCa?=
 =?us-ascii?Q?Lg5kjhPdkcpSX5+g/952IoIxofT4O3yLwrwDX8qeLvIBj4azcx2ZjLv6dRyx?=
 =?us-ascii?Q?R/7bzuGaOkL2fTfoHhwQJDHRjagRlZo4/nKWpU4zlHhecbUZhUXy51vwZrSt?=
 =?us-ascii?Q?N6MxushDgJDFiFHJNI4E1twTQx0z6gVgRDcvff6xRP12ndHuabeXfjxyeO7D?=
 =?us-ascii?Q?lR+wiUx6r81HuLySEj7TCcbrkoeDI62eHe56/Ilykxfb2+61Ltu7e4sv/XiP?=
 =?us-ascii?Q?blzTJL74sdzWmN9IDRYnPm0DdO9SCXKLOL1X2BsvgxdbzekmatceJoXNoX/D?=
 =?us-ascii?Q?R4WAzb4X5Vp6E4yVAL4fGeiMV9qfrT/7NQgIYKFqvtPq3RGDHcEDGolnu7mq?=
 =?us-ascii?Q?IXGDNR72RQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe9e22c-cc69-4496-fc93-08de6864a830
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 05:24:26.5221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5oDjOryCHIdXBzmQx+jhvOEkGkjEsWK/aE2pWvGq6BpvgmlSVsPKMwMPuju75UdgmkiAwRZ5IEFSKMU92Q14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6533
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

The SoCFPGA SoC64 reset manager code is currently built as
reset_manager_s10.o even though it is shared across multiple SoC64
families.

Split the implementation into:
- reset_manager_soc64.o for common SoC64 logic
- reset_manager_soc64_platform_families.o for platform-family-specific
  code

This improves code organization and prepares the reset manager for
additional SoC64 platform families. No functional change intended.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/Makefile                | 15 ++-
 arch/arm/mach-socfpga/reset_manager_soc64.c   | 94 +++++++++++++++++++
 ...> reset_manager_soc64_platform_families.c} | 75 +--------------
 3 files changed, 106 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/reset_manager_soc64.c
 rename arch/arm/mach-socfpga/{reset_manager_s10.c => reset_manager_soc64_platform_families.c} (78%)

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 4e85bfb00d4..71587fd3caa 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -34,7 +34,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_platform_families.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-y	+= wrap_handoff_soc64.o
@@ -47,7 +48,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_platform_families.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
@@ -62,7 +64,8 @@ obj-y	+= clock_manager_agilex5.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_platform_families.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
 obj-y	+= altera-sysmgr.o
@@ -79,7 +82,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_platform_families.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
@@ -95,7 +99,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_platform_families.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
diff --git a/arch/arm/mach-socfpga/reset_manager_soc64.c b/arch/arm/mach-socfpga/reset_manager_soc64.c
new file mode 100644
index 00000000000..71e9512af49
--- /dev/null
+++ b/arch/arm/mach-socfpga/reset_manager_soc64.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#include <errno.h>
+#include <exports.h>
+#include <hang.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/secure.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/smc_api.h>
+#include <asm/arch/system_manager.h>
+#include <asm/arch/timer.h>
+#include <dt-bindings/reset/altr,rst-mgr-s10.h>
+#include <linux/iopoll.h>
+#include <linux/intel-smc.h>
+#include <wait_bit.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Assert or de-assert SoCFPGA reset manager reset. */
+void socfpga_per_reset(u32 reset, int set)
+{
+	unsigned long reg;
+
+	if (RSTMGR_BANK(reset) == 0)
+		reg = RSTMGR_SOC64_MPUMODRST;
+	else if (RSTMGR_BANK(reset) == 1)
+		reg = RSTMGR_SOC64_PER0MODRST;
+	else if (RSTMGR_BANK(reset) == 2)
+		reg = RSTMGR_SOC64_PER1MODRST;
+	else if (RSTMGR_BANK(reset) == 3)
+		reg = RSTMGR_SOC64_BRGMODRST;
+	else	/* Invalid reset register, do nothing */
+		return;
+
+	if (set)
+		setbits_le32(socfpga_get_rstmgr_addr() + reg,
+			     1 << RSTMGR_RESET(reset));
+	else
+		clrbits_le32(socfpga_get_rstmgr_addr() + reg,
+			     1 << RSTMGR_RESET(reset));
+}
+
+/*
+ * Assert reset on every peripheral but L4WD0.
+ * Watchdog must be kept intact to prevent glitches
+ * and/or hangs.
+ */
+void socfpga_per_reset_all(void)
+{
+	const u32 l4wd0 = 1 << RSTMGR_RESET(SOCFPGA_RESET(L4WD0));
+
+	/* disable all except OCP and l4wd0. OCP disable later */
+	writel(~(l4wd0 | RSTMGR_PER0MODRST_OCP_MASK),
+	       socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
+	writel(~l4wd0, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
+	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
+}
+
+/*
+ * Return non-zero if the CPU has been warm reset
+ */
+int cpu_has_been_warmreset(void)
+{
+	return readl(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_STATUS) &
+			RSTMGR_L4WD_MPU_WARMRESET_MASK;
+}
+
+void print_reset_info(void)
+{
+	bool iswd;
+	int n;
+	u32 stat = cpu_has_been_warmreset();
+
+	printf("Reset state: %s%s", stat ? "Warm " : "Cold",
+	       (stat & RSTMGR_STAT_SDMWARMRST) ? "[from SDM] " : "");
+
+	stat &= ~RSTMGR_STAT_SDMWARMRST;
+	if (!stat) {
+		puts("\n");
+		return;
+	}
+
+	n = generic_ffs(stat) - 1;
+	iswd = (n >= RSTMGR_STAT_L4WD0RST_BITPOS);
+	printf("(Triggered by %s %d)\n", iswd ? "Watchdog" : "MPU",
+	       iswd ? (n - RSTMGR_STAT_L4WD0RST_BITPOS) :
+	       (n - RSTMGR_STAT_MPU0RST_BITPOS));
+}
diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_soc64_platform_families.c
similarity index 78%
rename from arch/arm/mach-socfpga/reset_manager_s10.c
rename to arch/arm/mach-socfpga/reset_manager_soc64_platform_families.c
index abb62a9b49f..04736b17b36 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_soc64_platform_families.c
@@ -6,6 +6,7 @@
  */
 
 #include <errno.h>
+#include <exports.h>
 #include <hang.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -15,7 +16,6 @@
 #include <asm/arch/system_manager.h>
 #include <asm/arch/timer.h>
 #include <dt-bindings/reset/altr,rst-mgr-s10.h>
-#include <exports.h>
 #include <linux/iopoll.h>
 #include <linux/intel-smc.h>
 #include <wait_bit.h>
@@ -29,46 +29,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
 #define F2SDRAM_SIDEBAND_FLAGOUTCLR0	0x54
 
-/* Assert or de-assert SoCFPGA reset manager reset. */
-void socfpga_per_reset(u32 reset, int set)
-{
-	unsigned long reg;
-
-	if (RSTMGR_BANK(reset) == 0)
-		reg = RSTMGR_SOC64_MPUMODRST;
-	else if (RSTMGR_BANK(reset) == 1)
-		reg = RSTMGR_SOC64_PER0MODRST;
-	else if (RSTMGR_BANK(reset) == 2)
-		reg = RSTMGR_SOC64_PER1MODRST;
-	else if (RSTMGR_BANK(reset) == 3)
-		reg = RSTMGR_SOC64_BRGMODRST;
-	else	/* Invalid reset register, do nothing */
-		return;
-
-	if (set)
-		setbits_le32(socfpga_get_rstmgr_addr() + reg,
-			     1 << RSTMGR_RESET(reset));
-	else
-		clrbits_le32(socfpga_get_rstmgr_addr() + reg,
-			     1 << RSTMGR_RESET(reset));
-}
-
-/*
- * Assert reset on every peripheral but L4WD0.
- * Watchdog must be kept intact to prevent glitches
- * and/or hangs.
- */
-void socfpga_per_reset_all(void)
-{
-	const u32 l4wd0 = 1 << RSTMGR_RESET(SOCFPGA_RESET(L4WD0));
-
-	/* disable all except OCP and l4wd0. OCP disable later */
-	writel(~(l4wd0 | RSTMGR_PER0MODRST_OCP_MASK),
-		      socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
-	writel(~l4wd0, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
-	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
-}
-
 static void socfpga_f2s_bridges_reset(int enable, unsigned int mask)
 {
 	int ret;
@@ -271,40 +231,9 @@ void socfpga_bridges_reset(int enable, unsigned int mask)
 				 ARRAY_SIZE(arg), NULL, 0);
 		if (ret)
 			printf("Failed to %s the HPS bridges, check bridges availability. Status %d.\n",
-				enable ? "enable" : "disable", ret);
+			       enable ? "enable" : "disable", ret);
 	} else {
 		socfpga_s2f_bridges_reset(enable, mask);
 		socfpga_f2s_bridges_reset(enable, mask);
 	}
 }
-
-/*
- * Return non-zero if the CPU has been warm reset
- */
-int cpu_has_been_warmreset(void)
-{
-	return readl(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_STATUS) &
-			RSTMGR_L4WD_MPU_WARMRESET_MASK;
-}
-
-void print_reset_info(void)
-{
-	bool iswd;
-	int n;
-	u32 stat = cpu_has_been_warmreset();
-
-	printf("Reset state: %s%s", stat ? "Warm " : "Cold",
-	       (stat & RSTMGR_STAT_SDMWARMRST) ? "[from SDM] " : "");
-
-	stat &= ~RSTMGR_STAT_SDMWARMRST;
-	if (!stat) {
-		puts("\n");
-		return;
-	}
-
-	n = generic_ffs(stat) - 1;
-	iswd = (n >= RSTMGR_STAT_L4WD0RST_BITPOS);
-	printf("(Triggered by %s %d)\n", iswd ? "Watchdog" : "MPU",
-	       iswd ? (n - RSTMGR_STAT_L4WD0RST_BITPOS) :
-	       (n - RSTMGR_STAT_MPU0RST_BITPOS));
-}
-- 
2.43.7

