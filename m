Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E3C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838FD80548;
	Thu, 13 Mar 2025 08:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SEYsC+0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8517A8168B; Thu, 13 Mar 2025 08:35:51 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5358980540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-523d8c024dfso256140e0c.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741851344; x=1742456144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m74cjY7unjOhibpejNgGlnZJE3gD6e7/C4L2S3JoUjI=;
 b=SEYsC+0jXwaJPNIpLSBGsA+nY39cmVrMnal44vgzOJqzCr9IoXwAuBhKCgJM9wF3ea
 1q9SmnNjuQewm6jbSlndQTE9EuB1GsyaVtTJbew/epGPNdWzkuzrc+ecO5LmOzNEpyhg
 EADnO+2SIJqUfhLYHdX1rQ7JziHUKWKAJ0zEx9nNGYHRH8EbVY+HUQQLpyxT1Sv3+1F0
 9FdReWAevb9uyKZb4Md2R7S7KIl83ipOS0vZLSOL9a7HFIEwMtXRjzospxpE/Xn+ekJi
 qHNMOWUoNbMRCNTSpwUt1U8LpDpHUvO5SfnubB5wsSpugUgydXO4YyFqS09J5ouj94T5
 COzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741851344; x=1742456144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m74cjY7unjOhibpejNgGlnZJE3gD6e7/C4L2S3JoUjI=;
 b=PFqK1VIuRxGaVqpsRGw/8g/qa0dL3f5Vx8qHAtDjGtkElslrZv+V54KqHVhxetYP9J
 iETJP+TlsgUU7B2UzI+9xssgxOjbVpFv+M3mefB4A0qekUaCp7zOiC/7gFLr7SAddK0S
 2PXug5hNgXMDlCMSbC+N9OOYI+qerindzctMVvsYiG2CksSQh5GiDFR2kbSF0yB36PXV
 r0cp4FaXVj2w2zc3PnIZ4tL6rPgGKihskDwwGhvmZFfv9QvqzJot9A3ha9eEdYs3oBNo
 9HIeL7vlfy8BgMaMxi8FaG77r5dvzHN/55JHr78tqFdlh4tSn5Kk1fzZ3HyBXTuCimvD
 L1Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZHBxVIW2NWgPJMP1//N43630yGubk36M5DMHTZn7GIACeDzeH1tNEsYrPp3zt78F8rYij/7U=@lists.denx.de
X-Gm-Message-State: AOJu0Yxm5czc8qKJ7CMbooOTy1lwPVJu+T8TpM+sOSzrOIyth5hAMGOh
 V+6mWNR6AHxokSXVSEDCzBw9ziWrcGAUK+hZZwYfaHtiAwUpMG1izYpAG+LegOhAyCA3ieeIjS8
 Hj0Z3poA1gIImSPZECVcA6u0bsD0eB7HxTJdz8g==
X-Gm-Gg: ASbGncuoxk1+PIZli8M+6HlhGlQSOarC7+0+u3qDVoTSitakFU6kl6kW/U9p7tL7b/J
 i1Dga3/wkFzLM+9eR33azdz9EpvtD7KO586V7uo/o6Yt/RSZ57D3wQ/L1sVsaqLxgbJYGIUQLC5
 oftFG66RuNQ+TLVcPeBJxAMxE7xq8=
X-Google-Smtp-Source: AGHT+IFWw29px39cma5Lu/X/WuHAR2mpL/UPYiMOtBIG30GGvwhBzlyeR5/LLl5MVdgXg532ut/Tj7jdU90OQT4f5Mc=
X-Received: by 2002:a05:6102:6056:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4c364bda24fmr6099107137.11.1741851344262; Thu, 13 Mar 2025
 00:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-7-sughosh.ganu@linaro.org>
 <6e801422-2cbf-4a66-892e-02091cb563a5@canonical.com>
In-Reply-To: <6e801422-2cbf-4a66-892e-02091cb563a5@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 13:05:33 +0530
X-Gm-Features: AQ5f1Jr8clpyKdavz4OXDaDCYRWPcKWWSrovJIKdxXIQO5lNXeulZGhl2jfnaHg
Message-ID: <CADg8p9711mRNbBc_ko8jm_qg8pPPQ0eRAcLwFZ0Og_jO2TXsLg@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] blkmap: store type of blkmap slice in
 corresponding structure
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
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

On Thu, 13 Mar 2025 at 02:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > Add information about the type of blkmap slice as an attribute in the
>
> %s/blkmap slice/blkmap slices/

Will change

>
> > corresponding slice structure. Put information in the blkmap slice
> > structure to identify if it is associated with a memory or linear
> > mapped device. Which can then be used to take specific action based on
> > the type of the blkmap slice.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since V7: None
> >
> >   drivers/block/blkmap.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> > index 34eed1380dc..453510cca62 100644
> > --- a/drivers/block/blkmap.c
> > +++ b/drivers/block/blkmap.c
> > @@ -16,6 +16,10 @@
> >
> >   struct blkmap;
> >
> > +/* Attributes of blkmap slice */
>
> Please, provide a description of the constants in Sphinx style
> explaining what linear and and memory slices are.

Okay

-sughosh

>
> Cf.
> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation
>
> Best regards
>
> Heinrich
>
> > +#define BLKMAP_SLICE_LINEAR  BIT(0)
> > +#define BLKMAP_SLICE_MEM     BIT(1)
> > +
> >   /**
> >    * struct blkmap_slice - Region mapped to a blkmap
> >    *
> > @@ -25,12 +29,14 @@ struct blkmap;
> >    * @node: List node used to associate this slice with a blkmap
> >    * @blknr: Start block number of the mapping
> >    * @blkcnt: Number of blocks covered by this mapping
> > + * @attr: Attributes of blkmap slice
> >    */
> >   struct blkmap_slice {
> >       struct list_head node;
> >
> >       lbaint_t blknr;
> >       lbaint_t blkcnt;
> > +     uint     attr;
> >
> >       /**
> >        * @read: - Read from slice
> > @@ -169,6 +175,7 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >               .slice = {
> >                       .blknr = blknr,
> >                       .blkcnt = blkcnt,
> > +                     .attr = BLKMAP_SLICE_LINEAR,
> >
> >                       .read = blkmap_linear_read,
> >                       .write = blkmap_linear_write,
> > @@ -248,6 +255,7 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >               .slice = {
> >                       .blknr = blknr,
> >                       .blkcnt = blkcnt,
> > +                     .attr = BLKMAP_SLICE_MEM,
> >
> >                       .read = blkmap_mem_read,
> >                       .write = blkmap_mem_write,
>
