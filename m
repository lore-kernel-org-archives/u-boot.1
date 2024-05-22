Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47AAC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453118811D;
	Wed, 22 May 2024 20:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ikp4FT54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C506F881C3; Wed, 22 May 2024 20:24:53 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF70888096
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 20:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-523b017a5c6so10161188e87.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716402291; x=1717007091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8jSnSGQa4b1XXZzlStPUj2w8UyIoEmwV7K2jE9Gb5zo=;
 b=ikp4FT548j0PI5N55eTAoF2u7+3MUkEwN/nLbk74NCf1eBWmhXmIqHOCGIR65ociL6
 fzUbgZuXalbY6lABJePMGMFMgctxRErSNAe0BbrFCjxvKc121LNlLPsC18C9A7RFhFOk
 vVKwaN0FbE3isGcAlGajFPq6wHRnEMeTmoZ0ZGP3pfWb3UTKu6t8S3zaNB2IZ8PEmAj4
 Nc8eBa9Hz1y6wfguRjq7wmSBYIZNKhZL8qwqiRsVvxo1/twSy+tc1V3nWH9FmLfmZSkf
 1jAL0ZQCm+wtbld0f9SOxm8lsCj3Me9eKBKyHkRgRu03Hcnckzx12xOrq3aFK9ej2BUs
 w8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716402291; x=1717007091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jSnSGQa4b1XXZzlStPUj2w8UyIoEmwV7K2jE9Gb5zo=;
 b=disJsBd/ck868hQ8zlFdEgS298tApTnndpTe5mivS8RbsjzUFjXkVd2jHku6pyFULA
 JfyVsc329CPu8cl1jwpf80/7c97F04Qyq7WI825V2Rv3GWgcP8dldR6ZEb7X1m+7O24d
 2h9quAXjGu+zlV+EWiRoOb+Ry1r+/8EsvBQPZaEUwtlzHo+ZC400/wCnJ9FZXsUYy/rB
 a5iu3IwWYe4Fp6hzkD/zmnoRUF0SwCIqpvTjapZyWgN4C3jbE93kVNqSVt+6e1B+CwTo
 3x6C98CepRHVbOMGdbHgu+U9alU5S+Wmzjgf1JOa/asCvlPoaYvp2FxHEFr7/h0RIhr3
 9+dA==
X-Gm-Message-State: AOJu0YwJGDbRF+wINa6J4yJzgi7OCC0bJpoEtyHsnkOo19KsKe1XvC1K
 Y85fqHMyd9XfwVItFY6aSjBT6T0VQ97yzUe7OEjrC26Sm6PkpXqD9/J1tGX7ujq8NWP/vZr2c+J
 accFzHse0mOCaddM3CAisytgsd2aai4/mstVz3A==
X-Google-Smtp-Source: AGHT+IFINxMp0selK7/3xGvIbvcXcrntFvtA5GBA06eahVig3rUrEtx7dIfF7ZZSTMV7KepzJUPY3etaQNL4rfL40K8=
X-Received: by 2002:a19:c506:0:b0:523:946f:ded4 with SMTP id
 2adb3069b0e04-526bf7384b4mr2135110e87.35.1716402290975; Wed, 22 May 2024
 11:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <b3f3d3eb4b8f508b6b63e353af4aafd63779ed6b.1716393035.git.jerome.forissier@linaro.org>
In-Reply-To: <b3f3d3eb4b8f508b6b63e353af4aafd63779ed6b.1716393035.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 May 2024 21:24:14 +0300
Message-ID: <CAC_iWj+hsEQi_YJeRqNcuYJfBY-1i3YenWKaxZkh0Dw2nb6-Kw@mail.gmail.com>
Subject: Re: [PATCH 14/15] MAINTAINERS: net-lwip: add myself as a maintainer
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 22 May 2024 at 19:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add myself as a maintainer for the lwIP network stack integration code
> and network commands. The library code itself (i.e., most files under
> lib/lwip/ except README, Makefile and integration files in u-boot) is
> unmodified from upstream and therefore does not need a maintainer.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a3b4d3712..0131f89ae3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1311,6 +1311,17 @@ F:       drivers/net/
>  F:     include/net.h
>  F:     net/
>
> +NETWORK (LWIP)
> +M:     Jerome Forissier <jerome.forissier@linaro.org>
> +S:     Maintained
> +F:     cmd/net-lwip.c
> +F:     configs/qemu_arm64_lwip_defconfig
> +F:     include/net-lwip.h
> +F:     lib/lwip/Makefile
> +F:     lib/lwip/README
> +F:     lib/lwip/u-boot/
> +F:     net-lwip/
> +
>  NIOS
>  M:     Thomas Chou <thomas@wytron.com.tw>
>  S:     Maintained
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
