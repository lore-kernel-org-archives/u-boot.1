Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341D2C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 09:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6278841F;
	Tue, 28 May 2024 11:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b68Abti9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B3388422; Tue, 28 May 2024 11:03:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE168841D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S93H2e122541;
 Tue, 28 May 2024 04:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716886997;
 bh=wNrR8ftPkUG8jpZj+rewG8C2HhdB3eJmvkf80d8QOm0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=b68Abti9RD9nVQdF/fkJkuQO/JKRNwAX2rdlDuoIVbE/F+cntJfBVYzuu/H9MTk57
 uXRwhQSEQYZLbzJ7poqzm5hFmEIhD1ZiIuFCVqLT9kXrGWbrYmSQmwbLVROE/2vMDG
 vmOEm/NHEllCaHeGHeznuk2DFnDcdCjiq9C5MquU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S93H6D073088
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 04:03:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 04:03:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 04:03:17 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S93Ds6022887;
 Tue, 28 May 2024 04:03:14 -0500
Message-ID: <2781fe82-2c1c-4bc8-9274-b6246561eed4@ti.com>
Date: Tue, 28 May 2024 14:33:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] power: pmic: tps65941: Add DM_PMIC dependency
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
 <20240528-b4-upstream-j721s2-avs-v2-1-df940f2309d0@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-1-df940f2309d0@ti.com>
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

Hi Manorit

On 28/05/24 13:43, Manorit Chawdhry wrote:
> This Kconfig depends on DM_PMIC but hadn't be explicitly stated which
> could cause config related issues.
> 
> Adds the dependency in Kconfig for tps65941.
> 
> Fixes: 6b86dd0c1ead ("power: pmic: tps65941: Add support for tps65941 family of PMICs")
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   drivers/power/pmic/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 562c1a3b122a..bbcbcee4c355 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -394,6 +394,7 @@ config SPL_PMIC_LP87565
>   
>   config PMIC_TPS65941
>   	bool "Enable driver for Texas Instruments TPS65941 PMIC"
> +	depends on DM_PMIC
>   	help
>   	The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
>   	This driver binds the pmic children.
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
