Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4CBE7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB25087670;
	Wed,  4 Oct 2023 19:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SxnMgCrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A368762E; Wed,  4 Oct 2023 19:58:51 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A30587641
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so615405e9.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442329; x=1697047129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kL9zqmPiPxgas5TKvSMgwJyhOMdMvmR1WCvjoUdToFI=;
 b=SxnMgCrU4L0b5brL2gr2pQUOF7cpDJtyD4qpbMqfA/PS9iF0Cl0CAbTyu6fzzE1pVo
 KxyxK0NDtzco4L/RsXT1NbFZ2JFUGKub+uvPcaIe/AoJnMFGq3dUrTfglPr7lJukD1BX
 JX6biP8jS+NILMpb6SptIB0zVGqGW67SCqJ4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442329; x=1697047129;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kL9zqmPiPxgas5TKvSMgwJyhOMdMvmR1WCvjoUdToFI=;
 b=gxjB/o5aNX1F0+y3z8rjmsFlyDW4rzDvvDCl6I1TWAun+Qv0aUpXtfG8vSQpFDYCvv
 NkgU85j6dugMGAgL45LWCpZfdnT0hRhksGJ3qEp45LzxcLwtaRz8oEYt1dkDOxhH/GOL
 f23VZDXn8x1wNR5g+g6zhxC2MDjYkVvNTdRPAwd1UbuFMLy9evTb5TxCOFeHHzZEaw1w
 cXsln0KFT8stPPkdXU36FMeCyBTE6u24UbTAi5IhZIeSPgyBQ956e0XDdRuA7dHy8gKn
 RhgQcCup4V9SM4s3GYWbmJy2tgaoPb9nqjJIwuKLQMdczxUSH9HlWShOoYD1qbBqeun9
 EpvQ==
X-Gm-Message-State: AOJu0YxFdpE+XqulhccxXHJz+akUxGOhtz0GYX04lSXWzU1k/DEzdbxk
 4t2HoNZ7ilnvPtrvnsm4knM3715B5LP41Ap2blIZ7g==
X-Google-Smtp-Source: AGHT+IFP2JcBJ17x3MuuzeO4wWzARFJPZVrBz6wT3v3meZiwtj6D2a7r3dwqC+cZw16UvvjXCO9/B4lYMOSPQx5yUsQ=
X-Received: by 2002:a5d:6989:0:b0:321:f74d:ade6 with SMTP id
 g9-20020a5d6989000000b00321f74dade6mr2659480wru.40.1696442328721; Wed, 04 Oct
 2023 10:58:48 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:48 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-4-sjg@chromium.org>
References: <20230923194424.1739224-4-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:48 -0700
X-Google-Sender-Auth: gCS4lnpWQTxz43zNbCj2jim2Wss
Message-ID: <CAPnjgZ1PDDREkQwDA0p=EwOvH-SCs+Fh0+2WOF9MFXuu-tN3Vg@mail.gmail.com>
Subject: Re: [PATCH v3 03/27] moveconfig: Correct ordering of asteval import
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

This should be after the standard imports. Move it to avoid a lot of
pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
