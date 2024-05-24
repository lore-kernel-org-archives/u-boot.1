Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5981C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 06:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38C1881D3;
	Fri, 24 May 2024 08:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Im6djR7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D678831F; Fri, 24 May 2024 08:02:29 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4463E87ED1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ad4so3480092b3a.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716530546; x=1717135346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ccdBODBNDNbwNSn1GkpEIg0zS6F4Pl0Q2Y/f8iHIBbA=;
 b=Im6djR7vh3mzYSlHUkJrEW/g7kLRW3aAmPo63gtF/6t169U+Etr8qy4KZ5oiCWKvGv
 UMiQfR/LkTnLTN0VSyHZG3I/bK0VajXwMCol94EIcVPjgMfGQC8lJ4OpGlt3tl0Zdj+F
 ZwM5XNn2mZYvTLveTP4khZp4jUG9jLonBuX5bwpiSX5MxvDvrrVf9+1ZXgUJkgvJkv4M
 y9HfLFBeY6ms0o+Y+li1+MKAdGbS0wd+a4Sc4rOVUf6hcN+f3qi1+TwXgBKMoVUjv1DX
 8qSyekq6Is5ykZPnlnAAKu+enApfnN2xLXyJuO3sJxD4wIwMhkZxaj6H+342SxTM1NcV
 nclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716530546; x=1717135346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccdBODBNDNbwNSn1GkpEIg0zS6F4Pl0Q2Y/f8iHIBbA=;
 b=Mw5v/OJN9bdLW1gNx0TmpIX1rWDJpF/S0fsTUo/tx7hHjs9wAcQBaa/1Cewbmrp4WW
 x3kAnNf003FZVdCi34idod6K4srNQRvajhrIpNjLQwX19k344AVx7YItrLt/r/TVLifN
 RYUeq6fTcMJC16pdHeQr7ocO9QX5weN5GSnamhWOEA6yL7UXZZx/IwEZClphJM0jVtxg
 gCLhAUfdr4zVKN7hX1/gQmAY0OgD9GjiKyb7s4KU+jRvdPs350XFhqYT+trhoa59+EL2
 rlBDEnSYUlMrRJIJougZ4ON/ZT8bF5fldLH0aBDOFjfZr8ho2eLCQKwJdLeI5atiIoE3
 i1bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTTVb59kkTWyjCPwM/PPx5HYSTYOLOn8SAYWm+5FEcNg0R+mTlJ5eXsA72+faN0mvjByPRO3pFCoCKrzcjxOniBJQ/BA==
X-Gm-Message-State: AOJu0YzeteqSqWklZ/SGEoozrckURvIw6CYhC524keXLt5lrE6xdum8C
 wLOVJAmhTswk00vckpemNKXRUtBld+zMcPWlKGSzo47VVdI7E03Tpx9yAPl5XkITttxvArlyULM
 3eWp5AAyEIebPMCZ1yJxNFvVs5wEt7Z3MQr813g==
X-Google-Smtp-Source: AGHT+IHqYq1sutRr62x2rGRIejYn0fdQwO8btUe5kfbdm5NNBPY0moZiUx8U/tnNbbbUCSg7FeDbHJJuzyApYhF9jqA=
X-Received: by 2002:a05:6a20:d04c:b0:1b0:1be7:3705 with SMTP id
 adf61e73a8af0-1b212cc5089mr2083423637.7.1716530545629; Thu, 23 May 2024
 23:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-1-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-1-e8154e00ec44@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 09:01:49 +0300
Message-ID: <CAC_iWj+WsO_dx84UHpv02b9cxNtzHYeCjZLP5VyVw9AbXet-yg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

[...]

>  #include <dm/uclass.h>
>  #include <rng.h>
> +#include <u-boot/sha1.h>
>
>  int uuid_str_valid(const char *uuid)
>  {
>         int i, valid;
> @@ -368,8 +369,40 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>                 }
>         }
>  }
>
> +#if CONFIG_IS_ENABLED(UUID_GEN_V5)
> +void gen_uuid_v5(struct uuid *namespace, struct uuid *uuid, ...)
> +{
> +       sha1_context ctx;
> +       va_list args;
> +       const u8 *data;
> +       u8 hash[SHA1_SUM_LEN];
> +
> +       sha1_starts(&ctx);
> +       /* Hash the namespace UUID as salt */
> +       sha1_update(&ctx, (char *)namespace, UUID_BIN_LEN);
> +       va_start(args, uuid);

Should we use sha1 here? Is it described somewhere in UUIDv5 requirements?
If not I'd rather have a sha256

> +
> +       while ((data = va_arg(args, const u8 *)))
> +               sha1_update(&ctx, (char *)data, va_arg(args, int));

sha1_update second argument is an unsigned int

> +
> +       va_end(args);
> +       sha1_finish(&ctx, hash);
> +
> +       /* Truncate the hash into output UUID and convert it to big endian */
> +       cpu_to_be32_array((u32 *)uuid, (u32 *)hash, 4);
> +
> +       /* Configure variant/version bits */
> +       clrsetbits_be16(&uuid->time_hi_and_version,
> +                       UUID_VERSION_MASK,
> +                       5 << UUID_VERSION_SHIFT);
> +       clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
> +                    UUID_VARIANT_MASK,
> +                    UUID_VARIANT << UUID_VARIANT_SHIFT);
> +}
> +#endif
> +
>  #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>  void gen_rand_uuid(unsigned char *uuid_bin)
>  {
>         u32 ptr[4];
>
> --
> 2.44.0
>

Thanks
/Ilias
