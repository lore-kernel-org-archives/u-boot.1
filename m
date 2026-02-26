Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E55FD461B
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 04:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6950B83AA9;
	Thu, 26 Feb 2026 05:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R2GzD9iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3E083D1A; Thu, 26 Feb 2026 05:35:07 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazhn15012018.outbound.protection.outlook.com [52.102.137.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6504D83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 05:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpeZIc1nEJscxYRBtNYxNy5w1XLdvqTZko/pj9X0650rkBSWurbfEhnr33CWMz307bnYo7R6DPg/pTDxpKd+G+mR4kiz+T29Nf1CRvQaaSmI9e40xhuznW+vGC6o1YlalqugY9BUgjjYgfJeYG9lNUB05PVwU/sbNauOtvgn0y75kG4f67jSUZHJuVAoQATV9XuJOxjmJHT5rXbldGKPkG9UpxHbJbM6xEQFRo5DUMOzieV1daHxhXZEPDDUeWWnb1mIFEpr1dNV+N5By+M/tFCeg5ZNTRqLu1c5R2Vu0STV7qTSFzeaYi9Nyeu1NL7BAn24VE8wNjcs88/rrjCa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmvohP3UVOfHsCWYMDmd9EDjT3ycQ1jToEvQJdcJxZ8=;
 b=febEUsHV2kGxrvHkD6/8tN32i/AhX2nxCmb996mD4UpqFq+jC1BP+cOY858CFfmqmi5BWvxVW7W7/mjs0kRWxpVbVpoJJQ/M57iN0azj1FxRDGwqOk/Bv54e0/H9/5csKbCn4LAxKYHwRQdyZd4SsL2UvrqN/G65p+WNmoswwp79vi5W2luCawGzbx+FDWIHHM9HtDoFrF7HB+FqwDNysF0A7hTgi2BGHsQOdj17qKKQg4ILgc/24KOhnQV7c02VPmQ/JftFDzpewq85SQKJgvxWN3sew5u2pxUIEWIUQH0YGM+GK84zRi7lfDM1LmTNOiKhvG62mKXfaTf2EIZdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmvohP3UVOfHsCWYMDmd9EDjT3ycQ1jToEvQJdcJxZ8=;
 b=R2GzD9iTlIeINLsJDPWJ90aD2tK+nOut5XSHJrs7dKdlp5cH9dV4vDeDgZn8IPHjNBGEXis+V9RD/suRn8hYMpsoBDNlqAya2Pjz7AQ3CzelEH4xiWvzOrv6fNI+zZOFgXmK07+jnFVG+n2SOn1t/gvnYgk9J5cILvFRYBJxpQg=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 IA0PR10MB7349.namprd10.prod.outlook.com (2603:10b6:208:40d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 04:34:49 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::60) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 04:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 04:34:47 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 22:34:47 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 22:34:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 22:34:47 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q4YhVj1215599;
 Wed, 25 Feb 2026 22:34:44 -0600
Message-ID: <50d29e78-1502-4dbd-ad24-a1025142947d@ti.com>
Date: Thu, 26 Feb 2026 10:04:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mach-k3: Defer CTRL_MMR access until after TIFS
 version response
To: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>,
 <j-keerthy@ti.com>, <n-francis@ti.com>, <bb@ti.com>, Diwakar Dhyani
 <d-dhyani@ti.com>
References: <20260225051559.416445-1-u-kumar1@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260225051559.416445-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c7aecd-e58f-4044-2fc0-08de74f05f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|34020700016|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: SVoniu6oBNw48ohPI8vmgMUUIj9+J1I21S+bP+d2d7qR2KqxezPGOdrIjBxbDZPxPalQlNVOEZ4ZY5xtaOOc+qiefsGIzPxf+ICD2d0llQObAaSOgoZb0C+6lRrps6Wqr6z0oTBhwjgpYjqcW5twFHj474cXYnCZgB9g6qiZa7MzWuZvLt5VSePZ9NHA6gLsJsI8AflPLDDHF0Ft7qv1Vy7uDNDeRJSC/Eu2wE5fI/zlwu/GDtVC+DIs3Q/ME+NeDqAncV2dT4I3u5w6SXR2NtsqJhy6B/f0ZUQxS/jJzsxGYAIIxKtW5Ca3reE3qIkbUK/u6BxDpCSB/m6xkJ/0GeAjI8QWLscYFzB6oBz/QjCZ2veO0mpVs2OL+wlBJM3cGr8JP8yKkpV3uqsTFVwWGADn9C5ErbSIjVu9fcv5pE7rr/SUz8Msyp6JXj2ahuZ6N+f57ds+NLClziAtBcyjATQYzrxGMy3Gechiwyfq40vwqbFDr/+M6ArVdq93pYTh9Qm0XVz+y/gzimOwIRBpEtKvuN0q9LGcupCnBrYqmowqbLkA2ueDzdqVjHb/+bipYRG7KoxcWKqzeIXyN9oWdTK/yX/Rjx7jaal7c4I1Z2pyf6K3JbhifscqS2XTWFYzJ6pPtRFhabzuPjXE2IBdtWPDgBAd5Jm8QVJW/0sx2vXcmBSfGJfVwFJ1mT/+HSIgTWjtZKx0NXQqufvhvCRjIH9gxvr6Pkg5JU891/jbLLD3mysGM9NnqMtk9D3w5BsvTqu4v4N8uLeLbxig1xjM3pJwW2Z13gaLecNk//9hW2U=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(34020700016)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f4KihUkqkuv+gXXXT+YB/tmtCsi5EaJszM1/c0haTAYNUt/GFbjaSxj8Dky2uB4CXJMGuPHseQTiNOnxgUbiNrYflGRoZE5bZc12bwEzvrGtQl86E/JPEO6mSe0klj0WOl+EMjJT1mKaa30KdWjszaC+QlMltuSyFPEIwahYGsEiTf+YrrLfkD2QkSKomoqZtvmHb3qY6QEeF9GPvLVsXBhOqRdghPFPHSlRE6PebufuNPCRfHg/tISjenl3vN6mhay0XsAR8z+aZbU43Rhka0SlbDswIX4YZjRquoetl8LsWwnypwci5m2r+ZqjkZLsVIfWJWSWIwQO58o1tkhS7RFuqitLXwuOB5QntJF/rmhNuijY6LQgnPsxLZgimu5gfcanXcSelHZPvD2iLt1LKz3Jq/1ahsAh9mCn06SHymjkbGijtrJADbwnak/XkFAu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 04:34:47.6786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7aecd-e58f-4044-2fc0-08de74f05f94
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7349
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



On 25/02/26 10:45, Udit Kumar wrote:
> The CTRL_MMR registers are firewalled at boot time, and TIFS unlock
> them as part of the system firmware initialization sequence.
> 
> Current code assumes the CTRL_MMR space can be accessible at early
> stage of board_init_f execution by unlocking them.
> 
> But on HS-SE devices, TIFS takes more time to complete initialization,
> and CTRL_MMR registers remains firewalled and not getting unlocked.
> Which results in any write to these registers are ignored.

Hmm, this looks like something that can happen on other K3 SoCs too.
Should we update all the other SoCs to follow the same logic?

> 
> So, move the CTRL_MMR unlock to a point after the TIFS version message is
> received, ensuring that the firmware initialization has progressed and
> CTRL_MMR can be unlocked successfully.
> 
> Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
> Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Changelog:
> Changes in v2:
> - Moved control mmr after tifs version
> - updated commit msg
> link
> v1: https://lore.kernel.org/all/20260223144558.395289-1-u-kumar1@ti.com/
> 
> Test logs of v2:
> HS-FS: https://gist.github.com/uditkumarti/c66ecbe800b4b3549fec3e505fe26dbf#file-hs_fs
> HS-SE: https://gist.github.com/uditkumarti/c66ecbe800b4b3549fec3e505fe26dbf#file-hs_se
> 
>  arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> index 1180c75f551..32a3eed40d4 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -84,8 +84,6 @@ static void k3_spl_init(void)
>  	 */
>  	store_boot_info_from_rom();
>  
> -	ctrl_mmr_unlock();
> -
>  	/* Init DM early */
>  	ret = spl_early_init();
>  	if (ret)
> @@ -151,6 +149,8 @@ static void k3_spl_init(void)
>  	/* Output System Firmware version info */
>  	k3_sysfw_print_ver();
>  
> +	ctrl_mmr_unlock();
> +
>  	/* Output DM Firmware version info */
>  	if (IS_ENABLED(CONFIG_ARM64))
>  		k3_dm_print_ver();

-- 
Regards
Vignesh
https://ti.com/opensource

