Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B21DCAC58E
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 09:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA278341C;
	Mon, 15 Sep 2025 11:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R25IqMBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9F883423; Mon, 15 Sep 2025 11:46:00 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D93831A4
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 11:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45de56a042dso25706125e9.3
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757929557; x=1758534357; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wGrQxngdhPq6RKyr7UieL3ksBBZKSLgHsxp2SYEVnx8=;
 b=R25IqMBVUvXk68lPSVIWjL3G5T6zVAPKV2Teb1Cr6/njKqJyv6VFZAiFlIjWrYp3rG
 AAgV3WFztfGkM0U64f0da2EvGna/vXDMf9BC5GlywC/wSZRN1l78TBXLbwW4V2pJM9SW
 WL7oLt2Qz6WuiuBt/DDrnscIoBTNOq2hXJuGXHXIj1ZTssWZt4lUvScVOqFK21mhLe/P
 VYOkG/HXk2wgd8KFlJolB3Zqalyn8bhF+mF0IQn1fz6i/gFBBrCKaLWau8WjicH5tv24
 C6dZjfzuVccB+d53ubnv35rugutqQGWo2h3MdxwJqb5WNn3Zmu+8rVQ3MjYTvCXGlpJj
 AUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757929557; x=1758534357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGrQxngdhPq6RKyr7UieL3ksBBZKSLgHsxp2SYEVnx8=;
 b=lq211U143QedeZ7z2oK90ZipV/6rMcvGc9XztKMd8QsGCZyd8zPQ0wJs04eE1hslPA
 ck+aLjBWhxwGlZF9xh+l3DwFO9RPjHLMO1Mkqfr0lTgU1yA3eovXxVgERoKg1kcArI0r
 Vr2w/R/MHZSfWE5ijQExlRUfHB/fvtMWrJlejeyxuZS1jzwJPQ96x+8NVECewJjgQOy+
 wBTmnC0GP0ZiCiU9dBWynaoV/FdeKU8xc3RGWQRWepFw54oNfHqfTCJwcoN6PJFjm4sn
 oIyBm4wmqhHBc5rooxqdWFAKnnOJbO0+QtWm+0d3LX4AHNwby0oBXZA/MycUqonYRn0y
 hCYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU2omQuW+c0DPKfKVb38Mt6EVOjDk8+CmUMVzif7dqeResq7W72U5vg/aF+c1c7udtZBU6FiA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2c1lVGF5w8QFEalw8I9HL8Dv3hjPd2lOkaZQmk7zB9A4dI1fd
 z8S2nDpoeW3VBMVg3th9BW8nu7yJr4oRBLp556/YOs9NHBYKtuTugQRH/mFzKpHMTdQ=
X-Gm-Gg: ASbGncsGNrwGQVCoKkJ6uzKpsEvBHKCLEqf8wBSFBCb98AqmOVKbuF/r8btrxNdxsPf
 /Wxc0hYoyxDF9tV2uhNVC0mvLOujsoKO3TISM5dF69FS1mDKKu/D5nw2D6XqIWarToc44kGWRqg
 mX0QBVbVH/Nj1K1H1Ae4bH5JsBYVtzMCCTCiDL6J4xZxjlJohUT7MRjx6EpazSDLgqt8y6I1GLE
 zy4+VMQflUfyi9hjTx1T8YamXFKu8Ci07NIE4GFvFu4y31mfBkuuQfxCCzbrKv+MaIDUMz8skXf
 613q89NuOshxdT8nUywfiRHNgCYKnkIA9ZyrLfWocVRMaJDdc168hlD+OE0fDKk6svtFmvbkm/c
 FqMVMqu+9FYRfbU4WkrNe0VCU11qFAzBbq6UMigkbjNar5dQSejwzpFMERtXMCUJrv8Upz46Sq1
 jwJOMn8J7MoTzYC9AavHEj
X-Google-Smtp-Source: AGHT+IGkyqq3gOk9mZSUth0J/cXD8XTD49jY5Xtbdz7FUDFUAjxGe/a7kg09wz0AxALBwGFwD1X29A==
X-Received: by 2002:a05:600c:1c8b:b0:45d:d68c:2a43 with SMTP id
 5b1f17b1804b1-45f2135226bmr106834715e9.33.1757929557387; 
 Mon, 15 Sep 2025 02:45:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:22a0:c480:eb4:f525?
 ([2a0a:ef40:f9e:3c01:22a0:c480:eb4:f525])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037d741asm168464115e9.23.2025.09.15.02.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 02:45:56 -0700 (PDT)
Message-ID: <cf91c8fe-a264-4db3-990b-b866a42d17a1@linaro.org>
Date: Mon, 15 Sep 2025 10:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
To: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
 <20250831153513.GA2800031@bill-the-cat>
 <20250913155154.GF124814@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250913155154.GF124814@bill-the-cat>
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

On 13/09/2025 16:51, Tom Rini wrote:
> On Sun, Aug 31, 2025 at 09:35:13AM -0600, Tom Rini wrote:
>> On Thu, Jul 03, 2025 at 12:31:50PM +0100, Andrew Goodbody wrote:
>>
>>> The for loop in se_desc uses i as the loop index and also to cause the
>>> loop to end if the passed in name is not found. However i is not
>>> incremented which could cause the loop to continue indefinitely and
>>> access out of bounds memory.
>>> Add an increment of i to ensure that the loop terminates correctly in
>>> the case where name is not found.
>>>
>>> This issue found by Smatch.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   drivers/power/regulator/pfuze100.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> I size tested this as part of merging and saw unexpected shrinkage. In
>> turn, this got me to look harder at the code and I think the best answer
>> is to refactor things so that se_desc(...) follow the normal (linux
>> kernel) pattern of for (i = 0; i < ARRAY_SIZE(desc); i++) instead of
>> being passed size. That's I think the root of this confusion too. I'll
>> post a patch shortly.
> 
> While I really wanted to make this suggested change, I'm just missing
> something as to how it should work, and perhaps the better answer is to
> rework the caller a bit to handle the check inline? I'm not sure...

Sorry Tom, I am just not sure if this is an action item on me or are you 
still looking at it? I do not know the code well but could take a look 
at it if needed.

Thanks,
Andrew
