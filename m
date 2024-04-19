Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0253C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 07:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA57886DE;
	Fri, 19 Apr 2024 09:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JNRvIblB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0B1886DD; Fri, 19 Apr 2024 09:53:24 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C12886DE
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d9fe2b37acso22191331fa.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713513202; x=1714118002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4fzl3dgCrOx07ucCj7dHqdH//GZ4lMBtyoWmzb5VfLw=;
 b=JNRvIblBSbTytorzyBPyhtLBb5mf72UpK2pHNVaAmEco+0fOXku06vmBQYEL1bgyW3
 DM7h9IYttMEY+H9HScWAsr1XF6eKQlPE8NGvYYHE2QVucfmIeUrZHt2MZUGrErbMZJbo
 Q2xns348gUbsXFamuBPPoQOSihhLb5gEiYdurkrgGFTLlHiZeFqv8KeORs5sIxSbwR/p
 OSoPUxlI5oUyhfSdymo8mEhXecu7ZK4JQLpp8gu8QPOMc7fOIOSSt7w2XjDyMh89gvEj
 wcGZSCVG9No8dM2R01AbYyXLI0yovmUXbOGnXIN2ShqNfpDsFq+E7l8Nyqu0QbluD2V8
 bA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713513202; x=1714118002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4fzl3dgCrOx07ucCj7dHqdH//GZ4lMBtyoWmzb5VfLw=;
 b=kk/up1vBuDjxr+2nyueZgk7fpEpshY6JMEVeiRECDdPO6KZ3atmFL+QPdhaA4AFfxO
 ihoSEwtKFtq0saasBSwXkcq39BmpI7P+N0FZhtIl8nOFPvcmi01p+waLDc6Kn4rtpqi8
 IfO0HvuCeY4qYEQB73IF4erYwqqqWNv7u9cWRkBHkPdbGLuWb0ynQc0oeh0Umr94QPVv
 Bb83i2JqqLMZXgDyJWZPCAtkde7KYY14RHUVtCjQ5hcvjmm5n/1QnftIi/y4lNx04hD2
 ya0tKZzPdXVUr9IO282oP0d661li6TmRSErn7L8ByRMc+s0oDFWBafeFWjYGZvs3q5SH
 SyhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWre82YweTyS8jnvHbzLsekfk6aSKKt9MGvJdnr5PIbjvA1eMHXNpSYAleb8tSBimXif+FjQrFbJ6SM6oyywNSLE8FaJw==
X-Gm-Message-State: AOJu0YzlgfXaBsj66w0EyqZtmNjLqAeQjrqzyzcSWZk/7V/NXvE1ff/L
 YiFI3dwpTVJUXjbICDumOWy+JDkPmyNZ3cUmvY6LLeyV3wt3TDHxlC0jYFa6TCmCBIeyhSiLxIg
 0bRFLzZQXqB4L2qfanlFncgVrWeeEBw5VMq3kfidiQTnUoapsBMU=
X-Google-Smtp-Source: AGHT+IGDBU/SHNJZ2SBkL0bFqYkzdRnV9NYTw6Pdn6g9xiIDr9YsZWbXX8qXEjKrlD2qLiMi5AG0pmF5gykaCcKlfsY=
X-Received: by 2002:a05:6512:12c7:b0:51a:a65b:ae18 with SMTP id
 p7-20020a05651212c700b0051aa65bae18mr1113839lfg.41.1713513201933; Fri, 19 Apr
 2024 00:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240419074201.9053-1-ilias.apalodimas@linaro.org>
 <1499200d-1e1d-4223-b26e-6d70d45bdbfe@canonical.com>
In-Reply-To: <1499200d-1e1d-4223-b26e-6d70d45bdbfe@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Apr 2024 10:52:45 +0300
Message-ID: <CAC_iWjJ2C7GY0Zoaf2DYEXLb4dZ7hjUo63D4bpSp6s_121tkpw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: change the error message when storing EFI
 variables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
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

Hi Heinrich

On Fri, 19 Apr 2024 at 10:51, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 19.04.24 09:42, Ilias Apalodimas wrote:
> > When we try to store EFI variables on a file, we need to use an ESP.
> > if an ESP is not found, variables will change in memory, but U-Boot
> > won't be able to restore them across reboots.
> >
> > Adjust the error message so users can understand what's going on
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/efi_var_file.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> > index 413e1794e88c..5276740ffe7a 100644
> > --- a/lib/efi_loader/efi_var_file.c
> > +++ b/lib/efi_loader/efi_var_file.c
> > @@ -82,7 +82,7 @@ efi_status_t efi_var_to_file(void)
> >
> >   error:
> >       if (ret != EFI_SUCCESS)
> > -             log_err("Failed to persist EFI variables\n");
> > +             log_err("ESP not found. UEFI variables won't persist reboots\n");
>
> %s/reboots/reboot/  We can't look further into the future.
>
> A missing ESP is not the only possible failure cause. How about
>
> * no space on disk
> * already 512 entries in FAT12 root directory
>

How about creating 2 error messages?
One stating the ESP is missing and another for write errors?

Thanks
/Ilias

> Best regards
>
> Heinrich
>
> >       free(buf);
> >       return ret;
> >   #else
>
