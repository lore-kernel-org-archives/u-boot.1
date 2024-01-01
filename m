Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1268C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C565987809;
	Mon,  1 Jan 2024 17:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VMjafMZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC45387076; Mon,  1 Jan 2024 17:49:28 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204A087721
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680b1335af6so5896486d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127762; x=1704732562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bkHamMqbKCKlXBM+tsdsGplB9QUc6KD1Igglus6LJrA=;
 b=VMjafMZGKF9u93kArshyPQQrm5joIpS0q6F2AS9pgPcHnNJkK/8dVPb3mkGXJNq++H
 GG/MzLxNvuurawhNdel0c4mPjqhD5d9jvnoMyhmpnSB3m+g4qpRR7T1n911gnGX8+0Eu
 W6gFIu1QAPdk6tiVfKJAZyoYQhN2Wuek3AZ1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127762; x=1704732562;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bkHamMqbKCKlXBM+tsdsGplB9QUc6KD1Igglus6LJrA=;
 b=YIktEu/1BUABdvITWRoWEf1KG/c4IV5g8i5mj23p241D80fkb4zDJRLz2MEqqvNkVj
 +g35Ngk8ggdo/DAfh2LoTnqNy/fHdyvUx8QrvsEi6vjCR3t4STUOkgh64YD7om8exYNT
 Oc8mPSX3ck4BzvjWqjohn5vIbX7bS24a3fU8YWnqUSC0WDRAbWxDrGh2/dmfbaoAfCfS
 cdEJmd+xtPcLsCQvDJA8F0JgdyZKuBsWeSb9WolUX8v7V25ATOWqWxdyHBb+bGy6nJPd
 PF3Q0r3rSZFkvLiKr/+OaZgIza7moE31c44BBnP2i6Npz8B3pa9TC0dA1VO2H0aCjG7w
 L2WA==
X-Gm-Message-State: AOJu0YxgQiDOfAV8TUDGy0Yu16RW+V2JmlZCfaJnz4cJRL0M5nLHoL5C
 5C0E/hGlpEcMMmlXdasCj7GDTNR+ZQoX17+5sx3s/o128+tTfCRUhpKjNzIGUA==
X-Google-Smtp-Source: AGHT+IFt+FPKWr9Bq4sJ0Nek/9mV84V2xLYr3npX2rGygPM/TCDXZn3zI31cR0gerw05LhoL7a+NK+cwMa/D+l8XGL4=
X-Received: by 2002:a05:6214:2027:b0:67f:3135:a179 with SMTP id
 7-20020a056214202700b0067f3135a179mr29832918qvf.35.1704127761984; Mon, 01 Jan
 2024 08:49:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:21 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-8-sjg@chromium.org>
References: <20231217163627.2339802-8-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:21 -0500
X-Google-Sender-Auth: 1USMaL02V3Cyh_4H1bQaHPzL5mM
Message-ID: <CAFLszThYC+=LK5NSZRYrg8TNBUBPeWM+GPi=dW19JHw+soZ=eg@mail.gmail.com>
Subject: Re: [PATCH 07/10] fdtgrep: Move property checking into a function
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The h_include() function includes a piece which checks if a node
contains a property being searched for. Move this into its own
function to reduce the size of the h_include() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

Applied to u-boot-dm/next, thanks!
