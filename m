Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2D1C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA1282C44;
	Wed, 30 Apr 2025 19:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y5k2mppE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C358282C2B; Wed, 30 Apr 2025 19:03:45 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B0082C03
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-605f7d3215cso16385eaf.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032622; x=1746637422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gORAMEuz66rWkhYsOJnnU7dJfk2GTNkKKYVTJXOsy1E=;
 b=Y5k2mppEou4UoHTLYs13nNYDw8aYWOdYWcJrU1AWUYou2cAlRHhOX2YExdJZDtkwTB
 wCB4Ij8AvIh4i6o1resYCTT+L5+3+SVkn4SBHypOUmIDC511MpWt27OrrWnX5kA4W5yz
 gWEjcDr4NDM9qoXfH+/wJrkLiyUTLm2UhAMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032622; x=1746637422;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gORAMEuz66rWkhYsOJnnU7dJfk2GTNkKKYVTJXOsy1E=;
 b=xLu21WSzumsmZ8rt9SUfS6exW1aS0QohI3OED1FUHpUJgdbWGLmVivymIUGouV6cRw
 fS97O5Z0TAsWS96EDcelQ7ar1oU4y/HC6RuzlS5Q1aQTzn2Mydbi99sdQUuMQEvCJAeV
 askMdaMXGSttIrkzq5XK0si5H0BoNJ0fjCUW9QCuV3T6fZEtxB3EUgjKILkylh2bKO3L
 WSzQcF6COF/2LWFZDgAfvqjgAfjAtcFuUPCBLQmqnmWPKH7zKoMI8MmsZkJt3mlkq16E
 ibbh+eHZiVebCh02UlDmp7LkwdWGGDUBn/wQ/0eI/YOn6BmmFIa6gGbrJxwn0mli6Q6r
 RPvA==
X-Gm-Message-State: AOJu0YxR3C4AEoo98aoVr64380MOajReaBCrCqsKhZSDrd5kORaIhlE3
 OoBemtYzvoWCOv5Gk2SvvRykylZFcuYW6FVbrAfJFuglORqHGC05C9qF/icBef5H1zPfBvsZ0R0
 1vK4=
X-Gm-Gg: ASbGncsAm01iWy/agpk5rKFqz368BL34BDBZiS8QRodhExi8pWSQZnzsr5QGjXH7BiE
 AAn/2oSVVp6M65H6DG1LPfe2DAPrHgIFJ8NsKw8XF7q/WqzII5VNEHctd4bve8rNlE7lRmJ1tAC
 bAIFAbHSleSvywnc+Y2W4O6KhCAltehMinCBr2y2fyZZgxmPScY/xM+u84Q1UxG7rt9hs5+P0Jt
 VxLb9/JIz5bRbS/ft7Baw6dfq7GbmTdoHQPXg+euzhtBnAghmUE3FGubdRyuh/UHFxrn2VZUBJV
 8r1uO6p3pVoJy2NFuHtuE6QWZFW+J91xfF+wJ8FGw79wRKQHA2/Pn82hYvSMCBstTU0cp0vSbRH
 1
X-Google-Smtp-Source: AGHT+IFRdE4Y5BCOf9+Wj62Sbw9Zn6aHRzy1Y7NRCKFmaduIzEeXq16/7hm1xdGgiC12DS8eotRE2w==
X-Received: by 2002:a05:6820:310b:b0:602:7078:df55 with SMTP id
 006d021491bc7-607d4469421mr2452866eaf.5.1746032622403; 
 Wed, 30 Apr 2025 10:03:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Pratyush Yadav <p.yadav@ti.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Vignesh R <vigneshr@ti.com>
In-Reply-To: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
References: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
Subject: Re: [PATCH] mtd: spi-nor: Use CONFIG_IS_ENABLED for
 CONFIG_SPI_FLASH_BAR defines
Message-Id: <174603262138.1760506.5604642456222960435.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:41 -0600
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

On Fri, 04 Apr 2025 11:56:07 +0200, Bernhard Messerklinger wrote:

> At the moment a mixture of ifdef(CONFIG_IS_ENABLED) and
> CONFIG_IS_ENABLED(SPI_FLASH_BAR) is used in the spi-nor framework.
> This leads to misbehaviour in the SPL as there is no Kconfig option
> CONFIG_SPL_SPI_FLASH_BAR. This commit standardizes the use of
> CONFIG_SPI_FLASH to get SPLs that load U-Boot proper from the
> SPI flash to work again.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: Use CONFIG_IS_ENABLED for CONFIG_SPI_FLASH_BAR defines
      commit: 37ccf4a949c4b8b24ed45495a0960695ddb3f7a7
-- 
Tom


