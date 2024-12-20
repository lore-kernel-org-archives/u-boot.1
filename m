Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C51E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFC780469;
	Fri, 20 Dec 2024 05:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AHoW2L9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32AD8043F; Fri, 20 Dec 2024 05:05:32 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC58580087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa696d3901bso262260666b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667530; x=1735272330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMKXxL6YKX9muVk6jUILpyhGRF6apSkJxcQvC4nJbEc=;
 b=AHoW2L9DFedMAS5rQtlpQiA838iWkqfQS/MoHYLa1hKpUuq54Zwu8mze/hWwmVtfAU
 1klQS0hBpIChaE6lO6v658bRb0sO6KyKBcBoEZr9kQT5F5tAwoU5C6bLwJUq3F9zI6xu
 GlGhE/9TtpCacjg5qZjYBzhiIhj3PLsSsC1qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667530; x=1735272330;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMKXxL6YKX9muVk6jUILpyhGRF6apSkJxcQvC4nJbEc=;
 b=Ob/Mp3JsPj7e2YDHKtcJctElbd0uT9AKA7wU1Ew5bjl/HsjNUnr53AnBu5m9cVEZE8
 sGhBzdcvCcr4tunjC9+QANy3SFI4D5VpvVnkHdTT66YMYIHiwUpnLElEWlqYHy/eAq+Q
 pKciNPPCsNrIpHhreju2tBKxk3GzAke3Z/4N2X9KPYN+ek/5WPFOho9fOCdavSVWRZly
 6/oDPrikQnGwK6mVw+RokpdBvWL78f+6aQYt9Uix1Q1/tBVnkVV2VJe6ZGfWAm0Robxm
 J45cZgxHXP1GabiWJ6dG3VEwVNEFHdarSH+8KycVd7kW1tcJScsHRqaOIxHYig+RU8gN
 oDvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKjBBDKZu4zb9JF7c9/en33h9COSSLsYA6ED5e3RApALwMCS3mP6TWHpakZZapTgYEoIKQdRw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9Dg9Z8CDFLGvqygpgiwpnua6GgSwImeDJ3328O22qSyyK+B2/
 gL+6IB5HFQdue2Ruqe8plBaZPHypR7NfqphXmzNhsVWyEcVXJd4gdx+MiptAPQxRc34d4bzmCeU
 lxRfLk1mJvIJCZBTF93Q1/z/h29OhGkHKTxfI
X-Gm-Gg: ASbGnctkYntyjMRtCLUbBXgAFZOzUWmqauPWS6OMDpjX9HQKmkOaEr5YD/QeCxuE5K+
 YMqQvLFbjWYbf8nG1zLH5te92V+ROeC2o0CwMvAE=
X-Google-Smtp-Source: AGHT+IGgAPL+LAdtslZ0drKOR6vbOSZJivoxtnxQuIa4IefF72iOGYeqaVRuWnVJf/dsNnuFVIlk/nQ8StkwjDUREbo=
X-Received: by 2002:a17:907:97d2:b0:aa6:af4b:7c95 with SMTP id
 a640c23a62f3a-aac33690754mr108928066b.56.1734667530170; Thu, 19 Dec 2024
 20:05:30 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:29 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-34-sjg@chromium.org>
References: <20241206023626.2456858-34-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:29 -0800
X-Google-Sender-Auth: Lnm6YsqOF-xozGNZ_C05_E6FFxg
Message-ID: <CAFLszTjDMRkm3m_xizCCfyoJFas+pyVpRqGgnZkCVgTHWXss1w@mail.gmail.com>
Subject: Re: [PATCH v3 33/46] pxe: Allow skipping the boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

Provide a way to skip booting the OS and just return. This will allow
bootstd to read out useful information.

Add debugging to help figure out the flow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c    | 12 ++++++++++--
 include/pxe_utils.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!
