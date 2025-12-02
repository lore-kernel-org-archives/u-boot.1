Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F261ACFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 13:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8279283E72;
	Tue,  2 Dec 2025 14:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="lAvVqMU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133E583E72; Tue,  2 Dec 2025 14:35:43 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA02C83CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 14:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b735b7326e5so1054682766b.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 05:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1764682540; x=1765287340;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wyK9HxNX3G8BxYfKpDLIOGW2C+rRHQJPiWpLGjQzsc0=;
 b=lAvVqMU08Z9E4gKYe52LRqqV9lnMbJgN0xrK7lwoaGHF3qU7DEnQ+iqHujRnKmUjGH
 uhlPSmTLqfr4UVvgki649JBGaQQMMe0dLAGK+DLZx2N8TDHOBulxEFKT1wtfn2PtxB28
 SS6UPILdVRoQ+rmZYHCB2nZtS57RPO2sA+UlHIlYWIWIvPsnDgxffKzN7LnbAtUe9Oom
 P4QhMLLxJK5aSoRjK03qwgBQTqFui/miaEFe0vcFZ7rD6Fn8iOc+T2UKVJjyB/B6vgRP
 36Ndhd7l/iTBo8BLtpFSv1LfIAz34ssviqmGj378IdPGyxVuifudiDGST163+ILlbHpl
 Kggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764682540; x=1765287340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wyK9HxNX3G8BxYfKpDLIOGW2C+rRHQJPiWpLGjQzsc0=;
 b=GjDtqoTArQ/Cx2iFuh36a8zu0JlHNXVZrIPgVL3uxWk5WazRHyypjKxejjSv/6w2dK
 Xsz+i27unVcsAvwuLc27Wxloj6xu7VCRee2of3MfVcjfnXPfG91Fml6/vg3YS/YH+jft
 OCB3Aqzr0i0pJoQ9g9FEZGLQjyaQVtugkBy2auM2VkaPAWBo68uK1vXfxpMs9obt9XLu
 x/XmubFAxa5AxOLcvxoH90CdBT5HuVkl0xXQt5Bux1bQ0JoPSMz8GlChPfyXQZYcnvtC
 TuceuN/0OU9MxwBb8a7r7o2V9zH5vFyRO51LKfC7UchDE9ILBMRyqCeXRJ0UTWShJTN0
 vvTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2F2V1sgkAlt0JwqUiVOut4tAwk5Z4wUMSWrIgS8UCSJOOcvVRk1UwviK0iGjRlB2q5+2vVZo=@lists.denx.de
X-Gm-Message-State: AOJu0YxRFuyb2dwQ1LtQPT5IYoexzkabwN6ZM35OY8r6/s/9qOPcCw25
 v3YOktNZjepeUIMQ7I5eswrfbpmcogPokN2u+Tla5DtU+sYY3XJ7o7KB0G2/lfDgfA==
X-Gm-Gg: ASbGncu7ySrtwqaH8Q0h3JtvfjpzVbh++T8d4ErD6Y4LToUkLc1n+FZi5y3YuDSLjnr
 PGUhOVsoXBoPx6B8JbMpp4XBl5bw7fVGYgmzS3SjFwUp8dNDFeNCuqv6VJ3TT9NgM4cmv2ONzVG
 zip76DGYWhshzmzXhO0ScDAyDdOnlO+ufboaccjK358cmGmvHeUQeM0oewzG5JSsdYJHIuEgOH7
 KbEldqVZcTzJlw3ZN5+uoFOrSZ7RShwnS9U27vpBZfnS+31icSm7TATZ62JZs8TM80treFkHK5e
 WRLCc7Kbia6y1cK/Os3aLgI4/hULkUizVrrtZbeao2THSBxnu50c+DPapsPysxiVocdfFN/d/c2
 o2z+jGIFNi7UQrKWNU0OWAiTEriQGucrgK48URvb1IqGegb0z/TkssG8ifsKbxbftF9RL/yD9OP
 /jsfIXi7qK6aQF2UoDzu5+nPflLgOd
X-Google-Smtp-Source: AGHT+IGGoawit6m+BrMT9at+eJDq/KotWTZ1y6Ysj/r8SJUxdpbVUX1XS9Szj9kDnRcR3eTLBj1GAg==
X-Received: by 2002:a17:907:6d16:b0:b76:ed25:b7f9 with SMTP id
 a640c23a62f3a-b79c233e04amr233779366b.20.1764682540131; 
 Tue, 02 Dec 2025 05:35:40 -0800 (PST)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59a63dfsm1476455966b.37.2025.12.02.05.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 05:35:39 -0800 (PST)
Message-ID: <a0a0f3cd-2e13-416a-915d-12586b5556ee@monstr.eu>
Date: Tue, 2 Dec 2025 14:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to boot u-boot from embedded ELF file in Microblaze core
To: =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro@linenoise.info>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
 <139d4052ed5e16f7de90ad681d032282f0bc74ad.camel@linenoise.info>
 <52b477fa-6d3f-486e-ab77-9b2d682973df@monstr.eu>
 <5e9c5be65bf1d40e749ae0e88e69ca786681865b.camel@linenoise.info>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <5e9c5be65bf1d40e749ae0e88e69ca786681865b.camel@linenoise.info>
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



On 12/2/25 12:07, Álvaro G. M. wrote:
> Hi
> 
> On Fri, 2025-11-28 at 08:23 +0100, Michal Simek wrote:
>>>
>>> I still haven't been able to solve this. Why is this value invalid? And which
>>> value should I put there to embed u-boot.elf into the microblaze boot memory?
>>
>> Because you need early stack pointer which is allocated in front of u-boot
>> itself at start. It means you need at least small space there.
>> U-Boot is going to be relocated to the end of memory anyway that's why it
>> shouldn't really matter that TEXT base is not aligned with DDR start.
> 
> Right, so if I were to run this from embedded BRAM, should I set
> CONFIG_TEXT_BASE to something slightly above 0 as well?
> 

How big is your bram?

Obviously never thought to have full u-boot in bram because bram sizes were 
small that's why never really wanted to allocated bram just for bootloader itself.
Another thing is that normally MB has reset address at 0 where reset vectors are.
And full u-boot is also setting up these vectors that's why you even don't want 
to have full u-boot to start from 0 but from any offset to have location for 
reset vectors.


> 
>> This is recreated file from binary. The best is to run make V=1 u-boot.elf
>>
>> Then you will see
>>     microblazeel-xilinx-linux-gnu-objcopy --gap-fill=0xff  -O binary   u-boot
>> u-boot-nodtb.bin && {  echo '  tools/relocate-rela  '; tools/relocate-rela
>> u-boot-nodtb.bin u-boot; } || { rm -f u-boot-nodtb.bin; false; }
>>     tools/relocate-rela
>>     cp u-boot-nodtb.bin u-boot.bin
>> microblazeel-xilinx-linux-gnu-objcopy -I binary -B microblaze  -O
>> elf32-microblaze u-boot.bin u-boot-elf.o
>>     microblazeel-xilinx-linux-gnu-ld u-boot-elf.o -o u-boot.elf -EB -T
>> u-boot-elf.lds --defsym="_start"=0x29000000 -Ttext=0x29000000
>>
>> Which is showing you what files are used.
>>
>> For you the best option is to use CONFIG_OF_EMBED=y which includes DTB directly
>> in binary that you don't need to deal with it.
> 
> That's what I did, but as I understand from those lines above, original binary
> does not include the DTS, right? That's why I get the fdtdec_setup() failed
> message.

with OF_EMBED dt is present in both files but relocation section is not filled 
by proper data.

>> Regarding sizes and location. I didn't try to put u-boot to BRAM but I can't see
>> any reason why you can't do it.
>> Overall binary size is all the time question what exactly you want to do with it.
>> SPL is another option but I didn't try it for a while but should be enabled.
> 
> Yeah, it looks like the u-boot.elf code region is bigger than my current
> bootloader (one based on the s-rec example), so it seems like it won't fit on my
> design. I will try SPL, which I'm sure will open a different can of worms  :)

SPL on microblaze is around but not really used (maybe never used in any 
product) because Xilinx was using fsboot instead. I think this could be solution 
for you too.


>> Keep in your mind that full relocation is enabled that's why you u-boot itself
>> is finding out where it runs and then update sections. Based on your loading
>> address you can in xsdb remap symbols to see them by:
>>
>> memmap -file u-boot -reloc $reloc_addr
>>
>> Keep in mind that Microblaze is pretty much EOL and for new designs you should
>> focus on Microblaze V(risc-v compatible version).
>>
> 
> Yes, thank you. I'm trying to upgrade an old design from 2016 because we've just
> built a new version of the board with a new mtd (mt25ql02g replacing mt25ql128),
> but it seems like Linux leaves the MTD configured in a mode our current
> bootloader (the s-record based one) isn't able to work with, so resetting the
> board leaves it unable to reload Linux kernel from flash. u-boot however is able
> to sf read data from the flash regardless of the status Linux left it with, so
> that's why I wanted to port u-boot to this semi-old design.
> 
> I'm facing however other problems related with this flash, as it seems that
> Linux is unable to write to it. But also, Vivado 2025.1 isn't quite capable of
> writing to my old mt25ql128, which I was able to do so with Vivado versions 2016
> through 2018 (I just posted about this on AMD/Vivado forums), so we are
> considering undoing this MTD change because it was intended as future-proofing
> for bigger software designs, but it seem like it isn't worth the effort for us
> right now.

I haven't really spent my time on SPI to help you on this. But you are using axi 
spi/qspi which shouldn't be that problematic. Lowering frequency or mode 
limitation can solve the problem.

Thanks,
Michal
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

