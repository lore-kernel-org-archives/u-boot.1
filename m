Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4900C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 20:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EBD82C2F;
	Wed, 18 Jun 2025 22:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LrYEGeu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A497E82C55; Wed, 18 Jun 2025 22:07:52 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F8C82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 22:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-710bbd7a9e2so791047b3.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750277269; x=1750882069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IfFd5QUmIGkT8nciCQ9dP+88P5BuMubWNcwn9SZv+5Q=;
 b=LrYEGeu3nff3p6L4R7/iZy0vd6Tb1yrZVcQC4criqpAjiik6AqI7+8iElDe79fYrKo
 UegNKoSAJ3Xvt/clRpYmcZ8knRTbbl0L/LUzqx8bceThnlx0BlxPJeKP/zjMYK3PsQyp
 F8DMFCabbbaGKDZAlxgvmgXb6AuXbZUZtOvtEceh6q9G5C06PuxU2+NmFh8LlgIUr0Dz
 3U7WrioWfRxK+y4bWvat8zagXld/gbHnZgDcqIUNbHQqa6YmceU5sJM3vvTBE/klay/U
 Ysu2lI0JhNsEmBLpZoFdswsaUg7mPk428PslAauja4xNySGsDLbja0HjyauJcO1qFCLP
 yrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750277269; x=1750882069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IfFd5QUmIGkT8nciCQ9dP+88P5BuMubWNcwn9SZv+5Q=;
 b=XX9CG1zAhW1ar4dtM0jW4Uj+dELH4UQOFuUiPDlEcAPRqiLwElRGQ1XBOycg5U5dNW
 D0bVr4Ph9dZrPcHJq1AQ/BNYoHqdFlUNAfCRSEi+F3pUWmnH0QCu2EkUdg+XmYOT5XQx
 XlXJoLzeraF7wENffJ6Vr81KIAwdeiNR9QJB8V+JZxX0XvLsnFkCoStWaC9QtH21Z8ds
 uhi0Ngo/h2elDWY3mLU7udoLaqhtOzaSSqd0yz9fwZlFOWfAfRzm6i6ABaEtKP7IMf+C
 8bF2OFY7r5vAN+qbFORpg9BgNcEf3rQu+FnV3sD4aFOQpJZevRThqsHcjUXC41/E7Vld
 Z4MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPKXUWxnm1WFSQW+/C8YmkD/Tj8L7DgOx2vWnOrQthNzJw+5tYWEazQ7szANyS4vS9hLeGBPg=@lists.denx.de
X-Gm-Message-State: AOJu0YzOp3OjpYzA29weXrCOtbriOpsyrSzaCo3ND9GWOwRdEgZjTXXF
 rO/1QeniwZckVtId9JZMcVL2v0elpz8r52yGzQswzJXv8hQi9UCwX50OcbJwuYlxCqp6t5Oq5Jc
 jBDeBeTc/63gJksGtXWKR9eNtNFHRLRf6tsex1Xr7UQ==
X-Gm-Gg: ASbGncvPzHJZDXSavcWbb7BJVCDyxZEF8p33XxwUuoFOl8Q27CXeDdwwcuvg3Kp9pob
 0mTJwZRSXM8OAqE5j3X2/hfGX6w6uy+phvOdk3PwEJfLPkIsEziIbmI+PsRXhrAUUMCTsMQ9LRd
 mxelEFnXgCIH+Tx7JdfzhihGVocZe+ylQ7mocofPkWJDA+
X-Google-Smtp-Source: AGHT+IF3BOV531omEviD1x0Yl/kHwhb/3ap0xAPxwJHmyE32MiLFdDk9GDQxvRcqbW1bjBvYd2n8jIeTNWy7rNt64ZQ=
X-Received: by 2002:a05:690c:578f:b0:711:a54e:8e11 with SMTP id
 00721157ae682-711a54e99bcmr83641217b3.24.1750277269404; Wed, 18 Jun 2025
 13:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618145016.GF6521@bill-the-cat>
 <875xgt3x2y.fsf@minerva.mail-host-address-is-not-set>
 <CAC_iWjKnLXYUEiJ-B_vxjCaoMpcPazT4HijAsdtA+PCKfCQXKQ@mail.gmail.com>
 <8734bw4yqe.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <8734bw4yqe.fsf@minerva.mail-host-address-is-not-set>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Jun 2025 23:07:13 +0300
X-Gm-Features: AX0GCFtt0tqKyHmiyuK6aXZmM9b6G3PAteMuPn7gjq__xL1mFILI9bK3AD4lHBA
Message-ID: <CAC_iWjJexudN_ZHB0TS5xnFLYeL8_99yWM_kqPgDR==1dB_2xg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, mripard@redhat.com, 
 alexl@redhat.com, mkorpers@redhat.com, eballetb@redhat.com, 
 mskrivan@redhat.com, Alexey Romanov <avromanov@salutedevices.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Javier no worries

On Wed, 18 Jun 2025 at 22:49, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
> Hello Ilias,
>
> > Javier I reviewed the patches but I probably missed something.
> >
> > I am getting a compilation error with the selftests applied.
> > #include <part_efi.h> seems to be missing.
> >
>
> Sorry about that. What's the command you are using to build so that I can
> replicate the issue. I tested with the following build command:
>
> make qemu-x86_64_defconfig && make -j8

Yea that's ok. The problem appears only if you test the patches
against -next. There are big changes in the kbuild system.
AFAICT it's only that include missing to make -next happy.

Cheers
/Ilias


>
> > Thanks
> >
> > /Ilias
> >
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>
