Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEC1C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED04F886A6;
	Fri, 26 Jul 2024 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jP+eJdlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D2C88636; Fri, 26 Jul 2024 14:59:11 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BF187B84
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d5b850d969so583564eaf.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998748; x=1722603548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JNadZdhEfCLBKxf7595lp/+iwLzfvuCUcq8kw593ceI=;
 b=jP+eJdlSWL36gxBQ4F/QYkgi0o8pSjUUPpTwtv0uNmXgW7r8WV8nklXIXyEfBQHBWX
 i4y3L/Be4ydLGbzjmi9VFd4O2ZQFAnh55RiJYYcvcdBsqGDybknQNdz4ybQIE+HtsAaT
 rd/8CBTWCIAHy1xYmL9A6lkrxqLvJOLHOwM0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998748; x=1722603548;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JNadZdhEfCLBKxf7595lp/+iwLzfvuCUcq8kw593ceI=;
 b=Ulr3LP6DmS3ijEG/es5QPBEU0mG5bUd/t0C5lOUIFJpK5bPrQ7dZjbabWyeHWrfj/c
 QQZx4eqAq8U8i2lUL1NrwlTSlgJmM1/iJwtLIW0T7o26MTL9Rqqit2WibOpiVyrc4loj
 S78fmOS3XNTc6ExYBGPLtc7qPwQxoJAVUFtXMODnAstwozvWXvz/knX37EqzW6x+mDth
 BIJGyPr5mERuBL4rZ+mWlAnCMrh5d6pQOT33zWKuEBTxFJxgWSK3T8V2hyWBHsId8E0H
 Fs5RsPISx1Psy7YyoYGPz4/q00sQ5PnC6GqfUks4r/9NmwZm5zT4RVAr5F29hYjLxJVb
 KCwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc9HypnsBfWjxzfECe88CcFdhyqaF5b0l2Fe3KwS2HEE8U500w5bYjdJO0KO3e7dA+z5LAkWvCWFBFxBwk1sYbCZ9pXQ==
X-Gm-Message-State: AOJu0Yx/uNdWfbvB6wyCmIfUPlOZ95x8O3P71wBavDNvGa3VWUcXZTDN
 qslMYOEZ3PnHrGpk84Fuftv0nH6/4KqyE7tqotoEFYZpvtd3BsA+rcEHZ5QFipW1D09ZvJX1XZ1
 Rsm9OJ8l3qu/o52ApMaIQvln+jvil3DlC6TKE
X-Google-Smtp-Source: AGHT+IFrVN+udR3RPnDRSZwcXXBGYQJFhl7FG7jh3RLrxcbjDVtWdCTpPEXVUaFT4xkfKSZ9i7UPvfy3LpiFUzhMAN0=
X-Received: by 2002:a05:6359:4595:b0:1a8:c0fd:cf2d with SMTP id
 e5c5f4694b2df-1acf8869b8fmr791172755d.9.1721998747908; Fri, 26 Jul 2024
 05:59:07 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:06 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-12-sjg@chromium.org>
References: <20240717155712.2913651-12-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:06 -0700
X-Google-Sender-Auth: zBq9dpk86B0XZfLDuldptV13xyM
Message-ID: <CAFLszTh9YZ--HUdaVjQSEnxH2m6EQSQYiPSK==zwfAxQyoeOAQ@mail.gmail.com>
Subject: Re: [PATCH 11/24] qconfig: Move checking directory to the top
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

Move this check to the top, so it happens always. The tool should be
run from the U-Boot source directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
