Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F212EC49EA1
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 845EE888E0;
	Tue, 30 Jul 2024 21:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZd3/Uz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA30A88806; Tue, 30 Jul 2024 21:44:51 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 874B98882F
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7a3b75133so36734486d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722368688; x=1722973488; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=btkXuM8FXErU1352jvxUlWALMA19VERdnNk5XaEBIS8=;
 b=fZd3/Uz1aqarUiEjuokhqVfrI3wRt5M8AZ6ytfv1pgB8mviugfd38YHuRIae/Wbhnv
 FmywBcR9yXDu+f+PARC88P8OMr4xV42gm4o3YDr2uF7s1wmcOQw/TSOk3qh9MqVWTVGm
 R8xNr4i/WM9ugih+DOZd2mihcb6ixMfFi+cHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722368688; x=1722973488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=btkXuM8FXErU1352jvxUlWALMA19VERdnNk5XaEBIS8=;
 b=nIYrLvCqo8pOYf42aga7hswfn+DCPX4XXvq0SJdY44gi2BqNBjl/gZBxygUx2gS8Sl
 z3aw5PEUNEqwIR6mgLa4INSzWM5McX1Rq7PE1844vZXfZzS++xDrU3NwKSfXmlvj0OhF
 gaU28NPO8OgbZTswCZSojQBbXfbD8ZSZnVED0kO0uw/2enjTMrOrEobrnaETAPBkKkEQ
 krT4kg1USzRBqiz/DGHabo7JwEkFDubXjIdvjB2ouMZShi9t+3NkY7hTjh/hfNUXgzJ+
 FTLMoZ68iPGj6PZFDkHLuCKih6ypPsYnf11f0UEGnexv7evZhT+3TXO392cXUiCX8ujt
 CL5w==
X-Gm-Message-State: AOJu0YwUEWLpX1f5RwZj3g2Ckx3XkthYP+EinVieGZmcb4oaRbrbxaFF
 SBnEqFUlWsPHNdpiai1aEcuw+n1LKRla5nnwoc7VfKE/wOwmDFhtEDsCZJ6SvUot7P9+UQ6AvD6
 Mte3G/ScKZ5dcVWkpWH0ryxamqgVD8z4rvUSE/mJnwK1TqbA=
X-Google-Smtp-Source: AGHT+IEijXnpRZqUz9JE9WuazG4CTfXsitmIt93DyYU+5ce+VnF+oDg6WOP9KUQuJYRBYEBSlIBMydwATqiHx+fp4QU=
X-Received: by 2002:a05:6214:1247:b0:6b4:dd2a:aa44 with SMTP id
 6a1803df08f44-6bb55a83e51mr175456736d6.37.1722368688404; Tue, 30 Jul 2024
 12:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-5-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-5-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 13:44:37 -0600
Message-ID: <CAFLszTj5TcBQLb01QRxBxvDhOXTiT4CWB6eadauGCu5DUKnr-g@mail.gmail.com>
Subject: Re: [PATCH 5/5] dm: use list_count_nodes() for counting list nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 30 Jul 2024 at 05:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The linux kernel has the list_count_nodes() API functions which is
> used for counting nodes of a list. This has now been imported in
> U-Boot as part of an earlier commit. Use this function and drop the
> list_count_items().
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  drivers/core/util.c | 14 ++------------
>  include/dm/util.h   |  8 --------
>  test/dm/bus.c       |  5 +++--
>  test/dm/core.c      |  9 +++++----
>  test/dm/test-fdt.c  |  5 +++--
>  5 files changed, 13 insertions(+), 28 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
