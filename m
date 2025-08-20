Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD30CA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 07:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7618307F;
	Wed, 20 Aug 2025 09:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="g8g/za+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985A382E67; Wed, 20 Aug 2025 09:32:30 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCB882F00
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 09:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSjC51gU255De0fOclr35EPbkoPd+YCQOr1CgMb76eLvfhvS62zu1HEevSvsc+Qag4VO+xJbdxFU24fCCL/lHGXgQ6qDVCAyOMGxS8nDnzxLoYDOufBmEJtHdiePnJZeHMAQC0jQ8JqjvmWxacLD2DuRHsp+kSeRzWsWJ3XSIsgvlgZzT4CdQj9yQ3UHo5hHVgF/h9OK3cqQo16whbl+lJlRrvlmTokf14xJsBpzYkapIp8/iII4ScQvZDnE7fY/E9QcwxM0y/WIKeud+1tHYn0kagQPNXIlcjkqOv5kM1iZJ+qJr+ufAMGhB4DQcr0p4LAh0k879+Im1bshMm/jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REl4W51vK9jPxHS9+R8Var2i7q+JtnOto/6IpSYB6Lo=;
 b=VBrK+p8s3hmErxFQ/c9WCN5ydUO3if+2kdk6+l45fBtGrvu8JTKe8xV08duMQ2ZDF8hYy9pSQkJS9bKu536uwzSdx2jzDAgYjEP6508bAO4IiFmvmhpJOSOhpXSUwE8hSuhW1jLFW//pjpPvyUWGe2xNUl8vgPXOJ27cNJhThJqOO0+bgR4gKm98w+WDZ3N0hs2Np6C+Sn1jkiV4ybzTFM6E37fWixuYPwsBI869tDxpBx67sUUf2R2gnmg6BZpgG0qCvwNuDODnf3v5XBSc9XsjuMWdTvLmavDrNCcw7RNKPUbFB7BnW5cKHtHhgx7wofJC+/vCKPp5d8hFDUUl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REl4W51vK9jPxHS9+R8Var2i7q+JtnOto/6IpSYB6Lo=;
 b=g8g/za+GV42BYAQ6SMVhOkYER2aJ4CV5fB8jBt5QAFEKBsBAa8SM+g+rwPgbHO5wzlKhHFqkOg0b+TWj57nUgdvhaEkWJpHlsneDujltGBZAHEZM5YMWAna9XJ2fZF7YAw2B5KiVFMyuwEYruJW/kpdw/UsvDTredRWKWPiPbpLh0CVAZdRC1xNz6iqPdK2pfqE3H0Ajr6TdZ9AnJDs3aEvpHoLGb9qwDQloeYEjfaW49M0q3njoV1texqhEK/8AGOYyhX+5g4cXNpRUKgku1Pa6VRhXf1MHUdDLgqsCIxdtX2+vJO/grjUZdTouJpwIRaSAqVO5zuomfSO3rjKiqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 07:32:25 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:32:25 +0000
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
Subject: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't exceed
 512MB
Date: Wed, 20 Aug 2025 00:32:01 -0700
Message-Id: <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66b6690c-0154-4d6e-8def-08dddfbbb532
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vetpsP6gPaDVUnDEvHQhV2ZJ2QHGHODR/7xxi4Fjk7W07UwWnb45kF/Glnk5?=
 =?us-ascii?Q?YgHAKb7AhhLAoUDBA8ELOGWrY8kC8IF0mprIAAoff55nWkVXIWoL1Lgtd2d3?=
 =?us-ascii?Q?O88BPBz6psPWRzeWjGbWjfEu3kFQcbeP5fkkfAj0ofvUKcmmrZxFLBZ9cdF7?=
 =?us-ascii?Q?1CFxiJpgCjtw/uoQE7B2R5MoLGrzbpE3WoB1Ab/JbaxD3ksbdfIFlz72dAF6?=
 =?us-ascii?Q?Do2TT5JoqJxWx7GNTQLkpr29ktQqQGjKCu+gz5iyjFb2oVwmT7eyPZb03Gxx?=
 =?us-ascii?Q?yPR9ckItQPG6lmGw6r2uiJmtl7Cp0leFTPQ0GR9RK4CfZ8V4IRVrpK+fKtE8?=
 =?us-ascii?Q?HhzZ5N9UGYrjoag86zztMAy0jjebKsRQoAjPtmKmzJz6VQE/OF7ywjve/YPd?=
 =?us-ascii?Q?BnBzLmZjyz2hvOp2Ifkp/uFxemaHkOrs2hBsRmLAwHDOpTFd28cQtK+Fh78l?=
 =?us-ascii?Q?Nit54aHJn0r1OQhsfB86icznzuA9GopXU6Wjac5NikzEYkPjLsrjDvzvl3mL?=
 =?us-ascii?Q?pBm7OYc+nWlvsi0d9AuwSAwUyHr3nHfu1IvJCSBFQozW0FJiVllseLmFCh89?=
 =?us-ascii?Q?HS/JyRKfGsxaznXRrQV/X05PLCdUTZ8h+rSVE4Cx4Zn/FShNouEL6GSNsXWn?=
 =?us-ascii?Q?GNFtps2BnCM71oipsj6qGdvedypE3Jep5Z/iXDS6a0Lat1Pb7CaHce6Af08r?=
 =?us-ascii?Q?v4+JjyCG2vzXfUlX+aey7YtbrI3CL+nbqi+A7HemnNFaTTyMSvYJaHq2nDRN?=
 =?us-ascii?Q?38hTMbzLP7jBcERx9VO7X+Bl6Lk3LbgbbJJ3uYkB0UM+gLd2qX0JNWR2Xr74?=
 =?us-ascii?Q?RjjhQOpyStf5SX0U6pfxgFcOU3gCkUQK9JIBgyr/IuDOFpfo9tr9sNac4J4k?=
 =?us-ascii?Q?VWxPUrsPrKOCVEFus1MpQxABhlkyMblgkXDu3bmStNrD8fNDoo61dKOHeZnq?=
 =?us-ascii?Q?lOFEs6yOSliHVYq+8I1B/HQ2yA103GESHFyetZdPkKaNsVsjhv1P3aQssO1s?=
 =?us-ascii?Q?QHaPDSFRGtztiVBhDGq/XcH0J3MMXKi2r93J+/XyasHS1CZ3LDJrRB1PggcP?=
 =?us-ascii?Q?2v4CbpLBhWcOnixvJLcnKxxMLwE8tBatVbWcltcsOU022Jez7bAMdVf+foJ0?=
 =?us-ascii?Q?LvQ0OGadQ3VXpV2UqKyusFnDI3uBHfZZBtvGxRqHZKxJVJq2T1ZmGs9ef6aF?=
 =?us-ascii?Q?drAl7OXwA2oi6wm28IAgQcd/1TdDB2ouVlKQbv9HU+mKyh8O2+I7J06bbQtv?=
 =?us-ascii?Q?GbDvI5M1h+EqLdu81+8lpWaIDLYqqLLuGisIacp//q3PMhc29sNc9YfcIpAk?=
 =?us-ascii?Q?W8Cvvm8nBt2wgeL8Wj5OsWqOAV1hU0Cn/gCmk9ost5wC2AKVRwqPj/w0FD4y?=
 =?us-ascii?Q?gbvmMVWJvWC6VSPmQY1IiQcz3qBFP/cVoOUUscnlZHq7LDrfBRp1dD8hA+GK?=
 =?us-ascii?Q?Q0Lbi3Dwd9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqSM7kKwWeCTaWv3wqm1oN/93PMJnJ8OlniWJhwQUloVddo8jW7++EKoeFoC?=
 =?us-ascii?Q?oNVX/IIYj9YjPVFiXCFuPXdrLryiNjhcfwxxohbqWxaOicmJI6q7QUyhc64E?=
 =?us-ascii?Q?LG1mD2NK3/qv5XHkTE69F6ts2XrJQE+rRQb3DF6EG//2bOllM69l54/NGLpY?=
 =?us-ascii?Q?dgYBe8jWdicUqSr/1tgXe3FsyrJ2HlPzsAQaP3hpIgAatyElWBn7hvr9ykXo?=
 =?us-ascii?Q?4ezJxr945I3DpKBRowahnCpXGmZgCADXHYO/26hUwsH0bNkEHxOR7835meuP?=
 =?us-ascii?Q?fLCNDclj/2ZOPGiB+sVsjyTo/bcRHYH+UojmFBBHV75WBnTLiWz/iFlPfFz1?=
 =?us-ascii?Q?yArY9RGozc0i6MHkWL/3EerJNYnYqTQp9e44M51k92F4uupeNvxJB5yHJecn?=
 =?us-ascii?Q?rCf/A4qPk6aVCwHJc67S1b3UNw1KFBehtGgWJEQoO02RGUVkasAhHgg/N0f5?=
 =?us-ascii?Q?DiWYw3t7MS26c+Kwl51elJC/J9ZWJlnIEBIGpdDwDFqz6Rg5Q/PV5BoTJnV+?=
 =?us-ascii?Q?YLfyqqe1WRZBG5EJUiSL/YU3Apyo5nKIuQsuPCkEQGJq3s2TF+YpRTolWBo0?=
 =?us-ascii?Q?tR8zUAVAq5Tn1SNLTbJGk7Lp/sonX86GbYQRcVZCaFyVdhX6vc+rep1gatNR?=
 =?us-ascii?Q?6jR87uakb6vQDAlnbJVuqdU2u21fbwUfwN8HKfjDGGfcupFII3jNFX/HA3iO?=
 =?us-ascii?Q?MVtI4RWo2Nl6EPLJ3o5gImYxSKM6SUuED5ELG/31BsFcWdop0zipPRKENw36?=
 =?us-ascii?Q?lD4cjeu2bQu9RGrqxIlCQLv7qnVD6OZQi0QGNHfqIXjYVVaPXnyeG38tT6uy?=
 =?us-ascii?Q?/WsYrFeQ8V99l6xkcrweRwLav1GC+7SKMmaA732lypxGQUbeofUAUAtcZCfY?=
 =?us-ascii?Q?T/EYJJxBC+0WI2X+jIIv2z8QxeVRzkWln10ElV/dJIbnLUjC/YDRIvmVeQCn?=
 =?us-ascii?Q?Zo7v6+4HFILytK+tomjpoFsR2iIFpwe2Br61U0sXlt4s6exmWuY0dUPlq3lJ?=
 =?us-ascii?Q?IxBWfwEIVq5yf9BrJikgYgOy44vm1T5kjfsN3O/jV1RwZ1I5FFl/1mTt5i+i?=
 =?us-ascii?Q?Do5ii8sUGyGMXisAx0eT6s6NZA3JOrtmVR9xph7c9pnajqJbxNisBeqw/SNY?=
 =?us-ascii?Q?2GmPjip/zqQKcpPDFWoVaXvKmP4g2DYfnX2CnR8CUqD0zimszx4NzPdKuVOR?=
 =?us-ascii?Q?uwk0i3Idvc34NAriwu2J/ewMmK+5cY1C4TykanDEKqJHL26D6qLvG5KVrlVI?=
 =?us-ascii?Q?EvACuGBFGPWAQbsDO9gNb50InilMMbkqo82GV43pUXu023mmtQJs2j3GDxZW?=
 =?us-ascii?Q?c8TJXfHhE1aagQO8nu1jTekiac2JeMqZkXHqvpDFL+k16BH5n4N3nOfuvALw?=
 =?us-ascii?Q?vtdbJOChaJqG1Yfjk7v4DdqFqv5Za8EXcCJ5m50f5aBJsRk4NbG6PFuGwX/P?=
 =?us-ascii?Q?D23gDRfLPrsmWv5pQsyE9UW4eB9hBvcmvxOH7G0TKNGJ6HnF714vtf+pV3a/?=
 =?us-ascii?Q?3r9DiJq5vLtokF2N9HgmJThberTK9YS4aHqE2GV1DgZw+uJgIRRKoTrmP01m?=
 =?us-ascii?Q?9yvkZv6mwqr7UM90BtfXUD9HsNJABkctoesF7hIyRehHZugvj9AH2BliYAwi?=
 =?us-ascii?Q?oYbfnrz+qsv84/RK2F3/GnQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b6690c-0154-4d6e-8def-08dddfbbb532
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:32:24.9444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/VYIF2bUorD7m6LGpfGAWCOtnAiTZVY76Rd5J5nOt5k8ktXMVwX9yWuXEzJKY0Pt1O2twbNonUzBzaxyeKaoRpvJnEgcNoYJvk3yMhad6LEQJ6TsZHx11tar5z23E2E
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

