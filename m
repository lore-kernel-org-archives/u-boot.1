Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28A9CF64B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2363B83E0E;
	Thu, 20 Nov 2025 05:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="muv8EXLQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tmanUBQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A61B84042; Thu, 20 Nov 2025 05:20:23 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6637A83952
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 05:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dBlWT13w6z9t8R;
 Thu, 20 Nov 2025 05:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvXAdrluQiQ0i9LyzWrGguhHfsjOCvHOTnsOMxKR+Eg=;
 b=muv8EXLQWO4cDzK6fYU551rmQ5d0QdyJ9pF6J7bDp+9hOyDqTGSRgOpXS7RYLbSQSgfiFc
 hRNpXa+j/1UN2WIFqizQqDMiUu90kWscBj1ahOmeuPzXaSWNIhwmHM8MCIu6KY/1wQFEdw
 IgUhEf3TAy/b/3aRkv+znYLYiDqTLDi6KtIk7m4uj8w0rGSw31sQQIW3dib28LkNyCjaO6
 d+JbaRUAAsZs6g/hTiesXSiBIYYsWmHzXDX6cjWPUEEIuPGRGv7K9caADcri+I8o020a6Z
 zs56BjnEY8CZyjZEQBILdtdOd2LOAKzRDGdsgx06CaaB5mMxa4vXbXiwQSiwhA==
Message-ID: <4460651f-7151-4743-a1e6-82928cb78b3c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvXAdrluQiQ0i9LyzWrGguhHfsjOCvHOTnsOMxKR+Eg=;
 b=tmanUBQMvXe9E1C29y1vh/rF00LwVSWWaL+5LzYjnZGHUotaYqB5Eb2a2lgzG8H/hQ/jKY
 jkGY6pyzw28UxNk1KLL8l9AEI0iu4AoRhj8c82aHl15q6jFIzXjCMLiEm2Se/7QmP4Rl5s
 OWvv3fHemYW1av/tBgZjoMIxIByhl+Yjxj5UoSedZQlv6ziwIfv00Cd1ZoSnfgN1Ob4Tzo
 2zpEdM+7L2fDrhbG2gOY4ZYn4R/tk0wGeeFBktceaEJ1y1HXMn5Aoq6liYHMDexL3f0gFC
 5Ix7Avh4s4Ff4pfCAUYm7JrResi+gZqofQCzSYunanS52CEDUT1jWw/xntgQOg==
Date: Thu, 20 Nov 2025 05:20:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value
 unconditionally
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-4-marek.vasut+renesas@mailbox.org>
 <CAFLszTgRxLTWjCCbxxme9XtG2E80CrYOesry_86YuagL8uPJ-w@mail.gmail.com>
 <8a4ba995-840a-41ed-b496-6c32965d4ce5@mailbox.org>
 <CAFLszTg6dF1dmJJDh8-2ZjUf6i9+ZOFvWNSxNRS_PBQ3CDNtHw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTg6dF1dmJJDh8-2ZjUf6i9+ZOFvWNSxNRS_PBQ3CDNtHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qfc9kp8omm31ufzuywozw13d5uejs9xf
X-MBO-RS-ID: 6ff931f48f421b627b3
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

On 11/14/25 12:34 AM, Simon Glass wrote:

Hello Simon,

>>>> diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
>>>> index 95f644c31f9..d16cc3d4730 100644
>>>> --- a/scripts/dtc/libfdt/fdt.c
>>>> +++ b/scripts/dtc/libfdt/fdt.c
>>>> @@ -168,7 +168,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>>>>
>>>>           *nextoffset = -FDT_ERR_TRUNCATED;
>>>>           tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
>>>> -       if (!can_assume(VALID_DTB) && !tagp)
>>>> +       if (!tagp)
>>>>                   return FDT_END; /* premature end */
>>>>           tag = fdt32_to_cpu(*tagp);
>>>>           offset += FDT_TAGSIZE;
>>>> @@ -186,7 +186,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>>>>
>>>>           case FDT_PROP:
>>>>                   lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
>>>> -               if (!can_assume(VALID_DTB) && !lenp)
>>>> +               if (!lenp)
>>>>                           return FDT_END; /* premature end */
>>>>
>>>>                   len = fdt32_to_cpu(*lenp);
>>>> --
>>>> 2.51.0
>>>>
>>>
>>> The can_assume() is there to be respected and helps to reduce code
>>> size. What problem are you actually seeing?
>> fdt_offset_ptr() can return NULL, and it does in test_spl on sandbox if
>> I recall it right, because the U-Boot code passes in offsets which can
>> not be resolved properly and that makes fdt_offset_ptr() return NULL and
>> trigger SIGSEGV when it is dereferenced here.
> 
> That sounds like the FDT is corrupt? Here we are parsing through tags,
> so we should really figure out why it is corrupt.
> 
> But if note, then we should not be passing bad offsets...so what is
> the root cause of that?
These four [1] [2] [3] [4] supersede this patch.

[1] 
https://lore.kernel.org/u-boot/20251120041439.817233-1-marek.vasut+renesas@mailbox.org/
[2] 
https://lore.kernel.org/u-boot/20251120041504.817264-1-marek.vasut+renesas@mailbox.org/
[3] 
https://lore.kernel.org/u-boot/20251120041526.817288-1-marek.vasut+renesas@mailbox.org/
[4] 
https://lore.kernel.org/u-boot/20251120041613.817311-1-marek.vasut+renesas@mailbox.org/
