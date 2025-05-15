Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C3FC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57DEC82B72;
	Thu, 15 May 2025 15:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dnhjiFLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E1082B7F; Thu, 15 May 2025 15:51:11 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB98282958
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fcc96b6a64so1908101a12.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747317068; x=1747921868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wAntcIglysI10o9Iuxyq6gxs1MsEDuVKW7Or59QzzVc=;
 b=dnhjiFLO0uo69FSPvx2oZfhEbFtlAUxrBRk9pjfdrC7xU6BI6nqp0l9e0aFFPLDujM
 213CoJQVp4NidfpvKH9eIAQ3kPuct/x7v3BUsAONLt7UsIFNyz4bwcRJGGryOSDy6NoB
 jlasT5RFvFrPO3XOSFovzndl8ef0lG4O7Ky+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747317068; x=1747921868;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAntcIglysI10o9Iuxyq6gxs1MsEDuVKW7Or59QzzVc=;
 b=DnX0EB4ACs1zYmdsNBS+Wl8hx6XZzqG4ECRgoQITUA16wR+cxOh2UI53yDY/NMj7L6
 4fGt6GyPtddnAY1oYhx1FGVNzQ3dDbzP3NPGVrQXLRCN5eUQJE2ca2L2dXT3qmaiV8gj
 fq2gUX2BOLIYwTMRAYHSItQkcsclZNBB4MkSwQjeSZG8+wv7uzEB8cJghfEMqugqsv4A
 JQB90OqZ69iDzpblCnPzTEe3nmTXdwX/z/gRCCXUGinf/sMySt8ke4icRsD9oE7W9BOl
 uPbUVJTljubUpnFUo9DawxjEj4CT9ACaDcot68xdHIulmXw04GBRpDZDEQn3QzfCJSZs
 Px3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxV+vyHGWFNo2TJCDuFlFH0wJB8mxwpnjbW3zT05ZX0lnyXhzHVY0tQnM0lUQduE3ve4KEoJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YzEry9tcLYNhxWBNtuJkaP4+M0zc1GMZJzyKUuWYqtq5cXCg3NP
 NKiJ3qNzxrgXNAgpY3FBPnYecCOiLaJQdQfx6YB0fbzfXdS5dBcoC/AZ1bTHyYxY0qFwlx7YPyu
 Vnwwy/uYo1UwZwS2lEaucCLgV8XWQ59clMiTt
X-Gm-Gg: ASbGncvx9VfhUc0/1rSjW6D/9zKiF2PehyriKu/rgqMKzVh1mXyP3/JUWRZopq7yyxz
 F1oroEcUO3hrbwE4r2NUhL5O95q1//nBnchCm5FSlJNQEx2V/kv8KZe9hnEK4wLVkHR57XRtkET
 /Sb6NEGTXlxRqMjbNDEZ1gWgugHpqgH58oxg==
X-Google-Smtp-Source: AGHT+IGzJDmOfSsN+W0rzejWyC8f5OYi56qJ8Ci1ovMxLI8FqXk8SsfL9pdUMIPSeSEAeScGsQsuOwe6yTFuXBHPPm8=
X-Received: by 2002:a05:6402:518f:b0:5f1:e466:660 with SMTP id
 4fb4d7f45d1cf-5ff986a778emr6756561a12.5.1747317068107; Thu, 15 May 2025
 06:51:08 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 06:51:06 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 06:51:06 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250511141828.2367318-6-sjg@chromium.org>
References: <20250511141828.2367318-6-sjg@chromium.org>
 <20250511141828.2367318-1-sjg@chromium.org>
Date: Thu, 15 May 2025 06:51:06 -0700
X-Google-Sender-Auth: GT4e3yrvnp71jBA_kOs6XS6N54g
X-Gm-Features: AX0GCFsIKBXIz8hO1dEvVBeZSsvbykTnAarS1e-SOFuVwyhXy0jy-xa710k2Mks
Message-ID: <CAFLszTgeiPizUkCzf2=e6SfkXufTGenFH+-xD_7pew_EbP367Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] u_boot_pylib: Support a fatal level in tout
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Tom Rini <trini@konsulko.com>, 
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

It is convenient to be able to print a message and exit. Add a new
'fatal' level to support this.

Update some assumptions about the level, so that the tools continue to
work as now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py    |  6 +++---
 tools/u_boot_pylib/tout.py | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)

Applied to sjg/master, thanks!
