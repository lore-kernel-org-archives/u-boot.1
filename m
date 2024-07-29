Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE65C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EF288914;
	Mon, 29 Jul 2024 18:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzX0g/3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E1A8882D; Mon, 29 Jul 2024 18:19:38 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7B088871
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso19795236d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269975; x=1722874775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eY6zIHtR/Hkw4R4zll1+M+m9Ncg0SLuvcKjrMjrHm7Y=;
 b=bzX0g/3Iu3nhSE6keHHZ+0uWsZybOrRmJO/OQVDJP+Z6K9kmk6UwxI8kcZGTg9+Tch
 P/sKYafbRdeGwqtyKIGiw16SqUMhMwrJCVAkfz9E6lTVy5V08Q+5Mu3K9rGbHfk2avzQ
 zc/cSdPkixG5E2UD9eQ0+Wzo10FgjeqPZBawU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269975; x=1722874775;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eY6zIHtR/Hkw4R4zll1+M+m9Ncg0SLuvcKjrMjrHm7Y=;
 b=gpkJ0QZKTRiVkVBOdVJrcM/sxr9t/HKEv4tGFropwnUa2l8L71H4CHKtBvUX8wGdLB
 lFuTHTexzFWc0vKCYpooqr06kQ6Ne3yo3taYy4OJGUgYDMOLTQUbLitG0kZMONiy5+Re
 2TVIgK+qbLAFiGSKi7XONyL/LOdnbkmuX1c7vziLCks/wTShPJlefrLXhpdduEkQsjHQ
 9BZNKPd3xKqDleF6oz5t7IayCccbUHw2ErCEvOl+sOEk51adD5iNcmqddDn9PcRR2Dlb
 w+F0V48yo6JeKbXEr5PAn2xRUPy7jSZO07vV9D7rAgdJVzqfN8Zq+UaR54zabD+hAInT
 YtRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqB/RjK/a4ti2Vc8LkUUu/4Zear9+mVS9CUWVWCHoQHCHYsjDTxHT8GXsvMVmZeB7hqeHSAc8lamNGQbGSNYEaGsGTug==
X-Gm-Message-State: AOJu0YxclokTz5o8tsDUWbVanC0o+S4RmBvJvY2EQooM2BaL2gtC2iCG
 QYcccxzRXIyX8LoGdk5DSA/JKKCpAMANtmuV4K1BKFIu4vbZIdh+3+JNHn3amUvBzwlaqA/eI9r
 E0VGkVjzfbVjsfmcZNbTbgFvc8vA3wMYwyOEF
X-Google-Smtp-Source: AGHT+IGNlQIdnJCz0YEjTiN34b2xXGKTsoaJgU6bXITUAv5sA6b6Jrp6hQm0Wr0HtJQUD97FQJCG44U6mS0sFMejE3A=
X-Received: by 2002:a05:6214:2609:b0:6b7:ad38:2df3 with SMTP id
 6a1803df08f44-6bb55aa5049mr94230156d6.39.1722269974725; Mon, 29 Jul 2024
 09:19:34 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-7-sjg@chromium.org>
References: <20240720104950.2730773-7-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:34 -0700
X-Google-Sender-Auth: JgKX-HEMEEsTMNSrxIPe3M4Rquc
Message-ID: <CAFLszTjY0vpfC1FD-08fV-u1JBHkfdBxwUS-bbJZhNC=XJ=YzA@mail.gmail.com>
Subject: Re: [PATCH 06/20] binman: elf: Add more debugging to
 LookupAndWriteSymbols()
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

When symbol-writing does not appear to work, it can sometimes be hard to
figure out what is going on. Add some more debugging to help.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/elf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
