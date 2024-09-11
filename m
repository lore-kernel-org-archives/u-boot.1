Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D89EE4995
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D62B89279;
	Wed, 11 Sep 2024 13:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BFgmCvt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCFD8927F; Wed, 11 Sep 2024 13:20:22 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE5689224
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3770320574aso4184906f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726053619; x=1726658419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p6j7HATtb3Kfk0ZOH9dGocQd5IRaoPV6qdyuHtRq17g=;
 b=BFgmCvt/gH7y4TrqbZ21O/KAq/eJbQ1wsIHGkEM5eVvWEicm6TrziPMRhGsIVmTyxs
 T0e/EU/qSPjCl6ue9jHMtORBjfYv4RY9lB/hM9IcK3SCn7Oe1K2+FOZPXFPTlq3vBa6e
 7w8bQv9xWxSUYTh2+u4up91XaHizwPFj7Tpiw88sbJY7JRp6Z166bvI3Js5+zP9WQVhr
 MSLkkmR4c6X8rbkUsct0R4cJHyh4LWPImr0T5rS2nE63YB04Isf5FxxZ8bi+PJiQZKu7
 BfcCQQkWERHWcAspyq9QAYbWvKae2bsx8bxLVszCmHEqZBbyPV3+LqtFohYRiYzc8Sau
 OWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726053619; x=1726658419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6j7HATtb3Kfk0ZOH9dGocQd5IRaoPV6qdyuHtRq17g=;
 b=oZ3LT88Tq5klgNZJj7ZbMHkYdV2Y6PmNNw0/+EGf/nK71bANH2G9WZ5/eI74msfokU
 uZyD1qAMOU0xZ5BqcAqGgtTOawy5JZPhrrZY1dplFVy6lD+vmIBTnw23nQZhQ6VImG0J
 gEAqJs6JQCPK9ejhd6kI42FvnXuWufkPKfMLvEYgkHywNSGzBJTyfdEUKuNG9vPCNJnq
 HHrhn17ixMl8pOM91oYp3IEwT55P6bwz3AD3+CMzgtrpXiBQT7s30n4BV5AEcZPGSlJw
 fw2dHlUc2FEgkdQ8QUC0InNw2wcICxo/dDYqJoHwazih/Nrn6YyxtR873Q8nbajQH4EL
 Mhqg==
X-Gm-Message-State: AOJu0YxEwu4ESjTqVbe67IbZifEppj67E7k74pV1Nwk0hi+yUsvW6AvL
 LNbEEItFbtjbDBHtO6Mwc/1n3JW1LfMKYb6CPPLnb/HyvrNENnyciHMDMkk/Ilk6t3aCstzyKo+
 gUfaBsUYxueq4FcRymCkie0wG2o75PcEptwgoSA==
X-Google-Smtp-Source: AGHT+IE63WAF+t55ZwIFGgaxbBEF8Skd4DZZHcUiYxmpQ4Si9dXnsAJjCwsKVkRhHwpFsuouzfXmbqSD3HA4EEyyZTU=
X-Received: by 2002:adf:f345:0:b0:374:bf1b:1c20 with SMTP id
 ffacd0b85a97d-378895d5070mr10794230f8f.23.1726053619342; Wed, 11 Sep 2024
 04:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240910154344.1837906-2-prasad.kummari@amd.com>
In-Reply-To: <20240910154344.1837906-2-prasad.kummari@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 11 Sep 2024 16:50:07 +0530
Message-ID: <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
Subject: Re: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
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

On Tue, 10 Sept 2024 at 21:14, Prasad Kummari <prasad.kummari@amd.com> wrote:
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
> Changes in V3:
> - Removed lmb_init_and_reserve() as part of latest LMB series.
> - Error message moved to one place.
> - lmb_alloc_addr() is not required because the given memory address is
>   being checked to ensure it is free or not.
>
> Changes in V2:
> - Rebased the code changes on top of the next branch.
>
> UT:
> Tested on Versal NET board
>
> Versal NET> fdt print /reserved-memory
> reserved-memory {
>         ranges;
>         #size-cells = <0x00000002>;
>         #address-cells = <0x00000002>;
>         tf-a {
>                 reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
>                 no-map;
>         };
> };
> Versal NET> sf read 0x70000000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
>
> Versal NET> sf write 0x70000000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
>
> relocaddr   = 0x000000007febc000
>
> Versal NET> sf read 0x000000007febc000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
>
> Versal NET> sf write 0x000000007febc000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
>
>  cmd/sf.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/sf.c b/cmd/sf.c
> index f43a2e08b3..7bb8bcfce2 100644
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
> @@ -272,6 +273,31 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
>         return 0;
>  }
>
> +#ifdef CONFIG_LMB
> +static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
> +{
> +       phys_size_t max_size;
> +       ulong end_addr;
> +
> +       lmb_dump_all();
> +
> +       max_size = lmb_get_free_size(start_addr);
> +       if (!max_size) {
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       end_addr = start_addr + max_size;
> +       if (!end_addr)
> +               end_addr = ULONG_MAX;
> +
> +       if ((start_addr + len) > end_addr) {
> +               return CMD_RET_FAILURE;
> +       }

This is one way to get the load address, yes. But please do note that
with this method, if the region of memory has already been marked as
reserved, the call to lmb_get_free_size() will fail, i.e. return a
value of 0. Whereas if you call lmb_alloc_addr(), and if the memory
region is marked reserved with the flags set to LMB_NONE, that call
will not fail, as we can re-reserve memory marked as LMB_NONE. Hence a
better approach would be to use the logic used in the fs module
function that I had pointed to in my earlier email.

Also, like I mentioned earlier, it will be better to refactor the
functionality, especially if the plan is to introduce this check for
loading stuff through other interfaces like nand, mmc etc. You can add
a function in the lmb.c like lmb_read_check() which does that.

-sughosh

> +
> +       return 0;
> +}
> +#endif
> +
>  static int do_spi_flash_read_write(int argc, char *const argv[])
>  {
>         unsigned long addr;
> @@ -315,7 +341,15 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
>                 ret = spi_flash_update(flash, offset, len, buf);
>         } else if (strncmp(argv[0], "read", 4) == 0 ||
>                         strncmp(argv[0], "write", 5) == 0) {
> -               int read;
> +               int read, ret;
> +
> +#ifdef CONFIG_LMB
> +               ret = do_spi_read_lmb_check(addr, len);
> +               if (ret) {
> +                       printf("ERROR: trying to overwrite reserved memory...\n");
> +                       return ret;
> +               }
> +#endif
>
>                 read = strncmp(argv[0], "read", 4) == 0;
>                 if (read)
> --
> 2.25.1
>
