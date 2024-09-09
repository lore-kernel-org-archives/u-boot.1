Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021F5ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410EF88D89;
	Mon,  9 Sep 2024 12:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eICoX1Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072F888D8B; Mon,  9 Sep 2024 12:18:36 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A0F88C70
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75c205e4aso20006531fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877113; x=1726481913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xmvneDKMgIMEbhYl2LS2hHWxTNf21rvDk234XhyPx8Q=;
 b=eICoX1RuzZY80cpytKgHMw7PfXJDzcFSNb1w64rsAPS22wTtbwLPRt1NIQ20sP4Zoa
 0wYTWWVJUF4ie9KIU9fD4G+GFSLSGJ3hsOr1tw8wmBGtw5f5JjIPBq/8qqkFb3forKyD
 ehDFXNsUiLf2+YVs8ACsEMCfrdU955dQ3KhFRi0FpkDGwBn58SYx2Y+724Hmtmwj5BiI
 g9zJa76pe00FM7CyudTKbK/6VKtsE0LXjR9Q+z53jBHBiriIb2DpqmElh1ExtsZ3qi5A
 IA9BBOzFo1ztBnIo8bWzvWVRakJf4j2fcW5bHltn5enle6Gjr02o1hT9Zr7M8C40vlaq
 KpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877113; x=1726481913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmvneDKMgIMEbhYl2LS2hHWxTNf21rvDk234XhyPx8Q=;
 b=dU3+1ZJ45wNy741tkayO+Tw7iEg+DrkUf7qZs1u4EpxK5wVsxNWUNzl8c7w9QQqNpS
 /8Z1Q7KGens1D7MihEGn+egMfLnKdt5u9BgN1DcVtHrlCQkfdRK6Yy96BhaEF8JD7Syw
 eXgZ02OpyXwGTcKb+WAwtoqT6scmW1zHs6aih7qfNeD0nTD+M65r6GL21i1ffMULsWVY
 BFwEReG4dkuAWIfhTYqMYQJs/VLmncuqX3hdTv/Ps8/C0/GOJ/E2YR7WRzAYSCV2gohQ
 zPqxE+NGhHaRN7+OXa9pmwQ6Rv3dPVHRLdexnXcLHngGdg94Ot2K5u53IujgS8LT/qUY
 MzgQ==
X-Gm-Message-State: AOJu0YzIldI2935X/Cd7wBDZUCx7TS+i9BiPskTMOE1OCjSUVneln28Z
 RK6B8Ux8X3Wqj1EDG9onL2HkAGZ1AfanZ0WItm07iK9pfkWBHm07fekKcUHIHQrbLoi94x0V51M
 GG63FNYyqyLzFqqu4MJJ9KR4IvjKyOkOQAkTslQ==
X-Google-Smtp-Source: AGHT+IHPqiY1ZHdCIgsL/rR5UJXMX01P8zPqDCZIckDiQidW+Csi7rHGgVNGwTxM8eQfuUjrdSiNi6DYQnJFwjQBua4=
X-Received: by 2002:a2e:be1a:0:b0:2f7:6194:b716 with SMTP id
 38308e7fff4ca-2f76194b7fcmr34336211fa.5.1725877112895; Mon, 09 Sep 2024
 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240909094509.1481038-1-prasad.kummari@amd.com>
In-Reply-To: <20240909094509.1481038-1-prasad.kummari@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Sep 2024 15:48:21 +0530
Message-ID: <CADg8p96yfYx3GMgqHyS5d+=2cOhjGdk56AgAkMLtHvYat=FkrQ@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: sf: prevent overwriting the reserved memory
To: Prasad Kummari <prasad.kummari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com, 
 venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com, 
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
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

On Mon, 9 Sept 2024 at 15:15, Prasad Kummari <prasad.kummari@amd.com> wrote:
>
> Added LMB API to prevent SF command from overwriting reserved
> memory areas. The current SPI code does not use LMB APIs for
> loading data into memory addresses. To resolve this, LMB APIs
> were added to check the load address of an SF command and ensure it
> does not overwrite reserved memory addresses. Similar checks are
> used in TFTP, serial load, and boot code to prevent overwriting
> reserved memory.
>
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>
> Changes in V2:
> - Rebased the code changes on top of the next branch.
>
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

Are you sure this has been rebased and tested on top of the next
branch. The lmb_init_and_reserve() function has been removed as part
of the LMB rework series. And the other API's are incorrect. Also,
please check the fs_read_lmb_check() function to see how this is to be
implemented. There is a call to the lmb_alloc_addr() function which
seems to be missing here. And lastly, it would help if we can refactor
this code so that all modules can reuse it. Thanks.

-sughosh

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
