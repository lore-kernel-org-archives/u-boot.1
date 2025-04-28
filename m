Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF0EC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF2782A0A;
	Mon, 28 Apr 2025 15:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GRT7Slnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE1A82948; Mon, 28 Apr 2025 15:24:26 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C43D829D4
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9WGGF010884;
 Mon, 28 Apr 2025 15:24:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 bhfEerA8+EwmnbaOHGDxqTJSjbjryOaacXNyQPSGnQA=; b=GRT7Slnn7/Cus2pg
 wS2Qjkb6oHwZCqpZwF1eD3fIXKE/Ks5+QrhsMwqJ6TF0Se5AESFfZs2UDKa6R8bs
 Bss+8xYWbq2YW+aoZQTMEv2dDxXEtLbkJa9l9t7TimUKkKAgidjFz+KCnniQCmVZ
 22qiur1RWWeU1NI/YQJO5rBrkcmz/h0iriPjTwwxtRPHEP+3HktOMDNQYr8aqVee
 oJIohD6h81Wad2DFtEeSZWSSCFHD4uZkVkRpjQg9dlsvLv1hq1ok2IlkU7T2WsXr
 8r5od4ZqR4gZ4Rm4uMn9NI4a9XwQ+B7FlKSJSTt8cw82RjYx/NqKl1cIcrv0d0tj
 9iwLyQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 469aencftm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:24:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 33CAE4006E;
 Mon, 28 Apr 2025 15:23:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2FC73A8088D;
 Mon, 28 Apr 2025 15:23:27 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:23:26 +0200
Message-ID: <9dc13c7d-db35-4313-8fab-1549daef2204@foss.st.com>
Date: Mon, 28 Apr 2025 15:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/22] configs: stm32mp25: add USB host boot support
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-12-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-12-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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



On 4/25/25 15:15, Patrice Chotard wrote:
> Add support for booting from USB pen drive, since USB host
> port is available on the STM32MP2.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  include/configs/stm32mp25_common.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
> index 1c28ce1c1e9..481b25a1f02 100644
> --- a/include/configs/stm32mp25_common.h
> +++ b/include/configs/stm32mp25_common.h
> @@ -41,11 +41,18 @@
>  #define BOOT_TARGET_UBIFS(func)
>  #endif
>  
> +#ifdef CONFIG_CMD_USB
> +#define BOOT_TARGET_USB(func)	func(USB, usb, 0)
> +#else
> +#define BOOT_TARGET_USB(func)
> +#endif
> +
>  #define BOOT_TARGET_DEVICES(func)	\
>  	BOOT_TARGET_MMC1(func)		\
>  	BOOT_TARGET_UBIFS(func)		\
>  	BOOT_TARGET_MMC0(func)		\
> -	BOOT_TARGET_MMC2(func)
> +	BOOT_TARGET_MMC2(func)		\
> +	BOOT_TARGET_USB(func)
>  
>  /*
>   * default bootcmd for stm32mp25:
Applied to u-boot-stm32/master

Thanks
Patrice
