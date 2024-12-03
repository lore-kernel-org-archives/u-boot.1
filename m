Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59925E74AC0
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 15:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8DE893DB;
	Tue,  3 Dec 2024 16:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M/YyG2yL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F26893D6; Tue,  3 Dec 2024 16:53:41 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77877894D9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 16:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53de92be287so8474496e87.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733241219; x=1733846019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CdYdHmZfn6nVc8kwIG1MUEUoG4HxQf27LihD0+cevfQ=;
 b=M/YyG2yLl9z4auhdHQ0+EOedIo0xVBzYvydgTJS6e7kgREpaVuGn3e7fypzyjtytlH
 yj51y86aCkptsmb67wAC8uV1O8AX/Zlf/3fVus50v2FdFQQHaDCtieT+U8jNF9Tfid1I
 Q+OpL4HcXd1kTMjAuwMcIp1bP8P9U3DOru5es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241219; x=1733846019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdYdHmZfn6nVc8kwIG1MUEUoG4HxQf27LihD0+cevfQ=;
 b=gKH1N+LiZ/C5ixKbOEIey6hbQbU1Rqrs/lspVqafUmwTQ3n9HC9Mb4aov1Z6hYR66P
 0kEfujE698PTEjndnbh/4hoNev9bM+l9YhUDADN/6XwvT+5iwe43hw6VRICM90HxFQ3s
 WX2DMMTFYHPW0LRhk/oS/CyxMIsB/SFUQ+28mLSBsbTQpZ9GGHIkTaSzDmPN6R7rCfB8
 /k73N6hLBvN4pGN86XTqyCT538zM4oktykjqe+EKVHKW8i5CQpKWZ2C0E9975iKxGino
 h/7nilm0kcC29cuHVnZ65vXTLBLxlzaJWQ9dKmHCa7Iu/H+0mnH1DCw/Iedf5lD5j9DM
 YXBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIeAtq5i2OrkYCSUjwKiIWRPzvKBzdU/5xOlAls2rCtesi7gcFt3OLBi3RIuuNuStHQ2z5uz0=@lists.denx.de
X-Gm-Message-State: AOJu0YycDbS0DPxcnWiGsNo1cBakGonIaMK+5iWjgHWFRz4CMv9Fks8d
 j4N1eD3CqCmewe/9Z9leezdndH11JKRCbpqD3WG8S6V0UJH+Tp2Ypg+DzML4rnrd/2MMizc4EvE
 qnqigfV4fHplhimbWkn4Sqfr7B4qbEbTJ/BgMZ0niR1wLZd8=
X-Gm-Gg: ASbGncvCJ9nK21X52CFxhsI+c/y0Egixk7rUvDo5PzZvSGqggYvAuCcp1jTHZlYsEIx
 NUn8LHTkHMUvHJSXwPqa9ljzCGtwvGLyF
X-Google-Smtp-Source: AGHT+IEm8WGVzhHGLrCYgnrPn/9BXrTR9ZvIEXVHqb8SAkOqtGEuISKx00NFEGQlz3WhSv0vTB7euW5gN/AQMYrH5/A=
X-Received: by 2002:a05:6512:400e:b0:53d:e324:11d8 with SMTP id
 2adb3069b0e04-53e129ff095mr2472705e87.18.1733241218713; Tue, 03 Dec 2024
 07:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
In-Reply-To: <20241203140133.GT2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 08:53:27 -0700
Message-ID: <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
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

Hi Tom,

On Tue, 3 Dec 2024 at 07:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 06:46:27AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 02, 2024 at 05:22:35PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > > This stops coral, bob and kevin from booting.
> > > > > > >
> > > > > > > The correct way to do this was always to use a Kconfig option, so let's
> > > > > > > first revert this broken idea.
> > > > > > >
> > > > > > > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> > > > > > do you have more information on why they don't work for a few boards?
> > > > > > Maybe the way to handle these logic within certain boards should be
> > > > > > changed other than to revert this?
> > > > >
> > > > > Yes, I'd like to understand the whole problem better since we had a
> > > > > forever-and-ever thread, compromised to what's in tree now and now you
> > > > > want to revert the compromise and bring is back to what was argued
> > > > > against for forever-and-ever, at least from a very quick read.
> > > >
> > > > I'm sorry but I believe I have explained the problem in that forever
> > > > and-ever thread, so I don't really want to re-run it. It may be that I
> > > > was right all along?
> > >
> > > Or maybe your use case is still badly explained, and your changes will
> > > instead break other platforms.
> > >
> > > > Raymond, I cannot pass the DT in the bloblist from TPL to SPL on x86.
> > > > There is not enough cache-as-RAM, for a start. Plus the DT is in the
> > > > memory-mapped SPI flash, so it makes no sense...
> > >
> > > DT using x86 is a pretty odd case. I don't recall if you mentioned that
> > > before, and it's likely everyone else assumed you were talking about
> > > something more standard. Of course, you're listing one x86 platform and
> > > two ARM platforms as needing this change. Non-chromebook Rockchip isn't
> > > generally broken (or several other people would be complaining).
> > >
> > > So something that may or may not be explained in the longer older
> > > threads is how the firmware in these platforms are doing anything with
> > > the device tree?
> > >
> > > But, the biggest problem I see with this portion of the series is that
> > > patch #4 is 'Revert "fdt: Allow the devicetree to come from a bloblist"'
> > > and patch #5 is "fdt: Allow the devicetree to come from a bloblist".
> > > What you need to do instead is squash all 3 of these in to one commit
> > > and then write a new message that explains what exactly you are
> > > changing, and why, instead of making someone else do that in order to
> > > review  your changes here.
> >
> > As I said, I do not wish to go through all of that again. It is still
> > a bad memory every though it was a year ago. I would like to build on
> > what I have here, to resolve any future breakages.
>
> Sure, then you need to post something that's reviewable, like I
> suggested.

It is quite reviewable. It is just a revert. I am not expecting you or
Linaro to agree with it, but I am confident it is correct.

Regards,
Simon
