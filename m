Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809E2C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C151889F8;
	Wed, 14 Aug 2024 14:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lGkrqgEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351F488A0D; Wed, 14 Aug 2024 14:40:23 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1DFC8899D
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b796667348so7360586d6.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723639219; x=1724244019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZD1+UCWnK/TsbPdXCstGrtLlqp2y1dWWafJp6RNKu08=;
 b=lGkrqgEl54ESkXeI2vO+zQOrRGnAUwhyFHyxnYyr2OAPJFai97R6WbsDgG7oEXEohS
 PirwV67Myb3iatFukAaY+dqffJyIMZJxXiAAnyaElDKK/tzufHFUDQ/0OG3PerqsmVl6
 sx+o16FLEu29CbkIjp4bTTEgy9U0UtSI9Bm8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723639219; x=1724244019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZD1+UCWnK/TsbPdXCstGrtLlqp2y1dWWafJp6RNKu08=;
 b=c3C6hxefAfvveMys+N2EC6Mols/AFuecdAxbFSc4b8iSE5GDzs3Vj0d142B87kzOPt
 hSdgzL7uVk/WESt31ErafXtXqWuI2Td/Z9Y76xfgjghd5OBxqkpXDrGElDyXF18lb825
 IqfI7+Jr8o9PK14d1f/pSC0BTANnzxdOkGclUDTSq6xGymTfEuYP2IdRqCvWs/bMVKWW
 hbLcy2A3rgtTb0QoBNuK+IAV4Xhw02s5AaW3TBu8cUFjD5LIzWMrsRQQUfRZK5kXkLfs
 840ZgYC4C+w7holQ2GV0XZMFZ27K2Q6VlT5Mn3yK30P4258GMgGGMnoDfdWDJxjcwe+F
 ZF+g==
X-Gm-Message-State: AOJu0YytD5lbfKUDeH9I5o+/FWrKAQFBqO3yjdvxJqsXpP9eYlG7eXhT
 hnRGRbi1BP5jcTu/n2yvHB5Zz8VAyDSEGWT6E+ygpSyF7D9QPmjyF5BkgpYZmGtmFZHbkUpF4hR
 aumWLDKu+eX5wERYcCQPS/6sNgKicLuq+TvlR8oZ4elGhj6E=
X-Google-Smtp-Source: AGHT+IExoRrKhvYXwikMK7yOORwfJU7Fc41dtX4r5N0OJm2VrzVFTlUmSkgCLSTEGtdizUqIIgXQcVdIeiyIeS24b9I=
X-Received: by 2002:a05:6214:419c:b0:6bb:9c82:6a31 with SMTP id
 6a1803df08f44-6bf5f9bb301mr30580826d6.12.1723639219456; Wed, 14 Aug 2024
 05:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-3-sjg@chromium.org>
 <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
In-Reply-To: <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 Aug 2024 06:40:08 -0600
Message-ID: <CAFLszThVpvHO8Jt2Mz1WB80=fDtYpzieo1eR4k2Jj=e37Gb87g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: Convert device_path allocation to use malloc()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Ilias,

On Wed, 14 Aug 2024 at 05:03, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 1 Aug 2024 at 20:36, Simon Glass <sjg@chromium.org> wrote:
> >
> > Currently this calls efi_alloc() which reserves a page for each
> > allocation and this can overwrite memory that will be used for reading
> > images.
> >
> > Switch the code to use malloc(), as with other parts of EFI, such as
> > efi_add_protocol().
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
>
> What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> ?

Yes, I reordered the patches in this series.

Regards,
Simon


>
> Thanks
> /Ilias
> >
> >  lib/efi_loader/efi_device_path.c         | 43 ++++++++++++------------
> >  lib/efi_loader/efi_device_path_to_text.c |  2 +-
> >  2 files changed, 22 insertions(+), 23 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > index 0f684590f22..47038e8e585 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -262,7 +262,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
> >         if (!dp)
> >                 return NULL;
> >
> > -       ndp = efi_alloc(sz);
> > +       ndp = malloc(sz);
> >         if (!ndp)
> >                 return NULL;
> >         memcpy(ndp, dp, sz);
> > @@ -315,7 +315,7 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> >                         end_size = 2 * sizeof(END);
> >                 else
> >                         end_size = sizeof(END);
> > -               p = efi_alloc(sz1 + sz2 + end_size);
> > +               p = malloc(sz1 + sz2 + end_size);
> >                 if (!p)
> >                         return NULL;
> >                 ret = p;
> > @@ -347,7 +347,7 @@ struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
> >                 ret = efi_dp_dup(dp);
> >         } else if (!dp) {
> >                 size_t sz = node->length;
> > -               void *p = efi_alloc(sz + sizeof(END));
> > +               void *p = malloc(sz + sizeof(END));
> >                 if (!p)
> >                         return NULL;
> >                 memcpy(p, node, sz);
> > @@ -356,7 +356,7 @@ struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
> >         } else {
> >                 /* both dp and node are non-null */
> >                 size_t sz = efi_dp_size(dp);
> > -               void *p = efi_alloc(sz + node->length + sizeof(END));
> > +               void *p = malloc(sz + node->length + sizeof(END));
> >                 if (!p)
> >                         return NULL;
> >                 memcpy(p, dp, sz);
> > @@ -377,7 +377,7 @@ struct efi_device_path *efi_dp_create_device_node(const u8 type,
> >         if (length < sizeof(struct efi_device_path))
> >                 return NULL;
> >
> > -       ret = efi_alloc(length);
> > +       ret = malloc(length);
> >         if (!ret)
> >                 return ret;
> >         ret->type = type;
> > @@ -399,7 +399,7 @@ struct efi_device_path *efi_dp_append_instance(
> >                 return efi_dp_dup(dpi);
> >         sz = efi_dp_size(dp);
> >         szi = efi_dp_instance_size(dpi);
> > -       p = efi_alloc(sz + szi + 2 * sizeof(END));
> > +       p = malloc(sz + szi + 2 * sizeof(END));
> >         if (!p)
> >                 return NULL;
> >         ret = p;
> > @@ -424,7 +424,7 @@ struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path **dp,
> >         if (!dp || !*dp)
> >                 return NULL;
> >         sz = efi_dp_instance_size(*dp);
> > -       p = efi_alloc(sz + sizeof(END));
> > +       p = malloc(sz + sizeof(END));
> >         if (!p)
> >                 return NULL;
> >         memcpy(p, *dp, sz + sizeof(END));
> > @@ -825,11 +825,11 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part)
> >  {
> >         void *buf, *start;
> >
> > -       start = buf = efi_alloc(dp_part_size(desc, part) + sizeof(END));
> > -       if (!buf)
> > +       start = malloc(dp_part_size(desc, part) + sizeof(END));
> > +       if (!start)
> >                 return NULL;
> >
> > -       buf = dp_part_fill(buf, desc, part);
> > +       buf = dp_part_fill(start, desc, part);
> >
> >         *((struct efi_device_path *)buf) = END;
> >
> > @@ -852,7 +852,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part)
> >                 dpsize = sizeof(struct efi_device_path_cdrom_path);
> >         else
> >                 dpsize = sizeof(struct efi_device_path_hard_drive_path);
> > -       buf = efi_alloc(dpsize);
> > +       buf = malloc(dpsize);
> >
> >         if (buf)
> >                 dp_part_node(buf, desc, part);
> > @@ -912,7 +912,7 @@ struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
> >         if (fpsize > U16_MAX)
> >                 return NULL;
> >
> > -       buf = efi_alloc(dpsize + fpsize + sizeof(END));
> > +       buf = malloc(dpsize + fpsize + sizeof(END));
> >         if (!buf)
> >                 return NULL;
> >
> > @@ -940,7 +940,7 @@ struct efi_device_path *efi_dp_from_uart(void)
> >         struct efi_device_path_uart *uart;
> >         size_t dpsize = dp_size(dm_root()) + sizeof(*uart) + sizeof(END);
> >
> > -       buf = efi_alloc(dpsize);
> > +       buf = malloc(dpsize);
> >         if (!buf)
> >                 return NULL;
> >         pos = dp_fill(buf, dm_root());
> > @@ -963,11 +963,11 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
> >
> >         dpsize += dp_size(eth_get_dev());
> >
> > -       start = buf = efi_alloc(dpsize + sizeof(END));
> > -       if (!buf)
> > +       start = malloc(dpsize + sizeof(END));
> > +       if (!start)
> >                 return NULL;
> >
> > -       buf = dp_fill(buf, eth_get_dev());
> > +       buf = dp_fill(start, eth_get_dev());
> >
> >         *((struct efi_device_path *)buf) = END;
> >
> > @@ -980,22 +980,21 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> >                                         uint64_t end_address)
> >  {
> >         struct efi_device_path_memory *mdp;
> > -       void *buf, *start;
> > +       void *start;
> >
> > -       start = buf = efi_alloc(sizeof(*mdp) + sizeof(END));
> > -       if (!buf)
> > +       start = malloc(sizeof(*mdp) + sizeof(END));
> > +       if (!start)
> >                 return NULL;
> >
> > -       mdp = buf;
> > +       mdp = start;
> >         mdp->dp.type = DEVICE_PATH_TYPE_HARDWARE_DEVICE;
> >         mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
> >         mdp->dp.length = sizeof(*mdp);
> >         mdp->memory_type = memory_type;
> >         mdp->start_address = start_address;
> >         mdp->end_address = end_address;
> > -       buf = &mdp[1];
> >
> > -       *((struct efi_device_path *)buf) = END;
> > +       *((struct efi_device_path *)&mdp[1]) = END;
> >
> >         return start;
> >  }
> > diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
> > index 0c7b30a26e7..4192581ac45 100644
> > --- a/lib/efi_loader/efi_device_path_to_text.c
> > +++ b/lib/efi_loader/efi_device_path_to_text.c
> > @@ -33,7 +33,7 @@ static u16 *efi_str_to_u16(char *str)
> >         u16 *out, *dst;
> >
> >         len = sizeof(u16) * (utf8_utf16_strlen(str) + 1);
> > -       out = efi_alloc(len);
> > +       out = malloc(len);
> >         if (!out)
> >                 return NULL;
> >         dst = out;
> > --
> > 2.34.1
> >
