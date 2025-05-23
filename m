Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A155C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD12833C0;
	Fri, 23 May 2025 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DkKiQD0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA39830B4; Fri, 23 May 2025 15:19:13 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86EE830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so1540055966b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006351; x=1748611151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IWORf89jG60mU3pGCFR/WwSYWVsUscXTmukKY8z74SY=;
 b=DkKiQD0DpjtX1bWTytyCPCmHOJXEd5x2ggbVaTDehCbfUaGFCeleeIlPS8K6jTMJFb
 7+jItYpu/2dXIrbwWElBl4FUr+Pp3+leyIaH1BRJcTTfagG1RHwtwZnf506wcBd6k9yB
 6ECrGlJGLsfK6sv+J3eDVu8rIcIu54EuhzU9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006351; x=1748611151;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWORf89jG60mU3pGCFR/WwSYWVsUscXTmukKY8z74SY=;
 b=oQghP/P6XQ6ZdKbCUU+HrAUAocJw929o4x8usqZ2SlQkLkNd9IRMVTRy5V4uM85WlR
 Asy29p0TCDK8004lTRav8zUGlfEj6X94feXnr47XvCv7ROIuUa9iijz2NanUXO0EJ+L4
 2wpf8m/hYizOm4n16ww5CMQa2PYq7RqR4sqBgDZN+eczMn3aUxl7E6W42jEPla1mlU2f
 hFm8+JzJVjB328ibJ5Nwo3AwGsbeBjJk8jr8wo5SUcCh7kFyxnZuToZ7EHLb+0dpM9bA
 vS/M9gRaem4QtfzLmRZ+EcqZ8pTBRmHeeV09roV1bfLw81/rbjwCJ/LhSCRuvFTh74Jn
 7d8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaShsUrXSNEepsww5nenmyaPzKpduMUHLG1ZDub3ZDY71biA3VlPAxWxamKMV9vLMhphoS1so=@lists.denx.de
X-Gm-Message-State: AOJu0YxtiYRpRD3PU7wZnWFW3QkozKwCRn1EALqF/Kh1LstxsfPuxr/D
 cpGNDGUeXS11NqjcDIEqW+AkkikmEA1Mfxg9jcNbJZc1KXujEggNPG5PTCcwJx4r10iONyr+Dz2
 s/A1CjRagb4OSfjdSOW5h5DWjLr967ZcOrl/Lxv2y
X-Gm-Gg: ASbGncvMaKL4QpLlC8Jfy+tDQb/h5S4yNkfG/+mCGBGWFqbCZskYiWMv4c5Q/IqdyXh
 NHxd/EU0vbku2eqbRQ7jV5S+iKPAVgbupAHy1AQfRyM7HUCEv01fZJ/4ORQ68JO4961LvHzqGM8
 le6sL7ZBir4Oclgbdhoo+X3J2qnPsFQ/vgig==
X-Google-Smtp-Source: AGHT+IEIUgDglrNQrRrMCA8v/bgXiNRZVAbC/hmzn1t9uImo9alLgnsPd1sWZjt+qyDV64mTUKgma0BuC8Bhon8Wi1c=
X-Received: by 2002:a17:907:1c8e:b0:ad5:a3fb:c420 with SMTP id
 a640c23a62f3a-ad5a3fbdc66mr1156859566b.1.1748006351387; Fri, 23 May 2025
 06:19:11 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:09 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:09 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-10-sjg@chromium.org>
References: <20250504132356.2317305-10-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:09 -0500
X-Google-Sender-Auth: f6RP9nWdj3RI09IvxPQ9lb0rE6Q
X-Gm-Features: AX0GCFtT-zAe1R2-SmVgZXl2xY39dQWddAuLaXOrGqP_mRa_3o75KaVP425nfpI
Message-ID: <CAFLszTjJbn4Jn_YsXDDFcBagcrYyjoRxw8GySZHw25bdUVv03A@mail.gmail.com>
Subject: Re: [PATCH v2 09/30] tools: Plumb in capture control
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add control of capturing output into u_boot_pylib and the tools which
use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/ftest.py           |  3 ++-
 tools/binman/main.py            |  4 ++--
 tools/buildman/main.py          |  2 +-
 tools/dtoc/main.py              |  5 +++--
 tools/dtoc/test_fdt.py          |  2 +-
 tools/patman/__main__.py        |  2 +-
 tools/u_boot_pylib/__main__.py  |  2 +-
 tools/u_boot_pylib/test_util.py | 10 +++++++---
 8 files changed, 18 insertions(+), 12 deletions(-)

Applied to sjg/master, thanks!
