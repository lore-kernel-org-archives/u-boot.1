Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3E7F99C89
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 20:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0221283B99;
	Sat, 18 Apr 2026 22:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Nu8/EGiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C52383BC8; Sat, 18 Apr 2026 22:01:35 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197B7839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 22:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 99ABD3F181
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776542492;
 bh=RV69wxL64o+/pBYx4Lf1zFpbyESNzL3MsofhIbaoWQI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Nu8/EGiJHfzQW4wWmEyk24pnNNvEkEOWaHMgFa7kVpLmmXPv1IiCdDm0EeZvd8Gbo
 w/S+3pkMpXcP7I4K5HOcrSqXf+4fMSDAUi9ZJceNAAwkABZHOgxh0sDOq4P/UlahkZ
 KjWw+EGCwFNs+huhpTFUHodAD5R3GTkLp6L9pzkmvts55c99eoK9M7OOpe9l4jAijK
 tZr7L8amOe9gvWX4VG3YTOK4l8YqREJY3AAcND87a9cYipZbQ+BEmu0t6MEgYvw+U/
 AickK0jkxRS9XMGbDn5TV3WxU3l+oMR2VOfbnpyf0aRRcdCYgDL6HS11FmHbnIHCWu
 d6ciYniMkj+byJHQaKLPMHS35VKGp1MQufixt9CD3SsNg11fO2InLDwJ/eSByKebCE
 GyvzREd+QgRmT2/5emnA4fhW7/TApxU7Xb5jC9GZqNcqnJ0KLRg/WxpWyd0F0aID2Z
 zgnNlS+/vG/wTgo1YLYjroDpdudv2GnPXf5cbqq0bO6a4CyvtI0kdmGM74TOc0MUbz
 e1B1xPSbA2SjF7sGOldH4FjdcJjv92snAtdJNpvgrvSWLv1tVCP7Cr2Wuyae+PXR/T
 TNMZcZFnXrM4qfQ8YLLaMt9gCioF+/6RTmp9WpQFFOEOkGXf5wHVaCq/Zp0fr2VZNK
 cc9blWQUHYhIfJ8qnuh1fR9k=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d780601b7so1235844f8f.2
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 13:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776542492; x=1777147292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RV69wxL64o+/pBYx4Lf1zFpbyESNzL3MsofhIbaoWQI=;
 b=mZuzjwOVRmCHrTSvZFqVefwAGmjAHsbp2RdEsZyY4c4um0BRfN/iqhm2wjqAWPdpix
 g5SzJB24EooPdKuaOOrfR4b2f0VOqaioUb0wID+9Py0bWZg0zvT52BUVXGFZ8PB7v/V2
 ZMFU3aoEry69WnNBe/m/juiaPvGqY/lb0xvuH7QoQAZEkqbGgcz/lJszH9arQ1N9Bpyk
 nnk1XPmPZ4nzGZ6fk0anF/CVEdicu78pRZ7e26YQlbAGRmGbdNFH+LswYQRBwvEaXvma
 F2f9pH8mEAJPthZSrzIL7+t2umTVVgJPXJH0XExrZvhuSQvKLjAgtlkkGfkL7v+tmCN/
 yMvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5ETvi2EAB+xv7ATLmXC6u3Px8I1XHcDy1eo17+Pi1hZdizMoBYbMvtZhzKcm5Wx2CRaDegL4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+7lFN18x3lcCvycgWw74+DkVQDR5Z1P2zvUvU9zISChPYrS0N
 7W/4Zz4C5/VP2eywxaLzfzLSbVxai3EJx2PLELNHKkRX3YFlIkr2+TfgYCmZIVS+8twH9fieQOt
 LpUy7wHrLLprCkl66rhn0wZxKDjo5gT3E7ivjwerllY6a9eyV+KAqHcRzzxyYwMMnoD5Ajy6hm8
 pWyRY=
X-Gm-Gg: AeBDietoyRcKWA8Zuq31R18w+8UWCM1+Kc34ulSthBM4QV599B9vBXOG79p/PfEFD8U
 DzDd0oCJfbD7/IzBoaiX1QNWTJEPZDgoEHHYkSZuAmp2xnHy2AAsxSPqXSIE6z0KM9oKRmazn3j
 FbrmYNMKINRiyTurmKxF/eVoXcAMahUm8UpbogcR8EF4s8n4gqh5Jttn9SVrTsAYclF6Bus0guE
 RmpcIeK1vn39YWVK4NNphsuEYaaO60zHb/MBxFgcoroH0uX5d6kXDT7fo3nXzXBOtHsnsmTQeot
 rWYUgkypvRb7dVzEG5G7vYJXHNrveI7S9AwGD4gwjU1Dr1BAoKo9+JaUTKzocItRDom0yT6QBVE
 MdldQEzEibU24VqcFH9qLIraR4++r9x7fTEw6qYZr4HQSMcyXRiUy4b6UmG89WaZjRpoRNx4AAf
 5Imu9fJDDLViNHR2fgLJLSUaBaTbiC5KTSE4ERWvB+Wm6kGZNzVMczYGVidc00Suut5Mw=
X-Received: by 2002:a05:600d:8449:b0:488:869c:edaa with SMTP id
 5b1f17b1804b1-488fb74e103mr95551925e9.7.1776542491960; 
 Sat, 18 Apr 2026 13:01:31 -0700 (PDT)
X-Received: by 2002:a05:600d:8449:b0:488:869c:edaa with SMTP id
 5b1f17b1804b1-488fb74e103mr95551755e9.7.1776542491516; 
 Sat, 18 Apr 2026 13:01:31 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc100162sm163557485e9.5.2026.04.18.13.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 13:01:31 -0700 (PDT)
Message-ID: <9447010a-c660-4776-8d8c-4313f4c40ae4@canonical.com>
Date: Sat, 18 Apr 2026 22:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
 <20260418190921.GS41863@bill-the-cat>
 <b67ed115-b040-48b0-b7d3-936dc8fb7dd6@canonical.com>
 <20260418194953.GT41863@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260418194953.GT41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/18/26 21:49, Tom Rini wrote:
> On Sat, Apr 18, 2026 at 09:46:47PM +0200, Heinrich Schuchardt wrote:
>> On 4/18/26 21:09, Tom Rini wrote:
>>> On Sat, Apr 18, 2026 at 08:15:10PM +0200, Heinrich Schuchardt wrote:
>>>
>>>> When building with GCC 15.2 the following warning show up:
>>>>
>>>>       scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
>>>>       assignment discards ‘const’ qualifier from pointer target type
>>>>       [-Wdiscarded-qualifiers]
>>>>         422 |                 sep = memchr(fixup_str, ':', fixup_len);
>>>>             |                     ^
>>>>       scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
>>>>       assignment discards ‘const’ qualifier from pointer target type
>>>>       [-Wdiscarded-qualifiers]
>>>>         432 |                 sep = memchr(name, ':', fixup_len);
>>>>             |                     ^
>>>>
>>>> Define sep as const char *.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    scripts/dtc/libfdt/fdt_overlay.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> Is this something already fixed in upstream dtc?
>>>
>>
>> 9a1c801a1a3c ("Fix discarded const qualifiers")
>> in git://git.kernel.org/pub/scm/utils/dtc/dtc.git
>> implements a similar change.
>>
>> But the patch is not applicable:
>>
>> error: scripts/dtc/fdtput.c: does not exist in index
>> error: scripts/dtc/meson.build: does not exist in index
>>
>> The change in fdt_overlay.c is identical.
> 
> Yeah, we need to re-sync with the kernel again, and there's some other
> issue to sort out. I don't recall what, just that someone else had
> looked and it wasn't a "update, no changes required". So we should look
> in to that I think. I don't know if gcc-15.2.x has released with a bug
> fix for building all of our platforms or not yet:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=121588
> 

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=121588 is marked as closed 
and backported.

releases/gcc-15.2.0-665-g4886dd899bb
4886dd899bbb ("lto: Fix SegFault in ICF caused by missing body")

This is in Debian and Ubuntu since release 15.2.0-15.
Ubuntu 26.04 is at 15.2.0-16ubuntu1.

Best regards

Heinrich
