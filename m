Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5B0105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 12:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F6F8423D;
	Fri, 13 Mar 2026 13:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nRoUh0+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594B6841D5; Fri, 13 Mar 2026 13:56:52 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3859984242
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64aedd812baso2161325d50.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 05:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773406609; cv=none;
 d=google.com; s=arc-20240605;
 b=PVzWqYWprW4i4ioN4Y3TZ3FkKahKSXAeBhuLxk7MBdL2zCh7HcFbgiFjdzNjHNnWIE
 50JujjeeL255M/aS8q7DJSBTSqCmrq5QgxLv2fZBCfb/XIXhXQD6Pj6GN0YzUW730T9t
 AwmrDBa361W2eRneej23ynR0ZbQWqQEIu6lfJr0HWLKgUmpJn6VpADcqsU1wyM22ZTnf
 HmyEgwpdWoBQPqZGjE2QK+ZcUjEmZE6ZYGKm4RL/XCLBGCf2rUeFVkrjG5WZD/Vt1mQ8
 3oxDqK1a7Qd46aibUnAR77cqlC2ipydx2WDAujITxNZEWxD4MJ6Zyf3OorQjjaV5W8zK
 EcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6BdWTySCT/vB270/o0vbONxnFs8Vx2aveHyj+ayMQIU=;
 fh=KE4jkT3nfpNDJEqDiskbASDEnUaFKefBEeDGTA6n4GQ=;
 b=TwBENOYcL3zIz7XFUjH4Zy2U8l2uzM9Ri4XthwlFJZfhzP2j9TgHIAK4A/O2Kc5E0u
 i/WNPWH9wMitIIv3dG8AfEG5D+dhu0DoP4cLyUBVTa2IbydzX70nEEhMGSxhLT/MhwM9
 OPLrF1Dte60mrqj4bVUD9XqSGHN54DL8Oh+0piz+9mNJP/54VeGlSeX/v597q7yLlahC
 AQoEV78Hngv3BAm9+lrlCIsI6ZNjcKV4r8QKESl6npWiFN0Gv7qyr5ANR2uj84j5n3Gf
 JqXi3PZbMXj90upg0kUnsplX1ONE8uEeNl7u4AZrazKL071QlVXWvwxPG/jkGkjCI5zo
 54Nw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773406609; x=1774011409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6BdWTySCT/vB270/o0vbONxnFs8Vx2aveHyj+ayMQIU=;
 b=nRoUh0+SCijKC1Iw15jbZnF0psYiQSAU6pNnYhtiSjE7VIPO+VcvS5LW3/ECyLIGLU
 OzVlXxCuFy+sQoLZb0O18SXTXpDL5VwPOXaphWGESH22UhTZNV4aRiirV63vEZEGDBkj
 JtiYINnA9+OrSygGOVFN18Ke3dk06XZs2dMfKF65oCrNb/9/ztdXnCx94jCgxuBpqAFi
 XWH5o2wUKJIFQF+INMZUOF6OXPFhYHiulfGMnzkU6joBGHkgfvXFtANNuQuHrVK5mJPC
 mBrEMbh/VjnOPW/UFqYnd8HhvHzNJj9pZA9A0iD3Y/ixa5T479QjGF4OR/gKML82W0im
 fDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773406609; x=1774011409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BdWTySCT/vB270/o0vbONxnFs8Vx2aveHyj+ayMQIU=;
 b=PU/NHiwzpv2BmkVWbFSSqHUqrqaboJJWGC6yJA+Z6snOregNxlsYawv8/ScvANFr2z
 T5s/Jmt5I4/QLLGaKDMcZiBCAJ5SfFh8qBmGuFJMv4NrSbspLgkECgOGTW29gkHz8vMR
 XUckBQIGYdWfuuMsTmf1u0u0UMp/3Wrv8rTKbeGpbkp5poUj1NtxrJfE3a3XC/btYHrU
 UpB5sAH4PX/LImiLm51yLHfHJ1wkzJer0yoUz1llWAWC39HAza//OrxeVD9GQ8COP5Xt
 qMJofxjIV9nhfm1T1RiyJ7+GsKBGCPTNHWRl7lltuQ3fmWdoyjioSxv0md3zBGA2PKHV
 8+GA==
X-Gm-Message-State: AOJu0YzxrVbtPraZaTYQ5k8uNgIDCE1tFO6dRRwvH+dhepNd/U+JN2dZ
 63EJsIy8gf9s//D9mHvAnKI+OWe0HWbTuYUeWamDnNALCq2XJo+4cberX9DGpks9sjNcSHkHOfc
 r7PTrNr5vPSzRcN35tLfGWo8a46i9nc5+4pa8hffjO1TsQb8Ou9Vygm4UAA35
X-Gm-Gg: ATEYQzxlkVyEbxvU8fdDaZuSexyXUC5jQq9b2KUTrQa8mhpCVRZNS1amIsTmrmLDbdE
 4Q8ZMkZ3zGfGMbL+J9yE55+2s5nMPFLQuGsK92sHSInYKmc9t6XcvS/bk3arkkrZfg64KHjOfTF
 hoTQWhbIgRF7tv8LqBq9Ji5Mb12pVMx3YFeHvmsQkB4wCTeSUDQ4jd3M6QarkvhCI3GO8/ZUeqN
 uxJgl9sN5OaS52DRC4bH+mmUYkh7vhZjfZLDliuRTP1Ff8REbaG/Ya6/QIhokXtwPc/7tyqLqO/
 Gzdrjky7mVG4zOSU8BK5X6Qqt4EkQrxL2TZOrA3gBDxuuP0pVxq90Tj6iD9Sdwu0MRaXbWu4+7b
 ckIZ0rJL5Neh9PZWet7n6L92Qn6ybVU2+Z0x74doHphPn+lblnY9laT6Tl1J5qN/nzQWfB+rmm4
 oBqHOgmiyVtTxC+dg6XThrn9Dn4sdX/A6qPHH8i9G2Jq/qPKrXlMBFkILJ5f2u4ZuULdc4eR/em
 iKVdhNg2ygiSYGl1Ka4TYh3YQ+akflumSrjlpCGJBupbtYZu9XIRBzkIyCjnOutqnszfuuDXEyh
 jjSpAUibKTx905W7k7aqy3EXCUbWZNvp4Iqssz8J8a7z
X-Received: by 2002:a53:ee0c:0:b0:64c:9cc5:573d with SMTP id
 956f58d0204a3-64e62f6e808mr2352264d50.32.1773406608966; Fri, 13 Mar 2026
 05:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260310162621.1163932-1-trini@konsulko.com>
In-Reply-To: <20260310162621.1163932-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Mar 2026 14:56:11 +0200
X-Gm-Features: AaiRm53nQ5a3P1xTFRRy1Eyeoir1k8sjKCXiOx2JXhpR9eDJEYDrdzpcYdPphNg
Message-ID: <CAC_iWjJwjuee0PYv1dWEeCJ6bE1d6W4DUe+1L9cnvo0vGvS6Yg@mail.gmail.com>
Subject: Re: [PATCH] dfu: Make the DFU_WRITE_ALT symbol available outside of
 DFU
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 10 Mar 2026 at 18:26, Tom Rini <trini@konsulko.com> wrote:
>
> The DFU_WRITE_ALT symbol is used both directly and indirectly (via
> UPDATE_COMMON) for EFI capsule updates (FIT or raw), but does not depend
> on DFU itself. Move this symbol outside of "if DFU" to remove a Kconfig
> dependency problem.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/dfu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 2cf4289b4486..962bda40ad2d 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -13,10 +13,10 @@ config DFU_OVER_TFTP
>         bool
>         depends on NET
>
> -if DFU
>  config DFU_WRITE_ALT
>         bool
>
> +if DFU
>  config DFU_TFTP
>         bool "DFU via TFTP"
>         depends on NETDEVICES
> --
> 2.43.0
>
