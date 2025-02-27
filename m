Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FE8C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5193810F6;
	Thu, 27 Feb 2025 15:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RXfpn5+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934F581110; Thu, 27 Feb 2025 15:21:44 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FA581109
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so1094665e87.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740666047; x=1741270847; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJk1sohPalpjkHRho+XB9VGmzrQ45bAukAq8kaTZi/g=;
 b=RXfpn5+qKRDMT/Hdw2AL2A31VH5TN7a8+2GFbl41IjPibbapj2DVI9GbR4JGSNSIF9
 wLOJxlc4wloF0nARyEqAXUOQin1XcI1wJ8C5+dn68znAyAyuoSZmxeWrFMFzPs0LjeXI
 bDyiLnyvji7fD1sef2wTuH9ZnhCEOlCieLiOZBpNzHUehuLB4EnLl4NjHPAs6td7H3rF
 kNKswlQmQmympjdaQmMeaXuHXozVixa/lznGOKtPudEGDnNtbnbfNIVdPKqYc7wgUSVg
 0HPIuCfjvg+5Ms/22TDP/MpqnvP16gRd3aQpEGwv7QODew2Ipba8LXu5qmwNk8NZ5Lqq
 UMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666047; x=1741270847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJk1sohPalpjkHRho+XB9VGmzrQ45bAukAq8kaTZi/g=;
 b=NVAEnq7sHXST7aKZHucmxlUDjNebqgHZYvNAMydt+RGPnByq+YFbPQoQPv9KVvrmEL
 IGLrO3Hgt/LzUOEobGAa0q14iOU2xz0W6DgfVy2ADzuhE5nnwEIhjlaLyap6R8E07Lsy
 aAeIa1SN1oFBNWdjerfSpVdNe0nG98Ql2zG7qpWXd1fyYiRdwQnldZWcsMX9jB3leEFG
 ejuW5hyClNuwQHxxNzUaJu2VldQOjSOF5WMR7RH8NNqYv4sUvEBkNtIrcSfOHjZEr76Z
 ppfav7TmMV6WC1LAm+zyUy/MrAuldDqhaIVAVP0aZhHZ4aDi35vn7atE5lvVfb36FVuu
 worw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFF8jfCnmGUdjYTyxM9aDxP2ETh+nouysCweWf9FT8ySIciubZOHYMbUTip6uLDYm23TvIT9c=@lists.denx.de
X-Gm-Message-State: AOJu0YxMmudVEWER+IyBJwRSvw1XFzdg04RPcQZAj9EdMm6Ni9kP5zQ9
 Dtxnix53rAn+dTdGR4AvyuGEmI1SsNtrcuHDxVqnj0cZZ/BA1T/gQo103WTlhrjj/KGPcPo3QS7
 y088lhhjeQWYp7Yrw8Xsz79RqyX2E4w==
X-Gm-Gg: ASbGncvDyFaC4V2FQxylCrnqGqUARbzeYoH8SGMx8sKTp/9TB+E1xU9ULGrlSEKmlyf
 El1sASQaHv5yw+g4Zb8i5r5SYCbYM7X7mgITgRr1jSo3cX0vqiRM67l//95Gx9i1+RrM1ejRYNS
 pcOJtBeLhwpZdpcaTJWMVHWy5JVEYb9s8LbROs85c=
X-Google-Smtp-Source: AGHT+IHQOF9oGtlvg3+f/HxhieC8FVaRsGiJDGYzdE8y3ftwpMEdpJ+k9wBsKgYNTSZsaLIihVp2bX/stup11vThODk=
X-Received: by 2002:a05:6512:15a9:b0:540:1f75:1b05 with SMTP id
 2adb3069b0e04-5493c57ab8amr5003299e87.19.1740666047340; Thu, 27 Feb 2025
 06:20:47 -0800 (PST)
MIME-Version: 1.0
References: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
In-Reply-To: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:20:36 -0300
X-Gm-Features: AQ5f1JpPQEcif7pZNGGtGhzFxOcFQHSoG_AjgO2fwCYyMeaFvRk4KzJzsMOASrk
Message-ID: <CAOMZO5DVb8JE4NN1pOAJrxxkNTBnq=WMotaaqM+TxYLr6f=b7Q@mail.gmail.com>
Subject: Re: [PATCH v2] siemens: common: Make DDR_SI_TEST depend on
 TARGET_CAPRICORN
To: 1425075683@qq.com
Cc: Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Thu, Jan 30, 2025 at 9:53=E2=80=AFPM <1425075683@qq.com> wrote:
>
> From: Liya Huang <1425075683@qq.com>
>
> The DDR_SI_TEST config option is only relevant to the i.MX8 Capricorn
> board.
> Make DDR_SI_TEST depend on DDR_SI_TEST so that it does not show up
> on other targets.
>
> Signed-off-by: Liya Huang <1425075683@qq.com>

Applied, thanks.
