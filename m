Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A08AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 11:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F264887755;
	Thu,  2 Nov 2023 12:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rao7+J0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFD487755; Thu,  2 Nov 2023 12:50:14 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FE28774E
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 12:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7ba46683a88so325025241.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698925806; x=1699530606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tFhe9CPDje3XfE0yuNKJYz4eHM0Dfp2zRBNUwsiGu+4=;
 b=Rao7+J0L6r76xtyNjB4cQAvrOJkzhQyHcVo6IzpV/AurFYDelk0EWzJKGi4NOSt0No
 x25YoG2qAA0SN+RoENg4+OLnLICtWpaH4KYeQ6ixDv6spis0ExYpMZDQpKv5J6OyoUi1
 hAZS6sCF0hJMi/IlrfEDBhkpr5Ca884cQRqAVvhEcapzD8VeBzpTs6UaOBVVMzOg98hA
 yPta0/i9z9sh9gC8ES2XdGrdbvJkTmUxuV8Pqr2xvcG6A6GcojVhR6TH4yqOYtAb7s07
 B7b7Qp/5KefY4D7nSBt2Ll/VQbX0HcztfpzgJ22rg1giZG5d72RKqAvCB4TQwB+YFv3e
 m5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698925806; x=1699530606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFhe9CPDje3XfE0yuNKJYz4eHM0Dfp2zRBNUwsiGu+4=;
 b=kKcdLxNOvllTHTSMgXwT6E+JUN4VFczT24EjEEJDAvAnCw4YAhzjKrDa/iBSkGKLmv
 8j08Yc5OY9QbAwHJPr0UCcZWZ0lvDnJM1vEMx20mmclw5pdMo7xxqhXOsdmPX/dhT3vQ
 v79X5NHWP2aWRbmNQ1YbOmNjpBq/Wf/3epXCwqdTlY09VlUNGHp2a/Yx4BeU6eNrQQsd
 s4PXrFbsmLRQMt2Ko+kxfR6L7UsHno3mZqJwD8nuMGG6xYglkYvzeZh+r+Sc9vDUf/19
 W4EW9cE9306N7ZJUbGkGZI118uS1bTQdWaJI4SnjUBRfSYQeD0le40NY1n+h0yKp2clh
 pezQ==
X-Gm-Message-State: AOJu0YwNHU9XHd6X3n3RoJbHUApRCEGQriOzkJyUCrsAV0lC/60mc8ku
 SrJnD5EcqBd7Psxwfj5PIEfdUcs9HKmrHdCyEXERPQ==
X-Google-Smtp-Source: AGHT+IG6UaA21ANNZUD6EoWrE+WmnRI5Llm3Ezi5aLHVRg+BN/QwuZQqD9u+b/erMuOPh3EncrZaCkR/b+yPl8cTufo=
X-Received: by 2002:a05:6102:474a:b0:455:f47c:6e66 with SMTP id
 ej10-20020a056102474a00b00455f47c6e66mr17954146vsb.17.1698925806685; Thu, 02
 Nov 2023 04:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-b4-qcom-maintainer-v1-1-d905d73d8cab@linaro.org>
In-Reply-To: <20231031-b4-qcom-maintainer-v1-1-d905d73d8cab@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 17:19:55 +0530
Message-ID: <CAFA6WYP=RU2o4mYdmqYLnOxXLFgnp1L0S5oPYNgXsBPtaOhyUQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update Qualcomm maintainer
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
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

On Tue, 31 Oct 2023 at 20:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> As Ramon has been inactive for some time now, add myself and Neil
> Armstrong to maintain Qualcomm efforts going forwards.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> I greatly appreciate the work done by Ramon Fried in keeping Qualcomm
> support alive in U-Boot the last few years. However it's clear that
> he hasn't been very active for some time now.
>
> I am currently working on a large cleanup effort to modernise Qualcomm
> support and enable several new reference platforms. To better facilitate
> this and to handle Qualcomm support going forwards, make myself maintainer
> of ARM SNAPDRAGON as well as my colleague Neil Armstrong (Amlogic
> maintainer).

Thanks Caleb and Neil for stepping up here. Although I won't be doing
any major development in the near future, I would like to keep an eye
on the Qcom platforms I maintain as of now. So you can add me as a
reviewer here if that's fine with you.

-Sumit

>
> I hope Ramon continues to participate in discussions and reviews going
> forward.
> ---
> base-commit: cbba1b7766bd93d74e28202c46e69095ac13760b
>
> // Caleb (they/them)
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cde778bc4d3d..be3666d14047 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -567,7 +567,8 @@ S:  Supported
>  F:     arch/arm/dts/am335x-sancloud*
>
>  ARM SNAPDRAGON
> -M:     Ramon Fried <rfried.dev@gmail.com>
> +M:     Caleb Connolly <caleb.connolly@linaro.org>
> +M:     Neil Armstrong <neil.armstrong@linaro.org>
>  S:     Maintained
>  F:     arch/arm/mach-snapdragon/
>  F:     drivers/gpio/msm_gpio.c
>
