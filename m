Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E736CC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E22808E6;
	Thu,  6 Feb 2025 11:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oJnuKR25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64215807F1; Thu,  6 Feb 2025 11:39:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEEB807D7
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 11:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738838344; x=1739443144; i=xypron.glpk@gmx.de;
 bh=tIQJDCnjtzuTpZ+nHWF2OZzUmlsRZ5k7YOWeTsOLbbg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oJnuKR25YPQcB65JvLB5Uhk0khNijZkPM7C5HNJw985hQTJwVC0ZFFf8DeXiLL2R
 4lAL3gfjzSTd63AP+MPssVATS8O3kpcOZ77jyJdJs3jPnVeLaz69nTCQu+P8HRzIz
 ywRHEAk6ZCNC/WBvFcFIjk4EzeMXaGpB8QDlvEwxHmvO6p8bjpBf+Gx2hR3+W61rt
 OUF5SEWr47CNZoWMsPIXFZmfPbl4Qw1p0DWCNhxgwz4nA112Ynee6qviz/ToTMwSY
 KdgDztNontihW2mnzYCAxK4GWdlMNRCyh+Fbf0tFwtldjQ5/5zUxcvi4wiGu8LVlK
 E7r62kZU+Q6NGWV+SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1th6HT3KBg-00BM1S; Thu, 06
 Feb 2025 11:39:03 +0100
Message-ID: <a4eddb23-526f-4f45-9c65-f592bdbf947a@gmx.de>
Date: Thu, 6 Feb 2025 11:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 trini@konsulko.com
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAC_iWjLwGnWYRPUvETp1ASar7eUvbZkrtpnzt5U7FT_dgsH_3w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLwGnWYRPUvETp1ASar7eUvbZkrtpnzt5U7FT_dgsH_3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUz/KgcXw5vkQsZ2y7Ue5viY2KoBVZp3jkKnozbTv71PTEBEu/v
 lQFmVHPGvVXVQ5LvzasdXh+kHD0MzIepufj99A48Fd695rd59+Y8cPQleXyiOx/ews6cGgx
 SkG4rXM2Fq01gs4ZH9ZyFMnCK4/+1pln5l1U2VpMVgTei7tx9FY6pWd96nqG5MCgP8PcIiC
 592BPWi7Z+JWJVybOhKcg==
UI-OutboundReport: notjunk:1;M01:P0:A5tXqdh3plQ=;FWA+k0IbrazwLzZEWGO+D8NSeiY
 ImGCGZLk6Eoa/Z1cTdIcMx7Vz23YO3pZvDtjsro9tQ5rhEJwm9+1bPDPXNkpCa94/f1EaZC4i
 I6r9OzPyhLBeRzHir0ix4IPeH6h0sU5RsGyMZf7CjvBeL37P5cFkJ9AasgU7sIR2rwhwUQT2e
 3/CZo280/9rd73WeS+uuqcjWgBYyp/qbabKjvl9NLPE7LsfKhjZQeE+LG/FA6e+/x8QE1joyZ
 BF1Jmog7pQ/LnVYWBBodP/oRMkGXcn0oyhGpVBmB5u9UpxiRb/v7R9u8YvqnI2xKlwO8oWGcp
 AuwfxA5Ae4Zo7GzWtYLkk3dhWVRRSi9QXGPOwzitoxhJktuSKcqBeWgU6NNaBMYzF3XsUFr2e
 1qHWFKRUt46J3uj5LZjlItMjkQSNMpaZJHpI7T0AdVFs1HC+ujfFjHgbWuPBPUDvRr465Hvs7
 dKdaGa74boy9azSch5ikXDvue6KCdttV+HruxpuWkSU1wssgH9Ok2Xfhj3U9yXW3D4CYTiQGD
 PppoDNCSzbooWxcn3oX4ausDOzJb6Ew2mZr07CWMb3jaKy5XXyV/0eLC9V5E1Oj4Fb+Ic28KU
 Oafk2N1tUfzILYZNuhexlaa3jmw/hMCqMd/ri4lXfVPr0tiZPfVOCfffi6/iZmGXczPhPK9Fp
 OwBNDww+ijqA9khqo6hDOoSWYcte82M3HiD0b6uSbp1Hw+LpGv9QIZgV3x9w260+QGhIi4Mm9
 4Ac8gXio+oYAnrujmvxxXe/CESwr+7//8HmX2YoaanF6H7GfTLfr31zsKSe6FreSFP/FPNlFz
 R6TglwEAMeH/33MtK4GHPwJsWo/MShz78OA8rf+eTTROMuqzfIpzR1YrgKPRi/eb4IPKiBNEw
 RvGGggGhQfFM5kFNjG2NNYsu5fd091QTRA5cJ7LDewCOW5TGsXt7d8EKdwB19I1MpJt6eDGwn
 LSJAAxFy7j73MAuq0eUCSY/QtCrvt7X9Qz0w4a6Bo3qFzJGbboomJDko4bKjVrTEoEG+UbpeP
 oXy+DNtEjbgA5jMn+ZG75KlfhOgc24eYPRQGe3nZ58cFITu6faiK2fEUqS4MqB/STmsX6pyiQ
 32gR8abpkoBF7v6h2ciw/SSnS2HrV0lVy7q74fpJRwgsQH6exe0f6dxRLHmcJRtuLF7YmLCcc
 YoY67hNgGF9SZF92DtK/hn+m+m5AaoOrGDKIS05ndciYFF589uB+zIZsRf7b0e3UZq+IwtURz
 S8+tBq12PLsVOvRFunEv89p7AKBq41ZZM7ZE/xt8o8Zj0iIPlZbu3PeuEmb+lA/kd4ihUCfsK
 1BaWm6NmwxEsObc5cQ6CiCazU10PHFeSFC3KdTSFExqwhBaGJQpu1WmmgBvCA7wW3U+re7r3k
 76qHfkPV74HtmC7BEAgaPRS38ze47G1CJo0wPpg0iHJyVu6Kis6s4GFIC5
X-Mailman-Approved-At: Thu, 06 Feb 2025 11:41:33 +0100
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

On 2/6/25 10:42, Ilias Apalodimas wrote:
> Hi Heinrich,
>
> [...]
>
>>>> +++ b/arch/arm/lib/cache.c
>>>> @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
>>>>
>>>>        return 0;
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>
>>> I would prefer if the weak function would return -ENOSYS indicating th=
e
>>> missing implementation and the real function would return 0 in case of
>>> success or an error code on failure. This way the EFI protocol could s=
et
>>> the return code if the architecture does not provide support for setti=
ng
>>> the attributes the passed addresses are invalid.
>>
>> Sure I'll change that in v2
>
> Okay, I had a look at EFI_MEMORY_ATTRIBUTE_PROTOCOL.SetMemoryAttributes.
> This function does not support EFI_UNSUPPORTED if you don't have code
> around to set the PTEs.

37.7.1.2 "EFI_MEMORY_ATTRIBUTE_PROTOCOL.SetMemoryAttributes" in UEFI
spec 2.11 lists EFI_UNSUPPORTED:

EFI_UNSUPPORTED
The processor does not support one or more bytes of the memory resource
range specified by BaseAddress and Length. The bit mask of attributes
is not supported for the memory resource range specified by BaseAddress
and Length

>
> So, I think we should
> - make the prototype an int and return an error
> - add a new bool *supported argument? And if the caller calls the functi=
on
> with base & size =3D=3D 0, set that value?
> That way we can choose not to install the protocol at all if the
> functionality doesn't exist.

Yes, it would help to be able to detect if the architecture specific
implementation exists.

Best regards

Heinrich

>
> Thanks
> /Ilias
>>
>> Cheers
>> /Ilias
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>> diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
>>>> index 370ad40f1423..b275646384a5 100644
>>>> --- a/arch/m68k/lib/cache.c
>>>> +++ b/arch/m68k/lib/cache.c
>>>> @@ -151,3 +151,5 @@ __weak void flush_dcache_range(unsigned long star=
t, unsigned long stop)
>>>>    {
>>>>        /* An empty stub, real implementation should be in platform co=
de */
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>> diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
>>>> index 8f543f2a2f26..7a93a8fcc6a7 100644
>>>> --- a/arch/nios2/lib/cache.c
>>>> +++ b/arch/nios2/lib/cache.c
>>>> @@ -127,3 +127,5 @@ void dcache_disable(void)
>>>>    {
>>>>        flush_dcache_all();
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>> diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
>>>> index a9cd7b8d30ac..3d0536caccde 100644
>>>> --- a/arch/powerpc/lib/cache.c
>>>> +++ b/arch/powerpc/lib/cache.c
>>>> @@ -58,3 +58,5 @@ void invalidate_icache_all(void)
>>>>    {
>>>>        puts("No arch specific invalidate_icache_all available!\n");
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>> diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
>>>> index 71e4937ab542..1c751e562157 100644
>>>> --- a/arch/riscv/lib/cache.c
>>>> +++ b/arch/riscv/lib/cache.c
>>>> @@ -151,3 +151,5 @@ __weak void enable_caches(void)
>>>>        if (!zicbom_block_size)
>>>>                log_debug("Zicbom not initialized.\n");
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
>>>> index 99acc5999652..22e0f1484a33 100644
>>>> --- a/arch/sh/cpu/sh4/cache.c
>>>> +++ b/arch/sh/cpu/sh4/cache.c
>>>> @@ -126,3 +126,5 @@ int dcache_status(void)
>>>>    {
>>>>        return 0;
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>> diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
>>>> index e6a7f6827fc2..aacc2d2627d6 100644
>>>> --- a/arch/xtensa/lib/cache.c
>>>> +++ b/arch/xtensa/lib/cache.c
>>>> @@ -57,3 +57,5 @@ void invalidate_icache_all(void)
>>>>    {
>>>>        __invalidate_icache_all();
>>>>    }
>>>> +
>>>> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm=
) {}
>>>> diff --git a/include/cpu_func.h b/include/cpu_func.h
>>>> index 7e81c4364a73..17b6d199302a 100644
>>>> --- a/include/cpu_func.h
>>>> +++ b/include/cpu_func.h
>>>> @@ -69,6 +69,22 @@ void flush_dcache_range(unsigned long start, unsig=
ned long stop);
>>>>    void invalidate_dcache_range(unsigned long start, unsigned long st=
op);
>>>>    void invalidate_dcache_all(void);
>>>>    void invalidate_icache_all(void);
>>>> +
>>>> +enum pgprot_attrs {
>>>> +     MMU_ATTR_RO,
>>>> +     MMU_ATTR_RX,
>>>> +     MMU_ATTR_RW,
>>>> +};
>>>> +
>>>> +/** pgprot_set_attrs() - Set page table permissions
>>>> + *
>>>> + * @addr: Physical address start
>>>> + * @size: size of memory to change
>>>> + * @perm: New permissions
>>>> + *
>>>> + **/
>>>> +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
>>>> +
>>>>    /**
>>>>     * noncached_init() - Initialize non-cached memory region
>>>>     *
>>>

