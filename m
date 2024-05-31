Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1250C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291588872E;
	Fri, 31 May 2024 18:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X9RHnSL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECF688783; Fri, 31 May 2024 18:12:32 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900E388607
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6c4926bf9bbso548102a12.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717171949; x=1717776749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ttRJpMVJwW3wbEWb/4eUo9Ccddy2KwKgNh39f2aCvQw=;
 b=X9RHnSL2cURYGV0ax7YYQCr3ok8nMZ1KB/oBG0Af3/GFx2Iw3EoxxzoDVZZCHMDNng
 WZ3jBM5hFrQiFLxN1nk6bv79yLlpkwFJtGRONfqvkn5yIAsihUJqspk3JaoWjIQDFEZ4
 wPaed8Q71cFBlAW76GhfGvVQhRuh5u0MiBMJVnTcDzAqE96riduLcwBR8Y7YolWAp6Ho
 JJgk/boNIBYQDzKfC8nCoav3rB3gbpJi6JW2feue5cNtZSGci+qrXE1fOi1WOt4GGopo
 XmTt8wBzRgEEzSnkfqA2RDTSeoo0BQG2ymUGXe4IhczLufOwYz8VEZ7uNONWnzhWGICL
 h7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717171949; x=1717776749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttRJpMVJwW3wbEWb/4eUo9Ccddy2KwKgNh39f2aCvQw=;
 b=bHU8A6sn4fedh8hAd7K4e3D32+QorkzVyEhYx4VhYwPVWOaKHsLTdGRcpnxgXLQYOz
 L0fC/XG3cyzs1rX37HNyQVXEtBU0vCd7G+gzRdo6TcDihNQElqZ6hHaaJ3UMWkMqR0Uc
 vBIqKjlzObIqoCJYHsVHk2FDi2IxPgvc6hAqp8BOYfAr962Pw8qwLZpLda5t4PZ2cg9Z
 y/Ta5lr714lBqI+94d5jBm22yKswjV+s5d5FBIxoPKggrYsBXG+6fK50PV3RydDQvOew
 FZAnLT3Cs8hBbUmLV9yelOzZTn79ZgZSIl5cSYL+3k7K3JN88YwYzWUeT/gLRHfItjHh
 Kt3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhiRC8gMiexrQvdV4d4AA4L2aQ3IFI9WxUdrKM0zU6lWbptpFgtUFakZQST5yu8VFmYkzQzJ4gkakjlgPtDANIMhqQRw==
X-Gm-Message-State: AOJu0Yy8lpF0idQjejunWhqBZL179kIx/eO+GtJEpwywVduAp958w6qF
 M0IFDD2/LV09rYb6lQGtlv4yRoDVwbB5TQ+qeluKPdmARHdjoxyPRZ0TmDZ1Ch2/iFAyTaCvmpJ
 2LyRqUM3C7wzZlQDqb05t/+ZeiMz2y3AIzCbnkg==
X-Google-Smtp-Source: AGHT+IEEsGsQwT5RDJULcZbLkh/3Jy3JgE9VFiypG0BXpit8aNYgnPkjj7wweGXXB7VHTFJnRMaxQg4yPQmy1zsgqNo=
X-Received: by 2002:a17:90a:bb87:b0:2bf:92a3:f6fe with SMTP id
 98e67ed59e1d1-2c1dc5c8f6dmr2313905a91.32.1717171948925; Fri, 31 May 2024
 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 19:11:52 +0300
Message-ID: <CAC_iWjKLfxe7q5HyT0f2mrnSYCYtqcvGzWFN877i0pdfELCD=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] lib: uuid: add UUID v5 support
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

[...]

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
> +               unsigned int len = va_arg(args, size_t);
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

uuid->time_hi_and_version is a u16 so this should be better off with a
be16_to_cpu?
OTOH your initial implementation was using clrsetbits_be16 and clrsetbits_8.
Looking at what we have the same calls are done in gen_rand_uuid().

I think it's better if you make a function call for this and replace
both your code and the gen_rand_uuid() instead of open coding that

Thanks
/Ilias
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
