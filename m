Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0187C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521AD88004;
	Wed, 17 Apr 2024 02:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mg45YB9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B4E88432; Wed, 17 Apr 2024 02:22:38 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461F188003
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e3f6f03594so33231855ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713313354; x=1713918154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B2yo5ri5Hm8JIYP48rZlQE86B8AeAnEXErSE/4ZerQg=;
 b=Mg45YB9j5A35tdcElXXhCg1AeRcHgjkgQabRS9Ahg+sZvXRm4d1II1lpxNTjxfQ1CD
 wOntEh9qyj73JN6WQLk0sQwELNpxstsI30GQYLpAzHwv7YyMfLTf/cRT6eO+cLjWWQRf
 wfNQi56Ol7ybBpezlKKB14a5R76mBgCUVKxlwPyEdZXlKGugqEJn0wcor7+kJw/oDMtK
 kpzeLmG4c03+MBen0r/yzSR9RDzGCArOlFTs7SQjKWL1xYK7sh6ghK+9U5K1x90AieX9
 audmVGGrcptjA7Y2rbt2tTGJnZs8E8Z3KMWQVehsZ7AT016s4JhkZimp05YYa5e/hwJP
 9KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713313354; x=1713918154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2yo5ri5Hm8JIYP48rZlQE86B8AeAnEXErSE/4ZerQg=;
 b=EfAHJMhFQfa8hZfF12SxbL3bQvUUA9a+nxI34/rZQmyLTy5QFyLYzwbG5gTJ7abdI9
 TsQdVPx5wDiblwU7T8LnIu7k832gY+cdpk4R5CnlZ7WG0QyyC0/Tx/bxZcjOpYCp62H7
 quemQGgTR0vm+zheU/X0bX1Pbsnmcil0dp8kHqnf6dizj7C94Gsq2yg0O8EU2NcjOK8c
 iKY8T5xo0wVVsuG11RdHH8DpQmWee0mOC/I0BXNHN5E61RagsWYbrgs97IVr++nlP2KP
 tuTsdfiDtuIOGlT4/zm2GNK6Nns6eFsxfumhUHbwqFO7uSlS6Btct8G69AQMXIx/guVj
 PElw==
X-Gm-Message-State: AOJu0Yy0xKJB5XLf8jz/B7o6wlMd28Vg/aMIbFrSHY/v7bbgZr+JwRBq
 IcL+9S4KgtvrURJYSb5bexUcnzh+/v3ykM+mCqEE1eXKGfmlICGia++1qzh8p+Ote4/PZCjKvdr
 TgEBWYztMgBVEkRWy9wbLnapUgsy+/jcdY4rV5A==
X-Google-Smtp-Source: AGHT+IEpVSLs9Ki/vqc8TwIbDbVZjPfLvkiWAkZoevxNRcCcho5HyEwdfhV/NHyfKYgA3K13xIv3Pb3YdniYJNe47k8=
X-Received: by 2002:a17:90a:3f09:b0:2a2:1900:493 with SMTP id
 l9-20020a17090a3f0900b002a219000493mr11145280pjc.40.1713313353716; Tue, 16
 Apr 2024 17:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-12-raymond.mao@linaro.org>
 <20240416192226.GW1054907@bill-the-cat>
In-Reply-To: <20240416192226.GW1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 16 Apr 2024 20:22:23 -0400
Message-ID: <CAEfUkUJvct2JPEDmvv02L-EZ9u_BkVbg1T=rafwMfe=pobfibQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] efi_loader: switch sha256 to mbedtls
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
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

Hi Tom,

On Tue, 16 Apr 2024 at 15:22, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 12:00:07PM -0700, Raymond Mao wrote:
>
> > When MBEDTLS_LIB_CRYPTO is enabled, use the APIs of sha256 from
> > hash shim layer instead.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  lib/efi_loader/efi_tcg2.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>
> Why can't we have the abstraction be at the level where we include one
> library or the other so that the calling code doesn't change?
>
> Yes, we can do this - The only reason I added new hash APIs with "_mb" is
just to
avoid vendor drivers that are using hash functions switch to MbedTLS with
this
patch set (As a [RFC], I was going to control all effects within the EFI
loader).
But if you think a complete switching has more benefits for estimation, I
can unify
all APIs between on/off MbedTLS.

Thanks and Regards,
Raymond
