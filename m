Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F94CFC505
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 01:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E6C890D4;
	Tue, 15 Oct 2024 03:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LC7EOL6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B8289159; Tue, 15 Oct 2024 03:30:32 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA3388D72
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 03:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20ca4877690so342755ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728955828; x=1729560628; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vllfM8E6Kaxnzbc0Hltfi8CdZgVV51rRD9kikxKKQY4=;
 b=LC7EOL6ET10pvclkOENZ9b7fpGqhXQCjdseSl/x+S5ovWMKWgTGd6OZ/Im7fKl9Z0Q
 qEGBZ7xtX99Rc9sy+5OVl/MhjVit9rk8l7J6l3NrItHVlHPPSD8QgjmBfiCEJZyqekr9
 EpfVt8h+JzSkZlXTxyb6sysGyFy6Eq7vPvwBwbVkBA8PqAt1mpFePvJPOlRVwbN8rNB1
 gPGS9a4okqjEWDUKMJLMtnh3yh3GvHc6rotX1LsktexH3/ouyKR/ZAfum9kYyBrjtHQ+
 J4HkCQnWWBVfQ9ZPIMLiF5ASpZtSQlCtYeROnl7tHAyU/JXA7X9LR2I79zKiI2xQhfVg
 KFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728955828; x=1729560628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vllfM8E6Kaxnzbc0Hltfi8CdZgVV51rRD9kikxKKQY4=;
 b=H0R0jNrHWM7kG6uBut3kfeWBIPBL3rRlgsBf+N0RXzk0au+N/5qv2HQqxn3lw5sZ/9
 oyVgp6GqxyhydmAQCe0ojJh8W/oFdxAKgJMMNS6J0eeabMHtnwh/fbzN2I+ygUhFX3is
 cK7CXRej4koOHIRYaR9sJBWExyZSX3cyWXo/26yIWEOYBHSdfhDs7nDiKjhPJ17JqaPv
 TAjfur9oLduWoenQouDdVlzvmZwKI9okae8K8mauqdJ5WbCPfcbZYeCivKxgziHRJ8HF
 t71b+50AK+NtYysfiAaXJpBydYzJBSBoHDlHLp76OXhqpfrGxAweXxQO+mvkEHBstNNQ
 iQOA==
X-Gm-Message-State: AOJu0Yz64J7RLRJgNRgZBC4AvEqGL4x8M9fugIacwJx5Br0JZXSUNhPp
 0vcdl4rT7zAD596pwP+Co8ecujONkeXWEFKwFAb9gS+dRjIIG4TL/G8ImN/lDF2N8Zt2O8lLjR8
 Ci0CpqqRBbaTTgLLal56DpjEREhuF0grs2khy
X-Google-Smtp-Source: AGHT+IFU7pGtg85AePAf0ggbcCTYZlKyfJFrLZ4ew2mefVyAZkTBLCqqzW0uRpPZncz104HMEjoT6iwzqj2dZMIMsE8=
X-Received: by 2002:a17:902:e5c2:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20cbce22417mr5279405ad.10.1728955827897; Mon, 14 Oct 2024
 18:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-21-patrick.rudolph@9elements.com>
In-Reply-To: <20241014131152.267405-21-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Mon, 14 Oct 2024 18:30:14 -0700
Message-ID: <CAFyOScrFmRQ2LeCC3MRDE1M4cbAvbjoyE-b97gjYPdrWBNBtZQ@mail.gmail.com>
Subject: Re: [PATCH v8 20/37] arm: gic-v3-its: Implement of_xlate
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Mon, Oct 14, 2024 at 6:16=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Translate IRQs by implementing of_xlate() as required by
> irq_get_by_index() to parse interrupt properties.
>
> TEST: Booted on qemu sbsa-ref that has a GICV3.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changelog v6:
> - Update header order
>
> ---
>  arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> index 22fa46a341..0d5545bfb2 100644
> --- a/arch/arm/lib/gic-v3-its.c
> +++ b/arch/arm/lib/gic-v3-its.c
> @@ -4,6 +4,7 @@
>   */
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <irq.h>
>  #include <asm/gic.h>
>  #include <asm/gic-v3.h>
>  #include <asm/io.h>
> @@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] =3D {
>         {}
>  };
>
> +static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_ar=
gs *args)
> +{
> +       if (args->args_count > 2) {
> +               log_debug("Invalid args_count: %d\n", args->args_count);
> +               return -EINVAL;
> +       }
Aren't gicv3 at least #interrupt-cells =3D 3; to distinguish PPI / SPI?
> +
> +       if (args->args_count > 0)
> +               irq->id =3D args->args[0];
> +       if (args->args_count > 1)
> +               irq->flags =3D args->args[1];

Don't you have to distinguish PPI and SPIs here? You'll use
args->args[0] as PPI vs SPI and args[1] is either 1:1 (PPI) or offset
by 32 for SPIs or am I misunderstanding something?
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

Cheers,
Moritz
