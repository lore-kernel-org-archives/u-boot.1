Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE9DC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 07:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03B6807D9;
	Tue, 11 Mar 2025 08:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCjChJtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E22180F92; Tue, 11 Mar 2025 08:34:45 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFC3807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso3612253276.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741678482; x=1742283282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ilo0UNjuplpq6gfd1oHEsuMiahQTUor6sI39eMLxzDY=;
 b=CCjChJtOm3qVjGNhiq/LLxjIWdJVhOfn6g+snQla+2Uj6J8/zNpiMZW/mZgtKk4uP3
 puc0lYzNQpkCQ1ZhR3SEKy4NccdV1J+leukzN44BiCxkY3ZwsO8MBGKR58jZpcA7+ai5
 LS4R6AvuFam3wRSMhR4B40Fx7sKIeEtj3jpc6X2mYGgICd0qnEveCwN1jykhttbOZH4t
 RpZ7p7p6q+tIwxx4364YkElBqC2IGni8NrgDM2nHuRfMwLV+f8LQCfU9aO3J8E/EqQyY
 3U8bAOKq+eZTPOn92rNeQd0KnUHQdE8WdB3SXJcB0xNkqL5UMnIoxCy56BuVS9dzqHVp
 YGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741678482; x=1742283282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ilo0UNjuplpq6gfd1oHEsuMiahQTUor6sI39eMLxzDY=;
 b=LlNV/c5tHqGTow4ZDtNQKaoaZlu4+Jn1ThwjZI0mYMoshRwsJa5qdAJLmW0YP0fYCv
 3sTiPBeoAExX6mBMVXDx6IZmDifu3eQ0+/UD0iyyVRGsE3XnL73SA2K/wMvBvNgdRe89
 Fwa8lrvLJpfxO3o2h3VknQSWPr/wr0E7qIVgR+YPdlUIr5LHy/WFU9oesnGncOxUe7wD
 /HfLl50NQZa+nBAzqLi/FddTSiHePO1rJDlgurVzLbT5tYdZJD4nmw3J13iBUV+HA4Sk
 kER0paxGGZDKzHqlGpyIhsad1sn963eXZ2ubyCHVnk34gBRSxH5U698QrVm1KaYM6ego
 nQaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzGLIHt+lfVFObE+Nwc5a7BeKWxlmh4FH/ESrdnXJfocx7gGFTOb+662x5of211mjIj/59xXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxqCGsja4VazcVilwry/grR1u1DuipKC113ok+Y7bg3TlbA6Msc
 rxbIH/HEUrOS5CuArn6QkhdLyIwLRBywAebkd4aQTlIzZUeiTaFovnDvC4ziINew4RKKMNqEJDK
 Bz3cLqhQasKErOYAo8ecZSy3z4CZvoDVyJmTl4w==
X-Gm-Gg: ASbGncssG4iq91vkX36oAPnEPDTXHgTJiUq85TX5mjliL9qAtarFW+LZaK+SNfR7B3Y
 PdmY1DI3SE99eMzKYeZz0yPb9R270GcUZZ7eJLKmVI3kbWKSnXti8mBZyLbnbhnPYI5joFJanVp
 lOQlVUcDT+XFqNU/MY2pcugTM8bYw=
X-Google-Smtp-Source: AGHT+IFul6f2eSg9hOKfIXs/yNizYjcaXavsFy4qsek3diX8BgiJhSGRB0DuqVBcGXA32bf5aYMUrO8VDh8MiIiWnSM=
X-Received: by 2002:a05:6902:3388:b0:e5a:c67e:6465 with SMTP id
 3f1490d57ef6-e635c1d721cmr17439176276.38.1741678481751; Tue, 11 Mar 2025
 00:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
 <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
 <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
In-Reply-To: <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 09:34:05 +0200
X-Gm-Features: AQ5f1JquGI08h1taKvLNyDoKwHALRwquHsrtYIMG670Mok4tRif7gHvny70yUPc
Message-ID: <CAC_iWjJKO4Dkbd_x9==Cq=Kb4Cy9S4PQqz7d714U9ErWsdW81A@mail.gmail.com>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
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

+CC Ard

On Sat, 8 Mar 2025 at 19:36, Ben Schneider <ben@bens.haus> wrote:
>
> On Wednesday, March 5th, 2025 at 12:20 AM, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 3/5/25 09:13, Sughosh Ganu wrote:
> > >
> > > Can you check what is the address being asked for in the
> > > lmb_alloc_addr() function.
> >
> > maybe also add a call to lmb_dump_all_force()
>
> Thank you both! This was exactly what I needed. This appears to be
> a kernel bug in randomalloc.c which always breaks out of a loop
> after only one iteration[1] which is unlikely to be the intention.
>
> Ben
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/firmware/efi/libstub/randomalloc.c#L133

FWIW we discussed this in the kernel mailing list as well [0]. Ben can
you apply [1] and see if it fixes your problem?
[0] https://lore.kernel.org/linux-efi/CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com/T/#t
[1] https://patchwork.ozlabs.org/project/uboot/list/?series=446790

Cheers
/Ilias
