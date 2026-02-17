Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AED7E6815F
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 10:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A398683981;
	Tue, 17 Feb 2026 11:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yPMaZFb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB5A83C61; Tue, 17 Feb 2026 11:04:03 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002418063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-649b5f5570fso4724179d50.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 02:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771322638; cv=none;
 d=google.com; s=arc-20240605;
 b=iANbdQclGLfzuvHpHFk9gvmN7vE1QDk20mculcm7OviWaOy2MzI9d0tr5qHSv1h/t7
 T6j4MHBzCgEK8upr77atkL98soUQ/8XKGA+CTmDPGE+WFtTYJ0W7uYoq0Xo3scBi1n21
 XkN60uLfeMF+uCiYuykQTRHdF6FEw0H4O2WrWCufFHeRM+3R3IhRTufBS1rHarSvVu3X
 YihdAitUZNKN0XA3Xc4i3SgU3pui+qnakOr81RQWWeMGkPck9s7X7SpCImCHYf3esghG
 tYe4GTIsXmheKx14+58ekXXXp/aVhLmOSGUadh39cVyhLrWxvfPUpPqs9TxK4EFacRrc
 c73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nDNuTPZN1k8jh0KjSBsfJBNiLfNxyAPgqwBOklCK7jE=;
 fh=fqr5n6MU+VFjSwQmuMOk4Knbf7/e/cAgkcBN8PgaEUU=;
 b=MZnWsiJrUTqRjg0TXemDvTfyHV6BggfnMsyeuGaBrwyMv/OhyLH+1O6bRN0TcPCN/C
 FiXMGQQORPA6kNn8y06md6ucGxzzKOqLIf4amWVxwVguNzPnwctHKfqkcRZnT14HIGck
 vBqMyxlHex+6JaXfmUip4w5mu/oV/so3uBZFbJsTahvsVoeBMuBRVTO5IVW9MazpbnYr
 iwGPYyWYnijwScQ+fQLHwKO0KMfpeHuDCdQT4rxNzS/xX5SL0EDzHN5Z9VrtiZKrz77F
 uxgtxvX4b4elJMBo51Hpn77F8c8Ae/A7Hkchwsf1zyTcMuTy+n4G/fHpPuzbzXwaswwM
 SLFg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771322638; x=1771927438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nDNuTPZN1k8jh0KjSBsfJBNiLfNxyAPgqwBOklCK7jE=;
 b=yPMaZFb5yGfz4+vxxwxmvHRVCxZLLaoFiygYhmlDNlO88949JMM0CBTHOYRs5nwIua
 IitERgMPNeIRfdT026GX5/DIWNMyYdhgW6b92R1SgFREVXADUOF5nitZ3TwnNNlIsVo5
 wu9pEBcpgurOoQVflVxQ13wHEPvPhDwiFd16kigDqUu71HBKTBY65CD/Yo+DgTxOcNWe
 Y4RadMTT2wvMsZmS12Hq1oP6d6e2FV5jasyV/PitiVKhL/ZWRSjocq+2jyHQgXirg59O
 h80eT+kImQeHeioglIsOmPQcu34GVskJA3nzgUra8eapOeXqYVlur1RFfePedeM6qbCr
 jERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322638; x=1771927438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDNuTPZN1k8jh0KjSBsfJBNiLfNxyAPgqwBOklCK7jE=;
 b=SPM9dbwMAgEf2XV52PaySIEoX+CprOzyQDpJz6DpmmeqUPNzWDuonL+YUIIM4/GJ7T
 keA4fzoI/jaNGISu/MspX77BKFguXJunVzB0XNHv4X/vbjgN6bL57YYgkNxjmfg/mcxQ
 W7r3TvVRcPuHcG157xqRMjy8rLxW6+CJIXpCQJQXPcXBiqjzMwLdMdf9L3yj0NRKg5OZ
 7h9Mz3PQXtV+LdZZkp43CnKWReWxzNtWKjh72TOJhScAkJpXctdSBAAdmTqUe1LitWKT
 eYq7sQB0sOAJ1NtADdAFUi+YZTJmZxeap8nJqZ3aafd2i5DmB8VOeK4pdh7W0LBSdlwd
 S36g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3QmNakfqACFQ/mEEhzTHjofWueFk98fyCwP6k3fnF56LzN+YSgJXdzSPR3AsMj6EmlFwcBSA=@lists.denx.de
X-Gm-Message-State: AOJu0YydQ8RI5uUwXAl+xRLNn+jZkFQcb9cxA3SUP4Z7Mi5Uf+OeN/Xf
 1DcGVJaUK1dbDJCvAWFuXvmWwIkQ1D85UN7B9caP7hFFXsi3/wUxwDJpCeH2KBP4I2n4ZmyB4eU
 dPk91k6swBwPpP5dVn0tUc1nr0n+WDQ8Nst5Lz0UJSg==
X-Gm-Gg: AZuq6aIc0vukEAGC/aQIryjamoREtrXZK7dlSwuA+yF58bjlgQMATXYquGlmy4Bd9kR
 utVJOP7dMBP0UfijZo3W5nsI9zR8zK+DHjDoCY/3tjbiYXYvn8tAQNZUKmilk2/5seizX8cNSpP
 bBGY71Jyq3ozQ26LdyV5RVI5VfNqd27+G9KFsJiY62t4n0/2gP4zceMD2nVyBxxn8N1H/sBGM4u
 pNzJwF2d/WSSde9uXQe9m28z5Uw5QIUUZm77ESM3/ZCCvEJjDTKw3ezfhaUQPqRlCX7ewnqo9rh
 nyGKFQTNwB6kgGXirygP0IAzwwRrUWc8wPdTPgkVzysj+DpMtc28XViIf9BN7IpTC0EPnIIxkPR
 5XcR2MFftkX/PeWl1cQFxY867hT6kwSYbBWi82fO0jcT2BC+Lw1IdXfLId8zhfw+JJTj9DLHSLn
 oSJuFUCs91b0G1EPbYC3Oj69qPk4QNRcGnvTJgdIren6RlYPYrHppjvOlWYALrsxwa11Wmu9YHY
 Uu9CnEjMH0zcxFtl4S/Y8brduSdtJ7s+xAnc4hFO3Nx8Y49Zm+pjsLCF5LPad+8S+kQZ5Cdu3oa
 I0Tb+xSpC2r2Fq8K0eao/9hv+0hkakOUWPRyyP43jdkV
X-Received: by 2002:a53:d005:0:b0:64a:ef61:1891 with SMTP id
 956f58d0204a3-64c202785a4mr8000516d50.30.1771322638568; Tue, 17 Feb 2026
 02:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20260217074655.34137-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKvGLUoR7-hD3LdgkYy5Oh2zR+g+P5ZtKnkpg-A_XvfaQ@mail.gmail.com>
 <740c2e83-b7c7-49db-bdaf-067352d9aa16@canonical.com>
 <CAC_iWjKFnChaXoZ0VZ-e3zF7qpF4Lrw_9aF8w3hT_kNRHcL5kg@mail.gmail.com>
In-Reply-To: <CAC_iWjKFnChaXoZ0VZ-e3zF7qpF4Lrw_9aF8w3hT_kNRHcL5kg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Feb 2026 12:03:22 +0200
X-Gm-Features: AZwV_QgyJqvPcxyl3AJ574a4SDaVnKIOQkpkJhNiJKi4sGJOKNvnH6YL3e1Eq9c
Message-ID: <CAC_iWjKzdWLMT_OpnEp-s686axrk7qUsX8Vq=9uWoY158XYPmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: require at least 128 KiB of stack space
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 17 Feb 2026 at 11:24, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 17 Feb 2026 at 10:46, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 2/17/26 09:18, Ilias Apalodimas wrote:
> > > Hi Heinrich,
> > >
> > > On Tue, 17 Feb 2026 at 09:47, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> The UEFI specification requires at least 128 KiB stack space. Consider this
> > >> value as a prerequisite for CONFIG_EFI_LOADER.
> > >>
> > >> Mention the requirement in the CONFIG_STACK_SPACE description and decribe
> > >> that the UEFI sub-system uses CONFIG_STACK_SPACE when defining the memory
> > >> map.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >>   Kconfig                | 8 +++++---
> > >>   lib/efi_loader/Kconfig | 2 ++
> > >>   2 files changed, 7 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/Kconfig b/Kconfig
> > >> index ce25ea24a60..99b3cd62526 100644
> > >> --- a/Kconfig
> > >> +++ b/Kconfig
> > >> @@ -615,9 +615,11 @@ config STACK_SIZE
> > >>          default 0x4000 if ARCH_STM32
> > >>          default 0x1000000
> > >>          help
> > >> -         Define Max stack size that can be used by U-Boot. This value is used
> > >> -         by the UEFI sub-system. On some boards initrd_high is calculated as
> > >> -         base stack pointer minus this stack size.
> > >> +         Define Max stack size that can be used by U-Boot. The UEFI sub-system
> > >> +         considers this value when setting up the memory map. The UEFI
> > >> +         specification requires 128 KiB or more of available stack space. On
> > >> +         some boards initrd_high is calculated as base stack pointer minus this
> > >> +         stack size.
> > >>
> > >>   config SYS_MEM_TOP_HIDE
> > >>          hex "Exclude some memory from U-Boot / OS information"
> > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > >> index 13e44be1d06..450ffa61c0a 100644
> > >> --- a/lib/efi_loader/Kconfig
> > >> +++ b/lib/efi_loader/Kconfig
> > >> @@ -15,6 +15,8 @@ config EFI_LOADER
> > >>          # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > >>          depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > >>          depends on !EFI_APP
> > >> +       # The EFI specification requires 128 KiB or more of stack space
> > >> +       depends on STACK_SIZE >= 0x20000
> > >
> > > Won't this disable EFI for ARCH_STM32 devices? Those define the
> > > default stack size as 0x4000.
> >
> > The UEFI specification explicitly requires an enabled MMU.
> > The ARMv7-M architecture does not offer it.
>
> There was a discussion about this earlier and we decided to keep it
> alive though. IIRC Mark explained why we can keep it enabled.

Ok looking at this again, the symbol for v7 is CONFIG_ARCH_STM32MP not
CONFIG_ARCH_STM32

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Thanks
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Thanks
> > > /Ilias
> > >>          default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > >>          select EFI
> > >>          select CHARSET
> > >> --
> > >> 2.51.0
> > >>
> >
