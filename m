Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C77C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65CC87845;
	Thu, 28 Dec 2023 12:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrpZarb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C98CB8706B; Thu, 28 Dec 2023 06:29:25 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B3886E05
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gch981213@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d4006b251aso47324925ad.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 21:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703741361; x=1704346161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jORddDTX2J6d1+QdjLP/aZgFTNGpy/DmzspQazGD2to=;
 b=XrpZarb4PIoYmzLxG6LUr1hoa/6aj3YUaiX0NQJ8PO9rTza57VRB2IXCGRDRbeJJkO
 eo8+8CYd8g+i+M+8mFQupi2uNbDFicDgVTbSzq1yuLy9jnQI4FYj8YLp0NzlkqkBLzju
 p8mXzdV7j9boOrfYtrAb4VPOOAq7TCaSruk61aZ1QHOdK9QcUAblmptzbL6EVVphUI6l
 Z3N4Ka4N3kf2dDOVuIQxU8z883qKCqFzA7mdmeqLweHmb5mGpiIHeMW2WTutd5OD2oAM
 M4tKTJfDDPhwYXHo+7qAu4WTUuK8rJOtsatXp5cpe9OGYr9alty9Ce4NbGJnVa3zrg8O
 5YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703741361; x=1704346161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jORddDTX2J6d1+QdjLP/aZgFTNGpy/DmzspQazGD2to=;
 b=JyoE2Xq0M9IB0W6VqX2YvlonkHVfCWeucvD/vysH8YIzBSTpqN0f37mKcXN10EmjTW
 BTZmKEbdsWsMDwaOZuGlXJAas628aYDwTSuOFAW8d/oLVGI3LqJKJJIIa6rcLKb7T098
 28vVleRUa5A2QawjzUU42hzAU+X+gdibFqzTU11J6LUZlv/A/pODrtlLI6hJANLULrb1
 FM+38h9FOhJw+OQWErk7rj7als/9w9HLGngYSuzGxsV5OFeviZShISjep0xjpSmbxWdI
 tIfcLX7xw3vL006LWsQjt4J4YbNhbSdjzMO15YsIM4s5rKYbcYE00wMPGrogXkztKl2D
 epxA==
X-Gm-Message-State: AOJu0YxqIzry+TvAu4OcTf6jZqssHlkH5lZqHQgLXHoNDZO4aClKV5Pt
 xXbmw7Bq/XwVAOAlOalQeS1iRxYbvxwqdQ==
X-Google-Smtp-Source: AGHT+IEspTdlT6pHXy0BSkpEcyuYpA0VCkmLzt8SIT6Vw8+pYnQyfgg5AD4zOPAZB4OnX0jOgSOz0Q==
X-Received: by 2002:a17:903:234f:b0:1d4:2dfe:215b with SMTP id
 c15-20020a170903234f00b001d42dfe215bmr12333881plh.116.1703741361081; 
 Wed, 27 Dec 2023 21:29:21 -0800 (PST)
Received: from guoguo-thinkbook.lan ([2001:250:3000:2b31:13b1:8229:957c:159f])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a170902868500b001d096757ac1sm12899534plo.47.2023.12.27.21.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 21:29:20 -0800 (PST)
From: Chuanhong Guo <gch981213@gmail.com>
To: u-boot@lists.denx.de
Cc: Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH] sunxi: add defconfig for nanopi_duo2
Date: Thu, 28 Dec 2023 13:29:15 +0800
Message-ID: <20231228052915.121433-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Dec 2023 12:26:55 +0100
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

FriendlyElec NanoPi Duo2 is a tiny SBC with Allwinner H3 and
Ampak AP6212 WiFi module. The device-tree for it is already
available in u-boot source tree. Add a default config for it.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 configs/nanopi_duo2_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 configs/nanopi_duo2_defconfig

diff --git a/configs/nanopi_duo2_defconfig b/configs/nanopi_duo2_defconfig
new file mode 100644
index 0000000000..5a2069789f
--- /dev/null
+++ b/configs/nanopi_duo2_defconfig
@@ -0,0 +1,11 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-nanopi-duo2"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_H3=y
+CONFIG_DRAM_CLK=408
+# CONFIG_VIDEO_DE2 is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_CONSOLE_MUX=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.43.0

