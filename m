Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6380DCF58C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DF683F66;
	Wed, 19 Nov 2025 18:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gW7sJWuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F52F84008; Wed, 19 Nov 2025 18:34:58 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15E584008
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dBTBk5qqlz9spJ;
 Wed, 19 Nov 2025 18:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763573694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOw84VHfL2pRdCLc4jQjalNRqP09vsGd7HdXNna2MyI=;
 b=gW7sJWuj4DyqN7Np1xIa7BKpqcpqxxSEIRNYWopJ6VGMO1d5O2BQXx4AF7pBMLap+qe/lr
 UtXU2FJauWnEEDsRmN0LDki9vmbu1pV7WeuPkajQk1UaHSNK9WRdDu6wFyEKCDyZ4oNwCi
 V6nih5ewpVUkB6tB2LMQOL9FXYN3dFeBoW6//3pA+AJO1EdDkYH6+RjGPf7IZtstIplO1S
 nWLn5kuo7KF05L1pe7T66i8bEHaokDv6BNsJ9KUpyj9mw+ms1dEDv0btEK8Ad0TweFHnxZ
 lLnQ1qXoW9vYsYcS9cERc4YTW7gxIx4pqB2E/J2dx+mcsKcKKf/EabvReHBugA==
Message-ID: <7a84357d-c4c6-45f1-a0bf-d21ee7a19a19@mailbox.org>
Date: Wed, 19 Nov 2025 18:03:35 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjKWr-J3pxmwT5mCDXaAiRxYFiX=hfHGdp2x81-0WzbEpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: srukc1gsm17d1e7dwuukdf88zx387ru8
X-MBO-RS-ID: 9743cf79391876569f1
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

On 11/18/25 2:56 PM, Ilias Apalodimas wrote:

Hello Ilias,

sorry for my slow response, I am buried under emails.

>>>> +               img = memalign(8, image_size);
>>>> +               if (!img)
>>>> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
>>>> +               memcpy(img, image, image_size);
>>>> +       } else {
>>>> +               img = (void *)image;
>>>> +       }
>>>> +
>>>> +       ret = fit_update(img);
>>>> +
>>>> +       if ((uintptr_t)image & 7)
>>>> +               free(img);
>>>
>>> Initialize img to NULL and make the check a bit simpler to read (or
>>> get rid of it overall)
>> This part ^ I do not understand. The img variable is used by
>> fit_update(img) , where should it be initialized to NULL ?
> 
> The patch might be misleading since it doesn't show the entire
> function. But from what I saw 'img' is only initialized when
> 'if ((uintptr_t)image & 7)' is true. you can initialize img to NULL on
> the declaration and just check for that.

The 'img' is always initialized, see this:

"
+	if ((uintptr_t)image & 7) {
+		img = memalign(8, image_size);
                 ^^^ ----------------------- Here it is initialized
+		if (!img)
+			return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
+		memcpy(img, image, image_size);
+	} else {
+		img = (void *)image;
                 ^^^ ----------------------- Here it is initialized too
+	}
"
