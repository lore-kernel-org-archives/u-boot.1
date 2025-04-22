Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EA9C369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 07:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8752781E25;
	Tue, 22 Apr 2025 09:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Q3SPfwgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 865508129F; Tue, 22 Apr 2025 09:52:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983D48059A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 09:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7SZ0a028178;
 Tue, 22 Apr 2025 09:52:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 2kI0kNN+fUUCbQWbzIjiyz/ghgz6aAnLQqDsUjBCWh0=; b=Q3SPfwgWoQai4Pcd
 h6uC2qVx4qfdZpT2nA8FqQSY7Gbxs+aIZGwr/iU83UswOJ30HdxBCLRjQ0ocZvw6
 8kmeHdcD6gy4YJbUztyqlE6pIUIMWxNmtx5AJXlVdfPib32RmMdk34z9lMlhlRW2
 GUQAovSpi3uvZCcV8zROsVdg4Sprl33xPSepKIFVjTCp7SQkWRw7eKcZdKxMn/Y6
 pOopejUrPB82mEiFv/3Gx5H18MngGAjntstMYBESXctT9cWrejO8nvQMR0DXE9pd
 LZSU2iz2KsrBR302RdU393fkNOxUDMvtwAEWVS4XeVQlqkQz2BYa02cwIfRzzqqL
 7P3O1g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4642qg8pks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 09:52:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 221F540063;
 Tue, 22 Apr 2025 09:51:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7B689C02E4;
 Tue, 22 Apr 2025 09:50:39 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 09:50:39 +0200
Message-ID: <f774b808-f867-443b-a6b9-3f38b69d03a3@foss.st.com>
Date: Tue, 22 Apr 2025 09:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] configs: stm32f746-disco_spl: Fix console cmdline
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
References: <20250401135132.395518-1-patrice.chotard@foss.st.com>
 <20250401135132.395518-3-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401135132.395518-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
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

Hi

On 4/1/25 15:51, Patrice Chotard wrote:
> The Linux cmdline encoded in the defconfig is wrong, the
> STM32 USART driver registers as ttySTM0 not ttyS0.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32f746-disco_spl_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
> index 8a8f506959b..f1761e50ad9 100644
> --- a/configs/stm32f746-disco_spl_defconfig
> +++ b/configs/stm32f746-disco_spl_defconfig
> @@ -27,7 +27,7 @@ CONFIG_AUTOBOOT_KEYED=y
>   CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
>   CONFIG_AUTOBOOT_STOP_STR=" "
>   CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
> +CONFIG_BOOTARGS="console=ttySTM0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>   CONFIG_DEFAULT_FDT_FILE="stm32f746-disco"
>   CONFIG_SYS_PBSIZE=1050
>   # CONFIG_DISPLAY_CPUINFO is not set


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

