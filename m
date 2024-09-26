Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1765CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6518888F94;
	Fri, 27 Sep 2024 00:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OxUhJ19C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E1088E04; Fri, 27 Sep 2024 00:07:47 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BCF188F41
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso1110582a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388463; x=1727993263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3M/HvuNcccnX+FfEEs7BZZeNtN2KRCT3dUgjC9djiKE=;
 b=OxUhJ19CrCVIqYPqPq7+wpiWqL0N2PnMQV07OFIyJHuA2fgFJ4cXJwfJJQigbpEdt0
 T86/HzYUMlOqSqEX2URSkEX5RX1UfnVCB/hwtw4X/d3f+iDO2nrlvoje6x6eIAfgaB08
 9qcEGE0HtCaDBou1u9jtyIKDGLvW8p2yLQEdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388463; x=1727993263;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3M/HvuNcccnX+FfEEs7BZZeNtN2KRCT3dUgjC9djiKE=;
 b=Ze8B28qDrQB8wQ4eDmeYCFMKq4Kq+tAkAErQaGN5s0jpuvJXYDiqkN9EA+/OXY8g4y
 UTkPrlGcPIiAfx9leNUQGdgOoVBaOxsR2Di8hWlbXYgl8YsQagpjq8iRT3eedU/tq/SR
 hx4Nry9LyC/HY6oI2BQ6zN3uno2BR1EnhuIwAnGJAg8LTX5H+sBtn692ucKMt9elEXjZ
 6rpvuIz2J/Zu62m/THR5z+1UwPR9iW+dyBuJJv/xMgnmSvUlkoVThzpMeqxOUdV0Yl6j
 2frXbQkbAGit860K7s1tCg3EWSHEFyGIABjowIGA/gp44FpwQ2C1pPdG6aZFd0gLZiex
 zz3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDj+utE1K63SWm/McY1E3bZitJKmCPGqcXV1s1kLyLnSXZWUXJ/XDJm8wAdZM80eFgaARtRvI=@lists.denx.de
X-Gm-Message-State: AOJu0YzatOdkqYrHyngMl4QLs1ET2BOupkrU/4mh2r061aY3SS2Qp2Uq
 /w0W354VpgU8WsB1dQ738JkUGDABkkNhf0yo2JIvvd8fXH4Prwr9iHB15wKTZ/i04gbgM1OOxAk
 DbxYJ7qtLVW+fdKIYOHp+wJshX6llU+Y5OS8s
X-Google-Smtp-Source: AGHT+IGr6w+OvIfEJQH0Bck7QHXUVVYWCfQaNeUki5n3n18Q863fSq27eT/VIDQemCAxWwOtAJjisJq1Fub+xcZJyGA=
X-Received: by 2002:a17:90a:c58a:b0:2e0:853a:af47 with SMTP id
 98e67ed59e1d1-2e0b8ed3456mr1335475a91.33.1727388463007; Thu, 26 Sep 2024
 15:07:43 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-14-sjg@chromium.org>
References: <20240623175515.1466908-14-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:42 -0700
X-Google-Sender-Auth: AGEs20Qcx0D1h8zhtkHMSh6DOtw
Message-ID: <CAFLszTj72-+n75qkm_kYJ3tUHsdvq3xtPajvDmcHEb+xZd=MKg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] buildman: Retry the build for current source
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Buildman retries a failed build when processing a branch, but does not
do this when building current source. It is useful to do this retry in
both cases, so add the logic for it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 8 ++++++++
 1 file changed, 8 insertions(+)

Applied to u-boot-dm/next, thanks!
