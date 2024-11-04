Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0143FD1119D
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 02:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208968912E;
	Mon,  4 Nov 2024 03:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mdHU53mq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A477789137; Mon,  4 Nov 2024 03:59:08 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E0589112
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 03:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e59746062fso3059361a91.2
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730689144; x=1731293944; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6qAauCwuHaaLpgrRMU/F2Og4hJfAWHiS+Qb6KN0EWo0=;
 b=mdHU53mq71eBSIZ0PvPjSm3XgUQcumwLKe4zchKKdWREhs4wUxoUWYpuFBev3aGd3i
 mk6BMvPHNVnq7LCPGX5HpJ6ntpU+YxQ9FRo4xcZmUDF9yxksLDRi3O5ZCELOGgM1csFJ
 yV2zEUJrQdr1hdk1KZ4z0UZRCKLFeJK1ppLZVsce2w1JUrcvgSVl+COhjYph7aKRVzhc
 WgmTiqvkZcD/UyqTu5RXQnH6XWtjKQVIFotOGxJffpwliazn3yP2OWY3KjSsVPfN2b3x
 dUDrN97k1S/nNsuaCUOiUZAIy1P/HjvGVcZCq1ogoojNUwLHoCXm0S1gWPx2yHkOG/HR
 H3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730689144; x=1731293944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qAauCwuHaaLpgrRMU/F2Og4hJfAWHiS+Qb6KN0EWo0=;
 b=KRqNBlIeQvg+n/Wr5hiHMWEsUawQ9+EVrDrRB32JHei2QwrkvzShIpvzE73Tby6Ycd
 9xErsnzqjS06eg9MeRwCMB3D8GOoXpc+/Lb4MlpQQLeUdalWr6niHNWZ86I9/E8ZqPrz
 oX4xD5LmyPSCjDRF51GDT6RtLAIXZqsOwByG/HKiwmWCwG5rZhIeNrr6f8veAaKG7hbO
 Q+TIO7AMIqhW8HuYvxl/xjGFVsiyHwvB5nhyXx2lDlJJWbygpvChBkAFpgsiwO9U5I0m
 c61RxrGCKx0kRNuX5XcEGmjSFZeB776X6tmXBicAJ+uFx3e4leTudIBDBe6R1nVXYkpt
 k6Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6W4paq9cPtlf+3OF0UO9guB8qYQfv25vsSo+H9RW5EIIjPzfix2wvrkSRGiTU1bC0/hWX97M=@lists.denx.de
X-Gm-Message-State: AOJu0YwcyrQtPbGB+HvJHpZk8WPa+DgKFQ9G2SA7kbwFDEfk3FNxY0Sd
 J/UOF5EGhWb84nPzLQEXR1BBBq5mtPyoNDSD1WDiKNZWgAgGJ9HpKgAx4OOaiU3r82S44l98rbj
 lOebQmthci2TxIdrIxkdBAJnhZbdmxlalqdZfKN7YyrtMtMiij5E=
X-Google-Smtp-Source: AGHT+IEo0Fca7+RlpYn2hnq6oMOobmJxDedOu6FusZxvUXdydkQyPAzaCP4KgqB3ipwBX5Who1ZT3qRwRyxxf9R4wp0=
X-Received: by 2002:a17:90b:3c46:b0:2e2:d239:84be with SMTP id
 98e67ed59e1d1-2e93c159030mr20736298a91.5.1730689144224; Sun, 03 Nov 2024
 18:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20241103224505.195451-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103224505.195451-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Nov 2024 04:58:26 +0200
Message-ID: <CAC_iWjKr1vNUF-XudBZ2kDemgb66LOpPp4CL2sBjLtO-BQY8Yg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: mkeficapsule: use %zd to print ssize_t.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Mon, 4 Nov 2024 at 00:45, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For printing a ssize_t variable we must use %zd and not %ld to avoid
> a -Wformat error on 32-bit systems.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/mkeficapsule.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index 49f5b7849e4..fb6c57f77c1 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -866,12 +866,12 @@ static struct fdt_header *load_dtb(const char *path)
>
>         dtb = malloc(dtb_size);
>         if (!dtb) {
> -               fprintf(stderr, "Can't allocated %ld\n", dtb_size);
> +               fprintf(stderr, "Can't allocated %zd\n", dtb_size);
>                 return NULL;
>         }
>
>         if (fread(dtb, dtb_size, 1, f) != 1) {
> -               fprintf(stderr, "Can't read %ld bytes from %s\n",
> +               fprintf(stderr, "Can't read %zd bytes from %s\n",
>                         dtb_size, path);
>                 free(dtb);
>                 return NULL;
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
