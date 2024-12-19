Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A79EE77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DE580304;
	Thu, 19 Dec 2024 03:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FXajOpm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D724080291; Thu, 19 Dec 2024 03:43:41 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C248021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a68480164so48274566b.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576219; x=1735181019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EOT3VouGGeaq/IcWEqf28rS0g6b+yCbTIyh/MyuARx8=;
 b=FXajOpm2f/2BYogqU77bc6DiOVicS72VlixcUybaRLtYCh+JFHJuLeU1ZCLAEO0Rur
 ENKQtpsHX4ipgRZYFSDZDb2j5Vli2mxxS4Wl8m9/SU9bZeXiTbQDItU3g98djwNq9ZWy
 P8hgoP222SiuTyPZN/I/6LSaqhJH+Jpx/PSmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576219; x=1735181019;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EOT3VouGGeaq/IcWEqf28rS0g6b+yCbTIyh/MyuARx8=;
 b=XfqI9gOWGxMbkByXpFOJeszL3Ld3NlzTpwHmHgwfPjlEPqTuPPp3gT9jYYLYpfQSMa
 qrOaUJULMROn3vs9x6XqHhIAgoOv2sIOMk0H9pRpBYtnM2GQVB5PMzy8UwmBY0Oxyih0
 QIn1GB/vBZhN1rRrFvtw+sm55Mb0v0OL4rRzBgVOp5jdAbT4U6Hhwlr1NKo1V3h2OssB
 M7UXG7KkU+xIUCn4+KUmBSCeuJLrzlpUd2qZAxTIpMSZ77CpZGRfXbRxIHcGRZGgKF6E
 UsyGtSsbnd97T8sdsyD+yn/L0c+hm+5DqsczzukzBzIcTyinvw2HRF9Mk5SXWMugeHqq
 lgqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGJVXwn0ToSm1ugrWOdXuUHHhJZxWkcg+wvPPDbTKb4C+bnyY1pr3acOgOLARIR4sqGs8MJ3E=@lists.denx.de
X-Gm-Message-State: AOJu0YzxW8PgPAIfaIlsvz8M/sJsjMe7iDf4ELex+3x1eZQfkQuaOY41
 feYXMjIOJ2l71E7hOA9Ao3BNgQXMLri8z1MiW4/QItrqiTnNRqlLXbF1ZfYeRiidG1HvtnMJO0x
 qOHR1ZtkrvU4o+VXerffefWnF1lNwui9Lpn+W
X-Gm-Gg: ASbGncsYDEbROS3h1cUBYw2jsI3EV0tX6ZYXHv/Zp5m143qZ3VGVdi/E4xPvvRW/U8c
 sGYwF9gZNNffi6VoehBJFkpBfWus8PQUdfyrvgkA=
X-Google-Smtp-Source: AGHT+IEO7JphhWu/qEszskzOVH373OnT8wmH/n4wuh60FAoSQHqDCezsQje59VMh2TeDni6pZHZ+zPYD1uFKFN8qC40=
X-Received: by 2002:a17:907:608f:b0:aa6:ab70:4a7d with SMTP id
 a640c23a62f3a-aabf49543c6mr466756566b.58.1734576219374; Wed, 18 Dec 2024
 18:43:39 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:38 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-8-sjg@chromium.org>
References: <20241211223822.2446254-8-sjg@chromium.org>
 <20241211223822.2446254-1-sjg@chromium.org>
Date: Wed, 18 Dec 2024 18:43:38 -0800
X-Google-Sender-Auth: KOHCNYMQBhihrCpGmE6Z0N14ovw
Message-ID: <CAFLszTjpatvUpO1hbGFhBtaTzqygMkTKO+6QGQWihw7V4HGzKQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] bootmeth_efi: Support PXE booting
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
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

Finish off the implementation so it is possible to boot an EFI app over
a network.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to support PXE booting

 boot/bootmeth_efi.c          | 15 +--------------
 lib/efi_loader/efi_bootbin.c |  5 ++++-
 2 files changed, 5 insertions(+), 15 deletions(-)

Applied to sjg/master, thanks!
