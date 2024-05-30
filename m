Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7527C27C43
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 15:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B73A886D4;
	Thu, 30 May 2024 17:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w6PgKUDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E53E886DF; Thu, 30 May 2024 17:08:40 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F252884D4
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 17:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b594deeso7202575ad.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717081717; x=1717686517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tu1nOjCBzwuTRetXoktNVi/y3DLc3CHqRRSIBcIxrQE=;
 b=w6PgKUDGqPncNncJZSeRSXk7GuUWihrZxhj0/CHMvmfKOEhh9TQF23wGFFSv2fx+Zk
 mMReT2P1Ge6B8YcOgTWXSCZA2/H4lu7zUi4f3rpUBdQgLNSX8YOzaKWsEqfIQDGHDWWl
 TF6QYJf+GZvN+xArxoU8xMVhjJABVm+T58Mhcu6oOW1PzRv7Z0hbBgAui+ii/2rVWw99
 6sFzfXSy0Ab2X2QmCMA66pef45W/dRiYaszGnO7qbHKgvDZEuCq8UCXuoVWWQ/FV3468
 UQ5KtmAqgkTf0yF3KLtAd4jNPubW1qm0itfK+iQ2a8SIEc8WTXbaXpevCWF9IrTKjT2q
 vWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717081717; x=1717686517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tu1nOjCBzwuTRetXoktNVi/y3DLc3CHqRRSIBcIxrQE=;
 b=q1ZhWXZOkzgJr6SKwdzOXPkihOZRCb1lblZiivg4PrSKpacLs2W+znusRqhg9XFTf4
 jBDdOqPbys4F7jPiTqZb+5JYQglZppMHTTrMZ3efvzIGUv1beR0U/Hbi+XTayyRKGyLW
 I2PStHBoyZX4RwTgpvnUxpT3Ao8sGvMkLUJvX6p7Izi4LfR8Mia8hbZ6uxtEqSDP+pr5
 YWzYX0dY/PvzxuXgX0ESgJH//J/AYYirdCQUuizYFlM3HAyTanl6yhnCvzLOF4PHCGrB
 K3CWT+nn74MYkPeMKl8iUb65CyCNAqrz0aCAY/kavqF5/VHPYYs3Wmu/eSYdPRZePJqs
 wshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbYniTuJy9dnf6QUEMyNUJCZdOjD6KYCvcM4AEqfkyl5nIz3/hLVG6Vm6qU14yvZE7wUUhx+zLIBpnOBSUo9quDi0MRA==
X-Gm-Message-State: AOJu0Yw/4tWW6OqFavzwT2mhZ5fDBMC2TgXL7V73L6ux9UUbqhcM471h
 wHRdeMMMuDinahViETkfWZM545D2E/hKc93BMv378iCKr4Toilyf8+bCMfeNDGhqqgML/s4uinS
 AAe/GU4SHfkYO7vp29kPaXax03MoNZDAPJpzirg==
X-Google-Smtp-Source: AGHT+IHwm6s45fj8rqDikz+ZfWZUvu7d9PHY3wYrNn/TVtQBuQWvgNNsbu1mfsCn93IeWb5OnGpFPGr8AFTapYJ9Hsk=
X-Received: by 2002:a17:902:e549:b0:1f4:5fe5:74c9 with SMTP id
 d9443c01a7336-1f61a4e4e8emr32406815ad.69.1717081716680; Thu, 30 May 2024
 08:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 18:08:00 +0300
Message-ID: <CAC_iWjJMHnZRm=cYiSrDtMGLtpCBQBEZTy6GGXkx0GhfXJBR9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

Hi Caleb,


> diff --git a/lib/uuid.c b/lib/uuid.c
> index dfa2320ba267..6ef006cca1da 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -21,8 +21,9 @@
>  #include <part_efi.h>
>  #include <malloc.h>
>  #include <dm/uclass.h>
>  #include <rng.h>
> +#include <u-boot/sha1.h>
>
>  int uuid_str_valid(const char *uuid)
>  {
>         int i, valid;
> @@ -368,8 +369,44 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>                 }
>         }
>  }
>
> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
> +{
> +       sha1_context ctx;
> +       va_list args;
> +       const uint8_t *data;
> +       uint8_t hash[SHA1_SUM_LEN];
> +       uint32_t tmp;
> +
> +       sha1_starts(&ctx);
> +       /* Hash the namespace UUID as salt */
> +       sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
> +       va_start(args, uuid);
> +
> +       while ((data = va_arg(args, const uint8_t *))) {
> +               size_t len = va_arg(args, size_t);

sha1_update takes an unsigned int
so i'd prefer
unsigned int len = .... etc

> +
> +               sha1_update(&ctx, data, len);
> +       }
> +
> +       va_end(args);
> +       sha1_finish(&ctx, hash);
> +
> +       /* Truncate the hash into output UUID, it is already big endian */
> +       memcpy(uuid, hash, sizeof(*uuid));
> +
> +       /* Configure variant/version bits */
> +       tmp = be32_to_cpu(uuid->time_hi_and_version);
> +       tmp = (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
> +       uuid->time_hi_and_version = cpu_to_be32(tmp);
> +
> +       uuid->clock_seq_hi_and_reserved &= UUID_VARIANT_MASK;
> +       uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
> +}
> +#endif
> +
>  #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>  void gen_rand_uuid(unsigned char *uuid_bin)
>  {
>         u32 ptr[4];
>
> --
> 2.45.0
>

Thanks
/Ilias
