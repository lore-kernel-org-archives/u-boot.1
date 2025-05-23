Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2A2C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCCF832AD;
	Fri, 23 May 2025 15:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RMtnoUXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E08833BF; Fri, 23 May 2025 15:19:25 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF28833CA
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-601f1914993so9345240a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006363; x=1748611163; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8mT4KcsM8bXY2PqUaTskTYdMA9oUlvCZXT3uItv/sAI=;
 b=RMtnoUXIwcMQZk2kAjlflEVbDWYmqQhR+eHTjMV6nX7ChM41/cjR0YhNaNycUFuC+W
 Ts2tZ1YeXZLysJ4ze/X/4r6UUw7lSC1JvpYwGzx329869uTY3PCqm4hx6Pn0xp7iWHDl
 4/+hjTVbmFbUYRK75+pOi9UWv5TQ2wKlKhlas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006363; x=1748611163;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mT4KcsM8bXY2PqUaTskTYdMA9oUlvCZXT3uItv/sAI=;
 b=pVi+89UPf+O2jznph3zirMjGhE8ygLpUeYIcaZ9KJIEtZbP5iEutMFZlv/zUBxv/Z1
 gdVcA4bxKg3X4rur9TWMkbFWoh8AkgDdlvqKbrFoyM9FeBupcPSBXNK7NQWnoP8jTl6F
 W7xDXtLMTtUZISZfrVIb38TfmqNb+Gr/y7kFvisQrLOD5zKI3/3mtGikmS59AEchpgDj
 OwSe8gHhoWnNZcjojxBaUq7DXkA0/cCtY82Fo2cvjEA+bSv957dTTXQYY4aJ6cpQwscc
 uXKnaoKJVRBkZ2ZIpaLRP2t7gtCdr7p6NpPG/H8uA8hohuiF1FXmh72KClLRiyh8gA0w
 43SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMwe17EQvFB+SZzNsWm2MUmlhNCByUmPzhQXi7g6W62JBhNe+01GjflzKdQRJLs8oP7T1xDSw=@lists.denx.de
X-Gm-Message-State: AOJu0YyKy8hIPTuY0Kgaa2UH7IbjJbHb6LBfxy0AyWoKYLO1kkgH5eUi
 eHQy7ViGVqLEOFxNGYUkO+hile2IU5aZiaTrK0Ma28dVoYvHHsjEifRYi06/ub7tJPQ5pP62BVl
 GtTTSrsf9H6DQVl8qU+4ajgt1SotAl0fZt2EEUMYt/OBYRTorOHshVUWR
X-Gm-Gg: ASbGncuOuSdeE5hVsQCOJHwojonX3BjIRsjlNwAwxvh/46cOCeJZMFshiO15ARz7jDi
 qUARhStC6G2ZOPnIrNRwLB1ml7PswsEBAN5RoxZR8lKQ4EX3P4aeDCKvM0UmNJfyGe9aJ5vfZF/
 3NZaq4tB2l7v4QSgK2qvL/7yXR/n/wcsakTtcXJ7wwsX0J
X-Google-Smtp-Source: AGHT+IHXOfa42nyy/qnjUlNA/UcNgWf86NBEEkCHhBKWj1mAVgctUVpBLZtntDeqgG81GdlYHElIbVsg2VEb4lTTDbM=
X-Received: by 2002:a17:906:dc94:b0:ad2:3723:6bf5 with SMTP id
 a640c23a62f3a-ad536b81a94mr2466835466b.22.1748006363040; Fri, 23 May 2025
 06:19:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:21 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:21 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-6-sjg@chromium.org>
References: <20250504132356.2317305-6-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:21 -0500
X-Google-Sender-Auth: nQQKAtgynq1z9kuWRsw5oxTXcMw
X-Gm-Features: AX0GCFufeTCjUrvrgoSqFXNDWO0dJtY4RClBioAUkGs49dwiNPotj1UpT8xmRRQ
Message-ID: <CAFLszTjn5JBv6a-QoWnzvBXvPGeacF+AHVLWL0u-8EHTMh9YSw@mail.gmail.com>
Subject: Re: [PATCH v2 05/30] u_boot_pylib: Improve ANSI-colour output with
 backgrounds
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

The current implementation does not handle background colours very well:

- It outputs an incorrect code in some cases, leading to wrong colours
- Some functions lack a control for the background

Tidy this up so that background colours can be used in more places.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/terminal.py | 38 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

Applied to sjg/master, thanks!
