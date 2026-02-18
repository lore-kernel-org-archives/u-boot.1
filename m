Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10888E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C87383D77;
	Wed, 18 Feb 2026 20:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FU3VAUn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 407E083D0F; Wed, 18 Feb 2026 20:26:48 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF9883A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so93891fac.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442805; x=1772047605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4KrWvoe6gNEXvwcMmIqm9CpqvwYooP9ccb0duaPAFQ=;
 b=FU3VAUn1TyFFawxtpFDyrK1tkdiiDbO9U1AhdhkWRIHM0tj/mvoLGCxAUh16pHXKOR
 hSLvo8uKi8M0B87PC/iY5/n/heeNVx8RwyJ08nllTN7HKc5g4So0rzCQa3vtCmMW/X6j
 8Vob1wh6tngd2Jm+mK9qkI7i8kQWziGYqgtOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442805; x=1772047605;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w4KrWvoe6gNEXvwcMmIqm9CpqvwYooP9ccb0duaPAFQ=;
 b=S9FzHmLe4q/L9O7mDp+XHgaKrT5CLhQezNypUCwzY+aDmbvVsIxU40cKmO4ahGmOxP
 qnIx7Ss3djtAgc0QCxHEvwxtNiBMQshP6npIRaRv64TQ6olmraeYeoLQGPwoWyFwTbW8
 xa+PDWUSpiy/vW0KE2iqhwSHnS3bSDkziufNrhQLfelR9w0QWwfqQDvxtr5KdTFXT6R3
 +zVOAofxCR4O6jXfvvS9DSjmKSKFACUjX0/YCDFyE4onBNSgLPqoqGerjbCz+GTP/cgt
 FQ81HGrbdVKmT71RmSNWR/5s/R0IkF6vavRg0UG+Y/XomhN7n4xlqv+OU9rA0VNHQCfd
 Vm/g==
X-Gm-Message-State: AOJu0Yx0XRxXTst5ChGqkGDmVbfpbyQbkrDMvdrUYDAbKYlb8cUHCxNe
 8hTcogReY+1fp4QNNd2UWDUyp+l16xXoxGXQi/vMSFqEpNGRR18kZ+4Qok+yP7b1dxY=
X-Gm-Gg: AZuq6aLAqc2pXJvDLpIOfCGAdn7guf7HGR7J9eiq8NargX2wZ15S1CnPxGFmb4k1YOI
 WeW0ubPTjipQXfGPTbnmysKIcPH8d0Cx1i/EzR6fI5YTDOlbQd90MQlSR0SXOGYDc37aTpgx0kU
 gWLeePDcuMZ/Z9RnKqAS5ypeGR8YT+96X6mpb0uDmeXlPBj0sldjZIIwQ2mubHQIsm+vAPD5qCk
 HYMmfkSDh+qJ+gB3iCjaAfGT3NEr/2JuZ0u7+U872Nj6dvxKvhPoqFaZLQ3fRL4965NKPEQIb8+
 mYTrIR9sSRBNJvdeizseUjmqHgXslM9zq2E2wapKLlFYIigwYQFrk6juxbPJURhaGYAymGrSVOe
 s2+wcR2MS7ETZatov/UeVgVGQe11tztArIN7bhuMgF8sb3pybLxOY1QEZ8+6ifg/jZJ6oeabZR1
 4p88fMRTlh/s9cTBPyYRAGp1oiR5D0gzVYfpUmrNU9u5iVf8wFGWcUlraSEAkosrZVpJOFgC33n
 JvhRH89wPgEcR+TlxU4UVWYSgbQuOlXWc6H5tWZdwWts7kxoA==
X-Received: by 2002:a05:6870:524b:b0:404:4238:b333 with SMTP id
 586e51a60fabf-41528f8dea2mr1623786fac.7.1771442804859; 
 Wed, 18 Feb 2026 11:26:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
References: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
Subject: Re: [PATCH v2 0/5] clk: mediatek: mt8188: fix clocks
Message-Id: <177144280383.3629982.5559868929996654174.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 02 Feb 2026 13:41:48 +0100, Julien Stephan wrote:

> I recently submitted the clock driver for MT8188. I naively submitted a driver that was ported
> from the kernel driver, and mostly work to boot a kernel.
> 
> Recently David Lechner, added support for the clk dump command for
> Mediatek clock drivers, so I used it to check the MT8188 and found
> several issues fixed on this series:
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] clk: mediatek: mt8188: remove separate topckgen-cg driver
      commit: a04835c0e929c04403b01b50e1dd966eb42e5004
[2/5] clk: mediatek: mt8188: fix circular clock dependency
      commit: 6354f83f43f7d2c1b76a17f9b5629a1af7b7916a
[3/5] clk: mediatek: mt8188: add missing fixed clock
      commit: 5e9bbbdab003e147f54d15e0a1c081c13bb0855f
[4/5] clk: mediatek: mt8188: fix some clock parents
      commit: 2797fa3efd88fb8e4661093aab1958799a4696f0
[5/5] clk: mediatek: mt8188: refactor driver to improve readability
      commit: 0cdd01dbde2a686ae3891c8bd79dd75d686fcbab
-- 
Tom


