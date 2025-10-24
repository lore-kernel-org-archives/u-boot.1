Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F00BCCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 11:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37A5835B3;
	Fri, 24 Oct 2025 13:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A54C8362A; Fri, 24 Oct 2025 13:24:11 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5965982E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 13:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6283FB220116;
 Fri, 24 Oct 2025 13:24:07 +0200 (CEST)
Message-ID: <8d762357-5ae8-4cd4-b9fd-37a7ab3eb678@freeshell.de>
Date: Fri, 24 Oct 2025 04:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] eeprom: starfive: Simplify
 get_ddr_size_from_eeprom()
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024085932.83596-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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



On 10/24/25 01:59, Hal Feng wrote:
> Directly return the DDR size instead of the field of 'DxxxExxx'.
> Move the function description to the header file.
> Return 0 instead of 0xFF if read_eeprom() fails.
> 
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/cpu/jh7110/spl.c                     |  2 +-
>  arch/riscv/include/asm/arch-jh7110/eeprom.h     |  8 +++++++-
>  .../visionfive2/visionfive2-i2c-eeprom.c        | 17 +++--------------
>  3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
> index 87aaf865246..3aece7d995b 100644
> --- a/arch/riscv/cpu/jh7110/spl.c
> +++ b/arch/riscv/cpu/jh7110/spl.c
> @@ -41,7 +41,7 @@ int spl_dram_init(void)
>  	/* Read the definition of the DDR size from eeprom, and if not,
>  	 * use the definition in DT
>  	 */
> -	size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;
> +	size = get_ddr_size_from_eeprom();
>  	if (check_ddr_size(size))
>  		gd->ram_size = size << 30;
>  
> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> index 45ad2a5f7bc..1ae9f2b840a 100644
> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> @@ -10,7 +10,13 @@
>  #include <linux/types.h>
>  
>  u8 get_pcb_revision_from_eeprom(void);
> -u32 get_ddr_size_from_eeprom(void);
> +
> +/**
> + * get_ddr_size_from_eeprom() - read DDR size from EEPROM
> + *
> + * @return: size in GiB or 0 on error.
> + */
> +u8 get_ddr_size_from_eeprom(void);
>  
>  /**
>   * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 17a44020bcf..ca5039ee433 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -550,23 +550,12 @@ u8 get_pcb_revision_from_eeprom(void)
>  	return pbuf.eeprom.atom1.data.pstr[6];
>  }
>  
> -/**
> - * get_ddr_size_from_eeprom - get the DDR size
> - * pstr:  VF7110A1-2228-D008E000-00000001
> - * VF7110A1/VF7110B1 : VisionFive JH7110A /VisionFive JH7110B
> - * D008: 8GB LPDDR4
> - * E000: No emmc device, ECxx: include emmc device, xx: Capacity size[GB]
> - * return: the field of 'D008E000'
> - */
> -
> -u32 get_ddr_size_from_eeprom(void)
> +u8 get_ddr_size_from_eeprom(void)
>  {
> -	u32 pv = 0xFFFFFFFF;
> -
>  	if (read_eeprom())
> -		return pv;
> +		return 0;
>  
> -	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
> +	return (hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL) >> 16) & 0xFF;
>  }
>  
>  u32 get_mmc_size_from_eeprom(void)

LGTM

Reviewed-by: E Shattow <e@freeshell.de>
