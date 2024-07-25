Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C78C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306EE87C7E;
	Thu, 25 Jul 2024 14:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pN9ZqVeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E914987C7E; Thu, 25 Jul 2024 14:54:46 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74F387C38
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so1475296a12.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912084; x=1722516884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xiwbOOviTk4QrUb4OH2leY+bPsDY+SX2+FY1BdBQqEQ=;
 b=pN9ZqVeEz6O+cbwzgglND5MZaQ6AvUK5lTBXNMzcNbfFXt7zhf7og0Pw+QvaUj27CV
 oKhsO0EF6sFb0C/ChulCC544tvwg6NHAvbOGwdh8wBhdmSjqwQEaxUuGocbzhmZ5SWZq
 HETawvUsNuukA89NRB7yhnRF3d26Jsp3/udDAQEaPURPOKubPAk2EU/hDNd1eqrbv814
 riuDVSq6tnchta6zORYeeqbVCz4wLPHT6IhW4LDhejY/RBZmVqBQRCay2rUTsKR9VFad
 ozLRpjXo7gECZHLsHrNtl/+ybB3ZO09R78YCCkNsNz7ExbUhDRNz8AQ23FwBC6mRmuXo
 7A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912084; x=1722516884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiwbOOviTk4QrUb4OH2leY+bPsDY+SX2+FY1BdBQqEQ=;
 b=D8dk9nmZJcX/8He7lWbi4hgVKTAu9HIEu+/EMugm3xo4vDUcqn5OlCj9r3DMnLQ/5E
 +vnUoEX4z+TrY+L95OzT1p9R3AQKMJy+Q4/aGhysOe0ADAdDW2lgB7ATVpuLhPNVi5Hh
 WwLhE8uXrfhK4239GnfKdxpdJIi0TIGrWr06Dw5saTLVBJfwjN14tKMzG9Te+IqVozBa
 j3ZdM+/OhttExsK4Al6b/aS7vLdEpGBaYzjS8g/z5LOBrbcuzooDjLtMiBn9AbIT496M
 cq+Sau9ADmTJZ6+kX39Uhsr78/MDf4+klq+nkSiDXnFdi8XlXhPXHecHjjr3/0J0uW8h
 2Xhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXflxHWtditrA89mcghdZNvVMSY+bO5QSTgPZh2HhNjdyF3+8HMdsuR6/Bvij4nj+WnziUTM0TcM6Vz29ZOVZzZb/9pwQ==
X-Gm-Message-State: AOJu0YxYbe84abVGHly5enyu6xRX225E9v5ShmcH7+kIXsgoZHWkan9S
 JVBsJuQA3+CfMkGKK3DZyZ9hWDHqSYidUAf0n5RXAu1oxcmzICwJ2UpB20asM/h/uwpL8YrJide
 1J0+dkmAYQo7ASWF8NDLEpiOWOEzPcfwASzjI5A==
X-Google-Smtp-Source: AGHT+IGk6dzU3A++H1Ogv7umyAwds/SdpGRyRQ2FwYTXbO2c7chu2cz9mFDsd+VsVfWFZ2JSW+T8Vp7A3p2nJXnLSwE=
X-Received: by 2002:a05:6402:2693:b0:59f:9f59:b034 with SMTP id
 4fb4d7f45d1cf-5ac141eb41amr3120329a12.13.1721912084191; Thu, 25 Jul 2024
 05:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
In-Reply-To: <20240724205418.GM989285@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 25 Jul 2024 18:24:32 +0530
Message-ID: <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
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

On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> >
> > Use this new data structure in the utility function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  lib/strto.c | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
>
> This is rather big growth when we didn't already have realloc:
> 05: lib: Convert str_to_list() to use alist
>    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
>             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
>                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
>                  function                                   old     new   delta
>                  realloc                                      -    1120   +1120
>                  alist_ensure_ptr                             -     140    +140
>                  alist_expand_to                              -     136    +136
>                  alist_init                                   -     108    +108
>                  alist_uninit_move_ptr                        -      76     +76
>                  alist_add_ptr                                -      72     +72
>                  alist_uninit                                 -      48     +48
>                  str_to_list                                204     232     +28
>

I am working on an implementation of lmb maps using lists. The list
nodes are then allocated with calloc, which I believe is included in
most of the board images. We can then compare the size impact with the
two implementations (alist vs list). Thanks.

-sughosh

> --
> Tom
