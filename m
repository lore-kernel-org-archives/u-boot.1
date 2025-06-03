Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BD7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 17:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E66F82AF6;
	Tue,  3 Jun 2025 19:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xE5WcKVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E9382C15; Tue,  3 Jun 2025 19:38:21 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A40582A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553D4XSm008726;
 Tue, 3 Jun 2025 19:38:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 uTr7bjj869aG0sP+0KcUxd0LYrQJSqB9dcPmG63xqL8=; b=xE5WcKVyrWahsLCI
 VVRGkxjcXOUN3zdZAoqyfB6peO1k8XXL2+/OUsWLn8MeiGafiCta54z6klEaXSe5
 W8nRGAmjFpO9rZSzrNVdb9hRt3ZEMQ60Xsved5JUOOUCmf/ehs4ESJ0l1rzuaEpO
 mGD90qX+Aa+qJQCOw0loBZGT+CvJQnd6bLYjp/IpqVan6ScXawqveOmS6CdXG153
 vOFdPaHIjZNI3NYsZuMixwYzoargzVEiUQRudOisgfDNwd207u7S2/p9IVv+nDIM
 tjSbeU2mkJ4YF4UMJGAWIH2JGd0yu0RzpbhYDXMCLclbxXboh2zLxKinyX3iNFEY
 XLMCzA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8v58h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 19:38:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AC6E84005E;
 Tue,  3 Jun 2025 19:37:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 947A1B53C90;
 Tue,  3 Jun 2025 19:36:48 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 19:36:48 +0200
Message-ID: <45b9cf6f-f0f3-4e5c-97e3-fcb370deb488@foss.st.com>
Date: Tue, 3 Jun 2025 19:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] configs: stm32mp25: increase SYS_MALLOC_F_LEN to
 0x60000
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom
 Rini <trini@konsulko.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-14-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250527132755.2169508-14-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
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

On 5/27/25 15:27, Patrice Chotard wrote:
> Due activation of SCMI, we need to increase SYS_MALLOC_F_LEN value
> to avoid following message:
>
> U-Boot 2025.04-01224-g75b77a2a6d31-dirty (Apr 25 2025 - 11:23:30 +0200)
>
> alloc space exhausted ptr 400040 limit 400000
> alloc space exhausted ptr 400020 limit 400000
> alloc space exhausted ptr 400060 limit 400000
> alloc space exhausted ptr 400060 limit 400000
>
> Set SYS_MALLOC_F_LEN to 0x60000 to fix this issue.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> ---
>
> (no changes since v1)
>
>   configs/stm32mp25_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 317a6d5ecd6..acb48f4ec72 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -1,6 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_ARCH_STM32MP=y
> -CONFIG_SYS_MALLOC_F_LEN=0x400000
> +CONFIG_SYS_MALLOC_F_LEN=0x600000
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x90000000
>   CONFIG_ENV_OFFSET=0x900000
>   CONFIG_ENV_SECT_SIZE=0x40000



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


