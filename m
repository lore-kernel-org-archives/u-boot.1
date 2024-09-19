Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38CBCF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5774D891D6;
	Thu, 19 Sep 2024 16:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="huKioHfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F8A891E9; Thu, 19 Sep 2024 16:10:22 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8B98919B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c35b72f943so7980726d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755019; x=1727359819; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=metzN5T5EJu9FHDm5vMdIZOHJtG5k/+dvGu8Ig+aIgg=;
 b=huKioHfnkj4TAIxJrtWqVvoEjS6DoWBTNJjtyz4cBpJrfiAMRrhmI+a9FqNeo/Zybo
 MyPknbLTyqWqM1LSuKokJ5wD3NPqyOCSDjolSL9KeQm+2Zq/0UkkiGJpYZmoz8m1uu+E
 DGLl0eRSlA/++EQIPcjXhlGVhRsdRiUV6Pk94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755019; x=1727359819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=metzN5T5EJu9FHDm5vMdIZOHJtG5k/+dvGu8Ig+aIgg=;
 b=tNIwRSd71IR8XvXSMybESaA75F4ElY4OKgAE+XKCfychY6DGuFWuEr82SrpWoodtl8
 gvAAfHrjswcZIVv33AiTn1lBOb/xR76wFElR2g3Vdk9nydXTm56wIz++UUwcOfzQTYgD
 fkH2XdPXFr54ch/YP/zjc1Cygts4IieaIIwgUtoA8n9uN7W6XGhlWh/myn0QaUdmZ1bJ
 eA4I3uJnkHZ27/s+FBeawmMWftKENELKDqjyQPxoaruF4tT1aJUEM0c5593VF+KHJle3
 cQocLIlx7yK4QzHiIKL+7YNvNCZulePWVOggbZKChGfCyi3T4twUxgZM/KO7kJWNXL24
 Oqkg==
X-Gm-Message-State: AOJu0Yy1iFQXPhaBwTIPKdooD6kekUdkFMIhI6EU0rLwVxXAYCpvruO1
 6KXSqhIJnv4bZQd7sGhhTzx3KtWnjWheTx+qS6GjCaBU9Lt7tU/V+k4IyHY9gtrL9c+ymKDiOwh
 t5WSIcE5DJXZJgfdupobGZl+J6FKci/IANmtJ
X-Google-Smtp-Source: AGHT+IEjFiStNQiQAys4Tir7SfllPtVEJOTKBW24ncqOUFq3SKJ/Eh8Usl8MvfMR7fU2WV/WTqbF04D8gbn+ySGzygc=
X-Received: by 2002:a05:6214:2348:b0:6c3:6344:d4e1 with SMTP id
 6a1803df08f44-6c6823a987dmr46956066d6.20.1726755018945; Thu, 19 Sep 2024
 07:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-35-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-35-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:08 +0200
Message-ID: <CAFLszTjQNpb+PjSkVKLrfvpaLFUP8t0k5j9L9DPGru7brcJBLg@mail.gmail.com>
Subject: Re: [PATCH v4 34/35] bloblist: Fix use of uninitialized variable
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:28, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Initialize addr to zero which allows to build on the CI
> which is more strict.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  common/bloblist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

New patch, I believe


> diff --git a/common/bloblist.c b/common/bloblist.c
> index 2008ab4d25..cf1a3b8b62 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -499,7 +499,7 @@ int bloblist_init(void)
>  {
>         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret = -ENOENT;
> -       ulong addr, size;
> +       ulong addr = 0, size;
>         /*
>          * If U-Boot is not in the first phase, an existing bloblist must be
>          * at a fixed address.
> --
> 2.46.0
>
