Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13991C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F83864AF;
	Mon, 28 Aug 2023 10:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qesHmGtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061B5864B9; Mon, 28 Aug 2023 10:28:10 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4263886421
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50091b91a83so4393318e87.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693211286; x=1693816086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tRk1PYzvdFhVKNU3wDlXxrdMcxPwCgondw1ErsBHBbs=;
 b=qesHmGtnYEPu4G6VJLRLODrJNgjbgaLOQ/Y+8LY9Y7DQt4SfkyeTm7G9l0poPyIkZW
 i+Zwvh67fjVGldMhzUkRHgshV+y0WFKznuYG/VRp/F/DwAWcTyWxmYW/abZrc5Mr+384
 QBdjfnGaFSi5MkH6gTq3A04qEs60Drig0Z/mh5f5byEv6QNcK6HqwF/Ub605om8wthGv
 iqb5VuSYptlysAYo7maSeNAUrOG2FBTZ1VcGPAiqgJD193TC+Qwe1xcaePOqPzTfMUG9
 MGSdTJQLztsN/li4dTo1kEpWFI7ApzT72rK2xpuSiMeIBfdnr1RIV5AD5/VRw+RXahSQ
 YA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693211286; x=1693816086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tRk1PYzvdFhVKNU3wDlXxrdMcxPwCgondw1ErsBHBbs=;
 b=eMZ6Uu6iRQOZqf6iRNp2gQWxIn9IaMhufddH8G1JJQSfgqFk4tP8Tx2sl2U9gfAyKs
 0g++fYi2p/vMSCLnNjKUdzMgxdwTAo0vwPcMma60W4Bjg+Redngloh7LWwUrsvFDol7j
 kDKBfWeu5TVGiWnkWr2qgp4fKA5IuIg+ZuA/Zu0xqDEqqf10s7aYvzruu2+3fMVTUDVV
 hDFEEvBlBkzzY/f/BklWdtOkkNAEX1p70rf/hzYDRPlE1Soqt0mBAxKCSAiEyQ+iUR8q
 OgmAekHquaGlXO5Vxdr2iFL1Ubz3OEyzlWwL7k5qQLpgMSmBOItwvlPpVZRvM1UG8H7o
 tmaQ==
X-Gm-Message-State: AOJu0YzhXuCC3JkkvWqYWrcXT0IKjE6pXCyoO8TZdce6khiJ+5oHSwQR
 p+tCFPiOfLVVqUAs2miVlLjxtLITgE0zs6VMbCBjhA==
X-Google-Smtp-Source: AGHT+IHl+2C6sWtZqTXieXZouuhUpw77PS/8O4k7J2qC5GNw5p9aTY2zpHqYllssnPrvzB7eE2eGwEI2S8CASD1CwjQ=
X-Received: by 2002:a05:6512:3586:b0:4fe:8c1d:9e81 with SMTP id
 m6-20020a056512358600b004fe8c1d9e81mr15863052lfr.36.1693211286413; Mon, 28
 Aug 2023 01:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-2-sughosh.ganu@linaro.org>
 <a1b4dfb2-bbf7-5487-098f-c4c46ecf631c@gmx.de>
In-Reply-To: <a1b4dfb2-bbf7-5487-098f-c4c46ecf631c@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 28 Aug 2023 13:57:55 +0530
Message-ID: <CADg8p96vc7_hFa668h5A8QPDuoVEPc+ggNnx9-iFaTsjcVns7Q@mail.gmail.com>
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

On Sat, 26 Aug 2023 at 16:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
>
> SPL can be the last boot stage (e.g. for Falcon Mode). So placing this
> under 'ifndef CONFIG_SPL_BUILD' is not correct.
>
> You need some logic that identifies into which boot stage this code
> belongs, e.g. use obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT).

Okay. Will check and add this under the suggested config symbol.

-sughosh

>
> Best regards
>
> Heinrich
>
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
