Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB9EC3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 782D5886B5;
	Thu, 11 Jul 2024 13:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="t8NxEV+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B6B886B6; Thu, 11 Jul 2024 13:03:38 +0200 (CEST)
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5998A874AC
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
 by shout01.mail.de (Postfix) with ESMTP id E7F07240DC1;
 Thu, 11 Jul 2024 13:03:35 +0200 (CEST)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
 by postfix03.mail.de (Postfix) with ESMTP id C5E1380192;
 Thu, 11 Jul 2024 13:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1720695815;
 bh=WEKnqZx1yUEpJRxoeInWUJpvDdZwEf8FO+tXDvDrOJc=;
 h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
 b=t8NxEV+PB8g3WAjsqiq58IYv4d5iaCFivom1VLw5kAUXNp8bJnn9N94Md+3leNA6a
 uBQ9wK1uspHlvxy49I0GkSOEQZlAOWWpUTb1bTllHPL0fHqzVPfCTJkqRwPQS5wi4G
 UUDIZxHVtkbnyyGLcnvNl8j810vSOinA5iAlpirtN/umgFaXzVEsrLKbR7wH4pz6Qe
 aU+ZmQcX61OEBuAlpwYT3Ybb0jMj2+VpsSX/zkZEbfK2hp/aHvpKSeXovWTY9A3fUp
 GSJ23KQso4rEzqtmDPTWuGqjJWRJFmZTfgp/jXCWfQshhyXm49C41jcP5zoo92ot08
 cjP/uyiws1CJg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 06029240C9A;
 Thu, 11 Jul 2024 13:03:33 +0200 (CEST)
Message-ID: <88c92e04-5cce-4821-9e20-4f910ded013b@mail.de>
Date: Thu, 11 Jul 2024 13:03:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] board: rockchip: Add FriendlyElec NanoPi R6S
To: Ulli Kehrle <ulli@vegan.im.it>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240607202111.453943-1-seb-dev@mail.de>
 <20240607202111.453943-2-seb-dev@mail.de> <87sex75kub.fsf@kehrle.me>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <87sex75kub.fsf@kehrle.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 3270
X-purgate-ID: 154282::1720695815-F36231F9-DF3FD9CB/0/0
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

Hi Ulli,

Sorry for the late reply, but thanks for testing!
I have sent a v3 of this patch, please reply to that mail
with your reviewed-by or tested-by tag if you'd like them
to be included.

Am 21.06.2024 um 00:07 schrieb Ulli Kehrle:
> 
> Sebastian Kropatsch <seb-dev@mail.de> writes:
>> The R6S is very similar to the R6C, the major difference being that
>> instead of the M.2 NVMe socket on the R6C, the R6S has a second RTL8125BG
>> Ethernet chip, which uses the same PCIe lanes that the R6C uses for its
>> M.2 socket. Other minor differences include:
>> - 12-pin GPIO FPC instead of 30-pin header
>> - IR receiver (pwm-based)
>> - 5V fan connector
>> Other than that, they are the same, which is why the difference in
>> U-Boot is only the missing NVME config option in the R6S defconfig.
>>
>> Please note that I was not able to test this device. I only chose to
>> add it due to it being a very similar implementation to the R6C, like the
>> NanoPi R5C and R5S are similar. It should however boot just fine and even
>> both RTL8125 Ethernet ports should work in U-Boot since RTL8125 is the
>> same chip used in the R6C, using the rtl8169 driver.
> 
> Hi Sebastian,
> 
> it looks like you forgot to include the hunk that includes the board
> config board/friendlyelec/nanopi-r6s-rk3588s/Kconfig into
> rk3588/Kconfig.

Yes indeed, thanks for catching this oversight! This is fixed in v3.

>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
>> index a9e400861a3..051d50e26f6 100644
>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>> @@ -257,6 +257,7 @@ config TEXT_BASE
>>   source "board/edgeble/neural-compute-module-6/Kconfig"
>>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>>   source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
>> +source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>>   source "board/indiedroid/nova/Kconfig"
>>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>>   source "board/turing/turing-rk1-rk3588/Kconfig"
> 
> Other than that, this appears to work great on my Nanopi R6S (with the
> device tree from linux-6.9), including all three network interfaces, but
> no working status leds for the rtl8169 ports.

Yes, I have noticed that too. Maybe this is a bug in the rtl8169 driver
from u-boot? Or maybe this can be fixed in the devicetree? Not sure.

> I have also noticed the
> minor inconvenience that only the first two interfaces are initialized
> with nonzero MAC addresses (because rockchip_setup_macaddr is hardcoded
> for two interfaces?):
> 
>> => pci enum
>> => net list
>> eth0 : ethernet@fe1c0000 7a:d9:6d:ad:cb:26 active
>> eth1 : eth_rtl8169 7a:d9:6d:ad:cb:27
>> eth2 : eth_rtl8169 00:00:00:00:00:00
> 
> I don't think this is a huge deal as it works fine when manually setting
> a MAC address and other boards with three or more interfaces (like the
> NanoPi R5S) also behave that way. What do you think?

Maybe this is a similar issue to this:
https://lore.kernel.org/u-boot/CAPDEroXsN03yKL3D-tCcfQqA6vde7P4t2GmwQq80vnLQJw+4YA@mail.gmail.com/T/

Solving this issue is beyond my current abilities unfortunately.

Cheers,
Sebastian

