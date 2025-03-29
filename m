Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC84C36011
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB38805C8;
	Sat, 29 Mar 2025 01:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XXy+z7XR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AB0809A5; Sat, 29 Mar 2025 01:51:28 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01AA6800C1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3014678689aso4010199a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743209483; x=1743814283; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UILaXqflMVDqNHVKtGrBcvmJl2KA17GkCPo9J170qsY=;
 b=XXy+z7XR81Pmd0KgYBVPVbtFBaOI3s1xdio8w7hi62uaxFuIPlre/5dBRopYwJUucz
 ckvBIkWDEAEGymysooSvzyNO1+I3xZc6oAeUDxqqVfomkPFfC7eswpNaSZTciWGg3yzs
 oYG7G3hHkM4ExTJBX3hvwmAApBcXFEavjZI3s0plo0/MDI+2Lnm59OLQ8jGAk2Z4FF/c
 XQ6/NFma2lxqeb3YsWYhKLxsczb0ds5uLPU9DI9Ur1oj2O58ObnkYmtYugN9X608FrCZ
 n4Adg5qkkVFBMp2Jj+ZppMCIQaYuX8beuy0FIcMEkCT9+Z2fys/hZZbohBfIccXtRZJh
 DDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743209483; x=1743814283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UILaXqflMVDqNHVKtGrBcvmJl2KA17GkCPo9J170qsY=;
 b=U1X9xsLmovPiUAAROoiMhgr+QoN5Ws+P7tyY/CCS5znzmxh5/mKHKCqZEY9+9eYkN0
 M/UcNHyzqvYbetS0IvvfK4/XDCBoCu2KNvezcYEC5deVhJlh+NAzMSBDbvW81iVve4/2
 B3AwJWCmae0woQWM2iB3TN2iWCDJGYpgfBvE3fGK9hjOv/RgPa10VtngHJl3wq7U8NaT
 OOAA7hJK7Y+mKIFwm/XABPoV0za5MrGloAR+4k0RG0NbCDz3RfoTXKiNb4fYJpHQrUBW
 whpCWxeo0kDN7t89iAh1OuOVrvxKJBY2cDBxeZEskMGhXeIFCJX4pBjsgwejoN9XRJLx
 Fr3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXer6vMUgg934QKr/hd2Nn7Tnw9AQvI4YSS7sRLmwz5zmtUl934La4WVryWCGNCc6DzavpbKgQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7hO2BvqtuowbYxyNlZlrUW0VLRZzfLGSkWNNrG5R1BKo2CgSo
 3UQwUxkckw0d1so3ODV7hsWL7mpCcG5VaCK4vUxNGJ2wRxzc/H6zBcea8P3ZKuMmEur3L5ScWE8
 dr/jMsiOkS1iVGoTfRD/tZPBzN8MwtRKYXjVaiQ==
X-Gm-Gg: ASbGncs/23jXGLf/YHhVCjsTC16kq/dw5BUCQEpp52WeqsqUfMqvFci14PcLpccrWZw
 wZQGhIj0L2nCOXfOuSFZ7e81f80lLIQwhGONGN9jssrEIRG/3yXWVfQ7TZfP1GiQ74VwUBXkF6R
 IUZxcliukZYxnWRH5KqbcaKXY1M8d5
X-Google-Smtp-Source: AGHT+IEcdntANzNEmS9KE/lQ9a/oTKMyAL7RGdttXu6X+7/Gt6C+u0Z0WxfqUD5wMsqF4YmA3R9QNmNqbqJBHs63+mg=
X-Received: by 2002:a17:90b:5208:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-30531e8c86bmr2509988a91.0.1743209483515; Fri, 28 Mar 2025
 17:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
 <CAEfUkULhW6fi9119WwTuUq__77Ga_ORcDpXsDzh+vs73QZmbkQ@mail.gmail.com>
 <CAFLszTiXypPhg1RXng7P6CV9xLAEuSMg4B+gjr0c53a0SvS3sQ@mail.gmail.com>
 <20250329000353.GI93000@bill-the-cat>
In-Reply-To: <20250329000353.GI93000@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 20:51:09 -0400
X-Gm-Features: AQ5f1Jq0MWiF6LueR07LRn4AlgNOOOZO4HovTPdIAAKxEhHURKwXwihpeUCuito
Message-ID: <CAEfUkULKfcU+N0WZMQBwvkGhGe6XnTASr4=bHiGXY3XrufPtCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom and Simon,

On Fri, 28 Mar 2025 at 20:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 11:39:13PM +0000, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Fri, 28 Mar 2025 at 09:06, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 28 Mar 2025 at 07:35, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > > > > is a default address for bootefi, bootm and booti to look for the
> > > > > device tree when launching the kernel.
> > > >
> > > > I wonder if we can drop use of that environment variable at some
> > > > point? It seems strange to set a variable to gd->fdt_addr only to use
> > > > it later. Why not just use gd->fdt_addr ?
> > > >
> > >
> > > First, the fdtdec happens in an early stage and it is not able to set
> > > the env variable at that time.
> >
> > No, I mean actually drop use of the environment var, so we wouldn't
> > set it at all.
>
> The environment is for humans and also other use cases. It's not going
> away.
>

Since fdt_addr is used as a part of boot command in numerous projects,
and it is a reality that "a fdt via bloblist" and "boot cmd with
fdt_addr" can coexist if we cannot drop the env var from the boot
command.
This patch is trying to solve this in a compatible way, allowing users
to pass a fdt_addr as a reference DT address, but U-Boot prioritizes
on the fdt from bloblist if it exists - the var fdt_addr is treated as
the final fdt address for kernel.
I think we can add some documentation to describe this further, but
generally I think the approach is simple and reasonable.

Regards,
Raymond

> --
> Tom
