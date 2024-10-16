Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6DDD2A559
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C181388DE1;
	Wed, 16 Oct 2024 22:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="mEeBGg1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E52F88DD1; Wed, 16 Oct 2024 22:10:37 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4506588DE6
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c87b0332cso9135ad.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729109434; x=1729714234; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NkOURuCTQP7nX+YObA1hR6Li4nOQ01h9Qw8vGLO6N4=;
 b=mEeBGg1eZKpT4A+Byf6RPxEv6h3JH8UZAIWN3kY1U9FNb1QbBL8uXrS2KgAQLe6WsH
 Yize1e3KJjadid+MbJtDzGctpBWR9CSbUpKYJwTcTMVUZEzO5tq6M780LQKsNX2yUA3I
 1VDXsxN2FhfqOKc8Gq19csmKOxv019JgyR0ysdCeyS3a4JiTmI3i7jEz96qj3yACKZsm
 SRW+qTszeCtmZjWuEYfjeEqrMAiaZ3iLp2EOUePZdaICyQ+N/DobAKC77B5OaHWGvaaW
 W5QMjhfYBXYoADQ1QQtbvbWJxwLBpIY3jSLPZy7JeOU2aOW+LyGAfAkspEaExZNrEnfv
 4lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729109434; x=1729714234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NkOURuCTQP7nX+YObA1hR6Li4nOQ01h9Qw8vGLO6N4=;
 b=gw1r6fjR/byyWGV/iSOwLYOvsge2K5uX/rKE5Wi7b0EPrYvuX6fyiC6SkgMV0EPbWk
 CmOnMkq9MWJ9lUQkszYhmt1t2Pl9TzVncQzhx+FGKzLZD9DCke93pLCgZXT8S0ZPUvkJ
 nVCEqv3FqbdJ7ZUJJvuY3xRFxQPFKYgyZu/qhEjeZWPEOJ1b5LnXB7gC/kaeLM8Y0Zjf
 tr9+gWCjsw4Upf9SuuBNs4x23cggd17i+PiC4AMKDaXt3lu/rQqeaBZcY2wrXTSV1S91
 wgQNfijUVc8R7wWBZLs7yA+6SKiOsE8SwQkY9C/vW3aPv6dqp8FJcDzrRPCgR04sfZNT
 SITQ==
X-Gm-Message-State: AOJu0YyG8cYoyr/w3Bh3YPZziXsiTMJpeRbEGQrISg5tCS5ftWzlgOsO
 NfOT0bft/FhdKSdQ6++VggmTQjkgLIxbDx/tPK3uH5/lKcMbYmRUwVgY49Zec+vgxFuXkVpoY61
 XjYB5nCf5B+9HunXSUmzkjCcNRlHGvY9SBTsqd6Am6DEjh4Hyl0fK
X-Google-Smtp-Source: AGHT+IHNP9ajRAqdV8NCaYQXhRJdgApSN7UYgbJF9n2SGe3zg3uQ1FvPr7OKB91AMKHDOH37r9XbYjrh5ZsIJ9y7fXg=
X-Received: by 2002:a17:903:2292:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-20d4992a6b5mr591855ad.15.1729109433392; Wed, 16 Oct 2024
 13:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-23-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-23-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Wed, 16 Oct 2024 13:10:22 -0700
Message-ID: <CAFyOScrn8S6sRpNfpuPNCDYR1vXEeP+v=SmDO9LS=6zJPfd3zQ@mail.gmail.com>
Subject: Re: [PATCH v9 22/37] drivers: misc: irq-uclass: Update
 irq_get_by_index
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
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

On Tue, Oct 15, 2024 at 11:16=E2=80=AFPM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Support reading the "interrupts" property from the devicetree in case
> the "interrupts-extended" property isn't found. As the "interrupts"
> property is commonly used, this allows to parse all existing FDT and
> makes irq_get_by_index() more useful.
>
> The "interrupts" property doesn't contain a phandle as "interrupts-extend=
ed"
> does, so implement a new method to locate the interrupt-parent called
> irq_get_interrupt_parent().
>
> TEST: Read the interrupts from the GIC node for ACPI MADT generation.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Moritz Fischer <moritzf@google.com>
> ---
> Changelog v9:
> - Read interrupt-cells from interrupt parent
> ---
>  arch/sandbox/dts/test.dts |  3 ++
>  drivers/misc/irq-uclass.c | 66 ++++++++++++++++++++++++++++++++++++++-
>  include/irq.h             | 14 +++++++++
>  test/dm/irq.c             | 15 +++++++++
>  4 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 8412506c17..9599a8db9c 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -522,6 +522,9 @@
>         };
>
>         f-test {
> +               #interrupt-cells =3D <2>;
> +               interrupt-parent =3D <&irq>;
> +               interrupts =3D <4 0>;
>                 compatible =3D "denx,u-boot-fdt-test";
>         };
>
> diff --git a/drivers/misc/irq-uclass.c b/drivers/misc/irq-uclass.c
> index 79eb7c200d..ac778593c9 100644
> --- a/drivers/misc/irq-uclass.c
> +++ b/drivers/misc/irq-uclass.c
> @@ -62,6 +62,40 @@ int irq_read_and_clear(struct irq *irq)
>         return ops->read_and_clear(irq);
>  }
>
> +int irq_get_interrupt_parent(const struct udevice *dev,
> +                            struct udevice **interrupt_parent)
> +{
> +       struct ofnode_phandle_args phandle_args;
> +       struct udevice *irq =3D NULL;
> +       ofnode node;
> +       int ret;
> +
> +       if (!dev || !interrupt_parent)
> +               return -EINVAL;
> +
> +       *interrupt_parent =3D NULL;
> +
> +       node =3D dev_ofnode(dev);
> +       if (!ofnode_valid(node))
> +               return -EINVAL;
> +
> +       while (ofnode_valid(node)) {
> +               ret =3D ofnode_parse_phandle_with_args(node, "interrupt-p=
arent",
> +                                                    NULL, 0, 0, &phandle=
_args);
> +               if (!ret && !device_get_global_by_ofnode(phandle_args.nod=
e, &irq))
> +                       break;
> +               node =3D ofnode_get_parent(node);
> +       }
> +
> +       if (!irq) {
> +               log_err("Cannot find an interrupt parent for device %s\n"=
, dev->name);
> +               return -ENODEV;
> +       }
> +       *interrupt_parent =3D irq;
> +
> +       return 0;
> +}
> +
>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>  int irq_get_by_phandle(struct udevice *dev, const struct phandle_2_arg *=
cells,
>                        struct irq *irq)
> @@ -142,10 +176,40 @@ err:
>  int irq_get_by_index(struct udevice *dev, int index, struct irq *irq)
>  {
>         struct ofnode_phandle_args args;
> -       int ret;
> +       struct udevice *interrupt_parent;
> +       int ret, size, i;
> +       const __be32 *list;
> +       u32 count;
>
>         ret =3D dev_read_phandle_with_args(dev, "interrupts-extended",
>                                          "#interrupt-cells", 0, index, &a=
rgs);
> +       if (ret) {
> +               list =3D dev_read_prop(dev, "interrupts", &size);
> +               if (!list)
> +                       return -ENOENT;
> +
> +               ret =3D irq_get_interrupt_parent(dev, &interrupt_parent);
> +               if (ret)
> +                       return -ENODEV;
> +               args.node =3D dev_ofnode(interrupt_parent);
> +
> +               if (dev_read_u32(interrupt_parent, "#interrupt-cells", &c=
ount)) {
> +                       log_err("%s: could not get #interrupt-cells for %=
s\n",
> +                               __func__, dev->name);
> +                       return -ENOENT;
> +               }
> +
> +               if (index * count >=3D size / sizeof(*list))
> +                       return -ENOENT;
> +               if (count > OF_MAX_PHANDLE_ARGS)
> +                       count =3D OF_MAX_PHANDLE_ARGS;
> +               args.args_count =3D count;
> +               for (i =3D 0; i < count; i++)
> +                       args.args[i] =3D be32_to_cpup(&list[index * count=
 + i]);
> +
> +               return irq_get_by_index_tail(ret, dev_ofnode(dev), &args,
> +                                            "interrupts", index, irq);
> +       }
>
>         return irq_get_by_index_tail(ret, dev_ofnode(dev), &args,
>                                      "interrupts-extended", index > 0, ir=
q);
> diff --git a/include/irq.h b/include/irq.h
> index 5638c10128..0fbc1a5f48 100644
> --- a/include/irq.h
> +++ b/include/irq.h
> @@ -200,6 +200,20 @@ int irq_restore_polarities(struct udevice *dev);
>   */
>  int irq_read_and_clear(struct irq *irq);
>
> +/**
> + * irq_get_interrupt_parent() - returns the interrupt parent
> + *
> + * Walks the devicetree and returns the interrupt parent's ofnode
> + * for the specified device.
> + *
> + * @dev: device
> + * @interrupt_parent: The interrupt parent's ofnode'
> + * Return: 0 success, or error value
> + *
> + */
> +int irq_get_interrupt_parent(const struct udevice *dev,
> +                            struct udevice **interrupt_parent);
> +
>  struct phandle_2_arg;
>  /**
>   * irq_get_by_phandle() - Get an irq by its phandle information (of-plat=
adata)
> diff --git a/test/dm/irq.c b/test/dm/irq.c
> index 836f2d82e7..ca3e188065 100644
> --- a/test/dm/irq.c
> +++ b/test/dm/irq.c
> @@ -76,6 +76,21 @@ static int dm_test_request(struct unit_test_state *uts=
)
>  }
>  DM_TEST(dm_test_request, UTF_SCAN_PDATA | UTF_SCAN_FDT);
>
> +/* Test of irq_get_by_index() */
> +static int dm_test_irq_get_by_index(struct unit_test_state *uts)
> +{
> +       struct udevice *dev;
> +       struct irq irq;
> +
> +       ut_assertok(uclass_get_device_by_name(UCLASS_TEST_FDT, "f-test",
> +                                             &dev));
> +       ut_assertok(irq_get_by_index(dev, 0, &irq));
> +       ut_asserteq(4, irq.id);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_irq_get_by_index, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +
>  /* Test of irq_get_acpi() */
>  static int dm_test_irq_get_acpi(struct unit_test_state *uts)
>  {
> --
> 2.46.2
>
