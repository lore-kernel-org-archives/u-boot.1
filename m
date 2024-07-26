Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAB7C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2E88871A;
	Fri, 26 Jul 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NhGPNXUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF3C886E7; Fri, 26 Jul 2024 14:59:16 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD82988570
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d5b22f97b7so574642eaf.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998752; x=1722603552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VKxV7UdDDLKfkURQQwLYmrtGBzq97334bx4X6aI5H1w=;
 b=NhGPNXUsgyPTCcs3JbJmEFpZCuHkkRgkJ3Ztc4tAWHhvTqGmeD2d1e9YyITJ75uvR4
 GhKDWTPjmc2AxhN0L+dLy62s++bPURRg5RPgnoIpCp52DNunEHTsyCt33xZi6Jsl3Slh
 xoWcNTe/iBiHzlZ4zJ3xA74vVeD8wDhZX4ORE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998752; x=1722603552;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKxV7UdDDLKfkURQQwLYmrtGBzq97334bx4X6aI5H1w=;
 b=H9kQzFxhb2GA9hU97GyM08VZ8+WW8WEnHxWR+3nXbboma22NDcSLktD6e1kV8rQDph
 JFMlHsLm1yo4Z/mkwOWeqBSHeHbhYoFM2q0wax1D1e3yVyCqsus81VpnVWf4+4SEqJhq
 /tUK2gkK72DNwlp1J/OIdKzMef4q9zqtlloQLqjcY39xTp33IPRNFqh8bnYd/269XbMt
 DzS0lOwJDc5joo921kdalLsPvbDFUW+wq+4d29Hi9fngwoNVYqgJj386jZw7AeU9XYjU
 eVjwOuC4P0doBnYgcC8kN9JhHLGigz9e8PAiPst53ZjjwjrcUNnHmzj1xGluQaRXsCb6
 0inA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW53Lelayi/QpVB0+3S9dGKiTJKZwrfV1uemaeblWTUy0F30rvL0Sr9HicI9SwGiiOczElvJmxGYqW7CWhhesKxlVPkXQ==
X-Gm-Message-State: AOJu0Yy14OOnUHp3dv37GEpXJgePoz+L8i+0mBPqMES/nj/o2b8gVJJb
 DaI5Fg339LlJGyjksJr9qn1+9kGfSKJiB1u+Hr+bgZq7uvDtlqInHsO5Gb3OSCnVKJRgbKwtZrp
 sksFvkhlDRn+wYBbKva4JvmLI/kH0RTiM1TuGZgPPVysnEXQ=
X-Google-Smtp-Source: AGHT+IFEpzmjkKGPLbAF15MCMLeOIx3lMHTflnpel3j4nttY7tEBEsXdx2QVMSqR03iGQ7onKN6g4cMU7gYEtrlTlnA=
X-Received: by 2002:a05:6358:310d:b0:1aa:c98b:a9ff with SMTP id
 e5c5f4694b2df-1acf8915b87mr677745355d.29.1721998752519; Fri, 26 Jul 2024
 05:59:12 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:11 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-8-sjg@chromium.org>
References: <20240717155712.2913651-8-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:11 -0700
X-Google-Sender-Auth: 6x8OsEgntxDLBimBvWL6Fw5UBqA
Message-ID: <CAFLszTipsVz9_G0-KzmHwTNixqQMkf-NBC0+FORh9na3Rhcv=A@mail.gmail.com>
Subject: Re: [PATCH 07/24] qconfig: Move arg parsing into a separate function
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

Reduce the size of main() by putting this code into its own function.
For now the parser object needs to be returned too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
