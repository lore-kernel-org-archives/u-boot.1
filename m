Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82CCC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1A588997;
	Wed, 24 Jul 2024 16:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="neHdYDl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3838D8897A; Wed, 24 Jul 2024 16:37:31 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B99488962
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-79f15e7c879so463798185a.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831846; x=1722436646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dcYdqoGDIJt5Z3rWAakRtFqJUUzpakIcxz/XbR8+1pA=;
 b=neHdYDl2TeXY6DTE96UnO9eLLIhvJZTkJ+WTMb+Yr9s/BXCj9oxI/9edoMDSiV3kYK
 3NYCw6Jkh6LPChQd8NotwAWeo1gKidHb00lGFw3cPTJORtAvDEzj2SBepUx7EzZtaUlG
 eB13SS9sObE2URPX1S/oLcac4fAZVtIAQ4RCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831846; x=1722436646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dcYdqoGDIJt5Z3rWAakRtFqJUUzpakIcxz/XbR8+1pA=;
 b=D/Yl0XBWll2DiI6WelmbIKIeLQVTx1fsxVE/5Er0xGgkZfSyg2lp44AOR+R0TzQRpe
 dcHnvqk21esOAetE5cdPZ1y9hW+sxJoIRq/FkBhvpZP7dfI2qKBLBrm0UJGexVCo6zcg
 FRlpkMrxabcoK82DrxSdCJO0BIoutKrC1GcEY1YLm+C4MkOuSRUFd9LhWxixaY9rNuFy
 7EiBpY6SPNqmo+BIYmZkBvgJbB5ytkryg/HLviAKFPKZYtJCvDxUUL6OIeSjVVXYB1Aq
 Uq1b6LOG0ZQNEyVoPHHiUN6iM82iMOApkbJFnsEoP6kchezHAnYorThRCn76gttI0EIl
 pdFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeNrmEW6p2P8AyyiF8UsjC3gxxjo2MZm5O07Xa2mOJhVPgSZNQ3jlFnjiU8H8HRnDnZgAiS731Oqv9qB3SWc+uwZ4fA==
X-Gm-Message-State: AOJu0YxPjj4O0EMQopdX5CSo3Db72cQbbUGYP3OhVfA0LWUYqZCM/h8D
 xbJODzjWvJy8KEETidOqTJw7PdLuEwjuCCDhzHVlxSdHkHzB/fsDKuyKm0n+VAzK7Xw4jGj2lBH
 gS1FVIxacpOj3Df0gs0f/0ZrI/yL0ja6s1WcrMbPhirA7q88=
X-Google-Smtp-Source: AGHT+IF9prpgTf4iCWW+KyAJ749CZEDMUEAyG5yO0/Sz4VumMVJIM3QyKPxlPjOV+JvQE2YEDIMEMkGySzAEhpdBoSY=
X-Received: by 2002:ad4:5ba4:0:b0:6b5:936d:e5e7 with SMTP id
 6a1803df08f44-6b990733094mr21687336d6.18.1721831845987; Wed, 24 Jul 2024
 07:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240723015555.GE989285@bill-the-cat>
 <trinity-430de174-6a75-482c-b8dd-fde586286c63-1721742246830@3c-app-gmx-bap35>
In-Reply-To: <trinity-430de174-6a75-482c-b8dd-fde586286c63-1721742246830@3c-app-gmx-bap35>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:37:15 -0600
Message-ID: <CAFLszTgt90Xne03OH4Z53T77j=ehqUJmK0OAXPNAPS7qm=4__g@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2024.10-rc1 released
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

Hi,

On Tue, 23 Jul 2024 at 07:44, Frank Wunderlich <frank-w@public-files.de> wrote:
>
> Hi,
>
> i notice build-error because of CONFIG_TOOLS_MKEFICAPSULE is set automaticly and does not find an include
>
> https://github.com/frank-w/u-boot/actions/runs/10059612312/job/27805232284
>
> tools/mkeficapsule.c:20:10: fatal error: gnutls/gnutls.h: No such file or directory
>    20 | #include <gnutls/gnutls.h>
>       |          ^~~~~~~~~~~~~~~~~
>
> solved it temporary by adding CONFIG_TOOLS_MKEFICAPSULE=n to my configs/mt7622_bpi-r64_defconfig
>
> commit: https://github.com/frank-w/u-boot/commit/2640a8881d3c6a232575f46b0f2b8a0217b6d639
> fixed pipeline: https://github.com/frank-w/u-boot/actions/runs/10059965071
>
> breaking commit seems to be
>
> b7a625b1ce49 tools: Build mkeficapsule tool by default if EFI_LOADER is set
>
> i have EFI_LOADER set to y,but it is unclear where the header-file should be...i do not find any gnutls.h in my tree

We should really build all tools always, where possible.

>
> regards Frank
>
>
> > Gesendet: Dienstag, 23. Juli 2024 um 03:55 Uhr
> > Von: "Tom Rini" <trini@konsulko.com>
> > An: u-boot@lists.denx.de
> > Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
> > Betreff: [ANN] U-Boot v2024.10-rc1 released
> >
> > Hey all,
> >
> > It's release day and here is -rc1. Looking at my own queue, I think
> > it's in OK shape, but there's a few things I want to take still, and I
> > need to check some other areas for mature changes to pull in as well.
> >
> > In terms of a changelog,
> > git log --merges v2024.07..v2024.10-rc1
> > contains what I've pulled but as always, better PR messages and tags
> > will provide better results here.
> >
> > I hope to remain on schedule and that means the rest of the rcs every
> > other Monday, and with final release on Monday,  October 7th, 2024.
> > Thanks all!
> >
> > --
> > Tom
> >

Regards,
Simon
