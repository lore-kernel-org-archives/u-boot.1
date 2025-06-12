Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E04C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 13:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73BE82B70;
	Thu, 12 Jun 2025 15:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KpslHYyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8042C82BD9; Thu, 12 Jun 2025 15:53:20 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D7D828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5534edc6493so1107077e87.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749736398; x=1750341198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wgKxbk0VSoc4kY81IxFgt4fPvEb692UI9hdX1OPSMA=;
 b=KpslHYyEntm8mIq7F/M8vPqu+73D3WyKiSPrDGbAE+i5nBY/AjcgVZEU8ZUmEoxwVh
 3vnyB5De5pX/K73Z3oMmwZdQQlMuiRJcripCWiYKKW6bepYFC/JswWo5IMekUmYQZEcO
 Nh7ftYwEYwIt5AH33tXLDgTut26eS2m/R8zUTzDCqDt7SSihrBi+YmA+D319d5EINhG5
 nsVxetyZpv1EuX8e8/d9BkMQmXE6WqcNI9pg0bnQC+gTIrXUROFja8D5/EjOJcqsClJQ
 AQQPvFTGhMG3op+cwKk0mz/mEqUYmHwYWdgSZkVwwPI2v/Slp9wZjUinIqMRAA79xeQx
 RY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749736398; x=1750341198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wgKxbk0VSoc4kY81IxFgt4fPvEb692UI9hdX1OPSMA=;
 b=tXgqiRvX3uG0q1Hrc5jg455Yz7CI7QKW6aB8qosemcGSYOTZ593iVCtZYdQLJDDUi6
 hYgPPNjtPVnRogscoIEaHp3MkTNJKaQyixbb2A7HXpOOJQ9J1/N2UhH5fT6uAvXIRiLO
 XmXvagfYGbKNmk4LH2Jk08x+DNRVvCTo8EFU9dcO2OqEyXqEsUQUFjWXJ4ZR+LCjZsv2
 fWU84FQwE0WC350SwxE4pLCJLSRMisjFEbWI8MitPq36JcFgxQ50kA8Q+C6hliTVuyBF
 30NGvIO8fikXLNFEt5g+mNqSv6p10bXmIbyAvT0Ieq0E3Hq6cFgoX1XKxjHER9yh7LVO
 4Ztg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc7r2ePoDMz1Lf2Ig7MWFJqCYlrqL+BqINcYkw5fZYWsWUd+gNkPi/RSXCGfHunnzdzBIoHzE=@lists.denx.de
X-Gm-Message-State: AOJu0YxO9OCYsXlF0BRJ2jMRObcfI/o0wXwWTAma9FnbargrZfa1xklC
 nGYEprAJBGXYfmmcmdM2TK8nHemU0xpIAS2phY9TXolGx63hYmyfjLDuKuT67bdUNbBMYuOlT6x
 oTkX4JE5GCcZweXD/lKLZOISGhC9bUjdMDw==
X-Gm-Gg: ASbGncsld0KE8kD4OfyOg3h32oVsE45mmir2CKG+Y3vXCg2pG8oR4csXUWL+pnZQF65
 4ySr6aVeXO4drfMpcCiFxgrUGxuH8VMu3qasz72m4bUbA+sMnAlWPomYiMT/NVurJVZAzsG1fut
 2YwLzmWOPe72fV6SasmUg/HP3Y0BAAh+biM1NngQFBalS/lH8iY/zfTUHE9XBaxER7ObI0EBQYe
 wE=
X-Google-Smtp-Source: AGHT+IHpkwxExOoQyIcjHlXqfhctP5tbkiSdYrqG/I660pqSEQOI9BwNu7l7z6QgNy2jIlcAKwqMInUBqL+ecADKrWE=
X-Received: by 2002:a05:6512:1383:b0:553:2633:8a63 with SMTP id
 2adb3069b0e04-553a558266emr1085988e87.17.1749736397386; Thu, 12 Jun 2025
 06:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250612133519.764041-1-hugo@hugovil.com>
In-Reply-To: <20250612133519.764041-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Jun 2025 10:53:06 -0300
X-Gm-Features: AX0GCFt1ZN2kHy3lZNaWAeOSb7XTp6cMF0Pj7EFygaxBSkcqF9SROTpjMUgU6ss
Message-ID: <CAOMZO5A=E7_9oOQUffveTNbyy=C2Bo_LW1d-ePdnXE0j3zbxLQ@mail.gmail.com>
Subject: Re: [PATCH] board: var-som-mx8mn: Fix alloc space exhausted in SPL
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Hugo,

On Thu, Jun 12, 2025 at 10:35=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> After enabling some options to support EEPROM read in SPL
> (CONFIG_SPL_I2C_EEPROM), the following error appears:
>
>     alloc space exhausted
>
> Increasing SYS_MALLOC_F_LEN from 8kB to 64kB fixes the problem.
>
> But instead of manually increasing the value, adopt method used in
> commit ce3f23404c19 ("board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
> CONFIG_SPL_SYS_MALLOC_F_LEN"):
>
> Dropping CONFIG_SPL_SYS_MALLOC_F_LEN option allows it to be set to the
> default value of CONFIG_SYS_MALLOC_F_LEN, which is set by default to 64kB
> (0x10000) on i.MX8M platforms.
>
> Suggested-by: Fabio Estevam  <festevam@gmail.com>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Tom, feel free to apply it directly to u-boot/master.
