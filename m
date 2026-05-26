Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE76CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11C8846E2;
	Tue, 26 May 2026 16:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yTHZNm4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B6384866; Tue, 26 May 2026 16:13:58 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B09846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so56325455e9.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804834; x=1780409634; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uQJ/FgzOks94tb3PgNBcwt1dy7yiwVPirxJqIRkaY0=;
 b=yTHZNm4rhrHeoWqPQVbN8gJSpE5rw7OhBZdQjw14eZSQxpIjLN/Go0L9JOxsCwybe9
 nqJ+5j66Qkv4GLzQ1ee5kdsod8N5ZjhxCPk3jtuNeNJf08s6pjdIDcQgYia8ZfYchvPV
 0Nngxi2dxzvqTxtyDo+cKN1sUEAgiM0jislIWUmBOdfIjtz9z+Rgx3TZK2qLWxTur+zv
 EoKInxpzdW3xdyplbIIQt1FDIUSuqmiA6WgAF8kxWd+91EdH1/rfzTlDmI+gVEPGmJyH
 yEN3ApAgdKRftVNlrvZLkOSQeQUSDVPSHSGQ0kQK6m2hEsCeSrJJDZdbDXKh3X9P9dSR
 C1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804834; x=1780409634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uQJ/FgzOks94tb3PgNBcwt1dy7yiwVPirxJqIRkaY0=;
 b=OeJzcj2Xk9jJR5KE6fkm91rQjhMGW3vkjL8szCPU3t+mdjToAOYYrEHq8F3JfR8/+p
 Ltl0cSsvoUXXlQRyD6cGTozk7q210QiihnGsFYJo3HMHLc8vS4Jp642DrpGV3CeW3KYe
 UC1P/RoyDk8VVkccExfmRPUvUq55NJj4ZV8YSHGv2RxHh9+6fsq3EOUBZxwFlLqC+xpI
 xME7jvp3/89c6QXs/zLjJuiSxCKIPXYtFh2IfA9If8lzMni96c7B+Y7hUK/d5wV6k6WE
 lEvEZ7DOX/ah29J/QEzp8UKrqP8g0YRLcwRiebpjGz+fe22sdOzBqRdo9keiv7p7vkSJ
 sXOg==
X-Gm-Message-State: AOJu0Yx/xuDD05jM8vb6uxMMAwp1yRiH2Z/Cf4MFy4b2h/qWX3OBK5+W
 zzmT7LUnwa4yclKGZYihOHWvsoCeasdbIspXYMLX3jlLxtl+17nERq+3zAEHfCyHbps=
X-Gm-Gg: Acq92OEss7EXXMLhBUukRnAKrZb1tDl/EG71h96iX/yhgbg+gbgXABK9I2gktnZ5XkJ
 hQ9HrFG8HBBMeP3Bk9f7VM7/HSEtUvMjnzdOrzD1A7aSTNGttdbaWMXsgI4Ht6sJoufbwmHsZLQ
 rUnwZ/nhURV7xsOavK9r49NOkZDLg6z2eQQ9F+QBajLsrpXyoz05ws9EPPRG9Go9f3tG5w2wyL1
 OI5+QhgLgHgNlpNgpiQgseo+ZN36ohUT05PAjcnnDcScmnrmosERvnj99QBiBFb9pbdyvrTCDee
 cTDMsIIa7Imf+TBtLnY3qDlowCwPNKSUiXfG5ofxokxOgn7ZmM1iBKQYwYJqh+zSDIB2KKjNwlz
 u2uYUfyYuaz9W7Q+Ey57CBHWRu9WrFctaeueGPQnxK4m39gg8VTrt8uM7xySWkR3y+Wf/PGOTpz
 6zWYg1RXMiKlVwKu/n3/nSKAFmkGj7UwGCxYZQskSJ0B1yw0vQ/oPGwacqXTwFCeM=
X-Received: by 2002:a05:600d:8486:10b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-4904249d1ecmr225665585e9.3.1779804834177; 
 Tue, 26 May 2026 07:13:54 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm323851305e9.11.2026.05.26.07.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:13:53 -0700 (PDT)
Message-ID: <a0a957f3-2375-4143-814d-3611c38c7876@linaro.org>
Date: Tue, 26 May 2026 16:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-4-7802245a40a2@linaro.org>
 <CAC_iWjL+gX29x5LPnzY3uksGo4ozFPg=NmfUB32po7CsYOyHUQ@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAC_iWjL+gX29x5LPnzY3uksGo4ozFPg=NmfUB32po7CsYOyHUQ@mail.gmail.com>
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



On 25/05/2026 14:53, Ilias Apalodimas wrote:
> Hi Casey,
> 
> [...]
> 
>>
>>         return NULL;
>>  }
>>
>> +/* Checks if the current PTE is an aligned subset of the region */
>>  static bool is_aligned(u64 addr, u64 size, u64 align)
>>  {
>> -       return !(addr & (align - 1)) && !(size & (align - 1));
>> +       return !(addr & (align - 1)) && size >= align;
>>  }
>>
>>  /* Use flag to indicate if attrs has more than d-cache attributes */
>>  static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>> @@ -1003,11 +1004,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>>         int levelshift = level2shift(level);
>>         u64 levelsize = 1ULL << levelshift;
>>         u64 *pte = find_pte(start, level);
>>
>> -       /* Can we can just modify the current level block PTE? */
>> +       /* Can we can just modify the current level block/page? */
>>         if (is_aligned(start, size, levelsize)) {
>> -               if (flag) {
>> +               if (attrs == PTE_TYPE_FAULT) {
>> +                       if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
>> +                               *pte = 0;
>> +                       else
>> +                               *pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK | PTE_BLOCK_INNER_SHARE);
> 
> Looks correct now, but the umapped memory appears as 'Device-nGnRnE'.
> Shouldn't we preserve whatever was there?

Maybe you could make a case for preserving the old values to know if
this region was mapped at some point, but I think that might just be
more confusing since we aren't generally interested in the history of
the TLB more so the current mappings. If you're explicitly debugging MMU
code then it still probably wouldn't be the most useful way to go about it.

> 
> Thanks
> /Ilias
>> +               } else if (flag) {
>>                         *pte &= ~PMD_ATTRMASK;
>>                         *pte |= attrs & PMD_ATTRMASK;
>>                 } else {
>>                         *pte &= ~PMD_ATTRINDX_MASK;
>> @@ -1107,8 +1113,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
>>         flush_dcache_range(gd->arch.tlb_addr,
>>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>>         __asm_invalidate_tlb_all();
>>
>> +       /* If we were unmapping a region then we have nothing to make and can return. */
>> +       if (attrs == PTE_TYPE_FAULT)
>> +               return;
>> +
>>         mmu_change_region_attr_nobreak(addr, size, attrs);
>>  }
>>
>>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
>>
>> --
>> 2.53.0
>>

-- 
// Casey (she/her)

