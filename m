Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5133C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 08:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D058688261;
	Wed,  5 Jun 2024 10:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jBCuTxC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A322882DA; Wed,  5 Jun 2024 10:11:33 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9F987D43
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 10:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35dceef429bso318702f8f.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717575090; x=1718179890;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wlz17xMbyp09UYjWNhruTeHcQXdyBvATGg5p7b69Bw8=;
 b=jBCuTxC6/4vTeaK7iyzEjFnKKRNNk9F0SnmrSnFTTF6p3f6RZElw3qBZj6LJoHS7pK
 sZvEN5fObPSkfICp/5siDvK8oeQLBkDRl24NXegWwGMS7gzKghlYZgTuFNU/EZvKqDeJ
 0jkcZHRGB6/ReJMA1mPM3aWvDotuu+mI+Ye7UdmnaV60KDyFDtDCEG8yNMK/dWVYh/wz
 cpQ5PzvEBHxhN33SN1kSYmHwCLeCzgYukt3te3wkXpH5ijlf0Qq5/4uZ1AnNN1b2tuVu
 NcWg9fT9K62XUhnTe32Q35LNZv7288fYaoTDN5Myi8KRw7wFhj0SLUNGpUYJ8J6FcmnE
 II5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717575090; x=1718179890;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wlz17xMbyp09UYjWNhruTeHcQXdyBvATGg5p7b69Bw8=;
 b=jq30EotLzaGkzXSSBvK0xEhfI9dLXm9zuNDbRYs8U17+uTXGzLDVQ1Dv1YcLd2dj8K
 1VtHPB1mPOg5NK+Nd/YNahCySs8hYMiMdlq9Q2HnAKc4kfRe0SrNucPeTej37kVZjVH3
 ioa+cZumi5ojaxnN44h2YvrXzNCMtpe5GdxjulA6gMkJvPQx8bhQmUUTaB/mYuy/JW5j
 hmSTzxtLa6VneeD0LaKHrCTnrAPlclRdDaQ20T8UbXG+8lr0S+nL7MM4HhI/JuMW1qez
 5qPvVfsvAepxEFqjCsXN/LMVNi/ZeK597LK3xFyruNKvHuHa73a7RDSavCzJyqM4g7Cp
 auEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsUHlyk8JoV2XwJqgjjgTiDOdorHyBXejz+KNeg9yR3nuMy3vbAlQeRhMEuBrhCxqFiQE/8rGRZEaip8w7W2Jrr5419A==
X-Gm-Message-State: AOJu0YxfXOrp/Z/W1/nwKc0DFOCCfuHCbd/4bdIFlKxEg42B34natJxQ
 evSuZXmFSk/2PNCEQPKsmK0LGGxdC+GyOV2rH6OaHgResCtu6r2qJV/u2O3HTUs=
X-Google-Smtp-Source: AGHT+IEEIepB9oWyWFDs8vrMV/Q5h1Hg1AENHLV5UEb/37SqBr7TLxC31xsuJQ9PPZ0pzFWjfGXO9Q==
X-Received: by 2002:a05:6000:1c2:b0:35d:c1d9:147b with SMTP id
 ffacd0b85a97d-35e83982623mr1417938f8f.20.1717575090061; 
 Wed, 05 Jun 2024 01:11:30 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bba6sm13571808f8f.104.2024.06.05.01.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 01:11:29 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
In-Reply-To: <09afc533-681d-41ce-aa3e-5cbcb0469b21@cherry.de>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
 <09afc533-681d-41ce-aa3e-5cbcb0469b21@cherry.de>
Date: Wed, 05 Jun 2024 10:11:28 +0200
Message-ID: <87o78fizbj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Quentin,

Thank you for the review.

On mar., juin 04, 2024 at 17:25, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Mattijs,
>
> On 6/4/24 5:15 PM, Mattijs Korpershoek wrote:
>> According to [1], we should use bootmeth when describing the
>> struct bootmeth:
>> 
>> """
>> For version 2, a new naming scheme is used as above:
>> 
>>      - bootdev is used instead of bootdevice, because 'device' is overused,
>>          is everywhere in U-Boot, can be confused with udevice
>>      - bootmeth - because 'method' is too vanilla, appears 1300 times in
>>          U-Boot
>> """
>> 
>> Replace all occurences in various comments for consistency.
>> 
>
> s/occurences/occurrences/

Urgh, I guess I spot typos from others but not my own ones :/

>
> Sorry, was too tempting to highlight a typo in a commit that fixes typos :)
>
> (Don't send a v3 for this please :) )

I won't. I hope the person applying this patch can do a fixup.

>
>> [1] https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.org/
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin
