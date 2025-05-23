Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1A5C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC6B8333D;
	Fri, 23 May 2025 15:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ClnIsjRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A1683322; Fri, 23 May 2025 15:18:53 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F843830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad564b7aea9so181398266b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006330; x=1748611130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKWCyZHHUe8R9fAu4DU84rPebu4PNtwJoShxholDH2c=;
 b=ClnIsjRkKecftZ/xYleDNZEndi8H/3qRwvvJ7X3VWbfqK9t36tWifQfKiM+WLWQ6e1
 o7zYEyqcHR3g08PEzItNs5FbwVWg7jUtiXGCT1pQRsuRBQgKBKKwRDK2EjpbRmfC1nkR
 Sjc3xMJdowqVNYiNvtFV00pAVkJVqC+OTpsAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006330; x=1748611130;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKWCyZHHUe8R9fAu4DU84rPebu4PNtwJoShxholDH2c=;
 b=pBL/RTN8nsPxywOezzQW+IfDvb1VZxKKTwDsxf2YUxinFeeqWCBbqdm7EJ29YZpei9
 9/UWon9rkE2qjArHwUJ2UwX6qkqzJa6W0iwfR2qUGYtnOfv49TWFpJM4bhlXj33PpTeF
 UTiQPzr9TgmtXGO46/Ka85beySatN/5MWzf76qq/pMQEVu2aRn4bRhkybj04fVLv0la2
 J0++5DhpkrLr3NuJX0os1EkiEJUuV4Nt7XdCiXZlnIqEKDF7jEVpYLq7lYASM2C7hML9
 SE6wuni4ug+fwUebZFj/OwqVUfE0qLHdeOc95F/O/XzV9kQS67hw3lsWFOpU11r76oS3
 yMpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrEs9zDPW2Ly4v5PIOIrVLyIRQzhtBY9LaNNKsOE0HQlAGnYIqFRky9axMG2DXWFdxh/7MUwE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8iFsRRIWp/iu6PSz5h1Mw4lynmW7fiVM3mjvfzGhGw2P8G5vY
 z5b4/TtrbGeHVPl6WtnhIHYaSJSsNEMRyO9iL7gjSccOcjRCGkBPPwQ067QvtbseMyl5IRihMw7
 f0tnW1nZ9NRjpyBDP6pDEc/uyK+9F1Zd+Rcmbe1g4wCFs1rPrr0dmfN+T
X-Gm-Gg: ASbGncsQafm9HNl1wfFzwefGFaY16C1hqiuc0QATUkCqcwXoVLa9QPctROZqXGZZs7L
 t8y33FMWclOUsxwXNPgZdxjbc4CI6xnrneRehb+jn3BnyliVnrSyICltiWxap/nRw5KRDq4QBx9
 hWAoE98I4Q0cV/iiht5NUnkxLHZfc41WZbcw==
X-Google-Smtp-Source: AGHT+IGGup4XqDf6Bc5XHEHGP9otUPijFeFN1YRbRV8PwpBtLfrKO5UMII5qQaetfmrSq3zYgBSb/szPkrGLi8gUNAo=
X-Received: by 2002:a17:906:6a26:b0:ad5:4998:9f1a with SMTP id
 a640c23a62f3a-ad63f984b0fmr321956966b.5.1748006330555; Fri, 23 May 2025
 06:18:50 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:49 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:49 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-17-sjg@chromium.org>
References: <20250504132356.2317305-17-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:49 -0500
X-Google-Sender-Auth: UCqoPmbYpzAGSp_XIl8XVG9a8L4
X-Gm-Features: AX0GCFu8TFwUYIpOvhrTL0ekIQ5UvNZbLtJUhMJF2O7UPpZGYvK16H0Yq5VSzMs
Message-ID: <CAFLszTg-vwazJ+aumJ8j+-pDNhKfVoR47heKBCbU4Z9EX=x1yg@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] patman: Create a module for handling patchwork
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

At present the patchwork implementation is very simple, just consisting
of a function which calls the REST API.

We want to create a fake patchwork for use in tests. So start a new
module to encapsulate communication with the patchwork server.

Use asyncio since it is easier to handle lots of concurrent requests
from different parts of the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/patchwork.py   | 66 +++++++++++++++++++++++++++++++++++++
 tools/patman/pyproject.toml |  2 +-
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 tools/patman/patchwork.py

Applied to sjg/master, thanks!
