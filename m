Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB956C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16353808A2;
	Thu,  6 Mar 2025 14:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HmvvvEj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E01F808A2; Thu,  6 Mar 2025 14:50:51 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6286380F4C
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac1f5157c90so111912966b.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 05:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741269048; x=1741873848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v9ht2/e/b5eb6eYVYtPLsWmPWesfAyDmftyWHqV9jGo=;
 b=HmvvvEj25Hh0IEjdIi6GzkHVdwwFelt55XnbIHkGNO3Xb1sE9SY6nYh3ncbxE7cnCz
 WUjkPM6TFF6VmTnXaFB1RfqIGX2X+MoUZTSGHMjiOSVyssE21N9BNdO8IFVAMcZeUZac
 gVS0hbBi58c7E7sT+qt2/CI3XvhnOOzKw24Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269048; x=1741873848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9ht2/e/b5eb6eYVYtPLsWmPWesfAyDmftyWHqV9jGo=;
 b=Fpbohpiss3+pbq8tVWZ6uBdboK1cg8p2ZkNbZS7iMceB0cCynaMDWTRkra9u4HewPU
 MukVNaxPiaVpUrA1iEW4oSvDOodcTVS6XmOEXTDOu1KSq/bJ1tIh0qiFCDjlED1iv/hX
 Qk+dkq/nUcDZc/+Zkw+endYJVY+FwCaJPEwv8VAIyKzAGkw01fDcB9RWBMwMYMHo+JWO
 rzmyWBlL6nxuPehCES3IHNvrM0xRoP/5m5w62pL4pExmkJ8rwXgM/O78T/+mepoy9+Pu
 ixvcL0LQD72XZm7n+KicGQVHVU1LbblAwJGUhja16rZQjn8jVYef2p/9HKk/0xbchVkX
 cxTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSH+8WS8WVaHk5p0aOuu5vyJgqXW50ZB+3qAtmCs0x40ak7z5Vjj7RTJxYqUO0tewtoDtuWxw=@lists.denx.de
X-Gm-Message-State: AOJu0YzSCa0w2jKWtqG9oRTeEXZp5BHr9FAjcDTqNoO3HIBZhe+NrtY5
 R5S9ePMGREGkgCytoKbwd1KYx+XLSmGP8S8H/HRGn1UjMwgIH7n/xcUnhbz6KkHmFyhJRvUctOE
 p/7j6S+ve/Rcng4CUM3QU+kMLzp80qYwlG7x5
X-Gm-Gg: ASbGnct5RTj759LaV9xesvkcbJF1qegI4SlfY7k/tMOvjSur6HQL0IveOKYcAnm9dtU
 cVQum1T1Muh9SVPr4c/WCSHKIBw6/mBF5CciFhjsVVkI4uvswTiIMIqM1vF7ornWi2l9NK73uMs
 BsssMuIjwcITkYgZU30tdTKEG1zKE=
X-Google-Smtp-Source: AGHT+IGo1Iy6hp4jqAkWE8zqgnQiPpGUtmPdBSD0XVR3cEiMyCszrixvA++88CyjE1TtHpy96VifC/sZ1qCD3TVYL8A=
X-Received: by 2002:a17:907:9404:b0:abf:768f:9a1f with SMTP id
 a640c23a62f3a-ac20dd08804mr673008766b.42.1741269047794; Thu, 06 Mar 2025
 05:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-6-swboyd@chromium.org>
 <20250221010711.GE1233568@bill-the-cat>
 <CAE-0n53x0NdhoF=w0kEzcgjsgPF7a8R0-sVndemsT3e45PJkCw@mail.gmail.com>
 <20250222010433.GZ1233568@bill-the-cat>
In-Reply-To: <20250222010433.GZ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 06:50:36 -0700
X-Gm-Features: AQ5f1Jq_jKPIoGBWQZTgZUxu3gwlxmqT4n_jeivOpxBqETxAB47OU0gFHmLhH6k
Message-ID: <CAFLszTjxjvySNo0XQMJqZSmKzOnG7bGuKPYO6mw0=w5HpHttFA@mail.gmail.com>
Subject: Re: [PATCH 05/12] arm: Support running U-Boot as a coreboot payload
 on ARM64
To: Tom Rini <trini@konsulko.com>
Cc: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
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

Hi Stephen,

On Fri, 21 Feb 2025 at 18:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 21, 2025 at 05:03:52PM -0800, Stephen Boyd wrote:
> > Quoting Tom Rini (2025-02-20 17:07:11)
> > > On Thu, Feb 20, 2025 at 12:58:47PM -0800, Stephen Boyd wrote:
> > >
> > > > Add a 'coreboot' cpu to armv8 that looks for the coreboot table near the
> > > > top of the 4G address space.
> > > >
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > ---
> > > >  arch/arm/Kconfig                     |  2 ++
> > >
> > > We can't really ask SYS_COREBOOT in two places, as unlike the kernel
> > > everyone always parses arch/*/Kconfig, so we should move
> > > arch/x86/cpu/coreboot/Kconfig to say arch/Kconfig.coreboot and do
> > > something like:
> > > config SYS_COREBOOT
> > >         bool "Support for booting u-boot as a coreboot payload" if ARM64
> > >         depends on ARM64 || VENDOR_COREBOOT
> > >         default y if VENDOR_COREBOOT
> >
> > Ok, thanks. I'll do that.
> >
> > >
> > > And then any of the sub-options that are imply'd by the existing stanza
> > > in the x86 file aren't applicable to ARM64 they can be "... if X86".
> > >
> > > As similar to the work to make EFI payload be a more generic option
> > > rather than x86 only, this too needs some thought to be easily
> > > expandable to cover the ARM case today and I'll assume RISC-V at some
> > > point in the future.
> > >
> >
> > Do you have a pointer to that EFI work?
>
> No because it's still very much in progress over in Simon's personal
> tree.

See here:

https://sjg.u-boot.org/u-boot/u-boot/-/tree/efiq4?ref_type=heads

Regards,
Simon
