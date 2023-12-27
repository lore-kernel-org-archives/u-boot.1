Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC02C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D318775F;
	Wed, 27 Dec 2023 16:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J+f9Fwc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90488775F; Wed, 27 Dec 2023 16:15:05 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D308761B
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28c23a0df1eso1244282a91.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703690100; x=1704294900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UGF6zh1kO8zzasuZj4+XQ+MQIgUg9eDJwgDTX334Tbo=;
 b=J+f9Fwc6Tg702ZwMJkPVGosHuRfgka1SWHEcmXqtP/GTv1AirC+3lLr3KsQUA3THc/
 VGam1YSAGL3za+Z6M66/oHDLHDmxW7u3eLP1GQqZkheisCyAzErdqCGtA6avBV1MCGh7
 Qjfd0JKzaAzvxs1rSzkUVNhTI35YTnvsXwJFrw6uzzETiK+oyHUFKuvy46M4nXzjg6UL
 3fFhg8iz+DkWIdUxKsX5mmVYRbG+YIhBv4gbnQLbqKDn5mQibQqtxOATrMNfNLTyjhKV
 r6qtM7pu7gY+AIzSrjMHtB1gdD0btuuwvGAWLBMCL1wMzX8bAwOipet1bodmT8b9i5/r
 zVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703690100; x=1704294900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UGF6zh1kO8zzasuZj4+XQ+MQIgUg9eDJwgDTX334Tbo=;
 b=BYaNqkkqS31wptwKPrMJS9XTx9p04oHFX3Ef5H2/EjMg57laxIX0EpdOn0iEMAv+kZ
 zaFnVpiq1Z+f7QlO/GYkxma5pybr8N8Faco4OW9YKCQXGXtGBBHOSxTOs45zUY9fX1vT
 Kc704XoVVAuLlZZhmrrDZ5iYwYDaU65p+ZKlGIwYbtyDk/03vCz8bUvzFO+P6u6uZNg5
 8vRdAYOtgSNZ55nrDFgkkV9yYlBq7Xt+KcUQ+vE8LJzDngTpgH3EHd64Z38JtLOgV6ik
 hX1byzCcErFdJf5ac3PpEB5VFndC45hF5yc1qSk3kMPl0LjDr5BQsmcPGTSAcW1I+qKg
 lonQ==
X-Gm-Message-State: AOJu0Yyk0gzBgvsYIWhsi5Oy54i4ui583SrTxsBtwZAv+TMB31giyy4B
 H6bCsGVhYivPt/oS9hOEqI5JCbya+X3q4+Y/b/aLYU7JmIFxgQ==
X-Google-Smtp-Source: AGHT+IGSfMKdsAnN2Exff90y1vC7OQTPaCT8pzmziVVXJqN31442vD9qgAnzKKlWWUh3kL6Xb9qilOoQVNcFEcIVVYo=
X-Received: by 2002:a17:90a:f698:b0:28c:5a10:f327 with SMTP id
 cl24-20020a17090af69800b0028c5a10f327mr1134198pjb.56.1703690100631; Wed, 27
 Dec 2023 07:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-9-raymond.mao@linaro.org>
 <CAC_iWjKEQyE+nmj16QVBLjnP5k3Wv+g4kYxXXAkzx_tPPhparw@mail.gmail.com>
In-Reply-To: <CAC_iWjKEQyE+nmj16QVBLjnP5k3Wv+g4kYxXXAkzx_tPPhparw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:14:50 -0500
Message-ID: <CAEfUkULETcw60ooEd7OsUSnVvN4DbhK_Era9QrkrFP-7mdGuiQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] bloblist: Checksum the entire bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 27 Dec 2023 at 04:57, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Spec v0.9 specifies that the entire bloblist area is checksummed,
> > including unused portions. Update the code to follow this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  common/bloblist.c |  9 +--------
> >  test/bloblist.c   | 10 ++++++++--
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 32692d8319..705d9c6ae9 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -319,17 +319,10 @@ int bloblist_resize(uint tag, int new_size)
> >
> >  static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
> >  {
> > -       struct bloblist_rec *rec;
> >         u8 chksum;
> >
> > -       chksum = table_compute_checksum(hdr, hdr->hdr_size);
> > +       chksum = table_compute_checksum(hdr, hdr->alloced);
> >         chksum += hdr->chksum;
> > -       foreach_rec(rec, hdr) {
> > -               chksum -= table_compute_checksum((void *)rec,
> > -                                                rec_hdr_size(rec));
> > -               chksum -= table_compute_checksum((void *)rec +
> > -                                                rec_hdr_size(rec),
> rec->size);
> > -       }
>
> Why do we need patch #7 if it gets removed immediately after?
> Can't we just squash those two with a proper commit message, since the
> spec requires checksumming the entire list?
>
> Yes. I think #7 and #8 can be squashed into one patch.
Will do this in V4.

Regards,
Raymond
