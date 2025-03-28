Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D4DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F5B8082A;
	Fri, 28 Mar 2025 12:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="exNfPnc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CE7809A4; Fri, 28 Mar 2025 12:35:39 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5987805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so3542984a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161734; x=1743766534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eQkz331SM9lzvPidpVlR4B53oKZRPN2z9ZRsawQddO8=;
 b=exNfPnc53bkbvXBe/XDqDhcjrzxFZnL6o4dnbQgeRlam387L0lceYYnD5Z9Y5cBV0i
 KQZfkRr0GfbWMFeIlDdO0EHvXL0KAbGn52WO6sWjUtGGYSePTVMD2IQojP3TQ6KfLCyJ
 MKznhaAKm5A4pkXngsnH2AsnPYzpEUiaqV3vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161734; x=1743766534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eQkz331SM9lzvPidpVlR4B53oKZRPN2z9ZRsawQddO8=;
 b=U8kd5CecMqJhFdOcF2PdZOVEvVvqDcQxWx5/Zky8dHPjUJv3gWcbf0xi5VUpas3yat
 Tb5D67mZYTSNKjfIbrjYOqrhI8m4oG+NlCzhOv393Zr2B+Ihlrlj7uEO7Nttl9AqV9c5
 iR3gAsAvyOrTnP5JKOVzJnf3h4B4agjAqwnsweJWKuj4zl0M771rYIN5AFg9HF9izh0p
 1Kr34Q79uv2phnKBKn/A+K87QAm9YD+/JDE0dCDnFBP+rz1fnW1muSTcS8mcn3ufVVYw
 4hxTSTx3rZeLTEDnVkGKWalQaVPk41DVcwc6K+egAdZKfp0xOTLrK0JaX++X8F48zYvB
 RdTw==
X-Gm-Message-State: AOJu0Yybcs+6BTx8xNO8dIZbgKUTWsi8fbd6K+7dCgxdJztBEFt9ONT9
 Ye0VwZBw3eOyuCJRBZ3LmdAmQ8F7VmnEUcd4j8kPKWzSr9Ui8d2yDbUsQekqqGmZzh63o7FLFj4
 mxVx7CcnWK748sOg3mpbYfSp3o70ToRRYQG1b
X-Gm-Gg: ASbGnctzw+9gNfcu9qHAkEET3lwu0X9RVjBm/t65JLEJU9vVM9765kHKSjJW08p5RfU
 5IxYiW0Lghp6gBo+gLdBux5mF5Z2LO/zOThLl2yAurFJSs3GIfsKY+qa+BiYJ9F4cCOsAVJnTWy
 u6mUyh6BoOF8YpC2OYPBttspCrzlM=
X-Google-Smtp-Source: AGHT+IFk828/GwM97d6VW0ddZv0PW4iqDKzDJ/n1G7M5qZRP4pqrm/umpDtsfED7Oa3o0yLgk8GPHVzsYpHmZ+s9F+o=
X-Received: by 2002:a17:90b:4c0d:b0:2ff:69d4:6fe2 with SMTP id
 98e67ed59e1d1-303a8159e14mr11144918a91.16.1743161733904; Fri, 28 Mar 2025
 04:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
In-Reply-To: <20250327231318.2713201-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:35:04 -0600
X-Gm-Features: AQ5f1JpMpqr0VztHuTl0kksDy2qnZ3ktefBQPhtTsu8NY4sVsenIM71pVk82_os
Message-ID: <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Raymond,

On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> is a default address for bootefi, bootm and booti to look for the
> device tree when launching the kernel.

I wonder if we can drop use of that environment variable at some
point? It seems strange to set a variable to gd->fdt_addr only to use
it later. Why not just use gd->fdt_addr ?

I hit this in the bootstd conversion but wasn't sure what to do. So
much confusion.

I see quite a few boards setting this variable in their environment.
So this patch would override that setting, wouldn't it? It's just not
clear what any of this means.

So I think at this point we should update the code to use the internal
control FDT directly.

>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  env/common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/env/common.c b/env/common.c
> index a58955a4f42..a38e5d107a8 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -16,6 +16,7 @@
>  #include <asm/global_data.h>
>  #include <linux/printk.h>
>  #include <linux/stddef.h>
> +#include <mapmem.h>
>  #include <search.h>
>  #include <errno.h>
>  #include <malloc.h>
> @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
>         return env_get_from_linear(default_environment, name, buf, len);
>  }
>
> +static int env_update_fdt_addr_from_bloblist(void)
> +{
> +       /*
> +        * fdt_addr is by default used by booti, bootm and bootefi,
> +        * thus set it to point to the fdt embedded in a bloblist if it exists.
> +        */
> +       if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
> +               return 0;

This is just too messy, sorry.

> +
> +       return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
> +}
> +
>  void env_set_default(const char *s, int flags)
>  {
>         if (s) {
> @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
>
>         gd->flags |= GD_FLG_ENV_READY;
>         gd->flags |= GD_FLG_ENV_DEFAULT;
> +
> +       /* This has to be done after GD_FLG_ENV_READY is set */
> +       if (env_update_fdt_addr_from_bloblist())
> +               pr_err("Failed to set fdt_addr to point at DTB\n");
>  }
>
>  /* [re]set individual variables to their value in the default environment */
> --
> 2.25.1
>

Regards,
Simon



On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> is a default address for bootefi, bootm and booti to look for the
> device tree when launching the kernel.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  env/common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/env/common.c b/env/common.c
> index a58955a4f42..a38e5d107a8 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -16,6 +16,7 @@
>  #include <asm/global_data.h>
>  #include <linux/printk.h>
>  #include <linux/stddef.h>
> +#include <mapmem.h>
>  #include <search.h>
>  #include <errno.h>
>  #include <malloc.h>
> @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
>         return env_get_from_linear(default_environment, name, buf, len);
>  }
>
> +static int env_update_fdt_addr_from_bloblist(void)
> +{
> +       /*
> +        * fdt_addr is by default used by booti, bootm and bootefi,
> +        * thus set it to point to the fdt embedded in a bloblist if it exists.
> +        */
> +       if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
> +               return 0;
> +
> +       return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
> +}
> +
>  void env_set_default(const char *s, int flags)
>  {
>         if (s) {
> @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
>
>         gd->flags |= GD_FLG_ENV_READY;
>         gd->flags |= GD_FLG_ENV_DEFAULT;
> +
> +       /* This has to be done after GD_FLG_ENV_READY is set */
> +       if (env_update_fdt_addr_from_bloblist())
> +               pr_err("Failed to set fdt_addr to point at DTB\n");
>  }
>
>  /* [re]set individual variables to their value in the default environment */
> --
> 2.25.1
>
