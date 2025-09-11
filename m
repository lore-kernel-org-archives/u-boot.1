Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E83CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 16:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9012D833BF;
	Thu, 11 Sep 2025 18:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hSsIXK5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DECB833BF; Thu, 11 Sep 2025 18:43:31 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71F283390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 18:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BGhQs6335064;
 Thu, 11 Sep 2025 11:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757609006;
 bh=Yhz2Sx1sbgYNW3c6fTk6JCcIGPKr0z1vRuC3J0G5jpE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hSsIXK5HKlzgstkkq+e1PrsxeJnllrWKQzfXB0oUjvfsO0yEKykd1MHGOgQwu0DTX
 D4jBE0ZUHMWv0c2eYl/fllbIRgPFCKdSmChzLDHVpsYh+ZizIo7H0AzasiBUy/McMc
 E5VM0UVLRAjGEd6+s9EB7PbsdaFq/nDgdAGmlKkc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BGhQQ31189423
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 11:43:26 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 11:43:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 11:43:25 -0500
Received: from [128.247.81.0] (ula0226330.dhcp.ti.com [128.247.81.0] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BGhPue2426162;
 Thu, 11 Sep 2025 11:43:25 -0500
Message-ID: <1e9902a0-3d0b-4266-b18f-0b0ad6ffbe13@ti.com>
Date: Thu, 11 Sep 2025 11:43:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v1 03/17] spl: Kconfig: allow K3 devices to use falcon
 mode
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-4-anshuld@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250911131414.3296697-4-anshuld@ti.com>
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

On 9/11/25 8:13 AM, Anshul Dalal wrote:
> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
> HS devices and can be enabled on K3 devices.
> 

The reason we disabled Falcon Mode for these devices is because it
could not be done securely, this is exactly what your series here
is intended to fix. If we have secure falcon boot, then we should
enable it for 32-bit devices also. Enable this for all TI devices
and you can drop the previous patch.

Andrew

> For secure boot, the kernel with x509 headers can be packaged in a fit
> container (fitImage) signed with TIFS keys for authentication.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   common/spl/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 7e87e50f693..4f817fd31c5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1201,7 +1201,8 @@ config SPL_ONENAND_SUPPORT
>   
>   config SPL_OS_BOOT
>   	bool "Activate Falcon Mode"
> -	depends on !TI_SECURE_DEVICE
> +	depends on !TI_SECURE_DEVICE_K2_OMAP2PLUS
> +	select SPL_OS_BOOT_SECURE if TI_SECURE_DEVICE_K3
>   	help
>   	  Enable booting directly to an OS from SPL.
>   	  for more info read doc/README.falcon

