Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B3C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97835835C7;
	Sat, 24 May 2025 07:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TPYFWNcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B23083303; Sat, 24 May 2025 07:06:04 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B57835B2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so76212366b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063161; x=1748667961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUAMfAA3j2TUG66gdWPu7+k0ZS36NzwslFjW2UzNLeo=;
 b=TPYFWNcW8i2QlZ5DpPa8bCEoKQWqackj/j1fDoZzeLRt/wvwmnDqtDHHEiEgzfHbvz
 mkUxQw74zeMCHZSu2Nx3gcTIoMYiLhGGfsnLMZiL5HbmynA2GanIDHRE4rlkUT4GQi32
 +F9oZcaxBQJ1ZRzrfLssvQGKcujuXodmJ9gOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063161; x=1748667961;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUAMfAA3j2TUG66gdWPu7+k0ZS36NzwslFjW2UzNLeo=;
 b=BhEcJpdZzBFXu7RpojKPqGIoASAslW3J+SdSreRpZmT7da7bL8qjsIZ7NV1V70Ff01
 iSwyfUN5dcvgT3hbu3dZogH2cYsccePTTTgenlvcoFHzqDTEkJr1oQDKRg3mSmx4XHeT
 Fg04rkB7qmY8UTkhaOV+DFz511aL067rF+2szVcq988722niTfcwGvOhIoMK7m06I8xQ
 KKl1yzmbb2q26k3A6/GdEcP7TKfx+uiI1oWGQ5JPkP8M2bqO5/ApE3DKtM2nBW1WagAl
 vn9V3WJ3T6pj4re8KSra+Vy8XpybLL2ESiF1wJ5vfH78LXShX3Lc+SsZ9HmlqTPO8Mqy
 0vaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFI4YK4iMrKk4h5zYqcV7cia/XKXL+y0b6/HSr3SxmndUnc2tcnnCmqL8wbZTmDZUAlMYrdK8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5PHCRgqpOYWGpZk6KaoujGx9rmHxhD+V3n4JLXSVzbdvYThf2
 q72x8TGmm0K/F/Bf/WyleTX6IMaJZadD73P9OyPdG5PpoxvuTmym29YyFDlOYKyFSllq/wyLvvi
 O2CT5YsDSVIkINVAQ4hkVLkIwaP25IU+oJ1d6miO1AKa0xt3+OBw2l9bX
X-Gm-Gg: ASbGncshMAs1HVfqVjjk1DXogreNFV1dEkRul2tdLmuPtLY+bM8paPE1XO4FgzFVgLt
 cEm/sEGf/5BEjsM8KkZNvCnk4TSKMEX+wetjNmMkrJXJT3vIB4xcVDaHcZXmgtEDmrR0TOUqQcO
 zW8boIooUyTgC/p0LylNUJToYnzZ2qdeQxRrC5qO3fcg==
X-Google-Smtp-Source: AGHT+IFIQaIgStkgIhR7he6Mr3M/cxx2EeN/tXBRDfq/k5UF7f1hfuYVtCBxpK6E1vts4u8EucxhvofVFCWGOx781sY=
X-Received: by 2002:a17:907:6d0c:b0:ad2:40ee:5e29 with SMTP id
 a640c23a62f3a-ad85b130236mr127299966b.10.1748063161585; Fri, 23 May 2025
 22:06:01 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 01:05:59 -0400
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 01:05:59 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-17-sjg@chromium.org>
References: <20250510110535.1453745-17-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 01:05:59 -0400
X-Google-Sender-Auth: 9K-_2rFBGdEJM1is5QERCFFQPsw
X-Gm-Features: AX0GCFvHMWR_3s7aTb1A8B1OV9Woz_UgTqMuDsw6prPVwz_DES3De378H2Yn_Q0
Message-ID: <CAFLszTh-5h+i9hOKZkjA_3fY+FAiXhLokfNtVcf7s-bU3B+Kmw@mail.gmail.com>
Subject: Re: [PATCH 16/25] patman: Support returning the parsers to use
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The parsing tests need to be able to try invalid arguments to make sure
that these are handled correctly. Provide a way to return the parsers
being used, as well as to pass in the parsers to use. This feature is
needed in test_series_no_subcmd(), for example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
