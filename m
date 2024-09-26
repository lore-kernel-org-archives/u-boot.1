Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0109CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A0788F3C;
	Fri, 27 Sep 2024 00:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yec4AzDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D7B88F41; Fri, 27 Sep 2024 00:07:24 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7E788F30
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e06fade5eeso1245276a91.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388440; x=1727993240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o1F5dHBisYC0X9HBAtotNLYSQrixm46XtNJgNUur3Hc=;
 b=Yec4AzDJGV/nU1NidtSbnl1UAJeEWvp/IB1SuAgE6ubWzuoPrkEkYGNHebHkTqoQGq
 d6GIE0GT3JYoI2T/A4pes5JQk7FCGTcwt7mWqdP9GmkyGT0WBLoqAS6DS3PrO5n7qjou
 Ur9RNQ3hr2mSEoffr6npScpTW8lAvbJsnaF2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388440; x=1727993240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1F5dHBisYC0X9HBAtotNLYSQrixm46XtNJgNUur3Hc=;
 b=otoZlmg13WbP6d0RQkHHQpj62jkmupOXiMN/tVwUH6Z4iR6OettgLNSeJ+UnwR5Mao
 nXqNSVw7dy1ZUGTlHQT22DAGxY/j+TPVYykfgkRbt5AWp/aAxVDk23+NkdNQtwGF0lXk
 wIgu4iVXvMRzgQFcJNZqBtqRfSZ6OPrCFwO2eBh5VhpAZHwGyeRBNHVcOU8qCARmtLnb
 8Bm3SZ41zobpLlKRE3uTYqUTbKXKXPM9umOWDpV2c/Jkizgk8ojKkDEp4ywG0xBZMZe9
 cwrdmyfhgGbT+3FelWEBoFOoHfrFs4iZtSNOr6BkJzYhlGJYIQ3hN/1KrWrSQzTJxLIE
 C39w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2j4naz1LjIg953RsDcqqDdb69K1E0NMqVIJCB6sxjI0i4aNNvVI1+ruBnaeAmTbecvODILIY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4HeUpnURbwFItlOxPsF7vid/AEr1VvMLu2CluwBaa4IVPzXDw
 3HrX1E7Va75+o7mIbZAT1kUUIz1YN1MxBksrKE4KBTjOqycGcahYRl9sDblIGSBBN6EmRKX6irr
 NRbWtoHQEbxIiFlaNNDux5k+pXZIpaRs9mhte
X-Google-Smtp-Source: AGHT+IHFwfZn/dUTCVVHWLJv8Sqs01RdponL0uWgENzA4V7f5tcmJ7P6YC+KpSA9NkqmnK8/TuGOhlTRi77JP7KAe9w=
X-Received: by 2002:a17:90a:d381:b0:2cb:4c32:a7e4 with SMTP id
 98e67ed59e1d1-2e0b89f9cecmr1291633a91.15.1727388440396; Thu, 26 Sep 2024
 15:07:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 18:07:18 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-13-sjg@chromium.org>
References: <20240826191143.426387-13-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 18:07:18 -0400
X-Google-Sender-Auth: HTpIMD7Ce0I6gdfiwmU0qt4JcYI
Message-ID: <CAFLszTiVtC-k4m8KsGEXWGArh3xfhsCse5nO2Wtu+RS+JoO7eQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] binman: Provide a way to set the symbol base address
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

The base address of the ELF containing symbols is normally added to
any symbols written, so that the value points to the correct address in
memory when everything is loaded. When the binary resides on disk, a
different offset may be needed, typically 0. Provide a way to specify
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst                       | 15 ++++++++
 tools/binman/elf.py                           |  7 ++--
 tools/binman/entry.py                         |  8 ++++-
 tools/binman/etype/blob_phase.py              |  5 +++
 tools/binman/ftest.py                         | 35 ++++++++++++++++---
 tools/binman/test/336_symbols_base.dts        | 23 ++++++++++++
 tools/binman/test/337_symbols_base_expand.dts | 24 +++++++++++++
 7 files changed, 110 insertions(+), 7 deletions(-)
 create mode 100644 tools/binman/test/336_symbols_base.dts
 create mode 100644 tools/binman/test/337_symbols_base_expand.dts

Applied to u-boot-dm/next, thanks!
