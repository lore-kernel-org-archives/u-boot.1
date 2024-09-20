Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E32CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 354E988D02;
	Fri, 20 Sep 2024 18:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h1pJa3Wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E913388C90; Fri, 20 Sep 2024 18:01:46 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D976688C63
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c3567a143eso16365036d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848104; x=1727452904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c7aEtJdZbncElj4zMlN8yrX8PpkDE7qC3xPH2pIRkdg=;
 b=h1pJa3Wz8DMayMFHIL87UteAQ5Jk6gSi3ZOjuqJLKuCptw2DdoJHW/trhEQ2SpFIhH
 8P/6g83skWDp5oh1AAFjDBAQyimfVr3Rb3gujZMgOfrL5526aVVT0ViD/2fvqkxFXXkR
 J2m4JtVqT6z8co38T0ATc+GdRsJ4r03Kbh7w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848104; x=1727452904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7aEtJdZbncElj4zMlN8yrX8PpkDE7qC3xPH2pIRkdg=;
 b=lTibWYjJeHiOJ27p2IrlUINwGpIs7BqZq2U+sfhrBKRuRVcFKKh2o9tdrFnBWHpz2K
 xpUikyfAeHELERIFNuSPnX9JwP952aWTmNKfumxjx3oEyoKiBjKwS6haJjtb1egvxwe9
 iVfCYaDALL4fc4lW3Hagu8v3GN3aw/EP4GVLcqHntI4Mq1RB+dMKClbAHoyTCDxhvMzP
 FWYltHWaDJb7Uj0TehQFtC46WqhXV0jhoyS020ynvA7edPuYpipeLrPtTtq1WMRWdcVW
 uTdP10yM1LzpBplhii8CAXE9V/JWtvBBeDevHMd8xPxCYbhpPlz53r/Z8pC0JE1kCGCK
 P/DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfQAIrY8FwdaAeAG8D/PnrXFhUh4rRWJSI8M6fYa0KJHf1q2Sq9OtXbSgOPCPuQLXCQLNsi4I=@lists.denx.de
X-Gm-Message-State: AOJu0YwnRjk+oAJB6/ZOgbbHO8dgwnDaUcLVLN654Ce7DAwsame+o5o2
 rKGS9PCmHNPL9fYFFi5rCEV9Y3IkVphBQ8ORgvpOVXObnRaU5hsxoew3mfW2WS3B6hykYL0j1x2
 j+9Ct43yrqQtsZNQySUnoqKqawhlI0gNLwn/+NpSQgKOKE+Fc2aZv
X-Google-Smtp-Source: AGHT+IFyXcsXzTDowuZavVnXTTRcfclI8nJfcbDC40WB+hSuUgC3z3QBLEEEMXvF88hTbl1CKzgGdgkaU/6TxyIJX3U=
X-Received: by 2002:a05:6214:2f0d:b0:6c5:317a:a664 with SMTP id
 6a1803df08f44-6c7bd46c895mr52525086d6.3.1726848103758; Fri, 20 Sep 2024
 09:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
 <20240716150616.349466-2-philippe.reynes@softathome.com>
In-Reply-To: <20240716150616.349466-2-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:33 +0200
Message-ID: <CAFLszTjvDqDfV9xNjdgqzOBt2hKRu_WWJMpVS8kfkQLBtzt7cA@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: lib: add test for sha256_hamc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
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

On Tue, 16 Jul 2024 at 17:06, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds a test for the function sha256_hmac
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hmac.c | 108 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 test/lib/test_sha256_hmac.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
