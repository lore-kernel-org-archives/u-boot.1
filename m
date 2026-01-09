Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AD5D16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293D983F56;
	Fri,  9 Jan 2026 12:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+1/P36v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85A08423D; Fri,  9 Jan 2026 12:32:28 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F89083CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34cf1e31f85so2692852a91.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958345; x=1768563145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CczFiZuwK9BoqtX3vKvC/4Rk4mv1f+VxPmnM+H6SpPk=;
 b=A+1/P36vuCQyYJM0CZ2mSkdBzPtPF/KI7xeYJg9zsKDXWeAv2r8yC3uSD+jsn1Bc40
 eYwmCFFU/0g256OpSKfzR5lPGN2H/IJ2v3JFn8MFtMIjZaPEOwF66s06Vcj9gi/M8H0+
 ngdVke9PAVlePMCveBnceC5Yw2tltFHHJiXS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958345; x=1768563145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CczFiZuwK9BoqtX3vKvC/4Rk4mv1f+VxPmnM+H6SpPk=;
 b=OzKqD7CCqRbaxZ6edGsm+iBaBbTH3r9HzE+tGthO2aiFAlh1cFQ5pCLlqfcUA6haXz
 1hBjJ9pFn9JwEj8yrRIjRyKYIJh5mk3by9PcUbpdPxfEgslK64TrLCaO55cUOUG1Ju26
 bumQkp5Qbte10tEZbJGiUtIGN2Sh0jrRHQclIzu9CzVmQbDZ2WALRf9P/I3AdVRmBFrq
 xbM4YkUSBM9//Tp8a56c3BWqMRLKQzCGGM+0M/5dgcbdtbNNrM53YVDHN5OJsWXVNQ/C
 lEoSvDxw2rmrsHMUDam0deV3g8VARHpX9HzdfpJf19nYVONX1cqQNQbQzrdLAGK1DA0E
 Freg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFQg3RfKyFfJQCUc/rHJH+WPDaC2pC089kwBBj5/n6e2eZhdAbPIleqobrELk5rOX3mT93nVc=@lists.denx.de
X-Gm-Message-State: AOJu0YzC0MhtIakbzZ8Swc2F10e/0TO+uXFzZcZ3EYOReJ3ZSsq0yfHT
 c3MScL4YmJ2IzNYbQUBNEaLrFp2hke2D1cLL9UaaAALeEjdyKrMY4nJWZYsw19E+k+FUnqELDhw
 Bg24Nmq81KzJNLyygZxLdX55kwChlWek5iGmGixaS
X-Gm-Gg: AY/fxX4tvmMgZwc9seSLrKPtjLYpfQZ0NubiFmHgTTUdVSXXvddTOEqMK0gDo3GjtcN
 +lHElG1Vkwm3RNnJoENsn0yydXxOcQQec3HQhB7D2X/mIxneNB+AXbKBEm7StmhC4rB36AqhD9J
 JUclbQbJ/y/I1YuSR7whzoNwe0mohS4RFFmBPuJ0Xk2ITWb+z4HO6CbKkYLa10QR7+n3m4F5CMH
 rOTZny0TeoAITdQMxnusXZk4RaoQDx4+eFitLIa3np1v7/KswfMf8Y1rcPdFCFvzQnXFA==
X-Google-Smtp-Source: AGHT+IGHErRKgv242zNHqo7+We7wwqzz9yvIxc5qMb/0NXyJ0AgbfTvM9V5uX7IsRHLRlzyriHxnKGUKlUy/ZNvRssw=
X-Received: by 2002:a17:90b:4acb:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-34f68b4c603mr9457958a91.8.1767958344726; Fri, 09 Jan 2026
 03:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20260107201838.3448806-1-visitorckw@gmail.com>
 <20260107201838.3448806-6-visitorckw@gmail.com>
In-Reply-To: <20260107201838.3448806-6-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:31:52 -0700
X-Gm-Features: AQt7F2qEncCoh3eE25k-fRIuPJyBo4pLz01N0aZkB4LH00AJ6yPiOm4eOpL3Nvo
Message-ID: <CAFLszTgys6Y=JNu-=aFoQ071Ac63qMKB99OVj-NtJ5-Arcw-RA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] m68k: Add support for M68040 CPU
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

On Wed, 7 Jan 2026 at 13:19, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the Motorola 68040 architecture. Currently, m68k
> support in U-Boot is primarily focused on ColdFire variants. Introduce
> the necessary infrastructure to support the classic M680x0 series,
> specifically targeting the M68040 as emulated by QEMU.
>
> The implementation includes exception vectors, early startup code, and
> minimal CPU initialization and relocation stubs. It also defines the
> standard m68k boot information structure used for passing hardware
> information to the operating system. To ensure compatibility, ColdFire-
> specific library objects such as cache and interrupt handling are
> excluded from the build when M68040 is selected.
>
> Additionally, apply a specific workaround during the early memory
> reservation stage. Use a manual loop to clear global data instead of
> the standard memset() function, as utilizing memset() at this point was
> observed to cause a hang on the QEMU platform.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v6:
> - Introduce hidden Kconfig symbol CONFIG_ARCH_COLDFIRE to group
>   ColdFire-specific files in Makefile, removing the need for
>   'ifndef CONFIG_M680x0'.
> - Add help text for CONFIG_M680x0.
>
>  MAINTAINERS                      |  6 +++
>  arch/m68k/Kconfig                | 30 +++++++++++++
>  arch/m68k/Makefile               |  1 +
>  arch/m68k/config.mk              | 10 ++++-
>  arch/m68k/cpu/m680x0/Makefile    |  6 +++
>  arch/m68k/cpu/m680x0/cpu.c       | 73 ++++++++++++++++++++++++++++++++
>  arch/m68k/cpu/m680x0/start.S     | 73 ++++++++++++++++++++++++++++++++
>  arch/m68k/cpu/m680x0/u-boot.lds  | 47 ++++++++++++++++++++
>  arch/m68k/include/asm/bootinfo.h | 39 +++++++++++++++++
>  arch/m68k/lib/Makefile           |  7 +--
>  10 files changed, 284 insertions(+), 8 deletions(-)
>  create mode 100644 arch/m68k/cpu/m680x0/Makefile
>  create mode 100644 arch/m68k/cpu/m680x0/cpu.c
>  create mode 100644 arch/m68k/cpu/m680x0/start.S
>  create mode 100644 arch/m68k/cpu/m680x0/u-boot.lds
>  create mode 100644 arch/m68k/include/asm/bootinfo.h
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
