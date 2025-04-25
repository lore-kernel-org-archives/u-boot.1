Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1A5C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C8582786;
	Fri, 25 Apr 2025 16:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="xgP3YjHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA4F82114; Fri, 25 Apr 2025 15:50:28 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E894E820F6
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30db1bd3bebso24083051fa.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745589025; x=1746193825;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPsPq9mWA053oxxTa3qFiyaUA5FRTy3ZxAFVyNGvBAU=;
 b=xgP3YjHbzc6iPQNkZh1cGsEbuc6MUoRlBx7A70zp/esfy0+4cNmzMMb9k9t0RtyQZi
 ki7NZ7sf/tyoUS5bmILWKRVG0d9SBXmMCAMRJ03/v1XRS94QogniMkKB0ddW+++FqmJe
 47hhGLMGJNwhklzx520Hcyc3qeGR9npLDIPESflCkvMcchHlSmzKnqy4oVbrz/9Ly/Zv
 2lVdYB3Xx19z2EaHO99up7hnst0knAXcmklUdHJxcdoywwAr3uLGHbRZIJSWu42ZAwSF
 flWzQWWmy9OI0e4vWYwDmtywcqN43fMllUs68qvjL8DjKsoHVP4STsUnfdFipWlIfFQv
 oeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745589025; x=1746193825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPsPq9mWA053oxxTa3qFiyaUA5FRTy3ZxAFVyNGvBAU=;
 b=nP+VBaysuibCXiNNtuyOFDE85TbdX3CM7Hfa+dgiVqiKYXv7WWYJ6DPOg9c7idUbqE
 7+KKq+bgH4OOQwzrM0NG5yerqI4xcJaLuwzfewDhuMWYbEsMbsLILPcYxiR/VCX6QeIn
 +xoHNJ39lIFZfhMluIg3cRjbcEs+10rRXeNkI/5cfJs7JdJoAl0m5DR29kAcSAVq0gM2
 lNNj8xjamFbJi0K3U58AkhIgbDM/Cx3cHQiZdUzTO5qkFttpBA1ygcquBt9mWFAQr7re
 I5a7pmGV8S4+nyNZpI7U8JPGOP1AZbxloRXxVg6Gh1rwTn0FRus33fFujQ/Dnvub07ZF
 8Rtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtN2ZyM5kC+KwMayCbdck2O/kLQnXgsBPifQtlk4clRfU2n2uQCBsc4jwuwgDSzkH/tvMJIsM=@lists.denx.de
X-Gm-Message-State: AOJu0YzIoC9WtiqfXUGZJDtixtUi64vMje1Hd4EZ1QaCubCbapv7UnSn
 z90ALhFMlGNMeuIldnbGJyEweJRZIK2h2pJ4UB+/ggjLRtxbVNmNJvhuiO+wuSl5VJE1nMdulOb
 uvhHr/+1tSbNtCtjm7oNVfWvHQhYZFYu2+hOalg==
X-Gm-Gg: ASbGncsf7CP8yOwJ/yJsCDvijO3fu41ePo3BxcoLVSPkYd7+UXqPaGCG2jb5M53jHtS
 MGKf5DyWI6WPx1uHNIbkVFELHpaNEMW1JRJE9P5LeoZPIG0OAcQvz0Ey2ybLLgEL5CXCT4sqDSO
 duWyuNLXSBdj0h7o/x+svMRw==
X-Google-Smtp-Source: AGHT+IEObN9j61kQOTQfGXzQlEPmc+OQnWFHljxvLtTE4TNc3++FytrZke0YhHBSUzm92dE5Yuqu6fD8ATvuTW5h1bc=
X-Received: by 2002:a05:651c:3133:b0:30b:bf4e:f6fa with SMTP id
 38308e7fff4ca-3190673cf65mr8251571fa.17.1745589024843; Fri, 25 Apr 2025
 06:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
 <20250417-wdt-v2-8-49939de473e1@hifiphile.com>
 <119e31f2-72a8-4826-9c92-4db928a1020c@linaro.org>
In-Reply-To: <119e31f2-72a8-4826-9c92-4db928a1020c@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 25 Apr 2025 15:50:15 +0200
X-Gm-Features: ATxdqUHNMldUAx_xA58KbAHWSPtQuiXNCsN1xI8QNFN96kQTHOGeR953mFklN7o
Message-ID: <CA+Gyqeb+_LNGi0qa7S9M1E4LjJPe=O3anf9AFVrm3cOcZB83Tw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] ARM: dts: at91: sam9x60-curiosity: Enable watchdog
 node
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 25 Apr 2025 16:09:21 +0200
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

On Fri, Apr 25, 2025 at 12:51=E2=80=AFPM Eugen Hristev <eugen.hristev@linar=
o.org> wrote:
>
> This 'timeout-sec' property is not in Linux DT. Any reason for adding it
> ? is the default different in U-boot ?
>

The timeout initialization is different in Linux, where the driver's
default value (16s) is taken during probing. On U-Boot without
<timeout-sec> the timeout is set to default value of 60s.

Since at91_wdt's maximum timeout is 16s, any higher value will be clamped
to 16s in the driver. I think it will make some confusion if the logs says
watchdog has 60s timeout but reset happens earlier:

WDT:   Started watchdog@ffffff80 with servicing every 1000ms (60s timeout)

What do you think, should we add a warning for the actual timeout ?

> I would add the support for sam9x60 as a single patch, this one and
> previous (patch 5) which adds the registers definition.

Which prefix should I use, arm:at91:wdt or watchdog: at91sam9_wdt ?
