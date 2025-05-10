Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89202C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A4C82A46;
	Sat, 10 May 2025 13:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X+pZZi60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E746982ACF; Sat, 10 May 2025 13:25:52 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E2682952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5faaddb09feso5577494a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876350; x=1747481150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jCISCpSnuzZ8kYXPg0YCNQz1TsanOdvTZmHkYBdYiiU=;
 b=X+pZZi60ZJSal30rU8cQhQKUGv7Xnx4ZnaTzhtf9XEAYvsmZh4EYavJmZ+el36mHFK
 ziLzFKtk1UuCMmAHd5EU0fRxAvIj2/Hc727hrOEt4AogvLL8uA26408WTbgo04oIHbgE
 r/zLt3jnRuub2O0H8uZRWcGHpmvgcmMakywgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876350; x=1747481150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jCISCpSnuzZ8kYXPg0YCNQz1TsanOdvTZmHkYBdYiiU=;
 b=j7SrvJGe3xlQGS/wpm0L3sargTUq04r83BsTV88ctBZpDOQh7GNXuYw2ZnFMlnu3pB
 U4Btg5KjEGFjk9+VcrglFQhoBxAEwoSKbsyImBtoPKwApuIU30sp8o6KHtCyDG63VCS9
 CrinDrEYC41jkoZrgWMM7+exQ1dhiDfQg4RJ5ZpnwgZxECoNpBqhctpp/k3q6T/6j6Ha
 1UNHeIF7hJWT/Vfoi1Mw26TEEUEj+zInDjqZS/oS66XzrD+jHAzG7jAguMOXCJGhBend
 0nwluuC6d2VOi5qDZ3oBB+Ot5DJvNC1ecm5LwR2OKH4qPqOUVDHRz7dtX2a/+yrhiVFm
 o3sw==
X-Gm-Message-State: AOJu0Ywx8b295SS3K4N5hZ1jMXcwPsC1gi6buCe1ZVLY8D6W2ABbSrN7
 iOA2D+230ipBqO4iv3BlzbbOMqLhV+DLpCOcjdvzGlSzZ9mila1nGs11dyYTja37Hv9jHg3Navg
 8WFFaxNOscZF6d/nNjV/rhbmrhvTdiqwjQaNLkbx/h/tvp4HS0eMG+Z8LXw==
X-Gm-Gg: ASbGncsmuO6Loetovo/cVwm3mNf+6VOuepECDB+hh4wqR4xCPslaO0VHqGFV63IoU5y
 I/3IW33Rqt04yuBOGjRZlALrhUMv1x1qpapU00fcvhhu5a4JbnNoFoWWxgl6dKBKXOXdYUqRfsz
 MMqulQKd3QKLKpd4oGbegbUZB+OoNsTUP5HQ==
X-Google-Smtp-Source: AGHT+IGfbx8Dzsvoe2wi5ssTVPevlf1HnBa1+dDQ4fQ8/L1zdHoq8z2kcOHoCBsqvmml9Lho2RZFTmCtqq/uyrtkMyo=
X-Received: by 2002:a05:6402:2355:b0:5fa:964f:b8b3 with SMTP id
 4fb4d7f45d1cf-5fca07ed5f4mr5804633a12.25.1746876350298; Sat, 10 May 2025
 04:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250507221112.518041-1-trini@konsulko.com>
 <20250507232500.527782-1-trini@konsulko.com>
 <20250507232500.527782-2-trini@konsulko.com>
In-Reply-To: <20250507232500.527782-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:32 +0200
X-Gm-Features: AX0GCFtnpAUDSny9qinekTTTAKaiOYwdtLrRyy-C41vzrWpXnNmm_qW-VjfXXRE
Message-ID: <CAFLszTiy1P=1AJm=jXua_EcYXqpM-pGt5Jb1QNwRwwAyrDj6Nw@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: pytest: Document the test_net test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 01:25, Tom Rini <trini@konsulko.com> wrote:
>
> Add this test to the documentation. While the diff appears large at
> first, the only changes within the test are to move the imports to
> follow the pydoc comment and then to code-block and indent the example
> configuration.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst    |   1 +
>  doc/develop/pytest/test_net.rst |   8 ++
>  test/py/tests/test_net.py       | 152 ++++++++++++++++----------------
>  3 files changed, 86 insertions(+), 75 deletions(-)
>  create mode 100644 doc/develop/pytest/test_net.rst

Reviewed-by: Simon Glass <sjg@chromium.org>
