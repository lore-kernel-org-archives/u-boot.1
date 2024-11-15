Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C8AD6A25E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A50896C5;
	Fri, 15 Nov 2024 15:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9NsA/yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCC9896DF; Fri, 15 Nov 2024 15:27:50 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500CF896CF
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso1608715b3a.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680866; x=1732285666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5UicL+RToNV+K/JQpnn6fHO0hToTavFI5Sr/WY2MzU=;
 b=T9NsA/ynZ5QyrxFNTe2i8SjZSjcQzu3A3G0jJ7phQazeYjOoaMUpmHWW+xlrudwt9j
 xDt4wt+bQWvUv2E7LpSkxNOyC+fbxacIVbpckCkB0cXQPAnddLoN2w3mZwUfhUbN4lyv
 putuE5quYIHYaFbo/OPp+flSV7Wp2uyzKJQOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680866; x=1732285666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v5UicL+RToNV+K/JQpnn6fHO0hToTavFI5Sr/WY2MzU=;
 b=RIaN1/6YH7CuiGfxHOCqmYDW7rztJDiQ3bb0wmO4ult2aXQUlNimclYKEtXPXW0h2r
 y4ZidF2q5Hpuy37n2mUKRLFQKS3wocHTd8mC9HEHMOfJ3/FUAQsMwfs2j5eRDMT/jRt7
 tsGPH/GwF9ACMsFBJ7TfWW+qCc5cnqSxNfC+pceHtUQYOT0ZVOuTmhHvZEcwwuCdMELm
 cjlkDXiIF5H98/trCaMe90vAdIwSnU6o9O2ye3N9/BFPHvJUBvo953w2RMD8TgjjLV2w
 PK/aweur5S7udcYrVixeot3LCxKWlEzDzoqT17g567o0fMXEZb2WCHLKE3/Mbgh4Aioh
 uzsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpSTmTa8A27BtPf26teZNJFLu0zG67Dd3tzMIfvFO4fB272Qy9N+iOn5hEdNS9v8IbTw51Zjo=@lists.denx.de
X-Gm-Message-State: AOJu0YyNd/LgiUukl5A4h29lxc2LsAq348UZ8pyNaQktD7OB79dsF/KG
 FnLb0e7rLQaGhCbGBbsWRWpkzpTJOOxMSIWD0aARFVTjWmE0RBop4Oviz2YHRD6eUSKGBbZ8UXX
 25smniT7K/85sxXN0HeidWlpBiYTdFLFkBljD
X-Google-Smtp-Source: AGHT+IH9ffb8sHGViclxNc2UbRzh2TXY1Z2LjjY+oudYg5IcmJ+79uzti1mEpj7S0hkoFybHxEOTl6UiOneH7jhNkKI=
X-Received: by 2002:a17:90b:2ece:b0:2ea:2906:a6fc with SMTP id
 98e67ed59e1d1-2ea2906a944mr717663a91.3.1731680865809; Fri, 15 Nov 2024
 06:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-10-sjg@chromium.org>
 <076d440e-6667-490a-94f5-cd010fb5da49@gmx.de>
In-Reply-To: <076d440e-6667-490a-94f5-cd010fb5da49@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:27:05 -0700
Message-ID: <CAFLszTg1H8HvooBb3R1xX8yWx+qj4r80FJRcX9D+bxcBG_xgkQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] bootm: test: Move test into boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 04:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/2/24 20:36, Simon Glass wrote:
> > This test doesn't belong at the top level. Move it into the boot/
> > directory, to match its implementation.
> >
> > This test is currently dependent on bloblist, but the real dependency is
> > on sandbox, so update that.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Make the test dependent on sandbox
> >
> >   test/Makefile           | 3 ---
> >   test/boot/Makefile      | 3 +++
> >   test/{ => boot}/bootm.c | 0
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> >   rename test/{ => boot}/bootm.c (100%)
> >
> > diff --git a/test/Makefile b/test/Makefile
> > index 48d8bc91ae6..4366e495a15 100644
> > --- a/test/Makefile
> > +++ b/test/Makefile
> > @@ -4,9 +4,6 @@
> >
> >   obj-y += test-main.o
> >
> > -ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
>
> Shouldn't this be CONFIG_$(PHASE_)BLOBLIST, see common/Makefile.

There are a ton of these situations. Yes, it could be converted, but
for now we don't run bloblist tests in anything other than U-Boot
proper.

Regards,
Simon
