Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78419E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7417586DDC;
	Sat,  7 Oct 2023 22:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AKuJrm9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FFD786DEE; Sat,  7 Oct 2023 22:37:58 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C033986DEC
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-538575a38ffso5396867a12.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711070; x=1697315870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4cPnN+0S3cb50G+NhmCdz2e1JH3TpyyoaI4XiocuVB4=;
 b=AKuJrm9c8fYrmeKnFqBNdoWYuW6//qQFHAUEjNDN6dwRexMaoszcXn2/Kv4KKyOx5e
 C3Mq9S1UuuhpIkEBTJdArtU8g+OAYTOA77ifvcQWckd3gvVt8ioDobzd1CY6ffCe0TVx
 tB3ULkAc6hpeG2o/ywB0NXB3JV9uOZ0eywJH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711070; x=1697315870;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cPnN+0S3cb50G+NhmCdz2e1JH3TpyyoaI4XiocuVB4=;
 b=EFQocc5YeIHaWzmTGzEI0gFSNFDiNYAXeOOy/Aa4jMI8CYZ1briX6hqQ7wIEL7OgdM
 DT4tJavUnaPm8dj4GVRube7OnAxkMYpZPyPNa9EBdl5UvHGioy1QK5M22LgQBpFNUsQa
 jc7kJ3TkoZlvhF0J6CPMSj52EWhLvZ0i2No6qWnf37ojQAxaLVyochRfa48iLdHpN6Ah
 1qWJhYOQliEmj5npe7qHLbLwgupo5IMzcCD59d0BwAyQ5TE2N666UVZq2LucQfZrotta
 3ddxFkgsWyhSDemhY6cHX3HeXr+X7H2Rmxoz1wveMsC+IO4XlGQ0IGVRf3stELLGfbjt
 /DOw==
X-Gm-Message-State: AOJu0Yx2nQka0aet0ar7kK5StNwdUAJeCXoQIpvWkZx6JlSRoPp+2Db+
 H4kPKmwrTvhiBthn+ag9PScRnv76GmPOk+llGPNyhIZyxdKymmW/ETw=
X-Google-Smtp-Source: AGHT+IFSIPi7ZNgNcoQVoK4Rxl0LAQbY8v2V9y5YI2HlKaEvX7mIGBfHKLMm7TZYSMCCJ1dtxDHaGEmmMnJniIJKvdU=
X-Received: by 2002:aa7:d683:0:b0:527:251e:1be8 with SMTP id
 d3-20020aa7d683000000b00527251e1be8mr10634738edr.13.1696711069987; Sat, 07
 Oct 2023 13:37:49 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:48 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ36npA2hkKFHDcmHgcdszX5Cn-cAJznZ-VdbAt1bkoA1A@mail.gmail.com>
References: <CAPnjgZ36npA2hkKFHDcmHgcdszX5Cn-cAJznZ-VdbAt1bkoA1A@mail.gmail.com>
 <20230923194424.1739224-17-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:48 -0700
X-Google-Sender-Auth: JUwQ_v-T-vPP6ckqNXxMfW5Ih_w
Message-ID: <CAPnjgZ2QvR4FAnxgysiP0ncTh7TdrrBmdKJ9eA_Q2K5knGJSHg@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] moveconfig: Fix misc pylint warnings
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Fix various remaining pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
