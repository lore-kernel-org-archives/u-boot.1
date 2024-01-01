Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D9C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81122876C9;
	Mon,  1 Jan 2024 17:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fYqIw6/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA484878B8; Mon,  1 Jan 2024 17:53:17 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D398E86FFD
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-680a06cc763so19172426d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127994; x=1704732794; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i5AsNIMS7b5Lc0uQf/Ldcovm46zJKKuDkeXS9kFv8gk=;
 b=fYqIw6/PWdi/dVpFOMF3mmMdzDHFQo1KzK4l03pmzHqb3wVYwzhMGWjVKz8bUOIULq
 TZODi7CHdNG1h0N7fJIU29d/XqBHDNdoOixGd+M6QwmmAfEOfP7EOg64glAgPlI9Yiat
 zmaHaEfYSpCnAG+3xPwCD5dKSe18ylrql1q8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127994; x=1704732794;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5AsNIMS7b5Lc0uQf/Ldcovm46zJKKuDkeXS9kFv8gk=;
 b=IiUo7K2bk2xSY/XjzqjSpqOkQUYZqsUSb9E3btxs+1bWDj8STRpusgzdOye2LQjAX0
 jJNOGQjFXqn+p1s1nuu8wiTKZIP9Mx/+a9HMqXsro4WA5oS7wI9xg3l4jJXYGVyZ+2KW
 0rk3eGhpIrH18JUDG54JBT9NkDbsf2REBrxDmQDQ3cXdaeI38EVXvN2g6HJ16jgud33/
 hwu4xpAtzMymrUX+rMgi0b4/wa4xvuSBYSLP3sBUNaUvWDhroiOAcIMMgEjTp2BH+dZl
 AJoR2+xO8ew8z1kKsiPSkSbYTUR25LARJmwtlTqDrz2WToYrMEXYCaHBWxPuVYv4osBn
 Ce4w==
X-Gm-Message-State: AOJu0Yxopp76zLhP3dybBVps5rWsqb6ZkSojhii2xHGUeK0uaeTYTK3t
 /DTzUZ0IrLgtok1x76oJtHsb5AlN4Rhmevj5+EItFvwH1PhU
X-Google-Smtp-Source: AGHT+IEfcLQKhqplxstt1mK9INhn1HCOo81DIR9AZpK6toEPqCbgSmCLn+lvKRxjJkDGdonDmOvW99wUuJjAQefDtO8=
X-Received: by 2002:a05:6214:2341:b0:67a:a721:d782 with SMTP id
 hu1-20020a056214234100b0067aa721d782mr23408082qvb.104.1704127994675; Mon, 01
 Jan 2024 08:53:14 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:14 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-12-raymond.mao@linaro.org>
References: <20231229174244.892818-12-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:14 -0500
X-Google-Sender-Auth: bPCCYEQoidio-suKbpeZK8vfosc
Message-ID: <CAFLszTjMfdzL=C9imZP6fFpuxbpDGLLcxVR9Dnk3fUkyfH=1QA@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] bloblist: Update documentation and header comment
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

Align the documentation with the v0.9 spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/bloblist.rst | 4 +++-
 include/bloblist.h       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
