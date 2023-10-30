Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD1CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367D587A93;
	Mon, 30 Oct 2023 12:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ug7pDZVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2877B87A9A; Mon, 30 Oct 2023 12:44:16 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CE087A91
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5079f9ec8d9so4861560e87.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666253; x=1699271053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bbJksOQpEaD6y2xSQUr3d8gkFwZ08RODD7O8PTHKirc=;
 b=ug7pDZVeB90tyfaWDSzQFfZ7RCgmjCzoK5GSSmfMq8iH19aa3rJAo3/oiRV256J5D0
 Bq62pUw4ThRHLG/HMFZZGi0EkUp4VbUSOdi9KOcoLD4vaTCcUAwXUixhXJAiTfIZfCP4
 IpTr5+/vdqykL3IGNQ2FhAAXk6SNJPDA6Sxghnm5eqJS5Y6XJLJpWJev0x5j3ZTf6gFK
 KOKG/IJT1sEs6aSqAzQDIO1CqxtgeeKuo9BOfjZJ+JG2D7FLNIXEyoQfaP0hfqMfocMV
 OdlzWWQ7DDwA/IS1msTT2RcO5SDEx/dmvSgEgP0PLHnyVCcUI1VXFu3xthNeRVsG/+fH
 lr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666253; x=1699271053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bbJksOQpEaD6y2xSQUr3d8gkFwZ08RODD7O8PTHKirc=;
 b=wZblfTlQjNZllzGI5YDGbYcQts0kk4YexX80tubaLsL984iJpyG+Ef6XGV6Lser1aF
 MAYCAW+Ji13ixtip2WSGDGQXkdxPz9cAEmUmDoCGBdRFC8Ikv5ddbThD9XeRfODjqi2S
 BL+Y2pyjFdQPPYrhzqWiLOMzHHzmvtxrN05BNnm6vxy0lfTJikji7SBcH1pgJFzD4cdM
 MqLaxW6vBA/N2woEaG8KPXHNoA/BYA3tya7nLdcHL4CHu4rLX/aOHzvOeQ/1z5PZQTQw
 QPreCNJiZRK9UBRJpURqTsx/9mPQEuk4XZpgUiRD/TmqLgHpm5k6iUCOAdt3k5n7grz3
 sTKw==
X-Gm-Message-State: AOJu0YzY+3nCD/VIE1bMLhS4znW2HE98GawPWO8usnUq0tNixz0dsstu
 Rqc9n9DckzPF8i04YdKlqCB422q7FqE/X4H/9dvp+X8jGpdR6IWF
X-Google-Smtp-Source: AGHT+IFff7aR5G/IPklvLolq3JZn3Et7NFaajxabY6wUHrWg6BL2j7ylQFpDo2hNrB8E2azpJMzlPyV4WS0NsBhwvqc=
X-Received: by 2002:a05:6512:3b24:b0:500:acae:30c5 with SMTP id
 f36-20020a0565123b2400b00500acae30c5mr4337428lfv.15.1698666252751; Mon, 30
 Oct 2023 04:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231029042817.3938657-1-sjg@chromium.org>
In-Reply-To: <20231029042817.3938657-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Oct 2023 13:43:36 +0200
Message-ID: <CAC_iWjLADtFmYFgofM5ATpFK11ha8MrX0XqyNwYxATpOrA3Heg@mail.gmail.com>
Subject: Re: [PATCH 0/3] tpm: Start to tidy up TPM tests
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>
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

Thanks Simon,

Apart from a nit in patch#2 this looks good.
Pleas note that this doesn't apply on -master so please rebase

On Sun, 29 Oct 2023 at 06:28, Simon Glass <sjg@chromium.org> wrote:
>
> This series is a starting point only. It tries to provide some direction
> for how the TPM tests should be run on real hardware and on sandbox.
>
> For sandbox, things are relatively easy since the TPM is reset before
> each test. Tests should start up the TPM before doing anything. Tests
> can be run in parallel, which is fine because tests are independent.
>
> For real hardware, tests cannot be made independent, other than by
> resetting the board, which if the hardware is correct, resets the TPM.
> So there may be more work to do to figure that out. The approach taken
> in this series for real hardware is to have a few tests which do init,
> then have the rest of the tests assume that the init is done. Tests
> that depend on the TPM already being inited can use 'tpm autostart'
> which works OK on sandbox and real hardware.
>
>
> Simon Glass (3):
>   tpm: sandbox: Support self-test continue in emulator
>   tpm: Convert sandbox-focussed tests to C
>   tpm: Drop unwanted special cases for sandbox
>
>  drivers/tpm/tpm_tis_sandbox.c |  1 +
>  test/dm/tpm.c                 | 77 ++++++++++++++++++++++++++-
>  test/py/tests/test_tpm2.py    | 99 ++++-------------------------------
>  3 files changed, 87 insertions(+), 90 deletions(-)
>
> --
> 2.42.0.820.g83a721a137-goog
>

Thanks
/Ilias
