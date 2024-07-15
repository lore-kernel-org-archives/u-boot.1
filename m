Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93299C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DFE87D87;
	Mon, 15 Jul 2024 11:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TWL94slE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C6286BF1; Mon, 15 Jul 2024 11:31:47 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED3A87D87
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58b447c511eso5040908a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721035905; x=1721640705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OAsqEtAuXCMVb3p+k7l92XxJcUMIEKV/du/dp43mJrc=;
 b=TWL94slEwSCHy1UXOxZ+LkePe5fZDjkO/Qa+vbHYyzwKKT2jpvGVSX0UhoNtgGPiEQ
 jYGemBO/xFpmg/aEdOhmfRvqtd3xjTqUOGmmkbqUc+LO2F/z88VB0N22bccOJ5XWycdj
 WYu9sx1Wixug6LvMaBgjneC7Twfc72fZYMONlwi6GThOMGh24LppS3l1QsXW4uvB09ll
 Yy/dqJfJ6+JRUpubNns2io7gFv5ExBcJ7b1yXzMnWl+575lTcDehsIyvIky9skIIZxEV
 ySv951o8DdL34FC6lHCTNre+RrnsjIgTj8gqKUhOsPjgHtdz35YC2Xrz3skjfrGuS9KY
 XYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721035905; x=1721640705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OAsqEtAuXCMVb3p+k7l92XxJcUMIEKV/du/dp43mJrc=;
 b=iOA1iKH5hak5YJUB1B0ap52gG55KpF6zVXcEVeeJFRDkHHOehZaC0Dec4Ad2JJFkhY
 GP5Xj4Bz9nTjOYW8gCkZVGhVLEUfh+MmyKnhKf0EaRm6emd8eGXVwznLCaBHWiZm660M
 FM6PA2o8rFF+iPD4MKV+AsQ1Urk0JpSXW7eaczoxKz/SUXAY7jxV11ohamyROR7EzBPI
 t0aBb1Vz2XNPw165Hy+YA5MgjWVaHO/koP0eaKjuEO+ze1DUDZufp8wozQvD35IiukOK
 rNMLjpNvAQKmKn3iMum0L83p+DQV6jIW2j2pY9bY0rODc1Lqv9OCCj2BkU3lyei4+xil
 o4Rg==
X-Gm-Message-State: AOJu0YyvXtCsRIyCJzXASQ2PS9Y3Fmj4fXRBae3GhkefFdUoGo9QxelK
 LhphMQZ38Xrlrn4JACEv2RSpuvx59k+XSlg4tQFHiiRSyZU2Va5ka1Hj3q4seUlS8J1i5LU+Ytq
 qkuelpFtvqqtgY71WHTeluGTjXLV3vnMCGIrFoQ==
X-Google-Smtp-Source: AGHT+IFS27SRfDh+PXzQD0C5asi4sfwzNUKn1tJnUl4y2OM/U2hzeSMhGz7goF6WeDrfJ9UAV/eHQkF7BgsDuHEZBnk=
X-Received: by 2002:a05:6402:1286:b0:57d:4f47:d9ee with SMTP id
 4fb4d7f45d1cf-594bc7c88e8mr12141730a12.31.1721035904891; Mon, 15 Jul 2024
 02:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-10-sughosh.ganu@linaro.org>
 <CAFLszTiN1K4tazqaBBCS37VHVtJ0ise2RQC2AGaLKg1SMFj9JQ@mail.gmail.com>
In-Reply-To: <CAFLszTiN1K4tazqaBBCS37VHVtJ0ise2RQC2AGaLKg1SMFj9JQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 15:01:33 +0530
Message-ID: <CADg8p974419Rqisf0qwH46FVobDYsxuLjnD5UV4kGRPcK7_vCg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/48] lmb: remove call to lmb_init()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
>
> kHi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The LMB module will be changed to have persistent and global memory
> > maps of available and used memory. With this change, there won't be
> > any need to explicitly initialise the LMB memory maps. Remove the call
> > to the lmb_init() function.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >  arch/arm/mach-stm32mp/dram_init.c |  1 -
> >  board/xilinx/common/board.c       |  1 -
> >  drivers/iommu/apple_dart.c        |  1 -
> >  drivers/iommu/sandbox_iommu.c     |  1 -
> >  include/lmb.h                     |  1 -
> >  lib/lmb.c                         | 18 ------------------
> >  test/lib/lmb.c                    | 18 ------------------
> >  7 files changed, 41 deletions(-)
>
> I can't actually find the call to lmb_init(). Where is it?

Sorry, I do not understand this question. This patch removes the
lmb_init() definition, as well as calls to the function from the rest
of the files.

-sughosh

>
> Regards,
> Simon
