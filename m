Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35CFCA5531
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 10:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F8086D0B;
	Wed, 13 Sep 2023 12:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQQLlsyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C3B86D2F; Wed, 13 Sep 2023 12:06:28 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE33686A49
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 12:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so11356473e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694599585; x=1695204385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3/zp+AtNCK1plm2VC5dwXcuRrqcHxnixwT5vcWt1094=;
 b=UQQLlsyOnrVDeZeXzCgGpgrxYnl9OvY5sZZo2kAqCE3JAJwpUbTWz89/8qDZvGLG7p
 aYUmryRVgjmBh0nZMyVfLuaVG0/Y3Kw4Ol3gtg2S2UA2fQYvNAF14oV030jYHo1Iueg1
 KBQEZxonRToSgV+6cJ+7iHA6+5tX9/QziylTl9EIdQWEJzBQEp1eaTqWvhOvPV+6OrDW
 GEBRuSA0GnmpVaTXFh0wj02UpzWhTaZ/gRqyHRqNPVNdiE6aoqeLfQ8WdLeg20kTlS0R
 Rd9jt9TpxuVDIbm2CPYb4L2T//rZC6du8M9SXC6YR3qXwdjs5lT4jAHATtpQTLQ5EWW9
 HTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694599585; x=1695204385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/zp+AtNCK1plm2VC5dwXcuRrqcHxnixwT5vcWt1094=;
 b=WlEFcwP42/coYp5G1lNScjDwMUUWAxlWTrMwcDdY18h1/KV4HS+f/9MWUutESkU0R8
 rO01OrPXqNx2l+A/F+hz7sDAaxw4v9n+2X8biS68F8y1pk+z8kDtE6mn1w9AXUEA1BqS
 5rURYtVeESb6pxnEfmPQstAQYWD4ak2sDms9akWOZbfAIyCP3bpLfVRAx8vLLapzcpXL
 GO+Pd+6RQwxpAGa6vt6cELFcRYFqs/DXDLccBvoJeatFE41U/JpR08WEGUr5FkoiceYm
 vyCYgpxGMl/PfYo7sBdLFd7vk/vbtzlV8p3W6YjxlOca0YiCh4/BoHbWsDXf0r0Z/UTZ
 ckFg==
X-Gm-Message-State: AOJu0YyMrMcwuXaOZrpKeSh4HMS/0EwDs9+ioQVrDKgaNrUaJm29Gojw
 GSRjBRjegGlrdnKnFUCbs7a1GE1L2Zddj0x9R/Y=
X-Google-Smtp-Source: AGHT+IHfo6u1FhyFktAU43dGlznybCbameIc4QDfdMZ1A+0OGJZjzZHlKXtmxUDcnBP1YfjQleTQpNn826W8wkSCnbY=
X-Received: by 2002:a05:6512:108c:b0:4fe:279b:7603 with SMTP id
 j12-20020a056512108c00b004fe279b7603mr1984328lfg.14.1694599584873; Wed, 13
 Sep 2023 03:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
 <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
In-Reply-To: <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 13 Sep 2023 11:06:13 +0100
Message-ID: <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Simon Goldschmidt <goldsimon@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>, 
 Simon Glass <sjg@google.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
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

> >> Then if for development you need  to pull he history of lwip, you can do it with:
> >> git pull -s subtree lwip  master --allow-unrelated-histories
> >> (but I think nobody will need this.)
> >>
> >> New update of the lwip net/lwip/lwip-external dir will be done with:
> >> git pull -s subtree lwip  master --allow-unrelated-histories --squash
> >> Squash commit also has to be git format-patch friendly.
> >>
> >> If you are ok with that proposal I will send v9 with the first patch created with steps above.
> >
> > We've gone through this before.  The whole purpose of this is not
> > having to maintain patches.
> > Simon, instead of "I had problems in the past", can you elaborate a bit more?
> >
> > Tom said he is fine with subtrees instead of submodules and I know for
> > a fact EDK2 doesn't have too many issues with submodules.
> > Their documentation is pretty clear on building and requires
> >
> > git clone https://github.com/tianocore/edk2.git
> > cd edk2
> > git submodule update --init
> >
> > Perhaps the situation has improved since you had issues?
>
> While I don't really care how you solve this technically, I'd *strongly*
> be interested for U-Boot to use *unmodified* lwIP sources where an
> explicit reference to an lwIP commit is used. I'd rather integrate
> bugfixes for U-Boot into lwIP than having the sources drift apart.

Strongly agree here, we want to use upstream and all the combined
development and reviews etc rather than forking off and ending up with
yet another slightly different IP stack. The whole advantage of
adopting LWIP is the advantage of combined security, features and bugs
from a wide range of projects :-)
