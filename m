Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F545C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAC9874CC;
	Wed, 13 Dec 2023 17:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WYeeIkLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FAE8743A; Wed, 13 Dec 2023 17:32:54 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93E487808
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28ab6f0944bso387841a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485171; x=1703089971; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YA4t547jqRGj7wwW85kt+3i7VIRX0l9DeZeT11CnXw=;
 b=WYeeIkLCzA9/8g0BHRNpX0QbHMlXgIA2Mterss7OOJXxIZdPx8JxNOFnba5okeiQEX
 1grnXsnQk2sY9myYIKgFBtNTRXKc+TJmFdouoXud7t+EqBwspLZpwZ+6StqMcFX8qJwK
 adReZj/XE2WzzM7yWo3VPi9BdqQhm9xn7PMvEefFkP19T8URNbEAvI+CA2GFw20jVs4t
 pB/8rbWcZAE+8DrDSBUk7EDMFlc0MYqZQr/A6FxNHKinyKVEyAul6GODCBh7BnaFbnrp
 jqcrOW48gfw2HGbC2NOr7V5D6S11eijxlYC4wtNzGcr8JqIGNalD1js0CNK97OL+4OSa
 O8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485171; x=1703089971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YA4t547jqRGj7wwW85kt+3i7VIRX0l9DeZeT11CnXw=;
 b=dhRQ70CeBYPv9rqaBnWpLDeZbWqYQfRhMGMXAGl/Rtgb0CqzK3MpSkAP6T/woqtwhi
 p5nhqeuevwBuMj0DGcMH4SR+GKzwbHuJIZKWBySm3B59bMBRhQqomUU/Ro0rCjLITG6l
 Pnefk+ZsK7DuZK+b9eq9rTtQbMFyLmc03TN5njtPUdCGmr9sdLGJiAp4k1fzuMQV1nd2
 v2O2mK44b+2FiFMymQB8WlhEb9JHovZNV2Mgd8+pI4QgWykqEUMHSi9zx9gLBzrJS+lr
 64be5chSGBhHlkFoqS0+f9OTBPO+EO5XTpBlmZR4fj3bd9F4r0kXfuq/3qFS9mWBWzYA
 e5qg==
X-Gm-Message-State: AOJu0YwNmobBaCuoow1mbRD6Mv1QJi+81vk0MOi5WJ1/JY98nY5/Br3U
 svFsTeFXetnoHiYwnhfMqtRvIIlJaLL+KtCj1kE=
X-Google-Smtp-Source: AGHT+IGcWDfth80p9BKxlAbW7tZY5YRvfHX7GtF9zEuDTZFR6YYIUWPhPMcPU4ZYyWlvAf4LiLeoOoF8cJckKPjnTDs=
X-Received: by 2002:a17:90a:7e95:b0:286:6fe0:8a69 with SMTP id
 j21-20020a17090a7e9500b002866fe08a69mr13987493pjl.2.1702485170040; Wed, 13
 Dec 2023 08:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20231027134127.201699-1-arnaud.ferraris@collabora.com>
In-Reply-To: <20231027134127.201699-1-arnaud.ferraris@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:32:37 -0300
Message-ID: <CAOMZO5DLoeZo5KqWG16+v+6OgTQMp7+w=uLfWzTcb=s=w10vag@mail.gmail.com>
Subject: Re: [PATCH 0/2] librem5: allow using distroboot w/ extlinux files
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Angus Ainslie <angus@akkea.ca>, kernel@puri.sm, u-boot@lists.denx.de
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

On Fri, Oct 27, 2023 at 10:41=E2=80=AFAM Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:
>
> The Librem 5 currently can't boot from `extlinux.conf` files due to
> undefined environment variables:
> * `fdtfile` is missing, preventing the kernel from selecting the
>   appropriate device-tree
> * the lack of `kernel_comp_addr_r` and `kernel_comp_size` forbids using
>   compressed kernels
>
> This series ensures those environment variables are defined and have
> usable values with regard to the board revision.
>
> Arnaud Ferraris (2):
>   librem5: properly set the `fdtfile` env variable
>   librem5: Add addresses for compressed kernel load

Applied all to u-boot-imx next, thanks.
