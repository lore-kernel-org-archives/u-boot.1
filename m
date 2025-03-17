Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A40C28B28
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7049280107;
	Mon, 17 Mar 2025 11:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WVilCGYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B0D80F4C; Mon, 17 Mar 2025 11:40:14 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A119A800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 11:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-523ee30e0d4so1865470e0c.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742208011; x=1742812811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wW7BpeS6NwWqYBb0CZFS4CHDMs5FrphFjSG0U6e+C/Y=;
 b=WVilCGYHrWRzqTqZd4A1AaAMAIp3WMXEGyDWbSXSCgc76nEQqTINV2kkQ2BLmYWiE2
 mtNCP3W8zPMlAkaMtpf/RlufmhmOgm5OqqpnwCxdEuE9Sar4MHfwSjDkEbklNfKqKbuW
 PF//I55RvqlV9dUGpyqmVcmq1qnJBx3tRGHePCPbbJGxi3+4bjYVXF3pSFwRTYxeqBHu
 9V9hkjmbsfGAg68IxsKZ1ALQVqaLvjRJ3B7XB7jlSjDcBzsgMszXodb01NTT3uQzcflP
 hmcFoLl002n0uOcKEfpFBWu3eIsZji7xai3VJCv6L7VzdBdrsOro63nHqPUZw2RbmGFf
 pM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742208011; x=1742812811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wW7BpeS6NwWqYBb0CZFS4CHDMs5FrphFjSG0U6e+C/Y=;
 b=WwYfIdAZND2gPf0sI77A81U+0wF/OmUp19AyWFit9+14imY6V2JgRiMjlzUbpqVjmV
 aoLjFQxL3WOIEi9l6987UfpSJ3KSC7T4E79IO2JnPNubvcv5v8VZ1xL88PjiNMrW+/BQ
 5fGBjy/WqMBafCod9FDiIzvH2OqtRR16hx6NzNgoDBrVXi2ilG+egZ80TZ95DFjfjaRy
 We3OSDjrp4ZEshWVUd/r1GksgHGu5e8jGQlEBkHBgvljKczANDSZTtWuadPXhf9LK4Hh
 ZWPwRfaPLbfH/x0D2ePf653l1hSzVpg3tUwQKqRMWIgvZHoIAiT7JnmrOWeDpIowX2r4
 JsUw==
X-Gm-Message-State: AOJu0YwPfviehQ1CG2BSs4MEDazW9AAJBxXAvIK3RPxzHEEI1xvdDHAW
 NsVxAO/wBMdvrlcWVylH/SEd+LG5A3sUx22WFsdEr4AOSN20tdUXyQaV8R2yOLEqDcAK6unIQOw
 M1+5bP1XIG+RXcE8VZiUu+jXiWG1dS9Iuhj7W1w==
X-Gm-Gg: ASbGncvsp3d1uamJDH/j+eToWOqay8ipXWFeJvuOPQovyzPy08VMvUXm/4Xqn1LPL/j
 aSosABfXM+5mmqSnPIXjqlhnbXOJtm9EnnlOmviw7fkLkJTQR5dlIQs3TXeY+lzzsCsxeCCWiAE
 M/Sdv3dq3xoUy0i9dSy7GNw25HXZo=
X-Google-Smtp-Source: AGHT+IECBUogY3XW7gFd5bqwy53OSMC5pztksgg7AmsVRu8n2vImGAE2+JpcmglxhdNoDftGXZ+S0Dl1bf9PC7tZiCw=
X-Received: by 2002:a67:c90e:0:b0:4c1:93df:e838 with SMTP id
 ada2fe7eead31-4c3832300fbmr5190991137.23.1742208011361; Mon, 17 Mar 2025
 03:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
 <72691528-b3cc-47be-a3ac-453710c6f906@amd.com>
In-Reply-To: <72691528-b3cc-47be-a3ac-453710c6f906@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 17 Mar 2025 16:10:00 +0530
X-Gm-Features: AQ5f1Jo323roe2LP0RSGzJLbY62c4mjFsHgFHzoL1c7Zm7FbxGHSYKxZG8HDZT0
Message-ID: <CADg8p95jm+SLY4jG5uQ7YdkhD01PWV-c6cM5+-B+FmcDutagpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cmd: fwu: Dump custom fields from mdata structure
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Mon, 17 Mar 2025 at 15:36, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Sughosh and Ilias,
>
> On 6/5/24 16:55, Michal Simek wrote:
> > The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> > data to the FWU metadata") added support for adding vendor data to mdata
> > structure but it is not visible anywhere that's why extend fwu command to
> > dump it.
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >
> > I am using this for some time to check various configurations that's why it
> > can be useful for others too.
> > Sughosh: Maybe there is better way how to dump it.
> > ---
> >   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> > index 9c048d69a131..ff6435505167 100644
> > --- a/cmd/fwu_mdata.c
> > +++ b/cmd/fwu_mdata.c
> > @@ -7,6 +7,7 @@
> >   #include <dm.h>
> >   #include <fwu.h>
> >   #include <fwu_mdata.h>
> > +#include <hexdump.h>
> >   #include <log.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> > @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
> >                              img_info->accepted == 0x1 ? "yes" : "no");
> >               }
> >       }
> > +
> > +     if (data->version == 2) {
> > +             struct fwu_mdata *mdata = data->fwu_mdata;
> > +             struct fwu_fw_store_desc *desc;
> > +             void *end;
> > +             u32 diff;
> > +
> > +             /*
> > +              * fwu_mdata defines only header that's why taking it as array
> > +              * which exactly point to image description location
> > +              */
> > +             desc = (struct fwu_fw_store_desc *)&mdata[1];
> > +
> > +             /* Number of entries is taken from for loop - variable i */
> > +             end = &desc->img_entry[i];
> > +             debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> > +
> > +             diff = data->metadata_size - ((void *)end - (void *)mdata);
> > +             if (diff) {
> > +                     printf("Custom fields covered by CRC 0x%x\n", diff);
> > +                     print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> > +                                          end, diff);
> > +             }
> > +     }
> >   }
> >
> >   int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
>
> Can you please take a look at this patch?

Apologies, this got completely missed. I will spend some time this
week on this. Thanks.

-sughosh
