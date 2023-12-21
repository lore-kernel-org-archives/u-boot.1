Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BEEC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4BB8786E;
	Thu, 21 Dec 2023 17:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ffOr2eJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F28728787E; Thu, 21 Dec 2023 17:07:38 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5545877E5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e30b28c1aso1296047e87.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703174856; x=1703779656;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A0zzH/vBq2XqKhr5tzGMNeVqhxK7rrXe+zAIEM0foGY=;
 b=ffOr2eJbfZkLSD+5JTcYe6UDX9c38FhXhMbDbT9Y2DYQlnzQ+euyfLlUJ3YsFtAi4L
 JxL2quWGLN943RnyF7cFtjfv71dZbAl+z7NWCRsmsx7kQ2u6u0mhUX4/2iZONVzwrfqC
 trffoB84J3xWC36GAjybv7xEk+49Jq20g7J2dvEQyDHhH/VgM53KpXl0H0aDgTgdRj1T
 XmmXN5he1ilZLPRcdMhbRRFaBoaTU2yI9SwiLVSiLjjvFWlH2AyMXXKgXNI+veCerCoo
 Qn/AKCfmtjSPtecCHIgby3Z52bveKO47FQaw9hSZi6OfKg1ABW0smJaFlxE/joRGhCq2
 r7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703174856; x=1703779656;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0zzH/vBq2XqKhr5tzGMNeVqhxK7rrXe+zAIEM0foGY=;
 b=UgAoyYxjWcnytUeZXVD0Ds9TVhNoysfNCxhBTDOEsp34clnsAvBO89C/Y0NXaI1cFL
 L4fssaY81QqETL/8vdsWgv3IAHsGrvkDS7Pb6gXZFDogx9AXkrHmvYHMhjNw8yWXFZDF
 lG4ZZ9ADaTcCGPyN/qs4Af20WnHReSGnk1HElIscTNCAmpy4MHkQm0UMo322c4Q0OhBi
 3vBxGCAeIQYkuQhpCYTRJV3rpjZLOI4jmkVaLnpGwLC+FytmzeTXEyaKLGFQq5f0JsAj
 QGW0JPUpyfdxONL8qcG7OcYOdFpvm5XUxNCNZJJsd5E1Pwu6tE49tonU+lEIYx3pzqeX
 ZsUg==
X-Gm-Message-State: AOJu0YxZ/1fab3SnW957IJkHIANJx2RImVSwsQMIfGyV3w63B9zadFyL
 tj/nCxfRRisOHmE5W1aj3PoMGw==
X-Google-Smtp-Source: AGHT+IFNAazV6Vyd8w/+xuel+h+y/1JdsUBCg55sihnmOVurxkdBUp62V4uonfZELz9iPyY/jM2p7A==
X-Received: by 2002:a05:6512:3045:b0:50e:3776:2e16 with SMTP id
 b5-20020a056512304500b0050e37762e16mr4886995lfb.73.1703174856057; 
 Thu, 21 Dec 2023 08:07:36 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 bi18-20020a05600c3d9200b0040d378623b1sm3801442wmb.22.2023.12.21.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 08:07:35 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: Fix ANDROID AB unknown file entry
In-Reply-To: <CAPLW+4nH3XO1kZrpsc3Q-g=8eX0fuDqTy1f-etynyXntTAFnEw@mail.gmail.com>
References: <20231220-maintainers-fix-ab-v1-1-dd16fc5285ed@baylibre.com>
 <CAPLW+4nH3XO1kZrpsc3Q-g=8eX0fuDqTy1f-etynyXntTAFnEw@mail.gmail.com>
Date: Thu, 21 Dec 2023 17:07:34 +0100
Message-ID: <87msu31qux.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Sam,

Thank you for your review.

On Thu, Dec 21, 2023 at 08:15, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:

> Hi Mattijs,
>
> On Wed, Dec 20, 2023 at 10:43=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Commit 19a91f2464a8 ("Create a new boot/ directory") moved the
>> android_ab.c code under boot/android_ab but did not update
>> the MAINTAINERS entry.
>
> Thanks for the patch! Would you mind adding corresponding "Fixes" tag
> below your Signed-off?

I don't mind, will send a v2.

>
> Other than that LGTM:
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>
>>
>> Update it so that the maintainer will get cc'ed again.
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7c1cb2dc4dc0..f6de883a7d8f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -60,8 +60,8 @@ ANDROID AB
>>  M:     Igor Opaniuk <igor.opaniuk@gmail.com>
>>  R:     Sam Protsenko <semen.protsenko@linaro.org>
>>  S:     Maintained
>> +F:     boot/android_ab.c
>>  F:     cmd/ab_select.c
>> -F:     common/android_ab.c
>>  F:     doc/android/ab.rst
>>  F:     include/android_ab.h
>>  F:     test/py/tests/test_android/test_ab.py
>>
>> ---
>> base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
>> change-id: 20231220-maintainers-fix-ab-2afa7cee97bd
>>
>> Best regards,
>> --
>> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
