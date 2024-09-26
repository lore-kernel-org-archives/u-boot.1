Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5946CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC8A88FA0;
	Fri, 27 Sep 2024 00:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NBHryT/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845BF88F8E; Fri, 27 Sep 2024 00:07:39 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B55C88F41
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7198cb6bb02so1151254b3a.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388453; x=1727993253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fx10y+EnEmMQUdSR3JLEpvDwjpHfzQFYrT6/VOcqBXU=;
 b=NBHryT/MqeaQ/1MLrC+efGbpAjFuQ6cIk7efOyDQtneu38EeI9Zm0Hl5cJ00PsNtCt
 eWO73z4TfCDmYcZ+VLpqHkvfDQCJFvybmCDgifLKos6jXGiMzvumUouH3vwpLXiOh6hs
 OJcFpBVBalrCa/8uzPdO5J6WRA6aHdL75gLTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388453; x=1727993253;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fx10y+EnEmMQUdSR3JLEpvDwjpHfzQFYrT6/VOcqBXU=;
 b=HTzGEAb4sFekEijMVkOdzOrXzX4rUI9Q1j5T9au5WH/QPXJMW/hZjvl5dwYc7ONaqJ
 YvOj2DzdycamLXlTEUtdLx7oPi0rD4oHF+Bm4slk8nGF1AhwwlhqRVgaV0o3DLQDYaxr
 T0s+T590SAgB7oznSYdfIB2M6aLaJ/DTi28jbb7mUmZKqR7pfsxWjkCE5VOgMkROG8qX
 RtNr3dHZnhMG9rEcSCuhaMD3Bq0gDcnWFrA2tnoN1KZX8Us9hYWVYjoOdtkG0qbWmIA/
 VdfeLRvrBSU7TVdqDM1DAucfWG3IYYbdw3OLLgRwReb+VMwX3WRF2x5bdTXsIxqR06BO
 S/HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrLa87xyHbDzBK0NBFw5xWiPV3ArBbetQ8gvty4lU3vvb2FuhYPeGEe8xKi6/padkpsSdTbtc=@lists.denx.de
X-Gm-Message-State: AOJu0YzcBKxEbf5eQouVL0QYDi0vSHbjq8h3e2gZ4o0D1dOcjssEoJiF
 sZ22jMNIbcWKWiUVJH2SXSl6Lr1k88YSS78pQ1LwGjW7x7kj2TA9DXjHahqJmZ5umHalVprjHUz
 SOmJ3jmh9OurloMLotGBjXZ2mMkRWMQYUmASS
X-Google-Smtp-Source: AGHT+IFKSvxKFiT+m88vVD/37u67ofo9KB6jQLcwdJyB7dX2XiQfsisJwnS9nwpbRez4ys9VTMapi+YpfkpW5q105Qg=
X-Received: by 2002:a05:6a21:9786:b0:1d2:bbf2:d8a5 with SMTP id
 adf61e73a8af0-1d4fa7a6fe0mr1292132637.31.1727388453701; Thu, 26 Sep 2024
 15:07:33 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:31 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-5-sjg@chromium.org>
References: <20240826191143.426387-5-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:31 -0700
X-Google-Sender-Auth: rw9yOBJElxnZJALWhloZF9_M9uU
Message-ID: <CAFLszTgJX3wMXozbrYSaYuuq5DySuny1qt06cx9eTK7MVbHSGg@mail.gmail.com>
Subject: Re: [PATCH 04/15] binman: Tidy up comments and pylint warnings in fit
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Update this entry type to resolve some pylint warnings and make sure
that functions and members are fully commented.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 73 ++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 31 deletions(-)

Applied to u-boot-dm/next, thanks!
