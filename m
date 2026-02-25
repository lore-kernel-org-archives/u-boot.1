Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E0EEFD205
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 08:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944BC83D8A;
	Wed, 25 Feb 2026 09:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="COT5hHDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4280F83DCB; Wed, 25 Feb 2026 09:10:33 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106C382A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so1127857d50.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 00:10:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772007029; cv=none;
 d=google.com; s=arc-20240605;
 b=MUVSjHc1oD2gpb/EcAq3IIAKh+7NDz2s63Jdnw4BMWOz5gqc0nxg2reOjZ0LxzKUzS
 NUvrhwKysLt8IMIGdcPksYXSo9MoJddGJhe48XXJ9m5ITnSAFFygsuV/5sdlGjyxYZGQ
 GLdHdA/Lp2ssgTEnKwPwigRTqLV2SxL2cC0NLII+ZZQfAHdFYUb419KWWQkqJfQ8/rBj
 Yb2ki6S3nqbqRsa565zw1Gp2GMx2Ik0JFOJSSHqu1ULwbqhrV1dHu2xxoi/k8sBOfZ4h
 +LDyDmujfgMizxgrK6DRHeO3MchPaGcoEEQb+DJj0LzVRuzschyhTxeB16yDjjR2yUSV
 ZngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pUl6Mxkb1bGOI5/daRljW4TRUiCUPwZYNJCMOO664Dg=;
 fh=hbKvOV02X+8PWkrCf9p3tdfQnwa3mXZTWJ9bXww9VPA=;
 b=KkZdcolmj0hCdRLLtFyH6Ber6NpFgBuC+PH34V9eIKpnO2K/FxTBiSonZ8/5G0sE7W
 oAwrHTkzL0nkTMlHOzKZmC4CDoSXKvRCDIvEDzpktnXLLViialsZXJKGfLVVZK+oIFen
 AFMX7kzB1qe+oyKnGF8fJlPzkDSnWVZwTOqqrwhfuN80J3AyCpKAOHEafyfpmu/9YBXb
 mY4U/VNVz3Kqo58Wnb0u+mOqXy/gAOGOJYQTbAc0BvhLKOc3GRuNZUYudk1jyMvw6JzO
 IUAX8gHBgOMghgxqJjTQlTJ6MvH0sgUaLYhaNSrBNddNLoVoRzIzuiuzi/oFB7MY1tgx
 xqgg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772007029; x=1772611829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pUl6Mxkb1bGOI5/daRljW4TRUiCUPwZYNJCMOO664Dg=;
 b=COT5hHDaaHVcetAOX8bY7WnZE+woibmftz2O6pphgCpmxwS87S9kDyRKonct46Yx80
 AtnHisj+z0mI3UGJsXNonU56dKPrDbPue+sv31aXA2tFGYc2FF+Fjp17ld0YmixVZvhR
 jhyaC28jgfBHp2qBvPW1KFu2Vq0dSrp/lokGBYzt4Vh6Zyl+fnbg/rKEpKCY4Lgq8KtM
 sZbHimav3zP/WWa/2kvUObLvb5seOXFs8zPJAR3F7n+aUSOJ2BPfikpGwd42izuotmVD
 4kaCoqf9gAYyxVfUv8K5kPa6MTFAxmK/2d0ATr/FYbJ2eW0g6LUjwZkilVIJWrsgpmzD
 6TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772007029; x=1772611829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUl6Mxkb1bGOI5/daRljW4TRUiCUPwZYNJCMOO664Dg=;
 b=ujMi9r+VPZA9jbp10VExS72024gScm0PCJeelmOpTy8Xl5bV3tz3SHorLgMrTKPT0P
 RukHqE193bEKyeoH9vCc2bM7lcU0nukyv5UZiV/VUox12SFJqRHV9t/x/LxY+j2l2xQB
 ht85oF6C12u69cmvnI/IiKF3X5W/csiTiPektqGV49AqcsOzekym3iWwsUAUOglKaxUz
 V4ZMSP/ukwsnGL0eunmGU4AEg/V3NlPmBe6d1EhEZkSzs8rkkumszlVJelPazeI1Wl4l
 uwW1ZkUHQNkSSG4mTJwtywXy2xc6VnVzPTID3dR04pgYVvd+b7a9XpScVCtQDobHFCh6
 UvLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgRGAJjtbJJv7PBXE8ectKMjt5Ffh8YI73BWXWFoQFiAO9OkHsJay2NjkBXcuKhcI9eEh0B8I=@lists.denx.de
X-Gm-Message-State: AOJu0YyEGVRMgdbZx/+EXHRxf+mWlK8RrTdI5l0PE3Uc6uAsDxpUPPs5
 e5oNXaaXaI/P09YhJdUazQa0OWrlv0VsbGs+bpykMMuXHiFqCXMXXc83X6N/QshdpmgKloA/xVm
 TbbalxJpTgZheXlbDm2JIhPAY8Ygj0suQEetTH4zJIQ==
X-Gm-Gg: ATEYQzxCWNm6CwQmXRT37Wb9HwrOxWrTcQid6lsIRYrubjcj0hXZ2z2vSvBJ3CiFeKo
 xJzVzhYNR1LfJ77FcZU94uJxR9+y0ksqbOjmNursJ55NcBUU+J9eXf/4LH8Ed4F88hyeqKb6Pgy
 y7LPNJJ5HVPpIh6nvJabhgVkWtKflV2OKKMZWay+K6KDAO+bQJSK3lYk2hxQqRzeaivQp2dejgL
 tJGNz7r1VYFxAr0/JePdrwOLrcpTJB52mWWPRzMC3MzFrSdHYek4O9dSF+7Ydu8/O8rMxiXwHXY
 1Vw3552xwQvDbhKRNnf/QyRfFEa3l1DAETKCCGdvJTwgYJmNMzqaGbum44PoQiYVYeZHuJqaEQj
 eas6fKV1x/tyImiHrgbzw2QK8oxHeEDSlIX/uzfhWc7sidt+4y9Bszmpp6F8ezQ0+Ce1hADgwVV
 3OMhWvFdsAS+FlFc6iIgZJnbNcitOeGZld6uFeEDmMC7DFqMiBOKMXRJf3+XIehDqhHQ8JKPGSl
 vR+ym5jV/8drOVn8kLeVCOhLWTTvLkCvLzhv80f56iaRDb7ejE5h3wtJUXHgg+Ng9vD3SBranXl
 yP+q1DZ7Ax9Hqk4LhmDwI7zGtix7cyzboJIsJ0MxddYU2yV70wldql8=
X-Received: by 2002:a05:690e:e8a:b0:649:d468:f79f with SMTP id
 956f58d0204a3-64c78d30489mr12115018d50.59.1772007028615; Wed, 25 Feb 2026
 00:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20260225072359.50691-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225072359.50691-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Feb 2026 10:09:52 +0200
X-Gm-Features: AaiRm52CiGlkMTAPy--PfX3zpDFLfic6s3X18qF4lGoLaPMyLMzqq3hDV_9qKvg
Message-ID: <CAC_iWj+wbMmnkcmnZnnduh7YaegEZs+R-ZqBJJuYp=rFFPQSPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mbedtls: don't use non-existent
 CONFIG_TPL_LEGACY_CRYPTO.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Wed, 25 Feb 2026 at 09:24, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Symbol CONFIG_TPL_LEGACY_CRYPTO does not exist.
> Don't select it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/mbedtls/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..1e0cf8579df 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -556,7 +556,6 @@ choice
>  config TPL_LEGACY_HASHING_AND_CRYPTO
>         bool "legacy crypto libraries"
>         select TPL_LEGACY_HASHING
> -       select TPL_LEGACY_CRYPTO
>
>  config TPL_MBEDTLS_LIB
>         bool "MbedTLS libraries"
> --
> 2.51.0
>
