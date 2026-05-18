Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D9CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 20:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE4383FEE;
	Mon, 18 May 2026 22:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="bjDD52t7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7741484119; Mon, 18 May 2026 22:26:17 +0200 (CEST)
Received: from mxd-3-706.seznam.cz (mxd-3-706.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2650D80433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 22:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-85fb448c55-l247v
 (smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
 id 699017a1329e43c86839dbff; Mon, 18 May 2026 22:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1779135916; bh=gzGmYddByQtbGuToYgRINfUr6k+WtVKuK5PRx6IoXYk=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=bjDD52t7JfFzZx+/L4G29dj/LD8gbnbiRc9AQfHzv6Kie5ksWvlraAN5QrBNlF6VC
 L90bbzgnHT5YY8V1qRi6ytGxlHJc5CnWL5th7PclBkLcvJFYHAo3wz0rFDvCpbr45X
 8SuefsDt1jFJAxLGX/UfO4autgUwY1bleqOAwfeYCYKftca3n9ZXEH0Gax69wYbXY2
 r9EDfWgJNE1JFFaUqq7wS7tQWqk4d9Xcn5nVQcaSxRaWiS6Cm80urxWWkhzWeOr3mY
 e4ST+aXuLY6YwBbfYHhLk9vu8zo17rArvqxYjUa32oHjbzQDxY+nNSo/+j7+mLJBg0
 RwrB2oNeptjaw==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-745c4d9bbb-7brj6 (szn-email-smtpd/2.0.73) with ESMTPA
 id fb6adfc2-863b-4365-9185-c3236e82fd09;
 Mon, 18 May 2026 22:25:07 +0200
Message-ID: <48832d44-dc85-4b23-980c-87ef686669e2@seznam.cz>
Date: Mon, 18 May 2026 22:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
 <1f639a99-7d32-4f3b-bd0b-8936cb56ea0d@linaro.org>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <1f639a99-7d32-4f3b-bd0b-8936cb56ea0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 May 2026 22:46:17 +0200
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

On 5/18/26 10:40, Casey Connolly wrote:
> Hi Michael,
>
> On 16/05/2026 20:19, michael.srba@seznam.cz wrote:
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
>> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
>>
>> Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to fix up
>> upstream dt to make usb work.
>>
>> Mirror u-boot proper selections like GPIO and pinctrl to ensure consistent
>> behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
>> reasons.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>   arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
>>   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>>   2 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 850768282ce..255d2035cdc 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
>>   	bool "Qualcomm Snapdragon SoCs"
>>   	select ARM64
>>   	select DM
>> +	select DM_EVENT if USB_DWC3_GENERIC
> Is there any reason not to make this uncoditional?
Well, my understanding is that it's only relevant if something registers
to receive an event. Maybe some stuff just has a slower path but would
benefit from this? I don't know, all I know is that the fixup has a hard
dependency on it.
>
>>   	select DM_GPIO
>>   	select DM_SERIAL
>>   	select DM_RESET
>> @@ -1149,9 +1150,39 @@ config ARCH_SNAPDRAGON
>>   	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select SYSRESET
>> -	select SYSRESET_PSCI
>> +	select SYSRESET_PSCI if !SPL
>>   	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>>   	select MMU_PGPROT
>> +	select SUPPORT_SPL
>> +
>> +	select OF_LIVE if USB_DWC3_GENERIC
> Same here, OF_LIVE carries performance benefits too besides the fixup stuff.
I wasn't aware of that, if that's the case there's probably no reason to ever
not enable it.
>> +	select SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
>> +	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
>> +	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
>> +	select SPL_DM if SPL
>> +	select SPL_DM_GPIO if SPL
>> +	select SPL_DM_PMIC if SPL
>> +	select SPL_DM_USB_GADGET if SPL
>> +	select SPL_ENV_SUPPORT if SPL
>> +	select SPL_EVENT if SPL_USB_DWC3_GENERIC
>> +	select SPL_GPIO if SPL
>> +	select SPL_HAS_BSS_LINKER_SECTION if SPL
>> +	select SPL_LIBCOMMON_SUPPORT if SPL
>> +	select SPL_LIBDISK_SUPPORT if SPL
>> +	select SPL_LIBGENERIC_SUPPORT if SPL
>> +	select SPL_OF_CONTROL if SPL
>> +	select SPL_PINCONF if SPL
>> +	select SPL_PINCTRL if SPL
>> +	select SPL_PINCTRL_FULL if SPL
>> +	select SPL_PINCTRL_GENERIC if SPL
>> +	select SPL_PINCONF_RECURSIVE if SPL
>> +	select SPL_PINMUX if SPL
>> +	select SPL_SPMI if SPL
>> +	select SPL_SPMI_MSM if SPL
>> +	select SPL_SPRINTF if SPL
>> +	select SPL_STRTO if SPL
>> +	select SPL_USB_GADGET if SPL
>> +	imply SPL_MMC if SPL
>>   	imply OF_UPSTREAM
>>   	imply CMD_DM
>>   	imply DM_USB_GADGET
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index c195d478512..a2228e217af 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -14,6 +14,9 @@ config SYS_VENDOR
>>   config SYS_MALLOC_F_LEN
>>   	default 0x2000
>>   
>> +config SPL_SYS_MALLOC_F
>> +	default y
>> +
>>   config SPL_SYS_MALLOC_F_LEN
>>   	default 0x2000
>>   
>> @@ -39,6 +42,13 @@ config SYS_CONFIG_NAME
>>   	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>>   	  will be used for board configuration.
>>   
>> +config SPL_SHARES_INIT_SP_ADDR
>> +	# override the default from common/spl/Kconfig
>> +	default n
>> +
>> +config SPL_HAVE_INIT_STACK
>> +	default y
>> +
>>   choice
>>   	prompt "Qualcomm boot0.h workaround"
>>   	optional
>>
