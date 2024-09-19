Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F0ACF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB31891E5;
	Thu, 19 Sep 2024 16:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e8Nn74GV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E15891A1; Thu, 19 Sep 2024 16:10:37 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC81A891FE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so639830b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755032; x=1727359832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q3zpd9GFXm3v9o+y26gpqKyAfvnWUM0GjD72Vd3iPrc=;
 b=e8Nn74GV5/pACB7qym07hOZBKap66xfOg/Xy+QshH37xZmz2jYt5XlKOh1aM/jIiik
 t8EGfAMjvUiBH76Cx9i+W+6sNSdTLa28Nv0ub+RYvBuPf1SeG3r2W2/VtuoFAch29PnY
 K5lcWw41UogQXm5mGfMs7utwTkfNMSbOYL8OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755032; x=1727359832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3zpd9GFXm3v9o+y26gpqKyAfvnWUM0GjD72Vd3iPrc=;
 b=IGouAnCooxDxzNkl5DYl0gGnqsl+B8LERSuQMGQjBgQ8g7wjRwmmQFRkUKT+6zaZGj
 M1brqYtGHAow3rLIIxu9MXvn03NxWPNfepj5cJ7MYfzhs+xcCOnF3txRI95uk5VDQQKr
 qhywywSmSTcYuE3HbhEVkHjMzLbg1ZhU9wkHDusgUTqlbsHG5z8sUGH0uImpJug6b5+4
 L4MPX8u2rmfkpEkjtNz5g3mX6WKsCEVsS2kB4FORtQnr8cvJvXXSFPeloGC8jCvxYI8d
 hk14r68MnBciuip2w3fyt9cDC13m7SL4Com2LVHUT1za8gojPU6YH+fRXWeGhJTFP2nf
 Mylw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwXYiBjXY4jQQt4iB5J/el3/kUqpU6Ia3E2vO1n2bm7u/nAewJp39Z4OPvE1AsdMjjiKDJr10=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/X3Icm4KDxjoPPiDUQm8cSKcT5Ci4PKX2Hhh9k3uAP/MwhA4I
 qe4Nj22tnacuq5c2BjzW3s9Za1SZ98Ampy6GXR0sqT4FVrPdRKOvS+7kcOu7cEU+SMH1x7wCkkb
 K5gJM61oclkMJJPvGSpbFs7+1qaHBcAkQJa87gUBEe6R2yUEF+xz4s08=
X-Google-Smtp-Source: AGHT+IFDwXrDANkcd+ftqLrL9KRuZTa+H+9fySdUvrwVAnmsffNTn/yAoI106BN/qn7BUn2oP84tCLVw2LfnHcyDjyc=
X-Received: by 2002:a05:6a00:812:b0:70d:1b48:e362 with SMTP id
 d2e1a72fcca58-719262065e5mr36721461b3a.26.1726755032060; Thu, 19 Sep 2024
 07:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240918215804.21809-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918215804.21809-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:17 +0200
Message-ID: <CAFLszTgG-Zf0RW_mHMLVQowcfZyV+AFacofWNM48C648+XMGbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: correct struct expo_action description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Wed, 18 Sept 2024 at 23:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Correct the description of the select.id member to fix a kernel-doc
> warning.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/expo.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Simon Glass <sjg@chromium.org>
