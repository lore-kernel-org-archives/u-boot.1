Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E463FE7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0783F8763F;
	Wed,  4 Oct 2023 19:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dyEXRO9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818B28761A; Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7457875F8
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso19333266b.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442315; x=1697047115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LWSD9AUTiq+2ap92w7PqNGSTp11CIKbR7Yobnib78IY=;
 b=dyEXRO9u+8VW6s+QpylKgJBJQ8SK6YB/OJ0y9gP8iTV4pKuwE8j5rhUcwFjPzOKcRY
 4mIralk+wru7F15YrVVTAwTJqckR0JEaeXLX3szZI0BeWvg/3Aqa7aMciZg1/WMLUOqQ
 OEZebGOB1LnTL3f2bQuo78jMVL+r3VWU1tDs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442315; x=1697047115;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LWSD9AUTiq+2ap92w7PqNGSTp11CIKbR7Yobnib78IY=;
 b=be71wtpg8Go0epsGLZS7oKtb71dHP3rSpIm6pFeAMW8vRAIydqJb+RFE/khWVGU0qV
 8E7+J8j/uwczeAq/fEmatfLmpUGyxxrYjtLWmMw03cVs1d/CKxwJ30cRijulG+MwOyUL
 V/Owp1q0SgFLSnQhsJDkiAMGPd9qlDfqAwXtu9hypSLceOArLOSJAnJfOXshoHjmEu/f
 7sa12TNvnStlJHOH4iZciPvA3RO1jYKNGM3Rzkjo0jTwsjb8/gy/OjOq6MQYTpqk48jC
 bGQQhjuCzrKroSew1cam09aOfUwpYgGOzzUbO5OguQWxZycN6p+0jRed1M1U6bVUQVTf
 7O6A==
X-Gm-Message-State: AOJu0YynFjNL+lz40FjhrgDF+71/utqBngSNnhUt/IT/ufQpvuidB0rH
 jLQuknXjgmxg+Kof//QuCDCArKHzLYu2qox1STZa+4h4EMj59opD0qM=
X-Google-Smtp-Source: AGHT+IEV/anJ7Ee69CyZiXHiswLAjrUrd+znqhGvN4wTobnNq8p3Ufqkdoi3vAIYTDdX9IqGYdrKeqiedfrMiw7akqc=
X-Received: by 2002:a17:906:308b:b0:9b6:50cd:a222 with SMTP id
 11-20020a170906308b00b009b650cda222mr2480221ejv.54.1696442315371; Wed, 04 Oct
 2023 10:58:35 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-15-sjg@chromium.org>
References: <20230923194424.1739224-15-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:33 -0700
X-Google-Sender-Auth: FoZuYjG20uzp5PlXn3FDUY93r6o
Message-ID: <CAPnjgZ1d-FyAVcXWzBtJBsovp-X+ZPUDMeCGJkowWREcRUm+5Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] moveconfig: Correct list-comprehension warnings
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

Correct some pylint warnings about needing to use list comprehension.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
