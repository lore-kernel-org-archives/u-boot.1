Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FB5C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7E882153;
	Tue,  6 May 2025 16:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aEq28cnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D8F82162; Tue,  6 May 2025 16:33:13 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37D0820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546EX82G525223
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 09:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746541988;
 bh=a7n/a8n8RvlJ85rWOWXct/oZx2jK/I2cemu7kZojdwU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aEq28cnTQ9qrDoeyMj57ZMocN1B0FMmnWTzLWn/QLuNhIf9R13X5O81e4sfKTkg/s
 wIujInaCnO9pCUagx0d+W5VQFqT3hysVyG+Vcadnd+gSNCCIWEb4lHbkvH+fku3E8U
 qbF88htWwVEcTOKRa2XWQQ/m+liuW5qqk4F8sjtM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546EX8bm031402
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 09:33:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 09:33:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 09:33:08 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546EX7tO057078;
 Tue, 6 May 2025 09:33:07 -0500
Message-ID: <b3cc74a0-3903-4970-89b3-eceb973a791c@ti.com>
Date: Tue, 6 May 2025 09:33:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] spl: Kconfig: allow K3 devices to use falcon mode
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>
References: <20250428141235.1734014-1-anshuld@ti.com>
 <20250428141235.1734014-2-anshuld@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250428141235.1734014-2-anshuld@ti.com>
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

On 4/28/25 9:12 AM, Anshul Dalal wrote:
> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
> HS devices and can be enabled on K3 devices.
> 
> For secure boot, the kernel with x509 headers can be packaged in a fit

"can be", this is the issue. Security is not just allowing methods that
are security checked, but forcing the use of such methods. Setting
OS_BOOT opens up several paths that look for non-FIT images. These
images do not enforce authentication like FIT does. This means one can
bypass secure boot when OS_BOOT is enabled by simply placing a non-FIT
boot image on the boot media.

Andrew

> container (fitImage) signed with TIFS keys for authentication.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   common/spl/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index c08045f9c8d..68e900e9b91 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1165,7 +1165,7 @@ config SPL_ONENAND_SUPPORT
>   
>   config SPL_OS_BOOT
>   	bool "Activate Falcon Mode"
> -	depends on !TI_SECURE_DEVICE
> +	depends on !TI_SECURE_DEVICE || ARCH_K3
>   	help
>   	  Enable booting directly to an OS from SPL.
>   	  for more info read doc/README.falcon
