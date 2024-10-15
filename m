Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E959CFC26E
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 06:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6CEE881A5;
	Tue, 15 Oct 2024 08:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="A0py+8mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B4C8852B; Tue, 15 Oct 2024 08:57:27 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407DE880F4
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 08:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e2915f00c12so3745013276.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728975443; x=1729580243; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H987red0HBMZhg+fNnMC77H7RFyV9VQo6zyuMuijQWY=;
 b=A0py+8mbrN4LkGyf/ly1+Nd2LsD8Jel3jfpCjz5sSzKsOrOXSzvAwVsuSLA1zRiJmV
 wHlngcS45FbMppyhG3BhwteFJ52t8taTE7EA4lf0yOkiIcqEYw7f/q6ubESFWupXElEL
 yWU02OMa79g+PFbghXvYv6y2eIBii9wC2Cv+FiZQxgMNYYyIgL5SAz7xKEA57hi2gXc2
 dMusue7maVqp2d7DF5n2vZNDiVcib2X8XiPFNKjF26TbcCEkmzFoFD6tf7n1FAaxK8lX
 mSHmnBPb7PyrcyW56F3iHM+z80PZCL2XK3RHHLndA+78FUtGlGVU15n8p0JZ5AEF1zMo
 kKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728975443; x=1729580243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H987red0HBMZhg+fNnMC77H7RFyV9VQo6zyuMuijQWY=;
 b=G5o9+XWl3h4WWgLA/sHuFl1MlHzvfQV6CeGEqH74K+cI0CBLNNDIqNgL/BQ++AQOsV
 +3etQAS//yW4qb/7JufWO7JpOgaFEps9iQOvNJdEbzSFAYV7wNpM3oKcXWp7xBXZoDjV
 vZMeAvQGIMLeQIWyccKsRI7LRXV7dGrsXvxkttO1YtRzlDqEpsc9ap4d7SvhtxBf/ws8
 nNCVcT246xfCXiLuOx7w0Z9HHADK/xWBC8qpxUFEgfWNlYJYlyCaj10uhvRkLwDLNvhC
 8Vj7W29qyJPMoisjcpOQ781PwiuP66+I0Fke4SKUwTjQPyAbpp68L7wDr4ocu2gjLwsQ
 z3Cw==
X-Gm-Message-State: AOJu0Yy+H/qTQB8K3JwvOtWChFcYe4w3Lobc+NVMYOnNsnezbMvx9vPA
 LixEAsAEfIg6C8Sgm69mpAUAAY/93ii73+tCbBu6GOYrrycdRFacPjNI/B+4m5XFxARiUwDWuuQ
 K9qzgqHpEepjVSQapXsSCHzUgz9cITZDPmUadtQ==
X-Google-Smtp-Source: AGHT+IG93hNnUU/nmIyFUShw3qr5HNK0udGa36PXH5qv9p5RDR6zgAcg5EvVfNoINfJorIifBBiQ0RxIPFDbEsKDpY8=
X-Received: by 2002:a05:6902:124f:b0:e29:44d6:5b4 with SMTP id
 3f1490d57ef6-e2944d60870mr6217775276.42.1728975442992; Mon, 14 Oct 2024
 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-23-patrick.rudolph@9elements.com>
 <CAFyOScrEaec0LWcj-2FzZuVWXin26TZh0AH8-gWqORonYSgmvA@mail.gmail.com>
In-Reply-To: <CAFyOScrEaec0LWcj-2FzZuVWXin26TZh0AH8-gWqORonYSgmvA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 15 Oct 2024 08:57:12 +0200
Message-ID: <CALNFmy3CdWT3FASwjuH-F8XjV5FMQOXKxDwjks1B1BchVy9Skg@mail.gmail.com>
Subject: Re: [PATCH v8 22/37] drivers: misc: irq-uclass: Update
 irq_get_by_index
To: Moritz Fischer <moritzf@google.com>
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

Hi Moritz,
On Tue, Oct 15, 2024 at 2:59=E2=80=AFAM Moritz Fischer <moritzf@google.com>=
 wrote:
>
> Hi Patrick
>
> On Mon, Oct 14, 2024 at 6:16=E2=80=AFAM Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Support reading the "interrupts" property from the devicetree in case
> > the "interrupts-extended" property isn't found. As the "interrupts"
> > property is commonly used, this allows to parse all existing FDT and
> > makes irq_get_by_index() more useful.
> >
> > The "interrupts" property doesn't contain a phandle as "interrupts-exte=
nded"
> > does, so implement a new method to locate the interrupt-parent called
> > irq_get_interrupt_parent().
> >
> > TEST: Read the interrupts from the GIC node for ACPI MADT generation.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  arch/sandbox/dts/test.dts |  3 ++
> >  drivers/misc/irq-uclass.c | 66 ++++++++++++++++++++++++++++++++++++++-
> >  include/irq.h             | 14 +++++++++
> >  test/dm/irq.c             | 15 +++++++++
> >  4 files changed, 97 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > index 8412506c17..9599a8db9c 100644
> > --- a/arch/sandbox/dts/test.dts
> > +++ b/arch/sandbox/dts/test.dts
> > @@ -522,6 +522,9 @@
> >         };
> >
> >         f-test {
> > +               #interrupt-cells =3D <2>;
> > +               interrupt-parent =3D <&irq>;
> > +               interrupts =3D <4 0>;
> >                 compatible =3D "denx,u-boot-fdt-test";
> >         };
> >
> > diff --git a/drivers/misc/irq-uclass.c b/drivers/misc/irq-uclass.c
> > index 79eb7c200d..068f67fe02 100644
> > --- a/drivers/misc/irq-uclass.c
> > +++ b/drivers/misc/irq-uclass.c
> > @@ -62,6 +62,40 @@ int irq_read_and_clear(struct irq *irq)
> >         return ops->read_and_clear(irq);
> >  }
> >
> > +int irq_get_interrupt_parent(const struct udevice *dev,
> > +                            struct udevice **interrupt_parent)
> > +{
> > +       struct ofnode_phandle_args phandle_args;
> > +       struct udevice *irq =3D NULL;
> > +       ofnode node;
> > +       int ret;
> > +
> > +       if (!dev || !interrupt_parent)
> > +               return -EINVAL;
> > +
> > +       *interrupt_parent =3D NULL;
> > +
> > +       node =3D dev_ofnode(dev);
> > +       if (!ofnode_valid(node))
> > +               return -EINVAL;
> > +
> > +       while (ofnode_valid(node)) {
> > +               ret =3D ofnode_parse_phandle_with_args(node, "interrupt=
-parent",
> > +                                                    NULL, 0, 0, &phand=
le_args);
> > +               if (!ret && !device_get_global_by_ofnode(phandle_args.n=
ode, &irq))
> > +                       break;
> > +               node =3D ofnode_get_parent(node);
> > +       }
> > +
> > +       if (!irq) {
> > +               log_err("Cannot find an interrupt parent for device %s\=
n", dev->name);
> > +               return -ENODEV;
> > +       }
> > +       *interrupt_parent =3D irq;
> > +
> > +       return 0;
> > +}
> > +
> >  #if CONFIG_IS_ENABLED(OF_PLATDATA)
> >  int irq_get_by_phandle(struct udevice *dev, const struct phandle_2_arg=
 *cells,
> >                        struct irq *irq)
> > @@ -142,10 +176,40 @@ err:
> >  int irq_get_by_index(struct udevice *dev, int index, struct irq *irq)
> >  {
> >         struct ofnode_phandle_args args;
> > -       int ret;
> > +       struct udevice *interrupt_parent;
> > +       int ret, size, i;
> > +       const __be32 *list;
> > +       u32 count;
> >
> >         ret =3D dev_read_phandle_with_args(dev, "interrupts-extended",
> >                                          "#interrupt-cells", 0, index, =
&args);
> > +       if (ret) {
> > +               list =3D dev_read_prop(dev, "interrupts", &size);
> > +               if (!list)
> > +                       return -ENOENT;
> > +
> > +               ret =3D irq_get_interrupt_parent(dev, &interrupt_parent=
);
> > +               if (ret)
> > +                       return -ENODEV;
> > +               args.node =3D dev_ofnode(interrupt_parent);
> > +
> > +               if (dev_read_u32(dev, "#interrupt-cells", &count)) {
> > +                       log_err("%s: could not get #interrupt-cells for=
 %s\n",
> > +                               __func__, dev->name);
> > +                       return -ENOENT;
> > +               }
>
> Don't you want to read this out of the interrupt-parent?
No. It should be read from the node/dev containing the "interrupts" propert=
y.
It encodes how many fields the interrupts property has and how many
fields to read.

>
> > +
> > +               if (index * count >=3D size / sizeof(*list))
> > +                       return -ENOENT;
> > +               if (count > OF_MAX_PHANDLE_ARGS)
> > +                       count =3D OF_MAX_PHANDLE_ARGS;
> > +               args.args_count =3D count;
> > +               for (i =3D 0; i < count; i++)
> > +                       args.args[i] =3D be32_to_cpup(&list[index * cou=
nt + i]);
> > +
> > +               return irq_get_by_index_tail(ret, dev_ofnode(dev), &arg=
s,
> > +                                            "interrupts", index, irq);
> > +       }
> >
> >         return irq_get_by_index_tail(ret, dev_ofnode(dev), &args,
> >                                      "interrupts-extended", index > 0, =
irq);
> > diff --git a/include/irq.h b/include/irq.h
> > index 5638c10128..0fbc1a5f48 100644
> > --- a/include/irq.h
> > +++ b/include/irq.h
> > @@ -200,6 +200,20 @@ int irq_restore_polarities(struct udevice *dev);
> >   */
> >  int irq_read_and_clear(struct irq *irq);
> >
> > +/**
> > + * irq_get_interrupt_parent() - returns the interrupt parent
> > + *
> > + * Walks the devicetree and returns the interrupt parent's ofnode
> > + * for the specified device.
> > + *
> > + * @dev: device
> > + * @interrupt_parent: The interrupt parent's ofnode'
> > + * Return: 0 success, or error value
> > + *
> > + */
> > +int irq_get_interrupt_parent(const struct udevice *dev,
> > +                            struct udevice **interrupt_parent);
> > +
> >  struct phandle_2_arg;
> >  /**
> >   * irq_get_by_phandle() - Get an irq by its phandle information (of-pl=
atadata)
> > diff --git a/test/dm/irq.c b/test/dm/irq.c
> > index 836f2d82e7..ca3e188065 100644
> > --- a/test/dm/irq.c
> > +++ b/test/dm/irq.c
> > @@ -76,6 +76,21 @@ static int dm_test_request(struct unit_test_state *u=
ts)
> >  }
> >  DM_TEST(dm_test_request, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> >
> > +/* Test of irq_get_by_index() */
> > +static int dm_test_irq_get_by_index(struct unit_test_state *uts)
> > +{
> > +       struct udevice *dev;
> > +       struct irq irq;
> > +
> > +       ut_assertok(uclass_get_device_by_name(UCLASS_TEST_FDT, "f-test"=
,
> > +                                             &dev));
> > +       ut_assertok(irq_get_by_index(dev, 0, &irq));
> > +       ut_asserteq(4, irq.id);
> > +
> > +       return 0;
> > +}
> > +DM_TEST(dm_test_irq_get_by_index, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> > +
> >  /* Test of irq_get_acpi() */
> >  static int dm_test_irq_get_acpi(struct unit_test_state *uts)
> >  {
> > --
> > 2.46.2
> >
>
> Cheers,
> Moritz
