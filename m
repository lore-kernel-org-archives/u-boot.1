Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0700EC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 20:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABD582AB2;
	Sat,  5 Apr 2025 22:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cMHzRxYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417E982B19; Sat,  5 Apr 2025 22:46:50 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4295B82AAF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so507438866b.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743886008; x=1744490808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tZnZmb3xZhcuXD4a24A+FEKEzrvn8Z3T78rwfZ71Rk8=;
 b=cMHzRxYl/X3BL5Px85i3k7C1jJDBDorOVOoL12N2gd+kRRlgzOZ6AKDP6jn0nhAZFI
 FfTJ3Zh+mAeQsm/j1b6/ElXYtgTparoaZy3+8RgTWakkr+k9NgWh02VfbaLuDofBFfEX
 jfLS5o4p4wxeKxltkBHc8/eZg8s3hN+HUobNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743886008; x=1744490808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZnZmb3xZhcuXD4a24A+FEKEzrvn8Z3T78rwfZ71Rk8=;
 b=IuMG5Sltg7UowuOdCJYluz/hIm8xngYIPDuXhimYBqWvsPdway9Yhatuia1x+YdwbE
 cIXSnmXpQKIfFwfRwqPUxEqmrf2wyy1otJ4MaCm2gaU4GRm6S7dHq43scVikgQWiUtou
 INImBwi1FAR9j3InAj4qLdnRZtp0v74ryELkqVhDzEXF3VOvN3djNAcv07Tl7gRXODAK
 3Y3Fj99ScvN3QIzc0RMeZuSABS9GRhh70VQXdsnT5ddoZo8nHHf82VSkUZTkV++rMLw8
 LulrmXXJ9AXPYX1w1wdiUbN1MdjgHnfQOPxKnaWIJe5v7XtIjxic62wB8V4yf5K791VV
 a09g==
X-Gm-Message-State: AOJu0YzMAvlWvth+8CjmipDGJSOx4g6Paph51eV6C16Jdqc6f3zcEk8Z
 jOaIn68dOVJPx6HNez1tnOuViw/ojRGOrQsthKvwZ6qTjYE4BNwblawmPSC5n9KPuN8kTNoJUeo
 WZi9m7zAuLko/+jz8pljkA2cZaveYP6UupXJo
X-Gm-Gg: ASbGncvKxguXUqPbZ3xsqwOdjP3vfr6MjMfjKmF9VEwVzAGdh4serC+mtloEGlxhXfA
 csSZBuWPIxCRlsOnXKcSA53CR1D9CBO19ntI1fW03nED4Ew4h/AETgyIbB8oC5BWEIdDijTOpj1
 qL3GD5natbG+w5e0ISb07P2yXe272y
X-Google-Smtp-Source: AGHT+IE5QpnVfJNiSK9RvtrSZGxt1QxktMO13Q4fXKlHhfJWlFhLHKYmnTrkKf0MrN9yO/gJJjqQnTskslSfgUyJA/o=
X-Received: by 2002:a17:907:7254:b0:ac3:154e:1386 with SMTP id
 a640c23a62f3a-ac7d6c9f3a3mr560962866b.6.1743886007610; Sat, 05 Apr 2025
 13:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250405190600.24081-1-hs@denx.de>
 <20250405190600.24081-7-hs@denx.de>
In-Reply-To: <20250405190600.24081-7-hs@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 6 Apr 2025 08:46:34 +1200
X-Gm-Features: ATxdqUG9nDHyprN4kbejbI-piCuMpIJwJ0eh5WqGlLHT_xZMdOj6j7zroOuyA-U
Message-ID: <CAFLszTjJTCGYVxynLu0u9tXRZ4BBNS-3DuMn8ScA-uG9RwrHnQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] [RFC] CI: add U-Boot testing on real HW with tbot
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heiko Schocher <hs@nabladev.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Heiko,

On Sun, 6 Apr 2025 at 07:06, Heiko Schocher <hs@denx.de> wrote:
>
> From: Heiko Schocher <hs@nabladev.com>
>
> add U-Boot tests on real hardware with tbot, which is started
> from gitlab CI (no idea where it runs).
>
> Currently one board is implemented (imx8qxp based cxg3 board).
>
> This is a good example, as we need to get some binary blobs
> for the build to get a working bootloader binary. This blobs
> are stored in the tftp directory on the lab host, to which the
> hardware is connected to. Tbot copies them from the lab host
> to the CI host.
>
> After build has finished, tbot copies the resulting bootloader
> binaries to the lab host where with, the help of USB SDP bootmode
> and uuu tool, the new flash.bin image is booted, and with USB
> fastboot mode flashed into the emmc. After that worked, bootmode
> is switched to emmc and the new flash.bin gets bootet (and tbot
> checks the bootmode output, so we can be sure, that really the
> new image boots from the correct bootdevice). A simple tbot
> testcase for a ping over ethernet is done and ut command is called.
>
> After that the test/py framework is started (from the CI host),
> no external scripts are necessary for this, as all "scripts"
> needed for this framework are created from tbot at runtime.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---

Thanks for sending this! I hope it will help with Tom's setup and get
some of his boards into CI.

Regards,
Simon
