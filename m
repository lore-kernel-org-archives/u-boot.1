Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E8FD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455AE8919E;
	Fri, 18 Oct 2024 01:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IDV8C3q1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC0D8912C; Fri, 18 Oct 2024 01:12:10 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BD488F23
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4608e389407so18625641cf.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206727; x=1729811527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c9pb//xZ8E+sJzk1I1r0ZKnx1Kj1fPJZw//NJf85CKI=;
 b=IDV8C3q1lM5U95B9jZs8o347jVjk+utwB9/0WhhJhnS1ThktOmFgac7g+BIr9SQXvQ
 +ShldCKwCO4N+Yr6SWAprMPee7i3e9J71TWoaSJr7tJvZu1P4E0cGbTsSOMXL+phy+JH
 1p/Lmf2v1f4sJRT7FzzJsxk/UAlRZqxSOh4vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206727; x=1729811527;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9pb//xZ8E+sJzk1I1r0ZKnx1Kj1fPJZw//NJf85CKI=;
 b=i6mDRLYKJO4TpdS0hyYMul0kAQKgngAfTJ3eq6HLB3cnA2rYHT22dJZbP9PGFNf9Wd
 fEmMS3LwyXP0TT55uCOL/r2S4cAqvpqBWejbhhGYW/DwEg8c/r4u79b7M//pDeiqnXoy
 LdxxhiAu7RuF0YWUYX+at3x65idcCw5YTr7Rp+cYJvnK76tBgUsrfWAhOeON1R9Gkg6/
 BXTHN5qioI9DcQiqPryJqfqYVDdNecxZqY6c6gFXJy4eA8bkwo2sSHPy1HukOTgbrS5Q
 06RxBRHbRGVEfxs/HGZdQ1tZtwYhw+Z1IBTqtujhmmK67Wp38t2vbBK5usILetDtaQFd
 OJtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOSxPMG5WOQSOVOMEeR7sjDIOXVwC2Oh0BA89M+6smLBixXl4wNn3G9MY6gyyd+jKmlMzFypE=@lists.denx.de
X-Gm-Message-State: AOJu0YyS1EaQEWcz0LKVosEG1QXB7OEj0845TrLd8kxxrMpq5Sa+1kuM
 wDpPxeNwGdO6Yu8PHlgc33CVx+vVwSKyuObMIoTDw1MA3QZLc6UyzH1Vu5tWPEVvJGNdEUaJlHK
 9oUIqRkz7saqDaVsOC9FGgm0DmFD/CXY8Zwu5
X-Google-Smtp-Source: AGHT+IEd8+Ja+dIuexDgOpWIAT2HRni1OV7wxAzJjF/Betl/G/sNAs2/rLwjYS7tukh0tIbeqU+3kXDVaqF4jpKKz7M=
X-Received: by 2002:a05:6214:4589:b0:6cc:41ca:be36 with SMTP id
 6a1803df08f44-6cde14d7542mr8674906d6.15.1729206727548; Thu, 17 Oct 2024
 16:12:07 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:07 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240901222734.462334-2-sjg@chromium.org>
References: <20240901222734.462334-2-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:07 -0700
X-Google-Sender-Auth: t8AZJZFwEepYkM9Fmljc4pcT4EQ
Message-ID: <CAFLszThZPYq=kM1R6t_unAED0Z+dD8VNb1dcg3CD=_PYgNTpHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] blk: Make functions available unconditionally
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
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

Some boards still don't enable BLK but we want to be able to at least
compile the code which relies on this. For example, bootstd includes
calls to blk_...() functions, albeit with a check for BLK so that the
code is eliminated by the compiler.

Reduce the scope of the BLK #ifdef to help with this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/blk.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
