Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC84CF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AC283F53;
	Wed, 19 Nov 2025 14:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBfQZJxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCAF83F56; Wed, 19 Nov 2025 14:16:50 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6462883F4E
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b472842981fso836879866b.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558208; x=1764163008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AqjtKPABTDFWgxkPoHN7r4u1cVqs4kKBE6uo6wHVvq4=;
 b=CBfQZJxJFv+IoHBzYnvKH0U8vg30OTdO73gptOrNxJFEoVR78CTRqialv0lmRokYkt
 BVI42s5VBFasphCfYiP/jZG2Gqh+vg6gx4ChASg1Ad6oEifJJSPILgtQLDz4BYpnDRpV
 8hEZtaaWhCPZUydUFA2BD6/52XU/R6K4RUonk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558208; x=1764163008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqjtKPABTDFWgxkPoHN7r4u1cVqs4kKBE6uo6wHVvq4=;
 b=bGT2rEUUQ6+vdUuPzCk1+rKacvbtqDy7mVAy159NWyuONQ+PU/p95wUFlneppDvMQ+
 75YyU0pLrl51LoYCMZ0HdcopUkHtZNOd/60vW5GgvLcLkbKhV4b7l4I6rwu02lwhIHe7
 qr6SXwUViVRpKTY6pJfRigigzcUYa1V/6jr0xqD46DWjG+zsTr4iIA1ssxzVzs/TxQfq
 Xb4zaPaepdIuM6AYsRYI99mwYpA7gmnXZE7QSUpjaaM5aX3DUy7fGh4P54wOcgjFZfEI
 wrsoQlZ63bWpNqvGp06Qp5jC2t8uIDJvqmsFcDiz15Cw97es/wV+2SbYJ9U2ZHXb+lev
 pWWg==
X-Gm-Message-State: AOJu0Yy7UeI1mYqZ6YBNDi7FIu4RrNa6Xn+uCrjZzgrSwo6j2oBEFpV1
 7CAtkt9SSlcVIY3uyadOD42heLwXvG711g2RxUEUUZf1L8X3B/A1IS6wd65OHaqyFyOuUHwN1OX
 pWD2jaBFHsuB8R6YtMSLCtc71u/97HCrHvyIaThU4
X-Gm-Gg: ASbGncvsjUYw0twIuyubq0N81a7So8qZOuAEykJ+1sjxyUducH3B89vzL770W9zOgAA
 gF6eSq6iyo62nbvqHgeoZUGavZu595QMk4OfOU6dryPzXYMGEdIPhv4KaVqf6r3ykyl2tHIv92U
 1MdMm4nQunDFgBl2GJkbgmR840byunV0lz+APe4D9qEcyx5pyd0nh9ALiu72dEG9iJu5mXZSqDv
 0NM9bJzdw3sHlX5VX8PU0ar9u/OGLxgt3K2mYqJMrRaHTQ1k8AjcJPv6B+H12Y3PL2Gtw==
X-Google-Smtp-Source: AGHT+IG4Xfbl7M0S/SsC+zkFnxAXEwph5K4aXnc9DoWDn4k5H8dbb3cXvzVbCCVQjBre7vnUSc/Mf1NYxi7YjE2i2+s=
X-Received: by 2002:a17:906:c10b:b0:b3b:5fe6:577a with SMTP id
 a640c23a62f3a-b73677ece6fmr1838835366b.8.1763558207808; Wed, 19 Nov 2025
 05:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-2-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-2-e053f683c0b8@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:19 -0700
X-Gm-Features: AWmQ_bmt8yhhq--EX5jj_CKk6q6tpF3Yqo9hjW3Nrtp_Hz2lL-tYPBdKFQVv0qs
Message-ID: <CAFLszThkqMi5jxWArGrqSfnMnX5P-RbHW5Xc8_GEMGjmPhyiVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tools: binman: mkimage: add support for passing
 the engine
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Yannic Moog <y.moog@phytec.de>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Mon, 17 Nov 2025 at 12:43, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> mkimage has support for OpenSSL engines but binman currently doesn't for
> direct callers of mkimage (e.g. the fit etype). This prepares for adding
> support for OpenSSL engines for signing elements of a FIT image, which
> will done in the next commit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/btool/mkimage.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

patchwork seems to be done, so I cannot try the test coverage

Reviewed-by: Simon Glass <sjg@chromium.org>
