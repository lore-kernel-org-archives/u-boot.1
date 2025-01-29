Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E6C0218F
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7DB80646;
	Wed, 29 Jan 2025 18:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bR0mFzt4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uu6p5pnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1508D8083C; Wed, 29 Jan 2025 18:38:45 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B7C805DA
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YjqBp31qMz9shs;
 Wed, 29 Jan 2025 18:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738172322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eM+nY4n9QzHpUaQmWKeHR0dJY/XtkViARaupOTuMErM=;
 b=bR0mFzt4kjlEGZgAD8f9W7uF8RHBS/Kv5TZaZGpHfyrCf9hpJ/lrzTf4PX8SsPJD06CRx9
 P1gH2hka9o9yjOsucNRG5N0f8sKhk10pk2wfMZIgjMkmd77xzsIikanow52yz4TWylxL4E
 bF+6wfGtTUm/iagTVVsTvY+8cXquFSyIzd2qJUOTeDUn+aGuGl/E97swssTDnLGeVhsc4C
 SXK3IToowJ4gfbEoAW5ZqTieGWKhlcozCh16vITk/SNUUtMPTKpyh2dJgkkB3YlX4Nj/fY
 wH3DxxTXhVjEzyNZZEvor6WIcu8ybvHaD6R41P9glHtxa+CJ86h9Fu5e5tFYog==
Message-ID: <3523e011-b0f1-43bb-bc39-baa8fd2e51d7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738172320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eM+nY4n9QzHpUaQmWKeHR0dJY/XtkViARaupOTuMErM=;
 b=Uu6p5pnvQQybTQEEYKGzBRt6+Fa4YFVdoRmdhnOINzGaM5EoUoTsSxrooOzuuER7/4PAtK
 U+3iaSo5dCsP9yDqBZGrA2GrpXrCa4wl4tfXXMiUbeHuv1415bOC8pa32h9TRWLZTiCqAc
 gCP678gYzC/cgmdt/LdnREUQEQevh2u1LLCtN61JG5mUK6PfKWdS7b2wHVUCKAipAOJ3s/
 v/D+gyR6izNnWOLgL58oupwdvyzhBjehKWyMl02ls1mvjKuWUE82h6VzfgJ2ixKdROrVdA
 FWa0UMf6dyRtn9MqBz2rKanJTJ6fhlaNo1FdS8B9mGmEcHrp1JqPkrLR7Ub4Dg==
Date: Wed, 29 Jan 2025 18:38:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <4097bdb7-8c8e-42af-8538-41338d49b328@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4097bdb7-8c8e-42af-8538-41338d49b328@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y4bxp9fggges8rag1846d78c1xirccus
X-MBO-RS-ID: eb7af7fe0bfbad59b35
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

On 1/29/25 6:10 PM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 1/12/25 11:36 PM, Marek Vasut wrote:
>> Add support for starting TFA from U-Boot running in EL3 as part of
>> fitImage boot, so the user can start U-Boot in the highest privilege
>> level on the platform, bundle TFA, Linux, DT into a single fitImage
>> and boot such a bundle as a whole.
>>
>> There are two main benefits of this approach. First is the ability
>> to run U-Boot in EL3, where it has unrestricted access to the entire
>> system and can act as a useful debug tool, as it was always intended
>> to be used. Second is the ability to easily and safely update of any
>> component in the fitImage, be it TFA, Linux or DT.
>>
>> The boot process is similar to regular Linux with DT fitImage boot
>> process, except the TFA has to be bundled into the fitImage. For the
>> bundling instructions, see below. The TFA is started as a 'loadables'
>> with custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
>> handling implemented in board code, and performing the handoff and
>> boot in case the TFA was loaded.
>>
>> The loadables handler is optional and meant to set up any sort of
>> handoff structures used by the TFA BL31 or perform any other setup
>> that is needed by the blob. The custom armv8_switch_to_el2_prep()
>> has to implement the jump to TFA BL31 with return to U-Boot just
>> before booting the Linux kernel.
>>
>> Example fitImage image and configuration section:
>>
>> /dts-v1/;
>>
>> / {
>>      description = "Linux kernel with FDT blob and TFA BL31";
>>
>>      images {
>>          kernel-1 { ... };
>>          fdt-1 { ... };
>>          atf-1 {                  /* This is the TFA BL31 image */
>>              description = "TFA BL31";
>>              data = /incbin/("../build/plat/release/bl31.bin");
>>              type = "tfa-bl31";
> 
> This would need to be added to the ITS spec, c.f. https:// 
> fitspec.osfw.foundation/

Where does one do that ?

>>              arch = "arm64";
>>              os = "arm-trusted-firmware";
>>              compression = "none";
>>              load = <0x46400000>;
>>              entry = <0x46400000>;
>>          };
>>      };
>>
>>      configurations {
>>          default = "conf-1";
>>          conf-1 {
>>              description = "Boot Linux";
>>              kernel = "kernel-1";
>>              fdt = "fdt-1";
>>              loadables = "atf-1"; /* This is the TFA BL31 loadable */
> 
> We have some special stuff around TF-A (and TEE for that matter IIRC) on 
> Rockchip. The ELF is split into multiple binaries to load at different 
> addresses:

[...]

>    Loadables:    u-boot
>                  atf-2
>                  atf-3
> 
> I assume this would be supported as well and we would "just" need some 
> sort of SoC-specific implementation of what was added in patch 1 of this 
> series?

Yes, I think so.

> Is this what you're recommending? We would then identify which 
> part of the binary it is based on the hardcoded load address instead of 
> reading the load address from the ITS. Or should we think of a way of 
> identifying them directly inside the ITS with some property for example?

Maybe try and prototype this loading of TFA for Rockchip and see how 
well it fits first (if at all), and then we can decide on the 
integration later?

> Otherwise a global remark on that feature is I believe it may increase 
> exposure to exploits. This means U-Boot will happily run anything 
> provided in EL3. E.g. imagine I provide a script in the ITS which U-Boot 
> loads and executes before loading the kernel, fdt and loadables. Let's 
> imagine this is sideloading (we even have some wget support now in U- 
> Boot so not too far fetched) some app to keep running in EL3 after the 
> kernel has booted. Or modify registers only accessible from EL3. Now you 
> better be even more careful about what you're booting from your 
> linux.itb. Is this a correct interpretation of the situation?
You have freedom to do whatever you want with no restrictions, for 
example shoot yourself in the leg by not authenticating random scripts 
up front and running whatever unknown stuff, sure. That is not a bad thing.

Running U-Boot in EL2 on top of non-free blobs is not any better, rather 
the opposite I think.
