Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249A9C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CE281E47;
	Wed, 19 Mar 2025 16:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IgVIz1De";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FC982063; Wed, 19 Mar 2025 16:04:47 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212C180FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso123293595ad.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396683; x=1743001483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ozn/qNuOWDEtf2S2enTjX6cf9ZLEHgKs8m7Ngt8sRjI=;
 b=IgVIz1Defs/oewi1WcC1NcQanjZxg+yhsAbHa823MMAAFqPFW3svmRVZxntKLBtaNA
 WVymvwcd6MUgEQtOCHWwmEfU8j0Yj404KxsbKxdEL9WZr7F2kzjKYyb5Fwn4qjyJGNyd
 f2+7f9Z+cT1A3RHiHMu1lS3+V9DEObTlcDjoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396683; x=1743001483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozn/qNuOWDEtf2S2enTjX6cf9ZLEHgKs8m7Ngt8sRjI=;
 b=fUEmA0TCC7z7ezDhWrSEte6SsRmMTgfWCHjSoXm90fq4lOYZMCT2XUbjbDuo53CqP5
 tKip0mlc++AuFgNgOoNHk/VnWIofnyhXd8rYQLdmKxleQT2amA8Y/pRTrXYGs56bhsyO
 QZIFF/0/uGYB9h9T3S0ye1gCJ18KHyBDg93427GUzBrSpOmF4i2oAjkvXb7u8NI+qPSI
 usNDhcSQ7/iq65FxK6jyfH9JZj0vKinyG3te/OpXQ6Xw+AIVr1Mq1NP+yukTQjjjZunJ
 D6NxBzW5DF+xf00KjYHAZWYEISmftwrEMuCxdV19gNS1VtCIO/n6eCJFgOzXC3pKH6Z/
 Usnw==
X-Gm-Message-State: AOJu0YyNkV5wKg4q00H2tpcL4S2l57fxjdfDN2LU76aHvmOgJLQtSLYr
 qbmeJ0mAsoyHV/f93OsIsH83HuyjbXe2idtuDOtRn/s8OgCVLvP2ieK7fAmJ8fpAU64PMvI6r2o
 CJQX7dmwDaqC924SOXHriPVvP/EG1WLcwd/2V
X-Gm-Gg: ASbGncvxe4y18G/dplep4gQ9kLxuSYcGOyqB91xgdHMjQBr4qge8vVn94d/U6CyoOJ/
 SiP5eD0KgOzJCqIft6TwyC32btr23lVfgDiIflJWrmPUHXeFw1OvatTU7is5G4mNjMZoIsBGzSB
 lQ4iqoFJb+3PY4awWl232YotkKWtM=
X-Google-Smtp-Source: AGHT+IHOVCz9Rr+AB7eUeIGHBP9c9Y7ljKsGSUAl/ZwdurKlazAwfMiLl/fDv7UvyRO5cSUSMfDSO7gLGkfqEw2b1A0=
X-Received: by 2002:a17:903:22d1:b0:224:a74:28d2 with SMTP id
 d9443c01a7336-22649a34a6fmr41966735ad.26.1742396683524; Wed, 19 Mar 2025
 08:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
In-Reply-To: <20250319145218.GG2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:04:28 +0000
X-Gm-Features: AQ5f1Jr8QTxoLClbJ0sKYFWJ8vioWnrxBJXZUe7CAFj5wU4hgAXx7_f9m4SSWAQ
Message-ID: <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
Subject: Re: [PATCH 09/17] test/py: Add a test image for Ubuntu
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
>
> > Add an extlinux image that contains a few Ubuntu entries.
> >
> > Increase the number of sandbox-USB-hub ports to permit this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I don't understand what this test adds. In neither the current Fedora
> test nor in this new test are we actually booting something, we're just
> taking a sample extlinux.conf and making sure it doesn't fail. Is it
> that we're testing in a useful fashion now having two labels?

I didn't think so either, which is why I never did this before. But it
turns out that there were some bugs, too.

>
> We should probably be clear about what we're doing in the tests and
> instead of adding seemingly arbitrary distributions add an extlinux test
> and testcases.

This is not actually a test case. It is simply creating a new image.
The test cases are in the other patches, so please take a look there.

Regards,
Simon
