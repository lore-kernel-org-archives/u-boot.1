Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C63CF8849
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 11:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8895C840E0;
	Thu, 20 Nov 2025 12:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="k8JoxPx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A93840AE; Thu, 20 Nov 2025 12:57:06 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425A8840D7
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 12:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dBxfQ1gpZz9vNs;
 Thu, 20 Nov 2025 12:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763639822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=034d/97G9y1bKsFpyIgNYozlPwz9nX6EEJCqhleL3ZA=;
 b=k8JoxPx6fSeIPopuW1h7/W7R1+XJHZFWadUezAO/l55ozG3piM/osuz9h6DtGMqQzxSJTT
 Pw73zHMe/wTw7q2LyfjYOK1NnvVksluOI+d7eP2pYZyO5Jpy/4jnUzCVyaOu0r+FBRbEf+
 94r1CL42Opp2fN+ePwgwlo5Hjgp9pHar76Cl1lKeyjQNnkiYYZpT33+NZiD/Ooc7nD+hax
 Yf+V22b7Rxp4W6G1moMV5fNP4tia/LYDUxFzRStOKzj83WFXkHfJQtZOTBzNuHXIxPSXRK
 Q0qE54xN7NNAbNbFgczJxu+KdAkgdL7tfCRA0g5gYTrHJD4sy9RRLFmTBGsKMA==
Message-ID: <2e4d6bfc-c26d-40ae-a565-bf1ab2c341d7@mailbox.org>
Date: Thu, 20 Nov 2025 12:28:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
 <20a873e8-d17c-43af-88af-ca14219859c3@mailbox.org>
 <CAC_iWjKWr-J3pxmwT5mCDXaAiRxYFiX=hfHGdp2x81-0WzbEpQ@mail.gmail.com>
 <7a84357d-c4c6-45f1-a0bf-d21ee7a19a19@mailbox.org>
 <CAC_iWj+tKuw-cByFDQMceb6w97KZ=0CzK3CWyA4ceC=eQ3L_CA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWj+tKuw-cByFDQMceb6w97KZ=0CzK3CWyA4ceC=eQ3L_CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5434ad5cf6d4f163044
X-MBO-RS-META: c3zxz18ifnp3pc88fswbjgsq8e7fgisw
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

On 11/20/25 7:10 AM, Ilias Apalodimas wrote:

Hello Ilias,

>>>>> Initialize img to NULL and make the check a bit simpler to read (or
>>>>> get rid of it overall)
>>>> This part ^ I do not understand. The img variable is used by
>>>> fit_update(img) , where should it be initialized to NULL ?
>>>
>>> The patch might be misleading since it doesn't show the entire
>>> function. But from what I saw 'img' is only initialized when
>>> 'if ((uintptr_t)image & 7)' is true. you can initialize img to NULL on
>>> the declaration and just check for that.
>>
>> The 'img' is always initialized, see this:
>>
>> "
>> +       if ((uintptr_t)image & 7) {
>> +               img = memalign(8, image_size);
>>                   ^^^ ----------------------- Here it is initialized
>> +               if (!img)
>> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
>> +               memcpy(img, image, image_size);
>> +       } else {
>> +               img = (void *)image;
>>                   ^^^ ----------------------- Here it is initialized too
>> +       }
>> "
> 
> Which I somehow missed reading the patch...
Therefore I assume, we can wrap this part of your feedback up ?

Thank you for your help !
