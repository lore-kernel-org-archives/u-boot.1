Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C6CEBF8E
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B70890CA;
	Fri, 27 Sep 2024 12:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qz633/Ao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5308890CA; Fri, 27 Sep 2024 12:43:56 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B9188FAF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cb3ba0a9a2so5442816d6.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727433833; x=1728038633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cP4GWr971ur7zG6dY1ZjWZM1a1YlAVeWKtAHobA4FLk=;
 b=Qz633/AoG/XrPXO7ac2hmO7nZBaI9x0XwMr/chHp7jKNCIq02B9dzyZ0yb/hKLE4SX
 ElPevD9+ZGN5pW5nUJgoCRKJ0URRKtKQVPw9Wv0KwQG2w9m8Sr2r/iFqcvvSMu+DoTpM
 H34sHpoE7r7vemVi08lv092zi6mEKD7bMwAY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727433833; x=1728038633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cP4GWr971ur7zG6dY1ZjWZM1a1YlAVeWKtAHobA4FLk=;
 b=c0Nz+6eoFc8Gpyyt3FbKQtz8dy4dcEUHfdKY3zLcmdm9+Ev5e8nxr+d/Yxmk+enRLx
 IGxMjeY7ZILZsHjSPl5mSTzqj3qMseN0nHD9Ksuz2QmmT/TDHUxk3F2Z7S8NaXeY8/lQ
 Gq5vF+Xlq0U3aZ8+XL4d/5qK4bboIA1RbNXUHVsWKiC1siL3p+EEd2lcOpY5eTSdGCwK
 qYb4HKWVODC3SiyUa6Yw9X+XTPUI9Qd+IKjMCOZR5pIUuiozgCGByF3fEZSj7Ch10FMj
 2FKCFwucgeXQ/p6l1QjZsO9s6iHCqKIzHINBH/3pMplJTj50RluffQJpQBN4HMf09iZw
 dPog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCCDALj5GGEob90sMUTyzaJwl07wlv8h2jydVFSFGLGoqCgK/tUddJdJpcRzad/B25eU3tQaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw02uqJIipsuYMREM/1+KQ7/XuypciM3P8IMHjgH0vNBb9FYZ9T
 ktH1HKtB96sKNJtrUbo21LsgU/rVbxFKs2iG+SWMLyoyEqupwe9NqbAm0gzh6B1vS34kZErY+jP
 TXCJs1VEha0GepwOVlP+3o6adq3brWHnxe88TP9o6l9zndkQBOq8Q
X-Google-Smtp-Source: AGHT+IE+eCcPzImfKWIbdT4Z+HcgqL0HwflIluLHZyTRDk3sxQSVYZQoD6ByhyGWZs4Hvudcof6ZHl0kLEseczexehg=
X-Received: by 2002:a05:6214:4497:b0:6cb:2186:275d with SMTP id
 6a1803df08f44-6cb3b5f7ef9mr45253756d6.26.1727433833518; Fri, 27 Sep 2024
 03:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240826191143.426387-16-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
 <CAFLszTg2s_4LKkJP-OAwjdSqpygwhggOmSAkY376UWTk2LGxzQ@mail.gmail.com>
 <25ee832c-5688-4a79-9c34-a2e34ec89a76@denx.de>
In-Reply-To: <25ee832c-5688-4a79-9c34-a2e34ec89a76@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:43:42 -0600
Message-ID: <CAFLszTj5GrW_aX7dzA0WANpk19CES3-QqWpt1nDuCPM8vKMuTw@mail.gmail.com>
Subject: Re: [PATCH 15/15] binman: Make a start on an iMX8 test
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Marek,

On Fri, 27 Sept 2024 at 00:20, Marek Vasut <marex@denx.de> wrote:
>
> On 9/27/24 12:07 AM, Simon Glass wrote:
> > This patch is for Marek, to provide a starting point.
> >
> > To try it, use 'binman test -T' and see the missing coverage.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   tools/binman/etype/nxp_imx8mimage.py |  3 ++-
> >   tools/binman/ftest.py                |  4 ++++
> >   tools/binman/test/339_nxp_imx8.dts   | 17 +++++++++++++++++
> >   3 files changed, 23 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/binman/test/339_nxp_imx8.dts
> >
> > Applied to u-boot-dm/next, thanks!
>
> Is this patch really supposed to be applied as-is ?
> The commit message makes it seem like some RFC/Example code.

Well it is better than what we have, so I applied it. It should give
you something to build on.

Regards,
Simon
