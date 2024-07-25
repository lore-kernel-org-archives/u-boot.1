Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54224C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825B4886DD;
	Fri, 26 Jul 2024 01:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mPpF5Xgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24EB88709; Fri, 26 Jul 2024 01:33:10 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B433A86FB1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7a8cada97so426836d6.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950387; x=1722555187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S0Y5aaHueeiBNszAs2Z/Mx/p/FhLM0X8T31O0P98gCY=;
 b=mPpF5XgfhbTQMZ83q3z4W69XMsMPX6h686DRGu0VJAntBa33cguBq1m23p/o4Rr3QF
 rL3mEYCDVZ/xiD7kpdZKXov3gs9Mowu09u0gKRPAgZWWGgs211nkQMQ9lhIct9XjbLbM
 dU88VlRnicQ0NOLTSAQCuj1vSTu7d0zgNfjAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950387; x=1722555187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S0Y5aaHueeiBNszAs2Z/Mx/p/FhLM0X8T31O0P98gCY=;
 b=PHFT68gx9S4BB2OaugWY4ZoRL+GGgR/aL+yAU5vFLBVLXWuaXCzataOZi51nWXZ3nV
 oQdQZ9xtIGy34BTfybPLkgDcuzrdFebojmerbfkEn2S6dOqmh40CZGy4aQEL8ZFRrv7U
 SleygjwGH9vw3WC1i+H9auiw9Kb49YAyXuOYYYr3ipA44k7spFo2RgKmF/qaqtz0k6to
 I/SpcNXs+h5iN5nh6dLuvK/65+2fF4A8uZcFzn51XFXvkRaOQQapfCGZ6fC5bk8E8jRg
 iPsyQj8hTIdKn08YCnXPB3BITo/tvZG0iX1wCJZKRz4XM6uanAZgN7jQWJQJt5lJC/E0
 0SYA==
X-Gm-Message-State: AOJu0Yy2LuxDqn8su76ZLjMYQzwhw4bBNZYlrBxnYXaMG4b20dGXBNE6
 tgxDeC5yPdf7u6yJxqK0wsoQ9zV6A4LSMF3h+NeFs+vKCtUQPs5GGYt+6Ny7avcEfkoIFr31QUP
 dqfHMLiCmAckh/fRfWHkfnmpvIlA+kSCS4LdB
X-Google-Smtp-Source: AGHT+IGUn28JdZdWFQEiCddnAKwPyfQSH2NdQZbqF2A5etxzq2L5UVNmUzbB0/DBHxANFRyyoaBdqtiZA+63bTzlkMw=
X-Received: by 2002:ad4:5c43:0:b0:6b5:e6b3:72f9 with SMTP id
 6a1803df08f44-6bb406d57d3mr44886996d6.9.1721950387573; Thu, 25 Jul 2024
 16:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-37-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-37-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:57 -0600
Message-ID: <CAFLszTjQ011M-C+JNAPkFce2CEA5qofdm2TEtETndcU1k8vF5w@mail.gmail.com>
Subject: Re: [PATCH 36/40] test: lmb: add a separate class of unit tests for
 lmb
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add the LMB unit tests under a separate class of tests. The LMB tests
> involve changing the LMB's memory map. With the memory map now
> persistent and global, running these tests has a side effect and
> impact any subsequent tests. Run these tests separately so that the
> system can be reset on completion of these tests.
>

This is just not a good idea...we should fix the tests so they don't
have these side effects.

> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  include/test/suites.h        |  1 +
>  test/Kconfig                 |  9 ++++++
>  test/Makefile                |  1 +
>  test/cmd_ut.c                |  7 +++++
>  test/lib/Makefile            |  1 -
>  test/{lib/lmb.c => lmb_ut.c} | 53 ++++++++++++++++++++++--------------
>  6 files changed, 50 insertions(+), 22 deletions(-)
>  rename test/{lib/lmb.c => lmb_ut.c} (93%)

Regards,
Simon
