Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A9AE7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37018762A;
	Wed,  4 Oct 2023 19:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mcyqYcnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0D6875FB; Wed,  4 Oct 2023 19:58:37 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154B387605
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so23161866b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442313; x=1697047113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XG3XJPMlJYg548HjULVTfOnLssKC6dk2WQrMjb1Is94=;
 b=mcyqYcnJMIKTBYsfCifTJ1M/0h562CLP3clv/KvoBTN/1FrDj82T3Wkj7Y70LMH+6p
 czleKAY5/mYcW4YSjCYs0Sjrv0T7OK8y2cOBMTSw/jHEU28N3Gz4nQs57yfYi1QMgifS
 TYEoRJWIK4E+VfBjf++vCEa9yliSiHUm42450=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442313; x=1697047113;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XG3XJPMlJYg548HjULVTfOnLssKC6dk2WQrMjb1Is94=;
 b=Jcxcx62CyRjwLIZuj3mMFgPAw8YTO9Tvnp7UWkQbdtaJqC/qApBaFGNMOcPTUUjFZf
 lPuQkhSFdWlGeern4saU2Chy84uytMJdlBwLIEuOSFUdB5vf7ZIK+wnCydHSj8ja0VTD
 /zRuX1BEORgZFbDWr2ePLuWB9iSY5V7Ig7MjKxYTj9EpSMdnsdJF9evwARRz6siXAao4
 Q0+Rptylze3Acqf9rSZCjRiqLzjZ07hDYM/ugmwC8dgJrXLdN8Sq4JdsIqAZymUpj61b
 GEG0FH7u6o2LPmEl9VEJJLWovNjKl54WCI/KtExp8ih49A8h9glbf0ecY+HfWJKrtJIO
 bi8A==
X-Gm-Message-State: AOJu0YyRbwK59H0rTST86TpG+PxpvvrnQC0BMY84s5o54lXMAOuRCMWE
 Dc5p86UbmQI7dyfZUPGtvWU5jOVet7KzPnmLNGj3lA==
X-Google-Smtp-Source: AGHT+IFRdarbN25QMm14VVZhrG7IE2TkYwfTRAsZYILC1TBQfp9QWx0w51EFM2mivfVZ/3apSKDpWXFaGic+Pt5jqhI=
X-Received: by 2002:a17:906:1d5:b0:9a1:bb8f:17de with SMTP id
 21-20020a17090601d500b009a1bb8f17demr2463614ejj.35.1696442313493; Wed, 04 Oct
 2023 10:58:33 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:32 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-17-sjg@chromium.org>
References: <20230923194424.1739224-17-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:32 -0700
X-Google-Sender-Auth: 9eZUjXKaTfrBPmql8EUlmNbyf7Q
Message-ID: <CAPnjgZ36npA2hkKFHDcmHgcdszX5Cn-cAJznZ-VdbAt1bkoA1A@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] moveconfig: Fix misc pylint warnings
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

Fix various remaining pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
