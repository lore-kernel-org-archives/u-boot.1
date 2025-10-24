Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EE4CCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 11:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9778B835B3;
	Fri, 24 Oct 2025 13:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65521835FE; Fri, 24 Oct 2025 13:30:21 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B58482E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 13:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6B091B22088A;
 Fri, 24 Oct 2025 13:30:17 +0200 (CEST)
Message-ID: <5baade67-579e-494e-8161-0f17ceeecf0b@freeshell.de>
Date: Fri, 24 Oct 2025 04:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-5-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024085932.83596-5-hal.feng@starfivetech.com>
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
> pcb_revision is stored in the pcb_revision field of ATOM4. Correct it.
> Move the function description to the header file.
> Return 0 instead of 0xFF if read_eeprom() fails.
> 
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/include/asm/arch-jh7110/eeprom.h         |  5 +++++
>  board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 11 ++---------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> index 1ae9f2b840a..8b689a75013 100644
> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> @@ -9,6 +9,11 @@
>  
>  #include <linux/types.h>
>  
> +/**
> + * get_pcb_revision_from_eeprom() - get the PCB revision
> + *
> + * @return: the PCB revision or 0 on error.
> + */
>  u8 get_pcb_revision_from_eeprom(void);
>  
>  /**
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index ca5039ee433..986dcc94992 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -535,19 +535,12 @@ int mac_read_from_eeprom(void)
>  	return 0;
>  }
>  
> -/**
> - * get_pcb_revision_from_eeprom - get the PCB revision
> - *
> - * 1.2A return 'A'/'a', 1.3B return 'B'/'b',other values are illegal
> - */
>  u8 get_pcb_revision_from_eeprom(void)
>  {
> -	u8 pv = 0xFF;
> -
>  	if (read_eeprom())
> -		return pv;
> +		return 0;
>  
> -	return pbuf.eeprom.atom1.data.pstr[6];
> +	return pbuf.eeprom.atom4.data.pcb_revision;
>  }
>  
>  u8 get_ddr_size_from_eeprom(void)

LGTM

Reviewed-by: E Shattow <e@freeshell.de>
