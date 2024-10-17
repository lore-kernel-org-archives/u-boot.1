Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A2D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A73889089;
	Fri, 18 Oct 2024 01:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dsuom+7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3170B89089; Fri, 18 Oct 2024 01:11:40 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769A1890AF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b1343e8042so144655385a.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206696; x=1729811496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3QHmgRlURtGjqwRMZQXOj09XLIxkiKv0+HaadFWlViE=;
 b=Dsuom+7VfHcfrTkPL7eCInqiCtpj17JBnnjM8W5wxMJ7DYuNfEzbPsMgh4fYcoIYW+
 gVPu4pmvgK3gxrxyc7rPpw2m9bNz0N+CvNT49ch0AGtWk0mTdP6HqDxD50hoiVML9i5F
 2UBVgPMh4CIT/mo1bEu7/5AqVAOYPQ4l0WEg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206696; x=1729811496;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QHmgRlURtGjqwRMZQXOj09XLIxkiKv0+HaadFWlViE=;
 b=eU23/nzqDS59Be6GYa9z6gGLyOXwXdIpmy7Ues3R4oIK4ZwKYXSAx3kK81F5iN5eUf
 XKfXJaA1JxPl+JIKs1B8pvkm7uVuCLtxbuDj829gbB9GZiR1JDxAIYL6gtyFQK7DOH1M
 ZgqciE3XM+/7iGU5dP/3tIAtvrReWVZmwz7uuIlrik03qNdB19HLBRcPsxHICPBswCzb
 jfCrtIzXQrrT7LgwgRYVx5TfFyKewIoNkOG4iAhM4twHonY92rG8s+Jlf2bb7p0TdMLV
 38HpR7g/xO4hYsm7T9y7y3ZrFIvbeZ5ETGCVqjcIZj6+RXG4cvgmdxLR5MjAk/O0feOK
 EUCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq6kMfDVrU/4TI89tjjuiqlHtXsy173I3pPptRg37xlKdb2+T9aIam5aL6Pskh/ZVDHsqg4Sc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2rvpwEAsUmBvsjl+3FYTC9PVB1xHsVkwo+4PlcWze+CNj0cIR
 hVUu8SqJ+yWpl0aMnbPz9MjVD3RPGVGVtGBCUilvkTUGDSBAqQw6OF7wHM8dX0ADjkDL1U6RYVS
 cw3iriiw++RQ0vvYVATZMT6oIgQrva5duNGi3
X-Google-Smtp-Source: AGHT+IHhFK4w0dAYD7oH4/C6jc6a1LUOB643CjdHOyES394KT14GVhU+p9awXqcbzVs5i6+7lalXbevtQXAJkWZzjms=
X-Received: by 2002:a05:6214:3bc6:b0:6cb:bfb5:6fc with SMTP id
 6a1803df08f44-6cde1538c5amr8903026d6.25.1729206695430; Thu, 17 Oct 2024
 16:11:35 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:35 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-11-sjg@chromium.org>
References: <20241014223212.2212442-11-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:35 -0700
X-Google-Sender-Auth: vNmiHZuGbLNnS5dNCZDX2v4XpZc
Message-ID: <CAFLszTick8j1+5uOfuTHJ0JV35MF4qKAdDJokY4dSvPu+_nyFg@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] expo: Drop scene_title_set()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

This function is really just an assignment, so serves no useful
purpose. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo_build.c | 4 ++--
 boot/scene.c      | 7 -------
 include/expo.h    | 9 ---------
 test/boot/expo.c  | 2 +-
 4 files changed, 3 insertions(+), 19 deletions(-)

Applied to u-boot-dm, thanks!
