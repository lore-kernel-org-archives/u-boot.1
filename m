Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A805DC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAFB816AF;
	Tue,  4 Mar 2025 16:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a0cVKqxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79848169D; Tue,  4 Mar 2025 16:37:05 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD0E81298
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e50de0b5easo4652743a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102623; x=1741707423; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AenkF8LLFusIM2TeZkAQeF7k4ACuhIJNA920sH6PLdI=;
 b=a0cVKqxzQ1Wge/dSqjH9h6aocNDuNzA7LET5lwM4ZNcPrwlDFC3y7iXnhMHd8cH4l6
 6omoGJCxu4RF7eNBQ5iq0hEuBTEltMIJ+D0Ma1FWgRWX/hVs/ArK7wNoMcQpqngUHteL
 wp2r0tgTplPvGpFroj+cyfp+FuA8uY6bW9Pyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102623; x=1741707423;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AenkF8LLFusIM2TeZkAQeF7k4ACuhIJNA920sH6PLdI=;
 b=EJvr3/WdY15RL+ElCnO3hSK8CBDsKbjTkiHQ7D1ASVCJ5TsclM8x0qYTjyhL1m3xsl
 tYojN/qk2jlnN4IPRr2N02U0BP7uFyt6QkHl5gq4tPZpHiFPwI8x4TDeyGbQhbN9cS4k
 78CulvkzJ6A5/uG/o9q4RX19cZIwft8R6nTQAMWE1nTqUy64BqyzvVfxBnpQFuRDvU90
 VM5J/wczqcKAVB+RNX+IjP+mKvX/3n7452Ex9BJqHQ4sIFNg+6UpaKkTuJcpLQaSJJwY
 XoptjD2jBPRV1wzv8sH0zez1Oujs5Pa7FFLGefZXNyDqeiPoso7s/zUjcbGNlUE2grdo
 wv3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDsZSGl0Mw4+sosqMFqy6fmMV519AkSY14t5DjeHd8rNSICPTKU80ZtmBU/SCbE+Rc3jEZwa0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9AUYeBwx5Et8caj219CCdsiAC1ptPIKl6MTa0RlAvnylsAMRM
 oQvsaTh2VnnW9XgO+jOhWM3ACO1N5bf1OaLN7Z6HgaCs2aZswBDPow12kJR1r7npYA3E5tPzinV
 M8TVkOOUqSIBB7bdB9qnGt/rrhZd3EXfZGdoD
X-Gm-Gg: ASbGncvZWUTbz6rTSy3YWDO71qqiE4NQUmnphQgha6mndAGss46dwdRagJli9vWgoPd
 TgomtYsKNdHYoYhEdJ28gMSgrZG5nvi5HvGA2YOV4YCsKp5MxeYRRmi9Dj2mwrT8lE8oqqHGQWz
 jJ2eWjCyI3bUvTKv1+9D8Yba2z91E=
X-Google-Smtp-Source: AGHT+IHPtO5VZzryHVs/o52sK3b5HCjQ3DZ7AThRAH8u4sDQrLKX+ZgEN294GbpQJneH3rOXHTLbNIguFzTAECAlsg0=
X-Received: by 2002:a17:907:c0f:b0:ac1:e53c:d149 with SMTP id
 a640c23a62f3a-ac1e53cdc73mr555307066b.13.1741102623289; Tue, 04 Mar 2025
 07:37:03 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 10:37:00 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 10:37:00 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-7-sjg@chromium.org>
References: <20241018030027.842749-7-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 10:37:00 -0500
X-Google-Sender-Auth: fkee6VYKkMM2rcDAEEqtQ6N-jEM
X-Gm-Features: AQ5f1JqJj7dI7SpW2KHYQS1_U-VqH7EQTofE5WzIBWqc-PxdsBzj7sLUcGTgv-Q
Message-ID: <CAFLszTiWqhi=Z75sFcSFpqycD479QHqH1F4gme_yjhoBrR+jdg@mail.gmail.com>
Subject: Re: [PATCH 6/8] membuf: Add some tests
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>, 
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

Add tests for the membuf implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/lib/Makefile |   1 +
 test/lib/membuf.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 test/lib/membuf.c

Applied to sjg/master, thanks!
