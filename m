Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E59CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A06F88F67;
	Fri, 27 Sep 2024 00:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DodjqrNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983F988F4B; Fri, 27 Sep 2024 00:07:46 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C006588E04
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e09d9f2021so836033a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388459; x=1727993259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bsPOJ2s7CV637gfxBC74QYqDNI/R2rIyYFJLcckMdWM=;
 b=DodjqrNMZLbkJicUWBp20UnuhF4jC/enLJJvukAEMQRl2KfYuUuKLwOk6gsxk69zsk
 cBqVyUd51aAXA5zlg53MYomhoMiG+n5LZHdoj9sfTg01pTBCOfWAG8PYLS9EC5eCaAHY
 oonm31RaUtJB3em7lwH9Z/aZC/2rU4PiZQTbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388459; x=1727993259;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bsPOJ2s7CV637gfxBC74QYqDNI/R2rIyYFJLcckMdWM=;
 b=uf+nDKI1fw1fwHv2MypJtTthcTyHG/FW/qhois1GENd6qbsvqS/66IdUN1vCZBmOyE
 3ykGe3RbUm4ijn2G3TwPoGRBkUa2o9gfB6WPD9aXwb4qzYBkpl0qAgsXPiNcZkaFLqKO
 khSNeoN0vFY7v76F97k/ju/dzcMWkr59gxSqZbbdXERe7FuCH+ROvs7nqmgri2L5iYuA
 rSYz9AsQFypT6iAUJrUHECzJgI5/PTtVkVELeTUMWg7ZBs+HHHYya1tJ3ZR+utqSnmDo
 NQkHt6FJxdsjN8csHmxxFi9bWk6PyAT/U/MyuB2/r39XgB0xa3gx9cEy2ErlvGR2h64g
 tR/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqRsMZEY4hKB7Wh8VED0kk21Nq1rJuxhLHW8v6KPzCkSZpzkQ+xhNuG5bW3RHA8rWCC+RN3iY=@lists.denx.de
X-Gm-Message-State: AOJu0YzDfxkfzLCYl9EmjxTIpfaBchNYWa2u2isJOkW956Mh1cGOJl/f
 hIC+ORRfe5CjgQ8zwMOqeP4gQ2acJymhy/92+V7Upan2aKa/Cy6JSrMN+5wLUviNDp+TSL3M/Nu
 kZRJDOnsxcmklcC/CHeridGr+4vTiM45QPVhe
X-Google-Smtp-Source: AGHT+IEDLLcHBIN63MKzi+YskbeUUSe59Xnv0BJ/F2CEdK3kpuhMGKxeL6owZycrPXonNtPSDas8dIQn5KLH8EBPRuw=
X-Received: by 2002:a17:90b:3607:b0:2e0:899d:c8a0 with SMTP id
 98e67ed59e1d1-2e0b899cc5dmr1229748a91.8.1727388459335; Thu, 26 Sep 2024
 15:07:39 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:38 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-2-sjg@chromium.org>
References: <20240826191143.426387-2-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:38 -0700
X-Google-Sender-Auth: 9YnqPxSoDhF8eVZydJI86YGGRP8
Message-ID: <CAFLszTi7bRy-zxrXL=Qut3_q0whQpP=q5Av0=UMSKNNS6Pdg6Q@mail.gmail.com>
Subject: Re: [PATCH 01/15] binman: Fix up test coverage for mkeficapsule
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Add tests for missing tools to complete the test coverage for this
etype.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/efi_capsule.py |  2 ++
 tools/binman/ftest.py             | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
