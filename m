Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93E7C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 09:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DFA487CE6;
	Mon, 29 Jan 2024 10:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CfUbG2c1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CD887CE9; Mon, 29 Jan 2024 10:55:31 +0100 (CET)
Received: from mail-m17219.xmail.ntesmail.com (mail-m17219.xmail.ntesmail.com
 [45.195.17.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BC287CBC
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 10:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CfUbG2c1DNgDsNQB0DrqEUHSVHedYZtpxfeot/+JZm+o0T0/ZTT9+hCRFEReG9p7ZPW97Ah/XPeplZ6M02dQYz7mQKQKCo75Q00y6pq3RvWa/gciJjqqnOqbFhsgx5jFUnlKlrMMt3PtA2OTfQ8BANunDPo+NYMV5Yg2xgT+Al8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=iFby5IsnVfEOqRLcfzcANrl/HqIlnOfyQewmSnFsSr0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 34FC99001B5;
 Mon, 29 Jan 2024 17:55:03 +0800 (CST)
Message-ID: <e1ae2d09-ec48-4b85-880b-8e42fe9abf1e@rock-chips.com>
Date: Mon, 29 Jan 2024 17:55:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] rockchip: migrate hardware.h inclusion into
 appropriate files
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-15-1eec1c34953c@theobroma-systems.com>
 <b0720d07-764d-4da6-aef4-c6c5a10fb0cf@rock-chips.com>
 <b14eb7bd-2dbd-4f79-b4c4-fa080b96cf2b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <b14eb7bd-2dbd-4f79-b4c4-fa080b96cf2b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsdGFYYSh9LTkMdSh5KGhhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d54a4d20503a9kunm34fc99001b5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Eio*CzMJMlEDMj5PHgxR
 PyEKCQFVSlVKTEtNTklJSktOS09OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSEpINwY+
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


On 2024/1/24 19:12, Quentin Schulz wrote:
> Hi Kever,
>
> On 1/24/24 11:46, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> Nothing of the hardware.h is used in include/configs, therefore, let's
>>> move that include to the files that actually require this include.
>>
>> hardware.h is one of common header for soc level, it's reasonable in 
>> the soc_common.h.
>>
>
> hardware.h is only defining macros which are "wrappers" around writel().
>
> writel() is NOT available in hardware.h, we need to include 
> <asm/io.h>. Which means someone who wants to use the wrappers defined 
> in hardware.h also needs to include the <asm/io.h> header, which 
> doesn't make much sense.
>
> Why this is done is because if I include <asm/io.h> in hardware.h but 
> do not remove hardware.h from the SoC configs header files, some 
> boards stop compiling in arch/arm/cpu/armv8/u-boot.lds with a 
> non-existing ALIGN signature (expects two arguments instead of 1). I 
> assume this is because there's an ALIGN macro somewhere in asm/io.h 
> that redefines the ALIGN assembly directive (c.f. 
> https://developer.arm.com/documentation/dui0473/m/directives-reference/align) 
> and that u-boot.lds somehow includes the SoC config header file 
> (because IIRC this is also included in the autogenerated 
> include/config.h which is included by "everything" ?)
>
> Basically, if I don't do that, then I need to manually add <asm/io.h> 
> to any file that also include <asm/mach-rockchip/hardware.h>, which 
> isn't really nice (but doable, we've done this until now).

Yes,  you are right.

This hardware.h is already there for the very beginning of the first 
rockchip soc support.

It's reasonable if all the soc related header file and its dependent 
header all included, but it's all around different files now.

So I will take this patch.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

>
> If you still prefer to keep hardware.h include in the SoC config 
> header file, then lemme know and I'll drop the hardware.h and io.h 
> patches from that patch series.
>
> Cheers,
> Quentin
