Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58005E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6267A89541;
	Thu,  5 Dec 2024 20:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IWnJOt3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC478955E; Thu,  5 Dec 2024 20:55:33 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C98989274
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so2119600a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428531; x=1734033331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VFLTKgbY0/zEzxUp1l50N2Vj0+WtmUNt2+0/ozLWgo=;
 b=IWnJOt3hKKLUTFFcKNR6r9hq7pVSEpG7bOb/uRwKj7FxyuoiF2c+OXBK7gQSPTJxEK
 xbRnsbGqFwDXA5Z0pgJlZWAra1f6zEqulrBWJV/CUQiuBPM76jLXRvL7lG5R23swnjAn
 qun5bJUh5rGmeAuVUPJ9gBSnl8aT1Ap76E8NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428531; x=1734033331;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8VFLTKgbY0/zEzxUp1l50N2Vj0+WtmUNt2+0/ozLWgo=;
 b=F4iBTJ7Rt3wgCfC7oYT9aY/grq4Gag/m6gXxofG+52Ys28yyE5I72u07RK9B/DjJUf
 eONG/k+0fjweqa2ym9obMGGAm6fVSp/Gaiq6HwYiXozo5ANWn/j8kbm3FCJCxyECFEaz
 bOcF/JdifOkb7YxHfCkn80ucU4AT1EYS+czP/BNyxpUjuG68nysdI6aAHft3SX2WgoWz
 LYNt4tNyrvYZ+YaKbT54gCjSrVVUwemn0Eaq3PNF1RI1j2MVKEqBt0p+5zVx2ETrJf4J
 1rq3cvf5OOCOYlAGXmR+pf5q4rBpOAW7AZohlJCszPKtJoPvE8KIgcWo2gpfhjBvELRv
 GJ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlzqAvzmxv0gZmWPrnkxs7M5jhW6XC8bUnU/+JA4gqa7zK8N12hXR2qsP0QycJdUP8LD+pyh8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywrn3GsoPGW4FZebWU8je/BwuvAfVTl6ceo+NF29wTt3+p0YrGn
 xJ7LaQEdvZ5Dlr+UkKBxXeuqhPTtA7jBKvV6wM7Eg1LyoSNQya5Pay7FbrYunVMrF57JYSNe8+e
 IkPwdvzL5GTi6aKlKn+pPQ8FAoby9PiF3kmjR
X-Gm-Gg: ASbGncv9T0V3biAPKSH4WxgrSVmEqIYwhV/STXrTSVg3qLL9jew0DuBe+pSB4Iy7mKP
 rKk/V7msjptz8JCm/5RMcP4TrhiHHD9XL
X-Google-Smtp-Source: AGHT+IEq22p+I22xM/baFvoggZnPYh6egCEIAUmKgPSe+5/ZhhEpeqrHlQH6ybYaSXolVQw0G+N70P3aSPHJ1Gm7Dcs=
X-Received: by 2002:a17:907:910d:b0:aa5:4800:37be with SMTP id
 a640c23a62f3a-aa63a0c2f49mr10797566b.32.1733428531140; Thu, 05 Dec 2024
 11:55:31 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:30 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-19-sjg@chromium.org>
References: <20241115231926.211999-19-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:30 -0600
X-Google-Sender-Auth: y3ZHHme3b47Zy6mEoIgNdIz92BA
Message-ID: <CAFLszThRFyC9mtM0kDFWUBFGB_ChauVQHQrpX6Q3VVHyEo2V_w@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] bootstd: Add the concept of an ad-hoc bootflow
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The normal situation with bootstd is that a bootflow is created from a
bootmeth. In some cases, a script or user-command may cause an image to
be loaded. To deal with this, add the concept of an ad-hoc bootflow.
This can be used to record information about manually loaded images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add a new patch supporting ad-hoc bootflows

 boot/bootstd-uclass.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 cmd/bootflow.c        |  5 +++--
 include/bootflow.h    |  3 ++-
 include/bootstd.h     | 19 +++++++++++++++++++
 4 files changed, 68 insertions(+), 3 deletions(-)

Applied to ci/master, thanks!
