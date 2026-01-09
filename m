Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B5D26D81
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348BD84390;
	Fri,  9 Jan 2026 19:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fYrRW4Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309A18438A; Fri,  9 Jan 2026 19:08:34 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D3184206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-455ddb90934so1495226b6e.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767982110; x=1768586910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5DU31cFiyMkTtQgGL8jHUzVOPBstnIKS+C+TfoiemHw=;
 b=fYrRW4Ftjsrlx2gMd3wJ7RWRvIfxtfU13oYsRm3RCa3TmQLm/MIdRCYV/yclnCm5a3
 sD3009rYsoLovAUoJZ0fa+jsOHQd69saBIq0U2jVxR2bdG2JWnzTSPUUuxlUG0skFgAX
 c0CRQk2eiT3b6ir+9u6oS2+UsMjb+Ex0mXzIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767982110; x=1768586910;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5DU31cFiyMkTtQgGL8jHUzVOPBstnIKS+C+TfoiemHw=;
 b=JR/mC9/bfpuLqVlbrZEsr9Df0m4iHEJ8HeCYh2TDWZpw0oI7x8TH80e6W+0Coj7bT5
 DHuuAxbwCHaspf2V31+VC2c/2IlumYujUucyeGjm2fErEG9AvtHGcFAhK2kwpJwMbKga
 FDSc3YZXm9imo2dKBHTDMulJtmxQF5gWPZkCMBmue+Wa3jp4xUNrYwwzCs3H+JHhBcY3
 4bzJxqmP9qCKop9kUxpPmGQvXPRrba9GeTZxcsUxxNLG7n6e4oV7opanbgkcb5teomld
 F8BV6BUKWrWc2EICYpua8mqSH6msFUvXbe7NjhIkP2NOibt0ZsDnP8RNqt0Xy3Xryh0U
 AoEg==
X-Gm-Message-State: AOJu0Yym+C4XSjRV1vC0JLTVO+4diwtdfRVyKloZbFaKYpaYqJtvjRoe
 UmhJiyO6r52k4QFjbl06jcyFci5l99JS+2NizDw/RrX6QPLYzfWNvJLJ375gXO6oKT+THl8RwKD
 KT83APPM=
X-Gm-Gg: AY/fxX7bAM6aHtmG246EfEzQzGiGBUOQtmNVpUbBhbWpcoF2IqpsNhyuRZn1lUh96eN
 +mVdBkNGroKumCxekvGPo4mCHXQtHFQxMZvoiMG04C7bmkhrrtZ8wn65PVkxWcYSt5v4rsV+dYk
 70MLFpqvly9mktK8eAHj0Txe4bnV9y1MruQt6Cizx+TgA4H1SSaMLM6OVZp5NBjqJh9RoMVVCI/
 0Ff73yrT7MMTAkZN0Bud55ybxRbxs3HKmr5F5QiHgGivgmp+I/GICLnuMqGLg9FEKuO9ZdHhseh
 AIddJFZL+5R6Q7WEZDw7oxERJoqaEHickGCC8xOSqPbWajxctxT/fXAZwlBd7zuKy8zuLCIaM86
 U35E5s4TDdn30Uvpy/3+M59+LdNZc/Ctjyeuh768+amZFTI183O4UxsJyWwPJMEO7coGhflr8Dr
 De3hzKvcS2uCyY8ZuiYS8u+R8pXZilyFcMRpdstMVsjrfYGTwmABV+Q5HyrRRaw2R2Z86KjMDJ6
 0e7ogoVCzYhnYFZvPaMyzwRTUxEbn+fu+G1Mg==
X-Google-Smtp-Source: AGHT+IGO2EtfxEvhdNsE+0Fhsv3Xouu4PyrtFoOFNzY5EI3N9Q3zQsKnW4rcWENIqAA1JfSjBAZ4jA==
X-Received: by 2002:a05:6808:19a0:b0:43f:5c61:448c with SMTP id
 5614622812f47-45a6bebc4cdmr7364249b6e.39.1767982110598; 
 Fri, 09 Jan 2026 10:08:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e2b74a3sm5056992b6e.19.2026.01.09.10.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:08:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251225161436.1224502-1-trini@konsulko.com>
References: <20251225161436.1224502-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH] labgrid: sage: Add BeagleBone Black
Message-Id: <176798210944.1451314.10670711117625785326.b4-ty@konsulko.com>
Date: Fri, 09 Jan 2026 12:08:29 -0600
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

On Thu, 25 Dec 2025 10:14:36 -0600, Tom Rini wrote:

> This adds support for a BeagleBone Black board, which is supported under the
> am335x_evm configuration.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] labgrid: sage: Add BeagleBone Black
      commit: 63d55a02127bb2886597fa28312b1b29b1dba61e
-- 
Tom


