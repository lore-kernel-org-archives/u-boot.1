Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CA0E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7400C8764B;
	Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BKGjLDds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9031187614; Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC108761C
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b2cee40de8so30497866b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442318; x=1697047118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ij2ldEYOftKKwuzubu7wvuj64AF8IU51dliXmjwE0ac=;
 b=BKGjLDdsFlLIWvUuiOUmRo3PZDn3UAu+MTVGQ3OmzI9J7bGbwQrpRbPeyLumjHitWF
 n3p+zm5qLiHylWFj1VxIp+drXSQ8WfYy++wTfxEYDHATS88chph/TKNoxp1pyBHWi5KU
 OS8J3qI5s9cOjaf4eobfqM44kLX/nkwqKWICs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442318; x=1697047118;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ij2ldEYOftKKwuzubu7wvuj64AF8IU51dliXmjwE0ac=;
 b=exgVYGQOeCY0aOC8JEX0koCWXXbF7vFGijIfk88xOOZdxozhz7d4MyX7IeFG48tBhR
 GvdTp+YBaSlquoSEFXs0fnmki1bsr1pp8EhnvmglAlZKMg4K5eWduz9X1kniLZgaT5Xv
 +xVhOFKE9kLQfEjR331NnCKgH3wPFYsREFA/z6WRfyadsYCJrhQADnuxwYrpDVMOEiBW
 PfLfy/5EEiolryY4h0yI+w/Sz/OQ+veOc23vJko4s1/YPDkAOMDJPAoAagj6u8flJXD1
 rrpaFLYtOnWe9IPXchJd2H4ECfR+52/P/2siyn3/+SfTrLiITgyiUdV9fxr7OoxVP1ce
 2R2A==
X-Gm-Message-State: AOJu0YxI0iQ5L0czYeeSR/zECb38zZDkWsodEkFSD0iUstKlhJ8znsd8
 SXrB5zl48DrwnVlkqd9h5b4HWdHts5iiLflhwnS7rA==
X-Google-Smtp-Source: AGHT+IG+A8J5bQN3vO8LdQkB2GDDWmEnWTIhwpccGQcRsLdq8NA9GcTo1tn2Jp7uL7QRv/SP6goLZqHYRpXpii3n/WM=
X-Received: by 2002:a17:906:e218:b0:9b2:be5e:3674 with SMTP id
 gf24-20020a170906e21800b009b2be5e3674mr285267ejb.36.1696442318105; Wed, 04
 Oct 2023 10:58:38 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:37 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-13-sjg@chromium.org>
References: <20230923194424.1739224-13-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:37 -0700
X-Google-Sender-Auth: zR0f91MHvsNj5MHG0e04yGGY8X8
Message-ID: <CAPnjgZ3oE_iFqrsenJ-q4Ha0N0Q1CicCc8WN7RYzLZhYZ-cSmQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/27] moveconfig: Correct non-snake variables names
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Correct some variable names that do not conform to snake case, with the
three-character minimum.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

Applied to u-boot-dm, thanks!
