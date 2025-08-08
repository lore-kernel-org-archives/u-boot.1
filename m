Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8573C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 17:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A608477D;
	Fri,  8 Aug 2025 19:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eOh/ei5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763528477E; Fri,  8 Aug 2025 19:08:33 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5222E84777
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 19:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30c29df87e6so265669fac.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754672910; x=1755277710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqLZeWhzqi45/RgEJFOKmyNscK+9dKdn1S4s67WxATI=;
 b=eOh/ei5okX32w1/KmCGKJ3B16K0i4awNukWiwr1Rhs/7nEqcsxlNvLciv95gb5DMJx
 +BkNx7VXR5zTaBmkQRsYWe0TdVfp1/lfq/obOyV9sIafbpk1eQ+/FmShiGDBiSTOIKbG
 xZS/5GFhsWIDdJAa+uJGTssQXC9yU6i2LOkJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672910; x=1755277710;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqLZeWhzqi45/RgEJFOKmyNscK+9dKdn1S4s67WxATI=;
 b=vlUnREXrBVAIOkCGNWTLcUlVZIEpdDbg/AG3mZW6x/322Gi4Tpcfzo2KX7ewvAwncU
 4w91+h7L0TF2qi4Qo9G7E4IBg4LPPPBfOiw90CsQhWRpuoEFNxbflk9YrEIW+WpjuJDh
 +aZGhCndltWNfGtDmTMwGVUWNegqrTZt2hA/3rGyTpg9aS6dj3f2BuA0ABMkr1Us9EV4
 HxOkjEhstgXtl7tzjWEZ0sAkRZv0pe5cW1gvLWdOofutSMSiA04vazRVSmCVB2jKKB1x
 36+mAtcOnMOINudFGZLqCJe7X7OYu3D1jsr8qXUYNgIlw6JBK5SkQsB0zQERx3M7zoJL
 C+Jg==
X-Gm-Message-State: AOJu0Yzf0rAN8Mi9G8VofQvs1HofKYel8BUxf/XhORrFwIOnoLKVPUFs
 4eKeuqy4UXBsvbWpMjFIQBEs/Ko8lca0GyqtKY/XcviEWiWuXtTDcQgojfdsAiaOoKY=
X-Gm-Gg: ASbGncuzzxDZGYsq1rj0xbBEBxAxAk7KT0NRBesBX9F21VEjrgeQbKDUpgRWqX+aWBD
 5ncp079HCvpmBkKarDoMAXnDmTHcO8YE8bjm9G7b2MeEZ6PDoxVAZQ0RLb/HqbaTHbaPkRWqzr1
 Zj3/pmWwC0KpXvbr53vWu73Qozk9aKIJG2Mpjmd3CFWtQfsrwvpiFfpYDBJJN09zrlghbEAjE9D
 brp4jq3pHeolyVumhwZuw9YgIPoPBiC2nqatCSclqSaiaj9joDMqRmHtQ+2AXj29AP+TLnUM8lQ
 vo61aIj4z0Vc61vOlirFrrDUTozJ7v5zJ7Zh2KJc/hc2Y5zkHBub9yzIL5xbmuahbn7OWbkffxd
 bniUb9x/GFfWJr//AsMMFQBrNmP8lH/UNZe2WpZybGJvzn6sKTlmMkLU=
X-Google-Smtp-Source: AGHT+IGmzUYXTTVJ7+Q50FTaMa4EoIwXtphK6F3RFglllnrqNgy4mOEbPrnHtGD6PPd00bfba9Cc4A==
X-Received: by 2002:a05:6870:8992:b0:30b:cb15:28b1 with SMTP id
 586e51a60fabf-30c20f2d908mr2255918fac.7.1754672909835; 
 Fri, 08 Aug 2025 10:08:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30bc9ede835sm2721061fac.32.2025.08.08.10.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 10:08:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 No generic patch CC mail please <noreply@example.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>
In-Reply-To: <20250808114014.121402-1-hs@nabladev.com>
References: <20250808114014.121402-1-hs@nabladev.com>
Subject: Re: [PATCH] MAINTAINERS: update email address of Heiko Schocher
Message-Id: <175467290803.1469283.9272845580231469969.b4-ty@konsulko.com>
Date: Fri, 08 Aug 2025 11:08:28 -0600
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

On Fri, 08 Aug 2025 13:40:14 +0200, Heiko Schocher wrote:

> use the new email address for community work.
> 
> While at it, cleanup git shortlog output, by adding
> fixes in .mailmap
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update email address of Heiko Schocher
      commit: 9fd31937dd21245f9979d167d97ab66d065d3d56
-- 
Tom


