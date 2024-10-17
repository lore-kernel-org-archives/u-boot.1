Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A84BD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D649C89177;
	Fri, 18 Oct 2024 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JzmQHPUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE761890F4; Fri, 18 Oct 2024 01:12:01 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFBF8912E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so10141686d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206718; x=1729811518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eYl2Z/pHp6SkGtmStf6PThIqrfN7iBouB1a8pq33j0c=;
 b=JzmQHPUVePT+cb8wqPme2YhNJj4Ja0ydVE86Unnht/G69y5pzBNCeSj1e08XxPExOx
 9XRaPsCcsVV6VOkNCKgukSwi/2uUa9U2WBdzBhJ1DCX1dIeJcCyx/LjVmkSNPXgh3eZN
 QCRv9Ko3jtc7rcqPLIzZWvEcRbVssTU8D3ZmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206718; x=1729811518;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYl2Z/pHp6SkGtmStf6PThIqrfN7iBouB1a8pq33j0c=;
 b=lR6Ue0Y60IJtb9ZrGa5C5DAPOk0NLEgE0mpdMMAYPuGImQdZBOIMuZ94UMUqjE/m/B
 mb1xWQe8fDmve4EkEFnPMeurgmqCilGKWTtn8PEj7eHba2KwYQpmlgOOycjXWaetTeKi
 DtK8LqbskUgt04VJEVztYXytQLr8ag9EQp7w7ZfngAxCnOFGcTJHDBQQDGEqR+ajIQCh
 L6j5SMp0QSf0cXc6XkGqTd3YNA+lBvBKnYP5hXsfGg6tcuwsfEdHlQ2xUL9KQWAmaqgZ
 GjuF9xXwxAbQZBcDilli0kXUjdifUlM3ge0YKw3KpyKK1TLhisjs5A6Rpx+7CmvlQ3fs
 3/hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDZJ2y7OQ0zxaNv0F15txO6hgJjIIhjdgKxVUmB5UjJvZBFXfQGRrlbAhXEMZ9Tb0ByCjtfOA=@lists.denx.de
X-Gm-Message-State: AOJu0YzhI9FFC5uHyIH0DYpeXozBZZiTxK4nMxiFgMmQ5JfXIP/+1AZh
 o/lR0Kmz8WB+VYePcehYKj5beZyjG8LTECzm9oWfxMWSzXqXVye4VpM0dElSYkHPjGUE9l59Iul
 AYMaESKA92Wb/C6UjiJjjpMT6xcPEaWcabUNm
X-Google-Smtp-Source: AGHT+IFFS1J3JUupfBSIy8c0CZB4oMeLNUQrMEgWynUbFHW9CfyiM6l5P8vUX6JA6QlCArgV6kIYHebFFkIVUWoJdJU=
X-Received: by 2002:a05:6214:4b13:b0:6cd:4972:59b1 with SMTP id
 6a1803df08f44-6cde153abd9mr8787896d6.27.1729206718622; Thu, 17 Oct 2024
 16:11:58 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:58 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240921175800.437341-1-sjg@chromium.org>
References: <20240921175800.437341-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:58 -0700
X-Google-Sender-Auth: z4zCugpBG5g9nVPWkJbi_yQD3UQ
Message-ID: <CAFLszThKsV2T5yGaifYTPmouvA_U8XzhSJF4=OJ3m2AEyw3jAA@mail.gmail.com>
Subject: Re: [PATCH] buildman: Correct some warnings about regex strings
To: Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
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

With Python 3.12 some warnings have cropped up. Fix them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py   | 6 +++---
 tools/buildman/toolchain.py | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

Applied to u-boot-dm, thanks!
