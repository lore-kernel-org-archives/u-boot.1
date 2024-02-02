Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BD4C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE74C87CAA;
	Fri,  2 Feb 2024 17:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sSRNs8Bu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B384587CBF; Fri,  2 Feb 2024 17:44:57 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9582187CA7
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412Gin8S014953;
 Fri, 2 Feb 2024 10:44:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706892289;
 bh=R2xXxCX1d0qIFqPhlK7UYcJx6+TxIQ+GzYu0HoEq0n8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sSRNs8BuqjYQvxAY9hAVBIbLmIMvOGGw0bRP/HvIxU6ydIye53v4ypCJVLLMoxt09
 LOpXsqVMKIi7xKyIfbNg9wU3rV/GY8SdHwiZU6Un/y8HABzvurmxXOx14cLAm0YWAj
 HWecpCVlqTBxyp70E2LwH+SycnAasZeEOJMeyAyg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412GinKE024380
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 Feb 2024 10:44:49 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 10:44:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 10:44:49 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412Gim6K088709;
 Fri, 2 Feb 2024 10:44:48 -0600
Message-ID: <b7e61559-4f23-4da4-8ba5-e95994475672@ti.com>
Date: Fri, 2 Feb 2024 10:44:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] arm: mach-k3: invert logic for split DM firmware
 config
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-22-bb@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240201030634.1120963-22-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 1/31/24 9:06 PM, Bryan Brattlof wrote:
> Currently, for the K3 generation of SoCs, there are more SoCs that
> utilize the split firmware approach than the combined DMSC firmware.
> Invert the logic to avoid adding more and more SoCs to this list.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm/mach-k3/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 03898424c9546..0574e81075e6d 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -130,7 +130,7 @@ config K3_ATF_LOAD_ADDR
>   
>   config K3_DM_FW
>   	bool "Separate DM firmware image"
> -	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
> +	depends on CPU_V7R && ARCH_K3 && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN

Always amusing to see how many SoCs get added to these lists before someone
realizes there is only one or two SoCs that are not on the list :)

BTW, this whole file is inside an "if ARCH_K3" block, so all symbols
depend on ARCH_K3 automatically. You can drop that check.

Otherwise,

Acked-by: Andrew Davis <afd@ti.com>

>   	default y
>   	help
>   	  Enabling this will indicate that the system has separate DM
