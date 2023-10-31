Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254F2C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E22874C1;
	Tue, 31 Oct 2023 08:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LbetB0ht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E80F874F4; Tue, 31 Oct 2023 08:53:45 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B048870EF
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=merlew4n6@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507c8316abcso7571778e87.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698738822; x=1699343622; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTKtjjBInPfAPD5U5LibVALj9uHOm1wlKanMeYGg8OU=;
 b=LbetB0ht+hJwSw4dFbmvPdo2Zq/MjQWRBiFmIFEYSaN4zvBByaZDu9jqXLrWZP8gQb
 7oOCuMJM0MdS15YsvSBSJB47tY4K9sD8ggY34/m3O8HBYJjLVZsJc2wDtOEzt32Vc2UJ
 w8JMank0Blw1A/RKwlDKcYriOUkXItyaaE9Ww3GyNv6JvL8cNZcqvIO8eVhAt7IfRYPp
 RngpP0ggpullbtPQLX8hxPxFop8MfjBI7fiIIhGSk+3beN+wCl1exhSJHbBFxA2G9iz7
 eqyDq8Jk+0YTkReEqPh9co9CKjvS8OfpAjkhV6hlFsUZ/QLblT1WFrt6sLL2Y6C/L6xI
 NqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698738822; x=1699343622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTKtjjBInPfAPD5U5LibVALj9uHOm1wlKanMeYGg8OU=;
 b=Pbak82JBjJSgEr7kH7ci6SsQa7WxK0HC30KTWal0Ph9HEajqmZhtcdoN39IAmWfTDt
 7GWiudrF5FxJ+GAeJjsiSE5yfKNeJLnjc+GHjH5x1KXVcZmFQgUgEaqSl7uu1fovBwZl
 zzq+mz5ilnNu57Qx6zVRWpqD4MbjA5ZYW9BOM5XNyfhX7yzXph1a1O8yvtwhjw9FEGEg
 GzAalw8uqI2R+xbmMcqunYx6iSrYCy+KDXccySHMFMko3TApPvsysSsr/J8B5zluBVoo
 qi6GFGyyjeLmDPKt7oNTKgvOFyxJFYwFCtyBUtTDsKfkW2n/DeWUEVYWCrmQH8r8tWCB
 v3nQ==
X-Gm-Message-State: AOJu0YxbnrwthSKNoW1nzpwaZ2qTBux1EoEZfdt0iNb0YYlz2FuzF8P0
 xvLZiNrGQ+IfcYGx5k6QRd5mmk1VU9todlwLr1w=
X-Google-Smtp-Source: AGHT+IEWVpgTxtV36LxDsgE/nYgkJ/yZB8riODiaVHZ7bHeXQltOSQ1Lypbs7HC7svATUH3b1mV+hmyqZowXik8zOx8=
X-Received: by 2002:a05:6512:e9c:b0:507:9a13:1fca with SMTP id
 bi28-20020a0565120e9c00b005079a131fcamr11597144lfb.27.1698738821742; Tue, 31
 Oct 2023 00:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
 <20231029084533.44607-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231029084533.44607-2-heinrich.schuchardt@canonical.com>
From: Xiang W <merlew4n6@gmail.com>
Date: Tue, 31 Oct 2023 15:53:29 +0800
Message-ID: <CAJ8bkyx5=CBLkGGDkeWGevJNwffkU7sAady=5q58a+FFErO9jg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] riscv: allow resume after exception
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anup Patel <apatel@ventanamicro.com>, 
 Kautuk Consul <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

setjmp can be called in set_resume.

Regards,
Xiang W

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> =E4=BA=8E2023=E5=B9=
=B410=E6=9C=8829=E6=97=A5=E5=91=A8=E6=97=A5 16:56=E5=86=99=E9=81=93=EF=BC=
=9A
>
> If CSRs like seed are readable by S-mode, may not be determinable by
> S-mode. For safe driver probing allow to resume via a longjmp after an
> exception.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  arch/riscv/lib/interrupts.c | 13 +++++++++++++
>  include/interrupt.h         | 22 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 include/interrupt.h
>
> diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
> index 02dbcfd423..a26ccc721f 100644
> --- a/arch/riscv/lib/interrupts.c
> +++ b/arch/riscv/lib/interrupts.c
> @@ -12,6 +12,7 @@
>  #include <linux/compat.h>
>  #include <efi_loader.h>
>  #include <hang.h>
> +#include <interrupt.h>
>  #include <irq_func.h>
>  #include <asm/global_data.h>
>  #include <asm/ptrace.h>
> @@ -21,6 +22,13 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +static struct resume_data *resume;
> +
> +void set_resume(struct resume_data *data)
> +{
> +       resume =3D data;
> +}
> +
>  static void show_efi_loaded_images(uintptr_t epc)
>  {
>         efi_print_image_infos((void *)epc);
> @@ -105,6 +113,11 @@ static void _exit_trap(ulong code, ulong epc, ulong =
tval, struct pt_regs *regs)
>                 "Store/AMO page fault",
>         };
>
> +       if (resume) {
> +               resume->code =3D code;
> +               longjmp(resume->jump, 1);
> +       }
> +
>         if (code < ARRAY_SIZE(exception_code))
>                 printf("Unhandled exception: %s\n", exception_code[code])=
;
>         else
> diff --git a/include/interrupt.h b/include/interrupt.h
> new file mode 100644
> index 0000000000..1baa60bcf2
> --- /dev/null
> +++ b/include/interrupt.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <asm/setjmp.h>
> +
> +/**
> + * struct resume_data - data for resume after interrupt
> + */
> +struct resume_data {
> +       /** @jump: longjmp buffer */
> +       jmp_buf jump;
> +       /** @code: exception code */
> +       ulong code;
> +};
> +
> +/**
> + * set_resume() - set longjmp buffer for resuming after interrupt
> + *
> + * When resuming the exception code will be returned in @data->code.
> + *
> + * @data:      pointer to structure with longjmp address
> + */
> +void set_resume(struct resume_data *data);
> --
> 2.40.1
>
