Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63449CDE002
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E12FF8496E;
	Thu, 25 Jun 2026 10:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nRk1xxlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7968B84968; Thu, 25 Jun 2026 10:53:08 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252B48496E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-37dfcc2767eso138473a91.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377584; cv=none;
 d=google.com; s=arc-20260327;
 b=G1V3ypbiHPU9k4cbSYMvgNR2i+vooIFm7R11kQk46SnwaxzOCo9jrW0G5H5uWKB6me
 AVvjYvW/bpeN5vheZ+NmTf6ccGFLdh8ukmJ5tCgIjgg6LhLvTEC7Lu7rHp6Cltojf3Vo
 mDhRpOwaBd2v/zaVhcZZPUxPoN9En00jqIytGih32hHQBldiHDYH6x2wgqJWXYnSuqaQ
 TpK8mTkoYWAIWZRSvsgZ36pmy9LU4shcljfYzhQ2+07+pDF5I/lA9F27sMsA9qLXAl6N
 CBb0OaCIip/EybowOAJ/jbOSSIfeYiu8cbQCZszsTvGr8Tj3tqofHNg4sVKvfZt3AH6K
 5Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PL2z4hTo9uvXrNlOztOUYIHsUDOIIpMA7lcDjPC/pQA=;
 fh=wAPxXabsJQrKbjEcipFJBkMrN8qkwa+R8vsEWSaDDcc=;
 b=a+F2UDyabnCt6V+4Pk+B/szLtCfsAtJiLsHc2MmohBmRkTSTFQJE38ktRma2s0fH97
 Mt1RlEqjItzE7Q/QByyW+0EtOVCLVTg82NxUKE+I1qrefEcGQfhFxXKiZ7WGbI8wD6yK
 jdXlA593vK2uPvWXV8T3In5tkKwZ9zjHQDnYaCeaA3fBGLV0pqDPazMAuvyxv2BWhndO
 8RTflylthzKzs+nxxxCKA15NRT4ubkGz6ry04mfHOBz1hcA1yvE45QFYmzYaxPMVuUg9
 msyICJYBYOUU82B0zTwrBS4apsgM94lSAj/YvxZLc0uOvnmWx7zADVuYSmWx+r8XweBd
 1/yA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377584; x=1782982384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PL2z4hTo9uvXrNlOztOUYIHsUDOIIpMA7lcDjPC/pQA=;
 b=nRk1xxloUTl3547l+zZxvvbauShr0Dp0U9AJnNFlNbHwGiloKkenYe7Mv71Z3BVTYk
 oWayriq59sCZ1l3B0LRiGD4HlYNvt+Onab58tK5M59mJcGvLSgqSCgBkve86o7//MA+9
 Y5tta3KCeMwqsD3+KmP+JJvEBB5NJLSNRzmD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377584; x=1782982384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL2z4hTo9uvXrNlOztOUYIHsUDOIIpMA7lcDjPC/pQA=;
 b=O2DgkBGLXhheYHq44wZ2XaOlCBIxHgYpLWTcTmBf7GeSM7BnQ8dos4QeNoZtMm2ydk
 wzvGc1nmDAyEdLGRPX8AE83Vw9KhiaptQTCCTZrlbULXnj1t2iuVn/kZ6vZqWk8iGnci
 Bz0qRwrGfgHiB2l3X2IvLus67vnrHv4mogQ0lt9KEWlPFOXQs6wknW6ZSZqd1meZ/QcO
 hRWHeS4OLXZaAiJtUZYlPpNFOGhHfj5smoBk5SHmUmm6bWNpBn5fHTga/+/3Kqs+hYP9
 ooCl2X+Guuo/ud22aNYkIzxyt+UBZuyKSCOfDzj1dJe6Xp0OVtlm0N9NHgNacMZRcXoS
 b5qA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbFhAw9JcNljlQ0Xh8wSzbnhuy5PhSsK5tZCvCwq34tA5N5CGZ0VyU36yAM5KCQEsETkfQU/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzLQTZrOKsRy916zAXdho9dkhGEK1Pp1hnJAdJMEcvzZiZwdrB7
 1ZPHSX+2nY6oytXYjFC2euMcrqXH03KcoEprINCXU5DZZLBrf606QofhNJ/un/+KnQBnnC6AQiV
 QOWH9SQx4xuo6AX9x/CXN5gwpaRfNu49URnNcQjNL
X-Gm-Gg: AfdE7cnJv67FXthFqaLAXTPjeylNcbIcD8by241G/guknaZOoE6AfdU+dbQFMHOgJU7
 6xacsTiZkm5nhegbVo1IVBKKuud5Td6kP8zUykXptIbviljPZH4DANEGB/MnZ1zz3ap7R0bhnMt
 iv2P0mGEx1sLNszm6iJaXf3a1n+eV41otBgnS4Rcn3RKZxhxqSCoArFrfa0rkYYbkMWm9XXNi8M
 KNHMCzqp7QsQ5p5R7B22mD0Ysb4lxgLe410cjszk1XldVuuZZ2KtJRDTQHiTbartWawKTlt173j
 pALoLdMV
X-Received: by 2002:a17:902:e78d:b0:2bf:13af:b077 with SMTP id
 d9443c01a7336-2c7fcf9ee27mr13942405ad.14.1782377584491; Thu, 25 Jun 2026
 01:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:52:30 +0100
X-Gm-Features: AVVi8Cd5jYpbtRCMJar4dm-szVkDkI0VrguwCw9uWvMxAyDSJohSnajJ49j1rU8
Message-ID: <CAFLszTgXfZ5a3gbZes_aBMAjY4WMCEh9-RwfmnPq9bJCFMfKJQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] efi_loader: add efi_app_common skeleton
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: add efi_app_common skeleton
>
> The EFI dump applications (acpidump, dbginfodump, dtbdump, initrddump,
> smbiosdump) each contain duplicate copies of the same output and
> input helpers, and each has its own command loop. This patch series
> deduplicates that code by introducing a shared module.
>
> Create lib/efi_loader/efi_app_common.c and efi_app_common.h to hold
> utilities shared across the EFI dump applications.
>
> This first patch adds the module skeleton:
>
> * State variables (app_handle, cout, bs, nocolor, systable) owned by
>   the common module.
> * efi_app_init() to initialize them from sys_table and image_handle,
>   including detecting the 'nocolor' load option via get_load_options()
>   and starts_with().
> * Output helpers: print(), printx(), color(), cls(), error().
> * starts_with() - test whether a UTF-16 string begins with a keyword.
> * get_load_options() - retrieve the load options of the loaded image.
> [...]
>
> lib/efi_loader/Makefile         |  13 +++-
>  lib/efi_loader/dbginfodump.c    |  43 +------------
>  lib/efi_loader/dtbdump.c        | 133 ++--------------------------------------
>  lib/efi_loader/efi_app_common.c | 106 ++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  67 ++++++++++++++++++++
>  lib/efi_loader/initrddump.c     | 126 +------------------------------------
>  lib/efi_loader/smbiosdump.c     | 100 +-----------------------------
>  7 files changed, 196 insertions(+), 392 deletions(-)

Great to see this!

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> new file mode 100644
> index 00000000000..e9e9334acc7
> --- /dev/null
> +++ b/lib/efi_loader/efi_app_common.c
> @@ -0,0 +1,106 @@
> +static efi_handle_t app_handle;
> +static struct efi_simple_text_output_protocol *cout;
> +struct efi_boot_services *bs;
> +static bool nocolor;
> +static struct efi_system_table *systable;

Is it intended to have bs as a global? If so, please add a comment and
put it out on its own.

> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> @@ -639,7 +548,7 @@ static void print_property(const unsigned char *val, u32 len)
>               for (int i = 0; i < len; ++i) {
>                       if (i)
>                               print(u" ");
> -                     printx(val[i]);
> +                     printx(val[i], 2);

dtbdump's local printx() took an unsigned char and always printed two
digits; the common helper takes (u64, u32 prec) and the call sites are
silently re-targeted. Behaviour is preserved, but please call the
signature change out in the commit message so a future bisect reader
can spot it.

> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> @@ -310,9 +272,10 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>  {
>       efi_status_t ret;
>
> +     efi_app_init(systab, image_handle);
> +
>       handle = image_handle;
>       systable = systab;
> -     cerr = systable->std_err;
>       cout = systable->con_out;
>       cin = systable->con_in;
>       bs = systable->boottime;

After efi_app_init() runs, every app still re-derives
cout/cin/bs/handle into its own static variabless, it is worth noting
in the commit message that updating the tools use use these comes
later...also that dbginfodump previously had no nocolor handling at
all, so its error() now respects nocolor.

Regards,
Simon
