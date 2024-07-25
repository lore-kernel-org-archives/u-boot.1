Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797A9C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D968884F9;
	Fri, 26 Jul 2024 01:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lxLeGAZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185628841E; Fri, 26 Jul 2024 01:33:07 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E905D87C38
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so431666d6.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950384; x=1722555184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ccuFgtFYEUIxj8mVLP50dSgXMiPe90aExdpv/EFgFYk=;
 b=lxLeGAZqMKhuCUKtLGowNqHxYa0XDWyYtqmjVrobjNYWMuyrSyJKLu6ooxJjvPgNFm
 xTbF/nh4/qNUlGjHRKB0lV2k61EFsNUvUSZNzjs7Qn5nRuhkm1uuRxsAU2fdlGaMxcwD
 SxC0dyOYVSx/gtZephTpOPbMa1OjOwj1j4uOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950384; x=1722555184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccuFgtFYEUIxj8mVLP50dSgXMiPe90aExdpv/EFgFYk=;
 b=UnyjH17uuoMB8XTbjKAAmBbPLpjEToLkD0SVRarchFKk7Whgt8dMHYQWJxp5vZMbpr
 mM9dsA6UNl6aKSdRItgaCE5jwnZ9kYJNq9M5E6MHYzFPVCuErfNJaIPhVmTkaU7Uxdke
 S7ionwEYBPvngL7bR3mYgr/+Nt60oRkgWMmwrvXaeoHJ2q904mu0VrUv6xtopOWJC+Dk
 7PJAXdDZBN9371GJfPcLYz+Evsh/OqgE6g8HZHWIesMbTQp/n4iIT88XATwum7j126za
 uxtMpAbDjmjWNBcM9HgeKf5yLGGy14/O5pLrUubUZpFQmOsr8AiGcIVfWrbX3gzn/A2a
 aSww==
X-Gm-Message-State: AOJu0YweH+VQ0Md8Bk5iQNGUktDP46WLJAokpNOWkNp8Z//wH/UC+nLN
 qhi1o7uaSVyV2dKsm278qWRFtBKowojrOT4DrFd2j11waEsrrCTdSqfYNUFWHQjfvQC2tSvFuC8
 r7uJMUy1M2fu9QLDTmcD+gr03g0el6c1A7hpU
X-Google-Smtp-Source: AGHT+IGBQEN34GGtzKU3u3we6X2DcsbepxbDmSui9I4TdltCk/CCku7nb81Q4AGoM30QHnLaaJaVEkdUf0RCcEqHv7w=
X-Received: by 2002:ad4:5c45:0:b0:6b5:cfba:10c7 with SMTP id
 6a1803df08f44-6bb40719cafmr45706476d6.30.1721950383798; Thu, 25 Jul 2024
 16:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-7-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-7-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:53 -0600
Message-ID: <CAFLszTgwmQTwRzBuOJvh-=qBGuq+5fRc6vxBptqgQuJyHyuP6w@mail.gmail.com>
Subject: Re: [PATCH 06/40] alist: add a couple of helper functions
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

On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a couple of helper functions to detect an empty and full alist.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  include/alist.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

I had to hunt around to see why these are needed. It's fine to add new
functions to the API, but in this case I want to make a few points.

>
> diff --git a/include/alist.h b/include/alist.h
> index 6cc3161dcd..06ae137102 100644
> --- a/include/alist.h
> +++ b/include/alist.h
> @@ -82,6 +82,28 @@ static inline bool alist_err(struct alist *lst)
>         return lst->flags & ALISTF_FAIL;
>  }
>
> +/**
> + * alist_full() - Check if the alist is full
> + *
> + * @lst: List to check
> + * Return: true if full, false otherwise
> + */
> +static inline bool alist_full(struct alist *lst)
> +{
> +       return lst->count == lst->alloc;
> +}

In general I see you manually modifying the members of the alist,
rather than using the API to add a new item. I think it is better to
use the API.

struct lmb_region rgn;

rgn.base = ...
rgn.size = ...
rgn.flags = ...
if (!alist_add(&lmb.used, rgn. struct lmb_region))
   return -ENOMEM;

or you could make a function to add a new region to a list, with base,
size & flags as args.

> +
> +/**
> + * alist_empty() - Check if the alist is empty
> + *
> + * @lst: List to check
> + * Return: true if empty, false otherwise
> + */
> +static inline bool alist_empty(struct alist *lst)
> +{
> +       return !lst->count && lst->alloc;
> +}

I would argue that this is a surprising definition of 'empty'. Why the
second term? It seems to be because you want to know if it is safe to
set values in item[0]. But see above for how to use the API.

> +
>  /**
>   * alist_get_ptr() - Get the value of a pointer
>   *
> --
> 2.34.1
>

Regards,
Simon
