Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF89E94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B49C86EAB;
	Fri,  6 Oct 2023 22:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jErBAMsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D926786EAF; Fri,  6 Oct 2023 22:32:51 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD44F86ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57b5f0d658dso1418613eaf.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624368; x=1697229168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygAtz+LIP1yczCt/LFX/PiK9ec0/xn7bA26O6eqGM1I=;
 b=jErBAMsVX+yxnLjuGSnqmvw6Xmzo/5zYNEhCZDzgW04xsHbaIjr+Una9J7xqKUjiqB
 JzZpVYTrJBb9z6wFHqC+Ar6LAfw7bTOOEyRn644dXzVlt6KJT9r/miwizpH8M9WoylFY
 EM7xN/BqfHlbFyfuy6KGdck7pA0NisrpQiq4/6BFlu5DEjqfWPoS0T7/EEGim1NlBdpB
 b9M58JNACCs0cUPitWmxRrBxvayDdMMNpbfCGtW4lWu6rm0q7dkDeAWa7MnyY8M1GazK
 qKDStrMr9r9ZG/ZiFt5ExuyDuBVFzPGWKDUE0LRiou2Jxpe80wkvx6qqZfOAygdI1Uh2
 DkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624368; x=1697229168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygAtz+LIP1yczCt/LFX/PiK9ec0/xn7bA26O6eqGM1I=;
 b=jNKrJqRqpR9OuDCATwUGGMVNE6P0JFCpYPfb7Tegm/sJ1Ua67WYs/W3b0AQsRCyn5J
 sZVgtzla8gg+YQZ1qtyWcmWxSJHhBtU+TWbWqpkFA6ythyMigApBzbL/+xQyVUJXUfFJ
 t9s+cT9JK2tbCwBg5/pqpYgMqHG+Q8HbjJsemCaJg/+fWtOcdOc+MUF2fNVc+/rDU8w7
 cmAFbHoKwqGpKGmx6lQggTs7ZY1FDsCUsEwMS8mpTwKMWNY2UmzrWVec0M1NS2/nEna5
 ja27MbTmcjC6moStxSF0x0JNjQetRcdkh8LGoaJQI2rnUd0bUyL9fmibBG5rtwfwObmn
 ppZA==
X-Gm-Message-State: AOJu0Yy64gKFpi7rT3ZjDbv2g+CP4KfXJWTycI/UvaRsoQXzo+8Y4xpl
 SATkAw0nFCbbtNQ7gKMLhsUbp/vOBgIMdv1zKFE=
X-Google-Smtp-Source: AGHT+IG88Eo8Bn4qmdY8845MKVOvU+crWEFfvMqeG3RTg91uvSmQuLXq/tg4AgwUjpEzkWzfhmUp8jZXO+oTGRwTMxg=
X-Received: by 2002:a4a:921b:0:b0:571:1fad:ebe0 with SMTP id
 f27-20020a4a921b000000b005711fadebe0mr9722362ooh.3.1696624368421; Fri, 06 Oct
 2023 13:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-3-jonas@kwiboo.se>
In-Reply-To: <20231001191730.4167035-3-jonas@kwiboo.se>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:32:37 +0300
Message-ID: <CAGi-RU+VDAqAkpmd2qnMddS2TWcnO+N1aZdoMwWLTN2_j_zV4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] net: dwc_eth_qos: Return error code when start
 fails
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 David Wu <david.wu@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
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

On Sun, Oct 1, 2023 at 10:17=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Return error code when phy_connect fails or no link can be established.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> v2:
> - Collect r-b tag
>
>  drivers/net/dwc_eth_qos.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 555eaee3bbc3..7565e716823a 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -811,6 +811,7 @@ static int eqos_start(struct udevice *dev)
>
>                 if (!eqos->phy) {
>                         pr_err("phy_connect() failed");
> +                       ret =3D -ENODEV;
>                         goto err_stop_resets;
>                 }
>
> @@ -838,6 +839,7 @@ static int eqos_start(struct udevice *dev)
>
>         if (!eqos->phy->link) {
>                 pr_err("No link");
> +               ret =3D -EAGAIN;
>                 goto err_shutdown_phy;
>         }
>
> --
> 2.42.0
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
