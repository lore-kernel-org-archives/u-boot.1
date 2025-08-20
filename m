Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF801CA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 07:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C1082F5E;
	Wed, 20 Aug 2025 09:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bkehYnmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37C88006D; Wed, 20 Aug 2025 09:32:28 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF7D82B07
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 09:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1FzqLPwvA1sFOdUnv2MaMfPDienDN5cvMvJ+XerVhJravNt3i9RVE5BxGJrWHxGpCszhVGPmWZu47kx1qi9bT+eWsnR0djv/e/rVUXlyH8KwM8+ggafLt6snIFOEj1e4S+tHR2rGToYO496CKAHW4SbNP3SH3Gj2Q9TbxJaqyRgDGcxeCcbkyE/IF7OibdHy5DkhSoSt8FXMEs09AkKkVuY1in4LlnxcKoHYtc07BXI4mXMp1VZnbRHao2KKW+GSQpNdAwSbA56V8Ms3agTTy32T+zQFjddQP2GhXu7oY63s+8bFb0/mn1RTxoVISe9rN25YxJK7Yd4Bc4zPQOacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxxoTr8jFIVpRR9iHrBxbNw4qnaNo3GReuD4Ehzb0yo=;
 b=My/XU5HJWdWy2jTkWeM3FRAdH9ykVHXTCBMaSIPcflIwRpR1cBhRXzRO/RUYi7+iKIy4gO/ucLgSa7H6QsXJ8Tr+iA6o9P0WA15P7L9KXCUMfxYiJXqg4SDlA2SZkpn29GkbMxGCAeqIN7Oyr8lfYcAMCz+yTykW6YIP+QwcaOA52ycXg4VD90Dw/WR3OTjhe+I+tUMzq57RwobNENQtmBf6LtP4BtKDCb0AOxkjslfLNhEPNa3pGiR7TIqR4McvmWglYELPzIcXPbGtCnMP0Y9lp7kq5TQJUgQ15DAy4W2c1+cKfujrLOlClsIrvuKrFr5viJzyMgwRhf898FlfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxxoTr8jFIVpRR9iHrBxbNw4qnaNo3GReuD4Ehzb0yo=;
 b=bkehYnmjqZ73uaLojBtENlnNm0lAEUQ6aTT9lhmpc6les3vsnORyPKZo1Grkcd9szqiLQhIbGBB4ciyKwTfxmm1P8Xl7jkEE7EQhnLP+/CAzbBON9BxVtJKtsSK42g6Oh34lbmzKg3dS6ojYu9Cv0pkNZqEC/M3HSvdYiUjpOqGlhIa5A3m6VAPbXinVPkXPR1Ir+tx1bbmGPdCx7nwvNHP4TCqufBnOe5QlDD1xwohh6i9FXbUdcue84sbph5lVonRItiUGXEVes/vckMEDCZcN9YyDFdRIMaWxXOja99Y5yxTvkPhAfYpPYe0RchIaasQoDZA5HvXRYnvUlDmbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 07:32:23 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:32:23 +0000
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
Subject: [PATCH v2 1/3] arch: arm: socfpga: Add SMMU initialization and setup
Date: Wed, 20 Aug 2025 00:31:59 -0700
Message-Id: <20250820073201.8649-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH5PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: edb6b9dd-d786-4ea6-2d3c-08dddfbbb430
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RxbtVxBeZpaXkNwnnRIZWx2xl71R4N/emJvKFlCx1alSxalIzKAm+FuIbJd8?=
 =?us-ascii?Q?quA1rbTJn9sFEuhspVsXX6bqohv14iSfVU7w3v/Ts2j1HBwVJ8KF3m2NOzUl?=
 =?us-ascii?Q?OoEU2dXQJEzt388Tus3i/tReMNto3kXGUXjxng3KOAQ7qsNel3qCGm8e1lEc?=
 =?us-ascii?Q?teDpzv5IoQCunGyDhiX5Cf0r6eQWUE4e2TWfBM3FDV5tBfJ6207LZvxuyk8P?=
 =?us-ascii?Q?42/H5p/gj4daLzNEYBxWaH3SajviXojPC0FXUdcdm6KOMiQ4T5t592a/7SMF?=
 =?us-ascii?Q?vxBEu1gEexGEkscJFWVI1JmcBbB6yQ6N3pg13zvnyWhRovcA+e4XfgbuCMHg?=
 =?us-ascii?Q?Eg48BLjqAKrvnsAKSnn9p8lsD62/xRVVt0bxdu43brUSmC6CQow0jHwR2RNa?=
 =?us-ascii?Q?eJAanbvDpQzxg+YSp1R36exPYO1r7+RFwIag6n1v0ceoMjs5XTRDUrjpU2cg?=
 =?us-ascii?Q?EWEneU1qkQz3J7XF/LH2vvTZgTtyspVOvl0uNxa4BXwcy+A8je4Vb1bFJMWC?=
 =?us-ascii?Q?KBRL1TmqNqXBk187emojeJ43QVtQ6h7k8dX2PJ54bfVlFlp/YgzsgA22Uxek?=
 =?us-ascii?Q?c5f5eEfsJuPGBw71fzrReINsCo5cTEMa0iR7XJDWSmEr8oza02LhmZmRYyUB?=
 =?us-ascii?Q?6vGdapbJIJbynTL5MSdC0YCi7sTCoTFTIXq4ZlXAoMxVDvvz4Ae2vwIVyaQ7?=
 =?us-ascii?Q?GFihbSLokBmth6b/L2tnOC0safz7YiCq/fSYGjNSdOS1eCNv7mp8iRagEtdM?=
 =?us-ascii?Q?lXnS+hAu/o6akyxXbQCY3ORb+/OvR693Xuu9iO4lMvHyGcISGoc7conhIudL?=
 =?us-ascii?Q?7jxKWb8PVNEmsZBmv6V1YSemqALDidHr7a/w9mBlK4BTjeOAZQr7Nm1x0gBM?=
 =?us-ascii?Q?AyUsea0VaPkJT3Diq+NXlfBH6viYLLD8QaXTxk/8wVC3ci3a/F5PZT6j89Tk?=
 =?us-ascii?Q?yr5ZGYwNjyV5LzgzHVbZfZjn2eN7ZS9IYNo3aJQe9UX9WmMUvBmEORh5wtTO?=
 =?us-ascii?Q?OpbkxnB/fN+1l5SXTijs3yVzgq0j8sgfHZvvzeBMy8z6VVUm5E7szwrKe3mF?=
 =?us-ascii?Q?4lbtWdYOYqLpxNV9RrMxYlDuYVURjt2Vh5NfZi0IYDPTlGn18ZesDFGfD5Fg?=
 =?us-ascii?Q?2Tubfiwn2Hiyle7G4k526BXFdFmRCA3NF9T0DqUmN3CnU77UaYtvNuQAahZ7?=
 =?us-ascii?Q?O+mv8NEteI8O5aS/2ycQPHDjMs7tJ63K15IxrMpCnARx3ZeGb2u9Teg3d2yp?=
 =?us-ascii?Q?FNzqey9v/zMDoXZVIWjup0T2J2Edm2LZMSac97ex3lbzz3MMSFTrzH+qq05K?=
 =?us-ascii?Q?qNWFoGBunKmz1df6GUK4M5kNUvcwW3NbiDJ+3w5j3t24TZaR4MCY8bJJrw95?=
 =?us-ascii?Q?y2WRXhMNQUs4jRK3wQto8z/gr1YSbMX8yPN1WsdGDwiiYRZzatDKb/bGXMyJ?=
 =?us-ascii?Q?z/0tVhYS5+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrLXPWPVh+Kj2OPEjDA+x3aqDkj7eK+bi7qdD5i1dDU+ULppI6ddgjkNLtr2?=
 =?us-ascii?Q?/zYkDjg8M2IOEHaLLYfOhlqhLPQrhfsXAmKy6VKcJfuUfTiilu25yC/1do8a?=
 =?us-ascii?Q?YFg8J+CzYCDe1NOpQHk5xTs4JAt5cStCZ1NIvLjra6XoxtjEcdJLUFBS0L7Z?=
 =?us-ascii?Q?MVtk5z7vAU864+xXK3zjEnIrno78YMxkIYbSEtbkVF6IQZFDeLwaBmsZFt4S?=
 =?us-ascii?Q?6chESjgp7ya/RhgFlvInz+SzzbBkg/fA+bUIwB8AH2GgadRdzQXbmVqURFrL?=
 =?us-ascii?Q?VAgGGVacpA9PVnLWNuC4sl+ogD0so+IB+JRomxnWQ8K2x/56SGTrM6b2HNN/?=
 =?us-ascii?Q?gw/+nSUb5zyB2QaH/aeF82AWjfxDQ63xwxENpvET1XxRIblEBhD5DLx5tvwg?=
 =?us-ascii?Q?LeNijph9vq55cXETi05WeHZfr2pIEUR0IXp4XK3G5PqsDQ6GNVz371RCxMiM?=
 =?us-ascii?Q?i184Ir5J7p7mZwqiCHUsafuc8pXsMpHJlptJBFGOc8F+QROQsyfVedoD1JJY?=
 =?us-ascii?Q?ubWNSfmbXG3AZVNSiwdIzlhA4YceqRZlZbfV1q64qcsYG42goizhlDPkO45y?=
 =?us-ascii?Q?wNiG3LxfGpLKOO67C+bnV46OReDVG8P7YIrhVBnoDtE9PLzse76jpZMQCdd5?=
 =?us-ascii?Q?f223k8j40bNswnEDmWhr7qFQoduiuRXb5EnFfkxOr12puyR6/CIsPFjvY2ws?=
 =?us-ascii?Q?4mtH6U8AyS4apjyD+4mbNJqWgf+oZw1ZDe/z+SBJ+s57IoRsGZJ6FpJ3h2/t?=
 =?us-ascii?Q?85aEJ6pYvGytGjVAIRb9iCPeKxt+++VOT7gFfgimBhe0pXbEfU5fxfIVMLPy?=
 =?us-ascii?Q?QOYtCmYTMDzvJid+V3H2dnx70eRZ2qoH+TGBOhHkdFs2aVs/QMBSIg3WGh1X?=
 =?us-ascii?Q?XCIGh7a/58WHhyvEkkdbp/v0gLb7il8zcKzBD+Wq2Xj3xn5gQ4F79RC7K7cx?=
 =?us-ascii?Q?w6UdpWTqvJ0VHZ7tv1Jpe7/kmfYPEgjwHTlUL0qjOxd2Y5MwMlVZrpfLoKfj?=
 =?us-ascii?Q?LbEg68u4yUHMKRZeGGPvYGemGI6Xsbi09eMNlD9S0vGw6nRQnOaxEo3hqLqS?=
 =?us-ascii?Q?DLWBqouuE8AELRN3UMGU3Tiv0Iq89n1R4taTBYGk8Hc9yaE7u0XUQRLZOuzO?=
 =?us-ascii?Q?hiY44KbKgr3Wl7IFYzK3Zy2Cid7swdRVviPxLlv4/lWOrZ0J+ELAN6gY02F2?=
 =?us-ascii?Q?AJBuEHDZqzva8FoSImw141z1kEJ9JHIG1Rjd0kfmFl1VcAQjs0h5hanp3Qi8?=
 =?us-ascii?Q?8ZDSmxbEQWh0a0MfCUYOKI4GtErQVVTUOBWb7jm2ZTkOJX7eFGO2vtytsm+J?=
 =?us-ascii?Q?8tXzSrV5Ne7fMLsmPjxnjEa2Cu27VDVftE5qsajKPhU89eHrug4nxw6dDEKe?=
 =?us-ascii?Q?kZ8Xng4hzoiChA/ZBW9LabuJVp2aW2ptkiS5P2qxlULsOxpu0JWd595mg71k?=
 =?us-ascii?Q?S1Nbe421pM26KZel5zOXMKVhTjtinfEDjbW1g3g7Qq+/7JlWuACAZV18eb57?=
 =?us-ascii?Q?2/Dcdev33CxvViVAhrhyay/BEnURCwERjIxsWt2MyFhTLInf98vjlyaa6D6J?=
 =?us-ascii?Q?t/6aLhtCT5PxCjeMftUjy1NKRcNsjfPoJSNsdS/immXIUY13HP3BElVFKuDX?=
 =?us-ascii?Q?9QwfkvVZsf2zy6S8CvsXuLk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb6b9dd-d786-4ea6-2d3c-08dddfbbb430
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:32:23.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXk3lLgO0X3zhu3Qb6mH3dqHnloSAEtm+DET7VWTFIYlp1N1jpzQtK8IlLJYdjCY6F9Lfuy4fxV+JyeYVs3AG1Zryxmp5aqHt4rf2lUuBgofRoQQNY33lQhqzK8PLcrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7982
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

SMMU initialization for SoC64 devices is added and stream IDs are
setup for SMMU peripheral matching. This allows non-secure
accesses with SMMU peripherals.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/Makefile                |  3 +
 arch/arm/mach-socfpga/include/mach/smmu_s10.h | 39 ++++++++++
 .../include/mach/system_manager_soc64.h       |  3 +
 arch/arm/mach-socfpga/smmu_s10.c              | 77 +++++++++++++++++++
 arch/arm/mach-socfpga/spl_soc64.c             |  6 ++
 5 files changed, 128 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/smmu_s10.h
 create mode 100644 arch/arm/mach-socfpga/smmu_s10.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index c43fdee4a48..5b414c6e995 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -35,6 +35,7 @@ obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
+obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-y	+= wrap_handoff_soc64.o
@@ -49,6 +50,7 @@ obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
@@ -80,6 +82,7 @@ obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
new file mode 100644
index 00000000000..4a28b109b0d
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void socfpga_init_smmu(void);
+
+#define SMMU_SET_STREAMID(x, r, w)	(((x) << (r)) | ((x) << (w)))
+
+#define SYSMGR_EMAC0_SID_ADDR	0xffd12050	/* EMAC0 (emac0_ace) */
+#define SYSMGR_EMAC1_SID_ADDR	0xffd12054	/* EMAC0 (emac1_ace) */
+#define SYSMGR_EMAC2_SID_ADDR	0xffd12058	/* EMAC0 (emac2_ace) */
+#define SYSMGR_NAND_SID_ADDR	0xffd1205c	/* NAND (nand_axuser) */
+#define SYSMGR_SDMMC_SID_ADDR	0xffd1202c	/* SDMMC (sdmmcgrp_l3master) */
+#define SYSMGR_USB0_SID_ADDR	0xffd12038	/* USB0 (usb0_l3master) */
+#define SYSMGR_USB1_SID_ADDR	0xffd1203c	/* USB0 (usb1_l3master) */
+#define SYSMGR_DMA_SID_ADDR	0xffd12074	/* DMA (dma_l3master) */
+#define SYSMGR_ETR_SID_ADDR	0xffd12078	/* ETR (etr_l3master) */
+
+/* Stream ID field offsets */
+#define EMAC_W_OFST	20
+#define EMAC_R_OFST	8
+#define NAND_W_OFST	0
+#define NAND_R_OFST	16
+#define SDMMC_OFST	16
+#define USB_OFST	16
+#define DMA_W_OFST	0
+#define DMA_R_OFST	16
+#define ETR_W_OFST	0
+#define ETR_R_OFST	16
+
+struct smmu_stream_id {
+	unsigned long addr;
+	u32 sid;
+	u32 r_bit_ofst;
+	u32 w_bit_ofst;
+	u32 secure_bit_offset;
+};
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 8a7d47bee44..3f91707ec49 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -80,6 +80,9 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_WDDBG			0x08
 #define SYSMGR_SOC64_SDMMC			0x28
 #define SYSMGR_SOC64_SDMMC_L3MASTER		0x2C
+#define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
+#define SYSMGR_SOC64_USB0_L3MASTER		0x38
+#define SYSMGR_SOC64_USB1_L3MASTER		0x3c
 #define SYSMGR_SOC64_FPGAINTF_EN1		0x68
 #define SYSMGR_SOC64_FPGAINTF_EN2		0x6C
 #define SYSMGR_SOC64_FPGAINTF_EN3		0x70
diff --git a/arch/arm/mach-socfpga/smmu_s10.c b/arch/arm/mach-socfpga/smmu_s10.c
new file mode 100644
index 00000000000..50be049538b
--- /dev/null
+++ b/arch/arm/mach-socfpga/smmu_s10.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/firewall.h>
+#include <asm/arch/smmu_s10.h>
+#include <asm/arch/system_manager.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const struct smmu_stream_id dev_stream_id[] = {
+	{SYSMGR_EMAC0_SID_ADDR, 0x01, EMAC_W_OFST, EMAC_R_OFST},
+	{SYSMGR_EMAC1_SID_ADDR, 0x02, EMAC_W_OFST, EMAC_R_OFST},
+	{SYSMGR_EMAC2_SID_ADDR, 0x03, EMAC_W_OFST, EMAC_R_OFST},
+	{SYSMGR_NAND_SID_ADDR,  0x04, NAND_W_OFST, NAND_R_OFST},
+	{SYSMGR_SDMMC_SID_ADDR, 0x05, SDMMC_OFST, SDMMC_OFST},
+	{SYSMGR_USB0_SID_ADDR,  0x06, USB_OFST, USB_OFST},
+	{SYSMGR_USB1_SID_ADDR,  0x07, USB_OFST, USB_OFST},
+	{SYSMGR_DMA_SID_ADDR,   0x08, DMA_W_OFST, DMA_R_OFST},
+	{SYSMGR_ETR_SID_ADDR,   0x09, ETR_W_OFST, ETR_R_OFST},
+};
+
+static void set_smmu_streamid(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev_stream_id); i++) {
+		u32 mask = SMMU_SET_STREAMID(0x3FF,
+					 dev_stream_id[i].r_bit_ofst,
+					 dev_stream_id[i].w_bit_ofst);
+		u32 value = SMMU_SET_STREAMID(dev_stream_id[i].sid,
+					 dev_stream_id[i].r_bit_ofst,
+					 dev_stream_id[i].w_bit_ofst);
+
+		clrbits_le32(dev_stream_id[i].addr, mask);
+		setbits_le32(dev_stream_id[i].addr, value);
+	}
+}
+
+/*
+ * Need to set the Secure bit (to make it non-secure) on each peripheral
+ * so that SMMU can access the peripheral
+ */
+static void set_smmu_accessible_reg(void)
+{
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC0,
+		     BIT(27) | BIT(25));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC1,
+		     BIT(27) | BIT(25));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC2,
+		     BIT(27) | BIT(25));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_NANDGRP_L3MASTER,
+		     BIT(21) | BIT(17));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_SDMMC_L3MASTER,
+		     BIT(5));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB0_L3MASTER,
+		     BIT(9));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB1_L3MASTER,
+		     BIT(9));
+}
+
+static inline void setup_smmu_firewall(void)
+{
+	/* Enable nonsecure SMMU accesses */
+	writel(FIREWALL_L4_DISABLE_ALL, SOCFPGA_FIREWALL_TCU);
+}
+
+void socfpga_init_smmu(void)
+{
+	setup_smmu_firewall();
+	set_smmu_streamid();
+	set_smmu_accessible_reg();
+}
diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index 651d9fc9cb8..6b219fe140d 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -7,6 +7,8 @@
 
 #include <hang.h>
 #include <spl.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/smmu_s10.h>
 #include <dm/uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -132,6 +134,7 @@ u32 spl_boot_mode(const u32 boot_device)
 /* board specific function prior loading SSBL / U-Boot */
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
+#if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
 	int ret;
 	struct udevice *dev;
 
@@ -140,4 +143,7 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		printf("HPS SMMU secure settings init failed: %d\n", ret);
 		hang();
 	}
+#endif
+
+	socfpga_init_smmu();
 }
-- 
2.35.3

