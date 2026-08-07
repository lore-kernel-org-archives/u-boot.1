Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0317C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 605D38134F;
	Fri,  7 Aug 2026 15:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hu2FO-UCC4xu; Fri,  7 Aug 2026 15:12:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F199581337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786115555;
	bh=S2VUi+H1FUpCe60gOPYPeCygME3RRXYBg/2hp4QspZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OkJMcYTTyEOcvoO107NOFIfqNFYBeYkXuWtgT8tGzCPaXv5Gxu8qxsMiSSvdECZJF
	 xTm8BUvwkf40cSl22mkHDaTrzqPZ4I/N/NDsEkdOyl4cXhfUub2Tz+uAw9njcELu9U
	 +cvAksId1tPb8eP+Fon+A+N1sEjBwxYRS86Iehkih1g9PVr4wTofCA/WPcJU/Kf3Im
	 Nx+r9k/hHEtprguOCYKwHuBLAgtDlvi+dPTHnsPfK+DecnWD3iEsjeQwtkt4poNYmj
	 MPi28Um09KKrdShloeOtxCjTlIF2P/4UpS1tD8vvcL90wy5iIuVDVX0LdYSaBruTrG
	 BtBWQH00cMXMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F199581337;
	Fri,  7 Aug 2026 15:12:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B68F2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BC9381337
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnI4M1SDs_Oz for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:12:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EFD1881348
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFD1881348
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFD1881348
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:31 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso4418987a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115550; cv=none;
 d=google.com; s=arc-20260327;
 b=qIFfOyHcjjkJ7+8C7TQJupl8EM3Oc1wc5vxAN+7tqmgatHXMjGAYrS6BptP6RLNRry
 fJLM7NOlDbG7MBgWSB7WrafAd3ziEO/+dlr/Vh6F8smn1gxnw/s+NgRatXmqU0xlBKKW
 yK8nUO/A4IwghJsTduQ2XacU0Y3d8KY2/LhrqNCnMo3HAfxFGpsDz5cCKVNsOAGsRBW0
 wfZSQSz/fLxtyGwhxvhsWrhsLj5z2WjxRVLwXzCZkXw8XLq5y38+bwgfqyGVB9Xe5vsE
 sGRPVcaFTmWrx4VcBh6P98XAHdizfLkc8Wy57xsj4VyZ0V4+yxeFtU0zGtAA28TuI1ah
 ZZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S2VUi+H1FUpCe60gOPYPeCygME3RRXYBg/2hp4QspZ4=;
 fh=Ve5Rf33lTpAQZl0FmIOUMp9/uPnwy1xsgvzmn825Zcc=;
 b=gm6Uekxk5CCi2p+EFbMEzEc04P6d5zPyz9/jOprL1I9x2BbB2pSAhq8du8elbWZ5Vh
 l5hZ5R8UPgd4G3SiC7VNdNb9f0qVjO6NYsM5I/3XsjciWCLFnLXSt5AdEmLnYtlMn+gg
 LsOlg5rwCpSzA9BNVWdsVyeIyfxUT7KcqJ3+lS2FGSIGX9M8KjQa5/vmkS9EUYjZR86S
 AkBhFlQcf3aLajiKJpbnxTsOx5DgpWcCBSv7I76r1Q0EZuGh4TBdq9RF45cMOlL23hpP
 dM3zClLwOd3YrKju9EWw0pdVHGG3o1MNXtacS7NKvAhiExOSIvDuq6yqJZB4NdtTZ48p
 2I5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115550; x=1786720350;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S2VUi+H1FUpCe60gOPYPeCygME3RRXYBg/2hp4QspZ4=;
 b=QAB9QGFQpNbv23T2t2HhRo8N6fX4YphmPj5W5+Gl/gHqrEgNpRZP1p0oIBWezumfRR
 Olj2CWmsQKjCzj2dFoV/H+QYhAn7RzNdVk8QrCPFBWddGWUKx98c4BKj0/FDUSiATurT
 AOhnovU6yvXe0vGbqiWOMA+MWZGbRMXaFi7UXj3gQKWJhq+/u1hHLmfDFTLuB7qNPCry
 JANqanrwDy69tj67T1nbtMD4kyjFbxfQX7Xd12rrLAJdAXUakGeulG2T7zUa7YAsYMH0
 lg4Hsb9IMNS5F68dy/EOk7WSba0aTUW6opw9EHowHNkFxYPo0m1du0Vr5vCQpQyIUFCC
 xd+g==
X-Gm-Message-State: AOJu0Yzn4dCvbY0ONzIKTLzfNWc2alRytHiVopII5mCrf6HGJiWSqgCo
 Q3zAInC0L5K9rpow4BTtX8XJFqbl36gpk3TF8DVwPXAXIycuzd2ZAOg3Eb+9vBAPFfAJMGcy6eS
 rcaY2wTJhOh6vXArQtaMKkP0b+a4iW7A5S3guQVFsVXZV5Xxw5ug=
X-Gm-Gg: AR+sD12MONcpP9TCM4L5Wuv8oF+oMXbkfKUCSdcAtqoKQ5KtOBlvD45ztwB1Af3m9qI
 Up/m140B7MtBnGQUOLHaEPlQ10j4j8D/fDgllzVySAk/7QUh9Lc3gGJEw89gxvasyAIZHU7+UFJ
 wFUYmSZTro2NR27de9NhEk5YYoc7+4UZbPVUcvkbNcmSRla3TdEvObjtOLkhtu/YrxPEGlSB1L0
 jTZ2R0P57Q+BpoLCJfF0Owegwvj++ZkKd+TcKC0aDy57pCj5DUWoWQHTE2hnYXcDaFfhHAkedH4
 0HYUUWu0wyyQr5CzAkzMdCPxIfKw0kpwjxMErPj0gBY=
X-Received: by 2002:a05:6402:e9f:b0:698:b899:d1 with SMTP id
 4fb4d7f45d1cf-6a14eff65fcmr11646640a12.0.1786115549875; Fri, 07 Aug 2026
 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-6-01746157643d@ti.com>
 <CAFLszTh9foQEBVa3BfNHpZ9-2Fr4BGNGCH+oYyLz4yCGr6SkhA@mail.gmail.com>
 <20260807142351.s27pj6ypv3pepdsn@bryanbrattlof.com>
In-Reply-To: <20260807142351.s27pj6ypv3pepdsn@bryanbrattlof.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 09:12:15 -0600
X-Gm-Features: AUfX_mxdfJUo0Qc1HSigHlJyzwQwSrUh85iVPCObEEvfAm-511zHyZie0v1AWeQ
Message-ID: <CAFLszTgPogFNTfLjQ52kSxM4nVDz5JBA=0tMz4eVgfrBBW0XCw@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] board: ti: am62lx: add initial board files
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786115550; x=1786720350;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S2VUi+H1FUpCe60gOPYPeCygME3RRXYBg/2hp4QspZ4=;
 b=RDTtiVQVzuFOoMWqgBMfxkXEqgRRj4B98MWdMQk+ABoovFkEbZvKBYEChQ4afMYDv0
 9tvbvwAAh485N04ndymrAjXi0D92cdqA1cbZU5ykSR14YnDPnFcp9hlD2KqQgFUBoRJW
 6U7/5ibudJR5nwyXGgy2O6ziPCFLKeny4LAuE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RDTtiVQV
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On Fri, 7 Aug 2026 at 08:23, Bryan Brattlof <bb@ti.com> wrote:
>
> On August  6, 2026 thus sayeth Simon Glass:
> > Hi Bryan,
> >
> > On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > > board: ti: am62lx: add initial board files
> > >
> > > Add the initial board files to support the AM62L3-SK reference boards
> > > for basic boot via SD and MMC
> >
> > The other patches in this series (defconfig target AM62L3_EVM,
> > MAINTAINERS entry 'AM62Lx BOARD', docs am62lx_evm.rst, yaml files
> > describing AM62L-EVM) all refer to the EVM, not an SK. Please fix the
> > commit message so the board name matches - and also add a full stop
> > and drop the mention of 'SD and MMC' (or spell out 'SD and eMMC' if
> > that is what you mean).
>
> Sure.
>
> >
> > >
> > > Tested-by: Anshul Dalal <anshuld@ti.com>
> > > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > >
> > > board/ti/am62lx/Kconfig        |  19 +++
> > >  board/ti/am62lx/MAINTAINERS    |   8 +
> > >  board/ti/am62lx/Makefile       |   7 +
> > >  board/ti/am62lx/am62lx.env     |   8 +
> > >  board/ti/am62lx/board-cfg.yaml |  32 ++++
> > >  board/ti/am62lx/evm.c          |  19 +++
> > >  board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
> > >  7 files changed, 473 insertions(+)
> >
> > > diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
> > > new file mode 100644
> > > index 00000000000..cafafb8ede8
> > > --- /dev/null
> > > +++ b/board/ti/am62lx/evm.c
> > > @@ -0,0 +1,19 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Board specific initialization for AM62Lx platforms
> > > + *
> > > + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> > > + *
> > > + */
> > > +
> > > +#include <asm/arch/hardware.h>
> > > +#include <asm/io.h>
> > > +#include <dm/uclass.h>
> > > +#include <env.h>
> > > +#include <fdt_support.h>
> > > +#include <spl.h>
> > > +
> > > +int board_init(void)
> > > +{
> > > +     return 0;
> > > +}
> >
> > None of these includes are used by an empty board_init(). Please drop
> > them and only add each one when the code that needs it lands. Also,
> > none of the other K3 boards (am62x, am62px, am62ax, am64x, j721e, ...)
> > provide a board_init() stub at all, so I suspect the whole function
> > can go away - leaving evm.c effectively empty. If that is the case,
> > you might as well not add evm.c and the Makefile entry until there is
> > something real to put in it.
> >
>
> Sure.
>
> > > diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
> > > new file mode 100644
> > > index 00000000000..0dd86db400e
> > > --- /dev/null
> > > +++ b/board/ti/am62lx/am62lx.env
> > > @@ -0,0 +1,8 @@
> > > +kernel_addr_r=0x82000000
> > > +fdt_addr_r=0x88000000
> > > +fdtoverlay_addr_r=0x89000000
> > > +ramdisk_addr_r=0x88080000
> > > +pxefile_addr_r=0x80100000
> > > +
> > > +dfu_alt_info_ram=
> > > +     u-boot.img ram 0x83000000 0x400000
> >
> > Just to check - the other am62* boards pull in env/ti/ti_common.env,
> > env/ti/mmc.env, env/ti/k3_dfu.env and set
> > console/boot_targets/mmcdev/etc. but it looks like this board is
> > relying on standard boot defaults? That's fine if so.
>
> Much of what is in the environment for older K3 SoCs will not work or
> would need to be overridden for AM62L based boards. Relying on standard
> boot defaults and letting downstream forks modify the environment
> however they wish seems appropriate here.
>
> >
> > > diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
> > > new file mode 100644
> > > index 00000000000..abb3174d4bc
> > > --- /dev/null
> > > +++ b/board/ti/am62lx/board-cfg.yaml
> > > @@ -0,0 +1,32 @@
> > > +  bm_writer_cfg:
> > > +    subhdr:
> > > +      magic: 0x7D8A
> > > +      size: 5
> > > +    allowed_host: 10
> > > +
> > > +  reserved: [0, 0, 0, 0, 0, 0, 0]
> >
> > A one-line comment pointing at where bm_writer_cfg and the reserved
> > block are documented in the TRM (or the tifs firmware header) would
> > help here. Same for the magic values in sec-cfg.yaml
>
> I don't know the specific version this was introduced but these
> structures are all documented in the TISCI specification along with
> everything else K3 uses.
>
>       https://software-dl.ti.com/tisci/esd/latest/3_boardcfg/BOARDCFG.html
>       https://software-dl.ti.com/tisci/esd/latest/3_boardcfg/BOARDCFG_SEC.html
>
> Are you suggesting I add these notes to the syntax.yaml or do you want
> them in these auto generated files?

How about a link to the docs somewhere in U-Boot doc/? Or do you
already have it?

Regards,
Simon
