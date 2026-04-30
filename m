Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153A7FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9173B8460B;
	Thu, 30 Apr 2026 09:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZQDnS7ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7263842C7; Thu, 30 Apr 2026 09:00:57 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B5B8460C
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isOoA+7/VNiXDcvbQ7O17mWmaqJCa1r+pJiyuja1ebFka/1DekK3PfToLhP+2Pb+5dLg+4g5aoqLjHiPnZ8xEyTQ0d2ewbQMj4JzEUiPqtFcOsaEvmbtVgUIdOWy+T+ChNkMrNaYxY+/C0S7UHn49kFZVNcBeh6/5W4C1hGw9tgLkgt7H+vsX0EOqYjrFSMb9+RNNhGNjOa8l6yPJyGJxSurCzmEH14tTBlbpobrVCtIpsz2rv7EyPzcWd8TeYv20IElkjYrlyg/HQ4HsBBAJZzCP+kc+EM7/0eqivpmkhJBJOJ17HgxZ73rkK37x55QQ22Gxuw8l4sCitfVG9O0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lO3KCHMrLkzscSSNclLyJ/WOyr62ZQSDRME48wZGks=;
 b=PRV0mg79fid2nlucyH6vAIzDOSbMMrS2GtTtAz2SCwJaLwpOGaF35AAGWTIpj5WG0RVoilBPwDg1EfzqtlYx9G6Zfhj0N9zNOFAedBLea9krd40OxRNhyTm8lJkj+WtPrTWcdqB4Yk3qIDRqbV/gRcWZtdgFSyvMbs3z1J7rpEOyu2CFrhKW17nZZY/MNzjAu1w90kOdmhjeQZ5KNMfqw9DutaGtVfUMsm0lVFyHlEUEz2aJHhr3V3TjFrVs4YT6hS+GhKhMYWgj4FDqTfD6UvFrsevzvOwTji/Gi9eBfWgtxS1k9PVn/6IiUmI7FXidPbU1n7HpgGfuo9Ykz/FHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lO3KCHMrLkzscSSNclLyJ/WOyr62ZQSDRME48wZGks=;
 b=ZQDnS7ss2CrpgLOBNpW+A9X9QEnzNf8OS+QNhmGlQHcxjQjoHvxR4RgTQLHyiv+jJhnrXbfdc7Qpc11IoYdcCQShAo99OgBykwu3zGpFgNkA9tYbmQpBpWtY4oHa/o2irlYGomvuco5Q+hWuYhZFl9RhFgrlT38i7ICZTiJcAu71J/rp+hdGVY3CXUhoZdjjIyzNnufNOizHKzzZU+gyYT6H5wkrlDOdcgiHUG/TgKTGjh8sN1i3EBMROKK34ajzk7A+CXbd/RLWfkpU5mcse8Kr/eCJ6u72BEAmmdUxZVqaYKMUrw5hEfW0FtStP/1yTiiO466hSQOgxPkjpxZL/Q==
Received: from AM8P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::28)
 by PA1PR10MB9457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 07:00:50 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:20b:218:cafe::c4) by AM8P189CA0023.outlook.office365.com
 (2603:10a6:20b:218::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:00:50 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:04:02 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:00:49 +0200
Message-ID: <912fab7c-327d-427b-8bc5-6f24e8fdf26a@foss.st.com>
Date: Thu, 30 Apr 2026 09:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET
 definition
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>
References: <20260401-factorize_tamp_fwu_boot_defines-v1-1-ebecaf20ad6b@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260401-factorize_tamp_fwu_boot_defines-v1-1-ebecaf20ad6b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|PA1PR10MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bf9608-0a4c-49e8-6730-08dea686368d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KbFG3+Wkn21Sjy4Knm788K1MXks/XIMcFzuDF19Nez5NXZY+dTbb28qPIZGL/oBq+Cs87hdAXgKv93BtlPpxfYOoHSkLmcJS+t0M9lrNMS8QWsCiH/Y9Ie5PDc9R4Cpnq5Qenawk0FKTkZIVBYTu3jyXICvTUrJyKnDAoxVI6f9lvkZZPYD5QgkPPJXgpG7ENVZOEvofKvBDfnVBCAfinXLn8GamHZluDDij1QHD03klnh6te0rS+I42N4Z2+dRngCjVfdemB7Qnb7/pXkBikd2PR8ghT70Sh2Ay26eBxqYZck8XaTpFBqfhc1cq4fKspdPER4+VRWGUfx3scGqxgksuzy4o5TMgVNZtK39GIKdNhLNucNUZfZzJalsXz75At3ddJKkawR+2nGixGbEmkxCyIm/WmVfwFSxjzZd1UcECQK0SYW36+YFmG5TE+Lvqekeb5NvV7qg2zrLahtrVRVvXKpVm43iz3tzpkIsFNrxq663X8EptzqFNThQ5JCPo7+R7+Fc2GYYZagTuN1vmvKZsE4ygWL9q/n/RMwFSRpDuv7nlO23DCohdBs3gt4brN/CKpI7+4MCFP6glORCr5mz9F65Vu5bFAPLVwQQP/qfle64R5bcUbMzUwLjyZ+4OEOAAT3XD2CyuBEgDflNhuJ56h8jMiXLg6e/zsUec7+DTNJntm4jDQEfDEC8BJyLeuOagatNcrMLsUu1vOkFYW3KgTna47jByvuOqob1XgOFNB1bWjAejX52Rl9d3peb74MPAhlOGmdAKLVlv511QKw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PVLShFRqBFM6LSKhpQzasGgWltcoYra0nik9Yg5fIRcHUZ+X7KsZP6iAsNGRo4xtUOx4RQWmvXnMpUbzA4JiJ3eUrhVxdcZxotEVY6J3wTmLB2nLMCGa+LIh1lF6LIQYkcCDCPXXmCI9oLjd9I/cMjwbMV25lfAdFWscHtgijKwL7tTHMWy5Wx8uFvRSBHVMdu/xPFli1LqPennLCBTrTS+Jo6rvy4LSY+Q8fWnRT+LigwlynezmbuWRSdFlN9oMkrSOYLO3sQUvB/Ow9R2bZcDqRjoIYT/xG1ov5R5Q9Xw9a/+Da3sgLiYXp7adOY5rToSQWgHdoXHppUYNwsS+bKQEgpVvgGYjPl2JGzqy+MQPbLvttJK36dDyGlFwzXrMt26WOgGd/zIg9ba3l/OKEaS9YkDLveSDChx1oQ1v2w56sgsyh4EMhjyrIcvpYOPL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:00:50.3012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bf9608-0a4c-49e8-6730-08dea686368d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9457
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



On 4/1/26 09:48, Patrice Chotard wrote:
> Factorize TAMP_FWU_BOOT_IDX_MASK and TAMP_FWU_BOOT_IDX_OFFSET
> definition which are common to STM32MP1 and STM32MP2 SoCs family.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/mach-stm32mp/include/mach/stm32.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index 7f349f3b68d..42e3735847a 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -135,6 +135,9 @@ enum forced_boot_mode {
>  /* TAMP registers */
>  #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * x)
>  
> +#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
> +#define TAMP_FWU_BOOT_IDX_OFFSET	0
> +
>  #ifdef CONFIG_STM32MP15X
>  #define TAMP_BACKUP_MAGIC_NUMBER	TAMP_BACKUP_REGISTER(4)
>  #define TAMP_BACKUP_BRANCH_ADDRESS	TAMP_BACKUP_REGISTER(5)
> @@ -144,9 +147,6 @@ enum forced_boot_mode {
>  #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(20)
>  #define TAMP_BOOTCOUNT			TAMP_BACKUP_REGISTER(21)
>  
> -#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
> -
> -#define TAMP_FWU_BOOT_IDX_OFFSET	0
>  #define TAMP_COPRO_STATE_OFF		0
>  #define TAMP_COPRO_STATE_INIT		1
>  #define TAMP_COPRO_STATE_CRUN		2
> @@ -196,8 +196,6 @@ enum forced_boot_mode {
>  /* TAMP registers zone 3 RIF 1 (RW) at 96*/
>  #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(96)
>  
> -#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
> -#define TAMP_FWU_BOOT_IDX_OFFSET	0
>  #endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>  
>  /* offset used for BSEC driver: misc_read and misc_write */
> 
> ---
> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
> change-id: 20260401-factorize_tamp_fwu_boot_defines-205eed07ad1e
> 
> Best regards,
Applied to u-boot-stm32/master

Thanks
Patrice
