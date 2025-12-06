Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF88FD339BC
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 16:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E7983A2B;
	Sat,  6 Dec 2025 17:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pzfEeTwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AFE83A83; Sat,  6 Dec 2025 17:12:31 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9D3839D7
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 17:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7aee74dceso1243368a34.2
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765037547; x=1765642347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JV8BUgPRgN8Rb2VfKxQ0GvO5pxrziNykOhf5uZISr5k=;
 b=pzfEeTwdMv9Lt6LeRHH9Gw0Jwc2tkmPjoH6pjkPnM2mSR33wPbThSfT4p09LtxMHdx
 bS/48qTTdmuA9nNuKOTv+l3RhReo68lB12hC7DF0c5PqV3HJjkt+lilWIeItzOq53soR
 qY/6cl/VvFwWCTU29YV8TA8cPSOABn9TT73sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765037547; x=1765642347;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JV8BUgPRgN8Rb2VfKxQ0GvO5pxrziNykOhf5uZISr5k=;
 b=PKOq/XHejePzTxvkIN80mKx/MZ8O+708yqUU/nAB4UcdnkMHCdd2Bop8DUuVynkmkb
 mzmnjrCxnLMnTxSI97ocaCIZzyLi8y+ABzAVToSXefHKS05L7jMV7aahNjfVzrUZ6NEV
 d4d3TxBecqEMb2tYmbOazSQRZLzygzuFXecMraS9wT9xyeG+DrK7MBm+SAbk5gI1/9pT
 KK6sr5zQUbIDsiJSssjDD769SjOT3JBkhDuIRRHF6IAVm6RoOZAlpTOLc0YOb2W2HKSD
 0aQzcqybwMdJ6lydAoG67OYTIBbyX3xHhz1ci3Iq6k4BA2jh1DJBUl9V8RuTECkcI3Ri
 YXQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeCPiCX+06CueJqvFMgDWhjORJJwU70sTykcF8qNqNazQc0+Ov0EAzgDHmWcEeFW43ekCv4Pw=@lists.denx.de
X-Gm-Message-State: AOJu0YzRR+VAHNJqxr9NAd5pl7SCdn8ruxpBu1Z4vfmhrkfRfgHdWtON
 Z3Uj4HqIrQGDKSEC5Q5A9N/f3SqfMH0mUq8uMjQw4FnP34R+joxUCBIXBmjnFCsTlKI=
X-Gm-Gg: ASbGncs3Y+tUgwdgC2KwanZlNSNogZBJbYfpA+fiuspb6oD/2u2z6wawVrywwPFq2ZN
 P9q23wrpdEQww8jD79eFNkJr4N1O5TeF6zxNjLhBOCuIlnmzIfWXz9O5eB5xcV5bvR+TxenSyep
 D4BO2DBBxHEZu0W2Eog+KPquSqHs4umrsDj1pr9zQFh8iCSFKq9/puaAZA3RMUIKRgBjbTAkGSJ
 O/UKNBTNviuXVRTVlQV6vRjjvlSQ/WINj32Qkqn1MwG9QOREpVuR260RIkK6wuzIT6uzKxOmGjx
 ZXPSbNliOzcuGVfOG2BWyIuYX5EFLYseNSLAAxoOceKaDRbTiYtIPpc+F2GS1SgsjpUDPsVHWaM
 nTNt6l+NNXwkNKno3sx8daOdzA2uTjervvUgSHHuDou2PG8jOwCR+xbhsxIs7j9EDbh7lPm5nZ1
 ODVwXJJXSP6DVa62VLFJMDOtG2w3/Rkh3EG+XL3ysu6LHmZZcD
X-Google-Smtp-Source: AGHT+IEM/0iNix/2JXk2C3kEd8ZbK2xxV0V+NbkGVDSI8cyZcKFpRzw1WGpfPbiFXcHt89y8dJq33w==
X-Received: by 2002:a05:6808:138d:b0:450:d7b1:4fb5 with SMTP id
 5614622812f47-4539dede186mr1137637b6e.12.1765037547635; 
 Sat, 06 Dec 2025 08:12:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8fa21asm6946180a34.1.2025.12.06.08.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 08:12:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: u-kumar1@ti.com, vigneshr@ti.com, mwalle@kernel.org, u-boot@lists.denx.de
In-Reply-To: <20251204122127.717108-1-c-vankar@ti.com>
References: <20251204122127.717108-1-c-vankar@ti.com>
Subject: Re: [PATCH v3] arm: mach-k3: j722s: Fix eMMC boot functionality
 broken by Ethernet boot
Message-Id: <176503754686.2614327.2051787395345428928.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 10:12:26 -0600
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

On Thu, 04 Dec 2025 17:51:27 +0530, Chintan Vankar wrote:

> While adding CPSW device support to enable Ethernet boot for J722S,
> dev-data and clk-data for eMMC was removed by mistake, which leads to eMMC
> boot failure. Update the dev-data and clk-data to fix that.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: j722s: Fix eMMC boot functionality broken by Ethernet boot
      commit: c7c2c3c0101f625c01bf101d652e03a6d4aa950f
-- 
Tom


