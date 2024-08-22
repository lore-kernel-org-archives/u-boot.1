Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF25C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 12:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F25F388EF1;
	Thu, 22 Aug 2024 14:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CKOFwsAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FEC88ED4; Thu, 22 Aug 2024 14:14:11 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E0C88EF1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 14:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so1189166a12.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724328848; x=1724933648; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h/+Iz38kx2qign4ulDoKbFYRTzi9qO5caKW4ks8PXcg=;
 b=CKOFwsAz1psEDniih++maG4GpXHNxZy0XsXSSfQCE7HlpJWXt4/ZN8szPd5D3gdjpK
 TpYXcC0IWCTiukvBxMFdU2rDCM/2anJ0BOZ3AJzf5mHpYiGhGIXG1X7t6FxKN87Be/U4
 8BKXUr1iauGFHoXzAr+x2ysPnmXb9KDCFTgICcSQbYSmbvutKed5x98Jp7dZHioW+Ov+
 lCNkbya7gQ3uOTb0GnP+KbvL1yvmES5lkHdCp3eont8iBChh3tPt/iAs6KFKwf3R77vJ
 fgQsb8w3sPUK24VMv0lOhuBIeVTlCmFsEAP5IySmDgIXZh9pBwvpx2xZZg+5RLYWqXwb
 PcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724328848; x=1724933648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h/+Iz38kx2qign4ulDoKbFYRTzi9qO5caKW4ks8PXcg=;
 b=OoYDApVLdWf2/s+Vk3BdW/dGP84wefiEHce2hbHEP8qVhWtlNQXSwmuhfhtqOxzysR
 8r08O3VoHW/dAjV58pGlSvtxaJILF7X/db3DxWi3etggfLJlSwGJI/KTyEnjYaRcsyuN
 mV4NiaoQVtkVcC+pKJo+AxNBpiqc/nwoP/TD8DPSsubBugp8O52mH0B837IngWcIh+fQ
 A6VCOsSJ3gKhkyjmkN4Io/+cj+oZKhmoHqcIZUS62MKS+aEjpqC9ssPTFN3WRvYCzxOA
 aXV7RaK6skuv5QkDP7Ggciebaq7qvYrCtDN8F4xurmew+Z+bxGr1vQVp52bKv/dR4w7x
 Rt1Q==
X-Gm-Message-State: AOJu0YysMLQvMnJTlPWpHnSb9k98qJ+gjumOe6hgH6CrOm0LV7/yFVFH
 TEmh/4waQeNYK61Z98ZnAZbX6KZ+6qxVK3dHBCMl0oQ7QyyrM0ktP3uXk5G7IIK6VLBcemOkNKx
 B5iM7BHJGzd94gc3S+B8UBDILAHXt61qBZIjLGA==
X-Google-Smtp-Source: AGHT+IEadMEaqyTv9K3lTrRdbUKEtPTjoVBfkRJbsE3ssueT/tjsy1CpXWdjU4i1ak3YIprzFoxA8lJ+wOCwXoXjjDg=
X-Received: by 2002:a05:6402:e93:b0:5bf:13d:4eaa with SMTP id
 4fb4d7f45d1cf-5c07920c689mr1222690a12.20.1724328847616; Thu, 22 Aug 2024
 05:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821224749.GA104928@oliver.lan>
In-Reply-To: <20240821224749.GA104928@oliver.lan>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 22 Aug 2024 17:43:56 +0530
Message-ID: <CADg8p96AZ8=Mf+egK0s7_08z86-Mg5iiwTgrHqaUO6koP03bNQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Make LMB memory map global and persistent
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

On Thu, 22 Aug 2024 at 04:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 21, 2024 at 04:28:12PM +0530, Sughosh Ganu wrote:
>
> > This is a follow-up from an earlier RFC series [1] for making the LMB
> > and EFI memory allocations work together. This is a non-rfc version
> > with only the LMB part of the patches, for making the LMB memory map
> > global and persistent.
> >
> > This is part one of a set of patches which aim to have the LMB and EFI
> > memory allocations work together. This requires making the LMB memory
> > map global and persistent, instead of having local, caller specific
> > maps. This is being done keeping in mind the usage of LMB memory by
> > platforms where the same memory region can be used to load multiple
> > different images. What is not allowed is to overwrite memory that has
> > been allocated by the other module, currently the EFI memory
> > module. This is being achieved by introducing a new flag,
> > LMB_NOOVERWRITE, which represents memory which cannot be re-requested
> > once allocated.
> >
> > The data structures (alloced lists) required for maintaining the LMB
> > map are initialised during board init. The LMB module is enabled by
> > default for the main U-Boot image, while it needs to be enabled for
> > SPL. This version also uses a stack implementation, as suggested by
> > Simon Glass to temporarily store the lmb structure instance which is
> > used during normal operation when running lmb tests. This does away
> > with the need to run the lmb tests separately.
> >
> > The tests have been tweaked where needed because of these changes.
> >
> > The second part of the patches, to be sent subsequently, would work on
> > having the EFI allocations work with the LMB API's.
>
> This generally feels like the right direction, but for v4 can you please
> look at the assorted checkpatch.pl warnings? Don't worry so much about
> trying to use IS_ENABLED and so forth if it doesn't enhance the
> readability but there are "func (....)" and some other issues that
> should be fixed. Thanks!

Sure, will fix these issues. Will wait for a few days to see if there
are any other comments on the patches. Thanks.

-sughosh
