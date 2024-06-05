Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8C9C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B18787AEC;
	Wed,  5 Jun 2024 07:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FmYxL8cq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC70F88096; Wed,  5 Jun 2024 07:54:10 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1BD8751B
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso43012845ad.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717566847; x=1718171647; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Z8myshYQZj+eJZLYplOSdGGZinZ3omwgPdu8DseJCI=;
 b=FmYxL8cqxK9h3YzdS9TqWdl3Mp5f0vHLHqtBJXVlvqYAe3OtDlfgSEjTrlC9dI86Qz
 bs3+GeOEAvCJ7WK5UQ54xOfvY70SC/YOOJOc625HVASsqPtYhrpE4LB5uSW5azL2Xguu
 4cZQJHbXVz7pDoK0mwOSdgoR8Qiw1LhA3Kjyd38sFV3MYZAMVXtHzZq8AFcbA0dGtwh2
 2w2EGOMQ7Axxjz20Qh+Cncu9Q1pWLVOI2aiMUcpI8mUqewXYv7b2+d3VRo8kO84a3ml7
 m7frfdLXmqyeO3TgPQhyJqvNSXfA5E2RVZKLrxYG9GRlLAaOHa9QFJEcKCRftys7DC16
 6bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717566847; x=1718171647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Z8myshYQZj+eJZLYplOSdGGZinZ3omwgPdu8DseJCI=;
 b=cpGw5zZ92A4khTMluQM4H4GnaIAto54jQSz4JwQicmT6DBFo4n3IRDxS5okI2jDTXs
 PfdpjflsmlBRhlr0vSTF6Inxc6TMQiLWXTmfdFXTzh9BKfHkZjsVt71x1uJLjbIWe0Qc
 CLcwJz0kT8AEUDM7GTiFsdnrCukOeURkE5Yi7v8BGP5AC0BBvvP1FM4rQv+MMU8w4j6m
 OhDQ8C1jjPI4GweY1KOXEYoLPTYeqqaXqdLv9sueMiWlrRtm8JpZTwYbBkItz0EZT7lY
 JxkP9jtwzNPmHt+fVFy1osvomzlxb0TFnkxOFk2xPw4JNkUodO6PPlz0UixrAIdxsc0b
 1qSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Tly/6U6Fvu4sbLk8Ta4wlm3Y3pC6LLGF4fFkzsHb+sbiBGvlvMlL4eQti6+xHU1VnzsRwfgepev0rutu07m5Evy3Iw==
X-Gm-Message-State: AOJu0YynF5IIu8yBBr1wVsHtHubnDoPOm1lz/IoIEvSdKuG7c7diWCOk
 KTrjzrrLjfmzOytk0pv3TeZ78gfSbuDz9zheKBIYdjmiOG2Vg/0TEFfUtwuajnBSKVJPC/fxvtE
 6eW0YfMTwsJtzeMaRjuFnR4YZdhl+jzmCiLaIvw==
X-Google-Smtp-Source: AGHT+IHMnVqe77UJFv4vuru0rrjzHBTwHDEDT5eS9uFrouMKePgTWG/IML3eXSREqqF1wIHQR/l6agPeGQFqpSef+OA=
X-Received: by 2002:a17:90a:5410:b0:2bd:fa57:b361 with SMTP id
 98e67ed59e1d1-2c27db10aecmr1589692a91.11.1717566846843; Tue, 04 Jun 2024
 22:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-3-sjg@chromium.org>
 <21ec4fcf-0a17-46c6-ae18-6787366e99fa@gmx.de>
In-Reply-To: <21ec4fcf-0a17-46c6-ae18-6787366e99fa@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 08:53:30 +0300
Message-ID: <CAC_iWjLzE9mgckmij1A0VRNj9RXAFsa8+Eu3X4R-Vbuf3P3LBg@mail.gmail.com>
Subject: Re: [PATCH 2/9] tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich

On Wed, 5 Jun 2024 at 07:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/5/24 05:25, Simon Glass wrote:
> > It does not make sense to enable all SHA algorithms unless they are
> > needed. It bloats the code and in this case, causes chromebook_link to
> > fail to build.
>
> Why would chromebook_link fail to build?
> Is TPM used by U-Boot on that board at all?
>
> >
> > Add a condition to TPM to correct this. Note that the original commit
> > combines refactoring and new features, which makes it hard to see what
> > is going on.
> >
> > Fixes: 97707f12fda tpm: Support boot measurements
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/Kconfig | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 189e6eb31aa..70b32362ada 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -438,10 +438,10 @@ config TPM
> >       bool "Trusted Platform Module (TPM) Support"
> >       depends on DM
> >       imply DM_RNG
> > -     select SHA1
> > -     select SHA256
> > -     select SHA384
> > -     select SHA512
> > +     select SHA1 if EFI_TCG2_PROTOCOL
> > +     select SHA256 if EFI_TCG2_PROTOCOL
> > +     select SHA384 if EFI_TCG2_PROTOCOL
> > +     select SHA512 if EFI_TCG2_PROTOCOL
>
> You need to consider CONFIG_MEASURED_BOOT which allows measured boot in
> the non-UEFI case.
>
> Please, take into account
>
> lib/tpm-v1.c:20:
> #error "TPM_AUTH_SESSIONS require SHA1 to be configured, too"
>
> This #error should be replaced by a Kconfig constraint.
>
> I would prefer the select statements to be in lib/efi_loader/Kconfig
> under EFI_TCG2_PROTOCOL.
>
> @Ilias, Eddie:
>
> Why do we require SHA1 which is considered insecure?
>
> Shouldn't we change tpm2_supported_algorithms[] to include only
> algorithms selected in the configuration? This would allow replacing all
> the select statements in Simon's patch by imply.

The algorithms used and configured by the TPM are device runtime
decisions, not compile-time ones and to my knowledge, there are no
devices out there that disable SHA1.

Failing to extend a PCR in an active bank is a security vulnerability.
It would allow the unsealing of secrets if an attacker can replay a
good set of measurements into an unused bank.

We could potentially fix that in the future since we can configure the
TPM active banks on boot, but IIRC we don't support that yet.

Regards
/Ilias

>
> Best regards
>
> Heinrich
>
> >       help
> >         This enables support for TPMs which can be used to provide security
> >         features for your board. The TPM can be connected via LPC or I2C
>
