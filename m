Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A7E7C4E9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A5288764E;
	Wed,  4 Oct 2023 19:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oUr+mU/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A508B87633; Wed,  4 Oct 2023 19:58:48 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14B187631
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b9ad5760b9so18072766b.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442326; x=1697047126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PuS8ryqEyqS2/nbhJ6nMSq72oxkND4JGwAtHc5VzvB0=;
 b=oUr+mU/5WO1XIHtP6FuOk4PaZZHZ8c73yztlrSdWru894V+1MGhzpDZkqrYPSairdN
 N10AJSSF6vldHmePcDxND9l4yZk9AzOxJoNDPKmhBhkgSOmv1fIVn2/Pjdm2JwP6pt5o
 pe9CgA7ObzvO5FA2TqzQgRKQBibuCgUlbUXUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442326; x=1697047126;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuS8ryqEyqS2/nbhJ6nMSq72oxkND4JGwAtHc5VzvB0=;
 b=XvHbMaBmE086kntgnpNr2kbe9LyiHCo9aFOFqgD8VdnlGjmi/uhmu8hprno30p+BII
 UebhaRkWBqhn6lsd4Ws1Yrj/ilJJ9b0sFRUfp5Kmf3mAeujwB+LKymGJ7i5jh3LlIjka
 PfPUAko/jGqB8GXIDM08Nv6OOuZSnyqTpLzuuRfOHJraHpz+YVMOdp5D0aeXRwLELMx0
 WV7mG/E0pO3AAWwdRN8kwJzKPPpUd9kYcnrjLKU7ocOfvwvaegy46rI03oRdxHKZsQR0
 H5bOvlU3Odr62cMSPxrIGnPGDP4dnxKuI//aYhISla0ngs92JXKkBmFxvGV413Ak/Wr6
 2deg==
X-Gm-Message-State: AOJu0Yz2SDA0MdEElvdl/jo8Kj/h9c+mm4nD2YgOTu+pzbC4gTu/F1sk
 iJzS4gvoRmRIGd/JoR00vdyfT0eY4GQQWl5BCkOk0A==
X-Google-Smtp-Source: AGHT+IGW+WNLcXCdm/byiQJbiUnz9QiufEenn/8++RvnLuCoVSG9OAyNbOTJMm4pm4dbhQIceReVjZqkKwLUVF9zN+o=
X-Received: by 2002:a17:906:5352:b0:99b:4ed4:5527 with SMTP id
 j18-20020a170906535200b0099b4ed45527mr2529688ejo.25.1696442325680; Wed, 04
 Oct 2023 10:58:45 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-6-sjg@chromium.org>
References: <20230923194424.1739224-6-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:44 -0700
X-Google-Sender-Auth: CeR4gr1Da45l2A0CSWU8VJx0pgc
Message-ID: <CAPnjgZ0P5w=eVus+i-HCtcrhbMMDULcKwnXSdsetRFq5SCeEgg@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] moveconfig: Drop CONFIG-moving code
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

As a step towards cleaning out old code, drop most of the code that moves
CONFIG options to Kconfig. This includes parse_one_config().

Drop the ACTION_... values as well, since they are no-longer used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 163 ++++++--------------------------------------
 1 file changed, 19 insertions(+), 144 deletions(-)

Applied to u-boot-dm, thanks!
