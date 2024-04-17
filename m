Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AAAC41513
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A2C88472;
	Wed, 17 Apr 2024 11:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hoP4jOq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C09A88472; Wed, 17 Apr 2024 11:04:55 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5052E88459
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4837253909=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43H7ix0W005483; Wed, 17 Apr 2024 11:04:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=bbES01ciWRVBIBFh6cO8FunpT4CWgnNhmNQmQ0j4G3g=; b=ho
 P4jOq5Zvv1MSOFJwtpf8Z6WFyv3ni5+Z/+ViPXOUbkR/CydpPLNlBioxGF4V9qG1
 0GZuyLtxBb7KDftFZBy9nir7OB/1GFDC4ZVDxPxw4Iw3MsTlPgON+r3SAzrmldSa
 BPLFavUVkctDyuguboe9LdannVjCzfgm2UokG0wEKJFGuURajTw+7YvGRJIV1X2n
 BBM0wymyhkmpXHHPEWBlier/LvGiB+D924HLlf14ljLCntUE88dhyM7WB9ikPT1D
 VUChm97wwVIScnFpqLzMzyCr/GBE7RSVsWi3kPDvntOEG+I5IcTk+HU3nrUOKvcc
 hAfgOXRfT4///28HRuKA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50hxa98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Apr 2024 11:04:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A35814002D;
 Wed, 17 Apr 2024 11:04:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 735192105AE;
 Wed, 17 Apr 2024 11:04:28 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 11:04:27 +0200
Message-ID: <af1c7071-3dc2-451b-aed6-61d6b2ea3e4a@foss.st.com>
Date: Wed, 17 Apr 2024 11:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/25] configs: stm32mp1: Enable BUTTON_GPIO flag for
 stm32mp15_trusted_defconfig
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-5-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240409150215.2497778-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.112]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
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

On 4/9/24 17:01, Patrice Chotard wrote:
> Enable BUTTON_GPIO flag for STM32MP15.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32mp15_trusted_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
> index 84b0854b557..74deaaba2e4 100644
> --- a/configs/stm32mp15_trusted_defconfig
> +++ b/configs/stm32mp15_trusted_defconfig
> @@ -70,6 +70,8 @@ CONFIG_TFTP_TSIZE=y
>   CONFIG_USE_SERVERIP=y
>   CONFIG_SERVERIP="192.168.1.1"
>   CONFIG_STM32_ADC=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK_SCMI=y
>   CONFIG_SET_DFU_ALT_INFO=y
>   CONFIG_USB_FUNCTION_FASTBOOT=y

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

