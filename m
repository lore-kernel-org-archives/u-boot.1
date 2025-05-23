Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6BDC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453628337A;
	Fri, 23 May 2025 15:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mr14LGap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B848F832FE; Fri, 23 May 2025 15:19:01 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DA2830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad5273c1fd7so1560038966b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006339; x=1748611139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eDbDXYFOUHQScdvR8/kizUnoM1FzsVjp6mYQ1H+wZsA=;
 b=mr14LGaplDbldUWnM2MDprNVnGNeK6e17O0XFR+U2nSTTBrIV0scxVkOIZFum0reQG
 KFWX7eNo8zpF+yZrAi9Yduuocg7zmH7Wj44liCJ93MZ0NSi7scoeAKRoldNAfTVIm1sk
 CK75EwVZefco8fyXlTfW6Nevxe1g+mN/bNjrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006339; x=1748611139;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eDbDXYFOUHQScdvR8/kizUnoM1FzsVjp6mYQ1H+wZsA=;
 b=GWN6aUxp8n67aiiGsW2HjRxYp4nixKCrzBGXNiMaf4Z/4e1/pOvjkMKoeg0Ec1RIsd
 ftzfgkg1f5Hm8Mm40pQBz8mXHGZWoFKz+sr6qYvuTb5LgAr+i1j65GyHDIPZuUFrzwLO
 T0BfQfQZ98EGWh/Qt8w6gIU8qGS4z3d9baVWirUu+DlnsVb3T4MlnQdCDJ0aFrbQckHG
 rDfkXLTod0eZWmC8UMVkWskW6RQvPhuX3yNNQXpG69UnH27yxgFh+EkQ6dR8+sBtq2a0
 hCt269Ej5q0YBZ85HiZklH+R4fBOAT185Kjk8UCV/6sYggYC1qIQLkD7TZw4wkQTFI1A
 OSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMSOSJYwOmGI+DCHrqrpLD+zS/dVJVjFATAz9ZEvoKGBjARmgP+bbme7xc85PC9x5auUKKRfE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0ypWlS78t4dt8+SlBLyoLnLxR13T/b4FmUSFbjLB2sCu5OBTt
 iWoSE5oiAHBTgh7TjZ400peDFX1dFGM7BUQLhzsdPJfnxm/4Jt1WoK9VbeWm2OjzeqKDxIeL1BA
 M1TFlT4F10372BvlspmMeIJKbGWUD+9MMfdaNzjp0aB1FSysQBsbJh9Dp
X-Gm-Gg: ASbGncvUMisudVJdnzldT5pM/aDBC41l6CspA33tkoRp+3pABpEtjcBUvYG8fo9IPGh
 9lDFzWU6dt2hOwMBdoU7M3uZSGlJQkJI1VXK4d2E6+vNvNOmfhAgv2nrY5uT81DSTa33ZIwrbxE
 OwUX6+oTyagVKyEkLJtMDZHbaFEsuJFpXUUA==
X-Google-Smtp-Source: AGHT+IFGbMGZfYzFlD57AgGggJ7KcD5ndQZEOwKNcsYBJLMLUAasXTzIqjjXavO8kDZDO+zpYGaTdEhsu/rYvYVi9rU=
X-Received: by 2002:a17:906:6a19:b0:acb:34b2:851 with SMTP id
 a640c23a62f3a-ad536f9d598mr2360314966b.44.1748006339274; Fri, 23 May 2025
 06:18:59 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:18:57 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:18:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-14-sjg@chromium.org>
References: <20250504132356.2317305-14-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 06:18:57 -0700
X-Google-Sender-Auth: VXT8maH6DBrpKC2uE3PimcUp1m4
X-Gm-Features: AX0GCFuSps8seRy4D0IKabXUZ5JobZp8ht-b5mtSTjAQNGWpa3MOYS5yPJ2AVaA
Message-ID: <CAFLszTh3S47fKDz=_d-yyThc-3RUtVuD=2az9K5gQN08SUMNSw@mail.gmail.com>
Subject: Re: [PATCH v2 13/30] patman: Support extra test features
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Provide support for the -X flag, which preserves the working directory
used by tests. Also support -N which shows captured output for tests.

Finally, allow selection of a particular test to run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/__main__.py  |  4 +++-
 tools/patman/cmdline.py   |  6 ++++++
 tools/patman/func_test.py | 24 +++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
