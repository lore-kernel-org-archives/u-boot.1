Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD679C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 05:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D478F88668;
	Fri, 19 Apr 2024 07:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713504708;
	bh=7XlJY68jpa59R3R/wT/DAbab8y/apudOHN8U4ZyLTBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uWL8riQcBqpTq0b6Q2n6CMueg4uA2QB0VUtfHFQrm9fN8VmV9ZTOSmdHeyg8+GKio
	 EjNQ7CZxfAyslW31v5C+uvFy3Y3KheHJMzwVXDdgH0KM0MVAzfGMpM3usR/CO9KQIl
	 /95FehhcmCxIGOpvD84V6hG8+VpJQKxlRZCP/0cR275MKDLTibYew6fw5zulbbUpoE
	 LT+Z+jGP7/MsQlRoetNiRFiAjN+iUMPQnutPKd9xBzjNJ72OGIWK4c9KgP6BsUS9Wd
	 L2X0xvCjOdUchXgUsdkH6Fz6eoTqY3zBGTeIPZEfz5bx+cHDU0hTdSL3Z/von+cagF
	 IC6YO2t+VBjkA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 11A9A88629;
 Fri, 19 Apr 2024 07:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713504707;
 bh=7XlJY68jpa59R3R/wT/DAbab8y/apudOHN8U4ZyLTBY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K/CJcV/NuJXqDr9eCfSQaJ11IccI8AqNmFVmwxWISCR1NbsL6U7uR8q91++2222DQ
 PQrRTi/XhaTrbWTLp0svh9n8Hy0Pw6mSSPnYMrs6ZwV9SjkZG/3FkElZk1339YHGWw
 ISd/L8m6iRC+yvTEM/dPdT5y+q3HOPwtDYjmiDTuqoT+akPsAb7u7377RzfOVn21sd
 nlbgCptGOK3BNdIbTYWBjdjbDLtudVFoxJGbLEvfTwW0VD/OnKXqKsycWNrLvlzxG/
 az8UJlvjBf4VqtiCP2bir/y93zbAyNCURYRK1tRK0S1YH0W7Z/uQp39nNlSqZQrc2q
 UPZnKlaMNB3rg==
Message-ID: <de1e8291-23cd-49d8-8070-d41b429f7cd3@denx.de>
Date: Fri, 19 Apr 2024 05:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on
 STM32MP15xx
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
References: <20240415125541.6547-1-marex@denx.de>
 <f4d25293-e9c6-45de-a0d9-643252e2a0b6@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <f4d25293-e9c6-45de-a0d9-643252e2a0b6@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/18/24 8:24 PM, Patrick DELAUNAY wrote:
> Hi,

Hi,

[...]

>> @@ -136,6 +140,18 @@ static void security_init(void)
>>        */
>>       writel(0x0, TAMP_CR1);
>> +    /*
>> +     * TAMP: Configure non-zero secure protection settings. This is
>> +     * checked by BootROM function 35ac on OTP-CLOSED device during
>> +     * CPU core 1 release from endless loop. If secure protection
>> +     * fields are zero, the core 1 is not released from endless
>> +     * loop on second SGI0.
>> +     */
>> +    clrsetbits_le32(TAMP_SMCR,
>> +            TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
>> +            FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x10) |
>> +            FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x10));
>> +
>>       /* GPIOZ: deactivate the security */
>>       writel(BIT(0), RCC_MP_AHB5ENSETR);
>>       writel(0x0, GPIOZ_SECCFGR);
> 
> 
> The recommended mapping (the mapping done in OP-TEE for OpenSTLinux) is 
> described in Wiki page
> 
> - 10 backup register secure
> 
> - 4  backup register secure write / non secure read
> 
> - 17 backup register Non-secure
> 
> It is done in
> 
> https://github.com/STMicroelectronics/optee_os/blob/3.19.0-stm32mp/core/arch/arm/plat-stm32mp1/main.c
> 
> with
> 
> 
> static TEE_Result stm32_configure_tamp(void)
> {
>      TEE_Result res __maybe_unused = TEE_SUCCESS;
>      struct stm32_bkpregs_conf bkpregs_conf = {
>          .nb_zone1_regs = 10, /* 10 registers in zone 1 */
>          .nb_zone2_regs = 5   /* 5 registers in zone 2 */
>                       /* Zone3 all remaining */
>      };
> 
>      /* Enable BKP Register protection */
>      if (stm32_tamp_set_secure_bkpregs(&bkpregs_conf))
>          panic();
> 
> 
> But when you are booting with SPL U-boot, all the boot chain and the 
> Linux kernel
> 
> is running in secure world
> 
> 
> So you have no reason to manage any limit for the access to backup 
> register,
> 
> you can allocate all the backup registers (the 32 one) to secure world
> 
> See "Figure 552. Backup registers secure protections" in reference mnauel
> 
> Protection zone 1 => x = 31 with  BKPRWDPROT = 31
> 
> Protection zone 2 & 3 => empty
> 
> +    clrsetbits_le32(TAMP_SMCR,
> +            TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
> +            FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
> +            FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
> 
> 
> Sorry for the delay, I need also to check on my side
> 
> 
> But anyway your proposal is functional,
> 
> So with or without the previous remark

Thank you for the detailed explanation and for checking this.
V3 is coming now.
