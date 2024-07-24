Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCE1C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 07:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EB788896;
	Wed, 24 Jul 2024 09:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qk43pQLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD74B88896; Wed, 24 Jul 2024 09:06:57 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970E3887F5
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 09:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25d6dd59170so3190208fac.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721804811; x=1722409611; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ny5zw6it9ju3d89g1qPbU6u3QFBzldQPmn10FIOuN4Y=;
 b=Qk43pQLbHAaimTBqS0zNS+hi4Cu8h2wei1Uju8hYr7A1IBl0onOmHD57WFO+DhUHiG
 ttsuml883dJN+mK7Sky/59lsXMUaTUsS37a6ixSVp85KfesuVz5gd1P2g1c/INcQ9Pfs
 4K8CB+obzlwI0qPpevRDum1KnOt8V0jk01NptCHqbrDoGkRwI/GIMCrvaXQoUP1tfDHX
 2OPWUa9RgqQrPEDfs75zcuqngdMinuM5dV4jJEsFm/YuwBB09JHBgOd6VQ+IsnREo8O0
 wkAgSGJhQBC6bUDaHM7iwtRgU06IZxcakeRxE8KCI/YUFyinzaG0fuEdrCCKIfZReQE0
 rBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721804811; x=1722409611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ny5zw6it9ju3d89g1qPbU6u3QFBzldQPmn10FIOuN4Y=;
 b=N7CticQNlM6qDbxM9qecDxz9s41fuoxm0Gt3Np2tBbrk1fidMVUB2VseKoF7ANmgII
 nZL4iTTAx05jx7WGtUBew+MT/IrrH66m6jgwd6eYbmyX318PjXTl0xMfRBcBRM57WpeJ
 8ZB2m/6FQARWlrqW4/psZLKopqp0WFNZhskzLVAKEwOodPyIK6ypSjgNjG56tMzggIBx
 /o9tmmYg757/39JHsPYKDeNtV8oqO2msbH6Hs8Lp2lhbwpBoVfbsQLUGyrYwqHG6Nux6
 yOQjtjuWyjIk6lfLHc7ulYUDjqyTmGtPuwNRXKnLRWqzKpxuzSjeoeU0hV8ufTNTp1Uo
 trIQ==
X-Gm-Message-State: AOJu0YyD4lReSQtYFVkb3KzJmbIiULd5ngt67gNOUlNb58eTs4ZAm+Gw
 Nkamj2mcwLpgbbPIMCWSc2JzbmJamB8PvD1Z6mcsEvBKkBk0/KR5LOi6BpYwgEmC3+Jso5S00kN
 l/98KHI1JGLEEyKDZlKoQilwOPvHQQkY+ciK09A==
X-Google-Smtp-Source: AGHT+IFp8/SGEtzTcv82XqDeMxJliXUJEPGcwIu03tMFXXCp5eMV34eaJmYdajhkM0+8q11KHZmM0RryJZtol/GKgGw=
X-Received: by 2002:a05:6870:3281:b0:260:df27:99fc with SMTP id
 586e51a60fabf-2648771dc1bmr2067165fac.25.1721804811160; Wed, 24 Jul 2024
 00:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-11-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-11-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jul 2024 10:06:13 +0300
Message-ID: <CAC_iWjJwEc2EZ4Lp+1ucxEBGJndcJBdb+4MO_LuMDpnOe-YKJw@mail.gmail.com>
Subject: Re: [PATCH 10/40] lmb: use the BIT macro for lmb flags
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 24 Jul 2024 at 09:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the BIT macro for assigning values to the LMB flags instead of
> assigning random values to them.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  include/lmb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 7b87181b9e..a1de18c3cb 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -5,6 +5,7 @@
>
>  #include <asm/types.h>
>  #include <asm/u-boot.h>
> +#include <linux/bitops.h>
>
>  /*
>   * Logical memory blocks.
> @@ -18,8 +19,8 @@
>   * @LMB_NOMAP: don't add to mmu configuration
>   */
>  enum lmb_flags {
> -       LMB_NONE                = 0x0,
> -       LMB_NOMAP               = 0x4,
> +       LMB_NONE                = BIT(0),
> +       LMB_NOMAP               = BIT(1),
>  };
>
>  /**
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
