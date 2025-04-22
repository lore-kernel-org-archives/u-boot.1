Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF83C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B63812BC;
	Tue, 22 Apr 2025 16:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vZuao3JT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAE181E25; Tue, 22 Apr 2025 16:37:37 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 460A681273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEbXvi1989152
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 09:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745332653;
 bh=mod60KQT3y51XvAJlBC/32GTdJkVSd0Gj29MmZWF3QI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=vZuao3JTYZXQHer75/6YWkj2xhaWAX/8oskJ7JrOIdognCRzcQxp5/HST2PbxAZML
 yV8cRmzYyldKNbehUf6v/NID/q/MvxtD1q5b5iKwZL/eaxRuaSOSVdK6G5Du8tWlGV
 vs8VZf2oK8F4szgBRtrwtIjvx5P8oDFGTMZHr7JY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEbXDp103846
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 09:37:33 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 09:37:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 09:37:33 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MEbT5G019885;
 Tue, 22 Apr 2025 09:37:30 -0500
Message-ID: <4917db59-9533-4540-a1d5-e648e4a0b5f3@ti.com>
Date: Tue, 22 Apr 2025 20:07:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Add config option for booting HSM core
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-2-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
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


On 4/22/2025 3:24 PM, Beleswar Padhi wrote:
> Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
> M4F core in the Wakeup Voltage Domain which could be used to run secure
> services like Authentication. Add a config option which indicates that
> the SoC has a HSM core and the firmware for the core is available.

Config option can not indicate firmware is available for core.

Thic could be

Add a config option which allows load of HSM firmware and booting of HSM core.


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
> +	help
> +	  Enabling this will indicate that the system has a HSM (High Security
> +	  Module) M4 Core and the firmware for the core is present. When
> +	  enabled, HSM core will be booted at R5 SPL execution time.
> +
>   if CPU_V7R
>   source "arch/arm/mach-k3/r5/Kconfig"
>   endif
