Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2D8F436B1
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 05:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6D084214;
	Sat, 18 Apr 2026 07:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="BuZbQeCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B8E8405A; Sat, 18 Apr 2026 03:02:58 +0200 (CEST)
Received: from mxd-1-a09.seznam.cz (mxd-1-a09.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775D183B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 03:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-fd5c5cd95-bfmjc
 (smtpc-mxd-fd5c5cd95-bfmjc [2a02:598:128:8a00::1000:a09])
 id 1e963f3e45986b571f3ff360; Sat, 18 Apr 2026 03:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1776474121; bh=wTKWtnk3lWwYgUfEC1Exyc41GL5E6C061ZT9VNGg1NA=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=BuZbQeCT/nSAwEezMnMsw8gR2qVYWCIoePAwOGGCAGMoR4FzZeumlRiKfmcAIREum
 LR8DGYaixZ+cmikxI+nTlM42cBqKWsAf8S0fSC0OeuSXvOQVEPIuXMcUfhOHfYsVTS
 340pGfpXfVHJ/Mlw8ldriFMynQu7wo+kbsADe2Vta4m6fNPJbKCKr0HeQyKZyXkNyN
 pSJdL+BEic7nEA5giNZPA3/SAd782Ogb/lTnH62iCm/8R5CK+vRp5NBEFmO4JZQ0A+
 pU92HGaMXfpp7OSvLU4R1AbZvRvV2ygFxvOA+Y+6SxyOTcy2TLLuNUiLrF+b6v1/Ld
 9VTSChZVqB+MA==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-7c7c659656-jspbn (szn-email-smtpd/2.0.72) with ESMTPA
 id f4815e30-c1a1-4b87-b7af-78801f37e081;
 Sat, 18 Apr 2026 03:01:24 +0200
Message-ID: <596c73ef-b0ec-4543-bd06-ac3b18029edd@seznam.cz>
Date: Sat, 18 Apr 2026 03:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] mach-snapdragon: Kconfig: changes / additions to
 support SPL
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
 <20260413171717.GA41863@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260413171717.GA41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Apr 2026 07:55:55 +0200
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

Hi,

On 4/13/26 19:17, Tom Rini wrote:
> On Sat, Apr 11, 2026 at 02:00:11AM +0200, michael.srba@seznam.cz wrote:
>
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> An SoC to target has to be selected, e.g. SPL_TARGET_SDM845.
>> This will select reasonable defaults and enable per-SoC linker
>> script (if required).
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> ---
>>   arch/arm/Kconfig                 | 31 +++++++++++++++++++++++++++-
>>   arch/arm/mach-snapdragon/Kconfig | 44 ++++++++++++++++++++++++++++++++++------
>>   2 files changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 03416c55265..8490e336516 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1138,9 +1138,38 @@ config ARCH_SNAPDRAGON
>>   	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select SYSRESET
>> -	select SYSRESET_PSCI
>> +	select SYSRESET_PSCI if !SPL
>>   	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>>   	select MMU_PGPROT
>> +	select SUPPORT_SPL
>> +	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
>> +	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
>> +	select SPL_DM if SPL
>> +	select SPL_DM_GPIO if SPL
>> +	select SPL_DM_PMIC if SPL
>> +	select SPL_DM_USB_GADGET if SPL
>> +	select SPL_ENV_SUPPORT if SPL
>> +	select SPL_GPIO if SPL
>> +	select SPL_HAS_BSS_LINKER_SECTION if SPL
>> +	select SPL_LIBCOMMON_SUPPORT if SPL
>> +	select SPL_LIBDISK_SUPPORT if SPL
>> +	select SPL_LIBGENERIC_SUPPORT if SPL
>> +	select SPL_MMC if SPL
>> +	select SPL_OF_REAL if SPL
>> +	select SPL_OF_CONTROL if SPL
>> +	select SPL_PINCONF if SPL
>> +	select SPL_PINCTRL if SPL
>> +	select SPL_PINCTRL_FULL if SPL
>> +	select SPL_PINCTRL_GENERIC if SPL
>> +	select SPL_PINCONF_RECURSIVE if SPL
>> +	select SPL_PINMUX if SPL
>> +	select SPL_SPRINTF if SPL
>> +	select SPL_STRTO if SPL
>> +	select SPL_USB_GADGET if SPL
>> +	imply DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC
>> +	imply SPL_EVENT if SPL_USB_DWC3_GENERIC
>> +	imply OF_LIVE if USB_DWC3_GENERIC
>> +	imply SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
>>   	imply OF_UPSTREAM
>>   	imply CMD_DM
>>   	imply DM_USB_GADGET
> This part looks good.
>
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index 976c0e35fce..74d687ceee2 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -11,18 +11,12 @@ config SYS_VENDOR
>>   	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
>>   	  will be used as the custom board directory.
>>   
>> -config SYS_MALLOC_LEN
>> -	default 0x10000000
>> -
>>   config SYS_MALLOC_F_LEN
>>   	default 0x2000
>>   
>>   config SPL_SYS_MALLOC_F
>>   	default y
>>   
>> -config SPL_SYS_MALLOC_F_LEN
>> -	default 0x2000
>> -
>>   config SYS_MALLOC_LEN
>>   	default 0x800000
>>   
>> @@ -45,4 +39,42 @@ config SYS_CONFIG_NAME
>>   	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>>   	  will be used for board configuration.
>>   
>> +config SPL_SHARES_INIT_SP_ADDR
>> +	default n
>> +
>> +config SPL_HAVE_INIT_STACK
>> +	default y
>> +
>> +# SPL targets
>> +
>> +config SPL_TARGET_SDM845
>> +	bool "Set reasonable default values for running SPL in SRAM on sdm845 devices"
> This namespace is confusing and so shouldn't be used. Does SDM845 get
> used without SPL? We should probably follow the convention of adding a
> new defconfig of <whatever board>_spl_defconfig, that enables the
> options as needed.
The rationale for this naming was that outside SPL, we don't currently
discriminate between SoCs at compile time (there is some discrimination
between legacy board support the and unified "board" which covers all
non-legacy boards no matter the SoC, but for non-legacy boards there
is just a single build of U-Boot proper, possibly with a board dtb
appended if used as the primary bootloader). I suppose the SPL_ prefix
may be confusing and isn't strictly necessary, and we may need a similar
target option for msm8916 in the future which wouldn't be used in SPL
but in u-boot proper, so it makes sense to get rid of the prefix.

The reason we need this config option at all (even if we move all
the Kconfig defaults that use it into the defconfig) is that the
boot0.h is shared among all of mach-snapdragon, and we need a way
to select which SoC-specific boot0.h we should include.
Now, it does look like SYS_SOC is intended for stuff like this,
however changing SYS_SOC from snapdragon seems to completely break
the unified board support which isn't really worth it.

Admittedly, it does seem that I somehow completely forgot to mention that
use of the config option in both the commit message and the Kconfig,
but it is effectively the only use it has left after moving everything
into the defconfig.

So, should I include an SoC selection menu similar to the board selection
menus in e.g mach-exynos, which would now solely be used by the ifdef
in boot0.h? Something like
```
choice
     prompt "Qualcomm SoC select"
     default TARGET_NONE if !SPL
     help
       While U-Boot on Qualcomm platforms doesn't generally need compile-time
       adjustment based on the target SoC, there are a few exceptions to this.
       Currently this concerns boot0.h discrimination.

config TARGET_NONE
     bool "Generic build"
     help
       Select this if you're not building SPL. U-Boot proper builds are currently
       generic across all SoCs.

config TARGET_SDM845
     bool "SPL targeting the sdm845 SoC"
     help
       Select this if you are bulding u-boot SPL for sdm845.
       Currently this gates sdm845-specific boot0.h (only used in SPL).

endchoice
```

... or do you have something else in mind? I'm not entirely sure if you're
suggesting to get rid of TARGET_SDM845 completely (which I really don't see
as possible at least without a lot of unnecessary pain) or just of it's
use for the defaults.

Regards,
Michael
>

