Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00E7C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5C484DCA;
	Fri, 17 Jul 2026 14:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HUbybid9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD27F84DDC; Fri, 17 Jul 2026 14:00:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F4A84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so64665965e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784289624; x=1784894424; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7TiZqVqWdaENav/vK6sFKSMszXymT9PUHeExnibXZgg=;
 b=HUbybid9ymHfxTMdU/LVOhwucquUT0pnnHeutCC249n8FSuUY9zrmGbyJFNLt3qD/X
 RNKEL5QzqNzozVyTfD0AK/Z/haQaUp5ZbE1NrkSxbr5qrFtLwinCJsOkTUtSii2oqwkN
 aG3rgQ9uveMOF4mNmgzi3Gm4TgKbuhExS31VUHs8TIm+KkEl1rBQ6JL+V1oihbJUoxnS
 w8CxBzlBmEzD3BZ75PJx1iDrCHFg/rWcvTVXQ6PE6bIxXn0t7BONh0kgWL9q+2tmuVVb
 a5hw8khCgu23Rt1EDdb72g/vMDF+LqjgH5MiCwzkMGiKhTUi3jtdI9s5mxiSNzYABF5n
 lo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784289624; x=1784894424;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7TiZqVqWdaENav/vK6sFKSMszXymT9PUHeExnibXZgg=;
 b=evejPrV4EediTydc3hSsxoPVdeVcl+TPx37odY7XRYj6IaHA80VLM+wBBsD4b6t8A9
 rr8NkoZR31JjQFIQLxTb3oMCiNDduYTD6n4yJmitGiUitSG4falAhOzq3Am/zx18uI+r
 r/nryokab34YYIygkLasrJd/YX0SF/qNGmadBPnpfR3Hd4P6xDt+d4d6EhYyii/tcwOA
 owf4z4FvbrfvDg48sZb+E4X5VjDdbvyq+gJ7d0t5OSgPfyAf6qBk3wJq+VL7cxWQFVzj
 iRebrS5OuhN1zFzY2sZWlbGjmdxGkgxzJCdZK0rWTFeUlOaFd0N979nfA8WGrXId5u2b
 Uo0A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqk93/RW7YubD+RoPaS6h51XasaJ3oeCFMpmKR1Ji4OOyqYmLn75sePcOn1S0eTZFh3G207HYc=@lists.denx.de
X-Gm-Message-State: AOJu0YwCF93JszGJfS5U6DS0ccXfWX1C7LwTUhjLHWhzZxEiT8twyIJQ
 1wimWC25dUU9Xt/NPrLsV7X+rvOHQNxE44KVlWd+TLlytZAlRXXT34MS
X-Gm-Gg: AfdE7cmO7IjCAijFJfqcZ0xpURLVaLDlF247PVzPTKmFqrw3j5WYPRnrvSGiHkKPUeg
 ljr1GeXWI3tJGFFbsrgVBV/lIus858O40RNlgSs876Q+sPT1gl5HrfnXogtjTxB4JkuBVTsMVUl
 +rHk0aON35dMCy+KagKH6FjW6cgAdTJSYperykDfzIyB84R2UINP63hxjGCsD9i+LdZQXRcy1m+
 uqRieCreT6EFGdDr/CozSRmq3e4BeciZSOc+rfhtjbchE1+bjCNDi31WcrLZxrj6XoO3IyD0OnN
 zxET/Gj7Wr3bh0dR3Cwin6vWc3BEG/HuHUPvMcZU3RObkzvaho6kMDW8gwS6QSjOC/4ijl6Aj/K
 KDt9tchdnVahofkDddJzOrXFrnkTnWxB1VDqFCBaDNV2JlThA8sv692OadJlujVGv0ZLsHzlmDO
 6mGCUfCoKoGN2n/zlTcYaVOGW2uJ/kfDX0ElgG3aq1Q/iWknTGpjA7DO/L13oRk9eIaWLD3w==
X-Received: by 2002:a05:600c:4ed1:b0:495:4cb8:42b9 with SMTP id
 5b1f17b1804b1-4954cb842f7mr10009255e9.4.1784289620351; 
 Fri, 17 Jul 2026 05:00:20 -0700 (PDT)
Received: from [192.168.68.84] (host-87-5-153-198.retail.telecomitalia.it.
 [87.5.153.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2edbe4sm44355865e9.12.2026.07.17.05.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 05:00:19 -0700 (PDT)
Message-ID: <df4a4fb2-643c-4d6a-a8de-edf15a375928@gmail.com>
Date: Fri, 17 Jul 2026 14:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: downgrade -EINVAL reservation failure to
 debug
To: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Guo <qijian.guo@nxp.com>
Cc: Randolph Sapp <rs@ti.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
 <e1a26574-4f7d-46f0-b757-55f419df326b@gmail.com>
 <d170674c-360e-400c-b263-a35aab640d71@kwiboo.se>
 <7e290ff6-0e97-4c9e-b82b-7425904efb8a@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <7e290ff6-0e97-4c9e-b82b-7425904efb8a@oss.nxp.com>
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



On 7/17/26 07:18, Joseph Guo (OSS) wrote:
> On 7/16/2026 7:55 PM, Jonas Karlman wrote:
>> [You don't often get email from jonas@kwiboo.se. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi Joseph and Emanuele,
>>
>> On 7/16/2026 10:25 AM, Emanuele Ghidoli wrote:
>>>
>>>
>>> On 7/13/26 10:45, Joseph Guo wrote:
>>>> When boot_fdt_handle_region() attempts to reserve a DTS reserved-memory
>>>> region via lmb_alloc_mem(), it may receive -EINVAL if the region's
>>>> physical address falls outside the LMB-managed memory range (i.e.
>>>> below PHYS_SDRAM on platforms where U-Boot does not manage the lower
>>>> DRAM window).
>>>>
>>>> A typical example is platforms like i.MX95 where PHYS_SDRAM starts at
>>>> 0x90000000, but remoteproc/rpmsg carveouts (vdev vrings, vdev buffer,
>>>> resource table) are placed at 0x88xxxxxx by hardware convention. Those
>>>> addresses are unreachable by U-Boot's allocator anyway, so failing to
>>>> mark them reserved has no practical consequence -- U-Boot will never
>>>> accidentally place the initrd or FDT blob there.
>>>>
>>>> Printing ERROR for a condition that is harmless and expected on many
>>>> platforms is misleading. Downgrade the -EINVAL case to debug() to
>>>> suppress the spurious output while preserving full visibility under
>>>> DEBUG/log builds.
>>>>
>>>> Real failures (e.g. -EEXIST from an overlapping reservation) continue
>>>> to be reported as ERROR.
>>
>> I sent a similar patch 2-3 weeks ago [1], and was planning to send a v2
>> that also change lmb_free() to return -EINVAL to also catch the free
>> scenario.
>>
>> [1] https://patch.msgid.link/20260627204851.1151419-1-jonas@kwiboo.se/
>>
>> Regards,
>> Jonas
>>
> 
> Hi Jonas,
> 
> Thanks for your information. This patch can be dropped in that case.
> 
> Regards,
> Joseph>>>
Hi Jonas,
I agree with Joseph.
Can you please add me in Cc to the v2?

Thanks and regards,
Emanuele

>>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
>>>> ---
>>>>  boot/image-fdt.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>>> index 9e0e0f93edd34ae9056926883b1a802858e179d9..2175fa338f55110862100fa9f491a0957e85ce56 100644
>>>> --- a/boot/image-fdt.c
>>>> +++ b/boot/image-fdt.c
>>>> @@ -95,6 +95,9 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>>>>              debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>>>>                    free ? "freed" : "reserved", (unsigned long long)addr,
>>>>                    (unsigned long long)size, flags);
>>>> +    } else if (ret == -EINVAL) {
>>>> +            debug("   skipping fdt memory region outside LMB range (addr=%llx size=%llx flags=%x)\n",
>>>> +                  (unsigned long long)addr, (unsigned long long)size, flags);
>>>>      } else {
>>>>              printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>>>>                     free ? "freeing" : "reserving", (unsigned long long)addr,
>>>>
>>>> ---
>>>> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
>>>> change-id: 20260713-downgrade-f8319ab2d75b
>>>>
>>>> Best regards,
>>>
>>> Hi Joseph,
>>>
>>> Tested on Toradex Aquila iMX95, which has reserved-memory regions for
>>> the Cortex-M7 (vrings, vdev buffer, resource table) below PHYS_SDRAM.
>>> The spurious ERROR messages are gone and boot is unaffected.
>>>
>>> Kind regards,
>>> Emanuele
>>>
>>> Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>>

