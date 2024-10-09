Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BC5CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262498908F;
	Wed,  9 Oct 2024 03:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hvfjOog/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCA489089; Wed,  9 Oct 2024 03:53:13 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F08890C9
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e1a715c72so639629b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438788; x=1729043588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=42cpCLTb5bghLp2l3Wp0J8nVIs5B64fwVDqLcZvMXw8=;
 b=hvfjOog/Nk1XOiDaKrHU6zran/HN8tCsDJj/7XkLQzltn3O2ZV2Suz0AFhRtziuufT
 K+xlT+Q+z4QlkAtpOfUp5uZjJBA/NuCtVUF4KcnlMilG35+lpKKdEXe8fFT3bsf18fgS
 1fAqiivAZg1ReOw7KS67C2x6Xh69pY6u/xah8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438788; x=1729043588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42cpCLTb5bghLp2l3Wp0J8nVIs5B64fwVDqLcZvMXw8=;
 b=qdRKzGtirLClGBDfsCeAK4vOzDZA9YJtVaiReDoL22prb3RtuStThy5hZiweOaG3f/
 LgoLq1H0HZ9h7h/orOSKRB1AtuOaGzVsYarAAoWg1PhZ3A2+OFJcL8vSaa20eYZLyOfy
 Ru/qsj+oqFR9BdPsYrtH7042bHX5HZnWyATOpbHyS0xgXdlHf3suXXuFG9GBO0wWcEiU
 M86W+kkonWAAjnARPL+O8nbjtY8zQCOgXRz5f2g1Kbh788M2Oh+Np+fwJtTw9aNjRUoR
 qlYsHMlllYfrLyfqh2DzbnbIPySP82Lr/EXXuuUmNiY8P0Uvt5UjRssigc8K6SxXvZX4
 wcaw==
X-Gm-Message-State: AOJu0Ywlj94PYlpywB7JLwxZPDYboGLmBzF1jlsKAVVtRMxlfj47VV/4
 aXX25dgizAkeIevMISTBbPHGqKMVNs7QY3Q+0bcr55++Xsc5gzJQRZIKOgMPaP7eEI4V2QXhV48
 ovY+Hutc+j73QoIJ2gAfRRZW7a3HJK45ShqDE
X-Google-Smtp-Source: AGHT+IG6l4E39KlkcsBOZH9QxGkPXRiUJAagOpyNQdflEyKet61TIBD/VoWRVUPHMqAGhkRtlB6vXNNwHMUGuOjZ3MI=
X-Received: by 2002:a05:6a00:1495:b0:71d:f510:b791 with SMTP id
 d2e1a72fcca58-71e1db7734amr1399344b3a.12.1728438788722; Tue, 08 Oct 2024
 18:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-7-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-7-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:42 -0600
Message-ID: <CAFLszTg5U+raRUrj35ZmizLjRXXSoy_VKp4=ALwhNoBU2qYWUQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] test: dm: wdt: replace cyclic_run() by schedule()
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> This is the last place outside of cyclic.c that references
> cyclic_run() directly. Replace by schedule(), so that cyclic_run() can
> be made private. This also better matches what I believe commit
> 29caf9305b6f ("cyclic: Use schedule() instead of WATCHDOG_RESET()")
> intended to do.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  test/dm/wdt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
