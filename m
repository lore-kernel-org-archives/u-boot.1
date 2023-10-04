Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B1E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12A4875CC;
	Wed,  4 Oct 2023 19:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IxyCaJ5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F09D875E8; Wed,  4 Oct 2023 19:58:28 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2415D875D2
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso22248166b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442304; x=1697047104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qLy1ND8tvJm52ZLJPhWTaVsOSMwXevRqa3hC1uFdLgA=;
 b=IxyCaJ5ARQX2M4/j6ROeRZDX5ssOIGLtXispAgOgi4XmuLf+N5FsuWt/5TmJ9WwhmC
 F2uO2+vI1W77OhBpaYjacrM0uBr3V0hBSMob0hwKyvE1BXw3GWqOMmsq3NbZ+I+Agy1j
 JN5Mw1/c6umtUs/Yl9ZNccJdf95Ig9aZsBkAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442304; x=1697047104;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLy1ND8tvJm52ZLJPhWTaVsOSMwXevRqa3hC1uFdLgA=;
 b=eiNxEb0/6gOSso7L7rFaDh93OFvhTbtgnQpNOYqNrH1tG+Lr7BwNhmt5U+SXkq0Nfo
 c4muhwlejiNCPGyRTAKZ+uwaZBbQJ+qMOwABy4tGC9EdQJVxteTiEz4l3tt7w4YT6f95
 6U8LIrzXgJfWcaVooVboWKWK7vSEnaq9l/DE1nubbEFe74cJs6n1r2XavKWSmbjfB3UK
 97h0AaXCl9tv4J6IjXDpueUndUmcOFDwYO+B2GjeySmoed7C+17KW85C/skJg65eRt8j
 sUm7Ru72OueBwumBuJUygrjY8hFj0wiQji0Jbfv1y7qa5YnX5N1Wdytm0ubNx0/+x/TA
 EtBw==
X-Gm-Message-State: AOJu0Ywj9rZ6UzbSvbVbxGkHoIPDegzv03RPPJ7uoJ4m76ubGnyvgkm+
 k+pE1WF6Y8bJD4wUp3bRtPrFrfydWh/joJyBNBUwWg==
X-Google-Smtp-Source: AGHT+IG8Y8Umj3GY0qHxKb95UkR0ErdhyfTbJs74fSNGQIxDpshX1E+U9WdxayRhHgBdjcRyIr0lAoRpLJ4gBg5wdGI=
X-Received: by 2002:a17:907:7783:b0:9ae:5aa5:ee6c with SMTP id
 ky3-20020a170907778300b009ae5aa5ee6cmr2617381ejc.12.1696442304473; Wed, 04
 Oct 2023 10:58:24 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:19 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-25-sjg@chromium.org>
References: <20230923194424.1739224-25-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:19 -0700
X-Google-Sender-Auth: 4whPLcrEPG2cOPd7sUIenuDVrtI
Message-ID: <CAPnjgZ2QqvJrJgHp1nPKCpsh36UPmmbHhrBrMcmXP_F-UEXiFA@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] moveconfig: Move summaries to the end
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

Write the summary for -s and -b at the end, using a unified format.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

Applied to u-boot-dm, thanks!
