Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C485C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEE98743F;
	Wed, 15 Nov 2023 14:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YaS3FXdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0675586366; Wed, 15 Nov 2023 14:17:03 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F96C86F53
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-991c786369cso1013859966b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054220; x=1700659020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mh0+rxfS9F1FQ0ss5IjvMUGithe/qUA0r4u+ImrffZs=;
 b=YaS3FXdq9E4NBLk1Kq0tQaxVsW6zi/z0iRDvzQNfF1CkMpIhvA2z6nQf97rK4mKq82
 lkBYQhCTjS66pBcTa1iG+XMNcO/0o7cVrt7ZO+jxP1etfXGGUFpFIM6vc31CWaZbKlqk
 3Fa6QH5+zj+dG5wVOJezrAn5+KZcLuMtT27eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054220; x=1700659020;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mh0+rxfS9F1FQ0ss5IjvMUGithe/qUA0r4u+ImrffZs=;
 b=qoxE5AXRNT+iIum7rusHe17/EcqJ3B6+lzCU5Jcx+i0vbVz9Bsk817CbuhMM3Ker3D
 gisrKPStmLLcd2y5njOb8y4wsXCMt2izRFVALQubWGj5dTpmatswOO+WuYG2aB6K06aO
 0SgcuF+S24lRAlilBl8reJxIPWIvYVrrLPvZCQT4tDiGdbuN8QIF/EFN16+2AsPcFT7U
 yjk3GGJGz23ycK/sOGELJ2N9I4fD+B0ku78NEm75reDByjAi0zp8brbXFPsCbEDw8/+G
 r1SiNiGnI5MYnWMDwSOuVoph1QoRGi3AIkOXXJJCMmiqZQjnHWJxDDsrMmQRS1imMaFV
 eK+A==
X-Gm-Message-State: AOJu0YyVlTXZ/i7ruAcyiJHLBtE3qiSRZSPTB+1IcSoqcyelpnutgyeT
 urOhAtL8h81ARRYZ3QP0FlBRYX5Ozu0R6LJUNlQ44g==
X-Google-Smtp-Source: AGHT+IHOMrFYGXxrbEB4grWNU6YmKDw77oP/n6HbnxT2fAfhjz7Jalc1ZZNCBDbEDb8ov0WIgQrAFjYXTzBImsIVjcc=
X-Received: by 2002:a17:906:4551:b0:9e3:277d:3233 with SMTP id
 s17-20020a170906455100b009e3277d3233mr9121151ejq.13.1700054220668; Wed, 15
 Nov 2023 05:17:00 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:16:59 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231104162527.1736401-3-sjg@chromium.org>
References: <20231104162527.1736401-3-sjg@chromium.org>
 <20231104162527.1736401-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:16:59 -0800
X-Google-Sender-Auth: DOixQrT5kAHWN17mXPx0nHGc2xQ
Message-ID: <CAPnjgZ3SNtn=Z0unigpafMmp6r8k=NG70aTB6MWY1tHBMrwLGA@mail.gmail.com>
Subject: Re: [PATCH 3/5] patman: Correct easy pylint warnings in __main__
To: Simon Glass <sjg@chromium.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Tidy up the code a little to reduce the number of pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Applied to u-boot-dm, thanks!
