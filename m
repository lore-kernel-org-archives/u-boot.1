Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B049EC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2765F83409;
	Sat, 24 May 2025 06:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k1sNnMKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFAF83416; Sat, 24 May 2025 06:25:07 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F1A83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso81604366b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060702; x=1748665502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r1mTpNoDkAxMruitlvMuWMiyj4hlOq8D0KFtwHP4UkY=;
 b=k1sNnMKFpUXdoo2SL7fhKEyQ9dyoQKtxQ2WCSvGFFDjlCI3l4nSl7hHqKosLt5PX2j
 jjAPzyXSVWGxiHiRTLlkjHpLOuVWf8J/IUyzrAr+FIHiY6qDVFkwOS1fXFc6DTJ44MpO
 7i6haRL3dLNuVq6F/pClBm2sHlv6TY+EBKo8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060702; x=1748665502;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1mTpNoDkAxMruitlvMuWMiyj4hlOq8D0KFtwHP4UkY=;
 b=BUnNEf+avADEC8euQEWbhgRaMF2pXiit6V776OytqkeyqoAl91z/8MIqxD4wosmIW/
 pJXTwBjpQ1tymE6rikIOYmfoKZQwS3Wli8aw40Eax9KqXsThyvHLtXpcyWv2zdWW7GFr
 lS6t/JjLu36zTRrnHdFhwpCL21vjh1p5g8YO64MqfUyvPvkniYbEThvhX/zy+v/GS8L0
 YRkoTQ2hQ8CkXtqwMhllJ61GXbH2CubQq3EEZSTCGNkfG9rSKeWCflIW+3nM6FA7GYNe
 Elhzyg3/kNSV/0ClMCRFmBaZWC61D9AjAf8/q3L2/LYk+wc4I6MNRvmoPhBLiOIEmn05
 m2dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSvmwlol31ib5t+YBfGq+IDQI9Eo6eSjNWgXD3wl2M5P+NDQnIOhiHcl+qo1nqO730uB0X8dg=@lists.denx.de
X-Gm-Message-State: AOJu0YxyPfXIBHNHLQ6Pr2/9hZCC28odN7Ev+RglCuadbKGxbsZqw8Wt
 6EjITI13XF2mZLRnCVRN3XeIuX3Ty1Bem5nI56ACN/bgUsBBtsFJA6ggEg5QxpIjThzS29irvFU
 5Dl4yQo1ZUXa7ezWOwk2ZtlfrwR4e7aATl4h+TPk+
X-Gm-Gg: ASbGncubV5vbc3nHdvhYDseHCpW2AmcsJ/bJMciJ+XORhtSDfnT/qFGmVm27P1JVF03
 052bBBTP8FLi5QmYd017a/EBMuSdpYyfZiVl6na9YjFlwjRnzaTMtBMc6URS20JKC8iuwINEwXf
 BzunHM3Hf2+G/sUX5+AblL4rGZCLmVKCI=
X-Google-Smtp-Source: AGHT+IHIQm/3c001qMuCm+exz2UHYWhxmG9jiF2TH+cqnBrvVYeNZ/kcVFznJ6xPf87WTJ3CtKoy4RM0gwSLyjx0iAg=
X-Received: by 2002:a17:907:3e95:b0:ad2:3f1f:7974 with SMTP id
 a640c23a62f3a-ad85b12061bmr113796566b.10.1748060702240; Fri, 23 May 2025
 21:25:02 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:01 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:01 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-21-sjg@chromium.org>
References: <20250508072907.207175-21-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:01 -0500
X-Google-Sender-Auth: NgPiJq0UThK2glHZIij9h0_6jV0
X-Gm-Features: AX0GCFuGTAVzTBKnwj50MIlk3uxbPgiQZVUg4f9klS_db0-DJtGhschPWlUREbM
Message-ID: <CAFLszTgYqAE5eWDOxDcCvvw9+B2e4C167rjBKMAEtjQ39Ys63w@mail.gmail.com>
Subject: Re: [PATCH 20/20] patman: Support collecting all lines in the commit
 message
To: Simon Glass <sjg@chromium.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

In some cases we want to collect all lines in the commit message so that
the commit can be recreated with the same message as before, or perhaps
with light filtering.

Add support for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchstream.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
