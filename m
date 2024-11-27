Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12DDD6ACCD
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB5E897DD;
	Wed, 27 Nov 2024 14:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FqFDPefz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A14897D9; Wed, 27 Nov 2024 14:07:20 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17C0897D6
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cfadf851e2so8936168a12.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712837; x=1733317637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LwaWIycZMk0jaeiOsXMk9QVlaKMcWSgnysrfB6EYZKU=;
 b=FqFDPefzx2F10LcEBhcBw7QZgiwbI6TS/vghoW4pF11j9ANIbIbdIl17et3CI2O0DW
 DzJcbnJaf39+yIn9fPpbnDqbrYzvHxgcOQ9dnbBgrVnQ2Z1MFrFWUaaq+gPms86peWXi
 ijr0kdUF4/xoNeo+JxHGuSpoPdBc+Jke/TaO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712837; x=1733317637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwaWIycZMk0jaeiOsXMk9QVlaKMcWSgnysrfB6EYZKU=;
 b=GXaemoAFIDFJSiiSfgVu/zoMxOjVmay3zkhXCi4JxFaNgU36QzJgab/4vaHmrwv0Do
 XlYj33s/l1c9hJKHSRMqv0v0JmLriB5Sy2Hp94SNtzkc38P03gaw/PLVSTKlY4FArb80
 35Nu7BrE42ljhfGUKpsjv5RcCbsP7COWLJjmSoOvkfO+DsJUb9RqtCk/Hea6wgZthvtw
 HUfyUsYMWMpPmcSOSl2jTfdid02EjoNfg6CkmmqLc+nkcmFbFGhCbXnpmMvqCmEPNqdN
 iXnqefsZe2UWe/8I64EbVoWgE3ymkJ5hapwwQ/g7kSZ6YEcirdX9zn1p8/B8xIPo8JaD
 DzRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3BB9Y+DYalXdWL5HVGLU+8dNeS+rrtih+8f4cQ1l85xYe48HRZYa3ipBB3o/Ai9V3SVAbe0s=@lists.denx.de
X-Gm-Message-State: AOJu0YzM+sW1fMrvYZVDBlyaHsXB58cizDUsx/15PBLt0GdKo/3eKipP
 DmW2dDi4N6vBeTR4GUwntOMoOdRWrf+e8wj96rraei4nRfbLWDeBWLppzuNNXT2cEcKwfecbQpX
 iuTxwQR/CWVZFkKyoNCwC8XB9b8Xs0w//Mq6o
X-Gm-Gg: ASbGncuO7lmNqkS03iVyttTnyZherJlO547SoZ+rihPXAytWd+/UbyfVyN/Jjjveo1C
 aNxpDU169hn1M4rgdhgO7zolSCNswtAY=
X-Google-Smtp-Source: AGHT+IH2JzpmNmjolUzfmLtToP9XBTJ6BbLdqIwHs7yA9SMtmA06CivmplHekqBsFTMFP6GyhQysm5MOia27N8S7fg8=
X-Received: by 2002:a17:906:3293:b0:aa5:1ec3:b96f with SMTP id
 a640c23a62f3a-aa580f1e06amr306890166b.17.1732712837171; Wed, 27 Nov 2024
 05:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-7-sjg@chromium.org>
 <5976a08e-a242-4665-85e6-410f48776229@gmx.de>
 <CAFLszThWDNCNhZ6wAaG3omKpT-ZEDkK-R1W-9DWyMuth8Vd55Q@mail.gmail.com>
In-Reply-To: <CAFLszThWDNCNhZ6wAaG3omKpT-ZEDkK-R1W-9DWyMuth8Vd55Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:07:05 -0700
Message-ID: <CAFLszTjWgWZ6VZg8ZQOd2RVrX-+vGy1NuwaBZ+8vwGJ2R83wqw@mail.gmail.com>
Subject: Re: [PATCH 06/13] efi_loader: Use the enum for memory type
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 26 Nov 2024 at 08:37, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Tue, 26 Nov 2024 at 02:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 25.11.24 21:44, Simon Glass wrote:
> > > Rather than an integer, it is better to use the enum provided, when
> > > referring to an EFI memory-type. Update existing uses.
> >
> > The C standard provides no definition of the size of the integer used to
> > implement enums. It could use u8, u16, u32, or u64.
> >
> > As EFI applications may be compiled using a different compiler we need
> > to control the width used for passing parameters in the API interface.
> >
> > We should have used u32 instead of int here. We could use a typedef for
> > more verbosity though that is frowned upon in U-Boot.
>
> Yes, the ext function is debatable. The rest seem OK to me, though, as
> they are internal functions, See also [1].

Hmm, but the spec uses enum, so arguably this patch is more correct?

>
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Call the value 'mem_type' consistently. Fix up one instance of
> > > upper-case hex.
> > >
> > > Fix up the calls in struct efi_boot_services so that they use the same
> > > enum, adding the missing parameter names and enum efi_allocate_type.
> > >
> > > While we are here, rename the 'memory' parameter to 'memoryp' so that it
> > > is clear it is a return value.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   include/efi_api.h                |  6 ++++--
> > >   include/efi_loader.h             | 28 ++++++++++++++-------------
> > >   lib/efi_loader/efi_boottime.c    | 13 +++++++------
> > >   lib/efi_loader/efi_device_path.c |  4 ++--
> > >   lib/efi_loader/efi_memory.c      | 33 ++++++++++++++++----------------
> > >   5 files changed, 45 insertions(+), 39 deletions(-)
> > >
>
> Regards,
> SImon
>
> [1] https://stackoverflow.com/questions/4879286/specifying-size-of-enum-type-in-c/4879350#4879350

Regards,
Simon
