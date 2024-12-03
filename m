Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AF1E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F78896A2;
	Tue,  3 Dec 2024 20:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dUx8LABu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8685C896BA; Tue,  3 Dec 2024 20:39:54 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9514688FAF
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so856736566b.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254792; x=1733859592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e6Tq8hjeyvl5BaLpBpLXJXJ5VSa8U7wJwPtSLuHrLmM=;
 b=dUx8LABurbFxDezawugQNnUgtKlqRbw5QjJyyb1WZC6EbMUGYxzc+/RNqLi6NbbiRo
 /UvYPKmk+D9aJwkNMNLg3oDiAkHQNTl+drz7wx3yygLHs69zV7LJcRWNLhBe0fPiQ79a
 o2wvSPXVpPQ2rdeRgT4obIml/uC/ec3c4W/ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254792; x=1733859592;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6Tq8hjeyvl5BaLpBpLXJXJ5VSa8U7wJwPtSLuHrLmM=;
 b=nRxYPEk6i+fwjH6H9lQL56U7Mm5hjD/U4b0By7VtVqQwV7YbVq0ekoOzvDO42Ch6DC
 s+KHUI4+blAToikwmmSsUXiKI814AaHAu3jAePoONVsRfZ2kDl4xxSOrXnOetpQ9vhC1
 Zf2mpyp84i8/36WWDeIO+DDNTk/czSqtOCyJN6jpdYs87qh+BR0QRrfX++l+RZjHkz1b
 8b8Z1Re1iTaTCKuM46HMOGj+r2VSP6eq5v6162+B8/qpTaRb2tPyMq2ijO1LpQc5wtTo
 6v6DgNyBtfzl5al8p9C+EDrqt7XlHSwvMQivZ8DAYwJtiHna+PVMqsP6uoOPCKGcphnt
 lbuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRneEfcBo4CQrQrxUNyG3z7YhZwf5TW414dpnPTY1wHSTuMz0X+5OcQyxI9pMFpCeqpyBOftY=@lists.denx.de
X-Gm-Message-State: AOJu0YyHGBJNZUaD2g+d7ergArEG0L9vdAAHEtEVVCRQgoHdLHAkcHpk
 h6dpnQ53d4sd/ZPynLMB8Hy9fuzunKUJjqMJpvtQMhwgEu+4l5uTU54qldIY8JU7oinMCLIn9LW
 FDiDgWjOpLO6S6R7oRIu7XcD3+6YgjvY1RhUk
X-Gm-Gg: ASbGnct39SbiFGT13cxX0nLP+EFeaat5FTWnjs9IPckNxD8zRVHivNsLq1h9m2seQhq
 jnbiRuRYEUxIeyS/OhZM4i07Jf7IaQ9Tf
X-Google-Smtp-Source: AGHT+IGIbxpmg4oBqOuIqMv0dZWSoUeZDdTLdqc4VsOXylAU7peMNYXtoQO1DvN8a5o2spVpGEenjzyhc9kI474w2UM=
X-Received: by 2002:a17:906:9c9:b0:aa5:1585:ebbf with SMTP id
 a640c23a62f3a-aa5f7d4edbbmr228384366b.21.1733254792038; Tue, 03 Dec 2024
 11:39:52 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:50 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-12-sjg@chromium.org>
References: <20241103003322.626036-12-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:49 +0000
X-Google-Sender-Auth: iAjDPn5Kx0-cm13c5dJDzORQwLQ
Message-ID: <CAFLszTiu3+4zCPem8Hu-WA+8xqANGGxQn6piyvkwMpShyJvChw@mail.gmail.com>
Subject: Re: [PATCH v3 11/25] led: Drop the legacy LED command
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
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

This is not used by any board. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Makefile     |   1 -
 cmd/legacy_led.c | 145 -----------------------------------------------
 2 files changed, 146 deletions(-)
 delete mode 100644 cmd/legacy_led.c

Applied to ci/master, thanks!
