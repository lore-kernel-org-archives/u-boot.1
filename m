Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF5C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FBF87937;
	Wed, 13 Dec 2023 21:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FmMz6iBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867818790A; Wed, 13 Dec 2023 21:39:46 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE9187922
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a1ef2f5ed01so924861266b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499983; x=1703104783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBn5YXzPrUssb6JtKZg+60VJX1QndFI3o1wkd9j/15Y=;
 b=FmMz6iByL86YCcrrVXuo+T4YO4AcBt0R6S17Z6K7HcaqRVqRmCirHSkX3bnVzjXR4P
 Oaz9qcoxVaCK3d0kutHgwLsPiksknKonsDjdNtfOcQp8Pm361Dz0En8NHMvRTzh1cNRT
 w9CS7Sb2ke9Ennxylv0FzvqbffPOwqOpRYqEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499983; x=1703104783;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBn5YXzPrUssb6JtKZg+60VJX1QndFI3o1wkd9j/15Y=;
 b=t0RczZ1jJ4ItjSaBtpIsEOVT04IlGCDYNx2imoHyYD/BF73AIlzL6Mzn6oPZtBm7Hz
 o33yU22shfqqFDiJyHh92eBuWLGwdMY+X5ISATXK0VHcf8akrO2KgfIO0Hhb7ibfyYhP
 xWdxExxzuhQCPhvHW80Q3HfSvmT8PSxpLC137O6kKs+gjIl8NR2ZZ5iAp0h3jobS+vxu
 1PeM35ySP1qN459M68a8KzxyN3/YUnsDDsHKH+G6EfknP5i/Y6R77RDrUBd9nsqy6pZ2
 JfGqf/PTQCuw0AqqTPfbkE0hXjKp81YqmHO4/1sDY7Sr+TJ0nqXiBQf9pK/J+dIeGz+P
 ukIA==
X-Gm-Message-State: AOJu0YwLMORjFjBrXdpZfiQt070SVgzULm0w/PL+amYk3XDr2LTa3Kzi
 woF1tK30MlNAbInTjbfBpp7EdgloRriMff+ytuQhRA==
X-Google-Smtp-Source: AGHT+IGOuB7b6WIIXAZ5qfhVNABcPt8KbwJC7H6AwMpPTVjeiNbKUjZZrvV024xNsF6tf5lMqS+oILSFOJiLYvX72ks=
X-Received: by 2002:a17:906:c112:b0:a1b:7622:db60 with SMTP id
 do18-20020a170906c11200b00a1b7622db60mr2655027ejc.1.1702499983287; Wed, 13
 Dec 2023 12:39:43 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:42 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-3-sjg@chromium.org>
References: <20231002011553.463514-3-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:42 -0800
X-Google-Sender-Auth: XNGvbWKHzDvz-VO9yJNm39VbluE
Message-ID: <CAPnjgZ2Bs-yfYj7=9h4Pyha2vT=WW-6ta3QYK-3+a6dGLdPXbg@mail.gmail.com>
Subject: Re: [PATCH 02/34] test: Add a new suite for commands
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
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

Add a new suite for 'cmd' tests, used for testing commands. These are
kept in the test/cmd directory.

For now it is empty, but it will be used for coreboot-command tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/cmd.h    | 15 +++++++++++++++
 include/test/suites.h |  1 +
 test/cmd/Makefile     |  2 ++
 test/cmd/cmd_ut_cmd.c | 21 +++++++++++++++++++++
 test/cmd_ut.c         |  6 ++++++
 5 files changed, 45 insertions(+)
 create mode 100644 include/test/cmd.h
 create mode 100644 test/cmd/cmd_ut_cmd.c

Applied to u-boot-dm/next, thanks!
