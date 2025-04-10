Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41817C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 06:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2CD838BA;
	Thu, 10 Apr 2025 08:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KciTrzl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7880C8394F; Thu, 10 Apr 2025 08:40:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F47E838AB
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso192552f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744267234; x=1744872034; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEs8Xlgpu78eclPVl032Y1JSBbuB/qnaYi/V09M3uKM=;
 b=KciTrzl6n96q0daRKRn5b3JPwIS0TmmL4eE7DE22+5iEcVwLk+hoRVD3rbLldmsl+V
 HKATt5UITnLaet59fod7fnpltDzdsUgJdtHPi8WlGEf4R+kikcOMrdcP6yNWyUH9vwzM
 G3zokqRqTdJK5yJbQw6LTkplWKHGBFFKvraH3LKaEldxqG3R7vtXJFLz6nH2bqOrmct9
 3QCdXM3JpqSl/OAyQUJs6QaIZ8voBBU1/Z48cpB+lEJHuV7xxvB2kHlNujsf870jcm8D
 CuYthnx6IMOw5kXBOzPnvLYyaE1a+czTvxZth7Ir3WB+53+/yuoXx2t9nWHfakg9Upnz
 J70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744267234; x=1744872034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEs8Xlgpu78eclPVl032Y1JSBbuB/qnaYi/V09M3uKM=;
 b=UmPaOEsH1GHWwV18vTmNQ93XEvpkmZhVvwIQ5fRKaCyyW6RvQcBWyOm0jq3eh0mXG+
 /EHxpM5sjsdQlKNBaco9phiI/UiU9bOfhf0XECMeBX6fQ8/N74WshOiyt4nc76AqQdvt
 opgiwuI50bGwyXTkvvg78niYBSQkTkFIvlTXloNTIe+UnpDWUsRaB3lYk0AzyhkqaeAT
 tt2AgqZrFJ+TWol+5+ZWVY9RplUmOKRCMeminKsQR/7kzLLufgo8Cdw5KOOFu0zeCZ2b
 t5DWkwWLdDjSQhR4HTDqcknz/IKH52D1E1WRwtTJOFLFoX4oGqIcbnLOH1fuj3FUgCYq
 5iOQ==
X-Gm-Message-State: AOJu0YyERZy8VLcRnBA//DxhvMa6d9UN6gX2b1peHhP8NSDPicLNPYKt
 8q/6jR8FGeaBKgC1IwBmhZQT9Gs5pNgOy+Iwz+LVJy+9bo5UHWjOHE3SchDFmCDy+YCCljY/mpB
 Dsz97OooYpRUXuFucnFThQHxabY4=
X-Gm-Gg: ASbGncuXfvxO+YVVETppkaXnoW2fCryZGVM7BQF50wIHZq6Zof4Og/E3Df/L8Evy+RQ
 NxyLAXgciEargnSivMCltE7PKw42Z6baGodzfO/RlYt/aYMJ65Om1KLzjGak+n2UqTyGflbj4yR
 UvI8urB9JHWVJrPfdns+jFh/A=
X-Google-Smtp-Source: AGHT+IH1i9Dg4yxKv1rDG3e/2+aTzTygOWK4Td+LFlwd5V2GiCFxzvakM7Z8IXsnoimn7cEWBP/PRRNQegzLalqU5B4=
X-Received: by 2002:a05:6000:144d:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-39d8f496db4mr1175489f8f.27.1744267233649; Wed, 09 Apr 2025
 23:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250409155723.431102-1-sjg@chromium.org>
In-Reply-To: <20250409155723.431102-1-sjg@chromium.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 10 Apr 2025 09:40:22 +0300
X-Gm-Features: ATxdqUHJafgjYzV3NAoAYBBCuNORyVux3IN33ObvntZviNUL5NcAvM1n8lX8rW0
Message-ID: <CAPVz0n2HGJKwP==pnu2KmSi--x1g-jyTjTfnX_2=NBHNsv99QA@mail.gmail.com>
Subject: Re: [PATCH] boot: Add missing code for bootz_run()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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
