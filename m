Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37294C83F22
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E7986569;
	Thu, 31 Aug 2023 04:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OE3JCKCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E76C86579; Thu, 31 Aug 2023 04:50:04 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0B486569
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso189570f8f.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450199; x=1694054999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2Rtnw+7G+TPeNMQvJ+TunX7eGrR/Eu/JPGF55Jq5bs=;
 b=OE3JCKCL8j54T5jieDbS8V6mQoP42Bt9VYAIGQjhAMnciZ9u54/JoMnuhgWam4cEiI
 0OZ5jvqDWyiWZ6eceyqRiroMnusTPZyqUSlMRqGPQjmV358C1yZ5vG3y/FS5umbyJKBI
 8/GV2OWd/IsUqbiW+EjP0EdmqhfQbFIYihVAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450199; x=1694054999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2Rtnw+7G+TPeNMQvJ+TunX7eGrR/Eu/JPGF55Jq5bs=;
 b=a7DxG0ndrB6nZpf/3WSK5v/vDnfnHijee+R8RS7w6zuMZTd1aPp3aNvt62WxGdq5EG
 dnRlT8oBq2ML7epbPVaegbEsDCvdN0aSbJAnv9dZK3c5jjaB/8XLfFexACBctmDeqe4o
 Wbvq36VplVNeuy3t+tc9ESGl38N7bdn1fd0c6P9mhH7i/zAFc0TUQ5LehWjY+4iD2hyq
 n0UDpcp54kEgaFmj5k6xxZ2jHrLnMYNUlhahEZLKQ1JfCg3afRLhcR8DslWyEulaEJk2
 HtMkmjI2JpP5Q+hCDnWkgYJSmY2fsjGsbYKzISScgdUscQFxeXw0I6cQlzgMauVKCj60
 5bLg==
X-Gm-Message-State: AOJu0YyxIZ8rSb+jKAxCoISBKxLElEEBOUk4gRlsQvGi1n3V+b3cgIf9
 qfauMiGDk9DuxqQR/CkuNZh3kg1tXnb2U0aOp5MHpQ==
X-Google-Smtp-Source: AGHT+IEBwom1uFeyGa6tYHdeKHkuIIF9guWzHpYeS6IN4u01TkZ8cZlS81s8vR9FCRrah+Zx4b4WjsQh1z2Nf6JXgUw=
X-Received: by 2002:a5d:5011:0:b0:319:664a:aff5 with SMTP id
 e17-20020a5d5011000000b00319664aaff5mr3037633wrt.37.1693450198929; Wed, 30
 Aug 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230829203710.84201-1-seanedmond@linux.microsoft.com>
 <20230829203710.84201-5-seanedmond@linux.microsoft.com>
In-Reply-To: <20230829203710.84201-5-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:23 -0600
Message-ID: <CAPnjgZ1wnBmb4mVvmaW-10E157xUjw+ZFvZ=2x10JxyWLrBxoQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dm: core: Modify default for OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, macromorgan@hotmail.com
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

On Tue, 29 Aug 2023 at 14:37, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> There is a preference to use the "ofnode" API for FDT fixups
> moving forward.  The FDT fixup will usually be for the kernel FDT.  To
> fixup the kernel FDT with the ofnode API, it's required to set the
> OFNODE_MULTI_TREE option.
>
> To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
> the default value for OFNODE_MULTI_TREE to ensure it's always set if
> !OF_LIVE.  This will cause a 1007 byte increase in the code size.

Interestingly, this option is not needed if we can pass the control
DTB to Linux, But at least for now, we don't know that a priori.

>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  drivers/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> index f0d848f45d..38e44ef6fc 100644
> --- a/drivers/core/Kconfig
> +++ b/drivers/core/Kconfig
> @@ -424,7 +424,7 @@ config DM_DEV_READ_INLINE
>
>  config OFNODE_MULTI_TREE
>         bool "Allow the ofnode interface to access any tree"
> -       default y if EVENT && !DM_DEV_READ_INLINE && !DM_INLINE_OFNODE
> +       default y if !OF_LIVE
>         help
>           Normally U-Boot makes use of its control FDT, the one used to bind
>           devices and provide options. In some cases, U-Boot must also process
> --
> 2.40.0
>

Regards,
Simon
