Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A39C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276CA88648;
	Fri, 26 Jul 2024 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cUoBPrlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123068859B; Fri, 26 Jul 2024 14:59:03 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0508F885A8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-64f4fd64773so22292577b3.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998740; x=1722603540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5kMTc3FVdsZLGmdAEcE9qRCcIpXJlYV1cMYUPFH8K5U=;
 b=cUoBPrlVovnkZGtgTbkMrHWgYQ9wgClU38CMzvkmrVfu3I8dyuMyrd8WY69+crEn33
 RFOPvkYqXcTUUpCKl0YKA7Js3Ejdndhyle49maMHPrKi8Kv3mMjMfn+7Ow1S4brjqGYr
 TuRHgpcEwRkY/KegXYTWUYpVtFG764/TO3Pjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998740; x=1722603540;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5kMTc3FVdsZLGmdAEcE9qRCcIpXJlYV1cMYUPFH8K5U=;
 b=YSLA8ILZcmmD0lfs+Zxd1ekKTePd8+tFUisg7zkXaoHCXWbkrmLa8yh0KbAbjzCBkn
 Py/WLu/Y5mLKs+HDCpbelQtSl7yokAmgtw4/BqV9nnT4nBLO6W/XnrLbrD4m6M+HafW+
 zpPSdJD/YG6vIDRMhYc+K+rzg+e+/y+XbzQIkBbr1DWJjlFJxHDL9uu62OXOVl8KupyZ
 uWemAomUzx5DZC6jLdcxWceeiVTLzKOY1aU7/0SOJ5at8zcs2cat5dn5b85UB/3hG7n7
 FcyUL6gRfsYSm+u+U1lM+nqBWaP5TsD1v6/iwvTIOffK0aqr5eyRKpD7ojX+JDf3ACAs
 f7sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEHqtxokvgyqRFvN81kJ9IDpDq8vXcUZgx7a7JxveTGb4cCw6ZEAaXApZ1R8djyEfd+Q3/sizD+5poKAfc7ERrJAHCqQ==
X-Gm-Message-State: AOJu0YyKovmtjOq9BgJ52Rl/WTkWng6nocy8rdLsvE4dH9b2EGPJTakG
 LJl4SiiSygPe1fPr8qRTXEQ8ajIoBag2pJMDQIEC25txtFhS/3fzzQjCnYRzr2iBsP5bHwNdWMg
 kZpeJYGa/Gok+m6+Es8mLEEtPyVkERHxN1HYv8BanvileZoI=
X-Google-Smtp-Source: AGHT+IEyyxYrScBetE636WSPXJCq/acsZHCkwn79JRsVvChDXHcegFIhtGBGqTgqrZDj8KR9NfxD8TLf6yzhDDNoX/M=
X-Received: by 2002:a81:a54b:0:b0:65f:ca0b:5ad9 with SMTP id
 00721157ae682-675b4f3eb5amr59160657b3.25.1721998739947; Fri, 26 Jul 2024
 05:58:59 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:58 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-18-sjg@chromium.org>
References: <20240717155712.2913651-18-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:58 -0700
X-Google-Sender-Auth: 4bwi3KbbpTIYus3Ol7rZGOIugwo
Message-ID: <CAFLszTj94sT4sgH0GRXr2OD5EXGw8rx21b314WN+WHYWysR7mQ@mail.gmail.com>
Subject: Re: [PATCH 17/24] qconfig: Move all move_config code into
 move_config()
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

Move the setup and completion code into the move_config() function so
it is all in one place.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

Applied to u-boot-dm, thanks!
