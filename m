Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8519ACD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 16:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A7A84979;
	Wed, 10 Jun 2026 18:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r36+D5Xa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC748495B; Wed, 10 Jun 2026 18:44:28 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475338494B
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 18:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gbBSk408Nz9v0n;
 Wed, 10 Jun 2026 18:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781109862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djsr7GQxgsUYHdaH59dnFLSTsZc3FJqjS/E1f0jGGw0=;
 b=r36+D5XafRIIwNi2UF6qb60psuT+q5u1/wINHhLdiyPGLmzZ/2OiJ19UkA7gacRgqgwZBD
 yso8d1mZvkvpHnffb/JU2s6uMgV7IsKH0K/E90I9c4RivXHHoe1Y35gTN3d9VNnX8ma8aT
 wto+4BgpU3f7LZoxc52lnubO+/NjYv510bNqhOKgeeRYMoaSaGofCVhdCYXhCAZaEFMKez
 aEmhH+pCL7DGHP4uZBk8aD/U4ptfaGGcwQPdY0OHtpG9UdS+7mdQxdizUnP6fBHflffdYX
 13yRGPwGJecBWLTb/Kz0Y1fTB3vso9aRT1RAHWIVouRoEsvzyMby7nqX6SKJEA==
Message-ID: <4a6af516-2597-473f-bb17-94781278256c@mailbox.org>
Date: Wed, 10 Jun 2026 18:44:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] spl: atf: support Linux as BL33 with ATF
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-1-2b20c5e83615@flipper.net>
 <7d68bdee-78de-48f2-9813-4fd804a419a9@mailbox.org>
 <CAKTNdwGpo9N6BoW_D4pzdS52LHpK2q9FHBRvr3EdpY5TJQUykA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAKTNdwGpo9N6BoW_D4pzdS52LHpK2q9FHBRvr3EdpY5TJQUykA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: adf630ab9d2ab3cc89e
X-MBO-RS-META: bf9isfzhmpjbr5ycciwe4tujrzggkgoe
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

On 6/10/26 9:51 AM, Alexey Charkov wrote:
> On Wed, Jun 10, 2026 at 8:00 AM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 6/9/26 6:52 PM, Alexey Charkov wrote:
>>> Modern SoCs such as Rockchip RK3576 need ATF to be running to provide
>>> firmware services to the OS.
>>>
>>> Enable the ATF boot flow to allow using Linux as BL33 (including its
>>> calling convention) to facilitate Falcon mode boot on such SoCs.
>>
>> TFA
> 
> Ok, thanks. The whole file is saying atf though :)

I suspect they renamed it because of naming collision with 
https://en.wikipedia.org/wiki/Bureau_of_Alcohol,_Tobacco,_Firearms_and_Explosives 
.

> I have to admit I'm still confused with all the naming. My latest
> understanding has been that ATF is the whole firmware including both
> non-secure BL31 and secure BL32, with TF-A being the upstream
> opensource implementation for the BL31 part

TF-A ... Trusted Firmware for the A-cores .

> , and OP-TEE being the
> upstream opensource implementation for the BL32 part (or is this part
> TEE-OS?).

OPTEE-OS is implementation of TEE (trusted execution env.), one of many.

> Anyway, happy to rename.
> 
>>> +/* BL33 defaults to U-Boot unless Falcon mode selects Linux. */
>>> +static int spl_atf_bl33_os;
>>> +
>>
>> Can we avoid this global static variable ?
> 
> Yep, let me try to refactor to drop it.
> 
>>>    /* Holds all the structures we need for bl31 parameter passing */
>>>    struct bl2_to_bl31_params_mem {
>>>        struct bl31_params bl31_params;
>>> @@ -87,8 +90,11 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>>>        SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
>>>                       ATF_EP_NON_SECURE);
>>>
>>> -     /* BL33 expects to receive the primary CPU MPID (through x0) */
>>
>> That seems a bit inconsistent, and not quite right. Do you know where
>> U-Boot expects primary CPU ID in x0 exactly ? Which part of U-Boot code
>> depends on it ?
> 
> That was pre-existing logic and comment, so I left it in place to
> avoid unintentionally breaking someone's setup. Happy to try and drop
> it, but I only have an assortment of Rockchip RK3576 based boards to
> test it on, which won't be very representative.

Please dig through the code a bit, see if this MPIDR passing is even 
needed, it might not be. Iit also smells a bit bogus, since MPIDR uses 
full 32bits of the register to encode core position, so why is there the 
0xffff is not clear to me.

>>> -     bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
>>> +     /* Linux-at-BL33 expects DTB in x0, U-Boot expects primary CPU MPID in x0. */
>>> +     if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_atf_bl33_os == IH_OS_LINUX)
>>> +             bl33_ep_info->args.arg0 = fdt_addr;
>>> +     else
>>> +             bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
>>
>> [...]
>>
>>> @@ -269,15 +279,22 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
>>>                bl32_entry = spl_fit_images_get_entry(blob, node);
>>>
>>>        /*
>>> -      * Find the U-Boot binary (in /fit-images) load addreess or
>>> -      * entry point (if different) and pass it as the BL3-3 entry
>>> -      * point.
>>> -      * This will need to be extended to support Falcon mode.
>>> +      * Find BL33 entry point. In Falcon mode, prefer Linux when requested.
>>> +      * Fall back to U-Boot if Linux cannot be resolved.
>> That does not seem correct, if Linux cannot be resolved, then the system
>> should stop booting, falling back into a bootloader could be security
>> risk. There is a "recovery" boot weak symbol function, which can be used
>> to start fallback bootloader, but that has to be deliberately
>> implemented and triggered by the user e.g. by holding a button down.
> 
> I thought from reading existing documentation [1] that "plain" Falcon
> mode is supposed to fall back to U-boot, while "secure" Falcon mode
> should fail. Which prompts me to at least add a fail path for the case
> when SPL_OS_BOOT_SECURE is enabled.
Ahh, now I see it, thank you for the clarification.
