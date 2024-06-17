Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1476C2BA18
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2868826E;
	Mon, 17 Jun 2024 16:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wDrp9J9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48586882E2; Mon, 17 Jun 2024 16:22:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2749B86EB5
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 50A143F724
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718634134;
 bh=3hNJ9WTmSoo29TRfY8ovzcTnn2hpnLOqPw0mjjWwh5w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=wDrp9J9ygEl02r0U/PzYturUphH9Rn1XYFk7cF/RJNypZYBN2XEug1TB/9GZwPYL3
 bcehjuUQC8KLTewpJyXrNMDfodYKGCQWaAE8aTWz4AvYPtq4lxy6oeWftrarpcrPPn
 VyGY9IC+Tiu0o49E0AAgpZFrdNAI4q45O2dZ8RGHOBriHSkcrJTnFW4zR3UY3Vl0ev
 nSd3hBm+b4FGXLEYEdDbsE59kwjqaJSHdUgkJuiUuPVF0/N3R2q+Wb0jHIJNfqWQ0S
 uQuaDp8UcEIxIOdEZHfYWxxlVTk3ga+9Xbvyh51PStJxwN5DYPp32WUPkaVunOZ9wN
 h9kc2TQxpt+sA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36073b9e266so1930064f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718634133; x=1719238933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hNJ9WTmSoo29TRfY8ovzcTnn2hpnLOqPw0mjjWwh5w=;
 b=i9c2MH0/W6BPaMbA0hwonKiNGrddTUPGzG6NHhdyqin9FeBmQJHs4oBnI3xJ4x+pLj
 zX+BwleaeiRNPLFXCuj+NK5p9hmGneM5zbRUTb7i3gseHz3nF5BUBwJwRoyAAg6RWm2O
 KeOp9gThRvw9bqDBi+6KKHJzs5acEAygx5SeDTmkaN5rL2P2V1gnD3CTjY3WUhclv69j
 EEMi6D0hDQpRHlsAlJVxyTOjazQdJzl6QvjULZntgLpSuvWkvUSodx4LrCaIHo+YqfzR
 18JTHMVq7Q9J57lo8FvtDnaqm42YAQa9k9xEfJr5Juuj0enz5M6E3l8OqsMTi05PgyA4
 BHvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlokT66NG57I8zq2r9yuoNiCuJ4uPZK1ld/xSlKic+DeHxfqbM7wa9mgJ1JtNNaqiLIxozZIDQyHw+Evyofr8NcgMIUg==
X-Gm-Message-State: AOJu0YwGkCP0uudZkuuBnnQGwxYDrHsdYYoz4wMIAK8X8qVtvUKo93Bu
 UsFuoGEYoEiTQzN6svE01Evm8rZuGljpSotZf6gsGnPIB2m5uHJ1hVHEUJe+3J3b6NhJqXrliL5
 DZFz7UCZPgxBA8UAAlxaMJN8z16hU14gPjdiJCQyHWicB+beW4FKzspRU0cYf6wPJhHk=
X-Received: by 2002:a05:6000:92a:b0:360:9392:4bbe with SMTP id
 ffacd0b85a97d-36093924c32mr3182274f8f.68.1718634133448; 
 Mon, 17 Jun 2024 07:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0APBDXCLvuIhuw5j5fI9+oC2ks+ykg9PZJm0fRPV3maJ3AGRxzzLXhOmTpCeSkZZ0nA5vLw==
X-Received: by 2002:a05:6000:92a:b0:360:9392:4bbe with SMTP id
 ffacd0b85a97d-36093924c32mr3182260f8f.68.1718634133039; 
 Mon, 17 Jun 2024 07:22:13 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a1esm11912090f8f.24.2024.06.17.07.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:22:12 -0700 (PDT)
Message-ID: <321b9695-a805-4b24-9f1a-502799c57eb4@canonical.com>
Date: Mon, 17 Jun 2024 16:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: update requirements.txt
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
References: <20240616085948.16692-1-heinrich.schuchardt@canonical.com>
 <CAFLszTh9Gj_xFgu6a_ErcG5JfLmB=xzq91oXBfuDzUzMoGRFqA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTh9Gj_xFgu6a_ErcG5JfLmB=xzq91oXBfuDzUzMoGRFqA@mail.gmail.com>
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

On 17.06.24 15:53, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 16 Jun 2024 at 02:59, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Update all required Python packages to current release.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   doc/sphinx/requirements.txt | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Does this fix / change anything? It is good to keep up-to-date to some
> extent, but it will break documentation for existing checkouts, until
> they refresh.
> 
> Regards,
> SImon

Thanks for reviewing.

There was no bug but for instance an outdated certificates list was used.

The new requirements.txt is only used when you run `pip install -r 
doc/sphinx/requirements.txt`.

Best regards

Heinrich
