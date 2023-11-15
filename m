Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7D9C47074
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF828744D;
	Wed, 15 Nov 2023 14:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEqaVl7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A621D87441; Wed, 15 Nov 2023 14:17:07 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA1F8615A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so10343557a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054225; x=1700659025; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOuk9FGiRWw/0XAoPaUxCPMEelTbQyR8RwH7pMdrjMM=;
 b=WEqaVl7WxWQhJXgHXC4ha2XJwQE0yeCYroOWNjfiFeJgP7TsGd9kw1b7s2B2nyDXbC
 R7k3Y67iipIDO7Oi2FHq1sU/sApikJi3pjp6BKCRuB3B0juQDi9McbAqCaGCjpOlJROb
 +7wGqGAQHzSJjyRM0QRAfr/vudJIcFCI621Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054225; x=1700659025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOuk9FGiRWw/0XAoPaUxCPMEelTbQyR8RwH7pMdrjMM=;
 b=j+Y/nU44ath3hGLmhdgJdKuNCoWIwgmKov72DxnPCbTfC33Ne4P3uaEqifKD4AYuoO
 D224NEmmxJhQC/9UNXfQ9j3kfhL6RY5K+FHknIHH8tw/cse26Eus6RRo96IKSv6stFNi
 jT6sLzrcvL3Cj11qpYqAdJOcgEqXFiYN41OX6OW4XNE5gPhKExOG/vT8hNzx8LUmuvZ1
 JRDHhPkQoDaVwhAkM6GhHFywgSiMJmG9Qvl7pIzEiT5vG8b+AIMEjbbwqjMOGBzlerdi
 G7YCZOcQI2c/gIFDuykR/o6rqyg8TpATrOJRomA7cBluOVeZV/OltsJTvdYlONGFcZXi
 wfwA==
X-Gm-Message-State: AOJu0YwXe9NlEC9Lgi6ZMKFNBWgQbOMCs5T2FIbr9/1615zNZQxLqEtf
 7AINJPBWwd2RR+0s+SnPftQZsI9doGGKoDoAY/EWvg==
X-Google-Smtp-Source: AGHT+IFmzL+EcN7DZzEDoSeco7fC4RRVaPorSf57P9SeM3SvWkQ1MkjVBI2gqSg0LuFdU1sxhrQ0FQIUXIuWBfp438E=
X-Received: by 2002:a17:906:7d4:b0:9e4:7b7:267d with SMTP id
 m20-20020a17090607d400b009e407b7267dmr9423545ejc.52.1700054225285; Wed, 15
 Nov 2023 05:17:05 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:17:04 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAEUhbmVv69eLfbpre6YuM4otZHmTBpYGeMahtkKqzQ-DdQ1c_w@mail.gmail.com>
References: <CAEUhbmVv69eLfbpre6YuM4otZHmTBpYGeMahtkKqzQ-DdQ1c_w@mail.gmail.com>
 <20231002011450.462468-1-sjg@chromium.org>
 <20231001191444.v3.6.I0229a119165879ecce6bafc8568708326bf5ba78@changeid>
Date: Wed, 15 Nov 2023 05:17:04 -0800
X-Google-Sender-Auth: 9CcQsytyBTVrv4-0-cSTYkmkKhU
Message-ID: <CAPnjgZ2QPE7Er39dQj5D04bNcuP3mjQQRA8QKvs0RKvSE4xS3w@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] expo: Correct background colour
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

On Mon, Oct 2, 2023 at 9:30=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Use the correct background colour when using white-on-black.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  boot/expo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Applied to u-boot-dm, thanks!
