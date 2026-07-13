Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C97C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9322084B33;
	Mon, 13 Jul 2026 15:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JEVJrZf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EB984B3B; Mon, 13 Jul 2026 15:15:09 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E429584B2B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so5662545a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783948507; cv=none;
 d=google.com; s=arc-20260327;
 b=dLoSgwidsByzrRi9pYAD0kcYR4LOtLaKgcpMpBTv8SloARRUGLajntSuDqs5zGhiGc
 Fuzu9c/1NeGRUfRlVHvSjRrzBP54j3tJ3Hy5oClcbgl3/OGG+66Khxz61I1g5xgPGljA
 oxtByC8iqTQ2X+IHV0gCjj6p7QZqlC9AjSIE9LG7hCVRRPSjLdrQl//V9FEeLbWnm7tq
 QIiwudByJmBuMqtlLPXZxyhShvAHQEvqmgXp3Cug6qK+/Q9is06+Dzl086XAi99JuNF2
 avNPwHOo2CXd/TK4ceSQ4cflo+4jNanznp3McNBuZUUk1H5lEa+xra4R3uXZm+4UAroh
 R/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y8TkMcGQhOGzw/P9dKIu9tZrWaXAOQYXKRHtCj+g9Tc=;
 fh=6hUQ+cBDEhdswFVdh7jsmENQZaH9K2EJzvSA9UTasck=;
 b=Yd2Xdb5pM42spLJ2ra/i7Yd/oGtoy16RvjuXwypAXmQZbzv9DUChoa1oYpvkc1VMNF
 KSwRmYhg6aI0G4gi34oMNfVNl+hZFx7YzYYti6YyfnWBscau2zBRPwRX50GgI0snctNN
 GLYGNMzHrXNB6t+Pw7fnLhcvbHCsZgB3q8YDVf6hrTJBaOq993EHMQ0Q7NPuWwbbFpQi
 1ztCx1rD7zdcnfp4mYQWDhTeNMepTDNRwDBWPPLT7HWrBBugZV1hUOlEjyYMo3aYZkhM
 2EEj6q25Ds/donyMfPDFZda9Cke0paztmP27Tm1cmVSZQCRN6W6exCehEBqghcselem5
 wLkg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783948507; x=1784553307; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y8TkMcGQhOGzw/P9dKIu9tZrWaXAOQYXKRHtCj+g9Tc=;
 b=JEVJrZf4+yEMXWmmBG7GFERDAcHUl/u2JzDWecsEMmcfJJj8xpujWKcGbD2el+yb+g
 1YMFaF8pcq9WxubbgzJyf7cE8D4rcOc1AfA3DfOBE5H1dM3eOAMhDnSIdJ8Mtb94f06b
 dZjD5mnTgrsDTW8w9bKDtOq0ic2q2ZQL2Tmkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948507; x=1784553307;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y8TkMcGQhOGzw/P9dKIu9tZrWaXAOQYXKRHtCj+g9Tc=;
 b=hjft0CJLSJdk9kx4R2vaFlqqXND+bD5R3Dslzrvf0myvE9O5+82gSJh21Xc2bB4+WB
 2lRQ8iUUqSfYuWFCyPE7vxMPO0vkWfmf5jPbjQBXSFgV+KBiwgC+9kG28+xsQuIgqUdy
 UKJh8iPbK5WjnuMFR1Gv46sCT9iqGS8AVcmc2BGzDeal00hwv6IMLMhuu9h3sgP2GCfw
 WWAi0vkfNuTXGxECG2Uv7jwO37D2Haq4Fci+iVojFenowauI9/G6hgSi99tvwT+lNKvR
 iIkRLvW7MwSKn9x1AB6weMT5Gs7wT/AwqksWGcaHmSg2WI02NjgGIbLaaWveyPFwEpwO
 iMVQ==
X-Gm-Message-State: AOJu0YxvE+fjVHwAXus8Se23jyQjEAxxIoylGjUQPiMfKmIFJ1s/auw5
 TrSxylDWWjSm2WpYsQTRAa9STmb1x/TvC675R4FFgPzHneDAB5lYwC3mulJrR60aBEuON7VuMgB
 e56vC/4v7G19YNejaaNULUM22seXmzd8fsTeBE0R5
X-Gm-Gg: AfdE7ckMP3p5gB9RgWNGpCDEUrE9N1CKYkskSbpn3s/BCCU9vgglOoNNlMo44MMXIvX
 bXmLOirJ5z06HwmyFopUQFjG619itZZRz0rNNyA18JVUNXFIg1ZvAF8x7RAeixDAg78ngAtL/IX
 GMhpDAPAj4piexluM7WtiHixkFU+LnEs9NZwT3LjwW9om9N8Un4dekG4nym/E16wzcsXPPhQR+2
 6AJ7qLaa9nk+yOeMZaApBsw9G4mFy6skyoGfRPPWeLJ3B6jkCnOL5/lO1FwXoGZ8B+8z/4=
X-Received: by 2002:a05:6402:3583:b0:698:3b7c:be69 with SMTP id
 4fb4d7f45d1cf-69c5f244e46mr4026595a12.37.1783948507299; Mon, 13 Jul 2026
 06:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
 <CAFLszTgP05iS-4dyaLbzmPGppdMmFxUQvh=JJJGnSjKJ0MnL7Q@mail.gmail.com>
 <CADh8LscDis-pfMK26usYEfS-cfRRSwvcm5hg_akXr287oDXQ=A@mail.gmail.com>
 <CAFLszTgqQtt-FMx7Rh3vVE_NLL8cKp5vveqmi4iNOKE2GwJt=Q@mail.gmail.com>
 <CADh8LscEUi5kvGQ28GErjEM=WvQ=6t0p5Kh30jQ-S8ZapG8yrw@mail.gmail.com>
In-Reply-To: <CADh8LscEUi5kvGQ28GErjEM=WvQ=6t0p5Kh30jQ-S8ZapG8yrw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:14:55 -0600
X-Gm-Features: AUfX_mz8i6FQHmc5znYOvs0x1-2x2OfFMIRKzK5UrOJj8eUSYB40EirlF8KOafM
Message-ID: <CAFLszTgr-j+6rVixiD_3EtC1Ve=iD7aunyKD1=HV=LUEg51iyA@mail.gmail.com>
Subject: Re: [RFC] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io
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

Hi Carlo,

On Fri, 10 Jul 2026 at 04:51, Carlo Caione <ccaione@baylibre.com> wrote:
>
> On Thu, Jul 9, 2026 at 9:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> > Just on this point, the question is really whether GRUB does not touch
> > it. My understand is that it actually loads the FDT from a file (Ilias
> > is the expert here) and that is why we have an EFI fix-up protocol to
> > send that loaded FDT back to U-Boot to be fixed up before booting.
>
> Oh, ok, good point. Now, there are two cases:
>
> 1. If grub.cfg does not execute the `devicetree` command, GRUB uses
> the firmware-provided FDT from the EFI configuration table. This is
> the path I tested (most common in stock distro images?)
> 2. If grub.cfg executes `devicetree <file>`, GRUB loads that FDT and
> can replace the configuration-table entry before starting Linux.
> Debian/Ubuntu GRUB also carries the EFI_DT_FIXUP_PROTOCOL support, so
> the loaded FDT is passed back to U-Boot before GRUB installs it.
>
> The mechanism proposed in this RFC (V2) guarantees that the selected
> and verified firmware FDT is the one presented to the initial EFI
> application. It does not make that configuration-table entry immutable
> after the EFI application starts. After all an EFI application can use
> InstallConfigurationTable() directly, so trying to enforce
> immutability in the firmware-FDT loader would not be sufficient in any
> case.
>
> BTW this also means that authentication of the firmware FIT covers the
> DT provided by firmware, but not a later DT deliberately loaded by the
> EFI boot manager (we cannot do much about that). The good news on this
> front is that (AFAICT) in a Secure Boot configuration GRUB's
> `devicetree` command is normally lockdown-restricted (but again that
> is a policy enforced by GRUB rather than by this mechanism).
>
> In general I think that is correct rather than a hole: same precedence
> as passing a DT to bootefi, an explicit devicetree beats the firmware
> default, and firmware cannot stop a loaded image from installing a
> configuration table anyway.
>
> Hope this works, cheers.

Yes, this seems right to me, thanks for the write-up.

Regards,
SImon
