Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7920C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A895E86FC8;
	Wed, 25 Oct 2023 10:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dN/U/9AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958AF87A2D; Wed, 25 Oct 2023 10:28:26 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C9A8689A
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id DA5276607343;
 Wed, 25 Oct 2023 09:28:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1698222504;
 bh=6o+hKoXGO55KO5FD982+LYv5UkH9mNqz9WkuhRgMTwQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=dN/U/9AGjCDaShxBaBvrLWfataYSUK4aJ1V7It5m64AhC1TpI5I6DoMr1Nd8kjzRH
 poVTevCFbqVfdb0iDsN0g0LaM5aphijc9JDm0WdTLyx80KWM+UEW1TnxsZPNNb3y3R
 hPrciUycj4PgI9b9A/R+9p5/8n/iJd5wIIikOqSm6KWbr/24AWQJ+YxyIpHunCTebG
 870i4qT7Whl+mF7QkTvKM1dcmB5FJDGdxFKpXcW4Vxv9FRQbyDkMzvFplzwvqwt1Ya
 cpiM+R3B8zEYR1Q5rZSblDtngrhAXCe2+d+syyuCCegExvBp8AIoFvx8ykPXzy1XVf
 QYvr/c8nyH0Aw==
Message-ID: <d6171ff3-766f-4846-9136-272c2f95dc3c@collabora.com>
Date: Wed, 25 Oct 2023 11:28:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for sam9x60 curiosity
To: Durai.ManickamKR@microchip.com, u-boot@lists.denx.de,
 Hari.PrasathGE@microchip.com, Varshini.Rajendran@microchip.com,
 Cristian.Birsan@microchip.com, Nicolas.Ferre@microchip.com,
 Balamanikandan.Gunasundar@microchip.com
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
 <20230922-gangrene-evolution-9c087f58f165@ifak-system.com>
 <a11db1f4-0d45-9056-a7a3-60a451fe7f1b@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <a11db1f4-0d45-9056-a7a3-60a451fe7f1b@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/26/23 09:13, Durai.ManickamKR@microchip.com wrote:
> 
> On 22/09/23 12:30, Alexander Dahl wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hello Durai,
>>
>> Am Thu, Sep 21, 2023 at 10:36:27PM +0530 schrieb Durai Manickam KR:
>>> This patch series adds boot from NAND support, configs update and
>>> fixes. The changes has been done on top of u-boot version 2023.07.
>> Well, interesting.  I sent patches for NAND flash support on that very
>> board some weeks ago which were already applied to the at91 custodian
>> tree:
>>
>> https://source.denx.de/u-boot/custodians/u-boot-at91/-/tree/next?ref_type=heads
>>
>> Tom already merged that to the mainline next branch.  I suggest you
>> rebase on next.
> 
> Hi Alexander,
> 
> Well, it is present in custodians next branch. Only thing which is
> missed is the NAND defconfig support [PATCH 2/4]. Will send only this
> patch shortly.

Hello Durai,

Before you resend, check your config please, as in the CI loop it does 
not build as-is:

+arm-linux-gnueabi-ld.bfd: drivers/clk/at91/sam9x60.o: in function 
`sam9x60_clk_probe':
+drivers/clk/at91/sam9x60.c:595:(.text.sam9x60_clk_probe+0x500): 
undefined reference to `sam9x60_clk_register_usb'
+make[1]: *** [Makefile:1765: u-boot] Error 1
+make: *** [Makefile:177: sub-make] Error 2

Eugen

> 
>> Add Eugen to Cc, since he still is officially listed as maintainer of
>> the at91 stuff.
>>
>> Greets
>> Alex
>>
>>> Durai Manickam KR (4):
>>>     configs: at91: sam9x60_curiosity: update
>>>       sam9x60_curiosity_mmc_defconfig
>>>     configs: at91: sam9x60_curiosity: Add
>>>       sam9x60_curiosity_nandflash_defconfig
>>>     ARM: dts: at91: sam9x60_curiosity: Enable NAND support
>>>     ARM: dts: at91: sam9x60_curiosity: fix eeprom compatible
>>>
>>>    arch/arm/dts/at91-sam9x60_curiosity.dts       | 106 +++++++++++++++++-
>>>    board/atmel/sam9x60_curiosity/MAINTAINERS     |   1 +
>>>    configs/sam9x60_curiosity_mmc_defconfig       |  14 +++
>>>    configs/sam9x60_curiosity_nandflash_defconfig |  92 +++++++++++++++
>>>    4 files changed, 212 insertions(+), 1 deletion(-)
>>>    create mode 100644 configs/sam9x60_curiosity_nandflash_defconfig
>>>
>>> --
>>> 2.25.1
>>>

