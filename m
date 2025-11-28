Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F11D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 07:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE8083B9B;
	Fri, 28 Nov 2025 08:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="Zu12JU9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2E6842FE; Fri, 28 Nov 2025 08:24:00 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79DE83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b735487129fso224232666b.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 23:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1764314638; x=1764919438;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ec0roNInj0R0cEtiVOUKO94jDTVNzB77yw530Wq/+MU=;
 b=Zu12JU9jl2LbdipnHyp5+vmUjEvGJMrVTFJcMSbuMRSHmBcSLB4g6Hw7VW1KQSyz70
 7ldR4JrVY8rJ64qOgWxWIKdsriIfIg6FNbNNxRm0PaLTZrFDst7gyzHFKe06tb/5uhll
 IL2Ex3NUZlo87SeBElbD2a/5U9WzRexq/MowXXfeU8FBftolQtK5FBZbcUyJeXRfSggS
 FnLbDc4uSekUWAOrqW9IHiLbeVmPBw+lBCi2CoOcJxGi3zPfKjrTmDLY1ZWihNn64n4M
 ycBzHnoq8FADxnr6YM2C+Eu3EFwjAvh/lfiNuGcZs33ztAO8rMMK8AT1NENBi1njpe9E
 ZaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764314638; x=1764919438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ec0roNInj0R0cEtiVOUKO94jDTVNzB77yw530Wq/+MU=;
 b=cGs3dTDjYTvRAizRvJAOrTgmkLUCtohuwEFjC4IK+mCP6rRdqoWnR/0Zz+mlLFxx4q
 suifnE5rnnbCoF/0ubOaACEphnDC1Ol27v2vjZK9c5fv/6udVIjOpPiqDRRRs6iUWLi5
 qbGqhZGz538u0Y2FCbYUdW1TplUxAk1R/RJi0vwJOf3v1IHxDYNWoeVd+RFWyHIMGKMN
 p9xSGvZvEEf9P6gPaxZDmY5jrOwAtOZuyBxml8wYOEjSytZ7ByQ8IZli3LZNKYkhIhsq
 1JXfejLDGA+lauFiCFyaswzGmMIH+5+v2MjC+vU6iqABYXtZh7AOpMkQbM59fBW0g9j6
 /HLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo0vvcU4rChHCLc3NSUddBgYP6dufXlOdIQfpOsyvNRGfVgMlUPzrQqZmVsReds8nXa6UKZ7c=@lists.denx.de
X-Gm-Message-State: AOJu0YwAsWbNq+qJ+patcjPr0Tz3CVXaY3IIbfycUWWe9BToUORFl80T
 WADitVXesOzRIXoU5lTgZKUts8sgRs6yXI1Yl756vlVm6WPXiptCy1sNIO9G20l+2L72cpsY/uN
 K1cNSjg==
X-Gm-Gg: ASbGncu/eDNtGKVj1Q+/2TZ6EndXF55y8o1qYaR2H1pNzwaQZIF0b602b1CgcKdydfK
 geqyl5YpAJxqTAvMcCGaZe5awGXOB3EO99guxuu7pI75CRfC8+BJxtSv2ZWcj+b6QrjvLRKg9mQ
 Gp1C1kfOIIGMq0QUPACwcv2MgSKXYLfmCpE58CMGAvo+D081Wu6Is+TLNGTf6KwLHT76xAOdlgA
 LtQz2HYCJevwj5LHoifFkzrTnM7R6MG5yMePloU5KegXO7xc0EVoXDiIlgmTP6M1pzoMGwIk+Pn
 EfWdkXlpGhcF76fmmJZaxtctQguNBoyRE2XDbBIOuSxSZPRxbB01OgezYPJQXo9h2Bp3PmseNnY
 5MIznUijwpMKeYlVORvjhO9QFlMgw+WGzLIDVXzyCKofuA01+sqFlMrxOF8lMcDb9V1VDup3iCJ
 ScAdgUANCNqNkK
X-Google-Smtp-Source: AGHT+IH9UKunAe7OARcSMbgAHAsa/GZP0xaV9JQkZrhoYTPqBmyDTCWwchIMJpcxqqkRT1cv/ftxkQ==
X-Received: by 2002:a17:906:fe4c:b0:b76:694a:b0ca with SMTP id
 a640c23a62f3a-b76715ebba8mr2828648066b.27.1764314637839; 
 Thu, 27 Nov 2025 23:23:57 -0800 (PST)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a7afb4sm367009966b.70.2025.11.27.23.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 23:23:57 -0800 (PST)
Message-ID: <52b477fa-6d3f-486e-ab77-9b2d682973df@monstr.eu>
Date: Fri, 28 Nov 2025 08:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to boot u-boot from embedded ELF file in Microblaze core
To: =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro@linenoise.info>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <34fcf068f421f6d95d41271ef52400d7464d080e.camel@linenoise.info>
 <139d4052ed5e16f7de90ad681d032282f0bc74ad.camel@linenoise.info>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <139d4052ed5e16f7de90ad681d032282f0bc74ad.camel@linenoise.info>
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

Hi,

On 11/28/25 07:42, Álvaro G. M. wrote:
> Hi all,
> 
> I've been working a bit on this and now I have more doubts than before...
> 
> On Fri, 2025-11-14 at 11:30 +0100, Álvaro G. M. wrote:
>>
>> [...]
>> I can load this via xsdb and u-boot works and is capable of booting Linux
>> kernel. However, there are a couple of things I don't understand.
>>
>> First off, if I set CONFIG_TEXT_BASE=0x80000000 (the exact beginning of RAM), it
>> won't boot, not even early debug message will appear. Why is that?
>>
> 
> I still haven't been able to solve this. Why is this value invalid? And which
> value should I put there to embed u-boot.elf into the microblaze boot memory?

Because you need early stack pointer which is allocated in front of u-boot 
itself at start. It means you need at least small space there.
U-Boot is going to be relocated to the end of memory anyway that's why it 
shouldn't really matter that TEXT base is not aligned with DDR start.


> 
>> And the second thing, my endgame is to embed u-boot.elf into Microblaze itself,
>> so it acts as FSBL. I reduced the size to the maximum and I got a quite small
>> binary, even smaller than my current bootloader (the one from Xilinx that loads
>> an SREC image from flash), so there shouldn't be any issue from that part. To do
>> this, I set CONFIG_TEXT_BASE=0x0, but again, no early boot debug message
>> appears.
>>
>> I've tried different values for CONFIG_TEXT_BASE in this case, but none of them
>> will work. Also, in either case, I'm not sure why, but I can't debug step by
>> step via xsdb, I won't see what ASM or C code matches with current PC address.
>> However, SPL will let me run it step by step via xsdb.
>>
> 
> I've discovered that I can launch u-boot file with xsdb and debug step by step
> via xsdb. But this file won't boot up properly, because somehow it seems to be
> missing the DT? But the file is bigger than u-boot.elf. If I load u-boot.elf, I
> get uboot console and am able to use sf probe and sf read to launch the kernel.
> But this file is smaller and I can't debug it step by step. So I don't really
> understand anything.
> 
> $ ls -al u-boot{,.elf}
> -rwxr-xr-x 1 sslayer sslayer 1882032 Nov 27 10:06 u-boot

this is file with all symbols

> -rwxr-xr-x 1 sslayer sslayer  215224 Nov 27 10:06 u-boot.elf

This is recreated file from binary. The best is to run make V=1 u-boot.elf

Then you will see
   microblazeel-xilinx-linux-gnu-objcopy --gap-fill=0xff  -O binary   u-boot 
u-boot-nodtb.bin && {  echo '  tools/relocate-rela  '; tools/relocate-rela 
u-boot-nodtb.bin u-boot; } || { rm -f u-boot-nodtb.bin; false; }
   tools/relocate-rela
   cp u-boot-nodtb.bin u-boot.bin
microblazeel-xilinx-linux-gnu-objcopy -I binary -B microblaze  -O 
elf32-microblaze u-boot.bin u-boot-elf.o
   microblazeel-xilinx-linux-gnu-ld u-boot-elf.o -o u-boot.elf -EB -T 
u-boot-elf.lds --defsym="_start"=0x29000000 -Ttext=0x29000000

Which is showing you what files are used.

For you the best option is to use CONFIG_OF_EMBED=y which includes DTB directly 
in binary that you don't need to deal with it.

Regarding sizes and location. I didn't try to put u-boot to BRAM but I can't see 
any reason why you can't do it.
Overall binary size is all the time question what exactly you want to do with it.
SPL is another option but I didn't try it for a while but should be enabled.

Keep in your mind that full relocation is enabled that's why you u-boot itself 
is finding out where it runs and then update sections. Based on your loading 
address you can in xsdb remap symbols to see them by:

memmap -file u-boot -reloc $reloc_addr

Keep in mind that Microblaze is pretty much EOL and for new designs you should 
focus on Microblaze V(risc-v compatible version).

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

