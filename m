Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB6C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2872386423;
	Mon, 28 Aug 2023 10:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kfTaWQPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1FD864A7; Mon, 28 Aug 2023 10:27:15 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC4686421
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so3881340a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693211233; x=1693816033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ip1FXMeD/0Py3wEgBvpfy///8WKMOwxIiZ/aKarH2Es=;
 b=kfTaWQPWD3ZC4pPcyUpjXcHa72dcYe6XN2JVE7Ul9cSAWUqJIrsLn+beQw7zifV/hk
 RLpGUiGdLqsDxy8ukFINjod0q4P837oWCNH9OsF2omeogosqK0a4tuEBml6yOnPllA48
 Pt9kGr++Thk/QYa3pneRClrW6b0Mj5D8Y5DL6QNroK3YKBGSx6qj3cjYHbBdONBcHlyc
 Tmg1Z1Z5xH3oUaN5zGHQu6o5L4G+gzxHvblvARDK2lketG/qiQBeINp/f6E8nxKomiyk
 jzsYoXb3PKxcd9+1WZLg+V07thheQy7AqEjBm0wJRqIjkPSLI6zmabZKQCT4VFJEJbMN
 mAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693211233; x=1693816033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ip1FXMeD/0Py3wEgBvpfy///8WKMOwxIiZ/aKarH2Es=;
 b=GcnZqGW5xI6K/y8pci5+stF0guT49WLTsUdKXmoLmV4/6XB5+n0TcGha/wEc5cwMVG
 YdhFvZaWXUvdTqT0HdbigtM84Pyn1Ljjnif9P3Ppe1+nDkj5OTPTbFXiQCdWHrFy/y1z
 arNITZ78zy9PqSlHuKJw8+13VfC1KJUH3VbZS7KNL+H6RminUPB0tY+o9gkRVArXw/kb
 6ebKE+NETGkiHopfUkXspMG39uqWi+K9Ot5Bm5kDLsfNF6aNJpWcZf2ytkelXneo/FjF
 DX9HXN0i5IaCAlHvuctGhB7MJadtD/3VkpyWBX1E+miHQRITfep3krvbhWapU3SimWlZ
 Eq/g==
X-Gm-Message-State: AOJu0YxizAChBiLm0HzSTnklr3CxrX1pV5Zid4bhLw6+QujxS6af49ED
 zeNvQlViDuLzq0h9nvBh7ft9hq03/NA5cukzPH6cgQ==
X-Google-Smtp-Source: AGHT+IFappqfjkx2Q13GNy7Fd/edTtx4q0gqv7TcwYjmPD5yl2VF140fbb7Kw86SElY3CuUCcHf7WTrvRJL4A6zmNoM=
X-Received: by 2002:aa7:c508:0:b0:523:1004:1c9a with SMTP id
 o8-20020aa7c508000000b0052310041c9amr16302337edq.35.1693211232597; Mon, 28
 Aug 2023 01:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-2-sughosh.ganu@linaro.org>
 <0a168e1e-546e-c149-d715-ccacfeb4208f@gmx.de>
In-Reply-To: <0a168e1e-546e-c149-d715-ccacfeb4208f@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 28 Aug 2023 13:57:01 +0530
Message-ID: <CADg8p96mk3YzVNLJBMY6oQ_zWvP94W3T5iiPy7FX9B9g+-qnuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] dt: Provide a way to remove non-compliant nodes
 and properties
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Sat, 26 Aug 2023 at 15:51, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> On 8/26/23 11:06, Sughosh Ganu wrote:
> > Add a function which is registered to spy for a EVT_FT_FIXUP event,
> > and removes the non upstreamed nodes and properties from the
> > devicetree before it gets passed to the OS.
> >
> > This allows removing entire nodes, or specific properties under nodes
> > from the devicetree. The required nodes and properties can be
> > registered for removal through the DT_NON_COMPLIANT_PURGE and
> > DT_NON_COMPLIANT_PURGE_LIST macros.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   include/dt-structs.h | 11 +++++++
> >   lib/Makefile         |  1 +
> >   lib/dt_purge.c       | 73 ++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 85 insertions(+)
> >   create mode 100644 lib/dt_purge.c
> >
> > diff --git a/include/dt-structs.h b/include/dt-structs.h
> > index fa1622cb1d..f535c60471 100644
> > --- a/include/dt-structs.h
> > +++ b/include/dt-structs.h
> > @@ -57,3 +57,14 @@ struct phandle_2_arg {
> >   #endif
> >
> >   #endif
> > +
> > +struct dt_non_compliant_purge {
> > +     const char *node_path;
> > +     const char *prop;
> > +};
> > +
> > +#define DT_NON_COMPLIANT_PURGE(__name)       \
> > +     ll_entry_declare(struct dt_non_compliant_purge, __name, dt_purge)
> > +
> > +#define DT_NON_COMPLIANT_PURGE_LIST(__name)  \
> > +     ll_entry_declare_list(struct dt_non_compliant_purge, __name, dt_purge)
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 8d8ccc8bbc..82a906daa0 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -37,6 +37,7 @@ endif
> >   obj-y += crc8.o
> >   obj-y += crc16.o
> >   obj-y += crc16-ccitt.o
> > +obj-y += dt_purge.o
> >   obj-$(CONFIG_ERRNO_STR) += errno_str.o
> >   obj-$(CONFIG_FIT) += fdtdec_common.o
> >   obj-$(CONFIG_TEST_FDTDEC) += fdtdec_test.o
> > diff --git a/lib/dt_purge.c b/lib/dt_purge.c
> > new file mode 100644
> > index 0000000000..f893ba9796
> > --- /dev/null
> > +++ b/lib/dt_purge.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#include <dt-structs.h>
> > +#include <event.h>
> > +#include <linker_lists.h>
> > +
> > +#include <linux/libfdt.h>
> > +
> > +/**
> > + * dt_non_compliant_purge() -        Remove non-upstreamed nodes and properties
> > + *                           from the DT
> > + * @ctx: Context for event
> > + * @event: Event to process
> > + *
> > + * Iterate through an array of DT nodes and properties, and remove them
> > + * from the device-tree before the DT gets handed over to the kernel.
> > + * These are nodes and properties which do not have upstream bindings
> > + * and need to be purged before being handed over to the kernel.
> > + *
> > + * If both the node and property are specified, delete the property. If
> > + * only the node is specified, delete the entire node, including it's
> > + * subnodes, if any.
> > + *
> > + * Return: 0 if OK, -ve on error
> > + */
> > +static int dt_non_compliant_purge(void *ctx, struct event *event)
> > +{
> > +     int nodeoff = 0;
> > +     int err = 0;
> > +     void *fdt;
> > +     const struct event_ft_fixup *fixup = &event->data.ft_fixup;
> > +     struct dt_non_compliant_purge *purge_entry;
> > +     struct dt_non_compliant_purge *purge_start =
> > +             ll_entry_start(struct dt_non_compliant_purge, dt_purge);
> > +     int nentries = ll_entry_count(struct dt_non_compliant_purge, dt_purge);
> > +
> > +     if (fixup->images)
> > +             return 0;
> > +
> > +     fdt = fixup->tree.fdt;
> > +     for (purge_entry = purge_start; purge_entry != purge_start + nentries;
> > +          purge_entry++) {
> > +             nodeoff = fdt_path_offset(fdt, purge_entry->node_path);
> > +             if (nodeoff < 0) {
> > +                     log_debug("Error (%d) getting node offset for %s\n",
> > +                               nodeoff, purge_entry->node_path);
> > +                     continue;
> > +             }
> > +
> > +             if (purge_entry->prop) {
> > +                     err = fdt_delprop(fdt, nodeoff, purge_entry->prop);
> > +                     if (err < 0 && err != -FDT_ERR_NOTFOUND) {
> > +                             log_debug("Error (%d) deleting %s\n",
> > +                                       err, purge_entry->prop);
> > +                             goto out;
> > +                     }
> > +             } else {
> > +                     err = fdt_del_node(fdt, nodeoff);
> > +                     if (err) {
> > +                             log_debug("Error (%d) trying to delete node %s\n",
> > +                                       err, purge_entry->node_path);
> > +                             goto out;
> > +                     }
> > +             }
> > +     }
> > +
> > +out:
> > +     return err;
> > +}
> > +EVENT_SPY(EVT_FT_FIXUP, dt_non_compliant_purge);
>
> This may interfere with other fixup code requiring U-Boot specific
> properties like bootmeth_vbe_ft_fixup().

Okay, I was thinking if we can have a flag to indicate which event
handler is to be run. I will check this, and add a separate event if
this solution turns to be overly complex.

>
> We should ensure that call dt_non_compliant_purge() is the last fixup
> action. Please, consider a separate event.

Will check.

>
> This code does not check if the property or node complies to the device
> tree scheme or not. So why not call the function dt_purge()?

Okay

-sughosh
