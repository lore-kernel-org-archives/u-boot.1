Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37AAC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6820B8776E;
	Thu,  2 Nov 2023 23:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cokAFcpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5326C87768; Thu,  2 Nov 2023 23:49:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD4A876DF
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a8ee23f043so17873617b3.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965362; x=1699570162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UB6hchb2aUz65KgkgrVT6MXpSL1/cRrBXoAU9VjBvaw=;
 b=cokAFcpvAzwQzPolyt7xPuyuw9iGH755lVZccXLvVGuSENDyGolGzYL7W5ZIoC3Mmj
 n5gw4huef1hBC6RlE2ALJJefvkyeX+4+LrzWRKMvUsUDmN2yU+1qcPc2fuwfQ7IGtOAW
 vW+MfrFoe1M0CUkUbBmDs/YWZTc7/vhuY0I2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965362; x=1699570162;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UB6hchb2aUz65KgkgrVT6MXpSL1/cRrBXoAU9VjBvaw=;
 b=lw3401v7sMrWSH17Cqogq37vc1yfzBTeHH6dcdcU0uEF9Mu3YA/H1PtGTGYGS2B2xT
 YXOQaYjxdVxt8aCIcB6YjyDEASqCpq6gcz6Og0kLEU3XK1wpJTc+BpEgAzXezKXcalrg
 AphOlbqSe9U4RLYiZ9a93OmuAIICwavmcUUoTIXv7X4nkV4dw/bV5dpIV7Mesa2PABN8
 Lj8maFS+B5AKER2KtVmkOwzhtvZtDYOl7Rl5ZdQ2zoedzngJTRLcaC4lSHiiRFfQQygw
 KH4nlK1FU1rHWzUGkHZ+9PzmA7A5INy5lw4VJEp6fCScuVimO6yZ8pvBtLS+V4L82NQT
 tqDg==
X-Gm-Message-State: AOJu0Yxx++HpufUWltO3z0YiHzIqGJqVMimJQOhlHu1g/h40gTlaFf4t
 A3WstA/UrI+x5w2M/9UTa2y2932o4qgAM2IrxeVr+w==
X-Google-Smtp-Source: AGHT+IFWA9n9yms2tPDE/h27q7fzMBS2R0W/Z8b3lyYQHQhuBPuOYV5W48jN8Dr7mwXOKPgEGMvK9T+GZ1SExTBxVRI=
X-Received: by 2002:a81:4f93:0:b0:59c:678:7a32 with SMTP id
 d141-20020a814f93000000b0059c06787a32mr1213788ywb.29.1698965361982; Thu, 02
 Nov 2023 15:49:21 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:16 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231014204033.3077052-6-sjg@chromium.org>
References: <20231014204033.3077052-6-sjg@chromium.org>
 <20231014204033.3077052-1-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:15 -0500
X-Google-Sender-Auth: UVC7czbKMlpX86Vm7wfFYeekFxM
Message-ID: <CAPnjgZ2CdcwWu0nLs1uFNF17WG=J=SgiJmPmzDPbr+m4Pxdk+A@mail.gmail.com>
Subject: Re: [PATCH 5/6] binman: Rename TYPE_STAGE to TYPE_LEGACY_STAGE
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
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

In preparation for changing how stages are stored, rename the existing
stage tag.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/cbfs.c                     |  2 +-
 include/cbfs.h                 |  2 +-
 tools/binman/cbfs_util.py      | 12 ++++++------
 tools/binman/cbfs_util_test.py |  3 ++-
 4 files changed, 10 insertions(+), 9 deletions(-)

Applied to u-boot-dm, thanks!
