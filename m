Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7F7D767FA
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 19:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF927892CF;
	Thu, 31 Oct 2024 20:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dwblDb3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D5488B9E; Thu, 31 Oct 2024 20:17:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA0A88B8F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 20:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fe9=R4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730402260;
 bh=kwcxM6rJkwNZPRIJtR8DQd7KCM/WDdlmqVAmoUUIVKs=;
 b=dwblDb3cRUuxqwTBAEYWeHn1io9H5aPI+0o88Tfj78vsrtCrOkhY+uQazUEgUIv+CbgACoHxh
 l71eYEiMp8w+PsTZRKQ/2z64kdxgGA0MhP3wc/oX6qY1+ou6lGYUfrhOuFLSQUnbQ3zOhtKMYsS
 xllCnTYmYafcorZm/wV5BJ+bMIyH+QNAc6XNkXPCQuejYPmeEVuw3Bt+Ecka7YKO72pfNHVbKGi
 f6Tk4IfjU56lkZ263ffvxr1MMq9/S3xvicsDiq9m+6UiF+8JcvxgCUqSWbBycSSKbQ25XcrtiTp
 r7ZFvkLQ8yMyhM/JOtj9kZ8MIJze3vl/im432vyS1ypQ==
Message-ID: <1d28e59e-9e92-4570-960c-ed642731a226@kwiboo.se>
Date: Thu, 31 Oct 2024 20:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rockchip: rock5b-rk3588: Enable automatic PCI
 enumeration
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 FUKAUMI Naoki <naoki@radxa.com>
References: <20241031180212.116330-1-sebastian.reichel@collabora.com>
 <e457b630-bd7d-4f7d-bd4e-20f0e3fbc9a2@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e457b630-bd7d-4f7d-bd4e-20f0e3fbc9a2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6723d7d14382f7c758ed7354
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

Hi Sebastian,

On 2024-10-31 19:15, Eugen Hristev wrote:
> Hello Sebastian,
> 
> On 10/31/24 20:01, Sebastian Reichel wrote:
>> PCI enumeration is required to detect the onboard Ethernet device.
>>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>>   configs/rock5b-rk3588_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
>> index c54e13e8732c..e5b9f7d326b4 100644
>> --- a/configs/rock5b-rk3588_defconfig
>> +++ b/configs/rock5b-rk3588_defconfig
>> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>   CONFIG_SPL_SPI=y
>>   CONFIG_PCI=y
>> +CONFIG_PCI_INIT_R=y
>>   CONFIG_DEBUG_UART=y
>>   CONFIG_AHCI=y
>>   CONFIG_FIT=y
> 
> This has been added and removed before, please see
> 
> https://lore.kernel.org/all/20231104130451.111020-1-martin.roukala@mupuf.org/T/
> 
> this commit adds it
> 5b269ed404dc ("configs: rockchip: rock5b-rk3588: Enable CONFIG_PCI_INIT_R")
> 
> this commit removes it again
> 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA 
> cards")

What use-case are you trying to solve with a forced pci enumeration?

With standard boot Ethernet should be enabled when it is needed.

However for EFI boot Ethernet maybe is not detected? Please see [1] for
a possible alternative patch that I created when someone reported an
issue with iPXE boot some time ago.

I did not get confirmation it fully solved the issue, from what I could
test it should help get Ethernet detected during EFI boot on a ROCK 5B.

[1] https://github.com/Kwiboo/u-boot-rockchip/commit/90b6d787de0b3e6ed863440be576b01d83ba5789

Regards,
Jonas

> 
> Eugen
> 
> 

