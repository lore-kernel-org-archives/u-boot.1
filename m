Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE07C3600C
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 02:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E695B8283E;
	Fri,  4 Apr 2025 04:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ir1akbQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC3D828D0; Fri,  4 Apr 2025 04:07:17 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5F4826AD
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 04:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apNDI65KUJrX9AlkSgZQ+Lpx3Lee9U4bD3zUCl7GR6XdX8TqRqUfBNmyF+d6RxdOid082UthJGzfrLtneBNnJ4eesWABOwCqgRSMFoGDgIvJzih8x48sYgFLls8luzMSNbly40rYlbv7czzFeM7ZdReHmV6v05ypbENk5roKobaEsMn+7rqmBljv/pcu+HmZ6reZO9+bYaRqZg9YsvEVhdXqQMQusQQtIJqfwYlV4aAJJH24vhDoEZZj/1O/R4XZsOoS8PnNKmjqzGg9HBXRzlTeQbrZ8I2eglkvv36EXrBUHCd32NrGD/a1eBTZ7SRgH2i3xzqcIeLfLuLe/iyGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v97wpx11oRuSEaqOI6O1cSX53/KrtH3X6Tk7xXiaSu0=;
 b=dP+6HgPqZSA4jcjqiE+QMMKbupNUrmKWs8nqCbLRo4n6SmcQKw6VLT9cXOnKs4M5b7ncvC9s/gVfXR5Ti57E0KurNEvEEc75r6lypARjqZpWrBzW5/brFIEDfd+tWL8/11mG2QnczIeI4yQVVdi67OtH5E/Bu25FKzIi7gCykG7Gih3ZIp8o8edZWIbEd9Dw8KyUUibq95wyWDLasTbDpuUw4M4N0eVPj0T4jhohNBKpRo6YJgBXKvPub911j2trRGO+XUYc1mEgJ3yBr1pfa0PQIZyxBkWvGVvfHl5FLqiWhfh/VyWzXDFE/CcFEGF9b3bP+bwKXMYrgW8SuVQkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v97wpx11oRuSEaqOI6O1cSX53/KrtH3X6Tk7xXiaSu0=;
 b=ir1akbQOlTridvb/6albwgwiQuLGdYbyBgWBtbfTnhLUaBxYsxoJyEvk5IdKrUvybKRUGCqNUj992+QJFAmVEQDaTrIKc0zaA5dNagL+H2t0oBFTpIt2A+6RPiHFSE36ooLwCL5RA2Y4t0n3z7veII+2BVfObiMI+++EsdhOehgFibsD/7p/1aS4oi0A+jNMY52vQNzprmq6jox/GraxSOCOHYp858zd8EQYC7+xxOh5GQkaFB+0vatwltENq+2Pr2BzlBCfkxwseaRRRXmGe7in9yI3FAYrCFuETXEHNpyza8HF+FFazDlOzSA+VYCqUmdHo6FXwkCgzymVFeswLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by MN2PR03MB5151.namprd03.prod.outlook.com (2603:10b6:208:1ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 02:07:11 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%7]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 02:07:11 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 1/2] arm: socfpga: soc64: Update reset manager registers
 for F2S bridge
Date: Thu,  3 Apr 2025 19:07:02 -0700
Message-Id: <20250404020703.4261-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
References: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|MN2PR03MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 278cc6b7-1819-430c-f912-08dd731d68ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QPyGwOBVFp+zK6HHhQ7isn/soAbveKbLmiwEsF93HOMaTh5TAZL5hLfQjcvx?=
 =?us-ascii?Q?YQ8IooAv2p0oADDCTLx34A/CjvUBi/gePtBBCQoI0Vy8lhLayKWcz9wGFpMn?=
 =?us-ascii?Q?BnHltxrxURs+naXNuGsn7MFbJSSvz9cE02/Hctu+edVRXAIVTYH/sr1ErhFI?=
 =?us-ascii?Q?iATzWEuuHWIrMiWdsKUBtrNp9JRtCkWns97g+A+LYXmdKl6ZI5iqgc82egIe?=
 =?us-ascii?Q?Pz1WVBbv1mK+hHXA3vWFWDsruLwHnUkuKzqjCPwEeceHAIfIaQ2dCELwlMEG?=
 =?us-ascii?Q?Mm98TFe/DeGkAypkCyT8RCbc/xhHci/Gy5NlFlh5rEUVxNlJfeLretgKHItZ?=
 =?us-ascii?Q?/26VtmQUJAtce+Gn8H+V20NphWB5JP3Ut3zEq2qi8Nkbqyk9dTBNjfFLOAw/?=
 =?us-ascii?Q?9q3BOyPWwQ9VCo1e3fiOy7CXr2n4mBi0gFUT5nv4a8ro4VgE0SC2rADcWS9J?=
 =?us-ascii?Q?CZr9wgrIpzANp70XhmaEwGY/9XaRlfI7effguGWfLHNgveq09xHzCxTdhJn/?=
 =?us-ascii?Q?e+Cnbuy30YE+XJX7Lk0HUE720E8PzG6IQPsJHDpKA59minsz53SzhNMhBTi7?=
 =?us-ascii?Q?07fhkAAOJ4jdUBxMs0Ass7PpGfI9N2CSzXkkf9LBZ3OxOvhJyUWsXZyWp5JJ?=
 =?us-ascii?Q?GHTc9birpm395vu5aox75nnkCJH2iwLcd3OwXfoRoBtfNDffsQJNUl8J0XbQ?=
 =?us-ascii?Q?u6TedmFDVYpyDMNtuGJrSBP1+jjfdRhdpjWv+H6KH5y0543fYXTqcY+8i52W?=
 =?us-ascii?Q?8P1lfiZFZ2UqhvepMkfvs6NJzSnkHDdxihcoCfZ+YrTvOAA9DIj+LK4DNW6R?=
 =?us-ascii?Q?AxgEwMfVFp3yRJ8obsAc9WJV6LSQZyDvhv2Q1cBGkOxAvuWRbFNH1oOK4cTv?=
 =?us-ascii?Q?fq3SjAWW1u2kdImwHU/w9oK4bPx9KRMoixUvKbLbpckS4UnUmfcBj3yGMuyU?=
 =?us-ascii?Q?6e/nNeH67dUMbhcOOlhcU/YdrFtRIMrBdVo4sVto0rvWY3I8XB5SRBy8T302?=
 =?us-ascii?Q?GkrhlnMoX0BA/oRHe+pJ1HHOJHKjWqGypNZszvVuDd0JH241sWuVpswCJaCt?=
 =?us-ascii?Q?mu7HaTl6ToaRqnAqQXyr42CPm2V5g5CvKp+dR85UNQ3lI2dliJ+D6hVY/6Gr?=
 =?us-ascii?Q?jwrAr1NDXg98zyHmtCcu2QZtlLcAsKgpd2fT9gtSZemqlTW8rZ5SNBRsJOrI?=
 =?us-ascii?Q?UTZa7zy6He2JxKJMj88at27DsHiyjPG0/RPDNBZWN4GXXL2GJA3WIiTfThrb?=
 =?us-ascii?Q?vqb8GVk/Nv2wyLj7BZdHkKUxFc8AXmC1zAm1b3EuCT3SAP6eMLivLVYM7hMc?=
 =?us-ascii?Q?XpOaeNjhKwpHhVo1HU8EStkX9/cJNgKbpWXjCDh5fruyIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LePNDPn+ythVXZ0wfLC39KAGJTRbiWRq5WRz/HHrJtd1I2CrKVC5r3kvs25F?=
 =?us-ascii?Q?YOq1AEKd5DmYpsrCt5M3pY6EEp2X5DZ1Yc9vQGrrQ3Nh10MjG8p3GDQpn0CN?=
 =?us-ascii?Q?vWDd2QW9EkhG7hwP9yS4T6RlIT97U/4QsX0eCeiYemrSLq+rU3F9wsWqNG3d?=
 =?us-ascii?Q?YX6aIdRCI9SXsISXrbst0lL5D7ehXViw+3y0p71253SysoY1oGKIRR1AzymM?=
 =?us-ascii?Q?ZGeu5nj0UUCT+esXkWQq9kX1TwNVRaJWWtytnyVXvu0FAKTYvFUTWIHiQdcG?=
 =?us-ascii?Q?t4vn8oP45h0hjH6Gql5YlLS6IoE4DcR6hBa6kJ36V/cKnM1iZBQ96k82n460?=
 =?us-ascii?Q?PoA63qUVBY9Abi8O14shlAbtQkfxXN2FU12ESR1XGVT/d4w+3olrNdGcN9wT?=
 =?us-ascii?Q?YyIATcVduPxxLpLEb80ukGibbe3NekNsl3VYXQLzM0mbDmSBKh4xKIb6oRqe?=
 =?us-ascii?Q?emHK3rc+nLCJ+3xzFZRrfYITh91IhgR5M2wo6yEIYRuMsjh9DZofM2vLY6KW?=
 =?us-ascii?Q?NB2Oox0l76GCaP57vnd+xyHDyeLr/rBDYE1qtT70g+4LWd+f/rhdheCsxnPk?=
 =?us-ascii?Q?JuN+dFzcvOkKKBE+hNPniE9sBrIV/HX+P7nCv+X0b+liGaoeIp24eRSXa5dF?=
 =?us-ascii?Q?6GQD4u+8tSNV1Jr0oNVoJY5NNDEe/nYbr5ryr8jqt3DbneE/RohwQk9+7PjE?=
 =?us-ascii?Q?+l+ckCEgXZ/opl/rmDn4SYSLenJxDJYW07ckT3FrZr2VYmWSFwPl3RuwnAzN?=
 =?us-ascii?Q?4w4XcQLNndZCzhpveGcKuE+oPk0hSy8a7O6hSUMlyqPkrncK0kaXCD9LIXfZ?=
 =?us-ascii?Q?740QHwR0ktqo1w1TKRXoO6+AbZY5v4UvHgcO3BfFDmu2eqretpyBIPs7KbdC?=
 =?us-ascii?Q?x3gJNigV+tBvjVoThu5m4JLTkroYUjd29+oogxuj5Lp/0Bb0TF8KVTAEb3vX?=
 =?us-ascii?Q?Oao8THhhVOIza4P+aruaR2gpKN5nP3X8+0lbdaD9U8xSCahUzxbIxPhh7dM5?=
 =?us-ascii?Q?ID74/mAI5Pjy8l/Fkmc6rvHsQwgdxBcbMO10PLTJcwJLhSk44GMTx6fioCcL?=
 =?us-ascii?Q?EBK5+xm2ls/KGV1Abk/GmCM2pjhLdP94Mho2glD54ZTJPApOBrhPfzNkDQXV?=
 =?us-ascii?Q?swXWpjB3UizPoAdHYFZXzZkJIINb6VX09yplUZwyA2ha/jNmsIOhQ1fHLl3a?=
 =?us-ascii?Q?P0I8CBHTSTEzjGDmpounEsMtT2yTEE0GGJDnKiCAsfVVuF6pzS4lbzJDjUo2?=
 =?us-ascii?Q?7faKkubTZyjF7YIzrUMpmC163azldUnv71hNyanSNBD2M17fjxT9WI+rwZtE?=
 =?us-ascii?Q?L/3Ire2mdcH8VNBLIEr6rWprhAWzniZnXbSxRowHUz8ua8YQhUul4fQCoYfZ?=
 =?us-ascii?Q?PHYmBUXVOcUTCY4sg89hx/weY9TJ5XjDDa+8JXRSJ93JKyeWnWRdfTB6Ld74?=
 =?us-ascii?Q?Yxo9+gL8NMv9tq9EOqBk5MO9zwGxmaA1XlFMGa/25y8+zspA5RKR1myZdb89?=
 =?us-ascii?Q?gowUEg1L+kQxsLzAeX5lrN5TcimCWPsZt1IOvv/v0bo9nypYZiYFR0YCftBs?=
 =?us-ascii?Q?yXXxbscBCp84cph+yAq0ccukXxLSSGxvEbjGJyyCF3cX+vFRk7izIzm7rvzL?=
 =?us-ascii?Q?t/N5YvIlHSY8jqzwT3D0xgg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278cc6b7-1819-430c-f912-08dd731d68ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 02:07:10.7619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiBr8FWyRPYpEwvtQkw261nBWhCIQamTOSonahyX6PZ1aOSA6QAj89Iwj6Q+ei9XHCUb7QyHg4ZyyQbaORki+pxZFrjazTMqXVdW66JTwwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5151
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

Add reset manager registers in preparation for F2S bridge reset
support as well as the mask support to enable/disable the bridges.

Mask value:
BIT0: soc2fpga
BIT1: lwhps2fpga
BIT2: fpga2soc

These bridges are available only in Stratix10:
BIT3: f2sdram0
BIT4: f2sdram1
BIT5: f2sdram2

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 .../include/mach/reset_manager_soc64.h         | 18 +++++++++++++++---
 arch/arm/mach-socfpga/misc_soc64.c             |  2 +-
 include/linux/intel-smc.h                      | 15 +++++++++++----
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
index 058fdd6e548..4b010be9ee8 100644
--- a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
@@ -10,9 +10,12 @@
 void reset_deassert_peripherals_handoff(void);
 int cpu_has_been_warmreset(void);
 void print_reset_info(void);
-void socfpga_bridges_reset(int enable);
+void socfpga_bridges_reset(int enable, unsigned int mask);
 
 #define RSTMGR_SOC64_STATUS	0x00
+#define RSTMGR_SOC64_HDSKEN	0x10
+#define RSTMGR_SOC64_HDSKREQ	0x14
+#define RSTMGR_SOC64_HDSKACK	0x18
 #define RSTMGR_SOC64_MPUMODRST	0x20
 #define RSTMGR_SOC64_PER0MODRST	0x24
 #define RSTMGR_SOC64_PER1MODRST	0x28
@@ -20,8 +23,17 @@ void socfpga_bridges_reset(int enable);
 
 #define RSTMGR_MPUMODRST_CORE0		0
 #define RSTMGR_PER0MODRST_OCP_MASK	0x0020bf00
-#define RSTMGR_BRGMODRST_DDRSCH_MASK	0X00000040
-#define RSTMGR_BRGMODRST_FPGA2SOC_MASK	0x00000004
+
+#define RSTMGR_BRGMODRST_SOC2FPGA_MASK		BIT(0)
+#define RSTMGR_BRGMODRST_LWSOC2FPGA_MASK	BIT(1)
+#define RSTMGR_BRGMODRST_FPGA2SOC_MASK		BIT(2)
+#define RSTMGR_BRGMODRST_F2SDRAM0_MASK		BIT(3)
+#define RSTMGR_BRGMODRST_F2SDRAM1_MASK		BIT(4)
+#define RSTMGR_BRGMODRST_F2SDRAM2_MASK		BIT(5)
+#define RSTMGR_BRGMODRST_DDRSCH_MASK		BIT(6)
+
+#define RSTMGR_HDSKEN_FPGAHSEN		BIT(2)
+#define RSTMGR_HDSKREQ_FPGAHSREQ	BIT(2)
 
 /* SDM, Watchdogs and MPU warm reset mask */
 #define RSTMGR_STAT_SDMWARMRST		0x2
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index e0b2b4237e1..104b24241e4 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -107,5 +107,5 @@ void do_bridge_reset(int enable, unsigned int mask)
 		return;
 	}
 
-	socfpga_bridges_reset(enable);
+	socfpga_bridges_reset(enable, mask);
 }
diff --git a/include/linux/intel-smc.h b/include/linux/intel-smc.h
index a54eff43add..6455335bae4 100644
--- a/include/linux/intel-smc.h
+++ b/include/linux/intel-smc.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2017-2018, Intel Corporation
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef __INTEL_SMC_H
@@ -482,10 +483,16 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
  * Call register usage:
  * a0 INTEL_SIP_SMC_HPS_SET_BRIDGES
  * a1 Set bridges status:
- *      0 - Disable
- *      1 - Enable
- * a2-7 not used
- *
+ *	Bit 0: 0 - Disable, 1 - Enable
+ *	Bit 1: 1 - Has mask value in a2
+ * a2 Mask value
+ *	Bit 0: soc2fpga
+ *	Bit 1: lwhps2fpga
+ *	Bit 2: fpga2soc
+ *	Bit 3: f2sdram0	(For Stratix 10 only)
+ *	Bit 4: f2sdram1	(For Stratix 10 only)
+ *	Bit 5: f2sdram2	(For Stratix 10 only)
+ * a3-7 not used
  * Return status
  * a0 INTEL_SIP_SMC_STATUS_OK
  */
-- 
2.25.1

