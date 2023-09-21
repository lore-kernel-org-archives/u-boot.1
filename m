Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C4CCD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F26386D07;
	Thu, 21 Sep 2023 03:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KX4h3DLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F386086CAB; Thu, 21 Sep 2023 03:04:32 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B081686D0D
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59c2ca01f27so5230767b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258269; x=1695863069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ze3UMTV2/EaYh4aYaNymrSTsmCwk+3CzhhKlMmTVr/Y=;
 b=KX4h3DLgTjlNQiWJofnNJIiDvLCiumxH/LDCWBo/ShFfDW1BSENOtvVk+g56TjEYac
 V3ybb3DPAJrRibuxISxv0SUUsM+PaG2saNfzxX/pw236AeTeJiUPKSvHJuy34x2TH29k
 2HSSQbRxkIzeNGEtGc4f5Oi1ER9aVWnnNfse4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258269; x=1695863069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ze3UMTV2/EaYh4aYaNymrSTsmCwk+3CzhhKlMmTVr/Y=;
 b=FjdAENoEsbl49zwUGzuLl5XkJuXX4Q1+meaigQXbFeiKoSUBC13nms+LSDEO8iMxQi
 lMhhHVTsf9VaLsToVAYDIsiKn+PvxmDJmSNGWPzojL+6UW3cTn87TdWybJGGPn4MMXs0
 pT/Vn+J+NZpldMMg2fgSaR1HrZjTtBcJ37JO8+zTJq3Gp7NbJuB09q8RQNAGE6yqt+ZG
 hnZd09q/YDCECix8og5VmOb4nDnkCXhKlKQ8W25aPpTMgRDuG0jSnTrLAGkTh8sY55Rj
 NeSTmJzyYPvSBe0IObXPteK/l8HV6gm8FOYkv6D9apo2UsMMKiWBFby1+r38qfsGARhT
 Mk2Q==
X-Gm-Message-State: AOJu0Yx4vukJaXFUoXwvDXj9sxMrVa5Y5+wy8BUphgIDKxpCCac60LU1
 PNgWLIi3Ved0ZUCR37VDLBTXKW1cSgjpgKG0ABQO9A==
X-Google-Smtp-Source: AGHT+IEwkqQbQ1iapSMdTl9Vue2KRQ8DTQIn8++5x/whN7DwmZK578VZnYj3URv01xUvbFNFixlNZIVbcgKoZMeGPgY=
X-Received: by 2002:a0d:f905:0:b0:595:320d:c9e2 with SMTP id
 j5-20020a0df905000000b00595320dc9e2mr3973213ywf.24.1695258269234; Wed, 20 Sep
 2023 18:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:02 -0600
Message-ID: <CAPnjgZ0=zPdtFk7H39_JHWixkBUgibzE4z+A8woyFS5pUNwiaQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] binman: update documentation for fit,align property
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

On Tue, 19 Sept 2023 at 05:37, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Eliminate the repetition "what alignment to use ... and provides the
> alignment to use", and indicate that fit,align can both be used by
> itself and together with fit,external-offset.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  tools/binman/entries.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
