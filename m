Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06525C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2DB888F6;
	Mon, 15 Jul 2024 15:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cxPKNYS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2675988827; Mon, 15 Jul 2024 15:31:46 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CFC888C7
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e02c4983bfaso4438026276.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050302; x=1721655102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6CPu0NLo1louOTaHm1hE0CT2R840+vkiTaXCsMi/JA=;
 b=cxPKNYS615PvNj4nisgcSjg1N8NMqPOq4MAmMxnEu4aayneKrflg4yLV/ZnNzXlnkr
 EqFWF7uJwdRl75NClZCtHkJdAaBizdFdDt3gQo42HEwZABJqFhzcWOT9yRHKQO4js1Qw
 koeCgDmtPW/rWkaaeVSt6znyx3t2hRJ67HVj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050302; x=1721655102;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6CPu0NLo1louOTaHm1hE0CT2R840+vkiTaXCsMi/JA=;
 b=bwUrQYSuxtQthTTDDMPtJqxEuAOpOOnrNd3EW86+ViTDHCxAB8PqJCj+ePcXkxQVr+
 5fW1koLQFa4WMyNd6pnR+0fsIOItbFDkAAbhRr8Rg9av4JJok4u4amAq6BAKWqBdPnkP
 ZScCykWVsSAYUs6GYSX3WcLV/v2mHODWOkRNekXcBynyrqmsw4AFj4ik1hQW9jyvpusv
 iPY4mcFhqV+qwWGm3K37g0NtEHfsMsZNs/5UGpKI7sIM8RzRJfTLI3YE0cWpVHqfrKXN
 FY7PySCK7k+2z/L6hpGyMXaqxu91P1gqYJxQ94760/LyV2fI74qi/PExD6VT0RUlgi5V
 oxKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAS3xGzUnX5yCpDQCtsbYsVDVZu+vrynK8zDlK2whsGHRbDwmOsmnT8tuyU8s1FjkSh//4esmttSWAJUe14Fa3AwBt/w==
X-Gm-Message-State: AOJu0YxIjfEj27SHCS2sXrnXRWmD7hKZB2k2wJxnRURF8jE+BVX6Ir7+
 /d1f5we9bqaMxlUFLWiZOqDySvQ7t9EhTEQHUoguVdmHR1j1+HKlPIy8Ln0fjxtoqprThvv1lx0
 k5lEm93a+/aKb/V4DnRTQ3hVHQJl6XO7fxOTT
X-Google-Smtp-Source: AGHT+IED6X4K+7Ki3aCT4urgucVqXUpH5jjUP3xzZ4RF30FauVoM4VAb3v3nxqTGpV16gtiouvWGgYwMDqXLiljP8Us=
X-Received: by 2002:a05:6902:100d:b0:e05:b655:329e with SMTP id
 3f1490d57ef6-e05b65533f0mr5460637276.55.1721050302040; Mon, 15 Jul 2024
 06:31:42 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:41 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-2-sjg@chromium.org>
References: <20240623175515.1466908-2-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:41 -0700
X-Google-Sender-Auth: oDOzGVk5j0CfdRP8zYvNILuqQ4Y
Message-ID: <CAFLszThVORmX9MssnCYFdinzNhog+r4+D6+cswSx2s56OASQBQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] binman: efi: Correct entry docs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Somehow the class documentation has got out of sync with the generated
entries.rst file. Regenerating it causes errors, so correct these and
regenerate the entries.rst file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 809f28e7213 ("binman: capsule: Use dumped capsule header...")
---

(no changes since v1)

 tools/binman/entries.rst                | 58 ++++++++++++-------------
 tools/binman/etype/efi_capsule.py       | 40 ++++++++---------
 tools/binman/etype/efi_empty_capsule.py | 22 +++++-----
 3 files changed, 61 insertions(+), 59 deletions(-)

Applied to u-boot-dm, thanks!
