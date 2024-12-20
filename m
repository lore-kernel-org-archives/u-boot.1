Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F908E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF7F80352;
	Fri, 20 Dec 2024 05:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bbLBHbVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FF348039B; Fri, 20 Dec 2024 05:05:08 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD6380087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aabbb507998so283433266b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667506; x=1735272306; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JsCfKEltDy4kY7/v4tRXEpW+GtD40E623Yy/SBM5eD4=;
 b=bbLBHbVAEnE9XP4qw+ipWs0YqlCVLrJjMWrWkG4oQYf7NkQWZMZWpMqERw8OQRRNvv
 AwebSzXYlc/UX40C20WPvwRTSXrNReuXIFpwtq+vCUE93fGh6hdptK9vxkWf3MzSXgGa
 rjBtM+gFFiAxRlqanvLxT3CefToCB4toD/UPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667506; x=1735272306;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JsCfKEltDy4kY7/v4tRXEpW+GtD40E623Yy/SBM5eD4=;
 b=H7VvKSVVJlBCGOs/Lyhuhbu3Kd3h83AXP+U1PKkXx9DArOrfggimNRgDaly5kOFgUr
 99qQaPy6PfJ5wDKQzAGAbqS4E4tsB7slTj5bvCNqJmauv511zZLTCzEAZ+wFKurW+G0b
 hp7ult3Ovih69R4dZVK3cbswxyk+i6f7nBAvzjNyndsNF7DGDmCGkRDQG847K9XVcxPT
 WDiwXz1O9OHGq60lXpMtpkO9XYumZxuD+5zAVhfO37twaF0fNZEC7D1qragbxXxwuiF7
 E2vDhGoQtjmuZ18ZLUaMEsBdr+KVhiQU0iZ7dInKCe0r2hLUENXIVSDhLGoGruT7J4zN
 UILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfokW8/q22nh0LjB3YeWjDYtLjeEbB8niEz8IuR55IqbJettjvl30ajQBgXbb5jL5pbQAxRPk=@lists.denx.de
X-Gm-Message-State: AOJu0YyKN+fQxrAH5Pe8y8+H3cqlj/GSIwdyE8r7x7Gy/lxbX1w1xKW3
 SYbmoPf37k1yDtAI6EmZ+ga/HlZE17ljYIYN+7BnLqId8mfR3ZKZPhvczCtTknlrtX2DrWBbcj/
 V4ik5KnMC82507hY5o7A0PgHOL29PeLWi8fYo
X-Gm-Gg: ASbGncss8h/Ba6Kjpw7VmKLILFqMz2UZpgHfPOWP/dqkJ4lDG7RbyKGKcinQM3kd+yv
 8plu1RhUIc0e7hMsqU4L8S3ohx31IgorTYnebDkY=
X-Google-Smtp-Source: AGHT+IH955e6hE4ufDt0LE7NX/fqi4o6MrV9BzksTmcRR0u0h+l9wS2Ptwv8SAXOpZxwzul+orSVGy1pznTZtKQZ56Q=
X-Received: by 2002:a17:907:2d27:b0:aa6:6e02:e885 with SMTP id
 a640c23a62f3a-aac334f95f1mr77242966b.47.1734667505938; Thu, 19 Dec 2024
 20:05:05 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:04 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-42-sjg@chromium.org>
References: <20241206023626.2456858-42-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:04 -0600
X-Google-Sender-Auth: qDWEohGLLbTbMb50Lq3rBLmqXGM
Message-ID: <CAFLszTgL3us4A8_t5hDjcbPbx_19CJXp2t6YgwUt+Lx9Pd39gg@mail.gmail.com>
Subject: Re: [PATCH v3 41/46] bootstd: Update extlinux and pxe to allow boot
 interruption
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
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

It is useful to be able to inspect things before the OS is actually
booted, perhaps to check that all is well or to adjust the kernel
command-line. Implement the 'read_all()' method to allow this.

Provide a simple test to check that the images are found.

For now it is not possible to actually continue the uninterrupted boot,
without re-reading all the images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Pass through the bootfile since extlinux and PXE are different

 boot/bootmeth_extlinux.c | 11 ++++++++++
 boot/bootmeth_pxe.c      | 11 ++++++++++
 boot/ext_pxe_common.c    | 29 ++++++++++++++++++++++++---
 include/extlinux.h       | 15 ++++++++++++++
 test/boot/bootflow.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!
