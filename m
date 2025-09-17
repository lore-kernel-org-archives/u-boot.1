Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7585CCAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E498361E;
	Wed, 17 Sep 2025 15:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gX33JllY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681F88361E; Wed, 17 Sep 2025 15:47:43 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8569835CB
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-75731ec93bcso1156044a34.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758116860; x=1758721660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzQ8MWMBdBZu4NwfwPtASoWnN5Nd0GoxZzxN7ksAhOY=;
 b=gX33JllYgjTTNrc/2ESLiQDsWiGTrlCT9+rDi5NNvJ2KsU8ZU4VC4o3dY0Yk9WC/lE
 m23fOEPjfcyGYg34Vy1Oxb5vpC37ypIIr9ztS+OWLbHnvWoQS3PGleOnWNyAH/jJVDYc
 of+Z97iRo/v362zV6RxFMP6Tk3q44KX9R5xv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116860; x=1758721660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzQ8MWMBdBZu4NwfwPtASoWnN5Nd0GoxZzxN7ksAhOY=;
 b=ACWRB1UENb8FDIVu/1w64RNpgMyRxlm+7vf/z1veexf9A5ZQ3Mwj9f61ALCY37U/as
 HWMK7+9hBG8YEJb92b9MphF1IJOVh1N2WbLfDO5K/xHssusq0sYZeJp3zNuK6CX/a4Pk
 5HW534amlshDwuvPnDG/1MFstDoMGVAwvPSXf7pQUm5RxkMkYEsHUY9r39ZnVoGUAWzF
 2tbcoA1qPZP2nbyf+5fzOMo0ua74+lBaj+yerKnAhE9GTvvqdITdpV6v6fexKiyhAAM5
 uoDbagllfPgsUM3grn9snX7OFHKdSF1Sc7eeb3wsNxpWOc1SRSh81nF7wcxppO1c6qde
 BgtQ==
X-Gm-Message-State: AOJu0YzP6M2O4PPJkKSHXHf0vf45XeEyjz2i17oP0FFPpJBRSMdmOhvh
 /DBgEJoqTNuFIB+eeQGq7XNKlqfKaX7GEMsNqSO6Xgg6fOLaJWSRBcHzOh6/llFQtoI=
X-Gm-Gg: ASbGncvh0SGsK544SeYSM6EUjtIsQ+m0gtaA9DNygED6Ok756bRuAv0ly26nGmGWf3V
 GjIHFDeaAQVnKpWXBrBsrow1w64c1KmZozR1GTTKumbg0KoEai99FOO5qkrljNajjbn5fTtW6ZX
 nuIQRviLloE2/oyWVo3bJHRoiwN79fu29vLDTZQR6Pr3B6W6dtSwkqqWMAY4hA1xGBtcSK/np3o
 6lk5iIsTsLnxg7ku8LKlhfkW397Dt8VQ7hS13n2UWutXQfdtWFq1jApT6aZAN/JyK4brhsgAZLj
 G9WbcNFzU/8XPEXzYFvNY0P6/XLnXAsi0OFyCzcXYVYO/B649Bd0WkKBXr0eGvPbnKlcYy2W/L2
 nPvrHmOr0oND5Aj3UZMBt587RiJ6ndbHCiNLiq42gK0uee/ZV5VeZsrY=
X-Google-Smtp-Source: AGHT+IG06mGQHilO7ChhuQGBBchYxJTI0oQGdB27MNq7E7aHQwkx3RtFYRwwDltK4KKlJpdARe11aw==
X-Received: by 2002:a05:6830:3697:b0:74a:6dfd:3675 with SMTP id
 46e09a7af769-76312ca047emr1453288a34.11.1758116859677; 
 Wed, 17 Sep 2025 06:47:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7538127f35dsm4799937a34.35.2025.09.17.06.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 06:47:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20250906230052.582621-1-marek.vasut@mailbox.org>
References: <20250906230052.582621-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH] phy: Reset init count on phy exit failure
Message-Id: <175811685869.752169.3298850426023376676.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 07:47:38 -0600
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

On Sun, 07 Sep 2025 01:00:44 +0200, Marek Vasut wrote:

> In case the PHY exit callback reports failure, reset init_count to 0 anyway,
> so the next attempt at PHY initialization might try to reinitialize the PHY
> and restore it to normal operation.
> 
> 

Applied to u-boot/next, thanks!

[1/1] phy: Reset init count on phy exit failure
      commit: c6a4b44cdcc11431223a9d9db17de0c587d49c72
-- 
Tom


