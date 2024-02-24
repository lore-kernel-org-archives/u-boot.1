Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968A0C54E41
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 23:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B4A87BEE;
	Sun, 25 Feb 2024 00:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SPy1/sfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385F587C62; Sun, 25 Feb 2024 00:43:38 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CCE8718A
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 00:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 134DB3FB5E; 
 Sat, 24 Feb 2024 23:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708818215;
 bh=pjbvw3wUSnx2Yk3mjClI/Lb+L0KBm+kivhk4LnyufLs=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=SPy1/sfMtqSqgdB86tk2moIptvUtJIeWv4/GbKcpFrONDnkWGGq9vbDH+9TrlQ7+q
 oF3Lm08R2pguJpkdCoOCUwjW16DkNNU11H1LkKRFTRV5GmJa4CEPESWUXAMKj+LHLj
 rmk/OEQ4r57jQue8Z1EWyX3tIrj3WtmkfLQblSA215JKDglHawFE9KfIMICXS+sWCD
 JONwvtvd8/yPCQVNGioCpaAjlYl9vRo0RCEeJNsAycmVoA9KuyydlBOHpLuSCvzb/u
 yUScncBLAv10mXaXi4XwTa2JY6BkPgm7eS1tVw3469Lwx1n8uy8Ky8yeifMuJyy5CB
 VJczq1QyKC2JQ==
Message-ID: <54eaf767-0b47-4da2-8804-6356fdaa893b@canonical.com>
Date: Sun, 25 Feb 2024 00:43:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: separate .data and .text sections of EFI binaries
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240214190625.13764-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+SVZw14QeNLFp8KC8=cP8fYaZUnThQG_cEivxN56BwAw@mail.gmail.com>
 <6350225c-0b02-47e9-a947-03b258885373@canonical.com>
Content-Language: en-US, de-DE
In-Reply-To: <6350225c-0b02-47e9-a947-03b258885373@canonical.com>
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

On 2/24/24 10:16, Heinrich Schuchardt wrote:
> On 2/16/24 11:35, Ilias Apalodimas wrote:
>> Hi Heinrich,
>>
>> [...]
>>
>>>          }
>>> +       .rela.dyn : { *(.rela.dyn) }
>>> +       .rela.plt : { *(.rela.plt) }
>>> +       .rela.got : { *(.rela.got) }
>>> +       .rela.data : { *(.rela.data) *(.rela.data*) }
>>
>> Why are we switching from Rel to Rela?
> 
> This was wrong.
> 
> Looking at the u-boot ELF binary we see these relocation sections:
> 
> arm: .rel.dyn
> arm64: .rela.dyn
> riscv64: .rela.dyn
> 
> In our EFI object files we currently have no relocations. This is why 
> tests did not complain.
> 
> In arch/arm/lib/reloc_arm_efi.c we handle DT_REL.
> In arch/arm/lib/reloc_aarch64_efi.c we handle DT_RELA.
> In arch/riscv/lib/reloc_riscv_efi.c we handle DT_RELA.

To be truthful our generated binaries are only usable because we have no 
relocations.

If we had relocations, copying these to the .text or .data section would 
would not work. We would have to translate them to the relocation format 
of PE files and put them into the .reloc section like EDK II does in 
BaseTools/Source/C/GenFw/Elf32Convert.c.

Best regards

Heinrich

> 
> Best regards
> 
> Heinrich
> 
>>
>>>          _etext = .;
>>>          _text_size = . - _text;
>>> -       .dynamic  : { *(.dynamic) }
>>> +       . = ALIGN(4096);
>>>          .data : {
>>>                  _data = .;
>>>                  *(.sdata)
>>> @@ -47,20 +59,19 @@ SECTIONS
>>>                  . = ALIGN(512);
>>>                  _bss_end = .;
>>>                  _edata = .;
>>> -       }
>>> -       .rel.dyn : { *(.rel.dyn) }
>>> -       .rel.plt : { *(.rel.plt) }
>>> -       .rel.got : { *(.rel.got) }
>>> -       .rel.data : { *(.rel.data) *(.rel.data*) }
>>> -       _data_size = . - _etext;
>>> +       } :data
>>> +       _data_size = _edata - _data;
>>>
>>> +       . = ALIGN(4096);
>>> +       .dynsym   : { *(.dynsym) }
>>> +       . = ALIGN(4096);
>>> +       .dynstr   : { *(.dynstr) }
>>> +       . = ALIGN(4096);
>>> +       .note.gnu.build-id : { *(.note.gnu.build-id) }
>>>          /DISCARD/ : {
>>>                  *(.rel.reloc)
>>>                  *(.eh_frame)
>>>                  *(.note.GNU-stack)
>>> -               *(.dynsym)
>>> -               *(.dynstr)
>>> -               *(.note.gnu.build-id)
>>> -               *(.comment)
>>>          }
>>> +       .comment 0 : { *(.comment) }
>>>   }
>>> -- 
>>> 2.43.0
>>>
>>
>> Cheers
>> /Ilias
> 

