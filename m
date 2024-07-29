Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28078C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F164788853;
	Mon, 29 Jul 2024 18:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hWWM0erY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4DBF8855C; Mon, 29 Jul 2024 18:19:23 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519D488863
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso19793146d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269960; x=1722874760; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bN5gG8l5CEbui/3OHRyjo3IsQb3nyMYaDfF/U7K44kk=;
 b=hWWM0erYMYBKLoRmSbebbHqgpzbi6dQo16WcDN4ASg8wrPMDUJQ6shfz+5HMihFF0d
 3ufvsjRc8R++daYoIjyKn2gFPNiGprb8z0xjnoNTVEoVj/aHWYZo0EPOUWhLATiR80+I
 pANqlBWJW3P7yoiXzFEaeXY2bFKrfpZA50YF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269960; x=1722874760;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bN5gG8l5CEbui/3OHRyjo3IsQb3nyMYaDfF/U7K44kk=;
 b=cmlWO+g3qgtO0SGfTUnxDM26T/K4rwZG6Cr4VbZ5S1stMtFU7AGpZY45zKJDmhMga4
 Jh3i4JCs4gimOG7E1oeg2nK4Z/eeiAiHcXW9ADVDbfDNp0LZc/qAL5y1ZmZjK1rkmCVz
 P3gjE6fvEp9MZItBvieii9UDOGUF0hC5aXSebnz/zKuftVqzrFISZiG4mnFy0HAvqcek
 /C83Vg4AqU/Uk0Ugw+PWLlCSwa7zHWwWhnxcNACAN/PUW9H8jw2SXkouhr1IESS9nwGU
 /MCneCxL0KFD/OaHrw+kzaIJOhdXAKvZWHU+1PbXPShoS3yDUAhGpubPKHYLzDP4vcS1
 1AEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5uid7yebDyeZjbo/31hyrRdppRPcCnaFsgzzw3KaGPbcCFnhfiKKemdKnOvYjv7p29t7WEeErM2TPUQjzLECGrnCiYA==
X-Gm-Message-State: AOJu0YyNZanJTxn6S9Ud/YHeE8RJjG9JDT7zDyNJboy937LaneAqa7qu
 ddSvDXUC3IrFwifsQczTv851yY5Ne1j54A4EoM9psj/cyE8MFFY0aoJqCAFB+dRUguvOZpf7+OR
 mi1hv7GaZbdcpZ8hi+NnE9L8hzS7fFxNLAcPX
X-Google-Smtp-Source: AGHT+IF58xvI2wOxEv2Vsuvlhma/gWlq1MOgDr7gEvm4MjnkAJ72oTuyGC81meK3zGh8VKtHyU4w6ITF1P0RAAURczQ=
X-Received: by 2002:a05:6214:20ee:b0:6b7:9ebc:308a with SMTP id
 6a1803df08f44-6bb55aa50efmr61106976d6.43.1722269960128; Mon, 29 Jul 2024
 09:19:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:19 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-18-sjg@chromium.org>
References: <20240720104950.2730773-18-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:19 -0700
X-Google-Sender-Auth: iSsBB2te3b2QGQaIGLPKa9u1Kwo
Message-ID: <CAFLszThhXgMBHh6N0jFUbBvWBigO4fY+a7TXMoDFmmg7DJCQmA@mail.gmail.com>
Subject: Re: [PATCH 17/20] binman: fit: Write the compatible string to
 configuration
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

FIT allows the FDT's root-node compatible string to be placed in a
configuration node to simplify and speed up finding the best match for
booting.

Add a new property to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst                 |  5 ++
 tools/binman/etype/fit.py                | 12 +++++
 tools/binman/ftest.py                    | 55 +++++++++++++++++++---
 tools/binman/test/334_fit_fdt_compat.dts | 60 ++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 7 deletions(-)
 create mode 100644 tools/binman/test/334_fit_fdt_compat.dts

Applied to u-boot-dm, thanks!
