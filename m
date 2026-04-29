Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4739FFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E6384837;
	Wed, 29 Apr 2026 16:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hjMrjkn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA36084855; Wed, 29 Apr 2026 16:02:07 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C0784832
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so21927582a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471318; cv=none;
 d=google.com; s=arc-20240605;
 b=MP3yTIUBs3ACDYgkvWxqh3YwEs+uROaeNDfIpukt4Z5XvxAVKYaaZE6K96qkr5u3g7
 NJ9iKkqNI90bVR3vtu2foDs/teDiha2CGnG0wtV+e1Tnn27NwqxwbU50Awwr/rEakSAm
 xCfY6KK3rECqZDjJ6cDGLNTCLlw1xe2Tu9wuD8VYLv0USNmp5gHVWlBGw2LnrB7+y7Le
 ADKwfEJf6AyoT09SyS3aCn/BrI0R5Z3bTPfmcZ6J0voUAzEr0T3MBlOVNPkz80V3RMcN
 AZaS6FKQFZjwJ8gg4iKgSo53c1SaUbyVTmdH9H6Hm3gb40QDqwO7RVoky4DR5M7KjVRl
 vxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gCxvXdPB2rgktdx24GWJxomNVjIlgnpeRMO5wWWXKYU=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=JXaRnlAGtnKnp2rpnYHu4GzL+f7Rg9Ev4aKMyLvcET8BIPnUGfrQ52194IVC6acHdB
 LS7ieeVQRXuOWs8D53X6NqSesxfG0xro7LOeDpaLrCRwGr9eLaHGXJQdmErbtofzE2V3
 mnr7dN5m+o8lGosoyzkXKoUViCaqInDS59qqrnQ427p68GitOf6tcjSg7GGUZANYqLkI
 1wSGgtkyuWrsXWRArMMd7GVYM8tDR+79KfRWk0qs7V7fe9rFSITC6BHCOSin8j7RZwYx
 x3U+Zf6yf/3Bj69HnoQ3ICyOQTM4071LsfdNViXWzn21uJnpZKX1gc9DVQumQhEBo83M
 SaJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471318; x=1778076118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gCxvXdPB2rgktdx24GWJxomNVjIlgnpeRMO5wWWXKYU=;
 b=hjMrjkn+ATOlheWSj8uIWbnmXUwoRhOdI6spHgPlx4nCNNWt2PvQWCOCAH8RjvUYtg
 jGDMaQXXDWmTfcxe6z3se4pbcuG5xVLP0sPi9na1PxQMCF0uemdtt/1QmfLcjyCsCIhr
 5U3gmx0uoMjlJ4EVrMis/8zm/h9y2hitsySwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471318; x=1778076118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCxvXdPB2rgktdx24GWJxomNVjIlgnpeRMO5wWWXKYU=;
 b=if8GAMcEjH0RPtnn3nBgSe2gObxIS6FDRrLWvxdnPP2vmGnvCoXYlkvoGAER2k/JC+
 WRCq07YRR8EzrrHC0kJB7524nyUzoINamywDVHJdU0mJ1/YtsUADfyV5B1XgU1FReDUE
 gpF1O3GBc7MTEpoguLboZyCq6ftCLOgSouwnwQpmnodnqRqtRhJhf8YBuPLYYk10rh0I
 DhsaanJWNaLorZ5nWgiHhklgv0q1IRsgCcVRQgpb4CRxCBLPkVb0RqmqdNTXpBb4U5P5
 XhsJGTCT6Hv7jWpDglFX2FxHdKXbf4upoUoJMPIXlK9mAOH/4VRkei/x1ZHuixqakuM7
 WF9A==
X-Gm-Message-State: AOJu0YyPkBWS1HM2wSkmcJfgkOsqzwninQIluaclIbwm0A0eSvq73Pir
 9jvWSjZ+u1YNyM99IDmHQJb3a8/Jit1UwNfUeVXVCrASO9qQBbGlmM4dQSH66i/dfLNxkASCkVt
 fvhaGmD06hUDC6jsjRbRv2MVaGRBtmDo1UfzAj1aU
X-Gm-Gg: AeBDievo6JPr6d9GDWiK8T+8gKLmSIZB5cHMSPC/fn/y2y6jfqVVEVxDsgsMmAgsdbA
 OzDG+haajCqTSGYRhFa2nmVhlVM6lKcV5C1nU+ZUU0ecYxoyyCr0BQ8FL1D4kPREdVyduWPjYvp
 WApkuHBMkYHGlnDsFa6uJP4KwrVeJ5ihaVbgb9d1rH8QS5uccMzS2Iok1kiyklz1/Ja5w1Ay8Kb
 /BZCVG2pPLmfIUny+f17yR1uxaoNXn7UNwV7V1o2m0Un6LfxHCJtlgYpzVStghDDTo2fdQ4QeTy
 IDHpWrfXRHJcsfGy
X-Received: by 2002:a17:907:3c84:b0:ba5:885d:3280 with SMTP id
 a640c23a62f3a-bb802da6a6cmr476334366b.17.1777471318192; Wed, 29 Apr 2026
 07:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <d86949c4ae8dd1314af7537c5799c7b92ddc17cb.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <d86949c4ae8dd1314af7537c5799c7b92ddc17cb.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:01:45 -0600
X-Gm-Features: AVHnY4IZzk4jcHTrBzmU6oyZTUhpMqhRIjd-ozywll9MweLpefq9PXHA_qSq4Ko
Message-ID: <CAFLszTibcikiRP+_4WDFqLWPWPY7L-b2QTiXdUzX+X0XhkKHsA@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] configs: sc5xx: Do not store environment in SPI
 flash
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> configs: sc5xx: Do not store environment in SPI flash
>
> Remove config option enabling storage of the environment
> in the SPI flash, to match shift of programming boot media
> to Linux.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> configs/sc573-ezkit_defconfig          | 4 ----
>  configs/sc584-ezkit_defconfig          | 5 -----
>  configs/sc589-ezkit_defconfig          | 5 -----
>  configs/sc589-mini_defconfig           | 5 -----
>  configs/sc594-som-ezkit-spl_defconfig  | 4 ----
>  configs/sc594-som-ezlite-spl_defconfig | 4 ----
>  configs/sc598-som-ezkit-spl_defconfig  | 4 ----
>  configs/sc598-som-ezlite-spl_defconfig | 4 ----
>  8 files changed, 35 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
