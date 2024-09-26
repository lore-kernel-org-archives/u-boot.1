Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF884CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED31388F2A;
	Fri, 27 Sep 2024 00:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AHJ1ATGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CCC88DB6; Fri, 27 Sep 2024 00:07:21 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C4688F16
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso1172116b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388436; x=1727993236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9O5+jruVbnF1e5NeyhBcsJgNpD/l9zTiupyH8fMzpOM=;
 b=AHJ1ATGAm11RdROKS8/oTu+TJR/LHE7FOOgIfz/odo9gg1DAYeFJlmvbvHh5OOy3H8
 axf90z18J0uwvDDzjzSeHNOfcKqfsPRz9SobYtFLKEvZ37u+3dNlIBNW+UWbsM2LZrDj
 Lb8MCzsAa8e+tWcnxM1GRMwaMeZXXP+1hsIkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388436; x=1727993236;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9O5+jruVbnF1e5NeyhBcsJgNpD/l9zTiupyH8fMzpOM=;
 b=qG7KLaH31zGhzRNdS5viDdBS8GrfS2RWWoWc/LPGSaD1LVT2oSm1kpXJIPt70DoYOO
 Rq9FohvP3dLITp9yQ94VufL4zXCBFgj0kS0jpbtqj3P760TUMT9u8KQ9yIicNHX5I4lg
 iYDb9YquCqa7nVeoJw8VdqYsX5ww0oboqrOMPzoxcYGrBVpt7cM+4sm5nd7+VovmXgXr
 TsfM3n46wIvvnAqWMAZ3hhEDx+/EkMXFDrexGklV617VlMM/YiPp9DjiqOMS9ZQV+96L
 ERuC1XXwOA/7I2J/DtTWGoqSGTGx5gdW+DJ4q3phJEzrgse/aldZM1olxPvHL2JxYjG3
 0PZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJR4FVJngTvpPp+XybX3oja7Ge9YHJ5TTl3puKs2s9w2ZiZWW5oLNnX/ZiweiboRQtYdG3u3o=@lists.denx.de
X-Gm-Message-State: AOJu0YwBKr5SdOK1br747AnT1OWXtQEm8MmnrBK2MB2tu5K9QoT81kLH
 ncDz4CKp9FZ5S1HfVHNKZzNoXKFVd5HyreNuBw2m5MFWlkSoEuZZv0wpBPoiVwV6qthEaadUsHV
 Rwvy8cNp4n6pj3Pz4QmtOTKzzDLWjJ8/CNfPc
X-Google-Smtp-Source: AGHT+IGoxyPuWgY/r0rl9hT4pN+67qd9X8UX+HW8CU7LA8QVYnv7k4DZx3P/kPONzAV9YdAxkvAojQdUafS8wH3ftFU=
X-Received: by 2002:a17:90a:3009:b0:2e0:a4a4:75d9 with SMTP id
 98e67ed59e1d1-2e0b89ef178mr1178883a91.12.1727388436030; Thu, 26 Sep 2024
 15:07:16 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:15 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-15-sjg@chromium.org>
References: <20240826191143.426387-15-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:15 -0700
X-Google-Sender-Auth: znTgRg3PmTV2FbST4mbTRCWXfZw
Message-ID: <CAFLszTippBa59Hiq-3LPK2MaA7DqZ6aiUF8zYD7Xi5faVKvDGQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] binman: Allow image_pos to be None when writing
 symbols
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Rong Tao <rongtao@cestc.cn>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Some images do not have an image_pos value, for example an image which
is part of a compressed section and therefore cannot be accessed
directly.

Handle this case, returning None as the value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/section.py          |  3 ++
 tools/binman/ftest.py                  | 49 +++++++++++++++++++-------
 tools/binman/test/338_symbols_comp.dts | 26 ++++++++++++++
 3 files changed, 65 insertions(+), 13 deletions(-)
 create mode 100644 tools/binman/test/338_symbols_comp.dts

Applied to u-boot-dm/next, thanks!
