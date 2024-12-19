Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A5E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B9380381;
	Thu, 19 Dec 2024 03:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m5mUQiuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E83580369; Thu, 19 Dec 2024 03:43:57 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3F480326
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so43195366b.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576235; x=1735181035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SrfGHojwfk/Z8TyF+8Z4C7t6iNCbo3PDdaK2xGxTejY=;
 b=m5mUQiuwrw2kJdYFNe/8F3cHj7ptS7mrs1/832vLTdeZvwOsV9Wkx44ZUBg5pG//4I
 uFs5H21BQAZIMfSgZo5oPeS7n9gqXrSsm99E2eri/lV9SAXG6TotryVgyIohahrZvEtL
 fe3jeoFyXaRs4G+iUK7MDAsXpUkTc8iXG8EH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576235; x=1735181035;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SrfGHojwfk/Z8TyF+8Z4C7t6iNCbo3PDdaK2xGxTejY=;
 b=TDOwiRJoxCNBI3zhXlVBFXswk0pYs7ocse4VyZ0XT7RWx7RAHKYQOX0IMNRfLmXQ7Z
 iWXBUZLPic4RQtpaMkZ5CtQnd9+AS7zYtlwYFxm44LcSqYEFrsx10T4S95Ln8NAUpVxi
 Z4hi4gxYpSGhGjbUziuc/Sx+rr4MrZZR1UjVb9s2FRBhX9MS6RwuHVI5kqjGz96iQGw6
 PNV90IrMqqAzv/JfMXCULOwyKHGbnIx19w/nszzLLHc/l6QseoER9MYI6V0NG82O63WQ
 U3vIhxBoo/cqOx4/oXX8lC/pMZ4m29gk9Ay9W5b7h5tPD+dZXhBZcws6l0zCnTsXxjod
 ybNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9j+M/BKPrhSiiHwAwHnro/OhvUUcOjKQsaPG+iyZF3ckz71EMenWmZu2umbOmOTfZ07nBcDs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8mFElDN8CV56ZNjHMznmLNXe3lZRzklsci3twMENvuvTgaRh6
 63BSwPIJKgkC1jUtmh363F5/dZQ7nol4Qcx/NLMN4cW9g3JyxJCAx/392zHee31MbipCtsZwWAb
 obAQ+I0vFGhzRIJfP/B6yZjUBhup+3AdR/2rl
X-Gm-Gg: ASbGncvsfCjacLVhyOVdfhD0R7oB8GSHBlwqnaxICBGKHsPgaP0CEc/FU3EjY0R7Cba
 Qn49/hBqpMU43qkr8rx5qX5uJI3H01k9J4QkrcC4=
X-Google-Smtp-Source: AGHT+IH625Wifaht9xLG8C2Ki2+U9WvF+qisdZTqyD9T2mDOGtAvEc7W5+QJwa1mDRQVeon3NxQnUy9GodlOCutgsXE=
X-Received: by 2002:a17:907:780b:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aabf48c67eamr363998266b.37.1734576235082; Wed, 18 Dec 2024
 18:43:55 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:54 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-3-sjg@chromium.org>
References: <20241211223822.2446254-3-sjg@chromium.org>
 <20241211223822.2446254-1-sjg@chromium.org>
Date: Wed, 18 Dec 2024 18:43:54 -0800
X-Google-Sender-Auth: 6-f4d0zV6tHwY1z0CEQ_1Dg0Qw8
Message-ID: <CAFLszTiu7Sq9izpY9cELB6zwxx2RnDUDPPyHYM7eh1wGEbuqSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] efi_loader: Make efi_run_image() static
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This function is not called from outside this file and has no entry in
the header file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
