Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557C0C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB6D82054;
	Thu,  3 Apr 2025 16:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ql85gEdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D2D82075; Thu,  3 Apr 2025 16:09:42 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A1E82012
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-30332dfc821so732307a91.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743689377; x=1744294177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/wbcf94rU0mYGEmcNl/I8Iw+qe8nze1KEztgaV5EuuY=;
 b=ql85gEdYRvUbfChLiAUDWTcfHu1/DM5VdTdDYtQfCWhZ+qnQYgLBTSqBH8WPGLdZPV
 3h7eibUW/gAG62RB0ebN/Y9nEJAkn9ixAyu/ec4u73uIpPvjG/1+r8sssU1oKARew2AQ
 6hFT0QB8wem2A/ZthFaYrBzPr6MdFh+SqWoZs6LCsWSLvqKb0ycJ+hMjCh+duyAPMYKD
 vMi8z+uRTaIyYZOIJKTq0/Q85LSfTQweMmZ4ss1K2Ax8cT6xsf1diMzMFAXK4kAoPcIF
 YVpqy2yAErBMKU8vTe7qZ29EYKWtYG/872OTUOMLwqju2EtkFKwqP3P1s4ux/xaM28iz
 WLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743689377; x=1744294177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wbcf94rU0mYGEmcNl/I8Iw+qe8nze1KEztgaV5EuuY=;
 b=V33s+IN6s5Rt7JNFM0ApP/D7XsN+hu3c46/i4/9II2j0fQFamyaTBah47THq/ILXeM
 V/2Rh++6875YH4YQkYl6x0I4hBcFET5EfjMP56Rh4BZeQyMEcmmnDtwnv+6psdFq9TMK
 uYVY0Prq0MX6LmKD4g3q3fVltI3Yh6n42KBS9FmIDk5FOKN7ayGYh7NyfwgDA2M9E2TE
 PVX4SzwXoPXoS1TywOBOTWC+PglAmwPfJBaVOVzB2SzpNrN50gD6ltaA4vZsviMq4PtH
 PFQPXNLEqXP2/KpAlEcVaA869Su+Y8C6/D4gLHOS6Uou3zbWb0p5Ry6EhQImIjI5unaC
 spFQ==
X-Gm-Message-State: AOJu0YzVWIPfxEhKQxLqSFqMBrBMsrxxAPryn94y4Qr4n9g+oe56w/mn
 OMwY3++jcfCtCZ1E/nhggJRC8Ljf6NOe1w/9OnfGd1oS0qnO88TFNPhXPXHf/yyOnoJpZbRGxC2
 c6WhVWzglgyB5LtlEL0DixIz4t9wqAjMQEeK3jg==
X-Gm-Gg: ASbGncvItrH8KwZ2F9pi6R1ssbije8R/apR1oTnnwptpWGeGX4lkbrgzJNS7HoNMke+
 s/KxHXPJ1/GJa3QBKFFjy5nIovO+3Z1ZYfPAIykarcNsIS8LNSItn6OmE6ndySfbp/ahGNS2dIX
 o1XBt5z8RApClkX3gSlOZ6fbFfb7g=
X-Google-Smtp-Source: AGHT+IFyw555uCPplwtv1dYLkbKvnsMbMDRChrN2uDW//hmVM9ALQ07U6ZPmd06cOWZNijQ4RuMKf5wFHX5n+03u/Mc=
X-Received: by 2002:a17:90a:c88b:b0:2ff:52e1:c4b4 with SMTP id
 98e67ed59e1d1-3057cc8249dmr3096930a91.32.1743689377403; Thu, 03 Apr 2025
 07:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
In-Reply-To: <20250328154401.3563921-1-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 3 Apr 2025 10:09:23 -0400
X-Gm-Features: AQ5f1Jr_nx7d2ZHZSXJw82Nr6QxRJOHATmKvDYPb_ob3RnlZWJISeqqu8yu158c
Message-ID: <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
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

Hi Simon,

On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
>
> The bloblist code took what I consider to be a wrong turn a year or so
> ago. As discussed with Tom, this series proposes a way to arrange things
> so that it is simpler to understand and manage.
>
> - Unwind some of the nesting in bloblist_init()
> - Avoid needing to init the bloblist just to get the FDT
> - Create a deterministic OF_BLOBLIST option rather than using guesswork
>
We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
mandatorily use bloblist to hand over everything between boot stages
including fdt, creating OF_BLOBLIST is not necessary.

> It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> CI at some point. In the meantime, the standard passage series[1] could
> be resurrected to give some coverage.
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
>
>
> Simon Glass (4):
>   bloblist: Simplify bloblist init
>   fdt: Introduce OF_BLOBLIST
>   bloblist: Provide access to the FDT address
>   fdt: Obtain the FDT from bloblist without parsing it
>
>  arch/arm/lib/xferlist.c            |   6 +-
>  common/bloblist.c                  | 102 ++++++++++++++++++-----------
>  doc/develop/devicetree/control.rst |   3 +
>  dts/Kconfig                        |   8 +++
>  include/bloblist.h                 |  16 ++++-
>  lib/fdtdec.c                       |  65 +++++++-----------
>  6 files changed, 116 insertions(+), 84 deletions(-)
>
> --
> 2.43.0
>
