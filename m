Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD12D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B3A891C2;
	Fri, 18 Oct 2024 01:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e9DlBC6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE6F8915F; Fri, 18 Oct 2024 01:12:26 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424BD8912B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cc2ea27a50so20386786d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206742; x=1729811542; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uUHqQfVU4RrDUYRW64e+JFspV3BUcd/tfMKrRF22fN0=;
 b=e9DlBC6ci/0HDFR+Sq9fdcmxyS98w2bPW8qJ9fUD1YzwGnLbJsJ0fhJ8XsXc1QI/lz
 3vtuGniIMIgLmCKMt3XzCqhqxGQqiLBLJUCqlqmmup91Syx2RDuuieMRFtf1W4mgoBy5
 nbuvt5qQQp0l30Mv0uIO3oys+HqSkHZbxFXuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206742; x=1729811542;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uUHqQfVU4RrDUYRW64e+JFspV3BUcd/tfMKrRF22fN0=;
 b=R/8PekxIWxdHUVFBdLHsKwuDAbJMyg2mOwqbiTlQaLfgzX9xOu3blax1lwJeSTOuQU
 8Fh39YaSW0Epr4UBY9ouwcQriHykcfyQbw3v8zgwwOQ9QTSJyUwAGmgL9f4teMfmQ5ol
 QpGLrIV8D0DYSEri4QwUDxGzfSO0DN/zabt4mL8a4nDjIeE/BsnLmgrnrvv3g5NV3z7W
 k+yNeMHVSSe6J9xMigOe6dZ4Hs4+NnJTaONp57y2fC8DyHi7hZUh9R3OuBObN864oysQ
 9ItWNUNyDor26uGHsv+0K0eKDFFivlGzmla7ExQYVpOFWxIm/ciY2LThpMEIe86EibIP
 9v1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyolcmmzuC52hyEzfFprWPzbiHIKPGeKlYQEJSgfPXcYuDXjbxVs5COMhf0VuOQvC6yWOyRC4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8ZDEE8UBLvr1NLFKc5oF9aDgK6glEOMKjyKmtFpw56mbR6Oby
 co7tf8HRqjRGngY1ZUkFemRFBPJcW3ucMt2rtmGk7mcVXXARsGK2G0+Q2SIL3FFOHrceSmBfEN9
 Rrtcro68ox7m9H5DQ3+ng04noELIt6kGHUUPI
X-Google-Smtp-Source: AGHT+IE9X5En0i5CPXnu0BsNYBauTOq0AhQ63DW6jNMtUIWLh2nHb75VmxB31kCVy4TabDV60isA+f59aQkI+fs9ocw=
X-Received: by 2002:a05:6214:5781:b0:6cc:44b:105a with SMTP id
 6a1803df08f44-6cde1b5d08dmr6111626d6.20.1729206742206; Thu, 17 Oct 2024
 16:12:22 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:21 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240108001455.35638-1-sjg@chromium.org>
References: <20240108001455.35638-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:21 -0700
X-Google-Sender-Auth: fg4VAo6YwjNylHQtVtaE3O0ijNg
Message-ID: <CAFLszTjqib7JkoRAONrMk_DXjW4iQmgi9fac7XPyGBKBOE3=1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: Allow querying the font size
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
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

All the font size to be queried using the 'font size' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/font.c             | 17 +++++++++--------
 doc/usage/cmd/font.rst |  6 ++++--
 test/cmd/font.c        |  9 +++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

Applied to u-boot-dm, thanks!
