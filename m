Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2078ECCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B76F836D3;
	Thu, 30 Oct 2025 13:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E22PjbS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4276F836F0; Thu, 30 Oct 2025 13:34:26 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5630E836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b6d2f5c0e8eso211964766b.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761827664; x=1762432464; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vnqcUAcJPTYzZEhpZvh4bE+XSDx7KlKAXdbWaHo9D1E=;
 b=E22PjbS6Gfd6dIj9tZORb1g0+tqcF+xga/SwuDa3oxnIsa4LAPyYtAIh1SPxgghhtJ
 6KWpkfKYCFsnlPVlRqHw5iu5ANWj/S58YIMm4COc0hoawTYGNeOX5JjGfE3m/ApfaTso
 9mrrZ6jmuQAzJt7N6QzwisY/TRYVca1H0LD8WtVPNUMM/EMgWbPFJud7olhBHQgSUGCN
 Kt/T7OX6RzXzWDAWsrGlnYz/Y3kYeAdlpYDHXKL/45kWZSKV6NO7IUkX5lTy4JFcrYrY
 ywrxEsRFqcRsrYgrpBtvdSERB5cVVw+3CZoLRxm9Aj4QIgHyIMnnbTAnhGD7E50x7Uv6
 bWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761827664; x=1762432464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnqcUAcJPTYzZEhpZvh4bE+XSDx7KlKAXdbWaHo9D1E=;
 b=M8pvQTV4BnzzQIZh0oszrCyw06UikuLaNbgPsYUghdUnFuujnusC5BoNPYmX0CBxsc
 Mq/XJtsjAUa1a9+UE3Q8SHoTIHBoIB4pG8FQnNMppwxcu09zJurnxA4mf1hmzuEU4igr
 r839BLIacRbgLdpLXw9LHP4aS2JKY6VFbCW1uyEuyek/rN7raQA2eADYmy/X6TQKF6FA
 kn8b8xydbx9Eltk+Tb4+70CD8Rpia1rN3axKx+9++fGeyeesn7joHPJJ5xJTBlb1WWGz
 BgIoRTVl35COY3D+zVl+2FNktUndLB9vDR+asuXdZl/aRghIcuFstsmLN3dM8PxOR9Yt
 Qj4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/aP3YkMPZn7lrEfjSeIBp19Bjcpb7ROwNz2iYw26BYKY+6laApgwRMFgV6/del+twdYbsb/8=@lists.denx.de
X-Gm-Message-State: AOJu0YwESpRtPB1WZSk1Dm0gJqHWzr/f9wpTspFA2pxDRAew7hMpI6uV
 jYeerDDNuyG+tiyD4H9+nzZG6AiE0fU31Xy7ZtAH1si2KJp1cNE9LXfIgTjM+nGsezE=
X-Gm-Gg: ASbGncuG99JQJA5/0UQMMT4A42iHXQTzXSR5JibKbhmgwBHTBciRgaLW33Ym6GiD72t
 2GGAxNW9AqwI2RKrCTtOn2jE3iEnEvfi2G4BJGCAAOztR4zouZNHUHtrVROXiYqw5GH+m0fEx8v
 80LYdu/lFjsSFv/tjZXerKtIrjHgebX4rSYzEqjCZljFzUquihjftd4zhpa59E+ws6gACgn8CTl
 wphTk+u9qN7xjeNDhijC6IjyefOGupaZ0SJX79GxnylSW57PNYP16Qxwoq/DoKa1KH0xP17M20r
 h9NnhsZqb5NeEmJzBESE9IN6Jrz+/o0b9vWT4BJq4m7RCiO/wUnaAWc6iJRbe1verzBF3yZ5R9A
 NFDh/MKhoK9izk0mQJuWxcQOgIUg8slwBWd56B90+UkMEHDXPBaHRkzQVmjYbjDG2ls4ZVUWW3l
 isY8h91qxqf6Rv+FNHbt3j1fdUOqvDRxOkLjn0JjngHtEctq40UyFL
X-Google-Smtp-Source: AGHT+IESD0J0M+0c6htYJU+ydvn1Uk87SZeYwYs8weoiZQ8kWICwxXRtApxcYyGjrn/FHD66uROhnA==
X-Received: by 2002:a17:907:961e:b0:b04:c373:2833 with SMTP id
 a640c23a62f3a-b703d523367mr701184166b.32.1761827663758; 
 Thu, 30 Oct 2025 05:34:23 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e67b.dip0.t-ipconnect.de. [91.41.230.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853e5138sm1745479066b.44.2025.10.30.05.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 05:34:22 -0700 (PDT)
Message-ID: <2546693c-4ee7-416c-9405-051d32f0444a@linaro.org>
Date: Thu, 30 Oct 2025 13:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: qcom: mkmbn: fix Elf constructor
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251028111334.2508482-1-casey.connolly@linaro.org>
 <60141b41-c456-4ea3-a755-d6b4c546d417@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <60141b41-c456-4ea3-a755-d6b4c546d417@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 30/10/2025 09:42, Neil Armstrong wrote:
> On 10/28/25 12:13, Casey Connolly wrote:
>> The Elf class constructor was missing two optional parameters: the Ehdr
>> object and a list of Phdr's to populate the Elf.
>>
>> Add these back so that the parse() method will work correctly.
>>
>> Fixes: 9fe658c97f5e ("tools: qcom: add mkmbn.py")
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   tools/qcom/mkmbn/elf.py | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
>> index 86f12d1f4e5d..7737adc6a4e2 100644
>> --- a/tools/qcom/mkmbn/elf.py
>> +++ b/tools/qcom/mkmbn/elf.py
>> @@ -171,11 +171,11 @@ def _align(i: int, alignment: int) -> int:
>>   class Elf:
>>       ehdr: Ehdr
>>       phdrs: List[Phdr]
>>   -    def __init__(self):
>> -        self.ehdr = Ehdr()
>> -        self.phdrs: List[Phdr] = []
>> +    def __init__(self, ehdr: Ehdr | None = None, phdrs: List[Phdr] |
>> None = None):
>> +        self.ehdr = ehdr or Ehdr()
>> +        self.phdrs: List[Phdr] = phdrs or []
>>         def total_header_size(self):
>>           return self.ehdr.e_phoff + len(self.phdrs) *
>> self.ehdr.e_phentsize
>>   
> 
> This patch is required to finalize the Qcom PR, I guess it's fine, so LGTM
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Even with this I kept running into issues with that series so it's
really not ready to go yet, dropped it and this patch from the PR. I'll
try and find some time to respin it soon and figure out the remaining
quirks.

Conceptually where I'm stuck is how to make the mbn stuff optional, we
want to have a list of soc/board compatible strings where we create it
and for other boards simply skip it, but binman doesn't have the concept
of optional binaries afaict?

A little lost in general with this one.

-- 
// Casey (she/her)

