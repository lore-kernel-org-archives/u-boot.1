Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2F6E8B365
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0BC83DCB;
	Tue,  3 Feb 2026 22:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W7pTV8VW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6323E83DF3; Tue,  3 Feb 2026 22:31:13 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9CD802C1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8845cb580bso1012098166b.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770154270; cv=none;
 d=google.com; s=arc-20240605;
 b=G8zCNzlADFUzlAewK9lwnzHIZFG8rcqotyo4bvw/fqC0BA/pobl45FgNMARzTqcY/+
 y7IGBoJ+VCQr8ah+3ifZolKeYYm1RuW1NquolvhuLznwrorjtHMxdbS/Dj0SXEjkifXe
 WqAcPBirZoSM7w1M+yCb/Y/otoEV0X/P1YSEYwgh3MwkSeiWyyvNFPYZ1T68nYPbP2da
 CtjgHrWUo9Y7bglfJ0KhD4BrlWdEDfJcXSlyPdP4x9jWxyySm1HOLWmQ5PBI/rbSqK+X
 rlpfcmyWeGroUhu5YtLNYowqp/BJRXp0ysipalO0yLhF9m3s+nVYOb1SOMnE5tWPn7MM
 PTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/C9kxTHYWwb65ctsgiaTGYjHsLD9fZOt/qoFuwBQ/0c=;
 fh=eU/EAncrzEMdQyccwmHsU7h0eIIa5f1bizQs4TiaiuM=;
 b=BXapXXwV6YwjlVEx/J+Jd3VyF2Zfv/U+BsQlB3T1gmptEJDkmL2m+F9y3OM/HuPV4h
 sgSNiGhzMxI1boIn9l01ytNMmnqdeD57emPfZwVgDXaoRP98ZEgYf1vgqarIJwNKsHEp
 z5u7cePWdt4glIuO3ycDSOCewdDxMYLdIh3+zuPVA0tf0qglnpzyMYnULgUL304v0MRB
 WlqB9P6+KfuHG9ngPgeTBjp5tSQVsakcDRpiSRAzEG60kH4RQd8d0JlysyFT1p4BUUk7
 YtvO0a9TdfPs0yukyWhL7/XQWBD3xuSVIeHowhODRB+nn2ojF/3tml05hJSfUz8mklmv
 LaHw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770154270; x=1770759070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/C9kxTHYWwb65ctsgiaTGYjHsLD9fZOt/qoFuwBQ/0c=;
 b=W7pTV8VWozMExVS35C0kMvWPhXpRFqLyJF03KV+pxnt8nv0BiNyiGT3Ic+v0tDzI4Y
 4YQVfxkz4VJ1S1xlhhSgDLFctZCtqTsDZJeb1yspMlmHpKs4cRqqILZxkw0r+ZFOlZ21
 W9QF/uoXkHFMI3riIzF4jGi3bpSgFh+cgRqxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770154270; x=1770759070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C9kxTHYWwb65ctsgiaTGYjHsLD9fZOt/qoFuwBQ/0c=;
 b=LXTGdDt+DO5QEjk1ztU6AawLKdY4WquO5ZFVi/zAECU95P18k8DNLLDJRFwZ6755/7
 9dR0lMk8sI5XVShfADR/hGzPIAShs3atfyFPfSzxVYBHDuhPsvLaQkx4VEKkaahMREqC
 aycvBESJ/m9OIHui+fBci98hhaMVILzVu6enYrzY8a3kPLHIYa+/07X5ES3c/lJRUSDw
 C9lo+M9Q7iZoSoirYWm7wXrAPl5slvKWNwmUqCp66WIEfKZsq6DUPfgRXL6Y7lOBv0Sv
 F7RkT/2KK64XNPmXQTb5IOTEs8oK3VxpGv3BN7EF8a2/aL6SRrUds4sM+2UW6E1eEE3h
 UMHw==
X-Gm-Message-State: AOJu0YwMZ9w1O699n8EAyRy/9hpKMv4YhF0MO9MU+B6kBIH5++ZNoPBS
 9kqjsGj6iqPN0xe2vi51GXbxLG2XtG0iL5AFF5WRvTH2D8pSRRNR0m9H1f977Nvr9UOXPqF7n47
 WhAjTFs+KU7hsVFocQGIfsAh9kmpG9Q4ru5DtzkMJ
X-Gm-Gg: AZuq6aJ7niA/z14+9sPmDwlRln3iVi9/fZnP+peZD0NPEUzV6Ok02/Q721v/heebH7/
 TRF1FILZE/tg41wowbjieWjZiEdzIBYF3fayLhkicEHtBGG6JIuLoP/Cdri6dcpMjCSDyTNpJry
 wCkDQkLZsUyrnwJt8evEzA640z74ZNOivnoqOAlGMMNpky0IBoU8zD3khwegIDwzm6ty1xP/m2/
 PpPjWht8zWRbMpeuhjZzmpqLD7+UNNqUYkOPDKugPXm6SChPATrq14HW7d9nkhoBwgm51c=
X-Received: by 2002:a17:907:c06:b0:b88:227e:3870 with SMTP id
 a640c23a62f3a-b8e9f070f2fmr55264866b.11.1770154270365; Tue, 03 Feb 2026
 13:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20260128-legacy-led-sunxi-v3-1-4a528077aeab@cherry.de>
In-Reply-To: <20260128-legacy-led-sunxi-v3-1-4a528077aeab@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 10:31:10 +1300
X-Gm-Features: AZwV_QjOMxWIfb700YwyXb2l5RP1kDkbH3lwTq_jxkBJIy2Vx-RJRc2mXSBWB84
Message-ID: <CAFLszThhrSf2PZU=whHzUJLMmyufw1cOVHnER6yB=7kdOn19aQ@mail.gmail.com>
Subject: Re: [PATCH v3] sunxi: remove usage of legacy LED API
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Hans de Goede <hdegoede@redhat.com>, Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Paul Kocialkowski <contact@paulk.fr>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Liya Huang <1425075683@qq.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bohdan Chubuk <chbgdn@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

On Thu, 29 Jan 2026 at 05:01, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> We are trying to get rid of the legacy LED API and PinePhone is one of
> the last ones requiring it.
>
> Unlike all other users of the legacy LED API, PinePhone is controlling
> the GPIO LED in SPL. Unfortunately, Sunxi doesn't enable DM support in
> SPL because of tight space constraints, so we cannot make use of the
> modern LED framework as that is based on DM_GPIO.
>
> Since PinePhone is the last user of this API, I'm moving the logic to
> Sunxi SPL code and will let this community decide how to handle this hot
> potato.
>
> The logic is extremely simplified as only one GPIO LED is currently
> controlled in SPL by PinePhone. No need for handling multiple LEDs or
> inverted polarity, let's keep it simple.
>
> This however allows us to use the modern LED framework once in U-Boot
> proper since this logic won't collide with the new framework.
>
> Since the only misc drivers that were compiled in SPL were guarded by
> CONFIG_LED_STATUS and CONFIG_LED_STATUS_GPIO, we can also disable
> CONFIG_SPL_DRIVERS_MISC (which does nothing anymore).
>
> This also saves some space for PinePhone in SPL and proper.
>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Note that I do not own this device so I could only build test it.
>
> This is to continue the effort of getting rid of the legacy LED API.
> ---
> Changes in v3:
> - rebased on top of master,
> - Link to v2: https://patch.msgid.link/20251216-legacy-led-sunxi-v2-1-5739a5a524c9@cherry.de
>
> Changes in v2:
> - removed printf as suggested by Andre in v1,
> - removed check of return code of gpio_request() as it'll always be 0
>   with the sunxi_gpio driver, we could technically even remove it as it
>   does nothing but return 0, but it is "more correct" to have it,
>   especially if Sunxi ever decides to move to DM_GPIO where you really
>   need to request the gpio (and check the return value),
> - Link to v1: https://patch.msgid.link/20251120-legacy-led-sunxi-v1-1-c4c1422fd242@cherry.de
> ---
>  arch/arm/mach-sunxi/Kconfig | 18 ++++++++++++++++++
>  board/sunxi/board.c         | 16 ++++++++++++----
>  configs/pinephone_defconfig |  9 +++------
>  3 files changed, 33 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

yay
