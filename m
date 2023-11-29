Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A46C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BBB86BA8;
	Wed, 29 Nov 2023 19:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rz0PEjfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1DB85E44; Wed, 29 Nov 2023 19:06:31 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D7886BA8
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cf974e87d9so85875ad.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281187; x=1701885987; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68vsV9fcVszFiCzWNZOPum0BboxMCMFQgWFP+RQY0Ag=;
 b=Rz0PEjfWrB/9LWGDbjNW+/GCtuu83wOISfS8GzJHcWC3zrO1d5uaJPGvnHx19ad3R2
 O3kUXfBc0wzBpt+mM8UNcj5k01ZkUVn4KTAzijseg3BNbuusKVPeDL495mstRNj+7mmN
 W1uE6cKXGRGxMa562eGkBaeD/u6VFqcAC09s0S0jy0000FeBVHOiXzSVR88IWcMWaZyj
 zd0ttGk4odDLlumcioNnCXaOe9nEs3HO33lHORwrvlS2UO8MCp2TvuNIOU+VQfNDp64x
 QneLdz1euSq6Qjo+viKNlPX8rWhwZD+1A4WMoL5mpOYPM2a/mY98x5zjJ2PQZ0qSDhli
 yZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281187; x=1701885987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68vsV9fcVszFiCzWNZOPum0BboxMCMFQgWFP+RQY0Ag=;
 b=kFgY3USegnuhWkIIYkE30gJYHIF0FrKr/khYAYn33vMUjPzDMsy+pErqu9tvrCmwn3
 itViko/svj2OG7u+bgyvObvjK5p953LYfEBncBRQSER+yf0ayUYiclKioFezr16auwHx
 86TxPTks3LaktE035XnDE1Mz4Mo6Dq0LBL+mKUB1xSvF8IqKXoAX9v3VpkG6sVbu3GW7
 H+3XX9XsNdP7HQ20odXh+ANC1nSS6rU5IesWSjJTXg0Eghd6KEjDzIeq+TFL0ntzXj39
 MKoa0QXPTM8HldcoZAGQM8WSpIbsNPlOv8gAYrQoU9tY+jbAMpmTTDB45UFa5rRophf6
 3Uig==
X-Gm-Message-State: AOJu0Yw4wEpKcL3r5cLvms/7HRVp4Z2AJAwDQhGbOoZXk77C3hml9MWD
 iZU1zYMeH7DKVDncHT/lDEmhcyJAn+ihaD276a9HayZw
X-Google-Smtp-Source: AGHT+IGXdy4SiQdN7V5Xwha5E7PR+lpLiLT4tvecKmlFeT1oWHBR4XarHfwA9HwvlbKkdGQ649v6MNR3LB+f2/2ppGU=
X-Received: by 2002:a17:90b:3643:b0:283:a179:963f with SMTP id
 nh3-20020a17090b364300b00283a179963fmr19597297pjb.2.1701281186764; Wed, 29
 Nov 2023 10:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20231017142500.4074185-1-hugo@hugovil.com>
In-Reply-To: <20231017142500.4074185-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:06:16 -0300
Message-ID: <CAOMZO5CUoiaQvC1HHGs0Ky_js6o4GqPma_Jwa4JyLtHRv+Brtw@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: add manufacturer to target description
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Tue, Oct 17, 2023 at 11:25=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Add Variscite manufacturer to the IMX8MN_VAR_SOM target menu label as
> the majority of targets include the manufacturer as part of their menu
> description/label and it helps when looking for a particular
> manufacturer/board.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
