Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C2EC02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 00:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF336800C1;
	Tue,  4 Feb 2025 01:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gLY+MxwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF42680104; Tue,  4 Feb 2025 01:38:30 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F7480050
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 01:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab6fb1851d4so683363266b.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 16:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738629508; x=1739234308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sQfMD/B5BKXxGWhvqBCX0uT0/0xH+k2AJ/hKqzKmbf8=;
 b=gLY+MxwPmSof9jttQIntYf7yYO+NgmhJOCZsBATx0UPz47hTsQwGYPlcXE8NI2ABpT
 cJOC426yfcW6k/MQaQqG+/xmlFPMhGtXbyh+Ug+hXB5ESGWHNYqWYJVH05VrOLcQ8iar
 3mj0M+52wRtPF+CcGlF5FZaT5IITxalDgIQ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738629508; x=1739234308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sQfMD/B5BKXxGWhvqBCX0uT0/0xH+k2AJ/hKqzKmbf8=;
 b=hFVpgvRsBGMsbSTDYpAZqZja0m5mqkWqdTV1s94unlX4mBrgz8UQR9el8r9+0WubPd
 rGf/FGdJlBkwlSt5aceYhIft7gSKR/0KAXTytvoc1AkSV888ptzm5/U72D5rZHFrho0P
 BfmlScI+eZ5W8uPfxygz6cPXwXYw5okne27NDUlJk8N/yMtQMmNOoyiGitziS58aGLhP
 RFTpU+tE+SBI8MKakNDxKFb77xhR9liO+ss2N5TcLl0fpLmbbM02d0jwJj3J/DVM3Uwy
 h3hCYEJcx1ZNRpujVAyDsGKGAn37O4MM7KfIpW7Mg+W9AG3HXjqmRIpxIIkVpA92ckB2
 gdqQ==
X-Gm-Message-State: AOJu0Yzd6lt8pYp0Gess77Afakc+yM8m8nk6pkRC6zpSbQZM6RAr7Bet
 38ioxxSw8FgEyBi9KRlMpKQ5x0I1hCuNPbRRbN7rxGtMBa//KmZ77IPhUzZw9xMWADxhuJVBdcK
 uozFouVOlnSttVhTdtUJxdORKaIvcomS1ATqo
X-Gm-Gg: ASbGncsMyN7uDDeh3kCZsiZJF8T1IL0qof6VTe/PaaZ6UiQMYIolNUs5xqr/t0LY6tE
 5w3Mn1a6qsg3oHUJdO9xdLTg2YJZPkN5h1FTD8bwScSwDOJIdLS7Joy9VZFXg56gGOt6/zswmTQ
 ==
X-Google-Smtp-Source: AGHT+IHXDYVgrhbyLQbFYnEtKjW1qfk46ptcF81P1fJJwIxnVWYROfFbds2DRUlvaZgLHFVm0xxjE8lCcLEktM4fSK8=
X-Received: by 2002:a17:907:7b8c:b0:ab6:cdc2:3417 with SMTP id
 a640c23a62f3a-ab748435262mr122429866b.15.1738629507857; Mon, 03 Feb 2025
 16:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
 <20250203201036.GT1233568@bill-the-cat>
In-Reply-To: <20250203201036.GT1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 17:38:16 -0700
X-Gm-Features: AWEUYZled8RbuUJRgN5M3ZWYPGmNUoH5THjZWa_NMT0AkBTvEWPc1jMFUr-Y4GI
Message-ID: <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
Subject: Re: [PATCH 31/32] efi: arm: Simplify the crt0 file and update link
 script
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
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

On Mon, 3 Feb 2025 at 13:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> > We don't need to manually add the PE header, since binutils has support
> > for this now. Remove it to simplify the file.
> >
> > Set the link-target to efi-app-aarch64 so that binutils knows what to
> > do. Add rules to pick up the arm64 files.
> >
> > Make some updates to the link-script for arm64, so this all works:
> >
> > - Pass  .hash .eh_frame and .reloc sections through to objcopy
> > - Put RELA pieces into a single section
> > - Put linker lists into .data
> > - Embed the dtb
> >
> > Note that it does not seem to be possible to use this approach with arm,
> > so this is left alone.

Thanks for looking at all this stuff.

>
> Did you mean x86 in this last comment? I'm not sure about the rest,
> either way, so I'll leave it to others to comment on that.

No, I mean 32-bit ARM. For reasons I don't understand, it seems the
toolchain doesn't support PE on 32-bit ARM.

Regards,
Simon
