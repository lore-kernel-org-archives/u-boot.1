Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD9C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 12:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FEE88A47;
	Thu, 15 Aug 2024 14:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gDkZjzIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E050388A54; Thu, 15 Aug 2024 14:27:18 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C9E88A39
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 14:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efd91dd28so159673e87.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723724836; x=1724329636; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HR/4/rv/EPTT+dnTNJyLyQEi0lLou8Zn/kKFh3OihRU=;
 b=gDkZjzIQt/Sw0ipAZkTmKnnDftCerH+sLITvyvx4S3xV8c04ZgvI1A0U+NGa2aPpdk
 umEpCpb9wPwJIwfZ0TIieUWSS132cj5wU9llM0ByA/mdjR52W2GmGuHl6euwCFZc5dJD
 rfa8gjQxFg3vQ1/KV5aU0KUdWu4XC0UL536iH6QNd65Nq+WxWuvK/pJorTj7xTcoK8H1
 OuK3O8n0I66oKL1kfqWSzBB9DE7wINmRRrFrtEbVYbRUHe5KHgV43RAc0b2GzaFNGfWV
 eFj7RGY7WVoYBiKgVKqnKblZB86ZggwJ8BfGgi0sBxJnimXnNbuTPaHjKN4oLR7SVUXP
 tgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723724836; x=1724329636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HR/4/rv/EPTT+dnTNJyLyQEi0lLou8Zn/kKFh3OihRU=;
 b=JDU0y/Fg6WFsGz+pM3aigS9RQLWljD2BRbj4jHE6dEGtK6kEHS1vGLkI9eTfA8F93p
 gN7pM/YEhpprxF+r6yZnaWXgSgYe39LeaF9g/YWYM49ejuEnkwTCJdBMB8eZUpO+3+B1
 V9znM6NhkJVCZedj/erWTvAVmoWouOaAwy/MNwe7wL6zmHA+ik0M7Ar6ARTlp9CoFHqZ
 HmpMeTng2UXdLTy57+p0rv999wTv7bxP1Xmx3B2NyT/8+fxaYTG4oXNhBC+NSE2FjDAS
 jB99nvroLR5PDhDmCPNsNETH5jFy7nBLhmIM5NxTKhTrYeP3mSqSHD4QEn5CNUyabLsY
 uoqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqi6GGu8m2hCY6cL71q4bIz6t/V/BB/hw8tKHYD9f3twUlwEbjLWNAph9gYvhrbbFy8OdnDjc=@lists.denx.de
X-Gm-Message-State: AOJu0YwCYIsIoeONEYFyLLT12gZwgGjTQbC9m9GdQDLz5rJod06V/Hvg
 VsH7/exYkqgdnP4ipQiJVtNxQfodtr9qIfyn8qgEg7UpY7ugKhfrHQn24EMXj14meFwg6G4Cq0o
 b2Ia4RDRe36QJDRNC51SsHBsmU5E=
X-Google-Smtp-Source: AGHT+IFG+0Tz88ulc1BPpsuL0Nyb0dILJsBxxzSqUekAWuLySfMpjKmdnTbWvdz/M3v77AfvmQRTmYXJbGiBiE2xIU8=
X-Received: by 2002:a05:6512:250e:b0:533:dde:bf07 with SMTP id
 2adb3069b0e04-5330ddec7c4mr800169e87.5.1723724835814; Thu, 15 Aug 2024
 05:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240815082422.470790-1-lukma@denx.de>
In-Reply-To: <20240815082422.470790-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Aug 2024 09:27:04 -0300
Message-ID: <CAOMZO5AOMwrrsQkwZPeBdGH_EU5H5VK31DBjJa_0WqLShQypVw@mail.gmail.com>
Subject: Re: [PATCH] dts: imx: Enable USB support in
 imx8mm-phyboard-polis-rdk-u-boot.dtsi
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com, 
 Cem Tenruh <c.tenruh@phytec.de>, Tom Rini <trini@konsulko.com>,
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

On Thu, Aug 15, 2024 at 5:24=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +&usbmisc1 {
> +       bootph-pre-ram;
> +};
> +
> +&usbotg1 {
> +       bootph-pre-ram;
> +};
> +
> +&usbphynop1 {
> +       bootph-pre-ram;
> +};
> +
>  &gpio1 {

Please try to keep the entries in alphabetical order.
