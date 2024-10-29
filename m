Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D42ED3A66C
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A385589190;
	Tue, 29 Oct 2024 16:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NIenc3qO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C0F8919A; Tue, 29 Oct 2024 16:45:55 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F372588D29
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso780016266b.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216753; x=1730821553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dfpU8ujw6WZKBQ7xFLRgD4UbTvlPdUCTCddMIwy5Wj0=;
 b=NIenc3qOi+/C8ISHkBtoKsQHvPrFHyj9GqfcW2RaM/VJOkuhjXO3iLSUJiPf7RFBUS
 lGLwQaOuGR0L0BHFqseUzr8MbZ2Ezw8z4jujwAW7NXNl4WhZFasgl8Ihndd8ikz/JwDv
 EheG8Z6AHhT1ImlUBroBBD4/jXs2xLJUWk7+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216753; x=1730821553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfpU8ujw6WZKBQ7xFLRgD4UbTvlPdUCTCddMIwy5Wj0=;
 b=ni9L78oirRCR2v+NMj6dMNNb+nghOaXXmB44KSRr5LakxBkUPRprG29DCEYM3EXvs9
 EPq09hPklYF+cJtc/M0UUpbiFY0BDjIPwWRaqXxESXLFgpciQOpWKfDqdbYZ0A/thIqQ
 uxdzE1q7Mmh+UITrNlKrtFOFK1Xs2aUt2hQFLaG8FwUhDa9U3J6exdf+bW6eW51MFuNJ
 +eRUpdaphPfCDdWcGyNrJ8Jt8r8DaJmxazKMe5soV1V/ktpF5Ah1vq9zV/A7CE93MyfF
 Tru1nQ3JRnShJkmmMCFa4XRfS9plt303ZXHBVOQfdXcMyPHg4bgSNt3k8UHLme5sMgcL
 /mWw==
X-Gm-Message-State: AOJu0YyUgGTszSz6Dj2QDO3G4B3ZplGFDuR/5U372kYySDHcCBl0MgmX
 rKw/k2uCw2FlaAGlYv8HlaskMtp4hKxXNZFZFAluQdo7sX2TGZtfp+1neFtXhZ63cqDgvxv7FPW
 E1KXK4Icq58ce65zO7BY7cQmHmLWfBK9jShZZ
X-Google-Smtp-Source: AGHT+IG9yhPpROXWYaUeNOJi5fPCULJtQe7TRAx/qRZyi6TS11BmzsgOcrAPshN1/f/Efndt2miyt73QuTMfY7euqlw=
X-Received: by 2002:a17:907:9281:b0:a99:f283:8147 with SMTP id
 a640c23a62f3a-a9de5f49d74mr1078826566b.27.1730216753411; Tue, 29 Oct 2024
 08:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
 <20241028193310.GS4959@bill-the-cat>
In-Reply-To: <20241028193310.GS4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:40 +0100
Message-ID: <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>
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

On Mon, 28 Oct 2024 at 20:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:
>
> > There is no particular need for bloblist to have its own test suite.
> > Move it into the common suite instead.
> >
> > Add the missing help for 'common' and update the docs.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This feels both like churn and weird. I would think "common" tests are
> for things that are kinda legacy and too catch-all to have their own
> subgroup.

It's just chosen so that the test for common/ is in test/common - i.e.
it makes it easier for people to find it.

BTW this series removes all tests from test/*.c and moves them into
appropriate subdirs. Some of the tests are quite old so have just sat
there all these years.

Regards,
Simon
