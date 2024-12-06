Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CACCE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCDA89655;
	Fri,  6 Dec 2024 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ircZk1r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBA389644; Fri,  6 Dec 2024 16:32:03 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F55B89613
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so1918067a91.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499113; x=1734103913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EK4+6zO8peDj7Vwzy5mhK8Fr2TN/2br2pqDXmAuZBK8=;
 b=ircZk1r8fe6t1SJt8usqCzaCTTCt9bXovA2vgAWCs6eiQ9A83H7+tuz/LDQvaNf8S+
 aK0GWSPUNYpurlES4kTDX+8h2x8Ot0FvDAQ0La/XsOchs4YpNCQh49hHXkbnNEge/iPD
 1w40Mwe0xgWHuVuNJ57m3xWW0fFTjJXBn7EVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499113; x=1734103913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EK4+6zO8peDj7Vwzy5mhK8Fr2TN/2br2pqDXmAuZBK8=;
 b=iEQQ5EvxCaA4qPHxPYcJdFMZK9O94IhkASnLZlwbiYh7gyGERXn7nVY+/svglmk4L7
 gvKYmKc+4PQPgv8DwTligupupdwq+1qW2Yl6gzDO2niDaebo4EhOdZ4kAxvS6qtpfd6c
 GPEMHfaB3Mg0TZJLtyvrEqiGuFqOOX4Cn4cS3ebfZtLrFlBNQgwXyZVtWWUGUamz+sTF
 ccHfoEnYyGOyXi8N1Z0Rl9bpsz8xJBS3Rbb9u8RsOg7iWVECwuOAvlOQ8W34L3N+TO70
 W1t2g1A3lHa4Z/RRT1FMMUc+rrawQrZy1OpO+5ldJL7WZX31MR9wkMmTGtE7A+UXniKI
 NcvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOKXDJKJ3x9lQXRzRpYozOS+f+PSxM8+2xE6sJB6smzIVfibOqcOmipx4hUTIY0nrTpRfBPAg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6J8V6Tt/E1mCr2x93na7IPxi/bjUEapryXMvUoYZ3i7Eib6jn
 wof10N8giOhAaNEk7NJKn1x7ylJQzsNFwNsQblmflMrtV1B/tblqpnYp2gdUlS2LxW1ZVkzLZXf
 btwWx0uW4H3jxTMK7gpFEcj/H1BzxsZJa9YuL
X-Gm-Gg: ASbGncuJXq5fHGuI9BOlBfHD/QBzI8KFX7dJb/xYf42t/3J5RPtVAYtFFbn68aKq9Oo
 7zwYAA6UwbKgGBI9v2qC2Tl9d0tqA/ALv
X-Google-Smtp-Source: AGHT+IEHHcsHqJvxiw/50obReIDqM4UcVk3SQiiHWRAEU9+yuHcgDwejuLpcilx/hA2yyRr537SS0JHX64E39bdfkDs=
X-Received: by 2002:a17:90a:e710:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2ef6ab103bcmr5162164a91.28.1733499113739; Fri, 06 Dec 2024
 07:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-5-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-5-05aff4b0ccf7@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:31:36 -0700
Message-ID: <CAFLszTj7psRzUuKfq+bMKeAsZS2xbox263sk=EAvOGKH+Z781A@mail.gmail.com>
Subject: Re: [PATCH 5/5] sandbox: set retval early in board_fdt_blob_setup()
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

Hi Evgeny,

On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> Bug:
> nobody sets 'ret' to non-error value inside board_fdt_blob_setup()
> in case, when gd->fdt_blob has been initialized before calling the
> board_fdt_blob_setup() (say, due to CONFIG_OF_EMBED=y)
>
> Reproduced with CONFIG_OF_EMBED=y && BLOBLIST=n.
>   ```
>     $ ./u-boot
>     initcall: 0000000000078e05 (relocated to 000061138d2c7e05)
>     initcall: 0000000000117b12 (relocated to 000061138d366b12)
>       fdtdec_setup():
>             gd->fdt_blob = dtb_dt_embedded()
>       fdtdec_setup():
>             gd->fdt_blob = board_fdt_blob_setup(&ret);
>
>         board_fdt_blob_setup():380 ret:-2 gd->fdt_blob:0x61138d4db310
>                 if (gd->fdt_blob)
>                         return (void *)gd->fdt_blob;
>
>     initcall failed at call 0000000000117b12 (err=-2: No such file \
>        or directory)
>     ### ERROR ### Please RESET the board ###
>   ```
>
> Patch moves code, zeroizing the 'ret', before checking the fdt_blob.
>
> Fixes: d8289e7dfe5 ("sandbox: fdt: Avoid overwriting an existing fdt")
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
>  arch/sandbox/cpu/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
> index d1c4dcf0764fb37ec99585a3db16fa34c3a54dac..7e93377e87e75b0fb92a8cf139b4a731a88a6a7b 100644
> --- a/arch/sandbox/cpu/cpu.c
> +++ b/arch/sandbox/cpu/cpu.c
> @@ -377,10 +377,10 @@ void *board_fdt_blob_setup(int *ret)
>         int err;
>         int fd;
>
> +       *ret = 0;
>         if (gd->fdt_blob)
>                 return (void *)gd->fdt_blob;
>         blob = map_sysmem(CONFIG_SYS_FDT_LOAD_ADDR, 0);
> -       *ret = 0;
>         if (!state->fdt_fname) {
>                 err = setup_auto_tree(blob);
>                 if (!err)
>
> --
> 2.34.1
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But note for the future we have:

https://patchwork.ozlabs.org/project/uboot/patch/20241102174944.412088-2-sjg@chromium.org/

Regards,
Simon
