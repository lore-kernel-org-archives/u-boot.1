Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9456CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200938394E;
	Mon, 11 May 2026 16:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="l/56AA8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0758394E; Mon, 11 May 2026 15:29:31 +0200 (CEST)
Received: from mxd-3-705.seznam.cz (mxd-3-705.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C6D680398
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7994f94c68-kzzv6
 (smtpc-mxd-7994f94c68-kzzv6 [2a02:598:96:8a00::1200:705])
 id 602b064f3b2552266182ca11; Mon, 11 May 2026 15:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778506113; bh=GE5nW3oCY9X05G+VBqXmfg0L1+W4uRgb2Uv8TNCrHVs=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=l/56AA8mMJ/MhJl3XJrPpvx+fKu5KuAjgfhCljIN+OVzTHIrkH4DVBmrI87AA+m14
 W/dNgijVIc4u9BZxLHdhDWDVbvLE9EpR1xMQkrxtjffYO3djrEemu0xF+u6FKT2eye
 lFpLnS9Mmh70eoqgiqqz8iWvW7y32bYnczadZPCVvLsyr2U1kIoRve8oEfwFITlGYw
 PenYcxA36L3/Hjer6B1ozZJzjikl1Lrp5lGITcsvCuMwrsaE9ZggA3naDRNF1oki4y
 66qXtGh8H0dtjwFndwKelpgvlII7uvAJ/OmkMR9PDCZFs6QI1XtC6s5XdYNfyG1A3Z
 PbqsVZtign33Q==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-856d78d9df-57vh9 (szn-email-smtpd/2.0.72) with ESMTPA
 id 22e8e09a-3c22-4d5e-80c9-1e87e9fceb35;
 Mon, 11 May 2026 15:28:31 +0200
Message-ID: <4deeaed1-5744-42c1-a4d3-bdeaa13d012c@seznam.cz>
Date: Mon, 11 May 2026 15:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] mach-snapdragon: Kconfig: changes / additions to
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
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-7-7d0e22aaaa8f@seznam.cz>
 <fc28d41d-957e-41b2-95ec-85b328dd611e@linaro.org>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <fc28d41d-957e-41b2-95ec-85b328dd611e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 May 2026 16:21:38 +0200
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

On 5/11/26 15:05, Casey Connolly wrote:
> Hi Michael,
>
> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
>> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
> I'm not sure if this was mentioned in a previous revision, but would it
> be possible to introduce a SNAPDRAGON_SPL kconfig (mayyybe in the
> mach-snapdragon kconfig?) to contain all the "if SPL" options and just
> simplify the list here? It just feels wrong to have half the options in
> the list be gated like this.
That is more or less what I did originally, but it was strongly opposed.
>
> It seems quite likely that we will end up with a few different SPL
> variants for snapdragon:
>
> 1. Your implementation for older SoCs doing many things from scratch
> 2. Qualcomms version for IoT more tightly integrated with TF-A
Well, that should mostly boil down to whether u-boot provides PSCI
or loads tf-a? Once someone REs all the stuff that qcom gets away with
hiding in blobs.
> 3. Another version I've seen where SPL is just used to chainload a full
> U-Boot and provide an extra level of redundancy
>
> These will all have slightly different requirements and code paths so
> being able to express this via kconfig seems like a good way to try and
> keep things manageable.
>
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
>> index f624675eadf..8e818071df6 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1135,6 +1135,7 @@ config ARCH_SNAPDRAGON
>>   	bool "Qualcomm Snapdragon SoCs"
>>   	select ARM64
>>   	select DM
>> +	select DM_EVENT if USB_DWC3_GENERIC
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

