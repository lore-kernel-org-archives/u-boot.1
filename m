Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAFEC28B28
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 11:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49B080FD8;
	Sun,  9 Mar 2025 12:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UjA7+WJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 698BC80FDE; Sun,  9 Mar 2025 12:01:01 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE60880107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 12:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so2678836276.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741518058; x=1742122858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p+Lq5cfkbOUhIckdKBGv8iUdOa65cmJeu7zEx6eYh40=;
 b=UjA7+WJ/BvhYWf9VV4PPGCv0BowZ7SkBoKS0MB/P9H3itJ/5nqFrtZRSL2wzHThuGj
 7PLO1RYQ+9fa0ARh2nZrthCe1wEnVGIhk9lwBvtSPeRfGtO1yc4i6IltQNWWQ2BHfuJy
 0X/qkXGstwmkleCMSGPQBCgz2hB8XKtxstIqnQO9UH/qLLo9/ZkmA8qw24Ps3sXG/X16
 rB7hVAR08tpRZVYf9CIt5djw6eYYI37DnJ0Ty5uxqh8xBhsU7TGT5SlZ6q+ExffNBi96
 cmip4Jhgh6VLW/QG4smqq1CrS7aKka3OlwmOKqNXsuQZJEaWonYWgBBe+3guWG20V6m7
 2HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741518058; x=1742122858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+Lq5cfkbOUhIckdKBGv8iUdOa65cmJeu7zEx6eYh40=;
 b=QijBGCywflAGL5FdlmvkVVNH8XcMtCRHBKSacOHqLi1IXGHEFWr5XPQUeY1bsI+8XA
 xbkCO9ZWkNNGz7K+A3VReFUPZQAfzo/mqJkRM3o1K9w+BNSETWEjIB+6/2TzzkLed84B
 2F5X2ALRQOwyoaSncWaZ4QtJMSmW7+8ScHb/kg229fYCLx4VKOTv/UlY8Vtcxa6o14BL
 YiKQlgRz220sdt5tOlk4jNfxYJgcBJdL/ZveIe0jbMrbsR7R539C41vigTM6azbT7W0x
 ayorAGColIMxbxOVnVCGk31F/01Az8+0vhDsYel3fh4oBOCQKpTj9FQ7FhT3p7UT9zo7
 +JAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsH6Fc39bNEJMgArp+wffyFcFTvWR+9WLVBoQt1D12akmblSv6o9rEfe7ZToa/+5UQbzvk0Aw=@lists.denx.de
X-Gm-Message-State: AOJu0YwjmEK/PLeG6+U5ZGclljEgaK5HzM8Nq+P2XZfXjc4qEoA7naZN
 wCEfD5EYiYhpJeXMfh7+pFOd1PdDVdaJ/QmK422qmzyX7dJwgpaWa/hcz8k0ZqQ5JOCbL+HN98t
 LNN7A6b1mbKP+4SyX1COREuZ6cAInl59eKX0+b2hFc7dqJWKF
X-Gm-Gg: ASbGnctCzQmywwkQQyA2TpAP4jVW6PjXXW3gv659oVjFMnxmNvblU/JVYQt25OrMFos
 TMNDchrGye0eBphqt4plD/9S7dvjR9HYOQgeXFNhoM+aT5TnZCQ8cN0GNCIXCru/AUc2wtD1Pbl
 //FOcryeMkjGzMYQBEOsfhPbwSuEwEAedLlruzlw==
X-Google-Smtp-Source: AGHT+IHcSM+r569+XtZXQqzcQynLJ8pDR3apEZId56WcU+a/26r63H8eG1jlWP7+0Nx6lJBuDg+AjC2k+wfIr6mTIqQ=
X-Received: by 2002:a05:6902:2688:b0:e58:cb:70f0 with SMTP id
 3f1490d57ef6-e636f572da8mr8433088276.6.1741518057696; Sun, 09 Mar 2025
 04:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-2-jerome.forissier@linaro.org>
 <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
 <26ec5905-e96a-4ff2-bdea-652eb9031ee3@linaro.org>
 <CAC_iWjJ6p8+2vV38rNPq0vJcAwY9iED=U129sYJxH=DL20-8rQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJ6p8+2vV38rNPq0vJcAwY9iED=U129sYJxH=DL20-8rQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 13:00:22 +0200
X-Gm-Features: AQ5f1JqPqKnxT31q03BkAFJ4vYhDkteFhb7b9dIqmgX6BJg8EDEh0yA_B3KqkRI
Message-ID: <CAC_iWjJu+Skm-YQ_Ri56EVtywy=HRuMm2gmqm7DaKXtRmVje5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
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

On Sun, 9 Mar 2025 at 12:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jerome, Heinrich
>
> On Wed, 5 Mar 2025 at 17:13, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Hi Heinrich,
> >
> > On 3/5/25 16:07, Heinrich Schuchardt wrote:
> > > On 05.03.25 15:26, Jerome Forissier wrote:
> > >> Add the "cacert" (Certification Authority certificates) subcommand to
> > >> wget to pass root certificates to the code handling the HTTPS protocol.
> > >> The subcommand is enabled by the WGET_CACERT Kconfig symbol.
> > >>
> > >> Usage example:
> > >>
> > >>   => dhcp
> > >>   # Download some root certificates (note: not authenticated!)
> > >>   => wget https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
> > >>   # Provide root certificates
> > >>   => wget cacert $fileaddr $filesize
> > >>   # Enforce verification (it is optional by default)
> > >>   => wget cacert required
> > >>   # Forget the root certificates
> > >>   => wget cacert 0 0
> > >>   # Disable verification
> > >>   => wget cacert none
> > >>
> > >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > >> ---
> > >>   cmd/Kconfig     |   8 ++++
> > >>   cmd/net-lwip.c  |  17 ++++++--
> > >>   net/lwip/wget.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
> > >>   3 files changed, 121 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> > >> index 8dd42571abc..d469217c0ea 100644
> > >> --- a/cmd/Kconfig
> > >> +++ b/cmd/Kconfig
> > >> @@ -2177,6 +2177,14 @@ config WGET_HTTPS
> > >>       help
> > >>         Enable TLS over http for wget.
> > >>
> > >> +config WGET_CACERT
> > >> +    bool "wget cacert"
> > >> +    depends on CMD_WGET
> > >> +    depends on WGET_HTTPS
> > >> +    help
> > >> +      Adds the "cacert" sub-command to wget to provide root certificates
> > >> +      to the HTTPS engine. Must be in DER format.
> > >> +
> > >
> > > Shouldn't we build CA certs into U-Boot?
> > > Downloading certs from unsafe media is not a good replacement.
> >
> > That's the purpose of patch 4/6 [1]. Although downloading may still be a
> > valid option when used with hash verification as I mentioned in a reply to
> > Ilias in v1 [2].
> >
>
> FWIW I think this still makes sense for peopke that don't want or can
> not add the cert in the u-boot binary, but can add a signed script to
> download it on the fly
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This still stands, but there are a few warning/errors on the entire
patchset. Can you address them and send a v3?

Thanks
/Ilias
