Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ADBC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 20:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A7F8033D;
	Thu, 16 Jan 2025 21:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737057823;
	bh=r5FDcc2Sri4L/Opdt8AhpKk8/ZOChcBlIzI0Wps3YZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xfae8FlWKPrqgEIo1A7knkHZLdYY9CtxwcRsr3PLHrXM9soyTcidlXp0DLL/bgJDS
	 ujzAmvVNu7/9tAmsJAeknCQ0R2ymfIlOMsFGRx0E+kcinOsvEfRYMYktB7tYdpj4rz
	 HG0MhYoEkOVdIvPQkqLCciAQuszybsbpgaC+ymNCS7tfa5vWPJ9b6EwQK9Fs2sTqkJ
	 jlsXTEQ7375KITPmrrQVoujc9lOXgWVdBEzY2KVEpkBYRjV8JS0GwAzHaFHaYR8JKs
	 K1cQMwA2ePKpi8YmbBlWOxhn1VvgS4AipTl+9AObnJtKZo0XA0k1R/flcf8iA7lzgQ
	 jYKACXrWtOxGA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B078069D; Thu, 16 Jan 2025 21:03:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552A88022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 21:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RJh3ODqy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44139104884B5; Thu, 16 Jan 2025 21:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737057818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5FDcc2Sri4L/Opdt8AhpKk8/ZOChcBlIzI0Wps3YZE=;
 b=RJh3ODqyxFxV3HAAtXjryUFxe8U6nhbi/l7IKi3db3suU+VeDG6wDxhKcNBe18KkdGeHvT
 MTMLciUxX1i2XPZc2bKRald8vAKfbKhTCZOFq7066QimMq5O5WG5v52wSxyXDUw0Wk9oSr
 YxENt5iMKYzp1uqYEXd1dKBOhNZPScPW7JxLOpsCZlAkFrLVKfiSjH46EgBloVEep+fTc/
 xKWhIvvlpgvMfTbcl21ubvBVR/I8gbAw1PA9VB82rJEbkKEaN6kd2o6fINOTx/jWhHa0u0
 Qy5ntFKZQ+OWoKMv5lSE98oWAjdLRfYsEWIJ3FWG6t2RtPs1lvV/Z5IzZA5H2w==
Message-ID: <788bf415-6110-4811-8a91-1949ad42252b@denx.de>
Date: Thu, 16 Jan 2025 21:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/20] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
 <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
 <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/16/25 8:42 PM, Tim Harvey wrote:
> On Thu, Jan 16, 2025 at 11:38 AM Tim Harvey <tharvey@gateworks.com> wrote:
>>
>> On Wed, Jan 15, 2025 at 5:30 AM Alice Guo <alice.guo@oss.nxp.com> wrote:
>>>
>>> From: Ye Li <ye.li@nxp.com>
>>>
>>> This patch adds i.MX95 19x19 EVK board basic support.
>>>
>>> Messaging unit for EdgeLock Secure Enclave, messaging unit for System
>>> Manager, uSDHC for SD Card, gpio, lpuart are supported now.
>>>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>> <snip...>
>>> diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..1ed15ca47b157067a7376b0b32101dc7f9899f4f
>>> --- /dev/null
>>> +++ b/board/freescale/imx95_evk/imx95_evk.c
>>> @@ -0,0 +1,54 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright 2025 NXP
>>> + */
>>> +
>>> +#include <env.h>
>>> +#include <init.h>
>>> +#include <asm/global_data.h>
>>> +#include <asm/arch-imx9/ccm_regs.h>
>>> +#include <asm/arch/clock.h>
>>> +#include <fdt_support.h>
>>> +#include <asm/io.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/delay.h>
>>> +#include <miiphy.h>
>>> +#include <netdev.h>
>>> +#include <asm/gpio.h>
>>> +#include <asm/mach-imx/sys_proto.h>
>>> +#include <scmi_agent.h>
>>> +#include <scmi_protocols.h>
>>> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
>>> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
>>
>> Hi Alice,
>>
>> Most of the above are not needed (and should be alphabetized anyway)
>>
>> The only ones needed are:
>> #include <asm/arch/clock.h>
>> #include <asm/gpio.h>
>> #include <asm/mach-imx/sys_proto.h>
>>
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>
>> not needed as you don't use gd
>>
>> Best Regards,
>>
>> Tim
> 
> Hi Alic,
> 
> One more thing to do for next series. Refresh your
> imx95_19x19_evk_defconfig as its very out of sync:
> 
> make imx95_19x19_evk_defconfig
> make savedefconfig
> cp defconfig configs/imx95_19x19_evk_defconfig
And please enable CONFIG_FIT and CONFIG_FIT_VERBOSE .
