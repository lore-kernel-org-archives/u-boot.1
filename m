Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B78C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C571887876;
	Thu, 25 Jul 2024 15:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gc7NhPYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC2387C86; Thu, 25 Jul 2024 15:57:27 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE4686463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7a3b75133so6964876d6.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915844; x=1722520644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tst832oQqi7u0GITYKCgKgwx7qdedxBosnZz7fLnL/I=;
 b=gc7NhPYXOGicnjfRDGegIzrdeRCc5TgbcyQImDnfiWTQcJeY4tMTdE/OzB5X+/udE1
 KxtGkTVWLts2xrVIRkl9ThrMmEh4i7O4tgNixzQpPhQqV+cJ9JZfjdDdu7i92WtOMhz1
 V+B0VHL1UQ41C9UGrKCULC1GORkHevTKb0zak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915844; x=1722520644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tst832oQqi7u0GITYKCgKgwx7qdedxBosnZz7fLnL/I=;
 b=QQDPeGuclC9sD6nHOKvTx+hRXVjen1wsXvGIcDpNQ8DxPVICHSm1LhTl+tsjGDEDVa
 6PCaAFejSlBg3HRJHjHQhhVYdMhqn2V78jQByzc6vaNAmyypS0TgA71J4opHtdmcGCGd
 Tbu7dEtEjVVhJgpr2SVCA9wJPvyckPiGLRpfdoiJ3bCGMuAVLdWxaMXGxdqTtibJTtHB
 OxJzUD4NYHAgsEbqlHm7MlGJbqlhFwYFIn1kquKuNcOlIb7wcPi15oWZ2+4Q9CR7i4an
 u3HmLMA40GJpHcWAMmzlKCU865iNjs0/uMOf9ZUzTFBNm4M1qN8wc1xCnSHCSlCFpOTg
 ap7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjcfk4XlyzoYoCK24RkhONz42l+6gyCeYya5KoGCC/jscKr2AWjWXwuEnQilh0YSdx/J2+u2Y5SZXsw1SwBqI2VCPtVA==
X-Gm-Message-State: AOJu0YwD6phcWk6gzyMFyoATs9+foLOdPid/aGVrrq7GE5XlKMlssq8x
 pGYa5pgYjgfYpu2ggdQ8uNrIyBPHFQUpgnul7WLU49QetmZ0fvlgqW1cgUf5bqGrT8RepFqpPAM
 0JnTIL9f0gRUwNnJPNJAcpt0kjTIXYcjxVsUn
X-Google-Smtp-Source: AGHT+IHMa4glPw8PJNcUgi30p7j9TNElVnyE+d/aeBTBvW3Sjk3k9fwqLeDpqCQ9xjUIvvmklO7Hclx+z+7Baip1wiY=
X-Received: by 2002:a05:6214:1d25:b0:6b7:9afa:238f with SMTP id
 6a1803df08f44-6bb3ca0d0e9mr34761206d6.21.1721915843864; Thu, 25 Jul 2024
 06:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <b81b9431-4681-432b-ba24-3e24e7e1cb85@amd.com>
In-Reply-To: <b81b9431-4681-432b-ba24-3e24e7e1cb85@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 07:57:12 -0600
Message-ID: <CAFLszTi-+KcZHT446yuQnPaXz-PP+1_cprWatPtM1jrfQKPOzw@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
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

Hi Michal,

On Thu, 25 Jul 2024 at 00:14, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 7/24/24 22:54, Tom Rini wrote:
> > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> >
> >> From: Simon Glass <sjg@chromium.org>
> >>
> >> Use this new data structure in the utility function.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >> ---
> >>   lib/strto.c | 35 +++++++++++++++++++----------------
> >>   1 file changed, 19 insertions(+), 16 deletions(-)
> >
> > This is rather big growth when we didn't already have realloc:
> > 05: lib: Convert str_to_list() to use alist
> >     aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> >              xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> >                 u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> >                   function                                   old     new   delta
> >                   realloc                                      -    1120   +1120
> >                   alist_ensure_ptr                             -     140    +140
> >                   alist_expand_to                              -     136    +136
> >                   alist_init                                   -     108    +108
> >                   alist_uninit_move_ptr                        -      76     +76
> >                   alist_add_ptr                                -      72     +72
> >                   alist_uninit                                 -      48     +48
> >                   str_to_list                                204     232     +28
> >
>
> this is definitely not acceptable. This mini configuration is running out of OCM
> and we are already pretty close to limit.

Also I forgot to mention that mx6sabresd exceeds its limit with this patch.

>
> What's the reason for this change? I can't see any explanation in commit message.

Much like the abuf library (which initially had no users), I try to
avoid adding dead code. So some sort of example is helpful. The bug
that I found in str_to_list() was fixed in the earlier commit in the
series, without needing alist. so it isn't necessary for that.

Regards,
Simon
