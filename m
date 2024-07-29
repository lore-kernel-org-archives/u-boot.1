Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0EDC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE17D88908;
	Mon, 29 Jul 2024 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YrSJs0jY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68FD8882D; Mon, 29 Jul 2024 18:19:37 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DF688861
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e0b10e8b6b7so2353486276.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269974; x=1722874774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hxI6lnwxZEwbYJU2Z3X1zY7n40SnqkZi0M3gK4/KhRM=;
 b=YrSJs0jYPc/h6d1gRZsoThm9XFa6oNl2zuIjIMjrRDwSI7xpKPB9ohpL/JSZBIKbuR
 rBV38k+JAZJTdFwHm6jhudDZHXLoLc1rp4gqBL1D8Vi2k89e/hgzl8y4gKeExLuchHm3
 WQL+/fLtIYlg0ogKtXz5ZrJqaZ0Zv8AvEpbCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269974; x=1722874774;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxI6lnwxZEwbYJU2Z3X1zY7n40SnqkZi0M3gK4/KhRM=;
 b=C4ejcY2D0mSVqg7Hrnuk9d/6f+CgGPUc8AlIgDwSOySvov9MGIBqTDRIMJiOt3xnY7
 4Vdm+TJl4brwmeG7SX20qX0eGmsMK0LxcX4Xav7wFQxKKsQqbkEb+ZB6y3HEXERAiL8Q
 1vj03NzF2WLgnl7ut8VzXKb2BD99fDVnirkwzJWotVGU+y2ybKqINPy80TB5mPiVCKb5
 XUM0LpocgzoKxQtl0ec35tQRqho7pYN3cTWr6UJfPCva0xVpnA+FqXjWrCP1M1GvCxx8
 jFCXXTdCGZOYJhihGDSDBbAht5ErO6bzx50nyv7kQArdtXPtD/Uslr2hRlp6Zwoy+y/+
 fSIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcvyDZWbmzUtP9HrqIBqFFKxBaif3uFk/krE2HZQg4ZBMZiZeYaaKljFJSZBBkBNumj2kastOSbz8ErXteu4AW5n1ghA==
X-Gm-Message-State: AOJu0YwxGlkbMAsEUdahYDx0MZCSmDw7z9tZgfQzgHjZosvHTXgG5iL/
 P3LmHrDi8up0SaLDcCBxgDOso6hxDKLsSvzEx9L/dhnA8643uXFwHROCX0dE64nfm2H1OwJWDk1
 b7QfLDoGpq/r4SfDU2M1oDK7QpUxlYexhbFWu
X-Google-Smtp-Source: AGHT+IHjoCXEulocnrTPGzPULnGGbSF3I0WmLM8MP1nwAPWEaDwzcUr33So8e/W29pcpfDnebmH+Y9d5YyAlAcxDii0=
X-Received: by 2002:a05:6902:c08:b0:e06:1bd:976 with SMTP id
 3f1490d57ef6-e0b5446aeefmr10635030276.22.1722269974456; Mon, 29 Jul 2024
 09:19:34 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-8-sjg@chromium.org>
References: <20240720104950.2730773-8-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:34 -0700
X-Google-Sender-Auth: NNztCmI5VZxdqY12d_4SESI8Xhs
Message-ID: <CAFLszTjW6fEr5fScvesY7_mnntp1UU-t4pMWGaqQnzS8YOMibg@mail.gmail.com>
Subject: Re: [PATCH 07/20] binman: Write the compressed output to a file
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

When an entry is compressed, write the compressed contents to a file so
that it is possible to see what was produced. This aids debugging with
new images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py | 3 +++
 1 file changed, 3 insertions(+)

Applied to u-boot-dm, thanks!
