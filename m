Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85EBC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6E688863;
	Mon, 29 Jul 2024 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bwx8iah/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B30B788896; Mon, 29 Jul 2024 18:19:27 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA8E88842
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7b23793c1so19106736d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269964; x=1722874764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rZInrS6/12tSnEeFLasuPm+GCtFBxv+ey9dfkVm8LcY=;
 b=bwx8iah/RPbOCxzYLUd24ccE8E9KF9qIRRC3vzQkLR7Yg6AzAK3dMcCTfK5LWZ1weZ
 7kQf13G/VPdZq2GWcmmk6u1rmiOSd3rC1KdMl3WkGfY0wGa0elvzYklEn4sRuURidtCr
 cZQ8+u1t8kndaiAXLRSY89vEvAGu1eD0MmXks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269964; x=1722874764;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZInrS6/12tSnEeFLasuPm+GCtFBxv+ey9dfkVm8LcY=;
 b=A4skvlYxJYsW9gPfTun7z9JTQfYnDWnqz/V6ZsnvojvnG7I+Xr8Adr0mhUn11689ei
 LQr+48KqSQzulzCF4qT8xlzH5l+cIZk5seq43bMrR7/pAwWUMdXQYKOjYuoGrf2Natca
 NStbXdl7+icQ5pUyAvMXmR2K5NlLiisFy6jy/8/G1Mzk4AaVExjJ6KXJDNismuBVAXBf
 FkbJtlLOlEzuMW/oDBXATldRq/Y/w9fRCEAZXpb5agaYhMFBIdZiLNYRXj0GAc+D0FIg
 p7L4r1XPXc5gGLjkchTWf/hj8YsYmF761RGt293T7qOMTqq+hlv816eIQpHSio+4CihX
 +D7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Fad1pN3Qzqm/zh94JdiFDDm2FH6FhMlaeZDbc8x9/ig60EKhyjgZq7xaUD5B5TTwdWHDvJ7aiwYAKblMwzZaUZV9Rg==
X-Gm-Message-State: AOJu0YzSIowDSI3orUqRmz2JG9SwWg62ArZLhhXeMjP/zZjrWKQ5iu2t
 dH5thwKdRf32AWJwMN0SCiCbS+Ah0r4YktwuPvhdGkqpui+5Amd4jZ8UKOJrXTgqKJn4fp2VVB4
 647lCTem2ifj24vESTaWXxC9mu5UiET/I0Wkr
X-Google-Smtp-Source: AGHT+IEJrleQ+uRPzfBWZtuEdMjLTsUqk4h04ddvoHjwxfTlQLPm7YVxn8mBvp3WkRIVsb1sycg0tIVYxQDLAk0ZwQw=
X-Received: by 2002:a05:6214:768:b0:6b5:82df:5a2a with SMTP id
 6a1803df08f44-6bb559cff26mr99511816d6.15.1722269964569; Mon, 29 Jul 2024
 09:19:24 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:24 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-17-sjg@chromium.org>
References: <20240720104950.2730773-17-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:24 -0700
X-Google-Sender-Auth: zwAlNuMIRbC5XfOtlmig03FFA-E
Message-ID: <CAFLszTjZoCDV3zmP9UMjNbdvK+hiYjK53rLW0P6_Xr=2aPkexw@mail.gmail.com>
Subject: Re: [PATCH 16/20] binman: fit: Allow providing FDT filenames in a
 directory
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
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

In some cases the list of available FDT files is not available in an
entryarg. Provide an option to point to a directory containing them
instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst              |  7 ++++
 tools/binman/etype/fit.py             | 19 ++++++++-
 tools/binman/ftest.py                 | 17 ++++++--
 tools/binman/test/333_fit_fdt_dir.dts | 58 +++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/333_fit_fdt_dir.dts

Applied to u-boot-dm, thanks!
