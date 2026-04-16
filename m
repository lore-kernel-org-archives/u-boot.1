Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C99DF8D77C
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C7483FC0;
	Thu, 16 Apr 2026 23:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SGoIVKww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C5383EEF; Thu, 16 Apr 2026 23:07:30 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF7583EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso14122b3a.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373647; cv=none;
 d=google.com; s=arc-20240605;
 b=Sxxz5+YsvlG+4CgSD877jeFPta6OyFJY4IzpW66w5R3oTOULHDoCQXgEEpt5V8VJqb
 TYft+A2G6Ryz0NDcVJekLHHLjBnTlgOFDxHrraKvrgYtfc01gvgIOFbVT9iEflvFDrV8
 3IhKT/8nO/79z77qhJhwm4yFyLSneZuEt4vBXNz83RbjxYrKtZJeSbLO5SQkE7ijoPSB
 rw6VKA4HZfd5Cr11b+RyvSZ1DKzir1RGGniODDMBxbPlQPdXAm/A0d6q2lN7+qt+JlW5
 M9T7iX258x+M8EppDF1ZW9TGb/2TpsVXxb5GigZoOIi8IRtR2LBXGDg+Tuer2BaSzyFZ
 KdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lCHrczTgAg1arX1rTBbwoFW4AgDmUUJyY+CWT808Fds=;
 fh=l/r1vsCeo0JYoY/8e+8RCaL8GrWqIw7H3MkBLAqGicU=;
 b=EqdL6m5E/NIJ7O9cD9DcCQcD20/gk4dWrr47W4lfZNeQZMHU8kcidCSjFa47CUhruD
 CTQFX5k4ayJa5d2ZOmK7T5LIYtXZHKg+jY8uG5yhcRtFo41JdHHB9qnPorY/M/l1cmrC
 +UZi362Nm0mZGLaXXEYeYS6g7ih3GsrVg4LRTDAKqLjkzcF7VMMl7rFaGuEvuR1XGdGA
 MiuWABqzXw63E3rIcv82sBYot2WWNLpPewCOKz/rlKbHTbe14Qo9aVoPSSVS+Br74ttZ
 /CJm8/rX/Mjt8r034O+4WqycWQVJGBN/ipF30bPHtYQBAxk1v2pcpwKwoYRpaynDwJuC
 hSaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776373647; x=1776978447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lCHrczTgAg1arX1rTBbwoFW4AgDmUUJyY+CWT808Fds=;
 b=SGoIVKwwsa2qpKIIiyL6IaWLcntODoJyKXxrbYMQes5EFI76vHhpEA3vUg+r+ZC9PN
 I4fRWp9pjnYSO07W/aJn85vt4Qv6x2gBL2Ce49Zuf78WHqpTTix+pWoZTGUox8su8Dbt
 hlvipjuMWhEXK28LoNRR+efas7Ewo8DSkck4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373647; x=1776978447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCHrczTgAg1arX1rTBbwoFW4AgDmUUJyY+CWT808Fds=;
 b=gkV/Dn+K3j/YAs19mLNvS7K2C9P34EiXU3SsQqo5b8x6wThbsEyXtVAOTqJnOf1q3I
 qbRlWq4ihmeAxxxt+s7u71Au+OzN/FqTz4bmVQvuKc3yPb8+NRlBAvmtwCLoNX9zk4k7
 HSFzGZvYx9YtvidkRURrDnJZZHtiZ1JaWT6ULXN0ofSBF9Xj29zo0roCUbz3TR2RSBYN
 uBw0/pBajCnbjnT8WlUqFChKPH8qZLVUXIJ1mm7ebdba5/cpUftSZ/58svHYg//113w9
 ZDppP17lfgHUxOECe0ebfh+u8L/nATpaHRTKfukH8MJ9RwdHuWoOxhrQnZKhxQu+pbFO
 vqlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Sdc7YXCMR0G8LwKuTth9j9lKCYNwONhsIYMLVAFexbD6gtu61f11KHVZIocoE4wFUWGSZg2g=@lists.denx.de
X-Gm-Message-State: AOJu0YweMRbDbp1Oy6US18tx1ik3hAfcBsxnM61fcmhEo+SfU+kU+rhn
 qpeU3lbpBIb/GeCT3MkmvOzlaQ5EARUAJVIE/qY7jZswLCrFTQJU1uqcLcUNeLYT92TCtqxS73g
 mq5euN0gmlrAtmjhMk3VV3WMEAmfiZ1SH74GRTu1D
X-Gm-Gg: AeBDietQcNcpf1u2zZsavb01vgtMlAkXfA7YnvHqMsYtAM8PiddxP+64x2C6UfG4kbC
 UHXbVK5tOyudKgoQvBf1WV3FJZ0iyUOAO9brYjjPi+rMIGFHdxZVEa2jkJb0IKM6PdfVmiTByF/
 OStzGnPvSGqGKf9kyacCV96N2wm5hL1chQU+f4oPpejFRmAFIkWAbpDCldoXSCtsDu+ZKNLaw3E
 wJvyYATq0lvGVXMFb/dLnhStqCVGBq6u2n1GI8rNzCVNLjItpwJ8IhYKUSAnXqLEkNVh28xOFMs
 ttP5Qo5F5imRYBquRKpr
X-Received: by 2002:a05:6a00:c89:b0:82f:592f:2ed7 with SMTP id
 d2e1a72fcca58-82f8890d526mr931402b3a.45.1776373647101; Thu, 16 Apr 2026
 14:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
 <20260416084535.1490476-2-ghidoliemanuele@gmail.com>
In-Reply-To: <20260416084535.1490476-2-ghidoliemanuele@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:07:03 +1200
X-Gm-Features: AQROBzCgSbXa8LPLitglm-VGTOgojPsljEXJP-ttnijStgAUD3m-4TCW8KK1WU0
Message-ID: <CAFLszThkuu0c8w6fOMWGKip7cNiNxDP73yvyUQnyLhMmMBMYhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] common: memsize: add RAM size probe based on alias
 detection
To: ghidoliemanuele@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Emanuele,

On 2026-04-16T08:45:22, Emanuele Ghidoli <ghidoliemanuele@gmail.com> wrote:
> common: memsize: add RAM size probe based on alias detection
>
> Add probe_ram_size_by_alias() to detect RAM size by checking whether a
> write to one address aliases to another address.
>
> Compared to get_ram_size(), this function allows the caller to:
> - limit probing to a small set of required accesses
> - avoid touching reserved or already used memory regions
> - handle non-linear alias patterns
>
> On the iMX95 SoC, when used with LPDDR5, accesses beyond the end of an 8GB DDR
> configuration do not alias to the expected linear wrap-around addresses.
> Instead, the aliased addresses appears to follow a pattern related to the
> DDRC bank and bank-group addresses mapping. Experimentally, the observed
> pattern is:
>
> Write        Read
> y00000000 -> x0001c000
> y00004000 -> x00018000
> y00008000 -> x00014000
> [...]
>
> common/memsize.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/init.h   |  7 +++++++
>  2 files changed, 63 insertions(+)

> diff --git a/common/memsize.c b/common/memsize.c
> @@ -127,6 +127,62 @@ long get_ram_size(long *base, long maxsize)
> +long probe_ram_size_by_alias(const struct ram_alias_check *checks)
> +{
> +     long save[2];
> +     int dcache_en = dcache_status();

Do we need to check for CONFIG_IS_ENABLED(SYS_DCACHE_OFF) here?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
