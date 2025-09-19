Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E245CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 16:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E67E8329F;
	Fri, 19 Sep 2025 18:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SzfFTwz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA0F83314; Fri, 19 Sep 2025 18:30:47 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387C383285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 18:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-620b2171204so1209586eaf.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758299443; x=1758904243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+caNCacuUQgX18iyq8G45AgtPTgTZMh+c/BNr+Sk/9I=;
 b=SzfFTwz7r1qp7i9ZfIT3T4AEx9s7NDj7CPBLIgw+X5wcCMxbNxI7hSNlfDDhOuiAj7
 Tz8plE87MY80PicarUcrtfYyEsK3GgtOsWhjjfwlWxPXp2pXd089usIXOyCaa4DEu4FF
 p2AD8uWWjZAQ56gE4UQ7QUhAstvkr3EGfsAR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758299443; x=1758904243;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+caNCacuUQgX18iyq8G45AgtPTgTZMh+c/BNr+Sk/9I=;
 b=QVELlAkB9V3D5snjxsWXF/AD172LyL+MqfLhevefensEa/BkHC5iP6WBCw5NUPY22N
 6MymD9lTBcqZRL2s9K+/QvsdTN8KE0QuQyDopAU/QzYpihJupVxKyuJZ2lvCqKCfPb7f
 D9Ix1yGvLBBrDfDV34L7L+eLIASPq/gsd47lNg4ef+wC/Ve6MY+b9OwxzYAr6E7rkkED
 VuNUKnEPQ5fUdMis/4Fu9wbnwBRmIavJAYtUAjaUIBihwCVAp78Ir8QT3JDOQ8w2Ttr5
 zVUhMeY4kRdYhHzC/GFXU6ChPWFN7+oBJt5qgejEukGmZodF+pZlLhgZDzEaZPrrEuac
 8PXQ==
X-Gm-Message-State: AOJu0Yw33Zggp6oc65kzp7szdRZoUr9pQ6aOKeiYAgkjFmUbEFySkWNG
 lWc/j4mH4rhkN10wTwfti9+cN9wWjUh9X75zo7uWdek5usBcU+e3P9X1AT/6Pvlehct2tFpXtxh
 EFE/3lGg=
X-Gm-Gg: ASbGncvo6mTKCT4A1M9kl1P98aM7KISe5egCnyttMSHK6cER0nOZ7FDT5W4mLQ/zqRZ
 BQuIL6Zm69uL+/rQfdih5WANa3dPyd57MtY3Bp9DMol58SOcHIOXF+dwKOpUNOHpZpq2FGnLQFl
 Fw/h9yxwiIfus+DxIXN1GLJMDlSSQxXXglhVhhOmnMjFVQWB9ooQkKNIdhIVZHpSQaKo70dpBV+
 NMRz2GxLPowRb/5vRtYiBR/MiNiMiOmGtCERA6iImrDnSwZYj1QcOE9iNqJyXkm5k5mzqB20dJO
 00DTc5q9GrJs975zLOHrgqDSkPKycpetXvzun+SyRqDNPquIaM38pP49YZTFG58W+ZLV5KMCDHC
 55LIE3LTpA8KpFExBrYG8B7nhSncfmjFQPLjImvXVs/GSBXK7iN6plVY=
X-Google-Smtp-Source: AGHT+IGj3vmc6zh+1hvjG80m9s9rL55Z/uGVufRweUHKflASYMLOxfPCeqNwwOXtmMhdeRuoLK+MQA==
X-Received: by 2002:a05:6820:22aa:b0:621:76b6:b3c with SMTP id
 006d021491bc7-6272a22402cmr1694176eaf.4.1758299443546; 
 Fri, 19 Sep 2025 09:30:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6261017ad17sm1640669eaf.12.2025.09.19.09.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 09:30:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <e7ce25bf-c64c-47bf-be8a-158756058ead@foss.st.com>
References: <e7ce25bf-c64c-47bf-be8a-158756058ead@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2026.01 =
 u-boot-stm32-20250919
Message-Id: <175829944235.1096324.5024012588208328818.b4-ty@konsulko.com>
Date: Fri, 19 Sep 2025 10:30:42 -0600
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

On Fri, 19 Sep 2025 08:36:18 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/next, v2026.01 = u-boot-stm32-20250919
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27668
> 
> Thanks
> Patrice
> 
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


