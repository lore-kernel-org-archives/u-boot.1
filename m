Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26A5C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D026886E2;
	Thu,  8 Aug 2024 12:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lnsDr6gB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59924888FA; Thu,  8 Aug 2024 12:08:31 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCE887DEA
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so704072a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723111707; x=1723716507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TiJC2dXkXwHVmJWtPHfDk1WfxB5AKK3Gxzxq1yivrOI=;
 b=lnsDr6gBZ7DLeUlGf6ceFEgX6xjr6KBLq6zONFrAeZwntkPr0N3Urd33q9fvQSmwFX
 ISsKJdWcirBbkf3JMq+m53OxBEviCn6BBrFJ6Z1giC7zwiC/sPrc+/TjXx/ddQROTxYv
 yDMH9kqrmP2ZKKsEkbqaoKOYUo7+ssulP3Ap8oYMD6IT250Wsnbg89lkjbflfPveoKIw
 ACA1vmrZ61DaXlhxTQspSr2iZOycISFIwryGWxV/Wveoa/J6sdq69bY1l4467tiHk0w8
 7+RVnUQBqS+CfDsvXbHZ24yUrT51VRciIRi7H2KwsZ1AiZ1SRh/sXKi/3GbyKMmLy47O
 WbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723111707; x=1723716507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TiJC2dXkXwHVmJWtPHfDk1WfxB5AKK3Gxzxq1yivrOI=;
 b=h1t8uLIBhaE7WND4kDP7aiOGcbFaTNnKXx2/4ck2TV7n2TbVRTpBC8BWK8OvDSqxaD
 UK8wM7mqH3rNcpkVddELvd5M2RLqxr+J+whGizmLjyjq4YYcynz45ACTAOry5+JFuqDt
 AI+co7udfDUG6svcqJOVYt/0D07y8ZZxlGEBcyWokAYBiTJhAEahEgVwvr5Li31/H0lx
 FfzzxooOUJzXR52HVOtE6ABm9v+6ldR/lINtdd4eYcpKDYFJZURRLLHWuRwVZKYY6Nm3
 kTVQe1Rpfq2CDn2cZ9c6e9fUBwkxxaIkIU3/ZM5OWoTIIzFVyqWegZKw5h889JXFRml/
 mkuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH4apoPnIIkOCX1CWA+gB67wN7ZWoo1UgrwjKiTXihTSJNvk1dcGH2GzXOQIm55Z5MX2kKYGY7pLdMiRYW19E4IGzkeA==
X-Gm-Message-State: AOJu0Yzv7iY8x68QVQTN32FNyeGppsK9Br7A6EUwmtdlEr7D89tJxTPq
 6u7Bpym3WxASTn87/tixDWXBGl0VcFD3viRLIilspTx+0eAq2AooazSytoOUdLY1b5LHiqE64I7
 vcb3OFMnhvk3xjNTuPY0+eJfmKPuFv0o50O4aPQ==
X-Google-Smtp-Source: AGHT+IGbLN9/FECJWO4ILaJOrDhu+tpOTkqRADn1W0uLswF0pLVz0wEbmYGMbHFmbq6CEQRbL9f3cNI98EtwhEkxHwI=
X-Received: by 2002:a17:90a:9a92:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d1c337141amr1405455a91.5.1723111707047; Thu, 08 Aug 2024
 03:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240806221138.210530-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240806221138.210530-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 13:07:50 +0300
Message-ID: <CAC_iWjKUVPBAge1COJhnDY6ikfXjD+1dZoxJmTeJ6xohxGa7fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct description of
 efi_get_distro_fdt_name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Wed, 7 Aug 2024 at 01:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use the correct function name.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index c5ecade3aeb..f882622fdad 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -14,7 +14,7 @@
>  #include <vsprintf.h>
>
>  /**
> - * distro_efi_get_fdt_name() - get the filename for reading the .dtb file
> + * efi_get_distro_fdt_name() - get the filename for reading the .dtb file
>   *
>   * @fname:     buffer for filename
>   * @size:      buffer size
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
