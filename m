Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8299BC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A048365C;
	Sat, 24 May 2025 07:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RvT6qCs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98CA3834BC; Sat, 24 May 2025 07:06:23 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2D183303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-601968db16bso1044529a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063180; x=1748667980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KfZdGdZz/bQbC2/QO5KJBpyVVuG9MDErojjaAg41Dik=;
 b=RvT6qCs3/sMSo11+vGjIz1hOO7njKKPMN9wEo51MZF9S+JHOVy2iUsQS2A5fj+H0ww
 f1bR4cOR+d6vsjs3AvpXbx3jyzv23vYx/r5mP09FUuMAhkiW1RnjNZVqODfm5fuL0rFM
 BZmhG9hLsxaqMXi/e7A4PbQeMWqecf/CzbC3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063180; x=1748667980;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KfZdGdZz/bQbC2/QO5KJBpyVVuG9MDErojjaAg41Dik=;
 b=QbNdsihJvfthnNin4XOcL58Lsk1YpGxSQNCgvTPJfBCEytGs4WB7NHPY8XyMjNOeA2
 RmMxWeAhreFTIer8Ys5zhJ48T1oom/OMKuyqKi+gBCc++8xYNKf7qKwmw3V65/coPYUY
 bKleK1tc1dVTIpmZMmU2vjLQ4yKDMF76ZVoNqyJj8Y2Gbzp9sBmbbnnDGBmpL16dO5WO
 2lVzJMv1xxw118IxkF4xupRqFs0xb2wDDME1vMSMp91BiXv3+/fAp4gAe6OTcDw4RqFH
 AqT7scuh3ugUT9seXYfqLPondGIxBPjQ1U4tNQp9xH1u1Nnl7raCFdUN7uY03Sihu0FE
 1KpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc4zSDRnJpu9UxgwoxzCzbYBqR4535npZvpWV5zniEDkKLsgIDrpk055uwcruxDUV4UbtZgNI=@lists.denx.de
X-Gm-Message-State: AOJu0YwzsDEbmO8Vn+s5CjaovRqHJ7SYinxg/8waWrZw/nRwZ0gcR1wK
 1+KUiHAxByL1CZEgaZ/7cmxNkaXThTv09bRT+nFRO6p/d+7gYl9eZLjVVg6/EeCmqZZFv4ayVYQ
 coBj1Xu92Yd9wLzur7LFbkAfl1vcF4YhKaY5yhpD4
X-Gm-Gg: ASbGncurY0YUJmS2Eg+lDDDihQbZya8aLmC5SDYmSxJ+K1wz1pR4I+jnW9FixKlAr3u
 suj0j9NUOnTpN1Lh4LuRY5bb/YfAAId6JxPVCXUPWSz0tVXhSjdwoJNZAN/Cwr0pbvkhjZL8cA9
 JwHQWH0rEi51XcimctMe0yuqIZgc8pB27tgx25xtBMZQ==
X-Google-Smtp-Source: AGHT+IEiBIApK5cYEHuarB7Vtszax3wjGHFA/Rvd91wPL24rrVPUwOqnEyebzEALEBEDfWHBKP3rRBG9e/1O57L378c=
X-Received: by 2002:a17:907:7e9c:b0:ad2:4788:10b9 with SMTP id
 a640c23a62f3a-ad85b18be66mr129075766b.33.1748063180442; Fri, 23 May 2025
 22:06:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:19 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:19 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-10-sjg@chromium.org>
References: <20250510110535.1453745-10-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:19 -0500
X-Google-Sender-Auth: NB7J-VQCfIVBEsbyDvECQpyKRCw
X-Gm-Features: AX0GCFsmTLq_IGfoJMJiMCbgQDfHSc09cdXt3eHPd5Wrx5lTE0gxH6I3-gyh-IQ
Message-ID: <CAFLszTgZXABvS5NqgZqVDvCAvqX6RCvni8F56VeusdQ9cssyYQ@mail.gmail.com>
Subject: Re: [PATCH 09/25] patman: Add a simple database implementation
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

For recording series information, patman needs a database. Add a module
which uses sqlite3 for this. It has a basic schema, enough to support a
series subcommand.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py |   3 +-
 tools/patman/database.py | 823 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 825 insertions(+), 1 deletion(-)
 create mode 100644 tools/patman/database.py

Applied to sjg/master, thanks!
