Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EADC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9247B84AE9;
	Thu,  9 Jul 2026 12:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="iNnB8Dfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3956784AFF; Thu,  9 Jul 2026 12:41:06 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E3F84AB8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4896ae35be9so714556b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 03:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783593663; cv=none;
 d=google.com; s=arc-20260327;
 b=dcqCETzMNrH4nSzPlPqiLn4qzFPi4d6biVtJuVcJ/JDznKDeM7GlFm0QhCfX7dJAoI
 5ObMFozam6BEy3yg8kNdPWrJTOrwKzfX8BtTHaEb+b/PX9d0Noedt4PPoLGgLaOKM3h7
 v2ZVyLglFOO6hpht6CgzxWVCaGuOvqGl99UwUOW8qnw5753aRJSYppklnFuva16bYISZ
 XW/UHwUYjx4y10E5HI/XnuIkX9IurTZAqFNVPwl8MBsGS+jkHz4SniNYjmZiWfds/Qgn
 iMZXDyipDxxgESaIf1eyO3b/UORK8xtxIlBodofeb7pHQbSKyF9hEtJiBAkgOL0Xa1q6
 GzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VIr9vzKQxVswZud7OxrFoDiSf0ta2McQIbW95tMuiQU=;
 fh=2JI3BWlK9aLyRxNEBbXNu6t1z9aANpCWS9aLaFWJ6TQ=;
 b=nLNEMMvAmpVywizWJRGct5F5Gq7WCT8GbGIwT/zQwSjkb/3JzhmMd57g5C1DYHulte
 q73bnv/jqkk7Owjdb8LiUe0nOuao2P3UE7gef+WnfGJKWtdAvIItKPKRC+GY43q7N/53
 SFfTn2SGiAcf/u6Wyfy8CeDCH10NHXQ+KiU34vBF12gTObH+VKPXAUv181u8bR0bmnYU
 OrF9RlhpTiJDfGed0732LmI4Nkl2+e72jpJ29vliqmEYDRB+3PBKI79zE7N47i3eXxen
 zrqs7ncpNbE9YkD1fn83J0qwAgX7mrKL+D5k8wjXjc0uw3NrEnatQDagKy6XQ0biMTpd
 8kTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783593663; x=1784198463; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VIr9vzKQxVswZud7OxrFoDiSf0ta2McQIbW95tMuiQU=;
 b=iNnB8Dfw68ojO9Xor8YEZYf/xSnJBSuH0HsMXvpjyRioEdeb8jsl+tNmvZO7Dp1o0g
 YH5hOtpmDCyMxbWB41r3iMEjztWzf+8+Wqdev2ik3yNPRw89v3DBds9cssP7qtkCmTcx
 i2csKZN4to9KGR6WSFZp6v4CvtyvdOQEXznV6BLRDjjnNwLVsrJ3pIfHzseVydVklIj/
 HYDMLGtIs+rU0aIALpbilBblX8LPWIU5CvmSkx+nzauLDxMuZ06Fc6WPS9RDgbuoiSEL
 dVOjk/xEKmgGjc0+M1mbdRutt3fhRbSgBATEtgV1qhB9huFDkJjXxLJd4n+5DtFPQLe8
 BnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593663; x=1784198463;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VIr9vzKQxVswZud7OxrFoDiSf0ta2McQIbW95tMuiQU=;
 b=eG3H4vKHPxgTvNnbaoFLkQfVm+a+UqJxUbVphwUeOled6b+qRfJJGgDSX+UYwAWzXG
 eVKPUvwkpnXuZRgXgR4JwclX0YLa6X2wMVSeCIY7IWkcCbfXjctmXdcJpNlrzyZ2+uwR
 2u4azCnPGKnsh6APO4feZtcdKzfp/hh8tLcjkz9wQxcXGcVUSHcZcBICypcCKTp0Y/XC
 /5AzVCIrkBm7xN/V56p7G/e3ZF/KRfoX7YO3KQCD0X9e7+ZfwgtjG0h3Fk0RNiqC8Ow6
 l9UqpYpyQ16UCsLXrcsHkB/ThXMx5eSKGy9tRV+Uc/POIRBxRA62SNSbXUB4MsyoGUqg
 4LAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tvyqus3CK+F+ZMorVo6sX2T5sI7i7XDOwMYAqcfWArifzjZATJbQC6o6jFMdU7BHxSMvf11E=@lists.denx.de
X-Gm-Message-State: AOJu0YzcdJ6eHVJnSxbrB/ivmvO1O2zKMqK5HcEc5t8BkrAMNkbsTypQ
 pM0bx6Wm9jVuksVYG9yPTWCqI1E0Vh7jZNCBdpAM/QihXHVKCBvSuS67g2stesP1AIVc4IyR/5u
 Xy7JnVw/W4xrNDkSl25I8qAx9h8ckqj0aN8E3gpYWGw==
X-Gm-Gg: AfdE7cmzno6kTNyBOg7/7iEcG+OOh1M1m2e3HxGVr+bHBmL7fLk7ma7S87D+BxN6Zs1
 PtubjqTG4ugy5F3/x+zYnGIfaEmORMj0HIqK9tUS0DFczyjAE1pwFQuN9P/kysvjf0MHCfLS4OW
 4mdCbKPCsDsPu/jdCvpwfKWGh57R7bfTQo1vdaFIkT883g0A0GYcVXdStHBXOY9PSreaUpwAKIO
 BZZoyGukOy7qnxSDfftKNQwkjDVepvhct9VnfA1HdZAMQ+JpDI/boukF9OCLUl7bd5carAI
X-Received: by 2002:a05:6808:15a8:b0:493:a860:5809 with SMTP id
 5614622812f47-4a201c02a11mr6153405b6e.4.1783593662746; Thu, 09 Jul 2026
 03:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260707205611.65287-1-ccaione@baylibre.com>
 <20260708171959.GA749385@bill-the-cat>
In-Reply-To: <20260708171959.GA749385@bill-the-cat>
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 9 Jul 2026 12:40:52 +0200
X-Gm-Features: AVVi8Cec9OBtfL_f7BacygNPU8g2UGDI77AVutUrU5A2SI40hhmv-Nb-QcLLKyQ
Message-ID: <CADh8Lsfs-CtYZN5qMUbp2FTe-0AbCi7G_6TXs1s-m7jWX+z0FQ@mail.gmail.com>
Subject: Re: [PATCH] fit: prefer the default configuration on best-match ties
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, quentin.schulz@cherry.de, u-boot@lists.denx.de, 
 dlechner@baylibre.com, jstephan@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 8, 2026 at 7:20=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> Did you look around under doc/ to see if anything there needs a note as
> well? Thanks.

mmh, probably I can add something to
doc/usage/fit/overlay-fdt-boot.rst to make this explicit.
Let me send a V2 with that, I'll add your Reviewed-by.

Cheers,

--
Carlo Caione
