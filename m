Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30864C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C87A82AAA;
	Wed,  4 Jun 2025 21:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KXeWuhSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5420382BAF; Wed,  4 Jun 2025 21:56:32 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED2282B5B
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtsw3pGmwnZMULRnOCKXEMnL4adfRy20Reo5RWa/vL0P/ZPPwmFq/9xhL/s4uwhj7KNkGeQ9Ql8ORAiiqnuKwTbL7uWA/0+AwXQEAGmFuVyo0EtFlSYrHbConcGdTmma0eSMN1R2fptQfwc1pF5fjA0wzRGPDpRccT2whTzp8R6c7jHQGuCK/CGmZi+tVfapXzqCbSY6eiWwXD6hTdBRzwlk7FKb20rGf0JrYwKNKpOglczesm5kx+sgMY1tJwj2OybLMwmpNvMm/mCkzP3xTBD7Ck0/f1z5PMB+hXlv4dJXEYPu9Vtgc/PRr9rNwAsw2loUJ6lwzvypnB8PAuOK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RNojcPvUIYg47qUW4Lrlrdm/psqr0+NG9dmFgZzwEk=;
 b=qHvGmgUHYUFks4xo1f67wDSy9JZnz4Hz0InKfkc4giCJlaxPUqJ3FcRz/DttGcCMlWfxWZYPwkaQ52toncEYmqo8NQKDqexoOkzZiFpn3aux6/SNsOznWmKxjxi5nDwWeyhnpCcNePK4Ra0mSn+FiZVfvPzT+ibWTOWAXjZda3nyBfEyohOSVK/DLlLaYRxVg0MQ6H81sTDXCx/Jv7rNDZhQJo7/8xNKoo5xGpMyIXC4yEH1p67ov10ZZSGNoUJ8UbMB506c1xyVcekZAILadwTRpPtLw30AtpwYpR36ofEqGLbUpEl8heUzgzc1ozK+vAe5U5b7DtiNfsntg/PwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RNojcPvUIYg47qUW4Lrlrdm/psqr0+NG9dmFgZzwEk=;
 b=KXeWuhSoWEIEV4eWnulrloC5L3HCg4MRDuyEB9iFZVrr/Rf7OHVQJeKslHpCrwR/ecjbVU+6FNV2+uPZEmyM+byYHHItWnu+2wXh4k2vCfiuspkTjTKIphC0gap+H/jUvL8to0l4FH+doSSW8K3bsoV9Mn4xd9odwwd4jvXxsR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:29 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:29 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 12/12] riscv: remove volatile from set_gd prototype
Date: Wed,  4 Jun 2025 21:56:12 +0200
Message-ID: <20250604195612.2312979-13-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ffeb89-42ca-4d2e-2207-08dda3a1e560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0QNNSF1/ynqVuVgQypkXGkWHrg0VKhss9S4YMAv8yiq2clxW5LbGNogkVoEs?=
 =?us-ascii?Q?Xm3pVanwMi8h3hea4/qmM1xjbASoxzbmoZvlCRCJI99xUTge9NnEqgfd4dk3?=
 =?us-ascii?Q?hXHtwSrR4Kdzb513R3KeK7czhAvdNB8gdZhi809IGqQCg0P0UidpJfjISQuk?=
 =?us-ascii?Q?6A0uYi9GxJzcAARcn6MY/1JzIYLyDJPmirEJm4vco5FOTj8UZWpynIRH1sd4?=
 =?us-ascii?Q?NGA0vFmDz73TqtwZbHzrZs8UChOUUqQZ1WH0dB3S9jcftw8ZgpjrOVceI7C8?=
 =?us-ascii?Q?3kivfnlASCbko0JThtOvcq0bHPFnC4CSFeOvMvuKQMgismJ2TrIhvZHhFVCV?=
 =?us-ascii?Q?l4GDAN/wk6QVWmWXUGCxmv/htzpjZXM4Lf4+xLT9BnhFIdNuQZ7uv87NokA1?=
 =?us-ascii?Q?PKdzuTHZ9sEOYjHTtBvU6tTDNOXqmC41BBnJMCFKLNxrGTIKps7IMzeSXSdV?=
 =?us-ascii?Q?jhWXcpgNg1PFq4HY2za1XodWfoluww23tFk0LA6RWMSa3EwjcG5smvxhmCm4?=
 =?us-ascii?Q?Bk+FE6CEMw/A/Y6O2TAjv7eRGYdq8QWMMFrTg2eZD7SmcJINI1niKr6MQGmj?=
 =?us-ascii?Q?MM0UjrkhSXe5iHzFw92WjpXEEPsbtM5/xCKLO9G7odJND0mFnUUl/GwEuNMV?=
 =?us-ascii?Q?0Ii93V9sXWhjftS0kls7GTNsgwnpbKN0LkHidJHl5NKyPCI8zukzHaudFqWh?=
 =?us-ascii?Q?4THpoS64bpQrKUrFp5TzPfo8VmSSiAtAMOt7ctFdP/0cdqLm3nLGFPw/qpOO?=
 =?us-ascii?Q?D0hNaViO+K4N4flS2Oz5OPto9dv3tkB+nJJD8qF7cWB0pNaIFQ2DDCLoAmLh?=
 =?us-ascii?Q?0yC6sRBOy9xUegbHUMDd2iQmPDYKAib3HJwYJAvOFIEkcKZ/F9Tod/C/tAxN?=
 =?us-ascii?Q?Zj30Fvs5+1bmkodSwdl3F8EGfSwSA6wxdN3/+qRRJfSvyZ4xfMRpCrMnDeaN?=
 =?us-ascii?Q?HIcejFEA0xnWbUl8Sz1eFPtdY/HUhPMxysJeJH1zzzaftrUI1rcNGc16tz/4?=
 =?us-ascii?Q?Hj2yeJeHGZ1USzXNNkSZxy61VgAj15m0KhanILEtg4ZMjLa+wqESd22fNVcx?=
 =?us-ascii?Q?Tw1nWtMmUWglZHBEGXmR06Ajp+5YnfMNlRPl9BlkdIKTIRG3xT3A2RiXgg8O?=
 =?us-ascii?Q?pQ3s5lKhf6Jcuki6lLT6wfBf3VuLaDEuaG7NEKSXMlJpdnNZC6qMXrOPy9lW?=
 =?us-ascii?Q?WWTFGzqeQf/uo5McoghMk4cx3MfIOi+PCYU7YXPVLv6TTwpzCF7Tqm20D4cp?=
 =?us-ascii?Q?99MFiZPnIugPZqSesu12KKNbFJgij7xF7mZNarzL1lsYTjJBIs428UbFBok/?=
 =?us-ascii?Q?2YBD4FpxPMDM4oWSMsbe6WNgSDiVjdnDqCK0Sbb5gesJ0BG8QnAvkKAfGGcr?=
 =?us-ascii?Q?w5lbusK7y2m5XHxQdV/kUaUKi+Wp7mW03mPni6wj4bsPEoaUBQAj5PZx+QnA?=
 =?us-ascii?Q?0GYzJs/expVSBsZA43O6dbjclML7oic1k57BeQrOX5SFxgVIvPkNPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMR0CW0hbfMztxHSyGybzK0q+9hY/Nm2n3R5v8iCuLuB0V/XzY6frKr+QTxB?=
 =?us-ascii?Q?6JNaCluStuzO12ACs4LfDJrrU/rVIZPH/XoDIHH68PYlE+pzSgqfpkHtIqXx?=
 =?us-ascii?Q?4n6kIg4uPfCnXGdfImhlhLgRnpym7exLebkRiHH4+pXEpqHwWyVzyAZc+3LT?=
 =?us-ascii?Q?SYpuahvjlDjHVd599tpuHGDfRmRhR2X9wOAtp7PkgabEx0G5prHxuGFkuSOO?=
 =?us-ascii?Q?e+a7s/LrE20XMx9CmXAxKAQnZ+18pIAkm/VaL5SNJ25JiGdAMhNcPHe2Viux?=
 =?us-ascii?Q?N42BCfpVOmsbJxT2eauGt2aJ3AQVgQO+mDkYeUnjlB1Dj2fEH2ZPnGiEap75?=
 =?us-ascii?Q?W4lMsitB45AYn8EWHQFj7v9Gq27EBJaK7n4xZ2Z5iAEkXThTsBWVb53bqzsL?=
 =?us-ascii?Q?To2hWOG177eg8ba95Y/G3G0/P4immlnbJjseD6468deBV6J3jlHrrO1lsgaS?=
 =?us-ascii?Q?A0Xi9I6XRylICGb55aYWSbkKU4F3zKm2JsRAr+rz0Nz6ed92PhsR1AzbqtvR?=
 =?us-ascii?Q?SVwTkLUoW/NK2ZvYGQtdrfhUZGeafqUWZWCsp9kBDM8qjGiWMfHjkcH5FDoz?=
 =?us-ascii?Q?Hl25GmRI50YYXgZDzmucwl2v5G+TgIefhiguIhbkswPSlMi8hy3FmxLU610v?=
 =?us-ascii?Q?rGm1N7FYcwW2Jvt2OkpSWSm58QYDF3EHoRmsAxNTkXvuFu0U3ZzrfjKZpqMG?=
 =?us-ascii?Q?mByyzSz/FF8hFWcCQreFdFVSnC2ne+gAAfOX060K+LGaRZDKixuwQ6QKPDzn?=
 =?us-ascii?Q?vSuOKHf2TMFVcEDAmv9UCRYc1v4FdyKIkT5zLSZ24XHuFB7Wml0QNu4ZAHVD?=
 =?us-ascii?Q?RkfZArKVis5e4dqM9GJKzanr42miUgrsbSptt1roIaQiAklbzUE5WWMrWHfO?=
 =?us-ascii?Q?xZT5VvEyP5qhR6af4hvdrWwFN/1cBhbOdE2lOkU3EvANmRbl6PadC0nEkMDH?=
 =?us-ascii?Q?xbISOq6zzeu7G3706nUhPrTsvxFUfG1eMbyLwRK7y6x14I9jQXjB28idhI7Z?=
 =?us-ascii?Q?p3Y1A7pY3qpU3KuOomvP/C1a9WkLbjPqm783EP8+7afENQMaLBtcAIS8SQKk?=
 =?us-ascii?Q?ViCV4uXQ3WTPp5Q4PwZiOKbvx5BkjZfxSLRKcfrb+fNnTJj7U61pGMbDNZzV?=
 =?us-ascii?Q?Kot2mld684OcruGyXG25AhHqnbi8uthY52MjVzAC8F1zBqQzH/6Qb4XHk83n?=
 =?us-ascii?Q?Sf71f+eqwABlS84kvAok4q/6jn53CQk4cmUi/JrzHSBnhz/suidZFbwjgb7p?=
 =?us-ascii?Q?1Sr0e9GKNKMFbjc7L0EH705z8F0hxKXV9jOkv3df2GixYUkbMX+5kJcA1CI5?=
 =?us-ascii?Q?488YZnHdOWtuZ8ZPs72GWddQxubK4ROgWjqPEMLUbxWbhfCRzL/5BX6yw444?=
 =?us-ascii?Q?CTGpu5XJJJEX3OiuCVArtQmv96kQOmQpTVbMbwhU+QhP6FFs3YYV5xbl7YGv?=
 =?us-ascii?Q?JUGjb5BIYgBCRfLB6wMpRMm9p84EBaB6B+p8iy1H/GjjfMw4Pif0AxNwqcI5?=
 =?us-ascii?Q?GO/dOdvliT78vIM8Tp83cGjapY+ZDU+QvTccEz9BwplLo+AK2IwxgtVJIDLU?=
 =?us-ascii?Q?/89UE9lpX/71NxwtUHHYryWdvBPmnpvasbrRgQUyDkFc00Vd8enrx6KyACXA?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ffeb89-42ca-4d2e-2207-08dda3a1e560
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:29.1159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJmXXMEloNGBgm8XMWjxPY2aOjn+qW0a+2lCmMiAXkeIGLgqQUCnd8XCltjyldqwXAMjv10dA9IyucaFDP39kVqiTT1YYDPKiobC3sfMvpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

It's slightly ironic that riscv at very first had the gd pointer
volatile qualified [6020faf62c3 ("riscv: nx25: include: Add header
files to support RISC-V")], removed that back in 2018
[40717eb849c ("riscv: checkpatch: Fix use of volatile")], and then in
2020 this helper was added [6b9966e1aa3 ("riscv: define function
set_gd()")] which needlessly had volatile in the prototype.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/riscv/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 47b5e2cfc8f..33f2b5ec5c8 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -68,7 +68,7 @@ static inline gd_t *get_gd(void)
 
 #endif
 
-static inline void set_gd(volatile gd_t *gd_ptr)
+static inline void set_gd(gd_t *gd_ptr)
 {
 #ifdef CONFIG_64BIT
 	asm volatile("ld gp, %0\n" : : "m"(gd_ptr));
-- 
2.49.0

