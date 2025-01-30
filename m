Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012B6C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F52B820F2;
	Thu, 30 Jan 2025 14:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DChh67p/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24819820E8; Thu, 30 Jan 2025 14:37:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184D382106
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738244205; x=1738849005; i=xypron.glpk@gmx.de;
 bh=AsKDoKMbNiBz9j46YHZ/3Y35Saj9+M5e+Deq8QjWDDo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DChh67p/0xOJABkwg08Oi1dpdimWVpzcIV1z8lxnimFFKUQw4vw9D0DJVaLPL6K0
 K+JAsOzEli1sR/WhvrmtUvL86VG51u6f1pXDo/WG165MdIY19IZQ2TGrVZ47sZXLA
 x9av1V/dl6XCBnYQuTjtY98+IAV38HVgVQsZcEk/XG1djTmhiOzwa0rElBRbJp9kZ
 YLjJnV9+Lf9fz8vrJQO/az+0CAV3zkZq2ZhvJPQ9DGuceDmovPpjGtqHOtyVpwMYp
 Cs6eeCvJba3F6aNfRCyLDgghDAG2DbDc1qdw6xFjSS8jquTBrGuLLIShy7W5hpyeJ
 DhciswuU5HjJq9dOqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.109.104]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1teKCW1qY1-00FH1c; Thu, 30
 Jan 2025 14:36:45 +0100
Message-ID: <2fbcb4c8-52d4-48a3-a2bf-f7cd8fb20a30@gmx.de>
Date: Thu, 30 Jan 2025 14:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] meminfo: add memory details for armv8
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-2-ilias.apalodimas@linaro.org>
 <bc481af0-64f1-47f4-af19-1aba64c2ae6c@gmx.de>
 <CAC_iWjKSFq-hhwzoxw9XMXj92fpmy1uz_J-kdqvYx0Ju6HcUMg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKSFq-hhwzoxw9XMXj92fpmy1uz_J-kdqvYx0Ju6HcUMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RMGtcJ3FjDdOkDC2t7MlFoKVp229MXacXPaBJHUT356Q0mOAXwK
 CikegvoqvRr84DsHfcywpIKkeKP5+nLHnEK5numHTr8LzCgDaY215HGTCYnf8qhvoeuKKV2
 RUpG3WrH9Lh8ZJXauFSs5vPLe0IiWsbellHn36uia3Ju+r0Ge0ZGUOwJ7CaU47ZVVC+iNne
 y2f6/oO7FgNaNbVGugDCQ==
UI-OutboundReport: notjunk:1;M01:P0:vqXfPzCHc8w=;MKYH6imgIaQprUTDNFDCtCN5t6o
 phGC2nFHGuKzipYPN/vs7RO7EWsoBVbz/rz9ijAsubO9+yuKG1oZEsUince4LYDmL8VDotdRx
 jLusGLB5Los0MjM69T/lT2poiZoUWZjNId/Orrhv0cyMHPyoAsW/l3SAwPxMyT2aXyMX85L5t
 d9NK0ooAGZJ1K0KRVc5f8/jy2NKXAWzG2KVigdgCVnnzL8syfIHBnBFwbqM58gUvdyusdzzmk
 8c0DyIshRf+SG9TwtIz4ZwvEMRNJxyvIsKtboNCkbGMsj+c9ry7X/Wru8akQVVxon54/XLWaH
 XXY6WyxSEsLT1Dtpi04qPfrPovKdtU4VVyp0URaD7f6uadjbq0wxZMzzTRc2rG56oVDiadg3t
 SzWwlFOp1jFizjdaqKhz1e8IpyrJ9Zp4eEPYt4pGO2OWn4qY4PkpHR5kqL8HrtaIkHK8mpSQo
 xkjnLL86l7BxuwKH7Jnhdq2vg9IKGKfnhSaFpClah1nF4Ax9poyB3EUDQikft5hPFEQtmU6mi
 38KDfaHW6XB0kfo9Ov2CpGv6dbB7jEnWQPrppJyykLdzr3TDvb1GUfqKphNzNved+O2dbbf1y
 vmh2wmXriuE5ypFK0c1eM/f4KpT0aO6P0jt3lOy9w5820BG2AsAZRGsld2zqtJ/ztcdAnwsP3
 hgS9oJRVTmLiStMBHm0sWYFmnOIiuP/egNZl9GP0oMlTa9164UAC0tfmeckVXAnYr/VPjhTna
 eV0JS17GACkeCJiHXshwo9jo6rxtcv1Pm+5ty4MZWQw6o4oRq+TC2HB9Zv5b4pBmD9qyPyxlz
 LltrXwKpV9SHBHSy/LJwwiYsAG9+S1T+lJibnpqc9y0Pjg/TxDtdnzjnqNeLJm5au+fwOr67c
 ryt6EjnL0VaSpskl17V9ASoRJ0VzeB4TO2IalB89SprqtlIZCI0awLTmajeYofrT699Lw7qVb
 MKK5gaKaItwzh0AU1L6B0fmZBD8B8Fq4NeSVAbucRPdf9gQA2VVFNdI1E+Ya4Mm69wIaCwqR/
 UBjRSI7lEYnmy+RqTilIFksZsuuEoobHQqq6bvPfcbR80TaV7aBsZ9/5nfbTwKweZrkNKFz0x
 HVOkAsIDA07krdZeyGx8mH6ia9xx9hxfwbix2GfKIfzcQ7+sDV1Rca/KC5aLQC1Dke9R9u5Ya
 gDHt6A4jhJ8rJxdHtC/vkkONcfV+PhMVUs+ZHRlQHgCH31eYQjwIV8L8mrzoaUkQ=
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

On 1/30/25 10:35, Ilias Apalodimas wrote:
> HI Heinrich
>
> On Thu, 30 Jan 2025 at 12:01, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 1/30/25 07:20, Ilias Apalodimas wrote:
>>> Upcoming patches are mapping memory with RO, RW^X etc permsissions.
>>> Fix the meminfo command to display them properly
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>    arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
>>>    arch/arm/include/asm/armv8/mmu.h |  2 ++
>>>    cmd/meminfo.c                    |  5 +++++
>>>    3 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_=
v8.c
>>> index 5d6953ffedd1..a4ca56c8ed42 100644
>>> --- a/arch/arm/cpu/armv8/cache_v8.c
>>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>>> @@ -421,7 +421,7 @@ static int count_ranges(void)
>>>        return count;
>>>    }
>>>
>>> -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
>>> +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
>>>    #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) =3D=3D PTE_TYPE_=
TABLE && (level) < 3)
>>>
>>>    enum walker_state {
>>> @@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
>>>    static void pretty_print_block_attrs(u64 pte)
>>>    {
>>>        u64 attrs =3D pte & PMD_ATTRINDX_MASK;
>>> +     u64 perm_attrs =3D pte & PMD_ATTRMASK;
>>
>> The variable perm_attrs is not needed. You could use pte directly.
>>
>>> +
>>> +     if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN)=
 &&
>>> +         perm_attrs & PTE_BLOCK_RO)
>>> +             printf("%-5s", " | RO");
>>> +     else if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK=
_UXN))
>>> +             printf("%-5s", " | RW");
>>> +     else if (perm_attrs & PTE_BLOCK_RO)
>>> +             printf("%-5s", " | RX");
>>> +     else
>>> +             printf("%-5s", " | RWX");
>>
>> The string has 6 characters. "%-5s" does not match!
>
> Ah thanks! That's the misalignment i was chasing
>
>> As the string length is known using a length identifier is superfluous.
>>
>> It would be helpful to add descriptions to the flags in
>> arch/arm/include/asm/armv8/mmu.h.
>>
>> https://documentation-service.arm.com/static/5efa1d23dbdee951c1ccdec5
>> describes:
>>
>> "The Unprivileged Execute Never (UXN) and Privileged Execute Never (PXN=
)
>> attributes can be set separately. This is used to prevent, for example,
>> application code running with kernel privilege, or attempts to execute
>> kernel code while in an unprivileged state."
>>
>> Shouldn't we show the values of UXN and PXN separately?
>
> I had that on my initial patches. But then I decided it's too Arm
> specific to print it.
> I was hoping more archs would fix that so I preferred RO, RW, RX since
> it's arch agnosticI don't mind re-adding it.

This code in arch/arm/cpu/armv8/cache_v8.c is architecture specific.

RISC-V has flags R, W, X, U where U controls access by user mode.

When printing the flags I guess we should use an architecture specific
notation.

Best regards

Heinrich

>
> Thanks for taking a look!
>
> Cheers
> /Ilias
>>
>> E.g:
>>
>> printf("%s%s%s\",
>>          pte & PTE_BLOCK_RO  ? " | RO " : "",
>>          pte & PTE_BLOCK_PXN ? " | PXN" : "",
>>          pte & PTE_BLOCK_UXN ? " | UXN" : "");
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>        switch (attrs) {
>>>        case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
>>> @@ -1112,3 +1123,8 @@ void __weak enable_caches(void)
>>>        icache_enable();
>>>        dcache_enable();
>>>    }
>>> +
>>> +void arch_dump_mem_attrs(void)
>>> +{
>>> +     dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
>>> +}
>>> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/a=
rmv8/mmu.h
>>> index 0ab681c893d3..6af8cd111a44 100644
>>> --- a/arch/arm/include/asm/armv8/mmu.h
>>> +++ b/arch/arm/include/asm/armv8/mmu.h
>>> @@ -66,6 +66,7 @@
>>>    #define PTE_BLOCK_NG                (1 << 11)
>>>    #define PTE_BLOCK_PXN               (UL(1) << 53)
>>>    #define PTE_BLOCK_UXN               (UL(1) << 54)
>>> +#define PTE_BLOCK_RO            (UL(1) << 7)
>>>
>>>    /*
>>>     * AttrIndx[2:0]
>>> @@ -75,6 +76,7 @@
>>>    #define PMD_ATTRMASK                (PTE_BLOCK_PXN          | \
>>>                                 PTE_BLOCK_UXN          | \
>>>                                 PMD_ATTRINDX_MASK      | \
>>> +                              PTE_BLOCK_RO           | \
>>>                                 PTE_TYPE_VALID)
>>>
>>>    /*
>>> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
>>> index 5e83d61c2dd3..3915e2bbb268 100644
>>> --- a/cmd/meminfo.c
>>> +++ b/cmd/meminfo.c
>>> @@ -15,6 +15,10 @@
>>>
>>>    DECLARE_GLOBAL_DATA_PTR;
>>>
>>> +void __weak arch_dump_mem_attrs(void)
>>> +{
>>> +}
>>> +
>>>    static void print_region(const char *name, ulong base, ulong size, =
ulong *uptop)
>>>    {
>>>        ulong end =3D base + size;
>>> @@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>>>
>>>        puts("DRAM:  ");
>>>        print_size(gd->ram_size, "\n");
>>> +     arch_dump_mem_attrs();
>>>
>>>        if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
>>>                return 0;
>>

