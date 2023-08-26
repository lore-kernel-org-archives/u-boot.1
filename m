Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB8DC83F0C
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 02:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1DA86B34;
	Sat, 26 Aug 2023 04:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KtCQmDFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD0E86B24; Sat, 26 Aug 2023 04:04:49 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BA586AB1
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 04:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso1175872f8f.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693015486; x=1693620286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rGyEZVAHVwd3kck5MN/EcXDDg6059qQKdHPsWUCj4i8=;
 b=KtCQmDFwrI7yMAq5wNnccGyWcAlyO4xR5p2RYY4Zsx5lx9zgMuHtyWEM7VmH9Ohftt
 r5+FqrmL/ZuLFrZciMK+UpoiDEOFqThyz1E52MG3ttpIoV5bKqix+PoeJE9hfha/vAv+
 CWJL3LQFwcifazuHePRgtz3DqukcQGECz9GS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693015486; x=1693620286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGyEZVAHVwd3kck5MN/EcXDDg6059qQKdHPsWUCj4i8=;
 b=l5reYKDVUmlVXp4Cn6wmMi2cnEZzCxarADscHlbzWqHdnTTJDy5vNcC5m2Mc0jH4tB
 Xf3YFVab5n5oOIwSGeBKg9Wpj9v6Yb3YbGi0vZAI6XEDzFGXrn1f2GR/gCJWgqloGRRm
 5sgVuIwr+r0rknAQ6XEuD0S5jF53pDum4AmzUshEmlqEWys5FlvoHupLHv60vluzkS63
 Our9t2pJnebLK+fhu/p+PLSVgYM9ylonjWoBJe2yvjCj/0BhhjG1eI1ynaAlEWBC2jc+
 /Vy9HThGHKc8Yae+6QV3iA9w8fe3GJ55t8+lvjEVJEhocqojZd0MBK//6M/+Y8+DT40w
 QSdQ==
X-Gm-Message-State: AOJu0Yy/9ECCweYGuq9i9xJe3zF5Ev0Zg48jZPM3AePmL3RF+vLrbLcx
 3WjAuQatRe6p73wqMMYZC/t+owExG35igFxjPuAvYg==
X-Google-Smtp-Source: AGHT+IEWXEfSDaVdkJRb8VaHKqMzJ7GFN9vVajF0ACHKBozSZqgYCxLL6LUkwsf9YzqCShgXXTkSlLTewoL9TqwRIXI=
X-Received: by 2002:a5d:63d2:0:b0:317:5b1b:1a40 with SMTP id
 c18-20020a5d63d2000000b003175b1b1a40mr14251175wrw.49.1693015485811; Fri, 25
 Aug 2023 19:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
 <20230826015343.167612-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230826015343.167612-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 20:04:33 -0600
Message-ID: <CAPnjgZ2kYCtNRXK6t88pK+G5w-+sBbGO4epxp4Ww1mjJVQT8dw@mail.gmail.com>
Subject: Re: [PATCH 3/3] cmd: let gpt_partition_entry be hexadecimal
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Joshua Watt <jpewhacker@gmail.com>
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

On Fri, 25 Aug 2023 at 19:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In commands like 'ls mmc 0:f' the partition number is hexadecimal.
>
> In command 'gpt setenv' variable gpt_partition_entry needs to be set
> to a hexadecimal value to allow its use as a parameter in a
> subsequent command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/gpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

eek that is an unfortunate bug


>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 99ca0a6163..964056bd28 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -744,7 +744,7 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
>         if (ret)
>                 goto fail;
>
> -       ret = env_set_ulong("gpt_partition_entry", i);
> +       ret = env_set_hex("gpt_partition_entry", i);
>         if (ret)
>                 goto fail;
>
> --
> 2.40.1
>
