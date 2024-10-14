Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D00D18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD59F88DED;
	Mon, 14 Oct 2024 23:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fpyrSxp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA75885D1; Mon, 14 Oct 2024 23:35:26 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077F288DED
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-45ffafa63easo42683431cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728941723; x=1729546523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEzaQ7hk89W1kHvmOvVpa+DGADnFEmMjdYzPMNV8UDQ=;
 b=fpyrSxp1EZ8VOGf9A4kLLY1Rhx750cG66hUJNOc9mFC5uH54vsjNyhaLFO4ZeI5IoW
 bgQfAYH8+L6hIcUC6HiHvS3cUI48RRT1klO0vN0Hh62IRKPf/fd+Qg1OHx7kvp7WLqgz
 haQiPzX/I5M93rWIoh247aSHf+QEGOCSwhD4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728941723; x=1729546523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UEzaQ7hk89W1kHvmOvVpa+DGADnFEmMjdYzPMNV8UDQ=;
 b=hrdSsdHj5vxJrrGtloHfFxEgAe6ZgM8nLmZsZp8vq+1gCr+GjvsarnPw542AekzanS
 SBWF3d5/rusEns8gwJ9LFIwBp8iN3f5jkIIAqxiOkbhShQtVMSx2XLmh8N5BxcZBsyqd
 JuINUG9creDpIlglgpLofXwolj1+wPLi0tIbqkIVoRpRKwkEEYCnkhEGTtIO7tu51Yho
 sAFd3JUPpn4G0qSxMNIQtaZbTsjEQh1fEZ2gWmnTyKUob+Qr8GeZ7XjM3cK67DQfcXwW
 3NNSysM1UcYrHfcYM6G5kqqlQZmg6wMHlCileIlof//1i4k2S6qrei79M5L5dx3Vc5XW
 VaDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7AcMPWFMrCcV6ZkzpuzWYPTaa+vlrT5B7ml6BWm2GumBP7hPXwoRWkubcOBP5kmaFFwXIuyw=@lists.denx.de
X-Gm-Message-State: AOJu0YxLJdCgz5bVN8vhCBe13e9XQxgTvcBcGTNHY4cJHoyU/L831yi4
 j0H4U8FcV+2GyR62hfogl0hojW7Jqafn+6lEhAwAoInoRjoiq27PLCfFJGQNGkWr6exZeaDnIWx
 er8R7c2bdE6HsKTRHgUAPiDB7ZMCbAHsiLx8O
X-Google-Smtp-Source: AGHT+IGLJgiLso7JCYdUqNU9TulXMEPxZ/DSNHPIB0z9IoBGwcBd9piqEVbnW6STsCz8B/GrsiAEERx9qULpYFZx2Cg=
X-Received: by 2002:a05:622a:2283:b0:460:59b1:d80 with SMTP id
 d75a77b69052e-46059b11492mr152517871cf.21.1728941722790; Mon, 14 Oct 2024
 14:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
In-Reply-To: <20241014212718.GZ53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:35:12 -0600
Message-ID: <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > > > > > LMB module becomes the common backend for managing non U-Boot image
> > > > > > > memory that might be requested by other modules.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > > Changes since V2:
> > > > > > > * Use map_to_sysmem() to get the user-visible address to be shared
> > > > > > >   with the lmb API's for sandbox.
> > > > > > >
> > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > >
> > > > > > When efi_init_obj() is called, it should be able to add the lmb memory
> > > > > > to its own tables. There is no need to worry about lmb after that,
>
> Saying "There is no need to worry about lmb after that" is not true.
> Invoking the "env" command for example will have efi_init_obj() be
> called, among the others that Heinrich listed. And to possibly refute
> a next issue, that is intentional so that efivars, the standard
> mechanism used by an OS to talk with the firmware can be available to
> U-Boot, if I recall things correctly.
>
> My understanding of your assumption is that you believe that once the
> EFI_LOADER subsystem has started work on a payload we're just a few call
> chains away from the OS being started and runtime services aside U-Boot
> being done.
>
> My understanding of how things are used today is that this is incorrect.

What I am getting at is that once we have called that function we know
we are booting an EFI app or using an EFI feature in preparation for
doing so. Let's start there. Is that correct?

Regards,
Simon
