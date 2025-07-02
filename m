Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D66C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDC181FEE;
	Wed,  2 Jul 2025 03:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OG+Ll+Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65DDA82ADA; Wed,  2 Jul 2025 03:03:51 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4431381E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3305736fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418228; x=1752023028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WoDtnyq7tLiYPRawKigqs8RzXHqgBny7Yf/XORRB+QU=;
 b=OG+Ll+Am3zaP0vyiAI4ySMty1uZC8h0n9f2PlTDAByQDLs1FpfxCt2Brs/MhWACBvW
 R/0ud3gV0DGEO0A3HdJlgkrOyFNLW+RofDrmf4Hort1JBoRqHEr3Pyfi6gIWzYsYzktg
 RuOgmEdqCa4c1OAMHi6LpNSFazuaKqLpQJ/II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418228; x=1752023028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoDtnyq7tLiYPRawKigqs8RzXHqgBny7Yf/XORRB+QU=;
 b=k5ORcF04tTaI11ieJIHeBhKzLgZu1wNstxcgVXnSM6qD1zRLrHT09YJ3Jt1jJCwQz1
 oWdpzKoFPHV+sJdsnVdyywob/bDxUjLZoQbusxg5ucTakU/GaO/gAykA6AdiPWW72mWa
 8ORSzP3hGWEcpsStuC7+XqJJqtSG4KVbjTqSps+UE29/HN0siSbCYYn7yOHCyOxk1wS2
 7Kn931poIGMYxYyPJ07wBOd4XAXqA/7HNjk88IPNwCmMauz4+STgKGBE2m9tSZf/AOyV
 WUbo+EiEKLHgH6jAdWOLttBxy/wAXbF+c/xihr/zuMRNqm75LAFu4huUWrV+Z6+83bi7
 SY9A==
X-Gm-Message-State: AOJu0Yy+OccoaP8KjatkHBIpWb4mvTZR+4G17N/mun5YFEEk2FCMMIxy
 N2RTJUl0jJZXBzKq86TIKEEnQfYEV2IcoNe3fzFkJ6NAS/cqNEhk0vWFTj0KxDv1WBROvC/A88n
 EIJ4l3/M=
X-Gm-Gg: ASbGncuQ8ycCkIOF3L9JuDm5XjiJb/3m/eRJ8tFm/oQN50wpp2ih2zyDf4L71TreN9b
 V1R/FbeAS/vMH7nUW2vU2blDD0uyogSjQooZlLp9Cc+AFnqwLukGcl5WRacM7+IYUmorb+jLG3f
 qlbEKDM9jHzYP5Sx7gCG89OnRwLfKfi9hhUdiakHtm8jMyXFRXRwIYnj+ISSjd5rFXZzZum6CGx
 ti9/wYFeuvmBlwdB8hVM053q4+HBSJvlsbYoIPH2blNDZ2jshPHLN51JfvPASUg30NLVh4To2GJ
 AdGpu93fjBaSLI4AfIbjecj3LVHe0VJ0nof9UOY+66aZiKEPmM+MIbWXuyW6mzq9MCe08mbyr1D
 5/3avWwm2WQAoviXTUvoAViw=
X-Google-Smtp-Source: AGHT+IFB0d+QzT9hTH3PZfzGYFUI4ausIknhKJasYsoZH7UN74RRFxCbAA3UNrQS9mrLCFE6LN/67A==
X-Received: by 2002:a05:6870:9d8f:b0:29e:48d6:2e62 with SMTP id
 586e51a60fabf-2f5889b1720mr812272fac.9.1751418227903; 
 Tue, 01 Jul 2025 18:03:47 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ef29absm3578201fac.14.2025.07.01.18.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:03:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 1/2] usb: gadget: rockchip: Add missing dependency
Date: Tue,  1 Jul 2025 19:03:45 -0600
Message-ID: <20250702010346.18716-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The rockchip usb gadget driver cannot build without platform specific
headers being available. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 46a83141481f..b0decd7b2512 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -202,6 +202,7 @@ config USB_FUNCTION_MASS_STORAGE
 
 config USB_FUNCTION_ROCKUSB
         bool "Enable USB rockusb gadget"
+	depends on ARCH_ROCKCHIP
         help
           Rockusb protocol is widely used by Rockchip SoC based devices. It can
           read/write info, image to/from devices. This enables the USB part of
-- 
2.43.0

