Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F2E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 21:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CCA3805EA;
	Mon, 30 Dec 2024 22:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lMzY0Zfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E56805C1; Mon, 30 Dec 2024 22:52:41 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67E980383
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 22:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46901d01355so82678621cf.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735595557; x=1736200357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JupAhqAcrf3S6TMOHEmNdIFTKlJ6JEypwXLNOSCTPE8=;
 b=lMzY0ZfeuRiE7MrOQ/0yhXKTl8+uwHAEIVsMlEhXmXXWx92vqNU8G+O6dIFU83he1M
 PnDha06VB1FCR3MqSEALLCaXQWGLsmzagemHVldgQl/7Gz0R+Hnh3dxEYXTduDu/cNZd
 1symefTGmFecv6EIIjsIkVjQy5hFCa/gOZVC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735595557; x=1736200357;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JupAhqAcrf3S6TMOHEmNdIFTKlJ6JEypwXLNOSCTPE8=;
 b=UuoVva630OlBsDlvPEsu7JY3I0NF5/z9n3N0//ecq1eU7U64WYHuJYMCcvKChcZH21
 0se8vw13HEG6+LB9Q8xYTjyozf7/Ns+ryp085W9EAStnqoEIgubKXzPhgnmxaBmt5qnl
 kOGv9geSU/lj4iMBCzjcbPum1D0qdtxgVYV1vhpNURW7TLdWnsp9fXBkbe94ZhUOphQo
 mmhyniw6M6N6KkN3ZdlHcIeKmAFdNeuRHK3KEXSvdFjUm54pPnuhInQxn4lstdFJyeU+
 m359h9bHxZA4f4GObZTck3A0Eq/SEPLlD0vyRPdsKs3JYCS6KjiAgIxSczO4F5i9wneG
 hGkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtTzOtHWMH5mwsRAh3slfCFiXXssHkLp6LtBYmHPzrkfh7/C7WGQ+GkleLjP0qhsuDz8txkOI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywl+2DSEaPjntrP6GpAEzW7arQEBbprs6kn29L6Ei90sEDhoGWz
 6mHNu7f4nOmwXSdB2wpTo2UfMnN35EltV2vXrlj1em6OHs2PJqJ9FFFsqkfihu4=
X-Gm-Gg: ASbGncu0V3dC1GdAKNc07+RqL2fKzZq/1OQTVwpYMhWIbokpzYVziszEKACYFPZhDbo
 JTKQceona7VNhPdfnrf7airWF6i2usWmR9IhyrhvFnIGurvjt5ESQwdUXZvYwkqsmgUDDQ1QBAS
 z4SrSGlRO5zZmuMgmE1qrcmBXUZsVdQRwRE+odtfLi2OL/s/MM4ndWZZSICzhVD3AGXz8x9gaC/
 8rPSfZZZqS1m4V6RrNOCRCR8TOLSkuaodWWY9sj+O4naffAQnfSptlr
X-Google-Smtp-Source: AGHT+IE/P6q2QHVzzEPOzkA0XKLYvrRzpErDmw1vG1owCqPlSE10Z6VFlwh9Ktoh2SmHIYaba48gTg==
X-Received: by 2002:ac8:5a04:0:b0:467:6742:5633 with SMTP id
 d75a77b69052e-46a4a8e8152mr586661711cf.23.1735595557655; 
 Mon, 30 Dec 2024 13:52:37 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb17e6asm109079101cf.69.2024.12.30.13.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 13:52:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
In-Reply-To: <20241211022550.2995-1-semen.protsenko@linaro.org>
References: <20241211022550.2995-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 0/4] lmb: Improve style
Message-Id: <173559555496.231403.9485840206246902773.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 15:52:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 10 Dec 2024 20:25:46 -0600, Sam Protsenko wrote:

> This series is intended to be picked up for -next.
> 
> Cleanup the LMB code a bit, after fixing the false positive error
> messages. No functional change. This series depends on [1] (which is
> "lmb: Fix reserving the same region multiple times").
> 
> Changes in v2:
>   - The original series was split by actual functional change patches
>     [1] and cleanup patches (this series)
>   - Collected review tags
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


