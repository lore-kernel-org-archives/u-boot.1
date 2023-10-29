Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3394C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA01D87098;
	Sun, 29 Oct 2023 08:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bd6NEu+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD41870F2; Sun, 29 Oct 2023 08:52:24 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2999C8708A
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 170A43F68B
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698565940;
 bh=Vm4hlFRSgEyPOxJ8JznxEfpKNrW4j9i5PSYa8P/BYzI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=bd6NEu+ZrLve79cgw3+OBe7SJsBoyZge8ADrr2cjS4mBt4rRiE2s2kWgFtWUROoNp
 +AkwiBA7ELHT00ezYi7xLMiiIu2f+o7CvE0C68XIYFck6SqlxgS0BnEqaftkQ55GY6
 zd9VCBDW50awOttTwz6kmLljxmHhxnFLxYYRn91f34Vqwp+FpQD3NmghhdiG7xgTHt
 BEyyhcj/vlvry6u66Ecz8R+CHbjK9he95TEtZrvLLbGiqBdaEs40v1pps4iScdzjRu
 4e5depFNLN6Y4BJulr1gC8wujVNuQRWHVffKDcOZ2+7dG3Sq786QtUgTefKtLuULhD
 UbWxF2rXxGyBQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32dc767e619so1816434f8f.1
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 00:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698565939; x=1699170739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vm4hlFRSgEyPOxJ8JznxEfpKNrW4j9i5PSYa8P/BYzI=;
 b=sLIDvnXiaX1mub4ZUiOxqdtS5odesCEhtV6Di7PqTuI+ffl+fhVHc0IAZx1dmCmKYR
 LdlEbjOZ/JCvzMkKh8jWI+RvA/ZGR//wtxHRM2qs4bCVgDMPI4rEtYkZgwm/peEUinDM
 OA3AfCQSwD+gSB32fCr3avisfiMIGCCgjJOVG0N2winGLwW31mzQdv3o0Zvc0mDadh+c
 ZBrXxBOVmgkDXge8hoMsEVRywaJ9PCKHw5ggln0hKks+20dbf8lZvD3N0/iXjyhs91Ta
 rXvPdtBMD+4Ngmn54e941SR9Hf1lRUPpbnPV194XBYHO8wL9kjSQN3iXsMkVqF4xevQs
 8htQ==
X-Gm-Message-State: AOJu0YxmuNXnN8p4GOL3PexBgrCfpkuVO7nmq+9ezUUEhsi4Ef6RhZJi
 0isQwZmkoQTAAz0K9+0EYWRzrDWF9CvPiSOEfXJDJeLi/AiylchmGVfPFobDO5+2jxTKIOfYq8r
 uO4jBqhR4A8Sl8vQ2PPMt0tpamwCfw64=
X-Received: by 2002:a5d:588f:0:b0:32f:7e4e:535d with SMTP id
 n15-20020a5d588f000000b0032f7e4e535dmr2126740wrf.15.1698565939348; 
 Sun, 29 Oct 2023 00:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiaBYrfpQp4PRkh33nDP4m4EDtSfeqhnIns+qA1aGMQm3y1gpnoZfAywkQ7R651hJutHkmAg==
X-Received: by 2002:a5d:588f:0:b0:32f:7e4e:535d with SMTP id
 n15-20020a5d588f000000b0032f7e4e535dmr2126727wrf.15.1698565938879; 
 Sun, 29 Oct 2023 00:52:18 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 n15-20020a5d4c4f000000b0032f7e832cabsm2353349wrt.90.2023.10.29.00.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 00:52:18 -0700 (PDT)
Message-ID: <bbd19ee0-9429-42a7-9164-1e695e6d57f3@canonical.com>
Date: Sun, 29 Oct 2023 08:52:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] rng: Provide a RNG based on the RISC-V Zkr ISA extension
To: Chanho Park <chanho61.park@samsung.com>
Cc: 'Sughosh Ganu' <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 'Rick Chen' <rick@andestech.com>, 'Leo' <ycliang@andestech.com>
References: <CGME20231028232641epcas2p48ab2b6db1932c3035028f44f16c831d8@epcas2p4.samsung.com>
 <20231028232612.109832-1-heinrich.schuchardt@canonical.com>
 <05e001da0a2a$4c9135a0$e5b3a0e0$@samsung.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <05e001da0a2a$4c9135a0$e5b3a0e0$@samsung.com>
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

On 10/29/23 06:39, Chanho Park wrote:
> Hi,
> 
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Heinrich
>> Schuchardt
>> Sent: Sunday, October 29, 2023 8:26 AM
>> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>; u-boot@lists.denx.de; Heinrich
>> Schuchardt <heinrich.schuchardt@canonical.com>
>> Subject: [RFC 1/1] rng: Provide a RNG based on the RISC-V Zkr ISA
>> extension
>>
>> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
>> provides an interface to a physical entropy source.
>>
>> A RNG driver based on the seed CSR is provided. It depends on
>> mseccfg.sseed being set in the SBI firmware.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> This works fine on my qemu risv with your opensbi patch and KASLR has been
> tested as well.
> Feel free to add my reviewed/tested-by tag.
> 
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>
> Tested-by: Chanho Park <chanho61.park@samsung.com>
> 
> Best Regards,
> Chanho Park

Thanks for reviewing.

I am currently looking into detecting if the seed register is readable 
to avoid a possible exception if the sseed flag is not set or the Zkr 
exception is not available.

Best regards

Heinrich

> 
>> ---
>>   drivers/rng/Kconfig         |  11 ++++
>>   drivers/rng/Makefile        |   1 +
>>   drivers/rng/riscv_zkr_rng.c | 102 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 114 insertions(+)
>>   create mode 100644 drivers/rng/riscv_zkr_rng.c
>>
>> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
>> index 994cc35b27..f8f1d91ed2 100644
>> --- a/drivers/rng/Kconfig
>> +++ b/drivers/rng/Kconfig
>> @@ -48,6 +48,17 @@ config RNG_OPTEE
>>   	  accessible to normal world but reserved and used by the OP-TEE
>>   	  to avoid the weakness of a software PRNG.
>>
>> +config RNG_RISCV_ZKR
>> +	bool "RISC-V Zkr random number generator"
>> +	depends on RISCV_SMODE
>> +	help
>> +	  This driver provides a Random Number Generator based on the
>> +	  Zkr RISC-V ISA extension which provides an interface to an
>> +	  NIST SP 800-90B or BSI AIS-31 compliant physical entropy source.
>> +
>> +	  Using this driver will lead to an exception if the M-mode
>> firmware
>> +	  has not set mseccfg.sseed=1.
>> +
>>   config RNG_STM32
>>   	bool "Enable random number generator for STM32"
>>   	depends on ARCH_STM32 || ARCH_STM32MP
>> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
>> index 47b323e61e..a5d3ca4130 100644
>> --- a/drivers/rng/Makefile
>> +++ b/drivers/rng/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_RNG_MSM) += msm_rng.o
>>   obj-$(CONFIG_RNG_NPCM) += npcm_rng.o
>>   obj-$(CONFIG_RNG_OPTEE) += optee_rng.o
>>   obj-$(CONFIG_RNG_STM32) += stm32_rng.o
>> +obj-$(CONFIG_RNG_RISCV_ZKR) += riscv_zkr_rng.o
>>   obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
>>   obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
>>   obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
>> diff --git a/drivers/rng/riscv_zkr_rng.c b/drivers/rng/riscv_zkr_rng.c
>> new file mode 100644
>> index 0000000000..f48ae35410
>> --- /dev/null
>> +++ b/drivers/rng/riscv_zkr_rng.c
>> @@ -0,0 +1,102 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * The RISC-V Zkr extension provides CSR seed which provides access to a
>> + * random number generator.
>> + */
>> +
>> +#define LOG_CATEGORY UCLASS_RNG
>> +
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <rng.h>
>> +
>> +#define DRIVER_NAME "riscv_zkr"
>> +
>> +enum opst {
>> +	/** @BIST: built in self test running */
>> +	BIST = 0b00,
>> +	/** @WAIT: sufficient amount of entropy is not yet available */
>> +	WAIT = 0b01,
>> +	/** @ES16: 16bits of entropy available */
>> +	ES16 = 0b10,
>> +	/** @DEAD: unrecoverable self-test error */
>> +	DEAD = 0b11,
>> +};
>> +
>> +static unsigned long read_seed(void)
>> +{
>> +	unsigned long ret;
>> +
>> +	__asm__ __volatile__("csrrw %0, seed, x0" : "=r" (ret) : :
>> "memory");
>> +
>> +	return ret;
>> +}
>> +
>> +static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
>> +{
>> +	u8 *ptr = data;
>> +
>> +	while (len) {
>> +		u32 val;
>> +
>> +		val = read_seed();
>> +
>> +		switch (val >> 30) {
>> +		case BIST:
>> +			continue;
>> +		case WAIT:
>> +			continue;
>> +		case ES16:
>> +			*ptr++ = val & 0xff;
>> +			if (--len) {
>> +				*ptr++ = val >> 8;
>> +				--len;
>> +			}
>> +			break;
>> +		case DEAD:
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * riscv_zkr_probe() - check if the seed register is available
>> + *
>> + * If the SBI software has not set mseccfg.sseed=1 or the Zkr
>> + * extension is not available this probe function will result
>> + * in an exception. Currently we cannot recover from this.
>> + *
>> + * @dev:	RNG device
>> + * Return:	0 if successfully probed
>> + */
>> +static int riscv_zkr_probe(struct udevice *dev)
>> +{
>> +	u32 val;
>> +
>> +	do {
>> +		val = read_seed();
>> +		val >>= 30;
>> +	} while (val == BIST || val == WAIT);
>> +
>> +	if (val == DEAD)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dm_rng_ops riscv_zkr_ops = {
>> +	.read = riscv_zkr_read,
>> +};
>> +
>> +U_BOOT_DRIVER(riscv_zkr) = {
>> +	.name = DRIVER_NAME,
>> +	.id = UCLASS_RNG,
>> +	.ops = &riscv_zkr_ops,
>> +	.probe = riscv_zkr_probe,
>> +};
>> +
>> +U_BOOT_DRVINFO(cpu_riscv_zkr) = {
>> +	.name = DRIVER_NAME,
>> +};
>> --
>> 2.40.1
> 
> 

