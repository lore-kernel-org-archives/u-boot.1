Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC85C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 12:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8876C87EDE;
	Thu, 14 Mar 2024 13:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vrull.eu header.i=@vrull.eu header.b="Rfajpho+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D2D87EDE; Thu, 14 Mar 2024 13:32:57 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C1487E15
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 13:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philipp.tomsich@vrull.eu
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso1166897a12.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1710419574; x=1711024374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E++f+sqdxV+PxvTQmu1uwuf24JFa+I2G6t8JWYIF28o=;
 b=Rfajpho+pHniZ+khAN2wP/x8U1NCQwYUQW98KRKiTgv3hnYZRb7PUeyYC/kOzfzQOG
 x6N0VMYoZ6gmGPimcdqW1wZjeY9xPvGA3FlWd4XyWTzAsVLWQ6qyDSCcg4fTPI2mYqhd
 7mdmN0pPkF9SuDFX50/PYMW8xTqdorxDKgdrzRCPbLi+rDtu2XOyA9ZIWe/tc9iRcC4H
 x602aDKQl4DqVzNsFG0tgOfDJrRwNQ7XHOxXpaX6P4Mk7y6vJKjVMNj71wJasFBQzh1f
 yUssS+e44sLaGutsVE1JuXYlQZ8Mv/4G8VLeAM/VacQFfjoZ+UHLiTeVdpB78TJ/y5Y/
 +Fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710419574; x=1711024374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E++f+sqdxV+PxvTQmu1uwuf24JFa+I2G6t8JWYIF28o=;
 b=a4Rtt/DXwhIyPTXsmyAVFsnlrX1aFTe2ONVC1lH2BrPsUUIoSH9Hul9jsd0Cm3c+0b
 SN9p6dkf72TPRM7o61qTmLb3RyK9g/XHBKlGdPHk1guNjBbfS+16X1tMyo5xIC8tv2lk
 eQ8wzv+M1ex5gMOqorze9Di7uuXkokmkrHfIQ56AYzdUWt++/sH5wSxLB/eCu0em0Kl2
 G3Gq0Zh5ChG35C3cv7O34ip5XBSi5NGC4htGVDDBkOG7a/bHx3C7EadYgORPCXivAjHm
 qRSslWdCwzu7Kj3fdDdaR2JWyKRCZVd5A9ALnnLcwxJKBXXEaplLwUbNbrWNHe/bHchN
 NdvQ==
X-Gm-Message-State: AOJu0YyTx0+gIZyGeeBJxfoaZd8LZqaRhuaX5Uuc4V98avvwADTJWk6Z
 HtcLE6oMVEDluUH8KHFD6cXEF3UUlb7bfknrNubNjByyN82J/yeSVN1q1Gi6/WYOqRrh73f+AQ4
 FbcaTehWnbgrXHTpE3poR85AfneTjmd14s+Q2bUrJtbmWBvhPWLW7tQ==
X-Google-Smtp-Source: AGHT+IGBUCfPQR+Z9x1c+7GXZGXEjbDP/U+0EcYUTRYo1Px2QlhLwIQkVszdMTI/D86NeIqxuxT2ofFqNua87J0Rfj4=
X-Received: by 2002:a05:6402:4149:b0:566:ab45:e6c5 with SMTP id
 x9-20020a056402414900b00566ab45e6c5mr1330972eda.28.1710419574333; Thu, 14 Mar
 2024 05:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240314115801.241575-1-chris.obbard@collabora.com>
 <20240314115801.241575-3-chris.obbard@collabora.com>
In-Reply-To: <20240314115801.241575-3-chris.obbard@collabora.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Thu, 14 Mar 2024 13:32:42 +0100
Message-ID: <CAAeLtUAd2TbBsPcWG+3X374rCgd3SEp4AhkimKRJc1DLBgHaGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rockchip: spl-boot-order: show DT path for missing
 device
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de, kernel@collabora.com, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 14 Mar 2024 at 12:58, Christopher Obbard
<chris.obbard@collabora.com> wrote:
>
> When debugging the SPL boot order, the node ID of a device which hasn't
> been found is printed but it can be quite hard to relate that to the
> specific devicetree node. To aid debugging, print the node path instead of
> the cryptic node ID.
>
> Original debug message:
>
>     board_boot_order: could not map node @73c to a boot-device
>
> With this patch applied this becomes e.g:
>
>    board_boot_order: could not map node /spi@ff1d0000/flash@0 to a boot-device
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
