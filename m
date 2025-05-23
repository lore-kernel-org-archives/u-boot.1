Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41685C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8941D832BE;
	Fri, 23 May 2025 15:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SE/y0rGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7656A83108; Fri, 23 May 2025 15:18:31 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882B583211
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad5297704aaso1548740666b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006309; x=1748611109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JnZ4nRyP+lkQnGjxsOcCty5qa+m9ai4LyPtXWbk4bCs=;
 b=SE/y0rGUo8+wkpguGsyiM0a3rCLrx4Zf6R/tNV/25tWYAUsHvxNtWvIsbD2Xg9LN6G
 GTA3OT2fJOlLenDFmYxMkeBV5CPQbAPNRxlfv/cLCVCxJ15WAbMiAwSZ1MHgOofNSWjw
 YKxNCYBiCq7La9QkvpAqkfUDK8nYXgluBJ5x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006309; x=1748611109;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnZ4nRyP+lkQnGjxsOcCty5qa+m9ai4LyPtXWbk4bCs=;
 b=cFoRg7Ilv2TrXYVYWPT9AfgGTL37uwUGzYLtNo958NSeaL0TJOe6z8rjvsOEE1fGqG
 fSAaQcgmRn7muoAfhWJi+Htj5Nd56n5HikkzTAlLp0GWY2vPOq4xDkM+Qd+w9xC+e9Ba
 lnpX2NEjvFVx+btdM0dAJm122lj2MUd9qCyvN6C4SqYJpLbeJEp0wSQqq3a4I6cBObNt
 H74yHhnctaF1dv+84FmhRaDTHwvgFpf9dHJa6H6kJQ87J5jv+yiBbSXWpHL3LMnT4Cup
 18n4ubTNpOagXfaKvB2EblDUVIJTtSrGT2PWbyiwyMRqeH4sB1uRh4zuue6M8hKbenoX
 /EWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDp8dW/zLTXTJZEOH9UiPzFvUO5Ep36x/k6TNcmLj6UL0NVe2z6syufLsYsZa/1K1KMifsAWc=@lists.denx.de
X-Gm-Message-State: AOJu0YxSqWZyAoxtdoblrqHoKKSw9dw23QllDO9aZH6Ukb1ywM+sF7Sa
 eir/2+pfKoSGo57HWIB5+V+jZWsZ+goRbeaOh8SQ3L3vCIZ7Y309CL7Y96MjT5ZzXmLAwtson5o
 3ui0MJXXLT4GjWEIA5GziIPh+teJ1WVNmx8qmlHd9kba30rlMur54NG9U
X-Gm-Gg: ASbGnctK3JFfXWrekh/SUnsNO3qFzpipiRg/KEBnoEBmKJRa5UgCbmI2hdLci+s6s4Y
 /4TxpSaw92gwaaXsBffls3N6FRF3FuVjYm6UPIZZSFC1rXoWkmwqnAu5nMLWfuizPyfQSC0943a
 1La+N+7PAdLEMsWrUStEj1VDQV9EaeqLXSPuFSRiffTvAo
X-Google-Smtp-Source: AGHT+IHTLP1InCPOeR9cGA5VNmwRdmj7qPTc6K8FZEfTNZPjjz4wwhIHXQ8s5hANe7uR1yCD3+BO0y46PPtV1A8MI6k=
X-Received: by 2002:a17:907:7e85:b0:ad5:ef0:5724 with SMTP id
 a640c23a62f3a-ad52d5170c6mr2371002866b.34.1748006303954; Fri, 23 May 2025
 06:18:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:21 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:21 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-27-sjg@chromium.org>
References: <20250504132356.2317305-27-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:21 -0500
X-Google-Sender-Auth: k5U4rDrfncpBONuKkv5NBSsTbn8
X-Gm-Features: AX0GCFtnMQumWmeyb7TA2tiOllnoOdUD7d_00t4mFcDcO0fKWKGvK1mvYzYBIZc
Message-ID: <CAFLszTjwW9F7enA8=9YvhtSVerkLkd=uOQ-SEzF4K0buu3aC5g@mail.gmail.com>
Subject: Re: [PATCH v2 26/30] patman: Use defaultdict directly
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

Import defaultdict to avoid needing to specify its module in multiple
places. Fix an extra blank line while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/status.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
