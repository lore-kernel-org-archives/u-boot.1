Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9118EC3ABAC
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEC0820F6;
	Sat,  3 May 2025 04:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOJjkI2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8346B82114; Sat,  3 May 2025 04:10:16 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3D7820F6
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ace98258d4dso357370666b.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238214; x=1746843014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwb3o+3SBbP0sRjoXPft588CW1oyF8TQrQTD8u9UsjA=;
 b=cOJjkI2e7VJLR4lHpxwgwPJvu7mgsxj/19WlpY5zerVvJiGY3YlaAexI4s45ZZZRy7
 kO2NCgcQGn5bPF0TroHzrl+VQ5pmlg3e9OUfeG+MtcYwHcCLoUvWVr2AAwPSSbTVDJWI
 jrJ4hmvWgPY11mb/oMVBfiWDkON2uR2xkkPC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238214; x=1746843014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mwb3o+3SBbP0sRjoXPft588CW1oyF8TQrQTD8u9UsjA=;
 b=klqQyPXQXMIzKlal1KuwyMtYSCJsfXKF5KMkQvLGSkcumneb4VUK+09h0M6xA4sc/u
 WKIMT56+/QoIy929d6GI9NAY1ov5SLk5CqpaWDwePQOwBtE977wUIy4hPsb24EATWaCg
 n9mIaJjCuAV8KO5HVP6u2fERH2iGK9HrpLnAYcgk0LHek84PShulUarnW8lcc0rJJWJ2
 2nNQSLhWVl7GH2boXZoKd5SdAO0kslKhlhs3s7MU5X6UbGJxzCqfDUyUP37+ZnYbsoX1
 spvWdAHa3Y62ev6K77sQgF4f1wwkmpsL9f4bCaJTc3XtdMSl/X5WiACMYFAhNMGQuwMr
 cJjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM8eOlm+hkUi+8g07xObAfp1u4cTjXOTgCQX5ba4+6c8T5oUM45jxMdnQQrmbLAI4qzWJzmOU=@lists.denx.de
X-Gm-Message-State: AOJu0YyE0hiu7JCCOL3Cw8bXw6z68BnIzVwLv6Jbqrmu3gcwvLALN1bw
 ZnGn2hUkfb2Mr4/wu24V/PgueEdcLLknLBWPbMFmFSZES+c2mSyf4AZgRBXDD7zwaE65KhBbz7U
 wBzGKWByMiTyrZ98SF2J7yGyWV7ApdckVOTog
X-Gm-Gg: ASbGncvUu6X41agnh4Mj8wCMKi3WQqqvwdTB9RovbVjRRkOttKtU64EUuWCtU6G4bAq
 DfOO52xAV64/dy5PvxjfFYAPanBXLXi+JyGTqCv85oCOOU8rSF2cBvXcAEwpKxFxD2wuVAI7HVF
 aDrBgh5zxGZg0txwW89fNGvnk=
X-Google-Smtp-Source: AGHT+IFA6LPNqxahwp9Ijqc8+Fpmvlt9h9w+6234t3TJjXRMOJxTv0aOQ1RZ9WgLDWYvfNSsuwvMRpa8163BBqv0ROg=
X-Received: by 2002:a17:906:f290:b0:aca:c57f:3a1b with SMTP id
 a640c23a62f3a-ad190858b87mr90142066b.54.1746238213929; Fri, 02 May 2025
 19:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
 <CAFLszTjcCXDnjOjpD88tGcvSz1AOAouyHKsynzCC3tngDqzOvQ@mail.gmail.com>
 <27c7a370-ad40-4935-8b2a-f27468a01467@canonical.com>
In-Reply-To: <27c7a370-ad40-4935-8b2a-f27468a01467@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:10:00 -0600
X-Gm-Features: ATxdqUEpQmn9uctXPLg3HFjha0NPdJfqJ0aG7xd3xpVCHijx2Iv8lJInKeQFV8E
Message-ID: <CAFLszTh3db5HwBfD9rg=YGY0n2DKE2vfBL0UG5x1_5DoJcj5WQ@mail.gmail.com>
Subject: Re: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Fri, 2 May 2025 at 10:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/2/25 16:49, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The boot method is deprecated as the EFI boot manager covers this
> >> functionality.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/Kconfig | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/boot/Kconfig b/boot/Kconfig
> >> index 71ddb37f6bb..b973d9eb0a7 100644
> >> --- a/boot/Kconfig
> >> +++ b/boot/Kconfig
> >> @@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
> >>          bool "Bootdev support for EFI boot"
> >>          depends on EFI_BINARY_EXEC
> >>          imply CMD_TFTPBOOT if CMD_NET
> >> -       default y
> >>          help
> >>            This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> >>            launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
> >> --
> >> 2.48.1
> >>
> >
> > As mentioned on the other patch, we need to keep this enabled and it
> > isn't obsolete.
> >
> > Regards,
> > Simon
>
> Please, read the UEFI specification especially chapter 3 "Boot Manager".
>
> * The functionality is fully covered by the boot manager.
> * The current implementation of the method does not comply with the UEFI
> specification. Especially if run before the boot manager.

We're going to have to go through this together sometime as it seems
like chicken & egg to me. We don't want Boot Manager first because it
is slow and stuffs up FEL on sunxi etc., we don't want it last because
then it has to wait for networking, we don't know whether bootmgr is
being used or not, so we just have to put it in the middle, but then
we don't know whether it will succeed, at which point we have to go
back and try the whole boot again..?

Regards,
Simon
