Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA8CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 10:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0340C84671;
	Fri, 29 May 2026 12:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QN7uxynW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092D5846A3; Fri, 29 May 2026 12:18:57 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0397D844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68852a4fc68so11302545a12.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049934; cv=none;
 d=google.com; s=arc-20240605;
 b=S0/g4/Emdzx5cJD7ffOrBEUrr5WUN10URSsA+Esih0b3bFEpjFiiMDIITakTUtuh3I
 XbRRaV25qz7xzYhGRTKCvJop4dc6pHAzRgjvinywqy8TApYOxce2Zh0JHq3ufQ41K2f2
 W0ox6cjmEJvoihTk+SY6Cea2N/PGvpV+cGZngr4P2NGAFFWf6dAMK2paR3lLGMuG2UFh
 tCSwOr9Mg/kRFpIN6Y6nA3+1XbVxR2Huy/kSMb2Z7TtFzrWfkxWyqANtOQEwzAMaZnoU
 wbOM+zuJVoVLuYT2tS2ambBkDPVKfCPbi2Wozy4CgMFpu5rhuuslf2/nJ2Yrr2xprQel
 UDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zzORvrlnpmWDvTp/4ycM/mEaG/un7WRlxzD7w2iEUNo=;
 fh=Yo4vwjGzZadQq4QlEOjnzA0p4GTBVomS3BuHz0i9HSA=;
 b=fNKIHQxkDGnRodOnqfN1OkWQYrOofJh8lavdZMU2R/dDEz3STumQSYG7APjPvRSCzC
 Qxb9hTiMAZ2ef/wII97BfXkymqx8565BuaUvfIQu9ko+44wHhdpvmzICSSDtKGKeVW+L
 EOn8+3lcYCU0SUgxjjNJh+1ZGE1qmGOZ8ZYtTUJtEVDMgIr4JQssBpVL6buq8xBZ5VCe
 eKkmZyJseHsa5BmQOkLDP9IoNwq8sA84SYiHwb5MWjMQp/OWTYX/HRmf9f85pxJy1hb5
 7xKHgaKTfG9hWddXTkvTKMIa33vuhIKt5J3H9ykEEVi9qwO8/8+zLf/PeHl5wbommU6u
 0wjw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780049934; x=1780654734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zzORvrlnpmWDvTp/4ycM/mEaG/un7WRlxzD7w2iEUNo=;
 b=QN7uxynW9ZFE0osvLqjapwEgtHNZLaKJ7LQVpJhLaWFhtRDVb2HT+yU/aIYdPRo0ox
 D/NBdTLEcO5ri3qiAkwCUM7Eo6SUoz6qTdVJRcylbvwas98nP3pnrRHfnGhvT/SkYtoU
 MCpc/lehVm8i0qtKOTUiiI49Xs496ao+hjPqVi91MqrRCvo2r5wyCyIXVY0vo1LZ0wY9
 vgh9d4V038ZUcZL/E3xuAdanJ+A8AJy3V4QoNgbuqdWGUEQAD0vvNoIln8apoG0UNbaD
 +jVcXrn7ww4YSC0p0lbNOGx5ZaqTx9ddAyGXSw2kFv9gA+byqX3t5rMzh2AHrQpFk8kO
 ihCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049934; x=1780654734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzORvrlnpmWDvTp/4ycM/mEaG/un7WRlxzD7w2iEUNo=;
 b=AH6WZtILp9Adu+tvKuez6nRRmsczDdx9GB3Kejaz+mmP+a9sSTEKHJg878APbuYl9L
 Zfabrym42WW6u9fzThAhWbzjhv+yuS1SE9B81N+OEkN39E9ZXq/54Y45IooAVPL9KNGl
 NHhq+kmCXghShENex5w5DDzkJBVVZjg7movf2U90AbPITfb0U5Tef81DvR1OfUc5d1c2
 MRlLdXtyP//Hlt/fvNY3G9Umu95HRFHACaMkk+Y4Ef7bNOOuMuv6W5u+I8KSmGHMnjBq
 m5FyxlJpoRmV63eaIaueJKNQbkWrye7RIcNrwc1HpPAVz8QWywmc4r3DFV8yPskQ/Lvy
 po7Q==
X-Gm-Message-State: AOJu0YwKiE+oT7mbiVkDV1mdBsad9vtZNdBjVi3Gc5fBcHXJqG1hrSmO
 B4rJEuiPUS98I1i/h25Rw03MWxDphBXwtDWbvhxXh3ikujU9lFap8wN1VdynXNJleC8BAisAdeS
 gxh1Sp2JWqX2ROMk+k1fvEiKPWCnQj4k=
X-Gm-Gg: Acq92OEU8Pwg71txEhanKfeXIeE9KK9rBj4ukr6IshJp/iX2n8BsX8OzHJSogbrBq7L
 /HUH9JiYysPO/UNCO+9VAE6Z+hKNpUIOCZmBqVO5fnYL9Ljj5XoByH/69NJX882HKp0dfg7pGJ3
 /bdEpJAZ5i88jpsPXPiwMngijsVIftgcgWpdglCgOhbQm9RHBQNnNYqmyf3N04CPed6pd3pr4Xe
 Mz9cG/qipY4nEyjVr3gw0bW5uleUupxu/5lst7OLiUqvo8FeewZMxfVNqV1Ou0RMxq5uD6pI3iY
 2lQko3hJSAqhjqJ688xYk4n3NElQ0JjwQcFy5a0iwhXXpP+elf4ADNzmTxPKAU62u+SDnxssnkM
 CxmWW++lmWI5boHt/VP+TFBl9bwScpQ0FI9RiBZ+g4YbgPD1Jv0GNQqpJJFPNjlwXMGOLGNh7rh
 p6LUoVZzupDkdDl3U00xqIX5g=
X-Received: by 2002:a17:907:2da4:b0:bd2:bd3:1ef8 with SMTP id
 a640c23a62f3a-be9cc2a80abmr119557066b.35.1780049934063; Fri, 29 May 2026
 03:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
In-Reply-To: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 29 May 2026 11:18:41 +0100
X-Gm-Features: AVHnY4IqnoF1st0CXBZphwHnvYdJsDzIxA2ldsXtyxbFuKg4c2Zv-qjvVjBf2dw
Message-ID: <CALeDE9PZDe4WdpDxe_3mwWqsobZp6AsBz-OG+5Gp89Bam8FdzQ@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: force 4K page alignment in linker
To: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Sam,

> Since 5c71f8110, the u-boot.elf produced by dragonboard410c_defconfig no
> longer fits in the 1MiB aboot partition it is intended for.
>
> To be precise, this issue occurs on toolchains that have a linker with a
> COMMONPAGESIZE > 4K. Since u-boot is hardcoded for 4K granules, we
> ensure that the linker doesn't try to align to anything larger than
> that, otherwise we're just filling our ELFs with a bunch of useless
> zeros.

Is this just applicable to ELFs or can it be applied more widely?

> Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Sam Day <me@samcday.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on a Rock960 where the elf output went from 9498864 to 9437424

> ---
>  arch/arm/config.mk | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> index a7eff84a267..bce9a31e966 100644
> --- a/arch/arm/config.mk
> +++ b/arch/arm/config.mk
> @@ -112,6 +112,14 @@ endif
>  # needed for relocation
>  LDFLAGS_u-boot += -pie
>
> +ifeq ($(CONFIG_ARM64),y)
> +# U-Boot uses fixed 4K granules, so we force the linker to match.
> +# Otherwise, we're subject to toolchain preferences, (e.g Fedora's
> +# aarch64-linux-none toolchain selects 64K granules) and we end up wasting
> +# a lot of space in ELFs with MMU_PGPROT enabled.
> +LDFLAGS_u-boot += -z common-page-size=0x1000 -z max-page-size=0x1000
> +endif
> +
>  #
>  # FIXME: binutils versions < 2.22 have a bug in the assembler where
>  # branches to weak symbols can be incorrectly optimized in thumb mode
>
> ---
> base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
> change-id: 20260528-4k-page-alignment-6cb594a073b0
>
> Best regards,
> --
> Sam Day <me@samcday.com>
>
>
