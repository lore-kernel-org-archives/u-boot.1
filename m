Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11049CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 16:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D2A88B08;
	Thu,  3 Oct 2024 18:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hNUm9H5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF2B88C0F; Thu,  3 Oct 2024 18:03:12 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B2788AC2
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 18:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20aff65aa37so9101345ad.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727971388; x=1728576188; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7+hNbJBh8B3qs2YXBjugo1xNLWnZEW8BHzC+YV/tyhk=;
 b=hNUm9H5UGvPGAvNKVLka+9iKFnM+v0qRgsFohYjxRwT/jR2KSRMSkHE+1nG5HPeKqN
 xiR36NMRv1mHPEOwPFJ0j3P96isTakslsMSCEk/QH59RYygwZNLH7VFs/Qcbywa7VYCY
 usubLdIY+BQFR2z9iHcr8t7MOzf7L7i5FA/W3ktCRDksQMCfIMDHHTcy8V54LamOh92x
 +5h+txXEQQEkh3Dbzh8pVI05igl3TWQsl31W9AYAKi5LRz7dUGvWH+c1rafxYPQk14lf
 nM4pyYm35x2gezczM21JVcxjJC9YcdODnp7oh+XpwyJMAD3E6Yvvi5rlZD3p2kJ7GJ2D
 KORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727971388; x=1728576188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+hNbJBh8B3qs2YXBjugo1xNLWnZEW8BHzC+YV/tyhk=;
 b=RsjRr6uC+pp/v9FXGL1+OYG3gtTB4eFgFOl5JobPMh08e9mJsszrUb2D9v5q1HH62z
 AOBXLZwGAUuM/SAIEgjkqVSz7P8yBlP1VxNpuaJLI9k0DIsaXQLk9Yr0TINP+ASKzswK
 O6GbLEqBTWz4WWR/ZLJBNp1lBLdNtHrPc4tKy2AEgEb4tD9Fy46uPSi46SDw4lvDzAvs
 eAGxOVk7gZDiHEmUFEBVNpQqyHLGtcYpFOzIs0QCfBLIYrVp7wZMJEfaOEtIq+mWE5ap
 HrgXU3LpyEi05z0wEQUD0lJ8k6TcQcjQPFnN++BFr6z50WxWAxD6Hkto5hjITwiZhq8k
 ls/A==
X-Gm-Message-State: AOJu0YwEe4Y0JRjzUpWE7CXwTDsm7lqfJ1hXlX6h1LwdQwT2Jcgghg+H
 oOnMFNSigxYHiD9pKpCPwyTa8kH+QJ6MHVtpEJVwoX/cZE8CZvU5n8P3JMULa3MdnVicx0KOARr
 U9W07Sd8gR4NtiWnjIyhoTWqzvgQrcAepXsBByQ==
X-Google-Smtp-Source: AGHT+IGnKNAP8jO5R8UPJ5hRSHJ4lEkPvwwIUGDkU2iVwANctMUZPJNtBxrOqmKzESqstJ4ieuZkLAQuThEh61Kmq08=
X-Received: by 2002:a17:902:ce12:b0:20b:7731:e3f8 with SMTP id
 d9443c01a7336-20bc5a3f514mr104376725ad.26.1727971388198; Thu, 03 Oct 2024
 09:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <97a2a2f8bceaf42aef74ea2daef9d1d6bb4445ac.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <97a2a2f8bceaf42aef74ea2daef9d1d6bb4445ac.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Oct 2024 19:02:32 +0300
Message-ID: <CAC_iWjL8949AUZ64qqog2xupq=2vSAiqAu4qD1SmbqfoNWR4Lw@mail.gmail.com>
Subject: Re: [PATCH v11 26/29] MAINTAINERS: net-lwip: add myself as a
 maintainer
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Andrew Davis <afd@ti.com>
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

On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add myself as a maintainer for the lwIP network stack integration code
> and network commands as well as the sandbox ethernet driver for lwIP.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ab39d91a55..27d6de67b21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1352,6 +1352,17 @@ F:       drivers/net/
>  F:     include/net.h
>  F:     net/
>
> +NETWORK (LWIP)
> +M:     Jerome Forissier <jerome.forissier@linaro.org>
> +S:     Maintained
> +F:     cmd/net-lwip.c
> +F:     configs/qemu_arm64_lwip_defconfig
> +F:     drivers/net/sandbox-lwip.c
> +F:     include/net-lwip.h
> +F:     lib/lwip/Makefile
> +F:     lib/lwip/u-boot/
> +F:     net/lwip/
> +
>  NIOS
>  M:     Thomas Chou <thomas@wytron.com.tw>
>  S:     Maintained
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
