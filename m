Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AC3CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F788394A;
	Wed,  8 Oct 2025 14:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FvnOe/5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1613A8394E; Wed,  8 Oct 2025 14:53:30 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D328A838AE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-637e9f9f9fbso12177314a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759928007; x=1760532807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYO1orsYZAgGB+zswvnfWyEBWw1c/4xpoX0dU4xQm8k=;
 b=FvnOe/5g5QklRwyj7qB/2QnOqnjzRFDA5oVXSRyBQ7PYmW93vr2ZOWwuvDKW8xLyTm
 19GAsFD6Im6hEcyBOSPmHXcytJZoRZvLk62Yq5U/yCL/8gTw3NkiaUNZW3/jQ81joyY0
 7uJ4O+lfWAaR6hZFd7XdEv6KeVwmqLuwuJwl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759928007; x=1760532807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYO1orsYZAgGB+zswvnfWyEBWw1c/4xpoX0dU4xQm8k=;
 b=dUTxRtq1ptuOfjnZq+3fc6HB0oU6n8gBRvLNDjLXxJAtA4CPtmzUrvrTmub+q6Nu+E
 5WUiw5HUwWN/YbHTu//59YJ0uzDKDEyflNib7jYZsI20kWQ9RjrNaVj1eOXt9kdZ0oIh
 +xLUMBlG6DwZcqqi6CMPZgyCs9YoeDhfGecRVmvlkrSanhPwa7FmwCl4bcS0Q2yVrXy5
 kLTlIJl4Xr7yDbKoWhIC/zAJV5O/faEcZxJG6XjZbevtw4Th3LoJOJ7skVp2lPnBIRSn
 9cJ3o7yNoyxH28KXd2IIJiwULJXNqRR4raabwrpvXIbC8mr01gBaJ8Ke7o9axclz1tB/
 sZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV58UdABv9JV/pwiZTUAqQ41PPojqNdcqEZmurAUjAYrBo9GJoZUCG8epEvlaubHIE4NbiApd4=@lists.denx.de
X-Gm-Message-State: AOJu0YwKWZRfda6GY55rwIybecjl0DtzexmEV6LuBTgQYGoKJSGO9HMG
 eWAfCs/NNzXVVXi2n4YmdK2YhYyAcp5EGAuFEPsKdR4xsuNGHAQ9ViY2n4Xq8ueKx7eWwYWa6vw
 8H4dCsxxMOCTjiXz+b2Kzb+tdS971KJyYBr2/jr9MOjUV7jFtGbymyw==
X-Gm-Gg: ASbGncvOSnoF0/hoFwgETxZTQSpXS6w8LXfxlH9qKkiy+5YR/3+eOZD9CzVkJ/cdU/M
 EG9s6PmbJWfMHNc8gOGP6C2qkqY4vE/iOLPh+nqyXUqAg4WMjaGIpt59vvw7UboTFuqztcY0/zg
 PicXXy98pdDbq/S05Qtfe7WB8Z67tgT0lkI2Cr8DoO/5/ShOkfI09ZOqPN7gC3B5266i6vXMXY0
 Kaa7owub08A4E4K41nBqWuusKbg8A==
X-Google-Smtp-Source: AGHT+IEoz4lEOMf0uv3Pm+5hQDHFZivKoSKhc0WRf1PlAQxVkrYiht5b6LrwVzNI3Sr2dZx2CvF9at0xIJgBPuLp5Pk=
X-Received: by 2002:a05:6402:13ca:b0:634:5705:5705 with SMTP id
 4fb4d7f45d1cf-639d5b88f41mr3148132a12.12.1759928007313; Wed, 08 Oct 2025
 05:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251003222714.4921-1-semen.protsenko@linaro.org>
 <CAFLszTiic5c_ZwX4hWJEAx=VGXxR8KOsNw2AQwzh92G-PRncGA@mail.gmail.com>
 <CAPLW+4n_wCzhsyVYiz1AzA4R0Z32nkjOs31F8TDwZXpyUM-J4Q@mail.gmail.com>
In-Reply-To: <CAPLW+4n_wCzhsyVYiz1AzA4R0Z32nkjOs31F8TDwZXpyUM-J4Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 06:53:15 -0600
X-Gm-Features: AS18NWBtwvWEZQj9hl3ciVVon5HTt2Gj0H5-PM7byOwYXORqXCWAzwPbMJ-nGJY
Message-ID: <CAFLszTh0AB5bA7oo6e9NZY7n0faMRxveWYD9sNbYmLUk=3D-TQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Fix bootflow info for efi_mgr
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Sam,

On Tue, 7 Oct 2025 at 13:32, Sam Protsenko <semen.protsenko@linaro.org> wro=
te:
>
> Hi Simon,
>
> On Mon, Oct 6, 2025 at 3:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> [snip]
>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > If you like, you could an a test for this to bootflow_cmd_info()
> >
>
> I remember the last time when I tried running bootstd tests they were
> broken. Are they functional now? Also, do we have some short
> documentation on running bootstd tests? If so, could you please
> reference it. I mean, I can add the test, but unfortunately don't have
> enough time to fix the broken test suite (if it's still broken).

It runs in CI so I don't think it can be broken. But perhaps it
doesn't work locally for you?

You need to run test.py first (e.g. with -k bootstd) to get it to
create the test files. After that you can just run sandbox with 'ut
bootstd ...' which is a bit quicker.

There is quite a bit of documentation too at [1]

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/testing.html
