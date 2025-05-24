Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55929C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BF1835C1;
	Sat, 24 May 2025 07:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Npj7cbg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17816835D8; Sat, 24 May 2025 07:06:15 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BCED83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-601f1914993so1007188a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063172; x=1748667972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PtiuqZtKVLPffNELlo3446A71EQEDQVwX/fF3N9PKDE=;
 b=Npj7cbg95zU2UQ87LcjmLX0HtEEbzWQqkeQ6vMyADe98mRIr5qRh6FpPlDIUDmyRdU
 QTp6piyyIgy8SSaUjngxXkXk8lgoDJsQ5GfwnVSkO1UfdNaV4QH/ykKxMUFEO1eYqu5Z
 Jjy5kTvem8VWQJJrJLEfn+ebu56l/c0DjNKQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063172; x=1748667972;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtiuqZtKVLPffNELlo3446A71EQEDQVwX/fF3N9PKDE=;
 b=g4+wN8E+jgoQK1Jy9rPSwV9GnlnB7XiaMY34XVxrkj4b3WzndcWa1rrY/4xt5ljgec
 HGNF61ZzNhalZkYM5oxt0IENYRIilCwSYb0va0BuAZHl+RG98/l9e6qehMBeKHRE53SR
 xKHCJgdKxtDr81vi2dZIdMwVcIbX1xZzMdVu3aJTosROcFNy6kQHjYEzglmruoHvR9uS
 pljYxxsEh3JOpoVWAjyoVpMCfQetmYDIbIxeR30tx55pQVj279zhNr8H2+5DdZP+Ew30
 ksIzk9JPpUqTumKUK0EEqpXD+hxTN0cxslIrS9XC/8w+hxl4gpIViG8YTLnA/QHjk+W5
 N3Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpuoWbOhr7h7pKPnMlUBMpgOm7DiQHBU6jOtxkri3dbt9xbkbMXmcZqN+qcBs4M3vQaBy4JUc=@lists.denx.de
X-Gm-Message-State: AOJu0YyP+Xc/InxJkk5MEM+e8HyXMhfcDhdiga3c5HqVEe/ILkemlM6e
 wrSsihvr6QCSojd00BxKDuIlvC8g/Hgsu6F74K2LNBOnJsVybdZ6+xcZ7CTKOBwhfm8hcz3X40L
 0sMK3a4MPwAc2YeSm97zLVqDdSDFKeYJDiWrPVFWF
X-Gm-Gg: ASbGncv+AMMEc1d09bmb/c3rlAgLtApro4jGO6GCOX4q1in6E5akh6MLvHw5vkqlySW
 rkycnhjFlJxTJj83K+dBcmlQuZfc5CuVmQAvFeb7rNuJttFtO/Cg1sq8RIOFsgU2xKNiEaTAEop
 1xDmSm6iWuVh/683UelS3FqkHhzstEsB9n1oX5hmvfvg==
X-Google-Smtp-Source: AGHT+IFzYumTYpcFq9+cz4oigILMACs4JmS1J0XUWT3fTKboRHEfj7sTG3EDo1+l94DJPir08mJKCM59Cz0qVeULYqw=
X-Received: by 2002:a17:906:f5a7:b0:ad5:4822:b7a2 with SMTP id
 a640c23a62f3a-ad85b187322mr132693466b.45.1748063172624; Fri, 23 May 2025
 22:06:12 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:11 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:11 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-13-sjg@chromium.org>
References: <20250510110535.1453745-13-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:11 -0500
X-Google-Sender-Auth: 8mgXMJZ4xgxHIaJ6pEYQrS7IUZQ
X-Gm-Features: AX0GCFsVOs6a5Foc8_0XJgqdfJH-pbjsbQ80nrp3ii-DyIWEC-IEYBELTy4Qkng
Message-ID: <CAFLszThGMRa4g+xeCXUrCsh-Wmk_xWO2nhXF59Scg+GkWhQtWg@mail.gmail.com>
Subject: Re: [PATCH 12/25] patman: Update status command support cover-letter
 info
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Add support to the status module for reading and supporting cover
letters, including comments. Plumb this through to the patchwork module.
The actual support in the latter is not yet integrated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 16 +++++----
 tools/patman/patchwork.py | 15 ++++++---
 tools/patman/status.py    | 71 ++++++++++++++++++++++++++-------------
 3 files changed, 67 insertions(+), 35 deletions(-)

Applied to sjg/master, thanks!
