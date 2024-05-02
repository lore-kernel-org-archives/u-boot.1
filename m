Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF628C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 15:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383B68838E;
	Thu,  2 May 2024 17:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="F9WGoM2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4424E883BE; Thu,  2 May 2024 17:01:04 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E02588377
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 17:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so6196974a12.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1714662060; x=1715266860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOcG+5zlbj1MZP/PpZLb4v9LHSmxyu8q8dlGUob3fR0=;
 b=F9WGoM2jkgcuJmyxkRAMEXGO4gLXvxzIeQZ9u+Aqhx0gxQz8TQI0PimKuIBbb6SG0h
 esqFYl0aTD2NPQcWGQNVtZAleJo829CX7DXU777N/Qcej9HioIBX5yO21njtASRAWcL0
 zIOd1dEYVqnl2NPKxy+g9cWuHtuG0xI0wQK1b1PojKWJ09g1r8k6iT6/9L594iQUtGYr
 1fISIydazK2CPNRTKmvN0v3Y1P7G9mFEjA0w8R7BzuVf0Q4UNeNv8ApEFQBfHU3teS6d
 xeuJT9+IaxOYPoPVfl0yZrXNVgqP9Pe5goDxJui2cbLDaSkKM67TqRLHehoyGyBCQgLc
 hSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714662060; x=1715266860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOcG+5zlbj1MZP/PpZLb4v9LHSmxyu8q8dlGUob3fR0=;
 b=IuzGegDDtnSuwSaEXYzOEhXh51w9+rhzFoY8lXs7onvmcrSIqj3Kfij8JCwd1EbLSw
 ZI2Yharxnh8L7KF0+Rf4xl9maYgt3WmZ8dhX6f5afHXlh8EPKUraNKYLpbJyDsC7sLNp
 hTxY8JCG71csmK9b2/lPeVIiqmPW1Ww9q9MwmUPITqsMozItNo1ik4x2ca3vlCr3Q1F3
 M1+wnv82npbz2Lxa1v0JsTEkWpBn/qXxEnax2OCAJzTzcwkI9q7a1A57vI+HtBcs0kMI
 h4iwNZSMBI9/TQX5sFgcWVXLXM0/OxRu+V6bOY9tsLfeGZ+EPU2eR58f7wEEiIBQuJE0
 yxYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMHB4SlKuV6AxGAzSgnpTruy0OnRz72yueqf5hwWtRoX1Ten0Szm0k/vg7pGsjp/tHBd6qw57t4cb9XFoo8igfeabSFA==
X-Gm-Message-State: AOJu0Ywot6HfKJNZn5Lm3upXjfiOp6X2YxCjUnTn5AOXOFklqQpXgjA7
 sDELwLzH8rp5pFTAoSqaV7Fi8a3CmmvetDsWM3By249LaxYsyNC6pK1yEPzSkf+tDUNQygo9bHQ
 2n7ItZsiINJWRTkSAsif8teW1Yy8pQ3YPfkB5ag==
X-Google-Smtp-Source: AGHT+IEqFFWkuZ6G01w6Ur90qBuoXAENRhYu5PmYqQlog5Q17dAdDtmHvAx1YkNh67udTFvn82ihCHtYdya4h38dU4I=
X-Received: by 2002:a17:90a:9918:b0:2ab:e45a:a27d with SMTP id
 b24-20020a17090a991800b002abe45aa27dmr2368000pjp.39.1714662059527; Thu, 02
 May 2024 08:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
 <526f5a87-24e6-4147-a29b-ee4e74c6abde@linaro.org>
In-Reply-To: <526f5a87-24e6-4147-a29b-ee4e74c6abde@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 2 May 2024 17:00:48 +0200
Message-ID: <CA+HBbNHQmRzovOaGEBhkJHt=YkSLvu-Nrt4027Z5uOjohTt+VA@mail.gmail.com>
Subject: Re: [PATCH 0/2] qcom: ehci: enable core + iface clocks
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 2, 2024 at 3:41=E2=80=AFPM Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
>
> Hi Sam,
>
> On 02/05/2024 15:16, Sam Day wrote:
> > These clocks are mandatory, as can be seen in msm_hsusb driver in the
> > Linux kernel.
> >
> > The appropriate HS_USB AHB/SYSTEM clocks were added to gcc_apq8016.
> >
> > Technically there's other adjacent SoC families that can use the
> > msm_hsusb driver with different clocks, but only msm8916/apq8016 are
> > currently making use of it so I think this change shouldn't break
> > anything elsewhere.
>
> Thanks for the patches. I have a feeling this might break IPQ4019, you
> might need to stub the clks there (cc Robert).

Hi,
IPQ4019 does not use ehci-msm, but rather DWC3 so it should be fine.

Regards,
Robert
>
> Seems like the To: and Cc: addresses aren't all quite right still.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> > ---
> > Sam Day (2):
> >        clk/qcom: apq8016: add support for USB_HS clocks
> >        ehci: msm: bring up iface + core clocks
> >
> >   drivers/clk/qcom/clock-apq8016.c | 31 +++++++++++++++++++++++++++++++
> >   drivers/usb/host/ehci-msm.c      | 37 +++++++++++++++++++++++++++++++=
++++--
> >   2 files changed, 66 insertions(+), 2 deletions(-)
> > ---
> > base-commit: ff0de1f0557ed7d2dab47ba976a37347a1fdc432
> > change-id: 20240502-msm8916-hs-usb-clocks-34bc22b03f3d
> >
> > Best regards,
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
