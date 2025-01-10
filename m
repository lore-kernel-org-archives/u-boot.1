Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDECAE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 14:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A4E801F5;
	Fri, 10 Jan 2025 15:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W9dgSP+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432208036B; Fri, 10 Jan 2025 15:21:01 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118BC800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 15:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1318005f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736518858; x=1737123658; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=svvSZs+lqK/CKisjunuCU9B3+i69fyZWhv/kILaitmI=;
 b=W9dgSP+pXshMxkXpTFblhiyRBZtxYsaGQs4QtRTd6prEIaGIwPgMmiUtfb7zdBgPa4
 p5Ark6AoqDG/DhxNCozn7uFbkA4TqCVtfbRv5BaJResrOquoMrA00EVXTgusJckc1ms6
 uq2Fhe1kdV0/Uqiinumvu4GOZq6dXaB5vP+kFn/sAZu4TNsOgPzXfs6sLVTWYHnzZOoK
 4Lrzm4WeYUz2TWaTU5QpCR+diVrcKyHEcYXz/or1ioSf+GLNL+QEWrA4L3mBDKv0bygj
 saCEeIBJnlFysC7+FEkjvj+kkHjzY/zbo6EN+ptHtX6xu4kogIX4LT0j7VDRhMUmJy+g
 SXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736518858; x=1737123658;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=svvSZs+lqK/CKisjunuCU9B3+i69fyZWhv/kILaitmI=;
 b=K87UeE1ENqZl8HmPG98FOH+Mbe3ylbw9OAQHhElRKhrRlMMH/yF6fcwPwMZdlmpcsZ
 3x8ZPNo4Fx+x8zpoHu/Dosw7AKd+o2T9G0ktmz2eXzJfMsxIvBQUViTDD/Csw3GQeRel
 TyYhAARRKIcJMPKdKELIO0HsY58sWA7hDzLU2LCCTwG5aRHro2Ra/HNII56D+XGlVNAV
 blWjTD1pT0dZk2jGLAlcREvwExsEXJSRaBnSocfcDxJZ3jYCw4plzDc0rzc125I/ey7e
 azrdhxx0/HCW8oAUFSu1auWQ01/xT7fJlaWXu0igcP6xK3s2EWQhuxZQ0PxDTDXFy68E
 OkoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVPf9zQbI9MCs4heOW7HSLJhP9d8byfHS+DSibQLfth4ZI9LNZzs9Db09n1qvR+8FzhRxZNak=@lists.denx.de
X-Gm-Message-State: AOJu0YzRsbX0NWDLALfxr4x5KfVrFuPNquoRvzgX6omrPLFM0+9TLSrk
 6bDTVyyn+vTKnfoAlkgHyft43YKrG46wqxLGM4m2/yASHcq4DWok/p9SpRBmHuY=
X-Gm-Gg: ASbGncuHuZh0NXgupZIwNuIhoydrpAibWKsiWKwMMs+SVe6BpiaxCWMIb5ybCYcehlh
 7SkCu7JUP932DNDrMhvR97qD+gUKvPjuXD9tc3sdKu6A1vSvaDnrUK/oOfvaNdfaeaZtlK/Rj+s
 Ht5a0kTYiSpg37D8liwvi+RyMXvyujNdO9w6F+gpy6DDrGbIfwR/xM9KmNw9iA3WW+pYZGEhHbc
 6PInGKZftBHHGsZBjtPt5QP4YYuhQQ0QlhmtFR53Myg4xma2so3y/tkr9KyORg7MYBTCUw+zc0l
 yZUFkGENjwTaSkdp22UQhE0AJsioIFiP+A==
X-Google-Smtp-Source: AGHT+IGd6qWyZw/44dxYCKCcrvsWFdCVNg0IoOT1mg5K2+1T3cbxNfbZOt//63IUvYn97h5gCPlp4g==
X-Received: by 2002:a05:6000:1884:b0:385:ea2b:12cc with SMTP id
 ffacd0b85a97d-38a8730442fmr10345931f8f.13.1736518858363; 
 Fri, 10 Jan 2025 06:20:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8?
 ([2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0casm4696821f8f.11.2025.01.10.06.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 06:20:57 -0800 (PST)
Message-ID: <1621d9a2-3fbb-4858-b5dc-929917dd5018@linaro.org>
Date: Fri, 10 Jan 2025 15:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] armv8: mmu: don't switch to emergency tlb when adding a
 dynamic mapping
To: Marc Zyngier <maz@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250108142235.1194640-1-caleb.connolly@linaro.org>
 <86septwdlr.wl-maz@kernel.org>
 <37c914cd-8f66-4474-8b88-7464b256cd49@linaro.org>
 <86r05dwbva.wl-maz@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <86r05dwbva.wl-maz@kernel.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 08/01/2025 16:42, Marc Zyngier wrote:
> On Wed, 08 Jan 2025 15:19:07 +0000,
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Marc,
>>
>> Thanks for your comments.
>>
>> On 08/01/2025 16:05, Marc Zyngier wrote:
>>> On Wed, 08 Jan 2025 14:22:24 +0000,
>>> Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> This seems to cause crashes on a bunch of Qualcomm platforms. It's safer
>>>> to just update the live table and flush it.
>>>
>>> You may want to provide a bit more information, because that's not
>>> much to go on, really.
>>
>> Best I have is "the board hangs and then resets when trying to switch
>> pagetables", I didn't manage to narrow it down exactly, but since it
>> seems to work to update the tables without switching that feels like a
>> better approach at least for now.
> 
> I think you should completely characterise the issue before changing
> things like this. My hunch is that the so-called "emergency" page
> tables do not map the page tables you're modifying. Or something along
> those lines. But you really want to get to the bottom of it.

I narrowed to the call to __asm_switch_ttbr() even with the same table
address (so no change), and I can't explain why this doesn't work.

> 
>>
>> In hindsight, this mmu_map_region() function is not great in a lot of
>> ways, I'm still getting my head around the MMU and I expect this will
>> keep being improved.
>>>
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>   arch/arm/cpu/armv8/cache_v8.c | 11 ++---------
>>>>   arch/arm/include/asm/system.h |  3 +--
>>>>   drivers/soc/qcom/cmd-db.c     |  2 +-
>>>>   3 files changed, 4 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
>>>> index e6be6359c5d9..43051d156122 100644
>>>> --- a/arch/arm/cpu/armv8/cache_v8.c
>>>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>>>> @@ -338,9 +338,9 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
>>>>   		size -= next_size;
>>>>   	}
>>>>   }
>>>>   
>>>> -void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
>>>> +void mmu_map_region(phys_addr_t addr, u64 size)
>>>>   {
>>>>   	u64 va_bits;
>>>>   	int level = 0;
>>>>   	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
>>>> @@ -350,19 +350,12 @@ void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
>>>>   	get_tcr(NULL, &va_bits);
>>>>   	if (va_bits < 39)
>>>>   		level = 1;
>>>>   
>>>> -	if (emergency)
>>>> -		map_range(addr, addr, size, level,
>>>> -			  (u64 *)gd->arch.tlb_emerg, attrs);
>>>> -
>>>> -	/* Switch pagetables while we update the primary one */
>>>> -	__asm_switch_ttbr(gd->arch.tlb_emerg);
>>>> -
>>>>   	map_range(addr, addr, size, level,
>>>>   		  (u64 *)gd->arch.tlb_addr, attrs);
>>>>   
>>>> -	__asm_switch_ttbr(gd->arch.tlb_addr);
>>>> +	flush_dcache_range(gd->arch.tlb_addr, gd->arch.tlb_size);
>>>
>>> Why would you invalidate anything when *mapping* something? By
>>> definition, if there was nothing mapped before, there is nothing to
>>> invalidate (hint: the architecture forbids negative caching).
>>
>> This isn't flushing the region or TLB, it's flushing the translation
>> table we just modified.
> 
> Ah, you're obviously right. I can't read today...
> 
> But it then begs the question: are the page tables configured to be
> accessed by the page-table walker in a non-cacheable fashion? That'd
> be rather silly, and the only reason why you'd need any form of CMO at
> this point.
> 
>> I'm wondering if this tlb_addr variable is misnamed, I'm reading ARM
>> docs which suggest the TLB is some cache inside(?) the MMU, but this
>> tlb_addr in U-Boot actually points to the translation table in memory if
>> my understanding is correct?
> 
> That's my impression, but each time I look at this code, I feel a bit
> sick...
> 
> 	M.
> 

