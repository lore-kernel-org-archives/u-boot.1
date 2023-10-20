Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE95CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 07:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7AB8721D;
	Fri, 20 Oct 2023 09:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EUA0zeOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D4C87250; Fri, 20 Oct 2023 09:48:48 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E795C86FC8
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40651a726acso4202215e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697788122; x=1698392922;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NG9H4mFsyQCfMr2OQJ22k9I3Q9ZqJHbQSqQ181eHPqQ=;
 b=EUA0zeOZs445vGivZGu/dI2F5HPOXTF4QS3/KM5H0Y/h11NFT1CPZnO4baluXQAAZG
 1ex7bLzaeADSQdz9LnbqC4jxWcL6jwdDtpLXg1MvaP+7mhLkcaG4jC6cjyKnbuZ2yjUh
 jBEbbNM2byDFpcghCRQk0GA85NjZgbc8Ly4xpvKF6W+IhF3t4EshYlJ5qPpVG7nvZENB
 lRieBCpXDh6sGmHhk1Gk7NYgn4c+jsKDBwaftVu8gI9fiTkTt357REFSj4mgknjOkKdZ
 80VGJh9kTjywvf873cSGpFsU1rYYlXobNOUSbdh16cHP0IuL2C0Mi3/U6Ictah6jhSwz
 uZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697788122; x=1698392922;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NG9H4mFsyQCfMr2OQJ22k9I3Q9ZqJHbQSqQ181eHPqQ=;
 b=KuRO9QpydCVw3DZH8rE21Vp6TdwlLYscMRTZZwZjhsCWO2mKkxjcCCukzqqWP63xgU
 g+0T11+a3ZXaoLRssGk5LnySxpXHOZCH8VEwtJUeMsp7bGMHXM3GeKy6WC01Um2U3G6Y
 JCcy+6yeMHmaddxP+pabhsfKsmpTLnHL/HN921OYHq2EJR72yyowvlZGG1oTr5tJ810e
 Rcnz19WjpL2ILZhFr0//M1Pu6NsPZ7AxPG6OFe9pdyDUY3jq6JTXXiDGldqc865W+1TH
 zXgaMLTk6alP2DLRzMawJvK4d2ZoIwS7p4dTB9+JVI7oDIpfK/qSOT+SBqcABdEvll4Z
 BKiQ==
X-Gm-Message-State: AOJu0Yy3xcuPOp6QNNcX8mhTDe6E6YKAobonQz0Y4Kg4H4n2K5rwYz1j
 ApUkNX65Ijxeu9+3SJ9OpkloaA==
X-Google-Smtp-Source: AGHT+IHLPaCxQWpSD2NrV0+RGRGixg7xL1x3QZwzHHPurRpD1WO7uFs90fWs/zU7WbJjARdoQyPVnQ==
X-Received: by 2002:a05:600c:46d5:b0:406:7232:1431 with SMTP id
 q21-20020a05600c46d500b0040672321431mr793002wmo.33.1697788122187; 
 Fri, 20 Oct 2023 00:48:42 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040531f5c51asm1529313wms.5.2023.10.20.00.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:48:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dylan Corrales <deathcamel58@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dylan Corrales <deathcamel58@gmail.com>
Subject: Re: [PATCH] doc: Replace dm_dump_all() with dm_dump_tree()
In-Reply-To: <20231019140230.2132338-1-deathcamel58@gmail.com>
References: <20231019140230.2132338-1-deathcamel58@gmail.com>
Date: Fri, 20 Oct 2023 09:48:41 +0200
Message-ID: <87pm19ybs6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dylan,

Thank you for your patch.

On jeu., oct. 19, 2023 at 10:02, Dylan Corrales <deathcamel58@gmail.com> wrote:

> Replace dm_dump_all() with dm_dump_tree() in driver model documentation,
> to reflect changes introduced in commit 145287040480 ("dm: core: Rename
> dm_dump_all()").
>
> Signed-off-by: Dylan Corrales <deathcamel58@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  doc/develop/driver-model/debugging.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/driver-model/debugging.rst b/doc/develop/driver-model/debugging.rst
> index bbb2794340..e13abddae6 100644
> --- a/doc/develop/driver-model/debugging.rst
> +++ b/doc/develop/driver-model/debugging.rst
> @@ -49,7 +49,7 @@ to see errors. Common ones are:
>       of_to_plat() method in the driver.
>  
>  If there is no error, you should check if the device is actually bound. Call
> -dm_dump_all() just before you locate the device to make sure it exists.
> +dm_dump_tree() just before you locate the device to make sure it exists.
>  
>  If it does not exist, check your device tree compatible strings match up with
>  what the driver expects (in the struct udevice_id array).
> -- 
> 2.34.1
