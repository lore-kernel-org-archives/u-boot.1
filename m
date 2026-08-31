Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3E7C624C6
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F229280BE6;
	Mon, 31 Aug 2026 15:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZmURemOs35aw; Mon, 31 Aug 2026 15:47:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788191252;
	bh=rH36ggAEpFx1mLbPaEiTuGZVw9PCOS8Gi2DfSFo0Z9w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwEkJaxJUFKdiNgmHoxtc1fmmqa2yf2Gd6RnuPzas0hLvPBOxkX21Ge7vpqsn1lmi
	 U1aQi0Ea+qazU/GEMv045wWHmVTPzsfUb1xpCMJvBBYy3RrZk/kIDmkoyov+VzyLaq
	 nrh2IwltI5QZclttnxg19Oni+dENbYpVHkgAJv/zfoRm9cvoIqSwIJVBuT5ItYv2Ut
	 Eq0Fybl37GZZeh5n+1mgM/6WY2yrjQ3QLCzVHpUgCKXPqheocWlZijP3uthLpt2VOJ
	 oxXmqGg1D+FN7xg8McuvnA8ZSs1Hp/7gVn692coqc6kl0yD4+FZKFWTJQ+OwVWxo4b
	 zCqE1EskfQm5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 006A980BBD;
	Mon, 31 Aug 2026 15:47:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 53A1123E
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C59780BBD
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ_dIf7B75xI for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 15:47:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=mQW/aEM7
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9568F80744
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L18jiMMKd7MMtsDsb8TpLPVnIEfWxJWhvR40cUy56tkzAphF5LhJGstPszjSYffwJa3sY/zHie+02ha1+axNZoaNkkAX/Jb5bqyxu1FwSrcn6xhC+pmmmgKnmx6oMKzmj+OLVoOL5zH1MzKYnC4zcydIxHEXoxyFSFKlYr0c25mMGuXSZdm65WEBywmoGDfLPe8Xc56eOC/8yTau2o9Dcd2wKywAl77bxX5g0QUvsZETKHUliNf/HpLKyN8rnAzWATKNqfazd5Pct5qbjSsZi7QjyLqq5BnupHdCSlORPyNKDP0xw8lDyHQF06CcXid8mg5rZsk5femAhg+ydVBeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH36ggAEpFx1mLbPaEiTuGZVw9PCOS8Gi2DfSFo0Z9w=;
 b=QQP2SFz/95uYGlwFl2bIs9w/jnezFXjdgdBg5aNZERrplSpkugEjP3s0V3TKkt4oZCzs89ymo5CkwgDQMB6cKtJo81CMp2AZSKQUvzuEi4qZ9LO1JQFkOUngj0g/QMTdhRY/nPPtjTW6OpyDkFPnHaL+T/bLkYZSveOPak7NIk2S8+0k3b2HmfkfF4xvaFj52EGLxOf8cLqnMYtWmUh71oHHH28etO4IxRTmz1LlyvtDJldCGR2JIaIh48J+tC5lIJoOzKszdTetuMQM9hCfHiWIyXkibEU6oXH+jXfj5cWNaQjgv5d48TJz7SIDbLEtszXn4ao/MPZZ0zs7u9KaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH36ggAEpFx1mLbPaEiTuGZVw9PCOS8Gi2DfSFo0Z9w=;
 b=mQW/aEM7houCTI+mt7ZBgFCfG+WCNTwst8vplujF7b5w8YLeQmMagYNm3fXMSPn48u8OHQGGh/QLMpwSOIQEs7EvBoCbcK0yMMk3RETv/4vMQ+Ydvfc42D5JIgKvHbv+qvyFAaMOscHuXn+zqTN1bCMx2aZ3Gh4KgyA2KqVo644W5Ccz4DIGQNc8vwL47zOqyjMfQeJ5ls78u7IHHbVMDBP6MdjbNA0k+ZXtLl2pjVh8RsqwQ5Xk4NPqIArePovAQ4yPSJaWHpFb3qFJGKZ3aPYJ2FwSfY4O7oyiGAY6RuNMSYlumSosrioo5kgbWyBjttg3VVUHMLthBHT0PLWYig==
Received: from DU2P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::10)
 by AS1PR10MB5190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:47:22 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::8f) by DU2P251CA0008.outlook.office365.com
 (2603:10a6:10:230::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 15:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:47:21 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 31 Aug
 2026 17:49:19 +0200
Received: from [10.48.87.93] (10.48.87.93) by ENXDAG1NODE3.st.com
 (10.75.129.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 31 Aug
 2026 17:47:20 +0200
Message-ID: <82510f74-2311-4e12-a58a-fe6cb1826e2d@foss.st.com>
Date: Mon, 31 Aug 2026 17:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: stm32mp2: fix TAMP_FWU_BOOT_IDX_MASK/OFFSET
 definition
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
References: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
 <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-1-611201a282ce@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-1-611201a282ce@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|AS1PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b5bcb3-737b-4c42-c6b9-08df07772551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: /vslLxtEhRWjF1stHHfxwaCLzcPCoWx7FT2Ucq3dEZLZPovKw8fGffQJ8u5JPDApBG7T3a3Nk1bAD0eFFjdNnbt8wCKpMVFijfhMqFBOhw9vcT43e1HmSepGWl2CGM3+QimO8GsBCCeFaJy6mywIC3ZJpgaq152Sp4JCGml5NlN9Xwven40sc4I7gKpvZNVhG7gvGbNJgWWqa75fDuXIM5N4L3ShgOqhaI0clRSsXUxVlyLf9yeiGWwxNjtrLr5bwKD+g/SkrWqDM7vzj7dyTvd0jdaoOhyJd2buQ1/SY6Vf96eIlVccTk5k2Fe+IEtqMCQTteQ+j7XKfvh5wmUluDEXeahgwY6lCUHEZse5r8LAVer9ocg03Bhe7/yQD19KMRW6zHM6Cp8kS2wyYSf0OlzRccnLBjytGiaI/AHOy8ojoQGFw+bd5JanBZ0AYURz/U52UfH3jnaNHZzmTRqXOwLLkMTBeSzi9kIBL9PIAHvoi3jRDQYzkU2jWYSZE5eGtGJkBDqefpi4rd6ETFG8G61G6Chr/FLUJl/fcvWeyWGtqufJ6NqulWqH9fECxPQ31WVQeTMnVeDGk1nBZss9GfMfxXu/2TC0SiCDli/sJ0Ff4O3zHrOLZOwyIsVw8xFTvX+BgUKL7+6kCxv2AqFDt8Q33/cf6u4BFI8wp5jIKck=
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SmnA5XUdj0nY/yAbV3rv/qhArDSIoLBl9dyBhkyhUdPRvI0bYhYoUmtzJB150Tuibv4u2tsjNpo0df+A+M5CBNd7Ml34DTA3CIYTc0ev/RZIhWQqHoLTrgPr9XJUh1N6pjv9a3NlDrSINFsKpX5KL80rFKWHrXhxgpS0mg+O5Pm6LnWtduK2YUYmx0UEld3eMSwVyqafT4TEELBVp4cskeNxepRFJ6PFeuEjvuZ0ajXcmBkSMlXMT24f3JBoIdxaI1AonjKqddSbiEwGoTDDUAlg+aezBWyE8N4q+bsp/7w426zaOvTKV/ZZIT4vkADuXVJMwRr/AxTnV8OO6nPs8abj1xQFiVj0TLEbovzpOsdeNUAhdHt5fA8YH6lzrANRlN0cCar2lDyg+mEIyVvJgI557dzyauo1pKEhfeWkbvqnN+Ql/5vx3cEqUy7TlRE0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:47:21.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b5bcb3-737b-4c42-c6b9-08df07772551
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5190
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/18/26 17:11, Patrice Chotard wrote:
> Move the definition of TAMP_FWU_BOOT_IDX_MASK and
> TAMP_FWU_BOOT_IDX_OFFSET outside of config check for
> CONFIG_STM32MP15X and CONFIG_STM32MP13X.
> 
> This patch solves a STM32MP2 compilation issue in
> board/st/common/stm32mp_fwu.c when CONFIG_FWU_MULTI_BANK_UPDATE
> is activated.
> 
> Fixes: 5166658ac605 ("ARM: stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET definition")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/mach-stm32mp/include/mach/stm32.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index 42e3735847a..dfbd4f43629 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -67,6 +67,9 @@ enum forced_boot_mode {
>  	BOOT_UMS_MMC2 = 0x12,
>  };
>  
> +#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
> +#define TAMP_FWU_BOOT_IDX_OFFSET	0
> +
>  #endif
>  
>  /*
> @@ -135,9 +138,6 @@ enum forced_boot_mode {
>  /* TAMP registers */
>  #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * x)
>  
> -#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
> -#define TAMP_FWU_BOOT_IDX_OFFSET	0
> -
>  #ifdef CONFIG_STM32MP15X
>  #define TAMP_BACKUP_MAGIC_NUMBER	TAMP_BACKUP_REGISTER(4)
>  #define TAMP_BACKUP_BRANCH_ADDRESS	TAMP_BACKUP_REGISTER(5)
> 


Does not consider this patch, Patrick has already submitted the same : 
https://patchwork.ozlabs.org/project/uboot/patch/20260717143131.1.I2460c17ad1978f8c5c5e85a6ba56cfd46ed975cf@changeid/

Patrice
