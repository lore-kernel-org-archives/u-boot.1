Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED91C0218A
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 03:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2FE80079;
	Mon,  3 Feb 2025 04:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lfAEpehq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBFF80087; Mon,  3 Feb 2025 04:41:45 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6718004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 04:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5db689a87cbso7705130a12.3
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 19:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738554102; x=1739158902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=heJs7UPTPgCWIl3jXiwSX3nPRjKdfnLqCzEpADsxUNk=;
 b=lfAEpehqUgyxizVhr7Dwz6tptlmJLbD77vv4fl3PrjpzNTaKWVK5fps3qShXb3v4F1
 0Jh3i0XHOgy+1uvrt0HyyHjVLsM6SC+QvPk6dX6yg7ChSk9+Qsn6yKYFK6AP71Hwm0rA
 4dxSdXD0+IMiY9obySuG9cBU6eyNKgir4CveRM5Zd8JaY7XxR5aGoTuw5mdSPuphbR0i
 gEUk+h+yuSEWrY+e7qoyNNIguV76QPfbOGaF95cruAk4W8OcGteCA5bZp4XpnQ9aLdmE
 wqTcZz4IN/Y6bR1b8HmPgEY+y4iI73eKoRZOWaV75rtNxyThNnPgtkqC9QuVDkDRiYRO
 Qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738554102; x=1739158902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heJs7UPTPgCWIl3jXiwSX3nPRjKdfnLqCzEpADsxUNk=;
 b=DvHef2nCPkDD/v5DJlMwzZhkEU1f6vqXLsvo5KrAGQgLVvJf0fYo7hf8FlVKPgj2fI
 ag8OH169SJKoZ7tzCzRahRxc/UpLINuwCQ0nMtIPXy6S89EQYYdg+7k9+SLGv32FaUW0
 8mhHs+E2+0VIe4XddcUfRsk7DlkXgpPOJgqIrzw9k3Xi7umgzt7fPh2dx6JrxNEhlPKG
 F3y+0syzcbwfeF/ov2eMPQyAS/y7vgQsOH9yNKg0snk4BcIl44JP+g4hm36PKeswa4Kq
 qCEAAjKjhOLvBbcmh9efy8Sd7HnUkP00mi+jqmjkuGxD+18ZarlH2xgtl1whaz4qBFV+
 PA8A==
X-Gm-Message-State: AOJu0YwPckSQFanh6Nk6rbE6LwiT7/Ddff9CVXnNReKROzbegtDh7jR/
 W+Oj6TeAgTzW2vgIukm2R6CC2gSI5jnTegSfUY50+3fwiqj+jfGbxeZ2MsvTpBSId47pmkeTLTg
 AE9NegKMed59jeaCXcXga4h8MbpY=
X-Gm-Gg: ASbGncsAXZupvZTGmE87kIKJObIlh1V1jbyUBgbwtbBNrdJp88e8S/iBF+DGtnl0ovS
 7WZ1xbRu2pd5JPb/JSDHaXxZSmnFxSi3Tiq0zT4Zj6bZJIf3uPaU8RCE0+oi72dJO+pHKkOUF
X-Google-Smtp-Source: AGHT+IE4gtZkUJAFquVWNF3r7++lcOV6lA3ixvTRZqythHZMnLL9i0C1TsdjVnOrwUURm9OweO9j5IxRwlqaMQMrvk4=
X-Received: by 2002:a05:6402:2390:b0:5dc:71f6:970a with SMTP id
 4fb4d7f45d1cf-5dc71f697d1mr13275328a12.16.1738554101886; Sun, 02 Feb 2025
 19:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <CAFLszThUo1u58Vwy77UEQZG79f7-BB2ysB5-oq-DHbP4c_ciRQ@mail.gmail.com>
In-Reply-To: <CAFLszThUo1u58Vwy77UEQZG79f7-BB2ysB5-oq-DHbP4c_ciRQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 3 Feb 2025 03:41:30 +0000
X-Gm-Features: AWEUYZk0bL--kZSN09CZebkZXsQJ0dxAGOetIBh4w-yF3lmHYdgW_1OfW31Xods
Message-ID: <CALeDE9MFGFEUmOHyOFFyLL4TeaZKjDSt+LBEfNEGgHSdtwDetg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] rpi: Tidy up booting
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 30 Jan 2025 at 19:55, Simon Glass <sjg@chromium.org> wrote:

> Hi,
>
> On Thu, 19 Dec 2024 at 17:34, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > ramdisk, by expanding the available space.
> >
> > It also tidies up some strange behaviour with the provided FDT, where a
> > separate pointer is maintained to it, even though U-Boot has copied it
> > and placed it in its own space. This avoids strange bugs where it
> > accidentally gets overwritten when loading a file into memory.
> >
> > The patch to expand the devicetree was dropped, meaning that people
> > should be careful to unset fdt_addr in the environment.
> >
> > In version 2, it incorporates some changes to fdt_addr, etc. suggested
> > by Tom, as well as adding myself as a maintainer.
> >
> > Changes in v4:
> > - Expand the comment on set_fdt_addr()
> > - Update the commit message to talk in terms of my testing
> >
> > Changes in v3:
> > - Add to the existing comment block
> > - Update the comment block with the new values, including compression
> >
> > Changes in v2:
> > - Add new patch to make myself an rpi maintainer
> > - Add new patch to set bootm_size
> > - Add new patch to drop fdt_high and initrd_high
> > - Drop patch to allow expanding the devicetree during relocation
> >
> > Simon Glass (5):
> >   rpi: Add myself to the list of maintainers
> >   rpi: Set bootm_size to 512MB
> >   rpi: Drop fdt_high and initrd_high
> >   rpi: Update environment to support booti and large initrd
> >   rpi: Use the U-Boot control FDT for fdt_addr
> >
> >  MAINTAINERS                   |  1 +
> >  board/raspberrypi/rpi/rpi.c   | 20 +++++++++----------
> >  board/raspberrypi/rpi/rpi.env | 37 +++++++++++++++++++----------------
> >  3 files changed, 31 insertions(+), 27 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> We have hit rc1 now. Is there any interest in applying this series?
>

I have started testing it but I am traveling so have limited devices (and
time) to test and I want to do more thorough testing on my return later in
the week.
