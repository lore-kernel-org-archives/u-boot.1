Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70412C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 00:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4F886977;
	Tue, 15 Aug 2023 02:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pnf4/XEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A090C8697E; Tue, 15 Aug 2023 02:31:14 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE17E86970
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 02:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5648fca18b9so764383a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692059470; x=1692664270;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6CXM3PUDbFvgySnOEKM/w6tisvaJSY2WxMB4taP8Hc=;
 b=Pnf4/XEKqqP0klVWCZiew8jzELb5iGlguf3+Zv6YGkCKglSnMwzAOW4jxvT4MiwOjb
 0s6yWucMYF+ndBcMVYRYJQM68pzI1KPCTKknI81uI/HSSNdVNhb5W9H6nixqppu75pv4
 iBCQ6gcM/0JKa1wOm8vGSXhNd6lBRx7azMfMeL14XLVIWqOwLMk5dUwQezd1oFPpBPX8
 1XrRuCk+Kq6PFIrrS5e97xhYiMVNUA+QfPp/OodAvGOMICBAUm4M+Dh5MPV3Tl2a+Cfl
 U0d1/bXeKYSMYPd/gfBzgcL0mmx7lK7csczn5IkaxRvJgpDswx5uDPDwsM3w1oDU3REB
 cSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692059470; x=1692664270;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S6CXM3PUDbFvgySnOEKM/w6tisvaJSY2WxMB4taP8Hc=;
 b=f0cz0tK8CvG4E7kTbnCStQyrz5I4tkTDFbBpqVng/XOMD/zSNHqZra+qxuchte6m8s
 9x8h0qFnGdlXeVxTLJ5LQUE4k2HW9DkdKUvLVRX8XZi7NlsfSmeKsDQAKXQEbD0cHku3
 +j8aiZx49teMXfPjI1GVdBNSR1nTvSwoHedfOsL4J8aj/Ul7miTTs/N9Oza6+CIe6xqT
 086Pp6a+miGY4wxlhTyLcTO5BaytmwZXNgECLQ0WFFrfYyBm27N2kQD9NJynvBkoazjr
 hx6BEB+nmD1rHuPL6Fy0sx+9ydvLsM3G3H5KFwFhaqSvIfL+OZpVN5ycvwDb0RH44iyO
 4+yQ==
X-Gm-Message-State: AOJu0Yw1dRx1ZstsVC95g9TOKIDHKwi3MsCg/1ZdWHskakRGmreaXmit
 5xImzGcUXJl6WbSnaUVZEczz/g==
X-Google-Smtp-Source: AGHT+IFj1REnjFxHqUP54PAzVNFeoZyrqhABYZ0PLTpEfXXNgcyUvZQkmE8mZFf1m28w9HRq3pIjKg==
X-Received: by 2002:a17:902:cec1:b0:1b8:9fc4:2733 with SMTP id
 d1-20020a170902cec100b001b89fc42733mr13365506plg.3.1692059470029; 
 Mon, 14 Aug 2023 17:31:10 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:8cbf:a2bc:9fe7:5424])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a170902eccc00b001aadd0d7364sm10035092plh.83.2023.08.14.17.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 17:31:09 -0700 (PDT)
Date: Tue, 15 Aug 2023 09:31:05 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Michal Suchanek <msuchanek@suse.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 8/8] disk: Make blk_get_ops() internal to blk uclass
Message-ID: <ZNrHSX5atPqd4x/2@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-8-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ2GHvNE0q1-r8VqRJhAPy-EuOsMqkmDq9NPPiDfMBz6wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2GHvNE0q1-r8VqRJhAPy-EuOsMqkmDq9NPPiDfMBz6wQ@mail.gmail.com>
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

On Mon, Aug 14, 2023 at 04:42:57PM -0600, Simon Glass wrote:
> On Sun, 13 Aug 2023 at 17:47, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> >
> > Move the macro into blk-uclass.c , since it is only used there.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Cc: Bin Meng <bmeng.cn@gmail.com>
> > Cc: Heinrich Schuchardt <xypron.glplk@gmx.de>
> > Cc: Joshua Watt <jpewhacker@gmail.com>
> > Cc: Michal Suchanek <msuchanek@suse.de>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tobias Waldekranz <tobias@waldekranz.com>
> > ---
> >  drivers/block/blk-uclass.c | 2 ++
> >  include/blk.h              | 2 --
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Unfortunately this does not stop people using the ops member directly.
> 
> For this series, I tried a patch myself [1] but I think I stuffed it
> up. So I will let Takahiro-San figure it out. I would very much like
> to see this clean-up go in.

At that time I thought that the necessary change was small and trivial:)

As for Marek's patch, let me first explain why I implement that way,
i.e. separating disk_blk_*() from part_disk_*():
- Initially I tried to implement disk_blk_*() work for both UCLASS_BLOCK
  and UCLASS_PARTITION, while this idea was rejected by Simon.
- Then, I implemented part_disk_*() with direct access to the devices,
  and part_disk_*(), as helper functions, with block caching.
  I thought that this approach was aligned with the implementation of
  block devices (blk_[read|wirte]).

If you don't think the second point makes sense, I can agree to Marek's
approach.

Thanks,
-Takahiro Akashi


> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230319192957.1084530-1-sjg@chromium.org/
