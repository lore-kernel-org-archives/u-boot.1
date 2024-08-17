Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA65C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA9C88A75;
	Sat, 17 Aug 2024 17:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N4Ecnbhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249D0886F9; Sat, 17 Aug 2024 17:58:36 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29FC88898
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-66a048806e6so29762837b3.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910313; x=1724515113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SjIOsBGzhR8dEUk9AxFIOjLmp2BO9E8j/awoRkcfD8M=;
 b=N4EcnbhiwpdUcRgoXky8Xll4bBk93/z6Pnt1e+BjDXE61WVb4m4lS5N5Qs3bIMWOWT
 1l8JZrk2Q0ZmU8W/jjWJUe/HNMG+UpADQQpWr5q9FMQrA5BWdnm1ISyHg2bH6xgODkNb
 RPd3Gy8Milba1N2RI3RHwXnIBw4crlSzakeVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910313; x=1724515113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SjIOsBGzhR8dEUk9AxFIOjLmp2BO9E8j/awoRkcfD8M=;
 b=GP9JKjpdzPBgJv3oj7QgbEUA9Pex/MRfCeAp3nTq1NpIIrU7yiGn2Qphh3XsI6qr1P
 EXTIo/hCjLdcGOPEC9kHPoDZvjvmCUXmV/nGnbRIzbXbkuW3h+8e/YXFUbhaoQkrhl9N
 EWH1PBtadfhQWyTGoi5cgZ6tBAefsy4XC20Em27tnM8LIB5waER13IKGsZnLIG6HLNRJ
 gB18N8zZDJTKhvTCTTlrcoW85gMqBylO4OTyrZcXV549hCk1SdrwnUVVI733QBzwopt7
 XyNu2z5HAVFWlWexrPgp0W29+/U/b6cmlsZZSSw6vhn84j+M8b80t5R1uSdApF6V9i7Y
 6xsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIOr9uFpfUOpuIHxHYHZhjTPaVSWI73Ph+xtXX86dR36N+9bYVvjKzPDqLwGM7G+D4bwf6nQJfpoBO5FjUseMvef/abQ==
X-Gm-Message-State: AOJu0YzYlSpaSxfbaffHDFMe5L6N0Q35YGOkBMLMtgQMvdLKSWdj650t
 l8FKOkVld8GB/8K8C6CWYKF4xj4MwqeDnIj+VKT5OB+UcWWLV7bDD2P/twVMV7ARJ/LrkRVBR1T
 XOMzwRxITHUALRNd62KQ/+s7Yg0oPanVQC06a
X-Google-Smtp-Source: AGHT+IECawdUBzM2bctCDzS+8h/tknlhWHXbZsL+uAsX3QkvI8M+H+7Ky6WLe7E8SiDIDVprdTVLfAm4kQEQwoQM/pA=
X-Received: by 2002:a05:690c:3103:b0:6b0:12fc:71fb with SMTP id
 00721157ae682-6b1b89071a3mr59969667b3.18.1723910312906; Sat, 17 Aug 2024
 08:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-6-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-6-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:22 -0600
Message-ID: <CAFLszTjKE-LSG96mCDX8dzg8=cahB_tm2dK5oUrvBe0MvO3emQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 5/9] net/tcp: rename ack_edge and seq_init to
 more common rcv_nxt and irs
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Use the names from RFC 9293
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net/tcp.h |  8 ++++----
>  net/tcp.c         | 32 ++++++++++++++++----------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
