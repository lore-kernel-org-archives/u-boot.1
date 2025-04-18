Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC11C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1850D82AA4;
	Fri, 18 Apr 2025 15:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bOft+zZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D467982B3F; Fri, 18 Apr 2025 15:47:13 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE26682A1C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so288391266b.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744984031; x=1745588831; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tNHrvmfbRsXXqM16sGqa9DDBWSVJAMDhKgjZag2R1+0=;
 b=bOft+zZ1xUkXf2Y8rCqGm6JCo2D2bHI3Lbf0Ed67/fs4SQVG0HlV5V2zYN4auKPuBD
 D/9lpLuhtjNCA2NE7e2s009P0nxCtfbcA2aDwslAaogocN4qDJtDBZipG4jQ+WT844AS
 f6i9LBqxHCfEDqhLv7dsK8MUjuQsWF5O9NMec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744984031; x=1745588831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNHrvmfbRsXXqM16sGqa9DDBWSVJAMDhKgjZag2R1+0=;
 b=dO0tPgFSFrQWY4lKYTrhsv5Hq/l8UKKSrrGQ8jNtOr10MB+ZZOts0FcTr8Ma+MenA3
 lynXnFcBa6QZbH3GSSgOzwa8yFVLPXwbJ+Nm3e2rSb1FMd/a+MBI6Brdz1WgQfFlTvyR
 cuyMyugoO3HqYubGUoVaJTaqqcUQjVb43Uvaqf2BfrUl8OR2Nc88au2deruerN2z9ox5
 O11itZH2M/pVTuLOCoPx6K3yovJT4eup+cbk5AFaV0tPPlAMoBVhZbVxaW0KMJdIjabo
 uGxPrz1wcSzvVIhs7H8cX8eAQ8luVn7o7f4MjyLtOLEibYnP11JYDYuMufbLTBGLkcoj
 j6dw==
X-Gm-Message-State: AOJu0Yx0jMjDxK6IP+r/REd4B5gtTPqWRYhHJjgCoPOMVygK4eI/kX80
 /ZyzUHDHGYAq79oNWji6wcRzFz+Ku7IDbSZfM9C5qIFaMdVppHbAHEd9aRTlMZZ03eWoEHSB9V3
 lWEtI6WQIVJYoEnOHAVyU8frHV3+hHH7y9c8S
X-Gm-Gg: ASbGncsPwnqTulB1BDX1fhNewL2rOajbmXtQrD/f7QBjo8+N27fy1vNEzswplgfrZkW
 JV4DkD7JGLYjI7nwflrs+WYMtV5CR56/VKBh9Xa3YFuHTnMF8OyoUInA14fIcvbawGewftKBkdw
 I9ua7LLkLYVkQhGJ/t7UpR+wc=
X-Google-Smtp-Source: AGHT+IFSVIxDUOzgysktqhFqbVWaLMJWJE/8P89dtLh4vlpl0Bd/iJJQC3w4DOqkOIf+EiNvkr732Pddhh9OuqHLxOo=
X-Received: by 2002:a17:907:9712:b0:aca:c437:849e with SMTP id
 a640c23a62f3a-acb74ad96ecmr267897466b.4.1744984031160; Fri, 18 Apr 2025
 06:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
In-Reply-To: <20250418133315.GJ5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 07:46:59 -0600
X-Gm-Features: ATxdqUE0ifBZM-iuVgxt51rbvT9tcxje_h7lsJerJLyWbgBCtnH9OFpPNViabS4
Message-ID: <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
>
> > This series restores the original behaviour of extlinux booting linux
> > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > a limit of 10x the compressed size.
> >
> > It also adds RISC-V support, since it uses a similar format to ARM64.
> >
> > Future work should integrate the code in 'booti' into main 'bootm'
> > logic.
> >
> >
> > Simon Glass (3):
> >   boot: Add a function to check if a linux Image is supported
> >   bootm: Add RISC-V support in booti_is_supported()
> >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> >
> >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> >  cmd/booti.c     |  1 +
> >  include/bootm.h |  3 +++
> >  3 files changed, 29 insertions(+), 6 deletions(-)
>
> This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so much as
> it was never relevant here to start with. The documentation
> (doc/usage/cmd/booti.rst) has explained that we use 10 x
> kernel_comp_size for the limit. The "bootm" namespace has largely been
> about uImage (and then FIT images when not using it's own namespace)
> images and not applied elsewhere, which is why bootz/booti handled
> things outside that namespace. And then, still, this series doesn't
> unify cmd/booti.c with your changes, it just introduces duplicated
> functionality, which is generally understood to be a bad thing.
>
> So again, please do similar to what you did for cmd/bootz.c and that
> report and move the existing functionality over. We can then look at
> cleaning it up (which should look like / abstract what we do for
> compressed FIT images) as a follow up, in order to make bisecting any
> regressions here easier down the line. Thanks.

Well, I still don't understand what you are getting at here.

The existing functionality for booti is already there. Marek added it
a few years back. Can you please be more specific as to what
functionality you think is missing?

Yes, the bootm implementation is separate from the booti command at
present. They both call booti_setup(). But the booti command uses
kernel_comp_addr_r which we shouldn't be using in bootm. In fact I'd
like to get rid of those vars, not proliferate them. There is
certainly some more common code which can be teased apart, but it's
not the subject of this bugfix. I have to stop somewhere.

Perhaps you should let me do this refactoring in the way that I
believe it should be done?

Regards,
Simon
