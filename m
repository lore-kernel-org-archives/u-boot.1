Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594E2D2F7EF
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 06:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C697088E17;
	Thu, 17 Oct 2024 08:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gDc6KJcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6096B88E8C; Thu, 17 Oct 2024 08:47:06 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A6888C05
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-84fe1bc5284so214826241.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729147621; x=1729752421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lb7Juep2N0YEYTsKd7SQ/Rn2owmAqsVflSsrmumFaB0=;
 b=gDc6KJcQDgG00nzQu3tBIkNlERDQU8idIOpYqUY6YVdh8B3Ku+YS0cc66ZHAkDF31A
 CjLSvFSPEoKd/SvXcXA8mueAE6hZnFHVQ1thOdDqC509V3f9AycRQy4w8ECOSacwzlpk
 wlnH8bPzHRfBW3fLPo1eH+2AfIAlEOmS3gnptaT4abvWGgXKu5HkQmrG80CgAYcEwjHf
 Oid1yFv4rn8QHYVHobl+4fxxVgbQp6FdPOOy8Fy8mx1tzWVxaBQbQn6HjKFI8jifcT7c
 UGVzKUXkb/nmIbMox6Q9RiVm620N5+U/M72Qhki7klxKjtfg4Tdqk87e8X5JHqTAOMyy
 /olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147621; x=1729752421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lb7Juep2N0YEYTsKd7SQ/Rn2owmAqsVflSsrmumFaB0=;
 b=Os6HeH9t3ZnzsVLrpWFMDCwfKCNK42DrLrTzOsfprkU58aI6euVX64l0Y0QaEs3E5V
 eakeeXogOclvQ11BGGVblQ/I7vgUssRgot9JKL+gADul0Pjbq9+7mcygU/fwvB2zSToT
 9rWETzEVYSFiXe66Fklnm9CgEJiQEeMkitNjOTzlZ2n06YLLIGqwwqZzc8jXbAfaZWwc
 0MO6SVGUfwVBvu0x/XGtzBQcUIAe781t3GXMYodLz7D6V/VCQGdUHLw1/kQ0myyTyMrI
 hP2LJ4fYX3UikCaPccnC4J5kxuRM4Ap6U/Ic6amYDU17xYaDx7uAde/YmqVa8zYHHTuZ
 PtpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMNJ8qT2bVrZs1gKw1ExEfFE5UM7jrW2FI5BW+a2d05fP2bed718xQTMEBkZKgf7ZiUr7xzS8=@lists.denx.de
X-Gm-Message-State: AOJu0YyysoWoGuT5XupYBPNKSVV2fhoy89hzJgOQDb6slbrA+P+dmRbd
 /Y85+n3AjFE/yTHDNWqhHQDFuv3AZtV0Bn8+Fvr9RO8gJiD6Tf145mU9bnPqfC/uA7jyKBVKf9I
 JuJit4F1QEweyrmAknz7b1A09bxJy/2TFfo/0xA==
X-Google-Smtp-Source: AGHT+IGFicrg0IWpcFcQwiF5s7RYOwqMHd7pqgY9UnNFo/4aE3hAcPcrg9FDYq8DqE+TLlQkOU7t542estByeBvAwMo=
X-Received: by 2002:a05:6102:6c6:b0:492:a93d:7cab with SMTP id
 ada2fe7eead31-4a475f12a2cmr13337307137.1.1729147621034; Wed, 16 Oct 2024
 23:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
In-Reply-To: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 17 Oct 2024 12:16:50 +0530
Message-ID: <CAFA6WYNNedfr2sL5xxWsxYqa1_zt5kxuznCYi1a71e+dz0ZNMA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: remove phy/phy-qcom-qmp.h in favor of
 dts/upstream
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 16 Oct 2024 at 13:07, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The upstream version has new defines use to build DT, drop
> it in favor of the dts/upstream more recent one.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  include/dt-bindings/phy/phy-qcom-qmp.h | 20 --------------------
>  1 file changed, 20 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
> deleted file mode 100644
> index 4edec4c5b22..00000000000
> --- a/include/dt-bindings/phy/phy-qcom-qmp.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> -/*
> - * Qualcomm QMP PHY constants
> - *
> - * Copyright (C) 2022 Linaro Limited
> - */
> -
> -#ifndef _DT_BINDINGS_PHY_QMP
> -#define _DT_BINDINGS_PHY_QMP
> -
> -/* QMP USB4-USB3-DP clocks */
> -#define QMP_USB43DP_USB3_PIPE_CLK      0
> -#define QMP_USB43DP_DP_LINK_CLK                1
> -#define QMP_USB43DP_DP_VCO_DIV_CLK     2
> -
> -/* QMP USB4-USB3-DP PHYs */
> -#define QMP_USB43DP_USB3_PHY           0
> -#define QMP_USB43DP_DP_PHY             1
> -
> -#endif /* _DT_BINDINGS_PHY_QMP */
>
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-f036014e174e
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>
