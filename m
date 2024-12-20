Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF1E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D4880429;
	Fri, 20 Dec 2024 05:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O6xTfwpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B39C80542; Fri, 20 Dec 2024 05:05:57 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74198037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aabbb507998so283510966b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667555; x=1735272355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CHLHL54DHGL3+CaQY5tcarXfkjF1tw5DNMjKyRy+eEg=;
 b=O6xTfwpxqSaUQA5o/0RVhN8xNF4tpI8npZ4X5OZABmTkdrGYPNG+N4boajZSrm7r2i
 VK53VFCwcAG9TLlv9dMZOZN5CsSZiia/0mhDnP1LDPrGClLlqkIsfMDSTqNeADwv6hYJ
 e1vzUJBYOObUlASuPXUoiNJgNo2Th8ifG7sHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667555; x=1735272355;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHLHL54DHGL3+CaQY5tcarXfkjF1tw5DNMjKyRy+eEg=;
 b=HSwiNskoDfrHOgQZ0NdiTxFPQb4SwpDwLQiwJ3BO2E+Qvq9mUgZzWN1QT1+Bna5bRU
 31EQPzieBaueiZXQcObfqJFujHVluwnnQQV2JsL8K0wmZO5y22oURQE9j3x6+MUII/dU
 TazB0OsOnJD2t++ufnE/v1hjlaR5NBGAJOebywA6/YlrAQDtalcy/JQexqio63/3tK3q
 e/JQQ7ag7KX5vethIaY4D7+ZRLoUtxGg6JGUr1McIsgg2ZeHo3neKFtnzjqfAyMqsE7B
 MtgD97lTWMZ6t9zquOXE5y7gkqklVxfxceXq+zOJL8pWfMAMJkQOqP9nSWQj9RM1289+
 YXow==
X-Forwarded-Encrypted: i=1;
 AJvYcCW004FC9KwWE8BJJNwndMWkrhDcm4B0PWoDy4qt2xcY6Z6Lb6SS0vgIdgc7vC2Xp2ZjMcFgsuU=@lists.denx.de
X-Gm-Message-State: AOJu0YyXxV1O3PWXYkPYjgty8dq76PAQVRUVE3XFgMz6N5e/uE1c2Ub8
 XIQfzQiz+fvB20Me7cmJci9d7GCDivfn00J9R5VjUsK6FyMK5sUIYt6s3TsDhGEiC4Sjwyhn+P6
 i2E3cv7CNtg5EWsPn23qp9fZon0ATDPI4wc60
X-Gm-Gg: ASbGncsft4VGEaPsh0d7UeBSKscTRIel6VlO8sC/RmSuWreq1VOUA8gmlVL2QZAbxdL
 K1qDyAF2Eq8Sqs25EpAYHQ85tjPBhZhUNuzIannM=
X-Google-Smtp-Source: AGHT+IFwv/zcp0MGGIrKRITPp02ne6Xo0cNwYB40SLNfd3lCtkb2UuDNtN8DDBtbSpw/OQxcTf+a959ecu8kWIDI9gU=
X-Received: by 2002:a17:907:d87:b0:aa6:7107:db00 with SMTP id
 a640c23a62f3a-aac33666102mr93083666b.50.1734667555116; Thu, 19 Dec 2024
 20:05:55 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:05:54 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-26-sjg@chromium.org>
References: <20241206023626.2456858-26-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:05:54 +0000
X-Google-Sender-Auth: 035Iga7B6KtTA8NEmxZq3F8_Qww
Message-ID: <CAFLszThwEMbj7ZL7erMFSiz+RRc6ABFCUZWAZJy8PV65Zfjyhg@mail.gmail.com>
Subject: Re: [PATCH v3 25/46] net: Return the address and size from
 parse_addr_size()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

Rather than updating the global, update the value of some parameters,
so the action of the function is simpler.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Applied to sjg/master, thanks!
