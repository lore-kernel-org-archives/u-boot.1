Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D52CCF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF87789098;
	Wed,  9 Oct 2024 03:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YwFSyG4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491E0890CA; Wed,  9 Oct 2024 03:53:10 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2011B8909E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71de9e1f374so3303524b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438786; x=1729043586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RH5JqgfHCfJ7Yws+qV4Pv2NTUxppE4KhMDccikR2XuA=;
 b=YwFSyG4IER1ruV3wL2YviDDWxgVhlqRmzBlkHid5vcgWfc1BivNE98NnQy04fRkgd8
 ZdM6agYn1UUfCq0Tz9/iWsOf7vmUnk72yPp3KGegwKOCHcbWyL3B7ZMO5kH/ulrX5AIv
 tHKvOrYyeP7rYvPzeZ5XphDIhH1AvW3wlHx9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438786; x=1729043586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RH5JqgfHCfJ7Yws+qV4Pv2NTUxppE4KhMDccikR2XuA=;
 b=P/Xlz6Zv5sAFLT2sFlSSYL2mQdHJg5TC9zCO8EW8FSUeqnMTpwlS6URf/wHGbuRkuK
 thWY6rPb8Fy+5YNnEnigv2HbhXRmpyDN3kUgob+pWHb2yTMkq8SZ/UYK336RIMU6NC7D
 ZpwRdD7Uy/j+OR7mawDdz0U74E1rK/vG/SN6d3LSuj/lMJUZ0MUJj9psYBO0IiH3mtb6
 ROmcknxJOOQvqeCfaHcai2CS/YADfwDOScuYaBHFo8nTUxhUGyGaG0Vv5wO3FoxPAca2
 /2VtW9/F4A2nAKV6ghrklCWSyCuWXibl6S5Yfi9w9tIFFYfRVDx0Lad/N601Bg9bmNz6
 g5Sg==
X-Gm-Message-State: AOJu0YzqDvJbY2N0wHEUb/QlGEAelu0P9G4bgX3V9kViCGXfyMZGNBn2
 WFaeoNY1glNZpL+mrvfzIADDDMuiJVM3BUiaisaE1wyZttPXhRDYvlPOE/+Hvy5nkFE9lJ+YyVb
 uKIri/NFvK3LmTaGFNYl3lTPkczKgBSWqek8axir00U9HvO2IJg==
X-Google-Smtp-Source: AGHT+IHK3kh+Feb9p1FfKWnvDZR94rSBtQnfR73lGiqyz+UfnNz1ef8bYet9zoquB6z8cnzoKfj6cYGir2Ju0wkYzw4=
X-Received: by 2002:a05:6a20:ce45:b0:1cf:38b0:57ff with SMTP id
 adf61e73a8af0-1d8a3c7792amr1447687637.48.1728438786703; Tue, 08 Oct 2024
 18:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-6-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-6-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:40 -0600
Message-ID: <CAFLszTjpaMS6PdVtc3WEvUHVB+Fjbmv4kA0ucC7fRwBPSjthng@mail.gmail.com>
Subject: Re: [PATCH 05/13] fs/cramfs: use schedule instead of cyclic_run as
 callback
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Prior to commit 29caf9305b6f ("cyclic: Use schedule() instead of
> WATCHDOG_RESET()") we had
>
> /* Currently only needed for fs/cramfs/uncompress.c */
> static inline void watchdog_reset_func(void)
> {
>        WATCHDOG_RESET();
> }
>
> and .outcb was set to that watchdog_reset_func().  Said commit changed
> that .outcb to cyclic_run instead of schedule, which would otherwise
> match all the other WATCHDOG_RESET replacements done. As the
> HW_WATCHDOG case is not handled by cyclic_run, this seems to be an
> oversight.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  fs/cramfs/uncompress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>



>
> diff --git a/fs/cramfs/uncompress.c b/fs/cramfs/uncompress.c
> index 2141edf22e4..97af8cb2b4f 100644
> --- a/fs/cramfs/uncompress.c
> +++ b/fs/cramfs/uncompress.c
> @@ -21,9 +21,9 @@
>   */
>
>  #include <stdio.h>
> -#include <cyclic.h>
>  #include <malloc.h>
>  #include <watchdog.h>
> +#include <u-boot/schedule.h>
>  #include <u-boot/zlib.h>
>
>  static z_stream stream;
> @@ -63,7 +63,7 @@ int cramfs_uncompress_init (void)
>         stream.avail_in = 0;
>
>  #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> -       stream.outcb = (cb_func)cyclic_run;
> +       stream.outcb = (cb_func)schedule;
>  #else
>         stream.outcb = Z_NULL;
>  #endif /* CONFIG_HW_WATCHDOG */
> --
> 2.46.2
>
