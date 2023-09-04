Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF1FC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 01:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55E0864C5;
	Mon,  4 Sep 2023 03:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eGJotr7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150CE8678A; Mon,  4 Sep 2023 03:09:44 +0200 (CEST)
Received: from mail-m121143.qiye.163.com (mail-m121143.qiye.163.com
 [115.236.121.143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20242864A0
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 03:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eGJotr7C348ZKpEUzA1sr4r1bHJkxD2HqT2wXfrz90u1Br/KVd6en1xzFXLJuonGDW7+L0xyZ/aZVnwpL3s0twjuU/RppvUUmf1IeF458tll1vVlLP9kzi9GGNKqIvwWQHzeuIRt+aCgilc9zTJoSqIT8ME6l93y8egAYatlpE4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=O4BRvl27vB5Z/ySjw6vYChqH/veXNe1WrTEiDIGM1uk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m127102.qiye.163.com (Hmail) with ESMTPA id 9453F6C02E1;
 Mon,  4 Sep 2023 09:09:16 +0800 (CST)
Message-ID: <18565ab5-2777-2ac4-6d13-76ed06d3c566@rock-chips.com>
Date: Mon, 4 Sep 2023 09:09:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] rockchip: Use an external TPL binary on RK3308
Content-Language: en-US
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 FUKAUMI Naoki <naoki@radxa.com>
References: <20230902163159.343716-1-massimo.pegorer+oss@gmail.com>
 <CAC928HY_6fotX5DnQMR4=pAojOTjMFhSmOQLX3sD87UF+ruQJw@mail.gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CAC928HY_6fotX5DnQMR4=pAojOTjMFhSmOQLX3sD87UF+ruQJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1LQ1ZNGU5MSxpIH05OTkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8a5dbc9d59b280kuuu9453f6c02e1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6CCo*TD1MLywsKR9RGjFI
 CC9PFE1VSlVKTUJITENCTE5MSU1PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUJDNwY+
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

Hi Massimo,

On 2023/9/3 18:04, Massimo Pegorer wrote:
> Il giorno sab 2 set 2023 alle ore 18:32 Massimo Pegorer
> <massimo.pegorer+oss@gmail.com> ha scritto:
>> There is no support to initialize DRAM on RK3308 SoC using U-Boot
>> TPL and therefore an external TPL binary must be used to generate
>> a bootable u-boot-rockchip.bin image.
>>
>> Imply ROCKCHIP_EXTERNAL_TPL by default for RK3308 builds. Remove
>> useless TPL_SERIAL.
>>
>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>> ---
>>   arch/arm/mach-rockchip/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index a279582f4f..e8584de258 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -159,6 +159,7 @@ config ROCKCHIP_RK3308
>>          select SPL_ATF
>>          select SPL_ATF_NO_PLATFORM_PARAM
>>          select SPL_LOAD_FIT
>> +       imply ROCKCHIP_EXTERNAL_TPL
>>          imply ROCKCHIP_COMMON_BOARD
>>          imply SPL_ROCKCHIP_COMMON_BOARD
>>          imply SPL_CLK
>> @@ -166,7 +167,6 @@ config ROCKCHIP_RK3308
>>          imply SPL_SYSCON
>>          imply SPL_RAM
>>          imply SPL_SERIAL
>> -       imply TPL_SERIAL
>>          imply SPL_SEPARATE_BSS
>>          help
>>            The Rockchip RK3308 is a ARM-based Soc which embedded with quad
>> --
>> 2.34.1
>>
> I've just noticed that Jonas followed a different approach for RK3568
> and RK3588:
>
> config ROCKCHIP_EXTERNAL_TPL
>      bool "Use external TPL binary"
>      default y if ROCKCHIP_RK3568 || ROCKCHIP_RK3588

You can add RK3308 to default y.


Thanks,

- Kever

>
> Is any one preferred? I slightly prefer the one I've done, as it gives
> a terse picture of what a SoC select/imply in a single place. Of
> course I can change it in a V2, if Jonas way is preferred, and to have
> a single congruent way to do things.
>
> Thanks. Regards,
> Massimo
