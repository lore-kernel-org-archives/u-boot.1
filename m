Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857DBC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F32C82ABA;
	Mon, 28 Apr 2025 15:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="2NdvMH3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3C282AAA; Mon, 28 Apr 2025 15:24:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D565A82A5C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9Pfbg028224;
 Mon, 28 Apr 2025 15:24:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Z0jDUw12w+8ijLf7QuUamzhShZJRhIcgv878/ne5deU=; b=2NdvMH3dl0kzP9Kk
 lGjSq264r0GFknd/Y/qBbaSjxPkCcrIm1apUHDt9qsHQjlwSRpHernTOBxjFCjt9
 I7UGqeQTQZeqts4b6cvDxGqiJpmu1zDOs73ufCBXbFVh0pxd27ynmrL1dkebME/g
 gi9lzxsSOHSpEI7Lz/Z7QjsBlX7NDT9evacZ3dy8aqU5A9EI9MMWgYY8LkkUrnTn
 RNv6QQFvesA72VylrdRoDFUwjWU/vsUJfi78h6IZtTDl1aO1ke1pHkryT0fCHgOe
 ol27pyeqovw0+sa3D50xib436nxrd4JrQrEr6r4wf9x6vz0qEXms382LKiZeIaSt
 3YWEVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 469923vr4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:24:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B58934002D;
 Mon, 28 Apr 2025 15:23:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62D58A80895;
 Mon, 28 Apr 2025 15:23:45 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:23:44 +0200
Message-ID: <1e8255af-b15b-4e10-93f2-b47aef858095@foss.st.com>
Date: Mon, 28 Apr 2025 15:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] arm: stm32mp: disable console for UART serial
 boot
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-16-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-16-patrice.chotard@foss.st.com>
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
> For UART serial boot, the console need to be deactivated to avoid issue
> with tools STM32CubeProgrammer.
> 
> This patch adds also the missing dependency for CMD_STM32PROG_SERIAL,
> to allow the silent and disable console. This avoid to add is on
> board level for STM32MP15 (with TARGET_ST_STM32MP15X or
> TARGET_ST_STM32MP13X)
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig |  2 ++
>  arch/arm/mach-stm32mp/stm32mp2/cpu.c        | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> index 589276282e4..490097e98be 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> @@ -27,6 +27,8 @@ config CMD_STM32PROG_USB
>  config CMD_STM32PROG_SERIAL
>  	bool "support stm32prog over UART"
>  	depends on CMD_STM32PROG
> +	imply DISABLE_CONSOLE
> +	imply SILENT_CONSOLE
>  	default y
>  	help
>  		activate the command "stm32prog serial" for STM32MP soc family
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> index 9548b27cfa7..c3b87d7f981 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> @@ -55,6 +55,19 @@ int arch_cpu_init(void)
>  	return 0;
>  }
>  
> +int mach_cpu_init(void)
> +{
> +	u32 boot_mode;
> +
> +	boot_mode = get_bootmode();
> +
> +	if (IS_ENABLED(CONFIG_CMD_STM32PROG_SERIAL) &&
> +	    (boot_mode & TAMP_BOOT_DEVICE_MASK) == BOOT_SERIAL_UART)
> +		gd->flags |= GD_FLG_SILENT | GD_FLG_DISABLE_CONSOLE;
> +
> +	return 0;
> +}
> +
>  void enable_caches(void)
>  {
>  	/* deactivate the data cache, early enabled in arch_cpu_init() */
Applied to u-boot-stm32/master

Thanks
Patrice
