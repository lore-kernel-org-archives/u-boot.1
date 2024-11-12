Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B222D41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4C588E78;
	Tue, 12 Nov 2024 03:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F8A89383; Tue, 12 Nov 2024 02:53:46 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E127C8904A
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: bizesmtpsz5t1731376337tu9slxe
X-QQ-Originating-IP: rxajmnZs7layJczrZcLYSszcR1QY7old+BVRD3RLHAg=
Received: from [192.168.125.182] ( [183.27.99.69])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 Nov 2024 09:52:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 721915833505858517
Message-ID: <A6BDA210C0B1EBD7+29e1a846-b4e0-4bba-adee-8bbbc6db7841@linux.starfivetech.com>
Date: Tue, 12 Nov 2024 09:52:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] dts: starfive: Switch to using upstream DT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-2-hal.feng@starfivetech.com>
 <75aab841-5e11-46b1-b747-59059a7fc4cd@gmx.de>
Content-Language: en-US
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <75aab841-5e11-46b1-b747-59059a7fc4cd@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NpWR2/YALQX3CR9tjfDPnf9kichJhU0SkTBmwJ3C5ynAJzWFwu9BH8VV
 EueCQEdhKdzgdmjYA4KEFTZ0UluB923cFBqMLI0DOhfPGKSEjNFUukXkAnx3vOGZPlsGHBl
 ye3qXySLmpE/evkbZ0n8JSyEsqjEZOwOviIqFuy3vTkHyL3q4EI61RdcmEWgBs17PH/ei1+
 zUm6JqcELO62Ft3p6KPXLfTn/+AERstXN7hgQJp4l9TdRWIr1JrqQqmpm7BE3fulKtiUnvz
 39UZOZYSshyF/IepoaYD/lRzLB2IIFt6MmaI2YBn47sT+/9VyRLO4vZfO7uD/aqT55ORo2z
 Ue1ud6d/UEE8MJQIrS0OENLYQuI8fEC3DBIDsaFa7VpqagAywEdxtL9ILoUBnzxjjaBWYL4
 zYPCKQ9Wd4XPvZ1MhQ0ZADW/+OqslzKqWsFoBR/20hBzDbZazVl/SiAw+FDtrFs0X44ZHmM
 BHJJM205DIbFYah/2xM/pTRMsuTrPBFt+QJIZHwI6qL62sLlKmKcnlk067hmGT8g/0MyKWc
 x2Idl5rDPtKgjjMX4ZljgVyGuKxj9lYIRu6h4lFmbHPGgoRgTBCKqi/2kQU49IJggnZEQdl
 2vXtlvz3IJZR2QRU77UlUNu130xVohjei2dSZlG8PtuGwQRwEgsVVw/5lH/anodIHmM3QMF
 aAVuXs8ZJ2958LiYViwXbB/cpaApQWTvDVeczDMXY0aHbtT4KmTuFVs77RI5gAH5NZw0/3B
 Ie1STcT/rCSbSq4u1z4kxzq9j2Yhcr+wiWBb2Sh8BPdIA+y8UsOoT1N/+APfbJUzM18Kov/
 bn0fblE897g2uREx+WzBeQipCqqeHMMbGo8AnkakPodX/sR55hx/6fMC7m6BtWxUmxFz8Ez
 zse3yEz1bXlpFvknbPLUcT+jvsMNwpyHeufB+Bn9OItJvCMGXBG1yDwAe4v3vfx0sDhrY4i
 2pmNzS66YIuiX/gyq6PP56IMR
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:32 +0100
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

On 11/11/2024 5:56 PM, Heinrich Schuchardt wrote:
> On 11/11/24 03:07, Hal Feng wrote:
>> Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
>> the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
>> to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set
>> the v1.3b device tree as the default device tree.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>   arch/riscv/cpu/jh7110/Kconfig                                   | 1 +
>>   ...boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} | 0
>>   configs/starfive_visionfive2_defconfig                          | 2 +-
>>   3 files changed, 2 insertions(+), 1 deletion(-)
>>   rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)
>>
>> diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
>> index e5549a01b8..9904a60ddd 100644
>> --- a/arch/riscv/cpu/jh7110/Kconfig
>> +++ b/arch/riscv/cpu/jh7110/Kconfig
>> @@ -19,6 +19,7 @@ config STARFIVE_JH7110
>>       imply MMC
>>       imply MMC_BROKEN_CD
>>       imply MMC_SPI
>> +    imply OF_UPSTREAM
> 
> IIRC the imply statement should be sorted in the sequence of appearance
> in .config to avoid dependency issues. In a follow up patch to this
> series you might want to sort the whole list of imply statements
> accordingly.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

OK, will add a new patch to sort this list in the next version.
Thanks for your review.

Best regards,
Hal

> 
>>       imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
>>       imply SIFIVE_CACHE
>>       imply SIFIVE_CCACHE
>> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>> similarity index 100%
>> rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>> rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
>> index 11e1332f87..40f553816e 100644
>> --- a/configs/starfive_visionfive2_defconfig
>> +++ b/configs/starfive_visionfive2_defconfig
>> @@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=100000000
>>   CONFIG_ENV_SIZE=0x10000
>>   CONFIG_ENV_OFFSET=0xf0000
>>   CONFIG_SPL_DM_SPI=y
>> -CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
>> +CONFIG_DEFAULT_DEVICE_TREE="starfive/jh7110-starfive-visionfive-2-v1.3b"
>>   CONFIG_SPL_TEXT_BASE=0x8000000
>>   CONFIG_OF_LIBFDT_OVERLAY=y
>>   CONFIG_DM_RESET=y
> 
> 


