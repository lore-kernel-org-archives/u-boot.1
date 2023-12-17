Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF87C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 17:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E3387CFC;
	Sun, 17 Dec 2023 18:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XFn5zaYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8FB87D02; Sun, 17 Dec 2023 18:36:55 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614DA87CF4
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cc5a0130faso16808341fa.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702834612; x=1703439412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iN0VyQc9xYmUxz+ed28MhFl6zs4jEyK21qYMAk65z0U=;
 b=XFn5zaYVvW1onCgU5kKMb3JMeJ4iZUVRJh0ndATVFQcoNY6TwovmXhDGJHHdRfTEzC
 4OFZRA0FweKWdrv+UFfXaOmk5lXasNIK1va4LflBNGiRhprCqzdh9AAxymZC2JJ43JpK
 nP+jOrKIUzNtwYGeQ+uAzvDF1nRu4TooYEZRs1d72Z0SxjMxuPrPPB74lxyZneG9rso2
 SAMCDbaJyalXlwh7DcUQo0GVjOUR4/IsJIgqz04P2ueajE4VeiXckO29gMsi32ordefd
 RsVVhaKxF2J/lCp+pG3mUo8BCpdk7c0EPNf1QKRpleV9aSL3DjXcCtVdyfls1PiKEVkh
 DuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702834612; x=1703439412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iN0VyQc9xYmUxz+ed28MhFl6zs4jEyK21qYMAk65z0U=;
 b=mFN6ha7LivKQe7DrK5DhKouuyx1sraQisHIrvKKFM9W+yc2srp09VD5hr89zzon71+
 nPJp20rC/6BJXbQMlNsX3K18Ww8a2oaEmNNwX9cGVkWKqd78eEBNRAG4r5viP58ufs7F
 z6qgNdVTqeQ59UC1F7pxoaTRDOFEvZKhVr5CwppC85cD6H1OOZAjBXy6aCc5OD6iN58w
 xCNmrwOEqSdJwYaAUsbAfmDkWXDclZYLqYvZlAuJd5/pdQKbl13dImBsHgedFN9230Ya
 RJvxWZarKyjCo9U2dJkCnkQT+X2FIBkqt2yyuBkwh5YOEYfOSn81X6eXyeeyOb5d/pzg
 buAw==
X-Gm-Message-State: AOJu0Yw8aeZSnfDyy7/JOY3ltS1b4uhQZ/Nirnolc79JQjwl8IRYFGR5
 QpvJK3gUvH9inSU5pCB6l9OdMKzbcfzg+fPfqenJ6pwxe7oN78AoGNA=
X-Google-Smtp-Source: AGHT+IEZQ3rZ/MDbTfeZ8TmwDkZbpWOR7qJWc8DJv9aTzXvdN2DfBcK/hEjhbWNw0PMVczCj8ZCGdfssuyNqxWKNpgw=
X-Received: by 2002:a2e:80d6:0:b0:2cc:5d9c:f77b with SMTP id
 r22-20020a2e80d6000000b002cc5d9cf77bmr1159808ljg.56.1702834612340; Sun, 17
 Dec 2023 09:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 17 Dec 2023 19:36:16 +0200
Message-ID: <CAC_iWj+yr-LL7mmZK5+ypNt=WpygwTPW6KN7vfs_knJeMnkcxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: build test/boot for CONFIG_UT_BOOTSTD=n
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>, 
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 17:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Building sandbox_defconfig with
>
>     CONFIG_UT_BOOTSTD=n
>     CONFIG_MEASURMENT=y
>
> results in an error:
>
>     /usr/bin/ld: test/cmd_ut.o:(.data.rel.cmd_ut_sub+0x408):
>     undefined reference to `do_ut_measurement'
>
> Fixes: 5999ea20fa42 ("test: Add sandbox TPM boot measurement")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/Makefile b/test/Makefile
> index 6b8a1506f5..feba097543 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -23,7 +23,7 @@ obj-$(CONFIG_UT_TIME) += time_ut.o
>  obj-y += ut.o
>
>  ifeq ($(CONFIG_SPL_BUILD),)
> -obj-$(CONFIG_$(SPL_)UT_BOOTSTD) += boot/
> +obj-y += boot/
>  obj-$(CONFIG_UNIT_TEST) += common/
>  obj-y += log/
>  obj-$(CONFIG_$(SPL_)UT_UNICODE) += unicode_ut.o
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
