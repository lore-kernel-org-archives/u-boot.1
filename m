Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7518E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7607E80295;
	Tue, 17 Dec 2024 20:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k8aCmpnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6311F80295; Tue, 17 Dec 2024 20:47:21 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492E780315
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso948811066b.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464839; x=1735069639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tjlz8riCKcjLIQL23EW/bAxGk5rLyil+G2Cgj4va8tM=;
 b=k8aCmpnbvP4DwsN/CLc7NeuXSzHuq0oUvZduox2NhOittls1rUKbp8oiIVq7+EuoIl
 XUx2YJUQTscQTujVDChDy00J8IkdOU6R6ZKXa/KUKMTlPN9j0lVafY2qyLU8GjQHaZaE
 UfqDxniUX8TSf+N4C1qbjSFRQBXNRMXbyBkMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464839; x=1735069639;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjlz8riCKcjLIQL23EW/bAxGk5rLyil+G2Cgj4va8tM=;
 b=mbYVuDWYJ9ORmKkUTF4MzZjLo2jfFKuIHVVPN1bBuzSlvsJpz0ONiW7/Dk2sSFp4mj
 S2IkIFQFWuOsTvz7987twaDIGzIxBkcr89uGiJJKAu+6Fr00qKdjOAF99JVUsfJMmtNV
 Ks5CQNmB9ErIvNEC0K9p552AULarT2R3Oo27tMJl81wavQQA3WcHsaH09SK9h0FbfNuz
 qKz/NTSA8crYjEsiQ/oBWgMGkp9K7HJGkDlQOL54I2tCZCA7QdcfImgMsTs94dBp+vrX
 78M7iBs0jGZH2o3ENxJI1d4S6/owmebbzYhtBcBp0WBnTLxcUTw7XrL8H/zkesfAiWyo
 piMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOexaThx6DUCUmNxp59Pi8hddsB3FQBPNyHBxzcmRD5OL2mjHI1XGubX6IEOI9+4qd23u7dt0=@lists.denx.de
X-Gm-Message-State: AOJu0YzBfJAYS9A4uvhpYF56kxJJgAO+PhvcHSjGUZyTOQR0uFCyYC0r
 TOI42JKnenME5Gre235v6Xmn7l6wD3mW5c+0vUxQL/rlphs7SxeCsDoqhvj9aGTesRun2R1OlqQ
 v5WOx9P/Dsg76/aT/QIfWhU17pG+U5oc2Gwn/
X-Gm-Gg: ASbGncvgwlebRuR7ti8NFHxvTnBptZj7oT76gPfoAiwTtnVbZkX0Yh0HYmuYeXnhIvl
 XVj/qlrrZNEmJ+BaDicy7/ClsvBQ4nxt9x5oby8A=
X-Google-Smtp-Source: AGHT+IFbGNEeONvPU6ImsZZFgqeeiJ93gvgozDtl3H22FVconUYghTHXfqz/EU2z7yuz/Tnd/hkDTi1ETARlM9kyUxo=
X-Received: by 2002:a17:907:72c6:b0:aa5:2a57:1779 with SMTP id
 a640c23a62f3a-aab77eecc9cmr1870940166b.59.1734464838843; Tue, 17 Dec 2024
 11:47:18 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:15 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-18-sjg@chromium.org>
References: <20241211135418.563803-18-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:15 -0800
X-Google-Sender-Auth: HgCPR0IKIbO2hpufggGs2hiUnCI
Message-ID: <CAFLszTiOuxYcfE82SJkoBtc4CX4Vu3bOLJ=FYPh8HKnQCboh3Q@mail.gmail.com>
Subject: Re: [PATCH v5 17/23] efi_loader: Show the address for pool allocations
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>, 
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

When logging pool allocations, show the address of the pointer, not the
pointer itself. This makes it easier to debug with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to show the address for pool allocations

 lib/efi_loader/efi_boottime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
