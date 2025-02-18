Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D8BC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 13:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0524380C72;
	Tue, 18 Feb 2025 14:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vjl4KiA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B875809A4; Tue, 18 Feb 2025 14:29:45 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE1D80C72
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe82so6028312f8f.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739885382; x=1740490182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qIEVQ5OUwYoH0qFcAtD0Yr0M0IAfo4hjTTlTu44KeKw=;
 b=Vjl4KiA7Y0APfKsOqG59pBoaOm0ZH1s49Q7iEPWlQnCchQEUwTE+MDLmRDQiPZA3/S
 BfqAL8ZGjmjtjur0lKJo6ji6Li+JKo5eRrJiPusPT57PHMZroVVA2BzsQFp8sMpP/FVk
 ep5INcjX9IWbVMj54qusLNm4lBN2bF0xQRmOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739885382; x=1740490182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIEVQ5OUwYoH0qFcAtD0Yr0M0IAfo4hjTTlTu44KeKw=;
 b=tL+MKCLbHBYaLX8yqKbrU7GjxLHmXYiIat0q8vAkXt+fnLfVSRkLR5WSv6j2YuMKaw
 qQq7zIJ42SqCQMc4lcPjWErW3kUp8Ox1m9mlAq0VxdsjhmbD0OuidfJ7lPppY4G6dFPE
 uncQEEhuJHT24w8mwHej/H6VmJXcKUv0XlsyDKu0jUjNW9P7KGfblxj8wlsVip+ddS+L
 QGxiH6z5w/eR3bYCIK4ImhH/1Jqh+Xqy0iRu6kRQucCv1auOI9PvIP77qYlm1TXLOm6z
 ps3QGqs8AJqSk3UkvAvcBBUZQ2IaADtqL9r9bl3U8q0SCVm/Ry5Qe6R09FTXASV5c6Tp
 ftqw==
X-Gm-Message-State: AOJu0YxKJT6Nu0x8XpAM1PF+dSJFye02IE8c0Rm/x27VFjUKgV4glsHE
 o8JlH62QGaMyfILNavDrhej5emCrQCZ6UMdZ9HBb566bZObAfGYcPJK1JTkpDvenY0P0YnUj0bm
 JIctXo/PXO7rsW3JEmq+LJ9GGkf0s7+GonVNH
X-Gm-Gg: ASbGnctVVSpfOc2gXJMVRsDP7PSJtFQwz+AuyFgST17p38b65QJWqkoMrpD3fHDAncW
 tEdii21RR2HGils/AwFSS6HaFBdqHn9Lq4ReJQmuo9YkLZbiRiwHep/7n61wM0HAl5zIVPCZIkQ
 ==
X-Google-Smtp-Source: AGHT+IHNA9WgUQPyxQhcmfcUypU+HGfsQZG/JwFwCSImk13iB5JLkgr/ygk50UrimCYqwS9yPpwLZ0EJPv1d+u4oHcg=
X-Received: by 2002:adf:f647:0:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-38f33f510eamr11578120f8f.42.1739885382156; Tue, 18 Feb 2025
 05:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-3-sughosh.ganu@linaro.org>
 <CAFLszThqvkcyBQf+Pn+7NsY_ERyP-mof+ic9-81z2wRQvmF3+w@mail.gmail.com>
 <CADg8p96c08cq-9c1NQfMpNK-S_YH7c=isXrjKWmfq2ayW4yMVQ@mail.gmail.com>
In-Reply-To: <CADg8p96c08cq-9c1NQfMpNK-S_YH7c=isXrjKWmfq2ayW4yMVQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 06:29:29 -0700
X-Gm-Features: AWEUYZl-C0rEDrYQI3F9xS_76YT-MA6y59jhOXm8kXuNdkDMZICwdDOZLJfsoCE
Message-ID: <CAFLszTinQuL-EhERNwAHN-cp2dcdEObsHG4PVgFFR7T7J9f-UA@mail.gmail.com>
Subject: Re: [PATCH 2/4] lmb: handle scenario of of encompassing overlap
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Tue, 18 Feb 2025 at 04:57, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 18 Feb 2025 at 17:08, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 13 Feb 2025 at 06:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The lmb_fix_over_lap_regions() function is called if the added region
> > > overlaps with an existing region. The function then fixes the overlap
> > > and removes the redundant region. However, it makes an assumption that
> > > the overlap would not encompass the existing region, and in such a
> > > scenario, it prints a message and returns without making the
> > > fix. Handle the case of an encompassing overlap also in the function.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > >
> > > Note: To be applied after an A-b/R-b/T-b from the original author
> > > of the lmb_fix_over_lap_regions() function on this
> > >
> > >  lib/lmb.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > Would it be possible to go back through your dozen-or-so lmb patches
> > and add some tests?
>
> I am adding tests in the first patch of this series [1], where I am
> fixing the lmb_reserve() function. In certain scenarios, it allows to
> reserve memory regions on top of existing reservations. Please check
> that patch and suggest additional test cases you think that might be
> missing. Thanks.

OK, good, thanks.

I'll leave it to you to figure out what is needed. Ideally you would
add a test to cover each problem you fix.


>
> -sughosh
>
> [1] - https://lore.kernel.org/u-boot/20250213131104.186663-1-sughosh.ganu@linaro.org/T/#m64b8622d1de3973955a9b0239de1f1304bc6d831
>

Regards,
Simon
