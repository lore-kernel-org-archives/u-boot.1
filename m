Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4118FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E93784654;
	Tue, 28 Apr 2026 09:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BMScq8on";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CFE84150; Tue, 28 Apr 2026 08:50:13 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55CE83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK3La/m1XtHxrpBq2kg+OSvOgaXCwft0+d+lmPXrVGi9SJFS8xJh7UYTRSpvEjGmiggWHuKL8TAOJSt+esF8PcOwY0xPrWFpVg55NXJGYoNabtSyOhfSdciefhl+lmNc3VWebGj3q+KmdHIvvAknkeD943YVJzLpJbvSVxpCayQ/VObegOMDi7Xx3QbxmQJHeCGA1QyjEqdH72V8IyDN3FujEP/Uf2Z7WbgP5RRFwc6YTlZX1TAhJIGle6ShS9dVgaa73rzAJmPxXFzdj5p1DHMcaiWtcN12sc0l7WwnyNMujLZP88FUah6dVd4C7d80Q/qt+OYEJd23KnvJ2OkhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL73ihL+YMnl4mCTi4enWBXlx1u/DORc8TuKCRxE9Q8=;
 b=mu58RPEGa2gg3GU+srhOTPb1/hGc8Ami/OyVmDZBNnybl6F1DIJiXV2vLpzmOV0+5RqXVSWDgpxGcxuNVeMP+pSXArOSdWDVlcT3FIAzKHE62Tnplccx9kr6KTL+AvSuvkASZB6oBpYHoyLrwzxiE3G4NM2Sw10xTZ+IfzQpQQjE+E+cj9R2BR7lkdL1CtHHkxSJ15ggAOauQSk8/xiBkWfP68KUQHRgoEGR5olq/mRd3GLSs1iCT8zl/C5hcGNMWL8EwqvmFv4ADYBLOc+drCVv+K7dHVeYXncRFVnwQIebORluQkfBITZOFANPv7Od5mUM+XGvRF24Ke9FZHfF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL73ihL+YMnl4mCTi4enWBXlx1u/DORc8TuKCRxE9Q8=;
 b=BMScq8onUzRLyL9+pMfdpAV+rHeq8gKRNMMah5hp2qphPEmD1h96yWdGP1a48w4aK2Y4dke/MHjDP4/5V38yaMnrTJmWsUrkLdfKZVjOzVa3e8VQ01e0kNtcmj0l9ozXbyPq7rqVdIcwcqaElTPmvPsvs78cRdeCbUVlJ6UHzVQV20mrXg4EPqNODRR8HFDVXDy13kWaeAO9l7HSzxnKW0g+SpadZeOhY/UjANmRSnt2o/m0o+9b+vy9bCfVEePmAX1ZUOo1mxxkIvyBqPcwEM4sa2bKc12qUGxQFoiaFoRz+UGRUx/Et4GbGnks7Hmt2I8h24AkeJjDD1yJ6nL70A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6356.namprd03.prod.outlook.com (2603:10b6:806:1b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:06 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:06 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 0/8] socfpga: n5x: Update Boot Support for N5X
Date: Tue, 28 Apr 2026 14:49:44 +0800
Message-ID: <20260428064952.3965-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f391aaa-3556-41a6-fe8f-08dea4f261c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: SY3RLC2ZVnTQugsSv9Ky8ZddKQ8K3L+XRmA4eVT9BdBBwaV2/9NNS5DgvrOVXeCC7DcvtDMkYwiUk34V3pCwGSODEMzJVWWZhrVZAcgqsnAMiywulswBgvkxrVprn9Mxf+N/bkuIFDK5yEsNdT5GxAC+jeKAQYlcqyILsktDuj4OnXeDwd3Ec4e27yBdYvISDkXKyiKELviMS6fgICuSLGoY4Y59pQOmLrpY/jmAUlniwZMpJJLhmu+92rVGe+nrkt4bUQEjJKUiAs8Z0M+VFFC/PWU0WcENyGyzxLWBpsLTv5VqqlAIWVS+FUrBxRWNrRbHCerqNf83ah9G+c+3cEeWrvECbFMeS3s6j8o+jwwnFhW9gYSHx5ZiM75RL7L0G8Ja6DWMsM/alozcxX0vTXKnI8TbP4rDpXiymc1OKDLx4OCX3tEPiY1wSg48fNLpxDJt0pPcHovQQYGafBlNyiovUvxu0/OxFiYX3VHuHC+AyB9smu9PJkkNr3u7DEblT3Frl7qYzox4evOaN0woDmlG2dLCC9oADUSNCY1mviCyH3IoVKvWMaKI4RDLy8r4uoO8KW1yj5+KQDfWcyXiZRJmaabVzO1cAtgCbuV94oVtsTaU4FnIZKDDI9vTpOGfKW3SRjpbm7kMxflWM/5W8s99qFOTWJR9J8iPCLws2PVPSAw7OG+Z/17lzBCGTL54t/RcegGuUAwlPZgO6MtaNxIe9BhRqOdB0GpOZDAZHAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oqf+suGqkUG+U4G94/G2BSE1gOo8glbI+8JKynkFuL8fmW83NyV+GfrmA8Y7?=
 =?us-ascii?Q?XhUiYteb0eFt1JC6u508OmSK+v93+jhrtLp4fAP9xY2symoXz8mo405ZDGTa?=
 =?us-ascii?Q?joPwk0koxwQkfX97W5puIMKupuf8eTTMsdkYBMnF+QDu2qBDhqdk3DCubB/L?=
 =?us-ascii?Q?KP/xvfenT6a8mzWEuoi2xBMuGQ/mI0H8KPriPp23OoyrJz8KU0JTY0S13nrV?=
 =?us-ascii?Q?UToAWGXokVDntyGdZ5z2P+fSmztEZ9RvptpNFlmvqwS3XaYj1w7/ap7goe8L?=
 =?us-ascii?Q?8EEjK+F8vtKzrOcoZpwf0/vw4WgO5rQ4XMDIUn/Gke0ulaOO4CPw6AJgbKHe?=
 =?us-ascii?Q?puTLyLS/w4xhBizJ9sjsOtV8c5jz3//Zkh4+LGBWijsTWLM/LQhTACf3ZEkt?=
 =?us-ascii?Q?QaBr2sCW8VQhNxYOEhyJEam0JoV+KITWxYKuZ8pXPWyMbpjqy4nb81EqSJsW?=
 =?us-ascii?Q?9i8BpTUjP2o9X+MNlsbCK26JiGZbahbO2BGQgs2vc0PegZoPCbjFbtIkZBYT?=
 =?us-ascii?Q?i6WCwelGuQD+fsRzAy+j67aQxwp6yGjxnQCOEq6JMvJ/staLU65lWPBITAko?=
 =?us-ascii?Q?q9mNY5EKdfKdvXeH/cR5iVwbr46GZOpGNwjbhGdDAeyIUualiFCsCvCNkSRX?=
 =?us-ascii?Q?zjEJhERFK3yQcfbR+s+dohsAioUit0yLRFu+v4wsUUzKW/n2M6h2lEvqWldN?=
 =?us-ascii?Q?orZFKhPsOJpX4SodERI5gd5WIjyIcnaUh5o8XVsYdgOCxxzwb4uEwjH0pShp?=
 =?us-ascii?Q?ewoTA+GDahs5+YPGQCwr/tB1zKxP3muuWW08KNfhjYO3rEJ392JiF8RNxw3u?=
 =?us-ascii?Q?1YAezrZklEbZEOqkMHJena5BtAlqmNmUmUQNyOKDTIvKJ1euLUR348eCDBDc?=
 =?us-ascii?Q?8T83mY9aQHrPUmH2eueRfdWEwqYPGXpiWNLCGVS+WLjMFkV3fisNDnaABIPb?=
 =?us-ascii?Q?7m4kilQ3Y4FaIeTYGomiz6Da9yD8zM760jr5FvOF7k13yNV4k5BA61tNOM26?=
 =?us-ascii?Q?iuisIuNsmtLF+PX+ZlXGzoqjPFG4cBg3USAo2DUEH6BEXXoS1z6ys6TYL15O?=
 =?us-ascii?Q?k4Rfb9LuGYHAW2RtFoOpNGruxKAPPWqLy/Ws0nF9Agfr4ZV6yAeSdbXKF+cW?=
 =?us-ascii?Q?gc1gLLUHEe24IJCLE2IsbFediUKhH7old1BY9RhKnrk1G82eqDHPNrJD4HTo?=
 =?us-ascii?Q?2CxgYqi867GFxYeLyKmwsasvoLeJs43JvszHT4IK6rym8c+Nhl23jhUe/3e5?=
 =?us-ascii?Q?vKzkFpgGgiJytFkdaMADCesDM5HD9fTzbN9Z8IXJpHIPoQ1GiJPmtQT6R7Ao?=
 =?us-ascii?Q?ZDm/E/VVYcZmBlH1Y4d6HUojQ17qAfpmor+mLS9HqJbK/aBtkQ3OEXI3yEIr?=
 =?us-ascii?Q?zUD3Vob4e0q7RFmqY9k2sIkafUxhtJyaVQkxEUnUDiGKE4nkSd9TKFYCkqVL?=
 =?us-ascii?Q?KySv2udEbKc8MWX/rXEQWaF11Gf78N+JSdF+CaZ3en3iSuHwbJl/VW2ooI02?=
 =?us-ascii?Q?xlOzpj04MpeTvbuwf6MueaPIeGzKfHkRpdn8YIjBPrns3L+xx9jNrmKxh2ZA?=
 =?us-ascii?Q?SzNkgAF4C7Gl43Gqnd5vNmEzUnRLF44O8iiYKg16apbYMAmIgKTdTgr77/pN?=
 =?us-ascii?Q?zI+6c5hSc9tFt3SVY4Mkp0jx09omI6U29UDy5J4Tz/ut61hO6Ov9MA4VlMmH?=
 =?us-ascii?Q?6GNezUrhmXmdljKO/ietfA3lm4XErv2receawCjJvsz/6s/1026DB5Y3rU22?=
 =?us-ascii?Q?m/cNoabJNwsxNGeBz8BHukXtd7wGTYk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f391aaa-3556-41a6-fe8f-08dea4f261c8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:06.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ds19WgEbB3qc41VCPCJmmx0uDjdMNZJigigCFemqCjxqqx0rat2ukPOO10eOZKpui4tZDBC3H9t0tOqGJ9wSFn7u8mwYwVK+JbV3TYWA1R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6356
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

This patch series updates the N5X platform support:
- Replace defconfig with ATF variant
- Switch to upstream Linux DT
- Convert firewall setup to driver model
- Add ISSI QSPI support
- Enable DDR retention and SPL SDRAM support
- Update SPL data save and restore implementation

Tested-on: Intel SoCFPGA N5X SoCDK hardware.

Detailed changelog can be found in the commit messages.

v1->v2:
--------
- Fix patch series submission.
- Clean up redundant DTS override.

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/cover/20260318030034.25889-1-chen.huei.lok@altera.com/

Chen Huei Lok (8):
  configs: socfpga: n5x: replace defconfig with ATF variant and simplify
    VAB
  arm: dts: socfpga: n5x: enable DT register settings and update GMAC
    nodes
  configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM support
  configs: socfpga: n5x: enable required configs for DDR retention
  configs: socfpga: n5x: enable ISSI QSPI
  arm: socfpga: n5x: switch firewall setup to driver model
  arch: arm: dts: n5x: switch to using upstream Linux DT config
  arm: socfpga: n5x: update SPL data save and restore implementation

 arch/arm/dts/Makefile                      |  1 -
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 55 ++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 18 +++--
 arch/arm/mach-socfpga/spl_n5x.c            | 29 ++++++-
 configs/socfpga_n5x_atf_defconfig          | 89 ---------------------
 configs/socfpga_n5x_defconfig              | 31 +++++---
 configs/socfpga_n5x_vab_defconfig          | 90 +---------------------
 7 files changed, 115 insertions(+), 198 deletions(-)
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

-- 
2.43.7

