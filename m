Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5477AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C1787036;
	Sun, 12 Nov 2023 04:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cBQkJlM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16B48708A; Sun, 12 Nov 2023 04:08:48 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4272786FB8
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-991c786369cso527332466b.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699758526; x=1700363326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QLKTVLJuKcubuwvDu9GRqV8mox9yYmSJk04kLg4b0+M=;
 b=cBQkJlM40AljUF8VR6TPTjOh5uXDSizYj2xrQRUqrDi1OtvUPgZ9b4kJ8ppko/HVjQ
 fs1a59xT5RKWh3InQi9tYFYfA1GFRyhGAeQMlSBHYhieIbNJQR5SYIwAFFpdR6fx6zDZ
 wT0MN722yRL5cFO/zDZFdhxTujBhu31WlSGps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699758526; x=1700363326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLKTVLJuKcubuwvDu9GRqV8mox9yYmSJk04kLg4b0+M=;
 b=BS6rmUjO8VeEG/CgIijW1g4yIH9agFxm97QaZ8dtJieIYYQKnvg8U8NHz+6glSTrYb
 4XwPFinkDm9UBnqMFLL46zvHRELwjo4TgLuWDeCcZfnx/Gx+a86jBvPo+doVhxiI1CN+
 iyIReyTfAP1q+GjYnzfW9xIWjRrqBUdb+yYWs1mrmJM+2yTDbKFBGRRSiGcwarUS6wco
 4Rd11exbRIcawuwdZadpedGoYVVrq/YuFwmhQiv1SYatv1ixYOorkIdHEGkGd3Wetl02
 GXmXjllngKm/hr741N8m0N0BRZqcxY2Q/ELEggygXcfpFmzcN13Vlrjc5DvNDFlEq+9r
 N6JQ==
X-Gm-Message-State: AOJu0Yzo4sLuZtUnRmk4XUZHd39md3TqYr6bPlGVeNC8a9BJufrrdN+k
 AsFrD6oedKqDnqtSIBYRjp0BORu+g84uZqq3kfOTMg==
X-Google-Smtp-Source: AGHT+IE/eB3mkXvYMw5OqmONzgXfiAzPZRlkxQfEI6HwtkNuH+RMCS+10uWZe+7fkU5WUbQBqQnNS4cYWhziyDtMl3Y=
X-Received: by 2002:a17:907:6d11:b0:9c5:cfa3:d04d with SMTP id
 sa17-20020a1709076d1100b009c5cfa3d04dmr2818293ejc.52.1699758525450; Sat, 11
 Nov 2023 19:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20231111003530.20369-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111003530.20369-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Nov 2023 20:08:33 -0700
Message-ID: <CAPnjgZ3BKo0RzMVeZbVgVqdST=Odoyi=ZRrQzh11HNZp-Voj=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: remove superfluous check in tpm_tis_send()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 10 Nov 2023 at 17:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Checking if variable chip is NULL after dereferencing it makes no sense.
> As discribed in [1] it is not expected that the variable can ever be NULL.
>
> [1] Re: [PATCH] tpm: avoid NULL pointer dereference in tpm_tis_send()
>     https://lore.kernel.org/u-boot/YaFwDtKKYRr7qzWc@apalos.home/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/tpm/tpm2_tis_core.c | 3 ---
>  1 file changed, 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
