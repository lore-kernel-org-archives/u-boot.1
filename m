Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A41FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC3B84894;
	Wed, 29 Apr 2026 16:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AEKQDJfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188A984855; Wed, 29 Apr 2026 16:42:27 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342ED84894
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C18543F7DD
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777473743;
 bh=N3yCeZvcsjUY4SixfM+7vopkbLS6cJUZlKSA4YGQALI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=AEKQDJfUfYG4ngQX9TknUxsTaYxkf8Nnffh8kSGB9s1t3vRkKxH5PqmxHBcTtS4yz
 dvjI9MZFAtnEAJ8/3nFBgoJho5MahZp1vVVX2hSdHREhSKgupWra/lcYdo754fWC/7
 bk7XIscOEKu3qw/T6LW/72zAxKA/eqGiGHtuJMJyzVS0veq9nT2WzdTpJj8463Eo9f
 cdQTZiem8sdnvHggUqm/8HTNs108rvmt2OLl8xqwUZ3t7Nj3t3bLoSBq2YEv9ChAYj
 B7rpKW9LkD9axHdA2dc6uymdr3aW4zHu6VyfA2cuseDdKHhdMRktuBNojnFxM09WS9
 bv4fhRmIziwfQgKC/SXE6gGan4SrxEd+B7pUJ73djEUW3uKAnWjEsTOr0ilTJY4deR
 hgW8GUOuRH/VUurJq/Gqswx8A0qMyIwF9KRbAD3EZrByFWqk/OiwcjugId8BiMNgcm
 b+XV0bbItxz0rMDRe5G5CzNDecdxQp/yCCYl5a7unHSsTtHDB5QI+dQsvbPA0k+RjJ
 zMhvJBCLoaGj8eAUnrgp+518g5kBhIF8spYvkuP9dbJtgXWl+CdXcOLuvK7ki7B7U4
 zOkosq7aUWabfuehkKd3Iq33aec9pm5fpTYWv6YnhC/GlZ1KcD8mL9By7oMS0ZDFtY
 T97erCZzyzQ9cZAG/9mkH9Ws=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48919890a95so74203325e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473743; x=1778078543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N3yCeZvcsjUY4SixfM+7vopkbLS6cJUZlKSA4YGQALI=;
 b=E2YXbwM6qFg8yLZ2B5FpQECgWIVjeIJpED6SUwqm46hbDpEU4sVx0R3VfUTOKDFz8C
 //1DXfc3xofOE1SV20/Lkxg3GYkXwJO5y5agojuFTGvSn8n5bxexa1TyattWa4r8iX4L
 nyRu0WCeldJX0M9e2N9kUzVNWaSJT/TuEGeRDW//BwStSy7iI6gUK5m6SpaREc4CZgy+
 R8ZvMCXlrr9whGqvyHwcxEhUkdewPmHQAYARqA6OvN3y8i/I5e/I5vorpe8aIypRV4+h
 b0/QoNUOwMu7VTEJ6oHxFKMsxPSJf2/N6Y6Qv+frtGG8U62jxul11kTW23WeAIKGM5i2
 mEUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WoN2YfMI3zEfUlnLkyvGpjPaLBzRccOwsZvESoO99CpwfVsQChzbVw0G7eYLKxkt8g81Yl4w=@lists.denx.de
X-Gm-Message-State: AOJu0YzpqieTZcO6Zszaqh1hI+VvwJKcDT89CSTvSKsYkUy99/HQK1Tn
 YlxyReol9VkO93RiD/Vb6vsPp7v1xtzcZpTob1EJtI9Ttr1qvXbNGWt0tovwfsjZGq0pfyTkiSZ
 NpOuN46Lh56vuOm/zR+vwzxtbgdbi1cUJITrllKn89SCfwFJ+NU3TXQ/orUJxEpU7iLLCoAs=
X-Gm-Gg: AeBDiesp2zWkCVLzITRCAgB6FQB+Bv/bXi6RvxoIhNVozCuF6F1e8WkTzOj1SbT+W55
 MXXedQq+/lwVajXoLBCdS1zZkfrHHLirn4KKN60pZG+FZkuz5SRqEqTTI2Zv6Syftu6MBNhdnrD
 OluR3zfDWO7uai7g+4klG29tLlCuM+U1/6JCVa7kCQSluz71b2r5BJOwnFbDNaGp6o9c8v2pPq9
 f0cgmh96RJ8hesSCqFN1s0+Adak3gwiPg7r3/dWIknIQb9AhFKMuSO5Yroj5Cl1/RjQnt7jHArm
 kqTzOQnJvSVBLdwDjv9a5iPrPdkArbBNCbJq3NYLlMlxnn5Jwkgk1gvsYwgztJc+G4f1TK/Pk5T
 glkTHozYQWjsw3a9Sr/XFtJL8r1EzKLJoccTB1STtUQpQtfdNd8blojDN3/+5CjvGFVjbNUawg+
 xpjkrbrRmrKrvLlN8o1upjBhMtftp/csCg3XKi+83kEJkKWA7Ek3cNety8BXDt1sNcmOw=
X-Received: by 2002:a05:600c:859a:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48a7b519560mr52943845e9.11.1777473743299; 
 Wed, 29 Apr 2026 07:42:23 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48a7b519560mr52943345e9.11.1777473742857; 
 Wed, 29 Apr 2026 07:42:22 -0700 (PDT)
Received: from [192.168.103.108]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c5be6dfsm62019835e9.10.2026.04.29.07.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 07:42:22 -0700 (PDT)
Message-ID: <db5d98f7-1036-4842-b70c-b6c1e3625ded@canonical.com>
Date: Wed, 29 Apr 2026 16:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] .clang-format: add U-Boot specific for each macros
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <floss@jetm.me>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20260428142848.48156-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgKkn0cwfv97FBVDK+FdCM-6BfasCvsA2oDe5qdzeuS4g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgKkn0cwfv97FBVDK+FdCM-6BfasCvsA2oDe5qdzeuS4g@mail.gmail.com>
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

On 4/29/26 16:21, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-04-28T14:28:48, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> .clang-format: add U-Boot specific for each macros
>>
>> Formatting via clang-format is controlled by .clang-format.
>> For each statements should be formatted with a brace at the line end:
>>
>>      for_each() {
>>      }
>>
>> This requires clang-format to know that the symbol is not a function
>> but a for each macro. We use some for each macros which don't exist in
>> Linux. Add these to file .clang-format.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> .clang-format | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>> diff --git a/.clang-format b/.clang-format
>> @@ -748,6 +748,57 @@ ForEachMacros:
>> +  # U-Boot specific
>> +  - '__for_each_child_of_node'
> 
> Should the 'git grep' recipe include drivers/ and arch/ as well?

Thanks for reviewing.

What I did was removing the directory restriction completely.

If we really need a comment, it would have to be in the # U-Boot section.

Best regards

Heinrich
