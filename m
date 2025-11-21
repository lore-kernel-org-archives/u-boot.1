Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97571CFC299
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1651A83A1B;
	Fri, 21 Nov 2025 18:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EDk5Ux1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A90883A5A; Fri, 21 Nov 2025 18:40:27 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30EF1839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so481360666b.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763746824; x=1764351624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mY1UbKqJvVYjBKaz+O8riS0Vn9nwWLkm3d/FGpRVktA=;
 b=EDk5Ux1IuBZ66D0n85/HUzcmDJ7U1aDaHg+ttXTCcwNbCIZ9hwk04qK7xbuHWxmql4
 b1EwClaQKH/IALtIamIJxXzE4qvd8q5i+QcOrN/JHwM2NmhwuBvJcx/NSsIbO5nOOXBc
 hUQGbpl1fa98KxkXT0Do6z9U9swMDDWiHfS0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746824; x=1764351624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY1UbKqJvVYjBKaz+O8riS0Vn9nwWLkm3d/FGpRVktA=;
 b=PyfSZoZNjcj9tB7QRzfg6Jfar6mjuG2Qerxfn/uPszb/QlLbjGvvVbEz1AOzdbWawG
 CVeAJoGMGPZBDRD0yFJ996U9JGaK3eVc8kUGgGcMPwomL8IIbAJxhfIByUi8gkxrADNl
 uLLaD1AlLIxBjSJOn+RtFUIai/iGyQ3Y8KqkGUPaObcq0RUpWfyI9kM5Qu56HEJqhwiw
 lQenVwn6i1av8ROsSmkvYCK03bjB8wqaAOB1pFaPXAbX+LpAZ/I+hGkBqe9oZg+IJXjG
 N9N5jdLeZrFUxsqcIFuh0puq4E5XeUHcwva4lSe7svWhGGgmgBqun4IRe+sj+oLbyO6/
 Cclw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNQpz1hNEVE6wDU5SYeJtSeW17bgDY4MdKDdQV5xiDYrO8SNYIGLUpJn8VQltqXeDlTEYhTRU=@lists.denx.de
X-Gm-Message-State: AOJu0YzK3oeRru9+T2DG5xSSuc/IMPrmMCH0bv9ilFDK3MZqQO/j588J
 iFVkLO+VL+B7RKTJy/DeR23efMrMbveT3rabsNEBFjj9uQ3dQNhtlp/G8ca05wlo2qzuUmJC4tx
 PjBEI+cxvgp+mq9s2yYAL9m3rh2Q54zhKQ8cmdVsg
X-Gm-Gg: ASbGncuj+ElVXUwNtHWyPR/bKBBGSDVbtTF8VEr9Ozbjh7IfvxCO/XsvdO788NPU6ot
 WW4iM+LKDPfi33Ylo1w8W9dUOBaokZTYz467p/0LwGF0SdeyVxPHHiUGwfEpa28b6S1up15vFa8
 t9XgYTJHk/M3v6jnulo/9RMKQpR/XcztB0K3FVJ755vzdzHVxBBriOKMJ0IQ93zk62GsFsicFvU
 wCDc7+/+3INp/LEbTPu9XT4zOTi3BWDWhdDwTDKdqY8sg2lfKvAO60tLSk9G9DVHOE6ng==
X-Google-Smtp-Source: AGHT+IHqFgR7FU/lvpl5Ugq9kwQfUUeJNCVqJzBXDYqjyOtT7hxOux1GgbDRzX0OFl0jUyncwbBVFm6wLJS0oMPZ/0E=
X-Received: by 2002:a17:907:1ca4:b0:b6d:5dbb:a1e1 with SMTP id
 a640c23a62f3a-b766ed8362dmr423260066b.5.1763746824661; Fri, 21 Nov 2025
 09:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
In-Reply-To: <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 10:40:13 -0700
X-Gm-Features: AWmQ_bk_fsupGdD8B8qnbkWZ5ni92aCTCJSfzbHuRS_kFWIGEkyNKZyP3VGyZgM
Message-ID: <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Fri, 21 Nov 2025 at 10:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/21/25 5:20 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> >>> which checks offsets in fdt_next_tag()
> >>>
> >>> The latter might be best. It would likely be very cheap in terms of
> >>> code size. In fact, I should have thought of this at the time.
> >> Wouldn't it be better to not misuse libfdt ?
> >
> > It actually isn't a misuse. It is perfectly OK to pass an invalid
> > offset and libfdt has defined behaviour in that case, absent any
> > 'assumptions' we force.
>
> It actually isn't OK to pass in invalid offset if we compile FDT with
> disabled tree validity checks.

We are saying exactly the same thing, if you read both of the above :-)

>
> > Remember, in Linux these checks are enabled. We added the 'assume'
> > thing to reduce code size. Here you have found a situation where it
> > breaks stuff, so we should back off the assumption a bit.
> U-Boot also has those checks enabled, SPL does not, and things break
> when OF_PLATDATA is enabled and there is no valid node associated with
> the udevice.

Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
size. If it is too much, add a new level FDT_ASSUME_EXISTS before
FDT_ASSUME_SANE and use that for the necessary checks (there will only
be a few, from my reading of the code).

REgards,
Simon
