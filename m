Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B40BCD6115
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB51386C2F;
	Wed, 11 Oct 2023 10:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q53VnU7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E26B86C33; Wed, 11 Oct 2023 10:29:50 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B3D86BA3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c77449a6daso56550985ad.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697012986; x=1697617786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tAzhSt60YtzX/q9oSoB0cVeVA5S2L/3himYhaYbGU4o=;
 b=Q53VnU7HOFEuCJIX9JzJzaSq2Y10O86P5etMoiRHBflqSecg1BdQOay4FVivHjIC/+
 DHPHlYeObEpOxT45PAIAIo+ETwGnQNg4URjEtRdIDGGw1HJvDAom5Yg4DTGXpZoD8Y0u
 O1hGaU/xJj5x6IA0060RT4cdLZYToCZYNAizdy6m976G1SJD+zRGgHmm8R+ozw1kWHwm
 uYJgmcqwNW8RQfijQHNG062wVc2PMFROw1t1oZiKbJVJd5Eol/gAHRLZMRYERWM9HnKD
 6mF8XWa7YaB//aIL77cQq7dsJjQMRCk4PI7PXrQ3vuJcW3BYqd8nXKIl3N4TINkMwXob
 De9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697012986; x=1697617786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAzhSt60YtzX/q9oSoB0cVeVA5S2L/3himYhaYbGU4o=;
 b=wlRPcotnXLc68/wiwthHAH8Ovd5fd6TclP/225YKyHFDIa2wd3rsjChh5hj0onprKG
 mzGLFKfWH72OsLXawA66bPrsiFYUdqsIGRNos2tb4fyTEmZt/+gOvtLqxYOqsEn7BQS0
 zDz+X/1BQSCl496L+lYvXlmjjA1i2rBRvFAVdZgOTZDb6q91/tJuhH1SG+ijUXx6J+Ow
 YPvRTBcUAFiUM/Za4TSTirmiy3h0kSHzc9g2TFYcQI+2ZIbgnDqeX1pw5FDN1HswcbJJ
 KReV1/UU3o1i/OPn0P4L+n5jaHskGB4PKePChFUmGskoWnxbzBsNjNxoqOsCJu1AM4id
 l7JQ==
X-Gm-Message-State: AOJu0Yz10pWohPlu00kxrN0lV6wDJel/tssmt/tWVxORREo5FMzB6Ni7
 u9SJ2JN0Hb4YoBGmgKYENZAbEbGe329TX4eppSlUqw==
X-Google-Smtp-Source: AGHT+IEQQVMeirxRN5eMFze/UHrljLgpTJdTdmacJJJzgMX1QiNs3wdUtz+NPTGQqFx3pGsmo98it/PQtmvD7Trm28s=
X-Received: by 2002:a17:90a:b888:b0:274:8a03:b546 with SMTP id
 o8-20020a17090ab88800b002748a03b546mr21136683pjr.23.1697012985808; Wed, 11
 Oct 2023 01:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-4-masahisa.kojima@linaro.org>
 <cc0cff36-359a-4c3b-9ba6-bce0834358bf@amd.com>
In-Reply-To: <cc0cff36-359a-4c3b-9ba6-bce0834358bf@amd.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Wed, 11 Oct 2023 17:29:34 +0900
Message-ID: <CADQ0-X9kOiUugvyAXbHawoH6iuruwetJVhZOUOhK2yBXM+JqcA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] blk: blkmap: add ramdisk creation utility function
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

Hi  Michal,

On Fri, 6 Oct 2023 at 20:26, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/27/23 11:36, Masahisa Kojima wrote:
> > User needs to call several functions to create the ramdisk
> > with blkmap.
> > This adds the utility function to create blkmap device and
> > mount the ramdisk.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   drivers/block/Makefile        |  1 +
> >   drivers/block/blkmap.c        | 15 ----------
> >   drivers/block/blkmap_helper.c | 53 +++++++++++++++++++++++++++++++++++
> >   include/blkmap.h              | 29 +++++++++++++++++++
> >   4 files changed, 83 insertions(+), 15 deletions(-)
> >   create mode 100644 drivers/block/blkmap_helper.c
> >
> > diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> > index a161d145fd..c3ccfc03e5 100644
> > --- a/drivers/block/Makefile
> > +++ b/drivers/block/Makefile
> > @@ -15,6 +15,7 @@ endif
> >   obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
> >   obj-$(CONFIG_$(SPL_TPL_)BLOCK_CACHE) += blkcache.o
> >   obj-$(CONFIG_BLKMAP) += blkmap.o
> > +obj-$(CONFIG_BLKMAP) += blkmap_helper.o
>
> you should actually build them only when it is enabled also for SPL/TPL
>
> It means use style like this.
>
> obj-$(CONFIG_$(SPL_TPL_)BLKMAP) += blkmap.o
> obj-$(CONFIG_$(SPL_TPL_)BLKMAP) += blkmap_helper.o

I will fix it.

Thanks,
Masahisa Kojima

>
> Thanks,
> Michal
