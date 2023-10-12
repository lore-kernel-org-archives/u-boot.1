Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6981CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF46486EA8;
	Thu, 12 Oct 2023 17:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YesVUDzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FCC86EAF; Thu, 12 Oct 2023 17:30:47 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E77B586EA6
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99de884ad25so181714766b.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfmFTq3GOoYOMUHxJcS1LY4oMbvhU1nOoU3UW+jSGO4=;
 b=YesVUDzR2UDmhA30hD/msj3IOQbWziHt4do2riCYaLkvtiHf/E89xnqG2W3XkK4D3s
 6mCmTXF2ljV+zoC9daEK7k/HB8FeH0JiOZkktGd1njkbdNizn1Y/rvBrZpwr0zFBC4Yb
 zmOLVFk1feq0pI50I/fvP1dgDxCNYZci03s7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfmFTq3GOoYOMUHxJcS1LY4oMbvhU1nOoU3UW+jSGO4=;
 b=kwsPQJ01QIecj6FW6fVVPgcfkD9tBraoRKVtofb5Q+hQL9XEhmF+qApFP12jTayCy9
 0+qY2UNiuxzvBCifgW3EZfBS7bCeJzLt/p1oNPJet/MVsrNZbBbaPuCo9W7NQUspo9kG
 3CethOBjYbMApU8SYVPPfK82Sg3ADNy6TMTzwonHitLWKX3MjioyU1yBrAtBDvLcmc+7
 qod74d7BcfWoauVdXCzUfh00bzYDvNr8Qg8ef0bJBcXHuw3m7Y+8kKdXFXUW0U4mZ7FL
 7EEK0ute5rRRu73KA/44F724evd6pb7b7CAXXtmezMztRUXzguswBM+iVxe44+Vgima3
 UmMg==
X-Gm-Message-State: AOJu0Yy9Oh2m3oFyF9wMpIYF52DgLfnhFu6/7oMHhf93B3rHnXtmD52B
 ykCMZre9fcCcpor1mb+aLUJInD8Lx/SQWetQYv6L70A+tt40BaHt1hA=
X-Google-Smtp-Source: AGHT+IEeMdzd5xNNU07Zz+jnGFexi6KijO1W1ByPy4L+dh8tWUcqtV20tdPyT6JaGexer+ro8JXgNx+xmkiIg6Q8r94=
X-Received: by 2002:a17:906:328b:b0:9b7:58:52a8 with SMTP id
 11-20020a170906328b00b009b7005852a8mr21436244ejw.19.1697124553320; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
 <c2acc0c6-0a8b-f4e1-7877-73fa5eef404b@gmail.com>
 <CAPnjgZ2EMus-Q9DY+-7dn-P5+VSLELd8nnp4NOxR0XxHzZfamw@mail.gmail.com>
 <e5ea6ffc-afe2-1002-5806-113d05c0cb24@gmail.com>
In-Reply-To: <e5ea6ffc-afe2-1002-5806-113d05c0cb24@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:28:49 -0700
Message-ID: <CAPnjgZ0Ar4BoPMOqf-+70AZov6+J83epr7UxCwFy=eX+oR3X3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dm: prepare rkmtd UCLASS
To: Johan Jonker <jbx6244@gmail.com>
Cc: Marek Vasut <marex@denx.de>, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, u-boot@lists.denx.de, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 dario.binacchi@amarulasolutions.com
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

Hi Johan,

On Thu, 12 Oct 2023 at 04:19, Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 10/2/23 03:16, Simon Glass wrote:
> > Hi Johan,
> >
> > On Thu, 28 Sept 2023 at 12:51, Johan Jonker <jbx6244@gmail.com> wrote:
> >>
> >> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
> >> in combination with existing userspace tools and rockusb command.
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >> ---
> >>  disk/part.c                | 4 ++++
> >>  drivers/block/blk-uclass.c | 1 +
> >>  include/dm/uclass-id.h     | 1 +
> >>  3 files changed, 6 insertions(+)
> >>
> >
> > A new uclass should have a sandbox test and a header file or some
> > other docs describing it.
>
> Hi Simon, Mark,
>
> Found by git bisect. This serie worked fine till this patch was applied:
>
> blk: Add bounce buffer support to read/write operations
> https://source.denx.de/u-boot/u-boot/-/commit/75191f75bce45f3b9aff607c88f17778d3805c61
>
> On Rockchip boards CONFIG_BOUNCE_BUFFER is selected by CONFIG_MMC_DW.
> These DW controllers have there own DMA interface.
> However Rockchip boards CONFIG_DM_DMA is not enabled.
> A virtual disk driver doesn't work with that extra buffer.
>
> This patch is there. What route should we take to get rid of it.

This rkmtd driver should depend on !BOUNCE_BUFFER perhaps? Or if the
bounce buffer is needed by rockchip, then perhaps we need to be able
to enable/disable it at runtime for different uclasses / devices?

Regards,
Simon
