Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17399E8B386
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E4883F36;
	Wed,  4 Feb 2026 01:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oeFC/6Fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306EE83F36; Wed,  4 Feb 2026 01:23:41 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3622B83E1E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65808bb859cso9228207a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164619; cv=none;
 d=google.com; s=arc-20240605;
 b=UuGwXwGSSNSHvzcwfdG8FrvMC9BYjBR8575WvLR8fjVYt++Pha3xGAeG8g87I4rLxJ
 WL8LVn5N3SREaPhScJqyO0+YypnpzhuuvaONL1PME2KPrqM4rU5a39B+7EnTV87kfLLM
 mBHWrW/bBhKudVKwVa2HAin9y6DXaVf7VmLwrLBt1pRbea8glWLE9s/5/gGbVoLTIPL9
 cj1AH8h5tXhbDpt+CQBi5weVQYT+0BNUJnrvNzLqaqbqvPDppO6MULdW/vh0UR9UaJ0c
 QM69zqYcMKZ/qICTr9M7Wja7GD3xxmbZTrP3pwOQgEklRrNi8RXr44X5KP8trBxIgHbT
 sIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lp6nVsEy+OfRsj6JJUUib0uGF7JvYlEmEpvHVZTmiMc=;
 fh=bcJ8UPPy/RJul/oAHDGhO8wIbB+cfDqukW6ZaOQSAIM=;
 b=PI4GBtMTovfz1YhT6VFo6WBS5KID12nvfrzAh80Dvy6u11lih9ZVJCu78HY7q+7kj6
 Q4yGHdr6gVC587bZ+Ye8XkRMGrIuGPmdRZf1plwDHUCJjaxexRJnMoEkvywKHnbVHzCh
 Wn47GYANHHJcBVhXwid+pff437jXwlc9j1tYxpxM2CZv9nt8/KHbXFazzKNp3xSjSA+p
 Aa088tbYdkUM5pFGyY6FoKA8VYkh9RWhDpLVY92u9vh42Fg62W48t23xFkzHubegMs4U
 ksUlI/Fj7E2y4awKHl5X7JWI/RaWsY25wzDjaPwE0B615MeOimbSnROHdPmFJj0kdkf9
 XSzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164619; x=1770769419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lp6nVsEy+OfRsj6JJUUib0uGF7JvYlEmEpvHVZTmiMc=;
 b=oeFC/6Fj2vyH8XJzQ7q7s115qS8KMnr688sAmf12J7i78mM9ZhpmEP45Q3wUh4XD2H
 glSGKVhuc2vZMtWhNtC3zwh87vBH+I874eYN0Z2V1P8iSfJXNNKOP1bBG6ri5uuIKB8l
 MG5qsmejfyEExQlOROs+ILsyaPKrdBY2Q0C1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164619; x=1770769419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp6nVsEy+OfRsj6JJUUib0uGF7JvYlEmEpvHVZTmiMc=;
 b=HFfmsnIeO9MkMy/EnzCT/mP1WLyR0+2uGrBx5UA5zHoIgScxCAjJqqqVHB0KPJq2I2
 IH71LpBTwb/DmwFl2VFqZegrnu8maRwDv9BLvK0nSsc+xzkxwIbTKN5U/d/L6iymDO/t
 YPCg8XAzN8+0wDuXgiQ1BsGuog8Yvm5Sh88YIFTmKwCuPC3C/C3atKzP6KDElieGNcTs
 UrK1ZHKVHcvjI1ELcQesXLMCqGb0djtA0OOa9vTwg0YFWKtFdphZ6xVQhiaUJrxDSOXo
 HEZwNoncvEY+xrSag7dyN19rh0tmispsITn7CkmO2W7+UDDT3ypN34CAw/kGMvv2fbfy
 6GEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNbiPAwy0x4j/47B6E8xClxaVMGOmTG6iEp2iNMnu+WXbmbl5lYCeYEll9aHCl/TJf7e6Hjg=@lists.denx.de
X-Gm-Message-State: AOJu0YyOQiD3Jo85PSNUkCvGRdjjY6PIA5BEvaBM5Jw3FxiOwNrO4BEF
 ARfSFf0F5Jpt/A4KbvAhp3XizQK+GMAKgbIg+WfpZrbeDWAs0GwjZP8C5DjOvNb2/ftjZ7DiwG5
 Ai+EyyG+qfO6BDWUefNF8TjUg3Al09xUTmJp+kLo59eNRQ2e1Gs5cNg==
X-Gm-Gg: AZuq6aIBgaePbuUHwbnMUHY1GG55rQCTj+o9s2++j5daOWFtHD7U2Gy6kD/RtwWCWuc
 9AV7xgoc840gyWV08gtV2CT1iIL6mVLyYf3l7D9zVCdpR9L7WKsbb58PsJR55byv3eR/RphUAN0
 jQM9t1RAfVLGyUsKPNpC+TNN64UM6DII3Y6ZmPB+e2c2dfgaoycIlqZhrUaQBMQd5d80qt6Ycgh
 ynTIdW7gcEcf+KOmK+NJ7DsxUURw1sX/6qf7vt8d2TV/39V2IWjbYLlFu7n8HALHUNcjKtU
X-Received: by 2002:a17:907:2d0d:b0:b88:6fd3:d5fc with SMTP id
 a640c23a62f3a-b8ea68e7c36mr10075266b.46.1770164618615; Tue, 03 Feb 2026
 16:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20260117214311.706022-1-linux@fw-web.de>
In-Reply-To: <20260117214311.706022-1-linux@fw-web.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:24 +1300
X-Gm-Features: AZwV_QiOGUFiKuE5FHzVV0dyIP_TQ37D-U55l5H5CuIYXbFqqogA6-JXKfMHoZs
Message-ID: <CAFLszTjBxGvTPbLXUF8tZQJXyrJmsJTbBx6c4-UfQbeqRfdsew@mail.gmail.com>
Subject: Re: [PATCH v3] cmd: mem: add function for getting ram size for use in
 scripts
To: Frank Wunderlich <linux@fw-web.de>
Cc: Tom Rini <trini@konsulko.com>, Frank Wunderlich <frank-w@public-files.de>,
 u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
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

Hi Frank,

On Sun, 18 Jan 2026 at 10:43, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add a command for getting detected ram size with possibility to write
> to environment variable.
>
> example usage:
>
> BPI-R4> msize
> 4294967296
> BPI-R4> msize m
> 4096m
> BPI-R4> msize g
> 4g
> BPI-R4> msize g ramsize
> BPI-R4> printenv ramsize
> ramsize=4
> BPI-R4>
>
> board with 8GB ram:
>
> BPI-R4> msize
> 8589934592
> BPI-R4> msize m
> 8192m
> BPI-R4> msize g
> 8g
> BPI-R4> msize g ramsize
> BPI-R4> printenv ramsize
> ramsize=8
> BPI-R4>
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2: add Kconfig entry
> ---
>  cmd/Kconfig |  5 +++++
>  cmd/mem.c   | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)

Please can you add doc/usage/cmd/ and test/cmd

>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5c611fb3016e..b82b17195b7e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -974,6 +974,11 @@ config CMD_RANDOM
>         help
>           random - fill memory with random data
>
> +config CMD_MEMSIZE
> +       bool "memsize"
> +       help
> +         Get RAM via command for use in scripts.

I suggest a little more info in your help, so it is clear what the
command actually does.

> +
>  config CMD_MEMTEST
>         bool "memtest"
>         help
> diff --git a/cmd/mem.c b/cmd/mem.c
> index d5d7ca2790bd..a067740d81c8 100644
> --- a/cmd/mem.c
> +++ b/cmd/mem.c
> @@ -33,6 +33,7 @@
>  #include <linux/compiler.h>
>  #include <linux/ctype.h>
>  #include <linux/delay.h>
> +#include <linux/sizes.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -711,6 +712,29 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
>  }
>  #endif /* CONFIG_LOOPW */
>
> +#ifdef CONFIG_CMD_MEMSIZE
> +static int do_mem_size(struct cmd_tbl *cmdtp, int flag, int argc,
> +                      char *const argv[])
> +{
> +       u64 memsize = gd->ram_size;
> +
> +       if (argc > 1) {
> +               if (!strcmp(argv[1], "m"))
> +                       memsize = (memsize + SZ_1M - 1) / SZ_1M;
> +               else if (!strcmp(argv[1], "g"))
> +                       memsize = (memsize + SZ_1G - 1) / SZ_1G;

Can you do something like this?

memsize = ALIGN(memsize, SZ_1G)

> +               if (argc > 2)
> +                       env_set_ulong(argv[2], memsize);

Normally U-Boot uses hex, so it would be worth mentioning that this
command doesn't. Or even provide a -d flag to select decimal?

> +               else
> +                       printf("%lld%s\n", memsize, argv[1]);
> +       } else {
> +               printf("%lld\n", memsize);
> +       }
> +
> +       return 0;
> +}
> +#endif /* CONFIG_CMD_MEMSIZE */
> +
>  #ifdef CONFIG_CMD_MEMTEST
>  static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong end_addr,
>                           volatile ulong *dummy)
> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>  );
>  #endif /* CONFIG_LOOPW */
>
> +#ifdef CONFIG_CMD_MEMSIZE
> +U_BOOT_CMD(
> +       msize,  3,      1,      do_mem_size,
> +       "get detected ram size, optional set env variable with value",
> +       "[m, g] [envvar]"
> +);
> +#endif /* CONFIG_CMD_MEMSIZE */
> +
>  #ifdef CONFIG_CMD_MEMTEST
>  U_BOOT_CMD(
>         mtest,  5,      1,      do_mem_mtest,
> --
> 2.43.0
>

Regards,
Simon
