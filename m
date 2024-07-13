Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE1BC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BC188856;
	Sat, 13 Jul 2024 17:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oSI0DLeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7508889A; Sat, 13 Jul 2024 17:14:14 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6725588831
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c9785517c0so2191490a91.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883649; x=1721488449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8k6HE85EbCtA6hzAfsuQnLFnphjjQuptU6pRrYupkVY=;
 b=oSI0DLegHCdXhGdNlzXdMIT2WbaWzm3ZwctGjBYZ69qu+M2FDfYS+DzJvPMddVz2TA
 IU9lUcV2uWz8WL23GLVa5jeFfnB9mP0PQdFm+t8WWq7E/FhiEb6SWNZD3y1qO81LlrRd
 gz9blmNzaHVwjH9Shej3D5ouQDOi50NAyFqk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883649; x=1721488449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8k6HE85EbCtA6hzAfsuQnLFnphjjQuptU6pRrYupkVY=;
 b=wPMTv+Ap293oYFJ9GkjxuFUjPWZ7sxJnxM27G6Hlz3u6f1l0KLCHeG7Amkcg8uQ6wh
 /Kqlg4z1Pr/aCmeZAXLvUx90T7/rKHjwEvioOuMDxWYX72PbPnss+1s1UgGjO6eHiP1P
 vGaXCiWKX0/AhpWnUzlc65fw82LKOL97I7nMx7fX4/osqjb0pr702TygRzKwrGO9Goff
 MmnVEyMPbe0V9vmUUb+ll4AJrKzn3N8y0DCvSczC8Y7g9siOvGk9sLSbmNP2Kf//r4Vl
 BQ5QQHLya4++uqurZIdOXwl58/+H80+TZhJxzVhDuSLikuPmKmTlk0+NtEOdG1SkxztA
 SsWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSkxJgjrwCrRm2UolAwvehGKFdNd2yA6SP7v5EhSWiU7jThZbHz65bdKT+zRRjGpe3Z4bM9z8Wr7RYTWP92aAKiRhdpQ==
X-Gm-Message-State: AOJu0YwVE63ovzbKnOqKkDQtNyK/CfvVUfwFW99Qnxy0Z3Xtm4SsLQZR
 6c0SdOP0LZvaci3xIu/j2cMrQ9iL/Qpwye0Oq6Mn3gJQJPYizvpP9hA6lvkz8Fpy828E7hfkwWG
 jHWTjUyXONwoKzxD/PE/mfbyevejVoJkwTfQ7
X-Google-Smtp-Source: AGHT+IG/P1xvSotpnJd2NUQwwiGs6ynAp6zDPSYe7p94XtIvkN4gGUBdNpCpxVmegEAK7Q/dIGlXrv2vRgVEx6DHX7E=
X-Received: by 2002:a17:90a:e654:b0:2c9:6187:98ca with SMTP id
 98e67ed59e1d1-2ca35c7bcd1mr10984764a91.22.1720883648948; Sat, 13 Jul 2024
 08:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240709092454.949260-1-jkeeping@inmusicbrands.com>
In-Reply-To: <20240709092454.949260-1-jkeeping@inmusicbrands.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:54 +0100
Message-ID: <CAFLszTgC11k38OeDi0PjwVAZvOMJvfpg3-EZ+p33osvNxLXx-g@mail.gmail.com>
Subject: Re: [PATCH] regulator: fixed: fix regulator-fixed-clock
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, u-boot@lists.denx.de
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

On Tue, 9 Jul 2024 at 10:25, John Keeping <jkeeping@inmusicbrands.com> wrote:
>
> For regulator-fixed-clock, the device's private data is never set so in
> fixed_clock_regulator_set_enable() is null and the function cannot
> complete successfully.
>
> Rename the _plat structure to _priv to better represent its role and set
> this as the private data.  As shown by the set_enable() function and by
> using the same .of_to_plat hook as regulator-fixed, the platform data is
> regulator_common_plat so also set .plat_auto correctly.
>
> Finally, set up the private data by adding a .probe function to look up
> the clock and set the member variable.
>
> Fixes: f3b5100aff3 ("regulator: fixed: add possibility to enable by clock")
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
>  drivers/power/regulator/fixed.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
