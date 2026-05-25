Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5605CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 20:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45317848BD;
	Mon, 25 May 2026 22:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OSlF6LLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFA9848E2; Mon, 25 May 2026 22:35:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC2B846AC
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 22:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so1833283966b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779741348; cv=none;
 d=google.com; s=arc-20240605;
 b=V+RqaaKn18s5CQsfJtRp+dC0d4kLfVNsDIskqVMhp7UzR4jIiTMHeg4wihJSKOOaip
 b4WThlYkzVUQoeS3zVzhdRtWtXLFUTkgsX+RF7YaTCbogmW+t0RgZeQkHLpBE97Eqfnu
 iRAg/gMdMdddngfCyW9KUOUYzKnSHvnb+q0UZNZe5FDUTam9QbW2aqCyQ49BDOxDmcy2
 hjOPpt/UMZRq4g4Vq5oQVtM2c7FxYM2imaz9EvdydHG2RlCpBpQpzsckq5BFO16vIoKY
 QImpd0hY9ObexOvgAqdyOctFRsg9v9AIls2jxBJqw/D/k4+Q9dafqLRkbY5rv1OY2Gag
 YbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5TK0F5ofIfFD4pHlBXfVvdAWDFM7wrGA+pyZ0JV0OWk=;
 fh=vvRLJ+pJ+YhVpO0KHMZeswzeyq4wWmBhPjdquMce9Gs=;
 b=ZM/zhW8PI6QSsZKF4MxNIiq/CZeABb7jySfDX+auHgs/Xm68WNpdZTeN2dbzrVGMnw
 qFXMxLLMnzIXUcI9F/hxGmVdLBRWB68f6UD5k/Kq7SegASlMI+UW8aPCW0/aY5i2zkOE
 /+s6OMxqCg65tHLtYAdwwuuWrg/bCC8fg240YZPO4WZjGr0qCj+KuH7TvSFVTEW+Xlc7
 r/QecXVDxLYgXGPlGS3G1i32plaKRLd0Un+OWGoH1PeOT/GBYwk2PjDKoqi37gn5MvD8
 pjUCBRHPWBfQcTwzr/0Jidfg4r1VY0lzhymaajtpt0cP02rRvG8ZICUH7TpPdNyBGsRR
 a2jA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779741348; x=1780346148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5TK0F5ofIfFD4pHlBXfVvdAWDFM7wrGA+pyZ0JV0OWk=;
 b=OSlF6LLhhAmdwOTqihiCje2u/nAKlrRV1Qw2qQQOK3zNT20I/lK+W9P+9Y3Q5LO9JB
 PxR/Ye6dpCsk/HuUu0Jgul98ddR8S7IU1BKr1yT5yPPUYlIgx5P35vabOVWQH7oxwCnq
 j0aHyFEdXxvLddpy4zPVND1uxSehzrQYW543U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779741348; x=1780346148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TK0F5ofIfFD4pHlBXfVvdAWDFM7wrGA+pyZ0JV0OWk=;
 b=VViQpY+qKf3DyJUvoZU+jKbRBtuTrl9RmP+hA8ehBnc1qPsGSOrnyaaEdWrh0jE+q7
 5aycZgzi+J+I0kBrLoGwE1Yy8A9jG+MW0+rGD4ZwKD6/KYErm9cmoeXq0KrEwR7aLpmQ
 Zz45+Fh4SyK9hrVEtJdbyMMirt4/t/MvAVqFekxHLbqEVg8prM5qWft2EzPsgu6Ndfir
 tDUi37aUQv89VhyDUhV6m9z66ga6mW8pESRxw+K6g9BYYpepBTgzn9mMAd+M2tEareCK
 GuP7zhKiIaQf6pRJlkLiPQio/nIrORIJea5PI3Ec7LjH1LUyLxv4oSByBrfghWg2iMOU
 J+Ng==
X-Gm-Message-State: AOJu0YyCmQ1Wl6jIwa+EBcuCv5sJSZvCcLdRirIOQbLKPIiKzyesnNUj
 AZ4zau7/rRO0ltle5a9NQUsU4u01ZycMLdLjiO67zajXqWX0s7ZBAw78mp8N5+XxIfprMJ5m4rA
 ZI1Opk1m/dIDo2gTJSeCwmjmkkZGE8BudSY3hZsqg
X-Gm-Gg: Acq92OFgVzGi/bXDoBu2rvuLo8Oq+qjlv2sTaEebKA0HQp0CxSFT74FdDPOPwc8a+om
 IcJRNgtjVge6Cjx2ygiDgHBYIKC1E+zM3RScAPX/dCoLAVu4YEa7cmdN8SkqRaKaokYPHY2JbMj
 qDGbKxkh/lQhTSGudipR46tlgimnpYjBXrdeZL0xRumgTLSEJxPWR6TXyDODStURwnO5Ri4gMxF
 iOHGo4cE9NMfUlsrqM4zm0cXrjIBZXfmquy8xf6Apnb3D9JDejxSsnQOAHLx5JYiUCGUASSosPm
 iXqhqczgNgY9lYJy
X-Received: by 2002:a17:907:944b:b0:bd2:15b5:bf60 with SMTP id
 a640c23a62f3a-bdd47dfbbcdmr739487366b.3.1779741347971; Mon, 25 May 2026
 13:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 14:35:36 -0600
X-Gm-Features: AVHnY4LSHSV5tU6AbsKmbj5S8MhdWtdsi_cNLebyhhW3XrKmQQatuKvlw2idsCg
Message-ID: <CAFLszTiub5powwOq_b57UGgkKa1v019+y-RbHH2O+aOTys+Chg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
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

On Mon, 25 May 2026 at 14:33, Francois Berder <fberder@outlook.fr> wrote:
>
> dev_read_addr does not return a void* but fdt_addr_t.
> Replace invalid usage of dev_read_addr by dev_read_addr_ptr.
>
> v2:
>  - Replace dev_read_addr by dev_read_addr_ptr
>  - Change error to EINVAL
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  drivers/watchdog/starfive_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
> index ee9ec4cdc3a..d2c16150f4c 100644
> --- a/drivers/watchdog/starfive_wdt.c
> +++ b/drivers/watchdog/starfive_wdt.c
> @@ -290,9 +290,9 @@ static int starfive_wdt_of_to_plat(struct udevice *dev)
>  {
>         struct starfive_wdt_priv *wdt = dev_get_priv(dev);
>
> -       wdt->base = (void *)dev_read_addr(dev);
> +       wdt->base = dev_read_addr_ptr(dev);
>         if (!wdt->base)
> -               return -ENODEV;
> +               return -EINVAL;
>
>         wdt->apb_clk = devm_clk_get(dev, "apb");
>         if (IS_ERR(wdt->apb_clk))
> --
> 2.43.0
