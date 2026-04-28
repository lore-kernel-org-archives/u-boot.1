Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26FAFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7308464E;
	Tue, 28 Apr 2026 18:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="NA2eDSGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504EA8464E; Tue, 28 Apr 2026 18:00:40 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD1984612
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso1007964466b.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777392038; cv=none;
 d=google.com; s=arc-20240605;
 b=R7OxWbm6VqGNW51LuSSYs429dtaafbwjz24dv1V3TivonpNZd2S8N1gTIZlhboXhEd
 3sV5/76t3TX3aR6CIFcqrhUOvpztU/NOZwwxY5JZxiIkU3dbRZSgkdf0liGGxlNL2qyh
 dG/0LjRZhyf+hDjsDiXN7etnm1D1tGilf5XPLvQ6Lrl7RTk35roGkL6col4X946M7HvT
 zEPu97uoLNE8YMSYb1oOWHj/wkXQGzYmCYDpPXsvwOHcJsHh87wgk+i53q0Lf41H4ZPy
 lCekzyK0Yis7mIrSigxyoF5NFuedFJhisCtIm6GJi++B5wZ/jOgI5McAmiI/rclhIWxA
 MVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h8jXIpUbuVwyJYX5U7o/o5rm0R0tWDH/OCYFKQQV6Zc=;
 fh=nUUDrYGu+cmQLZST/hhP5jN7Qd36lXfxYyl2tFOuJf0=;
 b=W8xnWxzQZzdUMZ602gMqOL4uedhfs135KN+dRWjvu9rkya/mvho+KIeFO0tCeWFYMz
 Z0lNAky5kZTB3Oi0VJ3f0yl1+aUEApGm2KKwupBKC/UeLF8IvOC3WlCduvSzcTq0hpas
 c0nB8CYaCj+IaVCytpPM8bmUUR5/XU1P/Fx5nKudZnQoCwDJ9shk+7xgN/yPcKr2jIUi
 tkPcHWttRPLD8HDsYu77rT9b3ZT6F5XBvHw02lULM2p8LEk42oIoSlAT/U7eG9Qmbfkq
 AlFZMC0RFq7h/VQx6d1JnjWc54c0wqz6dcgQAsRMQ0wNW3hvqbeqh4nImNslEo2EQrne
 Pr8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777392038; x=1777996838;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8jXIpUbuVwyJYX5U7o/o5rm0R0tWDH/OCYFKQQV6Zc=;
 b=NA2eDSGnwe7CdwxKjV50xA2/f+xf+JaqlmAVrK9oRxeYNV7agZZOzDWzDMJ3y0aJmi
 2yP4Q7j+KzDPc09mt2bx885ia6OJfFppAzcs0YzafbZF1TLElAIbnog3B0ix8zUwKcYC
 6p8zxOaocWDBDgapnTUwh6mB0rG0xkk+p27Qpq53vfa4JYEsOVFAPl6XGZNKTCdbiOva
 NOBt+8ghF8Rmfz8HaDvyI3jIDDPtv1chVBLrqRKBhJWykqmGcEOENOcLEfzyRSOuh2Nx
 omECe/29pKW0U5x3cl5A39JKiw99AK/9zGOz1HckTOwnO3Fq+E3xj151mInfhnLQVL4R
 LDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392038; x=1777996838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h8jXIpUbuVwyJYX5U7o/o5rm0R0tWDH/OCYFKQQV6Zc=;
 b=UC0plLWc/bWu03WPIuB/+Br75BqYD1KtzGBdzJQo5ht2U7h5F6yQmVZy6ch9ShxSvM
 4LDBAWeOLRKfwp9tO2lwwZWL3G/XbmOjpjFg3ocabjwuIPvQPCJt0nMFhyvIJ8oKGPGb
 RoGuMI6IufwWhAPMdHwgjBbb4lQ9BKnqJPn9yliOPpDs5b1mOyl58c1tubIbgeyF6mKl
 cfltGZBqrFBIVSVWZap4HQRW2mbzGpVDbo+N56Qewuf4qXWGPfa36/U+WDHrGtnpycZZ
 efGqceIkYaT8yCY0jJLQRS5AdGa2ImTqfInjEZKJYgls0e5sc3AZ71YrTBhs+KL8rQyR
 zDNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vEszWAGGfLT9NlUJLjltuy2J/ZZiPSsnzkciWguRp6dwyFddGKrUOFRBjyfwQ4QWYIUgYSws=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6EtxVYLkn7dqaV6gJ18eobkbOiFtsa0lzhPpSMDSoqEzYxD8Y
 wFyjRhC2ezn5lK+b7Zio0D6ZL4Vs1AywFDnDETRcJMV3a8ypCo0w2BoXCCuRZzf388KXj/umKEB
 YkfQFay7YuvBjFmf9FrbiuSWEhVo3nEsgw8OoaLPjTw==
X-Gm-Gg: AeBDietkEjRHNXIrW43GeZ4CvZGo2WlAN5F6coO9GoLAx/Owm/undfnldHBXA1lkDdY
 QpI1IWPimAufOptTt/fMYgK76fT7E1qFwdftnpLW2bgosroUIsStVCLP4faWe6aJmHpk4I1c3mz
 w52/3M9OKsZMSMlRYtvd22juicgR6xDDpQ1C9SDla1vbJauAycaMgtpCWI8Us/67DP7JzhuqiHz
 AXn4ipvAOGOT9WxyFLeBQEW9Y5CQWyVIcRUUgyya8Ps8fC1X9kaCzJNRZhz3RypRNF9zAvdqhpu
 +LDh5rRZqdweksRVelqDUpqomRNLMUCzAL9nDZe77VTe06NG4aTKb5zfszMu4oG+GF6mZUWu3Yr
 3/U72LxGcLoLIQhV1qNP7xe70AA63wKMI2Ks0mrS70zlGQM8=
X-Received: by 2002:a17:907:a4c:b0:bb8:a6e8:f93 with SMTP id
 a640c23a62f3a-bb8a6f75d34mr133059566b.12.1777392037523; Tue, 28 Apr 2026
 09:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 18:00:22 +0200
X-Gm-Features: AVHnY4KGTxIfv6siASIepSlUuaWli41HRXBGYJ16AtmjfvHmRhjlDsPXtcloTK4
Message-ID: <CAEHHSvaUe5cWmAUBvrjowWVAuPJ0yN7F8HP9wtzu4+BYxKK46Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] spi: mtk_snor: various fixes and improvements
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, "Noah.Shen" <noah.shen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>
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

Le lun. 6 avr. 2026 =C3=A0 22:14, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> This series contains some downstream patches that I have split up into
> logical commits. I have tested these patches on Genio 720 EVK by reading
> and writing the environment from the flash memory on the EVK.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Macpaul Lin (1):
>       spi: mtk_snor: fix zeroed data in DMA read bounce path
>
> Meiker Gao (1):
>       spi: mtk_snor: Remove status register write procedure in probe()
>
> Noah.Shen (6):
>       spi: mtk_snor: clean up comments
>       spi: mtk_snor: avoid alloc in mtk_snor_cmd_program()
>       spi: mtk_snor: conditionally copy tx/rx data
>       spi: mtk_snor: check return value of mtk_snor_cmd_exec()
>       spi: mtk-snor: add bounds checking in mtk_snor_cmd_program()
>       spi: mtk_snor: support newer SOCs
>
>  drivers/spi/mtk_snor.c | 196 ++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 129 insertions(+), 67 deletions(-)
> ---
> base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
> change-id: 20260403-mtk-spi-nor-improvements-dba489fad981
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

With the nitpick addressed (or ignored), the series looks good:

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
