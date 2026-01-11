Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C88D2502D
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3C983B85;
	Sun, 11 Jan 2026 17:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HVLjctkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AFA83C5E; Sun, 11 Jan 2026 17:32:34 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959BB83A79
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b5eb14e88so1146574a12.2
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149152; x=1768753952; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LaRvfPD2Dsc8g8OPspV6udqL1/D0a3W3iQw2c7lVpvQ=;
 b=HVLjctkrKerImPTy/rj87a8glvfrQYmuNSDOZdauok/mYOd6nw2iVURmPHwLl8SVc7
 WuR25PH/XN6RZWrMqqpC7lDZjLPZ0wbWwuaixJaSV6YKuA22Ff80GloCRF/wuY7a26Xh
 bDnVmDctSXKyQU/UMvyEfcBEzOKT681XiMlr2vynquDw/aHTLLSq93Yrta34S5bPvh95
 GArrNjlnSXNe+JbeDPX9L18JGxf1jkEWrsIbN8wIhB43Nmi0Ty6fnbIhgSGj+AaRS57/
 hJ3KaXvyGMUyeJ+UD/D2aP2zv1EcdDECxY3ILUD1LQZlONmFpu/d2GzVnIeGeSJkZbLc
 CniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149152; x=1768753952;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaRvfPD2Dsc8g8OPspV6udqL1/D0a3W3iQw2c7lVpvQ=;
 b=lmy7TgvDVEx2ta83tOIKGLGe5NpPv9ENgqrR3NIXKlnztOklwQymrqMTyvygoW7e8q
 gEJIiGmVzhG9ef9y0iaHd3106dFpoSSCsB27+xPXOyaPBCcaBg9ap0Jgod/zBGkUhDqP
 s1IBTmhgyIocLdWy85m+nGC0eQdZnbn911/X2HhgS4ep3refZWOf5IWZ3zhKTlAy20MH
 YvKMehqdS87FO3u7OySV6Zy2OHQVdajKS9RJ62lm+E1hehH+CiKRgAt087mT/IjPVA0c
 8f+QtOMHIZHwzYjCJfH8OO+Q/X0LOZ/LzerCdzI5oHZ9jia/ApAUXJeP0GL51IgEFEBk
 cXew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPvNSlSl55n15SfV/D9qzDHDp4HZqM7xetMXYcueEmjbq4H3yvtdVrh/76O5gR2e57ScsU1k=@lists.denx.de
X-Gm-Message-State: AOJu0YxvnsPkkh1MRhIsMVcNz7KvUmiH/nl8PR1Gf0ti7ieHdhzm8w6U
 FJCgKXQJ2wBohTupW2qCt7g/2SuMoUURaB+/vaci2dBTAQH3qqQRPv1O
X-Gm-Gg: AY/fxX4i4zC8ymObiwHloPLjmQfs64RQV0B5e6Xm60lBnHvnZxloYN5qAcrPJl34+WK
 owA5dKN8ub/Ngb4acbqOzbDDeQmDrW2qFxfKMeJGzZFn+9yJyV6pTYtsDm2ENrdrQs5Sz57lxNm
 KxjQqdrHSWuAa2/hpBWALMp+TK4ftmAxTvQX5hOdIH9mb91tX+XFN2MO18sd3Et4ek18kcKVYTz
 QyJYAx6fgdpSTlUntsWadpXLAFW9XctvSij6ZivdCCVB4dioG0tdjnZcynjxlTbFwLsk7qG1tl4
 uQNwrG8jWyJNQ+/ge9ZVJfHR8pE2nc4+tH9zD/6/bVZQWJYrei4B4rI86N+yS6yc7Mzd5vBSyho
 Kak95+caCHrLTaL12Jt/XxvsWuPaWEFt8txJ1JyAiVfZUWlZeeSNCKQxDxQC4Uw/DoUUUUCsgv5
 ndpJotLd71PIVLhEz+s6NrsY/AgAuSWCBg/576/jSApB9zGJQBHA==
X-Google-Smtp-Source: AGHT+IE8c60okTLYCkYWqA6KKJHGl3HBKo6MQ0yJanwFrL5GDMiqT10guzPMsBvmzSf1vcqmQaPgsw==
X-Received: by 2002:a17:907:1c18:b0:b87:1eaf:3762 with SMTP id
 a640c23a62f3a-b871eaf3f94mr7204066b.7.1768149151931; 
 Sun, 11 Jan 2026 08:32:31 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b870b0dba4esm234061866b.17.2026.01.11.08.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:32:31 -0800 (PST)
Message-ID: <663b01e8-112d-49ae-ac60-2db75dd0ea7f@gmail.com>
Date: Sun, 11 Jan 2026 17:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/6] ARM: dts: rockchip: Remove mshc aliases from RK3288
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <>
Content-Language: en-US
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The use of mshc aliases is deprecated for some while,
so remove them from the rk3288.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://patch.msgid.link/3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cafaf99e4a790f8492a034a3470f878779c8c535 ]

(cherry picked from commit faefae4ca217961a0d96a54c9618e56aa8fd37b3)
---
 dts/upstream/src/arm/rockchip/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
index 42d705b544ec..7e284b4fecdc 100644
--- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
@@ -34,10 +34,6 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mshc0 = &emmc;
-		mshc1 = &sdmmc;
-		mshc2 = &sdio0;
-		mshc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
--
2.39.5

