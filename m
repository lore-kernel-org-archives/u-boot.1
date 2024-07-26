Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63340C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A95886AA;
	Fri, 26 Jul 2024 14:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MivM3Bgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4FE885B6; Fri, 26 Jul 2024 14:59:08 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A145688614
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7a36f26f3so5044056d6.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998745; x=1722603545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ltwBQiw8XLqPhz8BOfV47H+2w6LqXnxQ6CHnoT7Y9ws=;
 b=MivM3BguPaZBK4nFSK4qS/s3S2utyoQCi3H6/k/hYa9+oLgVGjEUWEUxEK9TDXeVfB
 OUckG1uYv/KbcYhp3eocouW0+UVZr8vQp8O+Gnp9xxc6L/ppAs6GUQzuUx0E2jFF9wLa
 qky+wweyjkYOrraUAvvI1UNNRSnBj0IUM9wvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998745; x=1722603545;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ltwBQiw8XLqPhz8BOfV47H+2w6LqXnxQ6CHnoT7Y9ws=;
 b=MvIlejxZjKevRQtdsX6/kbahoNDFV6ql39zF2NJYhGjaVW7z9ruARvpP/q9qSwKG4r
 M2sS36yvXuyR/x6wGcMAeg99GVzY25TxWppzZBoTNVFqV/IGkurEwCMKfLGX52QJaFdY
 NPUwe37WaOEz/nIopFIll6MTwk65PDkKvAiERz3hQpkun4EKCVwlcAg5L201FUOW5ob7
 //zjIMMShv5RLha2UytB8R0CMqv2MRSxx9hw6bgYpPqYUobzDzna76DxO5IBYbss2ROQ
 WxQBNRGtmMILdxxXmhhHr6UD375VtAqRfHepdotxqd1ChMU/CI7LfLqweK8JRfkmL/IV
 B6WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+72YAQN1qnH+Q5hZcUL3XpUsEeJXpwZxRStxqQ4mc28CIF4b+8JxLtIfZH9rNpA06AjnYUXrVHHMDu9QFehYk7PvbOw==
X-Gm-Message-State: AOJu0YyMo7r7xZNwRuvWm+nfOTdjzdvTEFDV4s9GhhCCWSNauCMKEITj
 c6y/N5bgmQOy2MVVHvlNuVfC/Lhz2hbFIfAgC4U01IgZgTqQe6aro8LcrU/wvt7LTNoULBcKrnH
 joKzfj6BDvFQhFQb36dfIWPITkO1rnEqiE4jonT8YzwHF25c=
X-Google-Smtp-Source: AGHT+IEmifjQ+jlFRuN8+pjxCau3ctKQ15vsBC/VbXXotGIKPILhraztznIacv0iAdq4xFh1pDfZOZU7Ds/fN1IR80A=
X-Received: by 2002:a05:6214:e49:b0:6b5:684:2d5 with SMTP id
 6a1803df08f44-6bb3c887d74mr110038936d6.4.1721998745589; Fri, 26 Jul 2024
 05:59:05 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:03 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-14-sjg@chromium.org>
References: <20240717155712.2913651-14-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:03 -0700
X-Google-Sender-Auth: 0R4P3NqQ1SrgemFVXpAIfzR0L1k
Message-ID: <CAFLszTgTgdPTCtkJiJSZfVnJRiEqKT=S5PZ935EwHY32habg=g@mail.gmail.com>
Subject: Re: [PATCH 13/24] qconfig: Move testing into a separate function
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

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

Applied to u-boot-dm, thanks!
