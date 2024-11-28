Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361C2D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B30897B5;
	Thu, 28 Nov 2024 20:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbYHkL23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C2589D06; Thu, 28 Nov 2024 20:11:01 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F568949D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso160133766b.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821059; x=1733425859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tGz5gCWGQB8S2QYrE9PJzk0H1o592SWqapnNmmcRWTA=;
 b=UbYHkL23+Godi+JDppjFCCyoDaukAXK16oW9CSfkmXGqO+8On7N8AtAu+60rm8IpIw
 OlbZtUXunSN9m+qPGz7t/LJc45z5he0718cx0x1C2PRGTCoFkTLQUwRneF9CpoAM8KDO
 bq4ijshbBUpcK1t5mml40BczVabgDkZvT3uvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821059; x=1733425859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tGz5gCWGQB8S2QYrE9PJzk0H1o592SWqapnNmmcRWTA=;
 b=viZfwu70dAfRqJrMt1NYxRdyGDS8VM5KeZnN3kViWUGAWwutS8YtaIPDNsdZz8YMPQ
 sHb21yBe86Sgs4H0T0zKVWxXIx1hlpYcIV/vWBg2Ucsc6eTZXMLpI8ookxPUKdZL2r8k
 wnzJ3dXBPRZjRMxSjLl48xu6LLq58i9lNZ1u34h5qMJmf8RjbFFlDmi4lNJ02LQCIqPd
 B97q54Bmrhbq7kWE0qdlOnxcpeWtocxEI3mek1eisY+YJSEsMKoAwOjQAt0RJMMDYeby
 23BYTJfr1SrBgsCg7KGFfjnkgjai2CcZOqcOEYDi2XUeziOifUBCOlhWjOgv6Vn1oWe2
 //kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZuBm9MoM95yAKXVAp0GxxIXA3eihdNY5K6C2JBh/SwtmMpiXcvBhxlAV2YFJnoYi7VWtSMFg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywm1nHubktqAIDLaHW8IEyxSRxIcTzKKtHFfhFtv4euIPT4PfoV
 k6Z2SaoG2CYDT5JDGgrE9/eZqPdQBb4+NrX0UoBrezuHwVSM65xH2wxaFT71ds0VAR5YZff6Mss
 ZHDVtXNZtZ+BwZHPAsCJdv/GHSPXmJCAF8Xho
X-Gm-Gg: ASbGncsWZNZIwMNFpFai4IrlRVqQM/mEGbtNQHTZZ+emXL4ZX0Dly+1nhvGUyLfFhRG
 S7ExO8V1ZynG2ZdIoYUFsbRQHY0CU9UM=
X-Google-Smtp-Source: AGHT+IHuMx63I/IuszVT2GjdaUPo8M1WoGt3HTS0LZvtrVgmB95rfbmVpgq0Ra34D22S9/P8DJKXcWO6/+wafTbxrL8=
X-Received: by 2002:a17:907:7856:b0:aa5:27a8:4cbc with SMTP id
 a640c23a62f3a-aa580f266c6mr636048566b.15.1732821058652; Thu, 28 Nov 2024
 11:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-28-sjg@chromium.org>
 <c158c1e4-95f6-422e-8bb5-c86dcf418d11@gmx.de>
In-Reply-To: <c158c1e4-95f6-422e-8bb5-c86dcf418d11@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 12:10:45 -0700
Message-ID: <CAFLszTh5gFho0o1Mi=gU96b+PtuypnMtJHm6VQgabpXU8c3g5w@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] efi_loader: Don't try to add sandbox runtime code
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 28 Nov 2024 at 10:43, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 16:47, Simon Glass wrote:
> > This cannot work since the code is not present in the emulated memory.
> > In any case, sandbox cannot make use of the runtime code.
>
> For sure an EFI application running on the sandbox can run
> ExitBootServices() and then call the ResetSystem() runtime system service.
>
> Have a look at
>
> arch/sandbox/cpu/start.c:472:
> void __efi_runtime EFIAPI efi_reset_system().
>
> __efi_runtime implements ResetSystem() after ExitBootServices().
>
> >
> > For now, just drop it from sandbox. We can always adjust things to copy
> > it into memory, if needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
> >   1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index a33c025fa20..796fa99f4fb 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -755,16 +755,22 @@ static void add_u_boot_and_runtime(void)
> >       runtime_mask = SZ_64K - 1;
> >   #endif
> >
> > -     /*
> > -      * Add Runtime Services. We mark surrounding boottime code as runtime as
> > -      * well to fulfill the runtime alignment constraints but avoid padding.
> > -      */
> > -     runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > -     runtime_end = (uintptr_t)__efi_runtime_stop;
> > -     runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > -     runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > -     efi_add_memory_map_pg(runtime_start, runtime_pages,
> > -                           EFI_RUNTIME_SERVICES_CODE, false);
> > +     if (!IS_ENABLED(CONFIG_SANDBOX)) {
> > +             /*
> > +              * Add Runtime Services. We mark surrounding boottime code as
> > +              * runtime as well to fulfill the runtime alignment constraints
> > +              * but avoid padding.
> > +              *
> > +              * This is not enabled for sandbox, since we cannot map the
> > +              * sandbox code into emulated SDRAM
>
> The memory map is consumed by an EFI application like shim, GRUB, or the
> kernel stub.
>
> The memory map entries must take address values which can be used a
> void* without conversion. This is true both on real systems and on the
> sandbox.
>
> Isn't __efi_runtime_start a pointer to the start of the efi_runtime code
> section on the sandbox?

Yes, but it is not mapped into the emulated RAM, so it doesn't have an
address. Yes, we can get a pointer to it, but it isn't in the memory
map. So there is no way to add it to EFI's tables in a sensible
fashion.

A lot of the bugs fixed in this series were the result of the EFI
sandbox test finally landing, after a year of being ignored and
blocked. I am sure we will find more.

Regards,
Simon
