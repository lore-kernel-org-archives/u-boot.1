Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05F7C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214418059D;
	Thu,  1 May 2025 15:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fkS2Pq74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 029EE8081A; Thu,  1 May 2025 15:11:59 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECEA8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so103193266b.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746105116; x=1746709916; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pupPW1s4NfL03rm3WEZJAakLp4sMwKPrLhv3Rj7DtCA=;
 b=fkS2Pq74+rADIrre58x/mWH0tcOaXmMKSSw3FS/m6js6rifmDpDCjNAX4hEwWcYjRa
 vH9DswfOff82su7HBR2y7mcjDMoz1iRZwvkyVFyBGMeJ0FvvwFbiR41oAJkxK8pX9ZwI
 ApDkO/rE3fucE6emWHSbZ4s82sbI3Fpp2dlz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746105116; x=1746709916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pupPW1s4NfL03rm3WEZJAakLp4sMwKPrLhv3Rj7DtCA=;
 b=nmVFWMxlakoxaf9srwkD0NNA1OZjktQILs9iA0NM3nJtrfaSWHACtvlkxBof+kExaE
 hWi4mW+4uhVtk+R/SmgBIslrrgQV32kSW/5qoYLK+zakoSD44JdEQeI2W8+kzjw7I9dl
 LDZ9tFqYXXxbdbffGRdbRaJTiTQq92jUcQIdNzPlrL+hKMq7PRxBY5P6sKokK3q0Np99
 X1PesVgtC3u1mMh9kR5tWEC+A/4hxtIojyIWbZu+hZWUmmGOOwfNlQQTgKSU01i/+il5
 W6KWW5uW3VLqmvkg+D7C59S2Ji5aWPpWs0NtGmjZkwgT3wXxt6JPNfQG8ElsMNO+k+Tf
 T7DQ==
X-Gm-Message-State: AOJu0YzNmutnIfFYiyWK3RIhojWdgwE2+X2QS4h5yZQyVGd2jvlICmEk
 l3u9+Cb+aW9iHwrsAzMz1JztWcUQAz4JAM698I3EiRoYhooCwEDIVItQ9KXQ84LZ54Df2R/PjXx
 6EVllWldoO2xeCALhR2YSYCxyIxGHrUk6nFMT
X-Gm-Gg: ASbGncvjzTr9nis3FbDywKtw/LGnMOJLdvQ3e0VHhFJE3wPv22k1p9VH4d2sshTwg6K
 jX5YGAi/F+oZI3qygaUwvCGntiZydlZBxkJzgifKK+Xp5LeJM/yYFAh3fFntqfedGOFfYqejLEj
 6e99/lt/vghiq9MSgEaMaVI5s=
X-Google-Smtp-Source: AGHT+IHZeOTkCgptcraYRv/n24xuXVduJ82OVLUeFD9SJFLjA+QgYo6KjL77aoKCQ7ivU7fz1T0MTE+Bvj6mfjQlux8=
X-Received: by 2002:a17:907:72d6:b0:ace:5207:e2ec with SMTP id
 a640c23a62f3a-acedc55240emr720982766b.4.1746105116339; Thu, 01 May 2025
 06:11:56 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 May 2025 06:11:55 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 May 2025 06:11:55 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPVz0n2HGJKwP==pnu2KmSi--x1g-jyTjTfnX_2=NBHNsv99QA@mail.gmail.com>
References: <CAPVz0n2HGJKwP==pnu2KmSi--x1g-jyTjTfnX_2=NBHNsv99QA@mail.gmail.com>
 <20250409155723.431102-1-sjg@chromium.org>
Date: Thu, 1 May 2025 06:11:55 -0700
X-Google-Sender-Auth: Ye5c9SwOZHQvjis0PekfjL4kG1Y
X-Gm-Features: ATxdqUH-ZH9gR6h3ssL36K3FScyTl8pcbIJsQMztl2OBN7JqqDZKtcBCvUkCXMQ
Message-ID: <CAFLszTi4wxFPnaVwRiRZMCk9SOPu=8Rd7atKTwxdQ=_E_k--_w@mail.gmail.com>
Subject: Re: [PATCH] boot: Add missing code for bootz_run()
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

=D1=81=D1=80, 9 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 18:57=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The bootz method is special in that it uses its own implementation of
> several of the bootm states.
>
> The existing do_bootz() function calls bootz_run() but first does a few
> other things. These are missing in the direct call to bootz_run(). I
> probably missed this because bootz_start() sets up its own
> struct bootm_info so I assumed it was independent. While the struct
> itself is independent, changes to the images member (which is a pointer)
> persist.
>
> Move the required code into bootz_run()
>
> This change was manually tested on an rpi2 with postmarketOS added,
> using standard boot and also the 'bootz' command.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 47eda7e80ea ("boot: pxe: Use bootm_...() functions where possible"=
)
> Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>

It is not cleanly applicable to current u-boot/next with your pxe
changes present, but overall it fixes booting on my devices. Thank
you.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895

Applied to sjg/master, thanks!
