Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0015CE8D79
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 11:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD6E8913B;
	Thu, 19 Sep 2024 13:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DgNR2jN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4800889141; Thu, 19 Sep 2024 13:00:02 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68D788B27
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 12:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20536dcc6e9so5662465ad.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726743598; x=1727348398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b7ZQwDy/5+NlCEm1jrpuskC7ar3Pf456GhLbqeDKk3c=;
 b=DgNR2jN9sTomVBZBUqmGkfJis5HeHzKLBLLstYmIULdpscg0d3Cx5YEaYd/tYvdLct
 FjxJOgygPb3hZQKVU8RbwiGZSX0Ua/kvUmLihvNhIczAAC4a3JKRrr7F0hT193n2XbG+
 XJRmaKRI2Nm/BqoWj0G3KXSVLCqpVURwrtBEbDuKiwRySmfeaLpIvEzBkdGDmQoU+Z0V
 hto/wlP6vX6AdZIYLe2XyjG9RXFrKwgSlwdnhqaifFNF7YPMSiC5+TSUGqKRk7gnuiT9
 qByQQRcYGjbYhJMkJIlQ78KJ+eE5rdfvmRxJ7Cv8oUe6ADrscSmEXwzAFn3Br13OPkRE
 uF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726743598; x=1727348398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b7ZQwDy/5+NlCEm1jrpuskC7ar3Pf456GhLbqeDKk3c=;
 b=e9BKe143i1DPogMT2S8RyKyAfsnjHzMnl7Zux0fkMf6J/dsuqM47lfVOQW5A6lHLHv
 V0l+niDIDXGR1GZ4OjiRIN4FNk6hhYLQvf7+PK9Fl5yApJnaK6yro6gsom23GNkUiq4K
 7HCbAZIU7oXhlJy/pGJ2G2WAROoUJ1iaVzuwRMNvujGqe5TtZuP98nsaYuaDBC6wAEQj
 9OPbJOo73Y9buw3aRoPWwHjHeglRIYXfjv5N3udZsNEfHbMeqeF+HxuJm/ZXl6uXaStY
 +zO63vicGq4etHgiOMVzrYWnBqnBAIPu0e424zB2aa+2AIHhY2sFGzzDi0Flkb/ju6Ue
 pDuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4rLQ0IcZP06UWETS3ERWNmlp+6mscVxc/S3cQyY3gKkGVUENWLnrx3sI1FwgsY8MHpRCnpFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzPUOdLYYF7J7UQQzNChfaimO2Z4URKzl/XQGXnIz5WLhFCXsyW
 j6Tv7VmaDcY93hG4xXjyYWe4Gjqrk2Dx+eUHX+hmjiURxU18gYTguiXyapoNmE9EVDhqwk2Q9ry
 h2lZQTTj5WXBlDXD/MpgnLKoDqrD3CcopEsERYg==
X-Google-Smtp-Source: AGHT+IFSzRgBiLtYUUvGrm9VVmf+Gvus0oQAboKDV84zXAbpGSpM61MlVxGntWQgFHapJH/P8TMlcg6lNprXGDrTyYo=
X-Received: by 2002:a17:902:e812:b0:206:c5ec:1444 with SMTP id
 d9443c01a7336-2078284c131mr334498065ad.16.1726743598264; Thu, 19 Sep 2024
 03:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240919105523.179497-1-heinrich.schuchardt@canonical.com>
 <20240919105523.179497-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240919105523.179497-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 13:59:21 +0300
Message-ID: <CAC_iWjK3-tsuAKCUP=uoXsV_kHaFx5yruU7--qo23kt8xqQFgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lmb: add missing LMB_NOOVERWRITE description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Thu, 19 Sept 2024 at 13:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Without a LMB_NOOVERWRITE description building the HTML documentation leads
> to a warning which should be treated as an error.
>
> Fixes: 5e9553cc72b8 ("lmb: allow for resizing lmb regions")
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         change description text: %s/resized/overwritten/
> ---
>  include/lmb.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index fc2daaa7bfc..97fc9764c13 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -18,6 +18,7 @@
>   * enum lmb_flags - definition of memory region attributes
>   * @LMB_NONE: no special request
>   * @LMB_NOMAP: don't add to mmu configuration
> + * @LMB_NOOVERWRITE: region cannot be overwritten
>   */
>  enum lmb_flags {
>         LMB_NONE                = 0,
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
