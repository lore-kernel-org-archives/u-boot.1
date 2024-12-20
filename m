Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4664CE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0298180378;
	Fri, 20 Dec 2024 05:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DpNUxIsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF148021D; Fri, 20 Dec 2024 05:05:00 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE14880362
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aabbb507998so283420066b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667498; x=1735272298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4VAfJHY7sdFdzrU9gIkC3JZoPIOC0C3tlS6M5SXFBdA=;
 b=DpNUxIsmn5CnyfsE4GTqFdoulDM3pAKpmpceo/P3WF8z3izuzPvhcu6QCqEg9ttqk1
 htJjUTSt45fRwP1lqODc7veEZaBvbhb37GGhsvCj1Q+oG4pB0cr5OrTeWdhb4LvxWoJr
 +Kb9BX+xL6kqlV0/lwkEG0UAisluA9OjoUshQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667498; x=1735272298;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VAfJHY7sdFdzrU9gIkC3JZoPIOC0C3tlS6M5SXFBdA=;
 b=M5dJSy9KKyNemaaIFVSCTTMi2yzAxLz4WV5CONf3OHDcS8rekepRj1uIoShEqBrTp9
 scEPXkIfqaprW6aDnO4rypNY/V54230E2IcNmpTIZtkHD3lXebdAuquxAVlYeZ/rfqwP
 3F0afHtDDHR/G6f82BVPbo5/+joMx4b+sYhrzC7CChePpykWu8Px+p6bm1EoLvb0bYL9
 RbXLwv+leQtcE5l3FSVCES9G2e7Kz/UP0x8yiyBDG3dxvKtxNGoPNEYddJy8UAccXcPq
 blmqqaXr5Jt8ybChLGhZRruC/18zALzVQAYbvhA/2+i2CGE5Gk2lE+CywOK+pEAo2Kha
 lLbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdhkoe4+Cn0jJ5r5txPFyYlss3YnnpI7IV988IrxIz5AxxN7r0VvH1wU4TMpObxJNlKbd1BmM=@lists.denx.de
X-Gm-Message-State: AOJu0YwukjJJN0R7SdOxLSLRPszXZlgSqRAykQotZrCgOQbnEKBLw9mo
 o3fMf2rJcnMB65Zfp6Q0myLT9iAn4Zocn4voAUWj9O6aDXlEh+8dXWrTKTThk6Bv2cxPAOjoZcL
 FcVZjY2VEfnkw4pYyiDv94g9Sadizzl2nYAHp
X-Gm-Gg: ASbGncsm5ciKhNKdxAh1ClYz1Lh3lWmTHLLsNmE7hGkWYPWEVnpZ5ZOqgZRBLjNwliq
 Q5UaxLsedjd2Ry0gipW8o3/T1Kps3V/6F6+pJTtc=
X-Google-Smtp-Source: AGHT+IGlapZaKtNZsPf/et8ksecuDy8YDbtspEU24WZj1cSfneS3cttwFJ26m+cNDrKePocuaXRaztinHghPNOO9IrM=
X-Received: by 2002:a17:907:703:b0:aa6:7d82:5413 with SMTP id
 a640c23a62f3a-aac2d46b032mr89470766b.34.1734667498153; Thu, 19 Dec 2024
 20:04:58 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:04:57 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-45-sjg@chromium.org>
References: <20241206023626.2456858-45-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:04:57 -0800
X-Google-Sender-Auth: Jk_-JDVGV77nNLusCdoLphOZ500
Message-ID: <CAFLszTh7Gh77tEVaqMkq=sydrbo1Qwm5fB_+=HD-vcyokfysYg@mail.gmail.com>
Subject: Re: [PATCH v3 44/46] boot: Detect booti format properly in pxe_utils
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

Rather than assuming that a file can be booted with bootm, check that
the format is correct first. Do the same for booti.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to detect booti format properly in pxe_utils

 boot/pxe_utils.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
