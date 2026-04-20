Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB40EA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A665583FF5;
	Mon, 20 Apr 2026 04:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l/p72jia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F9E84181; Mon, 20 Apr 2026 04:51:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C0C839D9
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so582473666b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653511; cv=none;
 d=google.com; s=arc-20240605;
 b=fSnqN9R2IwTIsrLB85Fj+IP8h7H5C4qBm9wHU6ZwO4TK6p2ZOY4ehyjoa37diie68p
 OxS+bMBQB8D/Z4BQ9TP2JeW+KV5+IDR+F/953qGOsmuRpJV2IEhpwYYBdmtQWPUx7rhw
 0q+QOFhHQhFM7hOf3tjeX4fvAPas5mPbJu48ckMrYBYxANhiJ5JuJ+PfG+vT0oqa++rY
 x42W64a36xFNAJL0XRPQDtRCmTqYLv4clFHYPL5jN5EF96WCLaxIviRo/DDC7HDuPrZu
 eesprXG1m25f9pzKZc6vqYoZNVFX3JXqEtzO/ivB9atUF3q0y4+GR9wvFVsTgZ23BEi8
 3F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jKJoouf7fS1ouR3xXWGE+yMisBsO8OpIDngL0FzSeV4=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=jnW7yYAaTx4pcpY/GC0fd2kiSe7vBbaMd5F3W8Z6gZjBdB0Okdvu1i2h7GuTifWvgu
 ny4fZZPKFhXDPkfokFyM2hFJV7/xOWT5A/3qx8U5hhMh8/M8LzWyNaMbLAF/FElo65fb
 +9z9ANtlM/P+lHgvNRpF6VmC8LOkMyTtGtR4lP2y4YwHcJaUuSNXuW3DbZfZJN+qhJYU
 +fSpQ9lZOFpKRbarJUCD5KjCFRDt7fTzHuSLe3DaNP7r8r1nwic08qtHAn6d3HlAHYYD
 ssQELpOi9PDm8DTk1h6FTnKyPFrY+r8p9HFUD/zO3UEmgM24ESENSXA29kTEDtZEJQ1V
 G+yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653511; x=1777258311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jKJoouf7fS1ouR3xXWGE+yMisBsO8OpIDngL0FzSeV4=;
 b=l/p72jiaDOnrWhrrbeXdjekvlDuLh5Argz5Ot6UjPzQv/hnI2bjQuFN/lclwk8NisG
 oDufOL4G1QK/3kqzhbmSTHV8T/ACDG+6zOjedpon9iszFhOqjzer8GrANpzCozrA2y+J
 9tvGrlwa6Xif/nlE/+WBq0Dy+SAQtvkT6vMos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653511; x=1777258311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKJoouf7fS1ouR3xXWGE+yMisBsO8OpIDngL0FzSeV4=;
 b=KScNSHoiJj0nuCf7LpfiiGBL8VWbZwx64kYk7PfuUlfgInGP1y3y9F5YZUEzOrWF7j
 K/uTB6SkqD4z/L8aMsg3M4TSW8JAmKPlBYmc09uOvLlOKJUWn+zsvkIFZcYlQR6aGr75
 MnWGZJuSckihkNZnHRWI1KINZ2qOFWJDWRs1qQqGiXGtpFSlekIUtR+LJGRSjlfLDetm
 xl/eGTX8J6ILkSWWxy//4zhRfQWuI8rOR1CT0Cq73/CvdgLUgweL0iiBAbopO71TO3y1
 t8hovKT3Mk5hLsEI5DIZ3BYAJMyeqmVtroUUu/QkgiH4mkOcByZUz8XNcxJ/99bkWiqi
 R3lw==
X-Gm-Message-State: AOJu0YwHD08bx6Ua9/yt2XFR2O/tjXnLN+3xm1oBGRWdCXDOJCZ9td8V
 yAnawP6kwOog4E6SBqfnGYWOKDrnlKQWucXRYMke1FpegBhthwZDsLjEiS98PkKUAl7VliSCH0e
 3iMbyk7uEFuKcAWRI0CHcLJGzK+WrrMI34+swhmMR
X-Gm-Gg: AeBDietgtjq5zwo8XeI/JTa8DjTWK4eXBsavrPzHMp6q6mqqPxTeLCZeU7cpw7fdN6Y
 xWXABySt8TYJbWY46IKAgdM1tGhTGfySgXQM5IiykHNoZqx1irxfOk6cACLjWxQlFAsHielzHMr
 tOxP5KM59gjqnYseLa2TmhbENegOPQgiJiApolKwJX8ImnNoSMr+RhATVYPTTyonI3Vxc9/7nXA
 /mV/cn/r2cKyEBLRifqR8/TM47m3m4lckfYOTBJlhSwlbYs2efuB+z9pKPR33PEBML/RIW+yTgs
 wCQICx/rC/o0MVUGbQV5
X-Received: by 2002:a17:907:60d4:b0:ba3:eaf1:2743 with SMTP id
 a640c23a62f3a-ba421debcc2mr448888066b.19.1776653510990; Sun, 19 Apr 2026
 19:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <6564b0f416cb7581aee5d7a3ffaca62a2109c32b.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <6564b0f416cb7581aee5d7a3ffaca62a2109c32b.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:51:39 +1200
X-Gm-Features: AQROBzDvb2gHC1wbClpV3UpTRbfdaSFajO9FmSaPMBWAgKwl7zsTr4tC-m6QAEY
Message-ID: <CAFLszThmT1RoqXef9vYc55prSW6KypHUEv-4t=ZtfRrwD9eiNw@mail.gmail.com>
Subject: Re: [RESEND v4 05/14] mach-sc5xx: Add USB boot command
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Add USB boot command
>
> Add the USB boot command to the environments
> of the boards that support it.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezkit/sc573-ezkit.env         | 1 +
>  board/adi/sc589-ezkit/sc589-ezkit.env         | 1 +
>  board/adi/sc589-mini/sc589-mini.env           | 1 +
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env | 1 +
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env | 1 +
>  include/env/adi/adi_boot.env                  | 7 +++++++
>  6 files changed, 12 insertions(+)

> diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
> @@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
> +#define USE_USB

Just to check - sc584-ezkit has CONFIG_USB enabled in its defconfig
but this patch does not add USE_USB to that board. Is that
intentional?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
