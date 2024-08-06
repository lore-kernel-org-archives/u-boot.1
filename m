Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CF0C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C31588B14;
	Tue,  6 Aug 2024 23:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jXMYhwgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCCA881C1; Tue,  6 Aug 2024 23:51:13 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4BA88B06
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so810182a12.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981069; x=1723585869; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wieQC3reMpNH4C5mVm4aLNSiTria1nZbM01+2sK519E=;
 b=jXMYhwgbYokV2I6XXWpS3k1sLkJoyMWf6chmw6cY0jx2UfHkQLlEb0F5Z3c1rnpAUl
 DK4nZimIm7QcEzpq+PKi8OsS12t8/Ko8yiv0FdvO+7LQV6sAUFnx+PMyVUGAN4a3diOf
 WZFKgCgudCaP21pKPi+gRPsOFovApSDFNTOog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981069; x=1723585869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wieQC3reMpNH4C5mVm4aLNSiTria1nZbM01+2sK519E=;
 b=D67TcbJ3Qt8KH06OSDduHoutsIB2dAq127KdarBUfxxUNyOrMKTiEWSPGWhVaw2dub
 Nqg61rbixQeiqvP8i7dQAxmgzCdo8XSQ6QrGzaM0yMVtTEyg1n7/T4mmbAFHu170n0hs
 yNoM9YLBnEUIyxmyXgBxQfOWwnW68ENMG9d3GsXV5eVWdgi9DYnFsBxF6zwyZLC5Du0H
 psHzYr9BuBKWXDYNt9MMBGfqpA2Jk9LrkwTZMxLB4MKkPDMafiHjG8zYU0BEdCvE97Uu
 LHq1jQf5A5pSYM1ucZMxjWKpk6YJdL47HmgK2iqNE9smPvW4qKZuf3FYYiXuSgLL73Ev
 luzA==
X-Gm-Message-State: AOJu0YyYbZXuxRWkOmzMVKFtMrZnOFnPRiDzYlnwnn2LAwrHhwqRourl
 9hLnlVsK/YlpBocVLCwSfQYnGB1sUSkkPFcieVUNsWgQ0ciG+kpnGzo3K+Gt4JDCIch3YhnAMvG
 5nzXRUc/et4JVJKK20Eys+52v20ilnPpQ6ofO
X-Google-Smtp-Source: AGHT+IGT82p53Gkuk/toYYAqHhLnzxFzLvcsEF9cPbVMWJ2r3EilzFook/G7UFOqOle8th3N3cYgaNJwf0QR3MqwMEo=
X-Received: by 2002:a17:90b:38c3:b0:2c8:81b:e798 with SMTP id
 98e67ed59e1d1-2cff95147femr15709409a91.30.1722981068980; Tue, 06 Aug 2024
 14:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240802100846.16619-1-richard@nod.at>
 <20240802100846.16619-2-richard@nod.at>
In-Reply-To: <20240802100846.16619-2-richard@nod.at>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:40 -0600
Message-ID: <CAFLszTg4hkg=O8mOBxy_BzWd9sO0wnZMpWo+BP3e0xsb5=-E9Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] dlmalloc: Fix integer overflow in request2size()
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, 
 marek.vasut+renesas@mailbox.org, eugeneuriev@gmail.com, trini@konsulko.com, 
 bmeng.cn@gmail.com
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

On Fri, 2 Aug 2024 at 04:08, Richard Weinberger <richard@nod.at> wrote:
>
> req is of type size_t, casting it to long opens the door
> for an integer overflow.
> Values between LONG_MAX - (SIZE_SZ + MALLOC_ALIGN_MASK) - 1 and LONG_MAX
> cause and overflow such that request2size() returns MINSIZE.
>
> Fix by removing the cast.
> The origin of the cast is unclear, it's in u-boot and ppcboot since ever
> and predates the CVS history.
> Doug Lea's original dlmalloc implementation also doesn't have it.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  common/dlmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index 62e8557daa..44b06e38b2 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -386,8 +386,8 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>  /* pad request bytes into a usable size */
>
>  #define request2size(req) \
> - (((long)((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) < \
> -  (long)(MINSIZE + MALLOC_ALIGN_MASK)) ? MINSIZE : \
> + ((((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) < \
> +  (MINSIZE + MALLOC_ALIGN_MASK)) ? MINSIZE : \
>     (((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) & ~(MALLOC_ALIGN_MASK)))
>
>  /* Check if m has acceptable alignment */
> --
> 2.35.3
>
