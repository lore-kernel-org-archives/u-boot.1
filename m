Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE879C5321E
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 17:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45F688640;
	Sun, 25 Aug 2024 19:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k40Bu0gI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24F5886E7; Sun, 25 Aug 2024 19:53:05 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6288862E;
 Sun, 25 Aug 2024 19:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-533462b9428so6128599e87.3; 
 Sun, 25 Aug 2024 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724608383; x=1725213183; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUuNtkz5nQuplOHrRKjreApOfkbilC+PA/cnCRIwr5c=;
 b=k40Bu0gIVY9q+wx3WyfS8PJAmvcVxlYQUIfyI9/pJfxhKWIvo9tAYWDXGF9TQ8lJ7s
 eAX50ONYKnSDlXL0+/1VHZawNaF07KZRlNZSJ3zwMyIu8StH1OMKUy1J9Z2IrjL+MWye
 MES8MZR7Jc1rfd9necpTz/8G8fWulnhF1dqtiLEFZ0+ZpUyRwrLXnWz89IxC4U6ycc1Z
 Nz+DiOdwBWfozrLhX2n0yMB9joODqtkrMNUz3tTlN0rl8F+R45PBxd3a3TcPm9Q4YHWd
 2Maqmi9p64ZIT8Zej/17hPLVSjhv1ckWmnp3p0LZm0k1o0zx4cWlGpGS+avskAahF3+F
 yG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724608383; x=1725213183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUuNtkz5nQuplOHrRKjreApOfkbilC+PA/cnCRIwr5c=;
 b=V4Psh6BO22jnQaIN0vlO1Nq/yx5pYA4DxMdvNwG1bQsYfGGDc4ILgbyy9fOT4UdcFI
 cOWUnBNa0EHAkaj4TzkPgxBFqeLni4izmp87SHyyNXDwAvyi+pC1jQvbiyqJjF4QdU3U
 lHZIm2mrm9GxfjMkEpmOl3jOU5sHRwdmqF7G9iNYFhLAdsmKcNHxpLpQIN0CMHQ1tO9P
 F+Y7YImcXjR8hlCS511zR/2PkZKw0KMuRpNAbcyigH/X4Oqi4qAOKaOTF1l4gomMX6g5
 yg4YbPqSFjuNrtLqKhi1lxwAr0/BG/fm5V0Ky/IIv7ZbisuMY3RSlOGwC1tQNJr5AiJg
 XYOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPsC/uCACHEhyCFG12cLDzer/a7k/Z/t1T6fBO4poQhkFY+ncKpQfYunoCKxxWTRcN+OqJh9KzY2bKftpN08CY/A==@lists.denx.de
X-Gm-Message-State: AOJu0YzS1we0toyfAQt7l5OWpl30gzulXTb8u7HtzBrBmNdbooZ2PXj5
 PVydeGAK1vVRp2lfGmQyn6YvLSgWSm6athtEGRQnoqMdOtdiBzyClOgK9hIZklml0XR9lni1jBs
 42Bn2VKR6w68mHAdhjomhPqZ4T0o=
X-Google-Smtp-Source: AGHT+IHzwBJ7kt6WcQAxJeP5jzSJsmiI3cM8grOP4I/pTiatdhzNHuLlG+ibO2elLVZn9kptUHzC4TneeRLzu8vr53E=
X-Received: by 2002:a05:6512:39d0:b0:533:3268:b96f with SMTP id
 2adb3069b0e04-5343883d613mr6532927e87.12.1724608382316; Sun, 25 Aug 2024
 10:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
In-Reply-To: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 25 Aug 2024 10:52:51 -0700
Message-ID: <CANV2PTMbQg-1959WiTJ8SDgS9C0Js+D87x7bebwLFZir8f0GUQ@mail.gmail.com>
Subject: Re: xPL terminology
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Sun, Aug 25, 2024 at 6:07=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> We have the term 'SPL', which has a dual meaning. It is both a
> particular phase of U-Boot (the one that loads U-Boot proper) and a
> generic name for any pre-proper phase.

ZBL or ZSBL: Zeroth Stage Boot Loader (usually in MaskROM)

SPL: Secondary Program Loader is what gets loaded by ZSBL and jump
code execution to next

Everything after SPL seems like an invention of naming, and yes it is confu=
sing!

>
> You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> enabled for TPL and VPL builds, not just SPL.
>
> I propose to rename the generic term from SPL to xPL (meaning any PL
> phase), leaving SPL to just refer to the phase before U-Boot proper.
>
> The symbol would be CONFIG_XPL but in documentation we would talk of
> xPL, with a lower-case X, so it is more obvious that it refers to any
> phase.
>
> What do you think?
>
> Regards,
> Simon

Secondary / Tertiary / Verifying / U-Boot from documentation:

https://docs.u-boot.org/en/latest/usage/spl_boot.html

... does not add much clarity to what these programs do, excepting
"verifying" which is at least saying what it does.

When code execution is transferred to U-Boot (as SPL from ZSBL) then
it is simply U-Boot Program if you need a short acronym: UP UBP UPRG
UPGM UBPG

Add to this the descriptive short word name modifier of what that
U-Boot Program does:

TINY
VERIFY
SETUP
MAIN

Taking for example UP and TINY we would have UP_TINY UP_VERIFY UP_SETUP UP_=
MAIN

Any of these would be the SPL if they are loaded by the ZSBL, simple
enough. Also keeping the same mnemonic first letter to what it is
already now for making it less disruptive.

My comment then is that if you want it to be less confusing we should
get away from "SPL" (x)PL naming so it looks nothing like ZSBL or SPL
acronym. Also I observe that U-Boot code base norms are unnecessarily
cryptic and weirdly abbreviated descriptions in the guise of "reducing
code size" at the expense of readability... and it is welcome to me if
you can improve this with _less_ cryptic naming and descriptions.
Sorry "xPL" is more cryptic than it is now and keeps the overloading
of the "SPL" terminology which is the cause of confusion.

-E
