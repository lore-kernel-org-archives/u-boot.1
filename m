Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3E2C27C50
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D44882AF;
	Wed,  5 Jun 2024 04:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuPbbWDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A9288245; Wed,  5 Jun 2024 04:13:54 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E45388250
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-62a080a171dso48495717b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553630; x=1718158430; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ESKjlSZ3r+LZE6oXeDmYZIvkJG0E7YB250m+U0KTKes=;
 b=cuPbbWDRhlcCN5lyT7BvYwFByByrUQ3XbSK3ZxRd1mBJop9o0nY78kgARVT4l3Q4D5
 v91udJ5cnOqA+5FZnghtv5AnS17PfI8kjfLZ2/uPhUxbsneI2cVwAaEGspE9TctMxFqs
 lzz5yscYNywSXRwVWbonCfJmOgBRbHhVTZ4Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553630; x=1718158430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ESKjlSZ3r+LZE6oXeDmYZIvkJG0E7YB250m+U0KTKes=;
 b=i4MMHG8Sk5M+cJ1/wj1zbc4LoRx0sNtlh787+ox5abBfl6eOsnZGJBBxiOalApDQZ0
 s7ozzh181+1uuNUghw/9FvPdxBFP+DsqLn/cJWZ+REejhbnNrmnTIzESf5bUKLMWvqkO
 dMXPkGNI054+P0Ysdai0muHc8ncVXEAWHwzta2gspXqzILMtf9r8BzHFrxHHT3r1+YGi
 U6h8pZaR8nd8XxQ3SHcispQ0/6R0YehEC1XkWJH8Sj/0JQILxWnsdAfLGZSagbAIFDtU
 Lrd0GCQdvibXHQf3Eivf3x32qBWiRtO00/k2/2uX0uZ1W68Bs0K0yQawA5lNMC2cLl6r
 o/4Q==
X-Gm-Message-State: AOJu0YwEcnZ+NbDRwOy6ZxRITmzyx208E4W6his4vr9x7CtBOkGj2Kve
 zw1Y76nCMu3QrmHv+6K9XTeDahUbJ3dDyiasvve3mshpxupq/W0V11xueYf7e6ysaY/7KIBURM4
 ZW4ThPLGVwZJOuIBeHIVFPLjwnA+J6APvFrDu/2t8aZbTiTc=
X-Google-Smtp-Source: AGHT+IEFNLULiJ+GZ2JJKWhKLKcr2gJwc3UC4Ph+JbmAXPNbhYIuJN9DFoS5vW/p9WF5B1hM2v69zlNSe+3X0b7sH6E=
X-Received: by 2002:a25:d04b:0:b0:df7:93c8:5491 with SMTP id
 3f1490d57ef6-dfaca9e6133mr1201810276.28.1717553630437; Tue, 04 Jun 2024
 19:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240604161607.1133032-1-brandon.maier@collins.com>
 <20240604161607.1133032-2-brandon.maier@collins.com>
In-Reply-To: <20240604161607.1133032-2-brandon.maier@collins.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:40 -0600
Message-ID: <CAFLszTi1G44DPY8rMH_+sPkmSOfotxGSEJM=ec64VQzCr2==Bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools: binman: fix deprecated Python ConfigParser
 methods
To: Brandon Maier <brandon.maier@collins.com>
Cc: u-boot@lists.denx.de
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

Hi Brandon,

On Tue, 4 Jun 2024 at 10:16, Brandon Maier <brandon.maier@collins.com> wrote:
>
> The method `ConfigParser.readfp()` is marked deprecated[1].
>
> In Python 3.12 this method have been removed, so replace it with
> `ConfigParser.read_file()`.
>
> [1] https://docs.python.org/3.11/library/configparser.html#configparser.ConfigParser.readfp
>
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> CC: Simon Glass <sjg@chromium.org>
> ---
>  tools/buildman/bsettings.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Does this still work in earlier Pythons?

Regards,
Simon
