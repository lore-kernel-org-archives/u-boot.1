Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073E9C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F13C841F2;
	Thu,  2 Jul 2026 12:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HDkE0xIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA878469D; Thu,  2 Jul 2026 12:22:12 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F8E83FEE
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698aa75d15dso1126860a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782987730; cv=none;
 d=google.com; s=arc-20260327;
 b=UzT7p1PsZAZzDLQR+hVkAOeDSXFncCkNVsAxgkN6mwBem/MaefqIMTDzdpIxfSQ4wB
 ywmYF7CRtmQNWAu/Ld1LMRhTmt8krSEz9Y4i6u4I8rVAZSfhTg6KFYWQx2YCdGLGgTYU
 tDHb6nf8UonzpnVtXvMHroAH8iI49UbHqV9YBAl3Y3k0jIDU4v6RlZMV7dVZCWs9m/Nm
 PtWGA41qZJH7ysgcnI8cRJBiDmUJ+xkQd5289/qoQ6moqSVW7h96WdXFDrPCV1F9OOl+
 RSkYE6QHuTToCgA3As34uIUKVui9ifa6sn4PKMI3SNJziMOxdPsFyzUPYnRdLybRMhyc
 l92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zxzeaprBI4z7rUdXjLbLl1JxjfABXg6Kq6V7UBgNGWQ=;
 fh=RmyTNjaO52aYKbZgW7b9i/GqO1i6BaqamA+SQVldw+c=;
 b=jaGxc3hXrZ8H8E4vdPVrwdij46JlBCm84fxpq84dpeggN6svBqrKbis1NXjIYilpfy
 hV6+PYbrQEhs2MbXEv/kk0MNrIXwFNW+LzXc+BfpLyJcOdlzs4G+XCrI+ft0ZBp+2EVZ
 Feh7u2ksgSBZFdV1ywwL7a2+GIET/GZR1UROdF+WfL6xD0H3kc+z83ybBxmQlmsxRcGR
 tMZcUUjbPsAJx6//7vhJmkREji5AvE93xuioy+hyslbrodseP/EnnU+h9hFbcQtCvyTv
 7r8LLrJCggODsX44MeMXS60RnDkwjYctMigrnwQ/NO6z8OUd6Q0HZFr0EBAc3wPLbm8X
 K4DQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782987730; x=1783592530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zxzeaprBI4z7rUdXjLbLl1JxjfABXg6Kq6V7UBgNGWQ=;
 b=HDkE0xICZ8g7Rfw0Wyy98ca5YbQAiwTrnCSaRzBDUnn0gJt/FOJJYrE1EF+Z/T6Dn1
 LCE41WgbvZ908G8HbbIk0GwZHldfQVdzZTRpCf78kge8hc8iwMGRKcXGMZZpGwvEa21I
 x9Yic/UUuHSwjnCgk6PGwrEDjqiWlmw5hW2K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987730; x=1783592530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxzeaprBI4z7rUdXjLbLl1JxjfABXg6Kq6V7UBgNGWQ=;
 b=ofz2bhbM+rhyxAawCkxAgqswV6BQBmLo2QbNhICPBEZ8WaRaz6MJzTYIEmZ7KVkPpn
 VUDijV3t3mzpSRArlTZCBXbfJnvetDZ2O3c4m+dYXcEOjG1qF0qHSLjgjshJHqYe6ADF
 XIfuGojgytp4P/22UxsLZCDw/3thsR8ezTYE5F4lglpKWmwr/SQsnPhuAqI4iGAud8Bl
 9ADrwSzvtEps94nQp+0NSTGu9v2bxXoyPIh74IG4Z1mzlmK0ajaI3Ncl6YW9nrgHR/Fy
 b1ZGm7lowx/HV8dGzI600WsnwitTf/rNbl/0Wlojq20EPuTN9uLB8S46tLOetCVPxNyF
 oB3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8gvWvFeJW0kaKYJR+gx0MS6UMQ/4jhiwmFLA5jREZnzYwU1rBRB/rYv0p0HbKkYHi5qEIu4M=@lists.denx.de
X-Gm-Message-State: AOJu0YzzwbS+Bsc3B5a2/lmP1IOfXqRQ6G606yNMI+/wozKvnyXsSgia
 i8OUo6tu1c2/56gBnNd8QQXpBFV34C1jPd8xi4SkIH3jG3DbydeOz9RYzym9hvBOhBl3PdHXcUd
 gK3z9zFARHljWVMD60sos6Jkt402hHKe8suCaoUl3
X-Gm-Gg: AfdE7ckMdqyHhmfO6HSOovK6A9hxSwcrFbuq+vMGpNq59P2crRTuTwRKegHS3KfW5fU
 J2UTw5YAWcHh5q6UF1LhJGYro8wAm3gaRsoSxjU7umxZfQqCT0C4LlyLiKE2vmQXAN6TVCXjArG
 0gmQzffJ13SMgyrwSgAbqpPymOftVew2N/S5Horbjb4V7GgygoFKM68wsSU/nRL83RAtSB+yKm0
 kMUZthwRvxiFEnND2x/x1dB3Msvj20ycA3EAkOh5wvH81bsWAIrKXBJjugcZE5zjujv5T8vKQ==
X-Received: by 2002:a05:6402:a51b:10b0:698:562f:1005 with SMTP id
 4fb4d7f45d1cf-6989f31eb41mr1596792a12.16.1782987730132; Thu, 02 Jul 2026
 03:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-3-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-3-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:21:56 +0100
X-Gm-Features: AVVi8CdzridlcBiazhiM3iOI5qtCOQSA2HMaNi4bkx39RHwfD9psSwfKUOHtEZo
Message-ID: <CAFLszTho=qKJmEVx3a6S15NEXy04wuRGgW6UCmaozTE7bQsdGA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] linux/io.h: Use map_physmem to implement ioremap
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Jiaxun,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> linux/io.h: Use map_physmem to implement ioremap
>
> ioremap API is here to be compatible with Linux drivers,
> to maintain compatibility we need to ensure we are using
> the same way to determine virtual address for IO devices
> from physical address.
>
> map_physmem is U-Boot's standard way for doing the trick,
> we should follow that. For architectures VA == PA it has
> no impact, for MIPS it has it's own ioremap implementation
> in asm/io.h anyway.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> include/linux/io.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/include/linux/io.h b/include/linux/io.h
> @@ -59,11 +59,12 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
>  static inline void __iomem *ioremap(resource_size_t offset,
>                                   resource_size_t size)
>  {
> -     return (void __iomem *)(unsigned long)offset;
> +     return (void __iomem *)map_physmem(offset, size, MAP_NOCACHE);
>  }

This affects sandbox, but should be fine.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
