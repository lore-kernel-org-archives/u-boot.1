Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF310C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 09:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B74809A5;
	Fri, 28 Feb 2025 10:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DWG0V1Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2254D80BA4; Fri, 28 Feb 2025 10:08:06 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BFF807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1116687f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740733684; x=1741338484;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYhyZZNYZZXbnBbWkb2kTv66VpR6ifJhJsz5S93eHwk=;
 b=DWG0V1RvDaA9lV10RIkA8nW970UBiixweTF4uetuH5G2lPQPtp5wEgiMFFMGfTYX9v
 Ck9fuaI0gEEFv7kz3S3ToaH7Z3PLwLqWiNIAKwDU296B5B7JKUgrIGt9aBsseegRni9D
 g+01Tf2mViSBawf7Rd8mAXnPfFUvdDtpoBF7w9XDRe0iF8qYEFRnt7ZBjOILC8Jm83WF
 c7ppAZnExRGnaehNG+bdtgL1r/ZlFFaKPkLm0kKN2sfTl1Cfann2z9iEP59kssUD1Dgz
 7IlW474zV+NHfJ26kMC4fxqPGZt9jYKtfHzecRH4fNL/36Pa+UYD+YwGbM1V4Th8k2zv
 GY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740733684; x=1741338484;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYhyZZNYZZXbnBbWkb2kTv66VpR6ifJhJsz5S93eHwk=;
 b=NfkOFw8pyYK4KGgU4Iqc6P7UpU9KHGTE8lMq1U8LYFx8B0kHCLMN+pIjeq1yn3NGzO
 Qlx7u2mUTkf9LHgtnVVzlnfktUDQocVa4u6M/Iko9GEs8POZCQAU/AWEGm935Nyyaau6
 6HY80q54K3rNkWrZrxFPDDPVozsOLs2RWeLQvt4BgeORliXNYm5WIOEyJofrVsWqEB+T
 DdxaQFY+b1ZPUiUw69h8lLm6Xt3zwWV3GOWJBqqnG3HS/YIRiKzvqAXlnKcdCmpU4g6g
 wTRtyeHQV8iHUgm5YfDoENZR+Q9VNEqkCfzdfKFUkwSRD3EARwrVsT8fvWrlJsfpNF0s
 MfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoUcsCA72ggQzF3A3Bfhzi8uiVVAwi4zYv1UxmKhyX7uUPK8Aq4SgrBm1cZdH9glMGBYM+V8U=@lists.denx.de
X-Gm-Message-State: AOJu0YyzS+92NFRNbcNz5YltuKSZloZW0CQLkzdk4lN4mFA8Y7nDntO5
 hYg9eyu1cmPXj3xkgX1e/F5uB5ax5DkgB3Nw0KD3ncipOrsglQcpCUJLq0I1AFcP1jBeXjO2DXx
 L
X-Gm-Gg: ASbGncvRWgJhyebVZsU8OLiIDWhyji8m64bvkK/iiDGxFmkHp09babgQFX6VDu6r4fk
 9RVkbMbSZMvTZL5Fizoyjg/n0aTs4NLj8JKFKlpivMKZyIZHjQ5uIgLRvvm9pzPksaVst7uPByH
 tSo2izxBMkyhnuCBv1I67QQb7Yj9/b0nLB3dFXtj4krfvE8hSl9RRsKP2p+wtl2KC6e8v7AN7Kj
 vZY+JvH+uHtoBVcGVwh+lQXFYEdJiDw8E+kgtBwUFlu+V2m9HS1IAtBoHmhmdsf2frViwIslT8w
 oVApp6qDf1MNWP4fV08Bst7zADWP95jXZ5U=
X-Google-Smtp-Source: AGHT+IF9e9rowWysb3uwlF0PA7lOuEfJrRfaPkBevU7gzgTY9ueddeHLufdmuiarW1yoZ2XTxNlKTw==
X-Received: by 2002:a5d:64cf:0:b0:38f:3224:6615 with SMTP id
 ffacd0b85a97d-390ec7caa2cmr1834259f8f.7.1740733682909; 
 Fri, 28 Feb 2025 01:08:02 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm4677192f8f.15.2025.02.28.01.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 01:08:02 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/2] usb: gadget: Remove the legacy usbtty driver
In-Reply-To: <20250227205101.4127604-2-trini@konsulko.com>
References: <20250227205101.4127604-1-trini@konsulko.com>
 <20250227205101.4127604-2-trini@konsulko.com>
Date: Fri, 28 Feb 2025 10:08:01 +0100
Message-ID: <87cyf2e8su.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Tom,

Thank you for the patch.

On jeu., f=C3=A9vr. 27, 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:

> The lone user of this driver has been removed for some time. Remove this
> driver as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  common/stdio.c           |   3 -
>  drivers/serial/Makefile  |   3 -
>  drivers/serial/ns16550.c |   8 +-
>  drivers/serial/usbtty.c  | 983 ---------------------------------------
>  drivers/serial/usbtty.h  |  49 --
>  include/serial.h         |  20 -
>  include/stdio_dev.h      |   1 -
>  lib/Makefile             |   4 -
>  8 files changed, 2 insertions(+), 1069 deletions(-)
>  delete mode 100644 drivers/serial/usbtty.c
>  delete mode 100644 drivers/serial/usbtty.h

More code dead code removal, great!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>

[...]
