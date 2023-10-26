Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D911C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926CC87B8C;
	Thu, 26 Oct 2023 20:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JbBpyxnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFF586FC8; Thu, 26 Oct 2023 20:59:14 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F41787B94
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507be298d2aso1865295e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698346749; x=1698951549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pqzEfTSIkpQ3tOnbCFvG69Is9dr2HIpkp2nQoqeKzEw=;
 b=JbBpyxnLowE03yiJdI9eXZhzWWCc7d8TeTsHVX5z1SpurhSz/jHuygB6ehzxeh9Qwx
 B8c4oHL+hbnS0LNHk1mxc00x0/GAAivXQ8dnv4x0H29EQvosiNMJbLiRZQKzLLwMCW6w
 +kU6IUKOiiKixtPrUcyga/QLS4ocNM58ZX+jmXpY8t8WxHm8cL7JvV3jAihhmqgURizg
 9W8IKC+SIbvXoUmXOeHkkes/QwxTQbEf6qOrQ0eiDZxzpbZmzWYJ1uNF0ujuR7lt/EnP
 lubcMMcLWToruHr+P2MF3knLFhEzIahj8gN7+QJckuQJHzvalRpcVi/ldpl0Zudt0VHr
 VG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346749; x=1698951549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pqzEfTSIkpQ3tOnbCFvG69Is9dr2HIpkp2nQoqeKzEw=;
 b=fUkC7lIe/DsT9OdbQlPC+AYAoZnQ8VHUawbD+KZNDkMc37K6aRpXQ1vSOYJpmlNFAm
 QioMLlJvCwtluZ7LyB6e9WGCwx1/2GE7Ej0CKDZOwZ/wTNFBeSB05QL5PGohLExdn+3u
 zAUpEGVuSlxgFyKrIseMVxj7fdE7daV9PJe2gGsktfSw3YR7JtPi8K4v2U88OozsmfNf
 c0OG0i6T3xEPynCDvbudtDOFnIwXiWewQ2+tw+1P74B8eRnNchF2hMwtJi5Lri+74yXY
 rF4o1w67WSwPPlz51Sh6R5OtASQN4gUZ5S+XP535yjMwKGorAIvIdwPm6rHXnMutxio6
 IVow==
X-Gm-Message-State: AOJu0YyyN2Oe04OID5Bl9JzHZDrxmOYhirmRe2mpWEgyY7/8rQWYwSJv
 ER9H28EzJx334aWfD5PW+t76n6G35u92/EDpFYOmRw==
X-Google-Smtp-Source: AGHT+IFCbqU6FQp8DtivMcFS8ZC2F52LV7T2n4qiAQwdaWUdN29sXQp5wDrwtaHK076vpauA1vP1PnJ9Y/mn7IWxUi8=
X-Received: by 2002:ac2:511a:0:b0:507:984e:9f17 with SMTP id
 q26-20020ac2511a000000b00507984e9f17mr170247lfb.34.1698346749590; Thu, 26 Oct
 2023 11:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-3-masahisa.kojima@linaro.org>
In-Reply-To: <20231025065103.3101666-3-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 21:58:33 +0300
Message-ID: <CAC_iWj+tQ_-ht1N6H2WbuZuo9M4KaODfKE=08oVuFe1mi96dFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] board: developerbox: update old NOR flash layout
 build instruction
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com
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

On Wed, 25 Oct 2023 at 09:52, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> v2023.07 is the last version supporting old NOR flash layout
> by default. The later versions of U-Boot, Developerbox is
> configured to enable A/B update and new NOR Flash layout
> by default.
> This commit updates the documentation to pin the U-Boot
> version for the old NOR flash layout. It is still useful
> for the user wants to replace the factory default EDK II
> firmware to U-Boot.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  doc/board/socionext/developerbox.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
> index aa7080e26c..596cf9f908 100644
> --- a/doc/board/socionext/developerbox.rst
> +++ b/doc/board/socionext/developerbox.rst
> @@ -42,9 +42,10 @@ Compile from source
>  You can build U-Boot without any additinal source code.::
>
>    cd u-boot
> +  git checkout v2023.07
>    export ARCH=arm64
>    export CROSS_COMPILE=aarch64-linux-gnu-
> -  make SynQuacer_defconfig
> +  make synquacer_developerbox_defconfig
>    make -j `noproc`
>
>  Then, expand the binary to 1MB for preparing flash.::
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
