Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEEEC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC7C8361E;
	Sat, 24 May 2025 07:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n15bPLzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F02834BC; Sat, 24 May 2025 07:06:17 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C8283616
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad857db4f52so47973166b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063175; x=1748667975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gMVV8xLGNvZ7U9Txf+txdifsc4DO7Ay8UN1sgAtlMls=;
 b=n15bPLzpwPkYgyNmVV9pxNbmNqmKEOAeOsoSeg+2uPV/l2oXTQVxNkRkbPEaePVQhC
 Fol1ffkfe4YUGd+Znod1gw30/As4S9SqGLq2S3nIzsIkfbH7qDKRB2e6fsBY5+MNuFPK
 Y0ptQfzYEWcpJviN0mVq1VhDaqY/ch3k57I0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063175; x=1748667975;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMVV8xLGNvZ7U9Txf+txdifsc4DO7Ay8UN1sgAtlMls=;
 b=myjb7wTCjSuV2hcSzzR/C5yjcHXg2oNBX4rN+MJ/kjzsTWjp5D3Hx8ss1wFul5ulkR
 zYmLp9Evn5xnml7DPkXAqwHK9pIY7EnkskPgXc9UihCAWaTg5RHYnymqfosPOLHn0v7/
 kQFFJxOg26y87YoKCayMrRCv08ZDfnhBs7P8G0tOUEbs3Us2s/DdVSG3ZNlFyTRMJZcX
 Q2ufxIF6Y+qhT/f0nSNcLhC2TWMFjmAJy63LPi7qxTpg6fw1sRCkL5MoVSrSBYyUGVJS
 zu58hxxDsgnUBG4TyQAIGuOiAGoVFeuqLF1xEAgCeaC1IF3iZmflot1b1zsSVHwOdR4S
 Z/zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvEKKJBfP4/IaC0ifLjW853CwhxUoOhFdIDfEHKPcz7vMLV3AeFrXrqINOk0kWF6T3yT+creQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwxmsOtruHuoF6Z/Ymr1DX4l9Bej1mCKJpTKfe5qDMHMpnpIw3Z
 Zh0Va+vzYUN4JgxHqtBTczBHkb/Pz86d3lEnktZD6jU3/7rqDtqhSDeRD3+RFZmSCpgou+7kocD
 VqcMimDgy9rNJJzx4HgCHhAnyLkX55wlPlJtLhtbU
X-Gm-Gg: ASbGncvcUvrtcXtPRu4/4VjMZGS/wgV6axwBVn6zJ/O2ODMRyIe//A8OgNuElr8q7+Z
 8wMMAXbYc/FGI8ur78xEHfjt+c7VIxkFhSUTgbI98nGQeSConxgK/rKh+aR++RYVG7XPGBQRAqK
 XCKn/f26/b1laI1GT0MrwbYX/9TKhiCMM=
X-Google-Smtp-Source: AGHT+IHzJAwAZhG3TFip1obZ5v7Uz5M3JLQ+h3tFsBjAEdJwpHoqfBmaHmB+Sk2LZ1Q30u/GPpcaM8hurjHLt43g9vc=
X-Received: by 2002:a17:907:9484:b0:ad2:51d6:86c4 with SMTP id
 a640c23a62f3a-ad85b34ea6emr141725366b.61.1748063175580; Fri, 23 May 2025
 22:06:15 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 22:06:14 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 22:06:14 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-12-sjg@chromium.org>
References: <20250510110535.1453745-12-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Fri, 23 May 2025 22:06:14 -0700
X-Google-Sender-Auth: NSKxgcPvgSsaZmwODY4i6fOwqks
X-Gm-Features: AX0GCFtMM7HKZyIfUaA2z45hUGXVB6R0CRabotlyaCndY_gYM7Oit0kEbcoNF6U
Message-ID: <CAFLszTgxzVMbZCRX9NeiL0m7a2jQ1Lj8aUxxoqFKfq2M0CPZ6Q@mail.gmail.com>
Subject: Re: [PATCH 11/25] patman: Add a Cseries class
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

This is the main class for dealing with series, across branches and the
database.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py |    2 +-
 tools/patman/cseries.py  | 1165 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 1166 insertions(+), 1 deletion(-)
 create mode 100644 tools/patman/cseries.py

Applied to sjg/master, thanks!
