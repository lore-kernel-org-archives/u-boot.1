Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD53AC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D716980C83;
	Mon, 12 May 2025 18:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sFG5u163";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5DB826AA; Mon, 12 May 2025 18:29:17 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5676280584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c14235af3so2981947a34.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747067354; x=1747672154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oo+OGsJxe1vxkWIBnWapYXToGo0Bjixp6Z9bJuZdTRo=;
 b=sFG5u163mTXjKISMiCr+m3UZ8QUqK5yr/lPuDVG7kvpuDLl9umJMQFiNZ/zdsQBkox
 q7L2uxy8NaEaseEr/SxxYQC1ks5/hBZB6gR0x4thZ1mo+zTnVOLfXToJqiWFZqCpV824
 8IAgDKGJXVSJIEfpZRB/G1iUMsbRCJdaPEUo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747067354; x=1747672154;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oo+OGsJxe1vxkWIBnWapYXToGo0Bjixp6Z9bJuZdTRo=;
 b=D9zODjF5yBI4SV1Mit1QbwlppB4GXZj3wwTCwf6NBCX1xf9/gHfPqnM88sPbBYiraq
 2Rtu0Zfkq7w2qr1ZzZFOoAbCjPembbPubng334HTJxHNojywTRA8gWdVzDGxYBS2w+75
 lvFtYdYtOhk8QwVP+n9bBr6Gr9g98a21Ps1Z4OmbnZQfVioCdoOiIpNY8bmhz5q+aNs2
 317LQNkvkqceQHzyp1e7dqW9XY+21jD2drEep21qinE/Nm9hjk+BNM4thWs9GN+JCCkE
 zWQBvrLEpigCwZfxnM3ZMQmLNguXOad/I/LfGnF/oKkRTU0mULNMiIeSZZb3ReV7saFU
 VrSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIBsk4JWaF5RGDM0QZkA+GXbeHHBKF+9mypaKBEOuA2N2nxBIK1oVuR8NVTxUnFcnkbaUV9Cg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+RwTEpJJhbva1ATuMCTqPV3pcbZQyhhbhqBEcUjAy0xzn0r/z
 bngIbTusqRa45El3y/cKePIQCMIAc2VVqfc7P4rtpxkTJuUcngYsxOWtdKtImgU=
X-Gm-Gg: ASbGncs8YsWcmZBH+Q0W8+wg/7fsJzGTY0wPnIsfwXgx4vkWvMtt2xZ+WHG3fR0IrPf
 Z+oXFReZLRuO0pU9ZiuUGAAhmF5XXuhmCYaXq3bw9gU1duwjFTv6RZkm02BN/f2Nvzv20YeG6GG
 JVwSsdKEFRo1zWpKW8Ua7Cq4rrRxF7mzHkuLzPHxtcszw/jN+7YQnT58I10CdmQgcsOwjXv0Uz+
 wYe5VWZ4iNicqRlAMQpEJUK/L5suLSiFY6uf/PgAZVsxOhJrJsdIyTqbJ3+rVpCEDVtPMD6x6k6
 lpAiigrhZpwLbB9gS7LnLZqeFmmRrNOCdrYiwjeNBggRnfmsQVh7dn0qN2+CZr82C2SKZeqU5Lm
 QBtkGJnj6190m9tg4lbm8JQ==
X-Google-Smtp-Source: AGHT+IFaN0JdNX6dzOUfg0+9aEFNrs9bEfxUlHbyp+Ix5drkPUM5Yx96nXld9TGhO1MoSVyfRenJOA==
X-Received: by 2002:a05:6830:398d:b0:727:24c6:87e7 with SMTP id
 46e09a7af769-73226afb4ebmr8264048a34.19.1747067353845; 
 Mon, 12 May 2025 09:29:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732265ce4c4sm1589444a34.48.2025.05.12.09.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 09:29:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Dang Huynh <danct12@riseup.net>, 
 u-boot@lists.denx.de
In-Reply-To: <20250510153203.569240-1-jonas@kwiboo.se>
References: <20250510153203.569240-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2] clk: Fix clk_set_parent() regression
Message-Id: <174706735295.2273249.15226273765649833496.b4-ty@konsulko.com>
Date: Mon, 12 May 2025 10:29:12 -0600
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

On Sat, 10 May 2025 15:32:01 +0000, Jonas Karlman wrote:

> The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
> while reparenting") add a call to clk_enable() for the parent clock.
> 
> For clock drivers that do not implement the enable() ops, like most
> Rockchip clock drivers, this now cause the set_parent() ops to never
> be called when CLK_CCF=n (default for Rockchip).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] clk: Fix clk_set_parent() regression
      commit: 128d997a8772cc174f38d529d8b25f90b3aa8ad8
-- 
Tom


