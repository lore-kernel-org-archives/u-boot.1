Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530E6D60D1B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B028489548;
	Tue, 19 Nov 2024 11:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WFVlEVqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EECC8954E; Tue, 19 Nov 2024 11:18:04 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C64988E5C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3823cf963f1so1658785f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732011482; x=1732616282;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Q2R1FVRc58kit64B4CWcn/ODtKazHZVF9HxpGMd1Vk=;
 b=WFVlEVqNKN9udzVeHevsfag/HYtw/eTRwnDJnUrwzQutzo2Jnfw94mSjAXpIy6EWoI
 XKdWLPErRBzTXhkX7Dgm73ju9FYMwT8TRloT6Mg3YmE8KD19D/gr25kR5JrZJrbtM9sY
 5w1vRqFouGmpC17BIYufFQwixCRJAzYnB02+bfDimgOFRat4xlVu+peksYgEUVGPK/SW
 6LcmUpcLLN6DKWx8XTqh05vQ7YdThbmDp8Hx3QSZKaL7T5jXdyzYqG4lVP3j8nzBfJah
 Xa59wmhSPCReOSNwfyIcVDuNencoOP4zwyCp9pyb5SXF+AtvcNdRdgE3p+TwsMEPX8cr
 twsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732011482; x=1732616282;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Q2R1FVRc58kit64B4CWcn/ODtKazHZVF9HxpGMd1Vk=;
 b=GSmXwwStEs25B19hIwzGk2RxMHYDyI4MxspKQaGSmlbLuttiK+RUi48spVbqWZWITo
 MDF36w7YlipSXIk4RAniC6e+8UtRebeNqen+RumfIPKGa2nb/MZdTpTfIyHuF5AOylUt
 1jIfwEUYPSYQ1IkDtAGwL/eXdjPF/YhtLyZuqFYMXD0i0Thgwh3JkZqXCMznxistKpPs
 wB4cvzSDNLkd9p6n1+IRTO2CDKtEIv7+tS1CdsMmOLmpeupdhigfv/nF3ZcTm+94hUHT
 t3E9yXwtJgnRQ9fKfkUMYvVHB99LQSi2b39bBbAqEU0ax7FdBSGd5+L3yZBBYCkvWA8v
 cihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpdCMw8q7pfbQ+GAYx4VkA12tlF2hLFMeryK4kFZuuXX6Dr7QZja/NWXZoQ4Yu03YOQsIlWjU=@lists.denx.de
X-Gm-Message-State: AOJu0YzgswHchDvhGuDxexXfU5e6gotkGxlp/8jvTGlIvAdcZTfbaC7G
 qc50fB8TWLNelftr+uYT4p8QP6Bd9+fkWC3bw2ILlRUf/tUFFgGTwervImBVPOo=
X-Google-Smtp-Source: AGHT+IFAulfPrHbBs0dnO8WchmigaP6MndegB5MPM3HHtXA4RcmdxIVS7eHuvvcKdVbk9sDB3qblsQ==
X-Received: by 2002:a05:6000:1562:b0:382:2a2b:f81e with SMTP id
 ffacd0b85a97d-3822a2bf928mr12817421f8f.51.1732011482130; 
 Tue, 19 Nov 2024 02:18:02 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824770f3dasm5680944f8f.54.2024.11.19.02.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 02:18:01 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v2 2/5] bootstd: android: add non-A/B image support
In-Reply-To: <20241114-adnroidv2-v2-2-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-2-015bffb1373a@baylibre.com>
Date: Tue, 19 Nov 2024 11:17:58 +0100
Message-ID: <87y11fy1bd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On jeu., nov. 14, 2024 at 22:29, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Update android bootmeth to support non-A/B image.
> Enable AB support only when ANDROID_AB is enabled.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/Kconfig                     |  1 -
>  boot/bootmeth_android.c          | 51 +++++++++++++++++++++++++++++++++-------
>  configs/am62x_a53_android.config |  1 +
>  configs/sandbox_defconfig        |  1 +
>  4 files changed, 44 insertions(+), 10 deletions(-)
>

[...]
