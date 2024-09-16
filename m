Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81216C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B7188675;
	Mon, 16 Sep 2024 17:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FEcqng8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5452588EDA; Mon, 16 Sep 2024 17:42:07 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D2788387
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c3561804b5so26731156d6.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501324; x=1727106124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N0rokLHyfr4Hfp6l6m4t0H50rMLn5MXkT0YHiFHKj2c=;
 b=FEcqng8QT1E9KacdNSjzAo3VwsMmnfDR9u7rEMeDK2vbFEm6yPQ+4PBpVlYvXoHfU/
 FbeD5BVOiYfZdza494coDWNJksm+95ryJaOeCdiqT+0W7oq5luqxj9IzOxCjgauMfbBq
 MAZqNiTcybHlO+ftZF2Xd0mViQ3sSEOgLVTCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501324; x=1727106124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N0rokLHyfr4Hfp6l6m4t0H50rMLn5MXkT0YHiFHKj2c=;
 b=MCb0ERPVbLPS1UwLokMu6MdB8hW1QzMvc6EVajipb+x4C0ec5hSBbmjvkylG6ayP2F
 G4l+Se8wn27OHtW2e6rGl3L09JCo6gEAZex3V7RnQvhWNzuk4MEfz3+G9wvCNWSYAjDL
 V66/gl6ejLSXOeJrdPFmS5sQCuynfXdGcR1z1z9vKhv3dhBtOb9J3uHAxdlwECpVzFX5
 AcjXuT6sPXgxuemrUlwk+5Mjr0MBuiL+HDH7fhoORjZD8nXlpzkIQktJujbIwTYApYgl
 tYU1X8c3GBaAqDuaVWbuTOjWhLyBBfNWzjMrCygKo3oZyauRjynD8oV2ZCgXZzpu5IAD
 XikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3mrTCWAPSjmmf6JWj99pvHTyNPv41CgF23z9dBba7X2U5lT7EZEA8f6HhxRUMFZHfwsYPZLo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzwhg8kXQbhyQd13ee4s4Qu8wDdxi+Fw5PRhqqROolQav4qaqZS
 F4bimZXpgXuVLpitnzB45238yIgMhj3yvOYUBjmuwyIZD2yttzs4jHaTfQpe0hAOKSkNQ65PYln
 qvjJXuRe9+HD/SCJVvNOn6D5Z0UT400RUJdXX
X-Google-Smtp-Source: AGHT+IG7MIj3QCkGPTNoxo4pnmdu7BC5KuSsdH32fuNHptTZla2PoHlLTSC4dt2oLg5tcdBzqhHXVe2TjtRSQNuK3tE=
X-Received: by 2002:a05:6214:3904:b0:6c5:52d5:bbd0 with SMTP id
 6a1803df08f44-6c57e101b25mr189163376d6.32.1726501323972; Mon, 16 Sep 2024
 08:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-9-sjg@chromium.org>
 <ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de>
In-Reply-To: <ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:41:47 +0200
Message-ID: <CAFLszThNbOnfUvzk7QOhnBaD7Xn2+=uw1nOxLmCztu_5ZYL2gA@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] efi: Use the same filename for all sandbox builds
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

On Thu, 12 Sept 2024 at 08:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 03:18, Simon Glass wrote:
> > Sandbox is not a real architecture, but within U-Boot it is real enough.
> > We should not need to pretend it is x86 or ARM anywhere in the code.
> >
> > Also we want to be able to locate the sandbox app using a single
> > filename, 'bootsbox.efi', to avoid needing tests to produce different
> > files on each host architecture.
>
> The changed include is not meant to set anything for the sandbox app
> which you run on top of an UEFI firmware. The sandbox app probably
> should be called depending on the architecture sandboxaa64.efi,
> sandobxriscv64.efi, etc.
>
> This include is defining which file the EFI boot manager loads by
> default. This value must conform to the EFI specification. When I have
> built the sandbox on riscv64 I expect that it will load bootriscv64.efi
> from a distro installer image.

Perhaps we can support something like that later, but sandbox is
mostly for testing and development, so I don't see a lot of benefit.

It just makes things confusing. As I mentioned in the commit message,
sandbox is an architecture within U-Boot (see arch/sandbox). In the
early day we started adding host pass-through features but they didn't
end up being very useful.

If you want to boot a riscv64 image, you should do that on suitable
board. Of course the actual code in the bootsbox.efi file will match
the host, but that is actually the point of sandbox!

So I don't agree and I believe that the original change which split
these out is wrong.

Ilias requested that I drop the Fixes tag, but the offending commit is here:

3a0654ecd0d efi_loader: correctly identify binary name

I am not sure what this has to do with reproducible builds and the
commit was silent on that point.

Regards,
SImon


>
> Best regards
>
> Heinrich
>
> >
> > Drop the confusing use of host architecture and just let sandbox be
> > sandbox.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >
> > Changes in v5:
> > - Drop the Fixes tag
> >
> > Changes in v3:
> > - Put back the Linaro copyright accidentally removed
> >
> >   include/efi_default_filename.h | 24 ++----------------------
> >   1 file changed, 2 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
> > index 77932984b55..06ca8735002 100644
> > --- a/include/efi_default_filename.h
> > +++ b/include/efi_default_filename.h
> > @@ -16,26 +16,8 @@
> >   #undef BOOTEFI_NAME
> >
> >   #ifdef CONFIG_SANDBOX
> > -
> > -#if HOST_ARCH == HOST_ARCH_X86_64
> > -#define BOOTEFI_NAME "BOOTX64.EFI"
> > -#elif HOST_ARCH == HOST_ARCH_X86
> > -#define BOOTEFI_NAME "BOOTIA32.EFI"
> > -#elif HOST_ARCH == HOST_ARCH_AARCH64
> > -#define BOOTEFI_NAME "BOOTAA64.EFI"
> > -#elif HOST_ARCH == HOST_ARCH_ARM
> > -#define BOOTEFI_NAME "BOOTARM.EFI"
> > -#elif HOST_ARCH == HOST_ARCH_RISCV32
> > -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> > -#elif HOST_ARCH == HOST_ARCH_RISCV64
> > -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> > -#else
> > -#error Unsupported UEFI architecture
> > -#endif
> > -
> > -#else
> > -
> > -#if defined(CONFIG_ARM64)
> > +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> > +#elif defined(CONFIG_ARM64)
> >   #define BOOTEFI_NAME "BOOTAA64.EFI"
> >   #elif defined(CONFIG_ARM)
> >   #define BOOTEFI_NAME "BOOTARM.EFI"
> > @@ -52,5 +34,3 @@
> >   #endif
> >
> >   #endif
> > -
> > -#endif
>
