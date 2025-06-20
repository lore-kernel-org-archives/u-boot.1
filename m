Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5B5C7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 17:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613D082D60;
	Fri, 20 Jun 2025 19:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PRcTiYDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809B580E9A; Fri, 20 Jun 2025 19:49:29 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3E580E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 19:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so1080468fac.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750441766; x=1751046566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zuecDb3NJ+Ud3eCWv/bA206a6jsY7KGlMPBsp9yQsM=;
 b=PRcTiYDCT0VjKB5eOGwqHCUEpXqnUDAvtkWATMG5UIbaLF2Pc8Kfs0gSE0JkKpH2GG
 gs0jUUU8cw4XG+12DmuPsL74bf79D6U1LTFKKuZ2Yak/xXOK+be4GJn/EjMO6OHUWMzB
 rnLUIk2LUzZpbGgZXNqoyKEXJZPY5/fQXUxZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750441766; x=1751046566;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zuecDb3NJ+Ud3eCWv/bA206a6jsY7KGlMPBsp9yQsM=;
 b=BiCzORLPcSjHGXTupwXakZ+i4pkG+WxMfSE3O9Wx35L/iIfc0kZ//qM0tNWTgkcwFE
 Cv2VpnIkytji16hWBiDseWRgOQY9sad/z9JxKm+JStvFoszXYCKMvIqQDTVdqtY14KG0
 SO+PtvR9wAHTLNri1yzjZhqgVdmazhKZ4J3qr/cirOrvYamxR7Tly0uey5YzIf9y7dpE
 2skriV1fJPPq7gIu9ISTm4sDLxDvrM686G9XR+TZ/BpBbncjlHoT2N5km5JNAOg0Jy7A
 bbxydY0/mTyYb7U4PNAXeWr7AgPRqdAvcth8HkfqllemXE3bc9PgTbTbxSvjDpTBHh/7
 d7FQ==
X-Gm-Message-State: AOJu0YzhC/z/I6l2X1t2qK3NyksHH2nyBMcFX18DTWb3VF98xWr9XWap
 FnJiqMg3CfaHQ1YbWj09wUOwZn/KaH94EfIroldmKIXCxMut+U/BLFhTcMY9u/ydMtZeTL0sE5S
 l9kGJqWU=
X-Gm-Gg: ASbGncsAJAueUpkmpgN3nNaFZDBH4MM5cj1oi4H/JH1M1WAsm4P6wy6VP77/FpPYXzl
 Fbdm37aJk2dH2xZUvJ/j+PC1PBhRh+xH+rKSN3bAT7V7U9gCgViKrY5CV5FRisSq78WyGU8dnuK
 xoo1cSRwSVzBMhP40mF7pPd6WTyKx+W2JqQ3QqIQtvNyLNxV9SvlOowXo1+xnJxXRMnkvV6kSHX
 brTmvzdnOPgCanelfVUNoklwfbqqXrED9ySEoGvHU8y4FgLiu4wgWkUtvCRHSviCpRnvHVczFoF
 a/Omd+Fkw5BGaLBV21exJyBDf5Dyg+3xk2HlLyePci/9dn8PPHD8LVH/Edk1fB158wJLqgaZkuE
 0wFLFTEfb+KqQlP0MDjf1mq+QfVEnwQAA
X-Google-Smtp-Source: AGHT+IHRBpt0NZ3Y9zKbonzFImUuFW6P0Lpb1lmKAhTIWVLfiYJktLHAVY0i+Ar2O6dKnV05lOyYNw==
X-Received: by 2002:a05:6870:1615:b0:2eb:b6a2:8d77 with SMTP id
 586e51a60fabf-2eeee586c38mr2904139fac.29.1750441766026; 
 Fri, 20 Jun 2025 10:49:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee58bc74b2sm480067fac.0.2025.06.20.10.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 10:49:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <ce9f3c01-1025-48cb-8f4f-aa27781fa5df@linaro.org>
References: <ce9f3c01-1025-48cb-8f4f-aa27781fa5df@linaro.org>
Subject: Re: [PULL next] u-boot-at91-2025.10-a
Message-Id: <175044176486.3427696.6123024821098241284.b4-ty@konsulko.com>
Date: Fri, 20 Jun 2025 11:49:24 -0600
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

On Fri, 20 Jun 2025 10:36:09 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-2025.10-a , the first set of at91 features
> and fixes for the next 2025.10 cycle.
> 
> This feature set includes the addition of new sam9x7 SoC and a new board
> named sam9x7-curiosity. There is also new support for sam9x60 compatible
> at91 watchdog.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


