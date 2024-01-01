Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E7DC47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD438785F;
	Mon,  1 Jan 2024 17:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Grj+1/15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A26878A1; Mon,  1 Jan 2024 17:49:36 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848668785A
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-680861506afso21316916d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127766; x=1704732566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9sjqtAMrb+zVLh7Wtg7Mzl4iyLk5dsUkOSKODTT1+LU=;
 b=Grj+1/155z1Ncx0hwqVzqqkGMyeF4xsbzrCeUDI2Rbo+hw6nSJztVcdi1vL6OIQjfq
 RnVL/WuXlBg+tqpu1YemtITT7dqF1+Ve30F8E4nmImgfd6ufUKOLklkjZ3SUhuOrPMUb
 4CJCCzeG5h83Vpn+33SmTtbCRoTxhg7Fkpufs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127766; x=1704732566;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9sjqtAMrb+zVLh7Wtg7Mzl4iyLk5dsUkOSKODTT1+LU=;
 b=hohlzvuh4NLQElvgFKPTEjgSIpC2aGpQph4llej9AbPUjR9ZLqdWFTSjx+OqQ6cHAc
 1TZk+N5mZx1GKGh2n4dMG0sUWOvgol6qhffL6Vmm43oBOWdYtBKcX07X9vXQrZMHSmX3
 JENz2xs4ZWOfbi8Ew1bgvMPvZb03ivMiWsGD5yeh007SrA1fkBYOVwd884JE67GIAGrB
 MulIlfDn41RKI2KjqMmM/2oowmuC+Atm005b7QwJtq0H1tSx66DkIABRZtXEOOJ0MR+M
 Ya5KwWVfCdk/aJPM/hL1572T9qHpOYFPqx44OomeGstwsrlUSLfshQS2yROMlbc4Q0+r
 ZSfQ==
X-Gm-Message-State: AOJu0YxyH9mcDC923Km4ZNfqDIxB8VfoftEKp78r16RT2tC5L/JC2IU1
 x+WbKmuzhjtNsHG8n4FhTBf4EAX2sR9nNjT7qx9mobQF+WPblkAAt/PIHZ+uzA==
X-Google-Smtp-Source: AGHT+IGRK0cydNZtiaxIyQQEFbUwYyeytj3uvPOTN0dXCD74lzXJhPd/m3JDmMOVxhyCfOOVkjtOBZsR5234wbKZutU=
X-Received: by 2002:a05:6214:2027:b0:67f:3135:a179 with SMTP id
 7-20020a056214202700b0067f3135a179mr29833055qvf.35.1704127766406; Mon, 01 Jan
 2024 08:49:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:26 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-5-sjg@chromium.org>
References: <20231217163627.2339802-5-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:26 -0500
X-Google-Sender-Auth: ccrE1UUzJiW-8qFapXrH7tmxVGo
Message-ID: <CAFLszThz9ai54LgZysBSCZwFvFzCq_Cp95qgBAqn_9Uqxjm2UA@mail.gmail.com>
Subject: Re: [PATCH 04/10] fdtgrep: Correct references to fdt_find_regions()
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

The function name is actually fdtgrep_find_regions() so update the name
in comments accordinging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
