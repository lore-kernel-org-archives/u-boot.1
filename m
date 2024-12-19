Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8BEE77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13D480378;
	Thu, 19 Dec 2024 03:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JRkCFihO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDECB80391; Thu, 19 Dec 2024 03:43:47 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76CB8042A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa6997f33e4so44050966b.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576225; x=1735181025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YlF+1II487yu8djTrTq0gufxpsDfsEThsGF2f2ha6BA=;
 b=JRkCFihOre9vJ2RtykXL/Bp61A3BBAtJnnTQacYqBmihNkmB8z3mDKjsqdLBRL4BOI
 gJD/mgIW8V+UrCdChYg1XEVdxE7MqNq9z3uM7aT7fDtVv7Ikg54iQYc0ZJspBCY8eZYX
 5ykf+7/gAZzVgUfGmFAafkIrJYRm6+cIkFfHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576225; x=1735181025;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlF+1II487yu8djTrTq0gufxpsDfsEThsGF2f2ha6BA=;
 b=XcdeOcHQg84rqNkPv3rdhNCQA3DYpSnjQsbYQNIS+f9x8BrfoxWCRHeyosmwGxFo3w
 c7KULKlDkvk1fVHWDGqLtouTT3WWWSemauxw0x8u1VspGvIoS4c8fwj2ZC5XcypWmMup
 3OX8NbyW0GBcdomnJIPsGJdbaq4JghXwov74mebpKLCwaBYPDTjlw1jwlpK/PiZ6cWeN
 fIs0F38m7FF+yDYJ1LyPZgsTgt7pPIfCsqCQjYVPby/I4miQlLh/USRhp+XOVtvcTE8v
 Hj/TR/Y/D5gak34B1G7SonkfJgQ2dXbOPRbQwBHeokuXG/VsPwxw8Ga5N0wtACpK/Ywb
 9eeA==
X-Gm-Message-State: AOJu0YxN0oDDCdUOu/7pUxJArHRSHL+Sr/ABXSb/vVxUl8eVpZf6OHFX
 R4Y57KHekvRi2pompmr/d8Gwovugwea40L1L9mbUO4bV3Eqgm9pjBsMcnRCPHY2OlDiEI7qGl7x
 H9+20NBYUWJkI8WUgM7RPcz1gv1/U4nbcneuf
X-Gm-Gg: ASbGncsAqHDP90doXCPgMcwPt2mP1XQjyK9ZWLaPkbp2acYUZGalAys6jDOkGeGviPB
 XViH87/fsivfvdC2v8eN8XAF2MM3F2OghAdXY3LI=
X-Google-Smtp-Source: AGHT+IEpB0aDEcPHlllHqvDTr30CO7PPuiArUYPBW5hZS4JYqmQGmAH188FRqXuZAeobgnJTYKqIorpAwEvibj7pyOU=
X-Received: by 2002:a17:907:25c5:b0:aa6:aa8e:c89c with SMTP id
 a640c23a62f3a-aabf48d51c3mr382209366b.39.1734576225240; Wed, 18 Dec 2024
 18:43:45 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:43 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJrXndvOAN3dL=vJUP7e5zYXGeGRVZofs0G-HH0t_0XLw@mail.gmail.com>
References: <CAC_iWjJrXndvOAN3dL=vJUP7e5zYXGeGRVZofs0G-HH0t_0XLw@mail.gmail.com>
 <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-6-sjg@chromium.org>
 <CAC_iWjLk_moWeTpo-dR_FV7E4+40U0S+DjD5dd3nWhf2KSGDrg@mail.gmail.com>
 <CAFLszTh1wPrjXu7oJrdUGqyGEFLC-mZ4JzuwXuiUjegpqhPA9g@mail.gmail.com>
Date: Wed, 18 Dec 2024 18:43:43 -0800
X-Google-Sender-Auth: D-JNNPl-RkW8FWJR3DaMZLkn1jk
Message-ID: <CAFLszTjQ02tTa6TVj5bX9FAgUNXg_vXT2=MUq0S7qzp4Z91Opg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] efi_loader: Move the fallback code from
 efi_run_image()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Simon Glass <sjg@chromium.org>
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

On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 12 Dec 2024 at 00:53, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Checkpatch has errors on this. Please have a look
>
> It's the brackets not matching up because of
> efi_uninstall_multiple_protocol_interfaces() being so long. It also
> complains about possible blank lines at the end of the file, but that
> isn't correct.
>
> >
> > Also for some reason is fails to apply after patch 4.
>
> It is based on top of the other series (confusion between pointers and
> addresses). I can send it independently if you'd like to apply this
> one first.

Yes please, if it's not too much work. I think the other one still
needs bigger adjustments

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >
> >
> > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This code is only needed if an invalid image/device path is passed in.
> > > Move the code out to a caller where this can be dealt with. The normal
> > > flow will provide these parameters.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  lib/efi_loader/efi_bootbin.c | 103 ++++++++++++++++-------------------
> > >  1 file changed, 48 insertions(+), 55 deletions(-)
> > >
Applied to sjg/master, thanks!
