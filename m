Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5DCC369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 14:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB46B8210E;
	Sat, 19 Apr 2025 16:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gLkwOkDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130818212B; Sat, 19 Apr 2025 16:14:37 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38578129B
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 16:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so400250066b.0
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745072074; x=1745676874; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5tYsdJe+lV1pv9qXZjcUWePDk5RydhUCEwUTXEeK1Hk=;
 b=gLkwOkDHMvnlMhxuv102Q8avB2taOhMmXwOqmjHpgFZiHwWzIHNaz+m0oX0eaQAl7K
 XAfGqsEZ6baUBp3Il6R7nNX4e9N7oC6+MC9V2sFgHkyFl6vcXZLOy61j1fSiPwF4Xfjx
 uT6v7TXbARgQIhGEzmy7CpPjL9Ead72ASZP0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745072074; x=1745676874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5tYsdJe+lV1pv9qXZjcUWePDk5RydhUCEwUTXEeK1Hk=;
 b=W1kywU21bjhsuYhcg8ubkd6xnHDRf7yeTAvi6+HEG0Hy4QhurHPLJmL1+jk4VDjIHY
 CEMPsljFqzxSpI76ktdWBUL8uJLoO1FhyNeVvFBto413VZ0IM0JeRGXwu69HtddgXJ1x
 k993bMw0zMNctcUeuEhs15RlI3Nyu66NFW7uWUItvz7ThOLqeErVqIlLGDSBaK9QPvN3
 IsZDZUCwh3ZTEZwBbMmqgmQVwBA6p/3LwEp2qc3HQHnHLNMT9GKX5zXLx30UYzy8XDcE
 wKrUj5UMHtI556gjCqCcykI7ou+QO4xPwHfibz9OXxGeE90CR0+COfZCWlaIzH+2oyzt
 ctew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Mynl5xv1HKXmD9pp+7r0Pvw4Gck9Z9kzJszh4BzS0n/aVOg3pavEshemYFzdL/89cSUJwqw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy61t1U6hv0BsyqY/SNs04yqESzyfs+duaX6xshAGTM61yuFtxb
 GamnPwM18SdULjqy+a/CzAeNXmRpxSq8t9iimkIdkqhczuU2nctRH9rMtAIZ7fOLgxCy7PN0rvV
 hKb0ONd/h0zyhA+4O1HvnZTaxxSP3H8gQK/I2
X-Gm-Gg: ASbGncu68frPuRXe8k4cEhBISw9n9gBEzWz+F22s3JFZsdrYY2OHIbFJlqaZxelSMQw
 SxzKPWOnr52g9PzhwwRXzfs2dJHPxckWZ9jY75Wf0MAJakKMwiVvxtJMmfKk3o3JY+/itT3KR3F
 xO/UXbD0Q7xkO3fJ2Jg4NW1sniy1zav7MzwA==
X-Google-Smtp-Source: AGHT+IEyjH72OulgGeSubZ7ZNCo09ABje6X5nmDLnMMfP9QIYZqfYNrUBBdsCqv9q+aGcH638GzsOVuQOkPPueXKPCg=
X-Received: by 2002:a17:907:b9c5:b0:ac7:edc4:3d42 with SMTP id
 a640c23a62f3a-acb74b389d8mr442520166b.24.1745072074026; Sat, 19 Apr 2025
 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
In-Reply-To: <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Apr 2025 08:14:22 -0600
X-Gm-Features: ATxdqUHMOR-tIoVVR71MHhh8ffyQpa43zoHKY8PT6NUbVMEPD2o0u4O9WgTR85E
Message-ID: <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Heinrich,

On Sat, 19 Apr 2025 at 04:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/18/25 13:39, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Heinrich,
> >>
> >> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> >>> Currently we are no able to build with configuration fragments in our CI.
> >>> With this patch buildman gets a new argument --fragments for passing a
> >>> comma separated list of configuration fragments to add to the board
> >>> defconfigs, e.g.
> >>>
> >>>       tools/buildman/buildman \
> >>>       -o build \
> >>>       -k qemu-riscv64_smode \
> >>>       --fragments acpi.config
> >>>
> >>
> >> What about using:
> >>
> >> --fragment acpi.config --fragment fragment2.config
> >>
> >> ?
> >
> > Yes that could be useful. It would also allow wildcards, although the
> > code would need to drop the config/ directory prefix. Also, I see that
> > -z is available so perhaps that could be a (bad) short option?
>
> Hello Simon,
>
> What do you mean by useful?
>
> --fragments a,b conveys the same information as --fragment a --fragment b.
>
> We are not passing any config/ directory with the fragment names.
>
> Using wildcards in does not depend on how fragment names are passed.
>
> As maintainer of buildman, please, clearly express how you want the
> fragment names to be passed. "Could be useful" does not indicate any
> decision but let's me hang in limbo.

NAK

We need a file which lists the valid boards for each config fragment.
Buildman should parse that and it should be possible (with an argument
like --build-all-fragments) to build all fragments for a board (or all
boards), to make sure that things actually build. See [1]

So until that is done I'm going to NAK the whole concept[2].

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241108152350.3686274-9-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/20250329002537.GN93000@bill-the-cat/
