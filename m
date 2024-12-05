Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D43BE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCAD895B7;
	Thu,  5 Dec 2024 20:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K8YYTSxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB22895B7; Thu,  5 Dec 2024 20:56:16 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770FF895A4
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa545dc7105so230903266b.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428574; x=1734033374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FfwcOrGv05upYwthJ/DTisZ2sdz3y8RXMeoxzJnh4D0=;
 b=K8YYTSxQivtDIB7gqQWSNMWL8EmM37gc/NhseYIv3s1hsRue3/vEVY0stxubFH4vAu
 V9xQnpPAI4BQSKLtcxZbskG0gZCTjTAovufd+nWzPIZm2+u8QA6S8Hlstg2XNyKillPI
 GEwkkepivhvhpst8J5XIKqPee0R9192znVQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428574; x=1734033374;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FfwcOrGv05upYwthJ/DTisZ2sdz3y8RXMeoxzJnh4D0=;
 b=qt/dLGE7pdeMoai6hgPAnWA7XDVtOTKuZdSG1b5tjf9N2Mr6pfzthzJPSj7izxPINV
 vNW7GHWJukBo40iBHjSXAORdT4OWwwmvaH986pikttulqI3lWVUu7x10keo1OAQnAdEU
 e1MlJOhpslAV3pTl/jPadDdg3aeqTzVqXUstogvOOKKP2fJh6II6B4aaBxG+0U/bd3Cz
 WoJgVu43Io4Hh6NoRhfXoza5siEKR2jQg7rVnNryK8d07ImvUGTxJ0LO7pobhO/4Ovpo
 YOJtKf8Dva6HiUJL83bGGizwhGMCmCMgSlWW1kuFJ4bt5gdo3XEIsgRYY8TuMcgjfmR/
 F1rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2cUVsfMtw1O50+UjX9wKgBetkaAzuzAyJwQNzQnuffpMbQhLkK2+bUcHsNFsx6C5BNyVnKus=@lists.denx.de
X-Gm-Message-State: AOJu0YyIWBZ++rmQV8EgQmpJGfq/1mCEkTAlsdOsh/rxhJJZ7ZCsS6wN
 NIGKtpJpUgdh6AnR2sbNj57kq0wsLfGSZeikS2olwGyWxeWcAD0CP+P8Y/1xK/m61GCPeGOcmlt
 pD9jpzeEsgmreq0Joeopv50GutLtpcOGOyR7T
X-Gm-Gg: ASbGncvRBVjwmixJoMnjrHAzihyhvIgnGfOYJ6eWVujo3GrlW6oxHwPrAzBz6HuyWLI
 nm2RScZBixOLrR0hQL13p1cnS+Jxvwodr
X-Google-Smtp-Source: AGHT+IEKWg1U0NV6JqxkJyUWrpbgM7i3SA5DliDv6dTzIbK/MhgxdUSO9ldCpJIDgbV1u/iGGmp8y3TaX3d1MYLL6lI=
X-Received: by 2002:a17:907:1dcf:b0:aa5:2706:c3f with SMTP id
 a640c23a62f3a-aa63a21b6d4mr13379366b.47.1733428573989; Thu, 05 Dec 2024
 11:56:13 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:56:10 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-3-sjg@chromium.org>
References: <20241115231926.211999-3-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 11:56:10 -0800
X-Google-Sender-Auth: 6VEpYwAfM7Mx3cOsFJuiHVIWUUQ
Message-ID: <CAFLszThf4fZTX8TDHQs=7PMyam4dg8NEr08Tbfy1cPR_5e+NCg@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] bootstd: Move bootflow-clearing to bootstd
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
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

This relates to more than just the bootdev, since there is a global list
of bootflows. Move the function to the bootstd file and rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 boot/bootdev-uclass.c | 19 +++++--------------
 boot/bootstd-uclass.c | 15 +++++++++++++++
 cmd/bootflow.c        |  2 +-
 include/bootdev.h     | 10 ----------
 include/bootstd.h     | 10 ++++++++++
 5 files changed, 31 insertions(+), 25 deletions(-)

Applied to ci/master, thanks!
