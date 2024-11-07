Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35821D43361
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B226389287;
	Thu,  7 Nov 2024 15:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E70SK4BT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F340389293; Thu,  7 Nov 2024 15:10:20 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C4F89270
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e291f1d659aso937127276.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 06:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730988618; x=1731593418; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HwEn8SWXO78NEgFzTYqshKMm6eYWfa88psQBCh4jjo=;
 b=E70SK4BTvAK9Xdxi795+cH3s6J/8YiGeWY0lXcfqeOpRvHYgRGFZWFM3qO69ohfWyD
 hAHGLTB6NiMLasLTikWOiMJf0rdEJ2ZJUnjd/YNEfhYduDQXxQJIugUW0Z7n7YPJNAKA
 2fh+TZudn9uKdc9L0MzBvZ5OA5pXKfOC1FBMgdaRpDEcVt13VPOYOePdMoGFayyuH9IR
 QBjAFw4EKveLZxvCZMooyn/Dfp9eLJAecd0wulHdqr95OQ/5QYxsG9BntasYNC9O/oyU
 c8GTnP/+etI+uo5CmTvaU7pGNcoYw+1y2Pc71qpmkcUyboThpHkIJLTDfd0VHPfQ00/2
 I4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730988618; x=1731593418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HwEn8SWXO78NEgFzTYqshKMm6eYWfa88psQBCh4jjo=;
 b=U+dtHq+m75wxSE12bEda6z8uGqMamL9J+WVw2xO3eFdZfF/K/i9gYTSKHfs7Ao4B6K
 iiZDhmJHrIbBtjb6oQwn6fQIndJ2HqAkhykPV9r+bEkntdW65OTGACT+r9z5xD6v6DQv
 9dn+9/d+o2OgbA0JztJgUXLe4mEYT2oIFBPl9JaY6hpm4M4ZdgTId+ILQdAIMyu2FRE5
 e5PDIuM8h8CjryPTu7vBHgg7vYBkZRjKs4TqUvCVT9KGMJGrazWvFrvOiRR0UCyCfnYt
 A2JbDPVYSJ6LADm+gPkXD0Oez6SQ93Sm8MrqRhP82RquYIerB+rmb9ixGtPeybOGq5wR
 5BIg==
X-Gm-Message-State: AOJu0Yycf13Y0yCDcuBkm82FdS5EHERMJOkQ30nCSlgXYXdRhfTZZjsb
 OMUL8HsSoJdqwkmwO4nGbTsoUo185RHvIvuZaianH2Fj3NQVyuO5xH9NKSOZBn7UFqXwK+pM8LI
 3o9wIjH7J3MMywwgbJk+Zp2uQzi3JzLeOebEDqg==
X-Google-Smtp-Source: AGHT+IHgRnhMajxLKgcQOWnq8JDGFifeTWEKwr9qSjsH8f1yOW5yzRz9wwKBMUn13sZVUYN3ZaFw4aAmmIupA9FpGtU=
X-Received: by 2002:a05:690c:9b05:b0:6e3:ca30:25f with SMTP id
 00721157ae682-6ea64b2f420mr240723777b3.25.1730988617674; Thu, 07 Nov 2024
 06:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-3-dregan@broadcom.com>
In-Reply-To: <20241106210348.218507-3-dregan@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 15:10:05 +0100
Message-ID: <CACRpkdZbcR=zmQGnGgnxeCYoXFw8W8oZX_KsAnTGbEL00BH0Vg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: dts: Use upstream dts
To: david regan <dregan@broadcom.com>
Cc: u-boot <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Wed, Nov 6, 2024 at 10:04=E2=80=AFPM david regan <dregan@broadcom.com> w=
rote:

> Make use of OF_UPSTREAM which uses Linux dts.
>
> Signed-off-by: david regan <dregan@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
