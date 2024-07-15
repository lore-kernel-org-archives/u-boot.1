Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEE1C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BB988865;
	Mon, 15 Jul 2024 15:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q5FlfX1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7BA88872; Mon, 15 Jul 2024 15:31:27 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D308886D
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b5d3113168so27579376d6.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050283; x=1721655083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G29PYriBV1SBW0zBmzHJIs8ilDdmoTN552A5SNQTHjY=;
 b=Q5FlfX1blJbIY0sBak/K+yqJDbYlksu2BqTRehfiHI/L8L4/gWlLnbhZaGMVX5oS0j
 F2oyLUdF02Nc3o/1BQV/6u0okteH0k2yxHFxaOKBAjHgr9LaG0MYW4AkKmEtghOhG0VU
 kZ08GRX+B/YH9SMv84DnS0w2zdesvXWKIMdpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050283; x=1721655083;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G29PYriBV1SBW0zBmzHJIs8ilDdmoTN552A5SNQTHjY=;
 b=ZzQCQrV4JlgS3pgQucHNbZLwWql3Eb6S7MjqTH5zlENKDk7wglIb817BJyu+6dl978
 SnU0Bnn1VZv/Qyl2Q3/pFR5omIUbBD0z/FNVzlNPezuQ5wQdq/Hg8bqzCoOJYcsmc0Qd
 gq+BjxOC6R3/beSLbSUV80g5s5/+uSsA0XDazxqwtRqTXzhOQCg+bYl2DI+e8+bCIPWh
 QFWspP+KZJdraVuoSqaOWxB/zn9GjVGO0/BC4Oo+p2cbnt46YBMrKUHZqjNE7+dQTMzd
 4oBO+b+NBPVcx4mDhghcVeDPgl7ab+JEU42pqJv+bMox+jxVrpzhQlhlbCb5kpl0mTWZ
 YDhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBmDRgm8bKagjP76/FHdnoQwWQI0FooH2DA6M01DoL/fXXZApmink9a05SRrGZy7diVxTzn2tMI3u+dOm31gCDVgoCYg==
X-Gm-Message-State: AOJu0YyJpWmOjvUK9hwi+URnpSHWZbb6mC+SuYiLFCxraWA02sLdNTNJ
 vNp8tAbe2pE4wShirDSmmwqHKLuWSgcrok7kd7usAd6Xji6qWfeB4+nowAS2KaRFRTg49PvT0RJ
 1/20GkLALWVbG7NzC3Gt0mnkBk1yumFFt/zF0
X-Google-Smtp-Source: AGHT+IEu6LOQpGJwXTkFJGBmMp5aBHFL1ZqFXuVfsVZzSpyJt/tEthAg9454ddaVY9oTNlVzHm06jQhUKFOS2v5cj6M=
X-Received: by 2002:ad4:4ee4:0:b0:6b5:3eb:6cf6 with SMTP id
 6a1803df08f44-6b61c1af55dmr258495146d6.40.1721050283225; Mon, 15 Jul 2024
 06:31:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:22 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175622.1468600-3-sjg@chromium.org>
References: <20240623175622.1468600-3-sjg@chromium.org>
 <20240623175622.1468600-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:22 -0700
X-Google-Sender-Auth: DPLj2BDnjQPuuIy1Fpte7mkMaJU
Message-ID: <CAFLszTjYK7_BGss9MTMXbHbuNvvLGnUjr9Z3jGLmQYts4652bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] buildman: Add python3-pycryptodome
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>, 
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

This is used by some Binman entry types, so add it to allow more tests
to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add to buildman requirements instead

 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm, thanks!
