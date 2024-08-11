Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8296FC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B4D886F0;
	Sun, 11 Aug 2024 16:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WamxSsSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183F18855C; Sun, 11 Aug 2024 16:50:18 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE88F87E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70942ebcc29so2464769a34.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387814; x=1723992614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/PnYj7JKE3Hqyrd3vhYise3JxSYCYhBPmuVq+wX5cUw=;
 b=WamxSsSCJWPXYOURpjtEpbZN+MNHM6J/nE1NlcpnWC0lzUtBeggt57KHuJ/40cr8D8
 z+NPQhzG8A8cO2g7NEPKuf66aNn1XiqGKyAgn9Vy8VJvs8hyKnTwC8PxCT5gts6iYG6q
 ApPIjP2kWdKQHE6DV/MHaIvVJAX2Ogw426nm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387814; x=1723992614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PnYj7JKE3Hqyrd3vhYise3JxSYCYhBPmuVq+wX5cUw=;
 b=lCISGXEC5rStGEwFKXhetr2hI8ehe4lYM+N/brpkDdG7zHUx2uM4Xd6Sha6oKTatvx
 fG1K0G9fIB36GwvIN2f62JZrnZe9pdgF2sbimZVkQiIFPZCzZcz3qNiAE3D+JVXD+cTJ
 QfvtgLvowYhGP+IUBP+ooQ8YIp9fkN6U0IL3kL8H3MupgKDvHEqTIAK407fpO0J2euOr
 Ku96Bl7Tffk+8UXegqT6WBGLQqw0BcHUi8xOTen6UGvWQhMm9SazejxO5kmwcFbNy8Cw
 KlL+TqOimVFKHIobLdjOBZ//UxBxDa0jcgCaBHn18v+S66UJRYgSUtdZx2lP3Br/1cO2
 wpgw==
X-Gm-Message-State: AOJu0YyRzeveejC3c705aUlioIGR9Dv7nQ8/7O9gltC5j0hP2QrQayi/
 /BGgr6OKA//cWog2BhvWX8mhVGcesuiEVerY0QSV/VnCO8zOrNJiohlygVhj+XgnmD6T0yhwLhA
 imawmVs2HMPGz7ouCr/aOHcczgtM/fExBxy4z
X-Google-Smtp-Source: AGHT+IEY4oQ1lP26oeNRqsHUHVn1rFunIdFOgW3wNTrRz2lDwM2VqIraaIZEMHoP1x3MNFQdbvjj/KA5YXG3DNesBWE=
X-Received: by 2002:a05:6358:430c:b0:1aa:d3fe:e617 with SMTP id
 e5c5f4694b2df-1b176f7d2ebmr990403755d.16.1723387814743; Sun, 11 Aug 2024
 07:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240810135937.4041797-1-seanga2@gmail.com>
In-Reply-To: <20240810135937.4041797-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:04 -0600
Message-ID: <CAFLszTiBNsY=1OpNnnAHChKjkv2Sfv64mGjw+gzovcYR+W+52Q@mail.gmail.com>
Subject: Re: [PATCH] pinmux: generic: Use ENOENT instead of ENOSYS
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

On Sat, 10 Aug 2024 at 07:59, Sean Anderson <seanga2@gmail.com> wrote:
>
> ENOSYS should only be used when a subsystem is completely absent.
> Convert its use in pinctrl-generic to ENOENT, which better reflects the
> error condition (that a function/group/pin is missing).
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/pinctrl/pinctrl-generic.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
