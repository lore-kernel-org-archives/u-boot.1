Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1775FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC7F848DF;
	Thu, 30 Apr 2026 01:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k7BY4aqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC409848EE; Thu, 30 Apr 2026 01:47:19 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62EE848DD
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67845996252so608267a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506437; cv=none;
 d=google.com; s=arc-20240605;
 b=lMSi0wbb5qeSTJcFas6nNiklVsn6h6u4TQPuKHqFPzDDXoRJ32jaYfsSHMoexdBroK
 tbPa3KWkEO0VQ7aaKUOafMIkW28hPyEJNktc9ojkSYLgX4l9nE5kRix5A8kVkqD9wtHG
 g+v16iXB0tv2czBcvWqqTkqZ1t8N1i/D+XoDv8wjQRW5eeGtDuxzS0MfpnS2qg4VTlvy
 mHWjF93yxpfSvrznJR9zvN0bksNijpvXnElXBYjvyEoEm4uDZFOlltdtnWmfMilERYxJ
 uIaIhfXasA6dQjVvODREJ5n7D2x/DpmEIZZyOTVARADalxWxjMprEtnSjoZwxfSYZ0n6
 DoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z8WqKfntjqsKRzB1jOCnJc4F/c+UrCCAz+R5TWVdVNg=;
 fh=Prvn1fe1rDKzBIL6lkWTf+pyVG+Vv1XKXJVwhTRbLUU=;
 b=FM01vvvyTWRoetFQslJPQlDWWeEGotFvC9B2M0qILYwDEuSW1+IBcOOmkkdWvxlU3n
 jDmE7ZUqBcOMy3WOLhXTM3MiHAg4BEiaoSv00iUBGo4Mj17heyQJmFZMAEV+TkhYTA+t
 4hQkurHzxaBJ8VhNbAQ4owT5HDHvrJOPUE7LvYptoLiWtzEP5cXNkLUutQh/8GKQGnnz
 q2oOsKXjFnYimZqzvTFmiyKy6MB0hGhWGUEokmXgxXgMqK8vRq1Xxf3V7eYxOSUUpVok
 mV/faKDNc0HXs+nW0wT94tPanPp4fD4ZiSR5jZva/QAW6U0KL2Mtvq7EdvCQR0MnTh6Y
 Dvhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506437; x=1778111237; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z8WqKfntjqsKRzB1jOCnJc4F/c+UrCCAz+R5TWVdVNg=;
 b=k7BY4aqhXN0Jpbq2t7i/lmqM5A2YVaNgbDy8JTFihyzwChrn9Y9+R2hOzHiEp7AZSl
 Syj4n/kneLvrMk+LnbqhVYG5TJuxjYyonm8IuuRARtPGnJGiSeYLrbdrdV8Kv7okqxWe
 rnGd9qk+kgPSYqZNuiqtCafnrvo5eYjjDsSJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506437; x=1778111237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8WqKfntjqsKRzB1jOCnJc4F/c+UrCCAz+R5TWVdVNg=;
 b=OAwtO7IOtTjXd1gGzcv6mKDW3EUSKf13DBG6ZG6+r4jZ0EPuJ2vQXuZa455XY5WrmC
 9VJKAF4xtDFwgnzPGba6eldqbhnU2iOrXwJkm7ZULcDIDM18+4z2CVXiF2gw4eMQiNzP
 ZBVaVijDAjgmTeXKReEJTNo801kbiqxyZnzB8ovtv9Kj7CLPT/Holf7x/qFo/fkSh1m3
 9ASrinPtI0D2OP93euKkW+/WBB0N2mqhYyaYpzmFxRN9sRUqxTc5Mkl87E9xKMpXTHkS
 UEMudYnmtmbvORuPHatDOk/yXsyM01FAXjEw1puuFgKmLtiriZdPWtGDudWwgbeKgWaS
 yezw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ikjwfX+imXPwckhF8vERT432M1z/gGa3Id3fKbVdP+CZhEJ93sEddRlQroZ+jrnYII0q5q2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyTO/AJK7uXlzA6gnp6/UMP6BCXNgKeOY2CzrDzzTuE3jZIjCCy
 4LwFgBOM94/MZn9X+s2mpOJ1F+wB4zlRullw2iT1EumdhrLIY3X7Afl4kPJh9I68BXI2wvQMd/c
 kMDB9EhyoYsWyoz82RPTF9Lvplfw4EdvSAJhj+QLq
X-Gm-Gg: AeBDieuVJ+OetVAcgQkeoHuGkCgP/iEIh7Ai799dow3zJx+f8fUtcoWTSdS96BR4kJp
 frRpT5mmNdCNtbw9fOrYclaSy4dmrrMV01Xm+gQIdV8EFw6k208fFs/doYy21HKDZrEbVWz4nY5
 D1atfQsRZq6P9+BfkOeS3/TrdZn4dWjkGH/yCOytlaAGK2UKGytHl4jCPUwe/wKJSIOjHZ35tma
 X6T9Mo7mOaTK12yI0eejIE5L3cDjZKIf48YVCB6zatvwamtw0ooFVkxPqoF/02PfOlsfulvlo0V
 UDkQnbIqQGvoB+Bt
X-Received: by 2002:a17:907:94c9:b0:ba7:670b:f074 with SMTP id
 a640c23a62f3a-bbac49d2559mr44345366b.2.1777506437291; Wed, 29 Apr 2026
 16:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-4-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-4-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:47:05 -0600
X-Gm-Features: AVHnY4JRbqGSYAFnpuEFwCO8ZZnobhIYsbsP4jxBiQj8w9_Pmv_51IAm7ODQSz8
Message-ID: <CAFLszThq7yub=hHTZg7oofU-Kb6AJwuS2cwbq-6y47t+XMOTfg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] arm: mach-k3: Explicitly identify TIFSSTUB
 images when discarding buffers
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> arm: mach-k3: Explicitly identify TIFSSTUB images when discarding buffers
>
> The board_fit_image_post_process() function assumes that all TIFSSTUB
> images appear at the end of the image_os_match[] array by using
> the condition:
>
>         i < IMAGE_AMT && i > IMAGE_ID_DM_FW
>
> However, this assumption breaks when new image types are appended to the
> enum and the array, causing unintended image types to match this
> condition and having their buffer sizes incorrectly set to 0 with:
>
>         *p_size = 0
>
> To avoid this issue, replace the range-based check with an explicit
> match for TIFSSTUB image IDs.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/mach-k3/r5/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
