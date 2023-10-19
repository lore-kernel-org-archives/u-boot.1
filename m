Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27070CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712198704A;
	Thu, 19 Oct 2023 16:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y1gqekfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C9687139; Thu, 19 Oct 2023 16:00:08 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2708704A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbee70so13438109a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697724003; x=1698328803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/LyUDEr8usbYAgZpiEHH6paAijr6CTRXYaUqAGZkkM=;
 b=Y1gqekfny4qqxDX7ZNDpVRjs0lmvnAaJy5iDD4r///QsRcRholISKF46LqgXHYB8HC
 gxBpwo//NiKrTHERhFjEaeahrdfyFtQOab2o+wOq1OqB0eHuqQFIj/boksNyCVFdycn7
 2uICZ9346kKTbfOCSGTcuFZUCXLlMOo5/cEZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724003; x=1698328803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/LyUDEr8usbYAgZpiEHH6paAijr6CTRXYaUqAGZkkM=;
 b=f8z5bqFXlAroLBGsHfOqQrTVBqSULD45ADy5cLikLHP1Ohy/ViQgxbAXoUwIHgc1cC
 nZu3uMJ9pLclSJMhNMJdar0FMPZG1yRs0uFHGYcTptecJKr/Y/ZOJJkXe/3TE1wacSy2
 J3xiZeYHXCRfKelSI9BnmL8UeYOccbBFmz1cTnx/ZWQKKzlqa0jmje3m2aF/BjKkDLAP
 hOMV0UQMEyRTO1NVEgTlCJKByhDxjZ7CB0BoYf3FQ6+zIEnI3b7kQ6G+cIzAlXX2ZWyE
 O8me0xifW84PKgi/boD7UvetCkit6FbT0HyvgtwYe+NDourEEBvS1x4xvCpRmKclLYsU
 3NCg==
X-Gm-Message-State: AOJu0YwOCgmqIeubPsJyF5M3edz1V/TBtPNQSi66cjCVNrvq4pmYgRI9
 h7XzIsuklhzIYvX4dr7s0aol4c7tCAqHtHJXeW7zMQ==
X-Google-Smtp-Source: AGHT+IFA3DXDTx9Z/gSIHOWRRnFj83JH0fezbcIo4ys1Yhq7ejjz9q9bL8pvdogYoXVCXhqiK9TRgwi1zC4wgR9amAA=
X-Received: by 2002:a17:906:4b10:b0:9bf:4e0b:fb0a with SMTP id
 y16-20020a1709064b1000b009bf4e0bfb0amr1290172eju.57.1697724003021; Thu, 19
 Oct 2023 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-5-sjg@chromium.org>
 <e1d4ae7e-2a48-432b-8895-0f469af39b4e@gmx.de>
In-Reply-To: <e1d4ae7e-2a48-432b-8895-0f469af39b4e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 07:59:51 -0600
Message-ID: <CAPnjgZ0Ya5qJiegbc9RZ42wykfyjKCp1av7gHEpg_dBUecaLug@mail.gmail.com>
Subject: Re: [PATCH v3 04/32] cmd: Add a few more dependencies on CMDLINE
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Wed, 18 Oct 2023 at 07:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/17/23 00:27, Simon Glass wrote:
> > Add this to some more commands to avoid build errors with sandbox.
> >
> > Note that this is a temporary solution to expose more problems. A later
> > patch puts these behind an 'if CMDLINE'
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Add an explation as to why this patch is here
> >
> >   cmd/Kconfig | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 5bc0a92d57ad..00a7f84bce99 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -231,6 +231,7 @@ menu "Boot commands"
> >
> >   config CMD_BOOTD
> >       bool "bootd"
> > +     depends on CMDLINE
>
> Why don't we simply use a single "if" for all commands?
> Adding the same dependency to 200+ commands does not feel right.
>
> If there is any CONFIG_CMD* that is needed without CMDLINE, then that
> code should move to lib/ or drivers/.

This is here to fix build failures at this point in the series.

One of the later patches does what you suggest (27 I think).

Regards,
Simon
