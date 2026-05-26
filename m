Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA2CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B095E846E2;
	Tue, 26 May 2026 16:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vLo0f6s1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8166484702; Tue, 26 May 2026 16:10:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D83C846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so7641373f8f.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804647; x=1780409447; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mIIlue91LavUrI3g7pPE0E6d3Apgsim2heb4OcE2fw=;
 b=vLo0f6s10RSNuOwY5/liyvL2X457E6b1D82kQ16YwilmP/61md9iJY2VBinxdse2d4
 a4FhnXWEqsHcVYfT5q4vGBLmFvdURxInROWjZRBH1Mx0HPQ1coT9CsFjbJ70crCN7zB2
 +LnyhzYx6kqPovt1HE3j1wCSifJHVf+8UFJUEPKvmd0ZIH9TJZb2OygFQd7S9sJs+o/L
 zGN0DLBPxB258thTccp3ZuYN8/E2zyM2Gm9gONS1An+JklP3nloEjiUTxFgwvQp5tzQA
 LyI4ZYog/9+aKIDCoMeyRpviCnAdLZ78McuQwsCepeJcIL1h3JGbM+g1ou9D4DdCvKjz
 fypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804647; x=1780409447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/mIIlue91LavUrI3g7pPE0E6d3Apgsim2heb4OcE2fw=;
 b=fp7grjQOurdpi8h25+ynpt3AOGfF0KKJ14qFFhemIGn1SqBdoyWfvqrlDq8Y2M/emC
 2h4nq744OCxXBR3k3pLwGUaoZpOkYliYckzHsoNbl9QpnadL9mGARiZpEtieDlSHyng6
 ASPnEE0Y+rkvf8qlR+nDT8cmNg4i7sCMUBIO940Cl456//Q7EIvgENgks2JskVV6y0Wo
 MPeRKR2SEJbvyBZXBw85Mfjdzg93PytzPu4Zydp4XWMaQhJIE3HjFpF2T7pxyluylNkc
 EMUQ7ylyD6fLw+Rndon4TCZuXELfMI2zhDh/eS45C9huqZrwrKQ9bdwMXx5TEhwYOzs8
 ILJw==
X-Gm-Message-State: AOJu0YwdEDKhw0dAyLvZ82Lj+8mWhHCWEm7RXwONyH1namJrXBj0mwF+
 dTboFvoNtl5L/zLGX4otW+VOMXMswlFkR0kX077e/c+eunOuuOkur3UOCUaf5MiM+F0=
X-Gm-Gg: Acq92OFxA/pPHNhtJ4RSb3/PTkOab/nmhQcB7eETu6UL78fG3Tz5P2bOVI2S/PkR2Q7
 4KN3XCUeAkn7DsKeU+vFH9KC4iRK/lYTrhGP9BQkwDEjHRpE5DSvKvqS0M8rSW3E62mNtqa+q74
 OXUlbSPyap/JRqgt6kdOO/vOtIZg715U9AlAAMB2TjvMJoY1LYUVF0g/5ylo1zWwPaqrCEuAkI8
 0hQay/Tre6BKHb+YKQNFXUUxeohwPosPAcCjCP68CLIJ09phEtnPH0DtDkBjwQRMwEBdhx1LhrN
 XqzqndmMuTNOaC6xK5HZT+IJvZ1YQv6NrQ/Fs+s5qK2lhT2v7c0q+f9U1T3isL3ldqhP79WJvUU
 Ep5E6FSmFpCtgHM1MAjL4fDeoa91KPyAkpyHIaUbWLAZ1N1f27fe5v2LMA2pfjJ2WYt50+G0aKz
 hFt0IE5fvGBqmstm5pQkkWrLKom9Bz/5iqy1fbSBg3kHAjXTB24xjK6qXQKnG0xWEeejelY/b+l
 Q==
X-Received: by 2002:a05:6000:25c8:b0:45e:b9b4:c68d with SMTP id
 ffacd0b85a97d-45eb9b4c854mr26657154f8f.4.1779804646754; 
 Tue, 26 May 2026 07:10:46 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d493dfsm36749213f8f.23.2026.05.26.07.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:10:46 -0700 (PDT)
Message-ID: <1100f296-59ac-4c26-8711-a82e117c6e1d@linaro.org>
Date: Tue, 26 May 2026 16:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-2-7802245a40a2@linaro.org>
 <CAC_iWjJqSO42-w1Yk3+-bbjsGswBaZmg9Smo1CSpJMrP67cpRw@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAC_iWjJqSO42-w1Yk3+-bbjsGswBaZmg9Smo1CSpJMrP67cpRw@mail.gmail.com>
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



On 25/05/2026 13:35, Ilias Apalodimas wrote:
> On Mon, 18 May 2026 at 12:00, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>> When a region is explicitly unmapped (like with
>> mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
>> still remains but won't be used since the region is marked invalid.
>> Print these regions when we dump the pagetable to help with debugging.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  arch/arm/cpu/armv8/cache_v8.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
>> index 97a1c39ed268..2800ba57a464 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
>>
>>                 if (exit)
>>                         return;
>>
>> -               if (pte_type(&pte) == PTE_TYPE_FAULT)
>> +               if (!pte)
>>                         continue;
>>
>>                 attrs = pte & ALL_ATTRS;
>>                 /* If we're currently inside a block or set of pages */
>> @@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
>>
>>                         /* Go down a level */
>>                         __pagetable_walk(_addr, tcr, level + 1, cb, priv);
>>                         state[level] = WALKER_STATE_START;
>> -               } else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
>> +               } else {
>>                         /* We foud a block or page, start walking */
>>                         entry_start = pte;
>>                         state[level] = WALKER_STATE_REGION;
>>                 }
>> @@ -707,8 +707,12 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
>>  {
>>         u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
>>         int indent = va_bits < 39 ? level - 1 : level;
>>
>> +       /* Ignore empty blocks */
>> +       if (!start_attrs)
>> +               return false;
> 
> I am not sure I am following this one. This one get the value of
> TTBR_ELx. What are we trying to prevent? Perhaps we should move the
> check to walk_pagetable()?

Not sure what you mean about TTBR_ELx here. I think you're right that it
should be moved, I think I added it because I hit a case where there was
a table with no blocks in it (which obviously should never happen if the
mmu code is working properly).

I can just drop it then if we see empty FAULT mappings from address 0
with a size of 1 granule we know there's a bug in the MMU code :D


> 
> Cheers
> /Ilias
>> +
>>         printf("%*s", indent * 2, "");
>>         if (PTE_IS_TABLE(start_attrs, level))
>>                 printf("[%#016llx]%19s", _addr, "");
>>         else
>>
>> --
>> 2.53.0
>>

-- 
// Casey (she/her)

