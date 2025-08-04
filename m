Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BFEC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C05083E23;
	Mon,  4 Aug 2025 03:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EQIq7jP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AE783E04; Mon,  4 Aug 2025 03:25:25 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC7F83D5D
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrTBbccSwJSxxllrlFLckqWG084oq86EoZ8txYOnlph6QcqeupWSEQWNxhP3ucUTLX2ypr1eVhxnYa7gFulhCUithXJQA9SmNxeERphYQOyQVghzpVdawvfF6y5Sx7iqsCVH3wU1yr9YaqLUyuUn8kzVs6P6zGvbf/rXxPFYDftwmtRKdMCwEyocjqdIyMBJeFEpbbHqA0IuF1xNrzhktlukAXc7RJZqdHzGRO1soypchhBlVaQPQvYXAvHcFNSwUZxpWWB2z5fbFN7W5/KPiMVdpRtU0+UcrlEBEEvJyRy6a+Bs/z7WSUFV+pXZmhFErcYoZvfRc8lYsSB4aIsVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeH+Postv+MIc3VxTePlx3jJ3LHPe56R5MGaQAcdzr4=;
 b=mrC+yPaTKM2BkxIWp46Isc/QfmkNulDBLD7idU8mpkslLtOiyM2Pw5TBnutwo72DM24sLtkKh3dpJbPKIVNrBvMJHWW+W796aFDBapTR9Hp2Jnu9piFfxmODkzb4rS1QLXkICuGLNs2Zgyl/ZUvr8e1g0s7G4Sli/qbSkZzUG/qNjXywtuhXyWHyYFUNYvz2IZ3VpWou6RtSdXgrC9x7do+qgbXHDmwgqiZYoyTe3z1gBMcqpXnwTKRY68lWJ/mUJCtLIYloOIFWf+zJyyBbnNNuK+0lyid0+4FwJYDsXeYz3jBsTbO7wURMzPWijW83MrQq5rS5hnF6/9Y463ZgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeH+Postv+MIc3VxTePlx3jJ3LHPe56R5MGaQAcdzr4=;
 b=EQIq7jP1+oNx5VD+gK/eodPO/+pQTWyonhVS/QXU9LjhH20l5tZFPVlc+e89i2yNtoR2zDHZfb8mk+a/IGz2K4WhBzm+LSP23iZH9xkzYS7pW/O/weT1VbofGF1/IS884+YnWJKfaQ6HTSIMGaAbPQFhlBJl3x5MyXI3jXQU+quQa23ZkdPQ8/L22vCdvzXCjckpXcs2FpmLSfFzIIwZ7v2yE5GaUmLdJKCdiSttKsSs3lKcY8q4SKXM+IPcbUUVdqtxbrVaS+/X+cR9DBzAwhTKcv+24amlQD/Cupx0YWh5wyDwsLEPJkMeOa8Xgtt1Ky6WVmi+9flWDAkVqgWMAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:20 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:20 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 09/34] arm: socfpga: agilex5: Refactor system manager
 driver initialization
Date: Sun,  3 Aug 2025 18:24:36 -0700
Message-Id: <20250804012501.21811-10-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f89f248-df04-41bf-3ada-08ddd2f5c730
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ici8LapO5r+KHqrn0Dq1p6b3zlygISOo+jg8NktrOOAHD+DqJb/pO8TJC+BC?=
 =?us-ascii?Q?2RYXZ6ottdPGrpFOC++o5t/fXixgM1fEkK+uoL3qkS7UBm2/xXw9IcsRCNT4?=
 =?us-ascii?Q?x/tZlthNzvPIYJs9/offJP/6AlwQP4iO2J0leCjGKyuv1ay7SI5Lcb8z+xad?=
 =?us-ascii?Q?YOrttDwDWXRJKnkGESeQu9Q4zANYvhvxXNfZW/D1AJMKNMFkTQZ+C/lvH4Le?=
 =?us-ascii?Q?bfDjRKW0byrpuizinuhoQFJNMAF6QRgE4yJRcJMyXIz3awRSp15CkYMIue3N?=
 =?us-ascii?Q?h1D25j4dx+sHDBn7Qd9BDNXrOKlipT7KQfAfnxkNNGiWI13TeAXUh3lMwtZ5?=
 =?us-ascii?Q?AXYH+gtNr16t9zeoOadhI/Dkex0KdEn0YxjFbVpqwDcli7MoHJn4xXc0Dq0w?=
 =?us-ascii?Q?/oaOsAHz4MZ8Ar0z5zGtgoQ8UyddQFb0tTE3Mfa+aZy5Ktuy9PjvbV0r/aYT?=
 =?us-ascii?Q?vW8GZjw80WtGHdjHHCR819ofgYVDMvwACH4q/+ICyQAHoCaWAarXEoFQYqbL?=
 =?us-ascii?Q?57+SIk54O2/N53jtz2Day3ZHZ8DWlsCzzzQNZ4ieYn4m4T8XKk8/jL5ufjvU?=
 =?us-ascii?Q?B5ApP6rT7+OQCpF2o9JL2CyohBrPkDsNEGVJM6DWm5K1Ma5rWyZsJY+7kGd3?=
 =?us-ascii?Q?Z+4FBd+1EGrK9bOffok0IIuLrHTI9aWc2yNBJUSQS2ZAwonjhY+fVFzO0TZ4?=
 =?us-ascii?Q?BL9xhbBpd8+hUC4cXbjrakby1+WbbaDQ4eKfb8n0R4Q5Ue9z+T/DPIsmJKvv?=
 =?us-ascii?Q?m0IBIsmfr/n64TRyhgWguqoqHxnLQNoOnZMZeU7ytA4ilL9sKCTcTfHxPHan?=
 =?us-ascii?Q?d4oNKBmL8POuB8kieAPg4Uyz7/rOV3/55YVV+i52mQy9CgercUoGyMgq3I5q?=
 =?us-ascii?Q?seBFlnX81RKnkzCxPQb5J5xOXJgrN2+3bitj8M8ZuUc9cem+JvG63GuEsPmt?=
 =?us-ascii?Q?/NYa6f12xo/R83+IvDUZk3F2aZM1cW/ynJTseQSMSs+NHIU917jh4Iw0u0LF?=
 =?us-ascii?Q?gN6nMdZ5icP8PrnbOTBwvR+nmFEF/US7YXvJii3JytUoVSb2ZUmoCmFn280t?=
 =?us-ascii?Q?fiFBL3+hVtV/gRxat9CETJmyTTHZ3DAwTkpBq/zKyQ6MMGf35LI7BVpJQUuM?=
 =?us-ascii?Q?NPrZSflzwkV/WftOg+Y5HG+fsuoXPp9XIEZvPM2PgpoSiUnu2axABpygHDD+?=
 =?us-ascii?Q?VEwGdgLa4pV5njuSilFths0ZbCK5GdKZMVw9TRqotbKaGN+ARZJJ+yfTtX7z?=
 =?us-ascii?Q?3k2wMQFPJn0n+bCjM9WBZRqg4w6YNj1cdsC9JRb4AYc3gc9u4nOa1ZYWzkhi?=
 =?us-ascii?Q?WC3JUYhkR8MYtqR78Tv+izkBLNKQLvKSWlP0A/rQTgaZyjnx/lMgph6NxRU8?=
 =?us-ascii?Q?Uo9Z/PdwlltJSKjTu4S5hQoVbr2Qcl7HWjeWAad5eQek8lWryeyccR7LBZel?=
 =?us-ascii?Q?s3yGlrFi60w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2w/f6EhW9m3doXsgzkYwoilJS0EQW6pShgU9oUH5HQGcde4/e619zWO20tMf?=
 =?us-ascii?Q?PrmY4o/+NEfoEZkrqhkpYZcrxfQMb3WWLWnb9VJ6aqqKTXlrLIiPYxHdVhzT?=
 =?us-ascii?Q?F5Sh+LJw6yG/SYq03d/GzBJvaPsTBwrvNjhmN3/Y9OK5Y/YnF/vyKuh5QeKW?=
 =?us-ascii?Q?XJuJ5SJD6gDgG6Yp1Mr3Rc6L7gatQ1E4hRVyexJ7HJsMVAdOctOCdi0RtZvS?=
 =?us-ascii?Q?GP/hhXFPeyTPjPIri0lwsFcx+k8xExhIxbPG/hnTRDnkauWi7K/o5Q3eKZNu?=
 =?us-ascii?Q?3dXFJeBlj9DlN5UucLuWXVn0YzMIYsf0/20f15OGwsy9Vd0GUbwsk8agBE4m?=
 =?us-ascii?Q?PI3S6UjynN3r3qhdzHp71CBcsS9zBLjIPVR/G9QUE2d5L0whBkFMqwVDwVPd?=
 =?us-ascii?Q?buKop+pDfGFEMgaQBh0Cb3GpaM6PWnV6iCanwpBEUhJbq3y0mDrar5fHYuce?=
 =?us-ascii?Q?6r67QSiTxgftiCU91EJyb+Vu87LEKY5JG/TXYXPpfhkJmTJ+393se3JDWdSr?=
 =?us-ascii?Q?m17J8zMzLujD3H/lhsuJx4xI9Th6o7yw9MMsYZ8aAYHoyq1jHAbR7ERd/cYm?=
 =?us-ascii?Q?ySUtB1KB7jdpORN52/CccqOa9C58W4UYCmzdJ3cYrbxbO+jyIoArcutqgpWE?=
 =?us-ascii?Q?rG51lMMHRflXSH7Fe/cC7yRaQN3p10EHgtuqnozy+Uw9g5QIX5JD1/JWHPY2?=
 =?us-ascii?Q?PNuQDz+741q7J7nBil7eYRWJeRjxLGOwoFMrRi35d/rbrjddyoNCqbIjme4c?=
 =?us-ascii?Q?z+pg2fCAd1MavEUJ6euIK3DDY4hbb8mP76ut7u0NcOn1DN1l/LGVJ4OVZD4U?=
 =?us-ascii?Q?bjKRqTI0eIX12gtSKtP/l4BsSoAywjNlnXzfpJFia4OtF7n47UEhXVfyMswa?=
 =?us-ascii?Q?2TEAAClWZxUOsDU010HTAU5EWloCRFbA/DT+s7T9p0PFZmcuZICXCB5y1B2n?=
 =?us-ascii?Q?zgGkQx0AEU1KPJO0WkFq4tfUTiXkFQ+5SNMBO24q1PEOrVC9Iv4od/rYplQD?=
 =?us-ascii?Q?yMIo2bue3gBzM1UBV1ZTGcc4+uLhhdHEmccWi7lDZ+eCRHGqTy4uRIpIhf0C?=
 =?us-ascii?Q?bVN85Eez6pPejpQwdfQ2ldyd0PTs2CyFi7RkTNQJ9L720r9woYhsHP90alFg?=
 =?us-ascii?Q?U/iIk6W1r3PC9X5n99VyWk6TENW9/xDHOwveukN+dV0yd0kFutlkoAx3pCgV?=
 =?us-ascii?Q?Mv7cMBCTeu77XlJffoP0U+ot0zTGhIlIgK5r6IYRF5X3XHKgRV11GkYlfhGX?=
 =?us-ascii?Q?6AENDS5LUChqsZcPAr+E8K6VIav2P9415k3UISy1hqOtsyzie76/Vv7ynb3A?=
 =?us-ascii?Q?Dlbzjs4tpf4/2kpvFwjoqLq7F/GjoLC6TmwjlKDh/dPRHx7ym7rEyxHkSy8b?=
 =?us-ascii?Q?43mJoDtE/ExzMAwOet/o6fCrSAPv07XQVxLquVZrRzFEWLCbNBpGor8pDeMO?=
 =?us-ascii?Q?KqstUN4t81NkeQ0d5f3L0hoSOivoC7yX0OzdngIgSOJ7nHhiCkn5BVmwcqUD?=
 =?us-ascii?Q?NX5Vk9VX+ahneP8umKW/2lLhpcQOlYCtmiMu1gWC2aKACqViWiu9X1cZjegx?=
 =?us-ascii?Q?PZpu2iN32hzr+yd0+wiP0LsqujTf6qfQ2yGbn5emfarFMMDcx4whQgNncJOy?=
 =?us-ascii?Q?J9DyIvWgbC2WlcwqPQSfgVQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f89f248-df04-41bf-3ada-08ddd2f5c730
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:20.8602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCq6GInmwILmcGbq4aZSg/lFwJjPF3uMrFQ4xuF/4XzAodOxOyfPymC/knb7EA0CyIuWkpvgwa/HUKo/j9++4sJbfyDNO7wamNHJ5IhnuZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Refactor system manager initialization by searching for system manager
alias in Agilex5 device tree instead of manually passing node name to
the device model calling function

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex5.dtsi         |  4 ++++
 arch/arm/mach-socfpga/include/mach/misc.h |  2 +-
 arch/arm/mach-socfpga/misc.c              | 16 ++++++++++++----
 arch/arm/mach-socfpga/spl_agilex5.c       |  2 +-
 board/intel/agilex5-socdk/socfpga.c       |  2 +-
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
index 86322d7b0ce..d6a89300761 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -594,4 +594,8 @@
 			};
 		};
 	};
+
+	aliases {
+		sysmgr = &sysmgr;
+	};
 };
diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index ab46415168f..b200c877d43 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -52,7 +52,7 @@ bool is_periph_program_force(void);
 void set_regular_boot(unsigned int status);
 void socfpga_pl310_clear(void);
 void socfpga_get_managers_addr(void);
-void socfpga_get_sys_mgr_addr(const char *compat);
+void socfpga_get_sys_mgr_addr(void);
 int qspi_flash_software_reset(void);
 
 #endif /* _SOCFPGA_MISC_H_ */
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 97e01140513..3089f823b20 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -11,6 +11,7 @@
 #include <hang.h>
 #include <watchdog.h>
 #include <fdtdec.h>
+#include <dm/ofnode.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 #include <miiphy.h>
@@ -274,17 +275,24 @@ void socfpga_get_managers_addr(void)
 		hang();
 }
 
-void socfpga_get_sys_mgr_addr(const char *compat)
+void socfpga_get_sys_mgr_addr(void)
 {
 	int ret;
-	struct udevice *sysmgr_dev;
+	struct udevice *dev;
+
+	ofnode node = ofnode_get_aliases_node("sysmgr");
+
+	if (!ofnode_valid(node)) {
+		printf("'sysmgr' alias not found in device tree\n");
+		hang();
+	}
 
-	ret = uclass_get_device_by_name(UCLASS_NOP, compat, &sysmgr_dev);
+	ret = uclass_get_device_by_ofnode(UCLASS_NOP, node, &dev);
 	if (ret) {
 		printf("Altera system manager init failed: %d\n", ret);
 		hang();
 	} else {
-		socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(sysmgr_dev);
+		socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(dev);
 	}
 }
 
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index a9aad5350d2..92b9db89252 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -51,7 +51,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang();
 
-	socfpga_get_sys_mgr_addr("sysmgr@10d12000");
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	sysmgr_pinmux_init();
diff --git a/board/intel/agilex5-socdk/socfpga.c b/board/intel/agilex5-socdk/socfpga.c
index d6628cfc696..60c8704b391 100644
--- a/board/intel/agilex5-socdk/socfpga.c
+++ b/board/intel/agilex5-socdk/socfpga.c
@@ -7,6 +7,6 @@
 
 int board_early_init_f(void)
 {
-	socfpga_get_sys_mgr_addr("sysmgr@10d12000");
+	socfpga_get_sys_mgr_addr();
 	return 0;
 }
-- 
2.35.3

