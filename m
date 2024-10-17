Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E926D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AD3891B1;
	Fri, 18 Oct 2024 01:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KIcoN20D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B133189121; Fri, 18 Oct 2024 01:12:20 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F3989169
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbceb48613so8769426d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206737; x=1729811537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KvOGTHFWKS6ZqxW/P7MmEAP9y3sPhHszrGlmEZpojvA=;
 b=KIcoN20Dyci3COqszZc1jezWZjClRVQEVo8NCI7GIB6IXBX9jTOb2TtAkYlZ1uWB3o
 1IjnqdEG8MzB5IUrFLveOAu991Jb3Z4Fm7+WGPmrpvspVL9n1D2tQo6ha16QMvWwCOVD
 dmFUtUa2WGfelfo8jule6Tf+shAtyiPM/b0r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206737; x=1729811537;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvOGTHFWKS6ZqxW/P7MmEAP9y3sPhHszrGlmEZpojvA=;
 b=FJxtpYRDUb03m/g/mR7egUgy16blNT29rlzGP+IOBHnScvH/aKBcN3YaszG+r4+UmL
 OmqeW4mMT6hv9aENaapfuLMAPhyZ1Bdjbp0xQdv1QLKT/otl6zZerIVxKHkBQa7f9owH
 j+r2gkj1/5/gmRfCPMtLbBaoYmkiQrM0KrcV4Au4rbF+9aYepUJdAMr7kHMEuG07qzIL
 wlhlxISVLDV+BKp6P3ECzKMLd+qjFTcbYagV1H4PtiQifycfWsmNfBThdJhENjERFPK+
 bJ/OregrUNHtLWn6kjAAOT9pG1+vWHu+i4hieVeITiHjVki852dvtMIkYyz109GXNVVC
 fjjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTn4OX/3B9Cmwd+A1p99Ftnvq92GOD/wrqOWcn3FxyC6cm2odQN4Y1Y0YUj1YCul0WT3tzYIM=@lists.denx.de
X-Gm-Message-State: AOJu0YzNtp01N+SEoH/Ui7F9NSWakIeMjZw9rgof72tLinUeejYsnC5M
 IGdQpSq6B5DBhAGzh4LnCdZj3tWzOKsYq1BMMQ1p/SjIuyIMqx9ae6DJRKi+HwNIS1IridNn8Ek
 XRrvIKCLAC0I1YP3NxHQg8ft2oPc4zVlklasW
X-Google-Smtp-Source: AGHT+IEb+qyHAW2Ce6zz6zVHrbpnUmuwyMGRWMLriKAOJlsgGRoiz8wmWUYqIFzH3tA33c5SzgN+804LbeVc4fXgEL0=
X-Received: by 2002:a05:6214:3b83:b0:6cc:42d:bbb with SMTP id
 6a1803df08f44-6cde1695f11mr4541456d6.53.1729206737566; Thu, 17 Oct 2024
 16:12:17 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:17 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828014429.3320011-3-sjg@chromium.org>
References: <20240828014429.3320011-3-sjg@chromium.org>
 <20240828014429.3320011-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:17 -0700
X-Google-Sender-Auth: HNVfg5K3rdDhFpUxGLmoLUhwrQA
Message-ID: <CAFLszTgoia1uuCORoAD+6dkJF5n37rxTYnH02Npxa5=xUHCmWA@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: Ensure the CPU identity exists for timer init
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Troy Kisky <troykiskyboundary@gmail.com>,
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

When bootstage is used the timer can be inited before the CPU identity
is set up, resulting in the checks for the vendor not working.

Add a special call to work around this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/i386/cpu.c           | 5 +++++
 arch/x86/cpu/x86_64/cpu.c         | 6 ++++++
 arch/x86/include/asm/u-boot-x86.h | 9 +++++++++
 drivers/timer/tsc_timer.c         | 4 ++++
 4 files changed, 24 insertions(+)

Applied to u-boot-dm, thanks!
