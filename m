Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3214CC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0708887D;
	Mon, 29 Jul 2024 18:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KmQF0sU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1780888847; Mon, 29 Jul 2024 18:19:25 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD62A88829
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bb5a4668faso15130856d6.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269959; x=1722874759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Papr8Szkgj1ek12v7XLLh5bC5zeC4o6BnE92/gOELg0=;
 b=KmQF0sU3pv7k1Tz4zGohPkikwdD47PWBXfBjdN+HTn1PaxHGESLCvREjQVzRVo7aQC
 r1XNwIKIFQyTdOkbkl7a1f0N40Hz/l3RmbejkbGFb+mKsepaLkoXvPu0Eee5CIPY/m0I
 kD11ENVJwaDYLq154dwgtL2QtM56gXkBTdOXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269959; x=1722874759;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Papr8Szkgj1ek12v7XLLh5bC5zeC4o6BnE92/gOELg0=;
 b=h9iqmYcOHYXpFONvVPkDe3slaYml5FFpS3IEeBSrG6gt+9Z2J4QlojXDUQhaMy7mF3
 WvSI/BISk+c0D1BcXCfgDaFjiGZFiQO/m8k5L3Qy0Qz7mYVO1gixtGI76RS+X20E52D5
 Bhz6UNYIPJDC+Dlu9cI0+UjMY3hvhpE3ggVRyj0IPK48wNIlrdzY4XjrhhjqTSGiNmWu
 K0IAEFTKvulzkgLWz1t69eTrmhO7ZMSjYh8bx7Og8BXMqYBQGQ120qaCbqFWVFvmXfa0
 8ikZe0xF+GYmNJYqcf27dbUY4x09Lfn90Ke9mz6szYimpzw0PM5u8A9mAgFhbOczQIgO
 G7lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVgWzCFS7ttmZHw5VA6VIUDvQLArYoyN7O6TiG6hHM7hWtsIrOmAN1O+z6CT4gq1QHibfUiwpIiR5EDVIPgkXVAm+iJQ==
X-Gm-Message-State: AOJu0YyN9aneqQvT0hMasRhis9wBoXv9Eee7YWXuNEHIU4zd6mAIYvcD
 UfhETosVjUWbBXvTSqtHXT96VKoddXsfGCI8Xliqk2yKP+zDDntyRJTJ2S8aUr+DIUMBAgfmKE0
 vWeSz3edAJe53JdlHuc2yRYB56NKXW+4zPS72
X-Google-Smtp-Source: AGHT+IGRCD9CxN3ao6u+76syTTRJQ4Dvxx03WEppW3iNdNMnm52eBi2VT0FSAEoXH1JLyu3tdCU2AOzF1T+q2rVD7YQ=
X-Received: by 2002:a05:6214:1d06:b0:6b5:9576:a679 with SMTP id
 6a1803df08f44-6bb559f9411mr128701106d6.12.1722269959676; Mon, 29 Jul 2024
 09:19:19 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:19 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-19-sjg@chromium.org>
References: <20240720104950.2730773-19-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:19 -0700
X-Google-Sender-Auth: Is6ymXghvgt4-oKdm03mt20kEn8
Message-ID: <CAFLszTguQ6vwwQdDHinGUhk3_sB=701JafPh2FZJXWg9v4xLzw@mail.gmail.com>
Subject: Re: [PATCH 18/20] binman: fit: Allow running fdtgrep on devicetree
 blobs
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

When using FIT to load firmware builds for multiple models, the FIT must
include a common binary along with a number of devicetree blobs, one for
each model. This is the same mechanism as is used for loading an OS.

However, SPL builds do not normally use the full devicetree, but instead
a cut-down version which various nodes and properties removed.

Add a new fit,fdt-phase property to allow binman to produce these
devicetree blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/spl.rst                     |  2 +
 tools/binman/entries.rst                | 29 +++++++++++
 tools/binman/etype/fit.py               | 69 +++++++++++++++++++++++--
 tools/binman/ftest.py                   | 35 +++++++++++++
 tools/binman/main.py                    |  2 +
 tools/binman/test/335_fit_fdt_phase.dts | 61 ++++++++++++++++++++++
 6 files changed, 193 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/335_fit_fdt_phase.dts

Applied to u-boot-dm, thanks!
