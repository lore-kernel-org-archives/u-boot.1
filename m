Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B251C5472D
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 04:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FAD88A8B;
	Wed, 28 Aug 2024 06:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724818229;
	bh=J7oA9Gy2TvP4V91TWYP86rvBAuMLs38yrXSUP15gWYM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0RC237y3WzUnRXZt8HS6v2jLvGhHl1uP6xym0gdkn7O7v4KHKbFi5Oik2lqaAY8nH
	 lFaixxISaoM81oKipmgGqGOtKSspAMaoa0SJch1fvHYvPIBu/b5STqh/MdbojqeQaj
	 wAlLeyJvK/sVPwrm585+as8THih3Knfgf0jGpchnEnCcZN2KKvls3D+xQkcoKNvBOp
	 3/o6paz32jgm6+FbQXHa5TTWU/HaV2iazPRzRO4a9hz+PpRtrFx8UkWxOwA1VgN5GV
	 TagX0Pt3YWmTDRhiYahZA1WrvJqd7Ns3X/9QH27zGFYGBeOrvtY57P/ggKtm4BWHsH
	 Ba2IN5IQnGgDg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9DAFC889CD;
 Wed, 28 Aug 2024 06:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724818227;
 bh=J7oA9Gy2TvP4V91TWYP86rvBAuMLs38yrXSUP15gWYM=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=l/vc/Gbr5DUf2zbQu9UtCkOn5EvFbaAxMUW4UuyF1Pmnrk1MyJyPGACT0YShG4jJo
 qrog1Sjm72kdAcRy76uVJovOjaJub9Or33Iet/VzPyeBTtXvINqp8ICvQgeejLFXTL
 325WJxO7axASuOHFckt8NC23stD12Zl3RCQZAyGFVZ6kMAekL3C4z/p0ZK8RvQrwsv
 5lGRyCrmM3wR81vFUUI7JA+ijHDrKDKwdU7QJEJ0tFEuxYXV2Rm1hW5T/p3b2LxD3n
 UPWGTcX7d0GO9QoDLKq8rGkKJK4kT8Rr/NBKP8udNKahwY9sKnDoJ9dfEWVoxXLNUY
 ItL2XB0bblR8w==
Message-ID: <d2a1da39-2623-4f66-a70b-9331e1990f98@denx.de>
Date: Wed, 28 Aug 2024 06:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
To: Fabio Estevam <festevam@gmail.com>, Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <Mn.Zbvh.7W8POzTA8pZ.1cpeVN@seznam.cz>
 <CAOMZO5BGStCUYDipoiNo3z_EEVW9W9cGDKLk-08m6Tur3rOKBQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5BGStCUYDipoiNo3z_EEVW9W9cGDKLk-08m6Tur3rOKBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/28/24 4:16 AM, Fabio Estevam wrote:
> Adding more folks on Cc to help review it.
> 
> 
> On Tue, Aug 27, 2024 at 11:13 PM Tomas Paukrt <tomaspaukrt@email.cz> wrote:
>>
>> The PSR register works correctly for GPIO pins in input mode,
>> but always returns 0 for GPIO pins in output mode unless the SION
>> bit is set. The DR register works correctly in both modes without
>> the need to set the SION bit.

I think this claim is not correct.

There is a difference between PSR and DR , PSR reports the sensed state 
on the pad, the DR reports the state that was set on the pad by user. 
Those may differ, e.g. in case the pin is not even configured as a GPIO 
but has a IOMUXC SION bit set, it is still possible to read back the 
state of the pad via PSR register, but not via DR register.

For more details, see discussion around similar (rejected) patch to 
Linux kernel:

https://lore.kernel.org/all/CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com/

>> Please note that the Linux gpio-mxc driver already uses
>> the DR register for all GPIO pins in output mode:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=442b2494b17d1a4f0a14721580271eb23ebffd42

The flag BGPIOF_READ_OUTPUT_REG_SET indicates that for GPIOs which are 
set as direction-output, the state is read out of DR register, but for 
GPIOs which are direction-input, the state is read out of PSR register.

[...]

>> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
>> ---
>>   drivers/gpio/mxc_gpio.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c
>> index cac6b32..5cd7681 100644
>> --- a/drivers/gpio/mxc_gpio.c
>> +++ b/drivers/gpio/mxc_gpio.c
>> @@ -133,7 +133,7 @@ int gpio_get_value(unsigned gpio)
>>
>>          regs = (struct gpio_regs *)gpio_ports[port];
>>
>> -       val = (readl(&regs->gpio_psr) >> gpio) & 0x01;
>> +       val = (readl(&regs->gpio_dr) >> gpio) & 0x01;
>>
>>          return val;
>>   }
>> @@ -210,7 +210,7 @@ static void mxc_gpio_bank_set_value(struct gpio_regs *regs, int offset,
>>
>>   static int mxc_gpio_bank_get_value(struct gpio_regs *regs, int offset)
>>   {
>> -       return (readl(&regs->gpio_psr) >> offset) & 0x01;
>> +       return (readl(&regs->gpio_dr) >> offset) & 0x01;
>>   }

This change is not correct, it does unconditionally switch readback from 
PSR to DR and does not differentiate between input/output direction of 
the GPIO. This would have to be fixed in V3 to make that patch on par 
with the Linux behavior.
