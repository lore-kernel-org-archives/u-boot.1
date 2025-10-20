Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07385CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 09:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5C482C84;
	Mon, 20 Oct 2025 11:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z+IzRsnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5706882E34; Mon, 20 Oct 2025 11:34:28 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34C8807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 408753F2A9
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760952865;
 bh=n4+EFzErswSZzdaHU1q8hN9Tbgyd8D0fi/GcdveFpzU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Z+IzRsnLvtZnl2amg3FzLvbhJu4XFKsnF5w3xJZ+32XXQt7hqU4VR6Pml4YQ7eDSN
 ZSI0UgpIyx2XHX6zxA7VqAb8zY0QRhrx4m+826nAKvJoDQ7Aui9TiXt0Hw/GEawDd/
 bfJae25IKbT3po1XlMJ/1pmZPP+YSLf9kgNWz2HJRGrjFQI6CSOxvmoRTnJLm1Im1j
 6xVD2q3fJndExLwgR6/+E+o96k1x/J4aGaojhg3Vdty8LL489PDvByNqdoZDKpu/ta
 kMlqluITu+m9kGAW+OB58bFNS+zMSZ+uEjlwghQT0QuBOlyJLw/szJW6nctVUxjBv/
 aEtlN/FhEP3zlE0EpYyv9Vj8OYXyw2yjQDjU74VSCXD3KE3ED7Y4V/E019N1JK7F/c
 ez8Yjl3Q1TtT1AMV+kinXmjDx5/SRrSggm6xvPhSIzcuF5EnMhla9HQU0TQqPEV+Hw
 m3zHDSJRyDim/5Fj9KfawY0GLBNJ5xbO0jgOzov3vfOCgfo1OfQJ8XYHd5FhylqjVI
 f1KecWiX30eOan4OfISKOHyBkv+qoVd3CPiYEaOS32GpHVq41taxEC2NiPIouYJAIW
 T+2BHCMV++jSD/hCAplgyhCIYE9xumBBnpqqnkO7ELFZFxEuAOcu9j9ANFHTVwSAVU
 yS504AXFiBZaFCNnwriUz/oc=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso49862515e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760952864; x=1761557664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4+EFzErswSZzdaHU1q8hN9Tbgyd8D0fi/GcdveFpzU=;
 b=nC6gEUBijmiqjvumHEtxLMFvGbn4YFJJi3IGIMtyiTMipXBYJNb4SxvgkKpDGMII9v
 96YdOL2gbrtQ73Tb+2JZli5WX8GeQ3YO8Nanzf0CuFQU8yUZoaIgFwXica5DJKRorKjp
 qX5dMJZA8W3zfRXCK/tlSeV1U86/C5eAWmvs6NixscxvzsE9zbGWmUvFqX5m23mee+vH
 vWx81FLhKAUlhxEFsgYX8cAvhM+lC2nY4QW0HT8onqirQT+I89WBz5L4miWTqh/iXWZr
 PgunEHB+Q/232ABippQx7vFGNmo6uMffnJ0zQY49w4/7gRBGiUXH7OeE+mS/nVa2+RD4
 pqTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsxVv0JVsEv/Dpjho65WSOjYcTbp7EC64a6C6hvbnWd/92Cthcvf1T/0BsceHYXUcSX2XMojY=@lists.denx.de
X-Gm-Message-State: AOJu0YzcBpuvPvwu+fljVeMEIs2+FtfeXLlVSlTclFvI+YxvKdy9y101
 ho4Ji6Hg1RaMvxTIY/evHTLzDbqm7KaX2QZzhdH006UtwNS/LPnrlZ+fGT37/WG1203Jg1CVX05
 L8Z0QnZan7x+nuUKYQWry6gpp4anXDH7asD3Qsi0/fHp+4dKMXF4URHU+db+cjJ+uStSqq1o=
X-Gm-Gg: ASbGncvggCGuJntc6XjlrFZiWUGHZD8zufGRfb9tLyY6hLOK0KqMMJimh6DsyqQw3BF
 WNFymzmzDox9RutG1fFj8bIYe8CvYCsQ+pOliNLuV3ftZqUFTKP+LKovvRXjlhNLIBQ4DSrFxXo
 Sv9+He/AaGLgvoxYrWU2vLqHZTnebzrWdkwzXXlCrhETZGhUkmWcd3pSE5172HdFxJDtbmh04q4
 59v3j9JpGvZumo4JKPCJ5lu0SLhu0cDMpglEJnUBCL9jAfr/cGOY78HvtDvQ9arS84DJFMqROWG
 ICrLHpm4nJO4njdFGvh7a/q7jmEJxTX/uJczOemmvSidwnmwMFDfWVmtV7kKEXqbbPB9x4oQmdm
 2VUn4ISxsKjpriD3cDkfUMrMPgrLgWYMPKC+ne6e8uK6/EWC1N6KlBZ00ptWU7x8pqVFrZqUf
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4711791c5dfmr101651055e9.30.1760952864574; 
 Mon, 20 Oct 2025 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgkABfAkXpBZeRbRsU/dQHGteCCmNQEMOs2CDVbo3pgkMBz0ALjh/pMnuL/SEc1jfcO07aZQ==
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4711791c5dfmr101650755e9.30.1760952864051; 
 Mon, 20 Oct 2025 02:34:24 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144238easm226835345e9.4.2025.10.20.02.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 02:34:23 -0700 (PDT)
Message-ID: <65c84cfa-4cbc-4dcd-aad2-b95483322913@canonical.com>
Date: Mon, 20 Oct 2025 11:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
To: Yao Zi <ziyao@disroot.org>
Cc: Simon Glass <sjg@chromium.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
 <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com> <aPGc12v2H5sCZNMi@pie>
 <aPX80KCYCvnDRIgM@pie>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aPX80KCYCvnDRIgM@pie>
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

On 10/20/25 11:13, Yao Zi wrote:
> On Fri, Oct 17, 2025 at 01:33:11AM +0000, Yao Zi wrote:
>> On Thu, Oct 16, 2025 at 07:04:48PM +0200, Heinrich Schuchardt wrote:
>>> On 10/16/25 18:58, Heinrich Schuchardt wrote:
>>>> Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
>>>> synchronization in start.S") changed the hart synchronization in start.S.
>>>> It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
>>>> use. If the macro evaluates to true the old behavior is maintained.
>>>>
>>>> The macro evaluates to false for SPL builds which was unintended. Use
>>>> IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.
>>>>
>>>> This fixes a boot failure on StarFive JH7110 based boards.
>>>>
>>>> Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
>>>> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>
>> Hi Heinrich,
>>
>> Thanks for sending the patch!
>>
>>>
>>> Hello Yao,
>>>
>>> It would be worthwhile to understand why your new method does not work on
>>> the StarFive VisionFive 2. I only addressed the Kconfig issue. But I suspect
>>> there is something broken in the alternative pass.
>>
>> A possible reason is that, on JH7110 not all the cores support LR/SC
>> instructions: the S7 small core always raises access exception for it
>> since the implementation of LR/SC requires data cache to present, while
>> S7 doesn't have one.
>>
>> This is documented in SiFive U74-MC Core Complex Manual,
>>
>>> Load-reserved (LR) and store-conditional (SC) instructions are special
>>> atomic instructions that are only supported in data cacheable regions.
>>> As the S7 core does not have a data cache, the LR and SC instructions
>>> will always generate a precise access exception.[1]
>>
>> As S7 also takes part in the initial HART lottery, usage of LR/SC
>> instructions might just crash its boot process with exception.
>>
>> However I could only confirm the idea days later when I have access to
>> a JH7110 board. Since earlier Tom has merged the patch[2] that reverts
>> the problematic commit, do you think it's better to wait for me to
>> confirm the cause and write v3 of the patch, instead of fixing it up
>> now? I'll carry your Co-developed-by tag in v3 if you're okay with this.
> 
> Hi Heinrich,
> 
> I finally got a JH7110 board on hand and could find out what happens
> here. As stated in the U74-MC Core Complex Manual,
> 
>>> Load-reserved (LR) and store-conditional (SC) instructions are special
>>> atomic instructions that are only supported in data cacheable regions.
>>> As the S7 core does not have a data cache, the LR and SC instructions
>>> will always generate a precise access exception.[1]
> 
> This is correct, and with my patch the S7 core does trigger an
> exception when doing LR/SC stuff, but this alone isn't enough to break
> the whole SPL booting process up without even a banner shown up.
> 
> With some hand-written assembly added, I found that not only the S7
> core, but also the four U74 cores are trapped in exceptions as well.
> This is because U-Boot SPL, including the available_harts_lock variable,
> is loaded in 0x8000000, as pointed out by CONFIG_SPL_TEXT_BASE and
> spl/u-boot-spl.sym. According to StarFive JH7110's manual[3], the region
> is mapped to the L2 Loosely-Integrated Memory.
> 
> And the U74-MC Core Complex Manual again points out,
> 
>> When cache ways are disabled, they are addressable in the L2
>> Loosely-Integrated Memory (L2 LIM) address space as described in the
>> U74-MC Core Complex memory map in Section 5.2. The L2 LIM is an
>> uncacheable port into unused L2 SRAM and provides deterministic
>> access time.
> 
> The L2 LIM region is uncachable, too. Since U74 and S7 could only
> perform LR/SC instructions in cachable regions, the new LR/SC
> implementation will always trigger an Load Access Fault exception, thus
> doesn't work for JH7110.
> 
> Another simple patch[4] could confirm this, which just adds a simple
> load-reserved operation on available_harts_lock in
> arch/riscv/cpu/start.S, but still hangs the boot process on JH7110.
> 
> I've reviewed v2 of my patch again, and think besides the usage of
> CONFIG_IS_ENALBED() which you just pointed out, there should be no logic
> error. I'll probably send v3 of the patch carrying your fix along with
> a new patch to explicitly disable RISCV_ISA_ZALRSC on JH7110 platforms,
> 
> Thanks again for sending the fix.
> 
> Best regards,
> Yao Zi

Thank you for investigating

+CC Hal, Minda as JH7110 maintainers

Best regards

Heinrich

> 
>>> Best regards
>>>
>>> Heinrich
>>
>> Best regards,
>> Yao Zi
>>
>> [1]: https://starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf
>> (Chapter 3.6, Atomic Memory Operations)
>> [2]: https://lore.kernel.org/u-boot/176063629917.212270.1145034876136991424.b4-ty@konsulko.com/
> 
> [3]: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/u74_memory_map.html
> [4]: https://gist.github.com/ziyao233/75fc0e40956a19e4383ab360dd06c784

