Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0643DC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8912983906;
	Thu, 24 Jul 2025 23:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R/Png8Bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8868390B; Thu, 24 Jul 2025 23:17:36 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237B3835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-553d771435fso1518949e87.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391853; x=1753996653; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHuWVXTAMJdRFUQtgVLeaVIxKD/nUsB1DugOvTfNyoo=;
 b=R/Png8BcDRLuPLsL1Ic1jz0W/OEdFB08Cu7VWFkMLp8ltk1EZwEjuk7xC62kqmG2qz
 kMABv2sJX9AGuR8MFO7hd5YjgX62kIcURTZ4Chu2RRwR8fSaHOlylyn+0Swcrtaie6oC
 EVaAAyOKzeeDbjlG/mBHHdNZgDhZTQlwjpG9QZnk+EMfU1fFyqI/PtR73hUT1mqT2Fvo
 XRwYv1T1rU6tmaD78UeLjTavVL/GhmpJXsxcul5QsxUrreqqAYA65uIdkBIARfJZ9WMZ
 XTiL0R60oW7HieoXUm2iFC50SXCsBymVr1jJrsq+rM4YJ6FF5/1+xs9y2FxZbAxf6DUQ
 0lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391853; x=1753996653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHuWVXTAMJdRFUQtgVLeaVIxKD/nUsB1DugOvTfNyoo=;
 b=QHD911H5adPLsdfI+qX94jQ+rxo6zrrVXpnxyAiM9ZQDwQedp0jn9TwGqO0kOa6K3R
 OzPKhwPqPLA+3K6531TngINONDDCxDsdkRXoVq+Dfeth4LtN0VbV4tFOBycFUj1E061i
 VGn5usE4N/FkhTewSiOgmsv550TV+JeOb//SxMLrf9ffWWqeaxxzFEbClraeok/k9TXq
 giQfRUEIA5Cw8LmDx67UlWC32RGU+9No5cdbdlccHc05oM+k+0zBdRgz9N+nCyGpfH5E
 h9o1ezkTUGZL2yoexRwzJOc+gYRp1lQmv2R5QWh6mZzzPWZUdXk9u7e4v9rSaKO8C4jw
 o1lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtQUrujBFxdN/D8tkSsNkggMvJp0ugB6d3BV4cgrJXn9u/cnCcZg6QuaFJrVyBAXJQ79wfOJs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyx4si/wpfagcUbTdaYKkDhB4qpnIqLqTtStD9XZ159GVHUhnT5
 Ou2FURMbyCpE/YJzzC4bQuCWuHflWaLvddrjRhVafJddz4MuQtD4QtkjywuqkwYV2VonZBsuJR6
 nGXSaDdXiDtMf9TSd+ke40vjnwwX1U98=
X-Gm-Gg: ASbGncvb3tQDxWEaxCfXDWe05sNWnrwFHf12SHzBRqhvpibDNQRgfBzAa2ZY1cH759P
 mVrYlmjaRPiryj7lbJHKqPjEYJojalWNxtzEgOAhfcP9hW0QLG3CV4hFNSoyTNy+gg78SLc0Jnp
 0E/qS5q0LU7a1ufatQnJIS/K888osHVes0Thpw2LrP01QoS7FVJZsg0GAK/qMKEBkFivsIsQQ02
 piNWthfX8j060BSR3PeQG6WIB8j+BrE6DY9Qdc=
X-Google-Smtp-Source: AGHT+IGvgzDVNeDzXK4G0X0nOPZgQt3LG2KqiFPYHzsRKmAWxjjyE/WruuLW6D3Ap8Se/RUMXqtEzlHWGCPJxT67+ME=
X-Received: by 2002:a05:6512:3f21:b0:553:2e90:98b4 with SMTP id
 2adb3069b0e04-55a5134d99cmr2838725e87.17.1753391853213; Thu, 24 Jul 2025
 14:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-imx93_adc-v1-1-f7f272b54c6b@linaro.org>
In-Reply-To: <20250722-imx93_adc-v1-1-f7f272b54c6b@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:17:21 -0300
X-Gm-Features: Ac12FXylNqKLexWF3szr97B2zbZJbuFU1m3oEsLl_Vr0WJrRF3jBevn2EE8SiFk
Message-ID: <CAOMZO5AMxLBnFehaqGfQZ7KQEsUQ=rcka_8GdFwHc8-d8VT0eQ@mail.gmail.com>
Subject: Re: [PATCH] imx93: adc: local variable ret should not be unsigned
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Local variable ret is declared as unsigned but is used to receive the
> return value of functions that return int. ret is then tested for being
> negative which must always fail. Change ret to be an int.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Applied, thanks.
