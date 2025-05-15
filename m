Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A62C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E805882BA7;
	Thu, 15 May 2025 15:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i5thYita";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C91982BA7; Thu, 15 May 2025 15:51:24 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE57382BF2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fbfa0a7d2cso1597819a12.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747317080; x=1747921880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lkI9OskRwUCTh7QainjSwZh4PSS6/3J+EFPsRtdpLVg=;
 b=i5thYita4QhwZf/5EHoceeN2pQ7EUQK02lx8wtosiJJhQPWcZGnh2uN8b7As7U/xYD
 vRtbGBlSCGSZRNokqdnvd7pBGNm0v8lgGZqrpx5hgY0Kx6iN8zmdV8c7ZxRoE1pAkGpO
 Oq2lWW5PYCPxIb/+TZqJ3pD3uBHwEObb1HHmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747317080; x=1747921880;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lkI9OskRwUCTh7QainjSwZh4PSS6/3J+EFPsRtdpLVg=;
 b=JPGBJhWoHMzZOrr8wNJbWqBEGuBoHCQZzEuEAMrap6qo3FRaYvxRbxopF9d/NrFF/P
 /9ru9TES5RJgPfASCqf/1NkP61CkeqeKQxWky76B7yWcP6Ns17BC96GtPszQxXLiSNVF
 m0ZzjyVY082UVue6tNJ0gAQVMOKs6m4Q+lN/WNBen1xwE7U2qRzW24u9Mpe3sy1EggaZ
 5vmnGi22Ox6zt3bLjcv5fqyXa+zaguD9EI1X4N3iBspp1O+8vC4BEodCCwrtrXBWN7iT
 qk2zS6hPqgKa1z1Vpa6V9R8kP+can57/7TNsomF6GCjm92tG5cAW+bVeAxRbisBkxNf+
 /ibA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6J0roQbAFop8pOe6Z0UOhE8MpmV3YH6yu2kvqmGPIgnqRYo3UYr7+dV3afiFyrK6d+mjS5NQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxGcN8nQJs7rBLH8P1ym9vFLZBCeI+3ojJXIeujgeyC0SH0rW5K
 HmHncDFHgvJdFpJX0ERoja6Ve7e3Uc4KI6mEQbU+a8gAfHj7gdHB8HjhG02pgQjOdlKl5ECDKS1
 stKP7ET8+G6WbctXAdUHBau+PeKduLWqecQWV3nJvLQB49YgC1fzsBl9fQg==
X-Gm-Gg: ASbGnctgsUgIdc9WmnGuLg4aB19yFeDlJ+zEfqaZssq4dCFrKV4KkGStlBQ8w92UCJY
 JgFq5jxgE6jubV8Jnd08Au2tHggOmnjYNMiyXh5mr6Uj6ui7bUMq90IkQuPBYJtXKj3v8SadY58
 M7fVrlcpW7WU7eoW/MgyRb7LeFx1SBntYBZe2zT5hY6uHT
X-Google-Smtp-Source: AGHT+IFdNjFk8cCJh/FHPadiyOGcs6/WTUztyD56l1XT1TFZ2tN+iYNKKtc/qE05SNiS/vc2AoqLPi6/vIQvsirkU3E=
X-Received: by 2002:a05:6402:3551:b0:5fe:8643:2c9d with SMTP id
 4fb4d7f45d1cf-5ff988dd701mr6268431a12.33.1747317080222; Thu, 15 May 2025
 06:51:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 06:51:17 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 06:51:17 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250511141828.2367318-2-sjg@chromium.org>
References: <20250511141828.2367318-2-sjg@chromium.org>
 <20250511141828.2367318-1-sjg@chromium.org>
Date: Thu, 15 May 2025 06:51:17 -0700
X-Google-Sender-Auth: ZHBJmdCgZ4Gp1ygEhuBCcQIT_LI
X-Gm-Features: AX0GCFv7ysbo2t1O0hw-B7xj-jBdiz_JMKRmqYq8_ix9AQykax8hhMUDJBINnDI
Message-ID: <CAFLszTjf_4E+spiD3FBFvXQbXtrnBxgoF1hCjNsauySom2SgFA@mail.gmail.com>
Subject: Re: [PATCH 1/6] test: Update fs_helper to support passing in the image
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>, 
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

This function is useful for other scripts, so add a parameter to specify
the image name, if desired.

Also add a flag to quieten the output of some of the tools, since in
many cases we only want to see warnings / errors.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
