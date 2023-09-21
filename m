Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C56CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D909C86D25;
	Thu, 21 Sep 2023 03:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ubjdkddf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60B586D44; Thu, 21 Sep 2023 03:06:02 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D039086D1D
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59ea6064e2eso5589187b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LInRrprO9M0Fwwnl+GVZa6Zg6CvfEdCFXZtcLjYUS18=;
 b=UbjdkddfBb6eT4lciOZ/9/O7aclX7Pnaj+lNnPmaQROz6conaVoL3iQoA3XPV3vO69
 MMUD+eK01j7fTjcydsmzwvWFFHO6qYD7M5O7UHQ/vroLgs+I2xDAwFa7mAukhBz58DnU
 uKETbUWeBlUpKTylKMTUahMTzRmdFTkpMRNYFzT25IhB9/SB28EsYTWBcC/+8gZRQkom
 pXktEipHuFN9bjVCQiIXRtX4E0MPwJZYmRjg7+uRo03WK2nrnvMeufZ5DCHEhsoHCBiI
 XwYUxuXCHsC8mRwpMRTeEXKOEg9MSnfANYijfqWc53fFzIkZsvQr0XmCfO3w7O9Jqypu
 IdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LInRrprO9M0Fwwnl+GVZa6Zg6CvfEdCFXZtcLjYUS18=;
 b=K5DQmrjerWY5IlIVLEYMoTSaQQBSxJK0+A8s21ftc8lL7sjBPM4F99bVBEURuwi9oZ
 BIq//lq9nEaLQcd2eNo6O0vxXOOuhptcTOvB1mgkovrF6rbgLwHFKJbCeG1ut04DaK7H
 3Yinq/hrgyRjpv/M3Y1dW+ozTEwoJkYgLw0OZBWGNtFzboHVfQoj5oq+QlPQ8ETnSvZD
 pyoMvQhUqhLxm1y/ulEFSZxAFXTncPm0c/p0S97CMVfzZPHJ1sPqndIGcMVf9NuJFKpJ
 uqHGfRQXpngrIxgISZ+Lzzxgot5PTYNRMPGwThklhcOm/s1dcj4Mj20/21tm9GxwWcFo
 15/A==
X-Gm-Message-State: AOJu0YxfUFEhsrmtkeph1AOyb4HRSDNuJRayp+AJRVpOxcX72bMg3S3W
 C6i5jvC5xgkT3QPeFFFz3Ckz6z6DeNIXaOoCVVq9+w==
X-Google-Smtp-Source: AGHT+IFgsj3tKt0jo+XmNzxPv8d6K7FMQBWTJFXMDnPX5dD511/YuPXgm9TmALGQNlyLHAdv+zHiNETpAwZFjyNvZ2g=
X-Received: by 2002:a0d:dfd8:0:b0:59a:b7b2:5f02 with SMTP id
 i207-20020a0ddfd8000000b0059ab7b25f02mr4227176ywe.18.1695258357413; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-7-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-7-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:12 -0600
Message-ID: <CAPnjgZ2WSTE46=pA+44nYB4BmtyyTYkRU3WPxguEfsUxpFnRFA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] drivers: introduce Meson Secure Monitor driver
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> This patch adds an implementation of the Meson Secure Monitor
> driver based on UCLASS_SM.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  MAINTAINERS           |   1 +
>  drivers/sm/Kconfig    |   7 ++
>  drivers/sm/Makefile   |   1 +
>  drivers/sm/meson-sm.c | 198 ++++++++++++++++++++++++++++++++++++++++++
>  include/meson/sm.h    |  19 ++++
>  5 files changed, 226 insertions(+)
>  create mode 100644 drivers/sm/meson-sm.c
>  create mode 100644 include/meson/sm.h
>

Reviewed-by: Simon Glass <sjg@chromium.org>
