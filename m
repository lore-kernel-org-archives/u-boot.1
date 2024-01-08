Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E9BC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C1287A61;
	Mon,  8 Jan 2024 01:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eHDgzzgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4855087987; Mon,  8 Jan 2024 01:16:16 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089BB87A37
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f85fe5632so18610236d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672973; x=1705277773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RRp3FPviutwOCaze5op2DNip5LHhiq9z2YOB1lDcDGE=;
 b=eHDgzzgXI91jYRHf1OmSb4yuZUi+39BRY8HMxdVBiCdN7SgUpCzBVziAX8d3aFyijy
 mkgJEriv4vOyFW7yD2pu9ZO3Xdg3lv0el8ktNROBcqExcuU1Bq/+dcWuwnjG6d+28+SB
 OKVUGxr1J9J1uUGpcnBdY6pROhy3SqF6MT5zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672973; x=1705277773;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRp3FPviutwOCaze5op2DNip5LHhiq9z2YOB1lDcDGE=;
 b=ZaxNqD4NPw6unW9aZ3Rs4ZDrQBXu3qJCYuNVLlgxr5ZGeZyY0n/W+XUR2U7hcIzM9V
 Xd3gXCB7i+3arZvtwNqDrXSR2AFo6ZAP0JFAbkvBFLMFYligS6u4uTEZNccV3JdyMwOO
 3ewTaYwmvXEIYEm3UopjsotyU5wDuNXyENMTbgiEyTAIXnd7sbcAT0loDr3xHzIZrbYP
 AJ1DHZYtHhCUUn9WOyxBt5Q6fnwPONQztkgrr8el9XRaxZiozURjWEbNAaO7n0d0C3NE
 vIbY6QgCGPlp2pPfa6dJ7S/c/9uXhJlILCFlFGbZD3dR+7trhOJid3aF5pmT/w9oj2DQ
 GzKA==
X-Gm-Message-State: AOJu0YxW6Eac/SlZmGnPEr5aPWdnheY7XJNKk7+qeGi2Sm9S1KsAONrq
 WLY0eMszX4noOLzuDfsIu604rKzICoN7BS3r3iGYTxAVSyKD
X-Google-Smtp-Source: AGHT+IGS3EV75Tq5zVjrpF8tTUsb6ioegv2mDL4FtQkN+yBlUlUG7daW3eMtH/gMbroDbSbR2447D5TM27rxB9SU8tI=
X-Received: by 2002:ad4:5ceb:0:b0:67f:2ed5:437b with SMTP id
 iv11-20020ad45ceb000000b0067f2ed5437bmr5343351qvb.20.1704672972902; Sun, 07
 Jan 2024 16:16:12 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:12 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231231152555.464874-8-sjg@chromium.org>
References: <20231231152555.464874-8-sjg@chromium.org>
 <20231231152555.464874-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:12 -0600
X-Google-Sender-Auth: R1oGzNL1GusCUYpNQsVeSqXG3DM
Message-ID: <CAFLszTg-b1-tBfyMgCzF7+H=bvtbu0je2RvD1RsN5mrM6RkXQQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] smbios: Require the caller to align the SMBIOS
 table
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
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

All callers handle this alignment, so drop the unnecessary code. This
simplifies things a little.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v5:
- Update comment to mention x86 alignment

 include/smbios.h | 9 +++++----
 lib/smbios.c     | 2 --
 2 files changed, 5 insertions(+), 6 deletions(-)

Applied to u-boot-dm/next, thanks!
