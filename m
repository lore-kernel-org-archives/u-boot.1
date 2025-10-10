Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71972CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BF583FC1;
	Fri, 10 Oct 2025 13:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VwZAjEej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C4583FF0; Fri, 10 Oct 2025 13:13:48 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2114483F6A
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so1808489a91.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094824; x=1760699624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wahR28t7Sna0hox9NKcg2BqvF8vsol1U9Q05U3ubb70=;
 b=VwZAjEejLzOg3B/CViYr+ZCKb99BmB2a0lsaeQhH7jvlzqSD2+HwoftFY9wjaZSHHf
 TI+b5Jdls612bjtP3WGfrcZ4RUg5DDlnSYYP7w880SILgsasDgZWhwSVNitOnXtYMiY+
 o26qRGyWh59rFw3WlLJTGg3Sfohr+TdWAl7ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094824; x=1760699624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wahR28t7Sna0hox9NKcg2BqvF8vsol1U9Q05U3ubb70=;
 b=oz1LfWHK80mDkVf5bqtO9xHiDHezESYO9YosyYokjptwvBwf+3LbTuZInciHDOH7wC
 js4w3S4gPV/hoBNgv2FMJ97mtJ5B/rrANXKpUU9nmwTZP9g0JvPwiaPelR12AHwHSSzg
 rUQ7eJlPffn5sm1vJZ7qk0T6FqDvj/YQbjqWwdgGWNnGT4gTj085ziYXkEq88GAZVHac
 uKHIg/IKw+xmno3Ssf61dOA34wWQO5wR5xn9rhw2Ps0kYqCEPtF43cLGJREm3rF9wneE
 HmYvhB2+6iOPYgEiGo1SqIKnjM4PIgFjvu1Lp7sxlmTALOhl3i+Mzvq49pWqPSMcvUw4
 zd+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCRZ86NA4HtASAX35tNij/kAtur7sS0i+9v8HbilfwwbtpZDT04dEc9wid+9seeoXeGhZMYVA=@lists.denx.de
X-Gm-Message-State: AOJu0YylKQwIxQ/xhDYMSbGWkGs24vIUIpdZf6l5OyWl7Qo5baBy75lL
 hRVOWGLCrNyvegihS0DcdwuglrGscsRSjBEbppvBka/XaOHsO2/5hGJCHveM8QAVIL1THjLdCNw
 u4g/Tpe4VsGNMoysZSrqR+VmaPVALpB+Vjmnq33mT
X-Gm-Gg: ASbGncvh/vy63398v0jww4vnnVJ4v5I2v7Kn9Fe7RlO9CqPCgbLGFax0sQhBgmbrv7Q
 yJ/fef1EXlk4NM3syx4CIIhBL/5oju66nltq6bovl6+zPCOISJg1DofEb5NU3oYb211jnMPqxF0
 RaKLC5MRMch++C6M6TkZxNl/Fo8MAh8z701Z/IqE2bAc4WapZpZZMjTy6uBTAfiDjNo+d8lhZKW
 wDq8pBEf8e7zjd4hT754Zm+Y+lcJs7X
X-Google-Smtp-Source: AGHT+IEfRoCt8Va6ucXwg/SrsJOQBX35JolV8ORXocRRuCcOO4blOMkYAubvGuxGj202/SEpYOUlWUyjxFSunTBQ5z8=
X-Received: by 2002:a17:90b:1810:b0:32e:52aa:3973 with SMTP id
 98e67ed59e1d1-33b51125090mr15379861a91.8.1760094824615; Fri, 10 Oct 2025
 04:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-11-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-11-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:18 +0100
X-Gm-Features: AS18NWB7wPlY5ULQe6Ys53a628Wa7oy0p-nP8oARCEmnZGvzzIj3Rn-H6hiFvoo
Message-ID: <CAFLszTjxABb8h9Ewet5fMm3nWu44FCzOVmXd6ifmveWZb+rQ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] board: sandbox: Convert extension support to
 UCLASS framework
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Migrate sandbox extension board detection from legacy implementation to
> the new UCLASS-based extension board framework.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  arch/Kconfig            |  2 +-
>  board/sandbox/sandbox.c | 24 ++++++++++++------------
>  2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
