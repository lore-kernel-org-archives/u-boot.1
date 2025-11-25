Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7024D0EE1C
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 21:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085CE84132;
	Tue, 25 Nov 2025 22:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPaHCSCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A17E84137; Tue, 25 Nov 2025 22:34:07 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 203E884101
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 22:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c75387bb27so1796997a34.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764106444; x=1764711244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tU76EpcIl3/EaMUt7CLRiU/OzqLXrnJdekSdpFoS6nk=;
 b=DPaHCSCb3kwSeHFHYxApPuhS7i6hS9W6Og8xef1ciNPrkfLGAHJORZkEZUedAvEE6y
 KvuuQiEAHYh5WcYHBfhiJtVD5+GqsJenAeVIs0nMuVyJ7bxg0yiAGDQrUs3S9ei01wKf
 Ro6YEb1A+kbDklXcbwdYKCPhfH2gqo9GH1d8+eHHww5gzMaUH4PK+MCceb/BkDMd4ioK
 BTWRnYRvJ8J9lSXTCQjvPElYxri/EXaP9tAr/PG3vw2VO7nxP5NrcsKNLVuhjhh6Asqi
 OG9n0q0s60T4BBANKs62X/T47zFfC+qHrmc8rEkz5AjRmsl+2HXQ6N7msrVsII7SIWbm
 yu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764106444; x=1764711244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tU76EpcIl3/EaMUt7CLRiU/OzqLXrnJdekSdpFoS6nk=;
 b=GtbnU/rgFRaSSlxWo/kMKg6aAL2clJlV2+XpVDTtw0GfwHo4+kXQf3hTJKOu3GGqWW
 McVLE5a2iLC5FJLKKJfvxEJyz61+Drwk9O6rGszeVrX8nvp03rL/X90HGi7SedWK1s/V
 FeRvWroaTcYROeoQYxusfzBSzvW3qHNM+0HEh31s3zDThO4W2Bp00z7dLZv0wGoox6pI
 toU9UoO88Q26REx0UPozShcXJ83Hmjg6J+otm73AqcnobKhw2WjkjU8JBlDR0qU5iRAb
 y9YyN5hyUZCFuy+f2JBjJITH0nEvf5p/18FJCQ7VcviA0hM/e6/Hhd+D6e0UWs7ug3Qn
 ajNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd105kf8p8q+vY1Y08S17Oh0xVKlXYRRXnZeHTdlbWnXgHBDlAuw3oa4w9QLs4KMSIABVA/6I=@lists.denx.de
X-Gm-Message-State: AOJu0YygEMzJ55nLHWMBR0r3gne8YMv9Q0P77xIhjm/RqysXxNfZdqsu
 3FHYrxhTSMn17DSWTCKEAYKExJ/qLw/A6nB4w34pFTdXK/qyyxn+2bJlDnJYGXGah4I+sFXq89W
 q8csKe02+ZoXOQ0VhaU3ES2vHwUoYh/w=
X-Gm-Gg: ASbGnctoLeziL6+VD0WCHjZD+OelviC77OVtPgwninu7QtlRFUd1IN0FKU7ma22K40m
 dx6PMji38bmLXogH4iwT2Etw0fwX9cd4411xHElVVfHPSukA4Q0H5M2zhWZPpEBncas0+cfo/B0
 hxDKIBUrLembD7JKR/ZKRBsyEFJwooxNXPyCDEjc7fKm99vbRVwUpbDJuMSGWy+VndhaF2d/XH1
 lCCgmXFkGd74PI/uSS2SMydh4QiROugve+2l1r+5jO5/fU76OlrNnQihhLTC4kEnzVaOlHmR0/H
 yktU
X-Google-Smtp-Source: AGHT+IGvkyNUffCkieSvOmUT6o0EdiaxvV5Adra48xF3bcA1ioe70KaX+4339wV5CTWO1OK069KzfFxdQ92LSfiVUjg=
X-Received: by 2002:a05:6830:3147:b0:7c7:59a1:48be with SMTP id
 46e09a7af769-7c798ac9483mr8422594a34.5.1764106443795; Tue, 25 Nov 2025
 13:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20251125123847.307-1-briansune@gmail.com>
 <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
In-Reply-To: <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 26 Nov 2025 05:33:51 +0800
X-Gm-Features: AWmQ_bmafM8UFspdYrJjyIQWtOH-KXJpygBlZOErNHCqdpKzpZYEyN3OWROqq9s
Message-ID: <CAN7C2SAh5cfXKWxVq1omhtTkgbbFCZ2-kcG8A-+tggWuPUWqpA@mail.gmail.com>
Subject: Re: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Are you even sure SPL_CYCLIC is required? Wouldn't enabling CYCLIC be
> enough?

Short test answer is no. SPL_CYCLIC must be init with default timeout #.

> Since you have not identified the root issue yet, can you please provide
> the actual defconfig used before this change so we can figure out what
> is happening, if other boards are impacted and how to fix it properly so
> this possible misconfiguration cannot happen anymore?

socfpga_cyclone5_defconfig

But my patch did not target ONE config file. Because the risk or possible
hazard could happen on other GEN5 socfpga. Need others to report btw.
b.c. it requires complete fresh build to trigger possibly.

New patch V4 had pushed. CMD CYCLIC seems like not a must.

Brian
