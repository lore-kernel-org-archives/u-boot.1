Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247E2C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3338183416;
	Sat, 24 May 2025 06:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MkLdBPgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF5483477; Sat, 24 May 2025 06:25:18 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7B18344E
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60410a9c6dcso101121a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060714; x=1748665514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hpRYLdjPi+wPQx0Brqm24Gn5u6bPi5M+ozyrLlp9ghs=;
 b=MkLdBPgPlYg9uAymWCvVmD+6lxRFxkKAy6jaM/1R12FSxis0e9sJM9ZdmlBS0HF675
 9DoAHk8dl7Sy1D/L5IDcvyfTZp91YH1u8mX2WTh4Gk7rVL76h/+YL336SvdQHzbF2t6M
 OAUvEIQOBDSCylPhsF4k5vE/BuV0eFe/gvmZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060714; x=1748665514;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hpRYLdjPi+wPQx0Brqm24Gn5u6bPi5M+ozyrLlp9ghs=;
 b=qPfQ0jVKFp+cMte+cbMlibCS1hXANWpVv0W2zg+ScHFbGAGiN5gNKlPxmGvPnk5Biw
 mMvhf7pOlIn1UIkD5Y2vSvwx12WaptcotTpNbEv685DEDccKVsauYQUo+dNvu/oCVi4D
 Fz9P3MVAGaxC5snN2Tizu/xkyFrnvCCQpzMRuxi+ufywd2kP4pUsTl61GxWoYKRXL3Ow
 iG9k4r0UIehlmU5bmgOUXVXUc62T3pBJICg9i4H1nEOalT2cu6yW0R1FUxuqqjfrg0qD
 v4P3tQyobGZCyh3RXeroy+/XMvEOpPqeXGAtypYo9ffsydLw9yznU90B3y2DY/bpxtFR
 RK/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ7Avpk4esNBsaEs5B23q/1Snt067NX/3MFVd4vYJUWjKUE8tn7L+AYjg5IoVe1+Av0wsYXk4=@lists.denx.de
X-Gm-Message-State: AOJu0YwdKvMmse4zuXgoYreSH7gWAd33UYbpfK80PbEdLX4V6/GRNSKa
 rXjHzKp3rX45L6/gSA2smv8oCRim4sBZbFxVyPki0q5M/Uqvw64AC1/ocpqiHwNb8xcHLOp0X9o
 Z+5XD1gfKTa/Dp41Dj0FrcfvTjwAZQCcgMQW3YUSLYlqcfbpEzAOcfiwb
X-Gm-Gg: ASbGncvQTBZ87z9VAoRLb9bd1ebLvme2tmnFItkRQeMs7rdm535lDtLYlJ8947yY0Qr
 A6dnHV4LiYqVE4+HqZpVnB1YDs2fmoUA5klVoZ5rCzbbkg8B8AQ8CdKPHSbp1syHyWS5s9JOX2z
 g3nS53TpWFdNVjMPlut+LM4nUgY49S62E=
X-Google-Smtp-Source: AGHT+IFJCnfL8vZmAT7snwp173s+Wy03YEmOhaxw3ubqgZz7PgI7cDJ/85aPcZmCffHogoAKOP5VynxJS46E0bYXRLM=
X-Received: by 2002:a17:907:d643:b0:ad5:3055:a025 with SMTP id
 a640c23a62f3a-ad85b0518aemr132203466b.6.1748060714673; Fri, 23 May 2025
 21:25:14 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:11 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:11 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-17-sjg@chromium.org>
References: <20250508072907.207175-17-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 21:25:11 -0700
X-Google-Sender-Auth: 2IfX5amPsSEpP0yXgf3b9pgAimQ
X-Gm-Features: AX0GCFsCY1qjrBk4c_V-UNPyZQDoMrcLcUjc5iqUyqAC-agRR7baiyvoNHNtRX0
Message-ID: <CAFLszTiiiH7t4Y2qfgwzuHxK-Z5nJg2mZnVtFKOPUeoL7gfR6w@mail.gmail.com>
Subject: Re: [PATCH 16/20] patman: Split subparsers into their own functions
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

Simplify the main parser by moving subparser code into separate
functions. Fix a few pylint warnings while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 142 ++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 55 deletions(-)

Applied to sjg/master, thanks!
