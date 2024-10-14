Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC579CFC538
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26EC48904A;
	Mon, 14 Oct 2024 12:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktTKh1hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05B788A4C; Mon, 14 Oct 2024 12:26:28 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DA2890C2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e4d6abb743so2251146b6e.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728901585; x=1729506385; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5pJZ9Rnf2f0LQAmY7uepfGPbogq/Ekcj0wZq/6R1lU=;
 b=ktTKh1hb6Mk3R8pxKKoel7ccN5y0j1U4N6N5FnRT2fTkjf1bHHxJ8uNGAXUXHWOQpO
 6Qok0S7u0C+kIMqhhEjntgkPb3o+g5ka/qsjYcqhiWpyGzYtWGaSDsafm7OZWLAR6AzT
 75cEQUyernxAd1UC4s/7RD0Rum/PCoJVvVO1kmaPNvL9ARsxog4am6HOyA9uU50gn2O3
 a5FjSDAtLZlBoUzNzLgsX4OmXIh4coXBCQn4kLsLhcLACwEkUcnswf4zXboh0vTLvKUp
 MB0oF2zlAF5Lgo03gAmlYxdcPUpkvNaweRMCfK2CnvfxS+fWPh88tFwI256rod0u7cCK
 6lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728901585; x=1729506385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5pJZ9Rnf2f0LQAmY7uepfGPbogq/Ekcj0wZq/6R1lU=;
 b=vFkF/NnRlp0qUBRErWo7DG7aWUnNXRiAM6VvKQI2HgqZng/jHDZ2cQV6cusDJ43wlw
 hA7ymZE3i/xRGhpI247g1Yk27jTRjUqNWwlACAeGlkZv3++ENiSUY4SQT9FUmLqiMQmb
 /f/8ZuPtRd8jd0CRl0Uqjh7MpRB4eMF7znBMx5we7PPmmcyKaj1wZr7Y2/uvdK0nNaqA
 j41LZWXxMzFYo5RchHVZ0V96gXHb+PggAZEbSkU/7xKPvLmZehAZYxY6xNlfP+QD4LMn
 Xh37fgpz7UdsA54eSMijHHBYjc2ACV3iIjqOQHUKhAWxn+oT7NXP9Bo/w/ltpPPu9aJm
 q3Xg==
X-Gm-Message-State: AOJu0Ywu9yUEh1jvReZ7+lCMa508Bd1qanHOy9/T/fp+KdffLAcEtGik
 BJgvVYbNA0zrw+F9dEDHt3xtJI8fZRS53dNcBE164NqKshmtl0IuTZs0YZQj4khFUJYmDJ15Oyw
 3tRAOPDY9pUQzMm3JIIXJilpByetnQpMTBOCevQ==
X-Google-Smtp-Source: AGHT+IFzsKplNtBbtuETBPDFWW6IiutQ7g7RspXILPF1XJ44ReoLdN9IP3vdkkewSOQFFE1+12xm8IgG//rFTKsQPs0=
X-Received: by 2002:a05:6808:199e:b0:3e0:41ee:3ff4 with SMTP id
 5614622812f47-3e5c9129bd3mr7500523b6e.41.1728901585157; Mon, 14 Oct 2024
 03:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
In-Reply-To: <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
From: Alex ThreeD <alexthreed@gmail.com>
Date: Mon, 14 Oct 2024 13:26:14 +0300
Message-ID: <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Mon, Oct 14, 2024 at 12:10=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
> Let's make this override-able via environment variable, because this
> might be growing in the future again. Does this work ?
>
> size_t len =3D env_get_ulong("kaslrseed_size", 10, 32);

Maybe `env_get_hex("rng_seed_size", 32)` would be better? As most other env=
 are
hexadecimal.

Actually it seems that entropy required to init pool early has decreased in
Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
(BLAKE2S_HASH_SIZE)
https://elixir.bootlin.com/linux/v5.18/source/drivers/char/random.c#L236
https://elixir.bootlin.com/linux/v5.19/source/drivers/char/random.c#L551
Anyway config knob should not harm.
