Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968B2E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589EE80542;
	Fri, 20 Dec 2024 05:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D06me3Td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E937880569; Fri, 20 Dec 2024 05:06:14 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40DE8036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso232079966b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667572; x=1735272372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pdrFkDCH4rdouzk6Qo15OTlZAoYTGUQCBa97P+NGSKM=;
 b=D06me3TdHVAHmW6VZfo/Y7JFGmAYo7BRxqsusNBLSCO7//+V5Z+cLFV4dxR4Ndwyhg
 sH5++BgQDK7KW6wZAmlDAzBK1NhomXw7g/xfq8kdOfTnRJp4PgOmXZEaNFr6tBDgy5ql
 xE7Vqz/5E0o8lbXW2LRW8pEf8nZzuNiTp6Rfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667572; x=1735272372;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdrFkDCH4rdouzk6Qo15OTlZAoYTGUQCBa97P+NGSKM=;
 b=wFCN6StG7eVaEjIxlfXAWUdV7I9m7TaIM+ihHoX7JLxTVU6cUFwq7Gre9BgiizinrD
 Nsale1VaA9VKJ4uhXmC6i1tCvB8rAzcGP2xg8S14DOTTvrXMTL8i1kDzeG5pWJms9FZ0
 McDhxWH0A8+mxP+VEhiDQDal0CXg5anRiD3MTM5Ll+0n3Jayo9FGfOD7Mt2/GvVTThAK
 GGamnHCbM+VyX1Z2JityHWQ9hAa44Uzi7yNS3A27cCheSmhHsTGVBY/r00b54BdzP48z
 tautw8QQHYsDBXQFy9JbkLmQVqLWEEeuLWJ8jXkOBWNaK13u4TvcaIkoaY5SP4AScyus
 xeaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv1PeDaqQ8gbhVaI4Ff/4kH3CJvBsrEjQBvtobghY+m42216Hqd64dBUPeWotF0v4SSPaQQB0=@lists.denx.de
X-Gm-Message-State: AOJu0YyNqKIu/uCwxT0Aagb+QzFrblryWOGxFRqNJEDwRh1Bz+lZ+KJe
 Gu7D27roZy2U9LGv929zMJu5agY0ILx59Fs7JoR2Jgnj/5kxyxgza5faw3nQQobRLqA7z/5cxUS
 Q4JpTAMH8+ywRGyfrDndoy6ppmPcnKR34WhI8ZIcN6UGE1wE=
X-Gm-Gg: ASbGncuamddo6lPb+XQ5+cgqRsrpPnCeRAP+d3etT2ALCM5LIo5x3rgLLIVkQRb6hqz
 wCz5OmelAGnBNEw2q0RS7a29mjCGTf3n5yuxIgXk=
X-Google-Smtp-Source: AGHT+IHCoK1Fn6eytgch39kq/YwYFwwhhdfRaLJnA8bGIfsmc7BsHXNgs8m1UP72cJglZRKEmyXa450Kdlrs5slYgBo=
X-Received: by 2002:a17:907:da6:b0:aa6:824c:4ae5 with SMTP id
 a640c23a62f3a-aac345f5cfbmr98210066b.56.1734667572439; Thu, 19 Dec 2024
 20:06:12 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:11 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-20-sjg@chromium.org>
References: <20241206023626.2456858-20-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:11 +0000
X-Google-Sender-Auth: t73Kts6du1Nj_muuBg7uekOxodo
Message-ID: <CAFLszTh+A961YLTmvZt8gvKV5wNhZD=cq4-2ncA1nhySzAZqMw@mail.gmail.com>
Subject: Re: [PATCH v3 19/46] pxe_utils: Simplify default fdt in
 label_run_boot()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
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

Tidy up this code a little to avoid two calls to env_get() for both
fdt_addr and fdtcontroladdr

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Add new patch to simplify the code reading fdtcontroladdr and fdt_addr

 boot/pxe_utils.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

Applied to sjg/master, thanks!
