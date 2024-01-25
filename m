Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E598FC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A56187B58;
	Thu, 25 Jan 2024 17:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="srB7LH24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B066387B63; Thu, 25 Jan 2024 17:26:11 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED62879F6
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F4021404AA
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706199969;
 bh=08+pix+1okrugBYKi3wR8ubR8VtAS812Xiw1h8dW4HU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=srB7LH24hFYfeSIO4PT9j+/w0fl+w139u1hnrsOtGOZccgA1z21mMq9oYHd4FULXe
 77+FnvbjVd9+djQn1VIW4deGxlNpEmV8ULgAKMACildpfSOCu4yxJBb3Adb+dO6CMY
 QdOGSlHEQImk992ovm2oAPItky2IFqc7w1nWrQKjuauLgHL252zlWmNM1ANzFArhxv
 5ZPGTJaLS7kO56S/Y7Q8OfefDBvUBa6zRoDSkX5Mxemv2EuDYA1EpDR1bK6y6r5AU2
 /sqUGZYjfyHj4fAXIqJ5lEKbdVOAQqxSDrUPsd8G/a1twESmkVo+Vg78aEJO2CBnuj
 yW0JV375W6sxA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-337d2ccaab0so3805090f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199968; x=1706804768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08+pix+1okrugBYKi3wR8ubR8VtAS812Xiw1h8dW4HU=;
 b=UML+D8FWYlzbcGuNCBE2W7a+l40iuKUvkdQGniLsEwWzmBLqNDcVl9LXz6gc+Zk+Wm
 Bnz1e4JF9eZc3wvQX41+t78+8QB8a1wvS/Kwc/+/4zqPS/6XrqR8oN+bSkiTYfr0YGtn
 k2TsCcf0Q8foeIOqA0lS1GS5w0oTdDpzL0aBPl9rtwslKnMGfjKC+0nrvLnqI8rdG24L
 nioS7za1fsQsMMWbHFC2PcNmQeSaGVGKlhZy+VVQVwly+5JGoScZZ2jP1tddve/FgM6/
 d914V/SmJvX4S6ozRrVVKCierJvx/pWQKRvziCRhG7UPKDPx661+jDBH8MVaJ5l+RC93
 Az+Q==
X-Gm-Message-State: AOJu0YzMfWE2FNegilfYDCiJGG9ubkcSy2bKY0W/8BJ8kuL8bR7cN3o4
 HFL+WpsRuknytEOTuwxmo0BXOUKmf19uHP7CBhA31LNqrmZFMD+w5/T0JI1txkhglcxWYlWWeYN
 oosZ1bMpiiysVGsZQKgtcF+SB7btkXRetORYoc1JrUTaEC0kk8ZVW5L7XpjXgumcInOw=
X-Received: by 2002:a05:600c:2196:b0:40e:71e7:b2e4 with SMTP id
 e22-20020a05600c219600b0040e71e7b2e4mr823965wme.60.1706199968630; 
 Thu, 25 Jan 2024 08:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkBeg+qRwljAQBI5yXDK7ubjv97aCpV2PfEDWB2igCwrTyirbYEquMTgQQz2/kWyfcDLSrlQ==
X-Received: by 2002:a05:600c:2196:b0:40e:71e7:b2e4 with SMTP id
 e22-20020a05600c219600b0040e71e7b2e4mr823952wme.60.1706199968251; 
 Thu, 25 Jan 2024 08:26:08 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c198f00b0040e395cd20bsm3128260wmq.7.2024.01.25.08.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 08:26:07 -0800 (PST)
Message-ID: <fe5d249b-70f9-4465-9c65-90c16d2c5e82@canonical.com>
Date: Thu, 25 Jan 2024 17:26:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] configs: enable smbios command on sandbox
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
 <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
 <20240125161414.GN3652023@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240125161414.GN3652023@bill-the-cat>
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

On 25.01.24 17:14, Tom Rini wrote:
> On Thu, Jan 25, 2024 at 04:54:37PM +0100, Heinrich Schuchardt wrote:
> 
>> To make use of the Python smbios test we need the smbios command.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v3:
>> 	new patch
>> ---
>>   configs/sandbox_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
> 
> We should do sandbox64 too I think? Ilias was saying something I believe
> about testing one path via sandbox and another via sandbox64 (since they
> have different base dts files, putting stuff for one code path in one
> and stuff for the other in the other).

Currently the test asserts nothing that would be sandbox64 specific:

     assert 'DMI type 0,' in output
     assert 'String 1: U-Boot' in output
     assert 'DMI type 1,' in output
     assert 'Manufacturer: sandbox' in output
     assert 'DMI type 2,' in output
     assert 'DMI type 3,' in output
     assert 'DMI type 4,' in output
     assert 'DMI type 127,' in output

In a future series we might check more and then adding 
sandbox64_defconfig may make sense.

Probably this would also require providing text output for other SMBIOS 
table types.

Best regards

Heinrich

