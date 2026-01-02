Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4268BFA3751
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7683B83B8A;
	Sat,  3 Jan 2026 00:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="plAKbT54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B58883AAD; Sat,  3 Jan 2026 00:23:45 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E8883AEE
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-459a6261428so173986b6e.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396222; x=1768001022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmyVHr/4JK+0zQx5Zp7MG9rrWMk365RJbXOzJqjKyp4=;
 b=plAKbT5489xAzDIdUGuwPHJeop+n3zGYZTVBYuspGZqgU2ob5vO1ykSulx3oLw/5RG
 ONXTPFdQ10pu9IxsuDdhDc1KC4CL1d/tokNsbOu1j3Qm80BQGX9XK3M5pRcr6qRw0n3I
 2vAfgEds+QN/0/bNZRDg2nV913N9VXX/BffL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396222; x=1768001022;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wmyVHr/4JK+0zQx5Zp7MG9rrWMk365RJbXOzJqjKyp4=;
 b=FrwW8qKqGlvZIvHzRlaonQyULfuvIY5sHO8Sv/+mWIGBCRSzJDEYrHKSzUEP0t65KA
 Yog0H3E4k77x89W9DB7fKLSfpn/N4yL09yKftyOR8wxKhkq78/AxvzsIC9wg1+eDUHrw
 /leTfwgSuKanegq5vGENux5973cJuHQNFgKbYFUY9Rbpa+Ty0GW+HqUNI2EwMgiSyGMY
 RwEIbz7naibOnw9AD4mJGKy4qjine+OAxaSsdV/RIoJlekDvEBRgHBHh16Dq+W2ZkLDX
 YZL/FR//Hqf8yhvjtB3x9JM7k2yaNW0XNloW6WCTNHFvG8qx8kD5nQnE8TOVA32F1JAD
 rSlA==
X-Gm-Message-State: AOJu0YwRiJPGctPjF27hUxRLm1Q++4xX3Da62BIzs9AsYCqZtu0rbqeK
 /bYs88fQ7ch2LYpnnO2ewWPBwWpd36+Lu2313OYOUiYbpiZ7FNdYngmIQNgkUWsD4J0=
X-Gm-Gg: AY/fxX6bj3K/NRzCeCNc+gp4fV1APH7FLY5jZPckI33Y+AradT8H772nwui6JYrrOza
 aW7EScMcu39y1CO5X7hAWFXPQ/0QwEZTjoygOrArbKpYcj8TgZ3eP+k9mV+4jshaqVEODW7xxZ7
 I5D8TxEs6ZpC/e/H6eKy46VkxX8KziQ5FQMUsG/P+u37Y88OLymPO1Jj5aOAUVoCsaz5vpGFMAB
 tyj3abdUz4zuiMyKT++raQF4FU95MpzjrKlRgEMHDjP/AVUvBt2NINICIVM+rG/GUhcI1GX4RCD
 TLhVRtHWefLFIwSBeRVZihSWYskZMqgEj//U8HJ6ChpQsyaMmeaEe+V35gDDWa47MP2WMkFTJ7o
 UIaQri5tzFp3gWXAE9dHj5sByw6ClIhGfiEslRTJSyIiXrsQrFI8uhyDbmcCRWT+iCv1qNDTbjj
 TGTrmhISkLot//Q3RxaHPfXPYKoaM0XeOx8AKzhgYbSylHlp/A70hqggvYGLWjZwW22rUvoXRbX
 bpTPi2WNFZ/ltn+4Zt6A34AoaeItkYHKDY17w==
X-Google-Smtp-Source: AGHT+IHSAvHOZMNrCQy/7gkRphm9rmmJwEzSGkDbVLDGs5tDf7pFnzSLe5Lp/wfHhLH3bOd8KZDPPQ==
X-Received: by 2002:a05:6808:23ce:b0:44d:9f05:7159 with SMTP id
 5614622812f47-45a26df5524mr592709b6e.29.1767396222253; 
 Fri, 02 Jan 2026 15:23:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <BESP194MB2805B8F03A4EBD778B7656BADAA6A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805B8F03A4EBD778B7656BADAA6A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] dm: crypto: Check malloc return value
Message-Id: <176739622153.296893.11112355442359090237.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:41 -0600
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

On Thu, 04 Dec 2025 20:34:12 +0100, Francois Berder wrote:

> tmp_buffer is allocated using malloc but failure
> is not handled.
> This commit ensures that we do not use a NULL pointer
> if malloc fails.
> 
> 

Applied to u-boot/next, thanks!

[1/1] dm: crypto: Check malloc return value
      commit: 737386977b824111e9abd3524be2f7f4f61025b0
-- 
Tom


