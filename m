Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A2BC54798
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 16:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E55D876A4;
	Sat,  9 Mar 2024 17:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uzkzkaPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB7287776; Sat,  9 Mar 2024 17:25:51 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772098765B
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 17:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c213690558so806267b6e.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710001547; x=1710606347; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTO2Kwn1iX/DEdv2Z1xzXluKHps093ZP+OY81WgkgBs=;
 b=uzkzkaPcgG+k5jsIXaOScevsX2pXNRpkSvydouapQOEOdIsuSA4YGPsnL5SYaJi012
 hiGwiHz7EBmQK33cfvvNfRl/rcXLGF45+I8spMJ846IMae2mmWjfVXLtOd0+3jQRHLm9
 fLbrs4jHDckECeL02yKyc/xM8fPFrWH3DDNLRWU+RB5waBJUAWHn+9Uf+Ru/C13sd5hV
 qUKifpYMX9RHsX52k5r6DAGK9xfeU+lt/NlrmrC4r5mAJGnuzZzp50EcB/OgZBR2mNEp
 T1GQuYvbvM9QHiJaaDxKHAiZbpNVphooMg3W6KmTVC68S67W/A6e3xXtMe/fQEXPblKF
 2ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710001547; x=1710606347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTO2Kwn1iX/DEdv2Z1xzXluKHps093ZP+OY81WgkgBs=;
 b=T3VX+XvHpn8CgwLDfQ6Xz31adXA3lFoZ5jSC+ia0dZcwKxOQyLYU18T7/JHU0DMzW5
 OEm/MZqGLAXW+rAhzaYL7NY1BB4GAZ0VL+kkxr75H7jpw0g1LSz4PATo8GQFYjfCLLZY
 /RPU80lVzYuouSA75FUrT9YjpE1EF3Ws6os5CjZj/XKCFMCF3aN6E51S2EcCy1kViW20
 nB5xOnB9ti4djJ8FJ5jOU7x+iZTM2UsIe6Bf19ML9QCMEBdlBWA66XWsU4kvq5K3m/7t
 vU5fjyd57Utg8ZbJR1zRuAmbxTNlovPTLgsy2XPYajkynyL8hUPP5XaOrN+y2tYBU3Zr
 lKJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHXO15QXUQ1W6ugQVp7LQGF7UCLXvI6tUk/9n4oHqIF7I6Ww5NvgCDg+eRxviXQomS+djzt5CxtNcB9NQKA4dGvJ62eA==
X-Gm-Message-State: AOJu0YyKk5Oi/qJFFMbdoI1f9kEjY5uqs5sKIOZLiMkJ54pype+PMrkY
 Od//BD8ZYgGATb8Z4eCoTgdK89KDaBIIjZ+gyXtiYrSuFD6KfdG6UvSpMccfKKjqX2JSSxhkKyL
 5Y+8OL877NL8dRvy7U/982ASMODynjCvtp1tGew==
X-Google-Smtp-Source: AGHT+IFU5cDj4luBI3Kxl4fUKIBn+a81S0pS3CwJdAgY7KwimnoJ0JuiwjmqxPaHL7IL/Z2Wx5D5C7qZy0cuJsLDksU=
X-Received: by 2002:a05:6808:1a08:b0:3c2:13da:a302 with SMTP id
 bk8-20020a0568081a0800b003c213daa302mr2830903oib.49.1710001547032; Sat, 09
 Mar 2024 08:25:47 -0800 (PST)
MIME-Version: 1.0
References: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
In-Reply-To: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 9 Mar 2024 10:25:36 -0600
Message-ID: <CAPLW+4=vk0EAO7JsabtnYQf3tQ78DdeqPJq3KYa=toGNZeyRBw@mail.gmail.com>
Subject: Re: [PATCH] clk: Fix error message in clk_get_bulk
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Mar 9, 2024 at 6:27=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Fix a logical inversion of the printed text.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/clk/clk-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index ed6e60bc484..78d8ea94c65 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -180,7 +180,7 @@ int clk_get_bulk(struct udevice *dev, struct clk_bulk=
 *bulk)
>  bulk_get_err:
>         err =3D clk_release_all(bulk->clks, bulk->count);
>         if (err)
> -               debug("%s: could release all clocks for %p\n",
> +               debug("%s: could not release all clocks for %p\n",
>                       __func__, dev);
>
>         return ret;
> --
> 2.35.3
