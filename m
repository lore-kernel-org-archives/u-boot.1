Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C086C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41444877EC;
	Mon,  1 Jan 2024 17:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AXmnB5IB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B511586FFD; Mon,  1 Jan 2024 17:49:27 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22E087084
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-680a06cc763so19155016d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127762; x=1704732562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qnGWD1mBMYk6uYv+LqAqKYHc242AzgyXQyUGf/PpIvw=;
 b=AXmnB5IB2/DH7XXojx+uxKJ3/5gXXnfWNJs9Ri4NkN/wLy6ojLjLNZQu6jrKCb8W6f
 5dPYIzJl4WEQ6/CiWYmSqdL7xuSFYyIewpX2rIBE74NZbGHh1bI0OgP4w9ZZ4wd2hDqC
 dLH6wKFbMGd/aMZNydrQjb0CF1gbYouXGQSHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127762; x=1704732562;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qnGWD1mBMYk6uYv+LqAqKYHc242AzgyXQyUGf/PpIvw=;
 b=nI8JTWps9XWu2KtqieT/wSHuyvYBJEMotIIwOF58N6mKERMHoB2/Wt92tfjeMnAbm/
 Mr0JA+KksyvRh78A7epiCqafBXh2rmWkRyjkG0Kk3TL02R4NziOK7qPTIoqFm+iulTs0
 HGYYuPcQOB24Msi8B+69YlPVh9u4AN0FtxQPTegEeSU4xEDIkVqkoxFObIv1FO4izOCh
 ztMFX1oieJ1Ml6In4tdaRJ2zbv/49e4CKF6KyycI/zo3cTA7Zfom6wCt0DcrPom4O8RG
 H7U3DkLbf1Obw5rJ498Hzy0jWnjIQTS1F55F/YhjPjPkEXmuJS+rdCxo8Gn6xcdW5/nq
 B0HA==
X-Gm-Message-State: AOJu0Yxb/BoVv77g6xNuIQsdRV2jE6BQrUF1pgg2QSqQqe+hBSqVAAhN
 HSdu2Q6/fR7OLbLZozAh8XKt1gV5pPodXPRdNzf2qXx9sYiF
X-Google-Smtp-Source: AGHT+IEbhyhCnPaluUFi6Be7L44dW9wUW3IeQiC3EVeM0iT+qAxapTdCK83IjRqqtPUH6G6/aLfnNP7bkCCiRINF6Po=
X-Received: by 2002:a05:6214:20cd:b0:67f:666b:ada2 with SMTP id
 13-20020a05621420cd00b0067f666bada2mr29454641qve.28.1704127761734; Mon, 01
 Jan 2024 08:49:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:21 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-9-sjg@chromium.org>
References: <20231217163627.2339802-9-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:21 -0500
X-Google-Sender-Auth: 8Cgi7GZsnK-f90mbH-PCiVEP6qw
Message-ID: <CAFLszTjjwfqvqhLA0bKJc5B+o4Gns-tZBbe-XviW_D+pUjqaMw@mail.gmail.com>
Subject: Re: [PATCH 08/10] sandbox: Correct SPL condition for building
 devicetree
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

With sandbox, CONFIG_SANDBOX is y so the current rule ends up building
the devicetree for only those SPL builds where it is unwanted.

Correct the condition. This allows sandbox_vpl to produce a
u-boot-vpl.dtb file.

Fixes: e7fb789612e ("sandbox: Remove OF_HOSTFILE")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/Makefile.spl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
