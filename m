Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457ECC3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 07:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D187582012;
	Mon, 19 May 2025 09:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x0iBxCVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75AE8277D; Mon, 19 May 2025 09:06:33 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CEA803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 09:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70ccd1f5072so6222057b3.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747638390; x=1748243190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IzxnkxxlS0dHnIJwSJv7k/s+V1K4dBaL2l5qC67BQYc=;
 b=x0iBxCVI815SsfHbq9Uiu//thJonlfQ1CpqKZK2bygRgGJyaH521DwWIr8P0pTGwaz
 LuFr38dgqujztHz9jd49JlT8ufx8qA6Ac1oAh3jjDvpcfZg6mbLK6LBisbk/0Z4DahQW
 qgu7Oc42U5HzCSJLBIFkIHSBy10Rf4l5KaPuQ89MNs0ueMSqivfTDEIvSNUK6Bx7oYDk
 ux0CddAZmsE+5rO0hkMlCeJiiiyi29qhYCoJYtVjQc8itD4UsTh1CeyeKGwzDj+gVwVg
 2vU+rVN2doAIZ8dyIJ4+0jItzfN4aUVXg5KrtDM7NJYLMki1587TihabyxOPtlO4DMEX
 aTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747638390; x=1748243190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzxnkxxlS0dHnIJwSJv7k/s+V1K4dBaL2l5qC67BQYc=;
 b=ML1j3DiDuw+EVTU2FHiuVAXXpkcc32KsTO5hiriuCzwIAnanAMSBQmiGC1ji/4g676
 ziVIhKiY1pWmdnegtgfOtcyjNg1swJKZDJlYi9on9Bgav/F91n2to7ySWo74ezyLar56
 nUaXOdxU1ratmmj0PyksgreLuI6d4lfu+7l9hF0dnvEVq3Wz2zYDyhwxCArYjpEW6wnV
 rMxopT3zS46XPff/Ihxez5IBIyQb04Wn9y8SqDkPm7TAiwDMbn/9ynBHevq+kqb2gd+9
 yTSHdt8/ruLq3ykLLWkggkDsvJms7SrN44P4X/wO0QvsLNVu8AK8RQtXCrCQNGwcydjf
 6NLw==
X-Gm-Message-State: AOJu0Yzwd9kO0+RwSWafYEeXQ2zmtyudqe73Av5yX/Vri5lBJVztqRCk
 LZ+DgcKoEXZuvu0hnQpY1veQ9bKsLPLMNToKq8hxh8fR8zWp7rfGhOUPOQ9X8g/h/pQziGnMmE7
 5n7JmkCO+2plm9RwRRmBUhV1RIWGiMH5URytAbEvnXg==
X-Gm-Gg: ASbGncs56IXk0Y7wqQxzl2K0U/aWb0PXoWVtOFOEANgXSODd51287/C5Bbe9/2MCMS+
 zP9X3Jr/KdNieBZ5kiJLrc3gpMnh7fVpZjzVXlRg2lT/eENbzcJBTfVg9MJ/vAjefn9gCL1Ghw+
 xsw/9JS+SZmyotPwuIhPyr3WhUn5tYwwAVDg==
X-Google-Smtp-Source: AGHT+IEJymFzLs2GihZNqkrhs55ocNn7E4BJY5gUHPU/o7wRBdor2PMARmPNFU5To5Wm4IBAdliw5N6FTmYcXU1uCbg=
X-Received: by 2002:a05:690c:6f03:b0:6ef:7f89:d906 with SMTP id
 00721157ae682-70ca7bb63ecmr160470097b3.33.1747638390348; Mon, 19 May 2025
 00:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
 <20250514161841.3591411-3-adriano.cordova@canonical.com>
In-Reply-To: <20250514161841.3591411-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 10:05:54 +0300
X-Gm-Features: AX0GCFsZyvGamSzO9cm6V7uPwOfFpOOADCCIV5rFS19h47uCdM-7IkWQnqKHuWc
Message-ID: <CAC_iWjLM1u-bSWk8F-HgOaEh7n3ER4xy=i=2Hgy27j_AMpuPpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, jerome.forissier@linaro.org, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 14 May 2025 at 19:17, Adriano Cordova <adrianox@gmail.com> wrote:
>
> select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
> on the qemu platforms in CI.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>
> (no changes since v1)
>
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index f21d27cb27f..fa353c6fcac 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2153,7 +2153,7 @@ config CMD_TFTPBOOT
>
>  config CMD_WGET
>         bool "wget"
> -       default y if SANDBOX
> +       default y if SANDBOX || ARCH_QEMU
>         select WGET
>         help
>           wget is a simple command to download kernel, or other files,
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
