Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D721C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3A38841E;
	Fri, 26 Jul 2024 01:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TAj8L7r4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A70788717; Fri, 26 Jul 2024 01:33:12 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8986C88701
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-44fe106616eso400131cf.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950388; x=1722555188; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iRwFnTZtZj0vh/nojDc4b+0/OkSnfEcV6LohrdIR/Vo=;
 b=TAj8L7r4z5nnvpajqUz/4O/pxmXZy+aOrT98mg8rnE/mKrcBIGqD9bUmW9y1evFwyw
 N1RcH23QdbXyAW9JTiPbi5FQnt62Hs4LaRIgiJcGwtpoiSjcPQSty47nXTBmDwg3V8rm
 JIuhXo9T76x5dcXjeQPNso/mS3q9q5vjSxpzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950388; x=1722555188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRwFnTZtZj0vh/nojDc4b+0/OkSnfEcV6LohrdIR/Vo=;
 b=S4jlLVNndMTforPsp6CMfDkENUMxHbUJtlKzStMnygoQgYVDil3SeFiu6IgauJ4J7m
 l3xBHkSECG6OQdil/UhT8z7DiC1GP8KNe9JCYfDOBtGKaDwJSrcbWO/OmBCilLKrnHmw
 lIGnZjteh7tlcxq3ybnnujc1FvNOmt0DNURw3Y+BIC+jpzFpIRB7o/m9IkWqpFUGcRIv
 edhTsiXAjAJ2UlTJ+J2UsV/H2LPj5gkSQvh2fpxodlVpPl9lT/VqX8HROJWA71g7FLBj
 6C3PpYJZSCj5a62OXcoJt3rSApgpBjr64I4hZEAQhJtWRf+n/UovMdrb/uEuy44IcHMO
 TIwg==
X-Gm-Message-State: AOJu0YyTVmDak6nWBXk/v2W8FK+FRHkxCbXq0Vxv8vU0lwg/4sd/Bllf
 r3tMN0OZ8b5X+5qnbOjkgITEPXUa0jm1lRdBfmCztLGubqdBNe/2uO9QAa4yqI8TZzzFcwsc4LN
 GgQGgrKvy8e3T11LYVJ3iGkbglFrGuCMXb/OD
X-Google-Smtp-Source: AGHT+IHUvfVKd5L8Ko3+b31hgMs8KrhO3wzO4S1euYb+lrP9ryGXHekKJXgxA2XE7DDtZ3dZQseg9hrU1i8CHper/2g=
X-Received: by 2002:a05:6214:412:b0:6b5:6138:1a54 with SMTP id
 6a1803df08f44-6bb3cb22ee4mr52317326d6.56.1721950388479; Thu, 25 Jul 2024
 16:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-40-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-40-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:58 -0600
Message-ID: <CAFLszTha9DKWFkEO7=yp-cMa1R4vXfEjSSHntb3UA3CMdb9wWQ@mail.gmail.com>
Subject: Re: [PATCH 39/40] sandbox: adjust load address of couple of tests
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:06, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The TCG event log has now been moved to the start of the memory, and
> occupies 8KB of memory. Make a corresponding change to the load
> address in a couple of tests so that it does not overlap with the TCG
> event log.

That address overlaps with the FDT...so I am hoping you can leave the
low memory free.

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  test/py/tests/test_android/test_abootimg.py | 2 +-
>  test/py/tests/test_vbe.py                   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Regards.

Simon
