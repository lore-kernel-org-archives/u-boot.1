Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ABCCCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 09:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B0983B22;
	Thu,  6 Nov 2025 10:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rfXVTx6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B4383B47; Thu,  6 Nov 2025 10:11:31 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36986835B3
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 10:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 62681405B3;
 Thu,  6 Nov 2025 09:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AEBC116C6;
 Thu,  6 Nov 2025 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762420287;
 bh=E981YNv8dCNamTnkTq4gzQzlAcuSkdYTv5z+QsasJMo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rfXVTx6Zm68RxIglNvlYTzBPmW5O2K6DSTQptEGkzNRuTupMJ1xryz5HtxMuuHRkb
 BE3NuqvN7qAj1doLf/FyxmdxHP4Pzp+kP4p+aaVllNxmJselObx7x6+Hn2MaHPvZgo
 QWhq2vI/i72+E+eXJ8L6x3wbLYMGtMqnlMlWwaRG18RLB7bSN/8s1LU7yyEGddgVnP
 lhr0o23pMTngFNYC4Y0IVkKcBmPERm2GLb+xQdpKIIdi9rskoKot+6jbmFu3DdAWC5
 NWqdm1/FGWn/Emobi294FJxuS0PCzRn51MSG6b13L0Qo8VZAK9/UrSj+Dn5y1MzXjd
 3zfGt11lQ3ozA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Hrushikesh Salunke <h-salunke@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, trini@konsulko.com, lukma@denx.de,
 peng.fan@nxp.com, marek.vasut+renesas@mailbox.org, anshuld@ti.com,
 andre.przywara@arm.com, xypron.glpk@gmx.de, ye.li@nxp.com,
 sjg@chromium.org, dario.binacchi@amarulasolutions.com, a-dutta@ti.com,
 dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH v4] spl: Add support for Device Firmware Upgrade (DFU)
 over PCIe
In-Reply-To: <ded6f86b-4003-4832-8d49-4a7285dddbb4@ti.com>
References: <20251023080922.3527052-1-h-salunke@ti.com>
 <87tszf5dj0.fsf@kernel.org> <ded6f86b-4003-4832-8d49-4a7285dddbb4@ti.com>
Date: Thu, 06 Nov 2025 10:11:24 +0100
Message-ID: <87h5v7r0eb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Hrushikesh,

On Mon, Nov 03, 2025 at 11:10, Hrushikesh Salunke <h-salunke@ti.com> wrote:

> On 31/10/25 20:22, Mattijs Korpershoek wrote:
>> Hi Hrushikesh,
>> 
>> Thank you for the patch.
>> 
>> v4 is in good shape already. I have a couple of small remarks below.
>> Please have a look.
>> 
>> On Thu, Oct 23, 2025 at 13:39, Hrushikesh Salunke <h-salunke@ti.com> wrote:
>> 
>>> Introduces support for Device Firmware Upgrade (DFU) over PCIe in
>>> U-Boot. Traditionally, the DFU protocol is used over USB, where a
>
> [...]
>
>>>   
>>> +#ifdef CONFIG_SPL_PCI_DFU
>>> +	if (spl_boot_device() == BOOT_DEVICE_PCIE)
>>> +		return dfu_over_pcie();
>>> +#endif
>>> +
>>>   	/* set default environment */
>>>   	env_set_default(NULL, 0);
>>>   	str_env = env_get(dfu_alt_info);
>>> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
>>> index 71b7a8374bb..0c501cf02f2 100644
>>> --- a/common/spl/spl_ram.c
>>> +++ b/common/spl/spl_ram.c
>>> @@ -27,6 +27,11 @@ static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>>>   		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>>>   				      CONFIG_SPL_LOAD_FIT_ADDRESS);
>>> +
>>> +#ifdef	CONFIG_SPL_PCI_DFU
>>> +		if (spl_boot_device() == BOOT_DEVICE_PCIE)
>>> +			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
>>> +#endif
>> 
>> Can't we rewrite this using IF_ENABLED_INT() similarly to what has been
>> done for CONFIG_SPL_LOAD_FIT_ADDRESS ?
>> 
>> This should allow us to get rid of the #ifdef CONFIG_SPL_PCI_DFU part.
>> 
>>>   	}
>>>   	addr += sector;
>>>   	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
>>> @@ -47,6 +52,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>>>   		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>>>   				      CONFIG_SPL_LOAD_FIT_ADDRESS);
>>> +
>>> +#ifdef CONFIG_SPL_PCI_DFU
>>> +		if (spl_boot_device() == BOOT_DEVICE_PCIE)
>>> +			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
>>> +#endif
>> 
>> Same here
>> 
>>>   	}
>>>   
>>>   	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
>>> @@ -64,6 +74,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>>>   		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
>>>   #endif
>>>   
>>> +#if CONFIG_IS_ENABLED(PCI_DFU)
>>> +	if (bootdev->boot_device == BOOT_DEVICE_PCIE)
>>> +		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
>>> +#endif
>>> +
>> 
>> Same here. Please rewrite using if (IS_ENABLED(CONFIG_SPL_PCI_DFU)).
>> This way we are consistent with the rest of the file.
>> 
>
>
> Thank you for the feedback. However, using IS_ENABLED() instead of
> #ifdef in these locations causes compilation errors on platforms where
> BOOT_DEVICE_PCIE is not defined. The BOOT_DEVICE_PCIE macro is only
> defined in platform-specific headers, and is not available universally
> across all architectures. With IS_ENABLED(CONFIG_SPL_PCI_DFU), the code
> inside the conditional is still visible to the compiler even when the
> config is disabled. This means the compiler will try to evaluate
> BOOT_DEVICE_PCIE on platforms where it doesn't exist, resulting in a
> compilation error like:
>
> error: 'BOOT_DEVICE_PCIE' undeclared

I see. Sorry I missed that.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

I'll pick this up shortly to try to make it for v2026.01

>
> The #ifdef CONFIG_SPL_PCI_DFU approach ensures that the code referencing
> BOOT_DEVICE_PCIE is completely removed during preprocessing on platforms
> that don't support PCIe DFU, preventing the compilation error. This is
> similar to how other boot device checks are handled in U-Boot when the
> boot device macro may not be universally defined across all platforms.
>
> Regards,
> Hrushikesh.
>
>
>
>>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
>>>   	    image_get_magic(header) == FDT_MAGIC) {
>>>   		struct spl_load_info load;
>>> @@ -102,3 +117,6 @@ SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_ram_load_image);
>>>   #if CONFIG_IS_ENABLED(DFU)
>>>   SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
>>>   #endif
>>> +#if CONFIG_IS_ENABLED(PCI_DFU)
>>> +SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
>>> +#endif
>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>> index 7560008a842..77fc66eb8ba 100644
>>> --- a/drivers/Makefile
>>> +++ b/drivers/Makefile
>>> @@ -26,6 +26,7 @@ obj-$(CONFIG_MULTIPLEXER) += mux/
>>>   obj-$(CONFIG_$(PHASE_)ETH) += net/
>>>   obj-$(CONFIG_$(PHASE_)PCH) += pch/
>>>   obj-$(CONFIG_$(PHASE_)PCI) += pci/
>>> +obj-$(CONFIG_$(PHASE_)PCI_ENDPOINT) += pci_endpoint/
>>>   obj-$(CONFIG_$(PHASE_)PHY) += phy/
>>>   obj-$(CONFIG_$(PHASE_)PINCTRL) += pinctrl/
>>>   obj-$(CONFIG_$(PHASE_)POWER) += power/
>>> -- 
>>> 2.34.1
