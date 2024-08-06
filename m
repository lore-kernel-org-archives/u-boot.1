Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD4C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CE188CF3;
	Tue,  6 Aug 2024 23:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CAt8QCqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0269588C15; Tue,  6 Aug 2024 23:51:58 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48E688ACE
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so782284a91.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981112; x=1723585912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yaag+yfm6t6268z85LNgtpsrBPuQ8uNnE8f1a5PAFwg=;
 b=CAt8QCqXKeMVr1/tEI0OkYOvJXktzecLP7PeKZZ2fY47CbPtyrV12xBED5YXSxQwVJ
 IKyWV/OdlWy6R2A1agFuwi02KSTzOK9rKSgBB/Ci9bFtBcZbpGMu+xP0jNNlXtOmZrj6
 uZJoVQholQ7ENVEAaScj05hTF8yDDFBE122W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981112; x=1723585912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yaag+yfm6t6268z85LNgtpsrBPuQ8uNnE8f1a5PAFwg=;
 b=XEqFElAgIPBCoRGx3Ap0epK3YFTYkOyXNojUwR/0QWSbGt+B+IjNOruopKjFd/JiNM
 q8Ws/Git4O020hzIVeSHVywLEcFqsWkUYllUbHW5nGSRm9fZeVymj8AYiK2sNzqOPGr4
 S+9cRltekz7YysoxxacHDa103ArruRo0+DLfwlzMC9xDaNqAD8kav2+ezZMk1f8z8/a7
 vLuW7SZA6KMeiYE66RteSyeFUi2OjHtV+m0nnHz2EFEombhn9xv+91bPahXgPkICLI+4
 p2Qp5ZqgHG3KtpRjZ/XxgDgMsbOyFAieez/TJgb26aXZXWD7/FYCqNpwkHJUIXfQ8ayJ
 xDJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD3pu1sXYKQUXhjG+FGhmMivYb7TLpGPuiebJ1161hDM82b4JGhQFY56D/Ub3hQbpvLTG8rL1+2fJRT6OEr5pCReI9SQ==
X-Gm-Message-State: AOJu0YwzEyQ8cIQeQqTht6BhgKqm6Pl37DgJQNF4p5RmjweWhDFu6mWw
 yjVfO+pOKLUauuR+8eQWiGD2ZPdZlwgh+zhzzhx+/U+U/QOWt6OGRw+95jdBuwd5u59QaPsTkAu
 TZAlleSDIR7jpURy6F7JykPtgo3yKtEK9Snqj
X-Google-Smtp-Source: AGHT+IHnOrqFR1G7nbdFHWQ35Vl+V4KNRA7Os0bVIuqVnXvXZIa7GmwTmOlEbbkNHaBjEZ/JyI4k441NuuQZjJLp+d4=
X-Received: by 2002:a17:90b:152:b0:2c8:a8f:c97 with SMTP id
 98e67ed59e1d1-2cff955ce55mr15106689a91.37.1722981112419; Tue, 06 Aug 2024
 14:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240804150556.3519995-1-jonas@kwiboo.se>
 <20240804150556.3519995-4-jonas@kwiboo.se>
In-Reply-To: <20240804150556.3519995-4-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:51:40 -0600
Message-ID: <CAFLszTjJKvv3PTs+qWJkNh0KoD168i-8Pf+uLekheVNuzSMCaw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: regmap: Avoid multiple calls to
 ofnode_get_parent()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sun, 4 Aug 2024 at 09:06, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Until a live tree is used in U-Boot proper after relocation, use of
> ofnode_get_parent() will trigger a call to the very expensive
> fdt_parent_offset(), as detailed by the function documentation:
>
>   NOTE: This function is expensive, as it must scan the device tree
>   structure from the start to nodeoffset, *twice*.
>
> Re-use the returned value from a single call instead of having to make
> multiple calls for same node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/core/regmap.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
