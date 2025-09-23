Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F3CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 16:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65ADA80107;
	Tue, 23 Sep 2025 18:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZA9JFpE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D8980107; Tue, 23 Sep 2025 18:18:53 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80390800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 18:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NGIkiu1489682;
 Tue, 23 Sep 2025 11:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758644326;
 bh=QfvJpDQ/Ke+4cmkC82MXNZ4bbvYH4sgAGKLd8ARH2/c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZA9JFpE+7u2QUgKmtJRsNCOJDmhSF3INnTbfu2Vrr3ehWb+kxZ0NWMAei/A/NfFnK
 NXa9khJwe0f9rsIWwSdl1XOL+UVwkF6nnPgP+ny+cz+ZGdNrgXjXm2V0JXDGFq0raA
 m1fx8gotaAKBZvv0borC66lWBD1j0UlOektCSnkI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NGIk6l2097507
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 11:18:46 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 11:18:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 11:18:45 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NGIjDB575979;
 Tue, 23 Sep 2025 11:18:45 -0500
Message-ID: <134414a0-8fcc-4fb0-9f53-3dc803d41b70@ti.com>
Date: Tue, 23 Sep 2025 11:18:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] spl: Kconfig: allow K3 devices to use falcon mode
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>,
 <kever.yang@rock-chips.com>, <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
References: <20250923130901.705124-1-anshuld@ti.com>
 <20250923130901.705124-3-anshuld@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250923130901.705124-3-anshuld@ti.com>
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

On 9/23/25 8:08 AM, Anshul Dalal wrote:
> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
> HS devices and but can now be enabled with the addition of
> OS_BOOT_SECURE.
> 
> For secure boot, the kernel with x509 headers can be packaged in a fit
> container (fitImage) signed with TIFS keys for authentication.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   common/spl/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 7e87e50f693..ab780da9e1c 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1201,7 +1201,7 @@ config SPL_ONENAND_SUPPORT
>   
>   config SPL_OS_BOOT
>   	bool "Activate Falcon Mode"
> -	depends on !TI_SECURE_DEVICE
> +	select SPL_OS_BOOT_SECURE if TI_SECURE_DEVICE
>   	help
>   	  Enable booting directly to an OS from SPL.
>   	  for more info read doc/README.falcon

The subject doesn't need to include "K3", this is for all
TI secure devices.

This patch should also go last in the series. Not that it
causes any break, but feels like a "security bisectability"
problem to allow something and then after make it secure.

Andrew
