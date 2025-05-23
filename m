Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC914C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CCD8338D;
	Fri, 23 May 2025 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i2ybfFQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873EE830B4; Fri, 23 May 2025 15:19:10 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6058339C
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601aa0cb92eso8413321a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006348; x=1748611148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xbYu2W5bOHqpuY/LkKq/Bou4YTTHffRex/c5V8tnH7g=;
 b=i2ybfFQDE5is3sje8mbDdFQYIO5pTVuT6lHKL7m6s1/0vuEKONnVAx1EmcpcG5wmUQ
 QNCc/KuYOr4yd8u0eijfqEIifJwV5R/259pPiBrdUgl70hQcgG8wIGfhfPwwNZ6FtJNr
 k5eDwTdRDegZ8f9B1Mi4lXjyrszEFlrbSt1QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006348; x=1748611148;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbYu2W5bOHqpuY/LkKq/Bou4YTTHffRex/c5V8tnH7g=;
 b=Ar83aLFJXMdMrW9hGIwAI8q7WRfmQy74vBghP2E1lWscgMfNp78bfmAtLb7CDokKWJ
 CC9Bn6LAzf0F2rrYFiFCzGRlsUiLAAgANlYOO19IlhIRZhcqXpsYhumnUD5+5R1M+5PZ
 U7G263tHQUn3NJeY8lYilK+oFmO9Wz42lyEZCh32+fDYgjU8F7kVnm3U1K1C/8AAQqja
 TQzdhecKPOElIQLqJqMYc/mcmiZpg36PVXD7wbk06rbdJ8u8TNQ1IqMPJ6pwFN9e3qpv
 pX1L8rzdbm+KCUGic167Q9KDBiZV72ppwAOhhz7W7h9ZDHUDomC/MF8wAtZqe8aCfIOL
 JA3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS4yyldVs3i3mnslJ8/RFd7yHzSQGHdauYRN04CLjnnTswkBjoxXvqI3XIaY3+LKpBum9aejE=@lists.denx.de
X-Gm-Message-State: AOJu0YxAwooiSVMZpbFjSZcIGIanXGA7fTE+PtzVGc1JSbDB/dvXm/rN
 eIo3YEArPyuYCWyGTUMIZPaN4WUZRs4autWM6i8tP3iAu8V/bC/ZcEpTYGv/Kivvp3jw0iBemjX
 IyaA+Eud2veuM/0YglcNpWyVTWvGnpxgLzg1KKdYK
X-Gm-Gg: ASbGncu/135J6YZgd7cVC9oEsw9v/hmgWB0H2+YcS/gotsDE6iapwW+P0vibtGnFj2i
 gmYTl6TxBj+L0lDYbQHfOBVspxL8JgtoPAehyV/+ZOUIHppIcDpbzFkL88UhHkEsc5KmyOW6weF
 02p0HvsNs0yHViMzX2qQUwTdp1l9DhS9G2yw==
X-Google-Smtp-Source: AGHT+IGCbpTWy5s/dhoB5T4BVO31Yjtm847s05FXg3l7J3JZ0BFbULG3+lHIAXfEkokaGdbBKaRkmO6Ihppm0Cn3EcU=
X-Received: by 2002:a05:6402:2790:b0:602:2d06:6b21 with SMTP id
 4fb4d7f45d1cf-6022d066e76mr10695417a12.5.1748006348065; Fri, 23 May 2025
 06:19:08 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:05 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:05 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-11-sjg@chromium.org>
References: <20250504132356.2317305-11-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:05 -0500
X-Google-Sender-Auth: eDJezQ7kIf1KdDiz-cWxHEkIMLw
X-Gm-Features: AX0GCFvczZLx28tLWj69BQYw-sCCMb4YdUaiwLnQPVnI89pDEGC-xeMYiwC90u8
Message-ID: <CAFLszTix1BjjWaw5kUF-r9VxO7tiZQYCvmyFAQFDEXn8RVQ+hw@mail.gmail.com>
Subject: Re: [PATCH v2 10/30] patman: Correct a stray quote
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
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

A quote character was added a few years ago, but was not intended. Drop
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
