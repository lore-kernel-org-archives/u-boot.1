Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EECCCDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B1E88F66;
	Fri, 27 Sep 2024 00:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k0CYCVXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012F788F4D; Fri, 27 Sep 2024 00:07:37 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331E488F4C
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso1244033b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388451; x=1727993251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b6vlU5OTrzR3Hz4ULcwHfsdH1mMVggcgO1Jn/V7hlcE=;
 b=k0CYCVXpa8GzcSA2TeyHv9BEmWvwRwpmIo1lw6OLlZoJc4UqSTqhEMMqAW0aVrX89N
 ES/8uyyD6bkOQML+cjoGg0BORU8gfy/1XZUXE3Ch8sduplf+PVErVY0SvS33lKSrEFxz
 SzTONaH9ppxfk2mQ63rsfwBvHOvGVSRtexqy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388451; x=1727993251;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b6vlU5OTrzR3Hz4ULcwHfsdH1mMVggcgO1Jn/V7hlcE=;
 b=xIvMb0boa5sUwBO9Fm8oL020rNvvZOLkH0p6nIMdfix7EkkhanylMeJMIBwSY8UX9G
 ItThd1EomPWTg1wbekjxGpoQlYtO3Bl7OmaA9IP9B7NICEEGGPgLUV8U9DwXCQT4LtA6
 +gP8EdaDeXRilp/MpWrW6SF+1NXMLgkPCmXIExRbdmLpCqTFJWMLK375UcxS4uQ5kvLw
 Gvz4PpIBoEu4mir4FE2fu7+NMnbl2R2LJ58eTDVMaPv2OOLcOPVR3nzm48jGMA2L0MS+
 e/nYzSTug9wKrI4qYyaSE/zyJ58w3mn8FqL6gSs1OY3p4nS2MeWS7EK6Py8LoJcYBSC4
 4gNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhAahegUuh4u+wp83TJRBraKOez8UOP6pFhz+5Y+Bn+04STx5702tz+/UxXdhQHhjgy4V3w0k=@lists.denx.de
X-Gm-Message-State: AOJu0YzwPxXdjG8WcwtgfUaIOBsEwXZtxytEQtxZoPDYdbHSWqOk1MqE
 8Jl7TkvBXyxX3vqOQlFLZGi4ZfSZtQKNGEHZMxkeZaSXTS5kGsjSMUa56O0XqUh/cSmrYHTCYGG
 374CfWF0joswDNiRZkwMvuA9nrDlgPNRKgkRd
X-Google-Smtp-Source: AGHT+IHS3DJmyPn8FO1CNpgmc9jtfGpjNoQViRuz++YFKx7vMtQxsE6UP+2PVOS+Imq/d9vjgvmQCgBrPuWlDfCTcrk=
X-Received: by 2002:a05:6a00:9a3:b0:714:2014:d783 with SMTP id
 d2e1a72fcca58-71b25f275aamr1834818b3a.2.1727388450725; Thu, 26 Sep 2024
 15:07:30 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 18:07:29 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-7-sjg@chromium.org>
References: <20240826191143.426387-7-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 18:07:29 -0400
X-Google-Sender-Auth: ampKnQzrZNz9xhEUgbRS4uHnS1Y
Message-ID: <CAFLszTjOEi32-zP9a2XwkuJ_RJEiEmcaUjKupM+uRXbaKF8NUg@mail.gmail.com>
Subject: Re: [PATCH 06/15] binman: Update fdt-list-dir to use the provided
 directory
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Since the files are known to be in the provided directory, use that
instead of requiring it to be added to the list of input directories.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 10 ++++++++--
 tools/binman/ftest.py     |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
