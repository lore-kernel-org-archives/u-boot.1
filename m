Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEDDE95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7208D86EB1;
	Sun,  8 Oct 2023 01:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gGSfkMdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433E486EB7; Sun,  8 Oct 2023 01:12:10 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDDD86E28
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a4e29928c3so40946147b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YYAIuhyoSVSm75bz86AgJxFoJMZEKLdo3BOmQJ72FLU=;
 b=gGSfkMdWI9dT+HzPwObcLbGXdxMY/oOh5g9Si+wl7eCrL5+WYhOXpaFHC0itUooFw/
 GC0kCN8bvYhYb7iP7GbcLvi0A/Vhetcaea5RWw/8T2BtjE2GdVtiGjs0w7sPcJpA4lNL
 SM89RXRlNjesA5VUyxzhrR86MDw4NtYZ/vhwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYAIuhyoSVSm75bz86AgJxFoJMZEKLdo3BOmQJ72FLU=;
 b=MVJUGOf1hyZJjKuX2P2rt03IETCBXNF8UfzB0Kx70J+LhEn1stw28sejAm4z2MAtij
 pwyq37efA3c3ma5vozUP8tswkgfgGLCvZCIHoaf6B2CfwTkLffrdTwNPYG4qgW/Jt4hz
 2u5o1ywcY3szRwggFnRZ0TTbESuSVafkOIy1hKXr5qjNQ1N3ZyF/sGvtbse+B8ELZndO
 VDzyw3V4sdhiwu62p8u4CPnEuh1qI9kECGGAWiermMdlMrHRxzEF8Mm3oYln17I0MDJu
 qsuEU0gsVMY2E8jrY3WM9q0LpqA6iwJyxwNTy9hB/jFNFQnrSPj3SxJbGHqjQJN+O4LE
 dbsw==
X-Gm-Message-State: AOJu0YyoXNxNM52gen2pdmDMWpOboR32/6qhXtlHqcdvIZJ1FKachIRc
 I6xLa2sNAxmmXFTw1pM7uGhaazZNEgo18HnQTdoKcA==
X-Google-Smtp-Source: AGHT+IEgQ8kIQXSf2FhkbsMom/NPZ02cvbnhG9Dc2yf9TF80UyWex2O2VTsucvAkkp3/TassBRciLcP4h9lKB41Apao=
X-Received: by 2002:a05:690c:460e:b0:5a5:eb:f51f with SMTP id
 gw14-20020a05690c460e00b005a500ebf51fmr9244493ywb.29.1696720299295; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-2-sughosh.ganu@linaro.org>
In-Reply-To: <20231004112722.416877-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:09:45 -0600
Message-ID: <CAPnjgZ2VnHvEVg2sAqJ7kj5GY9fJSqJ_Zmh_zcXCVh09HffewA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: mkeficapsule: Add support to print capsule
 headers
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add support to dump the contents of capsule headers. This is useful as
> a debug feature for checking the contents of the capsule headers, and
> can also be used in capsule verification.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  tools/eficapsule.h   |   2 +
>  tools/mkeficapsule.c | 229 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 230 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
