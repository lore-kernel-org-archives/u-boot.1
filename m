Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B3FC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A965878FF;
	Mon, 23 Oct 2023 15:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BwylOtNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2E1878F8; Mon, 23 Oct 2023 15:04:34 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05925878FB
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso27057935e9.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698066271; x=1698671071; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSbuhBbmdQ1Vjait/bSI+h4/cB77oNAhLwkMAk9g0mc=;
 b=BwylOtNu0ijXOOP/44BqIy5OtDSmISzc40FPODufIa4WJh91V7MCsZBQqQWLt8lh3M
 uio3fkuOaa9eHgEStAl0IePlOb/Ez/TKpa+PeVDMDQNOlDdx+mcmKqqsPQ6Pt2f3Idoz
 0gyNICtAj0H5UwtmrXOlTAGkPQTCwKw4RXEEseaaaeJWnQUFhwblm1XX5ltA8ItdiEZ2
 2mrOM31R8xcoLzKsm7Wugl47kSJBDoq4ZYh8BXS39aI2kjWHOODhRN/fDx4yiJvkR/68
 Cv4/0KR0nAylzGyFwBUfQWtSp3HhsXb60SwV4RZQeNGnEs3+wnJvh2a/un8JhWgRDEGR
 egNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698066271; x=1698671071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSbuhBbmdQ1Vjait/bSI+h4/cB77oNAhLwkMAk9g0mc=;
 b=X9FlWrCelBVIRRcSME856fIPVkitpB6ysso+MRoGMmGZFzfjwJld/owfp+uTQaGa1S
 gzhEq0pn5fqQDsi4/EIPM9zXouu/b09XjMmYtMLDbjsxp8w7lLL4LLrXQ54zGDtrJqNY
 n1FGDOoTyr0grWilKg/zBQQjo61ln57OHWzHyh1u94cmg+/FPwlt13FVjwYKJhGN1GpC
 SY2lIark+oSutcIiYxBM5ChU+BuoUuXUlk85GnD0yjk5aZ83S4FJOmJY4MZ9fY1cYikS
 LTV4nim4XYARjNyh8+R5Oqp5k8JJoDXH3pTwH2f9uOTo+NzRMpRwbkr/Cm06Qe3y29Y2
 NeWw==
X-Gm-Message-State: AOJu0YyS8HTM2JFjq43EXFyyZpJQ0qcMpTNsoKqh/25rQz9dDPFl67UF
 wJACgkNgFcdxEnAgiVOAx777Ug==
X-Google-Smtp-Source: AGHT+IHZjlAYEoPSUrCM75dWONYqgdOL1U7y6BexXtt9wZDD4ejOBdpDNlhAiPWK4px0fdT2qa0agQ==
X-Received: by 2002:a05:600c:19c8:b0:408:cd96:7164 with SMTP id
 u8-20020a05600c19c800b00408cd967164mr3551372wmq.9.1698066270861; 
 Mon, 23 Oct 2023 06:04:30 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b003fefb94ccc9sm9463792wms.11.2023.10.23.06.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 06:04:30 -0700 (PDT)
Message-ID: <dcefcaf4-aa74-420f-b323-841bf7024ea8@linaro.org>
Date: Mon, 23 Oct 2023 14:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
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



On 23/10/2023 08:04, Simon Glass wrote:
> Hi Caleb,
> 
> On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 21/10/2023 01:45, Simon Glass wrote:
>>> U-Boot typically sets up its malloc() pool near the top of memory. On
>>> ARM64 systems this can result in an SMBIOS table above 4GB which is
>>> not supported by SMBIOSv2.
>>>
>>> Work around this problem by providing a new option to choose an address
>>> just below 4GB, if needed.
>> I may well be missing something here, but I don't quite understand the
>> justification behind the original patch [1] which caused this regression.
>>
>> I'm currently preparing support for a few different Qualcomm boards
>> which have different memory layouts, so far it's been possible to avoid
>> having any fixed addresses, so the same u-boot image can be used on all
>> of them (with just a different DTB).
> 
> What sort of memory layout do you have? I could enhance the patch to
> find the top of a memory bank below 4GB, perhaps? E.g. see the
> 'bdinfo' command.

I think that would probably be sensible (afaict this is more of less
what the EFI function did).

One of my boards has RAM starting at 0x40000000 and ending at
0xC0000000, frustratingly not quite managing to use the entire 4G
address space. There is also a hole in RAM, so u-boot relocates itself
to the end of the first memory bank

=> bdinfo
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000040000000
-> size     = 0x000000003eb00000
DRAM bank   = 0x0000000000000001
-> start    = 0x0000000080000000
-> size     = 0x0000000040000000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 115200 bps
relocaddr   = 0x000000007ea12000
reloc off   = 0x000000007ea12000
Build       = 64-bit
fdt_blob    = 0x000000007e5ec5c0
new_fdt     = 0x000000007e5ec5c0
fdt_size    = 0x0000000000006780
lmb_dump_all:
 memory.cnt = 0x2 / max = 0x40
 memory[0]	[0x40000000-0x7eafffff], 0x3eb00000 bytes flags: 0
 memory[1]	[0x80000000-0xbfffffff], 0x40000000 bytes flags: 0
 reserved.cnt = 0x8 / max = 0x40
 reserved[0]	[0x45700000-0x45cfffff], 0x00600000 bytes flags: 4
 reserved[1]	[0x45e00000-0x45f3ffff], 0x00140000 bytes flags: 4
 reserved[2]	[0x45fff000-0x461fffff], 0x00201000 bytes flags: 4
 reserved[3]	[0x4ab00000-0x53616fff], 0x08b17000 bytes flags: 4
 reserved[4]	[0x5c000000-0x5cffffff], 0x01000000 bytes flags: 4
 reserved[5]	[0x60000000-0x638fffff], 0x03900000 bytes flags: 4
 reserved[6]	[0x7d5e8000-0x7eafffff], 0x01518000 bytes flags: 0
 reserved[7]	[0x89b01000-0x89d00fff], 0x00200000 bytes flags: 4
> 
>>
>> As I mentioned before, efi_allocate_pages() seems to work fine from
>> install_smbios_table(), I haven't delved into the code too much but I
>> wonder if this could be an acceptable solution?
> 
> Unfortunately that function is EFI-specific. The function can only be
> called once EFI is inited. We only want to do that if booting with
> EFI.
> 
> The tables are written at the start of U-Boot, partly because that is
> how it is done on x86 and partly so the 'acpi' command actually works.
> 
> The EFI code ended up writing a separate set of tables, which is of
> course not correct.
> 
> I did look at creating an API in U-Boot to alloc memory below 4GB but
> then decided that for just this one use case it might not be worth it.

The LMB allocator can already do this with lmb_alloc_base(), would this
be an ok solution?

I have tested it and it seems to work as intended, allocating the first
free 32-bit address, and avoiding reserved regions.

It seems like the LMB allocator doesn't have a global pool, so I'm not
sure how it avoids conflicts, although maybe that just isn't really an
issue in reality.
> 
>>
>> Barring that, could we use an environment variable to pass this address
>> in? Although I think that might not be a very desirable solution.
>>
>> I appreciate you taking the time to prepare this patch and CC me. If
>> nobody else objects to this patch then I'd prefer to avoid blocking it.
>> In either case, I'd greatly appreciate any input on the above
>> suggestions so that I can implement a solution for my boards.
> 
> I would like it to be automatic. I assumed on ARM64 that there is
> memory available at 3.99GB if U-Boot has relocated to above 4GB, but
> as above I could make this more clever.
> 
> Regards,
> Simon
> 
> 
>>
>> Thanks and regards,
>>
>> [1]:
>> https://lore.kernel.org/u-boot/20230920030027.1385833-16-sjg@chromium.org/
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>   lib/Kconfig                 | 17 +++++++++++++++++
>>>   lib/efi_loader/efi_smbios.c | 12 ++++++++++++
>>>   2 files changed, 29 insertions(+)
>>>
>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index f6ca559897e7..a77f2f3e9089 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -994,6 +994,23 @@ config GENERATE_SMBIOS_TABLE
>>>         See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
>>>         the devicetree.
>>>
>>> +config SMBIOS_TABLE_FIXED
>>> +     bool "Place the SMBIOS table at a special address"
>>> +     depends on GENERATE_SMBIOS_TABLE && ARM64 && SMBIOS && EFI_LOADER
>>> +     default y
>>> +     help
>>> +       Use this option to place the SMBIOS table at a fixed address.
>>> +
>>> +       U-Boot typically sets up its malloc() pool near the top of memory. On
>>> +       ARM64 systems this can result in an SMBIOS table above 4GB which is
>>> +       not supported by SMBIOSv2. This option works around this problem by
>>> +       chosing an address just below 4GB, if needed.
>>> +
>>> +config SMBIOS_TABLE_FIXED_ADDR
>>> +     hex "Fixed address for use for SMBIOS table"
>>> +     depends on SMBIOS_TABLE_FIXED
>>> +     default 0xffff0000
>>> +
>>>   endmenu
>>>
>>>   config LIB_RATIONAL
>>> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
>>> index 48446f654d9b..84ea027ea48c 100644
>>> --- a/lib/efi_loader/efi_smbios.c
>>> +++ b/lib/efi_loader/efi_smbios.c
>>> @@ -61,6 +61,18 @@ static int install_smbios_table(void)
>>>               return log_msg_ret("mem", -ENOMEM);
>>>
>>>       addr = map_to_sysmem(buf);
>>> +
>>> +     /*
>>> +      * Deal with a fixed address if needed. For simplicity we assume that
>>> +      * the SMBIOS-table size is <64KB and that the malloc region does not
>>> +      * straddle the 4GB boundary.
>>> +      */
>>> +     if (IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED) && addr >= SZ_4G - SZ_64K) {
>>> +             addr = IF_ENABLED_INT(CONFIG_SMBIOS_TABLE_FIXED,
>>> +                                   CONFIG_SMBIOS_TABLE_FIXED_ADDR);
>>> +             log_warning("Forcing SMBIOS table to address %lx\n", addr);
>>> +     }
>>> +
>>>       if (!write_smbios_table(addr)) {
>>>               log_err("Failed to write SMBIOS table\n");
>>>               return log_msg_ret("smbios", -EINVAL);
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
