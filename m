Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5923AD2A559
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E0F88DF4;
	Wed, 16 Oct 2024 22:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SbwCrGt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08DE88DE6; Wed, 16 Oct 2024 22:09:26 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFAD88DD1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20ca4877690so8405ad.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729109363; x=1729714163; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59w8wM7GKkf1e6Y4T4xsg8w2LEt9Sw10RK5UQp3fH0M=;
 b=SbwCrGt/FGiC1l19Nts0wR7aSw8XxbyQ5CDeBfQ3adgmnQYcTKCdUYH24n22FTwrSD
 o1KeRZ0By3D6nahlUZFTBrTK2rhXge9eedzwy9DCrYwLmeR4g0c+6Uizhl/m4t7pa+aN
 evcB5Ghc24FKyQIVwRSOdk+b6gyRXAEO4EGoOQXuOl+Qew4SkBfNDbhGVcbHwc+jIEwd
 hpIYwIkLpDBD9wdJJ4balG57EtkFKZ3qjS5Ps/fYWhM41NyQEHORuWcXZtyeK6lbyHXH
 tq2Fr9BU/q5fD779MkEYlr+s4H5fLn9vc4XudwE25H2cPXn//ejTBEa3bW42WzV1yV/s
 2Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729109363; x=1729714163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59w8wM7GKkf1e6Y4T4xsg8w2LEt9Sw10RK5UQp3fH0M=;
 b=vMO7vV/eJY/T4ZqagiNtERZCgGRUsZrRj8kQR+VZsMf3Qq5g7+w9dI3I3e+bfK+iN/
 Wd5CzvHFWFm6HXIgsyoUw7DvdyIgo4PsoagFxFsrIgzK4qhzra9gY39E8ImDOrrjFRK2
 kH6DH4wQc9phU+sqyWCbJ0MnHr7QZY6utVfvJpLsX6qfM5hunZ930WZb9X0Kc2P+r9Li
 pmNqyVR2vnVRduGkiJXZEbiELfzP9e/cdBdZ41iZCnjSDKWQ2CVx2+P9SMO/8AAwS6ns
 1CW+qFYQeXdqYpmq5oMqWJS/X87B8AOKoMy2bbiI5pPlQWb0a3fJn3dv0OKCPWhcdtmL
 ufHA==
X-Gm-Message-State: AOJu0YxSTFiy+LHaiJp3xPK1G2xaOylkk8hmogFdQPdZZ6uu+eMZmeps
 2l/q0rMzM/EhICNunm/kL88ydU0cqheG3KNvZRx0PNMsBtWLvy/yo81G5PnYL/i0pkcNm1pJ+/T
 yed9R6zlTcBIY60lshswaUasSwzMIr49b0EBH8eyMTFW4kSKyhV4U
X-Google-Smtp-Source: AGHT+IECveLuIbfaEsyleV4iSTkHTgwgd/dKZEEBgO/1tkui3hDZzAWy01jwGN7C+/hxz/kAVL13nqss0TBt36/wwP4=
X-Received: by 2002:a17:902:ea0f:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-20d48a8fb15mr756525ad.0.1729109362694; Wed, 16 Oct 2024
 13:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-21-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-21-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Wed, 16 Oct 2024 13:09:10 -0700
Message-ID: <CAFyOScrfp10DiXeOQ8VXafFAdqwf7VNAtngktOC753=o0n1fog@mail.gmail.com>
Subject: Re: [PATCH v9 20/37] arm: gic-v3-its: Implement of_xlate
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Tue, Oct 15, 2024 at 11:15=E2=80=AFPM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Translate IRQs by implementing of_xlate() as required by
> irq_get_by_index() to parse interrupt properties.
>
> Map DT interrupts to ARM GIC interrupts as follows:
>
> - Interrupt numbers ID32-ID1019 are used for SPIs
> - ID0-ID15 are used for SGIs
> - ID16-ID31 are used for PPIs
>
> TEST: Booted on qemu sbsa-ref that has a GICV3.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Reviewed-by: Moritz Fischer <moritzf@google.com>
> ---
> Changelog v9:
> - Require at least 3 interrupt-cells
> - Map SPI interrupts to ID32+
> - Map PPI interrupts to ID16+
> ---
>  arch/arm/lib/gic-v3-its.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> index 22fa46a341..58f8bf864f 100644
> --- a/arch/arm/lib/gic-v3-its.c
> +++ b/arch/arm/lib/gic-v3-its.c
> @@ -4,9 +4,11 @@
>   */
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <irq.h>
>  #include <asm/gic.h>
>  #include <asm/gic-v3.h>
>  #include <asm/io.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <linux/bitops.h>
>  #include <linux/printk.h>
>  #include <linux/sizes.h>
> @@ -163,8 +165,30 @@ static const struct udevice_id gic_v3_ids[] =3D {
>         {}
>  };
>
> +static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_ar=
gs *args)
> +{
> +       if (args->args_count < 3) {
> +               log_debug("Invalid args_count: %d\n", args->args_count);
> +               return -EINVAL;
> +       }
> +
> +       if (args->args[0] =3D=3D GIC_SPI)
> +               irq->id =3D args->args[1] + 32;
> +       else
> +               irq->id =3D args->args[1] + 16;
> +
> +       irq->flags =3D args->args[2];
> +
> +       return 0;
> +}
> +
> +static const struct irq_ops arm_gic_v3_ops =3D {
> +       .of_xlate               =3D  arm_gic_v3_of_xlate,
> +};
> +
>  U_BOOT_DRIVER(arm_gic_v3) =3D {
>         .name           =3D "gic-v3",
>         .id             =3D UCLASS_IRQ,
>         .of_match       =3D gic_v3_ids,
> +       .ops            =3D &arm_gic_v3_ops,
>  };
> --
> 2.46.2
>
