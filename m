Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F44CC47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2B98790A;
	Mon,  1 Jan 2024 17:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VJdIAbUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46208792E; Mon,  1 Jan 2024 17:53:29 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D53978790A
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67ff241c2bcso52616756d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128006; x=1704732806; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dpFECKHyl/6p/iqTGhvUI7kUccs1f+oRTa4lMpRK+p4=;
 b=VJdIAbUcjAndqJMwKXh65It5A/HwzpQVeRQP7s4Y/10s/w0DNzWUuEGiuYXw3/W7DW
 4fXPM5Mz0OrI235usXLr5w1nSs4TfZhG1H5b7AcQZNExChkIezjpmI4l8Aed0kWWUU52
 wv4R9Y5+uq1V/GrLRN/LD7APniIQ1S+kOsRUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128006; x=1704732806;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpFECKHyl/6p/iqTGhvUI7kUccs1f+oRTa4lMpRK+p4=;
 b=EFZFgu7b+ukqay/rvI7dI0ny5hIC1UyvzBu/IGnd2O13Cqv7vPMZ2FDFMhcShbCekN
 YH5U2m7xFrEI4oDDXWvsKQTcJvjalQf9d0HV0LvAferlUoG4q21RqY0bgEOTM/i0C/Ts
 IxgKDdy/8v0BbdS74XqrhOzu9JdyVRpNq4fYa4G0vGYdoKHxpJc5B1IrJ3XhELbxALzT
 T3Lg6WmT2W9BJrM02DrKZ8FsR2Vp2HaPkbEqPs+y8ZpSed36CWgxg3NjM613/v4Cw+2w
 X+G868Q2ldfdzIjCvuT7pUdyJU+3GYa/1Z899A9+vaVo0RRyd4R8V4MsSMj3koH0Bg2j
 0JsA==
X-Gm-Message-State: AOJu0Yx4xqswZTD1utMDaQrXiWtsD6eWKbklEeI9vqO/wLst15dMdYN2
 /sQr2pewnW1YikIE5DnCKxgwCqmW6vYkaITIRa+4Z7xO0kZE
X-Google-Smtp-Source: AGHT+IESJyYUCdzWv2NqSuiurAHH1i5a+EG5WhHr/WdMf7I7WpJwUxEFxhG+gnoS/gezlQtML4iKjdk00rMDSBIzpq8=
X-Received: by 2002:a05:6214:f67:b0:67f:296e:b38f with SMTP id
 iy7-20020a0562140f6700b0067f296eb38fmr29939533qvb.24.1704128006383; Mon, 01
 Jan 2024 08:53:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:26 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-4-raymond.mao@linaro.org>
References: <20231229174244.892818-4-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:25 -0500
X-Google-Sender-Auth: yJe03MQ2FN8oraMSA1DEewEg3sw
Message-ID: <CAFLszTjLFgFQUGZm_UQCOc7rV=nC_3mcn69Dkg8shK_u+WhVXw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] bloblist: Change the magic value
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

This uses a new value with spec v0.9 so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2
- Update the bloblist magic to align to FW handoff spec v0.9.
Changes in v3
- Update the bloblist magic to align to FW handoff spec up to commit 3592349.

 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
