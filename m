Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253FEC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EA388B56;
	Thu,  1 Aug 2024 16:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mI4AaYMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64371889FC; Thu,  1 Aug 2024 16:42:38 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE5F88B36
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6678a45eaa3so59574687b3.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523355; x=1723128155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sD+enhfOMej7DvqkovxxtrJhVORM5GKgHn+gjTanvTo=;
 b=mI4AaYMd5wWd7FLGdfk1dIkWhjepODMGFNNL9osqqAxK8kwpLFvbqi36KN/L+DSzUm
 4dOMBiMqomlkJoVQTFF6svqqGMvcbVmbqo0862QlHJ6L29vm5FZi6HbxaEsBaWvAjhQx
 bb72ritDOTYqaswlRzw0dnypxEHS9yoVrfMrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523355; x=1723128155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sD+enhfOMej7DvqkovxxtrJhVORM5GKgHn+gjTanvTo=;
 b=lQXp9ZyFuNw8JKAoZ1ffPXRtcBA/5URzLRIFtwfr9vMsI+UNcbLYuHLPwXjaYfHpxA
 W1ZiPkqKtFalTlQptlDkn3xtLV2Th3ReAH5dFvOJkVjGaqrrKMDxDlUMCIJYwqwQAZUl
 2pqBP7Ez0Q0cIJkuVogTooXDtq58rWMEy0ghtaeISWyQj3hk7Yejpiguv/Etx4H4tNf9
 xX3Bf3rQ6/8wLdrxrHhpy0MIdgLbs983mkf1PMazwEiUDTw8ixnXM86BsrXDH7iQF0Bw
 xTV/IOcTbUCt+vsT+jBU3oVpcppcsd8tdmZoIDwb/vcog6tun+RR7PpyGyNO9Y4uomMv
 fZpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkwqW+2LtqrecEn/Xw/QX+o9LA7hH2MEjh+5l7Y4yEwIMq7qdCS76nSsK9ztbwBK1PS8rHOg7Q3SaQA0B8VsNjn4/0sw==
X-Gm-Message-State: AOJu0YyTEf3BLJM4PqP4An/7kWRXVRln0f/mUYcRgaWofxWogVewfbT4
 HXFyGglkxAeHyQ1ghTnGHnqtcO0wtOzU68gKJK4Zq3gf0/d+WrMQnEctnqw/H1bd2QNF+0cMlDw
 MOiqV8dqRjOCp6Ffbx++VyXLBAA7vjYZsd3S4
X-Google-Smtp-Source: AGHT+IEc7hZWA2HJRl5dMeZMv48Q9jQoCijeo25ZX9tbbvW51hbM1Uw6qi3ZJpvsAB5j6LoZEwZUBZvzeKrLbnr0Nxo=
X-Received: by 2002:a0d:f1c4:0:b0:64a:9fc7:3b15 with SMTP id
 00721157ae682-68961037a8fmr2769027b3.26.1722523355070; Thu, 01 Aug 2024
 07:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240731134257.686017-1-admin@hifiphile.com>
 <20240731134257.686017-4-admin@hifiphile.com>
In-Reply-To: <20240731134257.686017-4-admin@hifiphile.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:24 -0600
Message-ID: <CAFLszThGCdJYopHkQn_84OVjNjQyv3WbT4gmW7NpKYuuZRet8A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] cmd: bind: Use device sequence instead for driver
 bind/unbind
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
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

Hi Zixun,

On Wed, 31 Jul 2024 at 07:43, Zixun LI <admin@hifiphile.com> wrote:
>
> Currently uclass index is used for bind/unbind which ignores alias
> sequence numbering. Use device sequence number instead as it's
> the number explicitly set in the DT.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  cmd/bind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

I assume no tests need updating, but please do add a note to
doc/usage/cmd/bind.rst

> diff --git a/cmd/bind.c b/cmd/bind.c
> index 3a59eefd5c..30f1163e17 100644
> --- a/cmd/bind.c
> +++ b/cmd/bind.c
> @@ -31,7 +31,7 @@ static int bind_by_class_index(const char *uclass, int index,
>                 return -EINVAL;
>         }
>
> -       ret = uclass_find_device(uclass_id, index, &parent);
> +       ret = uclass_find_device_by_seq(uclass_id, index, &parent);
>         if (!parent || ret) {
>                 printf("Cannot find device %d of class %s\n", index, uclass);
>                 return ret;
> @@ -58,7 +58,7 @@ static int find_dev(const char *uclass, int index, struct udevice **devp)
>                 return -EINVAL;
>         }
>
> -       rc = uclass_find_device(uclass_id, index, devp);
> +       rc = uclass_find_device_by_seq(uclass_id, index, devp);
>         if (!*devp || rc) {
>                 printf("Cannot find device %d of class %s\n", index, uclass);
>                 return rc;
> --
> 2.45.2
>

Regards,
Simon
