Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA3BD59D85
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 00:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684C289270;
	Tue, 26 Nov 2024 01:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jVVTwZpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C66089270; Tue, 26 Nov 2024 01:32:58 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4305C88BFB
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cfe5da1251so6153821a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732581176; x=1733185976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y1zt0mZ3WLslNr38dYJgTK0e//mnMbGVJOJQwnQH2vU=;
 b=jVVTwZpjrFCmGW/fNn+CTLhCxZ4FrOHunGOGrRYOS7URjbeQiVoZB6fsXDf8Kbf/C1
 xHxg/AhAm4kXNSOVVnaQSoMqOJ3D73Y+bJBr0ijNd7u307YqGecQ8FPraT88Mr8KrCOW
 YGGhnhcDG9GntZzgQA/CdEq596m5jlgsajewY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732581176; x=1733185976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1zt0mZ3WLslNr38dYJgTK0e//mnMbGVJOJQwnQH2vU=;
 b=vyug6ZKHJ1VUQ36qk61Zb154/IN6gkHi51r00ixuYtXExxjpCAuuad6QFZoL6UwSv9
 B/YMTL/n53wrCfU0XoDFbXUjOWjq/5svWyTFnrtB4jJE1kWWMoeRS9+5BQiHS8oxneIu
 fnCVHBdYDe1HChiIGnGn7QRZXDAhJ75IWCpGhaxqGG+LyZyaMjfOCMQRZW5dUyWq0kmG
 3BecV0XH+63KXKZVLlz7zwAU3+II7VC5HjdSAcfUCW60r+qF/290IfxxqdUXvs7rK6Bl
 URexLDQzK5Cuod8m7jmpMgBMk7pn8ADUC9PC8xonlxw0t0hdchptLSvozKKDAzbngtot
 2aeg==
X-Gm-Message-State: AOJu0YwfRSfkuNj5FPZxw+plN6ZsqsWWQBCxNrJ/W+oO21XEkJ+y2DFY
 1CrusX2DGu+9t1lHjkY2fgbMb3gwoZHhhfhVGDqljy/4Jvih2lCBveqF5fB/qRBBmpECxUXZ2ih
 8wb5gcr5FQ/zNhA0Cb6DeUIH4dEH2ZkuHAZL9
X-Gm-Gg: ASbGncvsqXtBgJZ14m1PefUG244QcRX+2kWeI6dzYHfqVzPqn83cMBv7pcCYztZoj+e
 LmHLYe+C07BRO5qpt+lj53vwbqMXqnuE=
X-Google-Smtp-Source: AGHT+IHyCrrJpBEh6EYgx7673avPKvmQ5DcjWrfhcRFVZb6c51xhV01thnh3X1LhhMHszr1iqlKpDg9kOG4Q/ka2nC4=
X-Received: by 2002:a17:906:329b:b0:aa5:3979:cb3d with SMTP id
 a640c23a62f3a-aa53979cbecmr825374466b.26.1732581175780; Mon, 25 Nov 2024
 16:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
 <20241125115554.1707080-3-andrew.goodbody@linaro.org>
In-Reply-To: <20241125115554.1707080-3-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Nov 2024 17:32:41 -0700
Message-ID: <CAFLszTgz9jRKaySEhuHM2Kh1FxmigY1SJobpn-DPq3NvkN_psQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] sandbox: select CONFIG_64BIT for sandbox
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Mon, 25 Nov 2024 at 04:56, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
> static analysis tools.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> Updated commit title
>
> Changes in v2:
> Moved select of CONFIG_64BIT from SANDBOX64 to HOST_64BIT as
> suggested by reviewer.
>
>  arch/sandbox/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
> index 1c8353d615..db29ca14bd 100644
> --- a/arch/sandbox/Kconfig
> +++ b/arch/sandbox/Kconfig
> @@ -46,6 +46,7 @@ config HOST_32BIT
>
>  config HOST_64BIT
>         def_bool $(cc-define,_LP64)
> +       select 64BIT
>
>  config HOST_HAS_SDL
>         def_bool $(success,sdl2-config --version)
> --
> 2.39.5
>
