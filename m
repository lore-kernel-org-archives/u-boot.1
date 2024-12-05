Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15574E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1BB89551;
	Thu,  5 Dec 2024 20:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NIB17i12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418BA89551; Thu,  5 Dec 2024 20:55:31 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258DA89549
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso260894066b.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428528; x=1734033328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IPyI0vhCGMwp1pTB1Q+tyV6qZDu2QABKT5jDEgpFwyo=;
 b=NIB17i120Th/ZbYBnVDKGTEs1nKoRNrEOa0vdaf1N+TKXruaUCA6XI3d4+cdB7X+Ou
 4hmuPy2ddnwUBjI92V8UWkY9qjH3+4+dB/zZPp3pTBVtdQrwBPWY9AOcY7a4Oi48phZI
 uMzecxSLJQZXZsgLEodf2keMqXTTP9PZjloAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428529; x=1734033329;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPyI0vhCGMwp1pTB1Q+tyV6qZDu2QABKT5jDEgpFwyo=;
 b=kj91NcljZYOEV3MVVrfLF5e+vjvPibKuP1hgFJyMzEGE37vu/5V0zlxDcRbdDoEmls
 o0Wx+9xCUa5RW/uut3CeLm51uTMldA77IudDcx3sJMMHcsixYurM1VO9bT/j+4mIESPc
 mrEJJXIYtKBSe84OK1jYN7RJIWasNjNyrlo8l9NpShk3OgZStvcJUG4WOxyNt/gFJ7bO
 OxGNtR8kSjmNHk8IUB7c6vFyraM4J+BJjeMWo79WIVCUXi/cZQsX2gRdqdxJpF0ZSTxR
 P3A1DQh1Sg7VBO1hjqtJp9IGvf8aoa5zNAhPiSBj9MyXXkKy1c2BidO4sI84NYpqeauP
 XhaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsM/fvZweS19GuVM/4eKh6g6Uky4QDYCr1DOTYmKhlT5Pop+pODxUPnYnUZEaCz7NbiqoE/fs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4Hzuu1HbkVel2k82UjJFcZul1vVCjxGo2OvH8OclSkcmqiPZ5
 8L9IfChgkRLzM7a9VIYGacMU6sRB7Fj0CgZfasBRcDL8nYfIKbpW3iZJFZY1fQJakYfLy52+ApS
 ujpV8EspRE92rmkieZ5X/zy3/Z5VPG/IbKsMK
X-Gm-Gg: ASbGnctmOCjlyH5l5gStJUXA0jeQzyr+kWhi25jsKSKpvdfKmj3sMaxauS7mdcPqdmS
 9+uD/Rx2784RXNZ2uoi4Rp/Em5DIx/nNL
X-Google-Smtp-Source: AGHT+IFINjv6lDwaB+W5ELYyCafQH6caTrCWevkMFP2blvhSog+rjyea+HuiMkCBGSIjNhTcoh3mxtmrm4r204h96Bo=
X-Received: by 2002:a17:906:5a6a:b0:aa6:2624:204 with SMTP id
 a640c23a62f3a-aa63a288c5dmr7275166b.61.1733428528696; Thu, 05 Dec 2024
 11:55:28 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:55:27 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-20-sjg@chromium.org>
References: <20241115231926.211999-20-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 11:55:27 -0800
X-Google-Sender-Auth: UXjbXy-L7QaAxrATGDzHZEyOfcI
Message-ID: <CAFLszThgb-y_-DyGeOfuq2Lj-WMFMmLdGgp0Yd4fTTXMoMr6_w@mail.gmail.com>
Subject: Re: [PATCH v4 19/19] fs: Record loaded files in an ad-hoc bootflow
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

This makes a start on dealing with images loaded outside the context of
bootstd. For now, it just records these images. They can be listed using
the 'bootstd images' command.

Often, very little is known about these images, but future work could
perhaps use the filename or contents to detect the type.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Rebase on top of -master (which now has bootflow_efi() test)

Changes in v3:
- Add new patch to record loaded files in an ad-hoc bootflow

Changes in v2:
- Drop patches already applied
- Drop patches which add new image types
- Update to use a new image-type enum in bootflow.h

 doc/develop/bootstd/overview.rst |  3 +++
 fs/fs.c                          | 15 +++++++++++++++
 test/boot/bootflow.c             | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

Applied to ci/master, thanks!
