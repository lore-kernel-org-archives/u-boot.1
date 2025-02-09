Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B30C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 01:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2787380805;
	Sun,  9 Feb 2025 02:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vWgQs5Sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1756380834; Sun,  9 Feb 2025 02:27:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E74807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 02:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739064442;
 bh=Fs6VVcf3uIPeSjOHtFENMnTgorsDTtkepW4us+QFkno=;
 b=vWgQs5SmPGxwDhpjRvnFmZAUx1a2moaCnx+uxX9Lof4YUUeUBUKFoYiUPGskxORjGdnhO9t/W
 ighZI5jqu1a5ZZ0AoUNCnNkvLHQ7fVAveEhi5276vSjRGbs83UWN+XPFPz+dT/r7YVMQUjwOEGj
 ZLPLxbcZBZUPbd1ScNGpCbsh5NiFAcd4VxgXiihehaprBronNMAHzuTneMPcQRIHU6oi8GSSBWw
 zfQkZyh1L4T8OgSLM+MgFY2HAQDGJQD5UdOq27IJVn8ik6d9V/hD8vAgpv+3A9rwjx4xhMzHn/s
 c66rpDbXSe9Ro4zZdkC/djv9T6956z6fb7gyYPswucFQ==
X-Forward-Email-ID: 67a80477ae24fcf613ed6541
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e2b0e629-af15-4b9e-b79f-79802ae08c6a@kwiboo.se>
Date: Sun, 9 Feb 2025 02:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value
 in offset prop
To: Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-3-jonas@kwiboo.se>
 <CAFLszThaHxr6T5mj6jCWUUsieuSkCsmcWMDNu+td5jSimeL2PA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszThaHxr6T5mj6jCWUUsieuSkCsmcWMDNu+td5jSimeL2PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 2025-02-09 00:04, Simon Glass wrote:
> Hi Jonas,
> 
> On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Use the offset configured with SYS_SPI_U_BOOT_OFFS Kconfig option
>> instead of a hardcoded 0x40000 for the FIT payload offset.
>>
>> This has no intended impact as SYS_SPI_U_BOOT_OFFS=0x40000.
> 
> When you add CONFIG options into a devicetree, it makes it difficult
> to build it. We have to individually build U-Boot for each target just
> to get the right values.

This only aligned everything with the simple-bin-spi image and prepared
for moving the SPI flash payload offset to 0xE0000.

If you are looking at this now, please also take a look at [1]. There
where some questions directed at you there :-)

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241212235735.164272-7-jonas@kwiboo.se/

> 
> For rk3399-generic, this means I have to drop gru.
> 
> Can we not use a binman symbols instead?

All RK3399 targets having support for building a SPI flash image now use
CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000 after these changes where merged.

Regards,
Jonas

> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/dts/rk3399-gru-u-boot.dtsi | 2 +-
>>  arch/arm/dts/rk3399-u-boot.dtsi     | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Regards,
> SImon

