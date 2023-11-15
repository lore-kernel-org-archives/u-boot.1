Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7A7C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D0387230;
	Wed, 15 Nov 2023 14:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HyFXcHYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD98B8615A; Wed, 15 Nov 2023 14:16:59 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0CD886366
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9e62ab773f1so764206066b.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054217; x=1700659017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mJsd8P/i6c9fxacK8RUId1cY+WX2FZ2YsZWK2lICE/w=;
 b=HyFXcHYfj8ZHibSRpE9/PsaW85WSDxsngbMgsRNM3ajzx2agOztah0cj9RdgZ0uYOJ
 ZJ/95jW3TnfFZ0V5+nuh+f5K42U+H0LKSHHvmjf3tA3wx5Qh5fDjLoov/XUGCXtM4i6u
 mFF9wFVXm2ZRdqcwWjrhZgC4AtSqPvOrmMmUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054217; x=1700659017;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJsd8P/i6c9fxacK8RUId1cY+WX2FZ2YsZWK2lICE/w=;
 b=akjYZdYG3wvGOR3rO5cnHY93xgqthFhSkAncSSFh/Mbns0rU101dJNm06ir0wEIKTZ
 PBRqNuFTJpz/l5I68FLn3XTQx8ZDOXKkE15S07bR+w0OTDEClz0mXAzUyIe7w0x4Meoi
 UyxgzE1kvMgUF0Q0fuc48Ymfydi3QCyBq5b51wvVGEjP/7of+ilYjffC3WOPYlMcvoK5
 nnHDuFDHKKNAt/ymKB0ck4pLcLcrx3CXel6BlXLhrzA2PmvK7UwcbJVOCmltyXuEN1eh
 NPlVNULRginK8FdJh4UJ6cBVU7NYo3baPnS8wQRrts7Q02slfvr+s35iKu10+Z/XLryl
 61vg==
X-Gm-Message-State: AOJu0YyD67zL86Q7O/5tWF09CgKAB5ggq1x0SvR+ar192vZ7iuvnvWfM
 QmqHvlKpLFjQnJ7Z+5nAM3L+CCTzhLUo+FaRqdLELw==
X-Google-Smtp-Source: AGHT+IGCCiBirqcMyriel2DZTCUm3BNIre46/J7Xocm90K27vhz8bRMDmvUXuQ4lujHvs7On4YOqASgtMwmkjC7OI4k=
X-Received: by 2002:a17:906:3715:b0:9dd:e154:2a85 with SMTP id
 d21-20020a170906371500b009dde1542a85mr9025348ejc.59.1700054217223; Wed, 15
 Nov 2023 05:16:57 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:16:56 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231104162527.1736401-5-sjg@chromium.org>
References: <20231104162527.1736401-5-sjg@chromium.org>
 <20231104162527.1736401-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:16:56 -0800
X-Google-Sender-Auth: xKZp_HPN_P8ht2GpZF4zovOQpx8
Message-ID: <CAPnjgZ3R5kpvk+bcKoGUQ9+T828dCL0VfvdFNJSTuOjfyHoXkw@mail.gmail.com>
Subject: Re: [PATCH 5/5] patman: Correct Python 3.6 behaviour
To: Simon Glass <sjg@chromium.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The importlib_resources import is not actually used. Fix this so that
patman can run on Python 3.6 to some extent, once
'pip3 install importlib-resources' has been run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
