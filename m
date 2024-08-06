Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9414FC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA5788B32;
	Tue,  6 Aug 2024 23:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oHQ2pazh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E53D88B2F; Tue,  6 Aug 2024 23:51:33 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A0688B42
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb4b6ecb3dso929181a91.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981084; x=1723585884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UgilRznyHXI8hNbMKh5tdv77Bye3nU0uOETCjPsMYto=;
 b=oHQ2pazhbOSMx6zcQZM+2ksEXp83RcnSzadQzDd5ufRiskV3pHJDDAaZpjtf0f+21y
 ncC1Jv3SGiHnpWHIP96EF1D22BnfkjvBBTu11Mir/pcNBA3GZmUUiIqOpEmLKlz1vYj3
 +FFrOj5bnqHWEZjpHwp/YRYmqiM2GQOJV0vk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981084; x=1723585884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgilRznyHXI8hNbMKh5tdv77Bye3nU0uOETCjPsMYto=;
 b=R7MvAtspWOUylS2zkJ0nBX8pCtIJP+ez86hyQo85USx7f5nt+SLORFnFVb2yKYzoN8
 fvRHR+ERNCWdxh6ngSAWfzXg8137NgO8a8EZmdmFPY3G9fiwIfjuN355A5FhJfghMYM8
 Cesjod3wycKQvQNlDxhsS4piwi3u3TFdtINrsopKIz0TYn1wpNzYZ+uBPCGvGtsW3NC7
 18PEvQehEj95mtqZJMfhQgErlY6CJT4uAUXBUaCA6+KlMfD3zERpqafohYjX6Ro8Pxzq
 zoU4g0yznMDX8oUlINPp5h0bJ1MBdQCc6gJJiWAPT87tGm9SAz7zn+RRsJXlOPQICVOC
 Fp5A==
X-Gm-Message-State: AOJu0YwgZCen92lVZ6uvdFmDVdWudMj7ngFrDMqn7QS1TeKpRCSFVqkg
 9NUnfqXXVzFF2AyJ4F1gayWc6v9jqNpTh1zmW0TgQkvdQwlfMYw/kzExPjiIc1aR5+Uklsr9njJ
 PIdsIOPUCuGf4LWpxz+0RO+eYFYsoGZSL61Rf
X-Google-Smtp-Source: AGHT+IGywqHPpDDRpTFyYE6gbYzUDZukRFv+4KdEDIQ2uMA6rKdyq/W8FkzKDv7GxTpxZxSNdrsjxIu6D+VGdqTkqoA=
X-Received: by 2002:a17:90b:164f:b0:2cf:3d15:8ea9 with SMTP id
 98e67ed59e1d1-2cff93c8c9dmr16440655a91.4.1722981084102; Tue, 06 Aug 2024
 14:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
In-Reply-To: <20240806120659.686073-1-prasad.kummari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:46 -0600
Message-ID: <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Prasad Kummari <prasad.kummari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com, 
 venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com, 
 n-francis@ti.com, d-gole@ti.com
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

Hi Prasad,

On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
>
> Added LMB API to prevent SF command from overwriting reserved
> memory areas. The current SPI code does not use LMB APIs for
> loading data into memory addresses. To resolve this, LMB APIs
> were added to check the load address of an SF command and ensure it
> does not overwrite reserved memory addresses. Similar checks are
> used in TFTP, serial load, and boot code to prevent overwriting
> reserved memory.

The SPI flash may be used to load other things, not just an OS. What
is your use case or problem here?

Regards,
Simon


>
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
> UT:
> Tested on Versal NET board
>
> Versal NET> sf read 0xf000000 0x0 0x100
> device 0 offset 0x0, size 0x100
> ERROR: trying to overwrite reserved memory...
>
> Versal NET> sf read 0x79ea9000 0x 0x100
> device 0 offset 0x0, size 0x100
> ERROR: trying to overwrite reserved memory...
>
> Versal NET> sf write 0x79ea9000 0x 0x100
> device 0 offset 0x0, size 0x100
> ERROR: trying to overwrite reserved memory...
>
> Versal NET> sf write 0x79eaf000 0x20000 0x100
> device 0 offset 0x20000, size 0x100
> ERROR: trying to overwrite reserved memory...
>
>  cmd/sf.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/sf.c b/cmd/sf.c
> index f43a2e08b3..d2ce1af8a0 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -10,6 +10,7 @@
>  #include <div64.h>
>  #include <dm.h>
>  #include <log.h>
> +#include <lmb.h>
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <spi.h>
> @@ -272,6 +273,35 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
>         return 0;
>  }
>
> +#ifdef CONFIG_LMB
> +static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
> +{
> +       struct lmb lmb;
> +       phys_size_t max_size;
> +       ulong end_addr;
> +
> +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +       lmb_dump_all(&lmb);
> +
> +       max_size = lmb_get_free_size(&lmb, start_addr);
> +       if (!max_size) {
> +               printf("ERROR: trying to overwrite reserved memory...\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       end_addr = start_addr + max_size;
> +       if (!end_addr)
> +               end_addr = ULONG_MAX;
> +
> +       if ((start_addr + len) > end_addr) {
> +               printf("ERROR: trying to overwrite reserved memory...\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static int do_spi_flash_read_write(int argc, char *const argv[])
>  {
>         unsigned long addr;
> @@ -315,7 +345,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
>                 ret = spi_flash_update(flash, offset, len, buf);
>         } else if (strncmp(argv[0], "read", 4) == 0 ||
>                         strncmp(argv[0], "write", 5) == 0) {
> -               int read;
> +               int read, ret;
> +
> +#ifdef CONFIG_LMB
> +               ret = do_spi_read_lmb_check(addr, len);
> +               if (ret)
> +                       return ret;
> +#endif
>
>                 read = strncmp(argv[0], "read", 4) == 0;
>                 if (read)
> --
> 2.25.1
>
