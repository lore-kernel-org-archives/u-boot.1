Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98584C8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 11:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B3F4832C8;
	Thu, 28 Aug 2025 13:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkPkLCRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454D2832DD; Thu, 28 Aug 2025 13:10:15 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0730B8328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 13:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61ce9bcc624so351388a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756379412; x=1756984212; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kTqDBvPQTc3exOOh6ULvv8v6JlTHU3Qonp3sfdlPrbQ=;
 b=jkPkLCRdrcgkXWjnL4dzhCqiEvFd2pyL9CbasqOWS43VRcNvYlPRDI14YQVBjg6mn2
 6dO0/Dp5xZ1lSIfp4FhB3Ldyyd/FnFuKiuVaA4skEuemawcTZPudpIcAKcwPbvgySOY8
 UPqIIgmrhyI8afr/ZPxl7ZgYIQBnO3Xbt5SS5OP8ThGMGvvL9WAeSfkiNPuaxPW5dVZM
 A10sMkEZo+njP5iNfJBa2Pz0QeC4LGp747DFc+DqBFlIny7Si/L76dxD9CE9w94i98Az
 WKOKYKWPItttOsQaDwcvr9L1RsWjvpeaDdUh2pKpefwemFodl+H/2g1Hgme10dz5vFbA
 uOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756379412; x=1756984212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTqDBvPQTc3exOOh6ULvv8v6JlTHU3Qonp3sfdlPrbQ=;
 b=Z7GriIBAF9I3PDfCOlXAMysMpb0a3MVxreoiSSJRZyGC0a9u2xAs7TqF7BmikOgg/I
 M1sDqTvhUE4c0AWLLaTLJE8cty53EJ/R5yv8PwXJzVSHtBNd5ygwoYp7Vzb6eYFegIub
 1PU8Z5o4D5dJDROPoiuZdllo66YUh6WrQYXo+C4eIwdcDHmhT/NcUjkDooNRwpdPk/ln
 kUSC3Kf8B+Rhe+0CRHHv0OdA+6OMRj6Og2yP59qd9ztENFwml0cUAN+9bMg+F7UXlVBn
 nzsueJuqe0ncVLwi9Fwftwi48GH1iP+lZLLLqSyQyAz43dziXiXG2Qbr8efDSnkNsHg6
 nGaQ==
X-Gm-Message-State: AOJu0YyscS15gnNkwTv4FK65yYsME+McNA8Ijy3+tM+63YTZ4CMlSyYS
 49qB8OIAfD8qj6PgGxacUwGTHWWhftFTk7FthNJi3c9cTUBC60RTs3zfGXOc9fzlOlj1ZrJJPnf
 YZDvKh65+oc06RrXlc+sm2PJe76G4Xhz2zZzT
X-Gm-Gg: ASbGncsumBXzo1aVO1KnhnWskqky3Fh9Z/PdSZI48jklHX+6D7PFGlPaMRzZ5MECVWH
 WHZZNUw0dcbj1xyBgG58PUYqBprjNJCwA3rLamxkBpywoOxVx8UbCWrXMhrjoAvUMCD9nevygZ2
 gN9NSJiIGohF3BtLxVxT02jnj8iCv64/DOR6x3tJb65bgdPpR3OENT71xjqBIaYlb5/UchkD/Mk
 BFMc3kfTfB0XZKbcpytMyKkzEUCzYBRdNKz6cFAxnHz9imBZcX4qaqd
X-Google-Smtp-Source: AGHT+IFu4df917SK3nmpkV6Dok+SIAEiQfnstU3wWeba+48d5NzY/7TztZd6gSqF83eIkbjpePol8orzg+AO7d327Ec=
X-Received: by 2002:a05:6402:358d:b0:61c:d118:6182 with SMTP id
 4fb4d7f45d1cf-61cd11892c6mr2040184a12.29.1756379411975; Thu, 28 Aug 2025
 04:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <7c447cc15eafab93f91ac3f9d14b12045d2a66f2.camel@opensuse.org>
In-Reply-To: <7c447cc15eafab93f91ac3f9d14b12045d2a66f2.camel@opensuse.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 28 Aug 2025 12:10:00 +0100
X-Gm-Features: Ac12FXyOxwMN0tvEEJyn2YmWjNkfifoggdtocn5Lwhz07f2OHEFg2JIsGRJb9nc
Message-ID: <CALeDE9Pnj28JsHh_8ZBsZY80Ka38qF4XNTVQ6H0v=UmWz18RtA@mail.gmail.com>
Subject: Re: CM5 and LetsTrust TPM with u-boot and Linux
To: Jonas Kvinge <jonaski@opensuse.org>
Cc: u-boot@lists.denx.de
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

On Sat, 12 Jul 2025 at 18:25, Jonas Kvinge <jonaski@opensuse.org> wrote:
>
> Hi,
>
> I'm working on getting Raspberry Pi CM5 with a source kit io board and
> LetsTrust TPM with u-boot and Linux working.
> I'm building a custom u-boot similar to the description
> here: https://github.com/joholl/rpi4-uboot-tpm/blob/ad31306ce2f2d52f0572385bfc8bac33cb1f1f68/README.md#setting-up-and-configuring
>
> I've got this successfully working on the CM4 where the PCR's are
> extended on boot.
>
> I'm now trying a similar setup on the CM5.
> I use openSUSE Tumbleweed with a custom built u-boot and linux kernel.
> I use kernel 6.12.35 with all the Raspberry Pi modifications
> from https://github.com/raspberrypi/linux
>
> The TPM is detected, but the PCR's are not extended, showing zeros for
> all PCRs (tpm2_pcrread).

The TPM is detected where? In the kernel? If its' not detected in
U-Boot it won't be able to extend the PCRs throughout the boot process
so that's about what I would expect.

> In addition to the tpm-slb9670.dtbo from the latest firmware files for
> the Raspberry Pi
> (https://raw.githubusercontent.com/raspberrypi/linux/refs/heads/rpi-6.12.y/arch/arm/boot/dts/overlays/tpm-slb9670-overlay.dts
> ), I use the tpm-soft-spi.dts
> from https://raw.githubusercontent.com/joholl/rpi4-uboot-tpm/ad31306ce2f2d52f0572385bfc8bac33cb1f1f68/Raspberry_Pi_OS_64bit/tpm-soft-spi.dts

What does that overlay do?

> Do these needs to be modified for Raspberry Pi Compute Module 5, or
> could it be something in u-boot that needs to be changed?

Well does the TPM2 work in U-Boot? I suspect the SPI 40 pin connector
is via the RP1 chip, although I'm not sure, we don't yet support the
RP1 in U-Boot, let alone it's various peripherals. But maybe the SPI
is from the SoC. Looking into that would be where I would start your
investigations.

Peter
