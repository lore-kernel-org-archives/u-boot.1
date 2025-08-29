Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA3CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB8EC83447;
	Fri, 29 Aug 2025 09:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JyCdwS1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFE583447; Fri, 29 Aug 2025 09:33:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 324568328F
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F97E3F7CB
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756452831;
 bh=A0EM6DgsbVoAAbkI04s7EQRoyQ4dN06CN5fZ5HdDEYw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=JyCdwS1FN0Az2tvv7JNfP1rGc0xGycP50c0FCBzYBoWxVOZ3bs861tptmmZ1y1UVp
 Rf/tCAvNO9157AoJ7BrU84PBvEoq9YSzBQWON4XjA12i9NWguaT2A1PGZxnthcNMJb
 RI6F+wGUNB7l+StReOt2Z+/Jhhz2+viYoHhdwZPJ2typq0Cszwi12kNQSTPigLuTaF
 ARfXTGwC6+nKKa3CEcKZNyoj3myhLgMm/9CY42Jk3y7J/3jiphaCoy/blsFpb/8j30
 4BxC8jlDvMHio7i57yaHr0ogUNEvk2ydcv/raIrqo2QUTbdDN55dLQi8cJmy5FKvke
 RyCxbAT9t+8nw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b05d8d0so12311735e9.1
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 00:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756452830; x=1757057630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0EM6DgsbVoAAbkI04s7EQRoyQ4dN06CN5fZ5HdDEYw=;
 b=KDa3k/Yk+QXsdepUCneV0Y23zKyOc1bjzOvEYn6lra3gTLi1j2OEeZq/p2CC8eTC/2
 RVviARatq6gcui4x9V0cyNx10ILmtpYud6/l4FNyZaowcWd37fESpxaZfPFvFDjYDZbl
 g3r30tsS7fTDdqzmqh0IFKkUBvGU8Z7v6orzUxeDS4I37APDVRKZ8Mfo0Dd0PQK3SPzX
 W5jtOWNsOQIs8iYFA8pOgLIqksE2rQLST9jptDKwa0odVf6CuMMqsVHM+D2kq8nuPDtd
 e2epj6msHBXQWgGs2zmFRXZGi6p80Qn44rkJoDGs7RNTjtYSYZZgHlNt49TbxaLHwahw
 Vqxw==
X-Gm-Message-State: AOJu0YxwHzk6xZnGTI95dBDe2jonvcZNhBS1mG+8/4e6EmAn7jXZOjlG
 OhGAWUuUNEPtKuZDo5HdBrlmrjpWzpGulSPoam2isSTlOeMjyeil5rqltDwEg8QaQdEzgiH+0xm
 el8S4NWS2mgPCa1xnAkKTxI+fXvu3vlT8ksfSgMLhNNkxXq+1hKbzGNT9rGh4SKusY8pA0iI=
X-Gm-Gg: ASbGncsPyLe+p/g9utgOEK6la2O2CoGL/vipsS6St8XvK6BA6s7XPZEitNnatLPR+XO
 xqdRvKQpP66pfpGv41SHxOkWxBRMXnVO0rCUlFrwvvMxnAaQYbNBd44G2TXLlpBv12xF9zEEmC4
 wbZ94FpnVD2Hiz3osZcXGYH1MDV4HmwsccAEX70xCXtg0iIJAT0FBcj87DkuPQidZJeDbeYuuVr
 kNIY64EBIJMwMAim/IhYpuijuZEkbLG0CBqmGdhahsLIT0RaTN/sg7jaz0h3te2xusuVx5p8M79
 hVimZ10WmL+/sfhyv1Czjy9nnezEB9SKIisiz6upycJlDz/cctPcIUjfNl+cEaLAjd/gi0MXAw2
 tN9zzevs2+/gxjbwkNegisgl1URt/
X-Received: by 2002:a5d:5889:0:b0:3cf:74e0:55b9 with SMTP id
 ffacd0b85a97d-3cf74e05a00mr1320802f8f.63.1756452830001; 
 Fri, 29 Aug 2025 00:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdrfneo77GWPS51cNuZxV32n8myLGtpS1EepBbrzHYI+xg8gJYWjf6gtteqlDLWK3GgIhAlQ==
X-Received: by 2002:a5d:5889:0:b0:3cf:74e0:55b9 with SMTP id
 ffacd0b85a97d-3cf74e05a00mr1320778f8f.63.1756452829501; 
 Fri, 29 Aug 2025 00:33:49 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d?
 ([2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d8ebdsm2248014f8f.28.2025.08.29.00.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 00:33:48 -0700 (PDT)
Message-ID: <3f7547d9-5abb-42d9-9bf8-02329ced4364@canonical.com>
Date: Fri, 29 Aug 2025 09:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/10] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
To: Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250829060931.79940-4-hal.feng@starfivetech.com>
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

On 29.08.25 08:09, Hal Feng wrote:
> Directly return the DDR size instead of the field of 'DxxxExxx'.
> Move the function description to the header file.
> 
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   arch/riscv/cpu/jh7110/spl.c                     |  2 +-
>   arch/riscv/include/asm/arch-jh7110/eeprom.h     |  8 +++++++-
>   .../visionfive2/visionfive2-i2c-eeprom.c        | 17 +++--------------
>   3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
> index 87aaf865246..3aece7d995b 100644
> --- a/arch/riscv/cpu/jh7110/spl.c
> +++ b/arch/riscv/cpu/jh7110/spl.c
> @@ -41,7 +41,7 @@ int spl_dram_init(void)
>   	/* Read the definition of the DDR size from eeprom, and if not,
>   	 * use the definition in DT
>   	 */
> -	size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;
> +	size = get_ddr_size_from_eeprom();
>   	if (check_ddr_size(size))
>   		gd->ram_size = size << 30;
>   
> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> index 45ad2a5f7bc..6d0a0ba0c4a 100644
> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> @@ -10,7 +10,13 @@
>   #include <linux/types.h>
>   
>   u8 get_pcb_revision_from_eeprom(void);
> -u32 get_ddr_size_from_eeprom(void);
> +
> +/**
> + * get_ddr_size_from_eeprom() - read DDR size from EEPROM
> + *
> + * @return: size in GiB or 0xFF on error.
> + */
> +u8 get_ddr_size_from_eeprom(void);
>   
>   /**
>    * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 17a44020bcf..3866d07f9d4 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -550,23 +550,12 @@ u8 get_pcb_revision_from_eeprom(void)
>   	return pbuf.eeprom.atom1.data.pstr[6];
>   }
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
>   {
> -	u32 pv = 0xFFFFFFFF;
> -
>   	if (read_eeprom())
> -		return pv;
> +		return 0xFF;

Let's assume somebody cleared the EEPROM and the SPI flash.

Would it make sense to assume the minimum encodable RAM size (1 GiB) in 
this case, just to let the board boot to the console to allow writing 
the EEPROM with valid data again?

The current patch to simplify the code looks correct.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

>   
> -	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
> +	return (hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL) >> 16) & 0xFF;
>   }
>   
>   u32 get_mmc_size_from_eeprom(void)

