Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D62CC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70258363C;
	Sat, 24 May 2025 07:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i8gHPwEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9365D83619; Sat, 24 May 2025 07:06:28 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA9A83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad5574b59c0so87560866b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063186; x=1748667986; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pc1/l7mixSZOojr2H27vLFs3RElTM3YMBt45W2BR9Q4=;
 b=i8gHPwEETlvjcX5wxmw6Cm7o9VlzxTvzNJl/n0kMMvxw1J5LC/EsuTQsITv2HuuBuJ
 b5xTobxBtMd+N2roWBc0xCejJ+QRsmxmuvEE47G8LB6ROuWe28nYGBwLAfqB1zX6q+UH
 3RpqlFDZDmWI1Ti7yrASASLj6LTJBbcPDFDiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063186; x=1748667986;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pc1/l7mixSZOojr2H27vLFs3RElTM3YMBt45W2BR9Q4=;
 b=HosesZIJXYkwQeZskrqnR5j9NDfGPnUST6ujkPJeeY9wbIBaaPVpllaAti6bdrEPZX
 Y6TLRRD0E4Wx0Bp/r2027JqScxlPLT0iVAmROeRlDRbmTB8Dr1MSRR0YXPVn1+PNO6sb
 FVBQLOGW/ALfFxEgq/8gZgsXnzjGvGAZjigsTHzM1qdDCU1kT1LdKu9vJ/7ZqOV1jRwa
 0RDBLjdKr30EDNPsLJICV5us+yGHZ4+QM0qHv4/IBZxweeATmUMaNvPXW62PtMKE15uY
 mAWGiHJ9rJ/PZTH4iXGENbTbZas7Nebsxjgu6z8s5w3kz0Puh7w8kyNc5wNSrHhrsE4e
 Bkag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgrJ39755/ekhzYs40m2DGFSnvUelATm0M8o/Ogp13eV9NV+T7dje1epYdjw6UmMbcMTi9JqA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq5Or7MT2Ov8+9zO1B2wA+hmS+OlNxzrtWVX3nIzufJMg542oe
 42Yvh/sGwQsPwyrbl/hhfqv85JHIlJQHJqgZD8LuEPdkMP+F9AsJ6tlhP0BuMugxRPciyiHZLU+
 SUN6hKlZyYW65JT3wjNfzlz2DScu4nHfRrI9gwup/
X-Gm-Gg: ASbGncv9TnqmSdnNZMSBXsPWKEnAzLY76tHC5cX7LhEzdiWA19mMCblNsSncFCw2eco
 4Wp6yGrKp84c4vVTAW3VjLKVaFrTqIHkCfS07+MKr9drZPAv6gtZtWwQNV838pV5PXZM0uGy78d
 4OXZVS+xdNZImZ38GADG6W7xEKluU7Ozo=
X-Google-Smtp-Source: AGHT+IGtMc+FO/K1Xq1aUtboouEsu7aGgWAjjpBIh9a5JYg7ea6wwzhV0ACHjJK0TvNxayeI68ICpDUvcdbnPACB6og=
X-Received: by 2002:a17:907:3e10:b0:ad5:20ad:965e with SMTP id
 a640c23a62f3a-ad85b0bf5f4mr134408066b.22.1748063186153; Fri, 23 May 2025
 22:06:26 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:25 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:25 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-8-sjg@chromium.org>
References: <20250510110535.1453745-8-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:25 -0500
X-Google-Sender-Auth: OtNjLHArJs-JpfN0Rv7Cr5V6Pr0
X-Gm-Features: AX0GCFuq_tyR7qxjMEB4XmceRF8ImHZP-QjhhZ7rX8wYaIE3fpbsObX19NkzUy4
Message-ID: <CAFLszTisyaK8zc0y=bd51k-4Lwmye-jE7V_y6+cTR5bj-Tsaqg@mail.gmail.com>
Subject: Re: [PATCH 07/25] patman: Add a fourth series for testing
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

Create one more series to use for testing. This one has four separate
patches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/test_common.py | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

Applied to sjg/master, thanks!
