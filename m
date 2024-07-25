Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF495C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AAC588297;
	Thu, 25 Jul 2024 22:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="tR2ux5/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3DD8827A; Thu, 25 Jul 2024 20:48:34 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD48879AF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 20:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d1c655141so184881b3a.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721933311; x=1722538111;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KB4sj69c+3vISaXqXECkRRj94I6vnP+vrne54WOfvz4=;
 b=tR2ux5/Nyez7isi9sce4Wj2bZFMxyJUxhdtr09+/YenpeXWE2DE7FAUxo97X33XrPa
 ZC+lJQBfO89dKLy7AFnFN6XF+uUaysw5Nve6uerOMnYt1dSn2/0guS4zq6ss5VkPg57a
 F5RYlrRiq+gmzHNlOrpgcRK4s17HV+xRq/vCsykm39lsES+tyytMifpAOhsHes5V8mTb
 ZEZAGSwjuJgtYYpVcX2P4PmPkDmWqLOQRUqlnmbMN5hYw0l9Iju+cg7BlpiByC5FQX7x
 3Yxgy6EcB3MPcnUaY5gS5jRRIpXtAx1NOBQnG3loSfTelU3jO/4WddapS16DgXMXf3Vu
 HHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721933311; x=1722538111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KB4sj69c+3vISaXqXECkRRj94I6vnP+vrne54WOfvz4=;
 b=XPVEjGspWwaABm++6VeEMkyFYqBoDHAMW9QW1zKcqNaplFgb3o0ySgSdEqRh7Pb+4o
 0oXATuPltMScazSlLaD+ZrkwoylD6AArEyTqbb7lDG9ZbCNWP6dOzLgE2SuKXmJW1ZGt
 dMnD5Hnfgr8jYXu6eEBGwprrvicc4iqJhDzTyujC2sJ21ZkvbLnhOWNz2SO8Jn65/tza
 1dncJOxMvs/s2bT/K4SZnP5rpHtIcXfN8gqfuAwtO76XwvgLP6d7KT1c8YSdLAp3XfX7
 h4UveYZp+w7fvQsh3FN4EV3xbhEcvGxj2zqES0fHtWJ5PCWtT+OCxUGb0Yt9cWx6+LwL
 Kbjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxVtIbGrTDyN1Y+0vexqYKRYQJBahPCzgWfzlGFmzzCv7Mh+kF9GNTDrUqii41rE1nkU1xCr4oy982BTYBeBjr14ZnHw==
X-Gm-Message-State: AOJu0YwwSy+/5tIXEs4b4zM0ZqQLK9dIDKQxGdjWchqai1xAhfTbpg5Y
 zF1e1NjPHLinuCgnnYyTcNXOFbF0crs+oMe7YpRE/3vZtxmxexjPM7q1L9d84prli12rNRFBKvE
 imGGog6RHNK/Nlr+Dn0nlE9AbhYqlVZkRhbYg/Q==
X-Google-Smtp-Source: AGHT+IGcYwa9f/iYWaTkJytxFbY+/a/9Xl7jpwGJ5E/YBquPbjMdNKZ0VGrfLrZ8wvzPyE2LoPLnuphPKHEsgofBEXU=
X-Received: by 2002:a05:6a00:13a0:b0:70d:3a27:54ca with SMTP id
 d2e1a72fcca58-70eae963bd0mr3571380b3a.22.1721933310744; Thu, 25 Jul 2024
 11:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240725153204.358925-1-admin@hifiphile.com>
 <0e0a053a-56b8-470e-98bd-80e61417e5df@denx.de>
In-Reply-To: <0e0a053a-56b8-470e-98bd-80e61417e5df@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 25 Jul 2024 20:48:18 +0200
Message-ID: <CA+GyqeZURHRsM3MZcUzY3+tyu0SeBM7aPbYd48JmSxqVuuZw=w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] usb: gadget: atmel: Code refactor and
 DM_USB_GADGET support
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Jul 2024 22:55:09 +0200
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

On Thu, Jul 25, 2024 at 8:24=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 7/25/24 5:31 PM, Zixun LI wrote:
> > Changes in v4:
> > - Release clocks if probe failed
> > - Add missing endpoint data free
> > - Addressed comments
>
> Please collect any AB/RB/TB tags that were provided in v3 too.

Sorry didn't know that, should I spin a v5 ?
