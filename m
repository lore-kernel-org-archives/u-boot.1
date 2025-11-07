Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A430CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 12:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F06583D17;
	Fri,  7 Nov 2025 13:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1Tq2NLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0F183D18; Fri,  7 Nov 2025 13:23:14 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9764183CB1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 13:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b727f452fffso113952666b.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762518192; x=1763122992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8eGt4sLyz6zrHGm3ziRhNP+2weGnPJOGp6caajF9PM8=;
 b=b1Tq2NLbhMBAwvvQ2rzT7FC9sfXaHgcxfoFi0kUK1m/PCZ7/XACOi7XUx7iyCvOGy5
 nt2gvAnPsdeoXxVh+jcyw6sAp/X60YGVbpmqHU4lK7XgdyQjIIBvfHXoYR3q9ZAAHKFh
 ivbvuj/6OEqVwU/DSR0pdnb7vAhOoc/wW9N2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762518192; x=1763122992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eGt4sLyz6zrHGm3ziRhNP+2weGnPJOGp6caajF9PM8=;
 b=wDVH5vnfNu3ghH5KcgIztI+EzSjG9bB0ywOmYuVxzG7JthWn7N5sMjMSoE2oJUcLH3
 Vvzt9Hef2DwZA0+z0vH6pEaEKYNH6k1y6Wr5G1/er+R40VqA10uPZqy6xbHMDkx5c6eW
 XPlQm+xr3B+vjkr/9bbvyRxs5j0GQo3Pyn5fpmLwW4qn+P84zoEahZiba0Eex0M+eM2g
 REoHkzXiERYfPEcnX+hK8TB96SGeFM10SWX5aCSpQiPg0GLFEFbyfyObtdX/pz7GSqAs
 VVRGDB/wECfNMsoSiXe5iLAB427b8XGvuLXzk2Y0vPbA8AEaWKUsVoao/hzYLuVOF/+U
 cF7w==
X-Gm-Message-State: AOJu0YwTkgFj0sqcTnJcEqd/kKogdyI27s8+iOm1yvIuhqNvc6H1bGqC
 MCNoNpI9Mg5+La84fkHZqFlHMYREjUgarD9Dc3jEgyuzjDrYm34bx6MlKgAKV2nE2avWYTKZGT8
 KVNHmQkG+rFcRZWeL5QwfPpeXVanFM1+1SR1R3ISh
X-Gm-Gg: ASbGncsOm279BrFMLGEZtv4kYVOxETa+bUP9VbFBJQBHLk/PQ7rh4HXfx2+63eQHPwG
 fMZVuAvNQ5o0urJRmpOOY2s+BwPrUVoTFPkLEdAzsru/m4mwtH9SlvJ43fmhiIcJU/5p3UAKpKz
 8FPS3WsHbsaM4XdK+5Il036r0t+vYYhXizcJgYYmD2pMiTUnyCCcLIuoGIzGa83aEPKK7iyW7Av
 OJ3TBjz+6Su52dEF6GjRytZOdm4cXOy/eAkUC2qd/GLoMVu+yjK0Xwf0N5/98y1ll4p5T0=
X-Google-Smtp-Source: AGHT+IG2fJuV3ar9AwarU1uLAJdyRxclSb0vVJ5HyKi0e6hzMMDN/ptzOE7mTcEUOQwqYOaP5bz8CJmQaDTKVw60jCw=
X-Received: by 2002:a17:907:1c12:b0:b53:f93f:bf59 with SMTP id
 a640c23a62f3a-b72d0b3c51fmr195550166b.29.1762518192061; Fri, 07 Nov 2025
 04:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20251106232836.3243591-1-trini@konsulko.com>
In-Reply-To: <20251106232836.3243591-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 13:23:00 +0100
X-Gm-Features: AWmQ_bkBmnvvGUpPWzhH-iFqBGudCxA5iAwBM8qOkczOO0ilN5ZWENyS7us9mHY
Message-ID: <CAFLszTixiE+gxoOsV1tc0JLi9pce4pgenp2WGObLhED+txfjRA@mail.gmail.com>
Subject: Re: [PATCH] buildman: Correct override toolchain support for clang
To: Tom Rini <trini@konsulko.com>
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

On Fri, 7 Nov 2025 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> When initially adding support for building with clang with buildman,
> there was some minimum logic in the Makefile to inform clang what the
> expected target was, without CROSS_COMPILE being set. This has long been
> deprecated / removed from the Linux kernel, and also not functional in
> U-Boot. The normal expectation, especially so that an intentional
> mix-and-match of GNU binutils and LLVM C compiler can be used relies on
> CROSS_COMPILE also being set and passed. To have buildman do this we
> only need to remove the logic that was not setting CROSS_COMPILE when
> we had an override. Correct the comment about what override_toolchain
> does as it is functional outside of sandbox too.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
>  tools/buildman/toolchain.py | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I don't recall trying clang with real boards.
