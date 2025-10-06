Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8ACCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 23:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09ACE83ACD;
	Tue,  7 Oct 2025 01:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W4l9EALF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E8C83ACA; Tue,  7 Oct 2025 01:30:38 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3EF83929
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6399706fd3cso3087099a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759793436; x=1760398236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FVfw0/jfm4Fz223qX9pUn0Dyr11ae4SGRfqByTv4uTA=;
 b=W4l9EALFtZHEYsqxu5UnE81sgV7Kf0IMBFIQGp5mi/e9pEy6oiaPHwMptQd4+a3P5G
 gf1oGzDLejklKL1yL8pagHN5V0GJja4VtLh/Aw3KZyRXhHhitQiWc+UmrgyiBlnvJJI0
 g3ivIiiF/A7adhQrbqhks2AWBsCJY0VYuEq74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759793436; x=1760398236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVfw0/jfm4Fz223qX9pUn0Dyr11ae4SGRfqByTv4uTA=;
 b=dZU8ZDkNTdHFIbKlCK1Hboxyc7qUmVQ2T6JC5cZ2f+++gANkZc/0R0T5CCCkB8Q3Wf
 X9UJFFMPuaQkI1dX4jr+JOqXxmva4rnkVtT8aoYJrKhYsg1jt7AvgeMa+NLgrv9R3wTr
 yJbKzlbfJZ/hgJo78bq02vndIot3GCfcsozYbZ365mlpDWz8rLbM0VvT+41BNPJHIRxv
 WvVHugqV3ByxlOa0V37/zawhI8Am5q+ccXJJldUCQgjGnpTwJlW1czWVf2roPZdS/Rzh
 oqmhyX3cL7sYpNk+mI4ttrPfuytNVfXoxN8+98B/mstm0wMzoe0XgG7Elm3jL+3lG/tk
 MKIg==
X-Gm-Message-State: AOJu0YwO56vwV6L+LOvl/Ew8SGKXdCDCGIWVSjbURQl6JhA/HdYsWmav
 Uk2LFeMzGmBLwjvUQiP+fSxjIUIb8RdwYEKydjOSAt3IpeT1uEl3jIXsO14W4C5xoeYbRPInsUW
 3eWv1ewBPoMZm2h0Cqy6UHtQHBZY+aIOWsiQFgt1G
X-Gm-Gg: ASbGncvV1ybECVtdbP9XTA9mFKp8jZw2PCykcYx7upG35W+kK8wAvcCFam8zZCpbXZs
 UcPq1QJB6VNbescl8lExmvx3j5t25lNhhCCWSeNFpHyYBoyJEa1xbG+epiUV1cyMc4NbRm9g1Dy
 zKh+G6UWYQBiOqt9QNFBJ8Qz9tO9+AXxG9v2XuSyNHG7SfUKmkInv37jv2sT71H33wlnN1I8XGV
 GNoK3RytQHIQzNnuLXEX1DEUERf82mq
X-Google-Smtp-Source: AGHT+IEh1i7YRxllYsfHmFtR/A9L/dMR+D7NyhlwjD2JKk8VMWmsWXJ3NuqsHyAIZmg6U3Vh51jFHFjwK9oEMKQ0AfU=
X-Received: by 2002:a05:6402:2110:b0:637:e2b8:605b with SMTP id
 4fb4d7f45d1cf-639346c7b36mr14673041a12.5.1759793436321; Mon, 06 Oct 2025
 16:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
In-Reply-To: <20251002201537.GO6093@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 17:30:23 -0600
X-Gm-Features: AS18NWCacvCqILYWjcVkq5x6FeKnTo1us1gRYfdiW4qTlNm9mae-1gGAy2yEN5I
Message-ID: <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
>
> > It is helpful in tests to be able to show the bootflow that is being
> > examined. Move show_bootflow() into boot/ and rename it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add a log_err() for an invalid state
> >
> >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
> >  cmd/bootflow.c     | 68 ++--------------------------------------------
> >  include/bootflow.h |  9 ++++++
> >  3 files changed, 69 insertions(+), 65 deletions(-)
> [snip]
> > +     case BOOTFLOWST_COUNT:
> > +             log_err("Unexpected boot value of bootflow error %d",
> > +                      bflow->state);
>
> A small thing, checkpatch.pl catches that this isn't aligned with the '('
> here as it should be.

OK. I'm unsure whether I really want this line anyway, since it
increases code size.

>
> A larger thing, and please correct me if I'm wrong, but on reading the
> whole set of changes, this move + rename just means we're putting more
> info in the test output, and nothing else?

It will also appear if you have CONFIG BOOTSTD_FULL and use 'bootflow
list' or 'bootflow scan -l'.

Regards.

Simon
