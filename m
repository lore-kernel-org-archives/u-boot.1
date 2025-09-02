Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB7CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 07:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2AE83280;
	Tue,  2 Sep 2025 09:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QRVlLpOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9891A83287; Tue,  2 Sep 2025 09:38:11 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3B6831D3
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 09:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5827c6132535361;
 Tue, 2 Sep 2025 02:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756798686;
 bh=6ZUE3cA1zOKor+x/FSZMGNa1PeBU8nQFgtO3irZi4i4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QRVlLpOmAQsCPpNtAvF621KLem8tozgtpXsoWKVXHXGFHu39aAy3tokVZ8u4Wgib3
 mcNwc66wosYVDQgiBfiWyD0j2cjk1s+Y3yEuGD9VP+2eYKzxZrKPKi/dULGABoOQyA
 MF8n9mvfRE6GuRHNfD8bwxT6KJVlH127BcS2qoOE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5827c6222670572
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 02:38:06 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 02:38:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 02:38:06 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5827c3Fk3710140;
 Tue, 2 Sep 2025 02:38:04 -0500
Message-ID: <502f3823-3d15-405f-99e0-519c34b5afa5@ti.com>
Date: Tue, 2 Sep 2025 13:08:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at
 SPL
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250902064839.1296877-1-a-dutta@ti.com>
 <20250902064839.1296877-3-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250902064839.1296877-3-a-dutta@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 9/2/2025 12:18 PM, Anurag Dutta wrote:
> MUX_MMIO and HBMC are required in SPL stage in order to boot
> hyperflash successfully. Add configs to enable both in SPL stage.

I think should carry fixes tag

see sha id 5b2671594b80af116e259313d48bcd580d71f462


>
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>   configs/j721e_evm_r5_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
> index ceb2e273b54..52290722686 100644
> --- a/configs/j721e_evm_r5_defconfig
> +++ b/configs/j721e_evm_r5_defconfig
> @@ -124,6 +124,7 @@ CONFIG_CFI_FLASH=y
>   CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
>   CONFIG_FLASH_CFI_MTD=y
>   CONFIG_SYS_FLASH_CFI=y
> +CONFIG_HBMC_AM654=y
>   CONFIG_DM_SPI_FLASH=y
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_SOFT_RESET=y
> @@ -133,6 +134,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
>   CONFIG_MULTIPLEXER=y
> +CONFIG_SPL_MUX_MMIO=y
>   CONFIG_PINCTRL=y
>   # CONFIG_PINCTRL_GENERIC is not set
>   CONFIG_SPL_PINCTRL=y
