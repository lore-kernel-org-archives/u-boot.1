Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E674CC3DA7E
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A552888A2;
	Mon, 29 Jul 2024 18:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ehYYOliD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817358882D; Mon, 29 Jul 2024 18:19:34 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3576888867
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b5f46191b5so18690926d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269971; x=1722874771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DtV7F+u5+VN9t/Aqkm2Ch7XyTBOKfC19MEy7kaqbmGI=;
 b=ehYYOliD3fMxyUbm64UjK3ARm5hPMQFpX4EMa3+CXrSSUntzOvozo3SQOXB5+vOjc1
 WQhqVQdr4/UGnWPp33XGbw5CS6eUD0UT8KUKT6TfpU7CoioxWlrHioxV99Gbq2CubbCw
 S291h7noSZJc4S0hvUF7u+S9nt28+iX/SL+9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269971; x=1722874771;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DtV7F+u5+VN9t/Aqkm2Ch7XyTBOKfC19MEy7kaqbmGI=;
 b=dfeob0+GsI7ZKNEzbEjrDw9j2pc4856PdyaVDdW5k3X+38hk4IfpUJR0M22PFTQiA/
 FA8X7CK86Ux5ZA0hOKROCrGxTiy21TVq7wX1cqSJmxx8mxw+spUBhf1QiQhMmNhDVMNp
 TulW8Y3Ea+gLNkTJelpnpbqFxks1deC+xb71j09ROuDAdZIyPVDkdqKUlQHQsBmyoC4Q
 gas5bBe7DqeohVh0gJLoEiXwdQAZ4yDG3+UHnT3tXLPQ6qKBEN45BVutfL6PPyUWB8kE
 IrLESDgAPK6jW9qggZ/1kKqNTQU2baNZ4ZesiQ8JCFVnMvY3UwpzmS1+9pRb7AbQ+mS1
 tyOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCUo3Q8Tas/oxqIVLkTnLKoIqI8pFjXRJgduAeXfujF1niaKTM8l6nPqQcRyTh7YF9EgW/rmn2c3a+phyk/UrUGTe/wA==
X-Gm-Message-State: AOJu0Yx0o7tPYYDWww08ySi37g4Bl3D7ZPmXao918xYKj0YMm8+LUteu
 XENY3ivYDYmxmlXT1piwv9Ef7QN0n39e4kNFjpUtC6Tt+xKhsfc+FjWUn30S0NuoqdYyyQNKoNe
 A6Y0Q33EW7vRBMt1kzzhxFfzTxiYFwngAxEGZ
X-Google-Smtp-Source: AGHT+IEbNvp60od4VCkciPewL39kO3leWCS8AoVMl/iWAogTUOjD3l5iy+p4lyVT1sg4+kNCJTbMbAbuQKk+1u/Aq24=
X-Received: by 2002:a05:6214:402:b0:6b5:80e0:1301 with SMTP id
 6a1803df08f44-6bb55aeca19mr118198846d6.55.1722269971232; Mon, 29 Jul 2024
 09:19:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-11-sjg@chromium.org>
References: <20240720104950.2730773-11-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:30 -0700
X-Google-Sender-Auth: x83tkxx1Lykc71VDbDhL0UsnjHc
Message-ID: <CAFLszTgPBS1-DiFcfqcH-1wz5cZDf3TjMTzSRN5vtaUTXL0x8w@mail.gmail.com>
Subject: Re: [PATCH 10/20] binman: Fix a comment typo in _DoReadFileDtb()
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

Fix a minor typo in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
