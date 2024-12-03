Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393FCE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA934896AD;
	Tue,  3 Dec 2024 20:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VaECZi6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BBD88BFB; Tue,  3 Dec 2024 20:46:49 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C43F896D8
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2eeb64f3588so2259470a91.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255203; x=1733860003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FNxA59RsG62fRjjbbQf7usFL+hxntu31AJ3rxVYKJfA=;
 b=VaECZi6G5bBnjLJ68vacs25EmFZKEiaPwaq2eJ/ubr2r3YgYbUTAEqvhk1mFKA6ufI
 4ZprA7rXjTsacIb4OQ4ARMDWOSy8iynmtApEf21Fmo2k/0KbxCkdewKpc5ONHz0pJPTo
 pHPlFCtqIuWMpcL+jWJ7P4x+ZLvH2tHRJMQPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255203; x=1733860003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNxA59RsG62fRjjbbQf7usFL+hxntu31AJ3rxVYKJfA=;
 b=PqVR4iRd6QcoYaWJtfB68o6DZ1vHZaYcoutQBASagCx/ftPD8y0WmqXmE6o/8QFSo7
 CJq2ZpyAi3UYI7rybRj9XDGfOZAHzCKGRmkrPZlxmnq4sfmR6LeMnQi3aiZQ2JvhEgnC
 G2RMEGCt2bBF8BuTFMJGJAg4TJjoWYZ7ygjIcqP6hw4YMd1iBNAv9fylfaJyNMsrSp5e
 lKqeuU6dELu01iUNwZTlyO5nhJH4VdPZ7FZjZwr1QSBxjmzmfUrN20hcCAzUi1rQGJi5
 uuAHvyP+HAwKnYu8tHYyo5kUqTDHM7TVWbzqEyurivZLb3YT5SAHABin51Tn0NCsXmRU
 lQ+g==
X-Gm-Message-State: AOJu0YwQHPGISFcdpxcjC7FuNY5+33MBXWIbi1GkNjqSOysmdBHXL8X5
 JAdY/AGYr0utDT6SyU3LsBkQzWNJRHD4tU9LHXsTYRNfZbBusFVbsF1d8oSgBVVjDH7KoxjcIsb
 9Wl9upmsMEcZdLRQepxtinMOHpIXTtolq3JwHV+8DSik1QYs=
X-Gm-Gg: ASbGnctLk6+z+mldZOmDoP3s1YkAammjr3ppbBeXznqjCMCpSTRSk/QYaSg3gG+Davy
 tHi4EdA/NcHhQU8RToJVGdS2Dfoi/VnBf
X-Google-Smtp-Source: AGHT+IE5BXi1QCQhNbzF5w3ou/fHl9Hcs7o8OdD6fYpkiVerbHv0qFSifV4LlatO/xvzAiSbOGJRCyPw6+X1lvlU5U8=
X-Received: by 2002:a17:90b:33cd:b0:2ee:a04b:92ce with SMTP id
 98e67ed59e1d1-2ef01270000mr4468565a91.32.1733255203718; Tue, 03 Dec 2024
 11:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-21-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-21-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:56 -0700
Message-ID: <CAFLszThjjderVnpxf9rGcKL2MoOHnK+uceGTicR2em-opjaV-g@mail.gmail.com>
Subject: Re: [PATCH v3 20/25] image: Drop unused status_led.h header file
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Raymond Mao <raymond.mao@linaro.org>
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

On Sat, 2 Nov 2024 at 18:38, Simon Glass <sjg@chromium.org> wrote:
>
> This header file is not used, so drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  boot/image.c | 4 ----
>  1 file changed, 4 deletions(-)
>

Applied to ci/master, thanks!
