Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E3FEF4ED4
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3041283E7A;
	Mon,  6 Apr 2026 14:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ltng9/Ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF16A83FA3; Mon,  6 Apr 2026 14:19:53 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63868341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1uDJ4bswcukaWe/z4/M44RyuojQzbwP4kTQ4bmLqh2fIALJaWrunfmFZZmCTyFmLuwWghxj801eDAm9sXEauf01fAIDEFv3qQt68H0qrCigPNtAXGZOzn/TYvKfM6gMS6Xjd4pAU5VxV5F54/k7ZIcjSiGfzx8Rbrr+6U/CYLMagKaDS/ZBD0znZTgC+iRFOsVClFcNdmUam2LSRT2LyQI2GtOU+cGAscmpL1piaaFWbyB1s2/+DjOJE4MRvxFKPu17QNYteWZ5sMmIGjIveEsV2Lgns4BLeip7DzAvWHW88jXeWO2ky0j2I2SMtim2rJgg3F4nqlx44P0outiIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SER0GkPDXo8kYwm6x0NjRLX64zbJgDZG9Vev05qvrrk=;
 b=TDF+Ishvh5Am59qSJwdEcHZ3c5X5wI4y07ShtkKST0aB5/1+Z9oaiL0+DTLnBrVNvV/SYWrwBos3e2mtd3uMGmsLoEK2UY4RekLtiR5ibgCa7EcQsIw+sq5lCq3zW8lmwvcwY6eZ99ODKZ13FUKHpX+ZuiTVHObfREDIbiS/tna3BR/C3COKAGj/RBStDI6prSgdFeK1ZeAIQ7WXhqf/9V3I+rSq7CTmkIDcYFfFXYRoX8J3E+GlaQOImMPENfHQa6tMiykDwuSIOciWUH66LO1cjqiInc3zGTxVe1/7HuCEDXEB9RZmYjhJcLjK3E1fEIVmiOaOwXJ8tNLv4+EscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SER0GkPDXo8kYwm6x0NjRLX64zbJgDZG9Vev05qvrrk=;
 b=Ltng9/KsDkLhWn4KUY3bD8rRY1fKCAfhPt0q4eHHUDLZpyxfLiElSy6zP1G5skLkfucetFRI0DBj9ZH4xMYRAbyrkbXXvjL/PIDCGy209Lu7Tpa4omkRqWLezW4xfK5ocq3bj6gA+Nsi//8dQGDtxmVEkOukWaANsGlL52MuWj0=
Received: from SN7PR04CA0187.namprd04.prod.outlook.com (2603:10b6:806:126::12)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 6 Apr
 2026 12:19:47 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::3f) by SN7PR04CA0187.outlook.office365.com
 (2603:10b6:806:126::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 12:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 12:19:46 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:19:45 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:19:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 07:19:45 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636CJhxV1144371;
 Mon, 6 Apr 2026 07:19:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 1/4] treewide: move bi_dram[] from bd to gd
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <jonas@kwiboo.se>, <anshuld@ti.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260403090109.3564638-2-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-2-ilias.apalodimas@linaro.org>
Date: Mon, 6 Apr 2026 17:49:39 +0530
Message-ID: <177547797999.70791.8632199569441183064.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775477981; l=1427;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=3oP67Z6oEPCNvdb7Rfa0GARw+ZhVKa/FqhfdzR/P1Pg=;
 b=i9P2yeewBiSRK0gwDTLLcdwjH8g7cnME6FoslDqEr6mM5TJNYb4maoVs4bcZaM60UdwbyppSz
 eU7vv4Srf6pAowkKUjVLtLRwgo/222ThKU20cNV1sktlzaB4wquShQH
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: a63eccdd-a757-4d99-74db-08de93d6ca61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: m4TwR4DJks/VdNkZ5l+Je5lLvRulhFIqATK8VCRzfTv9vjJw5m2tFrB+477gvlt83ZeStnvC4Rf5fMxF+bcBBeFfW2tqdqjxvE0+F1sly3wwt9RKkL8Ok+xzQqoxshps5LgqWpxL466ZNjhTHeYwNpPerQlDBxL4KiMeHfJvDz4Ux+YUDQpiWbVvBKHOtAXD8MkhQr/c/IpUxbvT2N6sd/BrRE024Zn4Fw7L8D4SQRi6cILQA2zG8SwfBxGqduyafeZQTZEqK4AwgwcqRoz5i1RrsZE0TYy1KUUYVwWnPS5DGQaMMdz+BtcmJMfQVykK9MfqmRHloessOSH1RBL9Sbani3Dq0oDV+yb8qcKm9bi9Kq8ONg607MHJbe7YiXzfQ5nbpvILZPmhWNwVVCXGh2hxrcQNvhqxPjrqUlcFdXyQ/UMv1DXDQ3+KLtM5atIdfPDYjBkVl6OUdInsAJ2BtUpEe6MtimuXYglVS4EitS3OZgKt1lIncGy8xc4yUjMJ1O/1FG+XIwBST7Q35mJ4uhBCFqo6DbIOTG0tzSuSN5aoNR33HoGDArFTYCUZbH1Ow0BiIMQ4lyEm7LHjmqJNyTSRm9b14mmT69UalokmihUmdag/MGjekyyR8TzD6ZGTbF9mRYM7ooPHmDz4Ua2cUxYw5qxNKvsLtTaqw2FSOFCnPJdMFOwRnYyiTN4fEYAIGn0EHe8D02TwWdm7nqYkLqbEAPGZ35COWI+CFQ8i2gJgoQgX00Y4/3XVf0ybPu32o2mQHMZpHrr+AoWgGvvYvg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5TW67oWzVWqx6+8ErvzasVfZ8jvdkFZQNjG7mk0Qa3CJJANScohSbuPpcYS7psb414jM7mXlOteDcHASU2/G6XSVYiuicg73FM7z9bHcNtyxSZlIErnYEcvFqxjxNyddqZ/PxF1yMh21shzZz1umfzKvHuIcM15ChwhQLmBsQub+I6wJwBM4/KuKygLxBKHfQUgqbUg9WHmNY8bZ00TQ4m6UQ36cvyVW7FGtUvyjAcQ5aFWjWSNP/iNDZ6d2mL72PoiUkpFaaU1JkfOH6kOs+LilPWv2Gljq4bflgpw1toqp91yrxgjs1dXBBkRIGxWqtEmKIOluqSBog7PLr0+YY3E3QF8Y+nBpDI8swc4sxIDOzLU8z0sjyHx1MEGygbRsZwZq9FWu/wnfl+i6NHhcs7LoNCeoOaX71n/GLXEiq1DQgSsfZeiTxevyMFKaHnTc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:19:46.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a63eccdd-a757-4d99-74db-08de93d6ca61
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
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

On Fri, 03 Apr 2026 12:01:03 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> [...]
> Additionally, U-Boot defaults to relocating to the top of the first memory
> bank. While boards currently use custom functions to override this
> behavior, having the DRAM bank information available earlier in gd makes
> relocating to a different bank trivial and standardizes the process.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Two files below still refer to 'bd->bi_dram' after your patch, rest looks good
to me.

	--- a/arch/arm/lib/cache-cp15.c
	+++ b/arch/arm/lib/cache-cp15.c
	@@ -96,7 +96,7 @@ __weak void dram_bank_mmu_setup(int bank)
	 {
	 	int	i;
 
	-	/* bd->bi_dram is available only after relocation */
	+	/* gd->bi_dram is available only after relocation */
	 	if ((gd->flags & GD_FLG_RELOC) == 0)
	 		return;
 
	--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
	+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
	@@ -66,7 +66,7 @@ void dram_bank_mmu_setup(int bank)
	 		size = ALIGN(STM32_SYSRAM_SIZE, MMU_SECTION_SIZE);
	 #endif
	 	} else if (gd->flags & GD_FLG_RELOC) {
	-		/* bd->bi_dram is available only after relocation */
	+		/* gd->bi_dram is available only after relocation */
	 		start = gd->bi_dram[bank].start;
	 		size =  gd->bi_dram[bank].size;
	 		use_lmb = true;

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
