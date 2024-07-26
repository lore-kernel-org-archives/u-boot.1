Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008ADC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602C388636;
	Fri, 26 Jul 2024 14:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WCJffgkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C1288636; Fri, 26 Jul 2024 14:59:08 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB778863E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-66108213e88so19287877b3.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998743; x=1722603543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qeosWLI3+jedO7FAc8AruAQaOPvg9ZTwEfoNpAeSYsw=;
 b=WCJffgkxPKO9tuPjW2Qk/4fMQ17bR3yJhpVMmeQdKOJWwYcijpeb7M6ae2pqUcq4ni
 XHmE2NE+/RuU0zZW/mHZabZQ7Y2VqAFwFWaQeDpN6i9H/CjLu04iEML05+bH8+8L9+cQ
 TGNfPOg60n+jYaFLuYf6wHUC3QbqpCnmgB2Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998743; x=1722603543;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qeosWLI3+jedO7FAc8AruAQaOPvg9ZTwEfoNpAeSYsw=;
 b=pdvWMu1jZhaGASkjkTQUF5Ov+iWxFPQgrT7EYDQYbDaRmtIEmtGaZG9LJmT/G83vIJ
 OrxoOhOWzfqUWbreLmzWM72WfEQdNdkB64OehTesf2M0J47gvlWnThtf+llPyJAC7BTy
 Wa48SfTjYcPvPLljQ9GoRNmDZzjxhN4MjoSoX23oCrz8uIRCYXFKbegtZytVt3uB0eyU
 T7r92VXFsXBhz6cDY5O5tclSBup6iMygapy+4vLaZGGVF0dgUA7ziGtHkadQ/0W/ijSP
 fswt4WVfc1ULw7+MvUAk5qgLRsj1P7J+NHjgAV5b3FzC4FNq3F3Uetg9z1CyO5xNjmvi
 TJOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuUKZfsQeWZXjETVm+r/HHBjavdh4um+gxtkwvrwNWx7MPJZfdfG2PuSN0a7BW5S41eyQET+pKDGRMEgR535lZobIGWg==
X-Gm-Message-State: AOJu0YxA4iaG6kw1gHr4Tr3FKtY34AFyOYC/lxtHoLhWe9nAFC1AuPd9
 JH1pUVxx9mZUXt6tjFe0/PtYHbpaZ2uIAwDfTtPnh7GntgVVEwHrPCmdc8kDnqXNJiBwicgeczC
 ac5TABtJSluzmR27F9lfANB2fpBWKAoK6Nru1
X-Google-Smtp-Source: AGHT+IGrQFmWgslr5Y4/q2uV8xg+nGrdWPB1iAIfW81iYvdeNMMhy8woONHERefXnJY29taZyBpYYgumobqjXD61zDU=
X-Received: by 2002:a05:690c:498d:b0:65f:8209:3ede with SMTP id
 00721157ae682-67515f8b36amr70676357b3.44.1721998743586; Fri, 26 Jul 2024
 05:59:03 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:03 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-16-sjg@chromium.org>
References: <20240717155712.2913651-16-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:03 -0700
X-Google-Sender-Auth: XREkJ3vxYQgmftATincFOqAZZjs
Message-ID: <CAFLszTg4bG8rUChRDDA=5XX9iy7XhFudZoHzajrL825K82yBvQ@mail.gmail.com>
Subject: Re: [PATCH 15/24] qconfig: Move imply into a separate function
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

Reduce the size of main() by putting this code into its own function,
with the usage message staying in main().

Tidy up the comments for do_imply_config() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

Applied to u-boot-dm, thanks!
