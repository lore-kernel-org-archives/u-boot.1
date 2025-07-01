Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAE8C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 01:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C57EB81FEE;
	Tue,  1 Jul 2025 03:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="je/TLRPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23FA81FFC; Tue,  1 Jul 2025 03:46:47 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5A78006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5551a770828so1938869e87.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751334403; x=1751939203; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pc7xZjuE/YaJp1tFjaaf17H74tW/qkC1mfL4LqsZ06A=;
 b=je/TLRPmMaAlIOYwhXJ3x7alpmcwkppRBFkSo9m++BFdyZAR0YmLis0iK1QDM4ia/G
 l6P6LZQppOznj5xTY5ewPPNWVh9T98KtqPKuH8I8SfCfEHsuweVER+9L5ExgWDJJ43Nb
 /I64GEdoWA/s9grolYzWcrKuDmdFRz24EmZDEE9zYsiLpVHXJ9XQzzRone1hcfiP7ccD
 F50LNRURN+wJRgKPDWHg7fKFTSkRdbsjCAbIJJutCgOQksVF1ljY8nvTzwMoaaVnczeC
 K4QLuKeepAiSEjetgTvWnxxh66M7wK4uwjpBKMXH6YSZ9HnV8o5FOdDQWjixnw/xuQrz
 N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334403; x=1751939203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pc7xZjuE/YaJp1tFjaaf17H74tW/qkC1mfL4LqsZ06A=;
 b=wIou/QzJ6dxx46FQEFYDKcraiYBY/3GZu8YWtM1KFY1fCYKusLpv48ornA+VJqY1A2
 SCHebzuaUSqZz0KnZ+pVB0O4ntANjgOakv9WPGAGlnZhbMyklPdNrwDdd9b2hhjDsJHM
 6ljE3OOWWB3IVND7ZlEAY7A/dzx4BYFtlfLpCIxrRZHm6LKNqEKn+8X3CZNwWoOI1+ei
 ZDpdb6WcrHHB2oiE1ZytxXt8Nlj4YTQ3PMlXvBg6FwQCjxXql0VGdurN3cNdrdSOx37i
 M6Wp+Iea704f+ZI83epu+PM+Ath92vA6BldixqzfImpt50M5XolmDgTMcmBjdWtD9bZy
 uiqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo4nTTwnWMRnwpTCVeOmxwlcadOJ3v3KY24F15OK4O+voD0+SLbDxgKsZzJTxS0Saz309zhsc=@lists.denx.de
X-Gm-Message-State: AOJu0YxCoac9x1mMvd86TCx2z3EVVilXe+pfzenslGFM7luF6FxRa8CQ
 WPlRF6W2q0jrlm4iik9U1gtBKTTG7eqXDi6fznhw+BOGA4T67s4eRSxJuwge/UaKkjgWPYdzZbg
 jrD2Tfi9i180ipw4zyEl6qgT11yEBMPI=
X-Gm-Gg: ASbGnctolqwq2ARb2blMnNHWsA0/QAMbiO88VTG9Z1MpuKe2O3lDXwM8doIPk6GZdJ2
 jvfctwf+4VRZDwt6tECgFP/M7CaPlF06fFetZ6MXOpFevxgN5KJiPPr4yfJKqf1WbB/g7RbE/mx
 b2/cepRntHMuLjrZ2ZTTBAKpx4ZFGkZk3qr1h1Vhzrthq40Y6og1ig7u09naotb9B6mN5eti8GX
 CI=
X-Google-Smtp-Source: AGHT+IH+rYLvWSa37lKw1gDmH4HWsbEs7LjrGzQPowgoXCEg85RBtGL7KJtAnSbm7gwvduCo0bobsobYHfAJOEUIcBQ=
X-Received: by 2002:a05:6512:224b:b0:553:2357:288c with SMTP id
 2adb3069b0e04-5550b8802b9mr5508887e87.17.1751334403100; Mon, 30 Jun 2025
 18:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5BZR9e2EFKJho1QFM4B96L9oCKf=3+ZohfYujh7iFzUsg@mail.gmail.com>
 <20250628221944.2412860-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20250628221944.2412860-1-giulio.benetti@benettiengineering.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 30 Jun 2025 22:46:31 -0300
X-Gm-Features: Ac12FXzBjnoIjLuVstoTwonvAutRXWowseZtYKToFk3sjAZFZLtAp7132rlIxqc
Message-ID: <CAOMZO5Cf+pbKo+zAO0FfkwoAi+aHYYHi_hfCiXF8qdq7jx=KWg@mail.gmail.com>
Subject: Re: [PATCH v2] arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use
 common gpio.h
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sat, Jun 28, 2025 at 7:19=E2=80=AFPM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> The current file defines a struct gpio_regs identical to the one in
> <asm/mach-imx/gpio.h>. To eliminate code duplication and align with
> the approach used for i.MX8M, include the common header instead of
> redefining the struct.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied to u-boot-imx/next, thanks.
