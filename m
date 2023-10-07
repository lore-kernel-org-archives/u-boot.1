Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A400DE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048CC86ACA;
	Sat,  7 Oct 2023 22:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g54sS8iJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1727286A02; Sat,  7 Oct 2023 22:37:40 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0515863CF
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so183782966b.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711057; x=1697315857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Js38DplgRTy7OCZRauQuAS6oa1+kxnFhXOQVb2M8dbE=;
 b=g54sS8iJYOnHF4TZ06YbZL/bo+7JSmU48ZFxnhbOZC2w5VGGr3MhxUhubfV4n4pJ/4
 Ilsbm1p3X56QpzYkwHQeVR8W5b1qXvwztfCsV50bu8uJkmhOovqEmosWi4rsgz/1umbL
 8rCY4wpGZTaPl84lm9Dp9Y7uHKAmvvz+oAukE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711057; x=1697315857;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Js38DplgRTy7OCZRauQuAS6oa1+kxnFhXOQVb2M8dbE=;
 b=hCBJIIQehVyA8/6yOZv6RPyJO2EkWFTMn2mCzrtT/S5Z9j/amCPKoA10KLmGY2fs+3
 5fzKfssoeW4l9qgRzJoUyqHGvOGWJz+IWQXlM8xTwV9MxE/MGplVgbnk6DdeFySrGO6T
 yY3sZeKs/x2pJYamx2sZtn9R5oK7qbKNfYHO0PEnQEJJGfVWMtjnMtq3ZeiDZe1enOgj
 EHRlWrFHDdrOT0vUMULxOrTdk6Y+4oLnLO+vqtyJG8idujh9Baeo1aCgOqlQXhNef5LT
 INT0ZwASEXnaHvJjAblsvLGk/5XoQDco6QAIeIBCprSzKOoDfRlYkbf4j03adZcSaJ9+
 e6ig==
X-Gm-Message-State: AOJu0Yz5+3hY3UXThvJLGmI1Diaf8ANpqHSukFeryHCx3MnU4oZYTtJw
 uGuftM1Ce+FTSAXfhVotuT6rrviDuWz+8Yrs0ajuuA==
X-Google-Smtp-Source: AGHT+IF7YQwQ6ShJihijpL3tbOaRxfJBp7wdqayXlPWKTQOGCqRU4oHSIjXT011Agyi7lPABHzR0+u3HrEiJqYF3Ios=
X-Received: by 2002:a17:906:209b:b0:9ba:a38:f2c7 with SMTP id
 27-20020a170906209b00b009ba0a38f2c7mr2336452ejq.22.1696711057054; Sat, 07 Oct
 2023 13:37:37 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:36 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2tcCMT2KpMkHt-Z-BreWzrSrcFauboXCV4jsVxJxRKXg@mail.gmail.com>
References: <CAPnjgZ2tcCMT2KpMkHt-Z-BreWzrSrcFauboXCV4jsVxJxRKXg@mail.gmail.com>
 <20230923194424.1739224-28-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:36 -0700
X-Google-Sender-Auth: a4ghTt9JwNAg1ZriH8NrMUR8_yA
Message-ID: <CAPnjgZ3vkb9pzBnZNnxtkVv6ajY4040kuVwKxvOZ3XkK2jX0Mw@mail.gmail.com>
Subject: Re: [PATCH v3 27/27] qconfig: Update the documentation
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Update qconfig's documentation to better reflect its new purpose in life.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update based on Heinrich's comments

Changes in v2:
- Reinstate the -C option

 doc/develop/index.rst                       |   2 +-
 doc/develop/{moveconfig.rst => qconfig.rst} | 160 ++++++--------------
 2 files changed, 47 insertions(+), 115 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (59%)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
