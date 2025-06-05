Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10118C5B549
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 03:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5051C80050;
	Thu,  5 Jun 2025 05:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XYViwind";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE33D801BE; Thu,  5 Jun 2025 05:33:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C218004F
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 05:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=smelamud@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749094421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVgjD6cMqomiBtzKUckF2Ulr8+SsY/IHrcb48Wl/w1M=;
 b=XYViwindVWS8AYSFQT7AZD3JA+qMzcpdOWiXzMQ8u2G2d9vPjMEjhCSTNe5fxNDDFPhPZ6
 TBD8KdhpefifiERtmKefS4zLIJ7FxIk/uV5zpJ1JS7Y7ZxnlQ8NV/MTwv6oFUYkd1EYoFn
 20ml1J1zndWv5VMeDtSF2GbOAVr2CVw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-zqJKUUaJPB6OcuNyidSrBQ-1; Wed, 04 Jun 2025 23:33:37 -0400
X-MC-Unique: zqJKUUaJPB6OcuNyidSrBQ-1
X-Mimecast-MFC-AGG-ID: zqJKUUaJPB6OcuNyidSrBQ_1749094416
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-601f3f35b88so362829a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 20:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749094416; x=1749699216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVgjD6cMqomiBtzKUckF2Ulr8+SsY/IHrcb48Wl/w1M=;
 b=h8IffYsq/SO5KHsICAdskwD05Zh7MIs5td9UojrHIgQKHjJd3lwoLx1c3Q74hZjLRC
 q7xAWfskULRGWowOCR6PSnNabUpuPlglaBztK0fQR2ruJ6qjbYjqeObLdRuhI9xRhd0M
 O+JLMpli6z4/fho35f+GtQSvdPtLz56nQ7fNDzLrIwhJsEGdMBxHPKspfMNzRsvqcltg
 J7LSYWZvTRc4ZN7bFqpyCFRyProcWeCp8mzgTDrOjJknk7A4ETRNz2h+IvXUOsA4v8WI
 cpgJJVw2t7yXZKSEzs+3vH/9wjXT5zPalC6Skfot5fHWMqCO1W+rGPJ5F1fZbRTV0Ez1
 Rz+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV85aYr4l7IO8eVx/dWqy8vc9/OdhGAOpCW5If/LmEHHcXd4dOY9fXiwZdw86CGAcSpL25cO4M=@lists.denx.de
X-Gm-Message-State: AOJu0YyoQIedyhhr/BnvVXftBP/mPaT24qGGQvxfB+yfGP3wGz/W3QC2
 X80eWEGrFrWcbnAA9xB89Hj09jFTuF5/PbCz9oB6aUqsPvN1E8EHFxE/vZW9RAWSZnvuGxpAYtF
 lXraWR+iChyWNSTUoZhllPqkbPHvfE/6jt8CPrdUz7PA4zsxui8feF1RAXfft21yq62gUBlaUZ3
 CS2w0s9Kz6K7QFhQUSKHxXCemIjFIxsQ==
X-Gm-Gg: ASbGncs5G2ohP2HJhKU36Iz/tzltg0tNWGdoD7tPsowVqn4NdNilv/mne0xJjLNJdCk
 Ttgstd6wTKgC00Cf29+VwtBHUl5TvrB597GHgX7ldIp05xdK1ZMksEQgqNmoqodkHEjrLxaJpFm
 4g8eme
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id
 4fb4d7f45d1cf-606f836d433mr2908606a12.19.1749094416461; 
 Wed, 04 Jun 2025 20:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+vLhRkT9uFxhB1uH15iVjvhHcLCbjUdc7xfIg0ThNOrWR32oAlndddh43LibKsG4XurMMMTOTw57tnIq1t2w=
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id
 4fb4d7f45d1cf-606f836d433mr2908589a12.19.1749094415951; Wed, 04 Jun 2025
 20:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
 <20250603-us-renesas-watchdog-v3-2-af3a65afd03e@redhat.com>
 <87bjr3ubwe.fsf@kernel.org>
In-Reply-To: <87bjr3ubwe.fsf@kernel.org>
From: Shmuel Melamud <smelamud@redhat.com>
Date: Thu, 5 Jun 2025 06:33:24 +0300
X-Gm-Features: AX0GCFsREERDKyakpOjZI-eXUk4heoUApY4RUjbV94oSI_OQfVrHPC7SygZUai8
Message-ID: <CAMFVLy3mBpTsLD4nKr=cfY0oRYbkRf9rszKYAY3vxhJ81_X=2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] renesas: Renesas R-Car Gen4 watchdog driver
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Shmuel Leib Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zGK8HD6EyGKnGscpoH2FjenryGI--whMqTpW0Z786E4_1749094416
X-Mimecast-Originator: redhat.com
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

On Wed, Jun 4, 2025 at 12:02=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Shmuel,
>
> Thank you for the patch.
>
> On Tue, Jun 03, 2025 at 06:06, Shmuel Leib Melamud via B4 Relay <devnull+=
smelamud.redhat.com@kernel.org> wrote:
>
> > From: Shmuel Leib Melamud <smelamud@redhat.com>
> >
> > Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
> > 8184.0s are supported (CKS1 register is not involved). The watchdog
> > uses the clock of type CLK_TYPE_GEN4_MDSEL.
> >
> > The timeout is set in
> > dts/upstream/src/arm64/renesas/r8a779f0-spider-cpu.dtsi section &rwdt.
> >
> > This driver is based on upstream linux commit:
> > e70140ba0d2b("Get rid of 'remove_new' relic from platform driver struct=
")
> >
> > Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
> > ---
> >  drivers/watchdog/Kconfig       |   8 ++
> >  drivers/watchdog/Makefile      |   1 +
> >  drivers/watchdog/renesas_wdt.c | 182 +++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 191 insertions(+)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 1bb67f5035231df9f6ce01adb08d074855393143..a0f2948335f9c3b74b7823f=
039e578ff4030e97c 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -335,6 +335,14 @@ config WDT_K3_RTI_FW_FILE
> >
> >  endif
> >
> > +config WDT_RENESAS
> > +     bool "Renesas watchdog timer support"
> > +     depends on WDT && R8A779F0
> > +     select CLK
> > +     select CLK_RENESAS
> > +     help
> > +       Enables Renesas SoC R8A779F0 watchdog timer support.
> > +
> >  config WDT_SANDBOX
> >       bool "Enable Watchdog Timer support for Sandbox"
> >       depends on SANDBOX && WDT
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index e6bd4c587af6133c405dde6dbada8050debc781c..c4467d6e126d0c3e119bf80=
14b302e5b1432f541 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_WDT_MTK) +=3D mtk_wdt.o
> >  obj-$(CONFIG_WDT_NPCM) +=3D npcm_wdt.o
> >  obj-$(CONFIG_WDT_OCTEONTX) +=3D octeontx_wdt.o
> >  obj-$(CONFIG_WDT_OMAP3) +=3D omap_wdt.o
> > +obj-$(CONFIG_WDT_RENESAS) +=3D renesas_wdt.o
> >  obj-$(CONFIG_WDT_SBSA) +=3D sbsa_gwdt.o
> >  obj-$(CONFIG_WDT_K3_RTI) +=3D rti_wdt.o
> >  obj-$(CONFIG_WDT_SIEMENS_PMIC) +=3D siemens_pmic_wdt.o
> > diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_=
wdt.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..5dc5b0b51e0d19589ea96e7=
a66d4b790d377e7f8
> > --- /dev/null
> > +++ b/drivers/watchdog/renesas_wdt.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright 2025 Red Hat, Inc., Shmuel Leib Melamud <smelamud@redhat.=
com>
> > +
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <wdt.h>
> > +#include <asm/io.h>
> > +#include <dm/device_compat.h>
> > +#include <linux/delay.h>
> > +#include <linux/iopoll.h>
> > +
> > +#define usleep_range(a, b) udelay((b))
> > +
> > +struct rwdt {
> > +     u32 cnt;
> > +     u32 csra;
> > +     u32 csrb;
> > +};
> > +
> > +#define RWTCSRA_WOVF BIT(4)
> > +#define RWTCSRA_WRFLG        BIT(5)
> > +#define RWTCSRA_TME          BIT(7)
> > +
> > +#define CSR_MASK     0xA5A5A500
> > +#define CNT_MASK     0x5A5A0000
> > +
> > +/*
> > + * In probe, clk_rate is checked to be not more than 16 bit * biggest =
clock
> > + * divider (12 bits). d is only a factor to fully utilize the WDT coun=
ter and
> > + * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bi=
ts.
> > + */
> > +#define MUL_BY_CLKS_PER_SEC(p, d) \
> > +     DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
> > +
> > +/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
> > +#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk=
_rate)
> > +
> > +static const unsigned int clk_divs[] =3D { 1, 4, 16, 32, 64, 128, 1024=
, 4096 };
> > +
> > +struct rwdt_priv {
> > +     struct rwdt __iomem *wdt;
> > +     unsigned long clk_rate;
> > +     u8 cks;
> > +     struct clk clk;
> > +};
> > +
> > +static void rwdt_wait_cycles(struct rwdt_priv *priv, unsigned int cycl=
es)
> > +{
> > +     unsigned int delay;
> > +
> > +     delay =3D DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
> > +
> > +     usleep_range(delay, 2 * delay);
> > +}
> > +
> > +static int rwdt_start(struct udevice *dev, u64 timeout, ulong flags)
> > +{
> > +     struct rwdt_priv *priv =3D dev_get_priv(dev);
> > +     u64 max_timeout;
> > +     u8 val;
> > +
> > +     max_timeout =3D DIV_BY_CLKS_PER_SEC(priv, 65536);
>
> Why 65536. This number is used here ...

65536 here is the maximal value of the counter plus 1. If we divide it
by the number of impulses per second, we get the maximal timeout in
seconds.

> > +     timeout =3D min(max_timeout, timeout / 1000);
> > +
> > +     /* Stop the timer before we modify any register */
> > +     val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> > +     writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> > +     /* Delay 2 cycles before setting watchdog counter */
> > +     rwdt_wait_cycles(priv, 2);
> > +
> > +     while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
> > +             cpu_relax();
> > +
> > +     writel_relaxed((65536 - MUL_BY_CLKS_PER_SEC(priv, timeout)) | CNT=
_MASK,
> > +                    &priv->wdt->cnt);
>
> ... and here. Can we move it to a define to document its meaning?

65536 here is for negation. Since the counter is incremented on every
impulse, the timeout is the number of impulses that are left till
overflow of the counter.

In both cases it is the maximal value of the counter, so maybe it
makes sense to add a define for it.

> > +
> > +     writel_relaxed(priv->cks | RWTCSRA_TME | CSR_MASK, &priv->wdt->cs=
ra);
>
> I still see some subtle differences between linux driver (where a
> rwdt_write() helper function is present) and this U-Boot driver but with
> the rename, it's gotten much easier to review.
>
> Thanks for the improvements !
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int rwdt_stop(struct udevice *dev)
> > +{
> > +     struct rwdt_priv *priv =3D dev_get_priv(dev);
> > +
> > +     writel_relaxed(priv->cks | CSR_MASK, &priv->wdt->csra);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rwdt_reset(struct udevice *dev)
> > +{
> > +     struct rwdt_priv *priv =3D dev_get_priv(dev);
> > +     u8 val;
> > +
> > +     /* Stop the timer before we modify any register */
> > +     val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> > +     writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> > +     /* Delay 2 cycles before setting watchdog counter */
> > +     rwdt_wait_cycles(priv, 2);
> > +
> > +     writel_relaxed(0xffff | CNT_MASK, &priv->wdt->cnt);
> > +     /* smallest divider to reboot soon */
> > +     writel_relaxed(0 | CSR_MASK, &priv->wdt->csra);
> > +
> > +     readb_poll_timeout(&priv->wdt->csra, val, !(val & RWTCSRA_WRFLG),=
 100);
> > +
> > +     writel_relaxed(RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> > +
> > +     /* wait 2 cycles, so watchdog will trigger */
> > +     rwdt_wait_cycles(priv, 2);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rwdt_probe(struct udevice *dev)
> > +{
> > +     struct rwdt_priv *priv =3D dev_get_priv(dev);
> > +     unsigned long clks_per_sec;
> > +     int ret, i;
> > +
> > +     priv->wdt =3D dev_remap_addr(dev);
> > +     if (!priv->wdt)
> > +             return -EINVAL;
> > +
> > +     ret =3D clk_get_by_index(dev, 0, &priv->clk);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D clk_enable(&priv->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     priv->clk_rate =3D clk_get_rate(&priv->clk);
> > +     if (!priv->clk_rate) {
> > +             ret =3D -ENOENT;
> > +             goto err_clk_disable;
> > +     }
> > +
> > +     for (i =3D ARRAY_SIZE(clk_divs) - 1; i >=3D 0; i--) {
> > +             clks_per_sec =3D priv->clk_rate / clk_divs[i];
> > +             if (clks_per_sec && clks_per_sec < 65536) {
> > +                     priv->cks =3D i;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     /* can't find a suitable clock divider */
> > +     if (i < 0) {
> > +             ret =3D -ERANGE;
> > +             goto err_clk_disable;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_clk_disable:
> > +     clk_disable(&priv->clk);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct wdt_ops rwdt_ops =3D {
> > +     .start =3D rwdt_start,
> > +     .reset =3D rwdt_reset,
> > +     .stop =3D rwdt_stop,
> > +};
> > +
> > +static const struct udevice_id rwdt_ids[] =3D {
> > +     { .compatible =3D "renesas,rcar-gen2-wdt" },
> > +     { .compatible =3D "renesas,rcar-gen3-wdt" },
> > +     { .compatible =3D "renesas,rcar-gen4-wdt" },
> > +     {}
> > +};
> > +
> > +U_BOOT_DRIVER(wdt_renesas) =3D {
> > +     .name =3D "wdt_renesas",
> > +     .id =3D UCLASS_WDT,
> > +     .of_match =3D rwdt_ids,
> > +     .ops =3D &rwdt_ops,
> > +     .probe  =3D rwdt_probe,
> > +     .priv_auto =3D sizeof(struct rwdt_priv),
> > +};
> >
> > --
> > 2.49.0
>

