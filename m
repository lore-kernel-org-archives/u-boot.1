Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D8BE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8916680278;
	Thu, 12 Dec 2024 23:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YQiyHgCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF95F8022F; Thu, 12 Dec 2024 23:10:35 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95AA580224
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef81222be7so11429087b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734041432; x=1734646232; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhFazxDzKwD6rCcNUFhDbmpViEYA1VL9qVuR0+XJ5NU=;
 b=YQiyHgCovGrzC/EXvuVh906GVpty2tr22bDWFsRm/fzWCv80mwN6mtsA3B/+VK+69W
 VrcY2yxiB8kz22yXokqOw0lfEV5wKcUwW7KLM1f0+Gvqe26GtQ3HlWi9P2Rm1Ops+tOL
 9k73n2rj7vlTGG4DZc5qIbZ9Rvcrop8uxYoTgDIJUQBJ45MHmp/t7Ezr0irwrip1NaCh
 bmcYAfxFMtH4PhT95B+wcs1+xlHON0Q5eWQVgq6FGJZwRN0ldMQw9oGMeE5qYT04NkhB
 4s+qSdXDBxGTGMXXqoQWhIPvbug3N2KLFeEuQ8SYax66Ny/odMP/3zP2EmsajX1FXQC1
 MzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734041432; x=1734646232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhFazxDzKwD6rCcNUFhDbmpViEYA1VL9qVuR0+XJ5NU=;
 b=mnZf/Vb+byyctbNeH32k+SRp4+VnnL4uySWBVixeruuS+n1HdC0SukFk4bgx+wd40F
 sBVRyhFgwtrNcOlMaIuGMIiszoyKj+P07jlIpwMoospSPAYlSiACz0D10S+K43E2c/A6
 FvkWoeuW/I2ocgice3zYqc87rN/iPZOHobCCpBNYynQgA7XDYW9OEne4qMwkfTWOcNSL
 Qwg/XYBL3PaxW4yte3eYEArTaYVDkp1Lp6nckFQoZziiB3pOAb0moZsBTyGlqUBRZdO3
 /TrDKk7lZNXv+HK7OFhBAdH4awrnXKWXqmVMB9NabKMHmwwhMwSEI4NUUzUzvUpdZYg+
 D0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1zPjmCAwuxPxjryFTuUoD6OA2yD+JlhXk63O/YLPhAWwSUIkLQSt9lXIOYyV2q+D/rmZaBOo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1TviB53TGJtw67IG+mKoSEH1yFA+N/9Uqquk5OX9xjv+5+S+I
 7cPABIKRvgiXLoqHtgYLHBfccMZGkXNnsSP3lSNDe1D5mQLp3EOkvwT9RzBUpvqqZoS85pTUykA
 Dfxrl8lQgCnf9NKZOhU6lVj1oJu5dJEkdQBmhNg==
X-Gm-Gg: ASbGncuZO9ikw1pqqZ2RO8+S3612zvoRLv2AFDQWxmFyiTe2TEAT3tvbNQRKCzep95U
 8jHgKM57UGxKz7lY4fAgOwO+kQ1AB/FSr3hroHA==
X-Google-Smtp-Source: AGHT+IFEFyDKphnNPxKYULYgx0v68d3Vyn6RIATAQUQiUzyK0h+YpaaRhW2Q52sIK4eyTokZpgXdWFi1bCH+dqsJtFI=
X-Received: by 2002:a05:690c:360f:b0:6e2:ada7:ab3e with SMTP id
 00721157ae682-6f279b96e9fmr3914407b3.30.1734041432253; Thu, 12 Dec 2024
 14:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-4-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-4-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 16:10:20 -0600
Message-ID: <CAPLW+4nVZP4nSJd9YPFMnjKCzaCmQPn1DJMmRDV4OmE3z-v4mg@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] lmb: Remove lmb_reserve_flags()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
> There's not much we gain from this abstraction.
> So let's remove the latter, add the flags argument to lmb_reserve()
> and make the code a bit easier to follow.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

[snip]
