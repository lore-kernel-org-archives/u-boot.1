Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501D1D17141
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 21:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7B588DE5;
	Mon, 21 Oct 2024 23:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVIbBWoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B79C88DE5; Mon, 21 Oct 2024 23:39:35 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AED88E3C
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 23:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so6479797a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729546772; x=1730151572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SBMYw5/yfFrKgdwCRYIz+lZajlCyMKCsSHJ7pod5RWQ=;
 b=iVIbBWoHdj29v5TUeOgtDK+xNO1Mi4r4c8l7Mw45OQF4rQsrN7vw77tRKarr4M8mr6
 xPFtJJSSuf+SSS/K2RfEfK7ZRyp5JcDqYkUdy8fVoXSiPzfyc/Xf3ypGOvhGlMtLFkBF
 tJEMC1N72TxBeyJkijtAwbpNl6b2T+c/gl0g7kJM8i2d/Ed7uMWZznZ7X9JgvvqzLYdX
 TwtHiSHNKU1ycqqWG0oYTC/BFvk2cCWH46FXriQv9p8a+btd74NFXhO1YfZCtpRmq8Pf
 YY/ulYztmIBQ0pR+OH6zi5w9KKms9d5KuklK0gCechUt7Q04Igp7PED2UrCsxpBlkPhg
 GwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729546772; x=1730151572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBMYw5/yfFrKgdwCRYIz+lZajlCyMKCsSHJ7pod5RWQ=;
 b=l4zDFr28HXpmg2CnAv3y1TRJTboUOE3PKPOjM53zC5AL2v/Ao2fpCNh8z7h7qECjmq
 6KSwtH4yp51hZ4R2mJYn41uJJeGVY6AfIUXCMUb/tdxjuDRJHM5uVwT+MinkjS8UoXMr
 vMVgKNzMGUojcu46YayRS763IPBTqh3pszJyFQBCeRrasWr1HhNFsKLaQZUcVwgRN+Lm
 9SkS0XnzBYR/Ug5u7nTfQK0Gpua5Tu0pQKyPRkYl7tokjFf5CxOwzR238llA3PVs8A8V
 vjr5Dx7g/f6neGLhOYA+hHJuLF55eehWbPIYLmcSk3GvnW0rVKKY1WSCvTnFpOhWgA2T
 XT8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6575gQ5ikJ8RaI2XICd99K1lVkTxlctfV8GTL8TiA/7oMfg4rSPOP1sNxMxocjsLmJM6lypA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6/DLJD9TTZJ7cccz3H1W0ERVgyTN7dhMiFI2Cfbuwx/GTDLdL
 AL7UX3E7yYdEdudQF7bgSUM/xQdzOLFWsMkmit5wguQCXKG7PoFYL0oKGWSxaXp8UWCR+1StEFV
 3iSpETdGr34bj8i2+Q/HvKy6lV7I=
X-Google-Smtp-Source: AGHT+IFI8kZbMfNHjcRy3jw8nIJRXK/y9XFXBkz7kAgfp2g6mW/Il/P/cdbkyD4OunAS5USLOpcvadBa7+jAW9qVN7M=
X-Received: by 2002:a05:6402:358a:b0:5c9:85dc:5b9f with SMTP id
 4fb4d7f45d1cf-5ca0ac43593mr10467118a12.2.1729546772189; Mon, 21 Oct 2024
 14:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-6-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-6-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Oct 2024 22:39:20 +0100
Message-ID: <CALeDE9MecRXSmLd+r97hm0mJu0-eqOpCaTjnNjMqf2_=q=fiXw@mail.gmail.com>
Subject: Re: [PATCH 5/6] configs: Enable htts for wget on qemu arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
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

s/htts/https for the subject.

> QEMU already has an lwip variant of a defconfig. That defconfig
> is also configured with mbedTLS by default. So let's enable the
> remaining config options to enable wget for https:// as well
> and test that codepath in the CI
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/qemu_arm64_lwip_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index d3d8ef16e668..754c770c33fc 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,3 +7,4 @@ CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
> +CONFIG_WGET_HTTPS=y
> --
> 2.45.2
>
