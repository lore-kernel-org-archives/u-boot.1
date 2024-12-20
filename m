Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE1FE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8660680581;
	Fri, 20 Dec 2024 05:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MSvMRcJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91758037B; Fri, 20 Dec 2024 05:06:31 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20648056A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso233794566b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667589; x=1735272389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UTLje5eNtTCOVRrma7D/tFsWH4jlgFn5j+X5oGTjUS8=;
 b=MSvMRcJDUjzVQE2/9YK68bJMhY1Hvg61hzsdaZvR+hywwhoG7ch7GAmHutoCB1Rh+j
 N4Hdah+wVON/BgpSfTp5bcqqNt1HtrrmW13bNcQRL2QF6WZv+A7SAU0fHLPCpZtRdzz9
 1K1Cb7hmounT/t8ShQMqToSKQ9GU9mdE6Gem8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667589; x=1735272389;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTLje5eNtTCOVRrma7D/tFsWH4jlgFn5j+X5oGTjUS8=;
 b=dYtGkXmh84dWVoi5TJXr4EN4iuCNwXDed5e55mXmgB5WJR4dpDtHOFQML622uYelgm
 20kaGogpr/9Ong1kR3wafwJ7a+MLzXuL5fNnQm/8qDwvuTlXp2w8XM183oSej514Cy91
 SQmgGzD4phENE6VHHniLUZ0BEueheXeurz1igJX5pULwOLmxULW1DGfuLWmANaRYpH2B
 d88dzc48R4n4+xUgbTnZC93Z5PviyDCz6cKiMKyD/na+jZZYy6D/Co+ccVfJM0XPZkez
 o60LE8bFxSMU0ovQMegp1Oi3NLhk/Qj/HCcSr8uiSb867oXuvuTEVdi9Jd3swfejvQF9
 evwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfxlbs4VEUc4OhYMt3/f1kIZw0DV7vcWushb5f8q0hMGlF5RisYibkoS6actX8v6uJUCvtvRM=@lists.denx.de
X-Gm-Message-State: AOJu0YyCCMN80pvnRrUnkBY8FHA0jyCRWDKdeMKPu8gns+31MMa2u66Z
 ne4rafls1cqQfoyQJYiG/uZplP073Wl9qliFhimUwEhIx/lvYWMrGUB4fhO5MaRSH0zXSJfk5Yj
 93LYuHwE/FXcKze+Bq7J55Gj0MmFf4iJZthRC
X-Gm-Gg: ASbGncuGV6MHOQoiqsRKApFxOGXpZEn//dkKXO21PIalivHLIj+KpAaKeLsf47DjeP7
 Madw5X6CHDvY2ZzsxeuiEjDYjk8sqQJKtsZ0LsdI=
X-Google-Smtp-Source: AGHT+IFYObSVGrOtMaEg5E0+ojVcZvj7mldDIhdz0ML5cmV01XzAnOfYns2Kk8wGkbIG+ym8SyP1urBx+BpcCpzf6b0=
X-Received: by 2002:a17:906:c14c:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-aac33691020mr92990566b.49.1734667589353; Thu, 19 Dec 2024
 20:06:29 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:06:27 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-14-sjg@chromium.org>
References: <20241206023626.2456858-14-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:06:27 -0600
X-Google-Sender-Auth: omhyx2W6kjI7VU8LoJ-HZGOiugA
Message-ID: <CAFLszTib-kraz666Dx4wHK2OW0CCKV-Ravq6sv73pbKWj5rTJA@mail.gmail.com>
Subject: Re: [PATCH v3 13/46] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

This code cannot be compiled by boards which don't have this option. Add
an accessor in the header file to avoid another #ifdef

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/bootm.c    | 8 ++++----
 include/bootm.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
