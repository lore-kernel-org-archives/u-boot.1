Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44DAC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CB487B4D;
	Sat, 16 Dec 2023 19:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BSu/b02o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F5887BDB; Sat, 16 Dec 2023 19:48:19 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F000487B4D
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbce6056e85so1417901276.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752496; x=1703357296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IDlPOCwIMaHp07UUcN4PiiWkCrjyM7TUtLTaHkiQ6pE=;
 b=BSu/b02oi/9q0/TFCtU7TTewh5KSoPHcm+GjZt3euc8+3EI2Hs10bmoYo6xmyIZIoW
 p37hoDN8ID5h/NiqBhU4xrOI5fxCdD5qDlHEKSSbATSWMw2qtoGTNW05TOeR3oIstJID
 xliFYRm2i8W+xWZ0A6TF+CoAoauZ2UmZGVg90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752496; x=1703357296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDlPOCwIMaHp07UUcN4PiiWkCrjyM7TUtLTaHkiQ6pE=;
 b=pKHXMjN7NBA6Fr7tHkGdp8D8FZjG1zd9cp1dvMPTflViN4VYpoWZTcUAmjuVbCbNg/
 d+N97otwDhOSHtmM66hHwtKIKe1gUINplp1y7ouAAlluQb41qyb4eio0ELTJab4LnJCH
 Ui3LlzUyXY5dFZYBobQ782wgfFqOccxTH3pQ8i6i7+ot2nuUGrhaPeU+rrtjCQqT5wRo
 4tF+prfouceJDelflUb6WS3FtoTkTyL7HVue+VRFkz0APlEaBvK/GD6MhMskdc69SQRk
 0EHzah5FyEtv+41e687Ge9aW+3CKMs5ohlCYIIUChQjbapsd4It9gYhsDgrKs079LMGa
 3/Xg==
X-Gm-Message-State: AOJu0YywLO43uHGO374IH4k19qlU8JhxMvKCWl59LRwbYVZd0xS8Fdox
 3iWptezMk/Ufw63Oj5hRrWKXgF3vU5zkzsjqJItQdw==
X-Google-Smtp-Source: AGHT+IEPrG1tVX1EWY6SZaBHSOj0H3XrB3FE6EKXw4SUP4tOYY43y3+S+1O0L5Jpgw3758jkvibKNt23iqpgeWBPoZA=
X-Received: by 2002:a0d:d5d6:0:b0:5e2:f6b4:6c2 with SMTP id
 x205-20020a0dd5d6000000b005e2f6b406c2mr5461396ywd.103.1702752496557; Sat, 16
 Dec 2023 10:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:44 -0700
Message-ID: <CAPnjgZ1VMYzs3xW9e6sVBbWF=mheGEZg90PTFLYbO50bHWbd2Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: build test/boot for CONFIG_UT_BOOTSTD=n
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

On Sat, 16 Dec 2023 at 08:20, Heinrich Schuchardt
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

Reviewed-by: Simon Glass <sjg@chromium.org>

This looks like the best fix, to me.


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
