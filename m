Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A75C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD63888E7;
	Mon, 15 Jul 2024 15:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aKeRpZgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D5F888E7; Mon, 15 Jul 2024 15:31:42 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77872888EF
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b772455ab4so7777776d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050297; x=1721655097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rZ6to/UUv9BffnNW/Z7GYvBoi8wICAFg+28H1Dl8VsE=;
 b=aKeRpZgUr9V6MYP/0QLkvYYMjze8vnXK4s4Z9bEnlmrDpaeEHe9byd6PXw3s3zMOyf
 jNYlg4eJtKcMW1nyXkBfKDwANWeK9gAAE3YFWhaEO6BWhlaYo4JY6JgUlFQWBdVoqqFY
 boWhUoTp3aPep6JU6JdrRK0gG9JeWmlN7a2fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050297; x=1721655097;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZ6to/UUv9BffnNW/Z7GYvBoi8wICAFg+28H1Dl8VsE=;
 b=vnv4PxoT8a4HbLABrkQJ7aeFmelyOkM4U4pdlVwVGEM4SJeYJBCpv7NWMVlrKsAsBq
 mG5vHHicRadvXC4vqkUMnjDxNR4lwhuophpppYRrvlsCWLUOB73DcWvaDeEtcPTP7CFA
 nZNQivElb7M3oGUsHewr0nSTZoY2oiBycSsc69k0dddFt5LagIYn4dDMHK+kYBS8YOVq
 7iySHAwrivOajcNkH29uv3jFbwCLCTKgq09IFgDRwLaS0CtsTTkMK49BtHuocE30A9g4
 zLmCKlHSeJUYqpqz7hK1ATTg7rmyejpPb46HRjnTz/tGxWLJc7+YYiCV4x7mMZqqi9aJ
 OArw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTENyM1rdvhCnNdrTKGx4XrelL1UFML+N/e+CVhzXHJ/yiW1zcEdkv9yhdGTzoUec7nQaTSDi6IOOMmWbVCfkZ9Pwp7Q==
X-Gm-Message-State: AOJu0Yylzvy0lbszp3JN3bXAkObAjo3TfhFw2LvIiaXFL3WpDMau1K2L
 fdjEDM5FtB26wHbPWNH3ouU/Ta/6TCWTHXhaqsN2tzFnMKeVNseoOoIPgiV9fK5czIZvnmpVwCq
 5oK00ALKsMMGb/dBgZb3I7DZBqudsjupapJzR
X-Google-Smtp-Source: AGHT+IGa692kd4PZJMKD8fjVxeBh1GKv9czlnv4VlCp0NGMfJApYW/xhlb0K3aNpeXELbA9MtMWBlaNavM7UX6fHJ3w=
X-Received: by 2002:a0c:c305:0:b0:6b2:a68e:6cf5 with SMTP id
 6a1803df08f44-6b754b6abf3mr151010516d6.5.1721050297400; Mon, 15 Jul 2024
 06:31:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 09:31:36 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-6-sjg@chromium.org>
References: <20240623175515.1466908-6-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 09:31:36 -0400
X-Google-Sender-Auth: rTlX82W_FzIA5ETTfIDx3ILJ7Mk
Message-ID: <CAFLszTj+-mRNRSE8S-ohuX9KvbWg+0AyzkchV_Buc1hPLJQDWA@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] binman: Support an assumed size for missing
 binaries
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
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

Binman has a the useful feature of handling missing external blobs
gracefully, including allowing them to be missing, deciding whether the
resulting image is functional or not and faking blobs when this is
necessary for particular tools (e.g. mkimage).

This feature is widely used in CI. One drawback is that if U-Boot grows
too large to fit along with the required blobs, then this is not
discovered until someone does a 'real' build which includes the blobs.

Add a 'assume-size' property to entries to allow Binman to reserve a
given size for missing external blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/binman.rst                  |  7 ++++++
 tools/binman/entry.py                    |  1 +
 tools/binman/etype/blob.py               |  7 +++++-
 tools/binman/ftest.py                    | 28 ++++++++++++++++++++++++
 tools/binman/test/326_assume_size.dts    | 16 ++++++++++++++
 tools/binman/test/327_assume_size_ok.dts | 16 ++++++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/326_assume_size.dts
 create mode 100644 tools/binman/test/327_assume_size_ok.dts

Applied to u-boot-dm, thanks!
