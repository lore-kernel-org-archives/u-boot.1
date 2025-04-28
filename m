Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694A3C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E5B82893;
	Mon, 28 Apr 2025 15:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NtNA1dh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DFE82935; Mon, 28 Apr 2025 15:29:22 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51FF82724
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9Qdtn021410;
 Mon, 28 Apr 2025 15:29:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 TJR97h0ZaGxEucy0hcZde7JtiaLsD5nuDX0GUoh8ehI=; b=NtNA1dh1wgJcMgQp
 twEJIIhg7TnsdbpGqKucIyCf+Y9MgD0XMjJ9D3Avsmr0eBHh2I0/Kis4fElW95nH
 p3MZcNl5UV6Qx8m90MIXswHtnjiriMalxM5VXQnIeTbmaiVb8wnlHSD9pI2tZf1U
 3dkE+/ab6K14GTqj7hyPm5j/TygrHa49Bhu5I9zBSMGm99UmwkZ5FOFzoce/nMST
 lfRpk1bhfSs0IiX5Wb+qLekJv6X0ZWWju5WICsuidXvbB/04D9HLXCjlUCfHvEoB
 aKgmChuwhRH38lGAe9H/4Qvb8by/U2/YtU7y0rebn9qLSkrjli0wO2nLPl9JkGOt
 omVkBg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468mm9exq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:29:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 22D1140067;
 Mon, 28 Apr 2025 15:27:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF7F8A47ADB;
 Mon, 28 Apr 2025 15:24:28 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:24:28 +0200
Message-ID: <ca7fb705-66da-488e-9306-dd17aa15668e@foss.st.com>
Date: Mon, 28 Apr 2025 15:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/22] configs: stm32mp25: enable DISTRO_DEFAULT and
 BOOTCOMMAND
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-23-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-23-patrice.chotard@foss.st.com>
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
> Enable DISTRO_DEFAULT and BOOTCOMMAND flags for stm32mp25
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ---
> 
> Changes in v2:
>   - Enable DISTRO_DEFAULT and BOOTCOMMAND flags
> 
>  configs/stm32mp25_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 0e515e4af65..317a6d5ecd6 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -16,7 +16,9 @@ CONFIG_SYS_MEMTEST_END=0x88000000
>  CONFIG_API=y
>  CONFIG_SYS_MMC_MAX_DEVICE=3
>  CONFIG_FIT=y
> +CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=1
> +CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
>  CONFIG_SYS_PROMPT="STM32MP> "
>  # CONFIG_CMD_BDI is not set
>  CONFIG_CMD_BOOTZ=y
Applied to u-boot-stm32/master

Thanks
Patrice
