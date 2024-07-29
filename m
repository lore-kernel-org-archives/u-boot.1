Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1637C49EA1
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A9988808;
	Mon, 29 Jul 2024 17:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MT2I1/YT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C889188808; Mon, 29 Jul 2024 17:28:03 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997F08785E
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-66498fd4f91so20373687b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266880; x=1722871680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aCcH5DHV+Tdb6t9Sbb/d2Wkfr6ZUusgdGul9MD3vD6M=;
 b=MT2I1/YTecJTDKilyorXSpU/xb4E9ej+WxhF/UA9A5uW7VAx7kz9bSkMQrS5scJ02P
 +PMLo8P/Zbz771qbl5g4CyAMxR3B9nlYL0T03n3UDV45nInR5t4wQ3CIzS0YFgUluyjI
 DFJ4RevNaFzhJq8amyd3njDfuYDgM2aLh6ZKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266880; x=1722871680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCcH5DHV+Tdb6t9Sbb/d2Wkfr6ZUusgdGul9MD3vD6M=;
 b=bQO25RR/RHbUWQRi5j4Ezm6n25sRsBCMxO015LUg8tMy8JY16I5j5b0qaDHjylJGNH
 V2kXA7rzIWSpZXT5iwd6ZGhjzq0VUGivKZrCmWuqQUlI/aGRIbSEcfLe3eYOStKIxpiW
 yEEffgpY8nEhCB6fxNwnEu+39hQPJjRD5v5id3qWLiAsMOk49YUyM8Pisp1gOkh9vWeu
 6SgILZ4UPz9qRd+als1sGMtJqqhAmRSIts1ZbW2JsN8B4CWZxT5K+8dLlUrmWqYPaq1y
 W1K0+LHh04hv7+MS+LvrfGW0UX4HaIsN1puqq1w1x9O4aI/6x2pZq/84W2mV4NK1VxKX
 8ARQ==
X-Gm-Message-State: AOJu0YwIe/ugO8CloPJfF+Yh3K8CbsbwlFPmdm1KFJlN0wJrirZZ8Hd4
 rMlU5hYhI05X6SMl7bHj2aCkNmTN65xa9IOHdB1LiOhcYV/49zB+mG1VmaRnFgGF1ov9XCoCmVO
 hFvQLXnwYm3DJom6PIbNEZ8sltjDNRtVkwsc/
X-Google-Smtp-Source: AGHT+IFzBlHt8SvrgSZNahc4L1lHonFIRcXmfusaoXPsFB/8zYGkYHXyRhjKEBnfpb2gIWfVa6xd3yq6KJloq6WVtNA=
X-Received: by 2002:a05:6902:1889:b0:e05:f3da:6583 with SMTP id
 3f1490d57ef6-e0b5459b70emr8622271276.43.1722266880486; Mon, 29 Jul 2024
 08:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-26-sughosh.ganu@linaro.org>
 <CAFLszTg+5teQs4m++hX2wEDh1O7wTjPSK-2ogceFv1R=N_dz-A@mail.gmail.com>
 <CADg8p97svCoSq+2dz6tUYBGssn=-BNLQGGxgco_kUPzcf2Xa4Q@mail.gmail.com>
In-Reply-To: <CADg8p97svCoSq+2dz6tUYBGssn=-BNLQGGxgco_kUPzcf2Xa4Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:27:49 -0600
Message-ID: <CAFLszThsN+mJ2SQOBdEDEy0BZN82siVh7agp-6hKq7g5wM_JQQ@mail.gmail.com>
Subject: Re: [PATCH 25/40] sandbox: move the TCG event log to the start of ram
 memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 02:45, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The TCG event log buffer is being set at the end of ram memory. This
> > > region of memory is to be reserved as LMB_NOMAP memory in the LMB
> > > memory map. The current location of this buffer overlaps with the
> > > memory region reserved for the U-Boot image, which is at the top of
> > > the usable memory. This worked earlier as the LMB memory map was not
> > > global but caller specific, but fails now because of the overlap. Move
> > > the TCG event log buffer to the start of the ram memory region
> > > instead.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: New patch
> > >
> > >  arch/sandbox/dts/test.dts | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > > index 5fb5eac862..1e1e9eaeb5 100644
> > > --- a/arch/sandbox/dts/test.dts
> > > +++ b/arch/sandbox/dts/test.dts
> > > @@ -78,7 +78,7 @@
> > >
> > >                 event_log: tcg_event_log {
> > >                         no-map;
> > > -                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
> > > +                       reg = <(CFG_SYS_SDRAM_BASE + 0x1000) 0x2000>;
> > >                 };
> > >         };
> > >
> > > --
> > > 2.34.1
> > >
> >
> > It looks like this will conflict.
>
> Can you please elaborate a bit here. I am not saying that I am not
> open to a different solution, but I did not get any CI errors with
> this change.
>
> >
> > Please check and update the memory map at the end of
> > doc/arch/sandbox/sandbox.rst

The address you are choosing is too low in memory...move it above the
FDT and bloblist.

> >
> > Separate from this patch, I really think the TCG event log should go
> > in a bloblist. I can have a crack at that if you like.
>
> That can be taken up as a separate activity.

Regards,
Simon
