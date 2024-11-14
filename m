Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A0ED68B2C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAFB89607;
	Thu, 14 Nov 2024 15:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NH/28OPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F1E8960F; Thu, 14 Nov 2024 15:50:40 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16139895EE
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so717547b3a.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731595836; x=1732200636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LmxSkascJD96U/zql6n5trVwVjrKQGxxPon+FwWzQQM=;
 b=NH/28OPaXUwKE0Mr9DopLpJ0Xg4P+cPTr4CCGhrBW9CGJEswktTaLUkM9hKRbXYBA2
 dI4ETvkNrtgkIajpSiQTKou78kMX3qyj+HskKZhVmUgZjedkiB6QLiSNgGdFPDW2tNri
 xLP1PXMEM4tsrsEzaKANQhZKCygL/0wy8Ilyudq+aFP467hAKWbkfn3MbSYKCxatnlUc
 C2EUJv3gZIo5D3+E1ebx/H8IG/Gv7k3dCyAeVfHXOIjgAtFStDDXl5IvUMWWE+qOSzvA
 EJs+UfOlps7HS7VmCNPUcG2Yl+BfjqXIZAplNFdA+y8oZ7kjG0kIL2WRARLbZxEqoHnv
 FApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731595836; x=1732200636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmxSkascJD96U/zql6n5trVwVjrKQGxxPon+FwWzQQM=;
 b=omGmKwSFDFiiRL9MNslZEvgbs6zlnkck/9eWma4RoGbKqHM0/jS+WnTYl0gxdr0Bdj
 HjWBecAsFiWXdFCDtLib6On8Fvdzm3QcB2cpJk7Yg4mFKSXWZRsvHE9tVgKNpJI1W/U/
 1kgrVHGj65EctQ/nAZjzG7EKZPs8Q5wkRu0BBn0PM+EhU2k8dlRxqkdbT2s82PIip11p
 9WRlEJ94zI5SCRDKzuatan5pAmAFuXZJgJovp81j8FMmPZV52xdvCA9KTXvqxQwf1svi
 R/rQi/tGdTcmG73hBvKSs5N4QxmGKsVDlrIpvq24EXaYp59KMbEj7LKIuYW/5ES+TAuE
 UGGQ==
X-Gm-Message-State: AOJu0YwmDLW5iZ7TobN2Ilw+JoKsDblLGDR5CeQXUvuYvPik22z6kuw+
 pjPeqwQAthdFTs+y9MQatuS3+83rDppdHKRpNphAJshaEe+TPeC7ltGWnJsIN+VxqdbkMcgkbOo
 xuxSE/585iHN3z7jVW9IpBcsurYpv/NhPIl1LU0MbtXsT736tKuo=
X-Google-Smtp-Source: AGHT+IHna0+moA64E6o1VlcZVfFhHTm5uXV1MpANGthScB94qhK1ll+iPvv8hAgRzfZJixr1JF9rxTL8ZFyrMNZ+fJM=
X-Received: by 2002:a17:90b:4c0a:b0:2e5:e33c:99c5 with SMTP id
 98e67ed59e1d1-2e9f2d7a03bmr8779421a91.37.1731595836479; Thu, 14 Nov 2024
 06:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20241114142040.2051271-1-jerome.forissier@linaro.org>
In-Reply-To: <20241114142040.2051271-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Nov 2024 16:50:00 +0200
Message-ID: <CAC_iWj+w-6OvU7h3Rmiy_vKCAuNXB+9BS4uH3zHhLo5+PvU=5g@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: wget: update help string
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 14 Nov 2024 at 16:20, Jerome Forissier <jerome.forissier@linaro.org>
wrote:

> The lwIP version of wget also supports the legacy syntax. Document it in
> the help string.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/net-lwip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 42f8bd6b259..4dc97c6e184 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -39,7 +39,8 @@ U_BOOT_CMD(
>  #if defined(CONFIG_CMD_WGET)
>  U_BOOT_CMD(
>         wget,   3,      1,      do_wget,
> -       "boot image via network using HTTP protocol",
> -       "[loadAddress] URL"
> +       "boot image via network using HTTP/HTTPS protocol",
> +       "[loadAddress] url\n"
> +       "wget [loadAddress] [host:]path"
>  );
>  #endif
> --
> 2.40.1
>
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
