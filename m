Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ACBD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A712891AA;
	Fri, 18 Oct 2024 01:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hcFVSJbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995B8891A2; Fri, 18 Oct 2024 01:12:16 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E66A8912B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so8151726d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206732; x=1729811532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nze3Z64kFbBKItwiqII9uUwjnIZjKu04cuctYZh5Gzk=;
 b=hcFVSJbvQavKSz6+cizNtBrVqFRcU3RSNhOepCJ9N04BR5+FvVOyeJcIBbaED6s/+4
 55ZXR6lm9XdVCZXwT+/f8OHMX/qDjGno1aXfDX0nP4GZAHp6mXLs5IlrxsN0h2JPSUDB
 ZDswql2Tu8c/WL+9PJ0FaNqOqS4TxVpKnpr4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206732; x=1729811532;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nze3Z64kFbBKItwiqII9uUwjnIZjKu04cuctYZh5Gzk=;
 b=gPcIz1NJw600ePVOi+Sj2EthPDZCZMRGKxi5Z9xSkRUPmu/qYm3phgDKq9aBz0ddoU
 E3PANhoIcExy4DQqgilNlaRfvCIWEADztI37au6jRRfooYFS+xKrNyOUZDKKpcBp6RF4
 YIW3EJGTpN6HEcLg3z4tdFXFAHAn4eB81Jd6FVLoceg6tjvbUfWZAl+57pgntHTjY0Fb
 94QJZu74TLshWKUro5SeDoPAyF2ovDTKYyeBJBzx375tBTK3cVHUZ4+uOXpczQnP7ErW
 VJI4W/YJgWYSi6/01nMspLqB0uLzp2lncooOwsqKl479p2qqVX28MObH8uRU9OqGzR4t
 wq8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEUBvFQjd3lCGXV5R/ZLbgwj6zp83rD6HoOc8yPMYvKLidNep47RPStHpnRNwtR1CsA2govAU=@lists.denx.de
X-Gm-Message-State: AOJu0YxLqKiVuqs8SqG0GHHSMVKlmNKmLqg0tH1INafg5hPfZwHfD3TN
 2zM+UTKaBmahvgoYNTDL0jYplFUsJnR+rrhTZODfIzsh+jwpLS01ibF5/wfuQ+Rq5EnteDdcK35
 d5cupFJN668FWfGN9WJMy/gliEGiw0au15dk7
X-Google-Smtp-Source: AGHT+IE6J4CQyQyKz31jiyObHgFubYEkvYgboaR5WlGtrNO20GTZxcQRMmvbBWU8HtYtYdIVeXAkeK1aOsyZ2vfVMHQ=
X-Received: by 2002:a05:6214:5b0d:b0:6cb:c9d0:df32 with SMTP id
 6a1803df08f44-6cde14c2822mr6762846d6.11.1729206732220; Thu, 17 Oct 2024
 16:12:12 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:11 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828014429.3320011-6-sjg@chromium.org>
References: <20240828014429.3320011-6-sjg@chromium.org>
 <20240828014429.3320011-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:11 -0700
X-Google-Sender-Auth: uYwuofEc-P7uedj_XqCOdNw2w00
Message-ID: <CAFLszThq2MMNU-QU6P8igjC68wEk-2k+rEZ_m6K=PnebXyCf4w@mail.gmail.com>
Subject: Re: [PATCH 5/6] x86: Add a cpuid command
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

It is useful to obtain the results of cpuid queries, so add a command
for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/Makefile        |  2 +-
 cmd/x86/cpuid.c         | 37 ++++++++++++++++++++++
 doc/usage/cmd/cpuid.rst | 68 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 test/cmd/Makefile       |  1 +
 test/cmd/cpuid.c        | 22 +++++++++++++
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 cmd/x86/cpuid.c
 create mode 100644 doc/usage/cmd/cpuid.rst
 create mode 100644 test/cmd/cpuid.c

Applied to u-boot-dm, thanks!
