Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2F6CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBD489285;
	Thu, 19 Sep 2024 16:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GquV6uD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8EAC89266; Thu, 19 Sep 2024 16:14:38 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C483089273
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2055f630934so8289445ad.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755275; x=1727360075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OeCofrtJJLkkwnHfuzuov35asJXMwscZ0BVLUTUrwNE=;
 b=GquV6uD60x0JDjLc9edHUuQf0qnUIyFOuFsqx4D73+iQjJK3eoBbKjCUhoTueC2ujF
 HbvAgXHQGMWxa3mpMT9XKi9TSIfTPIRZRE3DcQFnHasCNbI9Iv2tMh9QGpeD3RFcVAKG
 PXdjBA+0vW8BkDz309ckDGdXiIVOSTV/XfbjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755275; x=1727360075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OeCofrtJJLkkwnHfuzuov35asJXMwscZ0BVLUTUrwNE=;
 b=GvDAITwCF89gmZ6vb1jk55x/Qomtq3VUMzhO44k5p/A/+KEcGMVP5OdecbA5Poj3gd
 KVqJjY4bVnpulNcXFKnw4nTgfWVX5cjE0+8v6ciKdnDezgrJBJQ3a+FJCr8hp4DbqaOF
 9dHdobwwuuF3U5P2v+R2EmBJjNH7JdDXW5KzTUvHA9ZxfwQv/DFFW6ENCxNAhCsthZJr
 hXUqWZpkQm0RGVVI0GzgocwScXIifhrI2gvjZSZe2yR8u6CA0s9FgQ27KZpGJibEPOlo
 0k2ZxlfoeE6+pm5enSOJ3TmWpo6BcMyVacXCEXkZrSitpEO96KewN091ZJQBZ3Ci6An7
 EDbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaZ6mu4QJOGLf028yesLNJAyzK0cw+/sxaQkbUML5Vm0aIY169RVXleMz1GYLc8p4Dnb3XL8A=@lists.denx.de
X-Gm-Message-State: AOJu0YyP1ojuid1njYiI890lp+DJXmqaD1YQi86RJfYvVgdkMTTcvMG2
 zc5OayE5KH7cNEfr3U1te3tMi8OktnyMMz05PMJwYpBsFqqhgMVeLVtulO9QchI2f8A7UYukjd2
 DXLy6kMwqn3D3foXeZRbDbE3HCaW9kqj3a9EU
X-Google-Smtp-Source: AGHT+IEiTLECJdKfVEdeg/yAOZbMh77AAETueSxPSNQ0Uba+PQZqMzOupVD+lAtTew5Ont89a3bi0pD8fuyQeo6OLS0=
X-Received: by 2002:a17:90a:5d17:b0:2d8:83ce:d4c0 with SMTP id
 98e67ed59e1d1-2db9ffcc174mr32289386a91.13.1726755275410; Thu, 19 Sep 2024
 07:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-3-ansuelsmth@gmail.com>
In-Reply-To: <20240812103254.26972-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:14:06 +0200
Message-ID: <CAFLszTgMzUmbTHPJ9EB_aRevE+NRtSn44uzutjLguXbE_mGWUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] led: implement led_set_state/period_by_label
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Dmitry Dunaev <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
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

Hi Christian,

On Mon, 12 Aug 2024 at 12:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Introduce new API led_set_state/period_by label as a shorthand to set
> LED state and LED blink period by referencing them by label.
>
> This is needed for the upcoming additional API that will declare LED in
> .confg and reference them by their LED label name.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/led-uclass.c | 28 ++++++++++++++++++++++++++++
>  include/led.h            | 18 ++++++++++++++++++
>  2 files changed, 46 insertions(+)
>

Can you please update test/dm/led.c for the new features in this series?

Regards,
Simon
