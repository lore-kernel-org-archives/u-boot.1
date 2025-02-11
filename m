Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C512AC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 16:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0733F80842;
	Tue, 11 Feb 2025 17:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BDnQd6Ma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE6B80B9C; Tue, 11 Feb 2025 17:51:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FDF806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 17:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41370a1617=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BEUmPA001857;
 Tue, 11 Feb 2025 17:51:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 LbUpIxssocfd0ZsVFQ4V1DNT+UGAYAG5OgjAlv3jipg=; b=BDnQd6MaIjfjX7s0
 SBlc/+Tg+ufVQtca7K4RMSngUyjvbg3h66GsP4qAqRcxc4Nn5uH2mdH2X4NzI6F2
 i8GOiQyelBzeljzV4BSbjfMtccFTM2x5+VQCw5dpiTgnI+o/AWA+hJIseXKEGawx
 nQGk7C5DjIuXSQVubrveT8clnDDoLKJMozXwuwp4U5yxMJyg+rulzKuDMoUMoXyE
 888KU/OYexl6pG2uuRtPbwgIzW2taVouRQRazQzV4J1YRr6BJPU10sFHFE150l53
 KNNyWr7ISAZTgLj69H5+z1geMpwRGDw+mlZJaaeI7M8c9YbraOucGVNRPuhUPg4V
 owuGLQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0qs4bs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 17:51:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DC15740055;
 Tue, 11 Feb 2025 17:50:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B0812AFA57;
 Tue, 11 Feb 2025 17:49:52 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:51 +0100
Message-ID: <98995b05-aacc-477f-b1f6-a9b2d307c0ea@foss.st.com>
Date: Tue, 11 Feb 2025 17:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: stm32f769-disco: Fix console cmdline
To: Linus Walleij <linus.walleij@linaro.org>, Vikas Manocha
 <vikas.manocha@st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
References: <20250211-stm32f769-uart-fix-v1-1-8d0eaf0b193a@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250211-stm32f769-uart-fix-v1-1-8d0eaf0b193a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
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



On 2/11/25 10:12, Linus Walleij wrote:
> The Linux cmdline encoded in the defconfig is wrong, the
> STM32 USART driver registers as ttySTM0 not ttyS0.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  configs/stm32f769-disco_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
> index 5be221afd2facb0af4a3a3f8df0f24fb34eaf10d..9edda0e36b2e92c3dbe3298a3da04bd731dac452 100644
> --- a/configs/stm32f769-disco_defconfig
> +++ b/configs/stm32f769-disco_defconfig
> @@ -18,7 +18,7 @@ CONFIG_AUTOBOOT_KEYED=y
>  CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
>  CONFIG_AUTOBOOT_STOP_STR=" "
>  CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
> +CONFIG_BOOTARGS="console=ttySTM0,115200n8 earlyprintk consoleblank=0 ignore_loglevel"
>  CONFIG_SYS_PBSIZE=1050
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_CYCLIC_MAX_CPU_TIME_US=8000
> 
> ---
> base-commit: cb3612dfe3fd9a702dc3657aae15b07974f9aa0b
> change-id: 20250211-stm32f769-uart-fix-66650ddf9c80
> 
> Best regards,


Hi Linus

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
