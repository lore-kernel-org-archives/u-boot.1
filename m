Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E3BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12B8888F5;
	Mon, 15 Jul 2024 15:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q3gkFS58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A459888CF; Mon, 15 Jul 2024 15:31:36 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E20888B4
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b06e63d288so25924306d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050292; x=1721655092; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/N5Nl9TBvDW0nmJtLgI3jTGLzO3Rv5BPkkRKPnWQKos=;
 b=Q3gkFS58ESzIZE48RwcJmvn66HpeiLXd0iVDJx/Nl99GGinYMTgkv2e2xIT0nXU/Mn
 pGEun2FhVvBCMapRgScxS2b+rBC509eXqlpDfLKsMHuM3+sKeP4aQhHP30MdC/iy5aOm
 y+ZTJyZFLGRzeNxZqrY8/LwLWDdzNi1dt/WHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050292; x=1721655092;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/N5Nl9TBvDW0nmJtLgI3jTGLzO3Rv5BPkkRKPnWQKos=;
 b=wv25pw7wRvSQv5dqTB9uBEt+PMYkZ0Tl/jrNgVU5Dl79Lp+IUZLibhwbMvlz0nbO4m
 fHcOBYyMANQwwW2j/0fmJyW3TpUtUWkQPA2l4Tj20FkKcNw0jWF5UwQS6t/L8eR30OKb
 qleKKh7z/zomuHPRhz7NO5OtnA934udtJ2Md6IdrVS2baQGfY/8RKYMdeJjar6ZqcGBF
 y2lLRbCRuWE06E691tkax86OceduEYj2XiCzDwCgPT0RQT85doavYwRb+kFg6f4rOVrr
 Nhg7L/8bPsgbAVWbbU9rELAJ6/8nH7D1Sl/6VK0LX21OJTvsHwwwApmEAbzIFnCNwqka
 2iRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVIe8++lGi1V0dEV1+46jiOAdD27/XU/X2+q7OYQCgBIJXFELeV2EgPdlj0Uj/TEv9bZxFWADcX4nsJe/KiFw5FJlnDg==
X-Gm-Message-State: AOJu0YzTEsxFQU1DAtZk5Vw9s9olRr1rly9MvbVyoivwnGQeafXIYX1m
 v6cpBiStgHebcNdtLRfB7WqpXlvgaWM6az2d0wIwMxJEJExKv/G3hPilaD0lfw8E35v5soBRTG0
 KRA2rdzFhPXm3/NUczA96HkwwQX4AdJisI+A8
X-Google-Smtp-Source: AGHT+IHMfShycdtm5OFmflUA5enTU/AjSFU/ziXUKp5tYHC7CJOuuvBkJL67Ls3wsSkO8bmU1A6mLBma009oSIfaAbQ=
X-Received: by 2002:a05:6214:628:b0:6b7:6544:c004 with SMTP id
 6a1803df08f44-6b76544c47emr53094196d6.1.1721050292394; Mon, 15 Jul 2024
 06:31:32 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:31 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-9-sjg@chromium.org>
References: <20240623175515.1466908-9-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:31 -0700
X-Google-Sender-Auth: Vp15m9Q-P7TkOB1zD2bOS26XSCU
Message-ID: <CAFLszTiBjhhEE_7rWa+qVDJ3Ux+506neMjTQTQFy=ryVqGHLiw@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] buildman: Make mrproper an argument to
 _reconfigure()
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

Pass this in so the caller can change it independently of the member
variable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
