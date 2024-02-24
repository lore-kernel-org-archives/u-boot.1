Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61473C54E41
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 09:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63C087725;
	Sat, 24 Feb 2024 10:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Uxv/3/Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A40387BAF; Sat, 24 Feb 2024 10:16:38 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD568765B
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 10:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2CC883F2F7; 
 Sat, 24 Feb 2024 09:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708766192;
 bh=etUjGS4W1bVyyLjys5SIiYhX3iOCT1sSyUTywOKIe7Q=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Uxv/3/XucaGa4QWZgfHfXmwxMi7PbpDzpDO1tCVKZCEoaUUHhhjgVuxkZrV30jO1Y
 I0HslQVQDI+tqse7G5676cNY8mLtHTBbhnPktEfFzFqTRkbbQh8PQdIkpPBOSFvFcv
 Brr9iFuGDQ9T9Iy/53J4uG8gGxzXlZRjFcRWtcsH9Xwii3kkH1VPTeN+q++o7qejy+
 TjZ/b5XhiIM0Z1RgZed7qyrjBiccZ3fW27F1V5H9O86o2FCZK8aYw12tbl2xpp0SNK
 S0kvTAuUhqP8sKD375QDa8i3GzKZ6ATaG3vw0jkuWGU7BrhcjEvPmJLjOOo/bkzR94
 llG5/OHk3GQEw==
Message-ID: <6350225c-0b02-47e9-a947-03b258885373@canonical.com>
Date: Sat, 24 Feb 2024 10:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: separate .data and .text sections of EFI binaries
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240214190625.13764-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+SVZw14QeNLFp8KC8=cP8fYaZUnThQG_cEivxN56BwAw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+SVZw14QeNLFp8KC8=cP8fYaZUnThQG_cEivxN56BwAw@mail.gmail.com>
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

On 2/16/24 11:35, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> [...]
> 
>>          }
>> +       .rela.dyn : { *(.rela.dyn) }
>> +       .rela.plt : { *(.rela.plt) }
>> +       .rela.got : { *(.rela.got) }
>> +       .rela.data : { *(.rela.data) *(.rela.data*) }
> 
> Why are we switching from Rel to Rela?

This was wrong.

Looking at the u-boot ELF binary we see these relocation sections:

arm: .rel.dyn
arm64: .rela.dyn
riscv64: .rela.dyn

In our EFI object files we currently have no relocations. This is why 
tests did not complain.

In arch/arm/lib/reloc_arm_efi.c we handle DT_REL.
In arch/arm/lib/reloc_aarch64_efi.c we handle DT_RELA.
In arch/riscv/lib/reloc_riscv_efi.c we handle DT_RELA.

Best regards

Heinrich

> 
>>          _etext = .;
>>          _text_size = . - _text;
>> -       .dynamic  : { *(.dynamic) }
>> +       . = ALIGN(4096);
>>          .data : {
>>                  _data = .;
>>                  *(.sdata)
>> @@ -47,20 +59,19 @@ SECTIONS
>>                  . = ALIGN(512);
>>                  _bss_end = .;
>>                  _edata = .;
>> -       }
>> -       .rel.dyn : { *(.rel.dyn) }
>> -       .rel.plt : { *(.rel.plt) }
>> -       .rel.got : { *(.rel.got) }
>> -       .rel.data : { *(.rel.data) *(.rel.data*) }
>> -       _data_size = . - _etext;
>> +       } :data
>> +       _data_size = _edata - _data;
>>
>> +       . = ALIGN(4096);
>> +       .dynsym   : { *(.dynsym) }
>> +       . = ALIGN(4096);
>> +       .dynstr   : { *(.dynstr) }
>> +       . = ALIGN(4096);
>> +       .note.gnu.build-id : { *(.note.gnu.build-id) }
>>          /DISCARD/ : {
>>                  *(.rel.reloc)
>>                  *(.eh_frame)
>>                  *(.note.GNU-stack)
>> -               *(.dynsym)
>> -               *(.dynstr)
>> -               *(.note.gnu.build-id)
>> -               *(.comment)
>>          }
>> +       .comment 0 : { *(.comment) }
>>   }
>> --
>> 2.43.0
>>
> 
> Cheers
> /Ilias

