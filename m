Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D136C3ABB6
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 01:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD1481FAB;
	Tue,  6 May 2025 03:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ec3a8kuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F15820F6; Tue,  6 May 2025 03:21:19 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A1581F7B
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 03:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H81PYBLbAzFsZuLtCGs5KOl+3e1uS/k+w8qSE+/O9+6g3nodYJembxxJDH8le3FYFAwVcE9aFb52wWxuLmuWgH5kPdjiHHjUFLe3ttF3xNfWsYeMKMfZqb/xU1Lg2kAjGsUhwvFfPMr8ReaM+eojYbRV5WbVTrwBHZ4YA6b4jg6MoYj8MFYnINV8VqSfyyS0nZnA1sAHpIGIVp7DSvYeKONX5RdI5LHMmDaWawRZbZS6chdns15WB4mDFzP4jUmsvg8lj3rrY6STM9Cb7FrOCUyjrRlVfR/E2sLVEQnijhtf9wWsFzs8YLAVIj4ba3sUz5mF+0RCEHaCGEKS/s6EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd8VqBk63Zqw4peFURZMFIKe1UjiFymXnzgIocdd8FE=;
 b=S9jCX3GRDMHCbOIWo6k3ST9kRle/grSfqeTmGr9AwA53LvhJMAxhrJQD4KpTME532/QRA5RFNv0CALORO1YE2YJ8GHOcbdSiY8SDfp3EiJV7gpzXVlvwa9V+Nl4aIcnHzJC/WHd07tP+Yu58KUdihBHi0aBWymdgbMLUfILLRdPAmEB2/W13wtvqHXqwl2X2+5tg2x1bXQY1cEvB8P+OSKa9OR231JZxOWkv9XX4iAwlN8y67fvkaPmJ7YzVU6sraASMUyPrOuUz2Mv41xUtmfslfeyzfXmWoN2k58mxlpd8cVJJEAcfB/ybE/BI4jbT+wZe7DfafTEVEf8HYr7wTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd8VqBk63Zqw4peFURZMFIKe1UjiFymXnzgIocdd8FE=;
 b=ec3a8kuPx1ace+V7cu9eoe6tdlBfKJTG4dJLnYpG4IHzrpPWJuzTdTBPLmUdVJeZMxVAcJ2JAJdJCycymMhINjTcvjFrHwBUbGib2cGlncc4EeblonsPFpNbyDWykzFNskk8Pf12swuSBt8wmL4awUfaxZUHZ1HQ/ISukGhOdTKdDZIsoPOgbC82cGdV1Fm4ekO7NllGMHYR4HsHO6DuVGvjzZDOPCoTNsdV2d0TT8Xt8HhtD9g7g3PZa7dcYMhttljkjZ38fXzhfgMgvbShzDEQomEz3cD9gmfXKEQYWuwfi9RAn2boBvkZE1ecE4+o45ZjEyx0OFmVKVD8Yg7KNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by PH0PR03MB6431.namprd03.prod.outlook.com (2603:10b6:510:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 01:21:11 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 01:21:11 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arm: socfpga: n5x: Remove invalid configuration for N5X
Date: Mon,  5 May 2025 18:20:59 -0700
Message-Id: <20250506012059.25762-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|PH0PR03MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1ebf74-aba1-4577-332e-08dd8c3c4929
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iZNxCUI2oPT1lL/ZCkHpqsF44vBBSYyzIuyQd0eY3iaULpgknDJ1gL67dmP1?=
 =?us-ascii?Q?M0ssj4DYMb6+UabmWpLB0Un3+Q7JSO72GbRBiCHtIKz47mc2DmeVLlGbkBp2?=
 =?us-ascii?Q?6/MmNWYZS4Ni355PXSZYCknXZt5+yjy0L++I1aKMy40yLjcxtbNamEbuJo1d?=
 =?us-ascii?Q?lH39Lb2L4dapF8WDmc3WfTviMYHudxhP30raA2MF2vXS3Le+DcBvZAu0ZHCe?=
 =?us-ascii?Q?t/iU1s83OujkLIrYXCHdNFKKbXfc56jWfx+Die352gK8bd+K646+FsQeoUqa?=
 =?us-ascii?Q?TSfM1bZTHyJlcVPf/849qN3hWwbJ1L8T03U31Rk0uVtCk1j7KMNDQsdbwOKr?=
 =?us-ascii?Q?xuExu7vp+L0AbTaRdmLYxf6aM2Octv9mYLQwO+AssqHgqztFbGbGA1+FppJ8?=
 =?us-ascii?Q?aQAvyrdlrMQQvlL6b/JoywTEfR1MgPCipsd7KXxx6tmVi21sIJTJHQ6kV413?=
 =?us-ascii?Q?2M2LhuR50QHi5/Ixbzw/Gi4ypj0wEycUx9qj4nsX3mluKR6fePkHClNYZXLA?=
 =?us-ascii?Q?jJ351WtzTQ7wdAJkD6qz4SP/X69d+YxtMkyC1TyK3IDsGzFnlyiWyQND5Ky2?=
 =?us-ascii?Q?H0nJ9XXCp1TwhYSIlyOWuxCxyaY7ZAM9HBxkaInuMj6YEMmL0pYlLhJvAotl?=
 =?us-ascii?Q?kJihyQMIRlMIVXQPfDcXoroA0COuyOF08orXZnOe9yRIrHUgSvil1ksJf8u5?=
 =?us-ascii?Q?0dbXylz3NiMTvYhbu5Se2FSzTtP8PapfXjVveXE5YoeXoZKHxHM5Eb0yploc?=
 =?us-ascii?Q?dzeTfQ4jj2ekTw0otzn5O28CUs+qiG8W1mj4eyt8NFRFNX8I0OT3mZIYxF+e?=
 =?us-ascii?Q?EwUPOaubKn/Z4VEGA3moKJsxifXMuIIOG0aup7Dnsy79cn0AtZ/GGAZUDYih?=
 =?us-ascii?Q?AYgRhCLMNW8CHTipGao1YfgSyn/1f3wvPNYAHofYSobX2apidGdnO7AtMp58?=
 =?us-ascii?Q?7aAr34FTTlqLMJ2JLEPMOxroh6a9bnQYwcFg3JkVl3tDHDZyEh8ZVn3ydytD?=
 =?us-ascii?Q?CmmAo8yeiMJMKTgGczgb4EBq3CLJiYj5ENGtK8uvJCYcZGmV5ayOZw12D7CU?=
 =?us-ascii?Q?pp2XCNVMJ3M/SGfEhNz2W+ln06aXFKppE5BWpdyhedd5zNhBHVoGU+76GuAK?=
 =?us-ascii?Q?obbHRPFzT/JciiffdB7lVQqRNPde67JYvD5ZrX5TkGnSfBCP17k1p0YhpuHg?=
 =?us-ascii?Q?v8UIAMdVY5Sd+k2I3cukJ7RO0Zl/2nGdMsxmd333N7VBn6Kq9eawJ6eVHKpQ?=
 =?us-ascii?Q?Vev8Nwhr7lO3mNdgB2+5nVuf7wJVaNZ2rcrahWmvsgeUA6yDbxb3ni57tWDh?=
 =?us-ascii?Q?4yhAfo8/ZXA9LkalgJ+e4isBAswm8GXi5y2wZcn1dzo/DqNp+Rmw9KhdBJzR?=
 =?us-ascii?Q?ojorhRx/ekbPSrG+m//UJgsKr2hRRTRxhF4HtY7BIZGyu+D/B3GfvI/5mX1g?=
 =?us-ascii?Q?O1Jzyge9SeQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBbKKTtW51W2UE44kp0j4lJYhwIXQ6lUeC3sIqg0lSHltJLZ/by484SzDx6o?=
 =?us-ascii?Q?SLk/HMTKoAsnHawX4qBJB0YuPQU5uQ6uGFOhHdXjtlbiI8joVon94tWqWhih?=
 =?us-ascii?Q?Scn0FN94CYIjb5+yAKh7FNGo/2NJaSnqHRKlEmQms4MTB1fwE1LD1xkEsgHG?=
 =?us-ascii?Q?jU01HteiUInj8TtPMfnokejBgjCLD5VIU6PaHQdc7/6EOy1QD7xYoOSQ2gy0?=
 =?us-ascii?Q?9007CcWiM4OSz6+/cjNQzqR9uWv7wJguVgvGLsBE3vKvyaqiwB0vLnX7nROz?=
 =?us-ascii?Q?tDUFu61G9wboPZIW8acZ1mYfCKsVAnGn7w5fayQ8JrhfXXR1VsF2oM/49Dg1?=
 =?us-ascii?Q?MT1ndpd1CkG9t2R0BhM+XkCQLOsEpE0g6zDjiU3Tax7Ld3S5ayJQOxKAl12u?=
 =?us-ascii?Q?84XxZnrdG3YCOYJLepvI51eQvm5g45Cf8TT6Dp7gymIGhm2aqhg874tbgP22?=
 =?us-ascii?Q?+15XeHuwzWQc+srzOoDjKugvumlrFhLK7w2pSRn6bsBqRGG/yRAMnSkoCyw8?=
 =?us-ascii?Q?ZH3JIX8Vlg8VMn+tV+lOZfWnmxfPhlB6LpkGh9758gjF6jL8k2or6wtEwvDW?=
 =?us-ascii?Q?xjkULCIecoi539q1JFYxRUC6aaPhNYIT+9lXZGsuKFI/jvnF8md9Sw9Twx2Y?=
 =?us-ascii?Q?aL9LQa5Bn7n1kU0O2zMyvkQA+u+68XxmGlNteqE5jR/yFHKMoq+KnBQEx3H0?=
 =?us-ascii?Q?ZyReeMBjtd9cldiqKjrDE/WMUZgsMVn8yw4snc5O0n7leCCj40MJPgxy98/J?=
 =?us-ascii?Q?CxqLxolzBILTs/5t0S6Mb6k+plA/ThhU/A3dC0jyLEdZoYWRLQtA3VKAaYO2?=
 =?us-ascii?Q?/H81MssNA71RRr7TsTwjH5Tygsq0HiCA3hvr9iq4kcYYWFz1wu/zzwUrEnqY?=
 =?us-ascii?Q?AXl6GxIeqwn44/PczGkMMnUKXdkZbE2yArv4aggQhgjffHoQxUuwcPO8yie9?=
 =?us-ascii?Q?0bj3OvpR2XwhGre8KQ0XrSstahAXa8g3Dl99FQLWij7Y/y9ODRXSjNiKu353?=
 =?us-ascii?Q?d6Vfcpost9z+lqTjtTiwYAlj/g2F1Rn6NORKVKOh5cAeTsIfEZD9j7eFvAq0?=
 =?us-ascii?Q?kQivhp+Gla3bovPJU+A6QxhaoqJX3oDxbSHFoRGeO/n6ioLS2bt5PPpttlA1?=
 =?us-ascii?Q?NdcYvKVi8cFfdyilb1FyzzCcfo0AHStk4H32Zb0G8Kz7ShCPa0ivRrfbEl3L?=
 =?us-ascii?Q?H8o/GGSRGROzBIGgzyXi146vSc60jgWj1NaKf1v7qhZkguzzcuDDjqfqI7mh?=
 =?us-ascii?Q?3XBPJ9wFB3RqNhwOHa9+eJ3HxfluKA2bR1S7ZR4y3jv6g4asmK5GTRcqr1Oc?=
 =?us-ascii?Q?II2j22fN07i88mOYBXpX0Z9/OVVfC0nyqmDknVrWmXkl8YtWaWolRnPYI+zZ?=
 =?us-ascii?Q?4o9e7foYBGrC/7Ua9OUm9MMhVhtLhFE0edMwVKs0GdVYUaI08/muIKWCKzZe?=
 =?us-ascii?Q?evdSeB/HL4JLljsWPge4k0PSWDcv//4r9VFx9oh2y4UEu9p38WUlEgHU3FAj?=
 =?us-ascii?Q?8B75FS2B9mD28b8soe/RFn95oeyHoKiZVfepjY9ALj6l5Jb6gKeTkEBrlY+R?=
 =?us-ascii?Q?qw4Ga0CMSuydVXbRCtouxR8k08QKzV/I6Jm1FCMU/dqdXbbZp9KJj7Cp3nOo?=
 =?us-ascii?Q?tQtAtH7u0p636vI9kOZUa98=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1ebf74-aba1-4577-332e-08dd8c3c4929
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 01:21:11.2062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU74gH3PQWaUZgPWQF3ty266MF5y8PhfCUS1RzvPHpmIgeLHf3WnhMOTONflmnXMw/xopfkgqr9J7t4/YQinigHnHxDvh9vZh7e8QNRcXGd7VEXmtjfeExDFlE4Fsgdl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6431
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

This configuration is not valid for N5X; removing it.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index a76a9fb2a39..156cfbbcf3b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -120,7 +120,6 @@ config TARGET_SOCFPGA_N5X
 	select BINMAN if SPL_ATF
 	select CLK
 	select GICV2
-	select FPGA_INTEL_SDM_MAILBOX
 	select NCORE_CACHE
 	select SPL_ALTERA_SDRAM
 	select SPL_CLK if SPL
-- 
2.35.3

