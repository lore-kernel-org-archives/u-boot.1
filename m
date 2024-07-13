Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5CBC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606E088831;
	Sat, 13 Jul 2024 17:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hpcw/VyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60002888B4; Sat, 13 Jul 2024 17:14:24 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6B7888AD
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c9a10728abso2127023a91.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883661; x=1721488461; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6jQI/Gzr4JI55Rk050o1r0+F+EJI3JRewo02OACICRg=;
 b=hpcw/VyIlTteBKfWNNJwXH23j0sHP2Bx+4rfidrdnC5FMDOa9gmioAVEfOngbOypCo
 D9KsfQLbaG/QeDkOijylbQ2NvN4+d4MuV++qOd8uZWJmgKj8G5s9ZcgW9XZTbuS7z+Bc
 UVyB7NEp1lhqi94wsfYyt56h9LP85nDWfHFZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883661; x=1721488461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jQI/Gzr4JI55Rk050o1r0+F+EJI3JRewo02OACICRg=;
 b=NZzB0lkcchC8y/YWdNNp81qKFoU6JdI103NWbCE1nF+VvkM9nGsifR2av6uSkpjeEU
 8EEPmzNvntoCTjLPyzDpHVLKyS5i1lWGngnHpZNyW/SU3f+Jqy1yuxpt/v6/Qax2ozE1
 sFoHIvc1fWrhB7JOHAqNTa3jFIHmen8UNbw2JvqUG2ulNu8zVonziMwF/mLHovlykcSF
 5Ft4e2dqEYUOfWyenGPwykmONeo9QjyU0PUPvKVQEx/9sOLr8BVrFqJXFuHpvEmpOrSF
 9EAR8UhKdJJTpLgsT2pSutPbkv/Zf8ryMKOSNs4le4FIvLH6JdPPOyICP+MPr/bfWPBK
 i7wQ==
X-Gm-Message-State: AOJu0YzbrLtcqVvqVV+Le1b5ErBiun86GDncJNsIjQUDw0RTTwdYC81P
 kdxlAuUbfO/tzrKyVUsd/qwtfOPMKL0wSS4v9jKrMsGCpPlJjxabGbG0hk99J2LIPi1vajm4ACU
 ilkt/cIf0bOeYbJtDwKPSKvOa3I6WXYnhaD+2
X-Google-Smtp-Source: AGHT+IG1LlJCaXtnej7fupDNurvPzk8c+QJpKMY8lcV90+AHR1IPKJussxcn6bCFMcXXanbNQn+CthxlbN+HQbgbXxU=
X-Received: by 2002:a17:90a:9ce:b0:2c9:81d3:65d5 with SMTP id
 98e67ed59e1d1-2ca35c6ea02mr10354984a91.24.1720883660794; Sat, 13 Jul 2024
 08:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-8-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-8-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:56 +0100
Message-ID: <CAFLszTgLkdJJXfL7uJDNenzti76xm0WXHge9v+WhJq+1ehtPRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/48] lmb: remove the unused lmb_is_reserved()
 function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The lmb_is_reserved() API is not used. There is another API,
> lmb_is_reserved_flags() which can be used to check if a particular
> memory region is reserved. Remove the unused API.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V1: None
>
>  include/lmb.h | 11 -----------
>  lib/lmb.c     |  5 -----
>  2 files changed, 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
