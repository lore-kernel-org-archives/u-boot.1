Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56443E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0998800D0;
	Wed,  8 Jan 2025 19:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="CbdOLiam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B4880275; Wed,  8 Jan 2025 19:55:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E05E80017
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103f025b2=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508GBaB3015614;
 Wed, 8 Jan 2025 19:55:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 bMFWJ87OfuQyddo4pUf2UBjUtAKZwqtx8zkKaKph5+Q=; b=CbdOLiamgi8vgSj7
 W8x0GZSS/Gea+h9F14jm5vMtmgnh8FQxuneUyhkXptxGkvLyE5IoiBZDDuSTQAJX
 hRSM9Mc1stslvt/hPana4aoKh+1Wpj4gfuZwSq+Olac5pD8YDYalYduN/JqjbrIA
 QZmITRLGj3RXF3hPP17/TZN2BlHIQjgHn+pVtU8Q5md4Gc5k/SkMxiRkJ4V10Oig
 /TgjlJf3jmy503afW+6HcI9MCI8NtMCG6jSvAeFSM5PXO2IrCW3HUdlPPurUfCzD
 vIY0knP1Q1eJkA93oG632tc9YDpJMgZumFwHEqYpGU83+n1Sa/6HXViPu43oYz04
 NfU92w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441vnw0h22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:55:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D83524004A;
 Wed,  8 Jan 2025 19:54:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 593EB2A15EF;
 Wed,  8 Jan 2025 19:53:37 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 19:53:36 +0100
Message-ID: <47929bfc-5a76-490e-a445-d0a0e991cc13@foss.st.com>
Date: Wed, 8 Jan 2025 19:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: stm32f469-disco: Set CYCLIC_MAX_CPU_TIME_US
 to 50000 for stm32f469-disco
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241211080936.1133105-1-patrice.chotard@foss.st.com>
 <20241211080936.1133105-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241211080936.1133105-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi,

On 12/11/24 09:09, Patrice Chotard wrote:
> Updating the framebuffer takes quite a long time on this slow patform,
> set CYCLIC_MAX_CPU_TIME_US to 50000 for stm32f469-disco to avoid
> following cyclic warning:
>
> "cyclic function video_init took too long: 46784us vs 5000us max"
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32f469-discovery_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
> index 98399416fa5..b0144763d37 100644
> --- a/configs/stm32f469-discovery_defconfig
> +++ b/configs/stm32f469-discovery_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_BOOTDELAY=3
>   CONFIG_SYS_PBSIZE=1050
>   # CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CYCLIC_MAX_CPU_TIME_US=50000
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SYS_PROMPT="U-Boot > "
>   CONFIG_CMD_IMLS=y


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


