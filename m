Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D324AEA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE507839D5;
	Thu,  9 Apr 2026 15:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="FinHxjzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D3183F98; Wed,  8 Apr 2026 19:07:01 +0200 (CEST)
Received: from mxd-2-a16.seznam.cz (mxd-2-a16.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3568D838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 19:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-sbn6w
 (smtpc-mxd-7644845457-sbn6w [2a02:598:64:8a00::1000:a16])
 id 404ebfd71b40ebbe41e77389; Wed, 08 Apr 2026 19:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775667965; bh=nF0iset6+Uj61V14fk16xypXNOJ8M4KtpyaRHWY4SMI=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=FinHxjzz3fMtFvKsOYdt6xfasYHcv29uQvwVl0LeKrSwwirr8UwYoWC3kd5AWsTfq
 0yLanhBBCBsGQW3PTyJxr9zqbty8MUTfFq4EF9IdHH+itoglyUW4n1rEMKSknmFNbu
 KX8Q3KTqDgxzQmYyUw1yZy4t3Z73xNJVRonuACwFHhTGsf9PAjtDQ7ml7+0LlnqIoQ
 nCWL4mdO353TiKuhrQmA0uuM0A0HRLvWW1RYaCfzB8/MKGjaz3/aGNhOG8V42j+cPw
 9fvUGN2mEu4C4zepzG6UzysJbtHpQkM/mvPhVXm7Jgq0pEfCTwHbWliYoJqAwiCJtd
 CzWOZ56bN2dIg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-789d8dfb5c-q6vgm (szn-email-smtpd/2.0.71) with ESMTPA
 id 51e3ce82-5fd3-4309-a9c2-81bb09aa2737;
 Wed, 08 Apr 2026 19:05:56 +0200
Message-ID: <b07ef09d-28f5-408d-b9c1-7524442f0f33@seznam.cz>
Date: Wed, 8 Apr 2026 19:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mach-snapdragon: support building SPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
 <20260406142737.GN41863@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260406142737.GN41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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



On 4/6/26 16:27, Tom Rini wrote:
> On Sat, Apr 04, 2026 at 01:18:19AM +0200, michael.srba@seznam.cz wrote:
>
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Initially sdm845 support is added, and only usb boot
>> is supported for the next stage.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> [snip]
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index 976c0e35fce..938e6ebd8bf 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -1,6 +1,24 @@
>>   if ARCH_SNAPDRAGON
>>   
>> +# SoC specific SRAM addresses
>> +
>> +# sdm845
>> +SDM845_BOOT_IMEM_BASE := 0x14800000
>> +SDM845_BOOT_IMEM_SIZE := 0x180000
>> +# we may not be able to use the whole BOOT_IMEM depending on the whitelisted regions hardcoded in PBL
>> +# (we could technically relocate ourselves after the fact)
>> +SDM845_BOOT_IMEM_OFFSET := 0x3f000
>> +SDM845_BOOT_IMEM_USABLE_SIZE := 0xc1000
>> +# technically the below would work, except the memory from 0x14833000 to 0x1483F000 gets trashed
>> +# between the ELF getting loaded and XBL_SEC jumping to our code
>> +#SDM845_BOOT_IMEM_OFFSET := 0x16000
>> +#SDM845_BOOT_IMEM_USABLE_SIZE := 0xea000
>> +SDM845_OCIMEM_BASE := 0x14680000
>> +SDM845_OCIMEM_SIZE := 0x00040000
>> +SDM845_OCIMEM_END  := $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OCIMEM_BASE) + $(SDM845_OCIMEM_SIZE) - 1))")
> I didn't know Kconfig even allowed this. And I *really* don't like it,
> and I think it's going in the wrong direction with respect to being able
> to configure a system. If these are configurable, then they need to be
> "hex" type "config" options, and then used later on. Otherwise they
> should just be the evaluated value as "default ... if ..." later on,
> instead.
This is per-SoC hardware info. The SRAM is physically located at that
address with that size. The offset/usable size are further restrictions
imposed by the bootrom, which are relevant for placing the text section
(the bootrom will copy the ELF segment precisely where the ELF segment
says it wants to live, as long as that's in a whitelisted region).

I really don't like the idea of just hardcoding hex values with either
no explanation of where they come from, or with a comment that may or
may not reflect the reality since there's no mechanism that would enforce
that the value was actually computed according to the comment.
(also the amount and complexity of such comments would be higher since
comments can't reference nonexistent intermediate variables)

What I wanted to do here was more along the lines of:
```
config QCOM_BOOT_IMEM_BASE
     default 0x14800000 if SPL_TARGET_SDM845

config QCOM_BOOT_IMEM_SIZE
     default 0x180000 if SPL_TARGET_SDM845

config QCOM_BOOT_IMEM_OFFSET
     default 0x3f000 if SPL_TARGET_SDM845

config QCOM_BOOT_IMEM_USABLE_SIZE
     default 0xc1000 if SPL_TARGET_SDM845
```
and then
```
config SPL_STACK
     default SDM845_OCIMEM_START + SDM845_OCIMEM_SIZE

config SPL_TEXT_BASE
     default QCOM_BOOT_IMEM_BASE + QCOM_BOOT_IMEM_OFFSET

config SPL_SYS_MALLOC_F_LEN
     QCOM_BOOT_IMEM_SIZE / 2
```

The problem with the above is that Kconfig absolutely doesn't support
doing that. The only way to do arithmetics is to use the preprocessor
("macro language"), and the preprocessor obviously doesn't have access
to the values of symbols, only to preprocessor variables.

The current form is the only solution I could come up with that avoids
hardcoding hex values, and from reading kconfig docs and sources I think
it's also the only solution possible short of patching kconfig to support
arithmetics.

If you consider this more ugly than magic hex values (which afaict is
the only other option, other than patching kconfig of course),
I can obviously do that, although it does make me very sad, and I'd prefer
if we can find a solution that avoids hardcoding. What do you think?
> [snip]
>> +config QCOM_SPL
>> +	bool "Enable SPL for Snapdragon SOCs"
>> +	select SUPPORT_SPL
>> +	select ARMV8_SPL_EXCEPTION_VECTORS
>> +	select ENABLE_ARM_SOC_BOOT0_HOOK
>> +	select SPL
>> +	select SPL_DM
>> +	select SPL_DM_GPIO
>> +	select SPL_DM_PMIC
>> +	select SPL_DM_USB_GADGET
>> +	select SPL_ENV_SUPPORT
>> +	select SPL_GPIO
>> +	select SPL_HAS_BSS_LINKER_SECTION
>> +	select SPL_LIBCOMMON_SUPPORT
>> +	select SPL_LIBDISK_SUPPORT
>> +	select SPL_LIBGENERIC_SUPPORT
>> +	select SPL_MMC
>> +	select SPL_OF_REAL
>> +	select SPL_OF_CONTROL
>> +	select SPL_PINCONF
>> +	select SPL_PINCTRL
>> +	select SPL_PINCTRL_FULL
>> +	select SPL_PINCTRL_GENERIC
>> +	select SPL_PINCONF_RECURSIVE
>> +	select SPL_PINMUX
>> +	select SPL_SPRINTF
>> +	select SPL_STRTO
>> +	select SPL_USB_GADGET
> This should be in the appropriate defconfig, or a config fragment if
> re-used a lot. Or mirroring other platforms, as part of the stanza for
> TARGET_... (or ARCH_...) as needed.
>
> [snip]
>> diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
>> new file mode 100644
>> index 00000000000..817c76b659e
>> --- /dev/null
>> +++ b/doc/board/qualcomm/spl.rst
>> @@ -0,0 +1,70 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +.. sectionauthor:: Michael Srba <Michael.Srba@seznam.cz>
>> +
>> +======================================
>> +Booting U-Boot SPL on Qualcomm SoCs
>> +======================================
>> +
>> +Overview
>> +----------
> These are style errors that will trip up CI when it builds the docs.
> Please run "make htmldocs KDOC_WERROR=1" for v2, thanks.
>

