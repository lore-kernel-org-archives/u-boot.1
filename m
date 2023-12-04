Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A54C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 19:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC4F8760C;
	Mon,  4 Dec 2023 20:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BmMPesXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7FD876A4; Mon,  4 Dec 2023 20:25:54 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BC78071F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 20:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5c230c79c0bso1767073a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701717950; x=1702322750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cL1Z1rnPyYkIsUV4yinFhEKq3q+HvwJlbYh2LzxeyF4=;
 b=BmMPesXVf3FMMRcRBZjLSBwjrHiUbbS9UHqIDHgiUHEss8t/5tJu6q9m4Lrc1rRypg
 mgPac803tgIvg0xJD4CoXDmqoQDQKtzVZkxv5CXO9619OOplJ/o+GigvnYM9lDY7PFml
 yIkP8VHOfD+QIOIyDXM5pJ2SLz5uu93SzyyvwbkuzN1/MDH7v/2dw5Og4BO+UuLq/aDE
 0e9l7iQKU5RyT5zGUflK0bF76uMC9QOT0WXZYOgrcFK0+mh9w44gcV99g5gcTnCYy2ed
 enzswCMDEhGEDeqypq0krHb1seVf6mR/eQ1uDXLN2IK2byYxgO9GPTIec74MSD3eT3ik
 vAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701717950; x=1702322750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cL1Z1rnPyYkIsUV4yinFhEKq3q+HvwJlbYh2LzxeyF4=;
 b=RO4rE6mTqsDKv4ScnF0ipFfIL0qJyzVf2F6Km1brzcTIRJ0fGBzHsN/eTx4/bdY69V
 AIx7OG2sc+b2EwN3NdaqD5J05F0cAbT1HWauJ39T5VsJJi82xbgWeUGPN4Hy83Mju2la
 Gt9EREQGYMLfNWioGF3i9/cfzIlD6YzejDNnjthstQT/Y2loqHIp3kR8EGO5xyjDfmYs
 tcII/HqcEGxyU5XUSuzS2LW8M9abzfSQp4JK4JstfEPLCtcBhBG+m8V/5gNI7b/g3jeB
 lvdOsL+npK2wQBePvMiUQraviaSGTawFzUvGJtMVJeznsWhvAwc2S/XXsZSR3SKwWNyc
 SSog==
X-Gm-Message-State: AOJu0Yy+5guPVIRU/boLBZS38YG5loIlZ22QxQaReHQqSJfSNrUl/wmO
 csEZwZBrYYuHVnV28xH1D+ghrs8/Fp6lz145V+HheQ==
X-Google-Smtp-Source: AGHT+IGJmgtOS4IjAgGxuHSX8p606SSrFZEvNMdzcOeiYRs2U7SpKb6Wez53LOoTHv00MC17nR6ghM1hoJutIn/v+AQ=
X-Received: by 2002:a17:90b:4a05:b0:286:811c:c3b5 with SMTP id
 kk5-20020a17090b4a0500b00286811cc3b5mr81975pjb.2.1701717950152; Mon, 04 Dec
 2023 11:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-16-raymond.mao@linaro.org>
 <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
In-Reply-To: <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 14:25:40 -0500
Message-ID: <CAEfUkUKaBotDRyReCLc_R628VzZ1CmaNdq_nCp=kd8iCn5R6-Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

When `OF_BOARD` is defined, the FDT should be from one of
the board-specific mechanisms:
1. FDT from a bloblist via boot args
2. FDT in memory
I don't think we need a new build option to distinguish these two, since it
can be done in runtime by checking whether the boot args follow the FW
Handoff spec conventions and the FDT exists in the bloblist.
If it fulfills the above conditions, we can take the FDT from bloblist,
otherwise from the predefined memory address.
This is fully backward compatible without adding a new build option.

Regards,
Raymond

On Sat, 2 Dec 2023 at 13:32, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > If CONFIG_OF_BOARD is defined, a board custom routine will provide a
> > bloblist or a specified memory address to retrieve the devicetree at
> > runtime.
> > A devicetree from a bloblist is prioritized than the one from specified
> > memory region.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> >   Amended from the original patch
> >   "[v2,30/32] fdt: Allow the devicetree to come from a bloblist".
> >   Remove CONFIG_OF_BLOBLIST and FDTSRC_BLOBLIST, a DTB from a previous
> >   loader is defined by CONFIG_OF_BOARD. The DTB can be located either in
> the
> >   bloblist or from a specified memory address.
> >
> >  doc/develop/devicetree/control.rst |  8 +++--
> >  dts/Kconfig                        |  9 ++++--
> >  include/fdtdec.h                   |  3 +-
> >  lib/fdtdec.c                       | 52 +++++++++++++++++++++++-------
> >  4 files changed, 53 insertions(+), 19 deletions(-)
>
> This is a bit mangled. I spoke to Ilias about this as osfc and thought
> we had it figured out, but it was a bit rushed so perhaps not.
>
> OF_BOARD refers to a board-specific mechanism
>
> We should have OF_BLOBLIST to reference to this, a standard mechanism
> and not board-specific.
>
> Ideally all boards should use a bloblist to send their DT to U-Boot.
> E.g. Raspberry Pi.
>
> So I believe my original patch was closer to what we want.
>
> Regards,
> SImon
>
