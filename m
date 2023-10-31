Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F42C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 15:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6328187CAB;
	Tue, 31 Oct 2023 16:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPT7lB9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70CF87CDF; Tue, 31 Oct 2023 16:20:04 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C0686C3B
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 16:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=merlew4n6@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso9544613a12.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698765602; x=1699370402; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6Kj69ZnVdmvWT52vjZYzC6Ny2y7pFBVhydpWQ8h1+8=;
 b=dPT7lB9kj6J0mlVak/6F1JScSj+nwTykR/ExSHf/IlV4FugRP3YyubtmJquGBLTQc8
 sJNyq50P+xb65fI+0UrXT2mtQzT5mUKFbIiEbePyhAW50hePuo7WWquu0APjm9tFbZca
 lbwCYg69XzuLgznDP3mtZiQfqSmxjwX3GZAq1h+9n4Bkx/GiM5RScZw22TA3CG+yauq/
 2EnI55FOm6zRamGEP4EUE/E0HS97y8mCL/B0gCrtwLAT01QugZVTWGWwVLqxjuUOwbQj
 xAHgA0DtcH6iVBj1d6H4DG5mzOhsS+GhHSxgz9iMKSYpkVKqUPgQIW7BJjQURdKdvgBx
 GzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698765602; x=1699370402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6Kj69ZnVdmvWT52vjZYzC6Ny2y7pFBVhydpWQ8h1+8=;
 b=bcJADsn+nTR3z+qCfCX5sZkWiavufXKXSkEFDj8/wOC/brsh/Drqzt3FJkK/upXenR
 NHMCBI0VbzUvmEZYjzTtpQFxZ6sqN2AxeX3i2V9vM/4b4vTfSizlkQofgMF0gEcW8hEz
 AHMTsCcmld8jy1r8HKj11owjI6GBHNwx6RAK/mWN/Yxayh6Q0hUlZsMft/xP/uqOd1S4
 g6UOvMYBl74Qeuf6TL6ns8DlBYW+vqzgWADtAlX1ZO2yS8k8oCEOORvDQ5HrTCB1F2SB
 uPPRr19SjCFeDlIbOTkmqsHyTvhdA9YjnEa8J0eHKfAEmu7yCKB/qAGUMaGoXC/SyUFu
 SQ5A==
X-Gm-Message-State: AOJu0Yzh1s5YZBvVgOideNcPIYfwQ+XDcDl+HoMgcVDl1U3mVjzHmMDy
 rykLk+YgoRD3FTi0joTOaoiia+Z2ipoTzVAmf5IoJFdEOkduuJp3
X-Google-Smtp-Source: AGHT+IF6UUaE3Sgt7dLD2jVV5QFSn6u37G5Wdb2N1khXNGyvOBdvscqdIZFOWpLffe5mDRonMPv8C72LyjAGX4zM1k0=
X-Received: by 2002:a50:a687:0:b0:53e:4a78:e281 with SMTP id
 e7-20020a50a687000000b0053e4a78e281mr9970696edc.27.1698765601872; Tue, 31 Oct
 2023 08:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
 <20231029084533.44607-2-heinrich.schuchardt@canonical.com>
 <CAJ8bkyx5=CBLkGGDkeWGevJNwffkU7sAady=5q58a+FFErO9jg@mail.gmail.com>
 <de0fc9e4-00a2-4069-8017-151d2d348311@canonical.com>
In-Reply-To: <de0fc9e4-00a2-4069-8017-151d2d348311@canonical.com>
From: Xiang W <merlew4n6@gmail.com>
Date: Tue, 31 Oct 2023 23:19:48 +0800
Message-ID: <CAJ8bkyytNLnr6xT=DgSh0T4LENGwc3WHbLVA4gbJ9E67pfyeZg@mail.gmail.com>
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

Thank you, I understand.

Regards,
Xiang W

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> =E4=BA=8E2023=E5=B9=
=B410=E6=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 20:09=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 10/31/23 09:53, Xiang W wrote:
> > setjmp can be called in set_resume.
>
> Unfortunately this is not possible. A longjmp buffer only stores
> register values and not the stack content.
>
> Let's assume that setjmp() is moved into set_resume():
>
> Let a function call set_resume(). The caller's address will be on the
> stack. Once the set_resume returns and the caller invokes another
> function the original stack content will be overwritten. When an
> exception occurs the longjmp will reenter set_resume() with the original
> stack pointer value pointing to a stack that does not match the original
> call to set_resume and set_resume will return to a random address.
>
> Best regards
>
> Heinrich
>
> >
> > Regards,
> > Xiang W
> >
> > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> =E4=BA=8E2023=
=E5=B9=B410=E6=9C=8829=E6=97=A5=E5=91=A8=E6=97=A5 16:56=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >> If CSRs like seed are readable by S-mode, may not be determinable by
> >> S-mode. For safe driver probing allow to resume via a longjmp after an
> >> exception.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v2:
> >>          new patch
> >> ---
> >>   arch/riscv/lib/interrupts.c | 13 +++++++++++++
> >>   include/interrupt.h         | 22 ++++++++++++++++++++++
> >>   2 files changed, 35 insertions(+)
> >>   create mode 100644 include/interrupt.h
> >>
> >> diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
> >> index 02dbcfd423..a26ccc721f 100644
> >> --- a/arch/riscv/lib/interrupts.c
> >> +++ b/arch/riscv/lib/interrupts.c
> >> @@ -12,6 +12,7 @@
> >>   #include <linux/compat.h>
> >>   #include <efi_loader.h>
> >>   #include <hang.h>
> >> +#include <interrupt.h>
> >>   #include <irq_func.h>
> >>   #include <asm/global_data.h>
> >>   #include <asm/ptrace.h>
> >> @@ -21,6 +22,13 @@
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >> +static struct resume_data *resume;
> >> +
> >> +void set_resume(struct resume_data *data)
> >> +{
> >> +       resume =3D data;
> >> +}
> >> +
> >>   static void show_efi_loaded_images(uintptr_t epc)
> >>   {
> >>          efi_print_image_infos((void *)epc);
> >> @@ -105,6 +113,11 @@ static void _exit_trap(ulong code, ulong epc, ulo=
ng tval, struct pt_regs *regs)
> >>                  "Store/AMO page fault",
> >>          };
> >>
> >> +       if (resume) {
> >> +               resume->code =3D code;
> >> +               longjmp(resume->jump, 1);
> >> +       }
> >> +
> >>          if (code < ARRAY_SIZE(exception_code))
> >>                  printf("Unhandled exception: %s\n", exception_code[co=
de]);
> >>          else
> >> diff --git a/include/interrupt.h b/include/interrupt.h
> >> new file mode 100644
> >> index 0000000000..1baa60bcf2
> >> --- /dev/null
> >> +++ b/include/interrupt.h
> >> @@ -0,0 +1,22 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +
> >> +#include <asm/setjmp.h>
> >> +
> >> +/**
> >> + * struct resume_data - data for resume after interrupt
> >> + */
> >> +struct resume_data {
> >> +       /** @jump: longjmp buffer */
> >> +       jmp_buf jump;
> >> +       /** @code: exception code */
> >> +       ulong code;
> >> +};
> >> +
> >> +/**
> >> + * set_resume() - set longjmp buffer for resuming after interrupt
> >> + *
> >> + * When resuming the exception code will be returned in @data->code.
> >> + *
> >> + * @data:      pointer to structure with longjmp address
> >> + */
> >> +void set_resume(struct resume_data *data);
> >> --
> >> 2.40.1
> >>
>
