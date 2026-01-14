Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59780D37E44
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D4180433;
	Wed, 14 Jan 2026 16:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIBRX3Gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B93F8063E; Wed, 14 Jan 2026 16:47:03 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4DA80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-38320cd563aso61038031fa.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 07:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768405617; x=1769010417; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ae1X6EmkA74e2tE9PxbxBc9mNQaEYuzVeppPQQdbFQ=;
 b=hIBRX3Gm4kSCeT+KySUEebVSs8QRRZd6ncOv8LAAwfYhWZGzZ+exMz6nsagfW+c1VD
 yT5CUQbBnXxUKDkFc1RiUArwyymuABbh2EQQQ4wx6DVpbwQYe/SbWrxTYti0b4r2vbOY
 tVgvnN1eN4uMqmEVdZ30jaNIc4O03egyrPHk2+6c4Aqpd/tXKL0d51MMek0SORuok9v3
 XmKxjbhfxgYRCGEwj6t1AYz64ZjLx+YjrKlQICGTaBUAJ3MDJ5mBrrKbj85B3UOkK4DD
 ND1sD8XiaEapAL7oMEj4VKL9b2B079bRpTGzIuRzfXQEC5tBKyZQKjAvvKcXTeB24cwF
 ttRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768405617; x=1769010417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Ae1X6EmkA74e2tE9PxbxBc9mNQaEYuzVeppPQQdbFQ=;
 b=eBU2a8fqdccWgEUbrDegEEtcdO5IX7Hleq9qqZMRt3uycC7Yi27MVApq6R6Dz4yqBJ
 PNhaWbS9mPX8rXcWZiQVbum1Gczk9wKKmI0d1KZW9eQwYJU6La0ZDaD033oeywt+uLRw
 lP4eTDBIaFywyKG2Tny7CT9W32YkjJiz0SDT3Ye3tTeAjGogH4tvp/6owbOw89g2u+Ue
 c+4r+HJ3Gi0R39l0KDF4q0W2lch8CQi6x1jNZYm3DvTM82ERxriWdOVHUCt7hjibTPnZ
 IM8NUjO4An4pzevrsAq0ITpsigJcRGmM3AZo7VHWXv3RQ4L4SuaLcN+cRDLamsRnkS9h
 cJzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCgqhQT43CbkpagUHX5NnOF76uzmI6p39Pr6BVN0gmCqn1TEiMfBSGMCDcl8yUToNdGaISo3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwT2d0pi4LfrYVA139Idwt+6Ag9IMlMVFUH73B9O+wXhgtedsTx
 F1sYbddzGxP9NR7Gx+BLF+WdK1rY7vSDaO3MsE1a4zv7r/dpRavQF4KENWsP0Qdh0rn8E+RmN3i
 CONFtdGFpXMWrHRhVTF+nNrFFTiKvC2E=
X-Gm-Gg: AY/fxX4f3DO8S5lIily+HDZUXZ0ZxDmLsHDK+7MqnqePgYflFfXPfwPUbXRvCCfr80V
 eAYBeCpbQo95/PHae/C1fvKK72Xgvc+PyIAlxO19jBnAslruMIxIEWRC3/e/m+4leyfAiEDxJ8B
 wL2sIJyGJ/+jA7Bgn6k2Laa9sFnL7TJb3Oynwxz3NPWyhoZK0R2T+xhT3MP1ulGQImmyp7gJWyF
 WMx0/V9Kg4ftFdIKhhs5Gf5WsFifTr7kJTUQ7BSNupXAh2pFPURr1mKbmfHQsjCqvig5hzT3PQd
 VzZIHg82HK2Sz0uKwv730c+x6Hc=
X-Received: by 2002:a05:651c:1502:b0:383:5c1e:bf00 with SMTP id
 38308e7fff4ca-3836066b07cmr9638211fa.14.1768405616325; Wed, 14 Jan 2026
 07:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com>
In-Reply-To: <20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Jan 2026 12:46:44 -0300
X-Gm-Features: AZwV_Qjxo2io2INMo5HZzxfTAvZMpLGvR6tRbwE22HTnYARiOx0NYEU58xMQ-98
Message-ID: <CAOMZO5BC+P5zVtmC0hocf+=Xo9nQwAcjsA6y4VtHLRAePLRESw@mail.gmail.com>
Subject: Re: [PATCH] cmd/Kconfig: fix type in CMD_PINMUX description
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>,
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

On Tue, Jan 6, 2026 at 8:05=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> Fix typo with correct spelling of "purposes".

There is a typo in the Subject line: type->typo.
