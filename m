Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C8ACFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1DB83DEC;
	Mon, 24 Nov 2025 16:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rGWPqkDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770E983BEF; Mon, 24 Nov 2025 14:55:07 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA0D83B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so36695335e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763992505; x=1764597305;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V5Endz+RIUiWqKq4+/Ooo8zpWW0M054YjWCo/Qzopik=;
 b=rGWPqkDuN6c7f1fXprm7UEFXuDZYZtfzUYK8dqTDVcQlGOyQr4ChWQDirmJjon86rs
 aCCGSnU2zumSGyj4NpEQ9UDjyGxXDvz99V++jQf95VJvsOVseBFVjr57dkK3koCu7khi
 uxAOSFBE/VNjgb4GBLMEcvxS4SZQZlrOqJOc9WYb4cymrVoWM8+vJbxL2/4qIoIdQLeh
 ZKQAFYr7WvppbSN6CLYreH0oLK5u/DL33HEFLw7ejWzyvhtcAWRqJEx33u1lEUssrDfW
 +dGhvatv7xlkdVuWZR/vLD1TaaHQ/M0Z36n9DXuPWuzNUbI6Z2vEQQmJjR/3YgkCiRsH
 Vzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763992505; x=1764597305;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5Endz+RIUiWqKq4+/Ooo8zpWW0M054YjWCo/Qzopik=;
 b=jmKCoha/AR8O2xgVeMO9uwvxR2wGwZcwk/ElsO0HQAWlYqV9PM9kdbpgtmhmechlo6
 IHhWMScpdMLh5zDeJsFKhBD1HQ5l8aWydVwSzG4nEcoaTTx7Xnz9/uxaM0qC5uyzY2GC
 N0Nfh8RcSfFMXwsTvUQ8Z7v9Sla5dlDH5lxKCVkbEj46Bj7YtjO/1PkynbKv+ZD2ZPUv
 BezlrZhU0ZUiLpEQSfviVNckSjK6ZJBsQ0Fd9LVgdHqM8mWIdSsk7bTzitW0BoeTqCnj
 AFzD68ytgC3yV/cfZcYhxtb7aFl+DX9xuSyVEhaXzMqyGgT60gcS2S4248l/anMqWNTi
 rbpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4XTzj8T/qjjblJAsxErxFkuLo32FNnSJusqeb4JjVYZakqZY0b5goEV5hGCTt7j2lzv0kOq0=@lists.denx.de
X-Gm-Message-State: AOJu0YwGxhf+eTsqcPx1VSjmL6B314n6vjKCHm/nvpJpVe1mrU2+ATMP
 Ap6AoRnArj7/uWbA762+9PtXCpfifKjNguUbKx64lHq5jsjo37r+EfFKPhHZg0bi06s=
X-Gm-Gg: ASbGncvM/c/idHWtnKhleSGg2uxMcq2EXKQsKwapP8BatIhFl9DdDz06Z/OvE31hBPy
 q8GZmJ5AiszX23LnOHA1vKelUX2iRjUBgbVOJluqUskjcUfu21rYeVsVbrQIuhBxcthbKBH67ZP
 N9v2fxbWbhycALXvmbLilHy3BvyOdylAr1xZ4OKFOxi17Af5nM1ur0IZrE/wNjH800L2dpwYpTZ
 LKdRRST8vZTd81iV1hUtjgewdXl5YkjSsou97SQj12g8F8PQ6gVwrOC50HEaMYaD1I8NryOPu7r
 8fMm9yR30BWYqqGU9r6QNKpiTM75D3Hj0YFa7UsuEghljSJGcmd7cHocfz6z40twkdP+b9yUKnc
 pZQNo3TW4dbxRO4ZvtC1/LYXcvTtr+i42zMvIbiwFUzUruqpshcFvuZmf7wehhUPbOdCi/2vZNK
 azRQap
X-Google-Smtp-Source: AGHT+IG15nz1EpzP9dp+zJsPceSdIuX5d2DdnEqCS3oE23+abhohS1dtNRP1YIAG7CkGwLmGTEvIIg==
X-Received: by 2002:a05:6000:2dc5:b0:429:d66b:507f with SMTP id
 ffacd0b85a97d-42cc1d32445mr11379436f8f.48.1763992504702; 
 Mon, 24 Nov 2025 05:55:04 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3592sm27221770f8f.21.2025.11.24.05.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 05:55:03 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=fe13a642558c56126a10bf6eaf56130855539e48b6a78f7d9c85451ea3db;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 24 Nov 2025 14:54:56 +0100
Message-Id: <DEGZ5HJ12L64.1VTJRRTC9P6UO@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Romain Gantois" <romain.gantois@bootlin.com>, "Simon
 Glass" <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Andrew Goodbody" <andrew.goodbody@linaro.org>,
 "Anatolij Gustschin" <ag.dev.uboot@gmail.com>, "Sukrut Bellary"
 <sbellary@baylibre.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
 <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
 <DEE8BZBDYO08.1SX1UEB750S25@baylibre.com>
 <423d52bd-2446-47de-b6bc-4ee61fd0c23e@mailbox.org>
 <DEEMMP7ISZ9P.BP6XAE07Y26S@baylibre.com>
 <18e034ad-8904-499b-a07f-034a5c01bc0b@mailbox.org>
In-Reply-To: <18e034ad-8904-499b-a07f-034a5c01bc0b@mailbox.org>
X-Mailman-Approved-At: Mon, 24 Nov 2025 16:36:23 +0100
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

--fe13a642558c56126a10bf6eaf56130855539e48b6a78f7d9c85451ea3db
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marek,

On Fri Nov 21, 2025 at 9:51 PM CET, Marek Vasut wrote:
> On 11/21/25 8:40 PM, Markus Schneider-Pargmann wrote:
>
> Hello Markus,
>
>> I rechecked the compatible lists, but they do not have two different
>> matching compatibles, mostly just one matches to a driver.
>>=20
>> But I think I may know why there was no issue with this. Grepping the
>> config symbols it seems there is no config in which both drivers are
>> actually enabled at the same time:
>>=20
>>    configs/renesas_rcar64.config:CONFIG_RENESAS_RPC_SPI=3Dy
>>    configs/renesas_rza1.config:CONFIG_RENESAS_RPC_SPI=3Dy
>>=20
>>    configs/r8a77990_ebisu_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
>>    configs/r8a77995_draak_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
>>    configs/rcar3_salvator-x_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
>>    configs/rcar3_ulcb_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
> These ^ configs include renesas_rcar64.config , see this:
>
> $  make rcar3_ulcb_defconfig ; grep RENESAS_RPC .config
> ...
> CONFIG_RENESAS_RPC_HF=3Dy
> CONFIG_RENESAS_RPC_SPI=3Dy

Thank you, yes, I missed that. I still don't know how it works for these
drivers then. Any clues are appreciated.

Best
Markus

--fe13a642558c56126a10bf6eaf56130855539e48b6a78f7d9c85451ea3db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaSRjsBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP9
wQEAvMi2QqZ+ZO3fBP5cfZnqfdyGVC0TI/2pugZQq6fOGs0BAMGITWHLiAu6pRed
93c9WRYicu6GCOkq5mlTqfr4HtMC
=4T0r
-----END PGP SIGNATURE-----

--fe13a642558c56126a10bf6eaf56130855539e48b6a78f7d9c85451ea3db--
