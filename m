Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEDDCA0EEB
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 01:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07501801DD;
	Wed, 20 Aug 2025 03:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2369802C1; Wed, 20 Aug 2025 03:49:44 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF6680107
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 03:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.12]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 23BA7B4E001C;
 Wed, 20 Aug 2025 03:49:39 +0200 (CEST)
Message-ID: <10379dc7-ca9e-45ee-b1ea-1f9709028511@freeshell.de>
Date: Tue, 19 Aug 2025 18:49:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select also CMD_DHCP from EFI_HTTP_BOOT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>
References: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
 <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
Content-Type: text/plain; charset=UTF-8
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

CC: Jerome

Hi Jan, and Heinrich, et al.

On 8/19/25 07:45, Heinrich Schuchardt wrote:
> On 19.08.25 16:33, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is needed because distro_efi_read_bootflow_net will then need
>> dhcp_run which is not already enabled by CMD_NET.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   lib/efi_loader/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index c2aa88f59fb..a4055e1cb43 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -564,6 +564,7 @@ config EFI_HTTP_BOOT
>>       bool "EFI HTTP Boot support"
>>       depends on NET || NET_LWIP
>>       select CMD_NET
>> +    select CMD_DHCP
> 
> It would be preferable to get rid of all CMD_* symbols here. They are
> just the result of missing separation of CLI and library.
> 
> DHCP is not needed to boot via HTTP. You can manually set up a network
> interface.
> 
> Please, change your patch to use "implies".
> 
> Best regards
> 
> Heinrich
> 
>>       select CMD_DNS
>>       select CMD_WGET
>>       select BLKMAP
> 

Yes this is the overall trouble I see and why I am writing [1] about
symbol names being shortened too much. It would be self-documenting and
more readable to refactor the network protocol symbol names throughout
U-Boot allowing as:

       select PROTO_NET_DHCP
       select PROTO_NET_DNS
       select PROTO_NET_HTTP
       select BLKMAP

...where there is no question what is intended. Compare to:

       select DHCP
       select DNS
       select HTTP
       select BLKMAP

...is very short, but not helpful for code maintenance, and in my
opinion very quickly reading this code block I do not understand which
symbols are network protocols; and searching the code base for all
network protocols in config is not simple, there is not enough information.

It makes most sense to me reading that CONFIG_CMD_DNS selects
PROTO_NET_DNS and if I am writing some code elsewhere this example is
easy to understand I should select PROTO_NET_DNS

I favor a wider change of renaming symbols for legacy network NET to
become LNET and then the result can be "NET" refers to any network stack
including LNET and LWIP. Then what I have suggested here for the context
of this patch will not be confused about selecting legacy network
protocols; it is about being readable and simple to understand quickly.

1: "Re: [PATCH] net: introduce CONFIG_DNS"
https://lore.kernel.org/u-boot/d77f193b-0b0a-44cd-b0e0-7da83a6a8f4b@freeshell.de/


- E Shattow
