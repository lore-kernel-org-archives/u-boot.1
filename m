Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA92E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40679895E0;
	Sun,  8 Dec 2024 16:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NAM3Ni4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402F5895DD; Sun,  8 Dec 2024 16:29:34 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFA289305
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d27243ba8bso5002806a12.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671772; x=1734276572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=25QmUW80At+6gcTGEcN4tei7cgIJnZuuHjZ1wYstmCs=;
 b=NAM3Ni4ixWK/V0V27JTMQybgpY/+o9cQKQ/WkyS5y38GReiZ1SMXz6g5NxkoDIfKAl
 f3DeCf720AFqAZjIjRE2buDLmryWS2DYr8DML7m7DrrbsGaH/aRjk7vrODSsDNgmxJs0
 WBh19fhiospJcu25aGJrlwFYRXROcfUZgL/8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671772; x=1734276572;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25QmUW80At+6gcTGEcN4tei7cgIJnZuuHjZ1wYstmCs=;
 b=p2VW8tl5jDOPpOt/MWEn1111iHSx6hF+/B31WuwEiEIugFUX/ipYHYgPixVyxo3KN2
 M4gN4zwWYXT7K4vG4wxbRfKMRfURuOZ3r/smgCHmms5inB5yOOrx06L8DyajprSaVuVV
 kQgwPrk2hA0srCJFontndk4+GlPEXgbqMhnHqlXVn/bzLlIYKRvraa8icDhARCwLt2Ky
 MpR7jC28K5JZNGQdDGLtz2VnWCKX9CoZL3pttD8kXTJfuyBT8XHGadmQA0o3GXm3ACI0
 WpP8Kam5SkNAQ5eK/k6EOlMFv0H4Xn5MgZlOpUXl3TNHvsBqCWWSQ3gNQiA8oaLCul6E
 BZhw==
X-Gm-Message-State: AOJu0YzSrOAISAdz4ab/TYQaTbPcNJwjCLaFJqQdiOVKhE4U5xFU7Z/O
 qu9xONzuvl5Jki5Se+DAQ+Qp8vb6Hgs628Y6Q6Wo6j0pYFVLXe5aNsO9aDenKKi9FnKYHhURgIG
 bRSLIwOZxFTnTNU2H4No9JZMiH9IBvma7C4Kt
X-Gm-Gg: ASbGnctiwRwaLwnEdmvqhlMBjILXL2oDObxl26MVQLnj/1CitSo+cXezUJJRHO+WfP7
 tygSehYhNdK6/QLGaHAcPHwjgyshFASvz
X-Google-Smtp-Source: AGHT+IEoHMD81jjzoUo+Y344LZFYjXaNncvHIoba1lM+4U0hhwLS2T6QJCrWHMiLPN6DZTgfltnI4jvv8t61AjMPJXc=
X-Received: by 2002:a05:6402:27c6:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5d3be696599mr10879736a12.4.1733671771743; Sun, 08 Dec 2024
 07:29:31 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 15:29:30 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjUc8acBkRh=1sxtvzO7g2VEYN8bA1r1mTskcHsX7c86Q@mail.gmail.com>
References: <CAFLszTjUc8acBkRh=1sxtvzO7g2VEYN8bA1r1mTskcHsX7c86Q@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-4-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 15:29:30 +0000
X-Google-Sender-Auth: tisagSBD9H6aTw9Vr293Ls7iYFI
Message-ID: <CAFLszThMLj6YyZ5ffMXXrxfXukGqOxQsY4+zNyN+m2U3JqD1qg@mail.gmail.com>
Subject: Re: [PATCH 03/10] Add a command to find a load address
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> For systems with more complicated firmware, the firmware memory map may
> vary significantly based on a number of factors. This makes it difficult to
> pick a hardcoded load address. Add a command for finding an available
> address with sufficient room to load the provided path.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  cmd/Kconfig     |  7 ++++
>  cmd/Makefile    |  1 +
>  cmd/addr_find.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 cmd/addr_find.c

Reviewed-by: Simon Glass <sjg@chromium.org>

(again, this needs doc/ and test/cmd/...)

>
Applied to ci/master, thanks!
