Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E66C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE8388C15;
	Thu, 15 Aug 2024 22:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UGfmfHx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A3388BFB; Thu, 15 Aug 2024 22:33:15 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC8288C07
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5b850d969so839234eaf.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753986; x=1724358786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pDVUspRWtMtdRWoV0Xt6fRuDr9W4RyHjDC3WQYvSDuo=;
 b=UGfmfHx+MO8cMLtUoy4669qXOGv6JMAOyc7nzc5pXUPHth3xtJmW6fDMo77HnFJYWo
 cHtryk9ZzEa+N5ENkJoSSYoFqwLpEaZ5Ydn7ljCUFmdS31Y12AoYIh2SzqN9suvnhy21
 AYOzwoKlRJcXcn72k+olSXPG9ryoRFnz/DBzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753986; x=1724358786;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDVUspRWtMtdRWoV0Xt6fRuDr9W4RyHjDC3WQYvSDuo=;
 b=OAUdE0kuiEO5mH+I6qEJj4+Y9nKwgxMRWX5py9iM8sg+Eh2vjeTXZ8eXKlCAILRgFV
 UnhJ8NEmG+7U5IMZoUHrDJob39MjPLSRVlK9Pzot5LYcop/tGfMntzha5JKeBfExJeyZ
 hIpPWizk8YzRHBxBWKJ1FCh0BBKZr4g+BBJg6ZP77gpBxPLzkhxeoHSEXSTV6X0rOQiY
 LGKJaRLR2gYNLKhF1Z56wLLsi01LRZJmJAVrHcRUHwvzIEITRyoYhPZWuD/gOiWuMz4e
 RcWhYSx3P6As1Q47yg8FeB1tMNqBC9gwl8E0pEN+34CgI10MswSnG9vhnVB4ibHtcNVS
 ZDeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNh+2t5wRnJYdEg4UZr+dPpnGq8RdXkUmTgbZVYjkzAh36WuIEfrgpKRPjQeBv9+XSG7oBcHFRg1jVk45sHVRUUe/3qg==
X-Gm-Message-State: AOJu0Ywn4ZJ7cwRZ3FWwYiM90tJWlQRBjPS0rtF0G55toQF7+14hiePF
 zMILcXcVvNfZEnkdjgRC+NwvPtjgkji3zSP3D3EcW6qStDpUWJTE5p800TtBLBXeLhQzd3mvk1A
 6ffw=
X-Google-Smtp-Source: AGHT+IGO56MF8dOEMxMoS+oXWGTQC0nGNnOhYjG97V5ymr+MxTX2jZcCL4jypUtxtEhgQwZiaijeZw==
X-Received: by 2002:a05:6820:602:b0:5c4:7b18:b8eb with SMTP id
 006d021491bc7-5da97f5a8f7mr1299403eaf.2.1723753985844; 
 Thu, 15 Aug 2024 13:33:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Alexander Dahl <ada@thorsis.com>, 
 u-boot@lists.denx.de, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814100830.1296313-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814100830.1296313-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [RESEND PATCH v2] cmd: led: fix led command usage for the
 LED_SW_BLINK enabled case
Message-Id: <172375398526.3490037.2217117634769170732.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 14 Aug 2024 14:08:30 +0400, Mikhail Kshevetskiy wrote:

> CONFIG_LED_BLINK and CONFIG_LED_SW_BLINK can be defined independently.
> Led blinking works if any (or both) of them is enabled. Unfortunately
> the led command help does not display blinking option if only
> CONFIG_LED_SW_BLINK is enabled. This is definitely wrong.
> 
> This patch fix an issue.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


