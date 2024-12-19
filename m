Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15059E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA8580361;
	Thu, 19 Dec 2024 03:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Awl97UfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F0F80326; Thu, 19 Dec 2024 03:43:45 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2728021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aab925654d9so56343366b.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576222; x=1735181022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pw7Fucr+hXDDAK96Dnm0ABVguB1sDW27cfdTW9TML1M=;
 b=Awl97UfWt1gMxuhuRV0ZP7hzPnH+94+ofQuNpyhVnJfW5HCegnwA0fSkcSyfPCDiqb
 7Bg9BTmcYaYXQLrXDJ8X6LPvAqgNNUJpIBCKVJZ8eT4WWV7pPyavWYudmrF1zh3DAfPD
 xPQfGQENCshrn8uXWxRH9UfNflVWORS1kwL/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576222; x=1735181022;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pw7Fucr+hXDDAK96Dnm0ABVguB1sDW27cfdTW9TML1M=;
 b=sr3u0/X6piNbk2FDcL/4j6zTWm0IxWa/W2BKX/hsAALCN3J/gzLQ4LhCmn89+TXmG3
 8pVHNJfYKao7PGP13Ai7ABObT59h9QR5YrHgsF4OmSnlzQ8+mjPMzLr74VB4AD5dJpE5
 Mi10Otzo+eXPl9/nl0AVm+tlxWNxyux7nSbuf7x6a5pp8bsI5qvjCPkr3UGsPRJB12t9
 guNiK5Q+fWXorAxkWYVa3fy1OAk+vFlK0xJ6mrP+Eudmzl0HvLZKSqYb9Rh+mN4gvwxM
 qXuaWjnjiSM5zbXtZFPf7yxiQezD0KNyMDBJFHA6ThsJnI0I9s2e2UDwVKi+AYBo/pCd
 5Y+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1bYGcejHA8XjGTBKZcHrz6lfqRmrUON4CH2aTMA1N5jH2+ibDa4OYxn3LR245gf++SLz7ptU=@lists.denx.de
X-Gm-Message-State: AOJu0YxNnZ4mwrfl3Gx7mxa0QW4HETfIsZTpSvVkimoUNk8O6Paustgm
 bsCMjyFu7GS/OqTUJCW8+ulfbIMER1cEPGFzJSksI4L3P3ZS5cD5eIacJ5bGnJ3AMBDn7BYnCOl
 asN+1V+EOAAtlMcZ44wsYkYLJQuHEDp8k2aqq
X-Gm-Gg: ASbGnctTMQQGqJ5Q+XYL/qlJ2Ji4szBXF+X6UvY+DSecSZW97lnLmzIn/z10Gn1ykkU
 M4nCkFaxkwNCyQo+Xj9P71O7dmNYAqiFK5lC3Ua4=
X-Google-Smtp-Source: AGHT+IEh5pGsJswDds8c9UpY1f7UcxubE2a0uEvrhQrKoyjhj3pq+Qq2uiu494d+yfL9t+w7GuVHoXpsAv/8fdpvpY0=
X-Received: by 2002:a17:907:c10:b0:aa6:79fa:b487 with SMTP id
 a640c23a62f3a-aabf4716e7emr507000666b.10.1734576222556; Wed, 18 Dec 2024
 18:43:42 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:41 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-7-sjg@chromium.org>
References: <20241211223822.2446254-7-sjg@chromium.org>
 <20241211223822.2446254-1-sjg@chromium.org>
Date: Wed, 18 Dec 2024 18:43:41 -0800
X-Google-Sender-Auth: eMUEmC3eRoRiP6oYlWRgMIkhL2o
Message-ID: <CAFLszTjXM8JF6ui1jvqG+APnkY8ZhKab2kFOesH5nEdqa5KAOQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] efi_loader: Pass in the required parameters from
 EFI bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Rather than setting up the global variables and then making the call,
pass them into function directly. This cleans up the code and makes it
all a bit easier to understand.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use efi_loader tag instead of efi
- Drop unnecessary path removal
- Fix 'require' typo
- Move calculation of dev-name into a separate function

 boot/bootmeth_efi.c          | 49 +------------------------
 include/efi_loader.h         | 10 +++++
 lib/efi_loader/efi_bootbin.c | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 47 deletions(-)

Applied to sjg/master, thanks!
