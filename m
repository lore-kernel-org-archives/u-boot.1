Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BB5E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1476D8954A;
	Thu,  5 Dec 2024 20:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cQUN5P+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A5D89274; Thu,  5 Dec 2024 20:55:42 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B92B8955D
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d27243ba8bso1482080a12.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428540; x=1734033340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ulrM1rkyyEUPYSr1PKxuYuU3amd6s3XKBHMFzCnwIuI=;
 b=cQUN5P+tZj2wjyljGBNKnS+ezk6pGlrSBtr6Hdr5Cnya1Qkf6I+/tT4D2uTJhbyl9E
 KU3nf8UXggnZM0XJruDZeYGXhynkKKrTKhnkTieluqPlKXZwUDQ/6g/pr0ianntrRIzU
 MSV9Q8ao7zDyPjjE2AMJUbCF0F/mD4Xw/T2Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428540; x=1734033340;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ulrM1rkyyEUPYSr1PKxuYuU3amd6s3XKBHMFzCnwIuI=;
 b=c9Hcq/fBwRi8mfpN4XPffxpYA30LMc5cKW/qoFuA3srSkafRPHHQKAFFhXK/5tt65i
 PG3WPV/2u8dPNcDYRV92JC4mJFdyqLyhvSng2v7ArrEzgG5x02GSqDdtCFiClu2EeGY9
 b20CR2ldZ+JekMlizDL/TkI1qvvgVFteQlCdtge/XQaRuPANmTvZWi1CCHltEaQuZzXk
 koX5+njtA5+APOkHgBpeFQ+S9EMJbp4wU82N6RiO+AzfKfX0EWM1oxmv76fgN+Jwj4Gy
 GAK6F8aquUvgjukbaZ+z64UZKrzPzedJNgnRDRPrruaj6zhZxXFwNnMMl8oMTydyLlwC
 /Yrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGa1cgeYeuJQiJihXG+wjb1+eAGJkMJGhKZufqHjCmIm0TIF1vlFnakHMCYVRTjKkT7B3FGo4=@lists.denx.de
X-Gm-Message-State: AOJu0YxclYoJbJ9q3mbBt+0RdSV7ujZCOQQ/vorU4G+a12WTQ9T6EsVm
 G7zcUlNc1RKCWXwW3qZ1jInSqhggozoX7A3k++5l9hDGk67o6FCi9aMYm6Ln6wnu6i5fznDNkVO
 qXIw8yWpIj2v8hXulBKpA18290ospN4fY3S5OMBARIQzCwDc=
X-Gm-Gg: ASbGncuZFYdUgEpCoc1j7ENq79hOnzMW0ldWeR9lop8LC2vZgR/1tsM5BYOKw4EWceM
 AaGk/O/IemcmiMlRNp+dZHiFgRYEe4qOV
X-Google-Smtp-Source: AGHT+IG9/hpU+jNbwhuP4AU+KnGwfJwdwFah9/ZvYijuQVh3aCR0oH/JITm2QLZNaxqa0BRMLqTq36gQ1lelLanX/Mc=
X-Received: by 2002:a17:907:7703:b0:aa5:449e:1a1d with SMTP id
 a640c23a62f3a-aa639fa434cmr14339066b.2.1733428539737; Thu, 05 Dec 2024
 11:55:39 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:55:37 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-16-sjg@chromium.org>
References: <20241115231926.211999-16-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 11:55:37 -0800
X-Google-Sender-Auth: z0G0rhfSiMTw2Gr2FB1tm6vlcR8
Message-ID: <CAFLszTgu2+FYMzt=02qN0ApU=tGH+j9VpGEe3SRK=VMAqFv4BA@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] bootstd: Update cros bootmeth to record images
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use the helper function

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth_cros.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

Applied to ci/master, thanks!
