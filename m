Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89651C369D7
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2DD8082A;
	Tue, 22 Apr 2025 16:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yMIThu/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA6F80FEC; Tue, 22 Apr 2025 16:32:52 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0349B8070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEWmHE1243450
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 09:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745332368;
 bh=q4nBngF7HPy/UKoL6IA4/zUWyfZSjj9636wSfJf3s9o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=yMIThu/SZEU+pfNKnZSFWmxHJuFQKpIJqSM7sJ1dx7ZC+qWZQi5t/Q6rRVSp3wi4N
 ElnslQSbO2YUm4nfgpQrY5RPcZEpvP17q7WmpCdDEbgpArA69RGNLqg4V3fXCxoyxi
 hyH1tI7wQusXDI49rr8kRloSh5lZy/p3QPcj7TRA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEWm2l008512
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 09:32:48 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 09:32:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 09:32:48 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MEWldf026813;
 Tue, 22 Apr 2025 09:32:47 -0500
Message-ID: <38af28d7-e8b3-41a4-ae5c-1e862f306189@ti.com>
Date: Tue, 22 Apr 2025 09:32:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Add config option for booting HSM core
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-2-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250422095430.363792-2-b-padhi@ti.com>
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

On 4/22/25 4:54 AM, Beleswar Padhi wrote:
> Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
> M4F core in the Wakeup Voltage Domain which could be used to run secure
> services like Authentication. Add a config option which indicates that
> the SoC has a HSM core and the firmware for the core is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm/mach-k3/Kconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb96..b787d2da244 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -181,6 +181,14 @@ config K3_REMOTEPROC_PRU
>   	imply REMOTEPROC_TI_PRU
>   	default y if (SOC_K3_AM642 || SOC_K3_AM654)
>   
> +config K3_HSM_FW
> +	bool "Load and Boot HSM core"
> +	default n

Default is already n, no need for this line.

Andrew

> +	help
> +	  Enabling this will indicate that the system has a HSM (High Security
> +	  Module) M4 Core and the firmware for the core is present. When
> +	  enabled, HSM core will be booted at R5 SPL execution time.
> +
>   if CPU_V7R
>   source "arch/arm/mach-k3/r5/Kconfig"
>   endif
