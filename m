Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8007CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1708460E;
	Wed, 24 Jun 2026 16:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i/HGDVJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5C4847C3; Wed, 24 Jun 2026 16:45:57 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0741A80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664346e66daso646549d50.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 07:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782312354; cv=none;
 d=google.com; s=arc-20240605;
 b=CzgLioz//XeQ3Wwb/aKqAPlDfGfEY8kGJpntLU3k0YFmED01jYzZ8Qz4nnw2sD6pMA
 uhl9BFDEuaMsrANH2JZ1tuoFIMPixZW3vvlocDbwmPnFpelvlILadC49XpbkVYagqfDV
 9lr/3fguK9gihQGiQK/5GspWJd6yo+2w+8K1U1eGX2Wy1uB9VcI859uzPMv8gPHKiq5E
 GQrkrmm9q5j5E1FV7EORvrTX7pSJ9NY4xy2Zoozbwo+Fsog/tcxMZ3O3caUlVDVouA7K
 dhQtbOesgM4q7yKN150QNwpJBfbeyYPU9A+OZPu43hYeP05UbjdJs/kxq8eS4ZO1CsgB
 pybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OCzSvwaGXMydlrsrLqzqhQ1umkMMGkeCGf7gPFTvlGw=;
 fh=Wj0+F2iHUAGVlbRmGHl1FASXTe9L+x7n+R9LhGxDZV0=;
 b=jhfTTMY7BqGuvhSUyJ2ECBISD4Xoq3t80dWfo+P+1B+6zNDfo0byaPJcxDnaakYIxq
 4jp6QkUTDG13Y9hQRaDPOFRFOrf2pJKIlAwlRuIOlFRjFRy4AFS1gfNvIkJ9mVUqCq8i
 R1V+F+4047aybhQh727+s4b96v0N1AXOEU1WczB3cB+yK8eI2K6lUBiIEMOxWZMP19Pf
 4KG3BFGv10scSVzMShJ4V3J+AstiLpOqGJMs22avVC0VX2s/S4n0nUgEw5LgdcaZWktd
 vWtEhm+QQv3xaAdGTXysYlSHQTV+MYxvbx2RsVVhEbDPE2m21DhSrlwVwoBGTKpz8c4E
 B0AA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782312354; x=1782917154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OCzSvwaGXMydlrsrLqzqhQ1umkMMGkeCGf7gPFTvlGw=;
 b=i/HGDVJcwt/Ei0kcMHqtWQ74CXY0W8AFW5amNm+QVnpVmgz5l4mdKEoi6tVaTu/nGX
 4R7HpeUMdjXHgUkcH5S5QIqUedZvWnaVhfLQ71clrFFoalcRzx71UXYJqFYgHB+xPQP2
 aYaq0mAbXNYjCD/z0CqxtaYlnpNTy3GPtQhEK3XypmAniZefiTrOT6ijoInjDo0u7jdT
 TyYaGocGNAEekGmTTjphJ2J0x0nh8SfNeZeAI5h16XKqWzHv/Wnoh0r/Nr9pfRdoTJKp
 lqFMc4GVeG4qeKFfT0YQfjV0JW7QtT8wI4rb3ScaNw/n/e8Tw4r6yOo1POBKJnkQnCxA
 aczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782312354; x=1782917154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCzSvwaGXMydlrsrLqzqhQ1umkMMGkeCGf7gPFTvlGw=;
 b=j6fUEa7uPPbj7y9DdWbqOg1TxTbZEDco+fAmzAX04QfcOkWXam9sf1QzR8WoLBL0yr
 J9ri6K5ugpl+7evOgHJpWHek3ki2FrcoEmZzikewEUC+O8kB+pnbt4ING0O+RN6GBlgf
 ClzD7S2JXf1BBaZlQ/0dDdSpQvmkvAiWC4u9bySIfJw3TcCy9o/x57fn5g5iQTyuAwW/
 DMRj0CNx/KIrUYBJ6TEroycCPlSxtZ21G+4HXeQMlOqK90uiwN/8wM8iRtd3hMnvUAAM
 VCKPKBq7E1+dA1z7SNmUohz+ashYqqi3heBrZyWRKyANqYRq9TK63EkWNoYhvG1i3r8/
 1i7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpa5dWOZEtOHxPZbVtpdy5oYFhSYnhDlS277t/bte0aferbGVWaBRpnfI2k0+SlD/xYt5zcz4s=@lists.denx.de
X-Gm-Message-State: AOJu0YxpX8kaUjzkXWkAGKqK4B8KfCuAUnbQjc9k0tdw3JGjsKZm7qlJ
 r5cQJaAh/Mm/icOqlyCTiTtMebxltZ3M7xPT/Scf8pMuapxQoOQ1sP/uBmjezwjyeMmTUK9LpEn
 TiRibqpFlOI8Ods+UQEYJxNHdwQMSbkxjK4r9+XQVHg==
X-Gm-Gg: AfdE7clVkG0EDmBfUemPYO/MmZCigFLPoeH10W1K/2Uqnt/E4mHPoD77OV/Sw9IVuns
 WQsa7vexl5KlPINAFcDaAqP8LhCI/WDpadCPDUhRSJfXGisXOGWn/7Zl12YE1UqNwh9V7YR5AuD
 BNN3iBTybFMERXy1eRxf1MWtru6MH5g1x5Omck6ScswrCfrxVR5+xcg8xi+xsAcP2/xLFJquah+
 whW8V0WjCYSTSrsFysnqjXdqDG9jsZfx/VLGROg2PkUzYLLLB4bb/3Acj1guyqC+YGsACfwFmmz
 HMtvLEVvrSt6z9KrJrWhREu4uX7CzgmbrtyKoBGL3Zc+hhVHZ1ngEuzXNnDZup1VZJCcauOjiWx
 YQqtIWRnOQOhBG4m91d5vphB4upPtBam7s/ppVF4mSoE4YZyKYGfutU6qbkdUWFJMnrvrRdRhiM
 ePkCtvUeYoXmR6EMMzA4hVo6Ir7Ic3alA8T5zvd1QqiLgjifRDXtfCSCH5Daw9OCLwWDvRzm69Q
 K9ZK6BExVgS2UiwsrCayKyx/oR5IfwLIA09/WJe+nmdGsJXyGA/SpVybiwBI0wqceKzOubUzkhE
 T2AlKrdmuWan+my7yNCLkTwn56k/3IPDDZ5OaM6JuNkyMR0rvGSo4otmIYGlyzhEanyqnsrZuz/
 j6wRojg==
X-Received: by 2002:a05:690e:b88:b0:660:8e61:1a60 with SMTP id
 956f58d0204a3-6636e45dd15mr3188583d50.14.1782312353634; Wed, 24 Jun 2026
 07:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260624054819.493294-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260624054819.493294-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jun 2026 17:45:17 +0300
X-Gm-Features: AVVi8CcprfQp6saOxE8OP6-_7P5hi1dNaot_oIRGuGSmFtQM9V_kKalFfz01X0M
Message-ID: <CAC_iWj+DiO65LsXMXAXXoAvvcVdpYFgGSYa_xf++vdb_pgS3kw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix building with
 CONFIG_EFI_VARIABLES_PRESEED=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Jon Mason <jon.mason@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich


On Wed, 24 Jun 2026 at 08:48, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Since commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> out-of-tree builds with CONFIG_EFI_VARIABLES_PRESEED=y fail with errors
> like:
>
>     ../lib/efi_loader/efi_var_seed.S:14: Error: file not found:
>     ubootefi.var
>
> For out-of-tree build we cannot use CONFIG_EFI_VAR_SEED_FILE in the
> .incbin statement of file efi_var_seed.S.
>
> * We have to prepend $(srctree) if the path is relative.
> * We must not prepend $(srctree) if the path is absolute.
>
> Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> Reported-by: Jon Mason <jon.mason@arm.com>
> Closes:
> https://lore.kernel.org/u-boot/CAPoiz9zg4OXgHo5J3WtJHKOEuWOdCDrugWfAt6Z+d71j=+q8oA@mail.gmail.com/T/#mffaca10a9e812d03eceafad59999a02e57258b9a
> Signed-off-by
> <https://lore.kernel.org/u-boot/CAPoiz9zg4OXgHo5J3WtJHKOEuWOdCDrugWfAt6Z+d71j=+q8oA@mail.gmail.com/T/#mffaca10a9e812d03eceafad59999a02e57258b9aSigned-off-by>:
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Makefile       | 7 +++++--
>  lib/efi_loader/efi_var_seed.S | 4 +---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index d73ad43951b..567db518a8f 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -74,8 +74,11 @@ obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) += efi_signature.o
>  obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
>  obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
>
> -EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> -$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> +TMP_VAR_SEED := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> +EFI_VAR_SEED_FILE := $(if $(filter /% ,$(TMP_VAR_SEED)) \
>

Nit, but the whitespace after /% is harmless, but not needed

In any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

+  ,$(TMP_VAR_SEED),$(srctree)/$(TMP_VAR_SEED))
> +AFLAGS_efi_var_seed.o := -DEFI_VAR_SEED_FILE=\"$(EFI_VAR_SEED_FILE)\"
> +$(obj)/efi_var_seed.o: $(EFI_VAR_SEED_FILE)
>
>  ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
>  capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
> diff --git a/lib/efi_loader/efi_var_seed.S b/lib/efi_loader/efi_var_seed.S
> index e0a40cf46c8..008a505d19e 100644
> --- a/lib/efi_loader/efi_var_seed.S
> +++ b/lib/efi_loader/efi_var_seed.S
> @@ -5,13 +5,11 @@
>   * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
>   */
>
> -#include <config.h>
> -
>  .section .rodata.efi_seed.init,"a"
>  .balign 16
>  .global __efi_var_file_begin
>  __efi_var_file_begin:
> -.incbin CONFIG_EFI_VAR_SEED_FILE
> +.incbin EFI_VAR_SEED_FILE
>  .global __efi_var_file_end
>  __efi_var_file_end:
>  .balign 16
> --
> 2.53.0
>
>
