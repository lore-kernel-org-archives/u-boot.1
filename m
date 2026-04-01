Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C62C10FCAD2
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E553484011;
	Thu,  2 Apr 2026 00:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dP9Lpdoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0424C8408D; Thu,  2 Apr 2026 00:49:45 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1999383CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so27444666b.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083782; cv=none;
 d=google.com; s=arc-20240605;
 b=XCkTyAi80JDFm+KqTTddHMG6Ie7Wxkwc0hT4dQrsfL49TFG9Mk8deNd3kDDE4o+79B
 xT3NpM7Sy0/2faeedStrEZXBiZ3Q4EinBmIkmwW2yMrdyt/oCnyvMdUGU0+HQwhd2D65
 tDhEgDwvxb0m6viNuj1D2NSwqwdNQVda1nDGbzKeIAP73W4z2IzFmkyMGRrQZd7w/KgO
 +tJR9OY6SO1jeskA0g5PSxOrn/R8u2qnXuHC+z8VTYkVSWMHKeOunk+Q4QbwKT7gBkmd
 m14vXUa4s2YPsJqyB1V0f/DT8Cn4iMjoUxwxaWxVTNLrv0/qECVeRaRX7pDrdq/Xq5BJ
 ExDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vLIIGLT350XGP6t3T+71Fb0rtvgTqXqPydDc3ktkb8Q=;
 fh=JdYuey8wYmmx/AtEosXUVTN8d8L/5S4NrdlkDKNw/io=;
 b=Si6BlT+hKwmdRK1Vk/Z+ngfRk2tr89EEJX0ulHtYnpg8m6idXdx1FaEs6sjGAUbEgj
 iBfp0z06lzZ5RCoa7Ds8oZHkPGbgMl21/2fCnJY4gbSo+60dSDyP4jjJpgQ2kNYK206a
 bcanLjK64HRlDewTjT+d1H6AlH/S3KX7rguQWEIRwxw7/EemnfBXcyU7CCEN0OfDiTeA
 JV59V+IwrryPPnauJl9deE1ngp/MG8OB5HxV7R610h1oOBC1C6syQSDSyR7kMdNNYhhA
 dG7OAAnpSa9DOZdIHt4QCcsNJR6nInDYsAPqw20aKOMhvtaV4mmSAXRPDgTGRSZ+ic33
 UVpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775083782; x=1775688582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vLIIGLT350XGP6t3T+71Fb0rtvgTqXqPydDc3ktkb8Q=;
 b=dP9Lpdohm3bZmyHr/kn46vVVsQfehq2Rbpb/hAM7dR7Ve7whJV2oEWDE8wMt/iA6NX
 /T5Tuhjfqgj5FtzPK9fgPuXEA4ecpwdlNyaNZDJ8sNmhfX9CuPQvIQk0dgwRwvsDjkUs
 x5S9/lzgsF1IJhHkn318zh2U2aeaE7YZb0TXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775083782; x=1775688582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLIIGLT350XGP6t3T+71Fb0rtvgTqXqPydDc3ktkb8Q=;
 b=ezK9w7ikvcm7A9omk0nrScPlOTHiQYh9I+4NbXlle+s3o66myLBmG9LPGgfWq4AZBl
 DbsN0iyZ2M1KgNPROorzFT0+L9wcZkyE9T6LPRjM8O817VXqAhJkLDB4Wz/CkgX8EciT
 i3L1s7xw3mwxdCPf8JejpHERFCUlUUgRx4cJuSkWKBUYA6UvyhDEzV8t7neK6noMhrU1
 ysf4xJVOnwG5rEUpwsfpP4VZVolcRNmr8df+JwfgmXKSuLvJGC8eOvtOf/qGKpoWK3tj
 lb0kzfhdxBhgQhL4HtMr+bQsAtaW3PT7GNsK6GBAy8iRZjBBSV1B/2IYYpL/cRBeaMCg
 m8Aw==
X-Gm-Message-State: AOJu0YzG1vjWVVf371wDL1tjLZa+UkyJfMQM5m03qoynoWOvYA66kIuB
 K/muAPGCc6yMw+mEsdv4zhIRHwnbm+VhlWcCiVCtcTGVxJOjvhYkqxlN/ERG1pyJwzR9LZ8a09q
 KEQRuVJVb75p7OpfkG+yRxv+tr7xeD833cS8hFxiu
X-Gm-Gg: ATEYQzzfGAtavxkr68iHfPDCgWLME3pFsdhXwjmc3kH4BkGn+w6AXmmiizzO/drJadO
 SpAyiqsC5/a4O6w8gs65Oeqo1UDtfSDg/31CLetBBsV9lSThg8EocQJrUx3kbFMSlzy3xWfur50
 g2mfWtM1Sw51YixmzPUIMk/AXew+lsiRhykoI1d8bgX0CqwzknnU9ijcMVkDga7M79aeIIkotqx
 e0iv98MODHTH2OUNqFqOFx//RdmuK19cIKfaTLK29R3HWNfRKHrFCClhlsmnADaCp2FUivkg0EM
 28NEcOm3MxkfyDMZ
X-Received: by 2002:a17:907:a28a:b0:b98:5547:3de2 with SMTP id
 a640c23a62f3a-b9c3f2ddbbcmr48877966b.49.1775083782524; Wed, 01 Apr 2026
 15:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:49:30 -0400
X-Gm-Features: AQROBzAMGaCcYPHwddLwrVQWrhM45EN7XRgmdz1CqcjZ5N-GZhQSd1tDcESebQk
Message-ID: <CAFLszTjZDutvPsVJszhSEzeM3feat3-EUtUXno=rpnujVm6QPw@mail.gmail.com>
Subject: Re: [v3,00/15] add software ecdsa support
To: philippe.reynes@softathome.com
Cc: u-boot@lists.denx.de
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

Hi Philippe,,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> This serie adds the support of ecdsa with software
> using mbedtls.

Thanks for this series, a useful feature! Sorry for not reviewing an
earlier version.

Regards,
Simon
