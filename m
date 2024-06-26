Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8570C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 15:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F39088495;
	Wed, 26 Jun 2024 17:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m95oz8sU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098BF8836D; Wed, 26 Jun 2024 17:40:12 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73B6884A9
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 17:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-644630a8de9so6842327b3.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719416409; x=1720021209; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL6h87fJW4NhpQ9NF+jRtRM56va4CxCjOTcgvB5hKdM=;
 b=m95oz8sUNtmieEcDwAtM7T+Zpk38KU38DluhkhSCun7D7u2pc4BBGr7/0iS9STkxtZ
 J9iwQ1ArqPl+UqyE5aTd30SUR2L7HNNeKG0XwsqaXwjoH5oOcwfd+QbhptcS66hb/6YO
 izRxXsqVK7jGCJoaboH/UCQlHQqJ+OF+BUv5eoRvBckFEYJ4qhne3V+B9/crgGB41wNY
 WNfMq//tgNs6ACsgjKLwJ46ARR93Ag74VuiA+stnxMYi3/DqrQjz+srJtHKaqZoItCbh
 y2mx8PwMGVfleFdwxIHDzlQyyZZ5Eg3AGarKpehH++2wMQMq5FVyt9Nd9Pm46ReYKYVf
 UbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719416409; x=1720021209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL6h87fJW4NhpQ9NF+jRtRM56va4CxCjOTcgvB5hKdM=;
 b=rEyox1pvIjCjUsOgWru525c3H4o/Kswhq5QCdxdmqDVTmsdLJMhDSvbxOnVD9AtUaa
 JyMIjNheIKsLPeP2dY5M9eZEgIsvuQWZZMY16ZfEhvfoVg2nNP9n7rLo+Qd/TQP/hAP1
 KKWLZcI8tWAEYVdqjtjKaASMqvRarJ9hI+NjFxKq2CZ9AFI5IMGkPYrx0yTzekDUUDvu
 i8GHwq6ZsokHjDIQDY6l4AS4Xdjl6JiwxVbY2vMDglIQBjkEnw+re8VJ1TJG93mODVDd
 I7RPTBmLeFHqOxts4mnwB48rckv10RyFtap+OqCqIWYy8CE757IjBT+aZVLxqIH1/qrt
 0QNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxq8qHVNMmVXEZKBkJobLoOXJ7qimdyD175BKPIuGutexGb4R60wuRD8pPfzXQBNqFoVO2XC2R3Ij+kJNCsmUEa+iZjA==
X-Gm-Message-State: AOJu0YwMKhjcEeI7Ab+l+ydVOABjKqGLpbY6CW7tRfRQaGnSqqB38McB
 IUeiacyhpjIvnD44LZqZYhs12zgakd/rNYiFZWOEdjUPkeDP0kCUW64dsN2naKkiW5hQHqdTdhf
 nSmo6hKMlsZwpFsN2kgQPEkoUPNhoFqpe0ALM0Q==
X-Google-Smtp-Source: AGHT+IGBqLV+CSS8VQkS3J2MrOgX+C4BxRmj1R/zmuu+NNfv1DsTHwN7VKYH8INPu/LlOyAeiK7szrLf0ml7Vh619oI=
X-Received: by 2002:a05:690c:a0f:b0:627:e3ba:2ad7 with SMTP id
 00721157ae682-6462e4f5f2emr41744907b3.9.1719416408658; Wed, 26 Jun 2024
 08:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240626151522.83561-1-linux.amoon@gmail.com>
 <20240626151522.83561-2-linux.amoon@gmail.com>
In-Reply-To: <20240626151522.83561-2-linux.amoon@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 26 Jun 2024 10:39:57 -0500
Message-ID: <CAPLW+4k9tgNftwC0dhiw+tR8XLXanX2z4dKuhEtWAzS2eE+a2A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] odroid: Fix target platform compilation issue on
 Odroid-XU3
To: Anand Moon <linux.amoon@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 --Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
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

On Wed, Jun 26, 2024 at 10:15=E2=80=AFAM Anand Moon <linux.amoon@gmail.com>=
 wrote:
>
> Resolved a compilation issue where the build system attempted
> to compile for the Odroid-XU3 platform instead of the specified
> Exynos4412 platform due to an incorrect CONFIG_SYS_BOARD setting.
> Updated the Makefile to ensure that compilation only occurs for
> the Odroid-XU3 specified target platform.
>
> Now, object files will be generated only when building for the
> TARGET_ODROID platform.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Tested om Odroid-U3 and Odroid-XU4.
> ---
>  board/samsung/odroid/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/samsung/odroid/Makefile b/board/samsung/odroid/Makefil=
e
> index 5bf48313de..615c99f501 100644
> --- a/board/samsung/odroid/Makefile
> +++ b/board/samsung/odroid/Makefile
> @@ -3,4 +3,4 @@
>  # Copyright (c) 2014 Samsung Electronics Co., Ltd. All rights reserved.
>  # Przemyslaw Marczak <p.marczak@samsung.com>
>
> -obj-y  :=3D odroid.o
> +obj-$(CONFIG_TARGET_ODROID)    :=3D odroid.o
> --
> 2.44.0
>
