Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EC8CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5A986EC5;
	Thu, 12 Oct 2023 05:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TzswWuCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9EB86D12; Thu, 12 Oct 2023 05:44:26 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7EF86D12
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7dd65052aso7932277b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082253; x=1697687053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=alxrb37mkMCHVM4sPauCyNAp7Qmn9fh5wCGI7ExRSr8=;
 b=TzswWuCuWqcMOAwj83zjLaMtGv3FGLGrkll0+WR05aJvLEwp+s5ThZIj4x5gGE0ADr
 Oz8FZqEqJ2TB8hHEa38ZsUIGC+CkGty/Lfse0FNmYkr1t10WhqgfYRLEhiyV0xyiPcv3
 g1tY6/IMdhbg51Hq4dQLf6piDXyhra9WqL4Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082253; x=1697687053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=alxrb37mkMCHVM4sPauCyNAp7Qmn9fh5wCGI7ExRSr8=;
 b=GekPlZMJtrAtompq+SdAJ7Onxe+d747fU/VxRu7yLFwpb1gi1eKEPLpKtDvVlzDxFR
 PYhPbhHoG4irxd6pjyzX2lWjRXTBr8N/N/Le7bpAmJF7p8mw18PbXMz+gWFg98P3uMYr
 Y5Qsk193j9136vbXfACyJnwuhADHNYvAAHPct+aQ7U5sk7HQ1jJ2NLGcNFSV4Nw4N1ae
 7d3YMXXqObfZN0dbSIM0koQlEWS0cyLDx2h0ujJjNHY8kvjnoI24UFZaz7B3xD2enBuk
 oRwHB7wt2J/S6QdyJhqgu0qW7/qcEqKRLdHzju2a/Wq01jV4W85eVblE22dOMF3U9awd
 jK+w==
X-Gm-Message-State: AOJu0YwCqhAwLZpk/T6Jmxqqs+FbE0WvBs9ysT3FWpflnVda+AX45d3f
 G+96WrY/CEzf14J8VuY5TcqExBbc5YqfhX6UYl+t1w==
X-Google-Smtp-Source: AGHT+IH0V4pmAkmXhF25/LEh0kW1HIKcXdft1VzmFKeCoZ33DwOEt3fLTfbjWw83sLFR9Dtojc41kGK8zp9WSvD8+5s=
X-Received: by 2002:a81:9292:0:b0:56f:fbc6:3b0 with SMTP id
 j140-20020a819292000000b0056ffbc603b0mr25793513ywg.14.1697082252769; Wed, 11
 Oct 2023 20:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-2-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-2-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:21 -0700
Message-ID: <CAPnjgZ07k1UeQDT6Ci9Dhtz6oKajGKoP5zr3-55UNHaJsN28=A@mail.gmail.com>
Subject: Re: [PATCH 01/26] spl: legacy: Fix referencing _image_binary_end
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> On non-arm architectures, _image_binary_end is defined as a ulong and not a
> char[]. Dereference it when accessing it, which is correct for both.

Is 'dereference' the right word?

>
> Fixes: 1b8a1be1a1f ("spl: spl_legacy: Fix spl_end address")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/spl/spl_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
> index 095443c63d8..e9564e5c2a5 100644
> --- a/common/spl/spl_legacy.c
> +++ b/common/spl/spl_legacy.c
> @@ -19,7 +19,7 @@
>  static void spl_parse_legacy_validate(uintptr_t start, uintptr_t size)
>  {
>         uintptr_t spl_start = (uintptr_t)_start;
> -       uintptr_t spl_end = (uintptr_t)_image_binary_end;
> +       uintptr_t spl_end = (uintptr_t)&_image_binary_end;
>         uintptr_t end = start + size;
>
>         if ((start >= spl_start && start < spl_end) ||
> --
> 2.37.1
>
