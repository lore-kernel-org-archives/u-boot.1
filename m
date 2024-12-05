Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01519E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645F989549;
	Thu,  5 Dec 2024 20:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CZJ9xw1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B70589568; Thu,  5 Dec 2024 20:55:44 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA3B8903B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa530a94c0eso272751666b.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428542; x=1734033342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1hSQlybVd6pA1ptplanlwHNctr1lmi0TvWKOCi096LQ=;
 b=CZJ9xw1gS9cuqIqnLzU3v1ONbGgUrJK7yJKQd5BWA4tTD7LFO4ev8bNkVJyEmC2Q8t
 Ul/U2DqlXqkGgvqJgs0I36KM1sNE1J/QkzLHLMkwYwbEcb7MzOZ1ZLq5lXGpjNoWxzB/
 Yl0+UfUcWBzSU/R2SjTn7m1U0w8TgQzzIyBqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428542; x=1734033342;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1hSQlybVd6pA1ptplanlwHNctr1lmi0TvWKOCi096LQ=;
 b=Ivc7lvtM++YJJMJDIwW7J5ElW+5nLmucPIiSs0W5PRisVW2J82aG1UsTazgEGcZGNj
 PsHGIFyYsL7gFFtdqAZfeVI98b+yqnoTzacj7I0NCwDyv0ghan4ket65ljKMKMyrrpZA
 6mW9V8LPfHlnO+ct6AmWN9zPQJzmLhEccAgLUKxC4uLVo0fWywJyUdJHKCsF4GKKP0Vr
 Orj+FYm+OaUUdi/J8sh74FFgRUfuj9Og/rCFN0rCjp24ntXawzB1daXorG9i3GnHPN9x
 D3PfhdMeH4mKFBjFF2OqHB1mRs5nvNImOUumqe9MERBvFhNCyb1a1y/0cbSc8nOtnOpd
 Jz9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU83sA/D2pbW5RopT9oWTVfV7qpsEO23VG5ktMU4qal51pxW5sNP44qu8Os/0Be5dVGdot4e4o=@lists.denx.de
X-Gm-Message-State: AOJu0Yys/WGBW36qmF7V/P8KRxnVBEFhVZKnbzSEpg3uMHvY5eRDYREU
 TA8dxZSysU8IsUBzt7jL28JV3Ww3GY5+WL3Ze6A155r38yoDsgmUcPzThedMRvVXFLhuyTwHUr9
 rBnKeRvgcLw8ARIumJCzEA1VuxQGPI8MXFQez
X-Gm-Gg: ASbGncu3ida8QlCpS5cf/Wd+Iq8pzu3k3KlaNYVJiewd4ScnvEgvWaaYbBYtBU3s4ci
 81lxG+szfT22EDbg4E7gVROkbgSO9eNhH
X-Google-Smtp-Source: AGHT+IE/wdntTlm2LKZUp08d6r+TfL+E2h13XAxAnY+ro742PiEk37a+HqBECW7OYGdKi2CKgvggyyXaHXIH3hF+OEY=
X-Received: by 2002:a17:906:3d22:b0:aa5:158a:fc18 with SMTP id
 a640c23a62f3a-aa63a0c43f8mr11008066b.31.1733428541843; Thu, 05 Dec 2024
 11:55:41 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:39 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-15-sjg@chromium.org>
References: <20241115231926.211999-15-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:39 -0600
X-Google-Sender-Auth: jhsMtIbk65bShCBx1N-udyAOWng
Message-ID: <CAFLszTiUXoVjKwhbZdy5Rvxc1=AC-O7-iWRBixL9=ZW9ccNH=Q@mail.gmail.com>
Subject: Re: [PATCH v4 14/19] Update bootmeth_alloc_other() to record images
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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

Update this function to add the image to the list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use the helper function

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth-uclass.c | 6 +++++-
 boot/bootmeth_script.c | 4 ++--
 include/bootmeth.h     | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

Applied to ci/master, thanks!
