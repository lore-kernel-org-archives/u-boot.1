Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA0CFC501
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 01:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A7A88DB3;
	Tue, 15 Oct 2024 03:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="wMMtZJr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD8388DEA; Tue, 15 Oct 2024 03:00:04 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A2A88CBB
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 03:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c8ac50b79so365925ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728953994; x=1729558794; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AuRBTRC28glQQbz6bqwcTcCNFwoEY93TbBjt+fjTi0=;
 b=wMMtZJr+AOD4CQH4MggnD6ngU4i0+IXC5IJZHhInU+Y2x0+seBKYtBJMNVTqR6kTc9
 bpi0AXk+9P9mbH1gp8lGPWtPmAV9JRs9ce15AsMaq+JI0sT6nqgKLX88XNeJCS0IV6/4
 d6Hdss1DwUMIbP2S0IYCEcjvNlVFpJzhgD1fnFcD7OO2/q62JEM0X/ZGcoOzMU5WSNkV
 oVMdYiOReKjqf60yOrnR10R9lo/ZmtxIKQtt9BMv+aNrm60hcmUVPXs7fG9ndhOVswJP
 9o1XditO46jCXgTnglEqPnBZ6XL7vFKuac5PwQ8ICQiB/H8vpu4pKx9JaFJcNPms4CM1
 KLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728953994; x=1729558794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AuRBTRC28glQQbz6bqwcTcCNFwoEY93TbBjt+fjTi0=;
 b=JFKQjaDKTX+fTGeeRq1YoVj5KFwoXD9gnzkDqqq5MdzT9RFFXU1Rp+xCMWQ20meDhL
 XDSKfUoNch5PSrSuYb0NpbZ97WHsvk/jWhzSi2ScTuOvSs1om1T3s5jBWnj2HVQBdC5S
 4P1Tiv/N/0nHtiG0lytFwAScqUWVDXxsgOg0E53I7tSp2XvwfHUXGPAwmHygn1zV+IeV
 q06cFp1iIs3e1ZYfMz933AGkMsZ3DUVrtKCfM94H+nrCYiafSDp4lLCY6jLMcE9hJ5TI
 R2vycqEIRflo2pkhqzFLLt68z4i7p4GzZ2uKaqLjLJvA+3zaJAEJ5RJNgcmWOAoowdRR
 FmLA==
X-Gm-Message-State: AOJu0Yyp4bXkNJIFvtO2hUzlwc9bZmagISOmasBb5cd98Tz8lmAr7WXG
 rzHtwcJ22s4P/LKDMA257jPewyRG0VTonmDYj16jSV+X5GBDhcRLpMLK6X8QYNxhsHtnH2HnJsP
 dUHS9Da8TTSTk4Tnz/r6vHYVNLL95mvG+C+oe
X-Google-Smtp-Source: AGHT+IGW66vFpIGT0Z5deJ0qwOl8YwWN5VmiCpiFP2r30oBY1GMiWmdJ1qiryT7VmeMxuLhRgjdS2JyzC4F/T1v247w=
X-Received: by 2002:a17:902:db11:b0:20b:5e34:1850 with SMTP id
 d9443c01a7336-20cc02e68f6mr4687595ad.23.1728953993634; Mon, 14 Oct 2024
 17:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-23-patrick.rudolph@9elements.com>
In-Reply-To: <20241014131152.267405-23-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Mon, 14 Oct 2024 17:59:40 -0700
Message-ID: <CAFyOScrEaec0LWcj-2FzZuVWXin26TZh0AH8-gWqORonYSgmvA@mail.gmail.com>
Subject: Re: [PATCH v8 22/37] drivers: misc: irq-uclass: Update
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

Hi Patrick

On Mon, Oct 14, 2024 at 6:16=E2=80=AFAM Patrick Rudolph
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
> Reviewed-by: Simon Glass <sjg@chromium.org>
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
> index 79eb7c200d..068f67fe02 100644
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
> +               if (dev_read_u32(dev, "#interrupt-cells", &count)) {
> +                       log_err("%s: could not get #interrupt-cells for %=
s\n",
> +                               __func__, dev->name);
> +                       return -ENOENT;
> +               }

Don't you want to read this out of the interrupt-parent?

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

Cheers,
Moritz
