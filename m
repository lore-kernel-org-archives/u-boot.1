Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E319D41C2D
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 10:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C789989554;
	Wed, 13 Nov 2024 11:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ET8210+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510218904A; Wed, 13 Nov 2024 11:11:45 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 757E589558
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so5440000a91.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731492700; x=1732097500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hnxyol2WafTSyeHAMoFFjtaf+u5ZuHK5FU3Fned1IB4=;
 b=ET8210+J1W1N48W1zAlPldFYqIHLWKMAQu6FY6/S0mqAXwdl8S4WAjrFARfYjClWOQ
 IdMAo1UrmIIxb83BIFOYzxXmNV4ixtYy28fwUtYkTJY33TZe4aRJW6wMxS001KEgiKJU
 u+76CbbCim7/MFAKv3iC7Vkf/NWYC356LrQmbtDxBA2DTKen5IyJ2igzY1RNWzFMKu/l
 sNlZZI9+aEG1QH7biGovh4BeRgnN+TxA6Cymjp7FT53SD2gHiuOOSsS2MI0CLKS2QU7K
 MjOnZqAroXnUWkwqDbiY+/mO8Bm9thyOI+7S7GX1I37lgrGyw1d06sqD2PIu4f3et7d1
 oS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731492700; x=1732097500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hnxyol2WafTSyeHAMoFFjtaf+u5ZuHK5FU3Fned1IB4=;
 b=Pb9PVCUNnR+LMLDcv4K1xh08CmzEYYVDQRrKNbWaidAI3Yq4BH3052WvPklNKiUS/3
 01poXVgxZ17r0qofY3fdODewi2kQxEEDoIvIGTV83sImWNkDaR9OS4z0DIlLTwcRgDbF
 qCcK8tI0l4Za+EUG4mVup2w7alGPU5RvUNRbNOjbthsZkJ25fc1cxQqiGNjJcltq4JME
 4BHNrlZbDisdA62jUsaF2yDRnMZDu3fR1nIel3BFYBoiUyYeHy9n0oXU32xZkAsShg/U
 ntjL925yd3SOYzQJrtMOCuBWKSfoL7YdWcFjWdQ4sExqZhVfUDqnad6do6S+0E5LO238
 9VVQ==
X-Gm-Message-State: AOJu0YxqYD2WHhzXQljmoUSU7t2UR8NsOXZFvuUZZho38VRNVzX9Zo5a
 01fyR5z9ZasJdBROsHxlWtOukKSAZXSR5ddDUjGk/wDzlVbv/UeR0EtLd9QTTyahYziTs2cmKpG
 jmGws8SUMoMQU7e3mNLew/RknSmuaGcrilqX69Q==
X-Google-Smtp-Source: AGHT+IG14DWXuOODWPzcsuQF0Pn/V8SjiDu93mlu6nA0cPBKJqGvt6v9fOQcJqzexrv/T/j+r1OgqrIOfge2yRwZAqE=
X-Received: by 2002:a17:90b:1d07:b0:2e0:7b2b:f76 with SMTP id
 98e67ed59e1d1-2e9b1741147mr25844721a91.19.1731492699968; Wed, 13 Nov 2024
 02:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-9-sjg@chromium.org>
In-Reply-To: <20241112141105.640189-9-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 12:11:03 +0200
Message-ID: <CAC_iWjLx6ZBF7sqzPaXS4eWQWLYThZG2eUpwLcccT116h58gzw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] CI: Add platform variable
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

On Tue, 12 Nov 2024 at 16:11, Simon Glass <sjg@chromium.org> wrote:
>
> Add a list of possible platforms that can be used by gitlab runners.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> Changes in v3:
> - Drop patches which remove grub and tracing for arm64
>
>  .gitlab-ci.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 0aeda53bc2d..e152060b046 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -3,6 +3,7 @@
>  variables:
>    DEFAULT_TAG: ""
>    MIRROR_DOCKER: docker.io
> +  PLATFORM: linux/amd64,linux/arm64
>
>  default:
>    tags:
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
