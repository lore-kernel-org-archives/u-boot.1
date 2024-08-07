Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906ECC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1678688D3D;
	Wed,  7 Aug 2024 16:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LegDuKDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4266B88D3D; Wed,  7 Aug 2024 16:36:42 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C7A88BE7
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db14930a1aso1192457b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041399; x=1723646199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5nMqu5ElSEo6BCSoJ7xUlFhiWAa1ZFQvzOHsmV67KRg=;
 b=LegDuKDioiSLFM7MxSxRy6kWcfEWO5rCI06bH4QPI3OZdbkOgwK1IFrLj5UqSDX+5a
 6xP8dv+ECAg8NLjYWj0p7yJqGnqcNMxamGT0A3tREayerPzyoW3++UT/c8M/ilcCTmNS
 1+hIZHxWlRUksdYPsX2zbP9+oDlklmJxBbvZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041399; x=1723646199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nMqu5ElSEo6BCSoJ7xUlFhiWAa1ZFQvzOHsmV67KRg=;
 b=sovFuY0VH7UJ3nilw6oLPAridOmeMbIkC4ZTA4FmJ+szImTNpUBlzkod88RksNdeeY
 JCw5s5E9Ir/EVu9S+V+efW1dGKZkzizofG/ocmgX39MxzZg0eKEYlRaL3LgN5TddPJH/
 53+JWVJ1E9APssfPcirvSmCy5PAbQXJHhoerJzxWbdyjvetnJbKtYD4rbIPDtXuvyZCf
 rZTBHbx4HGnZDS8E2pUGmYmShpFrluQybEcesnZbW+onhWkGi2RBxOciTLQrwt+nSs/M
 7vu++j+o1RtseZVdxRHG0JCBQg1hR4iGXMcoavwqnRkm7QgzBpQD5z/+yfxdLtcBk75r
 NK9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb/+P4MfgZBIqVCi4uKjknpT/vLq+NMkwlaENdnzOb0RiEZa/Vt2YLw1aejUCfe6ekl3Df1DEpiA92cDOz268qbyQgkQ==
X-Gm-Message-State: AOJu0Yzm+r1yCB45+2dRLaYknjAxf+JcoEGy/pgyAKAIPYoK2IjgwLz1
 PUCaKv+OFK3EMNHZrpTLAQalXi74J1pp54YGWaQAWdBeWjLb5izbNkKLW6ONPGmrywxbNGl0pRZ
 PNteiC/Ddhvf9UUflOEmnzA6oE4U2JZtVxzmz
X-Google-Smtp-Source: AGHT+IFGYV4ZIyaEip11AJwtdnN5mGy8HudMBCVoYcVEte0ItP79m2tnwBgjLde7f8EcQZnPR6mne0s/mrz9UmnEQ1s=
X-Received: by 2002:a05:6808:1598:b0:3d6:317b:a95c with SMTP id
 5614622812f47-3db55830a8emr22018588b6e.38.1723041398962; Wed, 07 Aug 2024
 07:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240806221138.210530-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240806221138.210530-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:28 -0600
Message-ID: <CAFLszTipOrFCsdsnHCHngosWAehbNa=PZbM_weUKa_2Q-OADFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct description of
 efi_get_distro_fdt_name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 6 Aug 2024 at 16:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use the correct function name.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


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
