Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A096C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F320884A5D;
	Thu,  2 Jul 2026 12:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kbgjtO36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8424084A5F; Thu,  2 Jul 2026 12:27:55 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E65984A47
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-697edb1bf6eso2387969a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988073; cv=none;
 d=google.com; s=arc-20260327;
 b=EmaqA/u5ogM+FSo04tutpc8UisI/TkBUhJD/kEoSXJojXvf12Zcgyvnmzgv2L9s1uG
 WLe+ebFK5Tg3rtJmnpj3QwFmxY+vy+JuzgktsL7wjrfw5RfYcTYNXaMTmIknD1ViVMCq
 YfDFNj9etcSTRGzwPcDSLmFyoVBNr7BKzH/dcCquzY1MlLdoxglO4LfkO3iudODcgBE2
 ACmQTMAUCJM/PSH7PQoHEcXraAn5pwGng44ib3SnYhMRNiN5k6eF6gvaFEDIwZMI2mfr
 oLkQQk2TBvZ7rniarrsCGbJiKDI0XAGAEPA7dHZ1+xBv9A0QYk69PNAG8Sx4nnB8anNY
 3JGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gr042asEbwZSaltYg3/gkRiuSMBdSJm87DHMNC8fLnc=;
 fh=Im1E0P9sJHZaAZL4XXnPU4JDGJewawe01R1mHC4sK/Y=;
 b=RBVhuWHa4YoBxRhbKArp274mtZNw+anoAP/7IY9QCdrMOOlExOXMISTwrvrUqogxly
 AhO6utnnBLaZIjOmSJknvowsLP4KmYdtiN/zKLdM1NVOhYgvuBoWLnr/a959aRX0TSbP
 sKsOn5LRY/UkRANQKIQaCWuuxDTbSHS3TvzrxzDX6t/PrprnoQccd1QVb81NViIt7Clb
 ZswJCUqsuc9gshJhTpcrlZOrJiataNtMvC6nGGEVORxifaGHoiBWQF6USFysvFi4fMQm
 3rVe1H6WowCQuM1owlDiFEQskMYxxxzORthmDWUI2tmo8nUlxfO1R86iMlFiJTkiqhcl
 /EQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988073; x=1783592873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gr042asEbwZSaltYg3/gkRiuSMBdSJm87DHMNC8fLnc=;
 b=kbgjtO36zb5reHi+/9WRdKOFPyjGNC1t5/9l8gdR/fFNkm1lXUChy4tcGwi+r379Il
 7PSFNW5izD0369ICEiZoDu5GAR7lzHHAs0XvbGje4pg0tUtVN3EzBatcVN7OokA+xMwk
 39uOya516P5cyUC2EdEwr3Iu1CVQTx2irvfZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988073; x=1783592873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gr042asEbwZSaltYg3/gkRiuSMBdSJm87DHMNC8fLnc=;
 b=GY73Qd7n/ORA/VyooTtuvqHLMNIYuf+UJTo+kgkbqM81x4xFYMHUBvAP+f1T2IVfej
 mv9kYDEDZc/1ZnqGwcnqrRd0DGn/GCWAu/PLK3UMTrXHj/2a3MlUlSxPy4R2s2BvVnaM
 kAt825AvGSQBSt9gR8vmixI2rczZJNmapYp+VXel0ofadKwP3/We5LF4k8qMKRDBMnuL
 2YrafZYVxskcE4h0V7Q05QfXK+DU3dUb5EYplc2JObJToeOyQ5Dy3ojFeMlRGwlFZ3zz
 FVF0w3KZ6S/S67NziXaHXZREC0lDP3r66qM45EK56FM+pHkNl9O/vTtcQzUqpXpaDPi5
 DhQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmeyPixCg02BQKIiq8+r6WM3h23nmwglxFVrAFM+fmAwLQ4NUQ06SujPxeIYknoRRTpb3rtU0=@lists.denx.de
X-Gm-Message-State: AOJu0YyMjy3J7v3tdnjWnEhA3qeSv+nH+TBjXdwcx1FH0RV3F2BqjyCw
 /6GQx5TVrBmMLkcL7IwbVDNhh8WpzemJ4giMGkbIerZMFdakMs+87H16AlipR8Ws7+fQX5fAJ8f
 qe7GCVZZyzTv7Jby8ogrltA4nPJJY0v/JF3WzVXjm
X-Gm-Gg: AfdE7cmUaHm9lTEA1Zb8GAcaw73TwNMMoyVk7pzTIfe1nC277tWcJs3uPKngiTMrLDc
 yl1yk+WTAGekmXrEKzWaa3Cn46XImQ5x6aTlSO+wSmIFrXtkJ2ECFsRoM8+I7pcD6NJvX7d3iel
 LaAjIk4AY/VCFy3LVEhTGke93I+l8IzG5nrnQhSqDt9Cg2wXAzbCDeE1iFjYbZ5q8su/lOSxBBz
 RpJq1C2ibx8pL7At5Q6EUAARBT3nQ4F2MtaNz20wnGlsa0kroaerf01rBr23+rDwypsGoCg6Q==
X-Received: by 2002:a05:6402:1ed3:b0:698:48c4:361c with SMTP id
 4fb4d7f45d1cf-6989f37103fmr2772950a12.28.1782988072993; Thu, 02 Jul 2026
 03:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-16-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-16-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:27:36 +0100
X-Gm-Features: AVVi8Ce_5L9KlwbjE712tEoz4IOKCGQ9RQHWiNHgKSCvltLUOhAPvhJp8mZyUl0
Message-ID: <CAFLszTihFKatBwxu6YeQDJZvXcbp6_s07Xtgb5STPREGU8K8LA@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] efi: LoongArch: Define LoongArch bits everywhere
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> efi: LoongArch: Define LoongArch bits everywhere
>
> They are all coming from UEFI specification, PE-COFF specification,
> or IANA websites.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> include/asm-generic/pe.h                          | 2 ++
>  include/config_distro_bootcmd.h                   | 5 +++++
>  include/pe.h                                      | 1 +
>  lib/efi_loader/efi_helper.c                       | 4 ++++
>  lib/efi_loader/efi_image_loader.c                 | 7 +++++++
>  lib/efi_loader/efi_runtime.c                      | 4 ++++
>  lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
>  7 files changed, 26 insertions(+)

> They are all coming from UEFI specification, PE-COFF specification,
> or IANA websites.

Please expand this to say what is actually added (PE machine types,
relocation type, PXE arch number, BOOTEFI filename, R_LARCH_RELATIVE
runtime reloc, selftest trap instruction) - 'bits everywhere' is
hard to grep for later.

> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
> @@ -371,6 +373,9 @@
> +#elif defined(CONFIG_ARCH_LA64) || (defined(__loongarch__) && __loongarch_grlen == 64))

Unbalanced parentheses - one extra ')' at the end.

> diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> @@ -35,6 +35,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> +#elif defined(CONFIG_LOONGARCH)
> +     /* ud 31 */
> +     asm volatile (".word 0x386007ff\n");

The rest of the series keys off CONFIG_ARCH_LA64. Please pick one
and use it consistently - otherwise a future LA32 build will
trigger this ud but be missing all the other bits. Given Tom's
suggestion on patch 6 to move to CONFIG_LOONGARCH, that is probably
the way to unify it.

> diff --git a/include/pe.h b/include/pe.h
> @@ -194,6 +194,7 @@ typedef struct _IMAGE_RELOCATION
> +#define IMAGE_REL_BASED_LOONGARCH64_MARK_LA  8 /* yes, 8 too */

The PE-COFF spec also defines IMAGE_REL_BASED_LOONGARCH32_MARK_LA
(=8). Since __loongarch_grlen == 32 is handled in efi_image_loader.c
below, it would be tidier to add both here even if only the 64-bit
one is wired up today.

Regards,
Simon
