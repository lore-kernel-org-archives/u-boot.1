Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB3CC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AA9809D4;
	Thu, 24 Apr 2025 14:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YyCw/JAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D02380F9C; Thu, 24 Apr 2025 14:00:36 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 985A9806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86f9c719d63so395408241.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745496032; x=1746100832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NxPyV06yjE4wiHMYtfQ7QP+cf7/zlLrlV7rLKzVZuMs=;
 b=YyCw/JAU+MIVveHXr3kUxXRDQNduX2vYgpL3gzjIEVutoLA/uln7M7RVq+gvIGq8aB
 O9MlpnCc2FYTigSAB2Vgmgxvu6/+hTXDMY8T92JG/eCgifZaZTjeMlYG1ytqxmpnHrRs
 600yunu6gvwT4Wi9bRKjsSZWaAjFHMfeixwE/RFPYRoRHMRYQK1Ph7uM1dE2cRKM/shC
 7KzRGmrz+3fvlUCUsLrBks77iFposblkD5V0OqjUJ0xjN/Yx1vYvk0iC8ywrBc6tkb5E
 SR61C3qsQvwyTnDS6PFp8iyAVJs4TCUtd1O/mBS8+xqRhC3Tv0Ghj5ui/p/rPDJ7kU89
 rukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496032; x=1746100832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NxPyV06yjE4wiHMYtfQ7QP+cf7/zlLrlV7rLKzVZuMs=;
 b=AYfXjHD2k0VvlbpWO16U9bhO8NlebnBL2362RqmndJlYYYD7pwKeEpLMfpijO95uaV
 3XQGFwd5AhWnmf3pbRNpxHtoJS3Wh3vRx2KvXskatBCOnu+QgBr0Uu2OaplFvbvLctYK
 eWQxeLENgvtPy9L84+uVyR5NNU5gxR4oiSkFZsLLZgqewbsRAmHSYNHGb1Gj6DFXS3lp
 GohF8YXRhETAUbSDT0Y+yIM4uqUlKb/s7h2+n6GwsI0U/U4H4FVG/HQtsAXdW+bvBwfV
 68WHE+znjXzFBkuAwdPcAwQRZUSz1UO+N0D52TKF2+TRRAw6IQgGYdoyNKRLW56gB/Ka
 VJcw==
X-Gm-Message-State: AOJu0YzR/scDChWRVjJW+adzZzolPcHLIZ3/t7ta/G8XdmHlEzRyXBCD
 ZaB6eM1t3m+jUXGP+wEC2MEDIwTPXzIrOuDV2/BMuqULErrY9JWmVXvnYbiacujVjPkkDLeMlz3
 k70vjUybCUf/BOeBjuGaO9l//puzNgiO1khxrUg==
X-Gm-Gg: ASbGncvho9leQyWnsEKf03+fLmePYpkbk2lAbZ4ZNGGWgvchJTZe98NrqlN6v9bOn29
 PTd5jS5QG+vKSjARWbJ7O2zIN9zoQyV3tRd/acyuBmY84BQfo86yiOrJgQ+h3cxI9AuZsQN4yzz
 EpRAiTxYJAyBznFQV6m2eLQ1c=
X-Google-Smtp-Source: AGHT+IEtZy3f/xMFLGUkMVeIsMMTVAvBR+7l21e3XshvR/b1IVIt/m3BNq2NNoAroLMs4d6y/k8JTWjAjxuDxZR6DVc=
X-Received: by 2002:a05:6102:dcd:b0:4ba:974c:891e with SMTP id
 ada2fe7eead31-4d38ebf4cfcmr1456168137.17.1745496030833; Thu, 24 Apr 2025
 05:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
In-Reply-To: <20250417132718.2023555-1-jerome.forissier@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 24 Apr 2025 17:30:19 +0530
X-Gm-Features: ATxdqUFyWPS9SL9Q4wZKLo0mtJT5Lzw7nUnQXRiRDz96XPseOxNWVBuJy4iHsmU
Message-ID: <CADg8p95zBr0H-gj1XQL+Wm6G=65Ts0sZVWdq1MrTo0wJTA=vSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] NET_LWIP LMB fixes
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 17 Apr 2025 at 18:57, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Two small patches fixing issues with tftp and wget when the network
> stack is NET_LWIP and LMB is enabled. Plus one prerequisite patch
> fixing a problem with wget that does printf()/puts()/putc() when
> called from EFI which is not allowed (messes with the console output)
> and a small refactoring in net/lwip/wget.c.
>
> Changes in v5:
> - See changelog in the individual patches
>
> Jerome Forissier (4):
>   net-lwip: change static function wget_loop() to be wget_do_request()
>   net, net-lwip: wget: suppress console output when called by EFI
>   net-lwip: wget: add LMB and buffer checks
>   net-lwip: tftp: add LMB and buffer checks
>
>  doc/usage/cmd/wget.rst                        |   2 +-
>  include/net-common.h                          |   2 +
>  lib/efi_loader/efi_net.c                      |   2 +-
>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |   8 +-
>  net/lwip/tftp.c                               |  56 +++++++--
>  net/lwip/wget.c                               | 117 +++++++++++++-----
>  net/wget.c                                    |  23 +++-
>  7 files changed, 159 insertions(+), 51 deletions(-)
>

Tested that the LMB checks are performed and wget/tftp commands do not
overwrite on an existing LMB reservation.

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

> --
> 2.43.0
>
