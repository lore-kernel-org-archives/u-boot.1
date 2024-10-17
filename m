Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2BD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF71890FD;
	Fri, 18 Oct 2024 01:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y1iGrzM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3CA89103; Fri, 18 Oct 2024 01:11:52 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAF188DA0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so10334256d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206707; x=1729811507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JrEGeSig1YoY8bRU2lHMG3se9opeY+SXTvFxzL2ksb8=;
 b=Y1iGrzM5LHPQ4SrvMVF3HxJl3NEHdKI/xz5xdl0MXdPcGhJpFH1WuMSrTrQ6+V8u41
 8eELJV0gu8d0bps+pLAeHWJo4EWqDzQsZ/WCjueAqFg7hE6WYUkqK9sgefs/BO7ljFlo
 cl4VFqQ6fTb/+iJk4tFcSot2VeN2+js+KhcbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206707; x=1729811507;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrEGeSig1YoY8bRU2lHMG3se9opeY+SXTvFxzL2ksb8=;
 b=ElsI4ZEZDq1sW7EFvowgd+R1tcT4H31rwOrRp8u6orXj6Xk1dfJS0MF4iaMYcN84Ze
 IooSS/Lo9Lzj2FcPSbpD9VuBxI2xBVmZmWxBRYtNfJ8nXPR1XsPWesBNVJ/MbgNh9uIO
 hOu2azEKBHKfY2phSf7HKI9CnUnlurF1CcdS9VlCMAdnXvFP3+7Hj3QnAr6ZIyJNkNq5
 yXrRs7My99K7xY2fkFJ0TUujjFfGEz+8uR4YaF9Fp70GlrGm6jozffrVAcWNVIPcyDtA
 IdwvYw5PLWp7fiyogPyOF+mxIQmt6vfWbJDKcHAm+Rpixb7pNpxtV9xsCK3Gv4PGEKU9
 0UXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR9hkTi20rvTluzb0ZKWQ2Rnd0JfnTQHbQXNgpyZebOmszKLHgRP+p9jF0PrFK3ZauzlNcuac=@lists.denx.de
X-Gm-Message-State: AOJu0YxYfj1OnGCPFD939uSzEUyrd50RBPHmypSQMhTglcQdvC9YRBaT
 gMpqlLNfM1py61J9dHwliMnbl8CEyWOSDCK886Dprbedmh5u2n6zQzUbackxR+mALqwimRBsk+S
 B9FAzJGhOyvvLS8L6SVQ6X2DfkTdkDL+0Xteu
X-Google-Smtp-Source: AGHT+IGmZIfs0l14mBbb6Lv+zi4uddpS4RbXanD6BCq6bwTpJgam4qm722mH4U5VeYP+NBluUlegoksM1dcEQSifuww=
X-Received: by 2002:a05:6214:3c9e:b0:6cc:2416:c247 with SMTP id
 6a1803df08f44-6cde167f083mr8889976d6.49.1729206707458; Thu, 17 Oct 2024
 16:11:47 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:47 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-2-sjg@chromium.org>
References: <20241014223212.2212442-2-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:47 -0700
X-Google-Sender-Auth: z_hKaab_Cq6p4JV5H9dgTHCVqco
Message-ID: <CAFLszThwDCinVqA25g5XufdMVZqwcZkxMom1X1Dcmj6VG3PtVQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] video: Add a dark-grey console colour
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

This is useful for highlighting something with a black background, as
is needed with cedit when using a white-on-black console. Add this as
a new colour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c                 | 2 +-
 drivers/video/video-uclass.c | 3 +++
 include/video.h              | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
