Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA05C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFE48791F;
	Wed, 13 Dec 2023 21:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bO+GNHF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF4C87911; Wed, 13 Dec 2023 21:39:44 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6D5878E2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a22f59c6aeaso174871566b.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499981; x=1703104781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2sbGe/BSacdu/qslfYKlTUpV+9tfCyI0tBUGXAvv79A=;
 b=bO+GNHF3ukFcNYByrH8x4ffWYyRpaBDUO/jpsRlTgah4Vt4WxboSyDFQaZku7zH84T
 e70G0rnZvroiR42kGNpOkX+mtug3Dk22dYDdVaPA+VETCAWOTyqUmz8GeGZhecErMk1A
 6WnTYIqRhi3bKjsG6aDxPManJez8vrFWvgyzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499981; x=1703104781;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sbGe/BSacdu/qslfYKlTUpV+9tfCyI0tBUGXAvv79A=;
 b=MvWMjqg8kMTkgw4NtL+z37UabPrpNFeU2tTvhj6KwCIbwdrnqevlY6qQtW8jJzrffC
 7smPHr0Mpz+iihoptKOQSwHTnGDGN6oHKX+LID4dV3QVNeLGg89luvQl//X+QOmmu0HV
 sNxbuajc5wF59gXsmOSTjFgwDRMr+f6sK+U4e5swmwZeBz8l21DfvP/X3dWm65lZ0ip8
 iU7XcYSSMG71hwZYOCAt/gwU6eJDzNktZc05jeFEVEheyXXTGbL76HnC9wZDWaoxozQz
 RiaFPT24GBAyjU8IbvH6s9wfvQZSLH6Zub2yvg4Rco6QlOaE6TePwkwY4l+A8h5bx0cD
 2dAQ==
X-Gm-Message-State: AOJu0YzBnvjVP4R8dHgPsk7BZlmZ4yABWIU1j+6eYSLnynudYLtR2ob5
 kW9rvAhWkKCFIGkurbH7KY9BQFKkdJaIr96tZ4l+UA==
X-Google-Smtp-Source: AGHT+IHGLJMR7AutPdY9dFmrtFEKG7zj/noBymRWfX1PHiEJWJW2Slsjndddx2sgcDfk7DkPT0WO9DkwgYK3GCfenSY=
X-Received: by 2002:a17:907:503:b0:a19:a19b:55f5 with SMTP id
 wj3-20020a170907050300b00a19a19b55f5mr3489537ejb.133.1702499981051; Wed, 13
 Dec 2023 12:39:41 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:39 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-6-sjg@chromium.org>
References: <20231002011553.463514-6-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:39 -0800
X-Google-Sender-Auth: BW7y6JUQg-X8OGDF-nTFR1TA6Bs
Message-ID: <CAPnjgZ3_YjrVteUFWaWz_evad7-T83PBTtGCoz137nr9FaJTsw@mail.gmail.com>
Subject: Re: [PATCH 05/34] test: Run bootstd tests only on sandbox
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, Brandon Maier <brandon.maier@collins.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

These make use of disk images which are not available on reak boards.
Add a new Kconfig to ensure these tests only run where they are valid.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Kconfig  | 5 +++++
 test/Makefile | 2 +-
 test/cmd_ut.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!
