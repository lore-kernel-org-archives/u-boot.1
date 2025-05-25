Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEDBC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB5582B34;
	Sun, 25 May 2025 21:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bVVUupLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1677082B37; Sun, 25 May 2025 21:45:56 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1684F82B33
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-602c4eae8d5so3131823a12.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748202353; x=1748807153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f7fTZBtzakUP/sMQc7bnYC+15H2us4M3uPm6w/6gxc8=;
 b=bVVUupLFrNdfx0j66Zx3joQJUi1uivj4m6LuroqV5DeOfwVhUyNMlw+SOE6cn1nf9C
 nhdMpT8Ei7nOm8TxtHDHPGcXAGTQ4XjA7oS4QN81XRwBDQLJ3peZuFZJthRzRdWX6aN7
 Nl9skXn2qvORzcpSPxYxx+V9hryYoqu0jhWYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748202353; x=1748807153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f7fTZBtzakUP/sMQc7bnYC+15H2us4M3uPm6w/6gxc8=;
 b=IIyyvLXdZrcygYm6x465jnGnhT7ya4ARkj3aJS5TaR+vjxESZ4u08H1FhJ5HlyxMKe
 aJ5JjsYCDBlMDRqN3uN6IZ1CuMa5/pm19fZEG6kT/Yky6gObt+qyz6tZ7wnt6KknS3Zs
 LxsPhP0mYoxncflBF7iNXNp4g4ajg6vd6rXM8j2ExfrvYL6C44rHhN40BqfEaGCDHjB0
 5t6e7vS+S9i4T167j3MUnHGaa0xEUl3CzxeTbcEvRNgFnMNkhvG/84Oo2m7TsPWwSG51
 71Slzd73V2AVsOXr5/r6tp5eflGjSySubVB5eSezhy9lIxbgt/T5bhtEeZJoLmF1sAmj
 2ftA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhyY9t0WJSQdeIPwD6JsPW8nODLO+KZGb/IUKB1tTU1PhhiHJyNAQOu1D1FuGGoEaYV9bzwaw=@lists.denx.de
X-Gm-Message-State: AOJu0YxNf3ryY77SllDKo/qYxrYf0typdiFUpMmzf/26iDdJNI1J7nZA
 CZm9gBYiXAG9xVLtnIU5oVluiwMFBU5efwzduQAlVlZoUB6I7GHXY4nkL2vzDWsOpcSB6XFzq+E
 4NLw8ElvqQW8clYPxATwlgJHlxUBBPsGu1JEB+JHP
X-Gm-Gg: ASbGncs71uoo6C/HIaqTmK8ym5RjkxQ0YfZN0NeTV2EO3MElmaH73SkFy0mCEenK4GC
 QB+niybU7xyx9ZC4I2sUKjVy9+xTUVr2IhllJTUl9EFOEzuhisD9oyiPaxJVi6RPw0muOz+xqOB
 ChFnSPj+SjEk7L0cW5rvXTHHOmZW5xqAY=
X-Google-Smtp-Source: AGHT+IG13UQI+mmm5cUDzW05x+OE0f+kmIQX4IviFN1mXPxnkQhHhMgJVXKlcX9+E233rQo1Tignh4q6AESlRUqc5wA=
X-Received: by 2002:a05:6402:2925:b0:5ec:6feb:5742 with SMTP id
 4fb4d7f45d1cf-602ce4dfb87mr3939094a12.16.1748202353458; Sun, 25 May 2025
 12:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgeJ_kvdUrBC=btzKAQGVZDtyJzk1LuD4t58n0zMmvU8w@mail.gmail.com>
 <ecde0d49-f04a-4a75-bacf-a170c2ebb0df@canonical.com>
In-Reply-To: <ecde0d49-f04a-4a75-bacf-a170c2ebb0df@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 20:45:41 +0100
X-Gm-Features: AX0GCFtN1iyHDia-WSmRWRjk1cNf5PyVwMID6_wIjvzukjFQRjG2igEaTyPpj1g
Message-ID: <CAFLszTiKaLmDnr2BSWBF8zGESJjh71vrAomzoYetb=EAJ9w8tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: BOOTMETH_DISTRO should select
 BOOTMETH_EFI_BOOTMGR
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Wed, 23 Apr 2025 at 14:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 23.04.25 14:28, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 21 Apr 2025 at 03:43, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Distros expect the EFI boot manager to run. It falls back to launching
> >> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
> >>
> >> BOOTMETH_EFILOADER is obsolete.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/Kconfig | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/boot/Kconfig b/boot/Kconfig
> >> index fb37d912bc9..89076220adb 100644
> >> --- a/boot/Kconfig
> >> +++ b/boot/Kconfig
> >> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
> >>          imply CMD_TFTPBOOT if CMD_NET
> >>          default y
> >>          help
> >> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> >> +         launching EFI\BOOT\BOOT<ARCH>.EFI if no boot option matches.
> >> +
> >>            Enables support for EFI boot using bootdevs. This makes the
> >>            bootdevs look for a 'boot<arch>.efi' on each filesystem
> >>            they scan. The resulting file is booted after enabling U-Boot's
> >> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
> >>          select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
> >>          select BOOTMETH_EXTLINUX  # E.g. Debian uses these
> >>          select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
> >> -       select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
> >> +       select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
> >>
> >>   config SPL_BOOTMETH_VBE
> >>          bool "Bootdev support for Verified Boot for Embedded (SPL)"
> >> --
> >> 2.48.1
> >>
> >
> > I don't want to make this bootmeth obsolete. What is the motivation for that?
>
> This method was written in a way that per se violates the UEFI
> specification as it does not set up required UEFI variables.
>
> You must never run this before the boot manager as booting
> EFI/BOOT/BOOT<ARCH>.EFI if there is a boot option violates the UEFI
> specification-
>
> The boot manager covers the functionality of this bootmeth.

I'm OK with the workaround we discussed, but this seems to go beyond
that. Can you do this without disabling this bootmeth? Or is there
some other clever way to keep things working as they do today?

I know we've discussed this before, but is there really no way to know
whether a board is using bootmgr? That would make things much easier.
Perhaps we should just disable the default for bootmgr and then let
boards enable it as needed? I think we discussed that too, but it
seemed it caused other issues? Perhaps we could add an environment
variable that gets checked?

Regards,
Simon
