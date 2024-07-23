Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E52C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72FFF88100;
	Tue, 23 Jul 2024 16:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uZm0XJiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18D986419; Tue, 23 Jul 2024 16:51:27 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8539B88708
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a156557029so4990995a12.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721746283; x=1722351083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qCjY6+UrPH5fzFN5DjqaegOkXR/0QvP+FQRwV1VRTHA=;
 b=uZm0XJiPHg1vThvvTivnt0Q3onG+YlXMs3zSrnWI39MxyXeKR2CLJYlkPlmdENEHl4
 rExn3o7qbGklgJp/NoDV0fQ2Loo6aBZj2ATLksraXwtqGgGg2EwjStJaPQOZFYvGvS3i
 czHA77U+xCrylSGz3edcPbDIJwEBK3Q67CV8QiXQHT6xp2B1hzOaLS9Quk0WSGpB0yhM
 tIdMPm5s1M/sXQU6FYKUoc2EgW3UXAIXYlY3x9Lp/67n68MPJiK05dO6L2o0pOf0Hb21
 Ndmi6Uisn++XzoGadXf5252NRJSfktlcvSCfGkg/fuNw1DWcvaYfe5So2t7QnESna0Yn
 grwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721746283; x=1722351083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qCjY6+UrPH5fzFN5DjqaegOkXR/0QvP+FQRwV1VRTHA=;
 b=BaY1/JmpBWMEskDzHKallSc0QVyX9zfib//V7Tivgd8x5SrEsQP/agM779ivNwXCzG
 6RGBfrjVlY9528Dw1LLdgOGeOR9G8YVSp1bBVf5r2FOQEo0Iy3jR9skB+j0SJLiIlKkF
 rYifqdYPdOvNl5KcAecnCMHxbyGQUvgUTObwMCq9jpVLoF4OvJaOeXhetoluH6dbiELW
 U9WNFvpXJ6qWlYMo3AcLPJ84g3Jq3xeyno9568xuiO4Xn3u9YZFQyZNPA/0NcSMPjgUM
 EKe0sepZeVF5RMqK2rjuCR/2zNu++GdXI9NXY0NHAPGsyGzpXynxAVr9v1176fk6UwtA
 PPCg==
X-Gm-Message-State: AOJu0YxLuQ3GWLOD6BreakPs3hAz387/mkFM9jRT0AXaaoCqb8U2JUMx
 k9ux5MIS10EwELfc358UG9MLStkvrWLU2bqZdghS4hjnNy7PWqT6OwUsrRlWgY0ra4tYHobw7Bm
 Pr3ucfZfSs8OOvtFejgU4P+NuLC7kQaBtJ1z1tw==
X-Google-Smtp-Source: AGHT+IH9u8S7yQ3nsc7kRiDX/W68dNCL5W0c6Eub0tXKZztx0B0OiGI4aKgvvSLLn4P6AN3lhZqccRh8rKIZp5yPQOc=
X-Received: by 2002:a50:9b08:0:b0:5a1:e92b:acb5 with SMTP id
 4fb4d7f45d1cf-5aaa3d7a0femr96002a12.11.1721746282954; Tue, 23 Jul 2024
 07:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
 <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
 <20240722173325.GA989285@bill-the-cat>
 <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
 <20240723144836.GH989285@bill-the-cat>
In-Reply-To: <20240723144836.GH989285@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 23 Jul 2024 20:21:11 +0530
Message-ID: <CADg8p96619yU3Li94_JsJx5VUpDpF7SqF3m9McHhQFYLchvktw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Tue, 23 Jul 2024 at 20:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 22, 2024 at 11:07:45PM +0530, Sughosh Ganu wrote:
> > On Mon, 22 Jul 2024 at 23:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jul 22, 2024 at 11:58:18AM +0530, Sughosh Ganu wrote:
> > > > On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
> > > > >
> > > > > > The aim of this patch series is to fix the current state of
> > > > > > incoherence between modules when it comes to memory usage. The primary
> > > > > > issue that this series is trying to fix is that the EFI memory module
> > > > > > which is responsible for allocating and freeing memory, does not have
> > > > > > any visibility of the memory that is being used by the LMB
> > > > > > module. This is further complicated by the fact that the LMB
> > > > > > allocations are caller specific -- the LMB memory map is not global
> > > > > > nor persistent. This means that the memory "allocated" by the LMB
> > > > > > module might be relevant only for a given function. Hence one of the
> > > > > > requirements for making the memory usage visible across modules is to
> > > > > > make LMB allocations persistent and global, and then have means to
> > > > > > communicate the use of memory across modules.
> > > > > >
> > > > > > The first set of patches in this series work on making the LMB memory
> > > > > > map persistent and global. This is being done keeping in mind the
> > > > > > usage of LMB memory by platforms where the same memory region can be
> > > > > > used to load multiple different images. What is not allowed is to
> > > > > > overwrite memory that has been allocated by the other module,
> > > > > > currently the EFI memory module. This is being achieved by introducing
> > > > > > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > > > > > re-requested once allocated.
> > > > > >
> > > > > > A review comment on the earlier version was to do away with the static
> > > > > > arrays for the LMB lists of free and used memory. This version
> > > > > > uses the alloced list data structure for the LMB lists.
> > > > > >
> > > > > > The second set of patches are making changes to the EFI memory module
> > > > > > to make use of the LMB functions to allocate and free memory. A
> > > > > > *_flags() version of LMB API's has been introduced for the same. The
> > > > > > earlier version was using notification mechanism from both LMB and EFI
> > > > > > modules to maintain memory coherence. This version makes use of the
> > > > > > LMB API functions for the memory allocations. This is based on review
> > > > > > comments of EFI maintainers.
> > > > >
> > > > > On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py fails
> > > > > due to:
> > > > > ...
> > > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > > > Filename 'pxelinux.cfg/default-arm-k3'.
> > > > > Load address: 0x80100000
> > > > > Loading: ##################################################  64 Bytes
> > > > >          8.8 KiB/s
> > > > > done
> > > > > Bytes transferred = 64 (40 hex)
> > > > >   1  pxe          ready   ethernet     0  port@1.bootdev.0          extlinux/extlinux.conf
> > > > > ** Booting bootflow 'port@1.bootdev.0' with pxe
> > > > > Retrieving file: pxelinux.cfg/default-arm
> > > > > am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base: 16
> > > > > link up on port 1, speed 1000, full duplex
> > > > > Using ethernet@8000000port@1 device
> > > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > > > Filename 'pxelinux.cfg/default-arm'.
> > > > >
> > > > > TFTP error: trying to overwrite reserved memory...
> > > > > Couldn't retrieve pxelinux.cfg/default-arm
> > > >
> > > > So this seems to be failing because the address used to load the pxe
> > > > config file seems to be overlapping with an already reserved region of
> > > > memory. Can you please check if modifying the address works?
> > >
> > > I'm not sure what address you're thinking of modifying but, this isn't
> > > overwriting U-Boot itself so it's a case that needs to work.
> >
> > Can you please print the lmb memory map through bdinfo and share it
> > with me. That will give some info on what is causing the issue. Thing
> > is, with this patchset, if there is another reservation with a
> > different flag(like LMB_NOMAP, LMB_NOOVERWRITE), this would cause the
> > load to fail.
>
> Well hunh. I thought I had reproduced the issue before posting, but I
> just pushed the same tree (I'm fairly certain) over to my lab and the
> tests are passing now. So, lets just see what happens with the next
> iteration of the series, sorry for the noise.

Okay, I will put out the LMB only, non-rfc series once the CI has gone
through fine. Btw, I hope you have seen my comment on irc about having
the SPL_LMB config symbol as a bool, instead of def_bool y. Thanks.

-sughosh

>
> --
> Tom
