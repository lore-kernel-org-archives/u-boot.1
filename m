Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAD5E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B15880584;
	Sat,  4 Jan 2025 20:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gN6oJiFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B6C8059C; Sat,  4 Jan 2025 20:31:29 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B518059C
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso69421266b.2
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019084; x=1736623884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vyEqcxvEbGQr70b1wCPO/zABvUUtUC4T1WHSoiVGpWw=;
 b=gN6oJiFgd5NwCUMr5grD0Zt72TZPskrdD6wpYUsnxp05v0Xh+iqdjKUeZdMdT6IQSk
 SjTTx3Wi2EJjlxKiuh9XS3rI/uYT8LaCXdqkU12jzFjIWpR9bGeQno9MYXRqyD85WoyP
 7M/e6Ilvz8LcRIokHz3zjgOC3XPpDMOtVqRdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019084; x=1736623884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyEqcxvEbGQr70b1wCPO/zABvUUtUC4T1WHSoiVGpWw=;
 b=dJOpjDVujjbRLFpL186+RCm7GWl4Xk6J8tV6H5wnq/K/OH6ciITxPrprt2lKGcxcUw
 Ca0iXXeX3umzzWPV/ZX8FZinYcTDdemQMAgesqa8vQCdyy9ztEuF/wmNmj2CsApTvuoo
 cJXv8nIu7eLryKqwM4OfG7G9IOAz75u6//xsQ51WHPa8jSsq+tUquebc8H3L1EjmeLyj
 EQrFslzau4E8nn32mUxTkt+owKJni5RRCyQqPv98sBRL0hlyYWaA4M01PhDawss36Riw
 kdQ9YWmT+0KdPcppuF30rBp7OarGIwahknqt9/gG5ukrwUZbk6ucP6eJwmoB+wVkKjfk
 DuBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVusHPcN2xCuJhziqdFs9M3bh3yfjQeCk5T41jo2uNsRXLRqf3jErkVBbgF6JR415C8vIUjkhc=@lists.denx.de
X-Gm-Message-State: AOJu0YwHzUvu3DZXswyc0zlNbHyqLywuEOqLvACL3J5TAojLDLF6gDH6
 1SbjuhfKJV9BttbvVebcluWLOzGS2gWiPGvIVmTBaG+HQO0HWJB/JWN1MJ0/U3a8Zw2ZIapFAJa
 RGvr8BWqjrDwLk9mFr7ASGoGflEnHCrFfQp34
X-Gm-Gg: ASbGncv5HhJ01Q1nZgeT+OcB767SJfoTHhn+jGByrmFL1i+8Q9i4dw3bXhdAdYr0gT0
 9NCnV9iF9FzjBXEB64n6kBd9g42rhFXC4tAzvjscs
X-Google-Smtp-Source: AGHT+IFy0wBxb2lL9mRQByHiahl5wN1CWt1TGjqVjYzpRISSJ0VtagfohI/4wfeUj1wHFGbPvfz7p0Lt6ys1GknqJLw=
X-Received: by 2002:a17:907:60d0:b0:aab:933c:4125 with SMTP id
 a640c23a62f3a-aac2702afb5mr5185301666b.10.1736019083586; Sat, 04 Jan 2025
 11:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-3-jonas@kwiboo.se>
In-Reply-To: <20250103215904.2590769-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:31:16 +1300
Message-ID: <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
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

Hi Jonas,

On Sat, 4 Jan 2025 at 10:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
> and SD-card.
>
> Vendor BL2 have solved the issue with different offsets by considering
> where BL2 was loaded from to adjust the offset where BL3 is read from.
>
> This provide a different solution to create a boot image that can be
> booted from both eMMC and SD-card and where the offset for reading next
> stage loader can be shared for both boot options.
>
> Inject code, that relocate the payload located at 0x1200 offset in TZRAM
> to the expected offset of 0x1000, into the padding area at offset 0x200
> when a normal GXBB boot image is created. A special GXBB eMMC header can
> then be created that have the payload offset point to this relocate
> code, BL1 will jump to this relocate code when booted from eMMC instead
> of the normal payload start. One effect of this is that the payload size
> limit must be reduced by 512 bytes on GXBB.
>
> Example of how to use it:
>   # Create a normal boot image
>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
>
>   # Create a boot image with a special eMMC header
>   tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
>
>   # Write normal boot image to sector 1 of eMMC/SD-card
>   dd if=bl2.bin of=/path/to/dev bs=512 seek=1
>
>   # Write eMMC header, 112 bytes, to start of eMMC
>   dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112
>
> Or with binman using something like:
>   binman {
>         multiple-images;
>
>         u-boot-gxbb-sd {
>                 filename = "u-boot-gxbb-sd.bin";
>                 pad-byte = <0xff>;
>
>                 mkimage {
>                         filename = "bl2.bin";
>                         args = "-n", "gxbb", "-T", "amlimage";
>
>                         u-boot-spl {
>                         };
>                 };
>         };
>
>         u-boot-gxbb-emmc {
>                 filename = "u-boot-gxbb-emmc.bin";
>                 pad-byte = <0xff>;
>
>                 mkimage {
>                         filename = "bl2-emmc.bin";
>                         args = "-n", "emmc", "-T", "amlimage";
>
>                         blob-ext {
>                                 filename = "bl2.bin";
>                         }
>                 };
>         };
>   };
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
>  tools/amlimage.c               | 37 ++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 tools/amlimage-gxbb-relocate.c
>

I sent [1] some years ago and would quite like to enable the odroid-c2
in my lab. Is that an older version of what you are supporting here?

I heard that there are people working on open source tools, but it has
been a few years and I'd be quite OK to just use vendor tools.

For your docs, could you put them in doc/ instead?

[..]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20211124040954.699821-8-sjg@chromium.org/
