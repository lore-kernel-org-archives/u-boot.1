Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53AFC54E49
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 21:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D761F87DB3;
	Sat,  9 Mar 2024 22:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NE9Ic4Cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C55187DE9; Sat,  9 Mar 2024 22:59:04 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032E887C82
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 22:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-788598094c4so75521985a.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 13:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710021535; x=1710626335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0Xtvoh+6iX/cWg9t8J7R62jg9GlZ+H97HPf1Qvw1lc=;
 b=NE9Ic4CyRx50W79DgIQ4JrKjoGfMQfxyhZ7zSDNQgMEMyR1qGfwDLQ/mfC4XHPFif1
 ScXA5akGqfEkSc2VVClyIGko5uaXfOchzub9VKIS4T2rdSDAfF1mbTczfj0x164iY1+W
 RRTYyco+zC9DJn3ssmg0+o8DqTJnvqjWUu4d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710021535; x=1710626335;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0Xtvoh+6iX/cWg9t8J7R62jg9GlZ+H97HPf1Qvw1lc=;
 b=FhB1zeE3Rb6X4ik0ESFnqzu6jyqPMc69EQEpXr1W/vW6w2D747EPuLnYgg0zAlemur
 Koqi6I5/YMKeUODN/E2TvyYCxf/VQ24i8jmpgoF2GsvQH8027cha6gLaVin9ItOUYRvl
 EB72RCxFLlsladILvHkSktBdPH0BDWCwQtP/9tvmoNMLKZyfqIpL/bZFuoIybYqXo/ds
 X5Ae0+gXIxf/dhf0TZZJl4ikFyXNIHKNvWZK57qT9Jn9ec6TCTf6JveciipTopgYIp1B
 RAnAG4Yv9nsYEYX3nZNEQCg3K1O4Jlb1042/OGec8gD5VNxbQKjb4yDx6aEINdGfFAAe
 Ad0Q==
X-Gm-Message-State: AOJu0YyPGhX/7fh9SjVehfD4LBCKeHuVjv1sisKw5+NXIIto3htWjeRz
 xYE+vyt+HwwSzoclFm/+fblN0dKM0bJNV0mDWI5U4dPq4UGimNVe0XpJ/GnNSRo=
X-Google-Smtp-Source: AGHT+IGXdENiGaY/fOQ4r/uWDd6COKhys1d5ldm1Ghc3priIYH04KJ4BWWUznUYRWndDK57zjM2Blw==
X-Received: by 2002:a05:620a:171f:b0:787:21a8:1177 with SMTP id
 az31-20020a05620a171f00b0078721a81177mr3764920qkb.59.1710021535426; 
 Sat, 09 Mar 2024 13:58:55 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 bj40-20020a05620a192800b007884db6b2absm1280167qkb.10.2024.03.09.13.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 13:58:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20240128011959.59995-1-marek.vasut+renesas@mailbox.org>
References: <20240128011959.59995-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] net: phy: Use PHY MDIO address from DT if available
Message-Id: <171002153399.481080.11212676210616891858.b4-ty@konsulko.com>
Date: Sat, 09 Mar 2024 16:58:53 -0500
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

On Sun, 28 Jan 2024 02:19:40 +0100, Marek Vasut wrote:

> In case the PHY is fully described in DT, use PHY MDIO address
> from DT directly instead of always using auto-detection. This
> also fixes the behavior of 'mdio list' in such DT setup, which
> now prints the PHY connected to the MAC correctly.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


