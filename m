Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5A2C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B324888A4;
	Sat, 13 Jul 2024 17:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+9UZgTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1168884F; Sat, 13 Jul 2024 17:14:19 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C18F888A1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70af8128081so2311424b3a.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883656; x=1721488456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gwZEgIfkeK8udQTdpnbmNGqIjXZ6Z8Tgdd4j9sy0o5o=;
 b=A+9UZgTlGXpT+2CUPggeKjx38zf54n7yEHpA9xZo9RqJRRUO9Sa/VdDikc/doWAwPT
 vK+zWM2dbOl1IW7KRf8UHR4WdIBKcjFzOpsYhH0Gi1n1sKPQrXEOP0sKMwdkVPgIOYgu
 3plMGFkEb9joHNq++tAoecAu4x0XUOUknas9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883656; x=1721488456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gwZEgIfkeK8udQTdpnbmNGqIjXZ6Z8Tgdd4j9sy0o5o=;
 b=dGQU/M3mNf/+W9Unu4sUfUXHhhRuB8VRJbW/jxdF8xZqijkfDzh1/mOs//UDvtXUUR
 48bJT1vnYH4mTUEUt7UMbpRt5TriJS3LU+kwF1QBIvp8myraAr4/YoNpPANS8VzsyLds
 bTXWR7RwtZP5BluBZCBLMxchEKwsX08DGJcD/hfI/f0A5WbYVHpjujZPRSm+T1WCnyfN
 n15XXPsc8RJc4pJ0H6eO0oxSUbMu3gU/P60pWE0WbAntOstW0da+anJOWM3oaXmwK8bI
 sJqbXpqMbxJ93cRcIRZSJFMjV2DH26d8iTROGiuDXngJ7ddxQH+Bs4te/L9NJD+4hmyb
 kz0w==
X-Gm-Message-State: AOJu0YxO9oPmcIIh1mD7LNt5ZnYmsThqFkkqNkuaKk2/k2lX8Zu/FJCW
 Xw3j5XqqBZ9hme81A6M9tIwdI5i4lffX6uWXqt/vm6DScujBFLGV13GtHsvNR79z5cSOqxI965K
 eji/dYuSvhKTn3jDuGUum+bhF2/q5dtOKo/d+JLhlkkGcwVw=
X-Google-Smtp-Source: AGHT+IG9OSHmdIl/xPBaDtESlcuLjlVgU5EjaCXecqTuqKpmiCJi89QeE+Nmdd6RMLs4L8s8c1BrwJ4H9pLr3DYK1Fs=
X-Received: by 2002:a05:6a21:9997:b0:1c0:e652:1b2f with SMTP id
 adf61e73a8af0-1c29824e443mr16638060637.33.1720883655696; Sat, 13 Jul 2024
 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-c68bf542-baa7-4122-858b-c6d5ef8bf843-1720619007870@3c-app-gmx-bs04>
In-Reply-To: <trinity-c68bf542-baa7-4122-858b-c6d5ef8bf843-1720619007870@3c-app-gmx-bs04>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:48 +0100
Message-ID: <CAFLszTiBhrQPMJNS8sjY-jnq8TFnqdWxutyU2NXPit2RZJczhA@mail.gmail.com>
Subject: Re: avoid syscon fallback class for getting regmap
To: Frank Wunderlich <frank-w@public-files.de>
Cc: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>, 
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>,
 John Crispin <john@phrozen.org>
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

Hi Frank,

On Wed, 10 Jul 2024 at 14:43, Frank Wunderlich <frank-w@public-files.de> wrote:
>
> Hi,
>
> i'm working on OF_UPSTREAM for mediatek boards and noticed missing syscon-fallback on some (mt7988) devicetree nodes.
>
> i know that u-boot uses this fallback to get the regmap shared across drivers, but only initializing once with the syscon_uclass.
>
> i tried adding the syscon-fallback to linux device tree and got pointed [1] back to uboot to solve the issue there...
>
> are there any ways to avoid syscon in device tree and get the regmap of different node?
>
> i guess i could use [2], but then it is possible to aquire same regmap multiple times which may result in issues (e.g. race-conditions).
> I also want to avoid creating multiple drivers doing the exactily same thing like syscon.
>
> one easy (but maybe unwanted way) is to add all compatibles for affected syscons to the syscon driver...but then it is no more generic (baed on compatibles then vendor-specific).

One option is to create a new driver in a new file and have its ops
use the syscon ops. See for example
arch/arm/mach-rockchip/rk3399/syscon_rk3399.c

Regards,
Simon
