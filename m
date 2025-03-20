Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF3C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 06:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F17080F0E;
	Thu, 20 Mar 2025 07:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UMDl+S6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9820580FF0; Thu, 20 Mar 2025 07:46:07 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5FA809D4
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6k3xt3167118
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Mar 2025 01:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742453163;
 bh=EYqQdEXc5aa+6aDgZAqzQXG5HL+ov9X88dxdOGbppbE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UMDl+S6mKUSpbhsQrqH6TeG6qKYdq2/7n29uP1bvw7XUS3T7qhS60hXvX9X/lZnME
 erK2ZcQ9RSmuEaFO4e3xVbZxAcY5GbDqAy+Y8VJXNSu0jypcLH4ydtUuiXODKQB6FR
 PUR+M72JopK1knH9/rpmIncrRuRXzH9pYf4/zEp8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6k3Hf020834;
 Thu, 20 Mar 2025 01:46:03 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 01:46:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 01:46:02 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6k0jH111746;
 Thu, 20 Mar 2025 01:46:00 -0500
Message-ID: <535b97ce-6802-47a6-8fcd-5157766d012b@ti.com>
Date: Thu, 20 Mar 2025 12:15:59 +0530
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

Hi Anurag,

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

Indentation seems to be off

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

-- 
Thanking You
Neha Malcom Francis
