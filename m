Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBDFE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F63086E8B;
	Sat,  7 Oct 2023 22:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJQfxeYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A4186DDA; Sat,  7 Oct 2023 22:37:53 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6376E86DC5
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ae7383b7ecso966056966b.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711065; x=1697315865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QTZMfI9RNEflbpbZzxg4NgKnaXO7j0vbqnG58eCOLw4=;
 b=gJQfxeYQ1K4qe/xBKTOErpKsBCAQux31kF11jMhh2hamawzyX7f/AKppgJ6d3Rxo5a
 BUchB3iyW+WO500oBkVkkZTafwSYLbekf8WABZSvnhobTImH3s6z90pD5Lm50drAK/Ta
 Kj3oupZaH70NWfJeja3GlTUGrQUs1ADt7lS6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711065; x=1697315865;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTZMfI9RNEflbpbZzxg4NgKnaXO7j0vbqnG58eCOLw4=;
 b=DPAgUITAwWdJzmYx1ncFlvI9nestR9CdcK/HrcDXFDFPjGlKkZMJVsSwNs0Jk3/Qug
 nBJZREP22has7quYs2358hgzSB5DfDSs8xPqlTpqDbnax//95Y5lgOci1ztSXDEfK8GA
 oHwi6ViZ0yzlXHL+AgZ3Rt3Mdv4kkzMjUVtukZo88NGMnv9zNvRUns1bXibz8eR3hvWD
 gg7pHmkz3VDOZydohgEQnbNc0REsea3m9ahy8/ZixHEUCk6My5qDcjmQ5O0zEkxazwLj
 yyECOTxXCvg3NkElp7hX7GBoy4hf+/4Jt98PFjaDDw7fFQrVf5jHwZ9Yrxz1m16O9k+d
 EE1g==
X-Gm-Message-State: AOJu0Yx7aZp69CT4kNC27nsNjsTWhMbr4cGf596XwKooO3ieUa3ouuOE
 UCjBcHhvq1jSXk/YrQevl09e/dw+t2XdU00AaH4DZw==
X-Google-Smtp-Source: AGHT+IEQPBTRaopqP21ptbcKqDd3xrh3EWhZgfr3cX0fsmECkWPbQMlWDSDJSM+nXYu0B/qABy/ETUKBMAUuvceOf58=
X-Received: by 2002:a17:907:9616:b0:9a4:11a3:c32b with SMTP id
 gb22-20020a170907961600b009a411a3c32bmr6015244ejc.29.1696711064632; Sat, 07
 Oct 2023 13:37:44 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2fO-2yeotg2NDwnFfbyuynBtQOoC5Q+CzfwLA----79g@mail.gmail.com>
References: <CAPnjgZ2fO-2yeotg2NDwnFfbyuynBtQOoC5Q+CzfwLA----79g@mail.gmail.com>
 <20230923194424.1739224-22-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:42 -0700
X-Google-Sender-Auth: MsrN4ai7hZGcmaJBqBiezLYMZcE
Message-ID: <CAPnjgZ1KPOR+dLhRT-h6Qd41rxY7wpeF9NtfJe0pjUOuaXB0Sw@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] moveconfig: Show failures in progress
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

Show the number of accumulated failures when processing. Use a shorter
format with colour.

An unwanted space appears before the defconfig name on every item except
the last. Fix that while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
