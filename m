Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC1E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF4B896B3;
	Tue,  3 Dec 2024 20:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LDlYRjYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44978896A2; Tue,  3 Dec 2024 20:39:52 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26702881E7
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so332638066b.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254789; x=1733859589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BP+v2fIT98WlmbEs14LWHTvLEq3zgiWqTlXmfw338gA=;
 b=LDlYRjYeiIE2JHdyYw3AQgCx/XMx9Hj8RaPq+Jhb5gKTlzM6rjOjY0qMb42tQHrGVC
 UAD75Pv1gCkIa7A5SLNGOl+eCaBdg9mGNEDEEwtMqoD1hS1GyOMt42rJHlnEwFyp7AH1
 7XLcDZmag6zacF7ruqez8tVQ7wqM8DOzmKIrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254789; x=1733859589;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BP+v2fIT98WlmbEs14LWHTvLEq3zgiWqTlXmfw338gA=;
 b=AUHYXvMBaBFUXBrW+n96mP8voK/kq8cCMhMv4AHoMVIW0IRHtCxRKNgey1o1XWH/b8
 EhhkAuDKKRYx4eX3mQadxILSSLCsl5u3B44YrwoyLGrdzr8G6/AQicyCmVlo6G4LP++O
 5TXHB0waBmhT0ZdN5AygbG/vnuxTXDKlV1faV1wirjjlAldkEzj5QD1OYppEtGpK+gxK
 2neCVMOL3tv2Aukh7eIeF8dKBrQLme4EIhI0xxB8T0Bxeef51cYKU34elikjv7e9UsHM
 8M2r9duk/fscSecd7OYjHL7jhGo6tK4n8N9wKI0ycZKAE8Eh7BcMccNgm0Sb8yd2x+yg
 fE/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNQUzl+Zi1wnMYuXK2+cY55298R5D4aVGJmZ++6tWPSzMiiQfXTDF+0uKBQnrat7IlDBZOLr0=@lists.denx.de
X-Gm-Message-State: AOJu0YyYeCFpFV60MjkKRWFZB2hQ3o93boJ/AfWfT+NddtF9MLtbA36m
 WBX+znwi4jlIr7Z2cZO4Y6yeR7Wleuu8GqOMAzhSFSSI/H/5f5zV0XFecUo3EcomyB4u3rsQJQR
 hkyB17kXjSSGSfoeW05ebxlGC79rmr5lloAP8
X-Gm-Gg: ASbGncuqkSAP4LqKv8pa8KLqaLuRhySmM6mnIrBImYIh44Ag+/+pB8FakduHwxmsHdf
 RbPgARfCzlosjd5jRtrt8AWmLOLsZdQhE
X-Google-Smtp-Source: AGHT+IGdNQwg6EUOS1YwcP70sLppl2bpid/1MxYUL2+D4rrCDsXRD1zS4zeZVjpuICAzlLm3eQT5EVYaNrf85QkjPOs=
X-Received: by 2002:a17:906:3d21:b0:aa5:46d3:4d88 with SMTP id
 a640c23a62f3a-aa6017e9a6fmr163791966b.15.1733254789669; Tue, 03 Dec 2024
 11:39:49 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:47 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-13-sjg@chromium.org>
References: <20241103003322.626036-13-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:47 +0000
X-Google-Sender-Auth: TryGltLKcJNJNGAwBO2bagzLGJw
Message-ID: <CAFLszThp8k22iZhT+eSKZn_xQV698MwQAeEC2GM1Vrz=E_-78A@mail.gmail.com>
Subject: Re: [PATCH v3 12/25] misc: Drop gpio_led driver
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/misc/Makefile   |   1 -
 drivers/misc/gpio_led.c | 106 ----------------------------------------
 2 files changed, 107 deletions(-)
 delete mode 100644 drivers/misc/gpio_led.c

Applied to ci/master, thanks!
