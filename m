Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92BC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0842A888D1;
	Mon, 29 Jul 2024 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HR9Jd2U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EBB88884; Mon, 29 Jul 2024 18:19:35 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C85888A4
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7a8cada97so17292976d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269971; x=1722874771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Su5nRjwEV8BEysiAdJsnDV/LR2UKd90a+zszCOsPME4=;
 b=HR9Jd2U1cID/yB9iWB2l8ykdTo8LbFdCT9CNBHoboRI/pOhLX+WUjCTCqcrsgTPsOV
 0xi+cZky3s81jE2HvmAFXqpRWDvN5GkXIa9g2o83UkzY/WnoKSE8u/KTIHr5JK8WDv6G
 15JMKJ9BrHphRBNYqLuVQs6xj76bOLEjTToxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269971; x=1722874771;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Su5nRjwEV8BEysiAdJsnDV/LR2UKd90a+zszCOsPME4=;
 b=MWrO9mw/6+48WwhQ9sovJUY5eTMf0FuJM0Zc5Mpng2UsC0VIEZlnspzrTH4cqmnB2E
 qEEoU12iar11Fx1cgJ3WvB+8cPJRKkdt8Z6xnuBaLaIbFoTBZMls7OYBjK/H7vjXdk6L
 JpBp/XPDXyE0AQxVS1QUa+i19E0WwwBMzRY5Cjh2pAErQSfTgmhuCEGQBjz8tvTmGzkW
 vO3VEbtRdbyBMrzza1X8hhP5uzT0rZtj7S2nN9WJGqJCRSTdmteMRu30eTcKFDro7xeD
 3SIPzUl5j00IPwO3l9MjsXF5+jRgGUTedjwdMZCSJoR3btbI1l6xxeRzqWgEkJ2ZeQSH
 qlSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJl83Goh2da8+n5P7pK+spSS02KIdQU81H4hYBjKtmopXLmLMNdk92TX6gX/l9B3OJFB0CPQk8YzbRnY+thhx3OGUhhA==
X-Gm-Message-State: AOJu0YzZN4bUKMGbHM+c+OLTzjr7A6sZ7nlZ+LXkwSrEog1CUPUxHxbU
 qvxJSVfHlmqCsAQC8Mez3nf+tiWZKXhnSKnQcfC9xSzbZddEvRkiJ8wCah9xNxfXOQcZs78gHD9
 JH2VHdGP1H1YrLmW/Fla+0iTUlUKgIGHTDTZD
X-Google-Smtp-Source: AGHT+IGX8KLHvU/ISLpV+y/Q4VhtX3GCqAZSeg7oWPSo85lw3XD8uzcuIOrccfmq+8fcdO2kvkIK/PUtAARxYEvnxjw=
X-Received: by 2002:a05:6214:2b0d:b0:6b5:4aa9:9682 with SMTP id
 6a1803df08f44-6bb55af91fcmr97062916d6.41.1722269971666; Mon, 29 Jul 2024
 09:19:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:31 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-10-sjg@chromium.org>
References: <20240720104950.2730773-10-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:31 -0700
X-Google-Sender-Auth: -TVocHmspTyW1EabI2cu842vano
Message-ID: <CAFLszTiDDC1XYu=zo67Fu1j6pFftbdGX-x8CntZk3=hF=JgX_Q@mail.gmail.com>
Subject: Re: [PATCH 09/20] binman: Mention expanded entries in u-boot-vpl
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
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

Add a comment about this entry type being expanded, to match the comment
for SPL and TPL. Drop an unwanted line in the SPL and TPL docs while
here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst               | 11 +++++------
 tools/binman/etype/u_boot_spl_nodtb.py |  2 --
 tools/binman/etype/u_boot_tpl_nodtb.py |  2 --
 tools/binman/etype/u_boot_vpl.py       |  3 +++
 tools/binman/etype/u_boot_vpl_nodtb.py |  4 ++--
 5 files changed, 10 insertions(+), 12 deletions(-)

Applied to u-boot-dm, thanks!
