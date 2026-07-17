Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46351C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A6784E30;
	Fri, 17 Jul 2026 15:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fAmNaIV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BDD384E38; Fri, 17 Jul 2026 15:47:42 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C08F84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so41060575ad.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296059; cv=none;
 d=google.com; s=arc-20260327;
 b=WWv3smTjodPy6eYZbm+zxUtCVZNA04FAdQ/8LTulPth2ZlZXtSvbbS4yNHqTnA+Xve
 JVT1jNBSDqNdC7Bt+i8vet2iop5XY2rf8mfUE3MS9FpOgW2aZsLLru4zZkvQoXJNxWwn
 iKEpp/zvooQMEJAxVLTP9ra4xrZS3yCQlnmNtsJc4jTUZltyNeQddBFHIdsucjwYwKQF
 SwB0DCPIAp81Fzy3WZ1rpDsRHZTW6jb2ExstZmYMhkPJF03wiHQidaC55ryeoJg7f+uu
 udm2fIZDhJdEhHSC/d9wD+avAhIHNqg1X44ImRS+LvNbrdPt2FI5kBV994E7Hx/9Eksr
 Z3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LXKbpDajiCrxAqTpGmNOruZlYWYItf3OKek2o8GBvV8=;
 fh=sYJEl6+nRqh9E1ET/JyMVreI5+I/7CZ9zjVJbNfsf/M=;
 b=s08zwuCtLy/vURauWAnpsZNlLqamrkhMUv4eM+nYyWUl10ZJwz77Cw7TXkYQNLt7iK
 0D9NfXyzApV4/4naD1XhQrxcNfK5XyX/a35J9xbecznYYdiH8vBzqh+0OZFWtungr1en
 cB0k0vPsaPpfCJR1rl1i/e0osXYViKGvFWWnMqYKSfOO1spGygwanijZXZCPvDHg6m7O
 GQ2XRGm6LQQW6ELJwV/28amKc3GNuZwbZh1Oez50jkeuKzI6LYOrI7LLLEV7+4OcoOrJ
 HOvea/EiNuTTLaOQmyhYoHdh/RVux+7SV3Cen069fMJ10CFYrU0o3JMi+WjZ3c6xbmzK
 uGBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784296059; x=1784900859; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LXKbpDajiCrxAqTpGmNOruZlYWYItf3OKek2o8GBvV8=;
 b=fAmNaIV+SI6M/7bFkIFQEP5a5NxxM6bXNvjlcvs9DBdcau2PedlhLriaAAJ9fec0ZQ
 n/YyBYWE8QPzt1tjCcsy+WLN8IhHNunUn7QYN+x+J4pfi8hviUyrJcs1ctfcz04pZ6NS
 R8dNqWpfTCQOU0xFPPIxzUxvNeNSjHSaSpLDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296059; x=1784900859;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LXKbpDajiCrxAqTpGmNOruZlYWYItf3OKek2o8GBvV8=;
 b=cFwjcrgp1IKU8mquQPwxIuYHa6UVwQOwc42RV7i9llAfBXi6zOiVwanVSwchaAcjts
 ki4Vkg7n9QKgKlYfjfeI5+bZrUTnpLSIQJhSDwSAP8IXbpW3W5KTLeVQU8IAnCHpY9Zq
 FJPDmSTEYS8T2s3h5BoK49doPI2UhSNQOYufO6T5YMiLzjGL/EuyVjkg+/zN7LTQJUMz
 ZVUOsLt7QrJuqEfTtZhuThGPyMfi+MgD+EXbCuLyte/tlCJ598yBfwN1GohXA6aa2wv9
 LltyU/cFrFbMzdArE2AetiKKojGqeDMsh9/ajZIZJYMnolCMCG3hrjtYAmJby/pSof8p
 zH0g==
X-Gm-Message-State: AOJu0YyjUy4Tm7cfESYp2D0mrzChXMJMpls94bq+W71LMytgboc2jwo8
 FUYSbrzG36W7GNb8I36jnfdpCiQ8W89kc+YOIIpDROQTz9x5mPQoVMHC90ubr3+vw10mjzQfcVY
 yDx8ErKbvSSaY6QIONGtUQZu0lbnBgeqR5u0+rdP6Z8IAaSuAg/M=
X-Gm-Gg: AfdE7cmVwiudT7vPzjLbLzWuS6Z5yjd0fGa7R1Q7LgDa49vhvwG60m88WI+0D4KxO7P
 4jcBbVu+B6INCgFVyNJ36F7lBY4qWXwa6cChOUlecaJVRVdHEGJyEKKYXP59gJ8Z+GcY6mOMekt
 7Q8MuAB1KwVUPJ8narNJMbDogUQSOYUlB6H9fxAiRW78TOBAecZ3XMC2H/wA0EkIko+QTbqNM7Y
 7zTq3bqSPJRZ3wELwogW9rEp0vQfghlTmqgTKtt3kqousC+FKx4ZF0ebcw/
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id
 d9443c01a7336-2cf349b5923mr28950545ad.32.1784296058713; Fri, 17 Jul 2026
 06:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:47:24 -0600
X-Gm-Features: AUfX_myBQ4YzfQKyxkLBna_IjdQWbHkIBbWxW4qy6xhV_KTL2za7oe_QF8NNYKo
Message-ID: <CAFLszTj7P8Gq4MeRq_SxNNShr4Mujbyg4YQy1LqzU8igxNqutA@mail.gmail.com>
Subject: Re: [0/8] usb: eth: Add CDC ECM/NCM support
To: jonas@kwiboo.se
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

Hi Jonas,

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:

> U-Boot currently only has support for automatic binding of the first
> device configuration for devices, so this implementaion works by adding
> bindings for VID/PID pairs and letting the drivers try to change active
> configuration during probe.

Since the VID/PID approach works around the USB core only matching
against the first configuration, please can you record that limitation
somewhere more permanent than the cover letter, e.g. a comment near
the new helper?

BTW there is a typo here: 'implementaion'

> Patch 5-6 adds drivers for CDC ECM and CDC NCM.

The config-descriptor walking code in the two drivers is nearly
identical, with the same interface/endpoint/functional-descriptor loop
in each. Since you already have a common file, please can you see
whether that loop can be shared, with the drivers providing just the
matching logic? Then any fixes to the parsing only need to be made
once.

> The driver implementations was created based of the CDC ECM 1.2 and
> CDC NCM 1.1 specifications and was tested on a few different USB
> Ethernet adapters using ASIX or Realtek IC.

This series has no tests. We already have sandbox USB emulators for
flash, keyboard and hub devices in drivers/usb/emul, so it should be
possible to add a CDC ECM emulator and a test which binds the driver
and exercises the descriptor parsing. That parsing handles untrusted
data from the device, so it is exactly the sort of code that benefits
from tests. Even covering just the ECM driver would help. What do you
think?

Regards,
Simon
