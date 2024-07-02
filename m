Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38D8C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 04:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A4588718;
	Tue,  2 Jul 2024 06:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719893069;
	bh=bvH41JazhyCRM+ndro4NDRtmx0Hz0m9ETxG7LOSEOko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yQ8UfTKDa1IwovmKxAIXLc5KM4ZK0UuD2tkEY48O4gWcJFXRsshBgt3DiqYDkueD8
	 QxNUcqKTlwAI5wZ8P2TBw3tBWECxvJVDc/g1o55RFC9NKxeu1oOocErWW/PQc5Lspw
	 TJJ7ufM17uz+6bwmRwmO4VbVBpxN9Y+IXlm+44+h3RET3NBCpg0P6drPBohfgYYHOW
	 pGIH2d8ivYyo9dbyB5h7+WUI9Rzwex0TQ/K27tPbkGW0/7FNP3eBmmm9//GOV04f/w
	 4plx0sA3FAZFqkLZdu8loqyfX0hcH8vwsZ7aAe0kZ8TiY+KVrNo742nn1v6USapG1g
	 2bIC76Xej86jQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A8B8C886FD;
 Tue,  2 Jul 2024 06:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719893068;
 bh=bvH41JazhyCRM+ndro4NDRtmx0Hz0m9ETxG7LOSEOko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IXNMGr3W8EQP/C+ORXvYGd3K1/K2OcjssBusN+0xkdlonzltIF3/kkLam7FHePtEG
 Zi6LRh6aF63oozGamZj0OitDm1rFQt2tZRS+0COIr07APYMwQ9Nu/Eo0e/wzhx/vHC
 p6h5rkbzkms7soCbKlKmcJIMb6jOPaTN0owIIKoy8H68cz1+6Z9AflZEJjvYBXtpSn
 /x1jfQ/ty1RwuHEdIZozeAoklZko0wPiY2wJqNkRM/3biY5WspPvh00mNCTklHRDqd
 ikHkib9AfJEe7ONK/o1y2gPFAGrwmSNCUX3hyn3KSqyhmX0tDZ1qOs0/3SlLljm1FY
 Etdb0Whmh99IA==
Message-ID: <bc923c6b-e2d9-4a12-be6f-7e5d404b1665@denx.de>
Date: Tue, 2 Jul 2024 02:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: socfpga: fix broken function call for arria10
To: Lothar Rubusch <l.rubusch@gmail.com>, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de
References: <20240701215927.285961-1-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240701215927.285961-1-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/1/24 11:59 PM, Lothar Rubusch wrote:
> Remove obsolete arguments in the function call. The call's argument list
> differs from its more recent definition. This breaks compilation of the
> 'socfpga_arria10_defconfig' target, with additionally enabled:
> 
>    CONFIG_CADENCE_QSPI=y'
> 
> The removed arguments are obtained from device-tree declaration.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> The patch makes the problem disappear. While messing with some old
> Intels, it looked to me as if this usually turned off code region of
> the misc_arria10.c still contains legacy arguments in the call. Thus
> broke my compilation. I'm unsure. Please verify.
> ---
>   arch/arm/mach-socfpga/misc_arria10.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
> index 93c9e8b0..5c782f6b 100644
> --- a/arch/arm/mach-socfpga/misc_arria10.c
> +++ b/arch/arm/mach-socfpga/misc_arria10.c
> @@ -211,11 +211,9 @@ int qspi_flash_software_reset(void)
>   	struct udevice *flash;
>   	int ret;
>   
> -	/* Get the flash info */
> +	/* Get the flash info, speed and mode will be read from DT */
>   	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
>   				     CONFIG_SF_DEFAULT_CS,
> -				     CONFIG_SF_DEFAULT_SPEED,
> -				     CONFIG_SF_DEFAULT_MODE,
>   				     &flash);

Reviewed-by: Marek Vasut <marex@denx.de>

Could you by any chance also send a patch to enable this QSPI NOR 
support on one of the A10 targets, so the CI would compile this code and 
this code wouldn't bitrot again ?

Thanks
