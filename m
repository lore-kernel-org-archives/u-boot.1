Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F15EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C23784198;
	Wed, 31 Dec 2025 20:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i+rlql61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900CD84199; Wed, 31 Dec 2025 20:30:50 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A847584183
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64d2c50f0d6so13417138a12.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767209448; x=1767814248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8P4C4+BQMEArfyeAK52HaqMNA2d3hGAhtNU7oI6ZDOI=;
 b=i+rlql61WOSJytpDoQ+T1F5MUZZvarVTQqPL8lmi2HjEco1Utrm+R5H4oQ36nzAqjM
 dcjL5X8aL8pOemS8zc2lKbLzwLKOfFkVFO+i7pK8weOd7eM5fZvxTgAPJ9zJIR0sV9Rt
 arOoRmqkPiG4hsZAJI5kHDVQhnjVdQTJY96b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209448; x=1767814248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8P4C4+BQMEArfyeAK52HaqMNA2d3hGAhtNU7oI6ZDOI=;
 b=pbNWkquC3iKg+y2sueenhKO6UGeloECW2pErjDiJ7TT2Uy6aKTrJDiGttCDg82hcEW
 gkz25cbv45jm1+K2E8hHDGIsUEhBTWnOxd+BeGFMrph+HjXwJFP1ZXKZ+OW2nEeHK3p8
 PW6N2S0j3iCLXXmUP5rBkAuBe3RMm5ooDOcCuy3VxdG5ZxYklps70UcTlKXvEeNulX67
 T0pWUG4zOt6Ih8MdF8N/sIsn0OAz+og5lVPjvPmbxIropnntbUzKx0vx3r+cr47VH+A6
 2MjPsQ/1zs2RiBXxg2Oz2fFRm5Wq/C7vM1QkCD7jyBiSrTI9fkGqHXT8uItKP4cu/0B6
 O0vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY3stQbvkh9ND2DpQcyzw+AuHf8hGwpHARPO697m5fZ5AzKWGPYsSc8qpei6lgRanSnPM4VA4=@lists.denx.de
X-Gm-Message-State: AOJu0YwT2k8kdfH19RGKvqPgfWd+hqUp+d77pEumqyJYJMJHr1lonUki
 BIxOGfmleW+EMtIAYd/sQuBBVk9s+BN+kdFfABrmMqEPWKMbZpC01ZvT6hcg5phVM/ZR/EeiJy5
 YNsdPpaIt3nTFLBxEFhazoP2yclxrJ1VineR3VZtc
X-Gm-Gg: AY/fxX7NMCuXYcTKjrXp6Ed+cNeEHfi60Q0TPeVq4HkWUhV6pU9HxMsuVldpZXLp7Jp
 Afyu1cWb274NQms/7c87oWaNjv/6+8ou9CQ3LbFZFt4H0Cm66lg896mYSH849/XzKQT20yf0F6Y
 udQHqCn2aCZP4jI3MbWbdMl6TnNxL8FA5Ijo1fej8Jw8mqc4PGiMrjHtnYB5dWdDnHd77jokLuQ
 vEu+PKrdpD1EArLUsgw3NiBgTXegSf1Y5ohJmjf4y4HwXRNeJ3/JzYj0FXFOrHj0DF7vg==
X-Google-Smtp-Source: AGHT+IEqYaWT6T7lO/y5jIfTTDIMxgOVzJeHDBmZifLLPshlZXUpQZFv/uINtJotirnxFfMBCOu3JNJwPNwiBt4yKpc=
X-Received: by 2002:a17:907:e109:b0:b80:4030:1eca with SMTP id
 a640c23a62f3a-b804030298fmr2792718066b.2.1767209448136; Wed, 31 Dec 2025
 11:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Dec 2025 12:30:34 -0700
X-Gm-Features: AQt7F2oLR3H_2lM-M81kpGsEjs1XXo9xIseQdy0cikHkXrLiNpy0qAnwxek5iKo
Message-ID: <CAFLszTjwFv8U-Y9OWwid-072TQGAF4HwCk62p7GPJFcsxP=eEA@mail.gmail.com>
Subject: Re: [PATCH 1/1] video: menu "TrueType Fonts" depends on TrueType
 enabled
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Alexander Graf <agraf@csgraf.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ion Agorria <ion@agorria.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
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

On Wed, 31 Dec 2025 at 07:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The Kconfig menu "TrueType Fonts" should only be shown if TrueType is
> enabled.
>
> Put all TrueType dependent customization within one if statement.
> Remove `depends TRUETYPE` clauses.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/video/Kconfig       | 10 ++++++----
>  drivers/video/fonts/Kconfig |  4 ----
>  2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>
