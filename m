Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CF7C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73DC8349B;
	Wed,  9 Jul 2025 18:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="faOBKkJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36FA983599; Wed,  9 Jul 2025 18:36:04 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290DF8349B
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73cddf31c45so9714a34.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752078961; x=1752683761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEqEMDhwfVOZrs/6yVwZHI4uIDBO4HpulqOLWJlauFk=;
 b=faOBKkJ52JaK4ZvNXnEsJqlrlGHWPVq69S8K+mxnxXCYz2o+VvTTomtqd0LdMqFE+Z
 rqu2jJY0tNDpUKEgYxy2uG8WCCkJ6f/2qLMLQTh+ElvJ8xGIwSOs7wJ1yxAdrbwmfS3i
 WY/0CeLpGqy9ULo4Bc6AoDzL1MvVcWca/IRuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752078961; x=1752683761;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEqEMDhwfVOZrs/6yVwZHI4uIDBO4HpulqOLWJlauFk=;
 b=b0WlmvB/Hzecght14Nn8GxQbtC4I/cAREN+4bB4CeDJ8irxDL7LVQTm8zsut8AU/qX
 HfegQz5i+XJnre5/nIxXPHX+Ra9tOl4o9qSlg2gHMktzyC2VCMUz1Id1+yuYr0bU3foY
 iYLhFA7sA5MgDh7uDCFM3Qp7bLQULtgmYpzHK2ray4JFBBH8jqMLPTzZgbGN0iNgIZHq
 CLKap7ftk7Pd0pLcKiFfL0s+7ByS7OMt/iX0E8ccaibGRUK0V5hEJb2CXerUho785c3U
 7X7XKZMjylQjjMUoW3eCEhpL6SGv/Pgf5d59cMhurBBxwkk1scz/zCfggZB1gmZivAom
 J2Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCeSWNPAwhC39HlhaPucwBVCX9JtbPYWkK5pxm4EZrHBHtU1Iy0EjrZJR1SgEbjrSrHylnAZg=@lists.denx.de
X-Gm-Message-State: AOJu0YwbdJ4zuSz1iOpMN4OGuzcfCXc+hgjZ78x6FI8OqtFuF1AZqOje
 9LLzLyiYbSzyoJ4ekohKKu2cLK0GF2XHqYYLQRZXZWrcstbGA8ksQxM+f2e4kQec7IY=
X-Gm-Gg: ASbGncvRp1QlmU0Vp9Iv9Jf6Urm5s2R27/j1RlqTMXruWWZ+H1lODcYa/5tDQpuYfgg
 vlrytyHJC7ZmZbk2o2Wvc7cL6WjQfghStTbUrVL8M1uluF15aWicSJPj/SzeNyQVo/y8+q6vY6V
 QiD9BTaVYXUKOriVNUJWw6hSY4Qx2GkwpBi3D15TqI/kMVTBoLAFxng03wSR4BF8xsxtMi9b2Oz
 RW6oajGjyv44Hs5axGUPJ37UeD9J3/J7yINpvQhAzupfaMWoGzKAO6vQQc7a185VxxCyA3u6/3d
 ONi/yLSGydLS/pV5vJxPRnPmeD7vPgwWUN8igR7kq44UFMmpHNOIcjviRAGY70b0edW2EjqrBXT
 O1tDL5ymIy/z5pFzd9BI=
X-Google-Smtp-Source: AGHT+IFvyXmZ+JTKqPbjcM/kH8g0gUFlzUYltyal5MuYtrhWm8rSzKnOJSWtJKZeSy4he0cKpRf9nA==
X-Received: by 2002:a05:6830:280d:b0:73a:8bf8:56b4 with SMTP id
 46e09a7af769-73cedfe3bf6mr364341a34.13.1752078960831; 
 Wed, 09 Jul 2025 09:36:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ab33dsm2068341eaf.28.2025.07.09.09.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:36:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: "Bajjuri, Praneeth" <praneeth@ti.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
In-Reply-To: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
References: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
Subject: Re: [PATCH 0/2] board: ti: am33xx: Add Ethernet support for
 Beaglebone Green Eco
Message-Id: <175207895947.1827628.2109051110641242598.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 10:35:59 -0600
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

On Thu, 26 Jun 2025 18:20:23 +0200, Romain Gantois wrote:

> This is version one of my series which enables Ethernet support on the BBGE
> board. This requires three main changes:
> 
>  - Describing the MAC<->PHY link and DP83867 PHY accurately in the device
>    tree
>  - Enabling the RGMII1 pinmux configuration
>  - Enabling the DP83867 driver
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] net: phy: dp83867: Allow excluding driver from SPL
      commit: 7eaa8aaa9a5930f75cc32a914b706869ad679f5c
[2/2] board: ti: am33xx: Add Ethernet support for Beaglebone Green Eco
      commit: 48b1f8a396bfe1b29d2033f3d23861a3f470de58
-- 
Tom


