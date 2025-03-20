Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3558C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 06:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A43E8083E;
	Thu, 20 Mar 2025 07:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kzZLyCQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F3C8083E; Thu, 20 Mar 2025 07:50:35 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9440E8003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6oUkh3147278
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 01:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742453430;
 bh=aPgSjYMyiCIepAa64lFchU9cE3xeZRjWxnsMeujHCec=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kzZLyCQXxN2MtMq89X/U/XFe7c7KfpuvnhgGXJMZsICRWhLk0QD63RKVkPcYRKAVa
 N8BnfDycRQiudp4D58gROsPnBk45NI71/+VNlwT+zzTSTIRfuDuPhV4rT0X8AJ5syQ
 D6fzD6X1IluqwIbVA0ior719pne/SR6xDfB/VHsY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6oUjW006774
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Mar 2025 01:50:30 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 01:50:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 01:50:29 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6oR1q116874;
 Thu, 20 Mar 2025 01:50:28 -0500
Message-ID: <6e0cf522-4878-4620-a2ad-db2933697a3e@ti.com>
Date: Thu, 20 Mar 2025 12:20:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mux: Kconfig: Add Kconfig options for MUX_MMIO
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <a-limaye@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250320063004.1069653-1-a-dutta@ti.com>
 <20250320063004.1069653-2-a-dutta@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250320063004.1069653-2-a-dutta@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

On 20/03/25 12:00, Anurag Dutta wrote:
> Add Kconfig options for MUX_MMIO so that it can be enabled
> in SPL stage.
> 
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>  drivers/mux/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index f15ee4f833f..2b95eb02177 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -10,6 +10,16 @@ config MULTIPLEXER
>  
>  if MULTIPLEXER
>  
> +config SPL_MUX_MMIO
> +	bool "MMIO register bitfield-controlled Multiplexer"
> +        depends on MULTIPLEXER && SYSCON
> +        help
> +          MMIO register bitfield-controlled Multiplexer controller.
> +
> +          The driver builds multiplexer controllers for bitfields in a syscon
> +          register. For N bit wide bitfields, there will be 2^N possible
> +          multiplexer states.
> +
>  config MUX_MMIO
>  	bool "MMIO register bitfield-controlled Multiplexer"
>  	depends on MULTIPLEXER && SYSCON


Maybe I'm missing something but what is this config supposed to do
exactly? It only depends on a couple of configs (is not selecting them)
and I don't see it doing anything in the code.

-- 
Thanking You
Neha Malcom Francis
