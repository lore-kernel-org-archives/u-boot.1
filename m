Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9BAC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ECB8888F5;
	Mon, 29 Jul 2024 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WCYTrb15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B311888AB; Mon, 29 Jul 2024 18:19:37 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0218882D
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso24725226d6.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269974; x=1722874774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jZTGGja+fQ8HVflhK4T93CylLii7x77PipQPTUhLKZ8=;
 b=WCYTrb15xnJ1BxFRNyUMb2VRxxBn3SB4ZzbCp1rzxrtb57+n81KXdTSW5g4UUxRrbf
 LDTBtfzYp5SQp8IKP7JsNMsRXBtBku8Wf1a4MCGAhQnXJneRM6yDck7obP9NfkBPUdFs
 rrQ5lnCr8+M0mbOBMMcM6IKm2P8+yulZAKEFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269974; x=1722874774;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jZTGGja+fQ8HVflhK4T93CylLii7x77PipQPTUhLKZ8=;
 b=xC9HOZIzGLh3dvXjWefozXc3rB2iEBtKjX2ezhwG2WYGHelcayggI7ju42k5o1yGVF
 hA8V+GeRG64U00egvFCm9L9r7Mook7tqcIxaxz5iEkDGYqHSD2IoLHAQpO5yfMEKyfsV
 t7eli511Bgm3TiSmoEehqzY49j2VGtFgRD8slZ7bcpLF7x6S0Esi8RdizwBP+dYi/w9x
 xKRN9v6D7tmf6MlNqf58fN4//QSIXSGAQsjSMi38f+SEN3acRoCIIfGvzpjHWd+5KbES
 6K3qvrKG4AzLClQC8L/txZZEgI1FWbdB4FYiiw0+ntZS/nT1e06upIYMfB9ehCHxPpgl
 NDZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEjni/TfDhzhRdEyO7TZFz0E2vuh8bTuf9kZqSFTy1rOVnnlgiJbVW2bbspm4/i+k49m9E45ybdqQ77TpKpoNpK18MZA==
X-Gm-Message-State: AOJu0YyW0Ecj4yiUIp0D7zojUab51Hsf7gLCDszsEXs1zd3VtcLRyxA9
 TSKbdoz6L+G7EUwfkbDlTOJV1LVJx9bZep8UYS+3NldU4MD6ANh43UFEcaVfvHY0vk33R7kuBn2
 ILnxTbmBZvgM6j7TwhPUgmEIBGlDpglN9g1Bf
X-Google-Smtp-Source: AGHT+IG9a4rczHYR3tklc2uB8yUDgGTphkl8WXhZf2jCHmsEzEseGfaf+lEbVOwtiVv4DNAmNqCfgw1OdTBhs7N/NKI=
X-Received: by 2002:ad4:5c44:0:b0:6b5:de3b:dc10 with SMTP id
 6a1803df08f44-6bb55aba971mr141539326d6.35.1722269974005; Mon, 29 Jul 2024
 09:19:34 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:33 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-9-sjg@chromium.org>
References: <20240720104950.2730773-9-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:33 -0700
X-Google-Sender-Auth: ZKZwUFMQkE0ytkAWXITpqpnK6S0
Message-ID: <CAFLszThQ+mk5+T6XhPouL=0_b0BQCUFcsXGucFUCUu2mhSfvqg@mail.gmail.com>
Subject: Re: [PATCH 08/20] binman: Correct comment in blob_dtb GetFdtEtype()
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
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

The filenames are a bit confused. Fix them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/blob_dtb.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
