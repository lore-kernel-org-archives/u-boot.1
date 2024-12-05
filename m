Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9C5E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55EFA89532;
	Thu,  5 Dec 2024 20:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J+zKdUBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB768952C; Thu,  5 Dec 2024 20:55:15 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB2489040
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cfa1ec3b94so1473733a12.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428512; x=1734033312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Akjgs1gIcd6slZ8d7VOAZrUAQg1Hf1Zfigk+UhXi86g=;
 b=J+zKdUBjBvooKIxz9WxXxoqC9uPSP4pj+pr2RuQ4rcw+QOtc5Rc+5saOAs523vqzB+
 w4A+6R35C3P1C91QSdNOxSp+KlvyOmxjijcTz078TzvDSGyX+46f3i8+j/TpWQKzmRUF
 JdOk4ID0J1Pzxl4+B9Wx9F/SmEmFxEDJox0iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428512; x=1734033312;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Akjgs1gIcd6slZ8d7VOAZrUAQg1Hf1Zfigk+UhXi86g=;
 b=EDL1X44jhI4qJjjDtNe/VetfQp/gzcx4ZR/1oi+eh2s1uhHeQW2VtlHFAV6XgG+S2v
 HRyGUm6+f9IGh1JJ0kFzswaWKgwkOiBEi1q63E31EPvMcPIvZ4hJrkR5HrZvkJZku1lW
 Bb+24KA9HiIMSc+xgEEiEQJsn6Bh7qOgIU0/jACU+lZDCoGvQDteVJ4tGLlpqLvkLvX3
 J8QYJUM0xGlqGi53PBPUcn8apo4qVb3DivkT1nTZXctiYNj/HwH7NEA29B0xoAR+YV9Q
 PUW6LoecPOSKNYPrUf49YOYfuKXGwzEPoJfK+TTIGvZwA/QZ8csgbnUsRD5NeJNHj0Jg
 09iQ==
X-Gm-Message-State: AOJu0Yy5DaVq9Y593n6xZNOykP0ayfDJU7WUB9A6OLAU7p/v9jgjWS2n
 7r/4au/W4LKFuUOote68ekg1jarWjLvGmY0LnGbcHzNavzcU2bXQJzcHDjvoWSg/tfqescS4r14
 qwfvODt1FeNgBdd20cu78uEn4ki05yplq0F+7
X-Gm-Gg: ASbGncvCCThfgxjXS2w9sxsZQzQIy+vf9zQJMYc0VxRn54z1+Qt2sdiVUT60SGSryOV
 Ch3t5csQ+444W3xFnznbyS+26h4ozlGhL
X-Google-Smtp-Source: AGHT+IE/Q/iH3khzFm0kZ4ixMZys6bGL1xe5fuLPLsK6h6q7EltHEamo1/HFTWD0cJDu9ZTgLAXQkRI68Kn/B7UGg9w=
X-Received: by 2002:a17:906:23e2:b0:aa5:46b6:4344 with SMTP id
 a640c23a62f3a-aa63a37b46bmr5421466b.58.1733428512609; Thu, 05 Dec 2024
 11:55:12 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:11 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241203200746.GA2457179@bill-the-cat>
References: <20241203200746.GA2457179@bill-the-cat>
 <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-6-sjg@chromium.org>
 <20241201164810.GT3600562@bill-the-cat>
 <CAFLszTiLxRdLZb3mykH6L5DLQwL2N+-TiKAzH+aDtGpWa4O46g@mail.gmail.com>
Date: Thu, 5 Dec 2024 13:55:11 -0600
X-Google-Sender-Auth: oGOWDqC9Qw1hjgTSOArR1ouWXXY
Message-ID: <CAFLszThw4=H5G5rqN7Nt8_41sLEkZm1iFMfx4LNqxwYkt=_ZNA@mail.gmail.com>
Subject: Re: [PATCH 5/8] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>, Simon Glass <sjg@chromium.org>
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

On Tue, Dec 03, 2024 at 12:45:12PM -0700, Simon Glass wrote:
> Hi Tom,
>
> On Sun, 1 Dec 2024 at 09:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 07:42:33AM -0700, Simon Glass wrote:
> > > Standard passage provides for a bloblist to be passed from one firmware
> > > phase to the next. That can be used to pass the devicetree along as well.
> > > Add an option to support this.
> > >
> > > Tests for this will be added as part of the Universal Payload work.
> > >
> > > Note: This is the correct way to deal with bloblist, since it allows
> > > boards to choose whether they want to use the devicetree from there, or
> > > not.
> > >
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221671-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228133654.2356023-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228194725.2482268-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20240104014919.413568-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20230921015730.1511373-31-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/
> >
> > You should
> > %s#https://patchwork.ozlabs.org/project/uboot/patch#https://lore.kernel.org/u-boot
> > all of these Links, aside from shorter, it's on much more broadly
> > distributed infrastructure. And this is a general comment as well.
> >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/bloblist.c                  |  1 +
> > >  doc/develop/devicetree/control.rst |  3 ++
> > >  dts/Kconfig                        |  8 ++++++
> > >  include/fdtdec.h                   |  3 +-
> > >  lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
> > >  5 files changed, 46 insertions(+), 13 deletions(-)
> >
> > The rest of this, I need to think on.
>
> It sounds like you have thought about this, and come to the conclusion
> that the reverts are not going in. So, for simplicity I'll leave this
> patch as is and make a note to use 'lore' in future. I wonder if there
> is an easy way to convert between lore and patchwork?

Both lore (always) and patchwork (for a while, maybe a year or more
now?) use the message-id in the URL, at the end even.

-- 
Tom

Applied to ci/master, thanks!
