Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980D4C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6F68352F;
	Sat, 24 May 2025 06:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lD5V3T+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDDD83303; Sat, 24 May 2025 06:25:39 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DDFF8342C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad564b7aea9so296480866b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060737; x=1748665537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YLZRvxPnjvfXHTasCci1beuRHEBLbG+8AdNBQOzVKpM=;
 b=lD5V3T+6Z4HsqVbMgwPdAYDLZOO/2iuikJYa9cO6wgLIbYah0h7bbIG0vYh5txozCW
 0JnA8j8Hw/pU5p+44NPuty7nt0J9fq4vAWMrv7jPESs5ib7Gn6GWcTUXhBbSkwYK5xDF
 DsWIH3tnOkuKl2luDenwh3AyLoppVZ5Zz/XgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060737; x=1748665537;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLZRvxPnjvfXHTasCci1beuRHEBLbG+8AdNBQOzVKpM=;
 b=h8Zyo2gEuC4/4LnOIA0426eRsEuCkABlfk5Ct12kO02qmhm+0FZP0FsRi4N2/dikgA
 A3HiPNoJsH2ST+Y2VdLJjAb3MReJXr4lHo01HPtLC0zUxBvxdQG2D6TbyD8UbwayaCsN
 bsSZ9tAqMQ+wboLCo2EexrHJ57qnXDqYIqOT0IugCBhjEEk8L7tdwDk8LqSKLP4XfTOR
 yT4sd/yuXs6Uq/0XlRSIpjAy5QaSd9dN204R4H905A3bJmNgCNicy8bRCSE4y3gCtdDL
 BDXTkuCKz9XgiOcZQ33p+zHF9umXCMDL9A1iLGcaLh50Yi1WWSbWUctjOXYlXIR4AVE3
 ZKkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIQ0BgSrZg0PwjvauXR0SU24Gg28spBQJYOxCm76h+W1iw1AkvIZDHihsNsKvhuuJt+nu5Ets=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9UQ22MAjSzDJGzjMszmhHvqB1Jhs/gDzYtek0qCRscVwBQQRa
 qZsFEhf9cw9IarWqm/eshwcRBn7gRiAzMgpztz5OmsqhTEOyXa8MWGbo+pSUfIfUrsSs5SSTnDQ
 5WJkQ+KH5xpikb/iqTVJv1ycT/pigGT/SdO4ATx2R
X-Gm-Gg: ASbGncsa8jwRj4DKAr2G9PDPdHiwktG/+dvW3WVmDa1WCidiS63gszQFw1sXsrP4vsf
 fdTV5JoIXmCUAtI0G4coib9VPLqQE/OQsHUj31sfUh93bkrsyl/aFq5GuKBJSM5p4YC1rMYqrv7
 xzXBshFYgwFb34YKS/3NG+p+y2JPjTCNd6VlhQanmBMQ==
X-Google-Smtp-Source: AGHT+IGO8Sjh7CQUxZks/HQ3de+AxBZcf7ONZNCG45lVcAucuqLXtNu/JAIxhPL2GAFs2Nm0da3qxXiyxu8v0DHVcro=
X-Received: by 2002:a17:907:7209:b0:ad5:61d1:d8ac with SMTP id
 a640c23a62f3a-ad63f982130mr634537466b.6.1748060737068; Fri, 23 May 2025
 21:25:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:35 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:35 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-9-sjg@chromium.org>
References: <20250508072907.207175-9-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:35 -0500
X-Google-Sender-Auth: bTX_f3Dlx-GjUieFgbLkgyz4aBs
X-Gm-Features: AX0GCFtzvvV4pX6-eV89xvgjkd2IUX1n3HJqr5QsMh1cYuYM-298O166AMO-ssc
Message-ID: <CAFLszTgpzg22NH9H-B4TqS5GpJz7M+3gmZ3yQuV06ZM_h7=21Q@mail.gmail.com>
Subject: Re: [PATCH 08/20] patman: Use itr instead of lines for iterator
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

The variables 'lines' is used to hold a list of output lines within a
test, but also to hold an iterator through those lines. Use 'itr' for
the latter, to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 161 +++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 79 deletions(-)

Applied to sjg/master, thanks!
